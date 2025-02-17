local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

function S:MirrorTimers()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.mirrorTimers) then return end
	if not E.db.ProjectHopes.skins.mirrorTimers then return end

	for i = 1, _G.MIRRORTIMER_NUMTIMERS do
		local mirrorTimer = _G['MirrorTimer'..i]
		local statusBar = _G['MirrorTimer'..i..'StatusBar']

		BORDER:CreateBorder(statusBar)
	end
end

S:AddCallback('MirrorTimers')
