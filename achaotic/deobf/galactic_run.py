"""
Run the full Galactic-protected script under instrumentation. We stub Roblox
APIs and log every indexed access / method call on them so the side-effects
the VM performs are observable in order.

Output: a call trace we can use to reconstruct the original Lua logic.
"""
import os, subprocess

HERE = os.path.dirname(os.path.abspath(__file__))
SRC  = os.path.normpath(os.path.join(HERE, "..", "obfuscated.lua"))
RUNNER = os.path.join(HERE, "galactic_runner.lua")
TRACE  = os.path.join(HERE, "galactic_trace.txt")

bit32_poly = r"""
if not bit32 then
  bit32 = {}
  function bit32.bxor(a, b)
    local r, bit = 0, 1
    while a > 0 or b > 0 do
      local ab, bb = a % 2, b % 2
      if ab ~= bb then r = r + bit end
      a = (a - ab) / 2; b = (b - bb) / 2; bit = bit * 2
    end
    return r
  end
end
"""

trace_lua = r"""
-- ---------- trace recorder ----------
local _tracefh = io.open([[__TRACE__]], "w")
local function tr(...) _tracefh:write(...); _tracefh:write("\n"); _tracefh:flush() end

local function makeProxy(name)
  local mt = {}
  local t = {}
  mt.__index = function(_, k)
    tr("INDEX  ", name, " -> ", tostring(k))
    local v
    if k == "HttpGet" or k == "HttpGetAsync" then
      v = function(self, url)
        tr("CALL   ", name, ":", k, "(", tostring(url), ")")
        return "-- simulated HttpGet body --"
      end
    elseif k == "GetService" then
      v = function(self, svc)
        tr("CALL   ", name, ":GetService(", tostring(svc), ")")
        return makeProxy("game."..tostring(svc))
      end
    elseif k == "IsStudio" then
      v = function(self) tr("CALL   ", name, ":IsStudio()"); return false end
    elseif k == "IsRunning" or k == "IsClient" then
      v = function(self) tr("CALL   ", name, ":", k, "()"); return true end
    elseif k == "IsServer" or k == "IsEdit" then
      v = function(self) tr("CALL   ", name, ":", k, "()"); return false end
    elseif k == "IsLoaded" then
      v = function(self) tr("CALL   ", name, ":IsLoaded()"); return true end
    elseif k == "WaitForChild" or k == "FindFirstChild" then
      v = function(self, c) tr("CALL   ", name, ":", k, "(", tostring(c), ")"); return makeProxy(name.."."..tostring(c)) end
    elseif k == "LocalPlayer" then
      v = makeProxy(name..".LocalPlayer")
    elseif k == "UserId" or k == "GameId" or k == "PlaceId" then
      v = 12345
    else
      v = makeProxy(name.."."..tostring(k))
    end
    rawset(_G_proxy_cache, name.."/"..tostring(k), v)
    return v
  end
  mt.__newindex = function(_, k, v)
    tr("SET    ", name, ".", tostring(k), " = ", tostring(v))
  end
  mt.__call = function(_, ...)
    local args = {...}
    tr("CALLALL ", name, "(#=", #args, ")")
    return nil
  end
  mt.__tostring = function() return "<proxy "..name..">" end
  setmetatable(t, mt)
  return t
end

_G_proxy_cache = {}
game        = makeProxy("game")
workspace   = makeProxy("workspace")
script      = makeProxy("script")
shared      = {}
_genv       = {}

function typeof(v) return type(v) end
function wait(t) return t or 0 end
task = { wait = function(t) return t or 0 end, spawn = function(f) pcall(f) end,
         defer = function(f) pcall(f) end, delay = function(_,f) pcall(f) end }

function getgenv() return _genv end
function getrenv() return _G end
-- getfenv shadowed below to fake source name

-- Fake debug so anti-debug checks pass. Roblox's debug.info / debug.traceback
-- should look benign (no "runner" / "deobf" etc. substrings).
debug = debug or {}
local _orig_info = debug.info
debug.info = function(a, b)
  tr("CALL   debug.info(", tostring(a), ",", tostring(b), ")")
  if b == "s" then return "LocalScript" end
  if b == "l" then return 1 end
  if b == "n" then return "" end
  return "LocalScript"
end
debug.traceback = function(msg, level)
  tr("CALL   debug.traceback(", tostring(msg), ",", tostring(level), ")")
  -- make it look like a benign Roblox traceback. Include a :<digit>: so match works.
  return "Stack Begin\nScript 'LocalScript', Line 1\nStack End"
end

-- Wrap the VM entry point in pcall so we keep the trace even on anti-debug throws.
local _real_error = error
function error(msg, level)
  tr("ERROR  thrown: ", tostring(msg))
  -- swallow the error to continue logging (but this breaks control flow; callers
  -- may still infinite-loop if we do this). Rethrow for now.
  _real_error(msg, level)
end

-- loadstring gets the fetched payload. Log it, don't actually execute.
function loadstring(s, chunkname)
  tr("LOADSTRING body length=", #tostring(s))
  -- save body
  local fh = io.open([[__TRACE__]]..".body", "w")
  fh:write(tostring(s))
  fh:close()
  return function(...) tr("EXECUTE loadstring-returned-chunk"); return nil end
end

-- Dump `a` after decoder finishes, so we have the string table available even if
-- the VM later errors out.
-- (We do that by appending a hook into the obfuscated source below.)
"""

with open(SRC, "r", encoding="utf-8", errors="replace") as f:
    src = f.read()

# The obfuscated file is: `--[[...]] return(function(...) <body> end)(...)`
# We strip the outer `return(function(...)` and `)(...)` so the body runs in
# our already-prepared environment.
# But simpler: just run it as-is; our stubs are already in _G. Lua 5.1 allows
# running the file body since functions resolve at call.
prelude = bit32_poly + trace_lua.replace("__TRACE__", TRACE.replace("\\", "\\\\"))

# Prepend our prelude to the obfuscated source (no modification to obf source itself).
with open(RUNNER, "w", encoding="utf-8") as f:
    f.write(prelude)
    f.write("\n-- ======== ORIGINAL OBFUSCATED SCRIPT ========\n")
    f.write(src)

print("wrote", RUNNER)
res = subprocess.run(["lua", RUNNER], capture_output=True, text=True, cwd=HERE, timeout=15)
print("rc:", res.returncode)
print("stdout:", res.stdout[-500:])
print("stderr:", res.stderr[-2000:])
if os.path.exists(TRACE):
    print(f"trace: {TRACE} size={os.path.getsize(TRACE)}")
