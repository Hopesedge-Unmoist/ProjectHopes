local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local _G = _G
local unpack = unpack
local hooksecurefunc = hooksecurefunc

function S:Blizzard_TrainerUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.trainer) then return end
	if not E.db.ProjectHopes.skins.trainer then return end

	local ClassTrainerFrame = _G.ClassTrainerFrame
	BORDER:CreateBorder(ClassTrainerFrame.backdrop)

	BORDER:CreateBorder(_G.ClassTrainerFrame.FilterDropdown, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.ClassTrainerListScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.ClassTrainerDetailScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.ClassTrainerTrainButton, nil, nil, nil, nil, nil, false, true)

	hooksecurefunc('ClassTrainer_SetSelection', function()
		local skillIcon = _G.ClassTrainerSkillIcon:GetNormalTexture()
		if skillIcon then
			BORDER:CreateBorder(skillIcon)
		end
	end)
end

S:AddCallbackForAddon('Blizzard_TrainerUI')
