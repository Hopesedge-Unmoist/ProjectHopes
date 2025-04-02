local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local UF = E:GetModule("UnitFrames")

local _G = _G

function S:BorderClassBar(_, frame)
	local bar = frame[frame.ClassBar]
	BORDER:CreateBorder(bar)
end

function S:ElvUI_ClassBars()
	if not E.private.unitframe.enable then return	end
	if not E.db.ProjectHopes.skins.classBars then return end

	-- Classbars
	S:SecureHook(UF, "Configure_ClassBar", "BorderClassBar")
end

S:AddCallback("ElvUI_ClassBars")