local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local unpack = unpack
local hooksecurefunc = hooksecurefunc

local function DressUpConfigureSize(frame)
	frame.OutfitDetailsPanel:ClearAllPoints()
	frame.OutfitDetailsPanel:Point('TOPLEFT', frame, 'TOPRIGHT', 7, 0)
end

local function HandleSetButtons(button)
	if not button.IsBorder then

	BORDER:HandleIcon(button.Icon)
	button.IsBorder = true
	end
end

local function SetSelection_Update(box)
	if box then
		box:ForEachFrame(HandleSetButtons)
	end
end

local function SetItemQuality(slot)
	if not slot.slotState and not slot.isHiddenVisual and slot.transmogID then
		slot.Icon.backdrop.border:SetBackdrop(Private.BorderLight)
		slot.Icon.backdrop.border:SetBackdropBorderColor(slot.Name:GetTextColor())
	else
		slot.Icon.backdrop.border:SetBackdropBorderColor(1, 1, 1)
	end
end

local function DetailsPanelRefresh(panel)
	if not panel.slotPool then return end
	local previousSlot = nil

	for slot in panel.slotPool:EnumerateActive() do
		if slot.backdrop then
			BORDER:HandleIcon(slot.Icon, true)
		end

		SetItemQuality(slot)

		if previousSlot then
			local point, relativeTo, relativePoint, xOfs, yOfs = slot:GetPoint()
			slot:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs - 2)
		end

		previousSlot = slot
	end
end

function S:DressUpFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.dressingroom) then return end
	if not E.db.ProjectHopes.skins.dressingRoom then return end

	local DressUpFrame = _G.DressUpFrame

	BORDER:CreateBorder(DressUpFrame)
	BORDER:CreateBorder(DressUpFrame.OutfitDetailsPanel, nil, nil, nil, nil, nil, true, false)

	BORDER:CreateBorder(_G.DressUpFrameResetButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.DressUpFrameCancelButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(DressUpFrame.LinkButton, nil, nil, nil, nil, nil, false, true)
	BORDER:HandleModelSceneControlButtons(DressUpFrame.ModelScene.ControlFrame)
	BORDER:CreateBorder(DressUpFrame.ToggleOutfitDetailsButton, nil, nil, nil, nil, nil, false, true)

	local SetSelection = DressUpFrame.SetSelectionPanel
	BORDER:CreateBorder(SetSelection)
	SetSelection:SetFrameLevel(6)

	if SetSelection then
		BORDER:CreateBorder(SetSelection.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

		hooksecurefunc(SetSelection.ScrollBox, 'Update', SetSelection_Update)
	end

	DressUpFrame.ModelBackground:SetDrawLayer('BACKGROUND', 1)
	DressUpFrame.LinkButton:Size(110, 22)
	DressUpFrame.LinkButton:ClearAllPoints()
	DressUpFrame.LinkButton:Point('BOTTOMLEFT', 4, 4)

	_G.DressUpFrameCancelButton:Point('BOTTOMRIGHT', -4, 4)
	_G.DressUpFrameResetButton:Point('RIGHT', _G.DressUpFrameCancelButton, 'LEFT', -3, 0)

	local OutfitDropDown = DressUpFrame.OutfitDropdown
	BORDER:CreateBorder(OutfitDropDown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(OutfitDropDown.SaveButton, nil, nil, nil, nil, nil, false, true)

	hooksecurefunc(DressUpFrame.OutfitDetailsPanel, 'Refresh', DetailsPanelRefresh)
	hooksecurefunc(DressUpFrame, 'ConfigureSize', DressUpConfigureSize)

	local WardrobeOutfitEditFrame = _G.WardrobeOutfitEditFrame
	BORDER:CreateBorder(WardrobeOutfitEditFrame.Border)

	BORDER:CreateBorder(WardrobeOutfitEditFrame.EditBox.backdrop)
	BORDER:CreateBorder(WardrobeOutfitEditFrame.AcceptButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(WardrobeOutfitEditFrame.CancelButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(WardrobeOutfitEditFrame.DeleteButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallback('DressUpFrame')
