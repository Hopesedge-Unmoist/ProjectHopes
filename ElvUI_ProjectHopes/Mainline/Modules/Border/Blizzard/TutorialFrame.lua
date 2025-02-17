local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

function S:TutorialFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.tutorials) then return end
	if not E.db.ProjectHopes.skins.tutorial then return end

	local TutorialFrame = _G.TutorialFrame
	BORDER:CreateBorder(TutorialFrame)

	BORDER:CreateBorder(_G.TutorialFrameOkayButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallback('TutorialFrame')
