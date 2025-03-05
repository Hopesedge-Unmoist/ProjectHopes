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
local TELEPORT_TO_DUNGEON = TELEPORT_TO_DUNGEON
local SPELL_FAILED_NOT_KNOWN = SPELL_FAILED_NOT_KNOWN

QoL.MAP_ID_TO_SPELL_IDS = {        
    -- Cataclysm
    [438] = {410080}, -- The Vortex Pinnacle
    [456] = {424142}, -- Throne of the Tides
    [507] = {445424}, -- Grim Batol
     
    -- Pandaria
    [2]   = {131204}, -- Temple of the Jade Serpent
    [56]  = {131205}, -- Stormstout Brewery
    [57]  = {131225}, -- Gate of the Setting Sun
    [58]  = {131206}, -- Shado-Pan Monastery
    [59]  = {131228}, -- Siege of Niuzao Temple
    [60]  = {131222}, -- Mogu'shan Palace
    [76]  = {131232}, -- Scholomance
    [77]  = {131231}, -- Scarlet Halls
    [78]  = {131229}, -- Scarlet Monastery
     
    -- Warlords of Draenor
    [161] = {159898}, -- Skyreach
    [163] = {159895}, -- Bloodmaul Slag Mines
    [164] = {159897}, -- Auchindoun
    [165] = {159899}, -- Shadowmoon Burial Grounds
    [166] = {159900}, -- Grimrail Depot
    [167] = {159902}, -- Upper Blackrock Spire
    [168] = {159901}, -- The Everbloom
    [169] = {159896}, -- Iron Docks
     
    -- Legion
    [197] = {}, -- Eye of Azshara
    [198] = {424163}, -- Darkheart Thicket
    [199] = {424153}, -- Black Rook Hold
    [200] = {393764}, -- Halls of Valor
    [206] = {410078}, -- Neltharion's Lair
    [207] = {}, -- Vault of the Wardens
    [208] = {}, -- Maw of Souls
    [209] = {}, -- The Arcway
    [210] = {393766}, -- Court of Stars
    [227] = {373262}, -- Lower Karazhan
    [233] = {}, -- Cathedral of Eternal Night
    [234] = {373262}, -- Upper Karazhan
    [239] = {}, -- Seat of the Triumvirate
     
    -- Battle for Azeroth
    [244] = {424187}, -- Atal'Dazar
    [245] = {410071}, -- Freehold
    [246] = {}, -- Tol Dagor
    [247] = {1216786}, -- The MOTHERLODE!!
    [248] = {424167}, -- Waycrest Manor
    [249] = {}, -- Kings' Rest
    [250] = {}, -- Temple of Sethraliss
    [251] = {410074}, -- The Underrot
    [252] = {}, -- Shrine of the Storm
    [353] = {445418, 464256}, -- Siege of Boralus
    [369] = {373274}, -- Mechagon Junkyard
    [370] = {373274}, -- Mechagon Workshop
     
    -- Shadowlands
    [375] = {354464}, -- Mists of Tirna Scithe
    [376] = {354462}, -- The Necrotic Wake
    [377] = {354468}, -- De Other Side
    [378] = {354465}, -- Halls of Atonement
    [379] = {354463}, -- Plaguefall
    [380] = {354469}, -- Sanguine Depths
    [381] = {354466}, -- Spires of Ascension
    [382] = {354467}, -- Theater of Pain
    [391] = {367416}, -- Streets of Wonder
    [392] = {367416}, -- So'leah's Gambit
     
    -- Dragonflight
    [399] = {393256}, -- Ruby Life Pools
    [400] = {393262}, -- The Nokhud Offensive
    [401] = {393279}, -- The Azure Vault
    [402] = {393273}, -- Algeth'ar Academy
    [403] = {393222}, -- Uldaman: Legacy of Tyr
    [404] = {393276}, -- Neltharus
    [405] = {393267}, -- Brackenhide Hollow
    [406] = {393283}, -- Halls of Infusion
    [463] = {424197}, -- Dawn of the Infinite: Galakrond's Fall
    [464] = {424197}, -- Dawn of the Infinite: Murozond's Rise
     
    -- The War Within
    [499] = {445444}, -- Priory of the Sacred Flame
    [500] = {445443}, -- The Rookery
    [501] = {445269}, -- The Stonevault
    [502] = {445416}, -- City of Threads
    [503] = {445417}, -- Ara-Kara, City of Echoes
    [504] = {445441}, -- Darkflame Cleft
    [505] = {445414}, -- The Dawnbreaker
    [506] = {445440}, -- Cinderbrew Meadery
}

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
    if not E.private.ProjectHopes.qualityOfLife.upgradeLevel then
        return
    end

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
	if not E.private.ProjectHopes.qualityOfLife.easyDelete then 
        return 
    end

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
	if not E.private.ProjectHopes.qualityOfLife.autoAcceptQuests then 
        return 
    end

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

-- Function to update the tooltip for the dungeon teleport buttons
function QoL:UpdateGameTooltip(parent, spellID, initialize)
    if self.isLoadingScreenEnabled then return end
    if not initialize and not GameTooltip:IsOwned(parent) then return end
    local Button_OnEnter = parent:GetScript("OnEnter")
    if not Button_OnEnter then return end
    local name = C_Spell.GetSpellName(spellID)

    Button_OnEnter(parent)

    if IsSpellKnown(spellID) then
        local spellCooldown = C_Spell.GetSpellCooldown(spellID)

        GameTooltip:AddLine(" ")
        GameTooltip:AddLine(name or TELEPORT_TO_DUNGEON)

        if not spellCooldown.startTime or not spellCooldown.duration then
            GameTooltip:AddLine(SPELL_FAILED_NOT_KNOWN, 0.6352941176470588, 0.2196078431372549, 0.2196078431372549)
        elseif spellCooldown.duration == 0 then
            GameTooltip:AddLine(READY, 0.5058823529411765, 0.7803921568627451, 0.5137254901960784)
        else
            GameTooltip:AddLine(SecondsToTime(ceil(spellCooldown.startTime + spellCooldown.duration - GetTime())), 0.6352941176470588, 0.2196078431372549, 0.2196078431372549)
        end
    else
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine(name or TELEPORT_TO_DUNGEON)
        GameTooltip:AddLine(SPELL_FAILED_NOT_KNOWN, 0.6352941176470588, 0.2196078431372549, 0.2196078431372549)
    end

    GameTooltip:Show()
    C_Timer.After(1, function () self:UpdateGameTooltip(parent, spellID) end)
end

-- Create individual dungeon button with best run score
function QoL:CreateDungeonButton(parent, spellIDs, mapID)
    if not spellIDs or not mapID then
        return 
    end

    local spellID = self:SelectBestSpellID(spellIDs)
    local button = self[parent] or CreateFrame("Button", nil, parent, "InsecureActionButtonTemplate")
    button:SetAllPoints(parent)
    button:RegisterForClicks("AnyDown", "AnyUp")
    button:SetAttribute("type", "spell")
    button:SetAttribute("spell", spellID)

    -- Create or update the font string for displaying best run score
    if not button.scoreText then
        button.scoreText = button:CreateFontString(nil, "OVERLAY")
        button.scoreText:SetFont(Private.Font, 20, 'OUTLINE')
        button.scoreText:SetPoint("BOTTOM", button, "BOTTOM", 0, 2)  -- Position the score at the bottom of the button
        button.scoreText:SetTextColor(1, 1, 0.5)  -- Set default text color
    end

    -- Fetch the best run score
    local _, score = C_MythicPlus.GetSeasonBestAffixScoreInfoForMap(mapID)
    
    if score then
        -- Fetch the rarity color for the score
        local scoreColor = C_ChallengeMode.GetSpecificDungeonOverallScoreRarityColor(score)
        local color = CreateColor(scoreColor.r, scoreColor.g, scoreColor.b, 1)  -- Create color from score rarity
        local hexColor = color:GenerateHexColor()  -- Generate hex color

        -- Display the score with colored text
        button.scoreText:SetText(format("|c%s%d|r", hexColor, score))
    else
        button.scoreText:SetText("No Score")  -- Display "No Score" if no data is available
    end

    -- Tooltip for the button
    button:SetScript("OnEnter", function () self:UpdateGameTooltip(parent, spellID, true) end)
    button:SetScript("OnLeave", function () if GameTooltip:IsOwned(parent) then GameTooltip:Hide() end end)

    self[parent] = button
end

-- Create dungeon buttons for all dungeons in the ChallengesFrame
function QoL:CreateDungeonButtons()
    if InCombatLockdown() then return end
    if not ChallengesFrame or not ChallengesFrame.DungeonIcons then return end

    -- Iterate through each dungeon icon and create buttons with mapID and spellIDs
    for _, dungeonIcon in pairs(ChallengesFrame.DungeonIcons) do
        local mapID = dungeonIcon.mapID  -- Retrieve the map ID for each dungeon
        local spellIDs = self.MAP_ID_TO_SPELL_IDS[mapID]  -- Get spell IDs for the current map ID
        self:CreateDungeonButton(dungeonIcon, spellIDs, mapID)  -- Pass mapID to the button creation function
    end
end

-- Event handler function
function QoL:OnEvent(event, arg1)
    if event == "ADDON_LOADED" and arg1 == "Blizzard_ChallengesUI" then
        self:Initialize()
        self:UnregisterEvent("ADDON_LOADED")
    elseif event == "LOADING_SCREEN_DISABLED" then
        self.isLoadingScreenEnabled = nil
    elseif event == "LOADING_SCREEN_ENABLED" then
        self.isLoadingScreenEnabled = true
    end
end

-- Select the best available spell ID from the list
function QoL:SelectBestSpellID(spellIDs)
    for _, spellID in ipairs(spellIDs) do
        if IsSpellKnown(spellID) then
            return spellID
        end
    end
    return spellIDs[1]  -- Return the first ID if no known spells are found
end

-- Initialization function
function QoL:Mplusimprovements()
    if not E.db.ProjectHopes.qualityOfLife.mplusimprovements then return end

    if not IsAddOnLoaded("Blizzard_ChallengesUI") then
        self:RegisterEvent("ADDON_LOADED", "OnEvent")
        return
    end
    
    self:RegisterEvent("LOADING_SCREEN_DISABLED", "OnEvent")
    self:RegisterEvent("LOADING_SCREEN_ENABLED", "OnEvent")
        
    -- Ensure that ChallengesFrame exists and is functioning
    if ChallengesFrame and type(ChallengesFrame.Update) == "function" then
        hooksecurefunc(ChallengesFrame, "Update", function () self:CreateDungeonButtons() end)
    end
    
    -- Initial button creation
    self:CreateDungeonButtons()
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
    QoL:Mplusimprovements()

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
QoL:RegisterEvent("ADDON_LOADED", "OnEvent")
QoL:RegisterEvent("LOADING_SCREEN_ENABLED", "OnEvent")
QoL:RegisterEvent("LOADING_SCREEN_DISABLED", "OnEvent")

E:RegisterModule(QoL:GetName())





