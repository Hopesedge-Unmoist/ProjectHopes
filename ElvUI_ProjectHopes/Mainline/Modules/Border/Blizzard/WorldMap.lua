local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local TT = E:GetModule('Tooltip')

local _G = _G
local unpack = unpack
local hooksecurefunc = hooksecurefunc

local SessionCommand_ButtonAtlases = {
	[Enum.QuestSessionCommand.Start] = 'QuestSharing-DialogIcon',
	[Enum.QuestSessionCommand.Stop] = 'QuestSharing-Stop-DialogIcon'
}

local function NotifyDialogShow(_, dialog)
	if dialog.IsBorder then
		return 
	end

	BORDER:CreateBorder(dialog.ButtonContainer.Confirm, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(dialog.ButtonContainer.Decline, nil, nil, nil, nil, nil, false, true)
		
	dialog.IsBorder = true
end

local function QuestLogQuests()      
	for button in _G.QuestScrollFrame.headerFramePool:EnumerateActive() do
		if button.ButtonText and not button.IsBorder then
			BORDER:CreateBorder(button, nil, nil, nil, nil, nil, true, true)
			button.IsBorder = true
		end
	end

	for button in _G.QuestScrollFrame.titleFramePool:EnumerateActive() do
		if not button.IsBorder then
			if button.Checkbox then
				BORDER:CreateBorder(button.Checkbox, nil, nil, nil, nil, nil, true, true)
			end

			button.IsBorder = true
		end
	end

	for header in _G.QuestScrollFrame.campaignHeaderMinimalFramePool:EnumerateActive() do
		if header.CollapseButton and not header.IsBorder then
			BORDER:CreateBorder(header.backdrop)

			header.IsBorder = true
		end
	end
end

local EventsFrameHookedElements = {}
local function EventsFrameHighlightTexture(element)
	local rr, gg, bb = unpack(E.media.rgbvaluecolor)
	element:SetTexture(E.Media.Textures.White8x8)
	element:SetVertexColor(rr, gg, bb)
	element:SetAlpha(0.2)
end

local function EventsFrameBackgroundNormal(element, texture)
	if texture ~= E.Media.Textures.NormTex then
		local r, g, b = unpack(E.media.backdropcolor)
		element:SetTexture(E.Media.Textures.NormTex)
		element:SetVertexColor(r, g, b)
		element:SetAlpha(0.5)

		local parent = element:GetParent()
		if parent and parent.Highlight then
			EventsFrameHighlightTexture(parent.Highlight)
		end
	end
end

local EventsFrameFunctions = {
	function(element) -- 1: OngoingHeader
		if not element.Background.backdrop then
			element.Background:StripTextures()
			element.Background:CreateBackdrop('Transparent')
			BORDER:CreateBorder(element.Background.backdrop, nil, nil, nil, nil, nil, false, false)
		end

		element.Label:SetTextColor(1, 1, 1)
	end,
	function(element) -- 2: OngoingEvent
		if not EventsFrameHookedElements[element] then
			hooksecurefunc(element.Background, 'SetAtlas', EventsFrameBackgroundNormal)
			EventsFrameHookedElements[element] = element.Background
		end
	end,
	function(element) -- 3: ScheduledHeader
		if not element.Background.backdrop then
			element.Background:StripTextures()
			element.Background:CreateBackdrop('Transparent')
			BORDER:CreateBorder(element.Background.backdrop, nil, -8, 6, 8, -6, false, false)
		end

		element.Label:SetTextColor(1, 1, 1)
	end,
	function(element) -- 4: ScheduledEvent
		if element.Highlight then
			EventsFrameHighlightTexture(element.Highlight)
		end
	end
}

local function EventsFrameCallback(_, frame, elementData)
	if not elementData.data then return end

	local func = EventsFrameFunctions[elementData.data.entryType]
	if func then
		func(frame)
	end
end

function S:WorldMapFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.worldmap) then return end
	if not E.db.ProjectHopes.skins.worldMap then return end

	local WorldMapFrame = _G.WorldMapFrame
	BORDER:CreateBorder(WorldMapFrame, nil, nil, nil, nil, nil, true, false)

	local MapNavBar = WorldMapFrame.NavBar
	BORDER:CreateBorder(MapNavBar.homeButton, nil, nil, nil, nil, nil, false, true)
	BORDER.HandleNavBarButtons(WorldMapFrame.NavBar)

	-- Quest Frames
	local QuestMapFrame = _G.QuestMapFrame
	-- 11.1 New Side Tabs
	local tabs = {
		QuestMapFrame.QuestsTab,
		QuestMapFrame.EventsTab,
		QuestMapFrame.MapLegendTab
	}

	for i, tab in next, tabs do
		BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)
	end

	QuestMapFrame.EventsTab:ClearAllPoints()
	QuestMapFrame.EventsTab:SetPoint("TOP", QuestMapFrame.QuestsTab, "BOTTOM", 0, -8)
	QuestMapFrame.MapLegendTab:ClearAllPoints()
	QuestMapFrame.MapLegendTab:SetPoint("TOP", QuestMapFrame.EventsTab, "BOTTOM", 0, -8)

	local EventsFrame = QuestMapFrame.EventsFrame
	if EventsFrame then
		local EventsFrameScrollBox = EventsFrame.ScrollBox

		EventsFrameScrollBox:SetBackdrop()
		BORDER:CreateBorder(EventsFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

		_G.ScrollUtil.AddAcquiredFrameCallback(EventsFrameScrollBox, EventsFrameCallback, EventsFrame, true)
	end

	local MapLegend = QuestMapFrame.MapLegend
	local MapLegendScroll = MapLegend.ScrollFrame
	MapLegendScroll:SetBackdrop()

	local DetailsFrame = QuestMapFrame.DetailsFrame
	--BORDER:CreateBorder(DetailsFrame, nil, nil, nil, nil, nil, true, false)
	DetailsFrame.BackFrame.BackButton:ClearAllPoints()
	DetailsFrame.BackFrame.BackButton:SetPoint("TOPLEFT", DetailsFrame.BackFrame, "TOPLEFT", 5, -17)
	BORDER:CreateBorder(DetailsFrame.BackFrame.BackButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(DetailsFrame.AbandonButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(DetailsFrame.ShareButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(DetailsFrame.TrackButton, nil, nil, nil, nil, nil, false, true)
	DetailsFrame.AbandonButton:Width(92.2)
	DetailsFrame.ShareButton:Width(92.2)
	DetailsFrame.TrackButton:Width(92.2)
	DetailsFrame.AbandonButton:Point('BOTTOMLEFT', nil, 'BOTTOMLEFT', -3, -5)
	DetailsFrame.ShareButton:Point('LEFT', DetailsFrame.AbandonButton, 'RIGHT', 5, 0)
	DetailsFrame.TrackButton:Point('LEFT', DetailsFrame.ShareButton, 'RIGHT', 5, 0)

	local QuestScrollFrame = _G.QuestScrollFrame
	BORDER:CreateBorder(QuestScrollFrame.SearchBox, nil, nil, nil, nil, nil, true, true)

	local QuestScrollBar = _G.QuestScrollFrame.ScrollBar
	BORDER:CreateBorder(QuestScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	local CampaignOverview = QuestMapFrame.CampaignOverview

	BORDER:CreateBorder(_G.QuestMapDetailsScrollFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	
	local MapBorderFrame = WorldMapFrame.BorderFrame

	do -- Add a hook to adjust the OverlayFrames   
		local Dropdown, Tracking, Pin = unpack(WorldMapFrame.overlayFrames)
		BORDER:CreateBorder(Dropdown, nil, nil, nil, nil, nil, true, true)
	end

	-- 8.2.5 Party Sync | Credits Aurora/Shestak
	QuestMapFrame.QuestSessionManagement:StripTextures()

	local ExecuteSessionCommand = QuestMapFrame.QuestSessionManagement.ExecuteSessionCommand

	hooksecurefunc(_G.QuestSessionManager, 'NotifyDialogShow', NotifyDialogShow)
	hooksecurefunc('QuestLogQuests_Update', QuestLogQuests)

	local MapLegend = QuestMapFrame.MapLegend
	BORDER:CreateBorder(MapLegend.BackButton, nil, nil, nil, nil, nil, false, true)

	local MapLegendScroll = MapLegend.ScrollFrame
	BORDER:CreateBorder(MapLegendScroll.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
end

S:AddCallback('WorldMapFrame')
