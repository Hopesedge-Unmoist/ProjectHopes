local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')
local S = E:GetModule('Skins')

local _G = _G
local pairs = pairs

function S:LFGBulletinBoard()
	if not E.db.ProjectHopes.skins.lfgbulletinboard then return end

	--skin main frame
	S:HandleFrame(_G.GroupBulletinBoardFrame)
	BORDER:CreateBorder(_G.GroupBulletinBoardFrame)

	--skin scroll bar
	S:HandleScrollBar(_G.GroupBulletinBoardFrame_ScrollFrameScrollBar)
	BORDER:CreateBorder(_G.GroupBulletinBoardFrame_ScrollFrameScrollBarThumbTexture)

	--skin & position bottom tabs
	S:HandleTab(_G.GroupBulletinBoardFrameTab1)
	BORDER:CreateBorder(_G.GroupBulletinBoardFrameTab1, nil, nil, nil, nil, nil, true, true)
	S:HandleTab(_G.GroupBulletinBoardFrameTab2)
	BORDER:CreateBorder(_G.GroupBulletinBoardFrameTab2, nil, nil, nil, nil, nil, true, true)
	_G.GroupBulletinBoardFrameTab1:ClearAllPoints()
	_G.GroupBulletinBoardFrameTab1:Point('TOPLEFT', _G.GroupBulletinBoardFrame, 'BOTTOMLEFT', -10, -6)
	_G.GroupBulletinBoardFrameTab2:ClearAllPoints()
	_G.GroupBulletinBoardFrameTab2:Point('BOTTOMLEFT', _G.GroupBulletinBoardFrameTab1, 'BOTTOMRIGHT', -10, 0)

	--skin and position search box
	S:HandleEditBox(_G.GroupBulletinBoardFrameResultsFilter)
	_G.GroupBulletinBoardFrameResultsFilter:Height(20)
	_G.GroupBulletinBoardFrameResultsFilter:ClearAllPoints()
	_G.GroupBulletinBoardFrameResultsFilter:Point('TOPLEFT', _G.GroupBulletinBoardFrame, 'TOPLEFT', 140, -5)
	BORDER:CreateBorder(_G.GroupBulletinBoardFrameResultsFilter, nil, nil, nil, nil, nil, true, false)

	--skin and position close,settings and refresh buttons (it requires elt's glues for UI-Panel-Button-X))
	--border can be removed if ever skinned in glues by Hopes
	BORDER:CreateBorder(_G.GroupBulletinBoardFrameCloseButton)
	BORDER:CreateBorder(_G.GroupBulletinBoardFrameSettingsButton)
	BORDER:CreateBorder(_G.GroupBulletinBoardFrameRefreshButton)
	_G.GroupBulletinBoardFrameSettingsButton:ClearAllPoints()
	_G.GroupBulletinBoardFrameSettingsButton:Point('BOTTOMRIGHT', _G.GroupBulletinBoardFrameCloseButton, 'BOTTOMLEFT', -5, 0)
	_G.GroupBulletinBoardFrameRefreshButton:ClearAllPoints()
	_G.GroupBulletinBoardFrameRefreshButton:Point('BOTTOMRIGHT', _G.GroupBulletinBoardFrameSettingsButton, 'BOTTOMLEFT', -5, 0)
end

S:AddCallbackForAddon("LFGBulletinBoard")
