local Name, Private = ...
local E = unpack(ElvUI)

ProjectHopes.ChangelogTBL = {
	'v|cff99ff20250310|r 10/03/2025',
	' • New logo yea. ',
	' • Updated Plugin page to be better and stronger lol',
	' • Added Chat border on both side. ',
	' • Fixed Glowline to be better',
	' • Updated M+ dungoen teleports. ',
	' • Removed a taint from Classic (ElvUI recommend) ',
' ',
	'v|cff99ff20250304|r 04/03/2025',
	' • Skin fixes.',
	' • Raid and M+ Weakauras.',
	' • New Sounds.',
	' • New name tag.',
	' • TOC Update.',
' ',
	'v|cff99ff3320250226|r 26/02/2025',
	' • Added missing border on Friends frame, Classic.',
	' • Added Custom anchors.',
	' • Added skin for Nova World Buffs (Thanks Angelos).',
	' • Added skin for Nova Spell Ranker (Thanks Angelos).',
	' • Added skin for Open All (Thanks Angelos).',
	" • Added skin for What's Training (Thanks Angelos).",
	' • Added skin for Leatrix Plus (Thanks Angelos).',
	' • Added skin for Ranker (Thanks Angelos).',
	' • Fix some skin overlaps on wow classic (Thanks Angelos).',
	' • Fixed up Baganator skin.',
	' • Alot of changes to skinning config.',
	' • TOC Update.',
' ',
	'v|cff99ff3320250221|r 21/02/2025',
	' • Added debug mode.',
	' • Added 2 new commands, /projecthopesdebug on/off and /projecthopes to open config.',
	' • Fixed border issues on Class Trainer (Classic)',
	' • Fixed overlap of buttons on Gossip (Classic)',
	' • Fixed overlap of buttons on Merchant window (Classic)',
	' • Added missing border on profession "Unlean" button.',
	' • TOC Update.',
' ',
	'v|cff99ff3320250220|r 20/02/2025',
		' • Merchant expanded on classic.',
		' • Added skin for ThreatClassic2.',
		' • Added skin for Spy.',
		' • Added skin for DBM.',
		' • Added Health Glowline customization(Width and Custom Color)',
		' • Added new tag, "Hopes:perpp" it hides power number when 100 or 0.',
		' • TOC Update.',
	' ',
	'v|cff99ff3320250218|r 18/02/2025',
		' • Added this pretty changelog.',
		' • Removed Class icons and moved into ProjectHopes_Data.',
		' • Updated TOC on Classic and Era and Retail.',
		' • Cleaned up alot more code that is not used anymore.',
	' ',
	'v|cff99ff3320250217|r 17/02/2025',
		' • Added Glowline to health on unitframes.',
		' • Fix for Details frame to error out if not 2 windows out and support for more frames.',
		' • Made Trainer border prettier.',
		' • Fixed Empowered castbar after I changed up some code without testing empowered.',
		' • Removed Purge text weakaura, in classic',
		' • Updated plater, small fixes.',
		' • Added border to Databars.',
		' • Made my plugin free.',
		' • Removed my Profiles, Weakauras and HopesUI module from my plugin.',
		' • Created a new plugin to store my Profiles, Weakauras and HopesUI module.',
		' • Rewrote alot of code.',
		' • TOC Update.',
		' • Changed Version number to date instead.',
	' ',

		-- "• ''",
	-- ' ',
}

function ProjectHopes:LoadNewSettings()
	
	E.db["ProjectHopes"]["skins"]["blizzardOptions"] = true
	E.db["ProjectHopes"]["skins"]["binding"] = true
	E.db["ProjectHopes"]["skins"]["tradeskill"] = true
	E.private["ProjectHopes"]["qualityOfLife"]["detailsResize"] = true

	
	--- Keep this stuff ---
	Private:Print("New features is now set. Have fun!")
	E:StaticPopup_Show('ProjectHopes_RL')
end