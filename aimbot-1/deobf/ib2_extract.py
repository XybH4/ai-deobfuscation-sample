"""
Extract the proto tree from an ib2-fork obfuscated Lua file.

Approach: the file's inner function builds a deserializer `s()` that returns
  { instructions[], sub_protos[], param_count, constants[] }
   i.e. a Lua 5.1-style function proto.
We patch the script so immediately after the deserializer is defined we call
s() and dump everything to disk, then exit before the VM runs.
"""
import os, re, subprocess, sys

HERE = os.path.dirname(os.path.abspath(__file__))
SRC  = os.path.normpath(os.path.join(HERE, "..", "obfuscated.lua"))
OUT  = os.path.join(HERE, "ib2_instrumented.lua")
DUMP = os.path.join(HERE, "ib2_proto.txt")

with open(SRC, "r", encoding="utf-8", errors="replace") as f:
    src = f.read()

# The deserializer is the `local function s()` just before `local function c(...)`.
# We'll inject a dumping block right before the final `return c(s(), {}, r)(...)` line.
MARKER = "return c(s(), {}, r)(...)"
i = src.find(MARKER)
assert i != -1, "marker not found"

# Build a Lua dumper that walks the proto tree and prints everything.
dumper = r"""
-- ---- Proto dumper ----
local _fh = io.open([[__DUMP__]], "w")
local function _w(...) _fh:write(...) _fh:write("\n") end
local function _esc(v)
  local t = type(v)
  if t == "string" then
    local out = {}
    for k=1,#v do
      local b = string.byte(v, k)
      if b == 34 then out[#out+1] = "\\\""
      elseif b == 92 then out[#out+1] = "\\\\"
      elseif b == 10 then out[#out+1] = "\\n"
      elseif b == 13 then out[#out+1] = "\\r"
      elseif b == 9  then out[#out+1] = "\\t"
      elseif b < 32 or b >= 127 then out[#out+1] = "\\"..b
      else out[#out+1] = string.char(b) end
    end
    return "\"" .. table.concat(out) .. "\""
  elseif t == "number" then
    if v == math.floor(v) and v > -1e15 and v < 1e15 then
      return tostring(math.floor(v))
    end
    return tostring(v)
  elseif t == "boolean" then
    return tostring(v)
  elseif v == nil then
    return "nil"
  else
    return "<"..t..">"
  end
end

local dumpProto
local pid = 0
local idmap = {}
local function protoId(p)
  if not idmap[p] then pid = pid + 1; idmap[p] = pid end
  return idmap[p]
end

dumpProto = function(proto)
  local myId = protoId(proto)
  local instrs = proto[1]
  local subs   = proto[2]
  local nparam = proto[3]
  local consts = proto[4]
  _w("===== PROTO #", myId, " =====")
  _w("params: ", tostring(nparam))
  _w("-- constants (", #consts, ") --")
  for k,v in pairs(consts) do
    _w("K[", k, "] = ", _esc(v))
  end
  _w("-- instructions (", #instrs, ") --")
  for k,v in ipairs(instrs) do
    _w(k, "\t", tostring(v[1]), "\t", tostring(v[2]), "\t", tostring(v[3]), "\t", tostring(v[4]))
  end
  _w("-- sub-protos (", #subs, ") --")
  for k,v in pairs(subs) do
    _w("P[", k, "] -> #", protoId(v))
  end
  _w("")
  for _, sub in pairs(subs) do dumpProto(sub) end
end

dumpProto(s())
_fh:close()
io.write("DUMPED\n")
os.exit(0)
"""
dumper = dumper.replace("__DUMP__", DUMP.replace("\\", "\\\\"))

# Inject before the final call, BEFORE the `return c(s(), {}, r)(...)` line.
instrumented = src[:i] + dumper + "\n" + src[i:]

# Lua 5.1 lacks 'bit' and 'getfenv' might be present — the script handles both.
# We also need 'unpack' (Lua 5.1 has it globally).
with open(OUT, "w", encoding="utf-8") as f:
    f.write(instrumented)
print("wrote", OUT)

res = subprocess.run(["lua", OUT], capture_output=True, text=True, cwd=HERE, timeout=30)
print("rc:", res.returncode)
print("stdout:", res.stdout)
print("stderr:", res.stderr[-800:])
if os.path.exists(DUMP):
    print("dump size:", os.path.getsize(DUMP))
