local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local M = E:GetModule('Misc')

local _G = _G
local unpack, next = unpack, next
local hooksecurefunc = hooksecurefunc
local format = string.format
local gmatch = string.gmatch
local char = string.char
local floor = math.floor
local error = error
local tostring = tostring
local gsub = string.gsub
local strmatch = strmatch
local strtrim = strtrim
local type = type
local utf8len = string.utf8len
local utf8lower = string.utf8lower
local utf8sub = string.utf8sub
local utf8upper = string.utf8upper
local ENUM_ITEM_CLASS_WEAPON = _G.Enum.ItemClass.Weapon

local GetItemInfo = C_Item.GetItemInfo

local GetInventoryItemID = GetInventoryItemID
local GetSpecialization = E.Retail and GetSpecialization or GetActiveTalentGroup
local GetSpecializationInfo = GetSpecializationInfo

local FLYOUT_LOCATIONS = {
	[0xFFFFFFFF] = 'PLACEINBAGS',
	[0xFFFFFFFE] = 'IGNORESLOT',
	[0xFFFFFFFD] = 'UNIGNORESLOT'
}

local characterSlots = {
	["HeadSlot"] = {
		id = 1,
		needsEnchant = E.Cata, -- Reputation Arcanum's
		needsSocket = false,
		direction = "LEFT",
	},
	["NeckSlot"] = {
		id = 2,
		needsEnchant = false,
		needsSocket = E.Retail,
		direction = "LEFT",
	},
	["ShoulderSlot"] = {
		id = 3,
		needsEnchant = false,
		needsSocket = false,
		direction = "LEFT",
	},
	["BackSlot"] = {
		id = 15,
		needsEnchant = true,
		needsSocket = false,
		direction = "LEFT",
	},
	["ChestSlot"] = {
		id = 5,
		needsEnchant = true,
		needsSocket = false,
		direction = "LEFT",
	},
	["ShirtSlot"] = {
		id = 4,
		needsEnchant = false,
		needsSocket = false,
		direction = "LEFT",
	},
	["TabardSlot"] = {
		id = 18,
		needsEnchant = false,
		needsSocket = false,
		direction = "LEFT",
	},
	["WristSlot"] = {
		id = 9,
		needsEnchant = true,
		needsSocket = false,
		direction = "LEFT",
	},
	["HandsSlot"] = {
		id = 10,
		needsEnchant = false,
		needsSocket = false,
		direction = "RIGHT",
	},
	["WaistSlot"] = {
		id = 6,
		needsEnchant = false,
		needsSocket = false,
		direction = "RIGHT",
	},
	["LegsSlot"] = {
		id = 7,
		needsEnchant = true,
		needsSocket = false,
		direction = "RIGHT",
	},
	["FeetSlot"] = {
		id = 8,
		needsEnchant = true,
		needsSocket = false,
		direction = "RIGHT",
	},
	["Finger0Slot"] = {
		id = 11,
		needsEnchant = true,
		needsSocket = E.Retail,
		direction = "RIGHT",
	},
	["Finger1Slot"] = {
		id = 12,
		needsEnchant = true,
		needsSocket = E.Retail,
		direction = "RIGHT",
	},
	["Trinket0Slot"] = {
		id = 13,
		needsEnchant = false,
		needsSocket = false,
		direction = "RIGHT",
	},
	["Trinket1Slot"] = {
		id = 14,
		needsEnchant = false,
		needsSocket = false,
		direction = "RIGHT",
	},
	["MainHandSlot"] = {
		id = 16,
		needsEnchant = true,
		needsSocket = false,
		direction = "LEFT",
	},
	["SecondaryHandSlot"] = {
		id = 17,
		needsEnchant = true,
		warningCondition = {
		  itemType = ENUM_ITEM_CLASS_WEAPON,
		},
		needsSocket = false,
		direction = "RIGHT",
	},
}

local inspectSlots = {
	["HeadSlot"] = {
		id = 1,
		needsEnchant = E.Cata, -- Reputation Arcanum's
		needsSocket = false,
		direction = "LEFT",
	},
	["NeckSlot"] = {
		id = 2,
		needsEnchant = false,
		needsSocket = E.Retail,
		direction = "LEFT",
	},
	["ShoulderSlot"] = {
		id = 3,
		needsEnchant = false,
		needsSocket = false,
		direction = "LEFT",
	},
	["BackSlot"] = {
		id = 15,
		needsEnchant = true,
		needsSocket = false,
		direction = "LEFT",
	},
	["ChestSlot"] = {
		id = 5,
		needsEnchant = true,
		needsSocket = false,
		direction = "LEFT",
	},
	["ShirtSlot"] = {
		id = 4,
		needsEnchant = false,
		needsSocket = false,
		direction = "LEFT",
	},
	["TabardSlot"] = {
		id = 18,
		needsEnchant = false,
		needsSocket = false,
		direction = "LEFT",
	},
	["WristSlot"] = {
		id = 9,
		needsEnchant = true,
		needsSocket = false,
		direction = "LEFT",
	},
	["HandsSlot"] = {
		id = 10,
		needsEnchant = false,
		needsSocket = false,
		direction = "RIGHT",
	},
	["WaistSlot"] = {
		id = 6,
		needsEnchant = false,
		needsSocket = false,
		direction = "RIGHT",
	},
	["LegsSlot"] = {
		id = 7,
		needsEnchant = true,
		needsSocket = false,
		direction = "RIGHT",
	},
	["FeetSlot"] = {
		id = 8,
		needsEnchant = true,
		needsSocket = false,
		direction = "RIGHT",
	},
	["Finger0Slot"] = {
		id = 11,
		needsEnchant = true,
		needsSocket = E.Retail,
		direction = "RIGHT",
	},
	["Finger1Slot"] = {
		id = 12,
		needsEnchant = true,
		needsSocket = E.Retail,
		direction = "RIGHT",
	},
	["Trinket0Slot"] = {
		id = 13,
		needsEnchant = false,
		needsSocket = false,
		direction = "RIGHT",
	},
	["Trinket1Slot"] = {
		id = 14,
		needsEnchant = false,
		needsSocket = false,
		direction = "RIGHT",
	},
	["MainHandSlot"] = {
		id = 16,
		needsEnchant = true,
		needsSocket = false,
		direction = "LEFT",
	},
	["SecondaryHandSlot"] = {
		id = 17,
		needsEnchant = true,
		warningCondition = {
		  itemType = ENUM_ITEM_CLASS_WEAPON,
		},
		needsSocket = false,
		direction = "RIGHT",
	},
}

local function EquipmentManagerPane_Update(frame)
	for _, child in next, { frame.ScrollTarget:GetChildren() } do
		if child.icon then
			BORDER:CreateBorder(child.icon, nil, -7, 7, 7, -7, nil, true)
		end
		BORDER:CreateBorder(child.PaperDollFrameIcon, nil, nil, nil, nil, nil, nil, false)
	end
end

local function UpdateFactionSkins(frame)
	for _, child in next, { frame.ScrollTarget:GetChildren() } do
		if not child.IsBorder then
			if child.Right then
				child.backdrop:Hide()
				BORDER:CreateBorder(child, nil, nil, nil, nil, nil, false, true)
			end

			local ReputationBar = child.Content and child.Content.ReputationBar
			if ReputationBar then        
				if ReputationBar.backdrop then
					BORDER:CreateBorder(ReputationBar.backdrop)
				end
			end

			child.IsBorder = true
		end
	end
end

local function UpdateTokenSkins(frame)
	for _, child in next, { frame.ScrollTarget:GetChildren() } do
		if not child.IsBorder then
			if child.Right then
				BORDER:CreateBorder(child, nil, -7, 7, 7, -7, false, true)
			end

			child.IsBorder = true
		end
	end
end

local function EquipmentDisplayButton(button)
	if not button.IsBorder then   
		_G.EquipmentFlyoutFrameButtons:SetBackdropBorderColor(1, 1, 1, 0)
		_G.EquipmentFlyoutFrameButtons:SetBackdrop()           
		BORDER:CreateBorder(button)
		button.border:SetBackdrop(Private.BorderLight)
		S:HandleIconBorder(button.IconBorder, button.border)

		button.IsBorder = true
	end

	if FLYOUT_LOCATIONS[button.location] then -- special slots
		button.border:SetBackdrop(Private.BorderLight)
		button.border:SetBackdropBorderColor(unpack(E.media.rgbvaluecolor))
	end
end

local function EquipmentUpdateItems()
	local frame = _G.EquipmentFlyoutFrame.buttonFrame              
	for _, button in next, _G.EquipmentFlyoutFrame.buttons do
		EquipmentDisplayButton(button)
	end
end
  
local function StringAbbreviate(text)
    if type(text) ~= "string" or text == "" then return text end
	if strmatch(text, "^Rune") then
		text = text:gsub(".* the ", ""):gsub(".* of ", "")
	else
		text = text:match("^(.-)%s*of.*$") or text -- Remove "of" and everything after
	end
  
    local letters = ""
    local lastWord = strmatch(text, "(%S+)$") or text
    if not lastWord then return text end

    for word in gmatch(text, ".-%s") do
      	local firstLetter = word:gsub("^[%s%p]*", "")
  
      	if not strmatch(firstLetter, "%d+") then
        	firstLetter = utf8sub(firstLetter, 1, 1)
        	if firstLetter ~= utf8lower(firstLetter) then
          		letters = format("%s%s. ", letters, firstLetter)
        	end
      	else
        	firstLetter = firstLetter:gsub("%D+", "")
        	letters = format("%s%s ", letters, firstLetter)
      	end
    end
  
    return format("%s%s", letters, lastWord)
end

local function EnchantAbbreviate(str)
    if type(str) ~= "string" or str == "" then return str end

    local abbrevs = {
        [_G["SPELL_STAT" .. _G.LE_UNIT_STAT_STRENGTH .. "_NAME"]] = "Str.",
        [_G["SPELL_STAT" .. _G.LE_UNIT_STAT_AGILITY .. "_NAME"]] = "Agi.",
        [_G["SPELL_STAT" .. _G.LE_UNIT_STAT_INTELLECT .. "_NAME"]] = "Int.",
        [_G["SPELL_STAT" .. _G.LE_UNIT_STAT_STAMINA .. "_NAME"]] = "Stam.",
        [_G["STAT_VERSATILITY"]] = "V.",
        [_G["STAT_CRITICAL_STRIKE"]] = "C.",
        [_G["STAT_AVOIDANCE"]] = "A.",
        [_G["STAT_HASTE"]] = "H.",
		[_G["STAT_LIFESTEAL"]] = "L.",

    }

    local short = StringAbbreviate(str)
    for stat, abbrev in pairs(abbrevs) do
        short = short:gsub(stat, abbrev)
    end

    return short
end

local function GetSlotNameByID(i)
	for slot, options in pairs(characterSlots) do
	  	if options.id == i then return slot end
	end
end

local function CheckMessageCondition(slotOptions)
	local conditions = slotOptions.warningCondition
	local enchantNeeded = true

	if enchantNeeded and conditions.level then
			enchantNeeded = (conditions.level == UnitLevel("player"))
	end

	if enchantNeeded and conditions.primary then
			enchantNeeded = false
			local spec = GetSpecialization()
			if spec then
					local primaryStat
					if E.Retail then
							primaryStat = select(6, GetSpecializationInfo(spec, nil, nil, nil, UnitSex("player")))
					end
					enchantNeeded = (conditions.primary == primaryStat)
			end
	end

	for slotID = 1, 16 do
			if enchantNeeded and conditions.itemType then
					local itemID = GetInventoryItemID("player", slotID)
					if not itemID then
							return false
					end
					local itemType = select(12, GetItemInfo(itemID))
					enchantNeeded = (itemType == conditions.itemType)
			end
	end

	return enchantNeeded
end



local function UpdatePageStrings(_, i, _, slot, slotInfo, which)
	if not slot.enchantText or not slot.iLvlText then return end
  
	local slotName = GetSlotNameByID(i)
	if not slotName then return end
  
	local slotOptions = characterSlots[slotName] or inspectSlots[slotName]
	if not slotOptions then return end

	if slotInfo.itemLevelColors and next(slotInfo.itemLevelColors) then
		local missingGemSlots = 2 - #slotInfo.gems

		if slotOptions.needsSocket and missingGemSlots > 0 then
			if not slotOptions.warningCondition or (CheckMessageCondition(slotOptions)) then
				if missingGemSlots > 0 then
					local text = format("Add %d sockets", missingGemSlots)
					slot.enchantText:SetText("|cFFef5350" .. text .. "|r")
				end
			else
				slot.enchantText:SetText("")
			end
		elseif slotInfo.enchantColors and next(slotInfo.enchantColors) then
				slot.enchantText:SetTextColor(unpack(E.media.rgbvaluecolor))

				local text = slotInfo.enchantTextShort
				text = EnchantAbbreviate(slotInfo.enchantText)
				slot.enchantText:SetText(text)
		elseif slotOptions.needsEnchant then
			if not slotOptions.warningCondition or (CheckMessageCondition(slotOptions)) then
				slot.enchantText:SetText("|cFFef5350" .. "Add enchant" .. "|r")
			else
				slot.enchantText:SetText("")
			end
		else
			slot.enchantText:SetText("")
		end
	else
		slot.enchantText:SetText("")
	end

	if slotOptions.direction == "LEFT" then

		slot.iLvlText:ClearAllPoints()
        slot.iLvlText:SetPoint("BOTTOMLEFT", slot, "BOTTOMLEFT", 0, 2)

		slot.textureSlot1:ClearAllPoints()
		slot.textureSlot1:SetPoint("BOTTOMLEFT", slot, "BOTTOMRIGHT", 5, 1)

		slot.textureSlot2:ClearAllPoints()
		slot.textureSlot2:SetPoint("LEFT", slot.textureSlot1, "RIGHT", 6, 0)

		if slotOptions.id == 16 then return end

		slot.enchantText:ClearAllPoints()
		slot.enchantText:SetPoint("TOPLEFT", slot, "TOPRIGHT", 3, -2)
    elseif slotOptions.direction == "RIGHT" then

		slot.iLvlText:ClearAllPoints()
        slot.iLvlText:SetPoint("BOTTOMRIGHT", slot, "BOTTOMRIGHT", 1, 2)

		slot.textureSlot1:ClearAllPoints()
		slot.textureSlot1:SetPoint("BOTTOMRIGHT", slot, "BOTTOMLEFT", -5, 1)

		slot.textureSlot2:ClearAllPoints()
		slot.textureSlot2:SetPoint("RIGHT", slot.textureSlot1, "LEFT", -6, 0)

		if E.Retail and slot.textureSlot3 then 
			slot.textureSlot3:ClearAllPoints()
			slot.textureSlot3:SetPoint("RIGHT", slot.textureSlot2, "LEFT", -6, 0)
		end
		
		if slotOptions.id == 17 then return end

		slot.enchantText:ClearAllPoints()
		slot.enchantText:SetPoint("TOPRIGHT", slot, "TOPLEFT", -3, -2)
    end

	BORDER:CreateBorder(slot.textureSlotBackdrop1)
	BORDER:CreateBorder(slot.textureSlotBackdrop2)
	if E.Retail and slot.textureSlot3 then 
		BORDER:CreateBorder(slot.textureSlotBackdrop3)
	end
end

function S:Blizzard_UIPanels_Game()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.character) then return end
	if not E.db.ProjectHopes.skins.character then return end

	local CharacterFrame = _G.CharacterFrame
	BORDER:CreateBorder(CharacterFrame)
	BORDER:CreateBorder(_G.GearManagerDialogPopup)

	S:SecureHook(M, "UpdatePageStrings", UpdatePageStrings)
	
	BORDER:CreateBorder(_G.ReputationFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.TokenFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(_G.CharacterStatsPane.ItemLevelCategory.backdrop)
	BORDER:CreateBorder(_G.CharacterStatsPane.AttributesCategory.backdrop)
	BORDER:CreateBorder(_G.CharacterStatsPane.EnhancementsCategory.backdrop)
	
	hooksecurefunc('EquipmentFlyout_UpdateItems', EquipmentUpdateItems) -- Swap item flyout frame (shown when holding alt over a slot)

	for i = 1, 3 do
		local SidebarTab = _G["PaperDollSidebarTab" .. i]
		if SidebarTab then
			BORDER:CreateBorder(SidebarTab, 1, nil, nil, nil, nil, false, true)
		end
	end

	for _, Slot in pairs({_G.PaperDollItemsFrame:GetChildren()}) do
		if Slot:IsObjectType('Button') or Slot:IsObjectType('ItemButton') then
			BORDER:CreateBorder(Slot)
			BORDER:HandleIconBorder(Slot.IconBorder, Slot.border)
			if Slot.backdrop then
				Slot.backdrop:Kill()
				Slot.IconBorder:Kill()
			end
		end
	end
	
	-- Remove the background
	local modelScene = _G.CharacterModelScene
	modelScene.BackgroundTopLeft:Hide()
	modelScene.BackgroundTopRight:Hide()
	modelScene.BackgroundBotLeft:Hide()
	modelScene.BackgroundBotRight:Hide()
	modelScene.BackgroundOverlay:Hide()
	if modelScene.backdrop then
		modelScene.backdrop:Kill()
	end
	CharacterStatsPane.ItemLevelFrame.rightGrad:Hide()
	CharacterStatsPane.ItemLevelFrame.leftGrad:Hide()

	for _, scrollbar in pairs({ _G.PaperDollFrame.EquipmentManagerPane.ScrollBar, _G.PaperDollFrame.TitleManagerPane.ScrollBar }) do
		BORDER:CreateBorder(scrollbar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	end

	BORDER:HandleModelSceneControlButtons(_G.CharacterModelScene.ControlFrame)

	--Equipement Manager
	hooksecurefunc(_G.PaperDollFrame.EquipmentManagerPane.ScrollBox, 'Update', EquipmentManagerPane_Update)
	BORDER:CreateBorder(_G.PaperDollFrameEquipSet, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.PaperDollFrameSaveSet, nil, nil, nil, nil, nil, false, true)

	_G.PaperDollFrameEquipSet:Size(80, 16)
	_G.PaperDollFrameEquipSet:ClearAllPoints()
	_G.PaperDollFrameEquipSet:SetPoint("TOPLEFT", _G.PaperDollFrame.EquipmentManagerPane, "TOPLEFT", 5, 0)

	_G.PaperDollFrameSaveSet:Size(80, 16)
	_G.PaperDollFrameSaveSet:ClearAllPoints()
	_G.PaperDollFrameSaveSet:SetPoint("LEFT", _G.PaperDollFrameEquipSet, "RIGHT", 5, 0)

	-- Icon selection frame
	local GearManagerPopupFrame = _G.GearManagerPopupFrame
	local BorderBox = GearManagerPopupFrame.BorderBox
	GearManagerPopupFrame:HookScript('OnShow', function(frame)
		for _, child in next, { frame.IconSelector.ScrollBox.ScrollTarget:GetChildren() } do
			local button = child.Icon
			if button then
				BORDER:CreateBorder(button, nil, nil, nil, nil, nil, nil, true)
			end
		end
		BORDER:CreateBorder(GearManagerPopupFrame)

		BORDER:CreateBorder(BorderBox.IconSelectorEditBox, nil, nil, nil, nil, nil, true, false)
		BORDER:CreateBorder(BorderBox.SelectedIconArea.SelectedIconButton, nil, nil, nil, nil, nil, true, true)
		BORDER:CreateBorder(_G.GearManagerPopupFrameButton, nil, nil, nil, nil, nil, false, true)
		BORDER:CreateBorder(BorderBox.OkayButton, nil, nil, nil, nil, nil, false, true)
		BORDER:CreateBorder(BorderBox.CancelButton, nil, nil, nil, nil, nil, false, true)
		BORDER:CreateBorder(GearManagerPopupFrame.IconSelector.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	end)

	--Handle Tabs at bottom of character frame
	do 
		local i = 1
		local tab, prev = _G['CharacterFrameTab'..i]
		while tab do
			BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)
			tab:ClearAllPoints()

			if prev then -- Reposition Tabs
				tab:Point('TOPLEFT', prev, 'TOPRIGHT', 0, 0)
			else
				tab:Point('TOPLEFT', _G.CharacterFrame, 'BOTTOMLEFT', -3, -5)
			end

			prev = tab

			i = i + 1
			tab = _G['CharacterFrameTab'..i]
		end
	end

	-- Reputation Frame
	local ReputationFrame = _G.ReputationFrame
	BORDER:CreateBorder(ReputationFrame.filterDropdown, nil, nil, nil, nil, nil, true, true)

	local DetailFrame = ReputationFrame.ReputationDetailFrame
	BORDER:CreateBorder(DetailFrame)

	BORDER:CreateBorder(DetailFrame.AtWarCheckbox, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(DetailFrame.MakeInactiveCheckbox, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(DetailFrame.WatchFactionCheckbox, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(DetailFrame.ViewRenownButton, nil, nil, nil, nil, nil, false, true)
	-- Currency Frame
	BORDER:CreateBorder(_G.TokenFramePopup)
	BORDER:CreateBorder(_G.TokenFrame.filterDropdown, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(_G.TokenFrame.CurrencyTransferLogToggleButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.CurrencyTransferLog)
	BORDER:CreateBorder(_G.TokenFramePopup.InactiveCheckbox, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.TokenFramePopup.BackpackCheckbox, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.TokenFramePopup.CurrencyTransferToggleButton, nil, nil, nil, nil, nil, false, true)

	local currencyTransfer = _G.CurrencyTransferMenu
	BORDER:CreateBorder(currencyTransfer)
	BORDER:CreateBorder(currencyTransfer.AmountSelector.InputBox)
	BORDER:CreateBorder(currencyTransfer.ConfirmButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(currencyTransfer.CancelButton, nil, nil, nil, nil, nil, false, true)

	hooksecurefunc(_G.ReputationFrame.ScrollBox, 'Update', UpdateFactionSkins)
	hooksecurefunc(_G.TokenFrame.ScrollBox, 'Update', UpdateTokenSkins)
end

S:AddCallbackForAddon('Blizzard_UIPanels_Game')
