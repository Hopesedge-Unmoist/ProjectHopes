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
            "Explorer - 597-619",
            "Adventurer - 610-632",
            "Veteran - 623-645",
            "Champion - 636-658",
            "Hero - 649-665",
            "Mythic - 662-678",
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

    local lastgossip
    QoLAutoAcceptQuests:RegisterEvent("QUEST_GREETING")
    QoLAutoAcceptQuests:RegisterEvent("GOSSIP_SHOW")
    QoLAutoAcceptQuests:RegisterEvent("QUEST_DETAIL")
    QoLAutoAcceptQuests:RegisterEvent("QUEST_COMPLETE")
    QoLAutoAcceptQuests:RegisterEvent("QUEST_ACCEPT_CONFIRM")
    QoLAutoAcceptQuests:RegisterEvent("QUEST_PROGRESS")
    QoLAutoAcceptQuests:SetScript("OnEvent", function(_, event)
        local normal = IsShiftKeyDown()
        if normal then
            return
        else
            if event == 'QUEST_GREETING' then
                --if accepting quests
                for i = 1, GetNumAvailableQuests() do
                    SelectAvailableQuest(i)
                end

                --if completing quests
                for i = 1, GetNumActiveQuests() do
                    local _, completed = GetActiveTitle(i)
                    if E.Retail then
                        if completed and not C_QuestLog.IsWorldQuest(GetActiveQuestID(i)) then
                            SelectActiveQuest(i)
                        end
                    end
                end
            end

            if event == 'QUEST_DETAIL' then
                if E.Retail then
                    if QuestGetAutoAccept() then
                        CloseQuest()
                    else
                        AcceptQuest()
                    end
                end
            end

            if event == 'QUEST_ACCEPT_CONFIRM' then
                ConfirmAcceptQuest()
                StaticPopup_Hide("QUEST_ACCEPT")
            end

            if event == 'GOSSIP_SHOW' then
                local guid = UnitGUID("npc")
                if guid == nil then
                    return
                end
                local NPC_ID = tonumber(string.match(guid, "Creature%-%d+%-%d+%-%d+%-%d+%-(%d+)"))
                local ignoredNPCS = {
                    [164079] = true,
                    [174871] = true,
                    [164173] = true,
                    [111243] = true,
                    [142063] = true,
                    [141584] = true,
                    [88570] = true,
                    [87391] = true,
                    [18166] = true,
                    [142700] = true,
                    [143005] = true,
                    [142685] = true,
                    [142975] = true,
                    [143007] = true,
                    [142992] = true,
                    [142997] = true,
                    [142998] = true,
                    [142983] = true,
                    [142995] = true,
                    [142993] = true,
                    [142981] = true,
                    [143004] = true,
                    [142973] = true,
                    [142970] = true,
                    [142994] = true,
                    [142969] = true,
                    [142157] = true,
                    [143008] = true,
                    [142158] = true,
                    [142159] = true,
                    [142977] = true,
                    [172925] = true,
                    [169501] = true,
                    [181059] = true,
                    [182681] = true,
                    [54334] = true, --darkmoon tp
                    [55382] = true, --darkmoon tp
                    [54346] = true, --darkmoon tp
                    [28160] = true, --free teleport guy for wrath to scholazar
                    [26673] = true, --magical kingdom of dalaran alliance free tp to dalaran
                    [29155] = true, --magical kingdom of dalaran horde free tp to dalaran
                    [29156] = true, --magical kingdom of dalaran free tp to dalaran
                    [196499] = true, --therazal, aiding the accord quest that drops scaling gear, so should be delayed
                    [199366] = true, --therazal, aiding the accord quest that drops scaling gear, so should be delayed
                    [194584] = true, --Khuri, fishing npc
                    [113617] = true, --cos teleport back npc
                    [193110] = true, --Khadin, profession npc
                    [222413] = true, --Zalgo
                }
                if ignoredNPCS[NPC_ID] then
                    return
                else
                    --https://wowpedia.fandom.com/wiki/Category:API_namespaces/C_GossipInfo
                    --if E.Retail or E.Cata then
                    local active = C_GossipInfo.GetActiveQuests()
                    local available = C_GossipInfo.GetAvailableQuests()
                    local notcomplete = 0
                    local completed = 0
                    local loopcomplete = false
                    if available[1] and available[1].title ~= nil then
                        for _, k in next, C_GossipInfo.GetAvailableQuests() do --quests to grab
                            for l, v in next, k do
                                if l == "questID" then
                                    C_GossipInfo.SelectAvailableQuest(v)
                                end
                            end
                        end
                    elseif active[1] and active[1].title ~= nil then
                        for i, _ in next, C_GossipInfo.GetActiveQuests() do --quests already grabbed
                            if active[i].isComplete then
                                completed = completed + 1
                            elseif active[i].isComplete ~= true then
                                notcomplete = notcomplete +1
                            end
                            loopcomplete = true
                        end
                        if loopcomplete then
                            for i, k in next, C_GossipInfo.GetActiveQuests() do
                                if completed >= 1 then
                                    for l, v in next, k do
                                        if l == "questID" then
                                            C_GossipInfo.SelectActiveQuest(v)
                                        end
                                    end
                                end
                                if completed == 0 then
                                    local gossipInfoTable = C_GossipInfo.GetOptions()

                                    if #gossipInfoTable == 1 then
                                        if NPC_ID == 153897 then
                                            return
                                        else
                                            if gossipInfoTable[i] and gossipInfoTable[i].gossipOptionID then
                                                if lastgossip ~= gossipInfoTable[i].gossipOptionID then
                                                    C_GossipInfo.SelectOption(gossipInfoTable[i].gossipOptionID)
                                                    lastgossip = gossipInfoTable[i].gossipOptionID
                                                end
                                            end
                                        end
                                    else
                                        for infonumber = 1, #gossipInfoTable do
                                            local text = gossipInfoTable[infonumber].name
                                            if text and text:match("|cFF0000FF") then --quests are marked with a blue (Quests) text too
                                                C_GossipInfo.SelectOption(gossipInfoTable[infonumber].gossipOptionID)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                    elseif (not active[1] or active[1].title == nil) or (not available[1] or available[1].title == nil) then
                        local gossipInfoTable = C_GossipInfo.GetOptions()
                        if E.Retail and C_Map.GetBestMapForUnit('player') == 762 then return end
                        if #gossipInfoTable == 1 then
                            if NPC_ID == 153897 then
                                return
                            elseif gossipInfoTable[1].name:match("|cFFFF0000") then
                                return
                            else
                                C_GossipInfo.SelectOption(gossipInfoTable[1].gossipOptionID)
                            end
                        else
                            for i = 1, #gossipInfoTable do
                                local text = gossipInfoTable[i].name
                                if text and text:match("|cFF0000FF") then --quests are marked with a blue (Quests) text too
                                    C_GossipInfo.SelectOption(gossipInfoTable[i].gossipOptionID)
                                end
                            end
                        end
                    end
                end
            end

            if event == 'QUEST_PROGRESS' then
                if GetQuestMoneyToGet() > 0 then
                    return
                else
                    if C_GossipInfo.GetNumActiveQuests() == 0 then --maybe npc only has 1 quest, or its laurent from revendreth and it has a turn in with 0
                        CompleteQuest()
                    end
                    for i, _ in next, C_GossipInfo.GetActiveQuests() do --quests already grabbed
                        local questdump = C_GossipInfo.GetActiveQuests()
                        if not questdump[i].isComplete then
                            return
                        elseif questdump[i].isComplete then
                            CompleteQuest()
                        end
                    end
                end
            end

            if event == 'QUEST_COMPLETE' then
                if GetQuestMoneyToGet() > 0 then
                    return
                else
                    if GetNumQuestChoices() <= 1 then
                        GetQuestReward(GetNumQuestChoices())
                    end
                end
            end
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