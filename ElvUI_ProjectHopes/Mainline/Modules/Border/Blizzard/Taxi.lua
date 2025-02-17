local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

function S:TaxiFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.taxi) then return end
	if not E.db.ProjectHopes.skins.taxi then return end

	local TaxiFrame = _G.TaxiFrame
	BORDER:CreateBorder(TaxiFrame)
end

S:AddCallback('TaxiFrame')
