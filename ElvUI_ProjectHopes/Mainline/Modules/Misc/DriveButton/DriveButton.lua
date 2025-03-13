local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

local DB = E:NewModule('DriveButton', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0')
local S = E:GetModule('Skins')

local DRIVE_TREE_ID = 1056
local registered = false

local function ToggleDRIVE()
  if GenericTraitFrame and GenericTraitFrame:IsShown() then
    GenericTraitFrame:Hide()
  else
    C_AddOns.LoadAddOn("Blizzard_GenericTraitUI")
    if not tIndexOf(UISpecialFrames, "GenericTraitFrame") then
      table.insert(UISpecialFrames, "GenericTraitFrame")
    end
    GenericTraitFrame:SetTreeID(DRIVE_TREE_ID)
    GenericTraitFrame:Show()
    GenericTraitFrame:SetPoint("CENTER")
  end
end

local function CheckRegistration(buttonLDB)
  if registered then return end
  if C_Traits.GetConfigIDByTreeID(DRIVE_TREE_ID) then
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
    icon = "interface/icons/inv_viciousgoblintrike",
    OnClick = ToggleDRIVE,
    OnTooltipShow = function(tooltip)
      tooltip:AddLine("Open DRIVE Configuration menu.")
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
