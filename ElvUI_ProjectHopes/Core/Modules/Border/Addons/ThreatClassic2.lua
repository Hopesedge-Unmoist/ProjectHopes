local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc
local pairs = pairs
local type = type
local unpack = unpack

function S:ThreatClassic2()
	if not E.db.ProjectHopes.skins.threatClassic2 then
		return
	end
	
	local ThreatClassic2BarFrame = _G.ThreatClassic2BarFrame
	ThreatClassic2BarFrame:StripTextures()
	ThreatClassic2BarFrame:SetTemplate('Transparent')

	E:Delay(0, function()
		if ThreatClassic2BarFrame.header:IsShown() then 
			ThreatClassic2BarFrame.header:StripTextures()
			ThreatClassic2BarFrame.header:SetTemplate('Transparent')
			ThreatClassic2BarFrame.header.edgeBackdrop:Kill()
			ThreatClassic2BarFrame.header:SetHeight(25)
	
			BORDER:CreateBorder(ThreatClassic2BarFrame, 2, nil, ThreatClassic2BarFrame.header:GetHeight() + 8)
			BORDER:CreateSeparator(ThreatClassic2BarFrame)
		else
			BORDER:CreateBorder(ThreatClassic2BarFrame)
		end	
			for _, child in pairs{ThreatClassic2BarFrame:GetChildren()} do
					if child:IsObjectType("StatusBar") then
							BORDER:CreateSeparator(child)
							if ThreatClassic2BarFrame.header.separator then
								ThreatClassic2BarFrame.header.separator:Kill()
							end
					end
			end
	end)
end

S:AddCallbackForAddon("ThreatClassic2")
