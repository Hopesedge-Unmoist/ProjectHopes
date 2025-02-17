local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

-- Version check popup
E.PopupDialogs.ProjectHopes_VC = {
	text = format('|cffC80000%s|r', L["Your ElvUI is outdated - please update and reload."]),
	whileDead = 1,
	hideOnEscape = false,
}

E.PopupDialogs.ProjectHopes_AltSetup = {
	text = L["|cff919191Project|r |cffffc607Hopes|r\nWant to setup Profiles on this Character?"],
	button1 = "DPS/TANK",
	button2 = "HEAL",
	button3 = "CANCEL",
	OnAccept = function() ProjectHopes:SetupAlts("main") end,
	OnCancel = function() ProjectHopes:SetupAlts("healing") end,
	whileDead = 1,
	hideOnEscape = false,
}

-- Version check
function ProjectHopes:VersionCheck()
	if E.version < Private.RequiredElvUI then
		E:StaticPopup_Show('ProjectHopes_VC')
		Private:Print(format('|cffbf0008%s|r', L["Your ElvUI is outdated - please update and reload."]))
	end

    if E.global.ProjectHopes.install_version and E.global.ProjectHopes.install_version < Private.Version then
		ProjectHopes:NewVersionCheck()
	end

    if E.private.ProjectHopes.install_version == nil and E.global.ProjectHopes.install_version == Private.Version then
		E.private.ProjectHopes.install_version = Private.Version
		E:StaticPopup_Show("ProjectHopes_AltSetup")
	end
end

function ProjectHopes:NewVersionCheck()
	E.global.ProjectHopes.install_version = Private.Version
	local version = (string.format("|cff99ff33"..Private.Version.."|r"))
	Private:Print("Welcome to version "..version..". If you have any issues please join the |TInterface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\phlogotiny.tga:0:0:0:0|t Discord for help")
	E:StaticPopup_Show("ProjectHopes_NVC")
end