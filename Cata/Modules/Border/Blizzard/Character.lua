local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local pairs, format = pairs, format
local unpack, next = unpack, next

local hooksecurefunc = hooksecurefunc
local GetItemQualityColor = GetItemQualityColor
local GetInventoryItemQuality = GetInventoryItemQuality
local GetItemQualityByID = C_Item.GetItemQualityByID
local HasPetUI = HasPetUI

local GetContainerItemID = C_Container.GetContainerItemID
local EquipmentManager_UnpackLocation = EquipmentManager_UnpackLocation

local FLYOUT_LOCATIONS = {
	[0xFFFFFFFF] = 'PLACEINBAGS',
	[0xFFFFFFFE] = 'IGNORESLOT',
	[0xFFFFFFFD] = 'UNIGNORESLOT'
}

local function EquipmentManagerPane_Update(frame)
	for _, child in next, { frame.ScrollTarget:GetChildren() } do
		if child.icon then
			BORDER:CreateBorder(child.icon, nil, -7, 7, 7, -7, nil, true)
		end
		BORDER:CreateBorder(child.PaperDollFrameIcon, nil, nil, nil, nil, nil, nil, false)
	end
end

local function HandleItemButtonQuality(button, rarity)
	if not button.border then return end
	if rarity and rarity > 1 then
		local r, g, b = GetItemQualityColor(rarity)
		button.border:SetBackdrop(Private.BorderLight)
		button.border:SetBackdropBorderColor(r, g, b)
	else
		button.border:SetBackdropBorderColor(1, 1, 1)
	end
end

local function PaperDollItemButtonQuality(button)
	if not button.SetBackdropBorderColor then return end

	local id = button.id or button:GetID()
	local rarity = id and GetInventoryItemQuality('player', id)

	HandleItemButtonQuality(button, rarity)
end

local function EquipmentItemButtonQuality(button)
	if not button.SetBackdropBorderColor then return end

	local location, rarity = button.location
	if location then
		local _, _, bags, slot, bag = EquipmentManager_UnpackLocation(location)
		if bags then
			local itemID = GetContainerItemID(bag, slot)
			rarity = itemID and GetItemQualityByID(itemID)
		else
			rarity = GetInventoryItemQuality('player', slot)
		end
	end

	HandleItemButtonQuality(button, rarity)
end

local function TabTextureCoords(tex, x1)
	if x1 ~= 0.16001 then
		tex:SetTexCoord(0.16001, 0.86, 0.16, 0.86)
	end
end

local function UpdateCurrencySkins()
	local TokenFramePopup = _G.TokenFramePopup
	if TokenFramePopup then
		BORDER:CreateBorder(TokenFramePopup)
		BORDER:CreateBorder(_G.TokenFramePopupInactiveCheckbox, nil, nil, nil, nil, nil, true, true)
		BORDER:CreateBorder(_G.TokenFramePopupBackpackCheckbox, nil, nil, nil, nil, nil, true, true)
	end
end

local function HandleTabs()
	local lastTab
	for index, tab in next, { _G.CharacterFrameTab1, HasPetUI() and _G.CharacterFrameTab2 or nil, _G.CharacterFrameTab3, _G.CharacterFrameTab4, _G.CharacterFrameTab5 } do
		tab:ClearAllPoints()

		if index == 1 then
			tab:Point('TOPLEFT', _G.CharacterFrame, 'BOTTOMLEFT', -10, -6)
		else
			tab:Point('TOPLEFT', lastTab, 'TOPRIGHT', -14, 0)
		end

		lastTab = tab
	end
end

local function EquipmentDisplayButton(button)
	BORDER:CreateBorder(button)

	if FLYOUT_LOCATIONS[button.location] then -- special slots
		button:SetBackdropBorderColor(unpack(E.media.bordercolor))
	end
end

local function EquipmentUpdateItems()
	for _, button in next, _G.EquipmentFlyoutFrame.buttons do
		EquipmentDisplayButton(button)
	end
end

function S:CharacterFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.character) then return end
	if not E.db.ProjectHopes.skins.character then return end

	-- General
	local CharacterFrame = _G.CharacterFrame
	BORDER:CreateBorder(CharacterFrame)

	local slots = {
		_G.CharacterHeadSlot,
		_G.CharacterNeckSlot,
		_G.CharacterShoulderSlot,
		_G.CharacterShirtSlot,
		_G.CharacterChestSlot,
		_G.CharacterWaistSlot,
		_G.CharacterLegsSlot,
		_G.CharacterFeetSlot,
		_G.CharacterWristSlot,
		_G.CharacterHandsSlot,
		_G.CharacterFinger0Slot,
		_G.CharacterFinger1Slot,
		_G.CharacterTrinket0Slot,
		_G.CharacterTrinket1Slot,
		_G.CharacterBackSlot,
		_G.CharacterMainHandSlot,
		_G.CharacterSecondaryHandSlot,
		_G.CharacterRangedSlot,
		_G.CharacterTabardSlot,
		_G.CharacterAmmoSlot
	}

	for _, slot in pairs(slots) do
		if slot:IsObjectType('Button') then
			local icon = _G[slot:GetName()..'IconTexture']
			
			BORDER:CreateBorder(icon)
		end
	end

	for _, scrollbar in pairs({ _G.PaperDollFrame.EquipmentManagerPane.ScrollBar, _G.PaperDollFrame.TitleManagerPane.ScrollBar, _G.CharacterStatsPane.ScrollBar }) do
		BORDER:CreateBorder(scrollbar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	end

	-- Re-add the overlay texture which was removed right above via StripTextures
	_G.CharacterModelFrameBackgroundOverlay:Kill()
	_G.CharacterModelFrameBackgroundTopLeft:Kill()
	_G.CharacterModelFrameBackgroundTopRight:Kill()
	_G.CharacterModelFrameBackgroundBotLeft:Kill()
	_G.CharacterModelFrameBackgroundBotRight:Kill()
	_G.CharacterModelScene.backdrop:Kill()

	_G.PetModelFrame.backdrop:Kill()
	_G.PetPaperDollPetModelBg:Kill()
	BORDER:HandleModelSceneControlButtons(_G.CharacterModelScene.ControlFrame)

	-- Equipement Manager
	hooksecurefunc(_G.PaperDollFrame.EquipmentManagerPane.ScrollBox, 'Update', EquipmentManagerPane_Update)
	BORDER:CreateBorder(_G.PaperDollFrameEquipSet, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.PaperDollFrameSaveSet, nil, nil, nil, nil, nil, false, true)

	-- Icon selection frame
	_G.GearManagerPopupFrame:HookScript('OnShow', function(frame)
		if frame.IsBorder then return end -- set by HandleIconSelectionFrame

		BORDER:HandleIconSelectionFrame(frame)
	end)

	-- Stats
	for i = 1, 7 do
		local frame = _G['CharacterStatsPaneCategory'..i]
		BORDER:CreateBorder(frame)
	end

	-- Pet Frame
	BORDER:CreateBorder(_G.PetPaperDollFrameExpBar)
	BORDER:CreateBorder(_G.PetModelFrameRotateLeftButton)
	BORDER:CreateBorder(_G.PetModelFrameRotateRightButton)

	-- Reputation Frame
	BORDER:CreateBorder(_G.ReputationDetailFrame)

	for i = 1, _G.NUM_FACTIONS_DISPLAYED do
		local factionStatusBar = _G['ReputationBar'..i..'ReputationBar']

		BORDER:CreateBorder(factionStatusBar)
	end

	BORDER:CreateBorder(_G.ReputationListScrollFrameScrollBar)
	BORDER:CreateBorder(_G.ReputationDetailAtWarCheckbox, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.ReputationDetailInactiveCheckbox, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.ReputationDetailMainScreenCheckbox, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(_G.TokenFrameContainerScrollBar)

	hooksecurefunc(_G.TokenFrameContainer, 'update', UpdateCurrencySkins)
	hooksecurefunc('TokenFrame_Update', UpdateCurrencySkins)
	hooksecurefunc('PaperDollItemSlotButton_Update', PaperDollItemButtonQuality)

	-- Equipment Flyout
	hooksecurefunc('EquipmentFlyout_UpdateItems', EquipmentUpdateItems) -- Swap item flyout frame (shown when holding alt over a slot)
	hooksecurefunc('EquipmentFlyout_DisplayButton', EquipmentItemButtonQuality)

	-- Tabs
	for i = 1, #_G.CHARACTERFRAME_SUBFRAMES do
		BORDER:CreateBorder(_G['CharacterFrameTab'..i], nil, nil, nil, nil, nil, true, true)
	end

	-- Reposition Tabs
	hooksecurefunc('PetPaperDollFrame_UpdateIsAvailable', HandleTabs)
	HandleTabs()

	for i = 1, 3 do
		local SidebarTab = _G["PaperDollSidebarTab" .. i]
		if SidebarTab then
			BORDER:CreateBorder(SidebarTab, 1, nil, nil, nil, nil, false, true)
		end
	end
end

S:AddCallback('CharacterFrame')
