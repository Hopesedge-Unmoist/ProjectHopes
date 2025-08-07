local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI);

local QoL = E:NewModule('QualityOfLife', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0');
local TT = E:GetModule('Tooltip')
local LSM = LibStub('LibSharedMedia-3.0')

local _G = _G
local tonumber = tonumber
local strmatch = strmatch

local CreateFrame = _G.CreateFrame
local tonumber = _G.tonumber
local string = _G.string
local C_GossipInfo = _G.C_GossipInfo
local IsShiftKeyDown = _G.IsShiftKeyDown
local GetNumAvailableQuests = _G.GetNumAvailableQuests
local SelectAvailableQuest = _G.SelectAvailableQuest
local GetNumActiveQuests = _G.GetNumActiveQuests
local GetActiveTitle = _G.GetActiveTitle
local C_QuestLog = _G.C_QuestLog
local GetActiveQuestID = _G.GetActiveQuestID
local SelectActiveQuest = _G.SelectActiveQuest
local StaticPopup_Hide = _G.StaticPopup_Hide
local next = _G.next
local QoLAutoAcceptQuests = CreateFrame("FRAME")
local GameTooltip, GameTooltipStatusBar = GameTooltip, GameTooltipStatusBar
local GetNumLootItems = GetNumLootItems
local GetTime = GetTime
local IsModifiedClick = IsModifiedClick
local IsFishingLoot = IsFishingLoot
local LootSlot = LootSlot

local C_Container_GetContainerNumFreeSlots = C_Container.GetContainerNumFreeSlots
local C_CVar_GetCVarBool = C_CVar.GetCVarBool

local AcceptResurrect = AcceptResurrect
local UnitAffectingCombat = UnitAffectingCombat
local UnitExists = UnitExists

local NUM_BAG_SLOTS = NUM_BAG_SLOTS

local IsAddOnLoaded = C_AddOns.IsAddOnLoaded

-- Function to create Gold colored text
local function CreateGoldText(text)
    if not text then return "" end
    return "|cffffc907" .. text .. "|r" -- Gold color code in WoW is "ffc907"
end

-- Function to add custom lines to the tooltip with highlighting the found upgrade level
local function AddCustomLine(tooltip, ...)
    local firstlogin = true
    if firstlogin then 
        firstlogin = false
        local foundLine = false
        local foundText = nil
        local upgradeOrder = {
            "Explorer 642-664",
            "Adventurer - 655-677",
            "Veteran - 668-691",
            "Champion - 681-703",
            "Hero - 694-710",
            "Mythic - 707-723",
        }
        
        local upgradeTextMapping = {
            ["Upgrade Level: Explorer"] = upgradeOrder[1],
            ["Upgrade Level: Adventurer"] = upgradeOrder[2],
            ["Upgrade Level: Veteran"] = upgradeOrder[3],
            ["Upgrade Level: Champion"] = upgradeOrder[4],
            ["Upgrade Level: Hero"] = upgradeOrder[5],
            ["Upgrade Level: Myth"] = upgradeOrder[6],
        }

		for i = tooltip:NumLines(), 1, -1 do
            local lineTextObject = _G[tooltip:GetName() .. "TextLeft" .. i]
            if lineTextObject then
                local text = lineTextObject:GetText()
                for upgradeLevel, upgradeDesc in pairs(upgradeTextMapping) do
                    if text:find(upgradeLevel) then
                        foundText = upgradeDesc
                        foundLine = true
                        break
                    end
                end
                if foundLine then
                    break
                end
            end
        end
        
        if foundLine then
            tooltip:AddLine(" ") -- Blank line for separation
            local lineNum = tooltip:NumLines() + 1
            for _, upgradeDesc in ipairs(upgradeOrder) do
                if foundText == upgradeDesc then
                    -- Apply green effect to the found line
                    tooltip:AddLine(CreateGoldText(upgradeDesc))
                else
                    -- Show other text in grey
                    tooltip:AddLine("|cff808080" .. upgradeDesc .. "|r")
                end
                lineNum = lineNum + 1
            end
            tooltip:Show()
        end
    end
end

function QoL:UpgradeLevel()
    if not E.Retail then return end
    if not E.private.ProjectHopes.qualityOfLife.upgradeLevel then return end
    
    -- Flag to ensure hooks are only added once
    if self.hooksAdded then
        return
    end

    -- Hook into the tooltip functions to add the custom line as required
    hooksecurefunc(GameTooltip, "SetBagItem", AddCustomLine)
    hooksecurefunc(ItemRefTooltip, "SetHyperlink", AddCustomLine)
    hooksecurefunc(GameTooltip, "SetHyperlink", AddCustomLine)
    hooksecurefunc(GameTooltip, "SetInventoryItem", AddCustomLine)
    hooksecurefunc(GameTooltip, "SetMerchantItem", AddCustomLine)
    hooksecurefunc(GameTooltip, "SetWeeklyReward", AddCustomLine)

    -- Mark hooks as added
    self.hooksAdded = true
end


function QoL:EasyDelete()
	if not E.private.ProjectHopes.qualityOfLife.automation.easyDelete then return end

	-- Higher quality than green
	hooksecurefunc(StaticPopupDialogs.DELETE_GOOD_ITEM, 'OnShow', function(frame)
		frame.editBox:SetText(DELETE_ITEM_CONFIRM_STRING)
	end)

	-- Quests and Quest starters
	hooksecurefunc(StaticPopupDialogs.DELETE_GOOD_QUEST_ITEM, 'OnShow', function(frame)
		frame.editBox:SetText(DELETE_ITEM_CONFIRM_STRING)
	end)
end

function QoL:AutoAcceptQuests()
	if not E.private.ProjectHopes.qualityOfLife.automation.autoAcceptQuests then return end

	local ignoredNPCs = {
		[164079] = true, [174871] = true, [164173] = true, [111243] = true,
		[142063] = true, [141584] = true, [88570]  = true, [87391]  = true,
		[18166]  = true, [142700] = true, [143005] = true, [142685] = true,
		[142975] = true, [143007] = true, [142992] = true, [142997] = true,
		[142998] = true, [142983] = true, [142995] = true, [142993] = true,
		[142981] = true, [143004] = true, [142973] = true, [142970] = true,
		[142994] = true, [142969] = true, [142157] = true, [143008] = true,
		[142158] = true, [142159] = true, [142977] = true, [172925] = true,
		[169501] = true, [181059] = true, [182681] = true, [54334]  = true,
		[55382]  = true, [54346]  = true, [28160]  = true, [26673]  = true,
		[29155]  = true, [29156]  = true, [196499] = true, [199366] = true,
		[194584] = true, [113617] = true, [193110] = true, [222413] = true,
	}

	local lastGossipOption

	local function GetNPCID()
		local guid = UnitGUID("npc")
		if guid then
			return tonumber(string.match(guid, "Creature%-%d+%-%d+%-%d+%-%d+%-(%d+)"))
		end
		return nil
	end

	local function SelectAvailableAndActiveQuests()
		for i = 1, GetNumAvailableQuests() do
			SelectAvailableQuest(i)
		end

		for i = 1, GetNumActiveQuests() do
			local _, completed = GetActiveTitle(i)
			if completed and (not E.Retail or not C_QuestLog.IsWorldQuest(GetActiveQuestID(i))) then
				SelectActiveQuest(i)
			end
		end
	end

	local function HandleGossip()
		local NPC_ID = GetNPCID()
		if not NPC_ID or ignoredNPCs[NPC_ID] then return end

		local activeQuests = C_GossipInfo.GetActiveQuests()
		local availableQuests = C_GossipInfo.GetAvailableQuests()
		local gossipOptions = C_GossipInfo.GetOptions()

		if #availableQuests > 0 then
			for _, quest in ipairs(availableQuests) do
				C_GossipInfo.SelectAvailableQuest(quest.questID)
			end
		elseif #activeQuests > 0 then
			local completed = false
			for _, quest in ipairs(activeQuests) do
				if quest.isComplete then
					C_GossipInfo.SelectActiveQuest(quest.questID)
					completed = true
				end
			end

			if not completed and #gossipOptions == 1 then
				-- Only one option, no active quest complete
				if NPC_ID ~= 153897 and not gossipOptions[1].name:match("|cFFFF0000") then
					local optionID = gossipOptions[1].gossipOptionID
					if lastGossipOption ~= optionID then
						C_GossipInfo.SelectOption(optionID)
						lastGossipOption = optionID
					end
				end
			else
				for _, option in ipairs(gossipOptions) do
					if option.name:match("|cFF0000FF") then -- Blue colored quest options
						C_GossipInfo.SelectOption(option.gossipOptionID)
					end
				end
			end

		else
			if E.Retail and C_Map.GetBestMapForUnit("player") == 762 then return end
			if #gossipOptions == 1 then
				if NPC_ID ~= 153897 and not gossipOptions[1].name:match("|cFFFF0000") then
					C_GossipInfo.SelectOption(gossipOptions[1].gossipOptionID)
				end
			else
				for _, option in ipairs(gossipOptions) do
					if option.name:match("|cFF0000FF") then
						C_GossipInfo.SelectOption(option.gossipOptionID)
					end
				end
			end
		end
	end

	local function HandleQuestProgress()
		if GetQuestMoneyToGet() > 0 then return end

		local activeQuests = C_GossipInfo.GetActiveQuests()
		if #activeQuests == 0 then
			CompleteQuest()
			return
		end

		for _, quest in ipairs(activeQuests) do
			if quest.isComplete then
				CompleteQuest()
			end
		end
	end

	local function HandleQuestComplete()
		if GetQuestMoneyToGet() > 0 then return end
		if GetNumQuestChoices() <= 1 then
			GetQuestReward(GetNumQuestChoices())
		end
	end

	QoLAutoAcceptQuests:RegisterEvent("QUEST_GREETING")
	QoLAutoAcceptQuests:RegisterEvent("GOSSIP_SHOW")
	QoLAutoAcceptQuests:RegisterEvent("QUEST_DETAIL")
	QoLAutoAcceptQuests:RegisterEvent("QUEST_COMPLETE")
	QoLAutoAcceptQuests:RegisterEvent("QUEST_ACCEPT_CONFIRM")
	QoLAutoAcceptQuests:RegisterEvent("QUEST_PROGRESS")

	QoLAutoAcceptQuests:SetScript("OnEvent", function(_, event)
		if IsShiftKeyDown() then return end

		if event == "QUEST_GREETING" then
			SelectAvailableAndActiveQuests()
		elseif event == "QUEST_DETAIL" then
			if E.Retail and QuestGetAutoAccept() then
				CloseQuest()
			else
				AcceptQuest()
			end
		elseif event == "QUEST_ACCEPT_CONFIRM" then
			ConfirmAcceptQuest()
			StaticPopup_Hide("QUEST_ACCEPT")
		elseif event == "GOSSIP_SHOW" then
			HandleGossip()
		elseif event == "QUEST_PROGRESS" then
			HandleQuestProgress()
		elseif event == "QUEST_COMPLETE" then
			HandleQuestComplete()
		end
	end)
end

function QoL:GetFreeSlots()
	local numFreeSlots = 0
	for bag = 0, NUM_BAG_SLOTS do
		numFreeSlots = numFreeSlots + tonumber((C_Container_GetContainerNumFreeSlots(bag))) or 0
	end
	return numFreeSlots
end

function QoL:LOOT_READY()
	if not E.private.ProjectHopes.qualityOfLife.fastLoot then return end

	local tDelay = 0
	if GetTime() - tDelay then
		tDelay = GetTime()
		if C_CVar_GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") and not IsFishingLoot() then
			for i = GetNumLootItems(), 1, -1 do
				if QoL:GetFreeSlots() > 0 then
					LootSlot(i)
				else
					Private.Print(L["Bags are full"])
				end
			end
			tDelay = GetTime()
		end
	end
end

function QoL:HideCrafterName()
	if not E.private.ProjectHopes.qualityOfLife.hideCrafter then return end

    ITEM_CREATED_BY=""
end

function QoL:RESURRECT_REQUEST(_, inviter)
    local inviterIsInCombat = UnitAffectingCombat(inviter)
    local bossExistsAndInCombat = UnitExists("boss1") and UnitAffectingCombat("boss1")

    -- Handle resurrection during combat situations
    if QoL.InCombat or inviterIsInCombat or bossExistsAndInCombat then
        if E.private.ProjectHopes.qualityOfLife.automation.combatresurrect then
            AcceptResurrect()
        end
    else
        -- Handle normal resurrection
        if E.private.ProjectHopes.qualityOfLife.automation.resurrect then
            AcceptResurrect()
        end
    end
end

function QoL:Initialize()
    QoL:EasyDelete()
    QoL:AutoAcceptQuests()
    QoL:UpgradeLevel()
    QoL:HideCrafterName()

    -- Hold this in here so it just takes over fps and is only loaded if needed. 
    if E.private.ProjectHopes.qualityOfLife.automation.combatresurrect or E.private.ProjectHopes.qualityOfLife.automation.resurrect then
        -- Register events with anonymous functions for combat state updates
        QoL:RegisterEvent("PLAYER_REGEN_ENABLED", function() QoL.InCombat = false end)
        QoL:RegisterEvent("PLAYER_REGEN_DISABLED", function() QoL.InCombat = true end)
        QoL:RegisterEvent("RESURRECT_REQUEST")
    end
end

-- Register events
QoL:RegisterEvent("LOOT_READY")

E:RegisterModule(QoL:GetName())