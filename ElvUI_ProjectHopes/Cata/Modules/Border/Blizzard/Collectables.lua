local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local strfind = strfind
local next, unpack = next, unpack
local ipairs, pairs = ipairs, pairs

local CreateFrame = CreateFrame
local PlayerHasToy = PlayerHasToy
local hooksecurefunc = hooksecurefunc
local GetItemQualityColor = GetItemQualityColor
local GetItemQualityByID = C_Item.GetItemQualityByID
local C_Heirloom_PlayerHasHeirloom = C_Heirloom.PlayerHasHeirloom

local QUALITY_7_R, QUALITY_7_G, QUALITY_7_B = GetItemQualityColor(7)

local function petNameColor(iconBorder, r, g, b)
	local parent = iconBorder:GetParent()
	if not parent.name then return end

	if parent.isDead and parent.isDead:IsShown() then
		parent.name:SetTextColor(0.9, 0.3, 0.3)
	elseif r and parent.owned then
		parent.name:SetTextColor(r, g, b)
	else
		parent.name:SetTextColor(0.4, 0.4, 0.4)
	end
end

local function mountNameColor(object)
	local button = object:GetParent()
	local name = button.name

	if name:GetFontObject() == _G.GameFontDisable then
		name:SetTextColor(0.4, 0.4, 0.4)
	else
		if button.background then
			local _, g, b = button.background:GetVertexColor()
			if g == 0 and b == 0 then
				name:SetTextColor(0.9, 0.3, 0.3)
				return
			end
		end

		name:SetTextColor(0.9, 0.9, 0.9)
	end
end

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

local function HeirloomsJournalLayoutCurrentPage()
	local headers = _G.HeirloomsJournal.heirloomHeaderFrames
	if headers and next(headers) then
		for _, header in next, headers do
			header:StripTextures()
			header.text:FontTemplate(nil, 15, 'SHADOW')
			header.text:SetTextColor(0.9, 0.9, 0.9)
		end
	end
end

local function SkinMountFrame()
	BORDER:CreateBorder(_G.MountJournal.FilterDropdown, nil, nil, nil, nil, nil, false, true)

	local MountJournal = _G.MountJournal
	BORDER:HandleIcon(MountJournal.MountDisplay.InfoButton.Icon)

	BORDER:CreateBorder(_G.MountJournalMountButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.MountJournalSearchBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(_G.MountJournal.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	hooksecurefunc(MountJournal.ScrollBox, 'Update', JournalScrollButtons)
end

local function SkinPetFrame()
	BORDER:CreateBorder(_G.PetJournalSummonButton, nil, nil, nil, nil, nil, false, true)

	_G.PetJournalPetCard.PetBackground:Kill()
	_G.PetJournalPetCard.ShadowOverlay:Kill()

	local PetJournal = _G.PetJournal
	BORDER:CreateBorder(_G.PetJournalSearchBox, nil, nil, nil, nil, nil, false, false)
	BORDER:CreateBorder(_G.PetJournal.FilterDropdown, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(_G.PetJournal.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	hooksecurefunc(PetJournal.ScrollBox, 'Update', JournalScrollButtons)
	BORDER:CreateBorder(_G.PetJournalPetCardPetInfo.backdrop)
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

local function SkinTransmogFrames()
	local WardrobeCollectionFrame = _G.WardrobeCollectionFrame
	BORDER:CreateBorder(WardrobeCollectionFrame.ItemsTab, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(WardrobeCollectionFrame.SetsTab, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(WardrobeCollectionFrame.progressBar.backdrop)

	BORDER:CreateBorder(_G.WardrobeCollectionFrameSearchBox)

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

	BORDER:CreateBorder(WardrobeTransmogFrame.ApplyButton, nil, nil, nil, nil, nil, false, true)

	WardrobeCollectionFrame.ItemsCollectionFrame:SetBackdrop(nil)
end

local function HandleTabs()
	local tab = _G.CollectionsJournalTab1
	local index, lastTab = 1, tab
	while tab do
		BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)

		tab:ClearAllPoints()

		if index == 1 then
			tab:Point('TOPLEFT', _G.CollectionsJournal, 'BOTTOMLEFT', -10, -5)
		else
			tab:Point('TOPLEFT', lastTab, 'TOPRIGHT', -14, 0)
			lastTab = tab
		end

		index = index + 1
		tab = _G['CollectionsJournalTab'..index]
	end
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
