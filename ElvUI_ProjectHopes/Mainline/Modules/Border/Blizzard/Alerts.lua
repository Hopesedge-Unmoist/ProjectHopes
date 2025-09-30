local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc
local unpack, select = unpack, select

local CreateFrame = CreateFrame
local GetItemQualityByID = C_Item.GetItemQualityByID

local ITEM_QUALITY_COLORS = ITEM_QUALITY_COLORS

local function SkinAlert(alert)
	BORDER:CreateBorder(alert, nil, nil, nil, nil, nil, true)
end

local function SkinEntitlementDeliveredAlert(frame)
	BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true)
	--BORDER:CreateBorder(frame.Icon.b)
end

local function SkinAchievementAlert(frame)
	BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true)
end

local function SkinGuildChallengeAlert(frame)
	BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true)
end

local function SkinGarrisonMissionAlert(frame)
	BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true)
	BORDER:CreateBorder(frame.MissionType.b)
end

local function SkinGarrisonShipMissionAlert(frame)
	BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true)
	BORDER:CreateBorder(frame.MissionType.b)
end

local function SkinGarrisonRandomMissionAlert(frame, _, _, _, _, _, quality)
	BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true)
	local border
	if not frame.isBorder then
		local border = CreateFrame("Frame", nil, frame.MissionType.b, "BackdropTemplate")
		border:SetFrameLevel(frame.MissionType.b:GetFrameLevel() + 2 or 1)
		border:SetBackdrop(Private.Border)
		border:SetPoint("TOPLEFT" , frame.MissionType.b, "TOPLEFT", -8, 8) 
		border:SetPoint("BOTTOMRIGHT", frame.MissionType.b, "BOTTOMRIGHT", 8, -8) 
		border:SetBackdropBorderColor(1, 1, 1)
		frame.isBorder = true
	end

	if frame.PortraitFrame and frame.PortraitFrame.squareBG then
		local color = quality and ITEM_QUALITY_COLORS[quality]
		if color then
			border:SetBackdrop(Private.BorderLight)
			border:SetBackdropBorderColor(color.r, color.g, color.b)
		else
			border:SetBackdrop(Private.Border)
			border:SetBackdropBorderColor(1, 1, 1)
		end
	end
end

local function SkinGarrisonShipFollowerAlert(frame)
	BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true)
end

local function SkinCriteriaAlert(frame)
	BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true)
	BORDER:CreateBorder(frame.Icon.Texture.b)
	--if frame.Icon.Texture.b then 
		--frame.Icon.Texture.b:Point('TOPLEFT', frame.Icon.Texture, 'TOPLEFT', -1, 1)
		--frame.Icon.Texture.b:Point('BOTTOMRIGHT', frame.Icon.Texture, 'BOTTOMRIGHT', 1, -1)
	--end
end

local function SkinDungeonCompletionAlert(frame)
	BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true)
	BORDER:CreateBorder(frame.dungeonTexture.b)
end

local function SkinScenarioAlert(frame)
	BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true)
	BORDER:CreateBorder(frame.dungeonTexture.b)
end

local function SkinGarrisonFollowerAlert(frame)
	BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true)
end

local function SkinMoneyWonAlert(frame)
	BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true)
	BORDER:CreateBorder(frame.Icon.b)
end

local function SkinNewRecipeLearnedAlert(frame)
	BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true)
	BORDER:CreateBorder(frame.Icon.b)
end

local function SkinInvasionAlert(frame)
	BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true)
end

local function SkinWorldQuestCompleteAlert(frame)
	BORDER:CreateBorder(frame, 1, nil, nil, nil, nil, true)
	BORDER:CreateBorder(frame.QuestTexture.b)
	frame.QuestTexture:ClearAllPoints()
	frame.QuestTexture:Point('LEFT', frame.backdrop, 'LEFT', 7, 0)
end

local function SkinLootUpgradeAlert(frame)
	BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true)
end

local function SkinLootAlert(frame)
	BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true)
	local lootItem = frame.lootItem or frame
	BORDER:CreateBorder(lootItem)
end

local function SkinLegendaryItemAlert(frame, itemLink)
	BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true)
	local border
	if not frame.isBorder then
		border = CreateFrame("Frame", nil, frame.Icon.b, "BackdropTemplate")
		border:SetFrameLevel(frame.Icon.b:GetFrameLevel() + 2 or 1)
		border:SetBackdrop(Private.Border)
		border:SetPoint("TOPLEFT" , frame.Icon.b, "TOPLEFT", -8, 8) 
		border:SetPoint("BOTTOMRIGHT", frame.Icon.b, "BOTTOMRIGHT", 8, -8) 
		border:SetBackdropBorderColor(1, 1, 1)
		frame.isBorder = true
	end

	local itemRarity = GetItemQualityByID(itemLink)
	local color = itemRarity and ITEM_QUALITY_COLORS[itemRarity]
	if color then
		border:SetBackdrop(Private.BorderLight)
		border:SetBackdropBorderColor(color.r, color.g, color.b)
	else
		border:SetBackdrop(Private.Border)
		border:SetBackdropBorderColor(1, 1, 1)
	end
end


local function SkinDigsiteCompleteAlert(frame)
	BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true)
end

local function SkinRafRewardDeliveredAlert(frame)
	BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true)
end

local function SkinNewItemAlert(frame)
	BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true)
	BORDER:CreateBorder(frame.Icon.b)
	frame.IconOverlay:Kill()
	if frame.Icon.b then
		frame.Icon.b:Point('TOPLEFT', frame.Icon, 'TOPLEFT', -1, 1)
		frame.Icon.b:Point('BOTTOMRIGHT', frame.Icon, 'BOTTOMRIGHT', 1, -1)
	end
end

local function SkinGarrisonTalentAlert(frame)
	BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true)
	BORDER:CreateBorder(frame.Icon.b)
end

local function SkinGarrisonBuildingAlert(frame)
	BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true)
	BORDER:CreateBorder(frame.Icon.b)
end

function S:AlertSystem()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.alertframes) then return end
	if not E.db.ProjectHopes.skins.alertframes then return end

    -- Achievements
    BORDER:SecureHook(_G.AchievementAlertSystem, "setUpFunction", SkinAchievementAlert)
    BORDER:SecureHook(_G.CriteriaAlertSystem, "setUpFunction", SkinCriteriaAlert)
    BORDER:SecureHook(_G.MonthlyActivityAlertSystem, "setUpFunction", SkinCriteriaAlert)

    -- Encounters
    BORDER:SecureHook(_G.DungeonCompletionAlertSystem, "setUpFunction", SkinDungeonCompletionAlert)
    BORDER:SecureHook(_G.GuildChallengeAlertSystem, "setUpFunction", SkinGuildChallengeAlert)
    BORDER:SecureHook(_G.InvasionAlertSystem, "setUpFunction", SkinInvasionAlert)
    BORDER:SecureHook(_G.ScenarioAlertSystem, "setUpFunction", SkinScenarioAlert)
    BORDER:SecureHook(_G.WorldQuestCompleteAlertSystem, "setUpFunction", SkinWorldQuestCompleteAlert)

    -- Garrisons
    BORDER:SecureHook(_G.GarrisonFollowerAlertSystem, "setUpFunction", SkinGarrisonFollowerAlert)
    BORDER:SecureHook(_G.GarrisonShipFollowerAlertSystem, "setUpFunction", SkinGarrisonShipFollowerAlert)
    BORDER:SecureHook(_G.GarrisonTalentAlertSystem, "setUpFunction", SkinGarrisonTalentAlert)
    BORDER:SecureHook(_G.GarrisonBuildingAlertSystem, "setUpFunction", SkinGarrisonBuildingAlert)
    BORDER:SecureHook(_G.GarrisonMissionAlertSystem, "setUpFunction", SkinGarrisonMissionAlert)
    BORDER:SecureHook(_G.GarrisonShipMissionAlertSystem, "setUpFunction", SkinGarrisonShipMissionAlert)
    BORDER:SecureHook(_G.GarrisonRandomMissionAlertSystem, "setUpFunction", SkinGarrisonRandomMissionAlert)

    -- Loot
    BORDER:SecureHook(_G.LegendaryItemAlertSystem, "setUpFunction", SkinLegendaryItemAlert)
    BORDER:SecureHook(_G.LootAlertSystem, "setUpFunction", SkinLootAlert)
    BORDER:SecureHook(_G.LootUpgradeAlertSystem, "setUpFunction", SkinLootUpgradeAlert)
    BORDER:SecureHook(_G.MoneyWonAlertSystem, "setUpFunction", SkinMoneyWonAlert)
    BORDER:SecureHook(_G.HonorAwardedAlertSystem, "setUpFunction", SkinMoneyWonAlert)
    BORDER:SecureHook(_G.EntitlementDeliveredAlertSystem, "setUpFunction", SkinEntitlementDeliveredAlert)
    BORDER:SecureHook(_G.RafRewardDeliveredAlertSystem, "setUpFunction", SkinRafRewardDeliveredAlert)

    -- Professions
    BORDER:SecureHook(_G.DigsiteCompleteAlertSystem, "setUpFunction", SkinDigsiteCompleteAlert)
    BORDER:SecureHook(_G.NewRecipeLearnedAlertSystem, "setUpFunction", SkinNewRecipeLearnedAlert)

    -- Pets/Mounts
    BORDER:SecureHook(_G.NewPetAlertSystem, "setUpFunction", SkinNewItemAlert)
    BORDER:SecureHook(_G.NewMountAlertSystem, "setUpFunction", SkinNewItemAlert)
    BORDER:SecureHook(_G.NewToyAlertSystem, "setUpFunction", SkinNewItemAlert)

    -- Cosmetics
    BORDER:SecureHook(_G.NewCosmeticAlertFrameSystem, "setUpFunction", SkinNewItemAlert)

        	--[=[ Code you can use for alert testing
		--Queued Alerts:
		/run AchievementAlertSystem:AddAlert(5192)
		/run CriteriaAlertSystem:AddAlert(9023, 'Doing great!')
		/run LootAlertSystem:AddAlert('|cffa335ee|Hitem:18832::::::::::|h[Brutality Blade]|h|r', 1, 1, 1, 1, false, false, 0, false, false)
		/run LootUpgradeAlertSystem:AddAlert('|cffa335ee|Hitem:18832::::::::::|h[Brutality Blade]|h|r', 1, 1, 1, nil, nil, false)
		/run MoneyWonAlertSystem:AddAlert(81500)
		/run NewRecipeLearnedAlertSystem:AddAlert(204)
		/run NewCosmeticAlertFrameSystem:AddAlert(204)

		--Simple Alerts
		/run GuildChallengeAlertSystem:AddAlert(3, 2, 5)
		/run InvasionAlertSystem:AddAlert(678, DUNGEON_FLOOR_THENEXUS1, true, 1, 1)
		/run WorldQuestCompleteAlertSystem:AddAlert(AlertFrameMixin:BuildQuestData(42114))
		/run GarrisonTalentAlertSystem:AddAlert(3, C_Garrison.GetTalentInfo(370))
		/run GarrisonBuildingAlertSystem:AddAlert(GARRISON_CACHE)
		/run GarrisonFollowerAlertSystem:AddAlert(204, 'Ben Stone', 90, 3, false)
		/run GarrisonMissionAlertSystem:AddAlert(664) (Requires a mission ID that is in your mission list.)
		/run GarrisonShipFollowerAlertSystem:AddAlert(592, 'Test', 'Transport', 'GarrBuilding_Barracks_1_H', 3, 2, 1)
		/run LegendaryItemAlertSystem:AddAlert('|cffa335ee|Hitem:18832::::::::::|h[Brutality Blade]|h|r')
		/run EntitlementDeliveredAlertSystem:AddAlert('', [[Interface\Icons\Ability_pvp_gladiatormedallion]], TRINKET0SLOT, 214)
		/run RafRewardDeliveredAlertSystem:AddAlert('', [[Interface\Icons\Ability_pvp_gladiatormedallion]], TRINKET0SLOT, 214)
		/run DigsiteCompleteAlertSystem:AddAlert('Human')

		--Bonus Rolls
		/run BonusRollFrame_CloseBonusRoll()
		/run BonusRollFrame_StartBonusRoll(242969,'test',10,515,1273,14) --515 is darkmoon token, change to another currency id you have
        ]=]
end

S:AddCallback('AlertSystem')
