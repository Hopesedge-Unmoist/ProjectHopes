local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local ipairs = ipairs
local hooksecurefunc = hooksecurefunc

function S:Blizzard_CombatLog()
	if not E.db.ProjectHopes.skins.misc then return end

	if E.private.chat.enable ~= true then return end
	-- this is always on with the chat module, it's only handle the top bar in combat log chat frame

	local Button = _G.CombatLogQuickButtonFrame_Custom
	Button:SetTemplate('Transparent')
	BORDER:CreateBorder(Button)
end

S:AddCallbackForAddon('Blizzard_CombatLog')
