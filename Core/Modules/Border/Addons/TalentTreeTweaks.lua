local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc
local pairs = pairs
local type = type
local unpack = unpack
local IsAddOnLoaded = C_AddOns.IsAddOnLoaded

function S:Blizzard_PlayerSpells()
	if not E.db.ProjectHopes.skins.talentTreeTweaks then return end

	if not IsAddOnLoaded("TalentTreeTweaks") then
		return
	end
	
	E:Delay(0.1, function()
		local TalentTreeTweaks = _G.PlayerSpellsFrame.TalentsFrame
		S:HandleButton(TalentTreeTweaks.TalentTreeTweaks_LinkToChatButton)
		BORDER:CreateBorder(TalentTreeTweaks.TalentTreeTweaks_LinkToChatButton, nil, nil, nil, nil, nil, false, true)
	
		local RespecButtonContainer = TalentTreeTweaks.TalentTreeTweaks_RespecButtonContainer
		BORDER:CreateBorder(RespecButtonContainer.RespecButton1, nil, -7, 7, 7, -7)
		BORDER:CreateBorder(RespecButtonContainer.RespecButton2, nil, -7, 7, 7, -7)
		BORDER:CreateBorder(RespecButtonContainer.RespecButton3, nil, -7, 7, 7, -7)
		BORDER:CreateBorder(RespecButtonContainer.RespecButton4, nil, -7, 7, 7, -7)
	
		S:HandleSliderFrame(TalentTreeTweaks.TalentTreeTweaks_TransparencySlider.Slider)
		BORDER:CreateBorder(TalentTreeTweaks.TalentTreeTweaks_TransparencySlider.Slider, nil, nil, nil, nil, nil, true, true)	
	end)

end

-- Using "Blizzard_PlayerSpells" because TalentTreeTweaks is creating button inside PlayerSpells. 
S:AddCallbackForAddon("Blizzard_PlayerSpells")
