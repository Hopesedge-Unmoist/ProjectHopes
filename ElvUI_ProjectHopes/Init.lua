local E, _, V, P, G = unpack(ElvUI)
local Name, Private = ...

local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale)
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

E.private.ProjectHopes = E.private.ProjectHopes or {}
E.private.ProjectHopes.qualityOfLife = E.private.ProjectHopes.qualityOfLife or {}
E.private.ProjectHopes.qualityOfLife.automation = E.private.ProjectHopes.qualityOfLife.automation or {}
if E.private.ProjectHopes.qualityOfLife.automation.borederDarkmode then
    Private.Border = {bgFile = nil, edgeFile = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Borders\\HopesUI_Dark.tga", tileSize = 0, edgeSize = 16, insets = {left = 8, right = 8, top = 8, bottom = 8}}
    Private.Separator = {bgFile = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\HopesUI_Separator_Dark.tga", edgeFile = nil, tileSize = 0, edgeSize = 0, insets = {left = 0, right = 0, top = 0, bottom = 0}}
    Private.vSeparator = {bgFile = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\HopesUI_vSeparator_Dark.tga", edgeFile = nil, tileSize = 0, edgeSize = 0, insets = {left = 0, right = 0, top = 0, bottom = 0}} 
    Private.Circle = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\PortraitBorderMain_Dark.tga"
    Private.PortraitBorder = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\PortraitBorder(NoShadow)_Dark.tga"
else
    Private.Border = {bgFile = nil, edgeFile = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Borders\\HopesUI.tga", tileSize = 0, edgeSize = 16, insets = {left = 8, right = 8, top = 8, bottom = 8}}
    Private.Separator = {bgFile = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\HopesUI_Separator.tga", edgeFile = nil, tileSize = 0, edgeSize = 0, insets = {left = 0, right = 0, top = 0, bottom = 0}}
    Private.vSeparator = {bgFile = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\HopesUI_vSeparator.tga", edgeFile = nil, tileSize = 0, edgeSize = 0, insets = {left = 0, right = 0, top = 0, bottom = 0}}
    Private.Circle = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\PortraitBorderMain.tga"
    Private.PortraitBorder = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\PortraitBorder(NoShadow).tga"
end

Private.BorderLight = {bgFile = nil, edgeFile = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Borders\\HopesUI_Light.tga", tileSize = 0, edgeSize = 16, insets = {left = 8, right = 8, top = 8, bottom = 8}}
Private.BackgroundTexture = {bgFile = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\Square_White.tga", edgeFile = nil, tileSize = 0, edgeSize = 0, insets = {left = 0, right = 0, top = 0, bottom = 0}}
Private.Glowline = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\Glowline.tga"
Private.MinimapRectangle = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\Rectangle.tga"
Private.AbsorbOverlay = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\Shield-Overlay.blp"
Private.AbsorbGlow = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\Shield-Overshield.blp"
Private.AbsorbTexture = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\Shield-Fill.tga"
Private.Portrait = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\CircleMaskScalable.tga"
Private.PortraitBorderColor = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\PortraitBorder(Colorable).tga"
Private.Font = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Fonts\\Expressway.ttf"
Private.TargetGlow = {bgFile = nil, edgeFile = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Borders\\Targetglow.tga", tileSize = 0, edgeSize = 16, insets = {left = 8, right = 8, top = 8, bottom = 8}}
Private.CastbarGlow = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\CastbarGlow.tga"
Private.HopesUI = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Statusbar\\HopesUI.tga"

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