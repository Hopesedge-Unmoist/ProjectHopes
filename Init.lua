local E, _, V, P, G = unpack(ElvUI)
local Name, Private = ...

local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale)
local EP = LibStub('LibElvUIPlugin-1.0')
local PI = E:GetModule('PluginInstaller')

local AceAddon = _G.LibStub("AceAddon-3.0")

local tonumber = tonumber
local GetAddOnMetadata = (C_AddOns and C_AddOns.GetAddOnMetadata) or GetAddOnMetadata

ProjectHopes = E:NewModule(Name, 'AceConsole-3.0', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0')

Private.Config = {}
Private.Credits = {}
Private.Logo = 'Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\phlogotiny.tga'
Private.Name = E:TextGradient('ProjectHopes', 0.6, 0.6, 0.6, 1, 0.78, 0.03)
Private.Texture = 'HopesUI'
Private.RequiredElvUI = tonumber(GetAddOnMetadata(Name, 'X-Required-ElvUI'))
Private.Version = tonumber(GetAddOnMetadata(Name, 'Version'))

E.private.ProjectHopes = E.private.ProjectHopes or {}
E.private.ProjectHopes.qualityOfLife = E.private.ProjectHopes.qualityOfLife or {}
if E.private.ProjectHopes.qualityOfLife.borederDarkmode then
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
Private.TargetGlow = {bgFile = nil, edgeFile = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Borders\\BorderTex2.tga", tileSize = 0, edgeSize = 16, insets = {left = 8, right = 8, top = 8, bottom = 8}}
Private.CastbarGlow = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\CastbarGlow.tga"
Private.HopesUI = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Statusbar\\HopesUI.tga"
Private.ClassIcon = {
    DEATHKNIGHT = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\ClassIcons\\DEATHKNIGHT.tga",
    DEMONHUNTER = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\ClassIcons\\DEMONHUNTER.tga",
    DRUID = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\ClassIcons\\DRUID.tga",
    EVOKER = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\ClassIcons\\EVOKER.tga",
    HUNTER = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\ClassIcons\\HUNTER.tga",
    MAGE = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\ClassIcons\\MAGE.tga",
    MONK = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\ClassIcons\\MONK.tga",
    PALADIN = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\ClassIcons\\PALADIN.tga",
    PRIEST = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\ClassIcons\\PRIEST.tga",
    ROGUE = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\ClassIcons\\ROGUE.tga",
    SHAMAN = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\ClassIcons\\SHAMAN.tga",
    WARLOCK = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\ClassIcons\\WARLOCK.tga",
    WARRIOR = "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\ClassIcons\\WARRIOR.tga",
} 

----------------------------------------------------------------------
------------------------------- Events -------------------------------
----------------------------------------------------------------------

function ProjectHopes:PLAYER_ENTERING_WORLD(_, initLogin, isReload)
	if initLogin or isReload then
		ProjectHopes:VersionCheck()
    end
end

function ProjectHopes:RegisterEvents()
	ProjectHopes:RegisterEvent('PLAYER_ENTERING_WORLD')
end

local function Initialize()
    EP:RegisterPlugin(Name, ProjectHopes.Config)
	ProjectHopes:RegisterEvents()
end

local function CallbackInitialize()
	Initialize()
end

E:RegisterModule(Name, CallbackInitialize)