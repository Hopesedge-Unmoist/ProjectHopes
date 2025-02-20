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

local SPECIALTHANKS = { '|cffffc607Ayije|r', '|cff14b4d3Jiberish|r' }
local PLUGINSUPPORT = { 
	'|cffa207faRepooc|r',
	E:TextGradient('Simpy but my name needs to be longer.', 0.18,1.00,0.49, 0.32,0.85,1.00, 0.55,0.38,0.85, 1.00,0.55,0.71, 1.00,0.68,0.32), 
	'|cff919191Azilroka|r', 
	'|cffd1ce96Flamanis|r', 
	'|cff919191Toxi|r', 
	'|cff919191fang2shou|r',
	'|cffc4c9ceBlinkii|r',
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

	local addonskins = {
		"warpdeplete",
		"bigwigsqueue",
		"auctionator",
		"bugsack",
		"raiderio",
		"omnicd",
		"rareScanner",
		"hekili",
		"weakAurasOptions",
		"simulationcraft",
		"Baganator",
		"details",
		"detailsresize",
		"mazeHelper",
		"talentTreeTweaks",
		"talentLoadoutsEx",
		"choreTracker",
		"threatClassic2",
		"spy",
		"dbm",
	}
	POA.Skins.args.desc = ACH:Header(L["Skins"], 1)
	POA.Skins.args.AddOns = ACH:Group(L["AddOns"], nil, 1)
	POA.Skins.args.AddOns.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.Skins.args.AddOns.args.desc.inline = true
	POA.Skins.args.AddOns.args.desc.args.feature = ACH:Description(L["Skins Addons to fit ProjectHopes."], 1, "medium")
	POA.Skins.args.AddOns.args.spacer = ACH:Header(L[""], 2)
	POA.Skins.args.AddOns.args.buttonGroup = ACH:Group(L[""], nil, 3)
	POA.Skins.args.AddOns.args.buttonGroup.inline = true
	POA.Skins.args.AddOns.args.buttonGroup.args.enableAll = ACH:Execute(L["Enable All"], nil, 1, function() for _, skin in ipairs(addonskins) do E.db.ProjectHopes.skins[skin] = true end E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.Skins.args.AddOns.args.buttonGroup.args.disableAll = ACH:Execute(L["Disable All"], nil, 2, function() for _, skin in ipairs(addonskins) do E.db.ProjectHopes.skins[skin] = false end E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.Skins.args.AddOns.args.warpDeplete = ACH:Toggle(L["WarpDeplete"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.warpdeplete end,function(_, value) E.db.ProjectHopes.skins.warpdeplete = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not IsAddOnLoaded("WarpDeplete") end)
	POA.Skins.args.AddOns.args.bigwigsqueue = ACH:Toggle(L["BigWigs Queue"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.bigwigsqueue end,function(_, value) E.db.ProjectHopes.skins.bigwigsqueue = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not IsAddOnLoaded("BigWigs") end)
	POA.Skins.args.AddOns.args.auctionator = ACH:Toggle(L["Auctionator"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.auctionator end,function(_, value) E.db.ProjectHopes.skins.auctionator = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not IsAddOnLoaded("Auctionator") end)
	POA.Skins.args.AddOns.args.bugsack = ACH:Toggle(L["BugSack"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.bugsack end,function(_, value) E.db.ProjectHopes.skins.bugsack = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not IsAddOnLoaded("BugSack") end)
	POA.Skins.args.AddOns.args.raiderio = ACH:Toggle(L["RaiderIO"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.raiderio end,function(_, value) E.db.ProjectHopes.skins.raiderio = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not IsAddOnLoaded("RaiderIO") end)
	POA.Skins.args.AddOns.args.omnicd = ACH:Toggle(L["OmniCD"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.omnicd end,function(_, value) E.db.ProjectHopes.skins.omnicd = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not IsAddOnLoaded("OmniCD") end)
	POA.Skins.args.AddOns.args.rareScanner = ACH:Toggle(L["Rare Scanner"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.rareScanner end,function(_, value) E.db.ProjectHopes.skins.rareScanner = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not IsAddOnLoaded("RareScanner") end)
	POA.Skins.args.AddOns.args.hekili = ACH:Toggle(L["Hekili"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.hekili end,function(_, value) E.db.ProjectHopes.skins.hekili = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not IsAddOnLoaded("Hekili") end)
	POA.Skins.args.AddOns.args.weakAurasOptions = ACH:Toggle(L["Weakauras Option"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.weakAurasOptions end,function(_, value) E.db.ProjectHopes.skins.weakAurasOptions = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not IsAddOnLoaded("Weakauras") end)
	POA.Skins.args.AddOns.args.simulationcraft = ACH:Toggle(L["Simulationcraft"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.simulationcraft end,function(_, value) E.db.ProjectHopes.skins.simulationcraft = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not IsAddOnLoaded("Simulationcraft") end)
	POA.Skins.args.AddOns.args.Baganator = ACH:Toggle(L["Baganator"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.Baganator end,function(_, value) E.db.ProjectHopes.skins.Baganator = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not IsAddOnLoaded("Baganator") end)
	POA.Skins.args.AddOns.args.details = ACH:Toggle(L["Details"], L["Adds a border, background and separators to Details\n\n|cFFFF0000This will only work 100% with ProjectHopes Details Profile.|r"], 3, nil, false, nil, function() return E.db.ProjectHopes.skins.details end,function(_, value) E.db.ProjectHopes.skins.details = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not IsAddOnLoaded("Details") end)
	POA.Skins.args.AddOns.args.detailsResize = ACH:Toggle(L["Details AutoResizer"], L["Resize Details Window 2 based on Zone type.\n   - Shows 2 players for none/party zone.\n   - Shows 5 players in raid zone."], 3, nil, false, nil, function() return E.db.ProjectHopes.skins.detailsresize end,function(_, value) E.db.ProjectHopes.skins.detailsresize = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.ProjectHopes.skins.details end, function() return not E.db.ProjectHopes.skins.details end)
	POA.Skins.args.AddOns.args.mazeHelper = ACH:Toggle(L["Maze Helper"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.mazeHelper end,function(_, value) E.db.ProjectHopes.skins.mazeHelper = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not IsAddOnLoaded("MazeHelper") end)
	POA.Skins.args.AddOns.args.talentTreeTweaks = ACH:Toggle(L["Talent Tree Tweaks"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.talentTreeTweaks end,function(_, value) E.db.ProjectHopes.skins.talentTreeTweaks = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not IsAddOnLoaded("TalentTreeTweaks") end)
	POA.Skins.args.AddOns.args.talentLoadoutsEx = ACH:Toggle(L["Talent Loadouts Ex"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.talentLoadoutsEx end,function(_, value) E.db.ProjectHopes.skins.talentLoadoutsEx = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not IsAddOnLoaded("TalentLoadoutsEx") end)
	POA.Skins.args.AddOns.args.choreTracker = ACH:Toggle(L["Chore Tracker"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.choreTracker end,function(_, value) E.db.ProjectHopes.skins.choreTracker = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not IsAddOnLoaded("ChoreTracker") end)
	POA.Skins.args.AddOns.args.ranker = ACH:Toggle(L["Ranker"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.ranker end,function(_, value) E.db.ProjectHopes.skins.ranker = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not IsAddOnLoaded("Ranker") end)


	local blizzardskins
	if E.Retail then
		blizzardskins = {
			"achievementFrame",
			"adventureMap",
			"addonList",
			"alertframes",
			"alliedRaces",
			"animaDiversionFrame",
			"artifactFrame",
			"auctionHouse",
			"azerite",
			"archaeologyFrame",
			"azeriteEssence",
			"azeriteRespec",
			"barbershop",
			"bag",
			"battleNet",
			"binding",
			"blackMarket",
			"calendar",
			"challenges",
			"channels",
			"chatConfig",
			"character",
			"chromieTime",
			"classTalent",
			"clickBinding",
			"collections",
			"contribution",
			"transmogrify",
			"communities",
			"covenantPreview",
			"covenantRenown",
			"covenantSanctum",
			"debugTools",
			"deathRecap",
			"dressingRoom",
			"editModeManager",
			"encounterJournal",
			"eventTrace",
			"expansionLandingPage",
			"flightMap",
			"friends",
			"garrison", 
			"genericTrait",
			"gossip",
			"guild",
			"guildBank",
			"guildControl",
			"guildRegistrar",
			"guide",
			"help",
			"inputMethodEditor",
			"inspect",
			"itemInteraction",
			"itemSocketing",
			"itemUpgrade",
			"islandQueue",
			"islandsPartyPose",
			"lookingForGroup",
			"lfguild",
			"loot",
			"lossOfControl",
			"macro",
			"mail",
			"majorFactions",
			"merchant",
			"microButtons",
			"mirrorTimers",
			"misc",
			"objectiveTracker",
			"obliterum",
			"orderHall",
			"perksProgram",
			"petBattle",
			"petition",
			"playerChoice",
			"professions",
			"professionsCustomerOrders",
			"bgscore",
			"quest",
			"questChoice",
			"runeforge",
			"scenario",
			"scrappingMachine",
			"settingsPanel",
			"soulbinds",
			"spellBook",
			"blizzardstaticPopup",
			"stable",
			"subscriptionInterstitial",
			"tabard",
			"talkingHead",
			"taxi",
			"ticketStatus",
			"timeManager",
			"tooltips",
			"tooltipscolor",
			"torghastLevelPicker",
			"trade",
			"trainer",
			"tutorial",
			"voidstorage",
			"warboard",
			"weeklyRewards",
			"worldMap",
		}
	elseif E.Classic then
		blizzardskins = {
			"addonList",
			"auctionHouse",
			"battleNet",
			"channels",
			"character",
			"communities",
			"debugTools",
			"dressingRoom",
			"eventTrace",
			"flightMap",
			"friends",
			"gossip",
			"guildControl",
			"guildRegistrar",
			"help",
			"inputMethodEditor",
			"inspect",
			"lookingForGroup",
			"loot",
			"macro",
			"mail",
			"merchant",
			"mirrorTimers",
			"misc",
			"petition",
			"quest",
			"settingsPanel",
			"spellBook",
			"stable",
			"subscriptionInterstitial",
			"tabard",
			"taxi",
			"timeManager",
			"tooltips",
			"trade",
			"trainer",
			"tutorial",
			"worldMap",
			"battlefield",
			"bgmap",
			"bgscore",
			"craft",
			"engraving",
			"gmChat",
			"questTimers",
			"talent",
			"tradeskill",    
		}
	elseif E.Cata then
		blizzardskins = {
			"achievementFrame",
			"addonList",
			"auctionHouse",
			"barbershop",
			"battleNet",
			"bgmap",
			"bgscore",
			"settingsPanel",
			"calendar",
			"channels",
			"character",
			"collections",
			"transmogrify",
			"communities",
			"debugTools",
			"dressingRoom",
			"encounterJournal",
			"eventTrace",
			"friends",
			"gossip",
			"guildControl",
			"guildRegistrar",
			"help",
			"inputMethodEditor",
			"inspect",
			"lookingForGroup",
			"loot",
			"macro",
			"mail",
			"misc",
			"merchant",
			"mirrorTimers",
			"petition",
			"quest",
			"runeforge",
			"settingsPanel",
			"itemSocketing",
			"spellBook",
			"stable",
			"tabard",
			"talent",
			"taxi",
			"timeManager",
			"tooltips",
			"trade",
			"tradeskill",
			"trainer",
			"worldMap",  
		}
	end
	
	POA.Skins.args.Blizzard = ACH:Group(L["Blizzard"], nil, 1)
	POA.Skins.args.Blizzard.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.Skins.args.Blizzard.args.desc.inline = true
	POA.Skins.args.Blizzard.args.desc.args.feature = ACH:Description(L["Skins Blizzard frames to fit ProjectHopes."], 1, "medium")
	POA.Skins.args.Blizzard.args.spacer = ACH:Header(L[""], 2)
	POA.Skins.args.Blizzard.args.buttonGroup = ACH:Group(L[""], nil, 3)
	POA.Skins.args.Blizzard.args.buttonGroup.inline = true
	POA.Skins.args.Blizzard.args.buttonGroup.args.enableAll = ACH:Execute(L["Enable All"], nil, 1, function() for _, skin in ipairs(blizzardskins) do E.db.ProjectHopes.skins[skin] = true end E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.Skins.args.Blizzard.args.buttonGroup.args.disableAll = ACH:Execute(L["Disable All"], nil, 2, function() for _, skin in ipairs(blizzardskins) do E.db.ProjectHopes.skins[skin] = false end E:StaticPopup_Show('ProjectHopes_RL') end)
	
	if E.Retail then
		POA.Skins.args.Blizzard.args.achievementFrame = ACH:Toggle(L["Achievements"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.achievementFrame end,function(_, value) E.db.ProjectHopes.skins.achievementFrame = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.adventureMap = ACH:Toggle(L["Adventure Map"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.adventureMap end,function(_, value) E.db.ProjectHopes.skins.adventureMap = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.addonList = ACH:Toggle(L["AddOn Manager"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.addonList end,function(_, value) E.db.ProjectHopes.skins.addonList = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.alertframes = ACH:Toggle(L["Alert Frames"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.alertframes end,function(_, value) E.db.ProjectHopes.skins.alertframes = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.alliedRaces = ACH:Toggle(L["Allied Races"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.alliedRaces end,function(_, value) E.db.ProjectHopes.skins.alliedRaces = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.animaDiversionFrame = ACH:Toggle(L["Anima Diversion"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.animaDiversionFrame end,function(_, value) E.db.ProjectHopes.skins.animaDiversionFrame = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.artifactFrame = ACH:Toggle(L["Artifact"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.artifactFrame end,function(_, value) E.db.ProjectHopes.skins.artifactFrame = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.auctionHouse = ACH:Toggle(L["Auction House"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.auctionHouse end,function(_, value) E.db.ProjectHopes.skins.auctionHouse = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.azerite = ACH:Toggle(L["Azerite"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.azerite end,function(_, value) E.db.ProjectHopes.skins.azerite = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.archaeology = ACH:Toggle(L["Archaeology"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.archaeologyFrame end,function(_, value) E.db.ProjectHopes.skins.archaeologyFrame = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.azeriteEssence = ACH:Toggle(L["Azerite Essence"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.azeriteEssence end,function(_, value) E.db.ProjectHopes.skins.azeriteEssence = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.azeriteRespec = ACH:Toggle(L["Azerite Respec"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.azeriteRespec end,function(_, value) E.db.ProjectHopes.skins.azeriteRespec = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.barbershop = ACH:Toggle(L["Barber Shop"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.barbershop end,function(_, value) E.db.ProjectHopes.skins.barbershop = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.bag = ACH:Toggle(L["Bag/Bank"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.bag end,function(_, value) E.db.ProjectHopes.skins.bag = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.battleNet = ACH:Toggle(L["Battle Net"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.battleNet end,function(_, value) E.db.ProjectHopes.skins.battleNet = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.binding = ACH:Toggle(L["Binding"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.binding end,function(_, value) E.db.ProjectHopes.skins.binding = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.blackMarket = ACH:Toggle(L["Black Market"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.blackMarket end,function(_, value) E.db.ProjectHopes.skins.blackMarket = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.calendar = ACH:Toggle(L["Calendar"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.calendar end,function(_, value) E.db.ProjectHopes.skins.calendar = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.challenges = ACH:Toggle(L["Challenges"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.challenges end,function(_, value) E.db.ProjectHopes.skins.challenges = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.channels = ACH:Toggle(L["Channels"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.channels end,function(_, value) E.db.ProjectHopes.skins.channels = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.chatConfig = ACH:Toggle(L["Chat Config"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.chatConfig end,function(_, value) E.db.ProjectHopes.skins.chatConfig = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.character = ACH:Toggle(L["Character"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.character end,function(_, value) E.db.ProjectHopes.skins.character = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.chromieTime = ACH:Toggle(L["Chromie Time"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.chromieTime end,function(_, value) E.db.ProjectHopes.skins.chromieTime = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.classTalent = ACH:Toggle(L["Class Talent"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.classTalent end,function(_, value) E.db.ProjectHopes.skins.classTalent = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.clickBinding = ACH:Toggle(L["Click Binding"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.clickBinding end,function(_, value) E.db.ProjectHopes.skins.clickBinding = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.collections = ACH:Toggle(L["Collections"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.collections end,function(_, value) E.db.ProjectHopes.skins.collections = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.contribution = ACH:Toggle(L["Contribution"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.contribution end,function(_, value) E.db.ProjectHopes.skins.contribution = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.transmogrify = ACH:Toggle(L["Transmogrify"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.transmogrify end,function(_, value) E.db.ProjectHopes.skins.transmogrify = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.communities = ACH:Toggle(L["Communities"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.communities end,function(_, value) E.db.ProjectHopes.skins.communities = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.covenantPreview = ACH:Toggle(L["Covenant Preview"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.covenantPreview end,function(_, value) E.db.ProjectHopes.skins.covenantPreview = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.covenantRenown = ACH:Toggle(L["Covenant Renown"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.covenantRenown end,function(_, value) E.db.ProjectHopes.skins.covenantRenown = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.covenantSanctum = ACH:Toggle(L["Covenant Sanctum"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.covenantSanctum end,function(_, value) E.db.ProjectHopes.skins.covenantSanctum = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.debugTools = ACH:Toggle(L["Debug Tools"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.debugTools end,function(_, value) E.db.ProjectHopes.skins.debugTools = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.deathRecap = ACH:Toggle(L["Death Recap"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.deathRecap end,function(_, value) E.db.ProjectHopes.skins.deathRecap = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.dressingRoom = ACH:Toggle(L["Dressing Room"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.dressingRoom end,function(_, value) E.db.ProjectHopes.skins.dressingRoom = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.editModeManager = ACH:Toggle(L["Edit Mode Manager"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.editModeManager end,function(_, value) E.db.ProjectHopes.skins.editModeManager = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.encounterJournal = ACH:Toggle(L["Encounter Journal"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.encounterJournal end,function(_, value) E.db.ProjectHopes.skins.encounterJournal = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.eventTrace = ACH:Toggle(L["Event Trace"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.eventTrace end,function(_, value) E.db.ProjectHopes.skins.eventTrace = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.expansionLandingPage = ACH:Toggle(L["Expansion Landing Page"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.expansionLandingPage end,function(_, value) E.db.ProjectHopes.skins.expansionLandingPage = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.flightMap = ACH:Toggle(L["Flight Map"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.flightMap end,function(_, value) E.db.ProjectHopes.skins.flightMap = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.friends = ACH:Toggle(L["Friend List"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.friends end,function(_, value) E.db.ProjectHopes.skins.friends = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.garrison = ACH:Toggle(L["Garrison"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.garrison end,function(_, value) E.db.ProjectHopes.skins.garrison = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.genericTrait = ACH:Toggle(L["Generic Trait"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.genericTrait end,function(_, value) E.db.ProjectHopes.skins.genericTrait = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.gossip = ACH:Toggle(L["Gossip Frame"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.gossip end,function(_, value) E.db.ProjectHopes.skins.gossip = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.guild = ACH:Toggle(L["Guild"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.guild end,function(_, value) E.db.ProjectHopes.skins.guild= value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.guildBank = ACH:Toggle(L["Guild Bank"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.guildBank end,function(_, value) E.db.ProjectHopes.skins.guildBank = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.guildControl = ACH:Toggle(L["Guild Control"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.guildControl end,function(_, value) E.db.ProjectHopes.skins.guildControl = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.guildRegistrar = ACH:Toggle(L["Guild Registrar"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.guildRegistrar end,function(_, value) E.db.ProjectHopes.skins.guildRegistrar = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.guide = ACH:Toggle(L["Guide"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.guide end,function(_, value) E.db.ProjectHopes.skins.guide = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.help = ACH:Toggle(L["Help Frame"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.help end,function(_, value) E.db.ProjectHopes.skins.help = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.inputMethodEditor = ACH:Toggle(L["Input Method Editor"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.inputMethodEditor end,function(_, value) E.db.ProjectHopes.skins.inputMethodEditor = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.inspect = ACH:Toggle(L["Inspect"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.inspect end,function(_, value) E.db.ProjectHopes.skins.inspect = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.itemInteraction = ACH:Toggle(L["Item Interaction"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.itemInteraction end,function(_, value) E.db.ProjectHopes.skins.itemInteraction = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.itemSocketing = ACH:Toggle(L["Item Socketing"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.itemSocketing end,function(_, value) E.db.ProjectHopes.skins.itemSocketing = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.itemUpgrade = ACH:Toggle(L["Item Upgrade"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.itemUpgrade end,function(_, value) E.db.ProjectHopes.skins.itemUpgrade = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.islandQueue = ACH:Toggle(L["Island Queue"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.islandQueue end,function(_, value) E.db.ProjectHopes.skins.islandQueue = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.islandsPartyPose = ACH:Toggle(L["Islands PartyPose"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.islandsPartyPose end,function(_, value) E.db.ProjectHopes.skins.islandsPartyPose = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.lookingForGroup = ACH:Toggle(L["Looking For Group"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.lookingForGroup end,function(_, value) E.db.ProjectHopes.skins.lookingForGroup = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.lfguild = ACH:Toggle(L["Looking For Guild"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.lfguild end,function(_, value) E.db.ProjectHopes.skins.lfguild = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.loot = ACH:Toggle(L["Loot Frames"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.loot end,function(_, value) E.db.ProjectHopes.skins.loot = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.lossOfControl = ACH:Toggle(L["Loss Of Control"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.lossOfControl end,function(_, value) E.db.ProjectHopes.skins.lossOfControl = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.macro = ACH:Toggle(L["Macros"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.macro end,function(_, value) E.db.ProjectHopes.skins.macro = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.mail = ACH:Toggle(L["Mail Frame"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.mail end,function(_, value) E.db.ProjectHopes.skins.mail = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.majorFactions = ACH:Toggle(L["Major Factions"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.majorFactions end,function(_, value) E.db.ProjectHopes.skins.majorFactions = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.merchant = ACH:Toggle(L["Merchant"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.merchant end,function(_, value) E.db.ProjectHopes.skins.merchant = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.microButtons = ACH:Toggle(L["Micro Bar"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.microButtons end,function(_, value) E.db.ProjectHopes.skins.microButtons = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.mirrorTimers = ACH:Toggle(L["Mirror Timers"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.mirrorTimers end,function(_, value) E.db.ProjectHopes.skins.mirrorTimers = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.misc = ACH:Toggle(L["Misc Frames"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.misc end,function(_, value) E.db.ProjectHopes.skins.misc = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.objectiveTracker = ACH:Toggle(L["Objective Tracker"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.objectiveTracker end,function(_, value) E.db.ProjectHopes.skins.objectiveTracker = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.obliterum = ACH:Toggle(L["Obliterum"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.obliterum end,function(_, value) E.db.ProjectHopes.skins.obliterum = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.orderHall = ACH:Toggle(L["Orderhall"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.orderHall end,function(_, value) E.db.ProjectHopes.skins.orderHall = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.perksProgram = ACH:Toggle(L["Perks Program"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.perksProgram end,function(_, value) E.db.ProjectHopes.skins.perksProgram = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.petBattle = ACH:Toggle(L["Pet Battle"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.petBattle end,function(_, value) E.db.ProjectHopes.skins.petBattle = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.petition = ACH:Toggle(L["Petition"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.petition end,function(_, value) E.db.ProjectHopes.skins.petition = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.playerChoice = ACH:Toggle(L["Player Choice"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.playerChoice end,function(_, value) E.db.ProjectHopes.skins.playerChoice = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.professions = ACH:Toggle(L["Professions"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.professions end,function(_, value) E.db.ProjectHopes.skins.professions = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.professionsCustomerOrders = ACH:Toggle(L["Professions Customer Orders"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.professionsCustomerOrders end,function(_, value) E.db.ProjectHopes.skins.professionsCustomerOrders = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.bgscore = ACH:Toggle(L["PVP Match"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.bgscore end,function(_, value) E.db.ProjectHopes.skins.bgscore = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.quest = ACH:Toggle(L["Quest Frames"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.quest end,function(_, value) E.db.ProjectHopes.skins.quest = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.questChoice = ACH:Toggle(L["Quest Choice"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.questChoice end,function(_, value) E.db.ProjectHopes.skins.questChoice = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.runeforge = ACH:Toggle(L["Runeforge"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.runeforge end,function(_, value) E.db.ProjectHopes.skins.runeforge = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.scenario = ACH:Toggle(L["Scenario"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.scenario end,function(_, value) E.db.ProjectHopes.skins.scenario = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.scrappingMachine = ACH:Toggle(L["Scrapping Machine"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.scrappingMachine end,function(_, value) E.db.ProjectHopes.skins.scrappingMachine = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.settingsPanel = ACH:Toggle(L["Setting Panel"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.settingsPanel end,function(_, value) E.db.ProjectHopes.skins.settingsPanel = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.soulbinds = ACH:Toggle(L["Soulbinds"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.soulbinds end,function(_, value) E.db.ProjectHopes.skins.soulbinds = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.spellBook = ACH:Toggle(L["Spell Book"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.spellBook end,function(_, value) E.db.ProjectHopes.skins.spellBook = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.staticPopup = ACH:Toggle(L["Static Popup"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.blizzardstaticPopup end,function(_, value) E.db.ProjectHopes.skins.blizzardstaticPopup = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.stable = ACH:Toggle(L["Stable"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.stable end,function(_, value) E.db.ProjectHopes.skins.stable = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.subscriptionInterstitial = ACH:Toggle(L["Subscription Interstitial"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.subscriptionInterstitial end,function(_, value) E.db.ProjectHopes.skins.subscriptionInterstitial = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.tabard = ACH:Toggle(L["Tabard"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.tabard end,function(_, value) E.db.ProjectHopes.skins.tabard = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.talkingHead = ACH:Toggle(L["Talking Head"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.talkingHead end,function(_, value) E.db.ProjectHopes.skins.talkingHead = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.taxi = ACH:Toggle(L["Taxi"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.taxi end,function(_, value) E.db.ProjectHopes.skins.taxi = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.ticketStatus = ACH:Toggle(L["Ticket Status"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.ticketStatus end,function(_, value) E.db.ProjectHopes.skins.ticketStatus = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.timeManager = ACH:Toggle(L["Stopwatch"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.timeManager end,function(_, value) E.db.ProjectHopes.skins.timeManager = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.tooltips = ACH:Toggle(L["Tooltips"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.tooltips end,function(_, value) E.db.ProjectHopes.skins.tooltips = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.tooltipscolor = ACH:Toggle(L["Tooltips Color"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.tooltipscolor end,function(_, value) E.db.ProjectHopes.skins.tooltipscolor = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.torghastLevelPicker = ACH:Toggle(L["Torghast Level Picker"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.torghastLevelPicker end,function(_, value) E.db.ProjectHopes.skins.torghastLevelPicker = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.trade = ACH:Toggle(L["Trade"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.trade end,function(_, value) E.db.ProjectHopes.skins.trade = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.trainer = ACH:Toggle(L["Trainer"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.trainer end,function(_, value) E.db.ProjectHopes.skins.trainer = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.tutorial = ACH:Toggle(L["Tutorials"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.tutorial end,function(_, value) E.db.ProjectHopes.skins.tutorial = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.voidstorage = ACH:Toggle(L["Void Storage"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.voidstorage end,function(_, value) E.db.ProjectHopes.skins.voidstorage = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.warboard = ACH:Toggle(L["Warboard"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.warboard end,function(_, value) E.db.ProjectHopes.skins.warboard = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.weeklyRewards = ACH:Toggle(L["Weekly Rewards"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.weeklyRewards end,function(_, value) E.db.ProjectHopes.skins.weeklyRewards = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.worldMap = ACH:Toggle(L["World Map"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.worldMap end,function(_, value) E.db.ProjectHopes.skins.worldMap = value E:StaticPopup_Show('ProjectHopes_RL') end)	
	elseif E.Classic then
		POA.Skins.args.Blizzard.args.addonList = ACH:Toggle(L["AddOn Manager"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.addonList end,function(_, value) E.db.ProjectHopes.skins.addonList = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.auctionHouse = ACH:Toggle(L["Auction House"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.auctionHouse end,function(_, value) E.db.ProjectHopes.skins.auctionHouse = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.battleNet = ACH:Toggle(L["Battle Net"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.battleNet end,function(_, value) E.db.ProjectHopes.skins.battleNet = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.channels = ACH:Toggle(L["Channels"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.channels end,function(_, value) E.db.ProjectHopes.skins.channels = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.character = ACH:Toggle(L["Character"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.character end,function(_, value) E.db.ProjectHopes.skins.character = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.communities = ACH:Toggle(L["Communities"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.communities end,function(_, value) E.db.ProjectHopes.skins.communities = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.debugTools = ACH:Toggle(L["Debug Tools"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.debugTools end,function(_, value) E.db.ProjectHopes.skins.debugTools = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.dressingRoom = ACH:Toggle(L["Dressing Room"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.dressingRoom end,function(_, value) E.db.ProjectHopes.skins.dressingRoom = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.eventTrace = ACH:Toggle(L["Event Trace"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.eventTrace end,function(_, value) E.db.ProjectHopes.skins.eventTrace = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.flightMap = ACH:Toggle(L["Flight Map"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.flightMap end,function(_, value) E.db.ProjectHopes.skins.flightMap = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.friends = ACH:Toggle(L["Friend List"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.friends end,function(_, value) E.db.ProjectHopes.skins.friends = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.gossip = ACH:Toggle(L["Gossip Frame"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.gossip end,function(_, value) E.db.ProjectHopes.skins.gossip = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.guildControl = ACH:Toggle(L["Guild Control"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.guildControl end,function(_, value) E.db.ProjectHopes.skins.guildControl = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.guildRegistrar = ACH:Toggle(L["Guild Registrar"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.guildRegistrar end,function(_, value) E.db.ProjectHopes.skins.guildRegistrar = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.help = ACH:Toggle(L["Help Frame"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.help end,function(_, value) E.db.ProjectHopes.skins.help = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.inputMethodEditor = ACH:Toggle(L["Input Method Editor"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.inputMethodEditor end,function(_, value) E.db.ProjectHopes.skins.inputMethodEditor = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.inspect = ACH:Toggle(L["Inspect"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.inspect end,function(_, value) E.db.ProjectHopes.skins.inspect = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.lookingForGroup = ACH:Toggle(L["Looking For Group"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.lookingForGroup end,function(_, value) E.db.ProjectHopes.skins.lookingForGroup = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.loot = ACH:Toggle(L["Loot Frames"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.loot end,function(_, value) E.db.ProjectHopes.skins.loot = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.macro = ACH:Toggle(L["Macros"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.macro end,function(_, value) E.db.ProjectHopes.skins.macro = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.mail = ACH:Toggle(L["Mail Frame"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.mail end,function(_, value) E.db.ProjectHopes.skins.mail = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.merchant = ACH:Toggle(L["Merchant"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.merchant end,function(_, value) E.db.ProjectHopes.skins.merchant = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.mirrorTimers = ACH:Toggle(L["Mirror Timers"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.mirrorTimers end,function(_, value) E.db.ProjectHopes.skins.mirrorTimers = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.misc = ACH:Toggle(L["Misc Frames"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.misc end,function(_, value) E.db.ProjectHopes.skins.misc = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.petition = ACH:Toggle(L["Petition"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.petition end,function(_, value) E.db.ProjectHopes.skins.petition = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.quest = ACH:Toggle(L["Quest Frames"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.quest end,function(_, value) E.db.ProjectHopes.skins.quest = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.settingsPanel = ACH:Toggle(L["Setting Panel"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.settingsPanel end,function(_, value) E.db.ProjectHopes.skins.settingsPanel = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.spellBook = ACH:Toggle(L["Spell Book"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.spellBook end,function(_, value) E.db.ProjectHopes.skins.spellBook = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.stable = ACH:Toggle(L["Stable"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.stable end,function(_, value) E.db.ProjectHopes.skins.stable = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.subscriptionInterstitial = ACH:Toggle(L["Subscription Interstitial"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.subscriptionInterstitial end,function(_, value) E.db.ProjectHopes.skins.subscriptionInterstitial = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.tabard = ACH:Toggle(L["Tabard"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.tabard end,function(_, value) E.db.ProjectHopes.skins.tabard = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.taxi = ACH:Toggle(L["Taxi"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.taxi end,function(_, value) E.db.ProjectHopes.skins.taxi = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.timeManager = ACH:Toggle(L["Stopwatch"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.timeManager end,function(_, value) E.db.ProjectHopes.skins.timeManager = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.tooltips = ACH:Toggle(L["Tooltips"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.tooltips end,function(_, value) E.db.ProjectHopes.skins.tooltips = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.trade = ACH:Toggle(L["Trade"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.trade end,function(_, value) E.db.ProjectHopes.skins.trade = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.trainer = ACH:Toggle(L["Trainer"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.trainer end,function(_, value) E.db.ProjectHopes.skins.trainer = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.tutorial = ACH:Toggle(L["Tutorials"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.tutorial end,function(_, value) E.db.ProjectHopes.skins.tutorial = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.worldMap = ACH:Toggle(L["World Map"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.worldMap end,function(_, value) E.db.ProjectHopes.skins.worldMap = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.battlefield = ACH:Toggle(L["Battle Field"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.battlefield end,function(_, value) E.db.ProjectHopes.skins.battlefield = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.bgmap = ACH:Toggle(L["BG Map"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.bgmap end,function(_, value) E.db.ProjectHopes.skins.bgmap = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.bgscore = ACH:Toggle(L["BG Score"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.bgscore end,function(_, value) E.db.ProjectHopes.skins.bgscore = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.craft = ACH:Toggle(L["Craft"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.craft end,function(_, value) E.db.ProjectHopes.skins.craft = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.engraving = ACH:Toggle(L["Engraving"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.engraving end,function(_, value) E.db.ProjectHopes.skins.engraving = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.gmChat = ACH:Toggle(L["GM Chat"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.gmChat end,function(_, value) E.db.ProjectHopes.skins.gmChat = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.questTimers = ACH:Toggle(L["Quest Timers"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.questTimers end,function(_, value) E.db.ProjectHopes.skins.questTimers = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.talent = ACH:Toggle(L["Talent"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.talent end,function(_, value) E.db.ProjectHopes.skins.talent = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.tradeskill = ACH:Toggle(L["Tradeskill"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.tradeskill end,function(_, value) E.db.ProjectHopes.skins.tradeskill = value E:StaticPopup_Show('ProjectHopes_RL') end)

	elseif E.Cata then
		POA.Skins.args.Blizzard.args.achievementFrame = ACH:Toggle(L["Achievements"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.achievementFrame end,function(_, value) E.db.ProjectHopes.skins.achievementFrame = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.addonList = ACH:Toggle(L["AddOn Manager"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.addonList end,function(_, value) E.db.ProjectHopes.skins.addonList = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.auctionHouse = ACH:Toggle(L["Auction House"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.auctionHouse end,function(_, value) E.db.ProjectHopes.skins.auctionHouse = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.barbershop = ACH:Toggle(L["Barber Shop"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.barbershop end,function(_, value) E.db.ProjectHopes.skins.barbershop = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.battleNet = ACH:Toggle(L["Battle Net"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.battleNet end,function(_, value) E.db.ProjectHopes.skins.battleNet = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.bgmap = ACH:Toggle(L["BG Map"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.bgmap end,function(_, value) E.db.ProjectHopes.skins.bgmap = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.bgscore = ACH:Toggle(L["BG Score"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.bgscore end,function(_, value) E.db.ProjectHopes.skins.bgscore = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.settingsPanel = ACH:Toggle(L["Setting Panel"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.settingsPanel end,function(_, value) E.db.ProjectHopes.skins.settingsPanel = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.calendar = ACH:Toggle(L["Calendar"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.calendar end,function(_, value) E.db.ProjectHopes.skins.calendar = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.channels = ACH:Toggle(L["Channels"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.channels end,function(_, value) E.db.ProjectHopes.skins.channels = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.character = ACH:Toggle(L["Character"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.character end,function(_, value) E.db.ProjectHopes.skins.character = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.collections = ACH:Toggle(L["Collections"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.collections end,function(_, value) E.db.ProjectHopes.skins.collections = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.transmogrify = ACH:Toggle(L["Transmogrify"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.transmogrify end,function(_, value) E.db.ProjectHopes.skins.transmogrify = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.communities = ACH:Toggle(L["Communities"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.communities end,function(_, value) E.db.ProjectHopes.skins.communities = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.debugTools = ACH:Toggle(L["Debug Tools"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.debugTools end,function(_, value) E.db.ProjectHopes.skins.debugTools = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.dressingRoom = ACH:Toggle(L["Dressing Room"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.dressingRoom end,function(_, value) E.db.ProjectHopes.skins.dressingRoom = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.encounterJournal = ACH:Toggle(L["Encounter Journal"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.encounterJournal end,function(_, value) E.db.ProjectHopes.skins.encounterJournal = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.eventTrace = ACH:Toggle(L["Event Trace"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.eventTrace end,function(_, value) E.db.ProjectHopes.skins.eventTrace = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.friends = ACH:Toggle(L["Friend List"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.friends end,function(_, value) E.db.ProjectHopes.skins.friends = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.gossip = ACH:Toggle(L["Gossip Frame"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.gossip end,function(_, value) E.db.ProjectHopes.skins.gossip = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.guildControl = ACH:Toggle(L["Guild Control"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.guildControl end,function(_, value) E.db.ProjectHopes.skins.guildControl = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.guildRegistrar = ACH:Toggle(L["Guild Registrar"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.guildRegistrar end,function(_, value) E.db.ProjectHopes.skins.guildRegistrar = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.help = ACH:Toggle(L["Help Frame"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.help end,function(_, value) E.db.ProjectHopes.skins.help = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.inputMethodEditor = ACH:Toggle(L["Input Method Editor"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.inputMethodEditor end,function(_, value) E.db.ProjectHopes.skins.inputMethodEditor = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.inspect = ACH:Toggle(L["Inspect"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.inspect end,function(_, value) E.db.ProjectHopes.skins.inspect = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.lookingForGroup = ACH:Toggle(L["Looking For Group"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.lookingForGroup end,function(_, value) E.db.ProjectHopes.skins.lookingForGroup = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.loot = ACH:Toggle(L["Loot Frames"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.loot end,function(_, value) E.db.ProjectHopes.skins.loot = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.macro = ACH:Toggle(L["Macros"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.macro end,function(_, value) E.db.ProjectHopes.skins.macro = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.mail = ACH:Toggle(L["Mail Frame"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.mail end,function(_, value) E.db.ProjectHopes.skins.mail = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.misc = ACH:Toggle(L["Misc Frames"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.misc end,function(_, value) E.db.ProjectHopes.skins.misc = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.merchant = ACH:Toggle(L["Merchant"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.merchant end,function(_, value) E.db.ProjectHopes.skins.merchant = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.mirrorTimers = ACH:Toggle(L["Mirror Timers"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.mirrorTimers end,function(_, value) E.db.ProjectHopes.skins.mirrorTimers = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.petition = ACH:Toggle(L["Petition"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.petition end,function(_, value) E.db.ProjectHopes.skins.petition = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.quest = ACH:Toggle(L["Quest Frames"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.quest end,function(_, value) E.db.ProjectHopes.skins.quest = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.runeforge = ACH:Toggle(L["Runeforge"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.runeforge end,function(_, value) E.db.ProjectHopes.skins.runeforge = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.settingsPanel = ACH:Toggle(L["Setting Panel"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.settingsPanel end,function(_, value) E.db.ProjectHopes.skins.settingsPanel = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.itemSocketing = ACH:Toggle(L["Item Socketing"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.itemSocketing end,function(_, value) E.db.ProjectHopes.skins.itemSocketing = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.spellBook = ACH:Toggle(L["Spell Book"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.spellBook end,function(_, value) E.db.ProjectHopes.skins.spellBook = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.stable = ACH:Toggle(L["Stable"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.stable end,function(_, value) E.db.ProjectHopes.skins.stable = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.tabard = ACH:Toggle(L["Tabard"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.tabard end,function(_, value) E.db.ProjectHopes.skins.tabard = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.talent = ACH:Toggle(L["Talent"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.talent end,function(_, value) E.db.ProjectHopes.skins.talent = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.taxi = ACH:Toggle(L["Taxi"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.taxi end,function(_, value) E.db.ProjectHopes.skins.taxi = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.timeManager = ACH:Toggle(L["Stopwatch"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.timeManager end,function(_, value) E.db.ProjectHopes.skins.timeManager = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.tooltips = ACH:Toggle(L["Tooltips"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.tooltips end,function(_, value) E.db.ProjectHopes.skins.tooltips = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.trade = ACH:Toggle(L["Trade"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.trade end,function(_, value) E.db.ProjectHopes.skins.trade = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.tradeskill = ACH:Toggle(L["Tradeskill"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.tradeskill end,function(_, value) E.db.ProjectHopes.skins.tradeskill = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.trainer = ACH:Toggle(L["Trainer"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.trainer end,function(_, value) E.db.ProjectHopes.skins.trainer = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.tutorial = ACH:Toggle(L["Tutorials"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.tutorial end,function(_, value) E.db.ProjectHopes.skins.tutorial = value E:StaticPopup_Show('ProjectHopes_RL') end)
		POA.Skins.args.Blizzard.args.worldMap = ACH:Toggle(L["World Map"], nil, 99, nil, false, nil, function() return E.db.ProjectHopes.skins.worldMap end,function(_, value) E.db.ProjectHopes.skins.worldMap = value E:StaticPopup_Show('ProjectHopes_RL') end)

	end

	local elvuiskins = {
		"actionBarsBackdrop",
		"actionBarsButton",
		"afk",
		"altPowerBar",
		"chatDataPanels",
		"chatPanels",
		"chatVoicePanel",
		"chatCopyFrame",
		"lootRoll",
		"options",
		"panels",
		"raidUtility",
		"staticPopup",
		"statusReport",
		"totemTracker",
		"Minimap",
	}
	POA.Skins.args.Elvui = ACH:Group(L["ElvUI"], nil, 1)
	POA.Skins.args.Elvui.args.desc = ACH:Group(L["Description"], nil, 1)
	POA.Skins.args.Elvui.args.desc.inline = true
	POA.Skins.args.Elvui.args.desc.args.feature = ACH:Description(L["Skins ElvUi frames to fit PeojectHopes."], 1, "medium")
	POA.Skins.args.Elvui.args.spacer = ACH:Header(L[""], 2)
	POA.Skins.args.Elvui.args.buttonGroup = ACH:Group(L[""], nil, 3)
	POA.Skins.args.Elvui.args.buttonGroup.inline = true
	POA.Skins.args.Elvui.args.buttonGroup.args.enableAll = ACH:Execute(L["Enable All"], nil, 1, function() for _, skin in ipairs(elvuiskins) do E.db.ProjectHopes.skins[skin] = true end E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.Skins.args.Elvui.args.buttonGroup.args.disableAll = ACH:Execute(L["Disable All"], nil, 2, function() for _, skin in ipairs(elvuiskins) do E.db.ProjectHopes.skins[skin] = false end E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.Skins.args.Elvui.args.actionBarsBackdrop = ACH:Toggle(L["Actionbars Backdrop"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.actionBarsBackdrop end,function(_, value) E.db.ProjectHopes.skins.actionBarsBackdrop = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.Skins.args.Elvui.args.actionBarsButton = ACH:Toggle(L["Actionbars Button"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.actionBarsButton end,function(_, value) E.db.ProjectHopes.skins.actionBarsButton = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.Skins.args.Elvui.args.afk = ACH:Toggle(L["AFK Mode"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.afk end,function(_, value) E.db.ProjectHopes.skins.afk = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.Skins.args.Elvui.args.altPowerBar = ACH:Toggle(L["Alt Power"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.altPowerBar end,function(_, value) E.db.ProjectHopes.skins.altPowerBar = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.Skins.args.Elvui.args.chatDataPanels = ACH:Toggle(L["Chat Data Panels"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.chatDataPanels end,function(_, value) E.db.ProjectHopes.skins.chatDataPanels = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.Skins.args.Elvui.args.chatPanels = ACH:Toggle(L["Chat Panels"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.chatPanels end,function(_, value) E.db.ProjectHopes.skins.chatPanels = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.Skins.args.Elvui.args.chatVoicePanel = ACH:Toggle(L["Chat Voice Panel"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.chatVoicePanel end,function(_, value) E.db.ProjectHopes.skins.chatVoicePanel = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.Skins.args.Elvui.args.chatCopyFrame = ACH:Toggle(L["Chat Copy Frame"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.chatCopyFrame end,function(_, value) E.db.ProjectHopes.skins.chatCopyFrame = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.Skins.args.Elvui.args.lootRoll = ACH:Toggle(L["Loot Roll"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.lootRoll end,function(_, value) E.db.ProjectHopes.skins.lootRoll = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.Skins.args.Elvui.args.options = ACH:Toggle(L["Options"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.options end,function(_, value) E.db.ProjectHopes.skins.options = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.Skins.args.Elvui.args.panels = ACH:Toggle(L["Panels"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.panels end,function(_, value) E.db.ProjectHopes.skins.panels = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.Skins.args.Elvui.args.raidUtility = ACH:Toggle(L["Raid Utility"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.raidUtility end,function(_, value) E.db.ProjectHopes.skins.raidUtility = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.Skins.args.Elvui.args.staticPopup = ACH:Toggle(L["Static Popup"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.staticPopup end,function(_, value) E.db.ProjectHopes.skins.staticPopup = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.Skins.args.Elvui.args.statusReport = ACH:Toggle(L["Status Report"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.statusReport end,function(_, value) E.db.ProjectHopes.skins.statusReport = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.Skins.args.Elvui.args.totemTracker = ACH:Toggle(L["Totem Tracker"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.totemTracker end,function(_, value) E.db.ProjectHopes.skins.totemTracker = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.Skins.args.Elvui.args.minimap = ACH:Toggle(L["MiniMap"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.Minimap end,function(_, value) E.db.ProjectHopes.skins.Minimap = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.private.general.minimap.enable end)
	POA.Skins.args.Elvui.args.dataPanels = ACH:Toggle(L["DataPanels"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.skins.dataPanels end,function(_, value) E.db.ProjectHopes.skins.dataPanels = value E:StaticPopup_Show('ProjectHopes_RL') end)

	-- Quality Of Life
	POA.qualityOfLife = ACH:Group(L["Quality Of Life"], nil, 6, 'tab')
	POA.qualityOfLife.icon = 'Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Icons\\qolicon.tga'
	POA.qualityOfLife.args.misc = ACH:Group(L["Misc"], nil, 1, nil, function(info) return E.private.ProjectHopes.qualityOfLife[info[#info]] end, function(info, value) E.private.ProjectHopes.qualityOfLife[info[#info]] = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POA.qualityOfLife.args.misc.args.header1 = ACH:Header(L["Misc"], 2)
	POA.qualityOfLife.args.misc.args.easyDelete = ACH:Toggle(L["Easy Delete"], L["Automatically fill out the confirmation text to delete items."], 3, nil, false, 'full')
	POA.qualityOfLife.args.misc.args.autoAcceptQuests = ACH:Toggle(L["Auto Accept/Complete Quests"], L["Automatically accepts and complete quests, when not holding SHIFT"], 4, nil, false, 'full')
	POA.qualityOfLife.args.misc.args.borederDarkmode = ACH:Toggle(L["Border Darkmode"], L["Changes the border used to black, works on Plater and Weakauras."], 4, nil, false, 'full')
	POA.qualityOfLife.args.misc.args.fastLoot = ACH:Toggle(L["Fast Loot"], nil, 4, nil, false, 'full')

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

	-- Tags
	POA.tags = ACH:Group(L["Tags"], nil, 7)
	POA.tags.icon = 'Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Icons\\tagsicon.tga'

	POA.tags.args.header = ACH:Header(L["Tags"], 1)
	POA.tags.args.spacer = ACH:Spacer(2, 'full')
	POA.tags.args.tag1 = ACH:Input(L["Shows the Units role when selected."], nil, 3, nil, 'full', function() return '[Hopes:role]' end, nil, nil)
	POA.tags.args.tag2 = ACH:Input(L["Shows the percent health and absorb without %."], nil, 4, nil, 'full', function() return '[Hopes:perhp]' end, nil, nil, not E.Retail)
	POA.tags.args.tag3 = ACH:Input(L["Shows the Units raidmarker when selected."], nil, 5, nil, 'full', function() return '[Hopes:raidmarker]' end, nil, nil)
	POA.tags.args.tag4 = ACH:Input(L["Shows the Leader Icon or Assist icon if the unit is Leader or Assist."], nil, 6, nil, 'full', function() return '[Hopes:leader]' end, nil, nil, not E.Retail)
	POA.tags.args.tag5 = ACH:Input(L["Shows heal absorb on unit."], nil, 6, nil, 'full', function() return '[Hopes:healabsorbs]' end, nil, nil, not E.Retail)

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
