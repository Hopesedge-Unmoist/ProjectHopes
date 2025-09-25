local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

local ACH = E.Libs.ACH

function ProjectHopes:FrameMover()
  local POA = ProjectHopes.Options.args

	POA.frameMover = ACH:Group(E:TextGradient(L["Frame Mover"], 0.6, 0.6, 0.6, 0.98, 0.34, 1), nil, 3, nil, function(info) return E.private.ProjectHopes.qualityOfLife.frameMover[info[#info]] end, function(info, value) E.private.ProjectHopes.qualityOfLife.frameMover[info[#info]] = value E:StaticPopup_Show("ProjectHopes_RL") end)
	local POAFMA = POA.frameMover.args
	POAFMA.desc = ACH:Group(L["Description"], nil, 1)
	POAFMA.desc.inline = true
	POAFMA.desc.args.feature = ACH:Description(L["This module provides the feature that repositions the frames with drag and drop."], 1, "medium")
	POAFMA.enable = ACH:Toggle(L["Enable"], nil, 1)
	POAFMA.elvUIBags = ACH:Toggle(L["Move ElvUI Bags"], nil, 2, nil, nil, nil, nil, nil, function() return not E.private.ProjectHopes.qualityOfLife.frameMover.enable end)
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
