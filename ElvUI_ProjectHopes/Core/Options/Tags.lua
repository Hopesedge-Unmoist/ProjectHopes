local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

local ACH = E.Libs.ACH

function ProjectHopes:Tags()
  local POA = ProjectHopes.Options.args

	POA.Tags = ACH:Group(E:TextGradient(L["Tags"], 0.6, 0.6, 0.6, 1, 0.31, 0.55), nil, 3)
	local POATSA = POA.Tags.args
	POATSA.desc = ACH:Group(L["Description"], nil, 1)
	POATSA.desc.inline = true
	POATSA.desc.args.feature = ACH:Description(L["This is where you can find all the miscellaneous modules that dont fit a catagory."], 1, "medium")
	POATSA.spacer = ACH:Spacer(2, 'full')
	POATSA.tag1 = ACH:Input(L["Shows the Units role with icon."], nil, 3, nil, 'full', function() return '[Hopes:role]' end, nil, nil)
	POATSA.tag2 = ACH:Input(L["Shows the percent health and absorb without %."], nil, 3, nil, 'full', function() return '[Hopes:perhp]' end, nil, nil, not E.Retail)
	POATSA.tag3 = ACH:Input(L["Shows the Units raidmarker when selected."], nil, 3, nil, 'full', function() return '[Hopes:raidmarker]' end, nil, nil)
	POATSA.tag4 = ACH:Input(L["Shows the Leader Icon or Assist icon if the unit is Leader or Assist."], nil, 3, nil, 'full', function() return '[Hopes:leader]' end, nil, nil)
	POATSA.tag5 = ACH:Input(L["Shows heal absorb on unit."], nil, 3, nil, 'full', function() return '[Hopes:healabsorbs]' end, nil, nil, not E.Retail)
	POATSA.tag6 = ACH:Input(L["Shows the percent power without %, and hide it when 0 or 100"], nil, 3, nil, 'full', function() return '[Hopes:perpp]' end, nil, nil)
	POATSA.tag7 = ACH:Input(L["Name tag that changes the color of name based on class, raidmarker and unit."], nil, 3, nil, 'full', function() return '[Hopes:name]' end, nil, nil)
	POATSA.tag8 = ACH:Input(L["Displays the Unit Status time."], nil, 3, nil, 'full', function() return '[Hopes:statustimer]' end, nil, nil)
	POATSA.tag9 = ACH:Input(L["Shows the Max health of Unit at 100% health, if under 100% it switches to percent health without percent icon."], nil, 3, nil, 'full', function() return '[Hopes:maxhealth:percent]' end, nil, nil)
	POATSA.tag10 = ACH:Input(L["Shows the Units role with text (DPS is not shown)."], nil, 3, nil, 'full', function() return '[Hopes:roletext]' end, nil, nil)
	POATSA.tag11 = ACH:Input(L["Shows healer only power in percent without %."], nil, 3, nil, 'full', function() return '[Hopes:healerperpp]' end, nil, nil)
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
