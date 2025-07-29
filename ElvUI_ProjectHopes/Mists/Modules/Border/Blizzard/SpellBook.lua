local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local unpack = unpack
local next, select = next, select
local hooksecurefunc = hooksecurefunc

local CreateFrame = CreateFrame
local GetProfessionInfo = GetProfessionInfo
local IsPassiveSpell = IsPassiveSpell
local SpellBook_GetWhatChangedItem = SpellBook_GetWhatChangedItem

local function UpdateButton()
	if _G.SpellBookFrame.bookType == _G.BOOKTYPE_PROFESSION then
		return
	end

	for i = 1, _G.SPELLS_PER_PAGE do
		local button = _G['SpellButton'..i]

		BORDER:CreateBorder(button.backdrop)
	end
end

local function HandleSkillButton(button)
	if not button then return end

	BORDER:HandleIcon(button.IconTexture, true)
end

function S:SpellBookFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.spellbook) then return end
	if not E.db.ProjectHopes.skins.spellBook then return end

	local SpellBookFrame = _G.SpellBookFrame
	BORDER:CreateBorder(SpellBookFrame)

	for i = 1, _G.SPELLS_PER_PAGE do
		local button = _G['SpellButton'..i]
		local highlight = _G['SpellButton'..i..'Highlight']

		BORDER:HandleIcon(button.IconTexture)
		hooksecurefunc(button, 'UpdateButton', UpdateButton)

	end

	for i = 1, 8 do
		local tab = _G['SpellBookSkillLineTab'..i]
		tab:StripTextures()
		tab:SetTemplate()
		tab:StyleButton(nil, true)
	end

	-- Skill tabs on the right side
	for i = 1, 8 do
		local tab = _G['SpellBookSkillLineTab'..i]
		BORDER:CreateBorder(tab)
	end

	-- Profession Tab
	for _, button in next, { _G.PrimaryProfession1, _G.PrimaryProfession2, _G.SecondaryProfession1, _G.SecondaryProfession2, _G.SecondaryProfession3, _G.SecondaryProfession4 } do
		local a, b, c, _, e = button.statusBar:GetPoint()
		BORDER:CreateBorder(button.statusBar)

		if button.icon then
			BORDER:HandleIcon(button.icon)
		end

		HandleSkillButton(button.SpellButton1)
		HandleSkillButton(button.SpellButton2)
	end

	for i = 1, 2 do
		local button = _G['PrimaryProfession'..i]
		BORDER:CreateBorder(button, nil, nil, nil, nil, nil, true, true)

		if button.iconTexture then
			BORDER:HandleIcon(button.iconTexture, true)
		end
	end

	-- Core Abilities Frame
	local SpellBookCoreAbilitiesFrame = _G.SpellBookCoreAbilitiesFrame
	hooksecurefunc('SpellBook_UpdateCoreAbilitiesTab', function()
		local buttons = SpellBookCoreAbilitiesFrame.Abilities
		for i = 1, #buttons do
			local button = buttons[i]
			if not button then return end

			if not button.IsBorder then
				BORDER:HandleIcon(button, true)

				button.IsBorder = true
			end
		end

		local tabs = SpellBookCoreAbilitiesFrame.SpecTabs
		for i = 1, #tabs do
			local tab = tabs[i]

			if tab and not tab.IsBorder then
				BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, false, true)

				tab.IsBorder = true
			end
		end
	end)

	-- Bottom Tabs
	for i = 1, 5 do
		BORDER:CreateBorder(_G['SpellBookFrameTabButton'..i], nil, nil, nil, nil, nil, true, true)
	end

	-- Reposition Tabs
	local tab = _G.SpellBookFrameTabButton1
	local index, lastTab = 1, tab
	while tab do
		tab:ClearAllPoints()

		if index == 1 then
			tab:Point('TOPLEFT', _G.SpellBookFrame, 'BOTTOMLEFT', -10, -5)
		else
			tab:Point('TOPLEFT', lastTab, 'TOPRIGHT', -14, 0)
			lastTab = tab
		end

		index = index + 1
		tab = _G['SpellBookFrameTabButton'..index]
	end
end

S:AddCallback('SpellBookFrame')
