local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

local ACH = E.Libs.ACH

function ProjectHopes:Tooltip()
  local POA = ProjectHopes.Options.args

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
