local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local LibStub = _G.LibStub

function S:Hekili()
	if not E.db.ProjectHopes.skins.hekili then return end

	E:Delay(0, function()
		for i = 1, 10 do
			if _G["Hekili_Primary_B"..i] then
				if not _G["Hekili_Primary_B"..i].border then
					BORDER:CreateBorder(_G["Hekili_Primary_B"..i])
				end
			end
			if _G["Hekili_Defensives_B"..i] then
				if not _G["Hekili_Defensives_B"..i].border then
					BORDER:CreateBorder(_G["Hekili_Defensives_B"..i])
				end
			end

			if _G["Hekili_Cooldowns_B"..i] then
				if not _G["Hekili_Cooldowns_B"..i].border then
					BORDER:CreateBorder(_G["Hekili_Cooldowns_B"..i])
				end
			end

			if _G["Hekili_AOE_B"..i] then
				if not _G["Hekili_AOE_B"..i].border then
					BORDER:CreateBorder(_G["Hekili_AOE_B"..i])
				end
			end

			if _G["Hekili_Interrupts_B"..i] then
				if not _G["Hekili_Interrupts_B"..i].border then
					BORDER:CreateBorder(_G["Hekili_Interrupts_B"..i])
				end
			end
		end
	end)
end

S:AddCallbackForAddon("Hekili")
