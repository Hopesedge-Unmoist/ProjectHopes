local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

function S:Blizzard_ItemInteractionUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.itemInteraction) then return end
	if not E.db.ProjectHopes.skins.itemInteraction then return end

	local mainFrame = _G.ItemInteractionFrame
	BORDER:CreateBorder(mainFrame)

	local itemSlot = mainFrame.ItemSlot
	BORDER:HandleIcon(itemSlot.Icon, true)

	if mainFrame.CurrencyCost then
		BORDER:HandleIcon(mainFrame.CurrencyCost.Currency.Icon, true)
	end

	local buttonFrame = mainFrame.ButtonFrame            
	if buttonFrame.Currency then
		buttonFrame.Currency.Count:ClearAllPoints()
		buttonFrame.Currency.Count:SetPoint("RIGHT", buttonFrame.Currency.Icon, "LEFT", -7, 0)
		BORDER:HandleIcon(buttonFrame.Currency.Icon, true)
	end

	BORDER:CreateBorder(buttonFrame.ActionButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallbackForAddon('Blizzard_ItemInteractionUI')
