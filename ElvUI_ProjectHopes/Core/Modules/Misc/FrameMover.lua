-- Thanks to WindTools(fang2hou) for the code. 
-- Improved abit, I take no credit for the code. 

local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local FM = E:NewModule('FrameMover', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0')

local B = E:GetModule("Bags")

local _G = _G
local pairs = pairs
local strsplit = strsplit
local tremove = tremove
local type = type

local InCombatLockdown = InCombatLockdown
local RunNextFrame = RunNextFrame

local C_AddOns_IsAddOnLoaded = C_AddOns.IsAddOnLoaded

local waitFrameList = {}

local BlizzardFrames = {
	"AddonList",
	"AudioOptionsFrame",
	"BankFrame",
	"BonusRollFrame",
	"ChatConfigFrame",
	"CinematicFrame",
	"ContainerFrameCombinedBags",
	"DestinyFrame",
	"FriendsFrame",
	"GameMenuFrame",
	"GossipFrame",
	"GuildInviteFrame",
	"GuildRegistrarFrame",
	"HelpFrame",
	"ItemTextFrame",
	"LFDRoleCheckPopup",
	"LFGDungeonReadyDialog",
	"LFGDungeonReadyStatus",
	"LootFrame",
	"MerchantFrame",
	"PetitionFrame",
	"PetStableFrame",
	"ReportFrame",
	"PVEFrame",
	"PVPReadyDialog",
	"QuestFrame",
	"QuestLogPopupDetailFrame",
	"RaidBrowserFrame",
	"RaidParentFrame",
	"ReadyCheckFrame",
	"RecruitAFriendRewardsFrame",
	"ReportCheatingDialog",
	"SettingsPanel",
	"SplashFrame",
	"TabardFrame",
	"TaxiFrame",
	"TradeFrame",
	"TutorialFrame",
	"VideoOptionsFrame",
	["DressUpFrame"] = {
		"DressUpFrame.OutfitDetailsPanel",
	},
	["MailFrame"] = {
		"SendMailFrame",
		"MailFrameInset",
		["OpenMailFrame"] = {
			"OpenMailFrame.OpenMailSender",
			"OpenMailFrame.OpenMailFrameInset",
		},
	},
	["WorldMapFrame"] = {
		"QuestMapFrame",
	},
}

local BlizzardFramesOnDemand = {
	["Blizzard_AchievementUI"] = {
		["AchievementFrame"] = {
			"AchievementFrame.Header",
			"AchievementFrame.SearchResults",
		},
	},
	["Blizzard_AlliedRacesUI"] = {
		"AlliedRacesFrame",
	},
	["Blizzard_ArchaeologyUI"] = {
		"ArchaeologyFrame",
	},
	["Blizzard_ArtifactUI"] = {
		"ArtifactFrame",
	},
	["Blizzard_AuctionHouseUI"] = {
		"AuctionHouseFrame",
	},
	["Blizzard_AzeriteEssenceUI"] = {
		"AzeriteEssenceUI",
	},
	["Blizzard_AzeriteRespecUI"] = {
		"AzeriteRespecFrame",
	},
	["Blizzard_AzeriteUI"] = {
		"AzeriteEmpoweredItemUI",
	},
	["Blizzard_BindingUI"] = {
		"KeyBindingFrame",
	},
	["Blizzard_BlackMarketUI"] = {
		"BlackMarketFrame",
	},
	["Blizzard_Calendar"] = {
		["CalendarFrame"] = {
			"CalendarCreateEventFrame",
			"CalendarCreateEventInviteListScrollFrame",
			"CalendarViewEventFrame",
			"CalendarViewEventFrame.HeaderFrame",
			"CalendarViewEventInviteListScrollFrame",
			"CalendarViewHolidayFrame",
		},
	},
	["Blizzard_ChallengesUI"] = {
		"ChallengesKeystoneFrame",
	},
	["Blizzard_Channels"] = {
		"ChannelFrame",
		"CreateChannelPopup",
	},
	["Blizzard_ClickBindingUI"] = {
		["ClickBindingFrame"] = {
			"ClickBindingFrame.ScrollBox",
		},
		"ClickBindingFrame.TutorialFrame",
	},
	["Blizzard_ChromieTimeUI"] = {
		"ChromieTimeFrame",
	},
	["Blizzard_Collections"] = {
		"CollectionsJournal",
		"WardrobeFrame",
	},
	["Blizzard_Communities"] = {
		"ClubFinderGuildFinderFrame.RequestToJoinFrame",
		"ClubFinderCommunityAndGuildFinderFrame.RequestToJoinFrame",
		["CommunitiesFrame"] = {
			"CommunitiesFrame.GuildMemberDetailFrame",
			"CommunitiesFrame.NotificationSettingsDialog",
		},
		"CommunitiesFrame.RecruitmentDialog",
		"CommunitiesSettingsDialog",
		"CommunitiesGuildLogFrame",
		"CommunitiesGuildNewsFiltersFrame",
		"CommunitiesGuildTextEditFrame",
	},
	["Blizzard_Contribution"] = {
		"ContributionCollectionFrame",
	},
	["Blizzard_CovenantPreviewUI"] = {
		"CovenantPreviewFrame",
	},
	["Blizzard_CovenantRenown"] = {
		"CovenantRenownFrame",
	},
	["Blizzard_CovenantSanctum"] = {
		"CovenantSanctumFrame",
	},
	["Blizzard_DeathRecap"] = {
		"DeathRecapFrame",
	},
	["Blizzard_DelvesCompanionConfiguration"] = {
		"DelvesCompanionConfigurationFrame",
		"DelvesCompanionAbilityListFrame",
	},
	["Blizzard_EncounterJournal"] = {
		["EncounterJournal"] = {
			"EncounterJournal.instanceSelect.ScrollBox",
			"EncounterJournal.encounter.info.overviewScroll",
			"EncounterJournal.encounter.info.detailsScroll",
		},
	},
	["Blizzard_ExpansionLandingPage"] = {
		"ExpansionLandingPage",
	},
	["Blizzard_FlightMap"] = {
		"FlightMapFrame",
	},
	["Blizzard_GarrisonUI"] = {
		"GarrisonBuildingFrame",
		"GarrisonCapacitiveDisplayFrame",
		"GarrisonMissionFrame",
		"GarrisonMonumentFrame",
		"GarrisonRecruiterFrame",
		"GarrisonRecruitSelectFrame",
		"GarrisonShipyardFrame",
		"OrderHallMissionFrame",
		"BFAMissionFrame",
		["CovenantMissionFrame"] = {
			"CovenantMissionFrame.MissionTab",
			"CovenantMissionFrame.MissionTab.MissionPage",
			"CovenantMissionFrame.MissionTab.MissionPage.CostFrame",
			"CovenantMissionFrame.MissionTab.MissionPage.StartMissionFrame",
			"CovenantMissionFrame.MissionTab.MissionList.MaterialFrame",
			"CovenantMissionFrame.FollowerList.listScroll",
			"CovenantMissionFrame.FollowerList.MaterialFrame",
		},
		["GarrisonLandingPage"] = {
			"GarrisonLandingPageReportListListScrollFrame",
			"GarrisonLandingPageFollowerListListScrollFrame",
		},
	},
	["Blizzard_GenericTraitUI"] = {
		["GenericTraitFrame"] = {
			"GenericTraitFrame.ButtonsParent",
		},
	},
	["Blizzard_GMChatUI"] = {
		"GMChatStatusFrame",
	},
	["Blizzard_GuildBankUI"] = {
		"GuildBankFrame",
	},
	["Blizzard_GuildControlUI"] = {
		"GuildControlUI",
	},
	["Blizzard_GuildUI"] = {
		"GuildFrame",
	},
	["Blizzard_InspectUI"] = {
		"InspectFrame",
	},
	["Blizzard_IslandsPartyPoseUI"] = {
		"IslandsPartyPoseFrame",
	},
	["Blizzard_IslandsQueueUI"] = {
		"IslandsQueueFrame",
	},
	["Blizzard_ItemAlterationUI"] = {
		"TransmogrifyFrame",
	},
	["Blizzard_ItemInteractionUI"] = {
		"ItemInteractionFrame",
	},
	["Blizzard_ItemSocketingUI"] = {
		"ItemSocketingFrame",
	},
	["Blizzard_ItemUpgradeUI"] = {
		"ItemUpgradeFrame",
	},
	["Blizzard_LookingForGuildUI"] = {
		"LookingForGuildFrame",
	},
	["Blizzard_MacroUI"] = {
		"MacroFrame",
	},
	["Blizzard_MajorFactions"] = {
		"MajorFactionRenownFrame",
	},
	["Blizzard_ObliterumUI"] = {
		"ObliterumForgeFrame",
	},
	["Blizzard_OrderHallUI"] = {
		"OrderHallTalentFrame",
	},
	["Blizzard_PlayerSpells"] = {
		"HeroTalentsSelectionDialog",
		["PlayerSpellsFrame"] = {
			"PlayerSpellsFrame.TalentsFrame.ButtonsParent",
			"PlayerSpellsFrame.SpecFrame.DisabledOverlay",
		},
	},
	["Blizzard_Professions"] = {
		["ProfessionsFrame"] = {
			"ProfessionsFrame.CraftingPage.CraftingOutputLog",
			"ProfessionsFrame.CraftingPage.CraftingOutputLog.ScrollBox",
		},
	},
	["Blizzard_ProfessionsBook"] = {
		"ProfessionsBookFrame",
	},
	["Blizzard_ProfessionsCustomerOrders"] = {
		["ProfessionsCustomerOrdersFrame"] = {
			"ProfessionsCustomerOrdersFrame.Form",
			"ProfessionsCustomerOrdersFrame.Form.CurrentListings",
		},
	},
	["Blizzard_PVPMatch"] = {
		"PVPMatchResults",
	},
	["Blizzard_PVPUI"] = {
		"PVPMatchScoreboard",
	},
	["Blizzard_ReforgingUI"] = {
		"ReforgingFrame",
	},
	["Blizzard_ScrappingMachineUI"] = {
		"ScrappingMachineFrame",
	},
	["Blizzard_Soulbinds"] = {
		"SoulbindViewer",
	},
	["Blizzard_StableUI"] = {
		"StableFrame",
	},
	["Blizzard_SubscriptionInterstitialUI"] = {
		"SubscriptionInterstitialFrame",
	},
	["Blizzard_TalentUI"] = {
		"PlayerTalentFrame",
	},
	["Blizzard_TimeManager"] = {
		"TimeManagerFrame",
	},
	["Blizzard_TorghastLevelPicker"] = {
		"TorghastLevelPickerFrame",
	},
	["Blizzard_TrainerUI"] = {
		"ClassTrainerFrame",
	},
	["Blizzard_UIPanels_Game"] = {
		"CurrencyTransferMenu",
		["CharacterFrame"] = {
			"PaperDollFrame",
			"ReputationFrame",
			"TokenFrame",
			"TokenFramePopup",
		},
	},
	["Blizzard_VoidStorageUI"] = {
		"VoidStorageFrame",
	},
	["Blizzard_WarboardUI"] = {
		"WarboardQuestChoiceFrame",
	},
	["Blizzard_WarfrontsPartyPoseUI"] = {
		"WarfrontsPartyPoseFrame",
	},
	["Blizzard_WeeklyRewards"] = {
		"WeeklyRewardsFrame",
	},
}

local temporarilyMovingFrame = {
	["BonusRollFrame"] = true,
}

local function removeBlizzardFrames(name)
	for i, n in pairs(BlizzardFrames) do
		if n == name then
			tremove(BlizzardFrames, i)
			return
		end
	end
end

function FM:Remember(frame)
	if not frame.ProjectHopesFrameNames or not self.db.rememberPositions then
		return
	end

	if temporarilyMovingFrame[frame.ProjectHopesFrameNames] then
		return
	end

	local numPoints = frame:GetNumPoints()
	if numPoints and numPoints > 0 then
		self.db.framePositions[frame.ProjectHopesFrameNames] = {}
		for index = 1, numPoints do
			local anchorPoint, relativeFrame, relativePoint, offX, offY = frame:GetPoint(index)
			self.db.framePositions[frame.ProjectHopesFrameNames][index] = {
				anchorPoint = anchorPoint,
				relativeFrame = relativeFrame,
				relativePoint = relativePoint,
				offX = offX,
				offY = offY,
			}
		end
	end
end

function FM:Reposition(frame, anchorPoint, relativeFrame, relativePoint, offX, offY)
	if InCombatLockdown() or not self.db or self.StopRunning then
		return
	end

	if not frame.ProjectHopesFrameNames or not self.db.rememberPositions then
		return
	end

	if not self.db.framePositions[frame.ProjectHopesFrameNames] then
		return
	end

	if temporarilyMovingFrame[frame.ProjectHopesFrameNames] then
		self.db.framePositions[frame.ProjectHopesFrameNames] = nil
		return
	end

	if not frame.isChangingPoint then
		frame.isChangingPoint = true
		local points = self.db.framePositions[frame.ProjectHopesFrameNames]

		frame:ClearAllPoints()
		for _, point in pairs(points) do
			frame:__SetPoint(point.anchorPoint, point.relativeFrame, point.relativePoint, point.offX, point.offY)
		end

		frame.isChangingPoint = nil
	end
end

function FM:HandleFrame(frameName, mainFrameName)
	local frame
	local mainFrame

	if frameName.GetName then
		frame = frameName
	else
		frame = _G
		local path = { strsplit(".", frameName) }
		for i = 1, #path do
			frame = frame[path[i]]
		end
	end

	if mainFrameName then
		if mainFrameName.GetName then
			mainFrame = mainFrameName
		else
			mainFrame = _G
			local path = { strsplit(".", mainFrameName) }
			for i = 1, #path do
				mainFrame = mainFrame[path[i]]
			end
		end
	end

	if not frame or frame.MoveFrame then
		return
	end
	if InCombatLockdown() and frame:IsProtected() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
		waitFrameList[#waitFrameList + 1] = {
			frameName = frameName,
			mainFrameName = mainFrameName,
		}
		return
	end

	frame:SetMovable(true)
	frame:SetClampedToScreen(true)
	frame:EnableMouse(true)
	frame.MoveFrame = mainFrame or frame
	frame:HookScript("OnMouseDown", function(self, button)
		if button == "LeftButton" and self.MoveFrame:IsMovable() then
			self.MoveFrame:StartMoving()
		end
	end)
	frame:HookScript("OnMouseUp", function(self, button)
		if button == "LeftButton" then
			self.MoveFrame:StopMovingOrSizing()
			FM:Remember(self.MoveFrame)
		end
	end)
	frame.ProjectHopesFrameNames = frameName
	if not frame.MoveFrame.ProjectHopesFrameNames then
		frame.MoveFrame.ProjectHopesFrameNames = mainFrameName
	end
	if not self:IsHooked(frame.MoveFrame, "SetPoint") then
		frame.MoveFrame.__SetPoint = frame.MoveFrame.SetPoint
		self:SecureHook(frame.MoveFrame, "SetPoint", "Reposition")
	end
end

function FM:HandleFramesWithTable(table, parent)
	for _key1, _frame1 in pairs(table) do
		if type(_key1) == "number" and type(_frame1) == "string" then
			self:HandleFrame(_frame1, parent)
		elseif type(_key1) == "string" and type(_frame1) == "table" then
			self:HandleFrame(_key1, parent)
			self:HandleFramesWithTable(_frame1, _key1)
		end
	end
end

function FM:HandleAddon(_, addon)
	local frameTable = BlizzardFramesOnDemand[addon]
	if not frameTable then
		return
	end

	self:HandleFramesWithTable(frameTable)
	if addon == "Blizzard_Collections" then
		local checkbox = _G.WardrobeTransmogFrame.ToggleSecondaryAppearanceCheckbox
		checkbox.Label:ClearAllPoints()
		checkbox.Label:SetPoint("LEFT", checkbox, "RIGHT", 2, 1)
		checkbox.Label:SetPoint("RIGHT", checkbox, "RIGHT", 160, 1)
	elseif addon == "Blizzard_EncounterJournal" then
		local replacement = function(rewardFrame)
			if rewardFrame.data then
				_G.EncounterJournalTooltip:ClearAllPoints()
			end
			self.hooks.AdventureJournal_Reward_OnEnter(rewardFrame)
		end
		self:RawHook("AdventureJournal_Reward_OnEnter", replacement, true)
		self:RawHookScript(_G.EncounterJournal.suggestFrame.Suggestion1.reward, "OnEnter", replacement)
		self:RawHookScript(_G.EncounterJournal.suggestFrame.Suggestion2.reward, "OnEnter", replacement)
		self:RawHookScript(_G.EncounterJournal.suggestFrame.Suggestion3.reward, "OnEnter", replacement)
	elseif addon == "Blizzard_Communities" then
		local dialog = _G.CommunitiesFrame.NotificationSettingsDialog
		if dialog then
			dialog:ClearAllPoints()
			dialog:SetAllPoints()
		end
	elseif addon == "Blizzard_PlayerSpells" and _G.HeroTalentsSelectionDialog and _G.PlayerSpellsFrame then
		local function startStopMoving(frame)
			local backup = frame:IsMovable()
			frame:SetMovable(true)
			frame:StartMoving()
			frame:StopMovingOrSizing()
			frame:SetMovable(backup)
		end
		startStopMoving(_G.HeroTalentsSelectionDialog)
		_G.PlayerSpellsFrame:HookScript("OnShow", function(frame)
			startStopMoving(frame)
			RunNextFrame(function()
				startStopMoving(frame)
			end)
		end)
		_G.HeroTalentsSelectionDialog:HookScript("OnShow", function(frame)
			startStopMoving(frame)
			RunNextFrame(function()
				startStopMoving(frame)
			end)
		end)
	end
end

function FM:PLAYER_REGEN_ENABLED()
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	self:HandleElvUIBag()

	for _, data in pairs(waitFrameList) do
		self:HandleFrame(data.frameName, data.mainFrameName)
	end

	waitFrameList = {}
end

function FM:HandleElvUIBag()
	if InCombatLockdown() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
		return
	end

	if self.db.elvUIBags then
		local f = B:GetContainerFrame()

		if not f then
			return
		end

		if not f.PHFrameMove then
			f:SetScript("OnDragStart", function(frame)
				frame:StartMoving()
			end)
			if f.helpButton then
				f.helpButton:SetScript("OnEnter", function(frame)
					local GameTooltip = _G.GameTooltip
					GameTooltip:SetOwner(frame, "ANCHOR_TOPLEFT", 0, 4)
					GameTooltip:ClearLines()
					GameTooltip:AddDoubleLine(L["Drag"] .. ":", L["Temporary Move"], 1, 1, 1)
					GameTooltip:AddDoubleLine(L["Hold Control + Right Click:"], L["Reset Position"], 1, 1, 1)
					GameTooltip:Show()
				end)
			end

			f.PHFrameMove = true
		end

		f = B:GetContainerFrame(true)
		if not f.PHFrameMove then
			f:SetScript("OnDragStart", function(frame)
				frame:StartMoving()
			end)
			f:SetScript("OnEnter", function(frame)
				local GameTooltip = _G.GameTooltip
				GameTooltip:SetOwner(frame, "ANCHOR_TOPLEFT", 0, 4)
				GameTooltip:ClearLines()
				GameTooltip:AddDoubleLine(L["Drag"] .. ":", L["Temporary Move"], 1, 1, 1)
				GameTooltip:AddDoubleLine(L["Hold Control + Right Click:"], L["Reset Position"], 1, 1, 1)
				GameTooltip:Show()
			end)
			f.PHFrameMove = true
		end
	end
end

function FM:Initialize()
	self.db = E.private.ProjectHopes.qualityOfLife.frameMover
	if not self.db or not self.db.enable then
		return
	end

	if _G.MailFrameInset then
		_G.OpenMailFrameInset:SetParent(_G.OpenMailFrame)
		_G.MailFrameInset:SetParent(_G.MailFrame)
	end

	self:HandleFramesWithTable(BlizzardFrames)
	self:RegisterEvent("ADDON_LOADED", "HandleAddon")
	for addon in pairs(BlizzardFramesOnDemand) do
		if C_AddOns_IsAddOnLoaded(addon) then
			self:HandleAddon(nil, addon)
		end
	end

	self:HandleElvUIBag()

	if _G.BattlefieldFrame and _G.PVPParentFrame then
		_G.BattlefieldFrame:SetParent(_G.PVPParentFrame)
		_G.BattlefieldFrame:ClearAllPoints()
		_G.BattlefieldFrame:SetAllPoints()
	end

	if E.Retail then 
		local skipHook = false
		self:SecureHook(_G.ContainerFrameSettingsManager, "GetBagsShown", function()
			if skipHook then
				return
			end
			skipHook = true
			local bags = _G.ContainerFrameSettingsManager:GetBagsShown()
			for _, bag in pairs(bags or {}) do
				bag:ClearAllPoints()
			end
			skipHook = false
		end)
	end
end

E:RegisterModule(FM:GetName())