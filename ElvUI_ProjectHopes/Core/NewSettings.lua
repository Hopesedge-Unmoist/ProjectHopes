local Name, Private = ...
local E = unpack(ElvUI)

ProjectHopes.ChangelogTBL = {
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


	--- Keep this stuff ---
	Private:Print("New features is now set. Have fun!")
	E:StaticPopup_Show('ProjectHopes_RL')
end