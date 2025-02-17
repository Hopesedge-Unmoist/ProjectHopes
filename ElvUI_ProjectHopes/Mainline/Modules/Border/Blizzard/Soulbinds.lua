local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

function S:Blizzard_Soulbinds()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.soulbinds) then return end
	if not E.db.ProjectHopes.skins.soulbinds then return end

	local SoulbindViewer = _G.SoulbindViewer
	BORDER:CreateBorder(SoulbindViewer)

	BORDER:CreateBorder(SoulbindViewer.CommitConduitsButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(SoulbindViewer.ActivateSoulbindButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallbackForAddon('Blizzard_Soulbinds')
