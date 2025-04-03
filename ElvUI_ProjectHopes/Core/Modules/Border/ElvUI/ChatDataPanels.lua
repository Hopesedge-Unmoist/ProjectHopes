local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local LO = E:GetModule("Layout")

local _G = _G

function S:BorderChatDataPanels()
	local leftCP = E.db.datatexts.panels.LeftChatDataPanel
	local rightCP = E.db.datatexts.panels.RightChatDataPanel

	if leftCP.enable and leftCP.backdrop then
		_G.LeftChatDataPanel.border:Show()
		_G.LeftChatToggleButton.border:Show()
	else
		_G.LeftChatDataPanel.border:Hide()
		_G.LeftChatToggleButton.border:Hide()
	end

	if rightCP.enable and rightCP.backdrop then
		_G.RightChatDataPanel.border:Show()
		_G.RightChatToggleButton.border:Show()
	else
		_G.RightChatDataPanel.border:Hide()
		_G.RightChatToggleButton.border:Hide()
	end
end

function S:ElvUI_ChatPanels()
	if not E.db.ProjectHopes.skins.chatDataPanels then return end

	BORDER:CreateBorder(_G.LeftChatDataPanel)
	BORDER:CreateBorder(_G.LeftChatToggleButton)

	BORDER:CreateBorder(_G.RightChatDataPanel)
	BORDER:CreateBorder(_G.RightChatToggleButton)


	-- Maunel run of Datapanels on start and let the funtion handle show/hide
	S:BorderChatDataPanels()
	S:SecureHook(LO, "ToggleChatPanels", "BorderChatDataPanels")
end

S:AddCallback("ElvUI_ChatPanels")
