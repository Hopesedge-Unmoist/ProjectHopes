local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

local ACH = E.Libs.ACH

function ProjectHopes:Miscellaneous()
  local POA = ProjectHopes.Options.args

	POA.Miscellaneous = ACH:Group(E:TextGradient(L["Miscellaneous"], 0.6, 0.6, 0.6, 0.65, 0.32, 1), nil, 3)
	local POAMSA = POA.Miscellaneous.args
	POAMSA.desc = ACH:Group(L["Description"], nil, 1)
	POAMSA.desc.inline = true
	POAMSA.desc.args.feature = ACH:Description(L["This is where you can find all the miscellaneous modules that dont fit a catagory."], 1, "medium")
	POAMSA.mplusimprovements = ACH:Toggle(L["Mythic+ Tab Improvements"], nil, 4, nil, false, 'full', function() return E.db.ProjectHopes.qualityOfLife.mplusimprovements end,function(_, value) E.db.ProjectHopes.qualityOfLife.mplusimprovements = value E:StaticPopup_Show('ProjectHopes_RL') end, not E.Retail, not E.Retail)
	POAMSA.driveButton = ACH:Toggle(L["Cloak Minimap Button, for faster config of Reshii Cloak"], nil, 4, nil, false, 'full', function() return E.db.ProjectHopes.qualityOfLife.driveButton end,function(_, value) E.db.ProjectHopes.qualityOfLife.driveButton = value E:StaticPopup_Show('ProjectHopes_RL') end, not E.Retail, not E.Retail)
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
