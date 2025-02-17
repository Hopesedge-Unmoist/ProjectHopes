local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next = next
local hooksecurefunc = hooksecurefunc

local function SkinPvpTalents(slot)
	local icon = slot.Texture
	BORDER:HandleIcon(icon)
end

local function HandleTabs()
	local tab = _G.InspectFrameTab1
	local index, lastTab = 1, tab
	while tab do
		BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)

		tab:ClearAllPoints()

		if index == 1 then
			tab:Point('TOPLEFT', _G.InspectFrame, 'BOTTOMLEFT', -3, -5)
		else
			tab:Point('TOPLEFT', lastTab, 'TOPRIGHT', 0, 0)
			lastTab = tab
		end

		index = index + 1
		tab = _G['InspectFrameTab'..index]
	end
end

function S:Blizzard_InspectUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.inspect) then return end
	if not E.db.ProjectHopes.skins.inspect then return end

	local InspectFrame = _G.InspectFrame
	BORDER:CreateBorder(InspectFrame)

	BORDER:CreateBorder(_G.InspectPaperDollFrame.ViewButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.InspectPaperDollItemsFrame.InspectTalents, nil, nil, nil, nil, nil, false, true)

	-- PvP Talents
	for i = 1, 3 do
		SkinPvpTalents(InspectPVPFrame['TalentSlot'..i])
	end

	_G.InspectModelFrameBackgroundTopLeft:Hide()
	_G.InspectModelFrameBackgroundTopRight:Hide()
	_G.InspectModelFrameBackgroundBotLeft:Hide()
	_G.InspectModelFrameBackgroundBotRight:Hide()
	_G.InspectModelFrameBackgroundOverlay:Hide()

	if _G.InspectModelFrame.backdrop then
		_G.InspectModelFrame.backdrop:Kill()
	end

	-- Tabs
	HandleTabs()

	_G.InspectPaperDollItemsFrame.InspectTalents:ClearAllPoints()
	_G.InspectPaperDollItemsFrame.InspectTalents:Point('TOPRIGHT', _G.InspectFrame, 'BOTTOMRIGHT', 0, -7)
	
	for _, Slot in pairs({_G.InspectPaperDollItemsFrame:GetChildren()}) do
		if Slot:IsObjectType('Button') or Slot:IsObjectType('ItemButton') then
			if not Slot.icon then return end

			BORDER:HandleIcon(Slot.icon)

			BORDER:HandleIconBorder(Slot.IconBorder, Slot.icon.backdrop.border)
		end
	end
end

S:AddCallbackForAddon('Blizzard_InspectUI')
