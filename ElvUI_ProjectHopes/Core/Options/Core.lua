local Name, Private = ...
local E, _, V, P, G = unpack(ElvUI)
local D = E:GetModule('Distributor')
local PI = E:GetModule('PluginInstaller')

local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale)
local LSM = E.Libs.LSM
local ACH = E.Libs.ACH

local pairs, sort = pairs, sort
local format = format
local tconcat, tinsert = table.concat, table.insert

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
	'|cff4beb2cLuckyoneUI|r, Made all this possible with template of his plugin.',
	'|cff919191AcidWeb|r, Thanks for help with the baseline code of OPie skin.', 
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

  -- Making it Global. 
  E.Options.args.ProjectHopes = ProjectHopes.Options

  -- Modules
	ProjectHopes:Automation()
	ProjectHopes:Borders()
	ProjectHopes:FrameMover()
	ProjectHopes:Media()
  ProjectHopes:Minimap()
	ProjectHopes:Miscellaneous()
  ProjectHopes:Portaits()
  ProjectHopes:Tags()
  ProjectHopes:Tooltip()
  ProjectHopes:Unitframes()
	ProjectHopes:WeakAurasAnchors()
end

--[[
	ACH:Color(name, desc, order, alpha, width, get, set, disabled, hidden)
	ACH:Description(name, order, fontSize, image, imageCoords, imageWidth, imageHeight, width, hidden)
	ACH:Execute(name, desc, order, func, image, confirm, width, get, set, disabled, hidden)
	ACH:Group(name, desc, order, childGroups, get, set, disabled, hidden, func)
	ACH:Header(name, order, get, set, hidden)
	ACH:Input(name, desc, order, multiline, width, get, set, disabled, hidden, validate)
	ACH:Select(name, desc, order, values, confirm, width, get, set, disabled, hidden, sortByValue)
	ACH:MultiSelect(name, desc, order, values, confirm, width, get, set, disabled, hidden, sortByValue)
	ACH:Toggle(name, desc, order, tristate, confirm, width, get, set, disabled, hidden)
	ACH:Range(name, desc, order, values, width, get, set, disabled, hidden)
	ACH:Spacer(order, width, hidden)
	ACH:SharedMediaFont(name, desc, order, width, get, set, disabled, hidden)
	ACH:SharedMediaSound(name, desc, order, width, get, set, disabled, hidden)
	ACH:SharedMediaStatusbar(name, desc, order, width, get, set, disabled, hidden)
	ACH:SharedMediaBackground(name, desc, order, width, get, set, disabled, hidden)
	ACH:SharedMediaBorder(name, desc, order, width, get, set, disabled, hidden)
	ACH:FontFlags(name, desc, order, width, get, set, disabled, hidden)
]]