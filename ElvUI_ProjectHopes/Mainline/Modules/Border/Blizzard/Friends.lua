local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next = next
local pairs = pairs
local unpack = unpack

local CreateFrame = CreateFrame
local hooksecurefunc = hooksecurefunc

local function HandleTabs()
	local tab = _G.FriendsFrameTab1
	local index, lastTab = 1, tab
	while tab do
		BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)

		tab:ClearAllPoints()

		if index == 1 then
			tab:Point('TOPLEFT', _G.FriendsFrame, 'BOTTOMLEFT', -3, -5)
		else
			tab:Point('TOPLEFT', lastTab, 'TOPRIGHT', 0, 0)
			lastTab = tab
		end

		index = index + 1
		tab = _G['FriendsFrameTab'..index]
	end
end

local function ReskinFriendButton(button)
	if button.IsBorder then return end
	button.IsBorder = true

	local summon = button.summonButton
	if summon then
		BORDER:CreateBorder(summon)
	end

	local invite = button.travelPassButton
	BORDER:CreateBorder(invite, nil, nil, nil, nil, nil, false, true)

	local icon = invite:CreateTexture(nil, 'ARTWORK')
	BORDER:CreateBorder(icon)
end

local function RAFRewardQuality(button)
	local color = button.item and button.item:GetItemQualityColor()
	if color and button.Icon then
		button.Icon.backdrop.border:SetBackdrop(Private.BorderLight)
		button.Icon.backdrop.border:SetBackdropBorderColor(button.Icon.backdrop:GetBackdropBorderColor())
	end
end

local function RAFRewards()
	for reward in _G.RecruitAFriendRewardsFrame.rewardPool:EnumerateActive() do  
		local button = reward.Button    
		local icon = button.Icon
		BORDER:HandleIcon(icon)

		RAFRewardQuality(button)
	end
end

function S:FriendsFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.friends) then return end
	if not E.db.ProjectHopes.skins.friends then return end

	BORDER:CreateBorder(_G.FriendsListFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.FriendsFrame.IgnoreListWindow.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.WhoFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.FriendsFriendsFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.QuickJoinFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	local buttons = {
		'FriendsFrameAddFriendButton',
		'FriendsFrameSendMessageButton',
		'WhoFrameWhoButton',
		'WhoFrameAddFriendButton',
		'WhoFrameGroupInviteButton',
		'FriendsFrameIgnorePlayerButton',
		'FriendsFrameUnsquelchButton',
		'AddFriendEntryFrameAcceptButton',
		'AddFriendEntryFrameCancelButton',
		'AddFriendInfoFrameContinueButton',
	}

	for _, button in pairs(buttons) do
		BORDER:CreateBorder(_G[button], nil, nil, nil, nil, nil, false, true)
	end

	local FriendsFrame = _G.FriendsFrame
	BORDER:CreateBorder(FriendsFrame)

	BORDER:CreateBorder(_G.FriendsFrameStatusDropdown, nil, nil, nil, nil, nil, true, true)

	local FriendsFrameBattlenetFrame = _G.FriendsFrameBattlenetFrame
	BORDER:CreateBorder(FriendsFrameBattlenetFrame)
	FriendsFrameBattlenetFrame.BroadcastFrame:Point('TOPLEFT', FriendsFrame, 'TOPRIGHT', 7, 0)

	--BORDER:CreateBorder(FriendsFrameBattlenetFrame.ContactsMenuButton, nil, nil, nil, nil, nil, true, false)

	BORDER:CreateBorder(FriendsFrameBattlenetFrame.BroadcastFrame)
	BORDER:CreateBorder(FriendsFrameBattlenetFrame.BroadcastFrame.EditBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(FriendsFrameBattlenetFrame.BroadcastFrame.UpdateButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(FriendsFrameBattlenetFrame.BroadcastFrame.CancelButton, nil, nil, nil, nil, nil, false, true)
	
	BORDER:CreateBorder(_G.AddFriendFrame)
	BORDER:CreateBorder(_G.AddFriendNameEditBox, nil, nil, nil, nil, nil, true, false)

	local INVITE_RESTRICTION_NONE = 9
	hooksecurefunc('FriendsFrame_UpdateFriendButton', function(button)
		BORDER:CreateBorder(button, nil, -7, 6, 7, -6, false, true)

		if button.gameIcon then
			ReskinFriendButton(button)
		end
	end)

	hooksecurefunc('FriendsFrame_UpdateFriendInviteButton', function(button)
		if not button.IsBorder then
			BORDER:CreateBorder(button.AcceptButton, nil, nil, nil, nil, nil, false, true)
			BORDER:CreateBorder(button.DeclineButton, nil, nil, nil, nil, nil, false, true)

			button.IsBorder = true
		end
	end)

	hooksecurefunc('FriendsFrame_UpdateFriendInviteHeaderButton', function(button)
		if not button.IsBorder then
			BORDER:CreateBorder(button)

			button.IsBorder = true
		end
	end)

	--Who Frame


	-- Bottom Tabs
	HandleTabs()
	
	for _, tab in next, { _G.FriendsTabHeader.TabSystem:GetChildren() } do
		BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)
	end

	--View Friends BN Frame
	local FriendsFriendsFrame = _G.FriendsFriendsFrame
	BORDER:CreateBorder(FriendsFriendsFrame)

	BORDER:CreateBorder(_G.FriendsFriendsFrameDropdown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(FriendsFriendsFrame.SendRequestButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(FriendsFriendsFrame.CloseButton, nil, nil, nil, nil, nil, false, true)

	--Quick join
	local QuickJoinFrame = _G.QuickJoinFrame
	local QuickJoinRoleSelectionFrame = _G.QuickJoinRoleSelectionFrame
	BORDER:CreateBorder(_G.QuickJoinFrame.JoinQueueButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(QuickJoinRoleSelectionFrame.AcceptButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(QuickJoinRoleSelectionFrame.CancelButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(QuickJoinRoleSelectionFrame.RoleButtonTank.CheckButton)
	BORDER:CreateBorder(QuickJoinRoleSelectionFrame.RoleButtonHealer.CheckButton)
	BORDER:CreateBorder(QuickJoinRoleSelectionFrame.RoleButtonDPS.CheckButton)

	local RAF = _G.RecruitAFriendFrame
	BORDER:CreateBorder(RAF.RecruitmentButton, nil, nil, nil, nil, nil, false, true)
	RAF.RecruitmentButton:Size(134, 16)

	local SplashFrame = RAF.SplashFrame
	BORDER:CreateBorder(SplashFrame.OKButton, nil, nil, nil, nil, nil, false, true)

	local Claiming = RAF.RewardClaiming
	BORDER:CreateBorder(Claiming.ClaimOrViewRewardButton, nil, nil, nil, nil, nil, false, true)

	local NextReward = Claiming.NextRewardButton
	BORDER:HandleIcon(NextReward.Icon)
	RAFRewardQuality(NextReward)

	local RecruitList = RAF.RecruitList
	BORDER:CreateBorder(RecruitList.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	-- Recruitment
	local Recruitment = _G.RecruitAFriendRecruitmentFrame
	BORDER:CreateBorder(Recruitment)

	BORDER:CreateBorder(Recruitment.EditBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(Recruitment.GenerateOrCopyLinkButton, nil, nil, nil, nil, nil, false, true)

	-- Rewards
	local Reward = _G.RecruitAFriendRewardsFrame
	BORDER:CreateBorder(Reward)

	-- Raidinfo
	BORDER:CreateBorder(_G.RaidInfoFrame)

	hooksecurefunc(Reward, 'UpdateRewards', RAFRewards)
	RAFRewards()
end

S:AddCallback('FriendsFrame')
