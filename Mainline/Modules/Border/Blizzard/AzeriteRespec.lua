local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

function S:Blizzard_AzeriteRespecUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.azeriteRespec) then return end
    if not E.db.ProjectHopes.skins.azeriteRespec then return end

	local AzeriteRespecFrame = _G.AzeriteRespecFrame

	BORDER:CreateBorder(AzeriteRespecFrame)

	local ButtonFrame = AzeriteRespecFrame.ButtonFrame
	BORDER:CreateBorder(ButtonFrame.AzeriteRespecButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallbackForAddon('Blizzard_AzeriteRespecUI')
