local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local TT = E:GetModule('Tooltip')

local pairs = pairs
local unpack = unpack

local _G = _G
local CreateFrame = CreateFrame
local hooksecurefunc = hooksecurefunc
local ITEM_QUALITY_COLORS = ITEM_QUALITY_COLORS
local C_PetBattles_GetPetType = C_PetBattles.GetPetType
local C_PetBattles_GetNumAuras = C_PetBattles.GetNumAuras
local C_PetBattles_GetAuraInfo = C_PetBattles.GetAuraInfo
local C_PetBattles_GetBreedQuality = C_PetBattles.GetBreedQuality
local BattlePetOwner_Weather = Enum.BattlePetOwner.Weather

local function SkinPetButton(self, bf)
	if self.backdrop then
		BORDER:CreateBorder(self, nil, nil, nil, nil, nil, false, true)
	end
end

function S:PetBattleFrame()
	if not E.Retail then return end
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.petbattleui) then return end
	if not E.db.ProjectHopes.skins.petBattle then return end

	local f = _G.PetBattleFrame
	local bf = f.BottomFrame
	local infoBars = {
		f.ActiveAlly,
		f.ActiveEnemy
	}

	for index, infoBar in pairs(infoBars) do
		BORDER:CreateBorder(infoBar.Icon.backdrop)
		BORDER:CreateBorder(infoBar.ActualHealthBar.backdrop)
	end

	local extraInfoBars = {
		f.Ally2,
		f.Ally3,
		f.Enemy2,
		f.Enemy3
	}

	for _, infoBar in pairs(extraInfoBars) do
		BORDER:CreateBorder(infoBar.Icon.backdrop)
		BORDER:CreateBorder(infoBar.ActualHealthBar.backdrop)
		infoBar.ActualHealthBar:Point('TOPLEFT', infoBar.Icon, 'BOTTOMLEFT', 0, -5)
		infoBar.ActualHealthBar:Size(35, 17)
		infoBar.ActualHealthBar.backdrop:ClearAllPoints()
		infoBar.ActualHealthBar.backdrop:Point('TOPLEFT', infoBar.Icon.backdrop, 'BOTTOMLEFT', 0, -5)
		infoBar.ActualHealthBar.backdrop:Point('TOPRIGHT', infoBar.Icon.backdrop, 'BOTTOMRIGHT', 0, -5)
		infoBar.ActualHealthBar.backdrop:Point('BOTTOMLEFT', infoBar.ActualHealthBar, 0, 0)
	end

	-- PETS UNITFRAMES AURA SKINS
	hooksecurefunc('PetBattleAuraHolder_Update', function(s)
		if not (s.petOwner and s.petIndex) then return end

		local nextFrame = 1
		for i=1, C_PetBattles_GetNumAuras(s.petOwner, s.petIndex) do
			local _, _, turnsRemaining, isBuff = C_PetBattles_GetAuraInfo(s.petOwner, s.petIndex, i)
			if (isBuff and s.displayBuffs) or (not isBuff and s.displayDebuffs) then
				local frame = s.frames[nextFrame]
				BORDER:CreateBorder(frame.backdrop)
				frame.backdrop.border:SetBackdrop(Private.BorderLight)

				if isBuff then
					frame.backdrop.border:SetBackdropBorderColor(0, 1, 0)
				else
					frame.backdrop.border:SetBackdropBorderColor(1, 0, 0)
				end

				nextFrame = nextFrame + 1
			end
		end
	end)
	

	local actionBar = _G.ElvUIPetBattleActionBar
	BORDER:CreateBorder(actionBar)

	local turnTimer = bf.TurnTimer
	BORDER:CreateBorder(turnTimer.SkipButton, nil, nil, nil, nil, nil, false, true)

	hooksecurefunc(turnTimer.SkipButton, 'SetPoint', function(btn, _, _, _, _, _, forced)
		if forced == true then return end

		btn:ClearAllPoints()
		btn:Point('BOTTOMLEFT', bar, 'TOPLEFT', 0, 6, true)
		btn:Point('BOTTOMRIGHT', bar, 'TOPRIGHT', 0, 6, true)

		turnTimer:SetSize(turnTimer.SkipButton:GetSize()) -- set after the skip button points
	end)

	BORDER:CreateBorder(bf.xpBar.backdrop, nil, -7, 7, 7, -7)
	bf.xpBar:Size(80, 16)

	bf.xpBar:Point('BOTTOMLEFT', turnTimer.SkipButton, 'TOPLEFT', 0, 6)
	bf.xpBar:Point('BOTTOMRIGHT', turnTimer.SkipButton, 'TOPRIGHT', 0, 6)

	hooksecurefunc('PetBattleUnitFrame_UpdateDisplay', function(s)   
		if s.petOwner and s.petIndex and (s.Icon.backdrop and s.Icon.backdrop:IsShown()) then
			local rarity = C_PetBattles_GetBreedQuality(s.petOwner, s.petIndex)
			if rarity then
				local color = ITEM_QUALITY_COLORS[rarity]
				s.Icon.backdrop.border:SetBackdrop(Private.BorderLight)
				s.Icon.backdrop.border:SetBackdropBorderColor(color.r, color.g, color.b)
			end
		end
	end)

	hooksecurefunc('PetBattleFrame_UpdateActionBarLayout', function()
		for i=1, _G.NUM_BATTLE_PET_ABILITIES do
			local b = bf.abilityButtons[i]
			SkinPetButton(b, bf)
		end

		SkinPetButton(bf.SwitchPetButton, bf)
		SkinPetButton(bf.CatchButton, bf)
		SkinPetButton(bf.ForfeitButton, bf)
	end)

	local PetBattleQueueReadyFrame = _G.PetBattleQueueReadyFrame
	BORDER:CreateBorder(PetBattleQueueReadyFrame)
	BORDER:CreateBorder(PetBattleQueueReadyFrame.AcceptButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(PetBattleQueueReadyFrame.DeclineButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallback('PetBattleFrame')
