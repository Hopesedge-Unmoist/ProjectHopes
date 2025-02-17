local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next = next
local unpack = unpack

function S:Blizzard_ScrappingMachineUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.scrapping) then return end
	if not E.db.ProjectHopes.skins.scrappingMachine then return end

	local MachineFrame = _G.ScrappingMachineFrame
	BORDER:CreateBorder(MachineFrame)
	BORDER:CreateBorder(MachineFrame.ScrapButton, nil, nil, nil, nil, nil, false, true)

	local ItemSlots = MachineFrame.ItemSlots            
	for i, button in next, { ItemSlots:GetChildren() } do
		if button.Icon then
			BORDER:HandleIcon(button.Icon)
			BORDER:HandleIconBorder(button.IconBorder, button.Icon.backdrop.border)
		end
	end
end

S:AddCallbackForAddon('Blizzard_ScrappingMachineUI')
