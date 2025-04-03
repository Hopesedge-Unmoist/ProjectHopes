local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local DB = E:GetModule("DataBars")

local _G = _G
local pairs = pairs

function S:BorderDataBar(_, name)
	local bar = _G[name]
	BORDER:CreateBorder(bar)
end

function S:ElvUI_DataBars()
	if not E.db.ProjectHopes.skins.dataBars then return end

	local bars = {
		_G.ElvUI_AzeriteBarHolder,
		_G.ElvUI_ExperienceBarHolder,
		_G.ElvUI_ReputationBarHolder,
		_G.ElvUI_HonorBarHolder,
		_G.ElvUI_ThreatBarHolder,
	}
	for _, bar in pairs(bars) do
		if bar then
			BORDER:CreateBorder(bar)
		end
	end

	-- Databars
	S:SecureHook(DB, "CreateBar", "BorderDataBar")
end

S:AddCallback("ElvUI_DataBars")
