local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next = next
local unpack = unpack
local tinsert = tinsert
local strfind = strfind
local hooksecurefunc = hooksecurefunc

local CreateFrame = CreateFrame
local GetNumTalents = GetNumTalents
local HasPetUI = HasPetUI

local TalentTabs = {}
local function HandleTabs()
	local lastTab
	for index, tab in next, TalentTabs do
		if index ~= 2 or HasPetUI() then
			tab:ClearAllPoints()

			if index == 1 then
				tab:Point('TOPLEFT', _G.PlayerTalentFrame, 'BOTTOMLEFT', -10, -5)
			else
				tab:Point('TOPLEFT', lastTab, 'TOPRIGHT', -14, 0)
			end

			lastTab = tab
		end
	end
end

function S:Blizzard_TalentUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.talent) then return end
	if not E.db.ProjectHopes.skins.talent then return end

	local PlayerTalentFrame = _G.PlayerTalentFrame
	BORDER:CreateBorder(PlayerTalentFrame)
	
	BORDER:CreateBorder(_G.PlayerTalentFrameToggleSummariesButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.PlayerTalentFrameLearnButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.PlayerTalentFrameResetButton, nil, nil, nil, nil, nil, false, true)

	if _G.PlayerTalentFrameActivateButton then
		BORDER:CreateBorder(_G.PlayerTalentFrameActivateButton, nil, nil, nil, nil, nil, false, true)
	end

	for i = 1, 3 do
		local panelName = 'PlayerTalentFramePanel'..i
		local panel = _G[panelName]
		BORDER:CreateBorder(panel.Summary)

		BORDER:CreateBorder(panel.HeaderIcon.backdrop)
		
		panel.Summary.Icon:CreateBackdrop()
		BORDER:CreateBorder(panel.Summary.Icon.backdrop)

		local activeBonus = _G[panelName..'SummaryActiveBonus1']
		if activeBonus then
			BORDER:CreateBorder(activeBonus.backdrop)
		end

		for j = 1, 5 do
			local bonus = _G[panelName..'SummaryBonus'..j]
			if bonus then
				BORDER:CreateBorder(bonus.backdrop)
			end
		end

		for j = 1, _G.MAX_NUM_TALENTS do
			local talent = _G[panelName..'Talent'..j]
			if talent then
				talent:CreateBackdrop()
				BORDER:CreateBorder(talent.backdrop, 1)
			end
		end

		local selectTree = _G[panelName..'SelectTreeButton']
		if selectTree then
			BORDER:CreateBorder(selectTree, nil, nil, nil, nil, nil, false, true)
		end
	end

	-- Pet
	BORDER:CreateBorder(_G.PlayerTalentFramePetPanel.backdrop)

	BORDER:HandleIcon(_G.PlayerTalentFramePetIcon)
	BORDER:HandleIcon(_G.PlayerTalentFramePetPanelHeaderIconIcon)

	for i = 1, GetNumTalents(1, false, true) do
		local talent = _G['PlayerTalentFramePetPanelTalent'..i]
		if talent then
			local icon = _G['PlayerTalentFramePetPanelTalent'..i..'IconTexture']
			if icon then
				icon:CreateBackdrop()
				BORDER:CreateBorder(icon.backdrop, 1)

			end
		end
	end

	-- Tabs
	for i = 1, 3 do
		local tab = _G['PlayerTalentFrameTab'..i]
		tinsert(TalentTabs, tab)
		BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)
	end

	hooksecurefunc('PlayerTalentFrame_UpdateTabs', HandleTabs)
end

function S:Blizzard_GlyphUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.talent) then return end
	if not E.db.ProjectHopes.skins.talent then return end

	-- Glyph Tab
	local GlyphFrame = _G.GlyphFrame
	BORDER:CreateBorder(GlyphFrame)

	BORDER:CreateBorder(_G.GlyphFrameSearchBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(_G.GlyphFrame.FilterDropdown, nil, nil, nil, nil, nil, false, true)

	for i = 1, _G.NUM_GLYPH_SLOTS do
		local frame = _G['GlyphFrameGlyph'..i]
		BORDER:CreateBorder(frame)
	end

	-- Scroll Frame
	BORDER:CreateBorder(_G.GlyphFrameScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)

	for i = 1, 10 do
		local button = _G['GlyphFrameScrollFrameButton'..i]
		if button and not button.IsBorder then
			button.backdrop:SetBackdrop(nil)
			local icon = _G['GlyphFrameScrollFrameButton'..i..'Icon']
			if icon then
				icon:CreateBackdrop()
				BORDER:HandleIcon(icon, true)
			end

			button.IsBorder = true
		end
	end

	-- Clear Info
	BORDER:CreateBorder(GlyphFrame.clearInfo.backdrop)
end

S:AddCallbackForAddon('Blizzard_TalentUI')
S:AddCallbackForAddon('Blizzard_GlyphUI')
