local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local unpack = unpack
local hooksecurefunc = hooksecurefunc

function S:Blizzard_OrderHallUI()
	if not E.private.skins.blizzard.enable or not E.private.skins.blizzard.orderhall then return end
	if not E.db.ProjectHopes.skins.orderHall then return end

	local OrderHallTalentFrame = _G.OrderHallTalentFrame
	BORDER:CreateBorder(OrderHallTalentFrame)
	BORDER:CreateBorder(OrderHallTalentFrame.BackButton, nil, nil, nil, nil, nil, false, true)
	BORDER:HandleIcon(OrderHallTalentFrame.Currency.Icon, true)
end

S:AddCallbackForAddon('Blizzard_OrderHallUI')
