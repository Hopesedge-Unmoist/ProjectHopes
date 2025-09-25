local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

local ACH = E.Libs.ACH

function ProjectHopes:Automation()
  local POA = ProjectHopes.Options.args

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
