local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local _G = _G
local next = next
local select = select
local hooksecurefunc = hooksecurefunc

local GetProfessionInfo = GetProfessionInfo
local C_SpellBook_GetSpellBookItemInfo = C_SpellBook.GetSpellBookItemInfo
local SpellBookSpellBank = Enum.SpellBookSpellBank

local function HandleSkillButton(button)
	if not button then return end

	BORDER:HandleIcon(button.IconTexture)
end

function S:Blizzard_ProfessionsBook()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.spellbook) then return end
	if not E.db.ProjectHopes.skins.professions then return end

	local ProfessionsBookFrame = _G.ProfessionsBookFrame
	BORDER:CreateBorder(ProfessionsBookFrame)

	--Profession Tab
	local barColor = {0, .86, 0}
	for _, button in next, { _G.PrimaryProfession1, _G.PrimaryProfession2, _G.SecondaryProfession1, _G.SecondaryProfession2, _G.SecondaryProfession3 } do
		BORDER:CreateBorder(button.statusBar)

		if button.icon then
			BORDER:HandleIcon(button.icon, true)
		end

		HandleSkillButton(button.SpellButton1)
		HandleSkillButton(button.SpellButton2)

		for i = 1, 2 do
			local button = _G['PrimaryProfession'..i]
	
			if button.iconTexture then
				BORDER:HandleIcon(button.iconTexture)
			end
		end
	end
end

S:AddCallbackForAddon('Blizzard_ProfessionsBook')
