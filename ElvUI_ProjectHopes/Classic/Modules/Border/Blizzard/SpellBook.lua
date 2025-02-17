local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next, unpack = next, unpack

local CreateFrame = CreateFrame
local hooksecurefunc = hooksecurefunc

function S:SpellBookFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.spellbook) then return end
	if not E.db.ProjectHopes.skins.spellBook then return end

	BORDER:CreateBorder(_G.SpellBookFrame.backdrop)

	local showAllRanks = _G.ShowAllSpellRanksCheckbox
	if showAllRanks then
		BORDER:CreateBorder(showAllRanks, nil, nil, nil, nil, nil, true, true)
	end

	for i = 1, 3 do
		local tab = _G['SpellBookFrameTabButton'..i]
		BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)
	end

	-- Reposition Tabs
	_G.SpellBookFrameTabButton1:ClearAllPoints()
	_G.SpellBookFrameTabButton1:Point('TOPLEFT', _G.SpellBookFrame, 'BOTTOMLEFT', -3, 89)
	_G.SpellBookFrameTabButton2:Point('TOPLEFT', _G.SpellBookFrameTabButton1, 'TOPRIGHT', -27, 0)
	_G.SpellBookFrameTabButton3:Point('TOPLEFT', _G.SpellBookFrameTabButton2, 'TOPRIGHT', -27, 0)

	-- Spell Buttons
	for i = 1, _G.SPELLS_PER_PAGE do
		local button = _G['SpellButton'..i]
		local icon = _G['SpellButton'..i..'IconTexture']
		local cooldown = _G['SpellButton'..i..'Cooldown']
		local highlight = _G['SpellButton'..i..'Highlight']

		BORDER:CreateBorder(button)

		button.bg:Hide()
	end

	for i = 1, _G.MAX_SKILLLINE_TABS do
		local tab = _G['SpellBookSkillLineTab'..i]
		local flash = _G['SpellBookSkillLineTab'..i..'Flash']

		BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, false, true)

		if i == 1 then
			tab:Point('TOPLEFT', _G.SpellBookSideTabsFrame, 'TOPRIGHT', -25, -70)
		end
	end
end

S:AddCallback('SpellBookFrame')
