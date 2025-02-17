local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local unpack = unpack

function S:Blizzard_DeathRecap()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.deathRecap) then return end
    if not E.db.ProjectHopes.skins.deathRecap then return end

	local DeathRecapFrame = _G.DeathRecapFrame
	BORDER:CreateBorder(DeathRecapFrame)
	BORDER:CreateBorder(DeathRecapFrame.CloseButton, nil, nil, nil, nil, nil, false, true)

	for i=1, 5 do
		local recap = DeathRecapFrame['Recap'..i].SpellInfo
		BORDER:CreateBorder(recap.Icon)
	end
end

S:AddCallbackForAddon('Blizzard_DeathRecap')
