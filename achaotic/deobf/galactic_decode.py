"""
Decode the string table of a Galactic Protection v1.6 obfuscated file.

Strategy: the obfuscator's decode routine runs at load time and:
  1. shuffles the string array `a`,
  2. base64-decodes entries starting with "-",
  3. Ascii85-decodes entries starting with "}",
  4. XORs every byte in every string with 132.

We instrument the file: keep everything up through the XOR loop, then dump
the fully decoded `a` table to disk and exit before the VM runs.
"""
import os, re, subprocess

HERE = os.path.dirname(os.path.abspath(__file__))
SRC  = os.path.normpath(os.path.join(HERE, "..", "obfuscated.lua"))
OUT  = os.path.join(HERE, "galactic_instrumented.lua")
DUMP = os.path.join(HERE, "galactic_strings.txt")
STUB = os.path.join(HERE, "stub.lua")

with open(SRC, "r", encoding="utf-8", errors="replace") as f:
    src = f.read()

# Anchor: the file opens with a `return(function(...)` then the string array,
# decoder, XOR pass, then the real VM entry starts with `return(function(X,c,U,...`
# We want to cut right BEFORE that final `return(function(X,c,U,`.
ANCHOR = "return(function(X,c,U,"
pos = src.find(ANCHOR)
assert pos != -1, "anchor not found"
before = src[:pos]  # everything through decoded-string XOR pass

# Build instrumented file: load stubs (bit32 etc.) + before + dump `a` + exit.
shim = r"""
do
  local fh = io.open([[__DUMP__]], "w")
  for i, v in ipairs(a) do
    if type(v) == "string" then
      local s = v
      s = s:gsub("\\", "\\\\"):gsub("\"", "\\\""):gsub("\r","\\r"):gsub("\n","\\n"):gsub("\t","\\t")
      s = s:gsub("[\1-\31\127-\255]", function(c) return string.format("\\%d", string.byte(c)) end)
      fh:write(string.format("[%d]=\"%s\"\n", i, s))
    else
      fh:write(string.format("[%d]=<%s>%s\n", i, type(v), tostring(v)))
    end
  end
  fh:close()
  io.write("DUMPED ", #a, " entries\n")
  os.exit(0)
end
"""
shim = shim.replace("__DUMP__", DUMP.replace("\\", "\\\\"))

# Lua 5.1 lacks bit32 by default. We need it for the XOR pass.
# Provide a tiny pure-Lua bit32.bxor implementation.
bit32_poly = r"""
if not bit32 then
  bit32 = {}
  function bit32.bxor(a, b)
    local r, bit = 0, 1
    while a > 0 or b > 0 do
      local ab = a % 2
      local bb = b % 2
      if ab ~= bb then r = r + bit end
      a = (a - ab) / 2
      b = (b - bb) / 2
      bit = bit * 2
    end
    return r
  end
end
"""

# Also the outer wrapper `return(function(...) ... end)(...)` swallows the
# whole body. We just need to close it so our shim is reached.
# Structure: return(function(...) <before> <shim> end)(...)
instrumented = (
    bit32_poly
    + before
    + "\n" + shim
    + "\nend)(...)\n"
)

with open(OUT, "w", encoding="utf-8") as f:
    f.write(instrumented)

print("wrote", OUT, "size", os.path.getsize(OUT))

res = subprocess.run(["lua", OUT], capture_output=True, text=True, cwd=HERE)
print("stdout:", res.stdout)
print("stderr:", res.stderr[-600:])
print("rc:", res.returncode)
print("dump exists:", os.path.exists(DUMP), "size:", os.path.getsize(DUMP) if os.path.exists(DUMP) else 0)
