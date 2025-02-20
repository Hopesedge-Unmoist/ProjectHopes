local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc
local pairs = pairs
local type = type
local unpack = unpack

function S:Spy()
	if not E.db.ProjectHopes.skins.spy then
		return
	end

	local Spy_MainWindow = _G.Spy_MainWindow
	S:HandleFrame(Spy_MainWindow)
	BORDER:CreateBorder(Spy_MainWindow)
	local Spy_AlertWindow = _G.Spy_AlertWindow
	S:HandleFrame(Spy_AlertWindow)
	BORDER:CreateBorder(Spy_AlertWindow)
	local Icon = Spy_AlertWindow.Icon
	Icon:CreateBackdrop()
	BORDER:CreateBorder(Icon)
	local SpyStatsFrame = _G.SpyStatsFrame
	S:HandlePortraitFrame(SpyStatsFrame)
	SpyStatsFrame.StatsFrame:StripTextures()
	SpyStatsFrame.StatsFrame:SetTemplate('Transparent')
	BORDER:CreateBorder(SpyStatsFrame)
	_G.SpyStatsTabFrameTabContentFrame:StripTextures()
	_G.SpyStatsTabFrameTabContentFrame:SetTemplate('Transparent')
	S:HandleCloseButton(SpyStatsFrameTopCloseButton)
	BORDER:CreateBorder(_G.SpyStatsTabFrameTabContentFrame)
	SpyStatsFrame_Title:ClearAllPoints()
	SpyStatsFrame_Title:SetPoint("TOP", SpyStatsFrame, "TOP", 0, -15)
	_G.SpyStatsFilterBox.FilterBox:StripTextures()
	S:HandleEditBox(_G.SpyStatsFilterBox.FilterBox)
	_G.SpyStatsFilterBox:SetSize(150, 15)
	BORDER:CreateBorder(_G.SpyStatsFilterBox.FilterBox)
	S:HandleCheckBox(_G.SpyStatsKosCheckbox)
	BORDER:CreateBorder(_G.SpyStatsKosCheckbox, nil, nil, nil, nil, nil, true, true)
	S:HandleCheckBox(_G.SpyStatsRealmCheckbox)
	BORDER:CreateBorder(_G.SpyStatsRealmCheckbox, nil, nil, nil, nil, nil, true, true)
	S:HandleCheckBox(_G.SpyStatsWinsLosesCheckbox)
	BORDER:CreateBorder(_G.SpyStatsWinsLosesCheckbox, nil, nil, nil, nil, nil, true, true)
	S:HandleCheckBox(_G.SpyStatsReasonCheckbox)
	BORDER:CreateBorder(_G.SpyStatsReasonCheckbox, nil, nil, nil, nil, nil, true, true)
	S:HandleButton(_G.SpyStatsRefreshButton)
	_G.SpyStatsRefreshButton:ClearAllPoints()
	_G.SpyStatsRefreshButton:SetPoint("BOTTOMRIGHT", SpyStatsFrame, "BOTTOMRIGHT", -12, 5)
	_G.SpyStatsRefreshButton:SetBackdrop()
	BORDER:CreateBorder(_G.SpyStatsRefreshButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.SpyStatsTabFrameTabContentFrameScrollFrameScrollBar, nil, nil, nil, nil, nil, false, true)
end

S:AddCallbackForAddon("Spy")