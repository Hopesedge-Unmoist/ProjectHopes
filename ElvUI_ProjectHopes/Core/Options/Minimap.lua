local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

local ACH = E.Libs.ACH

function ProjectHopes:Minimap()
  local POA = ProjectHopes.Options.args

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
	POAMA.minimapbutton.args.skinStyle = ACH:Select(L["Skin Style"], L["Change settings for how the minimap buttons are skinned"], 2, {NOANCHOR = 'No Anchor Bar', HORIZONTAL = 'Horizontal', VERTICAL = 'Vertical'}, false, nil, nil, function(info, value) E.db.ProjectHopes.minimapbutton[ info[#info] ] = value; MB:UpdateSkinStyle() end, function() return not E.db.ProjectHopes.minimapbutton.enable end)
	POAMA.minimapbutton.args.layoutDirection = ACH:Select(L['Layout Direction'], L['Normal is right to left or top to bottom, or select reversed to switch directions.'], 3, {NORMAL = 'Normal', REVERSED = 'Reversed'}, false, nil, nil, nil, nil, function() return not E.db.ProjectHopes.minimapbutton.enable or E.db.ProjectHopes.minimapbutton.skinstyle == 'NOANCHOR' end)
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
	POAMA.minimapid.args.options.args.align = ACH:Select(L["Text Align"], nil, 6, { CENTER = L["Center"], LEFT = L["Left"], RIGHT = L["Right"] }, nil, "medium", function() return E.db.ProjectHopes.minimapid.align or "LEFT" end, function(_, value) E.db.ProjectHopes.minimapid.align = value ID:UpdateDifficultyText(E.db.ProjectHopes.minimapid.font.name, E.db.ProjectHopes.minimapid.font.style, E.db.ProjectHopes.minimapid.font.size, value)	end)
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
