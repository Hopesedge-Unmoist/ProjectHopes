local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

local ACH = E.Libs.ACH

function ProjectHopes:WeakAurasAnchors()
  local POA = ProjectHopes.Options.args

	POA.weakAurasAnchors = ACH:Group(E:TextGradient(L["Weakaura Anchors"], 0.6, 0.6, 0.6, 0.29, 0.35, 1), nil, 3)
	local POAWA = POA.weakAurasAnchors.args
	POAWA.desc = ACH:Group(L["Description"], nil, 1)
	POAWA.desc.inline = true
	POAWA.desc.args.feature1 = ACH:Description(L["This module provides the feature to add Anchors within ElvUI to anchor weakuras to."], 1, "medium")
	POAWA.enable = ACH:Toggle(L["Enable"], nil, 2, nil, false, "full",function() return E.private.ProjectHopes.qualityOfLife.weakAurasAnchors end,function(_, value) E.private.ProjectHopes.qualityOfLife.weakAurasAnchors = value E:StaticPopup_Show('ProjectHopes_RL') end)
	POAWA.spacer = ACH:Spacer(3)
	POAWA.desc2 = ACH:Group(L["How does it work?"], nil, 3, nil, nil, nil, nil, function() return not E.private.ProjectHopes.qualityOfLife.weakAurasAnchors end)
	POAWA.desc2.inline = true
	POAWA.desc2.args.feature1 = ACH:Description(L["You go into '"].."|cffffc607/wa|r"..L["', and find the weakaura you want to anchor to the new Anchor Frames."], 1, "medium")
	POAWA.desc2.args.feature2 = ACH:Description(L["Once you have found the weakaura, scroll down in '"].."|cffffc607Display|r"..L["' in single weakura or '"].."|cffffc607Group|r"..L["' in group, until you find '"].."|cffffc607Position and Size Settings|r"..L["'."], 2, "medium")
	POAWA.desc2.args.feature3 = ACH:Description(L["When you have expanded '"].."|cffffc607Position and Size Settings|r"..L["' type in the name off one of the new custom Anchors."], 3, "medium")
	POAWA.desc2.args.feature4 = ACH:Description(L["\n"].."|cffffc607Anchor Names|r"..L[":\n"].."|cff81c783ProjectHopesBarAnchor|r"..L["\n"].."|cff81c783ProjectHopesExtraBarAnchor|r"..L["\n"].."|cff81c783ProjectHopesIconAnchor|r"..L["\n"].."|cff81c783ProjectHopesExtraIconAnchor|r"..L["\n"].."|cff81c783ProjectHopesTextAnchor|r"..L["\n"], 4, "medium")
	POAWA.desc2.args.feature5 = ACH:Description(L["After you have typed in one of the anchors, you can go to '"].."|cffffc607/emove|r"..L["' and select '"]..Private.Name..L["' in the '"].."|cffffc607Config Mode|r"..L["' move the Anchors around."], 5, "medium")
	POAWA.desc2.args.feature6 = ACH:Description(" ", 6, nil, 'Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\WeakauraAnchorDemo.tga', nil, 512, 512)
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
