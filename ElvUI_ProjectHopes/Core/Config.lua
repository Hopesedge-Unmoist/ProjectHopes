local Name, Private = ...
local E, _, V, P, G = unpack(ElvUI)
local D = E:GetModule('Distributor');
local PI = E:GetModule('PluginInstaller');

local LSM = E.Libs.LSM

local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale)
local pairs, sort = pairs, sort
local format, tonumber, tostring = format, tonumber, tostring
local tconcat, tinsert = table.concat, table.insert
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded

local GetCVar, GetCVarBool = GetCVar, GetCVarBool
local SetCVar = SetCVar
local MiniMapButtonSelect = {NOANCHOR = 'No Anchor Bar', HORIZONTAL = 'Horizontal', VERTICAL = 'Vertical'}
local MiniMapButtonDirection = {NORMAL = 'Normal', REVERSED = 'Reversed'}
local PORTRAITANCHORPOINT = {RIGHT = 'Right', LEFT, 'Right'}

local SPECIALTHANKS = { '|cffffc607Ayije|r', '|cff14b4d3Jiberish|r', E:TextGradient('Angelos', 0.7, 0.3, 1, 1, 0.9, 0.2), }
local PLUGINSUPPORT = { 
	'|cffa207faRepooc|r',
	E:TextGradient('Simpy but my name needs to be longer.', 0.18,1.00,0.49, 0.32,0.85,1.00, 0.55,0.38,0.85, 1.00,0.55,0.71, 1.00,0.68,0.32), 
	'|cff919191Azilroka|r', 
	'|cffd1ce96Flamanis|r', 
	'|cff919191Toxi|r', 
	'|cff919191fang2shou|r',
	'|cffc4c9ceBlinkii|r',
	'|cffdb171eTrenchy|r',
	
}

local function CheckRaid()
	if tonumber(GetCVar('RAIDsettingsEnabled')) == 0 then
		return true
	end
end

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
	ProjectHopes.Options = ACH:Group("|TInterface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\phlogotiny.tga:14:14:0:0|t" .. Private.Name, nil, 20)

	local POA = ProjectHopes.Options.args

	-- Don't export this
	D.blacklistedKeys.global.ProjectHopes = {}
	D.blacklistedKeys.global.ProjectHopes.dev = true

	-- Header
	POA.logo = ACH:Description(nil, 1, nil, 'Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\ProjectHopesLeft2.tga', nil, 512, 128)

	-- Spacer
	POA.header = ACH:Spacer(2, 'full')

	-- information
	POA.information = ACH:Group(format('|cfd9b9b9b%s|r', L["Information"]), nil, 1)
	POA.information.icon = 'Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Icons\\linksicon.tga'
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
	POA.Modules = ACH:Group(L["Modules"], nil, 3, 'tab')
	POA.Modules.icon = 'Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Icons\\moduleicon.tga'

	POA.Modules.args.desc = ACH:Header(L["Modules"], 1)
	POA.Modules.args.minimap = ACH:Group(L["Rectangle Minimap"], nil, 1)
	POA.Modules.args.minimap.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.Modules.args.minimap.args.desc.inline = true
	POA.Modules.args.minimap.args.desc.args.feature = ACH:Description(L["Makes the Minimap Rectangle."], 1, "medium")
	POA.Modules.args.minimap.args.spacer = ACH:Header(L[""], 2)
	POA.Modules.args.minimap.args.minimapret = ACH:Toggle(L["Enable"], L["Toggle Rectangle Minimap."], 2, nil, false, nil,function() return E.db.ProjectHopes.minimap.Rectangle end,function(_, value) E.db.ProjectHopes.minimap.Rectangle = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.Modules.args.minimapbutton = ACH:Group(L["Minimap Buttons"], nil, 2, nil, function(info) return E.db.ProjectHopes.minimapbutton[ info[#info] ] end, function(info, value) E.db.ProjectHopes.minimapbutton[ info[#info] ] = value; MB:UpdateLayout() end)
	POA.Modules.args.minimapbutton.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.Modules.args.minimapbutton.args.desc.inline = true
	POA.Modules.args.minimapbutton.args.desc.args.feature = ACH:Description(L["Add an extra bar to collect minimap buttons."], 1, "medium")
	POA.Modules.args.minimapbutton.args.enable = ACH:Toggle(L["Enable"], L["Toggle minimap buttons bar"], 2, nil, false, nil, nil, function(info, value) E.db.ProjectHopes.minimapbutton.enable = value; E:StaticPopup_Show("ProjectHopes_RL") end)
	POA.Modules.args.minimapbutton.args.spacer = ACH:Header(L[""], 2)
	POA.Modules.args.minimapbutton.args.skinStyle = ACH:Select(L["Skin Style"], L["Change settings for how the minimap buttons are skinned"], 2, MiniMapButtonSelect, false, nil, nil, function(info, value) E.db.ProjectHopes.minimapbutton[ info[#info] ] = value; MB:UpdateSkinStyle() end, function() return not E.db.ProjectHopes.minimapbutton.enable end)
	POA.Modules.args.minimapbutton.args.layoutDirection = ACH:Select(L['Layout Direction'], L['Normal is right to left or top to bottom, or select reversed to switch directions.'], 3, MiniMapButtonDirection, false, nil, nil, nil, nil, function() return not E.db.ProjectHopes.minimapbutton.enable or E.db.ProjectHopes.minimapbutton.skinstyle == 'NOANCHOR' end)
	POA.Modules.args.minimapbutton.args.buttonSize = ACH:Range(L['Button Size'], L['The size of the minimap buttons.'], 4, { min = 16, max = 40, step = 1 }, nil, nil, nil, function() return not E.db.ProjectHopes.minimapbutton.enable or E.db.ProjectHopes.minimapbutton.skinstyle == 'NOANCHOR' end)
	POA.Modules.args.minimapbutton.args.buttonsPerRow = ACH:Range(L['Buttons per row'], L['The max number of buttons when a new row starts'], 5, { min = 4, max = 20, step = 1 }, nil, nil, nil, function() return not E.db.ProjectHopes.minimapbutton.enable or E.db.ProjectHopes.minimapbutton.skinstyle == 'NOANCHOR' end)
	POA.Modules.args.minimapbutton.args.backdrop = ACH:Toggle(L['Backdrop'], nil, 6, nil, false, nil, nil, nil, function() return not E.db.ProjectHopes.minimapbutton.enable or E.db.ProjectHopes.minimapbutton.skinstyle == 'NOANCHOR' end)
	POA.Modules.args.minimapbutton.args.border = ACH:Toggle(L['Border for Icons'], nil, 7, nil, false, nil, nil, nil, function() return not E.db.ProjectHopes.minimapbutton.enable end)
	POA.Modules.args.minimapbutton.args.mouseover = ACH:Toggle(L['Mouse Over'], L['The frame is not shown unless you mouse over the frame.'], 7, nil, false, nil, nil, function(info, value) E.db.ProjectHopes.minimapbutton.mouseover = value; MB:ChangeMouseOverSetting() end, function() return not E.db.ProjectHopes.minimapbutton.enable or E.db.ProjectHopes.minimapbutton.skinstyle == 'NOANCHOR' end)
	POA.Modules.args.minimapid = ACH:Group(L["Minimap Instance Difficulty"], nil, 3, nil, function(info) return E.db.ProjectHopes.minimapid [info[#info]] end, function(info, value) E.db.ProjectHopes.minimapid[info[#info]] = value E:StaticPopup_Show("ProjectHopes_RL") end, nil, nil, nil)
	POA.Modules.args.minimapid.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.Modules.args.minimapid.args.desc.inline = true
	POA.Modules.args.minimapid.args.desc.args.feature = ACH:Description(L["Add Instance Difficulty in text format."], 1, "medium")
	POA.Modules.args.minimapid.args.spacer = ACH:Header(L[""], 2)
	POA.Modules.args.minimapid.args.enable = ACH:Toggle(L["Enable"], nil, 3, nil, nil, nil, nil, nil, nil, nil)
	POA.Modules.args.minimapid.args.align = ACH:Select(L["Text Align"], nil, 4, {LEFT = L["Left"], CENTER = L["Center"], RIGHT = L["Right"]}, nil, nil, nil, nil, nil, nil)
	POA.Modules.args.minimapid.args.hideBlizzard = ACH:Toggle(L["Hide Blizzard Indicator"], nil, 5, nil, nil, nil, nil, nil, nil, nil)
	POA.Modules.args.minimapid.args.font = ACH:Group(L["Font"], nil, 6, nil, function(info) return E.db.ProjectHopes.minimapid.font[info[#info]] end, function(info, value) E.db.ProjectHopes.minimapid.font[info[#info]] = value E:StaticPopup_Show("ProjectHopes_RL") end, nil, nil, nil)
	POA.Modules.args.minimapid.args.font.inline = true
	POA.Modules.args.minimapid.args.font.args.name = ACH:SharedMediaFont(L["Font"], nil, 1, nil, nil, nil, nil, nil, nil, nil)
	POA.Modules.args.minimapid.args.font.args.style = ACH:Select(L["Outline"], nil, 2, {NONE = L["None"], OUTLINE = L["OUTLINE"], THICKOUTLINE = L["THICKOUTLINE"], SHADOW = L["SHADOW"], SHADOWOUTLINE = L["SHADOWOUTLINE"], SHADOWTHICKOUTLINE = L["SHADOWTHICKOUTLINE"], MONOCHROME = L["MONOCHROME"], MONOCHROMEOUTLINE = L["MONOCROMEOUTLINE"], MONOCHROMETHICKOUTLINE = L["MONOCHROMETHICKOUTLINE"]}, nil, nil, nil, nil, nil, nil)
	POA.Modules.args.minimapid.args.font.args.size = ACH:Range(L["Size"], nil, 3, { min = 5, max = 60, step = 1 }, nil, nil, nil, nil, nil)

	POA.Modules.args.overshield = ACH:Group(L["Overshield"], nil, 3, nil, nil, nil, nil, function() return not E.Retail end)
	POA.Modules.args.overshield.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.Modules.args.overshield.args.desc.inline = true
	POA.Modules.args.overshield.args.desc.args.feature = ACH:Description(L["Add a texture to Over Absorb with a Glowline at the end."], 1, "medium")
	POA.Modules.args.overshield.args.spacer = ACH:Header(L[""], 2)
	POA.Modules.args.overshield.args.absorb = ACH:Toggle(L["Enable"], L["Toggle Overshield textures."], 2, nil, false, nil,function() return E.db.ProjectHopes.overshield.Absorb end, function(_, value) E.db.ProjectHopes.overshield.Absorb = value E:StaticPopup_Show('ProjectHopes_RL') end)
	
	POA.Modules.args.customtargetborder = ACH:Group(L["Target Border"], nil, 4)
	POA.Modules.args.customtargetborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.Modules.args.customtargetborder.args.desc.inline = true
	POA.Modules.args.customtargetborder.args.desc.args.feature = ACH:Description(L["Makes the Target Border a Solid frame and bring it in front of Unitframes."], 1, "medium")
	POA.Modules.args.customtargetborder.args.spacer = ACH:Header(L[""], 2)
	POA.Modules.args.customtargetborder.args.enable = ACH:Toggle(L["Enable"], L['Toggle the Target Border frame. (Target Frame Glow MUST be enabled.)'], 2, nil, false, nil, function(info) return E.db.ProjectHopes.targetGlow.foreground end, function(info, value) E.db.ProjectHopes.targetGlow.foreground = value; TG:Update() end, disabled, hidden)
	
	POA.Modules.args.cbackdrop = ACH:Group(L["Health Backdrop"], nil, 5)
	POA.Modules.args.cbackdrop.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.Modules.args.cbackdrop.args.desc.inline = true
	POA.Modules.args.cbackdrop.args.desc.args.feature = ACH:Description(L["Changes the health backdrop texture."], 1, "medium")
	POA.Modules.args.cbackdrop.args.spacer = ACH:Header(L[""], 2)
	POA.Modules.args.cbackdrop.args.custom = ACH:Toggle(L["Enable"], nil, 3, nil, false, nil,function() return E.db.ProjectHopes.cbackdrop.Backdrop end,function(_, value) E.db.ProjectHopes.cbackdrop.Backdrop = value E:StaticPopup_Show('ProjectHopes_RL'); ProjectHopes:CustomHealthBackdrop() end)
	POA.Modules.args.cbackdrop.args.customtexture = ACH:SharedMediaStatusbar(L["Backdrop Texture"], L["Select a Texture"], 4, nil, function() return E.db.ProjectHopes.cbackdrop.customtexture end, function(_,key) E.db.ProjectHopes.cbackdrop.customtexture = key E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.ProjectHopes.cbackdrop.Backdrop end)

	-- Borders
	POA.UnitFrames = ACH:Group(L["UnitFrames"], nil, 4, 'tab')
	POA.UnitFrames.icon = 'Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Icons\\bordericon.tga'

	POA.UnitFrames.args.desc = ACH:Header(L["UnitFrames"], 1)
	POA.UnitFrames.args.general = ACH:Group(L["General"], nil, 1, nil, nil, nil, nil, nil, nil)
	POA.UnitFrames.args.general.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.UnitFrames.args.general.args.desc.inline = true
	POA.UnitFrames.args.general.args.desc.args.feature = ACH:Description(L["Adds new features to UnitFrames"], 1, "medium")
	POA.UnitFrames.args.general.args.spacer = ACH:Header(L[""], 2)
	
	POA.UnitFrames.args.general.args.glowline = ACH:Group(L["Health Glowline"], nil, 3)
	POA.UnitFrames.args.general.args.glowline.inline = true
	POA.UnitFrames.args.general.args.glowline.args.enable = ACH:Toggle(L["Health Glowline"], nil, 1, nil, false, "full", function() return E.db.ProjectHopes.unitframe.unitFramesGlowline end,function(_, value) E.db.ProjectHopes.unitframe.unitFramesGlowline = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.UnitFrames.args.general.args.glowline.args.color = ACH:Color(L["Enter Color"], nil, 2, true, "full", function() local db = E.db.ProjectHopes.unitframe.unitFramesGlowlinecolor local default = P.ProjectHopes.unitframe.unitFramesGlowlinecolor return db.r, db.g, db.b, db.a, default.r, default.g, default.b, default.a end, function(_, r, g, b, a) local db = E.db.ProjectHopes.unitframe.unitFramesGlowlinecolor db.r, db.g, db.b, db.a = r, g, b, a E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.ProjectHopes.unitframe.unitFramesGlowline end, function() return not E.db.ProjectHopes.unitframe.unitFramesGlowline end)
	POA.UnitFrames.args.general.args.glowline.args.width = ACH:Range(L["Width"], nil, 3, { min = -20, max = 20, step = 1 }, "full", function() return E.db.ProjectHopes.unitframe.unitFramesGlowlineWidth end, function(_, value) E.db.ProjectHopes.unitframe.unitFramesGlowlineWidth = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.ProjectHopes.unitframe.unitFramesGlowline end, function() return not E.db.ProjectHopes.unitframe.unitFramesGlowline end)

	POA.UnitFrames.args.general.args.portraits = ACH:Group(L["Portraits"], nil, 4)
	POA.UnitFrames.args.general.args.portraits.inline = true
	POA.UnitFrames.args.general.args.portraits.args.classPortraits = ACH:Toggle(L["Class Portrait"], L["Use Class Portraits instead of Unit Portraits"], 1, nil, false, "full", function() return E.db.ProjectHopes.unitframe.classPortraits end,function(_, value) E.db.ProjectHopes.unitframe.classPortraits = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.UnitFrames.args.general.args.portraits.args.framelevelPortraits = ACH:Range(L["Frame Level of Portrait"], L["Default: 1"], 6, { min = 1, max = 20, step = 1 }, "full", function() return E.db.ProjectHopes.unitframe.framelevelPortraits end, function(_, value) E.db.ProjectHopes.unitframe.framelevelPortraits = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.UnitFrames.args.general.args.portraits.args.playerpositionPortraits = ACH:Range(L["Offset of Player Portait"], nil, 6, { min = -100, max = 100, step = 1 }, "full", function() return E.db.ProjectHopes.unitframe.playerpositionPortraits end, function(_, value) E.db.ProjectHopes.unitframe.playerpositionPortraits = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.UnitFrames.args.general.args.portraits.args.targetpositionPortraits = ACH:Range(L["Offset of Target Portait"], nil, 6, { min = -100, max = 100, step = 1 }, "full", function() return E.db.ProjectHopes.unitframe.targetpositionPortraits end, function(_, value) E.db.ProjectHopes.unitframe.targetpositionPortraits = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.UnitFrames.args.general.args.portraits.args.focuspositionPortraits = ACH:Range(L["Offset of Focus Portait"], nil, 6, { min = -100, max = 100, step = 1 }, "full", function() return E.db.ProjectHopes.unitframe.focuspositionPortraits end, function(_, value) E.db.ProjectHopes.unitframe.focuspositionPortraits = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.UnitFrames.args.general.args.portraits.args.targettargetpositionPortraits = ACH:Range(L["Offset of TargetTarget Portait"], nil, 6, { min = -100, max = 100, step = 1 }, "full", function() return E.db.ProjectHopes.unitframe.targettargetpositionPortraits end, function(_, value) E.db.ProjectHopes.unitframe.targettargetpositionPortraits = value E:StaticPopup_Show('ProjectHopes_RL') end)

	POA.UnitFrames.args.general.args.infopanel = ACH:Group(L["InfoPanel"], nil, 5)
	POA.UnitFrames.args.general.args.infopanel.inline = true
	POA.UnitFrames.args.general.args.infopanel.args.infopanelontop = ACH:Toggle(L["InfoPanel On Top"], L["This moves the Info Panel on the top of UnitFrames"], 5, nil, false, nil, function() return E.db.ProjectHopes.unitframe.infopanelontop end,function(_, value) E.db.ProjectHopes.unitframe.infopanelontop = value E:StaticPopup_Show('ProjectHopes_RL') end)

	POA.UnitFrames.args.playerborder = ACH:Group(L["Player"], nil, 10, nil, nil, nil, function() return not E.db.unitframe.units.player.enable end, nil, nil)
	POA.UnitFrames.args.playerborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.UnitFrames.args.playerborder.args.desc.inline = true
	POA.UnitFrames.args.playerborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Player Unitframe"], 1, "medium")
	POA.UnitFrames.args.playerborder.args.spacer = ACH:Header(L[""], 2)
	POA.UnitFrames.args.playerborder.args.player = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full", function() return E.db.ProjectHopes.border.Player end,function(_, value) E.db.ProjectHopes.border.Player = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.player.enable end)
	POA.UnitFrames.args.playerborder.args.playerpor = ACH:Toggle(L["Portrait"], nil, 5, nil, false, "full", function() return E.db.ProjectHopes.border.playerpor end,function(_, value) E.db.ProjectHopes.border.playerpor = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.player.enable or not E.db.ProjectHopes.border.Player end)
	POA.UnitFrames.args.playerborder.args.playersep = ACH:Toggle(L["Power/Health Separator"], nil, 4, nil, false, "full", function() return E.db.ProjectHopes.border.Playersep end,function(_, value) E.db.ProjectHopes.border.Playersep = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.player.power.enable or not E.db.ProjectHopes.border.Player or not E.db.unitframe.units.player.enable end)

	POA.UnitFrames.args.petborder = ACH:Group(L["Pet"], nil, 11, nil, nil, nil, function() return not E.db.unitframe.units.pet.enable end, nil, nil)
	POA.UnitFrames.args.petborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.UnitFrames.args.petborder.args.desc.inline = true
	POA.UnitFrames.args.petborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Pet Unitframe"], 1, "medium")
	POA.UnitFrames.args.petborder.args.spacer = ACH:Header(L[""], 2)
	POA.UnitFrames.args.petborder.args.pet = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.Pet end,function(_, value) E.db.ProjectHopes.border.Pet = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.pet.enable end)
	
	POA.UnitFrames.args.pettargetborder = ACH:Group(L["Pet Target"], nil, 12, nil, nil, nil, function() return not E.db.unitframe.units.pettarget.enable end, nil, nil)
	POA.UnitFrames.args.pettargetborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.UnitFrames.args.pettargetborder.args.desc.inline = true
	POA.UnitFrames.args.pettargetborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Pet Target Unitframe"], 1, "medium")
	POA.UnitFrames.args.pettargetborder.args.spacer = ACH:Header(L[""], 2)
	POA.UnitFrames.args.pettargetborder.args.enable = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.PetTarget end,function(_, value) E.db.ProjectHopes.border.PetTarget = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.pettarget.enable end)
	
	POA.UnitFrames.args.targetborder = ACH:Group(L["Target"], nil, 30, nil, nil, nil, function() return not E.db.unitframe.units.target.enable end, nil, nil)
	POA.UnitFrames.args.targetborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.UnitFrames.args.targetborder.args.desc.inline = true
	POA.UnitFrames.args.targetborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Target Unitframes."], 1, "medium")
	POA.UnitFrames.args.targetborder.args.spacer = ACH:Header(L[""], 2)
	POA.UnitFrames.args.targetborder.args.target = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.Target end,function(_, value) E.db.ProjectHopes.border.Target = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.target.enable end)
	POA.UnitFrames.args.targetborder.args.targetsep = ACH:Toggle(L["Power/Health Separator"], nil, 4, nil, false, "full",function() return E.db.ProjectHopes.border.Targetsep end,function(_, value) E.db.ProjectHopes.border.Targetsep = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.target.power.enable or not E.db.ProjectHopes.border.Target end)
	POA.UnitFrames.args.targetborder.args.targetpor = ACH:Toggle(L["Portrait"], nil, 5, nil, false, "full", function() return E.db.ProjectHopes.border.targetpor end,function(_, value) E.db.ProjectHopes.border.targetpor = value E:StaticPopup_Show('ProjectHopes_RL')  end, function() return not E.db.unitframe.units.target.enable or not E.db.ProjectHopes.border.Target end)

	POA.UnitFrames.args.focusborder = ACH:Group(L["Focus"], nil, 40, nil, nil, nil, function() return not E.db.unitframe.units.focus.enable end, not E.Retail, nil)
	POA.UnitFrames.args.focusborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.UnitFrames.args.focusborder.args.desc.inline = true
	POA.UnitFrames.args.focusborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Focus Unitframes."], 1, "medium")
	POA.UnitFrames.args.focusborder.args.spacer = ACH:Header(L[""], 2)
	POA.UnitFrames.args.focusborder.args.focus = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.Focus end,function(_, value) E.db.ProjectHopes.border.Focus = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.focus.enable end)
	POA.UnitFrames.args.focusborder.args.focuspor = ACH:Toggle(L["Portrait"], nil, 5, nil, false, "full", function() return E.db.ProjectHopes.border.focuspor end,function(_, value) E.db.ProjectHopes.border.focuspor = value E:StaticPopup_Show('ProjectHopes_RL')  end, function() return not E.db.unitframe.units.focus.enable or not E.db.ProjectHopes.border.Focus end)
	
	POA.UnitFrames.args.focustargetborder = ACH:Group(L["Focus Target"], nil, 41, nil, nil, nil, function() return not E.db.unitframe.units.focustarget.enable end, not E.Retail, nil)
	POA.UnitFrames.args.focustargetborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.UnitFrames.args.focustargetborder.args.desc.inline = true
	POA.UnitFrames.args.focustargetborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Focus Target Unitframes."], 1, "medium")
	POA.UnitFrames.args.focustargetborder.args.spacer = ACH:Header(L[""], 2)
	POA.UnitFrames.args.focustargetborder.args.enable = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.FocusTarget end,function(_, value) E.db.ProjectHopes.border.FocusTarget = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.focustarget.enable end)
	
	POA.UnitFrames.args.targetoftargetborder = ACH:Group(L["Target of Target"], nil, 50, nil, nil, nil, function() return not E.db.unitframe.units.targettarget.enable end, nil, nil)
	POA.UnitFrames.args.targetoftargetborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.UnitFrames.args.targetoftargetborder.args.desc.inline = true
	POA.UnitFrames.args.targetoftargetborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Target of Target Unitframes"], 1, "medium")
	POA.UnitFrames.args.targetoftargetborder.args.spacer = ACH:Header(L[""], 2)
	POA.UnitFrames.args.targetoftargetborder.args.tot = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.TargetofTarget end,function(_, value) E.db.ProjectHopes.border.TargetofTarget = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.targettarget.enable end)
	POA.UnitFrames.args.targetoftargetborder.args.targettargetpor = ACH:Toggle(L["Portrait"], nil, 5, nil, false, "full", function() return E.db.ProjectHopes.border.targettargetpor end,function(_, value) E.db.ProjectHopes.border.targettargetpor = value E:StaticPopup_Show('ProjectHopes_RL')  end, function() return not E.db.unitframe.units.targettarget.enable or not E.db.ProjectHopes.border.TargetofTarget end)
	
	POA.UnitFrames.args.targetoftargetoftargetborder = ACH:Group(L["Target of Target of Target"], nil, 51, nil, nil, nil, function() return not E.db.unitframe.units.targettargettarget.enable end, nil, nil)
	POA.UnitFrames.args.targetoftargetoftargetborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.UnitFrames.args.targetoftargetoftargetborder.args.desc.inline = true
	POA.UnitFrames.args.targetoftargetoftargetborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Target of Target Unitframes"], 1, "medium")
	POA.UnitFrames.args.targetoftargetoftargetborder.args.spacer = ACH:Header(L[""], 2)
	POA.UnitFrames.args.targetoftargetoftargetborder.args.enable = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.TargetofTargetofTarget end,function(_, value) E.db.ProjectHopes.border.TargetofTargetofTarget = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.targettargettarget.enable end)
	
	POA.UnitFrames.args.partyborder = ACH:Group(L["Party"], nil, 60, nil, nil, nil, function() return not E.db.unitframe.units.party.enable end, nil, nil)
	POA.UnitFrames.args.partyborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.UnitFrames.args.partyborder.args.desc.inline = true
	POA.UnitFrames.args.partyborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Party Unitframe."], 1, "medium")
	POA.UnitFrames.args.partyborder.args.spacer = ACH:Header(L[""], 2)
	POA.UnitFrames.args.partyborder.args.party = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.Party end,function(_, value) E.db.ProjectHopes.border.Party = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.party.enable end)
	POA.UnitFrames.args.partyborder.args.PartySpaced = ACH:Toggle(L["Party Spaced"], nil, 4, nil, false, "full",function() return E.db.ProjectHopes.border.PartySpaced end,function(_, value) E.db.ProjectHopes.border.PartySpaced = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.party.enable end)
	POA.UnitFrames.args.partyborder.args.partysep = ACH:Toggle(L["Separator"], nil, 5, nil, false, "full",function() return E.db.ProjectHopes.border.Partysep end,function(_, value) E.db.ProjectHopes.border.Partysep = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.party.enable or not E.db.ProjectHopes.border.Party end)
	
	POA.UnitFrames.args.raidborder = ACH:Group(L["Raid"], nil, 70, nil, nil, nil, function() return not E.db.unitframe.units.raid1.enable end, nil, nil)
	POA.UnitFrames.args.raidborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.UnitFrames.args.raidborder.args.desc.inline = true
	POA.UnitFrames.args.raidborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Raid Unitframe."], 1, "medium")
	POA.UnitFrames.args.raidborder.args.spacer = ACH:Header(L[""], 2)
	POA.UnitFrames.args.raidborder.args.raid = ACH:Toggle(L["Heal"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.raid end,function(_, value) E.db.ProjectHopes.border.raid = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.raid1.enable end)
	POA.UnitFrames.args.raidborder.args.raidbackdrop = ACH:Toggle(L["Heal (Backdrop)"], nil, 4, nil, false, "full",function() return E.db.ProjectHopes.border.raidbackdrop end,function(_, value) E.db.ProjectHopes.border.raidbackdrop = value E:StaticPopup_Show('ProjectHopes_RL') end, nil, function() return not E.db.ProjectHopes.border.raid end)
	POA.UnitFrames.args.raidborder.args.raiddps = ACH:Toggle(L["DPS/TANK"], nil, 5, nil, false, "full",function() return E.db.ProjectHopes.border.raiddps end,function(_, value) E.db.ProjectHopes.border.raiddps = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.raid1.enable end)
	
	POA.UnitFrames.args.tankframeborder = ACH:Group(L["Tank Frames"], nil, 70, nil, nil, nil, function() return not E.db.unitframe.units.tank.enable end, nil, nil)
	POA.UnitFrames.args.tankframeborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.UnitFrames.args.tankframeborder.args.desc.inline = true
	POA.UnitFrames.args.tankframeborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Tank Unitframe."], 1, "medium")
	POA.UnitFrames.args.tankframeborder.args.spacer = ACH:Header(L[""], 2)
	POA.UnitFrames.args.tankframeborder.args.maintankofftank = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.Maintankofftank end,function(_, value) E.db.ProjectHopes.border.Maintankofftank = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.tank.enable end)
	POA.UnitFrames.args.assistunitborder= ACH:Group(L["Assist Units"], nil, 70, nil, nil, nil, function() return not E.db.unitframe.units.assist.enable end, nil, nil)
	POA.UnitFrames.args.assistunitborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.UnitFrames.args.assistunitborder.args.desc.inline = true
	POA.UnitFrames.args.assistunitborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Assist Unitframe."], 1, "medium")
	POA.UnitFrames.args.assistunitborder.args.spacer = ACH:Header(L[""], 2)
	POA.UnitFrames.args.assistunitborder.args.maintankofftank = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.AssistUnits end,function(_, value) E.db.ProjectHopes.border.AssistUnits = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.assist.enable end)
	
	POA.UnitFrames.args.bossborders = ACH:Group(L["Boss"], nil, 80, nil, nil, nil, function() return not E.db.unitframe.units.boss.enable end, not E.Retail, nil)
	POA.UnitFrames.args.bossborders.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.UnitFrames.args.bossborders.args.desc.inline = true
	POA.UnitFrames.args.bossborders.args.desc.args.feature = ACH:Description(L["Adds a border to the Boss Unitframes"], 1, "medium")
	POA.UnitFrames.args.bossborders.args.spacer = ACH:Header(L[""], 2)
	POA.UnitFrames.args.bossborders.args.boss = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.Boss end,function(_, value) E.db.ProjectHopes.border.Boss = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.boss.enable end)

	POA.UnitFrames.args.arenaborders = ACH:Group(L["Arena"], nil, 90, nil, nil, nil, function() return not E.db.unitframe.units.arena.enable end, not E.Retail, nil)
	POA.UnitFrames.args.arenaborders.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.UnitFrames.args.arenaborders.args.desc.inline = true
	POA.UnitFrames.args.arenaborders.args.desc.args.feature = ACH:Description(L["Adds a border to the Arena Unitframes"], 1, "medium")
	POA.UnitFrames.args.arenaborders.args.spacer = ACH:Header(L[""], 2)
	POA.UnitFrames.args.arenaborders.args.arena = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.Arena end,function(_, value) E.db.ProjectHopes.border.Arena = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.arena.enable end)
	
	POA.UnitFrames.args.auraborder = ACH:Group(L["Buffs/Debuffs"], nil, 100, 'tab')
	POA.UnitFrames.args.auraborder.args.minimap = ACH:Group(L["Minimap"], nil, 1, nil, nil, nil, function() return not E.private.auras.enable end, nil, nil)
	POA.UnitFrames.args.auraborder.args.minimap.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.UnitFrames.args.auraborder.args.minimap.args.desc.inline = true
	POA.UnitFrames.args.auraborder.args.minimap.args.desc.args.feature = ACH:Description(L["Adds a border to the Buffs and Debuffs at Minimap."], 2, "medium")
	POA.UnitFrames.args.auraborder.args.minimap.args.spacer = ACH:Header(L[""], 2)
	POA.UnitFrames.args.auraborder.args.minimap.args.aura = ACH:Toggle(L["Enable"], L["Toggle the border of Buffs and Debuffs at minimap."], 3, nil, false, "full",function() return E.db.ProjectHopes.border.Aura end,function(_, value) E.db.ProjectHopes.border.Aura = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.private.auras.enable end)
	POA.UnitFrames.args.auraborder.args.unitframes = ACH:Group(L["Unitframes"], nil, 1)
	POA.UnitFrames.args.auraborder.args.unitframes.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.UnitFrames.args.auraborder.args.unitframes.args.desc.inline = true
	POA.UnitFrames.args.auraborder.args.unitframes.args.desc.args.feature = ACH:Description(L["Adds a border to the Buffs and Debuffs on Unitframes."], 2, "medium")
	POA.UnitFrames.args.auraborder.args.unitframes.args.spacer = ACH:Header(L[""], 7)
	POA.UnitFrames.args.auraborder.args.unitframes.args.uf = ACH:Toggle(L["Enable"], L["Toggle the border of Buffs and Debuffs at Unitframes."], 8, nil, false, "full",function() return E.db.ProjectHopes.border.AuraUF end,function(_, value) E.db.ProjectHopes.border.AuraUF = value E:StaticPopup_Show('ProjectHopes_RL') end, nil)

	-- Skins
	POA.Skins = ACH:Group(L["Skins"], nil, 5, 'tab')
	POA.Skins.icon = 'Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Icons\\skinicon.tga'
	POA.Skins.args.desc = ACH:Header(L["Skins"], 1)

	local addontoggles = {}
	if E.Classic or E.Cata or E.Retail then
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
	end

	if E.Cata then
	end

	if E.Cata or E.Retail then
		if IsAddOnLoaded("Hekili") then addontoggles.hekili = L["Hekili"] end
	end

	if E.Classic or E.Cata then
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

	POA.Skins.args.AddOns = ACH:Group(L["AddOns"], nil, 1)
	POA.Skins.args.AddOns.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.Skins.args.AddOns.args.desc.inline = true
	POA.Skins.args.AddOns.args.desc.args.feature = ACH:Description(L["Skins Addons to fit ProjectHopes."], 1, "medium")
	POA.Skins.args.AddOns.args.buttonGroup = ACH:Group(L[""], nil, 3)
	POA.Skins.args.AddOns.args.buttonGroup.inline = true
	POA.Skins.args.AddOns.args.disableAddOnsSkins = ACH:Execute(L["Disable AddOns Skins"], nil, 3, function() ToggleAddOnsSkins(false) end)
	POA.Skins.args.AddOns.args.enableAddOnsSkins = ACH:Execute(L["Enable AddOns Skins"], nil, 4, function() ToggleAddOnsSkins(true) end)
	POA.Skins.args.AddOns.args.addons = ACH:MultiSelect(L["AddOns"], L["Enable/Disable this skin."], -1, addontoggles, nil, nil, function(_, key) return E.db.ProjectHopes.skins[key] end, function(_, key, value) E.db.ProjectHopes.skins[key] = value; E:StaticPopup_Show('ProjectHopes_RL') end, nil, nil, true)

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
		tooltip = L["Tooltip"],
		trade = L["TRADE"],
		tradeskill = L["TRADESKILLS"],
		trainer = L["Trainer Frame"],
		tutorial = L["Tutorials"],
		worldMap = L["WORLD_MAP"]
	}

	if E.Cata or E.Retail then
		blizzardtoggles.achievementFrame = L["ACHIEVEMENTS"]
		blizzardtoggles.alertframes = L["Alert Frames"]
		blizzardtoggles.archaeology = L["Archaeology Frame"]
		blizzardtoggles.barbershop = L["BARBERSHOP"]
		blizzardtoggles.calendar = L["Calendar Frame"]
		blizzardtoggles.collections = L["COLLECTIONS"]
		blizzardtoggles.encounterJournal = L["ENCOUNTER_JOURNAL"]
		blizzardtoggles.subscriptionInterstitial = L["Subscription Interstitial"]
		blizzardtoggles.guildBank = L["Guild Bank"]
		blizzardtoggles.pvp = L["PvP Frames"]
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
		blizzardtoggles.chromieTime = L["Chromie Time Frame"]
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
		blizzardtoggles.lossOfControl = L["LOSS_OF_CONTROL"]
		blizzardtoggles.majorFactions = L["Major Factions"]
		blizzardtoggles.nonraid = L["Non-Raid Frame"]
		blizzardtoggles.objectiveTracker = L["OBJECTIVES_TRACKER_LABEL"]
		blizzardtoggles.obliterum = L["OBLITERUM_FORGE_TITLE"]
		blizzardtoggles.orderHall = L["Orderhall"]
		blizzardtoggles.perksProgram = L["Trading Post"]
		blizzardtoggles.petBattle = L["Pet Battle"]
		blizzardtoggles.playerChoice = L["Player Choice Frame"]
		blizzardtoggles.runeforge = L["Runeforge"]
		blizzardtoggles.scrappingMachine = L["SCRAP_BUTTON"]
		blizzardtoggles.soulbinds = L["Soulbinds"]
		blizzardtoggles.talkingHead = L["Talking Head"]
		blizzardtoggles.torghastLevelPicker = L["Torghast Level Picker"]
		blizzardtoggles.transmogrify = L["TRANSMOGRIFY"]
		blizzardtoggles.ticketStatus = L["Ticket Status"]
		blizzardtoggles.voidstorage = L["VOID_STORAGE"]
		blizzardtoggles.weeklyRewards = L["Weekly Rewards"]
	elseif E.Cata then
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
	
	POA.Skins.args.Blizzard = ACH:Group(L["Blizzard"], nil, 1)
	POA.Skins.args.Blizzard.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.Skins.args.Blizzard.args.desc.inline = true
	POA.Skins.args.Blizzard.args.desc.args.feature = ACH:Description(L["Skins Blizzard frames to fit ProjectHopes."], 1, "medium")
	POA.Skins.args.Blizzard.args.spacer = ACH:Header(L[""], 2)
	POA.Skins.args.Blizzard.args.buttonGroup = ACH:Group(L[""], nil, 3)
	POA.Skins.args.Blizzard.args.buttonGroup.inline = true
	POA.Skins.args.Blizzard.args.disableBlizzardSkins = ACH:Execute(L["Disable Blizzard Skins"], nil, 3, function() ToggleBlizzardSkins(false) end)
	POA.Skins.args.Blizzard.args.enableBlizzardSkins = ACH:Execute(L["Enable Blizzard Skins"], nil, 4, function() ToggleBlizzardSkins(true) end)
	POA.Skins.args.Blizzard.args.blizzard = ACH:MultiSelect(L["Blizzard"], L["Enable/Disable this skin."], -1, blizzardtoggles, nil, nil, function(_, key) return E.db.ProjectHopes.skins[key] end, function(_, key, value) E.db.ProjectHopes.skins[key] = value; E:StaticPopup_Show('ProjectHopes_RL') end, nil, nil, true)

	local elvuitoggles = {
		actionBarsBackdrop = L["Actionbars Backdrop"],
		actionBarsButton = L["Actionbars Button"],
		afk = L["AFK Mode"],
		altPowerBar = L["Alt Power"],
		chatDataPanels = L["Chat Data Panels"],
		chatPanels = L["Chat Panels"],
		chatVoicePanel = L["Chat Voice Panels"],
		lootRoll = L["Loot Roll"],
		options = L["Options"],
		panels = L["Panels"],
		raidUtility = L["Raid Utility"],
		staticPopup = L["Static Popup"],
		statusReport = L["Status Report"],
		totemTracker = L["Totem Tracker"],
		tooltips = L["Tooltips"],
		Minimap = L["Minimap"],
		dataPanels = L["DataPanels"],
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

	POA.Skins.args.Elvui = ACH:Group(L["ElvUI"], nil, 1)
	POA.Skins.args.Elvui.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.Skins.args.Elvui.args.desc.inline = true
	POA.Skins.args.Elvui.args.desc.args.feature = ACH:Description(L["Skins ElvUi frames to fit ProjectHopes."], 1, "medium")
	POA.Skins.args.Elvui.args.disableElvUISkins = ACH:Execute(L["Disable ElvUI Skins"], nil, 3, function() ToggleElvUISkins(false) end)
	POA.Skins.args.Elvui.args.enableElvUISkins = ACH:Execute(L["Enable ElvUI Skins"], nil, 4, function() ToggleElvUISkins(true) end)
	POA.Skins.args.Elvui.args.elvui = ACH:MultiSelect(L["ElvUI"], L["Enable/Disable this skin."], -1, elvuitoggles, nil, nil, function(_, key) return E.db.ProjectHopes.skins[key] end, function(_, key, value) E.db.ProjectHopes.skins[key] = value; E:StaticPopup_Show('ProjectHopes_RL') end, nil, nil, true)

	-- Quality Of Life
	POA.qualityOfLife = ACH:Group(L["Quality Of Life"], nil, 6, 'tab')
	POA.qualityOfLife.icon = 'Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Icons\\qolicon.tga'
	POA.qualityOfLife.args.misc = ACH:Group(L["Misc"], nil, 1, nil, function(info) return E.private.ProjectHopes.qualityOfLife[info[#info]] end, function(info, value) E.private.ProjectHopes.qualityOfLife[info[#info]] = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.qualityOfLife.args.misc.args.header1 = ACH:Header(L["Misc"], 2)
	POA.qualityOfLife.args.misc.args.easyDelete = ACH:Toggle(L["Easy Delete"], L["Automatically fill out the confirmation text to delete items."], 3, nil, false, 'full')
	POA.qualityOfLife.args.misc.args.autoAcceptQuests = ACH:Toggle(L["Auto Accept/Complete Quests"], L["Automatically accepts and complete quests, when not holding SHIFT"], 4, nil, false, 'full')
	POA.qualityOfLife.args.misc.args.borederDarkmode = ACH:Toggle(L["Border Darkmode"], L["Changes the border used to black, works on Plater and Weakauras."], 4, nil, false, 'full')
	POA.qualityOfLife.args.misc.args.fastLoot = ACH:Toggle(L["Fast Loot"], nil, 4, nil, false, 'full')
	POA.qualityOfLife.args.misc.args.detailsResize = ACH:Toggle(L["Details AutoResizer"], L["Resize Details Window 2 based on Zone type.\n   - Shows 2 players for none/party zone.\n   - Shows 5 players in raid zone."], 4, nil, false, 'full')

	if E.Retail then
		POA.qualityOfLife.args.misc.args.upgradeLevel = ACH:Toggle(L["Tooltip Upgrade Level"], L["Tooltip: Shows Upgrade Level of items."], 4, nil, false, 'full')
		POA.qualityOfLife.args.misc.args.hideCrafter = ACH:Toggle(L["Hide Crafter"], L["Tooltip: Hides crafter of item."],  4, nil, false, 'full')
		POA.qualityOfLife.args.misc.args.mplusimprovements = ACH:Toggle(L["Mythic+ Tab Improvements"], nil, 4, nil, false, 'full', function() return E.db.ProjectHopes.qualityOfLife.mplusimprovements end,function(_, value) E.db.ProjectHopes.qualityOfLife.mplusimprovements = value E:StaticPopup_Show('ProjectHopes_RL') end)
	
		POA.qualityOfLife.args.automation = ACH:Group(L["Automation"], nil, 2, nil, function(info) return E.private.ProjectHopes.qualityOfLife.automation[info[#info]] end, function(info, value) E.private.ProjectHopes.qualityOfLife.automation[info[#info]] = value E:StaticPopup_Show("ProjectHopes_RL") end)
		POA.qualityOfLife.args.automation.args.desc = ACH:Group(L["Description"], nil, 1)
		POA.qualityOfLife.args.automation.args.desc.inline = true
		POA.qualityOfLife.args.automation.args.desc.args.feature = ACH:Description(L["This module provides the some automations to make life better."], 1, "medium")
		POA.qualityOfLife.args.automation.args.resurrect = ACH:Toggle(L["Accept Resurrect"], nil, 2, nil, nil, 1.5)
		POA.qualityOfLife.args.automation.args.combatresurrect = ACH:Toggle(L["Combat Accept Resurrect"], nil, 2, nil, nil, 1.5)
	end

	POA.qualityOfLife.args.frameMover = ACH:Group(L["Frame Mover"], nil, 2, nil, function(info) return E.private.ProjectHopes.qualityOfLife.frameMover[info[#info]] end, function(info, value) E.private.ProjectHopes.qualityOfLife.frameMover[info[#info]] = value E:StaticPopup_Show("ProjectHopes_RL") end)
	POA.qualityOfLife.args.frameMover.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.qualityOfLife.args.frameMover.args.desc.inline = true
	POA.qualityOfLife.args.frameMover.args.desc.args.feature = ACH:Description(L["This module provides the feature that repositions the frames with drag and drop."], 1, "medium")
	POA.qualityOfLife.args.frameMover.args.enable = ACH:Toggle(L["Enable"], nil, 1)
	POA.qualityOfLife.args.frameMover.args.elvUIBags = ACH:Toggle(L["Move ElvUI Bags"], nil, 2, nil, nil, nil, nil, nil, function() return not E.private.ProjectHopes.qualityOfLife.frameMover.enable end)
	POA.qualityOfLife.args.frameMover.args.remember = ACH:Group(L["Remeber Positions"], nil, 3, nil, nil, nil, function() return not E.private.ProjectHopes.qualityOfLife.frameMover.enable end)
	POA.qualityOfLife.args.frameMover.args.remember.inline = true
	POA.qualityOfLife.args.frameMover.args.remember.args.rememberPositions = ACH:Toggle(L["Enable"], nil, 2, nil, nil, nil, nil, nil, function(info, value) E.private.ProjectHopes.qualityOfLife.frameMover[info[#info]] = value end)
	POA.qualityOfLife.args.frameMover.args.remember.args.clearHistory = ACH:Toggle(L["Clear History"], nil, 2, nil, nil, nil, nil, function() E.private.ProjectHopes.qualityOfLife.frameMover.framePositions = {} end)

	POA.qualityOfLife.args.weakAurasAnchors = ACH:Group(L["Weakauras Anchors"], nil, 2, nil)
	POA.qualityOfLife.args.weakAurasAnchors.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.qualityOfLife.args.weakAurasAnchors.args.desc.inline = true
	POA.qualityOfLife.args.weakAurasAnchors.args.desc.args.feature1 = ACH:Description(L["This module provides the feature to add Anchors within ElvUI to anchor weakuras to."], 1, "medium")
	POA.qualityOfLife.args.weakAurasAnchors.args.enable = ACH:Toggle(L["Enable"], nil, 2, nil, false, "full",function() return E.private.ProjectHopes.qualityOfLife.weakAurasAnchors end,function(_, value) E.private.ProjectHopes.qualityOfLife.weakAurasAnchors = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.qualityOfLife.args.weakAurasAnchors.args.spacer = ACH:Spacer(3)
	POA.qualityOfLife.args.weakAurasAnchors.args.desc2 = ACH:Group(L["How does it work?"], nil, 3, nil, nil, nil, nil, function() return not E.private.ProjectHopes.qualityOfLife.weakAurasAnchors end)
	POA.qualityOfLife.args.weakAurasAnchors.args.desc2.inline = true
	POA.qualityOfLife.args.weakAurasAnchors.args.desc2.args.feature1 = ACH:Description(L["You go into '"].."|cffffc607/wa|r"..L["', and find the weakaura you want to anchor to the new Anchor Frames."], 1, "medium")
	POA.qualityOfLife.args.weakAurasAnchors.args.desc2.args.feature2 = ACH:Description(L["Once you have found the weakaura, scroll down in '"].."|cffffc607Display|r"..L["' in single weakura or '"].."|cffffc607Group|r"..L["' in group, until you find '"].."|cffffc607Position and Size Settings|r"..L["'."], 2, "medium")
	POA.qualityOfLife.args.weakAurasAnchors.args.desc2.args.feature3 = ACH:Description(L["When you have expanded '"].."|cffffc607Position and Size Settings|r"..L["' type in the name off one of the new custom Anchors."], 3, "medium")
	POA.qualityOfLife.args.weakAurasAnchors.args.desc2.args.feature4 = ACH:Description(L["\n"].."|cffffc607Anchor Names|r"..L[":\n"].."|cff81c783ProjectHopesBarAnchor|r"..L["\n"].."|cff81c783ProjectHopesExtraBarAnchor|r"..L["\n"].."|cff81c783ProjectHopesExtraIconAnchor|r"..L["\n"].."|cff81c783ProjectHopesExtraIconAnchor|r"..L["\n"].."|cff81c783ProjectHopesTextAnchor|r"..L["\n"], 4, "medium")
	POA.qualityOfLife.args.weakAurasAnchors.args.desc2.args.feature5 = ACH:Description(L["After you have typed in one of the anchors, you can go to '"].."|cffffc607/emove|r"..L["' and select '"]..Private.Name..L["' in the '"].."|cffffc607Config Mode|r"..L["' move the Anchors around."], 5, "medium")
	POA.qualityOfLife.args.weakAurasAnchors.args.desc2.args.feature6 = ACH:Description(" ", 6, nil, 'Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\WeakauraAnchorDemo.tga', nil, 512, 512)

	-- Tags
	POA.tags = ACH:Group(L["Tags"], nil, 7)
	POA.tags.icon = 'Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Icons\\tagsicon.tga'

	POA.tags.args.header = ACH:Header(L["Tags"], 1)
	POA.tags.args.spacer = ACH:Spacer(2, 'full')
	POA.tags.args.tag1 = ACH:Input(L["Shows the Units role when selected."], nil, 3, nil, 'full', function() return '[Hopes:role]' end, nil, nil)
	POA.tags.args.tag2 = ACH:Input(L["Shows the percent health and absorb without %."], nil, 3, nil, 'full', function() return '[Hopes:perhp]' end, nil, nil, not E.Retail)
	POA.tags.args.tag3 = ACH:Input(L["Shows the Units raidmarker when selected."], nil, 3, nil, 'full', function() return '[Hopes:raidmarker]' end, nil, nil)
	POA.tags.args.tag4 = ACH:Input(L["Shows the Leader Icon or Assist icon if the unit is Leader or Assist."], nil, 3, nil, 'full', function() return '[Hopes:leader]' end, nil, nil, not E.Retail)
	POA.tags.args.tag5 = ACH:Input(L["Shows heal absorb on unit."], nil, 3, nil, 'full', function() return '[Hopes:healabsorbs]' end, nil, nil, not E.Retail)
	POA.tags.args.tag6 = ACH:Input(L["Shows the percent health and absorb without %, and hide it when 0 or 100"], nil, 3, nil, 'full', function() return '[Hopes:perpp]' end, nil, nil, not E.Retail)

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
