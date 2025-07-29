local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local strfind = strfind
local pairs, unpack = pairs, unpack
local hooksecurefunc = hooksecurefunc
local CreateFrame = CreateFrame

local C_SpecializationInfo_GetSpecialization = C_SpecializationInfo.GetSpecialization
local C_SpecializationInfo_GetSpecializationInfo = C_SpecializationInfo.GetSpecializationInfo

local function PositionTabs()
	_G.PlayerTalentFrameTab1:ClearAllPoints()
	_G.PlayerTalentFrameTab1:Point('TOPLEFT', _G.PlayerTalentFrame, 'BOTTOMLEFT', -10, -5)
	_G.PlayerTalentFrameTab2:Point('TOPLEFT', _G.PlayerTalentFrameTab1, 'TOPRIGHT', -15, 0)
	_G.PlayerTalentFrameTab3:Point('TOPLEFT', _G.PlayerTalentFrameTab2, 'TOPRIGHT', -15, 0)
	_G.PlayerTalentFrameTab4:Point('TOPLEFT', _G.PlayerTalentFrameTab3, 'TOPRIGHT', -15, 0)
end

function S:Blizzard_TalentUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.talent) then return end
	if not E.db.ProjectHopes.skins.talent then return end

	local PlayerTalentFrame = _G.PlayerTalentFrame
	S:HandlePortraitFrame(PlayerTalentFrame)
	BORDER:CreateBorder(PlayerTalentFrame)

	local buttons = {
		_G.PlayerTalentFrameSpecializationLearnButton,
		_G.PlayerTalentFrameTalentsLearnButton,
		_G.PlayerTalentFramePetSpecializationLearnButton
	}

	BORDER:CreateBorder(_G.PlayerTalentFrameActivateButton, nil, nil, nil, nil, nil, false, true)

	for _, button in pairs(buttons) do
		BORDER:CreateBorder(button, nil, nil, nil, nil, nil, false, true)
	end

	for i = 1, 4 do
		BORDER:CreateBorder(_G['PlayerTalentFrameTab'..i], nil, nil, nil, nil, nil, true, true)
	end

	-- Reposition Tabs
	PositionTabs()
	hooksecurefunc('PlayerTalentFrame_UpdateTabs', PositionTabs)

	for _, Frame in pairs({ _G.PlayerTalentFrameSpecialization, _G.PlayerTalentFramePetSpecialization }) do
		for i = 1, 4 do
			local Button = Frame['specButton'..i]
			local _, _, _, icon = C_SpecializationInfo_GetSpecializationInfo(i, false, Frame.isPet)

			if Button.backdrop then
				BORDER:CreateBorder(Button, nil, nil, nil, nil, nil, true, true)
			end

			BORDER:HandleIcon(Button.specIcon, true)
		end

		BORDER:HandleIcon(Frame.spellsScroll.child.specIcon, true)
	end

	for i = 1, 7 do -- MAX_TALENT_TIERS currently 7
		local row = _G['PlayerTalentFrameTalentsTalentRow'..i]

		for j = 1, 3 do -- NUM_TALENT_COLUMNS currently 3
			local button = _G['PlayerTalentFrameTalentsTalentRow'..i..'Talent'..j]
			if button then

				BORDER:HandleIcon(button.icon, true)
				BORDER:CreateBorder(button.bg)
			end
		end
	end
end

function S:Blizzard_GlyphUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.talent) then return end
	if not E.db.ProjectHopes.skins.talent then return end

	-- Glyph Tab
	local GlyphFrame = _G.GlyphFrame
	BORDER:CreateBorder(GlyphFrame)
	BORDER:CreateBorder(_G.GlyphFrameSearchBox, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.GlyphFrame.FilterDropdown, nil, nil, nil, nil, nil, false, true)

	for i = 1, _G.NUM_GLYPH_SLOTS do
		local frame = _G['GlyphFrameGlyph'..i]
		BORDER:CreateBorder(frame)
	end

	-- Scroll Frame
	BORDER:CreateBorder(_G.GlyphFrameScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)

	for i = 1, 10 do
		local button = _G['GlyphFrameScrollFrameButton'..i]
		if button and not button.IsBorder then
			BORDER:CreateBorder(button, nil, -6, 6, 6, -6, false, true)

			local icon = _G['GlyphFrameScrollFrameButton'..i..'Icon']
			if icon then
				BORDER:HandleIcon(icon)
			end

			button.IsBorder = true
		end
	end
end

S:AddCallbackForAddon('Blizzard_TalentUI')
S:AddCallbackForAddon('Blizzard_GlyphUI')
