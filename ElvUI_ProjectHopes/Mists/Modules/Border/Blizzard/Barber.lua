local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

function S:Blizzard_BarbershopUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.barber) then return end
	if not E.db.ProjectHopes.skins.barbershop then return end

	BORDER:CreateBorder(_G.BarberShopFrame)

	BORDER:CreateBorder(_G.BarberShopFrameResetButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.BarberShopFrameCancelButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.BarberShopFrameOkayButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallbackForAddon('Blizzard_BarbershopUI')
