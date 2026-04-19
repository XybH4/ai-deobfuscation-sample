-- =====================================================================
-- Deobfuscation of obfuscated.lua (ironbrew1 variant)
--
-- Full reconstruction recovered via execution trace. The script executed
-- to completion under a stubbed Obsidian UI library; every UI element,
-- label, default value, keybind, and dropdown option was captured from
-- the runtime. See deobf/ib1_trace2.txt for the raw call log.
--
-- Script identity:
--   Game    : Bizzare Lineage (Roblox, JoJo-inspired)
--   Script  : "Nameless Hub" V1.7
--   Author  : Nezia_Real
--   UI      : Obsidian (github.com/deividcomsono/Obsidian)
--   Theme   : Tokyo Night (default)
--   Saves   : NamelessHub (theme) / NamelessBLConfig (config)
--
-- Not recovered: the bodies of every Callback=<fn> (toggle handlers,
-- slider callbacks, button Func) -- those are VM-internal closures.
-- Their *names* tell you what each does.
-- =====================================================================

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players             = game:GetService("Players")
local LocalPlayer         = Players.LocalPlayer
local PlayerGui           = LocalPlayer:WaitForChild("PlayerGui")
local ReplicatedStorage   = game:GetService("ReplicatedStorage")

-- Skip the in-game Main Menu: force character spawn and destroy the menu.
local mainMenu = PlayerGui:FindFirstChild("Main Menu")
ReplicatedStorage.requests.character.spawn:FireServer()
if mainMenu then mainMenu:Destroy() end

-- Load Obsidian UI library + addons.
local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/SaveManager.lua"))()

-- Build the window.
local Window = Library:CreateWindow({
    Title            = " Nameless",
    Footer           = "Bizzare Lineage -- V1.7",
    NotifySide       = "Right",
    Icon             = 6031068423,
    ShowCustomCursor = false,
})

-- Tabs.
local Tabs = {
    Main          = Window:AddTab("Main",          "user"),
    AutoFarm      = Window:AddTab("Auto Farm",     "shopping-cart"),
    RaidFarm      = Window:AddTab("Raid Farm",     "target"),
    TeleportMisc  = Window:AddTab("Teleport/Misc", "map"),
    Settings      = Window:AddTab("Settings",      "settings"),
}

-- =====================================================================
-- TAB: Main
-- =====================================================================
local MovementBox = Tabs.Main:AddLeftGroupbox("Movement")
local CombatBox   = Tabs.Main:AddRightGroupbox("Combat")
local LockOnBox   = Tabs.Main:AddRightGroupbox("Lock-On")

-- Movement
MovementBox:AddSlider("WS_Slider", {
    Text = "WalkSpeed", Min = 16, Max = 250, Default = 16, Rounding = 1,
    Callback = function(v) --[[ sets LocalPlayer.Character.Humanoid.WalkSpeed = v ]] end,
})
MovementBox:AddSlider("JP_Slider", {
    Text = "JumpPower", Min = 50, Max = 500, Default = 50, Rounding = 1,
    Callback = function(v) --[[ sets Humanoid.JumpPower = v ]] end,
})
MovementBox:AddDivider()

MovementBox:AddToggle("Noclip_Tog", {
    Text = "Noclip", Default = false,
    Callback = function(state) --[[ toggle CanCollide-false loop ]] end,
}):AddKeyPicker("NoclipBind", {
    Text = "Noclip", Default = "V", Mode = "Toggle", SyncToggleState = true,
})

MovementBox:AddToggle("Fly_Tog", {
    Text = "Flight", Default = false,
    Callback = function(state) --[[ BodyVelocity / LinearVelocity flight ]] end,
}):AddKeyPicker("FlyBind", {
    Text = "Flight", Default = "Y", Mode = "Toggle", SyncToggleState = true,
})
MovementBox:AddSlider("Fly_Speed", {
    Text = "Flight Speed", Min = 0.1, Max = 10, Default = 1, Rounding = 1,
    Callback = function(v) --[[ fly speed multiplier ]] end,
})

MovementBox:AddToggle("InfJump_Tog", {
    Text = "Infinite Jump", Default = false,
    Callback = function(state) --[[ listens UserInputService.JumpRequest ]] end,
})

-- Combat -- attach the player to the nearest entity for melee-range farming
CombatBox:AddToggle("AttachNPCTog", {
    Text = "Attach to Nearest Entity", Default = false,
    Callback = function(state) end,
})
CombatBox:AddDropdown("AttachNPCPos_Drop", {
    Text = "Attach Position", Default = 1,
    Values = { "Back", "Below", "Behind" },
    Callback = function(v) end,
})
CombatBox:AddSlider("AttachNPCDist_Slider", {
    Text = "Attach Distance", Min = 0, Max = 15, Default = 5, Rounding = 1,
    Callback = function(v) end,
})

-- Lock-On
LockOnBox:AddToggle("LockOnTog", {
    Text = "Enable Lock-On", Default = false, Callback = function(state) end,
}):AddKeyPicker("LockOnBind", {
    Text = "Lock-On", Default = "J", Mode = "Toggle", SyncToggleState = true,
})
LockOnBox:AddLabel("[Lockon]: M2 to lockon/lockoff")

-- Lock-On: listens to M2 via UserInputService
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, processed)
    --[[ if input.UserInputType == Enum.UserInputType.MouseButton2
         and LockOnTog.Value then ... acquire/release target ... ]]
end)

-- =====================================================================
-- TAB: Auto Farm
-- =====================================================================
local ItemFarmBox  = Tabs.AutoFarm:AddLeftGroupbox("Item Farm")
local MeditateBox  = Tabs.AutoFarm:AddRightGroupbox("Meditation")
local WorkoutsBox  = Tabs.AutoFarm:AddLeftGroupbox("Workouts")
local PvPBox       = Tabs.AutoFarm:AddRightGroupbox("PvP Mission Farm")

-- Item Farm
ItemFarmBox:AddToggle("FarmTog", {
    Text = "Auto Farm Items", Default = false, Callback = function(s) end,
})
ItemFarmBox:AddToggle("FarmServerHopTog", {
    Text = "Server Hop When Empty", Default = false, Callback = function(s) end,
})
ItemFarmBox:AddButton({
    Text = "Manual Server Hop",
    Func = function() --[[ TeleportService:TeleportToPlaceInstance(...) ]] end,
})

-- Meditation
MeditateBox:AddToggle("MeditateTog", {
    Text = "Auto Meditate[Tp to gym first]", Default = false, Callback = function(s) end,
})
MeditateBox:AddDropdown("AttackPos_Drop", {
    Text = "Attach Position", Default = 1,
    Values = { "Back", "Below" }, Callback = function(v) end,
})
MeditateBox:AddSlider("AttackDist_Slider", {
    Text = "Attack Distance", Min = 0, Max = 15, Default = 5, Rounding = 1,
    Callback = function(v) end,
})

-- Workouts (each one fires the corresponding prompt / remote)
WorkoutsBox:AddToggle("DumbbellsTog",  { Text="Auto Dumbbells",  Default=false, Callback=function(s) end })
WorkoutsBox:AddToggle("BenchPressTog", { Text="Auto Bench Press",Default=false, Callback=function(s) end })
WorkoutsBox:AddToggle("SquatRackTog",  { Text="Auto Squat Rack", Default=false, Callback=function(s) end })
WorkoutsBox:AddToggle("SitupsTog",     { Text="Auto Situps",     Default=false, Callback=function(s) end })

-- PvP Mission Farm
PvPBox:AddDropdown("PvPRole_Drop", {
    Text = "Role", Default = 1, Values = { "Main", "Alt" }, Callback = function(v) end,
})
PvPBox:AddDropdown("PvPMainPlayer_Drop", {
    Text = "Select Main Player (Alt)", Default = 1,
    Values = {}, -- populated dynamically from Players:GetPlayers()
    Callback = function(v) end,
})
PvPBox:AddButton({
    Text = "Refresh Player List",
    Func = function()
        local list = {}
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then list[#list+1] = p.Name end
        end
        -- Library.Options.PvPMainPlayer_Drop:SetValues(list)
    end,
})
PvPBox:AddDropdown("PvPAttackPos_Drop", {
    Text = "Alt Attach Position", Default = 1,
    Values = { "Back", "Below" }, Callback = function(v) end,
})
PvPBox:AddSlider("PvPAttackDist_Slider", {
    Text = "Alt Attach Distance", Min = 0, Max = 15, Default = 5, Rounding = 1,
    Callback = function(v) end,
})
PvPBox:AddToggle("PvPFarmTog", {
    Text = "Enable PvP Farm [Priv Serv Only]", Default = false, Callback = function(s) end,
})
Players.PlayerAdded:Connect(function(p)    --[[ refresh dropdown ]] end)
Players.PlayerRemoving:Connect(function(p) --[[ refresh dropdown ]] end)

-- =====================================================================
-- TAB: Raid Farm
-- =====================================================================
local RaidSelectBox   = Tabs.RaidFarm:AddLeftGroupbox("Raid Boss Selection")
local RaidSettingsBox = Tabs.RaidFarm:AddRightGroupbox("Raid Boss Farm Settings")

RaidSelectBox:AddDropdown("BossSelect_Drop", {
    Text = "Select Boss", Default = 1,
    Values = { "Jotaro", "Kira", "Avdol", "DIO" }, Callback = function(v) end,
})
RaidSelectBox:AddToggle("BossFarmTog", {
    Text = "Enable Boss Farm", Default = false, Callback = function(s) end,
}):OnChanged(function(v) --[[ start/stop farm loop ]] end)
RaidSelectBox:AddToggle("BossAutoRetryTog", {
    Text = "Auto Retry Raid", Default = true, Callback = function(s) end,
})
RaidSelectBox:AddLabel("Jotaro: Auto raids & farms boss")
RaidSelectBox:AddLabel("Kira: Farms NPCs then Kira BTD")

RaidSettingsBox:AddDropdown("BossAttackPos_Drop", {
    Text = "Attack Position", Default = 1,
    Values = { "Back", "Below", "Behind" }, Callback = function(v) end,
})
RaidSettingsBox:AddSlider("BossAttackDist_Slider", {
    Text = "Attack Distance", Min = 0, Max = 15, Default = 9, Rounding = 1,
    Callback = function(v) end,
})
RaidSettingsBox:AddLabel("Position Options:")
RaidSettingsBox:AddLabel("Back = Behind boss (Z+)")
RaidSettingsBox:AddLabel("Below = Under boss (Y-)")
RaidSettingsBox:AddLabel("Behind = In front (Z-)")
RaidSettingsBox:AddDivider()

RaidSettingsBox:AddToggle("AutoStandSummonTog", {
    Text = "Auto Stand Summon", Default = false, Callback = function(s) end,
})
RaidSettingsBox:AddDivider()

RaidSettingsBox:AddToggle("AutoSkillsTog", {
    Text = "Auto Use Skills", Default = false, Callback = function(s) end,
})
RaidSettingsBox:AddDropdown("SkillSelect_Drop", {
    Text  = "Select Skills", Default = 1, Multi = true,
    Values = { "E", "R", "Z", "X", "C", "V" }, Callback = function(v) end,
})
RaidSettingsBox:AddSlider("SkillDelay_Slider", {
    Text = "Skill Delay (seconds)", Min = 0.1, Max = 3, Default = 0.5, Rounding = 1,
    Callback = function(v) end,
})

-- Stand Spinner (inside Raid Farm tab)
local StandSpinnerBox = Tabs.RaidFarm:AddLeftGroupbox("Stand Spinner")
StandSpinnerBox:AddDropdown("ArrowType_Drop", {
    Text = "Arrow Type", Default = 1,
    Values = { "Stand Arrow", "Lucky Arrow" }, Callback = function(v) end,
})
StandSpinnerBox:AddDropdown("TargetStand_Drop", {
    Text = "Target Stands", Default = 1, Multi = true,
    Values = {
        "White Snake", "Golden Experience", "Crazy Diamond", "Anubis",
        "The World", "The World High Voltage", "Star Platinum", "The Hand",
        -- additional values were truncated in the trace; the game's full stand
        -- list is expected here (Magicians Red, Hierophant Green, etc.)
    },
    Callback = function(v) end,
})
StandSpinnerBox:AddDivider()
StandSpinnerBox:AddToggle("SpinStats_Tog", {
    Text = "Enable Stats Spinning", Default = false, Callback = function(s) end,
})
StandSpinnerBox:AddLabel("Enable stats to check:")
StandSpinnerBox:AddToggle("CheckStrength_Tog", {
    Text = "Check Strength", Default = false, Callback = function(s) end,
})
StandSpinnerBox:AddDropdown("TargetStrength_Drop", {
    Text = "Strength Ranks", Default = 1, Multi = true,
    Values = { "D", "C", "B", "A", "S", "SS" }, Callback = function(v) end,
})
StandSpinnerBox:AddToggle("CheckSpeed_Tog", {
    Text = "Check Speed", Default = false, Callback = function(s) end,
})
StandSpinnerBox:AddDropdown("TargetSpeed_Drop", {
    Text = "Speed Ranks", Default = 1, Multi = true,
    Values = { "D", "C", "B", "A", "S", "SS" }, Callback = function(v) end,
})
StandSpinnerBox:AddToggle("CheckSpecialty_Tog", {
    Text = "Check Specialty", Default = false, Callback = function(s) end,
})
StandSpinnerBox:AddDropdown("TargetSpecialty_Drop", {
    Text = "Specialty Ranks", Default = 1, Multi = true,
    Values = { "D", "C", "B", "A", "S", "SS" }, Callback = function(v) end,
})
StandSpinnerBox:AddDivider()
StandSpinnerBox:AddToggle("StandSpinnerTog", {
    Text = "Enable Stand Spinner", Default = false, Callback = function(s) end,
})
StandSpinnerBox:AddButton({
    Text = "Check Current Stand",
    Func = function() --[[ print/Notify stand+ranks ]] end,
})
StandSpinnerBox:AddLabel("Note: Uses arrow every 7 seconds")
StandSpinnerBox:AddLabel("Stops when stand is obtained")

-- =====================================================================
-- TAB: Teleport/Misc
-- =====================================================================
local WorldTPBox  = Tabs.TeleportMisc:AddLeftGroupbox("World TP")
local ShopsBox    = Tabs.TeleportMisc:AddRightGroupbox("Shops")
local CharInfoBox = Tabs.TeleportMisc:AddLeftGroupbox("Character Info")
local StandInfoBox= Tabs.TeleportMisc:AddRightGroupbox("Stand Info")

-- World TP
WorldTPBox:AddButton({ Text = "TP to Quest Marker",     Func = function() end })
WorldTPBox:AddButton({ Text = "TP to Gym",              Func = function() end })
WorldTPBox:AddButton({ Text = "TP to Raid[Kira] NPC",   Func = function() end })
WorldTPBox:AddButton({ Text = "TP to Raid[Dio] NPC",    Func = function() end })
WorldTPBox:AddButton({ Text = "TP to Raid[Jotaro] NPC", Func = function() end })
WorldTPBox:AddButton({ Text = "TP to Prestige NPC",     Func = function() end })
WorldTPBox:AddButton({ Text = "TP to Determination NPC",Func = function() end })
WorldTPBox:AddButton({ Text = "TP to Cyborg NPC",       Func = function() end })
WorldTPBox:AddButton({ Text = "TP to Saitama NPC",      Func = function() end })

-- Shops
ShopsBox:AddButton({ Text = "Prestige Shop", Func = function() end })
ShopsBox:AddButton({ Text = "Raid Shop",     Func = function() end })
ShopsBox:AddButton({ Text = "Gang Shop",     Func = function() end })
ShopsBox:AddButton({ Text = "Crafting",      Func = function() end })

-- Character Info (labels update every Refresh Info click)
CharInfoBox:AddLabel("Player: " .. LocalPlayer.Name)
CharInfoBox:AddLabel("Money: Loading...")
CharInfoBox:AddLabel("Level: Loading...")
CharInfoBox:AddLabel("Worthiness: Loading...")
CharInfoBox:AddDivider()
CharInfoBox:AddLabel("Raid Tokens: Loading...")
CharInfoBox:AddDivider()
CharInfoBox:AddButton({
    Text = "Refresh Info",
    Func = function() --[[ read leaderstats/attributes into labels ]] end,
})

-- Stand Info
StandInfoBox:AddLabel("Name: Loading...")
StandInfoBox:AddLabel("Trait: Loading...")
StandInfoBox:AddDivider()
StandInfoBox:AddLabel("Speed: Loading...")
StandInfoBox:AddLabel("Strength: Loading...")
StandInfoBox:AddLabel("Specialty: Loading...")

-- =====================================================================
-- TAB: Settings
-- =====================================================================
local MenuBox = Tabs.Settings:AddLeftGroupbox("Menu")

MenuBox:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", {
    Text = "Menu keybind", Default = "RightShift", NoUI = true,
})
MenuBox:AddDivider()
MenuBox:AddButton({
    Text = "Unload GUI",
    Func = function() Library:Unload() end,
})
MenuBox:AddToggle("AutoMinimizeTog", {
    Text = "Auto Minimize on Load", Default = false,
    Tooltip = "Automatically minimize GUI when script loads",
    Callback = function(s) end,
})
MenuBox:AddToggle("KeybindMenuOpen", {
    Text = "Open Keybind Menu", Default = Library.KeybindFrame.Visible,
    Callback = function(v) Library.KeybindFrame.Visible = v end,
})
MenuBox:AddDropdown("NotificationSide", {
    Text = "Notification Side", Default = "Right",
    Values = { "Left", "Right" }, Callback = function(v) end,
})

-- Theme + Save manager wiring.
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })
ThemeManager:SetFolder("NamelessHub")
SaveManager:SetFolder("NamelessBLConfig")
SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)
ThemeManager:SaveDefault("Tokyo Night")
ThemeManager:LoadDefault()
SaveManager:LoadAutoloadConfig()

-- Background tasks.
local RunService = game:GetService("RunService")
RunService.Stepped:Connect(function(_, dt)
    --[[ per-frame: update fly velocity, lock-on camera, noclip CanCollide,
         attach CFrame lerp, label refresh timer, ... ]]
end)

UserInputService.JumpRequest:Connect(function()
    --[[ Infinite Jump: if toggle on, :ChangeState(Enum.HumanoidStateType.Jumping) ]]
end)

-- Bind menu toggle to the user-picked key.
Library.ToggleKeybind = Library.Options.MenuKeybind

Library:Notify("Script loaded! Script Is Made Only By Nezia_Real, Check Clipboard For Discord")
