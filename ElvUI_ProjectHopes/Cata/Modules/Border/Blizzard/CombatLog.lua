local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local CH = E:GetModule('Chat')
local LSM = E.Libs.LSM

local _G = _G
local ipairs = ipairs
local hooksecurefunc = hooksecurefunc

function S:Blizzard_CombatLog()
	if not E.private.chat.enable then return end
    if not E.db.ProjectHopes.skins.channels then return end

	local bar = _G.CombatLogQuickButtonFrame_Custom
	BORDER:CreateBorder(bar)

	local progress = _G.CombatLogQuickButtonFrame_CustomProgressBar
	BORDER:CreateBorder(progress)
end

S:AddCallbackForAddon('Blizzard_CombatLog')
