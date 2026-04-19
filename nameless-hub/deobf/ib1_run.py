"""
Run an ironbrew1-obfuscated Lua file under instrumentation.
Log every index/call on the game proxy to recover the script's behaviour.
"""
import os, subprocess

HERE = os.path.dirname(os.path.abspath(__file__))
SRC  = os.path.normpath(os.path.join(HERE, "..", "obfuscated.lua"))
RUNNER = os.path.join(HERE, "ib1_runner.lua")
TRACE  = os.path.join(HERE, "ib1_trace.txt")
BODY   = os.path.join(HERE, "ib1_loadstring_body.txt")

stub = r"""
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

local _fh = io.open([[__TRACE__]], "w")
local function tr(...) _fh:write(...); _fh:write("\n"); _fh:flush() end

local function newProxy(name)
  local mt = {}
  local t = {}
  mt.__index = function(_, k)
    tr("INDEX  ", name, " -> ", tostring(k))
    local v
    local ks = tostring(k)
    if ks == "HttpGet" or ks == "HttpGetAsync" then
      v = function(self, url, ...)
        tr("CALL   ", name, ":", ks, "(", tostring(url), ")")
        return "-- stubbed body --"
      end
    elseif ks == "GetService" then
      v = function(self, svc) tr("CALL   ", name, ":GetService(", tostring(svc), ")"); return newProxy("game."..tostring(svc)) end
    elseif ks == "WaitForChild" or ks == "FindFirstChild" or ks == "FindFirstChildOfClass" then
      v = function(self, c, ...) tr("CALL   ", name, ":", ks, "(", tostring(c), ")"); return newProxy(name.."."..tostring(c)) end
    elseif ks == "GetChildren" or ks == "GetDescendants" then
      v = function(self) tr("CALL   ", name, ":", ks, "()"); return {} end
    elseif ks == "IsLoaded" then
      v = function(self) tr("CALL   ", name, ":IsLoaded()"); return true end
    elseif ks == "IsStudio" or ks == "IsServer" or ks == "IsEdit" then
      v = function(self) tr("CALL   ", name, ":", ks, "()"); return false end
    elseif ks == "IsClient" or ks == "IsRunning" then
      v = function(self) tr("CALL   ", name, ":", ks, "()"); return true end
    elseif ks == "UserId" or ks == "GameId" or ks == "PlaceId" then
      v = 12345
    elseif ks == "LocalPlayer" then
      v = newProxy(name..".LocalPlayer")
    elseif ks == "Name" or ks == "DisplayName" then
      v = "Player"
    elseif ks == "ClassName" then
      v = "Part"
    elseif ks == "Parent" then
      v = newProxy(name..".Parent")
    elseif ks == "Loaded" then
      v = { Wait = function() end, Connect = function() end }
    else
      v = newProxy(name.."."..ks)
    end
    rawset(t, k, v)
    return v
  end
  mt.__newindex = function(_, k, v)
    tr("SET    ", name, ".", tostring(k), " = ", tostring(v))
  end
  mt.__call = function(self, ...)
    tr("CALLALL ", name, "(", h("#",...), " args)")
    return nil
  end
  mt.__tostring = function() return "<"..name..">" end
  setmetatable(t, mt)
  return t
end

function h(_, ...) return select("#", ...) end  -- helper

game       = newProxy("game")
workspace  = newProxy("workspace")
shared     = {}
_genv      = {}

function typeof(v) return type(v) end
function wait(t) return t or 0 end
task = {
  wait = function(t) return t or 0 end,
  spawn = function(f, ...) pcall(f, ...) end,
  defer = function(f, ...) pcall(f, ...) end,
  delay = function(_, f, ...) pcall(f, ...) end,
}
Enum  = newProxy("Enum")
Color3    = { new = function() return newProxy("Color3") end, fromRGB = function() return newProxy("Color3") end }
Vector3   = { new = function(x,y,z) local v = newProxy("Vector3"); v.X, v.Y, v.Z = x or 0, y or 0, z or 0; return v end }
Vector2   = { new = function(x,y) local v = newProxy("Vector2"); v.X, v.Y = x or 0, y or 0; return v end }
UDim2     = { new = function() return newProxy("UDim2") end }
UDim      = { new = function() return newProxy("UDim") end }
CFrame    = { new = function() return newProxy("CFrame") end }
Instance  = { new = function(cls) return newProxy("Instance."..tostring(cls)) end }
RaycastParams = { new = function() return newProxy("RaycastParams") end }

function getgenv() return _genv end
function getrenv() return _G end
function getfenv() return _G end

debug = debug or {}
debug.info = function(a,b)
  if b == "s" then return "LocalScript" end
  if b == "l" then return 1 end
  return "LocalScript"
end
debug.traceback = function(m,l) return "LocalScript:1: "..tostring(m or "") end

-- stubs for executor-specific functions
function checkcaller() return false end
function hookfunction(orig, new) return orig end
function hookmetamethod(obj, name, fn) return fn end
function getrawmetatable(o) return {} end
function setreadonly() end
function newcclosure(f) return f end
function getscriptclosure() return function() end end
function isfile() return false end
function isfolder() return false end
function readfile() return "" end
function writefile() end
function delfile() end
function listfiles() return {} end
function identifyexecutor() return "stub","1" end
function getgc() return {} end
function request() return {StatusCode=200, Body="-- stub body --"} end
http_request = request

function loadstring(s, chunkname)
  tr("LOADSTRING ", "len=", #tostring(s))
  local fh = io.open([[__BODY__]], "a")
  fh:write(string.rep("=", 40), "\n-- chunk:", tostring(chunkname), " len=", #tostring(s), "\n", tostring(s), "\n")
  fh:close()
  -- Return a proxy that acts like any library/API. The same proxy handles
  -- Obsidian, ThemeManager, SaveManager, etc. — they all route through __index/__call.
  return function(...) tr("EXEC loadstring-chunk"); return newProxy("LoadedLib") end
end

-- Also capture any `error()` that the VM throws so trace survives.
local _err = error
function error(msg, level)
  tr("ERROR  ", tostring(msg))
  _err(msg, level)
end

-- clear existing body file
local f = io.open([[__BODY__]], "w"); f:close()
"""

stub = stub.replace("__TRACE__", TRACE.replace("\\", "\\\\"))
stub = stub.replace("__BODY__",  BODY.replace("\\",  "\\\\"))

with open(SRC, "r", encoding="utf-8", errors="replace") as f:
    src = f.read()

# Also provide a real, non-zero stub body for HttpGet so loadstring downstream
# has something to parse. Return a tiny Lua snippet that, when executed, returns
# an all-permissive proxy.
stub += r"""
-- override newProxy HttpGet to return a parseable tiny Lua chunk
local real_newProxy = newProxy
local function makeHttp()
  local p = real_newProxy("game_http")
  getmetatable(p).__index = function(_, k)
    if tostring(k) == "HttpGet" or tostring(k) == "HttpGetAsync" then
      return function(self, url)
        tr("CALL   game:HttpGet(", tostring(url), ")")
        return "return _G.newProxy(\"FetchedLib\")"
      end
    end
    -- fallback to original behaviour
    return getmetatable(p).__index_orig and getmetatable(p).__index_orig(_, k)
  end
end
_G.newProxy = real_newProxy

-- Replace game's HttpGet with a real string-returning impl.
do
  local gmt = getmetatable(game)
  local orig = gmt.__index
  gmt.__index = function(t, k)
    if tostring(k) == "HttpGet" or tostring(k) == "HttpGetAsync" then
      return function(self, url)
        tr("CALL   game:HttpGet(", tostring(url), ")")
        return "return _G.newProxy(\"Fetched_"..tostring(url):gsub("[^%w]","_").."\")"
      end
    end
    return orig(t, k)
  end
end
"""
with open(RUNNER, "w", encoding="utf-8") as f:
    f.write(stub)
    f.write("\n-- ========= obfuscated body (wrapped in xpcall) =========\n")
    f.write("local _ok, _err = xpcall(function()\n")
    f.write(src)
    f.write("\nend, function(e) tr('XPCALL_ERR ', tostring(e)); return e end)\n")
    f.write("if not _ok then tr('SCRIPT_FAILED ', tostring(_err)) end\n")

print("wrote", RUNNER, "size", os.path.getsize(RUNNER))
# Guard against infinite loops with a short timeout; ib1 has LOTS of state-machine
# junk so give it time.
res = subprocess.run(["lua", RUNNER], capture_output=True, text=True, cwd=HERE, timeout=60)
print("rc:", res.returncode)
print("stdout:", res.stdout[-500:])
print("stderr:", res.stderr[-1500:])
if os.path.exists(TRACE):
    print("trace size:", os.path.getsize(TRACE))
