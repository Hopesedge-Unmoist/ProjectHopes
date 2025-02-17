local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local MICRO_BUTTONS = _G.MICRO_BUTTONS
	or {
		"CharacterMicroButton",
		"SpellbookMicroButton",
		"TalentMicroButton",
		"AchievementMicroButton",
		"QuestLogMicroButton",
		"GuildMicroButton",
		"LFDMicroButton",
		"EJMicroButton",
		"CollectionsMicroButton",
		"MainMenuMicroButton",
		"HelpMicroButton",
		"StoreMicroButton",
	}

function S:MicroButtons()
	if not E.db.ProjectHopes.skins.microButtons then return end

	for i = 1, #MICRO_BUTTONS do
		if _G[MICRO_BUTTONS[i]] then
			if not _G[MICRO_BUTTONS[i]].backdrop then
				_G[MICRO_BUTTONS[i]]:CreateBackdrop()
				BORDER:CreateBorder(_G[MICRO_BUTTONS[i]], nil, nil, nil, nil, nil, true, true)
			end
		end
	end
end

S:AddCallback("MicroButtons")
