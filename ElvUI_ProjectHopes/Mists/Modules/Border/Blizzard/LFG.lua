local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local LCG = E.Libs.CustomGlow

local _G = _G
local next = next
local min, select = min, select
local unpack, ipairs, pairs = unpack, ipairs, pairs
local hooksecurefunc = hooksecurefunc
local gsub = gsub

local UnitIsGroupLeader = UnitIsGroupLeader
local GetItemInfo = C_Item.GetItemInfo

local C_LFGList_GetAvailableActivities = C_LFGList.GetAvailableActivities
local C_LFGList_GetAvailableRoles = C_LFGList.GetAvailableRoles
local C_LFGList_GetActivityInfoTable = C_LFGList.GetActivityInfoTable
local C_LFGList_GetAdvancedFilter = C_LFGList.GetAdvancedFilter
local C_LFGList_GetApplicationInfo = C_LFGList.GetApplicationInfo
local C_LFGList_GetAvailableActivityGroups = C_LFGList.GetAvailableActivityGroups
local C_LFGList_GetSearchResultInfo = C_LFGList.GetSearchResultInfo
local C_LFGList_GetSearchResultMemberInfo = C_LFGList.GetSearchResultMemberInfo
local C_LFGList_SaveAdvancedFilter = C_LFGList.SaveAdvancedFilter

local LE_PARTY_CATEGORY_HOME = LE_PARTY_CATEGORY_HOME

local groupButtonIcons = {
	133076, -- interface\icons\inv_helmet_08.blp
	133074, -- interface\icons\inv_helmet_06.blp
	464820 -- interface\icons\achievement_general_stayclassy.blp
}

local colors = {
	greyLight = {r = 181, g = 181, b = 181},  -- RGB values for "b5b5b5"
	primary = {r = 0, g = 209, b = 178},     -- RGB values for "00d1b2"
	success = {r = 72, g = 199, b = 116},    -- RGB values for "48c774"
	link = {r = 50, g = 115, b = 220},       -- RGB values for "3273dc"
	info = {r = 32, g = 156, b = 238},       -- RGB values for "209cee"
	danger = {r = 255, g = 56, b = 96},      -- RGB values for "ff3860"
	warning = {r = 255, g = 221, b = 87},    -- RGB values for "ffdd57"
}

local RoleIconTextures = {
	TANK = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\Roles\\TANK.tga",
	HEALER = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\Roles\\HEALER.tga",
	DAMAGER = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\Roles\\DPS.tga",
}


local function SkinItemButton(parentFrame, _, index)
	local parentName = parentFrame:GetName()
	local item = _G[parentName..'Item'..index]
	if item and not item.backdrop.border then
		BORDER:CreateBorder(item.backdrop, 1)
		item.backdrop.border:SetBackdrop(Private.BorderLight)
		BORDER:HandleIconBorder(item.IconBorder, item.backdrop.border)
	end
end

local function HandleGoldIcon(button)
	local Button = _G[button]
	if Button.backdrop.border then return end
		
	BORDER:CreateBorder(Button.backdrop)
end

function S:ReskinIcon(parent, icon, role, data)
	local class = data and data[1]
	local spec = data and data[2]
	local isLeader = data and data[3]

	if role then
		icon:Size(16, 16)
		icon:SetTexture(RoleIconTextures[role])
		icon:SetTexCoord(0, 1, 0, 1)
	end

	if parent then
		if not icon.leader then
			local leader = parent:CreateTexture(nil, "OVERLAY")
			leader:SetTexture("Interface\\GROUPFRAME\\UI-GROUP-LEADERICON.BLP")
			leader:Size(12, 10)
			leader:SetPoint("BOTTOM", icon, "TOP", 0, -3)
			icon.leader = leader
		else
			icon.leader:SetShown(isLeader)
		end

		if class then
			local color = E:ClassColor(class, false)
			icon:SetVertexColor(color.r, color.g, color.b)
		end
	end
end

function S:UpdateRoleCount(RoleCount)
	local button = RoleCount:GetParent():GetParent()
	BORDER:CreateBorder(button, nil, -6, 6, 6, -6)

	if _G.LFGListFrame.ApplicationViewer.border then
		_G.LFGListFrame.ApplicationViewer.border:Hide()
	end
	
	if RoleCount.TankIcon then
		S:ReskinIcon(nil, RoleCount.TankIcon, "TANK")
	end
	if RoleCount.HealerIcon then
		S:ReskinIcon(nil, RoleCount.HealerIcon, "HEALER")
	end
	if RoleCount.DamagerIcon then
		S:ReskinIcon(nil, RoleCount.DamagerIcon, "DAMAGER")
	end
end

local function LFDQueueFrameSpecificUpdateChild(child)
	if not child.IsBorder then
		BORDER:CreateBorder(child.enableButton, nil, nil, nil, nil, nil, true, true)

		child.IsBorder = true
	end
end

local function LFDQueueFrameSpecificUpdate(frame)
	frame:ForEachFrame(LFDQueueFrameSpecificUpdateChild)
end

function S:LookingForGroupFrames()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.lfg) then return end
	if not E.db.ProjectHopes.skins.lookingForGroup then return end

	S:SecureHook("LFGListGroupDataDisplayRoleCount_Update", "UpdateRoleCount")

	local PVEFrame = _G.PVEFrame

	BORDER:CreateBorder(PVEFrame)

	BORDER:CreateBorder(_G.LFDQueueFramePartyBackfillBackfillButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.LFDQueueFramePartyBackfillNoBackfillButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(_G.LFGDungeonReadyDialog)
	BORDER:CreateBorder(_G.LFGDungeonReadyStatus)
	
	
	BORDER:CreateBorder(_G.LFGDungeonReadyDialogLeaveQueueButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.LFGDungeonReadyDialogEnterDungeonButton, nil, nil, nil, nil, nil, false, true)

	-- Role check popup
	BORDER:CreateBorder(_G.RolePollPopup)
	BORDER:CreateBorder(_G.RolePollPopupAcceptButton)

	for _, roleButton in pairs({
		_G.LFDQueueFrameRoleButtonHealer,
		_G.LFDQueueFrameRoleButtonDPS,
		_G.LFDQueueFrameRoleButtonLeader,
		_G.LFDQueueFrameRoleButtonTank,
		_G.RaidFinderQueueFrameRoleButtonHealer,
		_G.RaidFinderQueueFrameRoleButtonDPS,
		_G.RaidFinderQueueFrameRoleButtonLeader,
		_G.RaidFinderQueueFrameRoleButtonTank,
		_G.LFGInvitePopupRoleButtonTank,
		_G.LFGInvitePopupRoleButtonHealer,
		_G.LFGInvitePopupRoleButtonDPS,
		_G.LFGListApplicationDialog.TankButton,
		_G.LFGListApplicationDialog.HealerButton,
		_G.LFGListApplicationDialog.DamagerButton,

		-- these three arent scaled to 0.7
		_G.RolePollPopupRoleButtonTank,
		_G.RolePollPopupRoleButtonHealer,
		_G.RolePollPopupRoleButtonDPS,
	}) do
		local checkButton = roleButton.checkButton or roleButton.CheckButton
		if checkButton:GetScale() ~= 1 then
			checkButton:SetScale(1)
		end

		BORDER:CreateBorder(checkButton, nil, nil, nil, nil, nil, true, true)
		checkButton:Size(18)
	end

	hooksecurefunc('SetCheckButtonIsRadio', function(button)
		if not button.IsBorder then
			BORDER:CreateBorder(button)
		end
	end)

	do
		local index = 1
		local button = _G.GroupFinderFrame['groupButton'..index]
		while button do
			BORDER:CreateBorder(button, nil, nil, nil, nil, nil, false, true)

			BORDER:HandleIcon(button.icon)

			index = index + 1
			button = _G.GroupFinderFrame['groupButton'..index]
		end
	end

	for i = 1, 4 do
		BORDER:CreateBorder(_G['PVEFrameTab'..i], nil, nil, nil, nil, nil, true, true)
	end

	-- Reposition Tabs
	_G.PVEFrameTab1:ClearAllPoints()
	_G.PVEFrameTab2:ClearAllPoints()
	_G.PVEFrameTab3:ClearAllPoints()
	_G.PVEFrameTab1:Point('TOPLEFT', _G.PVEFrame, 'BOTTOMLEFT', -10, -5)
	_G.PVEFrameTab2:Point('TOPLEFT', _G.PVEFrameTab1, 'TOPRIGHT', -15, 0)
	_G.PVEFrameTab3:Point('TOPLEFT', _G.PVEFrameTab2, 'TOPRIGHT', -15, 0)
	
	-- Scenario Tab
	local ScenarioQueueFrame = _G.ScenarioQueueFrame
	if ScenarioQueueFrame then
		BORDER:CreateBorder(_G.ScenarioQueueFrameTypeDropdown, nil, nil, nil, nil, nil, true, true)
		BORDER:CreateBorder(_G.ScenarioQueueFrameRandomScrollFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
		BORDER:CreateBorder(_G.ScenarioQueueFrameSpecific.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
		BORDER:CreateBorder(_G.ScenarioQueueFrameFindGroupButton, nil, nil, nil, nil, nil, false, true)

		hooksecurefunc(_G.ScenarioQueueFrameSpecificScrollFrame, 'Update', LFDQueueFrameSpecificUpdate)
	end

	-- Dungoen finder
	BORDER:CreateBorder(_G.LFDQueueFrameFindGroupButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.LFDQueueFrameRandomScrollFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.LFDQueueFrameTypeDropdown, nil, nil, nil, nil, nil, true, true)

	HandleGoldIcon('LFDQueueFrameRandomScrollFrameChildFrameMoneyReward')

	-- Skin Reward Items (This works for all frames, LFD, Raid, Scenario)
	hooksecurefunc('LFGRewardsFrame_SetItemButton', SkinItemButton)

	BORDER:CreateBorder(_G.LFGInvitePopup, nil, nil, nil, nil, nil, false, false)
	BORDER:CreateBorder(_G.LFGInvitePopupAcceptButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.LFGInvitePopupDeclineButton, nil, nil, nil, nil, nil, false, true)

	
	BORDER:CreateBorder(_G[_G.LFDQueueFrame.PartyBackfill:GetName()..'BackfillButton'], nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G[_G.LFDQueueFrame.PartyBackfill:GetName()..'NoBackfillButton'], nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.LFDQueueFrameSpecific.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	local LFGListFrame = _G.LFGListFrame
	BORDER:CreateBorder(LFGListFrame.CategorySelection.StartGroupButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(LFGListFrame.CategorySelection.FindGroupButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(LFGListFrame.ApplicationViewer.Inset)
	LFGListFrame.ApplicationViewer.InfoBackground.backdrop:Hide()

	local EntryCreation = LFGListFrame.EntryCreation
	BORDER:CreateBorder(EntryCreation.CancelButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(EntryCreation.ListGroupButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(EntryCreation.Description, nil, nil, nil, nil, nil, true, false)

	BORDER:CreateBorder(EntryCreation.GroupDropdown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(EntryCreation.ActivityDropdown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(EntryCreation.PlayStyleDropdown, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(EntryCreation.ItemLevel.EditBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(EntryCreation.PVPRating.EditBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(EntryCreation.PvpItemLevel.EditBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(EntryCreation.VoiceChat.EditBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(EntryCreation.Name, nil, nil, nil, nil, nil, true, false)

	BORDER:CreateBorder(EntryCreation.ItemLevel.CheckButton, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(EntryCreation.PrivateGroup.CheckButton, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(EntryCreation.PvpItemLevel.CheckButton, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(EntryCreation.PVPRating.CheckButton, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(EntryCreation.VoiceChat.CheckButton, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(EntryCreation.CrossFactionGroup.CheckButton, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(EntryCreation.ActivityFinder.Dialog.EntryBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(EntryCreation.ActivityFinder.Dialog.SelectButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(EntryCreation.ActivityFinder.Dialog.CancelButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(_G.LFGListApplicationDialog)
	BORDER:CreateBorder(_G.LFGListApplicationDialog.SignUpButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.LFGListApplicationDialog.CancelButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.LFGListApplicationDialogDescription, nil, nil, nil, nil, nil, true, false)

	BORDER:CreateBorder(_G.LFGListInviteDialog)
	BORDER:CreateBorder(_G.LFGListInviteDialog.AcknowledgeButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.LFGListInviteDialog.AcceptButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.LFGListInviteDialog.DeclineButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(LFGListFrame.SearchPanel.SearchBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(LFGListFrame.SearchPanel.BackButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(LFGListFrame.SearchPanel.SignUpButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(_G.LFGListFrame.SearchPanel.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(LFGListFrame.SearchPanel.ScrollBox.StartGroupButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(LFGListFrame.SearchPanel.FilterButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(LFGListFrame.SearchPanel.RefreshButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(LFGListFrame.SearchPanel.BackToGroupButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(LFGListFrame.SearchPanel.AutoCompleteFrame, nil, nil, nil, nil, nil, true)


	hooksecurefunc('LFGListApplicationViewer_UpdateApplicant', function(button)
		BORDER:CreateBorder(button.DeclineButton, nil, nil, nil, nil, nil, false, true)
		BORDER:CreateBorder(button.InviteButton, nil, nil, nil, nil, nil, false, true)
		BORDER:CreateBorder(button.InviteButtonSmall, nil, nil, nil, nil, nil, false, true)
		button.InviteButtonSmall:ClearAllPoints()
		button.InviteButtonSmall:SetPoint("RIGHT", button.DeclineButton, "LEFT", -5, 0)
		button.InviteButton:ClearAllPoints()
		button.InviteButton:SetPoint("RIGHT", button.DeclineButton, "LEFT", -5, 0)


	end)

	hooksecurefunc('LFGListSearchEntry_Update', function(button)
		if button.CancelButton then
			BORDER:CreateBorder(button.CancelButton, nil, nil, nil, nil, nil, false, true)
		end
	end)

	hooksecurefunc('LFGListSearchPanel_UpdateAutoComplete', function(panel)
		for _, child in next, { LFGListFrame.SearchPanel.AutoCompleteFrame:GetChildren() } do
			if child:IsObjectType('Button') then
				BORDER:CreateBorder(child)
			end
		end
	end)

	--ApplicationViewer (Custom Groups)
	BORDER:CreateBorder(LFGListFrame.ApplicationViewer.AutoAcceptButton, nil, nil, nil, nil, nil, true, true)

	LFGListFrame.ApplicationViewer.NameColumnHeader:SetBackdrop()
	LFGListFrame.ApplicationViewer.RoleColumnHeader:SetBackdrop()
	LFGListFrame.ApplicationViewer.ItemLevelColumnHeader:SetBackdrop()
	LFGListFrame.ApplicationViewer.RatingColumnHeader:SetBackdrop()

	BORDER:CreateBorder(LFGListFrame.ApplicationViewer.RefreshButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(LFGListFrame.ApplicationViewer.RemoveEntryButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(LFGListFrame.ApplicationViewer.EditButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(LFGListFrame.ApplicationViewer.BrowseGroupsButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(LFGListFrame.ApplicationViewer.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	hooksecurefunc('LFGListCategorySelection_AddButton', function(btn, btnIndex, categoryID, filters)
		local button = btn.CategoryButtons[btnIndex]
		if button then
			if not button.IsBorder then
				BORDER:CreateBorder(button)
				button.IsBorder = true
			end

			button.SelectedTexture:Hide()
			local selected = btn.selectedCategory == categoryID and btn.selectedFilters == filters
			if selected then
				button.border:SetBackdrop(Private.BorderLight)
				button.border:SetBackdropBorderColor(1, 0.78, 0.03)
			else
				button.border:SetBackdrop(Private.Border)
				button.border:SetBackdropBorderColor(1, 1, 1)
			end
		end
	end)
end

S:AddCallback('LookingForGroupFrames')
