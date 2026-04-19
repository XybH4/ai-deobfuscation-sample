-- =====================================================================
-- Deobfuscation of obfuscated.lua (ib2 fork — Ironbrew 2 variant)
--
-- Method used:
--   1. Hooked the script's VM deserializer `s()` to dump the 14-proto tree
--      (instructions + constants + sub-protos + param counts).
--      Full dump is in deobf/ib2_proto.txt.
--   2. Mapped VM opcodes back to Lua 5.1 ops by reading the dispatcher
--      handlers (MOVE, GETTABLE, SETTABLE, GETGLOBAL, CALL, CLOSURE,
--      SELF, TEST/JMP, RETURN, LOADK, LOADBOOL, NEWTABLE, LEN, SUB, ...).
--   3. Reconstructed the high-level Lua from proto #1..#14.
--
-- This is a VM-derived reconstruction, not a textual diff of the original.
-- Variable names are inferred from adjacent constant strings and Roblox
-- API patterns; control flow and constant values are faithful to the VM.
--
-- What the script is: a Roblox client-side aimbot hook for a sword /
-- combat game. It:
--   * loads game modules (Modules.Utility, Modules.GameplayUtility,
--     PlayerScripts.Controllers.FighterController),
--   * finds the closest enemy player on-screen (skipping teammates,
--     deflecting players, and players behind walls),
--   * hooks the Utility and FighterController Raycast functions so they
--     redirect shots/swings toward the enemy's Head (or config.TargetPart)
--     when the hook fires from game code (checkcaller), subject to a
--     HitChance roll.
-- =====================================================================

return (function(...)

    -- -------- services --------
    local UserInputService   = game:GetService("UserInputService")
    local Players            = game:GetService("Players")
    local ReplicatedStorage  = game:GetService("ReplicatedStorage")
    local RunService         = game:GetService("RunService")
    local Camera             = workspace.CurrentCamera
    local LocalPlayer        = Players.LocalPlayer

    -- -------- cheat config --------
    local Config = {
        Enabled     = true,
        HitChance   = 100,
        TargetPart  = "Head",
        MaxDistance = 5000,
        TeamCheck   = true,
        WallCheck   = true,
    }

    -- -------- hook state --------
    local State = {
        OriginalRaycast        = nil,
        OriginalUtilityRaycast = nil,
        HookedUtility          = false,
        HookedGameplay         = false,
    }

    -- Safe require helper (proto #12)
    local function safeRequire(instance)
        local ok, result = pcall(require, instance)
        if ok then return result end
        return nil
    end

    -- -------- resolve game modules (protos #2, #3, #4) --------
    local Utility          = safeRequire(ReplicatedStorage.Modules.Utility)
    local GameplayUtility  = safeRequire(ReplicatedStorage.Modules.GameplayUtility)
    local FighterController =
        safeRequire(LocalPlayer.PlayerScripts.Controllers.FighterController)

    -- -------- IsValidPlayer (proto #5) --------
    -- Reject self, teammates (if TeamCheck), players with TeammateLabel gui.
    local function IsValidPlayer(player)
        if Config.TeamCheck then
            if not player.Team then return false end
            if not LocalPlayer.Team then return false end
            if player.Team == LocalPlayer.Team then return false end
        end
        if not player.Character then return false end
        local hrp = player.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return false end
        if hrp:FindFirstChild("TeammateLabel") then return false end
        return true
    end

    -- -------- IsWallBetween (proto #6) --------
    local function IsWallBetween(player)
        if not player.Character then return false end
        local rp = RaycastParams.new()
        rp.FilterDescendantsInstances = { LocalPlayer.Character, player.Character }
        rp.FilterType = Enum.RaycastFilterType.Exclude
        local origin = Camera.CFrame.Position
        local target = player.Character.HumanoidRootPart.CFrame.Position
        local result = workspace:Raycast(origin, target - origin, rp)
        if not result then return false end
        if result.Instance:IsDescendantOf(player.Character) then return false end
        return true
    end

    -- -------- IsDeflecting (proto #7) --------
    -- Skip players who are actively parrying (game marks them with a
    -- "_katana_deflect_active_not_local" flag + enabled particles).
    local function IsDeflecting(player)
        if not player.Character then return false end
        local hrp = player.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return false end
        if not hrp:FindFirstChild("_katana_deflect_active_not_local") then
            return false
        end
        for _, child in ipairs(hrp:GetChildren()) do
            if child:IsA("ParticleEmitter") and child.Enabled then
                return true
            end
        end
        return false
    end

    -- -------- GetClosestPlayer (proto #8) --------
    -- Score every valid player by on-screen distance from the mouse,
    -- return { target, character, hrp } for the best candidate.
    local function GetClosestPlayer()
        local target, targetChar, targetHRP
        if not LocalPlayer.Character then return nil end
        local targetPartName = Config.TargetPart or "Head"
        local bestDist = math.huge

        for _, plr in ipairs(Players:GetPlayers()) do
            repeat
                if plr == LocalPlayer then break end
                if not plr.Character then break end
                local char    = plr.Character
                local part    = char:FindFirstChild(targetPartName)
                local humanoid = char:FindFirstChild("Humanoid")
                if not part then break end
                if humanoid.Health <= 0 then break end
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if not hrp then break end
                if hrp:FindFirstChild("TeammateLabel") then break end

                if Config.TeamCheck     and not IsValidPlayer(plr)   then break end
                if not IsDeflecting  and IsDeflecting(plr)           then break end
                -- (sanity: skip if deflecting)
                if IsDeflecting(plr) then break end

                local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
                if not onScreen then break end

                if Config.WallCheck and IsWallBetween(plr) then break end

                local distWorld = (part.Position - Camera.CFrame.Position).Magnitude
                if distWorld > Config.MaxDistance then break end

                local mouse = UserInputService:GetMouseLocation()
                local dx    = Vector2.new(screenPos.X, screenPos.Y) - mouse
                local dist  = dx.Magnitude

                if dist < bestDist then
                    bestDist   = dist
                    target     = plr
                    targetChar = char
                    targetHRP  = hrp
                end
            until true
        end

        if not target then return nil end
        return { target, targetChar, targetHRP }
    end

    -- -------- HookUtility (proto #9 + inner closure proto #13) --------
    -- Patches Utility.Raycast so raycasts made by the game code are
    -- redirected to the aim target's position (subject to checks).
    local function HookUtility()
        if State.HookedUtility then return end
        if not Utility or not Utility.Raycast then return end
        State.HookedUtility          = true
        State.OriginalUtilityRaycast = Utility.Raycast

        Utility.Raycast = function(a, b, c, d, e, f)
            -- Skip when the call is made by our own script (checkcaller == true).
            if checkcaller() then
                return State.OriginalUtilityRaycast(a, b, c, d, e, f)
            end
            if not Config.Enabled then
                return State.OriginalUtilityRaycast(a, b, c, d, e, f)
            end

            local best = GetClosestPlayer()
            if not best then
                return State.OriginalUtilityRaycast(a, b, c, d, e, f)
            end
            if math.random(1, 100) > Config.HitChance then
                return State.OriginalUtilityRaycast(a, b, c, d, e, f)
            end

            -- Redirect the raycast direction toward the target part.
            local targetPart = best[2]:FindFirstChild(Config.TargetPart)
            b = targetPart.Position  -- parameter 2 = direction/target
            return State.OriginalUtilityRaycast(a, b, c, d, e, f)
        end
    end

    -- -------- HookGameplay (proto #10 + inner closure proto #14) --------
    -- Same pattern as HookUtility but against FighterController.Raycast.
    local function HookGameplay()
        if State.HookedGameplay then return end
        if not FighterController or not FighterController.Raycast then return end
        State.HookedGameplay   = true
        State.OriginalRaycast  = FighterController.Raycast

        FighterController.Raycast = function(a, b, c, d, e)
            if checkcaller() then
                return State.OriginalRaycast(a, b, c, d, e)
            end
            if not Config.Enabled then
                return State.OriginalRaycast(a, b, c, d, e)
            end

            local best = GetClosestPlayer()
            if not best then
                return State.OriginalRaycast(a, b, c, d, e)
            end
            if math.random(1, 100) > Config.HitChance then
                return State.OriginalRaycast(a, b, c, d, e)
            end

            local targetPart = best[2]:FindFirstChild(Config.TargetPart)
            b = targetPart.Position
            return State.OriginalRaycast(a, b, c, d, e)
        end
    end

    -- -------- install both hooks (proto #11 style launcher) --------
    HookUtility()
    HookGameplay()

end)(...)
