local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

local S = E:GetModule('Skins')
local BORDER = E:GetModule('BORDER')

local function CreateTable(parent, anchor, dataTable, cellHeight)
    cellHeight = cellHeight or 14
    local colWidths = {}

    for col = 1, #dataTable[1] do
        local maxW = 0
        for row = 1, #dataTable do
            local temp = parent:CreateFontString(nil, "OVERLAY")
            temp:FontTemplate(nil, 14, "OUTLINE")
            temp:SetText(dataTable[row][col])
            maxW = math.max(maxW, temp:GetStringWidth())
            temp:Hide()
        end
        colWidths[col] = maxW + 10 -- padding
    end

    for row = 1, #dataTable do
        local xOffset = 0
        for col = 1, #dataTable[row] do
            local fs = parent:CreateFontString(nil, "OVERLAY")
            fs:FontTemplate(nil, 14, "OUTLINE")
            fs:SetText(dataTable[row][col])
            fs:SetJustifyH("CENTER")
            fs:SetWidth(colWidths[col])
            fs:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT",
                xOffset, -((row-1) * cellHeight)
            )
            xOffset = xOffset + colWidths[col]
        end
    end
end

local function GreatVaultInfo()
  if not E.db.ProjectHopes.qualityOfLife.greatVaultInfo then return end
  
  local WeeklyRewardsFrame = _G.WeeklyRewardsFrame

  if frame then return end
  local frame = CreateFrame('Frame', 'ProjectHopes_GreatVaultInfo', WeeklyRewardsFrame)
	BORDER:CreateBorder(frame)
	frame:SetTemplate('Transparent')
	frame:SetWidth(300)
	frame:SetPoint("TOPRIGHT", WeeklyRewardsFrame, "TOPLEFT", -6, 0)
  frame:SetPoint("BOTTOMRIGHT", WeeklyRewardsFrame, "BOTTOMLEFT", 0, 0) 
  frame:SetFrameLevel(WeeklyRewardsFrame:GetFrameLevel() + 1)

	-- Header
	local header = CreateFrame('Frame', 'ProjectHopes_ChangelogHeader', frame, 'BackdropTemplate')
	header:Point('TOPLEFT', frame, 0, 0)
	header:Point('TOPRIGHT', frame, 0, 0)
	header:SetHeight(25)
	header:SetTemplate('Transparent')
	header:SetBackdrop(nil)
	header.text = header:CreateFontString(nil, 'OVERLAY')
	header.text:FontTemplate(nil, 15, 'OUTLINE')
	header.text:SetText(E:TextGradient("Great Vault Information", 0.6, 0.6, 0.6, 1, 0.77, 0.02))
	header.text:Point('CENTER', header, 0, -1)

	-- Content text
	local content = frame:CreateFontString(nil, "OVERLAY")
	content:FontTemplate(nil, 13, "OUTLINE")
	content:SetJustifyH("LEFT")
	content:SetJustifyV("TOP")
	content:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 10, -10)
	content:SetWidth(frame:GetWidth() - 20) -- wrap text inside the frame
  content:SetText(E:TextGradient("Gear Item Level:", 0.6, 0.6, 0.6, 1, 0.77, 0.02))

  local ilvlTable = {
    { "Explorer", "Adventurer", "Veteran"},
    { "|cff999999642-664|r", "|cffd9d9d9655-678|r", "|cff56c680668-691|r" },
    { "", "", "" },
    { "Champion", "Hero", "Myth" },
    { "|cff5a91c8681-704|r", "|cffab16e8694-717|r", "|cffff7f00707-723|r" },
  }

  local contentRaid = frame:CreateFontString(nil, "OVERLAY")
  contentRaid:FontTemplate(nil, 16, "OUTLINE")
  contentRaid:SetJustifyH("LEFT")
  contentRaid:SetJustifyV("TOP")
  contentRaid:SetPoint("TOPLEFT", content, "BOTTOMLEFT", 0, -100)

  local raidTable = {
    { E:TextGradient("Raids:", 0.6, 0.6, 0.6, 1, 0.77, 0.02), "LFR", "Normal", "Heroic", "Mythic" },
    { "1", "|cff56c680671|r", "|cff5a91c8684|r", "|cffab16e8697|r", "|cffff7f00710|r" },
    { "2", "|cff56c680671|r", "|cff5a91c8684|r", "|cffab16e8697|r", "|cffff7f00710|r" },
    { "3", "|cff56c680671|r", "|cff5a91c8684|r", "|cffab16e8697|r", "|cffff7f00710|r" },
    { "4", "|cff56c680675|r", "|cff5a91c8688|r", "|cffab16e8701|r", "|cffff7f00714|r" },
    { "5", "|cff56c680675|r", "|cff5a91c8688|r", "|cffab16e8701|r", "|cffff7f00714|r" },
    { "6", "|cff56c680675|r", "|cff5a91c8688|r", "|cffab16e8701|r", "|cffff7f00714|r" },
    { "7", "|cff56c680678|r", "|cff5a91c8691|r", "|cffab16e8704|r", "|cffff7f00717|r" },
    { "8", "|cff56c680678|r", "|cff5a91c8691|r", "|cffab16e8704|r", "|cffff7f00717|r" },
  }

  local contentDungeon = frame:CreateFontString(nil, "OVERLAY")
  contentDungeon:FontTemplate(nil, 14, "OUTLINE")
  contentDungeon:SetJustifyH("LEFT")
  contentDungeon:SetJustifyV("TOP")
  contentDungeon:SetPoint("TOPLEFT", contentRaid, "BOTTOMLEFT", 0, -170)

  local dungeonTable = {
    { E:TextGradient("Dungeons:", 0.6, 0.6, 0.6, 1, 0.77, 0.02), "+2", "+3", "+4", "+5", "+6"},
    { "Run", "|cff5a91c8684|r", "|cff5a91c8684|r", "|cff5a91c8688|r", "|cff5a91c8691|r", "|cffab16e8694|r"},
    { "Vault", "|cffab16e8694|r", "|cffab16e8694|r", "|cffab16e8697|r", "|cffab16e8697|r", "|cffab16e8701|r"},
    { "", "", "", "", "", "" },
    { " ", "+7", "+8", "+9", "+10", ""},
    { "Run", "|cffab16e8694|r", "|cffab16e8697|r", "|cffab16e8697|r", "|cffab16e8701|r", ""},
    { "Vault", "|cffab16e8704|r", "|cffab16e8704|r", "|cffab16e8704|r", "|cffff7f00707|r", ""},
  }

  local contentWorld = frame:CreateFontString(nil, "OVERLAY")
  contentWorld:FontTemplate(nil, 14, "OUTLINE")
  contentWorld:SetJustifyH("LEFT")
  contentWorld:SetJustifyV("TOP")
  contentWorld:SetPoint("TOPLEFT", contentDungeon, "BOTTOMLEFT", 0, -150)

  local worldTable = {
    { E:TextGradient("World:", 0.6, 0.6, 0.6, 1, 0.77, 0.02), "1", "2", "3", "4"},
    { "Run", "|cff999999655|r", "|cff999999658|r", "|cff999999662|r", "|cff999999665|r"},
    { "Vault", "|cff56c680668|r", "|cff56c680671|r", "|cff56c680675|r", "|cff56c680678|r"},
    { "", "", "", "", "" },
    { " ", "5", "6", "7", "8"},
    { "Run", "|cff56c680668|r", "|cff56c680671|r", "|cff5a91c8681|r", "|cff5a91c8684|r"},
    { "Vault", "|cff5a91c8681|r", "|cff5a91c8688|r", "|cff5a91c8691|r", "|cffab16e8694|r"},
  }

  CreateTable(frame, content, ilvlTable)
  CreateTable(frame, contentRaid, raidTable)
  CreateTable(frame, contentDungoen, dungeonTable)
  CreateTable(frame, contentWorld, worldTable)

  -- keep refs
  frame.content = content
  frame.contentRaid = contentRaid
  frame.contentDungoen = contentDungoen
  frame.contentWorld = contentWorld
end

S:AddCallbackForAddon('Blizzard_WeeklyRewards', GreatVaultInfo)