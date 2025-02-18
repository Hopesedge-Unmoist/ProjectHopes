local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next, unpack = next, unpack
local hooksecurefunc = hooksecurefunc

local GetItemQualityColor = C_Item.GetItemQualityColor
local GetInventoryItemQuality = GetInventoryItemQuality

local function Update_InspectPaperDollItemSlotButton(button)
	local unit = button.hasItem and _G.InspectFrame.unit
	local quality = unit and GetInventoryItemQuality(unit, button:GetID())
	BORDER:CreateBorder(button)

	if quality and quality > 1 then
		local r, g, b = GetItemQualityColor(quality)
		button.border:SetBackdrop(Private.BorderLight)
		button.border:SetBackdropBorderColor(r, g, b)
		return
	end
end

function S:Blizzard_InspectUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.inspect) then return end
	if not E.db.ProjectHopes.skins.inspect then return end

	local InspectFrame = _G.InspectFrame
	BORDER:CreateBorder(InspectFrame, nil, nil, nil, nil, nil, true, false)

	for i = 1, #_G.INSPECTFRAME_SUBFRAMES do
		BORDER:CreateBorder(_G['InspectFrameTab'..i], nil, nil, nil, nil, nil, true, true)
	end

	-- Reposition Tabs
	_G.InspectFrameTab1:ClearAllPoints()
	_G.InspectFrameTab1:Point('TOPLEFT', _G.InspectFrame, 'BOTTOMLEFT', 1, 71)
	_G.InspectFrameTab2:Point('TOPLEFT', _G.InspectFrameTab1, 'TOPRIGHT', -14, 0)

	hooksecurefunc('InspectPaperDollItemSlotButton_Update', Update_InspectPaperDollItemSlotButton)

	-- Honor Frame
	local InspectHonorFrame = _G.InspectHonorFrame
	BORDER:CreateBorder(InspectHonorFrame, nil, nil, nil, nil, nil, true, false)

	local InspectHonorFrameProgressBar = _G.InspectHonorFrameProgressBar
	BORDER:CreateBorder(InspectHonorFrameProgressBar, nil, nil, nil, nil, nil, false, false)
end

S:AddCallbackForAddon('Blizzard_InspectUI')
