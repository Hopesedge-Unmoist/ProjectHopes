local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

function S:ElvUI_ChatPanels()
	if not E.db.ProjectHopes.skins.chatPanels then return end
	
	BORDER:CreateBorder(_G.LeftChatPanel.backdrop)
	BORDER:CreateBorder(_G.RightChatPanel.backdrop)
end

S:AddCallback("ElvUI_ChatPanels")
