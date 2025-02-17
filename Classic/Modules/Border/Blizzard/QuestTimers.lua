local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

function S:Blizzard_QuestTimer()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.questTimers) then return end
	if not E.db.ProjectHopes.skins.questTimers then return end

	BORDER:CreateBorder(_G.QuestTimerFrame.backdrop)
end

S:AddCallbackForAddon('Blizzard_QuestTimer')
