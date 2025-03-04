local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')
local S = E:GetModule('Skins')

local _G = _G
local pairs = pairs

function S:Spy()
	if not E.db.ProjectHopes.skins.spy then return end

	local frameData = {
    	{frame = _G.Spy_MainWindow},
		{frame = _G.Spy_AlertWindow},
		{frame = _G.SpyStatsFrame.StatsFrame},
		{frame = _G.SpyStatsPlayerHistoryFrame},
		{frame = _G.SpyStatsTabFrameTabContentFrame, scrollbar = _G.SpyStatsTabFrameTabContentFrameScrollFrameScrollBar},
		{frame = _G.SpyStatsTabFrameTabContentFrame.ContentFrame},
	}

	local editboxData = {
		{editbox = _G.SpyStatsFilterBox.FilterBox, borderParams = {nil, nil, nil, nil, nil, true, false}},
	}

	local buttonData = {
		{button = _G.SpyStatsRefreshButton, borderParams = {nil, nil, nil, nil, nil, false, true}},
	}

	local checkboxData = {
		{checkbox = _G.SpyStatsKosCheckbox, borderParams = {nil, nil, nil, nil, nil, true, true}},
		{checkbox = _G.SpyStatsRealmCheckbox, borderParams = {nil, nil, nil, nil, nil, true, true}},
		{checkbox = _G.SpyStatsWinsLosesCheckbox, borderParams = {nil, nil, nil, nil, nil, true, true}},
		{checkbox = _G.SpyStatsReasonCheckbox, borderParams = {nil, nil, nil, nil, nil, true, true}},
	}
	-- Need this before skinning
	_G.SpyStatsFilterBox.FilterBox:StripTextures()

	-- Apply the skinning
	BORDER:SkinFrameList(frameData)
	BORDER:SkinEditboxList(editboxData)
	BORDER:SkinButtonList(buttonData)
	BORDER:SkinCheckBoxes(checkboxData)

	-- Position
	BORDER:ClearAndSetPoint(_G.SpyStatsRefreshButton, "BOTTOMRIGHT", _G.SpyStatsFrame, "BOTTOMRIGHT", -12, 5)
	BORDER:ClearAndSetPoint(_G.SpyStatsFrame_Title, "TOP", _G.SpyStatsFrame, "TOP", 0, -15)

	-- Adjust sizes
	BORDER:AdjustSize(_G.SpyStatsFilterBox,-20,-12)
	BORDER:AdjustSize(_G.SpyStatsKosCheckbox,-4,-4)
	BORDER:AdjustSize(_G.SpyStatsRealmCheckbox,-4,-4)
	BORDER:AdjustSize(_G.SpyStatsWinsLosesCheckbox,-4,-4)
	BORDER:AdjustSize(_G.SpyStatsReasonCheckbox,-4,-4)

	-- Additional Things
	-- Remove backdrop from Refresh button
	_G.SpyStatsRefreshButton:SetBackdrop()

	-- Skin Close Button
	S:HandleCloseButton(_G.SpyStatsFrameTopCloseButton)
	S:HandleCloseButton(_G.Spy_MainWindow.CloseButton)

	-- Skin Portait Frame
	S:HandlePortraitFrame(_G.SpyStatsFrame)

	-- Skin Alert Icon
	_G.Spy_AlertWindow.Icon:CreateBackdrop()
	BORDER:CreateBorder(_G.Spy_AlertWindow.Icon)

	-- Hide Titlebar
    _G.Spy_MainWindow.TitleBar:SetAlpha(0)
end

S:AddCallbackForAddon("Spy")
