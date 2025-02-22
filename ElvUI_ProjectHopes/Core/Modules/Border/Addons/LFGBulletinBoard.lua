local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')
local S = E:GetModule('Skins')

local _G = _G
local pairs = pairs

function S:LFGBulletinBoard()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.lfgbulletinboard) then return end

	--skin main frame
	S:HandleFrame(GroupBulletinBoardFrame)
	BORDER:CreateBorder(GroupBulletinBoardFrame)

	--skin scroll bar
	S:HandleScrollBar(GroupBulletinBoardFrame_ScrollFrameScrollBar)
	BORDER:CreateBorder(GroupBulletinBoardFrame_ScrollFrameScrollBarThumbTexture)

	--skin & position bottom tabs
	S:HandleTab(GroupBulletinBoardFrameTab1)
	BORDER:CreateBorder(GroupBulletinBoardFrameTab1, nil, nil, nil, nil, nil, true, true)
	S:HandleTab(GroupBulletinBoardFrameTab2)
	BORDER:CreateBorder(GroupBulletinBoardFrameTab2, nil, nil, nil, nil, nil, true, true)
	GroupBulletinBoardFrameTab1:ClearAllPoints()
	GroupBulletinBoardFrameTab1:Point('TOPLEFT', GroupBulletinBoardFrame, 'BOTTOMLEFT', -10, -6)
	GroupBulletinBoardFrameTab2:ClearAllPoints()
	GroupBulletinBoardFrameTab2:Point('BOTTOMLEFT', GroupBulletinBoardFrameTab1, 'BOTTOMRIGHT', -10, 0)

	--skin and position search box
	S:HandleEditBox(GroupBulletinBoardFrameResultsFilter)
	GroupBulletinBoardFrameResultsFilter:Height(20)
	GroupBulletinBoardFrameResultsFilter:ClearAllPoints()
	GroupBulletinBoardFrameResultsFilter:Point('TOPLEFT', GroupBulletinBoardFrame, 'TOPLEFT', 140, -5)
	BORDER:CreateBorder(GroupBulletinBoardFrameResultsFilter, nil, nil, nil, nil, nil, true, false)

	--skin and position close and settings buttons (it requires elt's glues for UI-Panel-Button-X))
	--border can be removed if ever skinned in glues by Hopes
	BORDER:CreateBorder(GroupBulletinBoardFrameCloseButton)
	BORDER:CreateBorder(GroupBulletinBoardFrameSettingsButton)
	GroupBulletinBoardFrameSettingsButton:ClearAllPoints()
	GroupBulletinBoardFrameSettingsButton:Point('BOTTOMRIGHT', GroupBulletinBoardFrameCloseButton, 'BOTTOMLEFT', -5, 0)
end

S:AddCallbackForAddon("LFGBulletinBoard")
