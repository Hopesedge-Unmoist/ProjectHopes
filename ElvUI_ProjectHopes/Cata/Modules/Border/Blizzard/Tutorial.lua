local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

function S:SkinTutorial()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.tutorial) then return end
	if not E.db.ProjectHopes.skins.tutorial then return end

	BORDER:CreateBorder(_G.TutorialFrame.backdrop)
	BORDER:CreateBorder(_G.TutorialFrameCheckButton, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.TutorialFrameOkayButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallback('SkinTutorial')
