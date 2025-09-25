local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

local ACH = E.Libs.ACH
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded

function ProjectHopes:Media()
  local POA = ProjectHopes.Options.args

	POA.Media = ACH:Group(E:TextGradient(L["Media"], 0.6, 0.6, 0.6, 1, 0.45, 0.30), nil, 3)
	local POAMAA = POA.Media.args
	POAMAA.desc = ACH:Group(L["Description"], nil, 1)
	POAMAA.desc.inline = true

	local descriptionText = L["This module let you set the font, outline and statusbar everywhere within |cff1784d1ElvUI|r"]
	local hasAdditionalAddons = false

	if IsAddOnLoaded("ElvUI_FCT") then
		descriptionText = descriptionText .. L[", |cFFdd2244Floating Combat Text Media|r"]
		hasAdditionalAddons = true
	end

	if IsAddOnLoaded("WeakAuras") then
		if hasAdditionalAddons then
			descriptionText = descriptionText .. L[" or |cffFFD100WeakAuras|r"]
		else
			descriptionText = descriptionText .. L[" or |cffFFD100WeakAuras|r"]
		end
	else
		if not hasAdditionalAddons then
			descriptionText = descriptionText
		end
	end

	POAMAA.desc.args.feature = ACH:Description(descriptionText, 1, "medium")
	POAMAA.elvuimedia = ACH:Group(L["|cff1784d1ElvUI Media|r"], nil, 2)
	POAMAA.elvuimedia.inline = true
	POAMAA.elvuimedia.args.font = ACH:Group(L[""], nil, 3)
	POAMAA.elvuimedia.args.font.inline = true
	POAMAA.elvuimedia.args.font.args.fontselect = ACH:SharedMediaFont(L["Font"], nil, 1, nil, function() return E.db.ProjectHopes.elvuifont end, function(_,key) E.db.ProjectHopes.elvuifont = key end)
	POAMAA.elvuimedia.args.font.args.fontbutton = ACH:Execute(L["Set Fonts"], nil, 2, function() ProjectHopes:SetElvUIFonts(E.db.ProjectHopes.elvuifont) end)
	POAMAA.elvuimedia.args.outline = ACH:Group(L[""], nil, 4)
	POAMAA.elvuimedia.args.outline.inline = true
	POAMAA.elvuimedia.args.outline.args.outlineselect = ACH:FontFlags(L["Font Outline"], nil, 1, nil, function() return E.db.ProjectHopes.elvuioutline end, function(_,key) E.db.ProjectHopes.elvuioutline = key end)
	POAMAA.elvuimedia.args.outline.args.outlinebutton = ACH:Execute(L["Set Outline"], nil, 2, function() ProjectHopes:SetElvUIOutlines(E.db.ProjectHopes.elvuioutline) end)
	POAMAA.elvuimedia.args.statusbar = ACH:Group(L[""], nil, 5)
	POAMAA.elvuimedia.args.statusbar.inline = true
	POAMAA.elvuimedia.args.statusbar.args.statusbarselect = ACH:SharedMediaStatusbar(L["Statusbar"], nil, 1, nil, function() return E.db.ProjectHopes.elvuistatusbar end, function(_,key) E.db.ProjectHopes.elvuistatusbar = key end)
	POAMAA.elvuimedia.args.statusbar.args.statusbarbutton = ACH:Execute(L["Set Statusbar"], nil, 2, function() ProjectHopes:SetElvUIStatusbars(E.db.ProjectHopes.elvuistatusbar) end)
	POAMAA.fctmedia = ACH:Group(L["|cFFdd2244Floating Combat Text Media|r"], nil, 2, nil, nil, nil, nil, function() return not IsAddOnLoaded("ElvUI_FCT") end)
	POAMAA.fctmedia.inline = true
	POAMAA.fctmedia.args.font = ACH:Group(L[""], nil, 3)
	POAMAA.fctmedia.args.font.inline = true
	POAMAA.fctmedia.args.font.args.fontselect = ACH:SharedMediaFont(L["Font"], nil, 1, nil, function() return E.db.ProjectHopes.fctfont end, function(_,key) E.db.ProjectHopes.fctfont = key end)
	POAMAA.fctmedia.args.font.args.fontbutton = ACH:Execute(L["Set Fonts"], nil, 2, function() ProjectHopes:SetFCTFonts(E.db.ProjectHopes.fctfont) end)
	POAMAA.fctmedia.args.outline = ACH:Group(L[""], nil, 4)
	POAMAA.fctmedia.args.outline.inline = true
	POAMAA.fctmedia.args.outline.args.outlineselect = ACH:FontFlags(L["Font Outline"], nil, 1, nil, function() return E.db.ProjectHopes.fctoutline end, function(_,key) E.db.ProjectHopes.fctoutline = key end)
	POAMAA.fctmedia.args.outline.args.outlinebutton = ACH:Execute(L["Set Outline"], nil, 2, function() ProjectHopes:SetFCTOutlines(E.db.ProjectHopes.fctoutline) end)
	POAMAA.weakauramedia = ACH:Group(L["|cffFFD100WeakAuras Media|r, |cffa23838Use at own Risk. Can break Weakauras! Backup of weakauras recommended|r."], nil, 2, nil, nil, nil, nil, function() return not IsAddOnLoaded("WeakAuras")end)
	POAMAA.weakauramedia.inline = true
	POAMAA.weakauramedia.args.font = ACH:Group(L[""], nil, 3)
	POAMAA.weakauramedia.args.font.inline = true
	POAMAA.weakauramedia.args.font.args.fontselect = ACH:SharedMediaFont(L["Font"], nil, 1, nil, function() return E.db.ProjectHopes.weakaurafont end, function(_,key) E.db.ProjectHopes.weakaurafont = key end)
	POAMAA.weakauramedia.args.font.args.fontbutton = ACH:Execute(L["Set Fonts"], nil, 2, function() ProjectHopes:SetWeakAurasFonts(E.db.ProjectHopes.weakaurafont) end)
	POAMAA.weakauramedia.args.outline = ACH:Group(L[""], nil, 4)
	POAMAA.weakauramedia.args.outline.inline = true
	POAMAA.weakauramedia.args.outline.args.outlineselect = ACH:Select(L["Font Outline"], nil, 1, {NONE = 'None', OUTLINE = 'Outline',	THICKOUTLINE = 'Thick',	MONOCHROME = '|cFFAAAAAAMono|r',	["MONOCHROME|OUTLINE"] = '|cFFAAAAAAMono|r Outline',	["MONOCHROME|THICKOUTLINE"] = '|cFFAAAAAAMono|r Thick'}	, nil, nil, function() return E.db.ProjectHopes.weakauraoutline end, function(_,key) E.db.ProjectHopes.weakauraoutline = key end)
	POAMAA.weakauramedia.args.outline.args.outlinebutton = ACH:Execute(L["Set Outline"], nil, 2, function() ProjectHopes:SetWeakAurasOutlines(E.db.ProjectHopes.weakauraoutline) end)
	POAMAA.weakauramedia.args.statusbar = ACH:Group(L[""], nil, 5)
	POAMAA.weakauramedia.args.statusbar.inline = true
	POAMAA.weakauramedia.args.statusbar.args.statusbarselect = ACH:SharedMediaStatusbar(L["Statusbar"], nil, 1, nil, function() return E.db.ProjectHopes.weakaurastatusbar end, function(_,key) E.db.ProjectHopes.weakaurastatusbar = key end)
	POAMAA.weakauramedia.args.statusbar.args.statusbarbutton = ACH:Execute(L["Set Statusbar"], nil, 2, function() ProjectHopes:SetWeakAurasStatusbars(E.db.ProjectHopes.weakaurastatusbar) end)
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
