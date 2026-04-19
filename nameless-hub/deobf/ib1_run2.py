"""
v2: Comprehensive Obsidian library mock so the VM can finish executing
and every :AddTab/:AddGroupbox/:AddToggle/:AddSlider/:AddButton/:OnChanged
/etc. call is logged. The trace becomes the cheat's full feature list.

Key insight from v1: the VM halted because our proxy returned non-number
values where arithmetic/comparisons were expected (ib1 VM does numeric ops
on its own internal state, not on user data -- but the proxy still needs to
respond to *every* method call Obsidian exposes so the user code doesn't
feed `nil` into the VM via `x = y.z` patterns).
"""
import os, subprocess

HERE = os.path.dirname(os.path.abspath(__file__))
SRC  = os.path.normpath(os.path.join(HERE, "..", "obfuscated.lua"))
RUNNER = os.path.join(HERE, "ib1_runner2.lua")
TRACE  = os.path.join(HERE, "ib1_trace2.txt")

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

-- Helper to describe arbitrary Lua values in one line.
local function desc(v, depth)
  depth = depth or 0
  local t = type(v)
  if t == "string"  then return string.format("%q", v) end
  if t == "number"  then return tostring(v) end
  if t == "boolean" then return tostring(v) end
  if t == "nil"     then return "nil" end
  if t == "function" then return "<fn>" end
  if t == "table" then
    if depth > 2 then return "<t>" end
    local out, n = {}, 0
    for k, vv in pairs(v) do
      n = n + 1; if n > 8 then table.insert(out, "..."); break end
      table.insert(out, tostring(k).."="..desc(vv, depth+1))
    end
    return "{"..table.concat(out, ", ").."}"
  end
  return "<"..t..">"
end

local function descArgs(...)
  local args = {...}
  local out, n = {}, select("#", ...)
  for i = 1, n do out[i] = desc(args[i], 0) end
  return table.concat(out, ", ")
end

-- Generic proxy. Any __index returns another proxy. Any __call logs + returns
-- another proxy. Arithmetic coerces to 0; comparisons return false.
local proxyMT = {}
local function newProxy(name)
  local t = {}
  setmetatable(t, proxyMT)
  rawset(t, "__proxy_name", name)
  return t
end

proxyMT.__index = function(t, k)
  local nm = rawget(t, "__proxy_name") or "?"
  tr("INDEX  ", nm, " -> ", tostring(k))
  local ks = tostring(k)
  -- built-in Roblox service handling
  if ks == "HttpGet" or ks == "HttpGetAsync" then
    local child = function(self, url, ...)
      tr("CALL   ", nm, ":", ks, "(", tostring(url), ")")
      -- Real loadable Lua so loadstring() works, and the returned value is a
      -- proxy-like table. The proxy name embeds the URL so later traces
      -- identify which library the call came from.
      local safeName = tostring(url):gsub("[^%w]", "_")
      return "return _G.__newProxy('Fetched_" .. safeName .. "')"
    end
    return child
  elseif ks == "GetService" then
    return function(self, svc) tr("CALL   ", nm, ":GetService(", tostring(svc), ")"); return newProxy("game."..tostring(svc)) end
  elseif ks == "WaitForChild" or ks == "FindFirstChild" or ks == "FindFirstChildOfClass" or ks == "FindFirstChildWhichIsA" then
    return function(self, c, ...) tr("CALL   ", nm, ":", ks, "(", tostring(c), ")"); return newProxy(nm.."."..tostring(c)) end
  elseif ks == "GetChildren" or ks == "GetDescendants" or ks == "GetPlayers" then
    return function(self) tr("CALL   ", nm, ":", ks, "()"); return {} end
  elseif ks == "GetPropertyChangedSignal" or ks == "Changed" or ks == "DescendantAdded" or ks == "ChildAdded" then
    return newProxy(nm.."."..ks)  -- a signal
  elseif ks == "Connect" or ks == "connect" or ks == "Once" or ks == "Wait" or ks == "wait" then
    return function(...) tr("CALL   ", nm, ":", ks, "(", descArgs(...), ")"); return newProxy(nm..":conn") end
  elseif ks == "IsLoaded" then
    return function() tr("CALL   ", nm, ":IsLoaded()"); return true end
  elseif ks == "IsA"  or ks == "IsDescendantOf" then
    return function() tr("CALL   ", nm, ":", ks, "()"); return false end
  elseif ks == "IsStudio" or ks == "IsServer" or ks == "IsEdit" then
    return function() tr("CALL   ", nm, ":", ks, "()"); return false end
  elseif ks == "IsClient" or ks == "IsRunning" then
    return function() tr("CALL   ", nm, ":", ks, "()"); return true end
  elseif ks == "UserId" or ks == "GameId" or ks == "PlaceId" then
    return 12345
  elseif ks == "Name" or ks == "DisplayName" or ks == "ClassName" then
    return "StubName"
  elseif ks == "Loaded" then
    return newProxy(nm..".Loaded")
  elseif ks == "CreateWindow" or ks == "CreateGroupBox" or ks == "CreateGroupbox"
     or ks == "AddTab" or ks == "AddGroupbox" or ks == "AddGroupBox"
     or ks == "AddSubTab" or ks == "AddLeftGroupbox" or ks == "AddRightGroupbox"
     or ks == "AddLeftGroupBox" or ks == "AddRightGroupBox"
     or ks == "AddTabbox" or ks == "AddTabBox"
     or ks == "AddToggle" or ks == "AddSlider" or ks == "AddInput"
     or ks == "AddButton" or ks == "AddLabel" or ks == "AddDivider"
     or ks == "AddDropdown" or ks == "AddColorPicker" or ks == "AddKeyPicker"
     or ks == "AddSearchBox" or ks == "AddSpacer" or ks == "AddDependencyBox"
     or ks == "OnChanged" or ks == "OnClick" or ks == "AddContextMenu"
     or ks == "OnChangedHover" or ks == "AddToolTip" or ks == "BindToToggle"
     or ks == "OnRightClick" or ks == "OnHover" or ks == "OnLeave"
     or ks == "DoClick" or ks == "Destroy" or ks == "SetValue" or ks == "SetText"
     or ks == "SetVisible" or ks == "Toggle" or ks == "AddKey" or ks == "SetActive"
     or ks == "SetLibrary" or ks == "SetBigButton"
     or ks == "SetIgnoreIndexes"
     or ks == "SetFolder" or ks == "LoadAutoloadConfig" or ks == "BuildConfigSection"
     or ks == "Load" or ks == "Save" or ks == "ApplyToTab" or ks == "AddConfigSection"
     or ks == "CreateThemeManager" or ks == "AddContextMenuGroup"
     or ks == "AddDescendants" or ks == "Notify" or ks == "NotifyAsync"
     or ks == "SetWatermarkVisibility" or ks == "SetKeybindsVisibility"
     or ks == "UpdateKeybindFrame" or ks == "UpdateWatermarkAlign"
     or ks == "UpdateWatermark"
  then
    return function(self, ...)
      tr("UI     ", nm, ":", ks, "(", descArgs(...), ")")
      return newProxy(nm..":"..ks)
    end
  else
    return newProxy(nm.."."..ks)
  end
end
proxyMT.__newindex = function(t, k, v)
  local nm = rawget(t, "__proxy_name") or "?"
  tr("SET    ", nm, ".", tostring(k), " = ", desc(v))
end
proxyMT.__call = function(t, ...)
  local nm = rawget(t, "__proxy_name") or "?"
  tr("CALL   ", nm, "(", descArgs(...), ")")
  return newProxy(nm.."()")
end
proxyMT.__tostring = function(t) return "<"..(rawget(t, "__proxy_name") or "?")..">" end
proxyMT.__concat   = function(a,b) return tostring(a)..tostring(b) end
proxyMT.__len      = function() return 0 end
proxyMT.__add = function() return 0 end
proxyMT.__sub = function() return 0 end
proxyMT.__mul = function() return 0 end
proxyMT.__div = function() return 1 end
proxyMT.__mod = function() return 0 end
proxyMT.__unm = function() return 0 end
proxyMT.__eq = function() return false end
proxyMT.__lt = function() return false end
proxyMT.__le = function() return false end

_G.__newProxy = newProxy
game       = newProxy("game")
workspace  = newProxy("workspace")
shared     = {}
_genv      = {}

function typeof(v) return type(v) end
local _wait_calls = 0
function wait(t)
  _wait_calls = _wait_calls + 1
  if _wait_calls > 3 then
    tr("WAIT_LIMIT reached, aborting game loop")
    error("__abort_loop__")
  end
  return t or 0
end
-- task.wait: after N calls, raise an error so `while task.wait() do ... end`
-- loops exit instead of spinning forever.
local _twait_calls = 0
local _TWAIT_LIMIT = 3
task = {
  wait  = function(t)
    _twait_calls = _twait_calls + 1
    if _twait_calls > _TWAIT_LIMIT then
      tr("TASK_WAIT_LIMIT reached, aborting game loop")
      error("__abort_loop__")
    end
    return t or 0
  end,
  spawn = function(f, ...) pcall(f, ...) end,
  defer = function(f, ...) pcall(f, ...) end,
  delay = function(_, f, ...) pcall(f, ...) end,
}
Enum       = newProxy("Enum")
Color3     = { new = function() return newProxy("Color3") end, fromRGB = function() return newProxy("Color3") end }
Vector3    = { new = function() return newProxy("Vector3") end, zero = newProxy("Vector3.zero") }
Vector2    = { new = function() return newProxy("Vector2") end }
UDim2      = { new = function() return newProxy("UDim2") end }
UDim       = { new = function() return newProxy("UDim") end }
CFrame     = { new = function() return newProxy("CFrame") end }
Instance   = { new = function(cls) return newProxy("Instance."..tostring(cls)) end }
RaycastParams = { new = function() return newProxy("RaycastParams") end }

function getgenv() return _genv end
function getrenv() return _G end
function getfenv() return _G end

debug = debug or {}
debug.info      = function(a,b) if b=="s" then return "LocalScript" end; if b=="l" then return 1 end; return "LocalScript" end
debug.traceback = function(m,l) return "LocalScript:1: "..tostring(m or "") end

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
function makefolder() end
function listfiles() return {} end
function identifyexecutor() return "stub","1" end
function getgc() return {} end
function getnamecallmethod() return "" end
function gethiddenproperty() return nil, false end
function sethiddenproperty() end
function fireclickdetector() end
function fireproximityprompt() end
function firetouchinterest() end
function getgenv() return _genv end
function setclipboard() end

local _real_loadstring = loadstring  -- save Lua-5.1 native before overriding
function loadstring(s, chunkname)
  tr("LOADSTRING url-chunk len=", tostring(#tostring(s)))
  local fn, err = _real_loadstring(s, chunkname)
  if not fn then
    tr("LOADSTRING parse-err: ", tostring(err))
    return function(...) return newProxy("LoadedLib") end
  end
  return function(...)
    tr("EXEC loadstring-chunk")
    local ok, res = pcall(fn, ...)
    if ok then return res else tr("EXEC err: ", tostring(res)); return newProxy("LoadedLib") end
  end
end
"""

stub = stub.replace("__TRACE__", TRACE.replace("\\", "\\\\"))

with open(SRC, "r", encoding="utf-8", errors="replace") as f:
    src = f.read()

with open(RUNNER, "w", encoding="utf-8") as f:
    f.write(stub)
    f.write("\n-- ========= obfuscated body (wrapped in xpcall) =========\n")
    f.write("local _ok, _err = xpcall(function()\n")
    f.write(src)
    f.write("\nend, function(e) tr('XPCALL_ERR ', tostring(e), ' @ ', debug.traceback('', 2)); return e end)\n")
    f.write("if not _ok then tr('SCRIPT_FAILED ', tostring(_err)) else tr('SCRIPT_OK') end\n")

print("wrote", RUNNER, "size", os.path.getsize(RUNNER))
res = subprocess.run(["lua", RUNNER], capture_output=True, text=True, cwd=HERE, timeout=540)
print("rc:", res.returncode)
print("stderr:", res.stderr[-600:])
if os.path.exists(TRACE):
    print("trace size:", os.path.getsize(TRACE), "bytes")
