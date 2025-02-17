local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local unpack = unpack

function S:Blizzard_ObliterumUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.obliterum) then return end
	if not E.db.ProjectHopes.skins.obliterum then return end

	local ObliterumForgeFrame = _G.ObliterumForgeFrame
	BORDER:CreateBorder(ObliterumForgeFrame)
	BORDER:CreateBorder(ObliterumForgeFrame.ObliterateButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallbackForAddon('Blizzard_ObliterumUI')
