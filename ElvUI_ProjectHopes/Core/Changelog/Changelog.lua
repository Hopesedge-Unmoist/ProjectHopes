local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local C_UI_Reload = C_UI.Reload

local CHANGELOG = {
	"|cff919191Project|r |cffffc607Hopes|r\n",
	"|cff85ff75Changelog|r:",

	"Added Glowline to health on unitframes.",
	"Fix for Details frame to error out if not 2 windows out and support for more frames.",
	"Made Trainer border prettier.",
	"Fixed Empowered castbar after I changed up some code without testing empowered.",
	"Removed Purge text weakaura, in classic",
	"Updated plater, small fixes.",
	"Added border for Databars",

	"\n\n|cffffc607Do you want to enable the new features?|r"
}

local changeLog = table.concat(CHANGELOG, "\n")

-- New Version popup
E.PopupDialogs.ProjectHopes_NVC = {
	text = changeLog,
	button1 = "Yes",
	button2 = "No",
	OnAccept = function() ProjectHopes:LoadNewSettings() end,
	whileDead = 1,
	hideOnEscape = false,
}

function ProjectHopes:LoadNewSettings()
	E.db["ProjectHopes"]["unitframe"]["unitFramesGlowline"] = true
	E.db["ProjectHopes"]["skins"]["dataPanels"] = true

	--- Keep this stuff ---
	Private:Print("New features is now set. Have fun!")
	E:StaticPopup_Show('ProjectHopes_RL')
end