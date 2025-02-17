local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local LCG = E.Libs.CustomGlow

local _G = _G
local next = next
local unpack = unpack

local GetLootSlotInfo = GetLootSlotInfo
local hooksecurefunc = hooksecurefunc
local IsFishingLoot = IsFishingLoot
local UnitIsDead = UnitIsDead
local UnitIsFriend = UnitIsFriend
local UnitName = UnitName

local GetItemQualityByID = C_Item.GetItemQualityByID

local C_LootHistory_GetNumItems = C_LootHistory.GetNumItems
local C_LootHistory_GetItem = C_LootHistory.GetItem
local ITEM_QUALITY_COLORS = ITEM_QUALITY_COLORS
local LOOT, ITEMS = LOOT, ITEMS

local function UpdateLoots()
	local numItems = C_LootHistory_GetNumItems()
	for i = 1, numItems do
		local frame = _G.LootHistoryFrame.itemFrames[i]
		if frame and not frame.IsBorder then
			local Icon = frame.Icon:GetTexture()
			BORDER:CreateBorder(frame)

			-- create a backdrop around the icon
			local _, itemLink = C_LootHistory_GetItem(frame.itemIdx)
			if itemLink then
				local itemRarity = GetItemQualityByID(itemLink)
				if itemRarity then
					local color = ITEM_QUALITY_COLORS[itemRarity]

					if color then
						frame.border:SetBackdrop(Private.BorderLight)
						frame.border:SetBackdropBorderColor(color.r, color.g, color.b)
					end
				end
			end

			frame.IsBorder = true
		end
	end
end

function S:LootFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.loot) then return end
	if not E.db.ProjectHopes.skins.loot then return end

	-- Loot history frame
	local LootHistoryFrame = _G.LootHistoryFrame
	BORDER:CreateBorder(LootHistoryFrame)
	BORDER:CreateBorder(LootHistoryFrame.ResizeButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(_G.LootHistoryFrameScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)

	hooksecurefunc('LootHistoryFrame_FullUpdate', UpdateLoots)

	-- Master Looter Frame
	local MasterLooterFrame = _G.MasterLooterFrame

	hooksecurefunc('MasterLooterFrame_Show', function()
		local item = MasterLooterFrame.Item
		if item then
			local icon = item.Icon
			local texture = icon:GetTexture()
			local color = ITEM_QUALITY_COLORS[_G.LootFrame.selectedQuality]

			BORDER:CreateBorder(item)
			item.border:SetBackdrop(Private.BorderLight)
			item.border:SetBackdropBorderColor(color.r, color.g, color.b)
		end
	end)

	local LootFrame = _G.LootFrame
	BORDER:CreateBorder(LootFrame.backdrop)

	for i = 1, _G.LOOTFRAME_NUMBUTTONS do
		local button = _G['LootButton'..i]

		BORDER:CreateBorder(button.backdrop)
		BORDER:HandleIconBorder(button.IconBorder, button.backdrop.border)
	end
end

S:AddCallback('LootFrame')
