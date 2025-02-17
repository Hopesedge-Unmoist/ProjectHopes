local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

function S:Blizzard_AzeriteUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.azerite) then return end
    if not E.db.ProjectHopes.skins.azeriteUI then return end

	BORDER:CreateBorder(_G.AzeriteEmpoweredItemUI)
end

S:AddCallbackForAddon('Blizzard_AzeriteUI')
