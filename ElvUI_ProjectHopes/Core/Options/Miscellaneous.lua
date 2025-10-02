local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

local ACH = E.Libs.ACH
local format = format

function ProjectHopes:Miscellaneous()
    local SpellHistory = E:GetModule('SpellHistory')

    local POA = ProjectHopes.Options.args

    POA.Miscellaneous = ACH:Group(E:TextGradient(L["Miscellaneous"], 0.6, 0.6, 0.6, 0.65, 0.32, 1), nil, 3, 'tab')
    local POAMSA = POA.Miscellaneous.args

    -- Description group
    POAMSA.miscellaneous = ACH:Group(L["Miscellaneous"], nil, 1)
    POAMSA.miscellaneous.args.desc = ACH:Group(L["Description"], nil, 1)
    POAMSA.miscellaneous.args.desc.inline = true
    POAMSA.miscellaneous.args.desc.args.feature = ACH:Description(L["This is where you can find all the miscellaneous modules that dont fit a catagory."], 1, "medium")

    -- Misc toggles
    POAMSA.miscellaneous.args.mplusimprovements = ACH:Toggle(L["Mythic+ Tab Improvements"], nil, 4, nil, false, 'full', function() return E.db.ProjectHopes.qualityOfLife.mplusimprovements end, function(_, value) E.db.ProjectHopes.qualityOfLife.mplusimprovements = value E:StaticPopup_Show('ProjectHopes_RL') end, not E.Retail, not E.Retail)
    POAMSA.miscellaneous.args.driveButton = ACH:Toggle(L["Cloak Minimap Button, for faster config of Reshii Cloak"], nil, 4, nil, false, 'full', function() return E.db.ProjectHopes.qualityOfLife.driveButton end, function(_, value) E.db.ProjectHopes.qualityOfLife.driveButton = value E:StaticPopup_Show('ProjectHopes_RL') end, not E.Retail, not E.Retail)
    POAMSA.miscellaneous.args.greatVaultInfo = ACH:Toggle(L["Adds more Information to the Great Vault window"], nil, 4, nil, false, 'full', function() return E.db.ProjectHopes.qualityOfLife.greatVaultInfo end, function(_, value) E.db.ProjectHopes.qualityOfLife.greatVaultInfo = value E:StaticPopup_Show('ProjectHopes_RL') end, not E.Retail, not E.Retail)

    -- GCD / Spell History group
    POAMSA.gcd = ACH:Group(L["Spell History(GCD)"], nil, 1)
    POAMSA.gcd.args.desc = ACH:Group(L["Description"], nil, 1)
    POAMSA.gcd.args.desc.inline = true
    POAMSA.gcd.args.desc.args.feature = ACH:Description(L["Track your spell casting history with a visual display that shows your current cast and recently used abilities. \nThis module provides real-time feedback on your rotation, including visual indicators for interrupted casts."], 1, "medium")
    POAMSA.gcd.args.enable = ACH:Toggle(L["Enable"], nil, 4, nil, false, nil, function() return E.db.ProjectHopes.gcd.enable end, function(_, value) E.db.ProjectHopes.gcd.enable = value E:StaticPopup_Show('ProjectHopes_RL') end)
    POAMSA.gcd.args.testIcons = ACH:Execute(L["Show/Hide Icons"], L["Fill all icon slots with test icons"], 5, function() if SpellHistory then SpellHistory:TestDisplay() end end, nil, nil, nil, nil, nil, function() return not E.db.ProjectHopes.gcd.enable end, function() return not E.db.ProjectHopes.gcd.enable end)
    POAMSA.gcd.args.settings = ACH:Group(L["Settings"], nil, 6, nil, nil, nil, function() return not E.db.ProjectHopes.gcd.enable end, function() return not E.db.ProjectHopes.gcd.enable end)
    POAMSA.gcd.args.settings.inline = true
    POAMSA.gcd.args.settings.args.growth = ACH:Select(L["Growth"], nil, 1, Private.Values.Growth, nil, "medium", function() return E.db.ProjectHopes.gcd.growth end, function(_, value) E.db.ProjectHopes.gcd.growth = value if SpellHistory then SpellHistory:UpdateGrowthDirection() end end)
    POAMSA.gcd.args.settings.args.mainIconSize = ACH:Range(L["Cast Icon Size"], L["Adjust the size of the Cast Icon"], 2, Private.Values.IconSize, nil, function() return E.db.ProjectHopes.gcd.mainIconSize end, function(_, value) E.db.ProjectHopes.gcd.mainIconSize = value if SpellHistory then SpellHistory:UpdateMainIconSize() end end)
    POAMSA.gcd.args.settings.args.historyIconSize = ACH:Range(L["History Icons Size"], L["Adjust the size of the History icons"], 3, Private.Values.IconSize, nil, function() return E.db.ProjectHopes.gcd.historyIconSize end, function(_, value) E.db.ProjectHopes.gcd.historyIconSize = value if SpellHistory then SpellHistory:UpdateHistoryIconSize() end end)
    POAMSA.gcd.args.settings.args.historyCount = ACH:Range(L["Number of History Icons"], L["How many spell history icons to display"], 4, {min = 1, max = 10, step = 1}, nil, function() return E.db.ProjectHopes.gcd.historyCount end, function(_, value) E.db.ProjectHopes.gcd.historyCount = value if SpellHistory then SpellHistory:UpdateHistoryCount() end end)
    POAMSA.gcd.args.blacklist = ACH:Group(L["Spell Blacklist"], nil, 7, "tree", nil, nil, function() return not E.db.ProjectHopes.gcd.enable end, function() return not E.db.ProjectHopes.gcd.enable end)
    POAMSA.gcd.args.blacklist.inline = true
    POAMSA.gcd.args.blacklist.args.spells = {type = "group", name = L["Blacklisted Spells"], order = 2, inline = true, args = {}}

    -- Refresh function (must be local, before input)
    local function RefreshBlacklistOptions()
        local args = POAMSA.gcd.args.blacklist.args.spells.args
        wipe(args)
        if E.db.ProjectHopes.gcd.blacklist then
            for spellID in pairs(E.db.ProjectHopes.gcd.blacklist) do
                local id = tonumber(spellID)
                local info = id and C_Spell.GetSpellInfo(id)
                local spellName = (info and info.name) or L["Unknown"]
                local icon = (info and info.iconFileID) and ("|T"..info.iconFileID..":14|t ") or ""
                args["spell"..id] = {
                    type = "toggle",
                    name = icon .. spellName .. " ("..id..")",
                    get = function() return true end,
                    set = function()
                        E.db.ProjectHopes.gcd.blacklist[id] = nil
						
                        if SpellHistory then
                            SpellHistory:RefreshDisplay()
                        end
	
                        RefreshBlacklistOptions()

                        if E.OptionsFrame then
                            E.OptionsFrame:RefreshTree()
                        end
                    end,
                }
            end
        end
    end

    POAMSA.gcd.args.blacklist.args.add = ACH:Input(L["Add SpellID"], L["Enter a spell ID to blacklist"], 1, false, "full", nil, function(_, value) if not E.db.ProjectHopes.gcd.blacklist then E.db.ProjectHopes.gcd.blacklist = {} end local spellID = tonumber(value) if spellID then local info = C_Spell.GetSpellInfo(spellID) if info and info.name then E.db.ProjectHopes.gcd.blacklist[spellID] = true Private:Print(format(L["Added %s (%d) to blacklist."], info.name, spellID)) RefreshBlacklistOptions() if E.OptionsFrame then E.OptionsFrame:RefreshTree() end else Private:Print(L["Invalid spell ID"]) end else Private:Print(L["Please enter a numeric spell ID."]) end end)
    RefreshBlacklistOptions()
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
