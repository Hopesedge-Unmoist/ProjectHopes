local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc



function S:Blizzard_ItemUpgradeUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.itemUpgrade) then return end
	if not E.db.ProjectHopes.skins.itemUpgrade then return end

	local ItemUpgradeFrame = _G.ItemUpgradeFrame
	BORDER:CreateBorder(ItemUpgradeFrame, nil, nil, nil, nil, nil, true, false)

	BORDER:CreateBorder(_G.ItemUpgradeFrameRightItemPreviewFrame, 1)
	BORDER:CreateBorder(_G.ItemUpgradeFrameLeftItemPreviewFrame, 1)

	ItemUpgradeFrame.BottomBG.backdrop:Hide()

	local button = ItemUpgradeFrame.UpgradeItemButton
	BORDER:HandleIcon(button.icon, true)
	BORDER:HandleIconBorder(button.IconBorder, button.icon.backdrop.border)

	local holder = button.ButtonFrame
	holder.backdrop:Hide()
	
	BORDER:CreateBorder(ItemUpgradeFrame.UpgradeButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(ItemUpgradeFrame.ItemInfo.Dropdown, nil, nil, nil, nil, nil, true, true)
end

S:AddCallbackForAddon('Blizzard_ItemUpgradeUI')
