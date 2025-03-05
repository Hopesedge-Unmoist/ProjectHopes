local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local TT = E:GetModule('Tooltip')

local _G = _G
local pairs, next = pairs, next
local hooksecurefunc = hooksecurefunc

local function LFGTabs()
	_G.LFGParentFrameTab1:ClearAllPoints()
	_G.LFGParentFrameTab1:Point('TOPLEFT', _G.LFGParentFrame, 'BOTTOMLEFT', 0, 67)
	BORDER:CreateBorder(_G.LFGParentFrameTab1, nil, nil, nil, nil, nil, true, true)

	_G.LFGParentFrameTab2:ClearAllPoints()
	_G.LFGParentFrameTab2:Point('LEFT', _G.LFGParentFrameTab1, 'RIGHT', -14, 0)
	BORDER:CreateBorder(_G.LFGParentFrameTab2, nil, nil, nil, nil, nil, true, true)

end

local function InitActivityButton(button, data)
	local checkButton = button.CheckButton
	if checkButton then
		if not checkButton.IsBorder then
			BORDER:CreateBorder(checkButton, nil, nil, nil, nil, nil, true, true)
		end
	end
end

local function InitActivityGroupButton(button, _, isCollapsed)
	local checkButton = button.CheckButton
	if checkButton and not checkButton.IsBorder then
		BORDER:CreateBorder(button.CheckButton, nil, nil, nil, nil, nil, true, true)

	end
end

function S:Blizzard_GroupFinder_VanillaStyle()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.lfg) then return end
	if not E.db.ProjectHopes.skins.lookingForGroup then return end

	-- Main Frame and both Tabs
	local LFGListingFrame = _G.LFGListingFrame
	BORDER:CreateBorder(LFGListingFrame, nil, nil, nil, nil, nil, true, false)
	LFGListingFrame:HookScript('OnShow', LFGTabs)

	local LFGBrowseFrame = _G.LFGBrowseFrame
	--BORDER:CreateBorder(_G.LFGListingFrameActivityViewScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true) --this taints according to ElvUI https://github.com/tukui-org/ElvUI/commit/8f49b25b95418c8902128000303769a45e0a8f5c
	BORDER:CreateBorder(LFGBrowseFrame, nil, nil, nil, nil, nil, true, false)
	LFGBrowseFrame:HookScript('OnShow', LFGTabs)

	-- Mouseover Tooltip
	if E.private.skins.blizzard.tooltip then
		TT:SetStyle(_G.LFGBrowseSearchEntryTooltip)
	end

	-- Buttons
	local buttons = {
		_G.LFGListingFrameBackButton,
		_G.LFGListingFramePostButton,
		_G.LFGBrowseFrameSendMessageButton,
		_G.LFGBrowseFrameGroupInviteButton
	}

	for _, button in pairs(buttons) do
		BORDER:CreateBorder(button, nil, nil, nil, nil, nil, false, true)
	end

	_G.LFGListingFrameBackButton:ClearAllPoints()
	_G.LFGListingFrameBackButton:Point('BOTTOMLEFT', LFGListingFrame, 'BOTTOMLEFT', 15, 76)
	_G.LFGBrowseFrameSendMessageButton:ClearAllPoints()
	_G.LFGBrowseFrameSendMessageButton:Point('BOTTOMLEFT', LFGListingFrame, 'BOTTOMLEFT', 15, 76)

	_G.LFGListingFramePostButton:Point('BOTTOMRIGHT', LFGListingFrame, 'BOTTOMRIGHT', -40, 76)
	_G.LFGBrowseFrameGroupInviteButton:Point('BOTTOMRIGHT', LFGBrowseFrame, 'BOTTOMRIGHT', -40, 76)

	_G.LFGBrowseFrameActivityDropDown.ResetButton:ClearAllPoints()
	_G.LFGBrowseFrameActivityDropDown.ResetButton:Point('TOPRIGHT', _G.LFGBrowseFrameActivityDropDown, 'TOPRIGHT', 0, 12)

	-- CheckBoxes
	local checkBoxes = {
		_G.LFGListingFrameSoloRoleButtonsRoleButtonTank.CheckButton,
		_G.LFGListingFrameSoloRoleButtonsRoleButtonHealer.CheckButton,
		_G.LFGListingFrameSoloRoleButtonsRoleButtonDPS.CheckButton,
		_G.LFGListingFrameNewPlayerFriendlyButton.CheckButton,
	}

	for _, checkbox in pairs(checkBoxes) do
		BORDER:CreateBorder(checkbox, nil, nil, nil, nil, nil, true, true)
	end

	BORDER:CreateBorder(_G.LFGListingFrameGroupRoleButtonsInitiateRolePoll, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.LFGListingComment, nil, nil, nil, nil, nil, true, false)

	-- DropDowns
	BORDER:CreateBorder(_G.LFGListingFrameGroupRoleButtonsRoleDropDown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.LFGBrowseFrameActivityDropDown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.LFGBrowseFrameCategoryDropDown, nil, nil, nil, nil, nil, true, true)

	-- Refresh
	BORDER:CreateBorder(_G.LFGBrowseFrameRefreshButton, nil, nil, nil, nil, nil, false, true)

	-- Role check popup
	BORDER:CreateBorder(RolePollPopup, nil, nil, nil, nil, nil, false, false)
	BORDER:CreateBorder(_G.RolePollPopupAcceptButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(_G.RolePollPopupRoleButtonTank.checkButton, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.RolePollPopupRoleButtonHealer.checkButton, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.RolePollPopupRoleButtonDPS.checkButton, nil, nil, nil, nil, nil, true, true)

	hooksecurefunc('LFGListingActivityView_InitActivityButton', InitActivityButton)
	hooksecurefunc('LFGListingActivityView_InitActivityGroupButton', InitActivityGroupButton)
end

S:AddCallbackForAddon('Blizzard_GroupFinder_VanillaStyle')
