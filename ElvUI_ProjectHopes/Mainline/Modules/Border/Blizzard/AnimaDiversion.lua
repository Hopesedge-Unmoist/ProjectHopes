local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

function S:Blizzard_AnimaDiversionUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.animaDiversion) then return end
    if not E.db.ProjectHopes.skins.animaDiversionFrame then return end

	local AnimaDiversionFrame = _G.AnimaDiversionFrame
	BORDER:CreateBorder(AnimaDiversionFrame)

	BORDER:CreateBorder(AnimaDiversionFrame.ReinforceInfoFrame.AnimaNodeReinforceButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallbackForAddon('Blizzard_AnimaDiversionUI')
