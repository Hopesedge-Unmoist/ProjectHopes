local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc

function S:Blizzard_CovenantRenown()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.covenantRenown) then return end
    if not E.db.ProjectHopes.skins.covenantRenown then return end

	local CovenantRenownFrame = _G.CovenantRenownFrame
            
	BORDER:CreateBorder(CovenantRenownFrame)
end

S:AddCallbackForAddon('Blizzard_CovenantRenown')
