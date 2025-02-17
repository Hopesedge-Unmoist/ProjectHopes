local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc
local pairs = pairs
local type = type
local unpack = unpack

function S:Simulationcraft()
	if not E.db.ProjectHopes.skins.simulationcraft then return end

	local Simc = E.Libs.AceAddon:GetAddon("Simulationcraft")
	hooksecurefunc(Simc, 'GetMainFrame', function()
		if not _G["SimcFrame"].IsBorder then
			S:HandleFrame(_G["SimcFrame"])
			S:HandleButton(_G["SimcFrameButton"])
			S:HandleScrollBar(_G["SimcScrollFrameScrollBar"])

			if _G["SimcFrame"] and not _G["SimcFrame"].border then
				BORDER:CreateBorder(_G["SimcFrame"])
				BORDER:CreateBorder(_G["SimcFrameButton"], nil, nil, nil, nil, nil, false, true)
				BORDER:CreateBorder(_G["SimcScrollFrameScrollBar"])
			end

			_G["SimcFrame"].IsBorder = true
		end
	end)
end

S:AddCallbackForAddon("Simulationcraft")
