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

-- Chat print
function Private:Print(msg)
	print(Private.Name .. ': ' .. msg)
end

-- Reload popup
E.PopupDialogs.ProjectHopes_RL = {
	text = L["|cff919191Project|r |cffffc607Hopes|r\nReload required - want continue?"],
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = C_UI_Reload,
	whileDead = 1,
	hideOnEscape = false,
}

-- Editbox popup from ElvUI\Core\General\StaticPopups.lua:78
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




