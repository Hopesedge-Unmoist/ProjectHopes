local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local select = select

function S:Blizzard_AlliedRacesUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.alliedRaces) then return end
    if not E.db.ProjectHopes.skins.alliedRaces then return end

	local AlliedRacesFrame = _G.AlliedRacesFrame
	local AlliedScrollFrame = AlliedRacesFrame.RaceInfoFrame.ScrollFrame

	BORDER:CreateBorder(AlliedRacesFrame)
	BORDER:CreateBorder(AlliedScrollFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:HandleModelSceneControlButtons(AlliedRacesFrame.ModelScene.ControlFrame)
	BORDER:CreateBorder(AlliedRacesFrame.ModelScene)

	AlliedRacesFrame:HookScript('OnShow', function(s)
		for button in s.abilityPool:EnumerateActive() do
			select(3, button:GetRegions()):Hide()
			BORDER:HandleIcon(button.Icon)

		end
	end)

	BORDER:CreateBorder(AlliedScrollFrame.Child.ObjectivesFrame)
end

S:AddCallbackForAddon('Blizzard_AlliedRacesUI')
