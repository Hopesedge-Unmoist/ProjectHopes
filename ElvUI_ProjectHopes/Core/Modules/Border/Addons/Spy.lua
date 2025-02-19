local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc
local pairs = pairs
local type = type
local unpack = unpack

function S:Spy()
	if not E.db.ProjectHopes.skins.spy then
		return
	end
	
	local Spy_MainWindow = _G.Spy_MainWindow
	Spy_MainWindow:StripTextures()
	Spy_MainWindow:SetTemplate('Transparent')

	BORDER:CreateBorder(Spy_MainWindow)
	
end

S:AddCallbackForAddon("Spy")
