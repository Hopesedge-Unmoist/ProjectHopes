local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next, unpack = next, unpack

local hooksecurefunc = hooksecurefunc
local CreateFrame = CreateFrame

local ITEM_QUALITY_COLORS = ITEM_QUALITY_COLORS

local function MasterLooterShow()
	local looter = _G.MasterLooterFrame
	local item = looter.Item
	if item then
		local icon = item.Icon
		local color = ITEM_QUALITY_COLORS[_G.LootFrame.selectedQuality or 1]

		BORDER:CreateBorder(item)
		item.border:SetBackdropBorderColor(color.r, color.g, color.b)
	end
end

local function LootHistoryElements(button)
	if button.IsBorder then return end
	BORDER:CreateBorder(button)

	local item = button.Item
	local icon = item and item.icon
	if item then
		BORDER:HandleIcon(icon)
		BORDER:HandleIconBorder(item.IconBorder, icon.backdrop.border)
	end

	button.IsBorder = true
end

local function HandleScrollElements(box)
	if box then
		box:ForEachFrame(LootHistoryElements)
	end
end

local function LootFrameUpdate(frame)
	for _, button in next, { frame.ScrollTarget:GetChildren() } do
		local item = button.Item
		if item then
			if item.backdrop then
				BORDER:HandleIcon(item.icon)
			end

			if button.Text then -- icon border isn't updated for white/grey so pull color from the name
				local r, g, b = button.Text:GetVertexColor()
				item.icon.backdrop.border:SetBackdropBorderColor(r, g, b)
			end
		end
	end
end

function S:LootFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.loot) then return end
	if not E.db.ProjectHopes.skins.loot then return end

	local LootFrame = _G.LootFrame
	if LootFrame then
		BORDER:CreateBorder(LootFrame)
		hooksecurefunc(LootFrame.ScrollBox, 'Update', LootFrameUpdate)
	end

	local HistoryFrame = _G.GroupLootHistoryFrame
	if HistoryFrame then
		BORDER:CreateBorder(HistoryFrame)
		BORDER:CreateBorder(HistoryFrame.Timer)

		local Dropdown = HistoryFrame.EncounterDropdown
		if Dropdown then
			BORDER:CreateBorder(Dropdown, nil, nil, nil, nil, nil, true, true)
		end

		BORDER:CreateBorder(HistoryFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
		hooksecurefunc(HistoryFrame.ScrollBox, 'Update', HandleScrollElements)

		local LootResize = HistoryFrame.ResizeButton
		if LootResize then
			BORDER:CreateBorder(LootResize)

			LootResize:ClearAllPoints()
			LootResize:Point('TOP', HistoryFrame, 'BOTTOM', 0, -5)
		end
	end

	local MasterLooterFrame = _G.MasterLooterFrame
	if MasterLooterFrame then
		hooksecurefunc('MasterLooterFrame_Show', MasterLooterShow)
	end

	local BonusRollFrame = _G.BonusRollFrame
	local bonusSpecIcon = BonusRollFrame.SpecIcon

	if BonusRollFrame then
		BORDER:CreateBorder(BonusRollFrame)
		BORDER:CreateBorder(_G.BonusRollLootWonFrame, nil, nil, nil, nil, nil, true, false)
		BORDER:CreateBorder(_G.BonusRollMoneyWonFrame, nil, nil, nil, nil, nil, true, false)
		BORDER:CreateBorder(BonusRollFrame.PromptFrame.Timer)
		BORDER:CreateBorder(BonusRollFrame.PromptFrame.IconBackdrop)
		BORDER:CreateBorder(bonusSpecIcon)
	end
end

S:AddCallback('LootFrame')
