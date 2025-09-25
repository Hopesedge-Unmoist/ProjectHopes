local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

local ACH = E.Libs.ACH
local pairs = pairs
local format = format
local IsAddOnLoaded = _G.C_AddOns and _G.C_AddOns.IsAddOnLoaded or _G.IsAddOnLoaded

function ProjectHopes:Borders()
  local POA = ProjectHopes.Options.args

	POA.Borders = ACH:Group(E:TextGradient(L["Borders"], 0.6, 0.6, 0.6, 1, 0.93, 0.66), nil, 3, 'tab')
	local POABS = POA.Borders.args
	POABS.desc = ACH:Group(L["Description"], nil, 1)
	POABS.desc.inline = true
	POABS.desc.args.feature = ACH:Description(L["This module adds border and skin various ElvUI, Blizzard and Addons."], 1, "medium")

	POABS.UnitFrames = ACH:Group(L["UnitFrames"], nil, 1)
	POABS.UnitFrames.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.desc.inline = true
	POABS.UnitFrames.args.desc.args.feature = ACH:Description(L["This is where you can choose what UnitFrames to have border."], 1, "medium")

	POABS.UnitFrames.args.playerborder = ACH:Group(L["Player"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.player.enable end, nil, nil)
	POABS.UnitFrames.args.playerborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.playerborder.args.desc.inline = true
	POABS.UnitFrames.args.playerborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Player Unitframe"], 1, "medium")
	POABS.UnitFrames.args.playerborder.args.player = ACH:Toggle(L["Enable"], nil, 3, nil, false, nil, function() return E.db.ProjectHopes.border.Player end,function(_, value) E.db.ProjectHopes.border.Player = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.player.enable end)
	POABS.UnitFrames.args.playerborder.args.playersep = ACH:Toggle(L["Power/Health Separator"], nil, 4, nil, false, nil, function() return E.db.ProjectHopes.border.Playersep end,function(_, value) E.db.ProjectHopes.border.Playersep = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.player.power.enable or not E.db.ProjectHopes.border.Player or not E.db.unitframe.units.player.enable end)
	
	POABS.UnitFrames.args.petborder = ACH:Group(L["Pet"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.pet.enable end, nil, nil)
	POABS.UnitFrames.args.petborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.petborder.args.desc.inline = true
	POABS.UnitFrames.args.petborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Pet Unitframe"], 1, "medium")
	POABS.UnitFrames.args.petborder.args.pet = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.Pet end,function(_, value) E.db.ProjectHopes.border.Pet = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.pet.enable end)
	
	POABS.UnitFrames.args.pettargetborder = ACH:Group(L["Pet Target"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.pettarget.enable end, nil, nil)
	POABS.UnitFrames.args.pettargetborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.pettargetborder.args.desc.inline = true
	POABS.UnitFrames.args.pettargetborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Pet Target Unitframe"], 1, "medium")
	POABS.UnitFrames.args.pettargetborder.args.enable = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.PetTarget end,function(_, value) E.db.ProjectHopes.border.PetTarget = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.pettarget.enable end)
	
	POABS.UnitFrames.args.targetborder = ACH:Group(L["Target"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.target.enable end, nil, nil)
	POABS.UnitFrames.args.targetborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.targetborder.args.desc.inline = true
	POABS.UnitFrames.args.targetborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Target Unitframes."], 1, "medium")
	POABS.UnitFrames.args.targetborder.args.target = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.Target end,function(_, value) E.db.ProjectHopes.border.Target = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.target.enable end)
	POABS.UnitFrames.args.targetborder.args.targetsep = ACH:Toggle(L["Power/Health Separator"], nil, 4, nil, false, "full",function() return E.db.ProjectHopes.border.Targetsep end,function(_, value) E.db.ProjectHopes.border.Targetsep = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.target.power.enable or not E.db.ProjectHopes.border.Target end)

	POABS.UnitFrames.args.focusborder = ACH:Group(L["Focus"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.focus.enable end, E.Classic, nil)
	POABS.UnitFrames.args.focusborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.focusborder.args.desc.inline = true
	POABS.UnitFrames.args.focusborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Focus Unitframes."], 1, "medium")
	POABS.UnitFrames.args.focusborder.args.focus = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.Focus end,function(_, value) E.db.ProjectHopes.border.Focus = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.focus.enable end)
	
	POABS.UnitFrames.args.focustargetborder = ACH:Group(L["Focus Target"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.focustarget.enable end, not E.Retail, nil)
	POABS.UnitFrames.args.focustargetborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.focustargetborder.args.desc.inline = true
	POABS.UnitFrames.args.focustargetborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Focus Target Unitframes."], 1, "medium")
	POABS.UnitFrames.args.focustargetborder.args.enable = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.FocusTarget end,function(_, value) E.db.ProjectHopes.border.FocusTarget = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.focustarget.enable end)
	
	POABS.UnitFrames.args.targetoftargetborder = ACH:Group(L["Target of Target"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.targettarget.enable end, nil, nil)
	POABS.UnitFrames.args.targetoftargetborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.targetoftargetborder.args.desc.inline = true
	POABS.UnitFrames.args.targetoftargetborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Target of Target Unitframes"], 1, "medium")
	POABS.UnitFrames.args.targetoftargetborder.args.tot = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.TargetofTarget end,function(_, value) E.db.ProjectHopes.border.TargetofTarget = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.targettarget.enable end)
	
	POABS.UnitFrames.args.targetoftargetoftargetborder = ACH:Group(L["Target of Target of Target"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.targettargettarget.enable end, nil, nil)
	POABS.UnitFrames.args.targetoftargetoftargetborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.targetoftargetoftargetborder.args.desc.inline = true
	POABS.UnitFrames.args.targetoftargetoftargetborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Target of Target Unitframes"], 1, "medium")
	POABS.UnitFrames.args.targetoftargetoftargetborder.args.enable = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.TargetofTargetofTarget end,function(_, value) E.db.ProjectHopes.border.TargetofTargetofTarget = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.targettargettarget.enable end)
	
	POABS.UnitFrames.args.partyborder = ACH:Group(L["Party"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.party.enable end, nil, nil)
	POABS.UnitFrames.args.partyborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.partyborder.args.desc.inline = true
	POABS.UnitFrames.args.partyborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Party Unitframe."], 1, "medium")
	POABS.UnitFrames.args.partyborder.args.party = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.Party end,function(_, value) E.db.ProjectHopes.border.Party = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.party.enable end)
	POABS.UnitFrames.args.partyborder.args.PartySpaced = ACH:Toggle(L["Party Spaced"], nil, 4, nil, false, "full",function() return E.db.ProjectHopes.border.PartySpaced end,function(_, value) E.db.ProjectHopes.border.PartySpaced = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.party.enable end)
	POABS.UnitFrames.args.partyborder.args.partysep = ACH:Toggle(L["Separator"], nil, 5, nil, false, "full",function() return E.db.ProjectHopes.border.Partysep end,function(_, value) E.db.ProjectHopes.border.Partysep = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.party.enable or not E.db.ProjectHopes.border.Party end)
	
	POABS.UnitFrames.args.raid1border = ACH:Group(L["Raid1"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.raid1.enable end, nil, nil)
	POABS.UnitFrames.args.raid1border.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.raid1border.args.desc.inline = true
	POABS.UnitFrames.args.raid1border.args.desc.args.feature = ACH:Description(L["Adds a border to the Raid1 Unitframe."], 1, "medium")
	POABS.UnitFrames.args.raid1border.args.raid = ACH:Toggle(L["Heal"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.raid end,function(_, value) E.db.ProjectHopes.border.raid = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.raid1.enable end)
	POABS.UnitFrames.args.raid1border.args.raidbackdrop = ACH:Toggle(L["Heal (Backdrop)"], nil, 4, nil, false, "full",function() return E.db.ProjectHopes.border.raidbackdrop end,function(_, value) E.db.ProjectHopes.border.raidbackdrop = value E:StaticPopup_Show('ProjectHopes_RL') end, nil, function() return not E.db.ProjectHopes.border.raid end)
	POABS.UnitFrames.args.raid1border.args.raiddps = ACH:Toggle(L["DPS/TANK"], nil, 5, nil, false, "full",function() return E.db.ProjectHopes.border.raiddps end,function(_, value) E.db.ProjectHopes.border.raiddps = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.raid1.enable end)

	POABS.UnitFrames.args.raid2border = ACH:Group(L["Raid2"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.raid2.enable end, nil, nil)
	POABS.UnitFrames.args.raid2border.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.raid2border.args.desc.inline = true
	POABS.UnitFrames.args.raid2border.args.desc.args.feature = ACH:Description(L["Adds a border to the Raid2 Unitframe."], 1, "medium")
	POABS.UnitFrames.args.raid2border.args.raid = ACH:Toggle(L["Heal"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.raid2 end,function(_, value) E.db.ProjectHopes.border.raid2 = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.raid2.enable end)
	POABS.UnitFrames.args.raid2border.args.raidbackdrop = ACH:Toggle(L["Heal (Backdrop)"], nil, 4, nil, false, "full",function() return E.db.ProjectHopes.border.raid2backdrop end,function(_, value) E.db.ProjectHopes.border.raid2backdrop = value E:StaticPopup_Show('ProjectHopes_RL') end, nil, function() return not E.db.ProjectHopes.border.raid2 end)
	POABS.UnitFrames.args.raid2border.args.raiddps = ACH:Toggle(L["DPS/TANK"], nil, 5, nil, false, "full",function() return E.db.ProjectHopes.border.raid2dps end,function(_, value) E.db.ProjectHopes.border.raid2dps = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.raid2.enable end)
	
	POABS.UnitFrames.args.raid3border = ACH:Group(L["Raid3"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.raid3.enable end, nil, nil)
	POABS.UnitFrames.args.raid3border.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.raid3border.args.desc.inline = true
	POABS.UnitFrames.args.raid3border.args.desc.args.feature = ACH:Description(L["Adds a border to the Raid3 Unitframe."], 1, "medium")
	POABS.UnitFrames.args.raid3border.args.raid = ACH:Toggle(L["Heal"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.raid3 end,function(_, value) E.db.ProjectHopes.border.raid3 = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.raid3.enable end)
	POABS.UnitFrames.args.raid3border.args.raidbackdrop = ACH:Toggle(L["Heal (Backdrop)"], nil, 4, nil, false, "full",function() return E.db.ProjectHopes.border.raid3backdrop end,function(_, value) E.db.ProjectHopes.border.raid3backdrop = value E:StaticPopup_Show('ProjectHopes_RL') end, nil, function() return not E.db.ProjectHopes.border.raid3 end)
	POABS.UnitFrames.args.raid3border.args.raiddps = ACH:Toggle(L["DPS/TANK"], nil, 5, nil, false, "full",function() return E.db.ProjectHopes.border.raid3dps end,function(_, value) E.db.ProjectHopes.border.raid3dps = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.raid3.enable end)
	
	POABS.UnitFrames.args.tankframeborder = ACH:Group(L["Tank Frames"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.tank.enable end, nil, nil)
	POABS.UnitFrames.args.tankframeborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.tankframeborder.args.desc.inline = true
	POABS.UnitFrames.args.tankframeborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Tank Unitframe."], 1, "medium")
	POABS.UnitFrames.args.tankframeborder.args.maintankofftank = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.Maintankofftank end,function(_, value) E.db.ProjectHopes.border.Maintankofftank = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.tank.enable end)
	POABS.UnitFrames.args.assistunitborder= ACH:Group(L["Assist Units"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.assist.enable end, nil, nil)
	POABS.UnitFrames.args.assistunitborder.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.assistunitborder.args.desc.inline = true
	POABS.UnitFrames.args.assistunitborder.args.desc.args.feature = ACH:Description(L["Adds a border to the Assist Unitframe."], 1, "medium")
	POABS.UnitFrames.args.assistunitborder.args.maintankofftank = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.AssistUnits end,function(_, value) E.db.ProjectHopes.border.AssistUnits = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.assist.enable end)
	
	POABS.UnitFrames.args.bossborders = ACH:Group(L["Boss"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.boss.enable end, E.Classic, nil)
	POABS.UnitFrames.args.bossborders.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.bossborders.args.desc.inline = true
	POABS.UnitFrames.args.bossborders.args.desc.args.feature = ACH:Description(L["Adds a border to the Boss Unitframes"], 1, "medium")
	POABS.UnitFrames.args.bossborders.args.boss = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.Boss end,function(_, value) E.db.ProjectHopes.border.Boss = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.boss.enable end)

	POABS.UnitFrames.args.arenaborders = ACH:Group(L["Arena"], nil, 1, nil, nil, nil, function() return not E.db.unitframe.units.arena.enable end, E.Classic, nil)
	POABS.UnitFrames.args.arenaborders.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.UnitFrames.args.arenaborders.args.desc.inline = true
	POABS.UnitFrames.args.arenaborders.args.desc.args.feature = ACH:Description(L["Adds a border to the Arena Unitframes"], 1, "medium")
	POABS.UnitFrames.args.arenaborders.args.arena = ACH:Toggle(L["Enable"], nil, 3, nil, false, "full",function() return E.db.ProjectHopes.border.Arena end,function(_, value) E.db.ProjectHopes.border.Arena = value E:StaticPopup_Show('ProjectHopes_RL') end, function() return not E.db.unitframe.units.arena.enable end)

	POABS.Addons = ACH:Group(L["Addons"], nil, 1)
	POABS.Addons.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.Addons.args.desc.inline = true
	POABS.Addons.args.desc.args.feature = ACH:Description(L["Skins Addons to fit ProjectHopes."], 1, "medium")

	local addontoggles = {}
	if E.Classic or E.Mists or E.Retail then
		if IsAddOnLoaded("BigWigs") then addontoggles.bigwigsqueue = L["BigWigs Queue"] end
		if IsAddOnLoaded("Auctionator") then addontoggles.auctionator = L["Auctionator"] end
		if IsAddOnLoaded("BugSack") then addontoggles.bugsack = L["BugSack"] end
		if IsAddOnLoaded("OmniCD") then addontoggles.omnicd = L["OmniCD"] end
		if IsAddOnLoaded("RareScanner") then addontoggles.rareScanner = L["Rare Scanner"] end
		if IsAddOnLoaded("Weakauras") then addontoggles.weakAurasOptions = L["Weakauras Option"] end
		if IsAddOnLoaded("Baganator") then addontoggles.Baganator = L["Baganator"] end
		if IsAddOnLoaded("Details") then addontoggles.details = L["Details"] end
		if IsAddOnLoaded("DBM-Core") then addontoggles.dbm = L["DBM"] end
		if IsAddOnLoaded("Leatrix_Plus") then addontoggles.leatrix_plus = L["Leatrix Plus"] end
		if IsAddOnLoaded("OpenAll") then addontoggles.openall = L["Open All"] end
		if IsAddOnLoaded("RXPGuides") then addontoggles.rxpguides = L["RXPGuides AH"] end
		if IsAddOnLoaded("Atlas") then addontoggles.atlas = L["Atlas"] end
		if IsAddOnLoaded("SimpleAddonManager") then addontoggles.simpleaddonmanager = L["SimpleAddonManager"] end
		if IsAddOnLoaded("OPie") then addontoggles.opie = L["OPie"] end
	end

	if E.Retail then
		if IsAddOnLoaded("WarpDeplete") then addontoggles.warpDeplete = L["WarpDeplete"] end
		if IsAddOnLoaded("RaiderIO") then addontoggles.raiderio = L["RaiderIO"] end
		if IsAddOnLoaded("Simulationcraft") then addontoggles.simulationcraft = L["Simulationcraft"] end
		if IsAddOnLoaded("MazeHelper") then addontoggles.mazeHelper = L["Maze Helper"] end
		if IsAddOnLoaded("TalentTreeTweaks") then addontoggles.talentTreeTweaks = L["Talent Tree Tweaks"] end
		if IsAddOnLoaded("TalentLoadoutsEx") then addontoggles.talentLoadoutsEx = L["Talent Loadouts Ex"] end
		if IsAddOnLoaded("ChoreTracker") then addontoggles.choreTracker = L["Chore Tracker"] end
	end

	if E.Classic then
		if IsAddOnLoaded("Ranker") then addontoggles.ranker = L["Ranker"] end
		if IsAddOnLoaded("NovaSpellRankChecker") then addontoggles.novaspellrankchecker = L["Nova Spell Rank Checker"] end
		if IsAddOnLoaded("AtlasLootClassic") then addontoggles.atlaslootclassic = L["Atlas Loot Classic"] end
	end

	if E.Mists then
	end

	if E.Mists or E.Retail then
		if IsAddOnLoaded("Hekili") then addontoggles.hekili = L["Hekili"] end
	end

	if E.Classic or E.Mists then
		if IsAddOnLoaded("ThreatClassic2") then addontoggles.threatClassic2 = L["ThreatClassic2"] end
		if IsAddOnLoaded("NovaWorldBuffs") then addontoggles.novaworldbuffs = L["Nova World Buffs"] end
		if IsAddOnLoaded("NovaWorldBuffs") and E.db.ProjectHopes.skins.novaworldbuffs then addontoggles.novaworldbuffsposition = L["Nova World Buffs Position"] end
		if IsAddOnLoaded("WhatsTraining") then addontoggles.whatstraining = L["What's Training"] end
		if IsAddOnLoaded("LFGBulletinBoard") then addontoggles.lfgbulletinboard = L["LFG Group Bulletin Board"] end
	end

	if E.Classic or E.Retail then
		if IsAddOnLoaded("Spy") then addontoggles.spy = L["Spy"] end
	end

	local function ToggleAddOnsSkins(value)
		E:StaticPopup_Show('ProjectHopes_RL')
    for key in pairs(addontoggles) do
			if key ~= 'enable' then
				E.db.ProjectHopes.skins[key] = value
			end
		end
	end

	POABS.Addons.args.disableAddOnsSkins = ACH:Execute(L["Disable AddOns Skins"], nil, 3, function() ToggleAddOnsSkins(false) end)
	POABS.Addons.args.enableAddOnsSkins = ACH:Execute(L["Enable AddOns Skins"], nil, 4, function() ToggleAddOnsSkins(true) end)
	POABS.Addons.args.addons = ACH:MultiSelect(L["AddOns"], L["Enable/Disable this skin."], -1, addontoggles, nil, nil, function(_, key) return E.db.ProjectHopes.skins[key] end, function(_, key, value) E.db.ProjectHopes.skins[key] = value; E:StaticPopup_Show('ProjectHopes_RL') end, nil, nil, true)

	POABS.Blizzard = ACH:Group(L["Blizzard"], nil, 1)
	POABS.Blizzard.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.Blizzard.args.desc.inline = true
	POABS.Blizzard.args.desc.args.feature = ACH:Description(L["Skins Blizzard frames to fit ProjectHopes."], 1, "medium")

	local blizzardtoggles = {
		addonList = L["AddOn Manager"],
		auctionHouse = L["AUCTIONS"],
		bags = L["Bags"],
		bgmap = L["BG Map"],
		bgscore = L["BG Score"],
		binding = L["KEY_BINDINGS"],
		blizzardOptions = L["INTERFACE_OPTIONS"],
		channels = L["CHANNELS"],
		character = L["Character Frame"],
		communities = L["COMMUNITIES"],
		debugTools = L["Debug Tools"],
		dressingRoom = L["DRESSUP_FRAME"],
		eventTrace = L["Event Log"],
		friends = format(E.Retail and '%s' or '%s & %s', L["Friends"], L["Guild"]),
		gossip = L["Gossip Frame"],
		guildControl = L["Guild Control Frame"],
		guildRegistrar = L["Guild Registrar"],
		help = L["Help Frame"],
		inspect = L["Inspect"],
		inputMethodEditor = L["Input Method Editor"],
		lookingForGroup = L["LFG_TITLE"],
		loot = L["Loot Frame"],
		macro = L["MACROS"],
		mail = L["Mail Frame"],
		merchant = L["Merchant Frame"],
		mirrorTimers = L["Mirror Timers"],
		misc = L["Misc Frames"],
		petition = L["Petition Frame"],
		quest = L["Quest Frames"],
		questChoice = L["Quest Choice"],
		raid = L["Raid Frame"],
		itemSocketing = L["Socket Frame"],
		spellBook = L["SPELLBOOK"],
		stable = L["Stable"],
		tabard = L["Tabard Frame"],
		talent = L["TALENTS"],
		flightMap = L["FLIGHT_MAP"],
		taxi = L["Taxi"],
		timeManager = L["TIMEMANAGER_TITLE"],
		tooltips = L["Tooltip"],
		trade = L["TRADE"],
		tradeskill = L["TRADESKILLS"],
		trainer = L["Trainer Frame"],
		tutorial = L["Tutorials"],
		worldMap = L["WORLD_MAP"]
	}

	if E.Mists or E.Retail then
	blizzardtoggles.achievementFrame = L["ACHIEVEMENTS"]
	blizzardtoggles.alertframes = L["Alert Frames"]
	blizzardtoggles.archaeology = L["Archaeology Frame"]
	blizzardtoggles.barbershop = L["BARBERSHOP"]
	blizzardtoggles.calendar = L["Calendar Frame"]
	blizzardtoggles.collections = L["COLLECTIONS"]
	blizzardtoggles.encounterJournal = L["ENCOUNTER_JOURNAL"]
	blizzardtoggles.guildBank = L["Guild Bank"]
	blizzardtoggles.pvp = L["PvP Frames"]
	blizzardtoggles.petBattle = L["Pet Battle"]
	blizzardtoggles.transmogrify = L["TRANSMOGRIFY"]
	end

	if not E.Retail then
		blizzardtoggles.questTimers = L["Quest Timers"]
	end

	if E.Retail then
		blizzardtoggles.adventureMap = L["ADVENTURE_MAP_TITLE"]
		blizzardtoggles.alliedRaces = L["Allied Races"]
		blizzardtoggles.animaDiversionFrame = L["Anima Diversion"]
		blizzardtoggles.artifactFrame = L["ITEM_QUALITY6_DESC"]
		blizzardtoggles.azerite = L["Azerite"]
		blizzardtoggles.azeriteEssence = L["Azerite Essence"]
		blizzardtoggles.azeriteRespec = L["AZERITE_RESPEC_TITLE"]
		blizzardtoggles.blackMarket = L["BLACK_MARKET_AUCTION_HOUSE"]
		blizzardtoggles.campsites = L["Campsite"]
		blizzardtoggles.chromieTime = L["Chromie Time Frame"]
		blizzardtoggles.cooldownManager = L["Cooldown Manager"]
		blizzardtoggles.contribution = L["Contribution"]
		blizzardtoggles.covenantPreview = L["Covenant Preview"]
		blizzardtoggles.covenantRenown = L["Covenant Renown"]
		blizzardtoggles.covenantSanctum = L["Covenant Sanctum"]
		blizzardtoggles.deathRecap = L["DEATH_RECAP_TITLE"]
		blizzardtoggles.editModeManager = L["Editor Manager"]
		blizzardtoggles.expansionLandingPage = L["Expansion Landing Page"]
		blizzardtoggles.garrison = L["GARRISON_LOCATION_TOOLTIP"]
		blizzardtoggles.genericTrait = L["Generic Trait"]
		blizzardtoggles.gmChat = L["GM Chat"]
		blizzardtoggles.guide = L["Guide Frame"]
		blizzardtoggles.guild = L["Guild"]
		blizzardtoggles.islandQueue = L["ISLANDS_HEADER"]
		blizzardtoggles.islandsPartyPose = L["Island Party Pose"]
		blizzardtoggles.itemInteraction = L["Item Interaction"]
		blizzardtoggles.itemUpgrade = L["Item Upgrade"]
		blizzardtoggles.lfguild = L["LF Guild Frame"]
		blizzardtoggles.losscontrol = L["LOSS_OF_CONTROL"]
		blizzardtoggles.majorFactions = L["Major Factions"]
		blizzardtoggles.nonraid = L["Non-Raid Frame"]
		blizzardtoggles.objectiveTracker = L["OBJECTIVES_TRACKER_LABEL"]
		blizzardtoggles.obliterum = L["OBLITERUM_FORGE_TITLE"]
		blizzardtoggles.orderHall = L["Orderhall"]
		blizzardtoggles.perksProgram = L["Trading Post"]
		blizzardtoggles.playerChoice = L["Player Choice Frame"]
		blizzardtoggles.runeforge = L["Runeforge"]
		blizzardtoggles.scrappingMachine = L["SCRAP_BUTTON"]
		blizzardtoggles.soulbinds = L["Soulbinds"]
		blizzardtoggles.talkinghead = L["Talking Head"]
		blizzardtoggles.torghastLevelPicker = L["Torghast Level Picker"]
		blizzardtoggles.voidstorage = L["VOID_STORAGE"]
		blizzardtoggles.weeklyRewards = L["Weekly Rewards"]
		blizzardtoggles.ticketStatus = L["Ticket Status"]
	elseif E.Mists then
		blizzardtoggles.arenaRegistrar = L["Arena Registrar"]
		blizzardtoggles.reforge = L["Reforge"]
	elseif E.Classic then
		blizzardtoggles.engraving = L["Engraving"]
		blizzardtoggles.battlefield = L["Battlefield"]
		blizzardtoggles.craft = L["Craft"]
	end

	local function ToggleBlizzardSkins(value)
		E:StaticPopup_Show('ProjectHopes_RL')
    for key in pairs(blizzardtoggles) do
			if key ~= 'enable' then
				E.db.ProjectHopes.skins[key] = value
			end
		end
	end
	
	POABS.Blizzard.args.disableBlizzardSkins = ACH:Execute(L["Disable Blizzard Skins"], nil, 3, function() ToggleBlizzardSkins(false) end)
	POABS.Blizzard.args.enableBlizzardSkins = ACH:Execute(L["Enable Blizzard Skins"], nil, 4, function() ToggleBlizzardSkins(true) end)
	POABS.Blizzard.args.blizzard = ACH:MultiSelect(L["Blizzard"], L["Enable/Disable this skin."], -1, blizzardtoggles, nil, nil, function(_, key) return E.db.ProjectHopes.skins[key] end, function(_, key, value) E.db.ProjectHopes.skins[key] = value; E:StaticPopup_Show('ProjectHopes_RL') end, nil, nil, true)

	POABS.ElvUI = ACH:Group(L["ElvUI"], nil, 1)
	POABS.ElvUI.args.desc = ACH:Group(L["Description"], nil, 1)
	POABS.ElvUI.args.desc.inline = true
	POABS.ElvUI.args.desc.args.feature = ACH:Description(L["Skins ElvUI frames to fit ProjectHopes."], 1, "medium")

	local elvuitoggles = {
		actionBarsBackdrop = L["Actionbars Backdrop"],
		actionBarsButton = L["Actionbars Button"],
		afk = L["AFK Mode"],
		altPowerBar = L["Alt Power"],
		minimapAuras = L["Minimap Auras"],
		chatDataPanels = L["Chat Data Panels"],
		castbar = L["CastBars"],
		chatPanels = L["Chat Panels"],
		chatVoicePanel = L["Chat Voice Panels"],
		classBars = L["Class Bars"],
		dataPanels = L["DataPanels"],
		dataBars = L["Data Bars"],
		lootRoll = L["Loot Roll"],
		options = L["Options"],
		panels = L["Panels"],
		raidUtility = L["Raid Utility"],
		staticPopup = L["Static Popup"],
		statusReport = L["Status Report"],
		totemTracker = L["Totem Tracker"],
		tooltips = L["Tooltips"],
		Minimap = L["Minimap"],
		nameplates = L["Nameplates"],
		unitframeAuras = L["Unitframe Auras"],
	}

	if E.Retail then
		elvuitoggles.tooltipscolor = L["Tooltips"]
	end

	local function ToggleElvUISkins(value)
		E:StaticPopup_Show('ProjectHopes_RL')
    for key, _ in pairs(elvuitoggles) do
			if key ~= 'enable' then
				E.db.ProjectHopes.skins[key] = value
			end
		end
	end

	POABS.ElvUI.args.disableElvUISkins = ACH:Execute(L["Disable ElvUI Skins"], nil, 3, function() ToggleElvUISkins(false) end)
	POABS.ElvUI.args.enableElvUISkins = ACH:Execute(L["Enable ElvUI Skins"], nil, 4, function() ToggleElvUISkins(true) end)
	POABS.ElvUI.args.elvui = ACH:MultiSelect(L["ElvUI"], L["Enable/Disable this skin."], -1, elvuitoggles, nil, nil, function(_, key) return E.db.ProjectHopes.skins[key] end, function(_, key, value) E.db.ProjectHopes.skins[key] = value; E:StaticPopup_Show('ProjectHopes_RL') end, nil, nil, true)
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
