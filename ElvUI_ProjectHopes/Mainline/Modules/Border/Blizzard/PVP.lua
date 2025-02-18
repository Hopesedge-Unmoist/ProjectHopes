local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local TT = E:GetModule('Tooltip')

local _G = _G
local ipairs, pairs, unpack, next = ipairs, pairs, unpack, next
local hooksecurefunc = hooksecurefunc

local GetItemInfo = C_Item.GetItemInfo
local GetItemQualityColor = C_Item.GetItemQualityColor

local ITEMQUALITY_ARTIFACT = Enum.ItemQuality.Artifact
local CurrencyContainerUtil_GetCurrencyContainerInfo = CurrencyContainerUtil.GetCurrencyContainerInfo
local C_CurrencyInfo_GetCurrencyInfo = C_CurrencyInfo.GetCurrencyInfo

local function HandleRoleButton(button)
	local checkbox = button.checkButton
	if checkbox:GetScale() ~= 1 then
		checkbox:SetScale(1)
	end
	checkbox:Size(24, 24)

	BORDER:CreateBorder(checkbox, nil, nil, nil, nil, nil, true, true)
end

function S:Blizzard_PVPUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.pvp) then return end
	if not E.db.ProjectHopes.skins.lookingForGroup then return end

	for i = 1, 2 do
		BORDER:CreateBorder(_G['PVPUIFrameTab'..i], nil, nil, nil, nil, nil, true, true)
	end

	for i = 1, 3 do
		local bu = _G['PVPQueueFrameCategoryButton'..i]
		BORDER:CreateBorder(bu, nil, nil, nil, nil, nil, false, true)

		BORDER:HandleIcon(bu.Icon)
	end

	local PVPQueueFrame = _G.PVPQueueFrame
	local SeasonReward = PVPQueueFrame.HonorInset.RatedPanel.SeasonRewardFrame
	BORDER:CreateBorder(SeasonReward.Icon)

	-- Honor Frame
	local HonorFrame = _G.HonorFrame
	BORDER:CreateBorder(_G.HonorFrame.SpecificScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.HonorFrameTypeDropdown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.HonorFrameQueueButton, nil, nil, nil, nil, nil, false, true)

	local BonusFrame = HonorFrame.BonusFrame
	for _, bonusButton in pairs({'RandomBGButton', 'Arena1Button', 'RandomEpicBGButton', 'BrawlButton', 'BrawlButton2'}) do
		local bu = BonusFrame[bonusButton]
		local reward = bu.Reward
		BORDER:CreateBorder(bu, nil, nil, 7, nil, -7, false, true)

		BORDER:HandleIcon(reward.Icon)

		BORDER:CreateBorder(reward.EnlistmentBonus, nil, -7, 7, 7, -7)
	end

	BonusFrame.RandomBGButton:Point('TOP', BonusFrame.Inset, 'TOP', 0, -2)
	BonusFrame.RandomEpicBGButton:Point('TOP', BonusFrame.RandomBGButton, 'BOTTOM', 0, -2)
	BonusFrame.Arena1Button:Point('TOP', BonusFrame.RandomEpicBGButton, 'BOTTOM', 0, -2)
	BonusFrame.BrawlButton:Point('TOP', BonusFrame.Arena1Button, 'BOTTOM', 0, -2)
	BonusFrame.BrawlButton2:Point('TOP', BonusFrame.BrawlButton, 'BOTTOM', 0, -2)

	-- Honor Frame Specific Buttons
	hooksecurefunc(HonorFrame.SpecificScrollBox, 'Update', function (box)
		for _, bu in next, { box.ScrollTarget:GetChildren() } do
			if not bu.IsBorder then
				BORDER:CreateBorder(bu, nil, -7, 7, 7, -7, true, true)
				BORDER:HandleIcon(bu.Icon, true)

				bu.Icon:Point('TOPLEFT', 7, -5)
				bu.Icon:Size(28, 28)

				bu.hover:Hide()

				bu.IsBorder = true
			end
		end
	end)

	HandleRoleButton(HonorFrame.TankIcon)
	HandleRoleButton(HonorFrame.HealerIcon)
	HandleRoleButton(HonorFrame.DPSIcon)

	-- Conquest Frame
	local ConquestFrame = _G.ConquestFrame
	BORDER:CreateBorder(_G.ConquestJoinButton, nil, nil, nil, nil, nil, false, true)

	HandleRoleButton(ConquestFrame.TankIcon)
	HandleRoleButton(ConquestFrame.HealerIcon)
	HandleRoleButton(ConquestFrame.DPSIcon)

	for _, bu in pairs({ConquestFrame.RatedSoloShuffle, ConquestFrame.RatedBGBlitz, ConquestFrame.Arena2v2, ConquestFrame.Arena3v3, ConquestFrame.RatedBG}) do
		local reward = bu.Reward
		BORDER:CreateBorder(bu, nil, nil, 7, nil, -7, false, true)
		BORDER:HandleIcon(reward.Icon)

		reward.RoleShortageBonus:SetFrameLevel(reward.Icon.backdrop.border:GetFrameLevel() + 1)
	end

	ConquestFrame.RatedSoloShuffle:Point('TOP', ConquestFrame.Inset, 'TOP', 0, -2)
	ConquestFrame.RatedBGBlitz:Point('TOP', ConquestFrame.RatedSoloShuffle, 'BOTTOM', 0, -2)
	ConquestFrame.Arena2v2:Point('TOP', ConquestFrame.RatedBGBlitz, 'BOTTOM', 0, -2)
	ConquestFrame.Arena3v3:Point('TOP', ConquestFrame.Arena2v2, 'BOTTOM', 0, -2)
	ConquestFrame.RatedBG:Point('TOP', ConquestFrame.Arena3v3, 'BOTTOM', 0, -2)

	-- Item Borders for HonorFrame & ConquestFrame
	hooksecurefunc('PVPUIFrame_ConfigureRewardFrame', function(rewardFrame, _, _, itemRewards, currencyRewards)
		local rewardTexture, rewardQuaility, _ = nil, 1

		if currencyRewards then
			for _, reward in ipairs(currencyRewards) do
				local info = C_CurrencyInfo_GetCurrencyInfo(reward.id)
				if info and info.quality == ITEMQUALITY_ARTIFACT then
					_, rewardTexture, _, rewardQuaility = CurrencyContainerUtil_GetCurrencyContainerInfo(reward.id, reward.quantity, info.name, info.iconFileID, info.quality)
				end
			end
		end

		if not rewardTexture and itemRewards then
			local reward = itemRewards[1]
			if reward then
				_, _, rewardQuaility, _, _, _, _, _, _, rewardTexture = GetItemInfo(reward.id)
			end
		end

		if rewardTexture then
			local r, g, b = GetItemQualityColor(rewardQuaility)
			rewardFrame.Icon:SetTexture(rewardTexture)
			if rewardFrame.Icon.backdrop then
				rewardFrame.Icon.backdrop.border:SetBackdrop(Private.BorderLight)
				rewardFrame.Icon.backdrop.border:SetBackdropBorderColor(r, g, b)
			end
		end
	end)

	-- PvP StatusBars
	for _, Frame in pairs({ HonorFrame, ConquestFrame }) do
		BORDER:HandleIcon(Frame.ConquestBar.Reward.Icon)
		BORDER:CreateBorder(Frame.ConquestBar)

	end

	-- New Season Frame
	local NewSeasonPopup = _G.PVPQueueFrame.NewSeasonPopup
	BORDER:CreateBorder(NewSeasonPopup)
	BORDER:CreateBorder(NewSeasonPopup.Leave, nil, nil, nil, nil, nil, false, true)

	local RewardFrame = NewSeasonPopup.SeasonRewardFrame
	BORDER:CreateBorder(RewardFrame.Icon, nil, -4, 4, 4, -4)
end

function S:PVPReadyDialog()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.pvp) then return end
	if not E.db.ProjectHopes.skins.lookingForGroup then return end

	BORDER:CreateBorder(_G.PVPReadyDialogEnterBattleButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.PVPReadyDialogLeaveQueueButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.PVPReadyDialog)
end

S:AddCallback('PVPReadyDialog')
S:AddCallbackForAddon('Blizzard_PVPUI')
