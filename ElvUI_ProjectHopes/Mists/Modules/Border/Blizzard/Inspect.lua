local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local CreateFrame = CreateFrame
local next, unpack = next, unpack
local hooksecurefunc = hooksecurefunc

local GetGlyphSocketInfo = GetGlyphSocketInfo
local GetInventoryItemQuality = GetInventoryItemQuality
local GetInspectSpecialization = GetInspectSpecialization

local function FrameBackdrop_OnEnter(frame)
	if not frame.backdrop then return end

	frame.backdrop:SetBackdropBorderColor(unpack(E.media.rgbvaluecolor))
end

local function FrameBackdrop_OnLeave(frame)
	if not frame.backdrop then return end

	frame.backdrop:SetBackdropBorderColor(unpack(E.media.bordercolor))
end

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

local function HandleTabs()
	local tab = _G.InspectFrameTab1
	local index, lastTab = 1, tab
	while tab do
		BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)

		tab:ClearAllPoints()

		if index == 1 then
			tab:Point('TOPLEFT', _G.InspectFrame, 'BOTTOMLEFT', -10, -5)
		else
			tab:Point('TOPLEFT', lastTab, 'TOPRIGHT', -15, 0)
			lastTab = tab
		end

		index = index + 1
		tab = _G['InspectFrameTab'..index]
	end
end

function S:Blizzard_InspectUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.inspect) then return end
	if not E.db.ProjectHopes.skins.inspect then return end

	local InspectFrame = _G.InspectFrame
	BORDER:CreateBorder(InspectFrame)

	-- Tabs
	HandleTabs()

	for i = 1, #_G.INSPECTFRAME_SUBFRAMES do
		BORDER:CreateBorder(_G['InspectFrameTab'..i], nil, nil, nil, nil, nil, true, true)
	end

	hooksecurefunc('InspectPaperDollItemSlotButton_Update', Update_InspectPaperDollItemSlotButton)

	-- PvP Tab
	_G.InspectPVPFrame:StripTextures()

	for _, name in next, { 'RatedBG', 'Arena2v2', 'Arena3v3', 'Arena5v5' } do
		local section = _G.InspectPVPFrame[name]
		if section then
			BORDER:CreateBorder(section, nil, nil, nil, nil, nil, true, true)
		end
	end

	-- Talent Tab
	_G.InspectTalentFrame:StripTextures()

	local Specialization = _G.Specialization
	BORDER:CreateBorder(Specialization, nil, nil, nil, nil, nil, true)

	for i = 1, 6 do
		for j = 1, 3 do
			local button = _G['TalentsTalentRow'..i..'Talent'..j]
			if button then
				if button.icon then
					BORDER:HandleIcon(button.icon, true)
				end
			end
		end
	end

	_G.TalentsTalentRow1:Point('TOPLEFT', 20, -142)

	_G.InspectTalentFrame:HookScript('OnShow', function(frame)
		if frame.IsBorder then return end

		frame.IsBorder = true

		local InspectGlyphs = _G.InspectGlyphs
		for i = 1, 6 do
			local glyph = InspectGlyphs['Glyph'..i]
			BORDER:HandleIcon(glyph, true)
		end
	end)
end

S:AddCallbackForAddon('Blizzard_InspectUI')
