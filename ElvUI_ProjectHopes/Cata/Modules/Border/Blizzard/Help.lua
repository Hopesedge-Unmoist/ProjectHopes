local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

function S:HelpFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.help) then return end
	if not E.db.ProjectHopes.skins.help then return end

	BORDER:CreateBorder(_G.HelpFrame, nil, nil, nil, nil, nil, true, false)
end

S:AddCallback('HelpFrame')
