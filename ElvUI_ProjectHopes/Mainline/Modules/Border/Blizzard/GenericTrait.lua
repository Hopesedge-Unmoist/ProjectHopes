local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc

function S:Blizzard_GenericTraitUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.genericTrait) then return end
	if not E.db.ProjectHopes.skins.genericTrait then return end

	local GenericTrait = _G.GenericTraitFrame
	BORDER:CreateBorder(GenericTrait)
end

S:AddCallbackForAddon('Blizzard_GenericTraitUI')
