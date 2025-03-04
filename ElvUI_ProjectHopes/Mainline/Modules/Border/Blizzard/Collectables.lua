local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local TT = E:GetModule('Tooltip')

local _G = _G
local next, unpack = next, unpack
local ipairs, pairs = ipairs, pairs
local select, strfind = select, strfind
local hooksecurefunc = hooksecurefunc

local CreateFrame = CreateFrame
local PlayerHasToy = PlayerHasToy

local C_Heirloom_PlayerHasHeirloom = C_Heirloom.PlayerHasHeirloom
local C_TransmogCollection_GetSourceInfo = C_TransmogCollection.GetSourceInfo
local GetItemQualityColor = C_Item.GetItemQualityColor
local GetItemQualityByID = C_Item.GetItemQualityByID

local QUALITY_7_R, QUALITY_7_G, QUALITY_7_B = GetItemQualityColor(7)
local BAG_ITEM_QUALITY_COLORS = BAG_ITEM_QUALITY_COLORS

local function selectedTextureSetShown(texture, shown) -- used sets list
	local parent = texture:GetParent()
	local icon = parent.icon or parent.Icon
	if shown then
		parent.backdrop:SetBackdropBorderColor(1, .8, .1)
		icon.backdrop:SetBackdropBorderColor(1, .8, .1)
	else
		local r, g, b = unpack(E.media.bordercolor)
		parent.backdrop:SetBackdropBorderColor(r, g, b)
		icon.backdrop:SetBackdropBorderColor(r, g, b)
	end
end

local function selectedTextureShow(texture) -- used for pets/mounts
	local parent = texture:GetParent()
	parent.border:SetBackdropBorderColor(1, .8, .1)
	parent.icon.backdrop.border:SetBackdropBorderColor(1, .8, .1)
end

local function selectedTextureHide(texture) -- used for pets/mounts
	local parent = texture:GetParent()
	if not parent.hovered then
		local r, g, b = 132/255, 132/255, 132/255
		parent.border:SetBackdropBorderColor(r, g, b)
		parent.icon.backdrop.border:SetBackdropBorderColor(r, g, b)
	end
end

local function buttonOnEnter(button)
	local r, g, b = 1, 0.78, 0.03
	local icon = button.icon or button.Icon
	button.border:SetBackdropBorderColor(r, g, b)
	icon.backdrop.border:SetBackdropBorderColor(r, g, b)
	button.hovered = true
end

local function buttonOnLeave(button)
	local icon = button.icon or button.Icon
	if button.selected or (button.SelectedTexture and button.SelectedTexture:IsShown()) then
		button.border:SetBackdropBorderColor(1, .8, .1)
		icon.backdrop.border:SetBackdropBorderColor(1, .8, .1)
	else
		local r, g, b = 132/255, 132/255, 132/255
		button.border:SetBackdropBorderColor(r, g, b)
		icon.backdrop.border:SetBackdropBorderColor(r, g, b)
	end
	button.hovered = nil
end

local function JournalScrollButtons(frame)
	if not frame then return end

	for _, bu in next, { frame.ScrollTarget:GetChildren() } do
		if not bu.isBorder then
			local icon = bu.icon or bu.Icon

			local r, g, b = 132/255, 132/255, 132/255
			BORDER:CreateBorder(bu, nil, -7, 6, 7, -6)
			bu.border:SetBackdrop(Private.BorderLight)
			bu.border:SetBackdropBorderColor(r, g, b)

			BORDER:CreateBorder(icon.backdrop, 1, -7, 8, 8, -8)
			icon.backdrop.border:SetBackdrop(Private.BorderLight)
			icon.backdrop.border:SetBackdropBorderColor(r, g, b)
			bu:HookScript('OnEnter', buttonOnEnter)
			bu:HookScript('OnLeave', buttonOnLeave)

			local parent = frame:GetParent()
			if parent == _G.WardrobeCollectionFrame.SetsCollectionFrame then
				hooksecurefunc(bu.SelectedTexture, 'SetShown', selectedTextureSetShown)
			else
				bu.selectedTexture:SetTexture()
				hooksecurefunc(bu.selectedTexture, 'Show', selectedTextureShow)
				hooksecurefunc(bu.selectedTexture, 'Hide', selectedTextureHide)
			end
			bu.isBorder = true
		end
	end
end

local function HandleDynamicFlightButton(button, index)
	if button.Border then button.Border:Hide() end

	local icon = select(index, button:GetRegions())
	if icon then
		BORDER:HandleIcon(icon, true)
	end
end

local function ToySpellButtonUpdateButton(button)
	if button.itemID and PlayerHasToy(button.itemID) then
		local quality = GetItemQualityByID(button.itemID)
		if quality then
			local r, g, b = GetItemQualityColor(quality)
			button.backdrop.border:SetBackdropBorderColor(r, g, b)
		else
			button.backdrop.border:SetBackdropBorderColor(0.9, 0.9, 0.9)
		end
	else
		local r, g, b = 132/255, 132/255, 132/255
		button.backdrop.border:SetBackdropBorderColor(r, g, b)
	end
end

local function HeirloomsJournalUpdateButton(_, button)
	if not button.IsBorder then
		BORDER:CreateBorder(button.backdrop)
		button.backdrop.border:SetBackdrop(Private.BorderLight)
		button.IsBorder = true
	end

	if C_Heirloom_PlayerHasHeirloom(button.itemID) then
		button.backdrop.border:SetBackdropBorderColor(QUALITY_7_R, QUALITY_7_G, QUALITY_7_B)
	else
		local r, g, b = 132/255, 132/255, 132/255
		button.backdrop.border:SetBackdropBorderColor(r, g, b)
	end
end

local function SkinMountFrame()
	BORDER:CreateBorder(_G.MountJournalSummonRandomFavoriteButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.MountJournal.FilterDropdown, nil, nil, nil, nil, nil, false, true)

	--local Flyout = _G.MountJournal.DynamicFlightFlyout            
	--HandleDynamicFlightButton(Flyout.DynamicFlightModeButton, 4)
	--HandleDynamicFlightButton(Flyout.OpenDynamicFlightSkillTreeButton, 4)
	HandleDynamicFlightButton(_G.MountJournal.ToggleDynamicFlightFlyoutButton, 1)

	local MountJournal = _G.MountJournal
	BORDER:HandleIcon(MountJournal.MountDisplay.InfoButton.Icon)
	BORDER:CreateBorder(MountJournal.MountDisplay.ModelScene.TogglePlayer, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(_G.MountJournalMountButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.MountJournalSearchBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(_G.MountJournal.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:HandleModelSceneControlButtons(_G.MountJournal.MountDisplay.ModelScene.ControlFrame)

	MountJournal.BottomLeftInset:SetBackdrop() 
	BORDER:HandleIcon(MountJournal.BottomLeftInset.SlotButton.ItemIcon)
	BORDER:CreateBorder(MountJournal.BottomLeftInset.SlotButton)
	hooksecurefunc(MountJournal.ScrollBox, 'Update', JournalScrollButtons)
end

local function SkinPetFrame()
	BORDER:CreateBorder(_G.PetJournalSummonButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.PetJournalFindBattle, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.PetJournalSummonRandomFavoritePetButton, nil, nil, nil, nil, nil, false, true)

	local PetJournal = _G.PetJournal
	BORDER:CreateBorder(_G.PetJournalSearchBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(_G.PetJournal.FilterDropdown, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.PetJournal.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(_G.PetJournalHealPetButton, nil, nil, nil, nil, nil, true, true)

	for i = 1, 3 do
		local petButton = _G['PetJournalLoadoutPet'..i]
		local petButtonHealthFrame = _G['PetJournalLoadoutPet'..i..'HealthFramehealthStatusBar']
		local petButtonXPBar = _G['PetJournalLoadoutPet'..i..'XPBar']
		BORDER:CreateBorder(petButton, 0, nil, nil, nil, nil, true, false)
		BORDER:CreateBorder(petButtonHealthFrame, 1, nil, nil, nil, nil, true, false)
		BORDER:CreateBorder(petButtonXPBar)
		for index = 1, 3 do
			local f = _G['PetJournalLoadoutPet'..i..'Spell'..index]
			BORDER:CreateBorder(f)
		end
	
	end

	for i = 1, 2 do
		local btn = _G['PetJournalSpellSelectSpell'..i]
		BORDER:CreateBorder(btn)
	end

	BORDER:CreateBorder(_G.PetJournalPetCardPetInfo, 0, nil, nil, nil, nil, true, false)

	_G.PetJournalPetCard:SetBackdrop(nil)

	for i=1, 6 do
		local frame = _G['PetJournalPetCardSpell'..i]
		BORDER:CreateBorder(frame)
	end

	BORDER:CreateBorder(_G.PetJournalPetCardHealthFramehealthStatusBar, 1, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(_G.PetJournalPetCardXPBar, 1, nil, nil, nil, nil, true, false)

	hooksecurefunc(PetJournal.ScrollBox, 'Update', JournalScrollButtons)
end

local function SkinToyFrame()
	local ToyBox = _G.ToyBox
	BORDER:CreateBorder(ToyBox.searchBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(ToyBox.FilterDropdown, nil, nil, nil, nil, nil, false, true)
	ToyBox.FilterDropdown:Point('LEFT', ToyBox.searchBox, 'RIGHT', 6, 0)

	BORDER:CreateBorder(ToyBox.progressBar.backdrop)

	for i = 1, 18 do
		local button = ToyBox.iconsFrame['spellButton'..i]
		BORDER:CreateBorder(button.backdrop)
		button.backdrop.border:SetBackdrop(Private.BorderLight)
		button.backdrop.border:SetBackdropBorderColor(button.backdrop:GetBackdropBorderColor())
	end
	hooksecurefunc('ToySpellButton_UpdateButton', ToySpellButtonUpdateButton)
end

local function SkinHeirloomFrame()
	local HeirloomsJournal = _G.HeirloomsJournal
	BORDER:CreateBorder(HeirloomsJournal.SearchBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(HeirloomsJournal.ClassDropdown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(HeirloomsJournal.FilterDropdown, nil, nil, nil, nil, nil, false, true)
	HeirloomsJournal.FilterDropdown:Point('LEFT', HeirloomsJournal.SearchBox, 'RIGHT', 6, 0)

	BORDER:CreateBorder(HeirloomsJournal.progressBar.backdrop)
	hooksecurefunc(HeirloomsJournal, 'UpdateButton', HeirloomsJournalUpdateButton)
end

local function HandleTabs()
	local tab = _G.CollectionsJournalTab1
	local index, lastTab = 1, tab
	while tab do
		BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)

		tab:ClearAllPoints()

		if index == 1 then
			tab:Point('TOPLEFT', _G.CollectionsJournal, 'BOTTOMLEFT', -3, -5)
		else
			tab:Point('TOPLEFT', lastTab, 'TOPRIGHT', 0, 0)
			lastTab = tab
		end

		index = index + 1
		tab = _G['CollectionsJournalTab'..index]
	end
end

local function SetsFrame_ScrollBoxUpdate(button)
	for _, child in next, { button.ScrollTarget:GetChildren() } do
		if not child.IsBorder then
			BORDER:CreateBorder(child, nil, -5, 6, 7, -6, false, true)
			BORDER:HandleIcon(child.IconFrame.Icon, true)

			child.IsBorder = true
		end
	end
end

local function SetsFrame_SetItemFrameQuality(_, itemFrame)
	local icon = itemFrame.Icon
	BORDER:CreateBorder(icon.backdrop)

	if itemFrame.collected then
		local quality = C_TransmogCollection_GetSourceInfo(itemFrame.sourceID).quality
		local color = BAG_ITEM_QUALITY_COLORS[quality or 1]
		icon.backdrop.border:SetBackdrop(Private.BorderLight)
		icon.backdrop.border:SetBackdropBorderColor(color.r, color.g, color.b)
	else
		icon.backdrop.border:SetBackdrop(Private.Border)
		icon.backdrop.border:SetBackdropBorderColor(1, 1, 1)
	end
end

local function SkinTransmogFrames()
	local WardrobeCollectionFrame = _G.WardrobeCollectionFrame
	BORDER:CreateBorder(WardrobeCollectionFrame.ItemsTab, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(WardrobeCollectionFrame.SetsTab, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(WardrobeCollectionFrame.progressBar.backdrop)
			
	BORDER:CreateBorder(_G.WardrobeCollectionFrameSearchBox)
	BORDER:CreateBorder(_G.WardrobeCollectionFrame.ClassDropdown, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(WardrobeCollectionFrame.FilterButton, nil, nil, nil, nil, nil, false, true)
	WardrobeCollectionFrame.FilterButton:Point('LEFT', WardrobeCollectionFrame.searchBox, 'RIGHT', 5, 0)

	BORDER:CreateBorder(WardrobeCollectionFrame.FilterButton.ResetButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.WardrobeCollectionFrame.ItemsCollectionFrame.WeaponDropdown, nil, nil, nil, nil, nil, true, true)

	for _, Frame in ipairs(WardrobeCollectionFrame.ContentFrames) do
		if Frame.Models then
			for _, Model in pairs(Frame.Models) do
				BORDER:CreateBorder(Model)
				Model.Favorite:SetFrameLevel(6)
				if Model.HideVisual then	
					Model.HideVisual:SetFrameLevel(6)
				end

				hooksecurefunc(Model.Border, 'SetAtlas', function(_, texture)
					if texture == 'transmog-wardrobe-border-uncollected' then
						Model.border:SetBackdrop(Private.BorderLight)
						Model.border:SetBackdropBorderColor(0.9, 0.9, 0.3)
					elseif texture == 'transmog-wardrobe-border-unusable' then
						Model.border:SetBackdropBorderColor(0.9, 0.3, 0.3)
					elseif Model.TransmogStateTexture:IsShown() then
						Model.border:SetBackdrop(Private.BorderLight)
						Model.border:SetBackdropBorderColor(1, 0.7, 1)
					else
						Model.border:SetBackdrop(Private.Border)
						Model.border:SetBackdropBorderColor(1, 1, 1)
					end
				end)
			end
		end

		local pending = Frame.PendingTransmogFrame
		if pending then
			local Glowframe = pending.Glowframe

			if Glowframe.backdrop then
				BORDER:CreateBorder(pending, nil, -8, 8, 8, -9)
				pending.border:SetBackdrop(Private.BorderLight)
				pending.border:SetBackdropBorderColor(1, 0.7, 1)
			end

		end
	end

	local SetsTransmogFrame = WardrobeCollectionFrame.SetsTransmogFrame
	SetsTransmogFrame:SetBackdrop(nil)

	local SetsCollectionFrame = WardrobeCollectionFrame.SetsCollectionFrame
	SetsCollectionFrame:SetBackdrop(nil)
	BORDER:CreateBorder(SetsCollectionFrame.ListContainer.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	hooksecurefunc(SetsCollectionFrame.ListContainer.ScrollBox, 'Update', SetsFrame_ScrollBoxUpdate)

	local DetailsFrame = SetsCollectionFrame.DetailsFrame
	BORDER:CreateBorder(DetailsFrame.VariantSetsDropdown, nil, nil, nil, nil, nil, true, true)
	hooksecurefunc(SetsCollectionFrame, 'SetItemFrameQuality', SetsFrame_SetItemFrameQuality)

	local WardrobeFrame = _G.WardrobeFrame
	BORDER:CreateBorder(WardrobeFrame)

	local WardrobeTransmogFrame = _G.WardrobeTransmogFrame
	S:HandleDropDownBox(WardrobeTransmogFrame.OutfitDropdown, 200)

	BORDER:CreateBorder(WardrobeTransmogFrame.OutfitDropdown.SaveButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(WardrobeTransmogFrame.OutfitDropdown, nil, nil, nil, nil, nil, true, true)
	WardrobeTransmogFrame.OutfitDropdown.SaveButton:ClearAllPoints()
	WardrobeTransmogFrame.OutfitDropdown.SaveButton:Point('LEFT', WardrobeTransmogFrame.OutfitDropdown, 'RIGHT', 5, 0)

	for i = 1, #WardrobeTransmogFrame.SlotButtons do
		local slotButton = WardrobeTransmogFrame.SlotButtons[i]
		BORDER:CreateBorder(slotButton, 1, nil, nil, nil, nil, true)
	end

	BORDER:CreateBorder(WardrobeTransmogFrame.SpecDropdown, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(WardrobeTransmogFrame.ApplyButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(WardrobeTransmogFrame.ModelScene.ClearAllPendingButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(WardrobeTransmogFrame.ToggleSecondaryAppearanceCheckbox, nil, nil, nil, nil, nil, true, true)
	BORDER:HandleModelSceneControlButtons(WardrobeTransmogFrame.ModelScene.ControlFrame)
	WardrobeTransmogFrame.SpecDropdown:ClearAllPoints()
	WardrobeTransmogFrame.SpecDropdown:Point('RIGHT', WardrobeTransmogFrame.ApplyButton, 'LEFT', -4, 0)

	WardrobeCollectionFrame.ItemsCollectionFrame:SetBackdrop(nil)


	local WardrobeOutfitEditFrame = _G.WardrobeOutfitEditFrame
	BORDER:CreateBorder(WardrobeOutfitEditFrame)

	BORDER:CreateBorder(WardrobeOutfitEditFrame.EditBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(WardrobeOutfitEditFrame.AcceptButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(WardrobeOutfitEditFrame.CancelButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(WardrobeOutfitEditFrame.DeleteButton, nil, nil, nil, nil, nil, false, true)
end

local function SkinCollectionsFrames()
	BORDER:CreateBorder(_G.CollectionsJournal)

	HandleTabs()

	SkinMountFrame()
	SkinPetFrame()
	SkinToyFrame()
	SkinHeirloomFrame()
end

function S:Blizzard_Collections()
	if not E.private.skins.blizzard.enable then return end
	if E.db.ProjectHopes.skins.collections then SkinCollectionsFrames() end
	if E.db.ProjectHopes.skins.transmogrify then SkinTransmogFrames() end
end

S:AddCallbackForAddon('Blizzard_Collections')
