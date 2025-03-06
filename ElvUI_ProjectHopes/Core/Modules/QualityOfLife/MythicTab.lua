local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI);
local MTb = E:NewModule('MythicTab', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0');

local TT = E:GetModule('Tooltip')

local IsAddOnLoaded = C_AddOns.IsAddOnLoaded
local GameTooltip, GameTooltipStatusBar = GameTooltip, GameTooltipStatusBar
local TELEPORT_TO_DUNGEON = TELEPORT_TO_DUNGEON
local SPELL_FAILED_NOT_KNOWN = SPELL_FAILED_NOT_KNOWN

local C_ChallengeMode.GetSpecificDungeonOverallScoreRarityColor = C_ChallengeMode.GetSpecificDungeonOverallScoreRarityColor
local C_MythicPlus.GetSeasonBestAffixScoreInfoForMap = C_MythicPlus.GetSeasonBestAffixScoreInfoForMap
local SelectBestSpellID = SelectBestSpellID

MTb.MAP_ID_TO_SPELL_IDS = {        
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
  [247] = {467555, 467553 }, -- The MOTHERLODE!!
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
  [525] = {1216786}, -- Operation: Floodgate
}

-- Function to update the tooltip for the dungeon teleport buttons
function MTb:UpdateGameTooltip(parent, spellID, initialize)
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
function MTb:CreateDungeonButton(parent, spellIDs, mapID)
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
      button.scoreText:SetText("No\nScore")  -- Display "No Score" if no data is available
  end

  -- Tooltip for the button
  button:SetScript("OnEnter", function () self:UpdateGameTooltip(parent, spellID, true) end)
  button:SetScript("OnLeave", function () if GameTooltip:IsOwned(parent) then GameTooltip:Hide() end end)

  self[parent] = button
end

-- Create dungeon buttons for all dungeons in the ChallengesFrame
function MTb:CreateDungeonButtons()
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
function MTb:OnEvent(event, arg1)
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
function MTb:SelectBestSpellID(spellIDs)
  for _, spellID in ipairs(spellIDs) do
      if IsSpellKnown(spellID) then
          return spellID
      end
  end
  return spellIDs[1]  -- Return the first ID if no known spells are found
end

-- Initialization function
function MTb:Mplusimprovements()
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

function MTb:Initialize()
  MTb:Mplusimprovements()
end

MTb:RegisterEvent("ADDON_LOADED", "OnEvent")
MTb:RegisterEvent("LOADING_SCREEN_ENABLED", "OnEvent")
MTb:RegisterEvent("LOADING_SCREEN_DISABLED", "OnEvent")

E:RegisterModule(MTb:GetName())