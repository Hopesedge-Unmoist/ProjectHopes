local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')


local _G = _G
local next, unpack = next, unpack
local hooksecurefunc = hooksecurefunc

local GetItemQualityColor = C_Item.GetItemQualityColor
local GetInventoryItemQuality = GetInventoryItemQuality

local MAX_ARENA_TEAMS = MAX_ARENA_TEAMS

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
	_G.InspectFrameTab3:Point('TOPLEFT', _G.InspectFrameTab2, 'TOPRIGHT', -14, 0)

	hooksecurefunc('InspectPaperDollItemSlotButton_Update', Update_InspectPaperDollItemSlotButton)

	-- Talents
	BORDER:CreateBorder(_G.InspectTalentFrame, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(_G.InspectTalentFrameScrollFrame, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(_G.InspectTalentFrameScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)

	for i = 1, _G.MAX_NUM_TALENTS do
		local talent = _G['InspectTalentFrameTalent'..i]

		if talent then
			talent:CreateBackdrop()
			BORDER:CreateBorder(talent.backdrop, 1)
		end
	end

	-- HandleTab looks weird
	for i = 1, 3 do
		local tab = _G['InspectTalentFrameTab'..i]
		tab:StripTextures()
	end

	-- Honor/Arena/PvP Tab
	for i = 1, MAX_ARENA_TEAMS do
		local inspectpvpTeam = _G['InspectPVPTeam'..i]
		BORDER:CreateBorder(inspectpvpTeam, nil, nil, nil, nil, nil, true, true)
	end
end

S:AddCallbackForAddon('Blizzard_InspectUI')
