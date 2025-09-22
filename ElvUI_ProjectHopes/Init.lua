local Name, Private = ...

local E, _, V, P, G = unpack(ElvUI)
local EP = LibStub('LibElvUIPlugin-1.0')
local PI = E:GetModule('PluginInstaller')

local AceAddon = _G.LibStub("AceAddon-3.0")

local tonumber = tonumber
local GetAddOnMetadata = (C_AddOns and C_AddOns.GetAddOnMetadata) or GetAddOnMetadata

ProjectHopes = E:NewModule(Name, 'AceConsole-3.0', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0')
_G[Name] = Private

Private.Config = {}
Private.Credits = {}
Private.Logo = 'Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\ProjectHopes2025logo.tga'
Private.Name = E:TextGradient('ProjectHopes', 0.6, 0.6, 0.6, 1, 0.78, 0.03)
Private.Texture = 'HopesUI'
Private.RequiredElvUI = tonumber(GetAddOnMetadata(Name, 'X-Required-ElvUI'))
Private.Version = tonumber(GetAddOnMetadata(Name, 'Version'))
Private.Media = {}
Private.Portraits = {}

E.private.ProjectHopes = E.private.ProjectHopes or {}
E.private.ProjectHopes.qualityOfLife = E.private.ProjectHopes.qualityOfLife or {}
E.private.ProjectHopes.qualityOfLife.automation = E.private.ProjectHopes.qualityOfLife.automation or {}

local darkMode = E.private.ProjectHopes.qualityOfLife.automation.borederDarkmode
local suffix = darkMode and "_Dark" or ""
local noShadow = "(NoShadow)" .. suffix
local path = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\"

-- Border
Private.Border = {bgFile = nil, edgeFile = path .. "Borders\\HopesUI" .. suffix .. ".tga", tileSize = 0, edgeSize = 16, insets = { left = 8, right = 8, top = 8, bottom = 8 }}
Private.BorderLight = {bgFile = nil, edgeFile = path .. "Borders\\HopesUI_Light.tga", tileSize = 0, edgeSize = 16, insets = {left = 8, right = 8, top = 8, bottom = 8}}

-- Separators
Private.Separator = {bgFile = path .. "Textures\\HopesUI_Separator" .. suffix .. ".tga", edgeFile = nil, tileSize = 0, edgeSize = 0, insets = { left = 0, right = 0, top = 0, bottom = 0 }}
Private.vSeparator = {bgFile = path .. "Textures\\HopesUI_vSeparator" .. suffix .. ".tga", edgeFile = nil, tileSize = 0, edgeSize = 0, insets = { left = 0, right = 0, top = 0, bottom = 0 }}

-- Portraits
Private.Circle = path .. "Textures\\PortraitBorderMain" .. suffix .. ".tga"
Private.PortraitBorder = path .. "Textures\\PortraitBorder" .. noShadow .. ".tga"
Private.Portrait = path .. "Textures\\CircleMaskScalable.tga"
Private.PortraitBorderColor = path .. "Textures\\PortraitBorder(Colorable).tga"
Private.Portraits.Mask = path .. "Textures\\Portrait\\Portrait_Mask.tga"
Private.Portraits.Background = path .. "Textures\\Portrait\\Portrait_Background.tga" 
Private.Portraits.Border = path .. "Textures\\Portrait\\Portrait_Border" .. suffix .. ".tga"
Private.Portraits.BorderColor = path .. "Textures\\Portrait\\Portrait_BorderColor.tga" 

-- Shield Overlay
Private.AbsorbOverlay = path .. "Textures\\Shield-Overlay.blp"
Private.AbsorbGlow = path .. "Textures\\Shield-Overshield.tga"
Private.AbsorbTexture = path .. "Textures\\Shield-Fill.tga"

-- Glowline
Private.Glowline = path .. "Textures\\Glowline.tga"
Private.CastbarGlow = path .. "Textures\\CastbarGlow.tga"
Private.TargetGlow = {bgFile = nil, edgeFile = path .. "Borders\\Targetglow.tga", tileSize = 0, edgeSize = 16, insets = {left = 8, right = 8, top = 8, bottom = 8}}

-- Misc Textures
Private.BackgroundTexture = {bgFile = path .. "Textures\\Square_White.tga", edgeFile = nil, tileSize = 0, edgeSize = 0, insets = {left = 0, right = 0, top = 0, bottom = 0}}
Private.MinimapRectangle = path .. "Textures\\Rectangle.tga"
Private.Font = path .. "Fonts\\Expressway.ttf"
Private.HopesUI = path .. "Statusbar\\HopesUI.tga"

E.Media.Textures.RoleIcons = path .. "Textures\\RoleIcons.tga" -- White Role Icons. 

----------------------------------------------------------------------
------------------------------- Events -------------------------------
----------------------------------------------------------------------
function ProjectHopes:ParseVersionString()
	local version = GetAddOnMetadata(Name, 'Version')
	local prevVersion = GetAddOnMetadata(Name, 'X-PreviousVersion')
	if strfind(version, 'project%-version') then
		return prevVersion, prevVersion..'-git', nil, true
	else
		local release, extra = strmatch(version, '^v?([%d.]+)(.*)')
		return tonumber(release), release..extra, extra ~= ''
	end
end

ProjectHopes.version, ProjectHopes.versionString = ProjectHopes:ParseVersionString()

local function Initialize()
    EP:RegisterPlugin(Name, ProjectHopes.Config)
    ProjectHopes:RegisterEvents()
    
    if not ProjectHopesDB then
        _G.ProjectHopesDB = {}
    end
end

local function CallbackInitialize()
	Initialize()
end

E:RegisterModule(Name, CallbackInitialize)