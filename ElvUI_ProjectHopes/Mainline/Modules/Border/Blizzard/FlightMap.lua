local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

function S:Blizzard_FlightMap()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.taxi) then return end
    if not E.db.ProjectHopes.skins.flightMap then return end

	local FlightMapFrame = _G.FlightMapFrame
	BORDER:CreateBorder(FlightMapFrame)
end

S:AddCallbackForAddon('Blizzard_FlightMap')
