local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local CH = E:GetModule('Chat')
local DT = E:GetModule('DataTexts')
local AceAddon = E.Libs.AceAddon
local C_UI_Reload = C_UI.Reload
local format, print = format, print
local hooksecurefunc = hooksecurefunc
local SetCVar = SetCVar
local S = E:GetModule('Skins')
local GameMenuFrame = _G.GameMenuFrame
local DisableAddOn = C_AddOns.DisableAddOn
local EnableAddOn = C_AddOns.EnableAddOn
local GetAddOnInfo = C_AddOns.GetAddOnInfo
local GetNumAddOns = C_AddOns.GetNumAddOns
local LoadAddOn = C_AddOns.LoadAddOn

-- Global strings
local ACCEPT = ACCEPT
local CANCEL = CANCEL

-- Chat print
function Private:Print(msg)
	print(Private.Name .. ': ' .. msg)
end

-- Keep these enabled in debug mode
local AddOns = {
	["ElvUI"] = true,
	["ElvUI_Libraries"] = true,
	["ElvUI_ProjectHopes"] = true,
	["ElvUI_Options"] = true,
	["BugSack"] = true,
	["!BugGrabber"] = true -- Use square brackets and quotes for special characters
}

-- Reload popup
E.PopupDialogs.ProjectHopes_RL = {
	text = L["|cff919191Project|r |cffffc607Hopes|r\nReload required - want continue?"],
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = C_UI_Reload,
	whileDead = 1,
	hideOnEscape = false,
}

-- Slightly modified for title text and additional chat print
E.PopupDialogs.ProjectHopes_EDITBOX = {
	text = Private.Name,
	button1 = OKAY,
	hasEditBox = 1,
	OnShow = function(self, data)
		self.editBox:SetAutoFocus(false)
		self.editBox.width = self.editBox:GetWidth()
		self.editBox:Width(280)
		self.editBox:AddHistoryLine('text')
		self.editBox.temptxt = data
		self.editBox:SetText(data)
		self.editBox:HighlightText()
		self.editBox:SetJustifyH('CENTER')
		Private:Print(data)
	end,
	OnHide = function(self)
		self.editBox:Width(self.editBox.width or 50)
		self.editBox.width = nil
		self.temptxt = nil
	end,
	EditBoxOnEnterPressed = function(self)
		self:GetParent():Hide()
	end,
	EditBoxOnEscapePressed = function(self)
		self:GetParent():Hide()
	end,
	EditBoxOnTextChanged = function(self)
		if self:GetText() ~= self.temptxt then
			self:SetText(self.temptxt)
		end
		self:HighlightText()
		self:ClearFocus()
	end,
	OnAccept = E.noop,
	whileDead = 1,
	preferredIndex = 3,
	hideOnEscape = 1,
}

-- Version check popup
E.PopupDialogs.ProjectHopes_VC = {
	text = format('|cffC80000%s|r', L["Your ElvUI is outdated - please update and reload."]),
	whileDead = 1,
	hideOnEscape = false,
}

-- Debug mode
function ProjectHopes:DebugMode(msg)
	local switch = strlower(msg)
	if switch == 'on' then
		for i = 1, GetNumAddOns() do
			local name = GetAddOnInfo(i)
			if not AddOns[name] and E:IsAddOnEnabled(name) then
				DisableAddOn(name, E.myname)
				ProjectHopesDB.ProjectHopesDisabledAddOns[name] = i
			end
		end
		SetCVar('scriptErrors', 1)
		C_UI_Reload()
	elseif switch == 'off' then
		if next(ProjectHopesDB.ProjectHopesDisabledAddOns) then
			for name in pairs(ProjectHopesDB.ProjectHopesDisabledAddOns) do
				EnableAddOn(name, E.myname)
			end
			wipe(ProjectHopesDB.ProjectHopesDisabledAddOns)
			C_UI_Reload()
		end
	else
		Private:Print('Use /ProjectHopesdebug on')
		Private:Print('Or use /ProjectHopesdebug off')
	end
end

-- Register all commands
local function LoadCommands()
	ProjectHopes:RegisterChatCommand('projectHopesdebug', 'DebugMode')
	ProjectHopes:RegisterChatCommand('projecthopes', 'Toggles')
end

-- Events
function ProjectHopes:PLAYER_ENTERING_WORLD(_, initLogin, isReload)
	if initLogin or not ProjectHopesDB.ProjectHopesDisabledAddOns then
		ProjectHopesDB.ProjectHopesDisabledAddOns = {}
	end

	LoadCommands()
end

-- Register events
function ProjectHopes:RegisterEvents()
	ProjectHopes:RegisterEvent('PLAYER_ENTERING_WORLD')
end

