local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

function S:ElvUI_AltPowerBar()
	if not E.db.ProjectHopes.skins.altPowerBar then return end

	local bar = _G.ElvUI_AltPowerBar
    
	if not bar then
		return
	end
	
	BORDER:CreateBorder(bar.backdrop)
end

S:AddCallback("ElvUI_AltPowerBar")
