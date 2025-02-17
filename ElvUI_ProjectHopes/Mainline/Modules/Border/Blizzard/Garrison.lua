local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next = next
local unpack, pairs, ipairs, select = unpack, pairs, ipairs, select

local CreateFrame = CreateFrame
local hooksecurefunc = hooksecurefunc

function S:Blizzard_GarrisonUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.garrison) then return end
	if not E.db.ProjectHopes.skins.garrison then return end

	local frames = {
		_G.GarrisonCapacitiveDisplayFrame,
		_G.GarrisonMissionFrame,
		_G.GarrisonLandingPage,
		_G.GarrisonBuildingFrame,
		_G.GarrisonShipyardFrame,
		_G.OrderHallMissionFrame,
		_G.OrderHallCommandBar,
		_G.BFAMissionFrame,
		_G.CovenantMissionFrame
	}

	local tabs = {
		_G.GarrisonMissionFrameTab1,
		_G.GarrisonMissionFrameTab2,
		_G.GarrisonLandingPageTab1,
		_G.GarrisonLandingPageTab2,
		_G.GarrisonLandingPageTab3,
		_G.GarrisonShipyardFrameTab1,
		_G.GarrisonShipyardFrameTab2,
		_G.OrderHallMissionFrameTab1,
		_G.OrderHallMissionFrameTab2,
		_G.OrderHallMissionFrameTab3,
		_G.BFAMissionFrameTab1,
		_G.BFAMissionFrameTab2,
		_G.BFAMissionFrameTab3,
		_G.CovenantMissionFrameTab1,
		_G.CovenantMissionFrameTab2
	}

	for _, frame in pairs(frames) do
		if frame then
			BORDER:CreateBorder(frame)
		end
	end
	for _, tab in pairs(tabs) do
		BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)
	end
end

S:AddCallbackForAddon('Blizzard_GarrisonUI')
