-- Thanks to WindTools(fang2hou) for the base code. 
-- Cleaned and improved version with better error handling and performance.

local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local FM = E:NewModule('FrameMover', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0')
local B = E:GetModule("Bags")

local _G = _G
local pairs, ipairs = pairs, ipairs
local type = type
local InCombatLockdown = InCombatLockdown
local RunNextFrame = RunNextFrame
local C_AddOns_IsAddOnLoaded = C_AddOns.IsAddOnLoaded

local processedFrames = {}
local delayedFrames = {}

local FRAME_DATA = {
    core = {
        "AddonList", "AudioOptionsFrame", "BankFrame", "BonusRollFrame",
        "ChatConfigFrame", "CinematicFrame", "ContainerFrameCombinedBags",
        "DestinyFrame", "FriendsFrame", "GameMenuFrame", "GossipFrame",
        "GuildInviteFrame", "GuildRegistrarFrame", "HelpFrame", "ItemTextFrame",
        "LFDRoleCheckPopup", "LFGDungeonReadyDialog", "LFGDungeonReadyStatus",
        "LootFrame", "MerchantFrame", "PetitionFrame", "PetStableFrame",
        "ReportFrame", "PVEFrame", "PVPReadyDialog", "QuestFrame",
        "QuestLogPopupDetailFrame", "RaidBrowserFrame", "RaidParentFrame",
        "ReadyCheckFrame", "RecruitAFriendRewardsFrame", "ReportCheatingDialog",
        "SettingsPanel", "SplashFrame", "TabardFrame", "TaxiFrame",
        "TradeFrame", "TutorialFrame", "VideoOptionsFrame"
    },
    
    nested = {
        DressUpFrame = { "DressUpFrame.OutfitDetailsPanel" },
        MailFrame = { "SendMailFrame", "MailFrameInset" },
        ["MailFrame.OpenMailFrame"] = { 
            "OpenMailFrame.OpenMailSender", 
            "OpenMailFrame.OpenMailFrameInset" 
        },
        WorldMapFrame = { "QuestMapFrame" }
    },
    
    addons = {
        ["Blizzard_AchievementUI"] = {
            AchievementFrame = { "AchievementFrame.Header", "AchievementFrame.SearchResults" }
        },
        ["Blizzard_AlliedRacesUI"] = { "AlliedRacesFrame" },
        ["Blizzard_ProfessionsCustomerOrders"] = {
            ProfessionsCustomerOrdersFrame = { 
                "ProfessionsCustomerOrdersFrame.Form",
                "ProfessionsCustomerOrdersFrame.Form.CurrentListings" 
            }
        },
        ["Blizzard_PVPMatch"] = { "PVPMatchResults" },
        ["Blizzard_PVPUI"] = { "PVPMatchScoreboard" },
        ["Blizzard_ReforgingUI"] = { "ReforgingFrame" },
        ["Blizzard_ScrappingMachineUI"] = { "ScrappingMachineFrame" },
        ["Blizzard_Soulbinds"] = { "SoulbindViewer" },
        ["Blizzard_StableUI"] = { "StableFrame" },
        ["Blizzard_SubscriptionInterstitialUI"] = { "SubscriptionInterstitialFrame" },
        ["Blizzard_TalentUI"] = { "PlayerTalentFrame" },
        ["Blizzard_TimeManager"] = { "TimeManagerFrame" },
        ["Blizzard_TorghastLevelPicker"] = { "TorghastLevelPickerFrame" },
        ["Blizzard_TrainerUI"] = { "ClassTrainerFrame" },
        ["Blizzard_UIPanels_Game"] = {
            CurrencyTransferMenu = {},
            CharacterFrame = { "PaperDollFrame", "ReputationFrame", "TokenFrame", "TokenFramePopup" }
        },
        ["Blizzard_VoidStorageUI"] = { "VoidStorageFrame" },
        ["Blizzard_WarboardUI"] = { "WarboardQuestChoiceFrame" },
        ["Blizzard_WarfrontsPartyPoseUI"] = { "WarfrontsPartyPoseFrame" },
        ["Blizzard_WeeklyRewards"] = { "WeeklyRewardsFrame" }
    }
}

local function ResolveFramePath(path)
    if type(path) ~= "string" then return path end
    
    local frame = _G
    for segment in path:gmatch("[^%.]+") do
        frame = frame and frame[segment]
        if not frame then return nil end
    end
    return frame
end

function FM:EnableFrameDragging(frame, dragTarget)
    if not frame or frame.MoveFrame or processedFrames[frame] then 
        return 
    end
    
    if InCombatLockdown() and frame:IsProtected() then
        delayedFrames[#delayedFrames + 1] = { frame = frame, target = dragTarget }
        self:RegisterEvent("PLAYER_REGEN_ENABLED")
        return
    end
    
    frame:SetMovable(true)
    frame:SetClampedToScreen(true)
    frame:EnableMouse(true)
    frame.MoveFrame = dragTarget or frame
    
    frame:HookScript("OnMouseDown", function(self, button)
        if button == "LeftButton" and self.MoveFrame:IsMovable() then
            self.MoveFrame:StartMoving()
        end
    end)
    
    frame:HookScript("OnMouseUp", function(self, button)
        if button == "LeftButton" then
            self.MoveFrame:StopMovingOrSizing()
        end
    end)
    
    processedFrames[frame] = true
end

function FM:ProcessFrameList(frameList, parentFrame)
    for key, value in pairs(frameList) do
        if type(key) == "number" and type(value) == "string" then
            local frame = ResolveFramePath(value)
            if frame then
                self:EnableFrameDragging(frame, parentFrame and ResolveFramePath(parentFrame))
            end
        elseif type(key) == "string" then
            local frame = ResolveFramePath(key)
            if frame then
                local parentTarget = parentFrame and ResolveFramePath(parentFrame) or frame
                self:EnableFrameDragging(frame, parentTarget)
                
                if type(value) == "table" then
                    self:ProcessFrameList(value, key)
                end
            end
        end
    end
end

local ADDON_CUSTOMIZATIONS = {
    ["Blizzard_Collections"] = function()
        local checkbox = _G.WardrobeTransmogFrame and _G.WardrobeTransmogFrame.ToggleSecondaryAppearanceCheckbox
        if checkbox and checkbox.Label then
            checkbox.Label:ClearAllPoints()
            checkbox.Label:SetPoint("LEFT", checkbox, "RIGHT", 2, 1)
            checkbox.Label:SetPoint("RIGHT", checkbox, "RIGHT", 160, 1)
        end
    end,
    
    ["Blizzard_EncounterJournal"] = function(self)
        local function tooltipReplacement(rewardFrame)
            if rewardFrame.data and _G.EncounterJournalTooltip then
                _G.EncounterJournalTooltip:ClearAllPoints()
            end
            if self.hooks and self.hooks.AdventureJournal_Reward_OnEnter then
                self.hooks.AdventureJournal_Reward_OnEnter(rewardFrame)
            end
        end
        
        if _G.AdventureJournal_Reward_OnEnter then
            self:RawHook("AdventureJournal_Reward_OnEnter", tooltipReplacement, true)
        end
        
        local journal = _G.EncounterJournal
        if journal and journal.suggestFrame then
            for i = 1, 3 do
                local suggestion = journal.suggestFrame["Suggestion" .. i]
                if suggestion and suggestion.reward then
                    self:RawHookScript(suggestion.reward, "OnEnter", tooltipReplacement)
                end
            end
        end
    end,
    
    ["Blizzard_Communities"] = function()
        local dialog = _G.CommunitiesFrame and _G.CommunitiesFrame.NotificationSettingsDialog
        if dialog then
            dialog:ClearAllPoints()
            dialog:SetAllPoints()
        end
    end,
    
    ["Blizzard_PlayerSpells"] = function()
        if not (_G.HeroTalentsSelectionDialog and _G.PlayerSpellsFrame) then return end
        
        local function forcePosition(frame)
            if not frame then return end
            local wasMovable = frame:IsMovable()
            frame:SetMovable(true)
            frame:StartMoving()
            frame:StopMovingOrSizing()
            frame:SetMovable(wasMovable)
        end
        
        forcePosition(_G.HeroTalentsSelectionDialog)
        
        _G.PlayerSpellsFrame:HookScript("OnShow", function(frame)
            forcePosition(frame)
            RunNextFrame(function() forcePosition(frame) end)
        end)
        
        _G.HeroTalentsSelectionDialog:HookScript("OnShow", function(frame)
            forcePosition(frame)
            RunNextFrame(function() forcePosition(frame) end)
        end)
    end
}

function FM:OnAddonLoaded(_, addonName)
    local frameData = FRAME_DATA.addons[addonName]
    if frameData then
        self:ProcessFrameList(frameData)
    end
    
    local customization = ADDON_CUSTOMIZATIONS[addonName]
    if customization then
        customization(self)
    end
end

function FM:OnCombatEnd()
    self:UnregisterEvent("PLAYER_REGEN_ENABLED")
    
    for _, data in ipairs(delayedFrames) do
        self:EnableFrameDragging(data.frame, data.target)
    end
    delayedFrames = {}
    
    self:ConfigureElvUIBags()
end

function FM:ConfigureElvUIBags()
    if not self.db.elvUIBags or InCombatLockdown() then 
        if InCombatLockdown() then
            self:RegisterEvent("PLAYER_REGEN_ENABLED")
        end
        return 
    end
    
    local function enableBagDragging(bagFrame)
        if bagFrame and not bagFrame.PHFrameMove then
            bagFrame:SetScript("OnDragStart", function(frame)
                frame:StartMoving()
            end)
            bagFrame.PHFrameMove = true
        end
    end
    
    enableBagDragging(B:GetContainerFrame())
    enableBagDragging(B:GetContainerFrame(true))
end

function FM:Initialize()
    self.db = E.private.ProjectHopes.qualityOfLife.frameMover
    if not (self.db and self.db.enable) then
        return
    end
    
    if _G.MailFrameInset and _G.OpenMailFrameInset then
        _G.OpenMailFrameInset:SetParent(_G.OpenMailFrame)
        _G.MailFrameInset:SetParent(_G.MailFrame)
    end
    
    for _, frameName in ipairs(FRAME_DATA.core) do
        local frame = ResolveFramePath(frameName)
        if frame then
            self:EnableFrameDragging(frame)
        end
    end
    
    self:ProcessFrameList(FRAME_DATA.nested)
    
    self:RegisterEvent("ADDON_LOADED", "OnAddonLoaded")
    
    for addonName in pairs(FRAME_DATA.addons) do
        if C_AddOns_IsAddOnLoaded(addonName) then
            self:OnAddonLoaded(nil, addonName)
        end
    end
    
    self:ConfigureElvUIBags()
    
    if _G.BattlefieldFrame and _G.PVPParentFrame then
        _G.BattlefieldFrame:SetParent(_G.PVPParentFrame)
        _G.BattlefieldFrame:ClearAllPoints()
        _G.BattlefieldFrame:SetAllPoints()
    end
end

E:RegisterModule(FM:GetName())