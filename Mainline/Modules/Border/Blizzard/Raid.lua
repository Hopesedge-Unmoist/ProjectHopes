local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local pairs = pairs

function S:Blizzard_RaidUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.raid) then return end
	if not E.db.ProjectHopes.skins.raidInfo then return end

	for i=1, _G.MAX_RAID_GROUPS*5 do
		BORDER:CreateBorder(_G['RaidGroupButton'..i], nil, nil, nil, nil, nil, false, true)
	end
end

S:AddCallbackForAddon('Blizzard_RaidUI')
