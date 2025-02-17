local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local pairs = pairs
local hooksecurefunc = hooksecurefunc
local IconColor = E.QualityColors[Enum.ItemQuality.Epic or 4] -- epic color only

local function SkinRewardIcon(itemFrame)
	if not itemFrame.IsBorder then
		BORDER:CreateBorder(itemFrame.backdrop)
		itemFrame.backdrop.border:SetBackdrop(Private.BorderLight)
		itemFrame.backdrop.border:SetBackdropBorderColor(IconColor.r, IconColor.g, IconColor.b)

		BORDER:HandleIcon(itemFrame.Icon)
		itemFrame.Icon.backdrop.border:SetBackdrop(Private.BorderLight)
		itemFrame.Icon.backdrop.border:SetBackdropBorderColor(IconColor.r, IconColor.g, IconColor.b)
		itemFrame.IsBorder = true
	end
end

local function SkinActivityFrame(frame, isObject)
	if frame.Border then
		if isObject then
			hooksecurefunc(frame.ItemFrame, 'SetDisplayedItem', SkinRewardIcon)
		end
	end
end

local function ReskinConfirmIcon(frame)
	BORDER:HandleIcon(frame.Icon)
	frame.Icon.backdrop.border:SetBackdrop(Private.BorderLight)
	frame.Icon.backdrop.border:SetBackdropBorderColor(frame.Icon.backdrop:GetBackdropBorderColor())
end

local function SelectReward(reward)
	local selection = reward.confirmSelectionFrame
	if selection then
		ReskinConfirmIcon(selection.ItemFrame)
		
		local alsoItems = selection.AlsoItemsFrame
		if alsoItems and alsoItems.pool then
			for items in alsoItems.pool:EnumerateActive() do
				ReskinConfirmIcon(items)
			end
		end
	end
end

local function UpdateSelection(frame)
	if not frame.backdrop then return end

	if frame.SelectedTexture:IsShown() then
		frame.border:SetBackdrop(Private.BorderLight)
		frame.border:SetBackdropBorderColor(unpack(E.media.rgbvaluecolor))
	else
		frame.border:SetBackdrop(Private.Border)
		frame.border:SetBackdropBorderColor(1, 1, 1)
	end
end

function S:Blizzard_WeeklyRewards()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.weeklyRewards) then return end
	if not E.db.ProjectHopes.skins.weeklyRewards then return end

	local WeeklyRewardsFrame = _G.WeeklyRewardsFrame
	BORDER:CreateBorder(WeeklyRewardsFrame)

	if E.private.skins.parchmentRemoverEnable then
		BORDER:CreateBorder(WeeklyRewardsFrame.RaidFrame)
		BORDER:CreateBorder(WeeklyRewardsFrame.MythicFrame)
		BORDER:CreateBorder(WeeklyRewardsFrame.WorldFrame)

		BORDER:CreateBorder(WeeklyRewardsFrame.PVPFrame)
		BORDER:CreateBorder(WeeklyRewardsFrame.SelectRewardButton)

		local header = WeeklyRewardsFrame.HeaderFrame
		BORDER:CreateBorder(header)
	end

	BORDER:CreateBorder(WeeklyRewardsFrame.SelectRewardButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(WeeklyRewardsFrame.ConcessionFrame, nil, -9, 9, 9, -9)

	SkinActivityFrame(WeeklyRewardsFrame.RaidFrame)
	SkinActivityFrame(WeeklyRewardsFrame.MythicFrame)
	SkinActivityFrame(WeeklyRewardsFrame.PVPFrame)
	SkinActivityFrame(WeeklyRewardsFrame.WorldFrame)

	for _, activity in pairs(WeeklyRewardsFrame.Activities) do
		SkinActivityFrame(activity, true)
	end

	local warningDialog = _G.WeeklyRewardExpirationWarningDialog
	if warningDialog then -- doesn't always exist
		warningDialog:Point('TOP', WeeklyRewardsFrame, 'BOTTOM', 0, -5)
		BORDER:CreateBorder(warningDialog)
	end

	hooksecurefunc(WeeklyRewardsFrame.ConcessionFrame, 'SetSelectionState', UpdateSelection)

	hooksecurefunc(WeeklyRewardsFrame, 'SelectReward', SelectReward)
end

-- /run UIParent_OnEvent({}, 'WEEKLY_REWARDS_SHOW')
S:AddCallbackForAddon('Blizzard_WeeklyRewards')
