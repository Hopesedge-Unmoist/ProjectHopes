local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

function S:WorldMapFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.worldmap) then return end
	if not E.db.ProjectHopes.skins.worldMap then return end

	local WorldMapFrame = _G.WorldMapFrame
	BORDER:CreateBorder(WorldMapFrame.BorderFrame.backdrop)
	BORDER:CreateBorder(WorldMapFrame.MiniBorderFrame.backdrop)
	BORDER:CreateBorder(_G.WorldMapZoneMinimapDropdown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.WorldMapContinentDropdown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.WorldMapZoneDropdown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.WorldMapZoomOutButton, nil, nil, nil, nil, nil, false, true)

	if E:IsAddOnEnabled('Questie') and _G.Questie_Toggle then
		BORDER:CreateBorder(_G.Questie_Toggle, nil, nil, nil, nil, nil, false, true)
	end
end

S:AddCallback('WorldMapFrame')
