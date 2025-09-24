local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded

local format = string.format
local type = type
local pairs = pairs
local _G = _G

local properties = {
  elvuifonts = {
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
  },

  fctfonts = {
    font = true, 
    critFont = true,
  },

  weakaurafonts = {
    text_font = true,
    textFont = true,
    globalTextFont = true,
    font = true,
  },
  
  elvuioutlines = {
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
  },

  fctoutlines = {
    fontOutline = true, 
    critFontOutline = true,
  },
  
  weakauraoutlines = {
    outline = true, 
    text_fontType = true,
  },

  elvuistatusbars = {
    statusbar = true, 
    statusBarTexture = true, 
    statusBar = true, 
    glossTex = true, 
    normTex = true, 
    barTexture = true,
    texture = true,
  },

  weakaurastatusbars = {
    texture = true,
  },
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

-- ElvUI specific settings
local function applyElvUISetting(settingType, value)
  local propTable = properties["elvui" .. settingType]
  if not propTable then return end

  setRecursive(E.db, value, propTable)
  setRecursive(E.private, value, propTable)  
  setRecursive(E.global, value, propTable)

  E:StaggeredUpdateAll()
  
  Private:Print(format("|cff00ff00%s|r %s", value, L["has been set to all %s Options within |cff1784d1ElvUI|r."]:format(settingType:sub(1,1):upper() .. settingType:sub(2))))
end

-- WeakAuras specific settings
local function applyWeakAurasSetting(settingType, value)
  local propTable = properties["weakaura" .. settingType]
  if not propTable or not IsAddOnLoaded("WeakAuras") or not _G.WeakAurasSaved then 
    return 
  end

  setRecursive(_G.WeakAurasSaved, value, propTable)
  
  Private:Print(format("|cff00ff00%s|r %s", value, L["has been set to all %s Options within |cffFFD100WeakAuras|r."]:format(settingType:sub(1,1):upper() .. settingType:sub(2))))
end

-- FCT specific settings
local function applyFCTSetting(settingType, value)
  local propTable = properties["fct" .. settingType]
  if not propTable or not IsAddOnLoaded("ElvUI_FCT") or not _G.ElvFCT then 
    return 
  end

  setRecursive(_G.ElvFCT, value, propTable)
  
  Private:Print(format("|cff00ff00%s|r %s", value, L["has been set to all %s Options within |cFFdd2244Floating Combat Text|r."]:format(settingType:sub(1,1):upper() .. settingType:sub(2))))
end

-- Combined function that applies to all addons
local function applySetting(settingType, value)
  applyElvUISetting(settingType, value)
  applyWeakAurasSetting(settingType, value)
  applyFCTSetting(settingType, value)
end

-- ElvUI functions
function ProjectHopes:SetElvUIFonts(fontValue)
  applyElvUISetting("fonts", fontValue)
end

function ProjectHopes:SetElvUIOutlines(outlineValue)
  applyElvUISetting("outlines", outlineValue)
end

function ProjectHopes:SetElvUIStatusbars(statusbarValue)
  applyElvUISetting("statusbars", statusbarValue)
end

-- FCT functions
function ProjectHopes:SetFCTFonts(fontValue)
  applyFCTSetting("fonts", fontValue)
end

function ProjectHopes:SetFCTOutlines(outlineValue)
  applyFCTSetting("outlines", outlineValue)
end

function ProjectHopes:SetFCTStatusbars(statusbarValue)
  applyFCTSetting("statusbars", statusbarValue)
end

-- Weakaura functions
function ProjectHopes:SetWeakAurasFonts(fontValue)
  applyWeakAurasSetting("fonts", fontValue)
end

function ProjectHopes:SetWeakAurasOutlines(outlineValue)
  applyWeakAurasSetting("outlines", outlineValue)
end

function ProjectHopes:SetWeakAurasStatusbars(statusbarValue)
  applyWeakAurasSetting("statusbars", statusbarValue)
end

