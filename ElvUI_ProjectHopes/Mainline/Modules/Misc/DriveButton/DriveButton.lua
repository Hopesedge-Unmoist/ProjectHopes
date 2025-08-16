local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

local DB = E:NewModule('DriveButton', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0')
local S = E:GetModule('Skins')

local SYSTEM_ID = 29
local TREE_ID = 1115
local registered = false

local function ToggleDRIVE()
    GenericTraitUI_LoadUI()
    GenericTraitFrame:SetSystemID(SYSTEM_ID)
    GenericTraitFrame:SetTreeID(TREE_ID)
    ToggleFrame(GenericTraitFrame)
end

local function CheckRegistration(buttonLDB)
    if registered then return end
    if C_Traits.GetConfigIDByTreeID(TREE_ID) then
        local icon = LibStub("LibDBIcon-1.0")
        if icon and buttonLDB then
            icon:Register("DRIVEButton", buttonLDB, DRIVE_BUTTON_MINIMAP)
            SlashCmdList["DRIVEButton"] = ToggleDRIVE
            registered = true
        end
    end
end

function DB:Initialize()
    if not E.db.ProjectHopes.qualityOfLife.driveButton then return end
    
    S:AddCallbackForAddon(Name, CheckRegistration)

    DRIVE_BUTTON_MINIMAP = DRIVE_BUTTON_MINIMAP or {}

    buttonLDB = LibStub("LibDataBroker-1.1"):NewDataObject("DRIVEButton", {
        type = "launcher",
        text = "DRIVE",
        icon = "interface/icons/inv_cape_armor_etherealshawl_d_01",
        OnClick = ToggleDRIVE,
        OnTooltipShow = function(tooltip)
            tooltip:AddLine("Open Cloak Configuration menu.")
        end,
    })

    local eventWatcher = CreateFrame("Frame")
    eventWatcher:RegisterEvent("TRAIT_CONFIG_LIST_UPDATED")
    eventWatcher:RegisterEvent("PLAYER_ENTERING_WORLD")
    eventWatcher:RegisterEvent("TRAIT_CONFIG_CREATED")
    eventWatcher:SetScript("OnEvent", function() CheckRegistration(buttonLDB) end)

    CheckRegistration(buttonLDB)
end

E:RegisterModule(DB:GetName())
