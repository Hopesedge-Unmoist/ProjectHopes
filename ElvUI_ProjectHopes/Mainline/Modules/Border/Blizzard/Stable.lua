local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc

local function AbilitiesList_Layout(list)
	if not list.abilityPool then return end

	for frame in list.abilityPool:EnumerateActive() do
		if not frame.IsBorder then
			BORDER:HandleIcon(frame.Icon, true)
			frame.IsBorder = true
		end
	end
end

function S:Blizzard_StableUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.stable) then return end
	if not E.db.ProjectHopes.skins.stable then return end

	local StableFrame = _G.StableFrame
	BORDER:CreateBorder(StableFrame)

	BORDER:CreateBorder(StableFrame.StableTogglePetButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(StableFrame.ReleasePetButton, nil, nil, nil, nil, nil, false, true)

	local StabledPetList = StableFrame.StabledPetList           
	BORDER:CreateBorder(StabledPetList.FilterBar.SearchBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(StableFrame.StabledPetList.FilterBar.FilterDropdown, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(StabledPetList.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	local modelScene = StableFrame.PetModelScene
	if modelScene then
		local abilitiesList = modelScene.AbilitiesList
		if abilitiesList then
			hooksecurefunc(abilitiesList, 'Layout', AbilitiesList_Layout)
		end
	end

	BORDER:HandleModelSceneControlButtons(modelScene.ControlFrame)
end

S:AddCallbackForAddon('Blizzard_StableUI')
