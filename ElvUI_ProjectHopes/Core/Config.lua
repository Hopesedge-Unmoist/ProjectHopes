local Name, Private = ...
local E, _, V, P, G = unpack(ElvUI)
local D = E:GetModule('Distributor');
local PI = E:GetModule('PluginInstaller');
local PORTRAIT = E:GetModule('Portrait', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0');

local LSM = E.Libs.LSM

local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale)
local pairs, sort = pairs, sort
local format, tostring = format, tostring
local tconcat, tinsert = table.concat, table.insert
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded

local MiniMapButtonSelect = {NOANCHOR = 'No Anchor Bar', HORIZONTAL = 'Horizontal', VERTICAL = 'Vertical'}
local MiniMapButtonDirection = {NORMAL = 'Normal', REVERSED = 'Reversed'}
local PORTRAITANCHORPOINT = {
    center      = "Center",
    left        = "Left",
    right       = "Right",
    top         = "Top",
    bottom      = "Bottom",
    topleft     = "Top Left",
    topright    = "Top Right",
    bottomleft  = "Bottom Left",
    bottomright = "Bottom Right",
}

local PORTRAITFRAMESTRATA = {
    BACKGROUND = "BACKGROUND",
    LOW        = "LOW",
    MEDIUM     = "MEDIUM",
    HIGH       = "HIGH",
    DIALOG     = "DIALOG",
    TOOLTIP    = "TOOLTIP",
}

local SPECIALTHANKS = { 
	'|cffffc607Ayije|r', 
	'|cff14b4d3Jiberish|r', 
	E:TextGradient('Angelos', 0.7, 0.3, 1, 1, 0.9, 0.2), 
	'|cff2ab6ffHoffa|r'
}

local PLUGINSUPPORT = { 
	'|cffa207faRepooc|r, Changelog code and minimap coding help.',
	E:TextGradient('Simpy but my name needs to be longer.', 0.18,1.00,0.49, 0.32,0.85,1.00, 0.55,0.38,0.85, 1.00,0.55,0.71, 1.00,0.68,0.32), 
	'|cff919191Azilroka|r, Orignal author of Minimap Buttons, all credits go to him.', 
	'|cffd1ce96Flamanis|r', 
	'|cff919191Toxi|r', 
	'|cff919191fang2shou|r',
	'|CFF00A3FFB|r|CFF00B4FFl|r|CFF00C6FFi|r|CFF00D8FFn|r|CFF00EAFFk|r|CFF00F6FFi|r|CFF00F6FFi|r, Thanks for helping with Portrait, and thanks for the Statusbar Texture.',
	'|cffdb171eTrenchy|r',
	E:TextGradient("Eltruism", 0.50, 0.70, 1, 0.67, 0.95, 1) .. ', Thanks for helping with coding.',
	'|cff919191Tevoll|r, Minimap Buttons.',
	'|cff3dff98Kringels|r, Help with coding Tags.',
}


local function SortList(a, b)
	return E:StripString(a) < E:StripString(b)
end

sort(PLUGINSUPPORT, SortList)
sort(SPECIALTHANKS, SortList)

for _, name in pairs(PLUGINSUPPORT) do
	tinsert(Private.Credits, name)
end
Private.PLUGINSUPPORT_STRING = tconcat(PLUGINSUPPORT, '|n')

for _, name in pairs(SPECIALTHANKS) do
	tinsert(Private.Credits, name)
end
Private.SPECIALTHANKS_STRING = tconcat(SPECIALTHANKS, '|n')

function ProjectHopes:Config()
	E.Options.name = format('%s + %s |cff99ff33%.2f|r', E.Options.name, Private.Name, Private.Version)

	-- LibAceConfigHelper
	local ACH = E.Libs.ACH
	ProjectHopes.Options = ACH:Group("|TInterface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\ProjectHopes2025logo.tga:14:14:0:0|t" .. Private.Name, nil, 20)

	local POA = ProjectHopes.Options.args

	-- Header
	POA.logo = ACH:Description(nil, 1, nil, 'Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\ProjectHopes2025 with banner.tga', nil, 256, 256)

	-- Spacer
	POA.header = ACH:Spacer(2, 'full')

	-- information
	POA.information = ACH:Group(E:TextGradient(L["Information"], 0.6, 0.6, 0.6, 0.63, 0.62, 0.58), nil, 1)
	
	POA.information.args.header = ACH:Header(L["Information"], 1)
	POA.information.args.spacer = ACH:Spacer(2, 'full')

	POA.information.args.contact = ACH:Group(L["Message From the Author"], nil, 1)
	POA.information.args.contact.inline = true
	POA.information.args.contact.args.description = ACH:Description(format("%s\n%s\n%s", format(L["Thank you for using %s!"], Private.Name), format(L["You can send your suggestions or bugs via %s suggestions or help channel."], "|cff5865f2" .. L["Discord"] .. "|r"), format(L["If you want access to my Weakauras and Profiles then subscribe to my %s."], "|cfff96d5a" .. L["Patreon"] .. "|r")), 1, "medium")
	POA.information.args.contact.args.discord = ACH:Execute(format('|cff5865f2%s|r', L["Discord"]), nil, 4, function() E:StaticPopup_Show("ProjectHopes_EDITBOX", nil, nil, "https://discord.gg/nZAWgKyjCB") end, 'Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\discordlogo', nil, 0.7)
	POA.information.args.contact.args.patreon = ACH:Execute(format('|cfff96d5a%s|r', L["Patreon"]), nil, 5, function() E:StaticPopup_Show("ProjectHopes_EDITBOX", nil, nil, "https://www.patreon.com/HopesUI") end, 'Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\patreonlogo', nil, 0.7)

	POA.information.args.supporter = ACH:Group(L["Special Thanks"], nil, 2)
	POA.information.args.supporter.inline = true
	POA.information.args.supporter.args.desc = ACH:Description(Private.SPECIALTHANKS_STRING, 1, 'medium')
	POA.information.args.pluginsupport = ACH:Group(L["Plugin and Module Support"], nil, 3)
	POA.information.args.pluginsupport.inline = true
	POA.information.args.pluginsupport.args.desc = ACH:Description(Private.PLUGINSUPPORT_STRING, 1, 'medium')

	--line break so these non options are not with the others
	POA.linebreak3 = ACH:Group(" ", nil, 2)
	POA.linebreak3.disabled = true

	-- Modules
	POA.Modules1 = ACH:Group(L["Modules"], nil, 2)
	POA.Modules1.disabled = true

	POA.Minimap = ACH:Group(E:TextGradient(L["Minimap"], 0.6, 0.6, 0.6, 0.607843137254902, 1, 0.4274509803921569), nil, 3, 'tab')
	local POAMA = POA.Minimap.args
	-- Rectangle Minimap
	POAMA.minimap = ACH:Group(L["Rectangle Minimap"], nil, 1)
	POAMA.minimap.args.desc = ACH:Group(L["Description"], nil, 1)
	POAMA.minimap.args.desc.inline = true
	POAMA.minimap.args.desc.args.feature = ACH:Description(L["Makes the Minimap Rectangle."], 1, "medium")
	POAMA.minimap.args.minimapret = ACH:Toggle(L["Enable"], L["Toggle Rectangle Minimap."], 2, nil, false, nil,function() return E.db.ProjectHopes.minimap.Rectangle end,function(_, value) E.db.ProjectHopes.minimap.Rectangle = value E:StaticPopup_Show('ProjectHopes_RL') end)
	-- Minimap Buttons
	POAMA.minimapbutton = ACH:Group(L["Minimap Buttons"], nil, 2, nil, function(info) return E.db.ProjectHopes.minimapbutton[ info[#info] ] end, function(info, value) E.db.ProjectHopes.minimapbutton[ info[#info] ] = value; MB:UpdateLayout() end)
	POAMA.minimapbutton.args.desc = ACH:Group(L["Description"], nil, 1)
	POAMA.minimapbutton.args.desc.inline = true
	POAMA.minimapbutton.args.desc.args.feature = ACH:Description(L["Add an extra bar to collect minimap buttons."], 1, "medium")
	POAMA.minimapbutton.args.enable = ACH:Toggle(L["Enable"], L["Toggle minimap buttons bar"], 2, nil, false, nil, nil, function(info, value) E.db.ProjectHopes.minimapbutton.enable = value; E:StaticPopup_Show("ProjectHopes_RL") end)
	POAMA.minimapbutton.args.skinStyle = ACH:Select(L["Skin Style"], L["Change settings for how the minimap buttons are skinned"], 2, MiniMapButtonSelect, false, nil, nil, function(info, value) E.db.ProjectHopes.minimapbutton[ info[#info] ] = value; MB:UpdateSkinStyle() end, function() return not E.db.ProjectHopes.minimapbutton.enable end)
	POAMA.minimapbutton.args.layoutDirection = ACH:Select(L['Layout Direction'], L['Normal is right to left or top to bottom, or select reversed to switch directions.'], 3, MiniMapButtonDirection, false, nil, nil, nil, nil, function() return not E.db.ProjectHopes.minimapbutton.enable or E.db.ProjectHopes.minimapbutton.skinstyle == 'NOANCHOR' end)
	POAMA.minimapbutton.args.buttonSize = ACH:Range(L['Button Size'], L['The size of the minimap buttons.'], 4, { min = 16, max = 40, step = 1 }, nil, nil, nil, function() return not E.db.ProjectHopes.minimapbutton.enable or E.db.ProjectHopes.minimapbutton.skinstyle == 'NOANCHOR' end)
	POAMA.minimapbutton.args.buttonsPerRow = ACH:Range(L['Buttons per row'], L['The max number of buttons when a new row starts'], 5, { min = 4, max = 20, step = 1 }, nil, nil, nil, function() return not E.db.ProjectHopes.minimapbutton.enable or E.db.ProjectHopes.minimapbutton.skinstyle == 'NOANCHOR' end)
	POAMA.minimapbutton.args.backdrop = ACH:Toggle(L['Backdrop'], nil, 6, nil, false, nil, nil, nil, function() return not E.db.ProjectHopes.minimapbutton.enable or E.db.ProjectHopes.minimapbutton.skinstyle == 'NOANCHOR' end)
	POAMA.minimapbutton.args.border = ACH:Toggle(L['Border for Icons'], nil, 7, nil, false, nil, nil, nil, function() return not E.db.ProjectHopes.minimapbutton.enable end)
	POAMA.minimapbutton.args.mouseover = ACH:Toggle(L['Mouse Over'], L['The frame is not shown unless you mouse over the frame.'], 7, nil, false, nil, nil, function(info, value) E.db.ProjectHopes.minimapbutton.mouseover = value; MB:ChangeMouseOverSetting() end, function() return not E.db.ProjectHopes.minimapbutton.enable or E.db.ProjectHopes.minimapbutton.skinstyle == 'NOANCHOR' end)

	-- Minimap Instance Difficulty
	POAMA.minimapid = ACH:Group(L["Minimap Instance Difficulty"], nil, 3)
	POAMA.minimapid.args.desc = ACH:Group(L["Description"], nil, 1)
	POAMA.minimapid.args.desc.inline = true
	POAMA.minimapid.args.desc.args.feature = ACH:Description(L["Add Instance Difficulty in text format."], 1, "medium")
	POAMA.minimapid.args.enable = ACH:Toggle(L["Enable"], nil, 1, nil, nil, nil, function() return E.db.ProjectHopes.minimapid.enable end, function(_, value) E.db.ProjectHopes.minimapid.enable = value E:StaticPopup_Show("ProjectHopes_RL") end)
	POAMA.minimapid.args.options = ACH:Group(L["Options"], nil, 3, nil, nil, nil, nil, function() return not E.db.ProjectHopes.minimapid.enable end)
	POAMA.minimapid.args.options.inline = true
	POAMA.minimapid.args.options.args.hideBlizzard = ACH:Toggle(L["Hide Blizzard Indicator"], "|cFFFF0000" .. L["Requires a UI Reload"] .. "|r", 2, nil, nil, nil, function() return E.db.ProjectHopes.minimapid.hideBlizzard end, function(_, value) E.db.ProjectHopes.minimapid.hideBlizzard = value E:StaticPopup_Show("ProjectHopes_RL") end)
	POAMA.minimapid.args.options.args.font = ACH:SharedMediaFont(L["Font"], nil, 3, nil, function() return E.db.ProjectHopes.minimapid.font.name end, function(_, value) E.db.ProjectHopes.minimapid.font.name = value ID:UpdateDifficultyText(value, E.db.ProjectHopes.minimapid.font.style, E.db.ProjectHopes.minimapid.font.size, E.db.ProjectHopes.minimapid.align) end)
	POAMA.minimapid.args.options.args.style = ACH:FontFlags(L["Outline"], nil, 4, nil, function() return E.db.ProjectHopes.minimapid.font.style end, function(_, value) E.db.ProjectHopes.minimapid.font.style = value ID:UpdateDifficultyText(E.db.ProjectHopes.minimapid.font.name, value, E.db.ProjectHopes.minimapid.font.size, E.db.ProjectHopes.minimapid.align) end)
	POAMA.minimapid.args.options.args.size = ACH:Range(L["Size"], nil, 5, { min = 5, max = 60, step = 1 }, nil, function() return E.db.ProjectHopes.minimapid.font.size end, function(_, value) E.db.ProjectHopes.minimapid.font.size = value ID:UpdateDifficultyText(E.db.ProjectHopes.minimapid.font.name, E.db.ProjectHopes.minimapid.font.style, value, E.db.ProjectHopes.minimapid.align) end)
	POAMA.minimapid.args.options.args.align = ACH:Select(L["Text Align"], nil, 6, TEXTALIGNMENT, nil, "medium", function() return E.db.ProjectHopes.minimapid.align or "LEFT" end, function(_, value) E.db.ProjectHopes.minimapid.align = value ID:UpdateDifficultyText(E.db.ProjectHopes.minimapid.font.name, E.db.ProjectHopes.minimapid.font.style, E.db.ProjectHopes.minimapid.font.size, value)	end)

	POA.Unitframes = ACH:Group(E:TextGradient(L["UnitFrames"], 0.6, 0.6, 0.6, 0.34, 1, 0.67), nil, 3, 'tab')
	local POAUFA = POA.Unitframes.args
	POAUFA.overshield = ACH:Group(L["Overshield"], nil, 1, nil, nil, nil, nil, function() return not E.Retail end)
	POAUFA.overshield.args.desc = ACH:Group(L["Description"], nil, 1)
	POAUFA.overshield.args.desc.inline = true
	POAUFA.overshield.args.desc.args.feature = ACH:Description(L["Add a texture to Over Absorb with a Glowline at the end."], 1, "medium")
	POAUFA.overshield.args.absorb = ACH:Toggle(L["Enable"], L["Toggle Overshield textures."], 2, nil, false, nil,function() return E.db.ProjectHopes.overshield.Absorb end, function(_, value) E.db.ProjectHopes.overshield.Absorb = value E:StaticPopup_Show('ProjectHopes_RL') end)
	
	POAUFA.customtargetborder = ACH:Group(L["Target Border"], nil, 1)
	POAUFA.customtargetborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POAUFA.customtargetborder.args.desc.inline = true
	POAUFA.customtargetborder.args.desc.args.feature = ACH:Description(L["Makes the Target Border a Solid frame and bring it in front of Unitframes."], 1, "medium")
	POAUFA.customtargetborder.args.enable = ACH:Toggle(L["Enable"], L['Toggle the Target Border frame. (Target Frame Glow MUST be enabled.)'], 2, nil, false, nil, function() return E.db.ProjectHopes.targetGlow.foreground end,function(_, value) E.db.ProjectHopes.targetGlow.foreground = value E:StaticPopup_Show('ProjectHopes_RL') end)
	
	POAUFA.cbackdrop = ACH:Group(L["Health Backdrop"], nil, 1)
	POAUFA.cbackdrop.args.desc = ACH:Group(L["Description"], nil, 1)
	POAUFA.cbackdrop.args.desc.inline = true
	POAUFA.cbackdrop.args.desc.args.feature = ACH:Description(L["Changes the health backdrop texture."], 1, "medium")
	POAUFA.cbackdrop.args.custom = ACH:Toggle(L["Enable"], nil, 3, nil, false, nil,function() return E.db.ProjectHopes.cbackdrop.Backdrop end,function(_, value) E.db.ProjectHopes.cbackdrop.Backdrop = value E:StaticPopup_Show('ProjectHopes_RL'); ProjectHopes:CustomHealthBackdrop() end)
	POAUFA.cbackdrop.args.customtexture = ACH:SharedMediaStatusbar(L["Backdrop Texture"], L["Select a Texture"], 4, nil, function() return E.db.ProjectHopes.cbackdrop.customtexture end, function(_,key) E.db.ProjectHopes.cbackdrop.customtexture = key E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.ProjectHopes.cbackdrop.Backdrop end)

	POAUFA.glowline = ACH:Group(L["Health Glowline"], nil, 1)
	POAUFA.glowline.args.desc = ACH:Group(L["Description"], nil, 1)
	POAUFA.glowline.args.desc.inline = true
	POAUFA.glowline.args.desc.args.feature = ACH:Description(L["Adds a Glowline to all healthbars on unitframes."], 1, "medium")
	POAUFA.glowline.args.enable = ACH:Toggle(L["Health Glowline"], nil, 1, nil, false, nil, function() return E.db.ProjectHopes.unitframe.unitFramesGlowline end,function(_, value) E.db.ProjectHopes.unitframe.unitFramesGlowline = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POAUFA.glowline.args.color = ACH:Color(L["Enter Color"], nil, 2, true, nil, function() local db = E.db.ProjectHopes.unitframe.unitFramesGlowlinecolor local default = P.ProjectHopes.unitframe.unitFramesGlowlinecolor return db.r, db.g, db.b, db.a, default.r, default.g, default.b, default.a end, function(_, r, g, b, a) local db = E.db.ProjectHopes.unitframe.unitFramesGlowlinecolor db.r, db.g, db.b, db.a = r, g, b, a E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.ProjectHopes.unitframe.unitFramesGlowline end, function() return not E.db.ProjectHopes.unitframe.unitFramesGlowline end)
	POAUFA.glowline.args.width = ACH:Range(L["Width"], nil, 3, { min = -20, max = 20, step = 1 }, nil, function() return E.db.ProjectHopes.unitframe.unitFramesGlowlineWidth end, function(_, value) E.db.ProjectHopes.unitframe.unitFramesGlowlineWidth = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.ProjectHopes.unitframe.unitFramesGlowline end, function() return not E.db.ProjectHopes.unitframe.unitFramesGlowline end)

	POA.Portaits = ACH:Group(E:TextGradient(L["Portraits"], 0.6, 0.6, 0.6, 0.34, 1, 0.67), nil, 3, 'tab')
	local POAPOR = POA.Portaits.args
	POAPOR.player = ACH:Group(L["Player"], nil, 1, 'tab', nil, nil, nil, function() return not E.db.unitframe.units.player.enable end)
	POAPOR.player.args.playerpor = ACH:Toggle(L["Enable"], nil, 1, nil, false, "full", function() return E.db.ProjectHopes.portraits.playerpor end, function(_, value) E.db.ProjectHopes.portraits.playerpor = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.player.enable end)
	POAPOR.player.args.Options = ACH:Group(L["Misc"], nil, 2, nil, nil, nil, nil, function() return not E.db.ProjectHopes.portraits.playerpor end)
	POAPOR.player.args.Options.inline = true
	POAPOR.player.args.Options.args.playerBorderColor = ACH:Toggle(L["Border Color"], nil, 2, nil, false, "full", function() return E.db.ProjectHopes.portraits.playerBorderColor end, function(_, value) E.db.ProjectHopes.portraits.playerBorderColor = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POAPOR.player.args.Options.args.playerMirror = ACH:Toggle(L["Mirror Portrait"], nil, 3, nil, false, "full", function() return E.db.ProjectHopes.portraits.playerMirror end, function(_, value) E.db.ProjectHopes.portraits.playerMirror = value PORTRAIT:UpdatePortrait("player", E.db.ProjectHopes.portraits.playerClassBackdropColor, E.db.ProjectHopes.portraits.playerClass, value, E.db.ProjectHopes.portraits.playerClassTexture) end)
	POAPOR.player.args.Options.args.playerClass = ACH:Toggle(L["Class Portrait"], nil, 4, nil, false, "full", function() return E.db.ProjectHopes.portraits.playerClass end, function(_, value) E.db.ProjectHopes.portraits.playerClass = value PORTRAIT:UpdatePortrait("player", E.db.ProjectHopes.portraits.playerClassBackdropColor, value, E.db.ProjectHopes.portraits.playerMirror, E.db.ProjectHopes.portraits.playerClassTexture) end)
	POAPOR.player.args.Options.args.playerClassTexture = ACH:Select(L["Class Texture"], nil, 6, (function() local t={} for k,v in pairs(Private.Media.Class) do t[k]=v.name or k end return t end)(), nil, "medium", function() return E.db.ProjectHopes.portraits.playerClassTexture end, function(_, value) E.db.ProjectHopes.portraits.playerClassTexture = value PORTRAIT:UpdatePortrait("player", E.db.ProjectHopes.portraits.playerClassBackdropColor, E.db.ProjectHopes.portraits.playerClass, E.db.ProjectHopes.portraits.playerMirror, value) end, nil, function() return not E.db.ProjectHopes.portraits.playerClass end)
	POAPOR.player.args.Options.args.playerClassBackdropColor = ACH:Color(L["Backdrop Color"], L["Choose a color for the portrait background"], 7, true, nil, function() local c = E.db.ProjectHopes.portraits.playerClassBackdropColor or { r=1, g=1, b=1, a=1 } return c.r, c.g, c.b, c.a end, function(_, r, g, b, a) E.db.ProjectHopes.portraits.playerClassBackdropColor = { r=r, g=g, b=b, a=a } PORTRAIT:UpdatePortrait("player", E.db.ProjectHopes.portraits.playerClassBackdropColor, E.db.ProjectHopes.portraits.playerClass, E.db.ProjectHopes.portraits.playerMirror, E.db.ProjectHopes.portraits.playerClassTexture) end, nil, function() local style = E.db.ProjectHopes.portraits.playerClassTexture or "hd" local media = Private.Media.Class[style] return not(media and media.transparent) or not E.db.ProjectHopes.portraits.playerClass end)
	POAPOR.player.args.Position = ACH:Group(L["Position"], nil, 3, nil, nil, nil, nil, function() return not E.db.ProjectHopes.portraits.playerpor end)
	POAPOR.player.args.Position.inline = true
	POAPOR.player.args.Position.args.playerframelevel = ACH:Range(L["Framelevel"], nil, 5, { min = -100, max = 100, step = 1 }, "medium", function() return E.db.ProjectHopes.portraits.playerframelevel end, function(_, value) E.db.ProjectHopes.portraits.playerframelevel = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POAPOR.player.args.Position.args.playerSize = ACH:Range(L["Size of Portrait:"], nil, 5, { min = 0, max = 200, step = 1 }, "medium", function() return E.db.ProjectHopes.portraits.playerSize end, function(_, value) E.db.ProjectHopes.portraits.playerSize = value PORTRAIT:UpdateSize("player", E.db.ProjectHopes.portraits.playerSize, E.db.ProjectHopes.portraits.playerClass) end)
	POAPOR.player.args.Position.args.playerPosition = ACH:Select(L["Position"], nil, 7, PORTRAITANCHORPOINT, nil, "medium", function() return E.db.ProjectHopes.portraits.playerPosition or "center" end, function(_, value) E.db.ProjectHopes.portraits.playerPosition = value PORTRAIT:UpdatePortrait("player",E.db.ProjectHopes.portraits.playerClassBackdropColor,E.db.ProjectHopes.portraits.playerClass,E.db.ProjectHopes.portraits.playerMirror,E.db.ProjectHopes.portraits.playerClassTexture,E.db.ProjectHopes.portraits.playerBorderColor) PORTRAIT:UpdatePosition("player",value,E.db.ProjectHopes.portraits.playerOffsetX or 0,E.db.ProjectHopes.portraits.playerOffsetY or 0) end)
	POAPOR.player.args.Position.args.playerOffsetX = ACH:Range(L["X Offset (Left/Right)"], nil, 8, {min=-200,max=200,step=1}, nil, function() return E.db.ProjectHopes.portraits.playerOffsetX or 0 end, function(_, value) E.db.ProjectHopes.portraits.playerOffsetX = value PORTRAIT:UpdatePosition("player",E.db.ProjectHopes.portraits.playerPosition or "center",value,E.db.ProjectHopes.portraits.playerOffsetY or 0, E.db.ProjectHopes.portraits.playerStrata) end)
	POAPOR.player.args.Position.args.playerOffsetY = ACH:Range(L["Y Offset (Down/Up)"], nil, 9, {min=-200,max=200,step=1}, nil, function() return E.db.ProjectHopes.portraits.playerOffsetY or 0 end, function(_, value) E.db.ProjectHopes.portraits.playerOffsetY = value PORTRAIT:UpdatePosition("player",E.db.ProjectHopes.portraits.playerPosition or "center",E.db.ProjectHopes.portraits.playerOffsetX or 0,value, E.db.ProjectHopes.portraits.playerStrata) end)
	POAPOR.player.args.Position.args.playerStrata = ACH:Select(L["Frame Strata"], nil, 10, PORTRAITFRAMESTRATA, nil, nil, function() return E.db.ProjectHopes.portraits.playerStrata or "MEDIUM" end, function(_, value) E.db.ProjectHopes.portraits.playerStrata = value PORTRAIT:UpdatePosition("player", E.db.ProjectHopes.portraits.playerPosition or "center", E.db.ProjectHopes.portraits.playerOffsetX or 0, E.db.ProjectHopes.portraits.playerOffsetY or 0, value) end)

	POAPOR.target = ACH:Group(L["Target"], nil, 1, 'tab', nil, nil, nil, function() return not E.db.unitframe.units.target.enable end)
	POAPOR.target.args.targetpor = ACH:Toggle(L["Enable"], nil, 1, nil, false, "full", function() return E.db.ProjectHopes.portraits.targetpor end, function(_, value) E.db.ProjectHopes.portraits.targetpor = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.target.enable end)
	POAPOR.target.args.Options = ACH:Group(L["Misc"], nil, 2, nil, nil, nil, nil, function() return not E.db.ProjectHopes.portraits.targetpor end)
	POAPOR.target.args.Options.inline = true
	POAPOR.target.args.Options.args.targetBorderColor = ACH:Toggle(L["Border Color"], nil, 2, nil, false, "full", function() return E.db.ProjectHopes.portraits.targetBorderColor end, function(_, value) E.db.ProjectHopes.portraits.targetBorderColor = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POAPOR.target.args.Options.args.targetMirror = ACH:Toggle(L["Mirror Portrait"], nil, 3, nil, false, "full", function() return E.db.ProjectHopes.portraits.targetMirror end, function(_, value) E.db.ProjectHopes.portraits.targetMirror = value PORTRAIT:UpdatePortrait("target", E.db.ProjectHopes.portraits.targetClassBackdropColor, E.db.ProjectHopes.portraits.targetClass, value, E.db.ProjectHopes.portraits.targetClassTexture) end)
	POAPOR.target.args.Options.args.targetClass = ACH:Toggle(L["Class Portrait"], nil, 4, nil, false, "full", function() return E.db.ProjectHopes.portraits.targetClass end, function(_, value) E.db.ProjectHopes.portraits.targetClass = value PORTRAIT:UpdatePortrait("target", E.db.ProjectHopes.portraits.targetClassBackdropColor, value, E.db.ProjectHopes.portraits.targetMirror, E.db.ProjectHopes.portraits.targetClassTexture) end)
	POAPOR.target.args.Options.args.targetClassTexture = ACH:Select(L["Class Texture"], nil, 6, (function() local t={} for k,v in pairs(Private.Media.Class) do t[k]=v.name or k end return t end)(), nil, "medium", function() return E.db.ProjectHopes.portraits.targetClassTexture end, function(_, value) E.db.ProjectHopes.portraits.targetClassTexture = value PORTRAIT:UpdatePortrait("target", E.db.ProjectHopes.portraits.targetClassBackdropColor, E.db.ProjectHopes.portraits.targetClass, E.db.ProjectHopes.portraits.targetMirror, value) end, nil, function() return not E.db.ProjectHopes.portraits.targetClass end)
	POAPOR.target.args.Options.args.targetClassBackdropColor = ACH:Color(L["Backdrop Color"], L["Choose a color for the portrait background"], 7, true, nil, function() local c = E.db.ProjectHopes.portraits.targetClassBackdropColor or { r=1, g=1, b=1, a=1 } return c.r, c.g, c.b, c.a end, function(_, r, g, b, a) E.db.ProjectHopes.portraits.targetClassBackdropColor = { r=r, g=g, b=b, a=a } PORTRAIT:UpdatePortrait("target", E.db.ProjectHopes.portraits.targetClassBackdropColor, E.db.ProjectHopes.portraits.targetClass, E.db.ProjectHopes.portraits.targetMirror, E.db.ProjectHopes.portraits.targetClassTexture) end, nil, function() local style = E.db.ProjectHopes.portraits.targetClassTexture or "hd" local media = Private.Media.Class[style] return not(media and media.transparent) or not E.db.ProjectHopes.portraits.targetClass end)
	POAPOR.target.args.Position = ACH:Group(L["Position"], nil, 3, nil, nil, nil, nil, function() return not E.db.ProjectHopes.portraits.targetpor end)
	POAPOR.target.args.Position.inline = true
	POAPOR.target.args.Position.args.targetframelevel = ACH:Range(L["Framelevel"], nil, 5, { min = -100, max = 100, step = 1 }, "medium", function() return E.db.ProjectHopes.portraits.targetframelevel end, function(_, value) E.db.ProjectHopes.portraits.targetframelevel = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POAPOR.target.args.Position.args.targetSize = ACH:Range(L["Size of Portrait:"], nil, 5, { min = 0, max = 200, step = 1 }, "medium", function() return E.db.ProjectHopes.portraits.targetSize end, function(_, value) E.db.ProjectHopes.portraits.targetSize = value PORTRAIT:UpdateSize("target", E.db.ProjectHopes.portraits.targetSize, E.db.ProjectHopes.portraits.targetClass) end)
	POAPOR.target.args.Position.args.targetPosition = ACH:Select(L["Position"], nil, 7, PORTRAITANCHORPOINT, nil, "medium", function() return E.db.ProjectHopes.portraits.targetPosition or "center" end, function(_, value) E.db.ProjectHopes.portraits.targetPosition = value PORTRAIT:UpdatePortrait("target",E.db.ProjectHopes.portraits.targetClassBackdropColor,E.db.ProjectHopes.portraits.targetClass,E.db.ProjectHopes.portraits.targetMirror,E.db.ProjectHopes.portraits.targetClassTexture,E.db.ProjectHopes.portraits.targetBorderColor) PORTRAIT:UpdatePosition("target",value,E.db.ProjectHopes.portraits.targetOffsetX or 0,E.db.ProjectHopes.portraits.targetOffsetY or 0) end)
	POAPOR.target.args.Position.args.targetOffsetX = ACH:Range(L["X Offset (Left/Right)"], nil, 8, {min=-200,max=200,step=1}, nil, function() return E.db.ProjectHopes.portraits.targetOffsetX or 0 end, function(_, value) E.db.ProjectHopes.portraits.targetOffsetX = value PORTRAIT:UpdatePosition("target",E.db.ProjectHopes.portraits.targetPosition or "center",value,E.db.ProjectHopes.portraits.targetOffsetY or 0, E.db.ProjectHopes.portraits.targetStrata) end)
	POAPOR.target.args.Position.args.targetOffsetY = ACH:Range(L["Y Offset (Down/Up)"], nil, 9, {min=-200,max=200,step=1}, nil, function() return E.db.ProjectHopes.portraits.targetOffsetY or 0 end, function(_, value) E.db.ProjectHopes.portraits.targetOffsetY = value PORTRAIT:UpdatePosition("target",E.db.ProjectHopes.portraits.targetPosition or "center",E.db.ProjectHopes.portraits.targetOffsetX or 0,value, E.db.ProjectHopes.portraits.targetStrata) end)
	POAPOR.target.args.Position.args.targetStrata = ACH:Select(L["Frame Strata"], nil, 10, PORTRAITFRAMESTRATA, nil, nil, function() return E.db.ProjectHopes.portraits.targetStrata or "MEDIUM" end, function(_, value) E.db.ProjectHopes.portraits.targetStrata = value PORTRAIT:UpdatePosition("target", E.db.ProjectHopes.portraits.targetPosition or "center", E.db.ProjectHopes.portraits.targetOffsetX or 0, E.db.ProjectHopes.portraits.targetOffsetY or 0, value) end)

	POAPOR.focus = ACH:Group(L["Focus"], nil, 1, 'tab', nil, nil, nil, function() return not E.db.unitframe.units.focus.enable end)
	POAPOR.focus.args.focuspor = ACH:Toggle(L["Enable"], nil, 1, nil, false, "full", function() return E.db.ProjectHopes.portraits.focuspor end, function(_, value) E.db.ProjectHopes.portraits.focuspor = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.focus.enable end)
	POAPOR.focus.args.Options = ACH:Group(L["Misc"], nil, 2, nil, nil, nil, nil, function() return not E.db.ProjectHopes.portraits.focuspor end)
	POAPOR.focus.args.Options.inline = true
	POAPOR.focus.args.Options.args.focusBorderColor = ACH:Toggle(L["Border Color"], nil, 2, nil, false, "full", function() return E.db.ProjectHopes.portraits.focusBorderColor end, function(_, value) E.db.ProjectHopes.portraits.focusBorderColor = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POAPOR.focus.args.Options.args.focusMirror = ACH:Toggle(L["Mirror Portrait"], nil, 3, nil, false, "full", function() return E.db.ProjectHopes.portraits.focusMirror end, function(_, value) E.db.ProjectHopes.portraits.focusMirror = value PORTRAIT:UpdatePortrait("focus", E.db.ProjectHopes.portraits.focusClassBackdropColor, E.db.ProjectHopes.portraits.focusClass, value, E.db.ProjectHopes.portraits.focusClassTexture) end)
	POAPOR.focus.args.Options.args.focusClass = ACH:Toggle(L["Class Portrait"], nil, 4, nil, false, "full", function() return E.db.ProjectHopes.portraits.focusClass end, function(_, value) E.db.ProjectHopes.portraits.focusClass = value PORTRAIT:UpdatePortrait("focus", E.db.ProjectHopes.portraits.focusClassBackdropColor, value, E.db.ProjectHopes.portraits.focusMirror, E.db.ProjectHopes.portraits.focusClassTexture) end)
	POAPOR.focus.args.Options.args.focusClassTexture = ACH:Select(L["Class Texture"], nil, 6, (function() local t={} for k,v in pairs(Private.Media.Class) do t[k]=v.name or k end return t end)(), nil, "medium", function() return E.db.ProjectHopes.portraits.focusClassTexture end, function(_, value) E.db.ProjectHopes.portraits.focusClassTexture = value PORTRAIT:UpdatePortrait("focus", E.db.ProjectHopes.portraits.focusClassBackdropColor, E.db.ProjectHopes.portraits.focusClass, E.db.ProjectHopes.portraits.focusMirror, value) end, nil, function() return not E.db.ProjectHopes.portraits.focusClass end)
	POAPOR.focus.args.Options.args.focusClassBackdropColor = ACH:Color(L["Backdrop Color"], L["Choose a color for the portrait background"], 7, true, nil, function() local c = E.db.ProjectHopes.portraits.focusClassBackdropColor or { r=1, g=1, b=1, a=1 } return c.r, c.g, c.b, c.a end, function(_, r, g, b, a) E.db.ProjectHopes.portraits.focusClassBackdropColor = { r=r, g=g, b=b, a=a } PORTRAIT:UpdatePortrait("focus", E.db.ProjectHopes.portraits.focusClassBackdropColor, E.db.ProjectHopes.portraits.focusClass, E.db.ProjectHopes.portraits.focusMirror, E.db.ProjectHopes.portraits.focusClassTexture) end, nil, function() local style = E.db.ProjectHopes.portraits.focusClassTexture or "hd" local media = Private.Media.Class[style] return not(media and media.transparent) or not E.db.ProjectHopes.portraits.focusClass end)
	POAPOR.focus.args.Position = ACH:Group(L["Position"], nil, 3, nil, nil, nil, nil, function() return not E.db.ProjectHopes.portraits.focuspor end)
	POAPOR.focus.args.Position.inline = true
	POAPOR.focus.args.Position.args.focusframelevel = ACH:Range(L["Framelevel"], nil, 5, { min = -100, max = 100, step = 1 }, "medium", function() return E.db.ProjectHopes.portraits.focusframelevel end, function(_, value) E.db.ProjectHopes.portraits.focusframelevel = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POAPOR.focus.args.Position.args.focusSize = ACH:Range(L["Size of Portrait:"], nil, 5, { min = 0, max = 200, step = 1 }, "medium", function() return E.db.ProjectHopes.portraits.focusSize end, function(_, value) E.db.ProjectHopes.portraits.focusSize = value PORTRAIT:UpdateSize("focus", E.db.ProjectHopes.portraits.focusSize, E.db.ProjectHopes.portraits.focusClass) end)
	POAPOR.focus.args.Position.args.focusPosition = ACH:Select(L["Position"], nil, 7, PORTRAITANCHORPOINT, nil, "medium", function() return E.db.ProjectHopes.portraits.focusPosition or "center" end, function(_, value) E.db.ProjectHopes.portraits.focusPosition = value PORTRAIT:UpdatePortrait("focus",E.db.ProjectHopes.portraits.focusClassBackdropColor,E.db.ProjectHopes.portraits.focusClass,E.db.ProjectHopes.portraits.focusMirror,E.db.ProjectHopes.portraits.focusClassTexture,E.db.ProjectHopes.portraits.focusBorderColor) PORTRAIT:UpdatePosition("focus",value,E.db.ProjectHopes.portraits.focusOffsetX or 0,E.db.ProjectHopes.portraits.focusOffsetY or 0) end)
	POAPOR.focus.args.Position.args.focusOffsetX = ACH:Range(L["X Offset (Left/Right)"], nil, 8, {min=-200,max=200,step=1}, nil, function() return E.db.ProjectHopes.portraits.focusOffsetX or 0 end, function(_, value) E.db.ProjectHopes.portraits.focusOffsetX = value PORTRAIT:UpdatePosition("focus",E.db.ProjectHopes.portraits.focusPosition or "center",value,E.db.ProjectHopes.portraits.focusOffsetY or 0, E.db.ProjectHopes.portraits.focusStrata) end)
	POAPOR.focus.args.Position.args.focusOffsetY = ACH:Range(L["Y Offset (Down/Up)"], nil, 9, {min=-200,max=200,step=1}, nil, function() return E.db.ProjectHopes.portraits.focusOffsetY or 0 end, function(_, value) E.db.ProjectHopes.portraits.focusOffsetY = value PORTRAIT:UpdatePosition("focus",E.db.ProjectHopes.portraits.focusPosition or "center",E.db.ProjectHopes.portraits.focusOffsetX or 0,value, E.db.ProjectHopes.portraits.focusStrata) end)
	POAPOR.focus.args.Position.args.focusStrata = ACH:Select(L["Frame Strata"], nil, 10, PORTRAITFRAMESTRATA, nil, nil, function() return E.db.ProjectHopes.portraits.focusStrata or "MEDIUM" end, function(_, value) E.db.ProjectHopes.portraits.focusStrata = value PORTRAIT:UpdatePosition("focus", E.db.ProjectHopes.portraits.focusPosition or "center", E.db.ProjectHopes.portraits.focusOffsetX or 0, E.db.ProjectHopes.portraits.focusOffsetY or 0, value) end)

	POAPOR.targettarget = ACH:Group(L["Targettarget"], nil, 1, 'tab', nil, nil, nil, function() return not E.db.unitframe.units.targettarget.enable end)
	POAPOR.targettarget.args.targettargetpor = ACH:Toggle(L["Enable"], nil, 1, nil, false, "full", function() return E.db.ProjectHopes.portraits.targettargetpor end, function(_, value) E.db.ProjectHopes.portraits.targettargetpor = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.targettarget.enable end)
	POAPOR.targettarget.args.Options = ACH:Group(L["Misc"], nil, 2, nil, nil, nil, nil, function() return not E.db.ProjectHopes.portraits.targettargetpor end)
	POAPOR.targettarget.args.Options.inline = true
	POAPOR.targettarget.args.Options.args.targettargetBorderColor = ACH:Toggle(L["Border Color"], nil, 2, nil, false, "full", function() return E.db.ProjectHopes.portraits.targettargetBorderColor end, function(_, value) E.db.ProjectHopes.portraits.targettargetBorderColor = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POAPOR.targettarget.args.Options.args.targettargetMirror = ACH:Toggle(L["Mirror Portrait"], nil, 3, nil, false, "full", function() return E.db.ProjectHopes.portraits.targettargetMirror end, function(_, value) E.db.ProjectHopes.portraits.targettargetMirror = value PORTRAIT:UpdatePortrait("targettarget", E.db.ProjectHopes.portraits.targettargetClassBackdropColor, E.db.ProjectHopes.portraits.targettargetClass, value, E.db.ProjectHopes.portraits.targettargetClassTexture) end)
	POAPOR.targettarget.args.Options.args.targettargetClass = ACH:Toggle(L["Class Portrait"], nil, 4, nil, false, "full", function() return E.db.ProjectHopes.portraits.targettargetClass end, function(_, value) E.db.ProjectHopes.portraits.targettargetClass = value PORTRAIT:UpdatePortrait("targettarget", E.db.ProjectHopes.portraits.targettargetClassBackdropColor, value, E.db.ProjectHopes.portraits.targettargetMirror, E.db.ProjectHopes.portraits.targettargetClassTexture) end)
	POAPOR.targettarget.args.Options.args.targettargetClassTexture = ACH:Select(L["Class Texture"], nil, 6, (function() local t={} for k,v in pairs(Private.Media.Class) do t[k]=v.name or k end return t end)(), nil, "medium", function() return E.db.ProjectHopes.portraits.targettargetClassTexture end, function(_, value) E.db.ProjectHopes.portraits.targettargetClassTexture = value PORTRAIT:UpdatePortrait("targettarget", E.db.ProjectHopes.portraits.targettargetClassBackdropColor, E.db.ProjectHopes.portraits.targettargetClass, E.db.ProjectHopes.portraits.targettargetMirror, value) end, nil, function() return not E.db.ProjectHopes.portraits.targettargetClass end)
	POAPOR.targettarget.args.Options.args.targettargetClassBackdropColor = ACH:Color(L["Backdrop Color"], L["Choose a color for the portrait background"], 7, true, nil, function() local c = E.db.ProjectHopes.portraits.targettargetClassBackdropColor or { r=1, g=1, b=1, a=1 } return c.r, c.g, c.b, c.a end, function(_, r, g, b, a) E.db.ProjectHopes.portraits.targettargetClassBackdropColor = { r=r, g=g, b=b, a=a } PORTRAIT:UpdatePortrait("targettarget", E.db.ProjectHopes.portraits.targettargetClassBackdropColor, E.db.ProjectHopes.portraits.targettargetClass, E.db.ProjectHopes.portraits.targettargetMirror, E.db.ProjectHopes.portraits.targettargetClassTexture) end, nil, function() local style = E.db.ProjectHopes.portraits.targettargetClassTexture or "hd" local media = Private.Media.Class[style] return not(media and media.transparent) or not E.db.ProjectHopes.portraits.targettargetClass end)
	POAPOR.targettarget.args.Position = ACH:Group(L["Position"], nil, 3, nil, nil, nil, nil, function() return not E.db.ProjectHopes.portraits.targettargetpor end)
	POAPOR.targettarget.args.Position.inline = true
	POAPOR.targettarget.args.Position.args.targettargetframelevel = ACH:Range(L["Framelevel"], nil, 5, { min = -100, max = 100, step = 1 }, "medium", function() return E.db.ProjectHopes.portraits.targettargetframelevel end, function(_, value) E.db.ProjectHopes.portraits.targettargetframelevel = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POAPOR.targettarget.args.Position.args.targettargetSize = ACH:Range(L["Size of Portrait:"], nil, 5, { min = 0, max = 200, step = 1 }, "medium", function() return E.db.ProjectHopes.portraits.targettargetSize end, function(_, value) E.db.ProjectHopes.portraits.targettargetSize = value PORTRAIT:UpdateSize("targettarget", E.db.ProjectHopes.portraits.targettargetSize, E.db.ProjectHopes.portraits.targettargetClass) end)
	POAPOR.targettarget.args.Position.args.targettargetPosition = ACH:Select(L["Position"], nil, 7, PORTRAITANCHORPOINT, nil, "medium", function() return E.db.ProjectHopes.portraits.targettargetPosition or "center" end, function(_, value) E.db.ProjectHopes.portraits.targettargetPosition = value PORTRAIT:UpdatePortrait("targettarget",E.db.ProjectHopes.portraits.targettargetClassBackdropColor,E.db.ProjectHopes.portraits.targettargetClass,E.db.ProjectHopes.portraits.targettargetMirror,E.db.ProjectHopes.portraits.targettargetClassTexture,E.db.ProjectHopes.portraits.targettargetBorderColor) PORTRAIT:UpdatePosition("targettarget",value,E.db.ProjectHopes.portraits.targettargetOffsetX or 0,E.db.ProjectHopes.portraits.targettargetOffsetY or 0) end)
	POAPOR.targettarget.args.Position.args.targettargetOffsetX = ACH:Range(L["X Offset (Left/Right)"], nil, 8, {min=-200,max=200,step=1}, nil, function() return E.db.ProjectHopes.portraits.targettargetOffsetX or 0 end, function(_, value) E.db.ProjectHopes.portraits.targettargetOffsetX = value PORTRAIT:UpdatePosition("targettarget",E.db.ProjectHopes.portraits.targettargetPosition or "center",value,E.db.ProjectHopes.portraits.targettargetOffsetY or 0, E.db.ProjectHopes.portraits.targettargetStrata) end)
	POAPOR.targettarget.args.Position.args.targettargetOffsetY = ACH:Range(L["Y Offset (Down/Up)"], nil, 9, {min=-200,max=200,step=1}, nil, function() return E.db.ProjectHopes.portraits.targettargetOffsetY or 0 end, function(_, value) E.db.ProjectHopes.portraits.targettargetOffsetY = value PORTRAIT:UpdatePosition("targettarget",E.db.ProjectHopes.portraits.targettargetPosition or "center",E.db.ProjectHopes.portraits.targettargetOffsetX or 0,value, E.db.ProjectHopes.portraits.targettargetStrata) end)
	POAPOR.targettarget.args.Position.args.targettargetStrata = ACH:Select(L["Frame Strata"], nil, 10, PORTRAITFRAMESTRATA, nil, nil, function() return E.db.ProjectHopes.portraits.targettargetStrata or "MEDIUM" end, function(_, value) E.db.ProjectHopes.portraits.targettargetStrata = value PORTRAIT:UpdatePosition("targettarget", E.db.ProjectHopes.portraits.targettargetPosition or "center", E.db.ProjectHopes.portraits.targettargetOffsetX or 0, E.db.ProjectHopes.portraits.targettargetOffsetY or 0, value) end)

	POAPOR.boss = ACH:Group(L["Boss"], nil, 1, 'tab', nil, nil, nil, function() return not E.db.unitframe.units.boss.enable end)
	POAPOR.boss.args.bosspor = ACH:Toggle(L["Enable"], nil, 1, nil, false, "full", function() return E.db.ProjectHopes.portraits.bosspor end, function(_, value) E.db.ProjectHopes.portraits.bosspor = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.boss.enable end)
	POAPOR.boss.args.Options = ACH:Group(L["Misc"], nil, 2, nil, nil, nil, nil, function() return not E.db.ProjectHopes.portraits.bosspor end)
	POAPOR.boss.args.Options.inline = true
	POAPOR.boss.args.Options.args.bossBorderColor = ACH:Toggle(L["Border Color"], nil, 2, nil, false, "full", function() return E.db.ProjectHopes.portraits.bossBorderColor end, function(_, value) E.db.ProjectHopes.portraits.bossBorderColor = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POAPOR.boss.args.Options.args.bossMirror = ACH:Toggle(L["Mirror Portrait"], nil, 3, nil, false, "full", function() return E.db.ProjectHopes.portraits.bossMirror end, function(_, value) E.db.ProjectHopes.portraits.bossMirror = value PORTRAIT:UpdatePortrait("boss", E.db.ProjectHopes.portraits.bossClassBackdropColor, E.db.ProjectHopes.portraits.bossClass, value, E.db.ProjectHopes.portraits.bossClassTexture) end)
	POAPOR.boss.args.Position = ACH:Group(L["Position"], nil, 3, nil, nil, nil, nil, function() return not E.db.ProjectHopes.portraits.bosspor end)
	POAPOR.boss.args.Position.inline = true
	POAPOR.boss.args.Position.args.bossframelevel = ACH:Range(L["Framelevel"], nil, 5, { min = -100, max = 100, step = 1 }, "medium", function() return E.db.ProjectHopes.portraits.bossframelevel end, function(_, value) E.db.ProjectHopes.portraits.bossframelevel = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POAPOR.boss.args.Position.args.bossSize = ACH:Range(L["Size of Portrait:"], nil, 5, { min = 0, max = 200, step = 1 }, "medium", function() return E.db.ProjectHopes.portraits.bossSize end, function(_, value) E.db.ProjectHopes.portraits.bossSize = value PORTRAIT:UpdateSize("boss", E.db.ProjectHopes.portraits.bossSize, E.db.ProjectHopes.portraits.bossClass) end)
	POAPOR.boss.args.Position.args.bossPosition = ACH:Select(L["Position"], nil, 7, PORTRAITANCHORPOINT, nil, "medium", function() return E.db.ProjectHopes.portraits.bossPosition or "center" end, function(_, value) E.db.ProjectHopes.portraits.bossPosition = value PORTRAIT:UpdatePortrait("boss",E.db.ProjectHopes.portraits.bossClassBackdropColor,E.db.ProjectHopes.portraits.bossClass,E.db.ProjectHopes.portraits.bossMirror,E.db.ProjectHopes.portraits.bossClassTexture,E.db.ProjectHopes.portraits.bossBorderColor) PORTRAIT:UpdatePosition("boss",value,E.db.ProjectHopes.portraits.bossOffsetX or 0,E.db.ProjectHopes.portraits.bossOffsetY or 0) end)
	POAPOR.boss.args.Position.args.bossOffsetX = ACH:Range(L["X Offset (Left/Right)"], nil, 8, {min=-200,max=200,step=1}, nil, function() return E.db.ProjectHopes.portraits.bossOffsetX or 0 end, function(_, value) E.db.ProjectHopes.portraits.bossOffsetX = value PORTRAIT:UpdatePosition("boss",E.db.ProjectHopes.portraits.bossPosition or "center",value,E.db.ProjectHopes.portraits.bossOffsetY or 0, E.db.ProjectHopes.portraits.bossStrata) end)
	POAPOR.boss.args.Position.args.bossOffsetY = ACH:Range(L["Y Offset (Down/Up)"], nil, 9, {min=-200,max=200,step=1}, nil, function() return E.db.ProjectHopes.portraits.bossOffsetY or 0 end, function(_, value) E.db.ProjectHopes.portraits.bossOffsetY = value PORTRAIT:UpdatePosition("boss",E.db.ProjectHopes.portraits.bossPosition or "center",E.db.ProjectHopes.portraits.bossOffsetX or 0,value, E.db.ProjectHopes.portraits.bossStrata) end)
	POAPOR.boss.args.Position.args.bossStrata = ACH:Select(L["Frame Strata"], nil, 10, PORTRAITFRAMESTRATA, nil, nil, function() return E.db.ProjectHopes.portraits.bossStrata or "MEDIUM" end, function(_, value) E.db.ProjectHopes.portraits.bossStrata = value PORTRAIT:UpdatePosition("boss", E.db.ProjectHopes.portraits.bossPosition or "center", E.db.ProjectHopes.portraits.bossOffsetX or 0, E.db.ProjectHopes.portraits.bossOffsetY or 0, value) end)

	POAPOR.pet = ACH:Group(L["Pet"], nil, 1, 'tab', nil, nil, nil, function() return not E.db.unitframe.units.pet.enable end)
	POAPOR.pet.args.petpor = ACH:Toggle(L["Enable"], nil, 1, nil, false, "full", function() return E.db.ProjectHopes.portraits.petpor end, function(_, value) E.db.ProjectHopes.portraits.petpor = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.pet.enable end)
	POAPOR.pet.args.Options = ACH:Group(L["Misc"], nil, 2, nil, nil, nil, nil, function() return not E.db.ProjectHopes.portraits.petpor end)
	POAPOR.pet.args.Options.inline = true
	POAPOR.pet.args.Options.args.petBorderColor = ACH:Toggle(L["Border Color"], nil, 2, nil, false, "full", function() return E.db.ProjectHopes.portraits.petBorderColor end, function(_, value) E.db.ProjectHopes.portraits.petBorderColor = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POAPOR.pet.args.Options.args.petMirror = ACH:Toggle(L["Mirror Portrait"], nil, 3, nil, false, "full", function() return E.db.ProjectHopes.portraits.petMirror end, function(_, value) E.db.ProjectHopes.portraits.petMirror = value PORTRAIT:UpdatePortrait("pet", E.db.ProjectHopes.portraits.petClassBackdropColor, E.db.ProjectHopes.portraits.petClass, value, E.db.ProjectHopes.portraits.petClassTexture) end)
	POAPOR.pet.args.Options.args.petClassTexture = ACH:Select(L["Class Texture"], nil, 6, (function() local t={} for k,v in pairs(Private.Media.Class) do t[k]=v.name or k end return t end)(), nil, "medium", function() return E.db.ProjectHopes.portraits.petClassTexture end, function(_, value) E.db.ProjectHopes.portraits.petClassTexture = value PORTRAIT:UpdatePortrait("pet", E.db.ProjectHopes.portraits.petClassBackdropColor, E.db.ProjectHopes.portraits.petClass, E.db.ProjectHopes.portraits.petMirror, value) end, nil, function() return not E.db.ProjectHopes.portraits.petClass end)
	POAPOR.pet.args.Options.args.petClassBackdropColor = ACH:Color(L["Backdrop Color"], L["Choose a color for the portrait background"], 7, true, nil, function() local c = E.db.ProjectHopes.portraits.petClassBackdropColor or { r=1, g=1, b=1, a=1 } return c.r, c.g, c.b, c.a end, function(_, r, g, b, a) E.db.ProjectHopes.portraits.petClassBackdropColor = { r=r, g=g, b=b, a=a } PORTRAIT:UpdatePortrait("pet", E.db.ProjectHopes.portraits.petClassBackdropColor, E.db.ProjectHopes.portraits.petClass, E.db.ProjectHopes.portraits.petMirror, E.db.ProjectHopes.portraits.petClassTexture) end, nil, function() local style = E.db.ProjectHopes.portraits.petClassTexture or "hd" local media = Private.Media.Class[style] return not(media and media.transparent) or not E.db.ProjectHopes.portraits.petClass end)
	POAPOR.pet.args.Position = ACH:Group(L["Position"], nil, 3, nil, nil, nil, nil, function() return not E.db.ProjectHopes.portraits.petpor end)
	POAPOR.pet.args.Position.inline = true
	POAPOR.pet.args.Position.args.petframelevel = ACH:Range(L["Framelevel"], nil, 5, { min = -100, max = 100, step = 1 }, "medium", function() return E.db.ProjectHopes.portraits.petframelevel end, function(_, value) E.db.ProjectHopes.portraits.petframelevel = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POAPOR.pet.args.Position.args.petSize = ACH:Range(L["Size of Portrait:"], nil, 5, { min = 0, max = 200, step = 1 }, "medium", function() return E.db.ProjectHopes.portraits.petSize end, function(_, value) E.db.ProjectHopes.portraits.petSize = value PORTRAIT:UpdateSize("pet", E.db.ProjectHopes.portraits.petSize, E.db.ProjectHopes.portraits.petClass) end)
	POAPOR.pet.args.Position.args.petPosition = ACH:Select(L["Position"], nil, 7, PORTRAITANCHORPOINT, nil, "medium", function() return E.db.ProjectHopes.portraits.petPosition or "center" end, function(_, value) E.db.ProjectHopes.portraits.petPosition = value PORTRAIT:UpdatePortrait("pet",E.db.ProjectHopes.portraits.petClassBackdropColor,E.db.ProjectHopes.portraits.petClass,E.db.ProjectHopes.portraits.petMirror,E.db.ProjectHopes.portraits.petClassTexture,E.db.ProjectHopes.portraits.petBorderColor) PORTRAIT:UpdatePosition("pet",value,E.db.ProjectHopes.portraits.petOffsetX or 0,E.db.ProjectHopes.portraits.petOffsetY or 0) end)
	POAPOR.pet.args.Position.args.petOffsetX = ACH:Range(L["X Offset (Left/Right)"], nil, 8, {min=-200,max=200,step=1}, nil, function() return E.db.ProjectHopes.portraits.petOffsetX or 0 end, function(_, value) E.db.ProjectHopes.portraits.petOffsetX = value PORTRAIT:UpdatePosition("pet",E.db.ProjectHopes.portraits.petPosition or "center",value,E.db.ProjectHopes.portraits.petOffsetY or 0, E.db.ProjectHopes.portraits.petStrata) end)
	POAPOR.pet.args.Position.args.petOffsetY = ACH:Range(L["Y Offset (Down/Up)"], nil, 9, {min=-200,max=200,step=1}, nil, function() return E.db.ProjectHopes.portraits.petOffsetY or 0 end, function(_, value) E.db.ProjectHopes.portraits.petOffsetY = value PORTRAIT:UpdatePosition("pet",E.db.ProjectHopes.portraits.petPosition or "center",E.db.ProjectHopes.portraits.petOffsetX or 0,value, E.db.ProjectHopes.portraits.petStrata) end)
	POAPOR.pet.args.Position.args.petStrata = ACH:Select(L["Frame Strata"], nil, 10, PORTRAITFRAMESTRATA, nil, nil, function() return E.db.ProjectHopes.portraits.petStrata or "MEDIUM" end, function(_, value) E.db.ProjectHopes.portraits.petStrata = value PORTRAIT:UpdatePosition("pet", E.db.ProjectHopes.portraits.petPosition or "center", E.db.ProjectHopes.portraits.petOffsetX or 0, E.db.ProjectHopes.portraits.petOffsetY or 0, value) end)

	POAUFA.Infopanel = ACH:Group(L["InfoPanel"], nil, 5)
	POAUFA.Infopanel.args.desc = ACH:Group(L["Description"], nil, 1)
	POAUFA.Infopanel.args.desc.inline = true
	POAUFA.Infopanel.args.desc.args.feature = ACH:Description(L["Moves Infopanel on top of the frame."], 1, "medium")
	POAUFA.Infopanel.args.infopanelontop = ACH:Toggle(L["InfoPanel On Top"], L["This moves the Info Panel on the top of UnitFrames"], 5, nil, false, nil, function() return E.db.ProjectHopes.unitframe.infopanelontop end,function(_, value) E.db.ProjectHopes.unitframe.infopanelontop = value E:StaticPopup_Show('ProjectHopes_RL') end)

	POA.Tooltip = ACH:Group(E:TextGradient(L["Tooltip"], 0.6, 0.6, 0.6, 0.30, 1, 0.92), nil, 3, nil, function(info) return E.private.ProjectHopes.qualityOfLife[info[#info]] end, function(info, value) E.private.ProjectHopes.qualityOfLife[info[#info]] = value E:StaticPopup_Show('ProjectHopes_RL') end, not E.Retail, not E.Retail)
	local POATPA = POA.Tooltip.args
	POATPA.desc = ACH:Group(L["Description"], nil, 1)
	POATPA.desc.inline = true
	POATPA.desc.args.feature = ACH:Description(L["Adds various QoL stuff to tooltip."], 1, "medium")
	POATPA.upgradeLeveldesc = ACH:Group(L["Update Level"], nil, 1)
	POATPA.upgradeLeveldesc.inline = true
	POATPA.upgradeLeveldesc.args.feature = ACH:Description(L[" "], 1, "medium", function() return "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\ToolTipUpgradeInfo.tga", 135, 90 end)
	POATPA.upgradeLeveldesc.args.upgradeLevel = ACH:Toggle(L["Enable"], nil, 1, nil, nil, nil, nil, nil, nil, not E.Retail)
	POATPA.hideCrafterdesc = ACH:Group(L["Hide Crafter"], nil, 1)
	POATPA.hideCrafterdesc.inline = true
	POATPA.hideCrafterdesc.args.feature = ACH:Description(L[" "], 1, "medium", function() return "Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\ToolTipCrafterName.tga", 155, 68 end)
	POATPA.hideCrafterdesc.args.hideCrafter = ACH:Toggle(L["Enable"], nil, 1, nil, nil, nil, nil, nil, nil, not E.Retail)

	POA.Automation = ACH:Group(E:TextGradient(L["Automation"], 0.6, 0.6, 0.6, 0.25, 0.70, 1), nil, 3, nil, function(info) return E.private.ProjectHopes.qualityOfLife.automation[info[#info]] end, function(info, value) E.private.ProjectHopes.qualityOfLife.automation[info[#info]] = value E:StaticPopup_Show("ProjectHopes_RL") end)
	local POAANA = POA.Automation.args
	POAANA.desc = ACH:Group(L["Description"], nil, 1)
	POAANA.desc.inline = true
	POAANA.desc.args.feature = ACH:Description(L["This module provides the some automations to make life better."], 1, "medium")
	POAANA.resurrect = ACH:Toggle(L["Accept Resurrect"], nil, 2, nil, nil, 'full')
	POAANA.combatresurrect = ACH:Toggle(L["Accept Combat Resurrect"], nil, 2, nil, nil, 'full')
	POAANA.easyDelete = ACH:Toggle(L["Easy Delete"], L["Automatically fill out the confirmation text to delete items."], 3, nil, false, 'full')
	POAANA.autoAcceptQuests = ACH:Toggle(L["Auto Accept/Complete Quests"], L["Automatically accepts and complete quests, when not holding SHIFT"], 4, nil, false, 'full')
	POAANA.borederDarkmode = ACH:Toggle(L["Border Darkmode"], L["Changes the border used to black, works on Plater and Weakauras."], 4, nil, false, 'full')
	POAANA.fastLoot = ACH:Toggle(L["Fast Loot"], nil, 4, nil, false, 'full')
	POAANA.detailsResize = ACH:Toggle(L["Details AutoResizer"], L["Resize Details Window 2 based on Zone type.\n   - Shows 2 players for none/party zone.\n   - Shows 5 players in raid zone."], 4, nil, false, 'full')

	POA.weakAurasAnchors = ACH:Group(E:TextGradient(L["Weakaura Anchors"], 0.6, 0.6, 0.6, 0.29, 0.35, 1), nil, 5)
	local POAWA = POA.weakAurasAnchors.args
	POAWA.desc = ACH:Group(L["Description"], nil, 1)
	POAWA.desc.inline = true
	POAWA.desc.args.feature1 = ACH:Description(L["This module provides the feature to add Anchors within ElvUI to anchor weakuras to."], 1, "medium")
	POAWA.enable = ACH:Toggle(L["Enable"], nil, 2, nil, false, "full",function() return E.private.ProjectHopes.qualityOfLife.weakAurasAnchors end,function(_, value) E.private.ProjectHopes.qualityOfLife.weakAurasAnchors = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POAWA.spacer = ACH:Spacer(3)
	POAWA.desc2 = ACH:Group(L["How does it work?"], nil, 3, nil, nil, nil, nil, function() return not E.private.ProjectHopes.qualityOfLife.weakAurasAnchors end)
	POAWA.desc2.inline = true
	POAWA.desc2.args.feature1 = ACH:Description(L["You go into '"].."|cffffc607/wa|r"..L["', and find the weakaura you want to anchor to the new Anchor Frames."], 1, "medium")
	POAWA.desc2.args.feature2 = ACH:Description(L["Once you have found the weakaura, scroll down in '"].."|cffffc607Display|r"..L["' in single weakura or '"].."|cffffc607Group|r"..L["' in group, until you find '"].."|cffffc607Position and Size Settings|r"..L["'."], 2, "medium")
	POAWA.desc2.args.feature3 = ACH:Description(L["When you have expanded '"].."|cffffc607Position and Size Settings|r"..L["' type in the name off one of the new custom Anchors."], 3, "medium")
	POAWA.desc2.args.feature4 = ACH:Description(L["\n"].."|cffffc607Anchor Names|r"..L[":\n"].."|cff81c783ProjectHopesBarAnchor|r"..L["\n"].."|cff81c783ProjectHopesExtraBarAnchor|r"..L["\n"].."|cff81c783ProjectHopesIconAnchor|r"..L["\n"].."|cff81c783ProjectHopesExtraIconAnchor|r"..L["\n"].."|cff81c783ProjectHopesTextAnchor|r"..L["\n"], 4, "medium")
	POAWA.desc2.args.feature5 = ACH:Description(L["After you have typed in one of the anchors, you can go to '"].."|cffffc607/emove|r"..L["' and select '"]..Private.Name..L["' in the '"].."|cffffc607Config Mode|r"..L["' move the Anchors around."], 5, "medium")
	POAWA.desc2.args.feature6 = ACH:Description(" ", 6, nil, 'Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\WeakauraAnchorDemo.tga', nil, 512, 512)

	POA.Miscellaneous = ACH:Group(E:TextGradient(L["Miscellaneous"], 0.6, 0.6, 0.6, 0.65, 0.32, 1), nil, 5)
	local POAMSA = POA.Miscellaneous.args
	POAMSA.desc = ACH:Group(L["Description"], nil, 1)
	POAMSA.desc.inline = true
	POAMSA.desc.args.feature = ACH:Description(L["This is where you can find all the miscellaneous modules that dont fit a catagory."], 1, "medium")
	POAMSA.mplusimprovements = ACH:Toggle(L["Mythic+ Tab Improvements"], nil, 4, nil, false, 'full', function() return E.db.ProjectHopes.qualityOfLife.mplusimprovements end,function(_, value) E.db.ProjectHopes.qualityOfLife.mplusimprovements = value E:StaticPopup_Show('ProjectHopes_RL') end, not E.Retail, not E.Retail)
	POAMSA.driveButton = ACH:Toggle(L["Cloak Minimap Button, for faster config of Reshii Cloak"], nil, 4, nil, false, 'full', function() return E.db.ProjectHopes.qualityOfLife.driveButton end,function(_, value) E.db.ProjectHopes.qualityOfLife.driveButton = value E:StaticPopup_Show('ProjectHopes_RL') end, not E.Retail, not E.Retail)

	POA.frameMover = ACH:Group(E:TextGradient(L["Frame Mover"], 0.6, 0.6, 0.6, 0.98, 0.34, 1), nil, 5, nil, function(info) return E.private.ProjectHopes.qualityOfLife.frameMover[info[#info]] end, function(info, value) E.private.ProjectHopes.qualityOfLife.frameMover[info[#info]] = value E:StaticPopup_Show("ProjectHopes_RL") end)
	local POAFMA = POA.frameMover.args
	POAFMA.desc = ACH:Group(L["Description"], nil, 1)
	POAFMA.desc.inline = true
	POAFMA.desc.args.feature = ACH:Description(L["This module provides the feature that repositions the frames with drag and drop."], 1, "medium")
	POAFMA.enable = ACH:Toggle(L["Enable"], nil, 1)
	POAFMA.elvUIBags = ACH:Toggle(L["Move ElvUI Bags"], nil, 2, nil, nil, nil, nil, nil, function() return not E.private.ProjectHopes.qualityOfLife.frameMover.enable end)
	POAFMA.remember = ACH:Group(L["Remeber Positions"], nil, 3, nil, nil, nil, function() return not E.private.ProjectHopes.qualityOfLife.frameMover.enable end)
	POAFMA.remember.inline = true
	POAFMA.remember.args.rememberPositions = ACH:Toggle(L["Enable"], nil, 2, nil, nil, nil, nil, nil, function(info, value) E.private.ProjectHopes.qualityOfLife.frameMover[info[#info]] = value end)
	POAFMA.remember.args.clearHistory = ACH:Toggle(L["Clear History"], nil, 2, nil, nil, nil, nil, function() E.private.ProjectHopes.qualityOfLife.frameMover.framePositions = {} end)

	POA.Tags = ACH:Group(E:TextGradient(L["Tags"], 0.6, 0.6, 0.6, 1, 0.31, 0.55), nil, 5)
	local POATSA = POA.Tags.args
	POATSA.desc = ACH:Group(L["Description"], nil, 1)
	POATSA.desc.inline = true
	POATSA.desc.args.feature = ACH:Description(L["This is where you can find all the miscellaneous modules that dont fit a catagory."], 1, "medium")
	POATSA.spacer = ACH:Spacer(2, 'full')
	POATSA.tag1 = ACH:Input(L["Shows the Units role when selected."], nil, 3, nil, 'full', function() return '[Hopes:role]' end, nil, nil)
	POATSA.tag2 = ACH:Input(L["Shows the percent health and absorb without %."], nil, 3, nil, 'full', function() return '[Hopes:perhp]' end, nil, nil, not E.Retail)
	POATSA.tag3 = ACH:Input(L["Shows the Units raidmarker when selected."], nil, 3, nil, 'full', function() return '[Hopes:raidmarker]' end, nil, nil)
	POATSA.tag4 = ACH:Input(L["Shows the Leader Icon or Assist icon if the unit is Leader or Assist."], nil, 3, nil, 'full', function() return '[Hopes:leader]' end, nil, nil, not E.Retail)
	POATSA.tag5 = ACH:Input(L["Shows heal absorb on unit."], nil, 3, nil, 'full', function() return '[Hopes:healabsorbs]' end, nil, nil, not E.Retail)
	POATSA.tag6 = ACH:Input(L["Shows the percent health and absorb without %, and hide it when 0 or 100"], nil, 3, nil, 'full', function() return '[Hopes:perpp]' end, nil, nil, not E.Retail)
	POATSA.tag7 = ACH:Input(L["Name tag that changes the color of name based on class, raidmarker and unit."], nil, 3, nil, 'full', function() return '[Hopes:name]' end, nil, nil)
	POATSA.tag8 = ACH:Input(L["Displays the Unit Status time."], nil, 3, nil, 'full', function() return '[Hopes:statustimer]' end, nil, nil)

	POA.BuffsDebuffs = ACH:Group(E:TextGradient(L["Buffs & Debuffs"], 0.6, 0.6, 0.6, 1, 0.45, 0.30), nil, 3)
	local POABDS = POA.BuffsDebuffs.args
	POABDS.desc = ACH:Group(L["Description"], nil, 1)
	POABDS.desc.inline = true
	POABDS.desc.args.feature = ACH:Description(L["This module adds border to buffs and debuffs on unitframes and at minimap."], 1, "medium")
	POABDS.uf = ACH:Toggle(L["Toggle the border of Buffs and Debuffs at Unitframes."], nil, 2, nil, false, "full", function() return E.db.ProjectHopes.border.AuraUF end, function(_, value) E.db.ProjectHopes.border.AuraUF = value E:StaticPopup_Show('ProjectHopes_RL') end, nil)
	POABDS.minimap = ACH:Toggle(L["Toggle the border of Buffs and Debuffs at minimap."], nil, 2, nil, false, "full", function() return E.db.ProjectHopes.border.Aura end, function(_, value) E.db.ProjectHopes.border.Aura = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.private.auras.enable end)

	POA.Borders = ACH:Group(E:TextGradient(L["Borders"], 0.6, 0.6, 0.6, 1, 0.93, 0.66), nil, 3, 'tab')
	local POABS = POA.Borders.args
	POABS.desc = ACH:Group(L["Description"], nil, 1)
	POABS.desc.inline = true
	POABS.desc.args.feature = ACH:Description(L["This module adds border and skin various ElvUI, Blizzard and Addons."], 1, "medium")

	POABS.UnitFrames = ACH:Group(L["UnitFrames"], nil, 1)
	POABS.UnitFrames.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.desc.inline = true
	POABS.UnitFrames.args.desc.args.feature = ACH:Description(L["This is where you can choose what UnitFrames to have border."], 1, "medium")

	POABS.UnitFrames.args.playerborder = ACH:Group(L["Player"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.player.enable end, nil, nil)
	POABS.UnitFrames.args.playerborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.playerborder.args.desc.inline = true
	POABS.UnitFrames.args.playerborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Player Unitframe"], 1, "medium")
	POABS.UnitFrames.args.playerborder.args.player = ACH:Toggle(L["Enable"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.border.Player end,function(_, value) E.db.ProjectHopes.border.Player = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.player.enable end)
	POABS.UnitFrames.args.playerborder.args.playersep = ACH:Toggle(L["Power/Health Separator"], nil, 4, nil, false, nil, function() return E.db.ProjectHopes.border.Playersep end,function(_, value) E.db.ProjectHopes.border.Playersep = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.player.power.enable or not E.db.ProjectHopes.border.Player or not E.db.unitframe.units.player.enable end)
	
	POABS.UnitFrames.args.petborder = ACH:Group(L["Pet"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.pet.enable end, nil, nil)
	POABS.UnitFrames.args.petborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.petborder.args.desc.inline = true
	POABS.UnitFrames.args.petborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Pet Unitframe"], 1, "medium")
	POABS.UnitFrames.args.petborder.args.pet = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.Pet end,function(_, value) E.db.ProjectHopes.border.Pet = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.pet.enable end)
	
	POABS.UnitFrames.args.pettargetborder = ACH:Group(L["Pet Target"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.pettarget.enable end, nil, nil)
	POABS.UnitFrames.args.pettargetborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.pettargetborder.args.desc.inline = true
	POABS.UnitFrames.args.pettargetborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Pet Target Unitframe"], 1, "medium")
	POABS.UnitFrames.args.pettargetborder.args.enable = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.PetTarget end,function(_, value) E.db.ProjectHopes.border.PetTarget = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.pettarget.enable end)
	
	POABS.UnitFrames.args.targetborder = ACH:Group(L["Target"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.target.enable end, nil, nil)
	POABS.UnitFrames.args.targetborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.targetborder.args.desc.inline = true
	POABS.UnitFrames.args.targetborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Target Unitframes."], 1, "medium")
	POABS.UnitFrames.args.targetborder.args.target = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.Target end,function(_, value) E.db.ProjectHopes.border.Target = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.target.enable end)
	POABS.UnitFrames.args.targetborder.args.targetsep = ACH:Toggle(L["Power/Health Separator"], nil, 4, nil, false, "full",function() return E.db.ProjectHopes.border.Targetsep end,function(_, value) E.db.ProjectHopes.border.Targetsep = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.target.power.enable or not E.db.ProjectHopes.border.Target end)

	POABS.UnitFrames.args.focusborder = ACH:Group(L["Focus"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.focus.enable end, E.Classic, nil)
	POABS.UnitFrames.args.focusborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.focusborder.args.desc.inline = true
	POABS.UnitFrames.args.focusborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Focus Unitframes."], 1, "medium")
	POABS.UnitFrames.args.focusborder.args.focus = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.Focus end,function(_, value) E.db.ProjectHopes.border.Focus = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.focus.enable end)
	
	POABS.UnitFrames.args.focustargetborder = ACH:Group(L["Focus Target"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.focustarget.enable end, not E.Retail, nil)
	POABS.UnitFrames.args.focustargetborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.focustargetborder.args.desc.inline = true
	POABS.UnitFrames.args.focustargetborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Focus Target Unitframes."], 1, "medium")
	POABS.UnitFrames.args.focustargetborder.args.enable = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.FocusTarget end,function(_, value) E.db.ProjectHopes.border.FocusTarget = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.focustarget.enable end)
	
	POABS.UnitFrames.args.targetoftargetborder = ACH:Group(L["Target of Target"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.targettarget.enable end, nil, nil)
	POABS.UnitFrames.args.targetoftargetborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.targetoftargetborder.args.desc.inline = true
	POABS.UnitFrames.args.targetoftargetborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Target of Target Unitframes"], 1, "medium")
	POABS.UnitFrames.args.targetoftargetborder.args.tot = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.TargetofTarget end,function(_, value) E.db.ProjectHopes.border.TargetofTarget = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.targettarget.enable end)
	
	POABS.UnitFrames.args.targetoftargetoftargetborder = ACH:Group(L["Target of Target of Target"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.targettargettarget.enable end, nil, nil)
	POABS.UnitFrames.args.targetoftargetoftargetborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.targetoftargetoftargetborder.args.desc.inline = true
	POABS.UnitFrames.args.targetoftargetoftargetborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Target of Target Unitframes"], 1, "medium")
	POABS.UnitFrames.args.targetoftargetoftargetborder.args.enable = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.TargetofTargetofTarget end,function(_, value) E.db.ProjectHopes.border.TargetofTargetofTarget = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.targettargettarget.enable end)
	
	POABS.UnitFrames.args.partyborder = ACH:Group(L["Party"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.party.enable end, nil, nil)
	POABS.UnitFrames.args.partyborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.partyborder.args.desc.inline = true
	POABS.UnitFrames.args.partyborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Party Unitframe."], 1, "medium")
	POABS.UnitFrames.args.partyborder.args.party = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.Party end,function(_, value) E.db.ProjectHopes.border.Party = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.party.enable end)
	POABS.UnitFrames.args.partyborder.args.PartySpaced = ACH:Toggle(L["Party Spaced"], nil, 4, nil, false, "full",function() return E.db.ProjectHopes.border.PartySpaced end,function(_, value) E.db.ProjectHopes.border.PartySpaced = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.party.enable end)
	POABS.UnitFrames.args.partyborder.args.partysep = ACH:Toggle(L["Separator"], nil, 5, nil, false, "full",function() return E.db.ProjectHopes.border.Partysep end,function(_, value) E.db.ProjectHopes.border.Partysep = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.party.enable or not E.db.ProjectHopes.border.Party end)
	
	POABS.UnitFrames.args.raid1border = ACH:Group(L["Raid1"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.raid1.enable end, nil, nil)
	POABS.UnitFrames.args.raid1border.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.raid1border.args.desc.inline = true
	POABS.UnitFrames.args.raid1border.args.desc.args.feature = ACH:Description(L["Adds a border to the Raid1 Unitframe."], 1, "medium")
	POABS.UnitFrames.args.raid1border.args.raid = ACH:Toggle(L["Heal"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.raid end,function(_, value) E.db.ProjectHopes.border.raid = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.raid1.enable end)
	POABS.UnitFrames.args.raid1border.args.raidbackdrop = ACH:Toggle(L["Heal (Backdrop)"], nil, 4, nil, false, "full",function() return E.db.ProjectHopes.border.raid2backdrop end,function(_, value) E.db.ProjectHopes.border.raid2backdrop = value E:StaticPopup_Show('ProjectHopes_RL') end, nil, function() return not E.db.ProjectHopes.border.raid2 end)
	POABS.UnitFrames.args.raid1border.args.raiddps = ACH:Toggle(L["DPS/TANK"], nil, 5, nil, false, "full",function() return E.db.ProjectHopes.border.raiddps end,function(_, value) E.db.ProjectHopes.border.raiddps = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.raid1.enable end)

	POABS.UnitFrames.args.raid2border = ACH:Group(L["Raid2"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.raid2.enable end, nil, nil)
	POABS.UnitFrames.args.raid2border.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.raid2border.args.desc.inline = true
	POABS.UnitFrames.args.raid2border.args.desc.args.feature = ACH:Description(L["Adds a border to the Raid2 Unitframe."], 1, "medium")
	POABS.UnitFrames.args.raid2border.args.raid = ACH:Toggle(L["Heal"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.raid2 end,function(_, value) E.db.ProjectHopes.border.raid2 = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.raid2.enable end)
	POABS.UnitFrames.args.raid2border.args.raidbackdrop = ACH:Toggle(L["Heal (Backdrop)"], nil, 4, nil, false, "full",function() return E.db.ProjectHopes.border.raid2backdrop end,function(_, value) E.db.ProjectHopes.border.raid2backdrop = value E:StaticPopup_Show('ProjectHopes_RL') end, nil, function() return not E.db.ProjectHopes.border.raid2 end)
	POABS.UnitFrames.args.raid2border.args.raiddps = ACH:Toggle(L["DPS/TANK"], nil, 5, nil, false, "full",function() return E.db.ProjectHopes.border.raid2dps end,function(_, value) E.db.ProjectHopes.border.raid2dps = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.raid2.enable end)
	
	POABS.UnitFrames.args.raid3border = ACH:Group(L["Raid3"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.raid3.enable end, nil, nil)
	POABS.UnitFrames.args.raid3border.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.raid3border.args.desc.inline = true
	POABS.UnitFrames.args.raid3border.args.desc.args.feature = ACH:Description(L["Adds a border to the Raid3 Unitframe."], 1, "medium")
	POABS.UnitFrames.args.raid3border.args.raid = ACH:Toggle(L["Heal"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.raid3 end,function(_, value) E.db.ProjectHopes.border.raid3 = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.raid3.enable end)
	POABS.UnitFrames.args.raid3border.args.raidbackdrop = ACH:Toggle(L["Heal (Backdrop)"], nil, 4, nil, false, "full",function() return E.db.ProjectHopes.border.raid3backdrop end,function(_, value) E.db.ProjectHopes.border.raid3backdrop = value E:StaticPopup_Show('ProjectHopes_RL') end, nil, function() return not E.db.ProjectHopes.border.raid3 end)
	POABS.UnitFrames.args.raid3border.args.raiddps = ACH:Toggle(L["DPS/TANK"], nil, 5, nil, false, "full",function() return E.db.ProjectHopes.border.raid3dps end,function(_, value) E.db.ProjectHopes.border.raid3dps = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.raid3.enable end)
	
	POABS.UnitFrames.args.tankframeborder = ACH:Group(L["Tank Frames"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.tank.enable end, nil, nil)
	POABS.UnitFrames.args.tankframeborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.tankframeborder.args.desc.inline = true
	POABS.UnitFrames.args.tankframeborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Tank Unitframe."], 1, "medium")
	POABS.UnitFrames.args.tankframeborder.args.maintankofftank = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.Maintankofftank end,function(_, value) E.db.ProjectHopes.border.Maintankofftank = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.tank.enable end)
	POABS.UnitFrames.args.assistunitborder= ACH:Group(L["Assist Units"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.assist.enable end, nil, nil)
	POABS.UnitFrames.args.assistunitborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.assistunitborder.args.desc.inline = true
	POABS.UnitFrames.args.assistunitborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Assist Unitframe."], 1, "medium")
	POABS.UnitFrames.args.assistunitborder.args.maintankofftank = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.AssistUnits end,function(_, value) E.db.ProjectHopes.border.AssistUnits = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.assist.enable end)
	
	POABS.UnitFrames.args.bossborders = ACH:Group(L["Boss"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.boss.enable end, E.Classic, nil)
	POABS.UnitFrames.args.bossborders.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.bossborders.args.desc.inline = true
	POABS.UnitFrames.args.bossborders.args.desc.args.feature = ACH:Description(L["Adds a border to the Boss Unitframes"], 1, "medium")
	POABS.UnitFrames.args.bossborders.args.boss = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.Boss end,function(_, value) E.db.ProjectHopes.border.Boss = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.boss.enable end)

	POABS.UnitFrames.args.arenaborders = ACH:Group(L["Arena"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.arena.enable end, E.Classic, nil)
	POABS.UnitFrames.args.arenaborders.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.arenaborders.args.desc.inline = true
	POABS.UnitFrames.args.arenaborders.args.desc.args.feature = ACH:Description(L["Adds a border to the Arena Unitframes"], 1, "medium")
	POABS.UnitFrames.args.arenaborders.args.arena = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.Arena end,function(_, value) E.db.ProjectHopes.border.Arena = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.arena.enable end)

	POABS.Addons = ACH:Group(L["Addons"], nil, 1)
	POABS.Addons.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.Addons.args.desc.inline = true
	POABS.Addons.args.desc.args.feature = ACH:Description(L["Skins Addons to fit ProjectHopes."], 1, "medium")

	local addontoggles = {}
	if E.Classic or E.Mists or E.Retail then
		if IsAddOnLoaded("BigWigs") then addontoggles.bigwigsqueue = L["BigWigs Queue"] end
		if IsAddOnLoaded("Auctionator") then addontoggles.auctionator = L["Auctionator"] end
		if IsAddOnLoaded("BugSack") then addontoggles.bugsack = L["BugSack"] end
		if IsAddOnLoaded("OmniCD") then addontoggles.omnicd = L["OmniCD"] end
		if IsAddOnLoaded("RareScanner") then addontoggles.rareScanner = L["Rare Scanner"] end
		if IsAddOnLoaded("Weakauras") then addontoggles.weakAurasOptions = L["Weakauras Option"] end
		if IsAddOnLoaded("Baganator") then addontoggles.Baganator = L["Baganator"] end
		if IsAddOnLoaded("Details") then addontoggles.details = L["Details"] end
		if IsAddOnLoaded("DBM-Core") then addontoggles.dbm = L["DBM"] end
		if IsAddOnLoaded("Leatrix_Plus") then addontoggles.leatrix_plus = L["Leatrix Plus"] end
		if IsAddOnLoaded("OpenAll") then addontoggles.openall = L["Open All"] end
		if IsAddOnLoaded("RXPGuides") then addontoggles.rxpguides = L["RXPGuides AH"] end
		if IsAddOnLoaded("Atlas") then addontoggles.atlas = L["Atlas"] end
		if IsAddOnLoaded("SimpleAddonManager") then addontoggles.simpleaddonmanager = L["SimpleAddonManager"] end
	end

	if E.Retail then
		if IsAddOnLoaded("WarpDeplete") then addontoggles.warpDeplete = L["WarpDeplete"] end
		if IsAddOnLoaded("RaiderIO") then addontoggles.raiderio = L["RaiderIO"] end
		if IsAddOnLoaded("Simulationcraft") then addontoggles.simulationcraft = L["Simulationcraft"] end
		if IsAddOnLoaded("MazeHelper") then addontoggles.mazeHelper = L["Maze Helper"] end
		if IsAddOnLoaded("TalentTreeTweaks") then addontoggles.talentTreeTweaks = L["Talent Tree Tweaks"] end
		if IsAddOnLoaded("TalentLoadoutsEx") then addontoggles.talentLoadoutsEx = L["Talent Loadouts Ex"] end
		if IsAddOnLoaded("ChoreTracker") then addontoggles.choreTracker = L["Chore Tracker"] end
	end

	if E.Classic then
		if IsAddOnLoaded("Ranker") then addontoggles.ranker = L["Ranker"] end
		if IsAddOnLoaded("NovaSpellRankChecker") then addontoggles.novaspellrankchecker = L["Nova Spell Rank Checker"] end
		if IsAddOnLoaded("AtlasLootClassic") then addontoggles.atlaslootclassic = L["Atlas Loot Classic"] end
	end

	if E.Mists then
	end

	if E.Mists or E.Retail then
		if IsAddOnLoaded("Hekili") then addontoggles.hekili = L["Hekili"] end
	end

	if E.Classic or E.Mists then
		if IsAddOnLoaded("ThreatClassic2") then addontoggles.threatClassic2 = L["ThreatClassic2"] end
		if IsAddOnLoaded("NovaWorldBuffs") then addontoggles.novaworldbuffs = L["Nova World Buffs"] end
		if IsAddOnLoaded("NovaWorldBuffs") and E.db.ProjectHopes.skins.novaworldbuffs then addontoggles.novaworldbuffsposition = L["Nova World Buffs Position"] end
		if IsAddOnLoaded("WhatsTraining") then addontoggles.whatstraining = L["What's Training"] end
		if IsAddOnLoaded("LFGBulletinBoard") then addontoggles.lfgbulletinboard = L["LFG Group Bulletin Board"] end
	end

	if E.Classic or E.Retail then
		if IsAddOnLoaded("Spy") then addontoggles.spy = L["Spy"] end
	end

	local function ToggleAddOnsSkins(value)
		E:StaticPopup_Show('ProjectHopes_RL')
    for key in pairs(addontoggles) do
			if key ~= 'enable' then
				E.db.ProjectHopes.skins[key] = value
			end
		end
	end

	POABS.Addons.args.disableAddOnsSkins = ACH:Execute(L["Disable AddOns Skins"], nil, 3, function() ToggleAddOnsSkins(false) end)
	POABS.Addons.args.enableAddOnsSkins = ACH:Execute(L["Enable AddOns Skins"], nil, 4, function() ToggleAddOnsSkins(true) end)
	POABS.Addons.args.addons = ACH:MultiSelect(L["AddOns"], L["Enable/Disable this skin."], -1, addontoggles, nil, nil, function(_, key) return E.db.ProjectHopes.skins[key] end, function(_, key, value) E.db.ProjectHopes.skins[key] = value; E:StaticPopup_Show('ProjectHopes_RL') end, nil, nil, true)

	POABS.Blizzard = ACH:Group(L["Blizzard"], nil, 1)
	POABS.Blizzard.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.Blizzard.args.desc.inline = true
	POABS.Blizzard.args.desc.args.feature = ACH:Description(L["Skins Blizzard frames to fit ProjectHopes."], 1, "medium")

	local blizzardtoggles = {
		addonList = L["AddOn Manager"],
		auctionHouse = L["AUCTIONS"],
		bags = L["Bags"],
		bgmap = L["BG Map"],
		bgscore = L["BG Score"],
		binding = L["KEY_BINDINGS"],
		blizzardOptions = L["INTERFACE_OPTIONS"],
		channels = L["CHANNELS"],
		character = L["Character Frame"],
		communities = L["COMMUNITIES"],
		debugTools = L["Debug Tools"],
		dressingRoom = L["DRESSUP_FRAME"],
		eventTrace = L["Event Log"],
		friends = format(E.Retail and '%s' or '%s & %s', L["Friends"], L["Guild"]),
		gossip = L["Gossip Frame"],
		guildControl = L["Guild Control Frame"],
		guildRegistrar = L["Guild Registrar"],
		help = L["Help Frame"],
		inspect = L["Inspect"],
		inputMethodEditor = L["Input Method Editor"],
		lookingForGroup = L["LFG_TITLE"],
		loot = L["Loot Frame"],
		macro = L["MACROS"],
		mail = L["Mail Frame"],
		merchant = L["Merchant Frame"],
		mirrorTimers = L["Mirror Timers"],
		misc = L["Misc Frames"],
		petition = L["Petition Frame"],
		quest = L["Quest Frames"],
		questChoice = L["Quest Choice"],
		raid = L["Raid Frame"],
		itemSocketing = L["Socket Frame"],
		spellBook = L["SPELLBOOK"],
		stable = L["Stable"],
		tabard = L["Tabard Frame"],
		talent = L["TALENTS"],
		flightMap = L["FLIGHT_MAP"],
		taxi = L["Taxi"],
		timeManager = L["TIMEMANAGER_TITLE"],
		tooltips = L["Tooltip"],
		trade = L["TRADE"],
		tradeskill = L["TRADESKILLS"],
		trainer = L["Trainer Frame"],
		tutorial = L["Tutorials"],
		worldMap = L["WORLD_MAP"]
	}

	if E.Mists or E.Retail then
	blizzardtoggles.achievementFrame = L["ACHIEVEMENTS"]
	blizzardtoggles.alertframes = L["Alert Frames"]
	blizzardtoggles.archaeology = L["Archaeology Frame"]
	blizzardtoggles.barbershop = L["BARBERSHOP"]
	blizzardtoggles.calendar = L["Calendar Frame"]
	blizzardtoggles.collections = L["COLLECTIONS"]
	blizzardtoggles.encounterJournal = L["ENCOUNTER_JOURNAL"]
	blizzardtoggles.guildBank = L["Guild Bank"]
	blizzardtoggles.pvp = L["PvP Frames"]
	blizzardtoggles.petBattle = L["Pet Battle"]
	blizzardtoggles.transmogrify = L["TRANSMOGRIFY"]
	end

	if not E.Retail then
		blizzardtoggles.questTimers = L["Quest Timers"]
	end

	if E.Retail then
		blizzardtoggles.adventureMap = L["ADVENTURE_MAP_TITLE"]
		blizzardtoggles.alliedRaces = L["Allied Races"]
		blizzardtoggles.animaDiversionFrame = L["Anima Diversion"]
		blizzardtoggles.artifactFrame = L["ITEM_QUALITY6_DESC"]
		blizzardtoggles.azerite = L["Azerite"]
		blizzardtoggles.azeriteEssence = L["Azerite Essence"]
		blizzardtoggles.azeriteRespec = L["AZERITE_RESPEC_TITLE"]
		blizzardtoggles.blackMarket = L["BLACK_MARKET_AUCTION_HOUSE"]
		blizzardtoggles.campsites = L["Campsite"]
		blizzardtoggles.chromieTime = L["Chromie Time Frame"]
		blizzardtoggles.cooldownManager = L["Cooldown Manager"]
		blizzardtoggles.contribution = L["Contribution"]
		blizzardtoggles.covenantPreview = L["Covenant Preview"]
		blizzardtoggles.covenantRenown = L["Covenant Renown"]
		blizzardtoggles.covenantSanctum = L["Covenant Sanctum"]
		blizzardtoggles.deathRecap = L["DEATH_RECAP_TITLE"]
		blizzardtoggles.editModeManager = L["Editor Manager"]
		blizzardtoggles.expansionLandingPage = L["Expansion Landing Page"]
		blizzardtoggles.garrison = L["GARRISON_LOCATION_TOOLTIP"]
		blizzardtoggles.genericTrait = L["Generic Trait"]
		blizzardtoggles.gmChat = L["GM Chat"]
		blizzardtoggles.guide = L["Guide Frame"]
		blizzardtoggles.guild = L["Guild"]
		blizzardtoggles.islandQueue = L["ISLANDS_HEADER"]
		blizzardtoggles.islandsPartyPose = L["Island Party Pose"]
		blizzardtoggles.itemInteraction = L["Item Interaction"]
		blizzardtoggles.itemUpgrade = L["Item Upgrade"]
		blizzardtoggles.lfguild = L["LF Guild Frame"]
		blizzardtoggles.losscontrol = L["LOSS_OF_CONTROL"]
		blizzardtoggles.majorFactions = L["Major Factions"]
		blizzardtoggles.nonraid = L["Non-Raid Frame"]
		blizzardtoggles.objectiveTracker = L["OBJECTIVES_TRACKER_LABEL"]
		blizzardtoggles.obliterum = L["OBLITERUM_FORGE_TITLE"]
		blizzardtoggles.orderHall = L["Orderhall"]
		blizzardtoggles.perksProgram = L["Trading Post"]
		blizzardtoggles.playerChoice = L["Player Choice Frame"]
		blizzardtoggles.runeforge = L["Runeforge"]
		blizzardtoggles.scrappingMachine = L["SCRAP_BUTTON"]
		blizzardtoggles.soulbinds = L["Soulbinds"]
		blizzardtoggles.talkinghead = L["Talking Head"]
		blizzardtoggles.torghastLevelPicker = L["Torghast Level Picker"]
		blizzardtoggles.voidstorage = L["VOID_STORAGE"]
		blizzardtoggles.weeklyRewards = L["Weekly Rewards"]
		blizzardtoggles.ticketStatus = L["Ticket Status"]
	elseif E.Mists then
		blizzardtoggles.arenaRegistrar = L["Arena Registrar"]
		blizzardtoggles.reforge = L["Reforge"]
	elseif E.Classic then
		blizzardtoggles.engraving = L["Engraving"]
		blizzardtoggles.battlefield = L["Battlefield"]
		blizzardtoggles.craft = L["Craft"]
	end

	local function ToggleBlizzardSkins(value)
		E:StaticPopup_Show('ProjectHopes_RL')
    for key in pairs(blizzardtoggles) do
			if key ~= 'enable' then
				E.db.ProjectHopes.skins[key] = value
			end
		end
	end
	
	POABS.Blizzard.args.disableBlizzardSkins = ACH:Execute(L["Disable Blizzard Skins"], nil, 3, function() ToggleBlizzardSkins(false) end)
	POABS.Blizzard.args.enableBlizzardSkins = ACH:Execute(L["Enable Blizzard Skins"], nil, 4, function() ToggleBlizzardSkins(true) end)
	POABS.Blizzard.args.blizzard = ACH:MultiSelect(L["Blizzard"], L["Enable/Disable this skin."], -1, blizzardtoggles, nil, nil, function(_, key) return E.db.ProjectHopes.skins[key] end, function(_, key, value) E.db.ProjectHopes.skins[key] = value; E:StaticPopup_Show('ProjectHopes_RL') end, nil, nil, true)

	POABS.ElvUI = ACH:Group(L["ElvUI"], nil, 1)
	POABS.ElvUI.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.ElvUI.args.desc.inline = true
	POABS.ElvUI.args.desc.args.feature = ACH:Description(L["Skins ElvUI frames to fit ProjectHopes."], 1, "medium")

	local elvuitoggles = {
		actionBarsBackdrop = L["Actionbars Backdrop"],
		actionBarsButton = L["Actionbars Button"],
		afk = L["AFK Mode"],
		altPowerBar = L["Alt Power"],
		chatDataPanels = L["Chat Data Panels"],
		castbar = L["CastBars"],
		chatPanels = L["Chat Panels"],
		chatVoicePanel = L["Chat Voice Panels"],
		classBars = L["Class Bars"],
		dataPanels = L["DataPanels"],
		dataBars = L["Data Bars"],
		lootRoll = L["Loot Roll"],
		options = L["Options"],
		panels = L["Panels"],
		raidUtility = L["Raid Utility"],
		staticPopup = L["Static Popup"],
		statusReport = L["Status Report"],
		totemTracker = L["Totem Tracker"],
		tooltips = L["Tooltips"],
		Minimap = L["Minimap"],
		nameplates = L["Nameplates"],
	}

	if E.Retail then
		elvuitoggles.tooltipscolor = L["Tooltips"]
	end

	local function ToggleElvUISkins(value)
		E:StaticPopup_Show('ProjectHopes_RL')
    for key, _ in pairs(elvuitoggles) do
			if key ~= 'enable' then
				E.db.ProjectHopes.skins[key] = value
			end
		end
	end

	POABS.ElvUI.args.disableElvUISkins = ACH:Execute(L["Disable ElvUI Skins"], nil, 3, function() ToggleElvUISkins(false) end)
	POABS.ElvUI.args.enableElvUISkins = ACH:Execute(L["Enable ElvUI Skins"], nil, 4, function() ToggleElvUISkins(true) end)
	POABS.ElvUI.args.elvui = ACH:MultiSelect(L["ElvUI"], L["Enable/Disable this skin."], -1, elvuitoggles, nil, nil, function(_, key) return E.db.ProjectHopes.skins[key] end, function(_, key, value) E.db.ProjectHopes.skins[key] = value; E:StaticPopup_Show('ProjectHopes_RL') end, nil, nil, true)

	E.Options.args.ProjectHopes = ProjectHopes.Options
end

--[[
	ACH:Color(name, desc, order, alpha, width, get, set, disabled, hidden)
	ACH:Description(name, order, fontSize, image, imageCoords, imageWidth, imageHeight, width, hidden)
	ACH:Execute(name, desc, order, func, image, confirm, width, get, set, disabled, hidden)
	ACH:Group(name, desc, order, childGroups, get, set, disabled, hidden, func)
	ACH:Header(name, order, get, set, hidden)
	ACH:Input(name, desc, order, multiline, width, get, set, disabled, hidden, validate)
	ACH:MultiSelect(name, desc, order, values, confirm, width, get, set, disabled, hidden)
	ACH:Range(name, desc, order, values, width, get, set, disabled, hidden)
	ACH:Select(name, desc, order, values, confirm, width, get, set, disabled, hidden)
	ACH:Spacer(order, width, hidden)
	ACH:Toggle(name, desc, order, tristate, confirm, width, get, set, disabled, hidden)
]]
