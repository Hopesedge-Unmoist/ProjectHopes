local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded

local format = string.format
local type = type
local pairs = pairs
local _G = _G

local properties = {
  fonts = {
    font = true, 
    countFont = true, 
    timeFont = true, 
    hotkeyFont = true, 
    macroFont = true, 
    nameFont = true, 
    tabFont = true, 
    headerFont = true,
    itemLevelFont = true, 
    locationFont = true, 
    critFont = true,
  },
  
  outlines = {
    fontOutline = true, 
    locationFontOutline = true, 
    fontStyle = true, 
    itemInfoFontOutline = true, 
    itemLevelFontOutline = true, 
    tabFontOutline = true, 
    headerFontOutline = true, 
    countFontOutline = true, 
    hotkeyFontOutline = true, 
    macroFontOutline = true, 
    timeFontOutline = true, 
    nameplateFontOutline = true, 
    nameplateLargeFontOutline = true, 
    outline = true,   
    totalLevelFontOutline = true, 
    critFontOutline = true,
  },
  
  statusbars = {
    statusbar = true, 
    statusBarTexture = true, 
    statusBar = true, 
    glossTex = true, 
    normTex = true, 
    barTexture = true,
  }
}

local function setRecursive(tbl, value, props)
  for key, v in pairs(tbl) do
    if props[key] then
      tbl[key] = value
    elseif type(v) == "table" then
      setRecursive(v, value, props)
    end  
  end
end

local function applySetting(settingType, value)
  local propTable = properties[settingType]
  if not propTable then return end

  setRecursive(E.db, value, propTable)
  setRecursive(E.private, value, propTable)  
  setRecursive(E.global, value, propTable)

  if IsAddOnLoaded("ElvUI_FCT") and _G.ElvFCT then
    setRecursive(_G.ElvFCT, value, propTable)
  end

  E:StaggeredUpdateAll()

  Private:Print(format("|cff00ff00%s|r %s", value, L["has been set to all %s Options within |cff1784d1ElvUI|r."]:format(settingType:sub(1,1):upper() .. settingType:sub(2))))
end

function ProjectHopes:SetAllFonts(fontValue)
  applySetting("fonts", fontValue)
end

function ProjectHopes:SetAllOutlines(outlineValue)
  applySetting("outlines", outlineValue)
end

function ProjectHopes:SetAllStatusbars(statusbarValue)
  applySetting("statusbars", statusbarValue)
end
