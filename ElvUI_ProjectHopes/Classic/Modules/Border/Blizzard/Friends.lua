local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local unpack, pairs = unpack, pairs

local BNConnected = BNConnected
local BNFeaturesEnabled = BNFeaturesEnabled
local GetGuildRosterInfo = GetGuildRosterInfo
local GetQuestDifficultyColor = GetQuestDifficultyColor
local hooksecurefunc = hooksecurefunc

local GUILDMEMBERS_TO_DISPLAY = GUILDMEMBERS_TO_DISPLAY
local C_FriendList_GetNumWhoResults = C_FriendList.GetNumWhoResults
local C_FriendList_GetWhoInfo = C_FriendList.GetWhoInfo

local function SkinFriendRequest(frame)
	if frame.IsBorder then return end

	BORDER:CreateBorder(frame.DeclineButton, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(frame.AcceptButton, nil, nil, nil, nil, nil, true, true)

	frame.IsBorder = true
end

local function AcquireInvitePool(pool)
	if pool.activeObjects then
		for object in pairs(pool.activeObjects) do
			SkinFriendRequest(object)
		end
	end
end


function S:FriendsFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.friends) then return end
	if not E.db.ProjectHopes.skins.friends then return end

	-- Friends Frame
	local FriendsFrame = _G.FriendsFrame
	BORDER:CreateBorder(FriendsFrame.backdrop)

	BORDER:CreateBorder(_G.FriendsFrameStatusDropdown, nil, nil, nil, nil, nil, true, true)

	for i = 1, #_G.FRIENDSFRAME_SUBFRAMES do
		BORDER:CreateBorder(_G['FriendsFrameTab'..i], nil, nil, nil, nil, nil, true, true)
	end

	-- Reposition Tabs
	_G.FriendsFrameTab1:ClearAllPoints()
	_G.FriendsFrameTab1:Point('TOPLEFT', _G.FriendsFrame, 'BOTTOMLEFT', -15, -5)
	_G.FriendsFrameTab2:Point('TOPLEFT', _G.FriendsFrameTab1, 'TOPRIGHT', -14, 0)
	_G.FriendsFrameTab3:Point('TOPLEFT', _G.FriendsFrameTab2, 'TOPRIGHT', -14, 0)
	_G.FriendsFrameTab4:Point('TOPLEFT', _G.FriendsFrameTab3, 'TOPRIGHT', -14, 0)

	-- Friends List Frame
	for i = 1, _G.FRIEND_HEADER_TAB_IGNORE do
		local tab = _G['FriendsTabHeaderTab'..i]
		BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)
	end

	for i = 1, _G.FRIENDS_FRIENDS_TO_DISPLAY do
		local button = 'FriendsFrameFriendsScrollFrameButton'..i

		BORDER:CreateBorder(_G[button..'TravelPassButton'], nil, -5, 7, 7, -7, false, true)
	end

	BORDER:CreateBorder(_G.FriendsFrameFriendsScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(_G.AddFriendEntryFrameAcceptButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.AddFriendEntryFrameCancelButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.FriendsFrameAddFriendButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.FriendsFrameSendMessageButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.FriendsFrameUnsquelchButton, nil, nil, nil, nil, nil, false, true)

	-- Battle.net
	local FriendsFrameBattlenetFrame = _G.FriendsFrameBattlenetFrame
	local FriendsFrameBroadcastInput = _G.FriendsFrameBroadcastInput

	BORDER:CreateBorder(_G.AddFriendNameEditBox)
	BORDER:CreateBorder(_G.AddFriendFrame)

	-- Pending invites
	BORDER:CreateBorder(_G.FriendsFrameFriendsScrollFrame)
	BORDER:CreateBorder(_G.FriendsFrameFriendsScrollFrame.PendingInvitesHeaderButton, nil, nil, nil, nil, nil, false, true)

	hooksecurefunc(_G.FriendsFrameFriendsScrollFrame.invitePool, 'Acquire', AcquireInvitePool)

	BORDER:CreateBorder(_G.FriendsFriendsFrame.backdrop)
	BORDER:CreateBorder(_G.FriendsFriendsCloseButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.FriendsFriendsSendRequestButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.FriendsFriendsList)
	BORDER:CreateBorder(_G.FriendsFriendsScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.FriendsFriendsFrameDropdown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.FriendsFrameBroadcastInput, nil, nil, nil, nil, nil, true)
	-- Ignore List Frame
	BORDER:CreateBorder(_G.FriendsFrameIgnorePlayerButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.FriendsFrameUnsquelchButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.FriendsFrameIgnoreScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)

	-- Who Frame
	BORDER:CreateBorder(_G.WhoFrameEditBox)
	BORDER:CreateBorder(_G.WhoFrameWhoButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.WhoFrameAddFriendButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.WhoFrameGroupInviteButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.WhoFrameDropdown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.WhoListScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)

	-- Guild Frame (/groster)
	S:HandleFrame(_G.GuildFrameLFGFrame, true)
	BORDER:CreateBorder(_G.GuildFrameLFGButton, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(_G.GuildListScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.GuildFrameGuildInformationButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.GuildFrameAddMemberButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.GuildFrameControlButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.GuildMOTDEditButton, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.GuildMemberDetailFrame, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.GuildFrameLFGFrame, nil, nil, nil, nil, nil, true, true)

	if _G.GuildFrameImpeachButton then
		BORDER:CreateBorder(_G.GuildFrameImpeachButton, nil, nil, nil, nil, nil, false, true)
	end

	-- Member Detail Frame
	BORDER:CreateBorder(_G.GuildMemberRemoveButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.GuildMemberGroupInviteButton, nil, nil, nil, nil, nil, false, true)

	-- Info Frame
	BORDER:CreateBorder(_G.GuildInfoFrameScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.GuildInfoSaveButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.GuildInfoCancelButton, nil, nil, nil, nil, nil, false, true)

	-- Guild Control Frame (Guild Master Only)
	BORDER:CreateBorder(_G.GuildControlPopupFrameDropdown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.GuildControlPopupFrameEditBox)

	for _, checkBox in pairs({ _G.GuildControlPopupFrameCheckboxes:GetChildren()}) do
		if checkBox:IsObjectType('CheckButton') then
			BORDER:CreateBorder(checkBox, nil, nil, nil, nil, nil, true, true)
		end
	end

	BORDER:CreateBorder(_G.GuildControlPopupAcceptButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.GuildControlPopupFrameCancelButton, nil, nil, nil, nil, nil, false, true)

	-- Raid Frame
	BORDER:CreateBorder(_G.RaidFrameConvertToRaidButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.RaidFrameRaidInfoButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.RaidFrameAllAssistCheckButton, nil, nil, nil, nil, nil, true, true)

	-- Raid Info Frame
	BORDER:CreateBorder(_G.RaidInfoScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)

	-- Repositions
	_G.GuildFrameGuildInformationButton:Width(108)
	_G.GuildFrameAddMemberButton:Width(108)
	_G.GuildFrameControlButton:Width(108)

	_G.GuildFrameAddMemberButton:ClearAllPoints()
	_G.GuildFrameAddMemberButton:Point('RIGHT', _G.GuildFrameControlButton, 'LEFT', -5, 0)

	_G.GuildFrameGuildInformationButton:ClearAllPoints()
	_G.GuildFrameGuildInformationButton:Point('RIGHT', _G.GuildFrameAddMemberButton, 'LEFT', -5, 0)

	_G.GuildMemberRemoveButton:Width(98)
	_G.GuildMemberGroupInviteButton:Width(98)
	_G.GuildMemberRemoveButton:Point('BOTTOMLEFT', 5, 5)
	_G.GuildMemberGroupInviteButton:ClearAllPoints()
	_G.GuildMemberGroupInviteButton:Point('LEFT', _G.GuildMemberRemoveButton, 'RIGHT', 6, 0)

	_G.WhoFrameWhoButton:Width(108)
	_G.WhoFrameAddFriendButton:Width(108)
	_G.WhoFrameGroupInviteButton:Width(108)

	_G.WhoFrameAddFriendButton:ClearAllPoints()
	_G.WhoFrameAddFriendButton:Point('RIGHT', _G.WhoFrameGroupInviteButton, 'LEFT', -5, 0)

	_G.WhoFrameWhoButton:ClearAllPoints()
	_G.WhoFrameWhoButton:Point('RIGHT', _G.WhoFrameAddFriendButton, 'LEFT', -5, 0)
end

S:AddCallback('FriendsFrame')
