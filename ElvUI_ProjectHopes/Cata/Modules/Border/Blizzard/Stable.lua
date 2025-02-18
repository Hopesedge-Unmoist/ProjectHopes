local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local _G = _G

function S:PetStableFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.stable) then return end
	if not E.db.ProjectHopes.skins.stable then return end

	local PetStableFrame = _G.PetStableFrame
	BORDER:CreateBorder(PetStableFrame.backdrop)

	BORDER:CreateBorder(_G.PetStablePurchaseButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.PetStableCurrentPet)

	for i = 1, _G.NUM_PET_STABLE_SLOTS do
		BORDER:CreateBorder(_G['PetStableStabledPet'..i])
	end
end

S:AddCallback('PetStableFrame')
