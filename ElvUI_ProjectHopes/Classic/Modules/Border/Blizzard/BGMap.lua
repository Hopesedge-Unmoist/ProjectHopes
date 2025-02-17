local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc

function S:Blizzard_BattlefieldMap()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.bgmap) then return end
	if not E.db.ProjectHopes.skins.bgmap then return end

	local BattlefieldMapFrame = _G.BattlefieldMapFrame
	BORDER:CreateBorder(BattlefieldMapFrame)
end

S:AddCallbackForAddon('Blizzard_BattlefieldMap')
