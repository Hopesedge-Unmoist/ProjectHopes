local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next = next
local unpack = unpack
local hooksecurefunc = hooksecurefunc

local HasPetUI = HasPetUI
local GetInventoryItemQuality = GetInventoryItemQuality

local GetItemQualityColor = C_Item.GetItemQualityColor

local NUM_FACTIONS_DISPLAYED = NUM_FACTIONS_DISPLAYED
local CHARACTERFRAME_SUBFRAMES = CHARACTERFRAME_SUBFRAMES

local function PaperDollItemSlotButtonUpdate(frame)
	if not frame.SetBackdropBorderColor then return end

	local id = frame:GetID()
	local rarity = id and GetInventoryItemQuality('player', id)
	BORDER:CreateBorder(frame)
	if rarity and rarity > 1 then
		local r, g, b = GetItemQualityColor(rarity)
		frame.border:SetBackdrop(Private.BorderLight)
		frame.border:SetBackdropBorderColor(r, g, b)
	end
end

local function HandleTabs()
	local lastTab
	for index, tab in next, { _G.CharacterFrameTab1, HasPetUI() and _G.CharacterFrameTab2 or nil, _G.CharacterFrameTab3, _G.CharacterFrameTab4, _G.CharacterFrameTab5 } do
		tab:ClearAllPoints()
		BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)

		if index == 1 then
			tab:Point('TOPLEFT', _G.CharacterFrame, 'BOTTOMLEFT', 0, 71)
		else
			tab:Point('TOPLEFT', lastTab, 'TOPRIGHT', -14, 0)
		end

		lastTab = tab
	end
end


local function HandleResistanceFrame(frameName)
	for i = 1, 5 do
		local frame, icon, text = _G[frameName..i], _G[frameName..i]:GetRegions()
		BORDER:CreateBorder(frame)

		if i ~= 1 then
			frame:ClearAllPoints()
			frame:Point('TOP', _G[frameName..i - 1], 'BOTTOM', 0, -5)
		end
	end
end

function S:CharacterFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.character) then return end
	if not E.db.ProjectHopes.skins.character then return end

	-- Character Frame
	local CharacterFrame = _G.CharacterFrame
	BORDER:CreateBorder(CharacterFrame.backdrop)

	for i = 1, #CHARACTERFRAME_SUBFRAMES do
		BORDER:CreateBorder(_G['CharacterFrameTab'..i], nil, nil, nil, nil, nil, true, true)
	end

	-- Seasonal
	if E.ClassicSOD then
		local runeButton = _G.RuneFrameControlButton
		if runeButton then
			BORDER:CreateBorder(runeButton, nil, nil, nil, nil, nil, false, true)
		end
	end

	-- Reposition Tabs
	hooksecurefunc('PetTab_Update', HandleTabs)
	HandleTabs()

	HandleResistanceFrame('MagicResFrame')

	hooksecurefunc('PaperDollItemSlotButton_Update', PaperDollItemSlotButtonUpdate)

	HandleResistanceFrame('PetMagicResFrame')

	BORDER:CreateBorder(_G.PetPaperDollFrameExpBar)

	-- Reputation Frame
	for i = 1, NUM_FACTIONS_DISPLAYED do
		local factionBar = _G['ReputationBar'..i]

		BORDER:CreateBorder(factionBar)
	end

	BORDER:CreateBorder(_G.ReputationListScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(_G.ReputationDetailFrame)

	BORDER:CreateBorder(_G.ReputationDetailAtWarCheckbox, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.ReputationDetailInactiveCheckbox, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.ReputationDetailMainScreenCheckbox, nil, nil, nil, nil, nil, true, true)

	-- Skill Frame
	for i = 1, _G.SKILLS_TO_DISPLAY do
		local bar = _G['SkillRankFrame'..i]
		
		BORDER:CreateBorder(bar)
	end

	BORDER:CreateBorder(_G.SkillListScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(_G.SkillDetailScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(_G.SkillDetailStatusBar)
	
	BORDER:CreateBorder(_G.SkillDetailStatusBarUnlearnButton, nil, nil, nil, nil, nil, true, true)

	-- Honor Tab
	BORDER:CreateBorder(_G.HonorFrameProgressBar)
end

S:AddCallback('CharacterFrame')
