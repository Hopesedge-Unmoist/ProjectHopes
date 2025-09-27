local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

local ACH = E.Libs.ACH

function ProjectHopes:Unitframes()
	local OS = E:GetModule('Overshields', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0');

  local POA = ProjectHopes.Options.args

	POA.Unitframes = ACH:Group(E:TextGradient(L["UnitFrames"], 0.6, 0.6, 0.6, 0.34, 1, 0.67), nil, 3, 'tab')
	local POAUFA = POA.Unitframes.args
	POAUFA.overshield = ACH:Group(L["Overshield"], nil, 1, nil, nil, nil, nil, function() return E.Classic end)
	POAUFA.overshield.args.desc = ACH:Group(L["Description"], nil, 1)
	POAUFA.overshield.args.desc.inline = true
	POAUFA.overshield.args.desc.args.feature = ACH:Description(L["Add a texture to Over Absorb with a Glowline at the end."], 1, "medium")
	POAUFA.overshield.args.absorb = ACH:Toggle(L["Enable"], L["Toggle Overshield textures."], 2, nil, false, nil,function() return E.db.ProjectHopes.overshield.Absorb end, function(_, value) E.db.ProjectHopes.overshield.Absorb = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POAUFA.overshield.args.config = ACH:Group(L["Configuration, HopesUI Defaults:"], nil, 3, nil, nil, nil, nil, function() return not E.db.ProjectHopes.overshield.Absorb end)
	POAUFA.overshield.args.config.inline = true
	POAUFA.overshield.args.config.args.absorbwrapped = ACH:Execute(L["Set Absorb style to Wrapped"], nil, 3, function() OS:SetAllHealPredictionProperty("absorbStyle", "WRAPPED") end, nil, nil, 200, nil, nil, function() return not E.db.ProjectHopes.overshield.Absorb end)
	POAUFA.overshield.args.config.args.absorheight  = ACH:Execute(L["Set Absorb height to -1"], nil, 4, function() OS:SetAllHealPredictionProperty("height", -1) end, nil, nil, 200, nil, nil, function() return not E.db.ProjectHopes.overshield.Absorb end)
	POAUFA.overshield.args.config.args.changeColor = ACH:Execute(L["Change the color of the absorb bar."], nil, 4, function() E.db.unitframe.colors.healPrediction.absorbs = { r = 0.47450983524323, g = 0.86274516582489, b = 1, a = 1 } E.db.unitframe.colors.healPrediction.overabsorbs = { r = 1, g = 1, b = 1, a = 1 } end, nil, nil, 250)
	POAUFA.overshield.args.config.args.changeMaxOverflow = ACH:Execute(L["Set Max Overflow to 0"], nil, 5, function() E.db.unitframe.colors.healPrediction.maxOverflow = 0 end, nil, nil, 200)

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
