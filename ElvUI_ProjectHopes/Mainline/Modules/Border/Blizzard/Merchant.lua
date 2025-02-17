local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local unpack = unpack
local hooksecurefunc = hooksecurefunc
local BLIZZARD_MERCHANT_ITEMS_PER_PAGE = 10

function S:HandleMerchantItem(index)
	for currencyIndex = 1, 3 do
		local itemLine = _G["MerchantItem" .. index .. "AltCurrencyFrameItem" .. currencyIndex]
		for _, region in pairs({ itemLine:GetRegions() }) do
			if region:GetObjectType() == "Texture" then
				region:SetTexCoord(unpack(E.TexCoords))
			end
		end
	end
end

function S:SkinButton(i)
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.merchant) then
		return
	end

	local item = _G["MerchantItem" .. i]
	local button = _G["MerchantItem" .. i .. "ItemButton"]
	local icon = _G["MerchantItem" .. i .. "ItemButtonIconTexture"]
	local money = _G["MerchantItem" .. i .. "MoneyFrame"]
	local nameFrame = _G["MerchantItem" .. i .. "NameFrame"]
	local name = _G["MerchantItem" .. i .. "Name"]
	local slot = _G["MerchantItem" .. i .. "SlotTexture"]

	item:StripTextures(true)
	item:CreateBackdrop("Transparent")
	item:Size(155, 45)
	--item.backdrop:Point("TOPLEFT", -1, 3)
	--item.backdrop:Point("BOTTOMRIGHT", 2, -3)

	button:StripTextures()
	button:StyleButton()
	button:SetTemplate(nil, true)
	button:Size(40)
	button:Point("TOPLEFT", item, "TOPLEFT", 4, -2)

	icon:SetTexCoord(unpack(E.TexCoords))
	icon:SetInside()

	nameFrame:Point("LEFT", slot, "RIGHT", -6, -17)

	name:Point("LEFT", slot, "RIGHT", -4, 5)

	money:ClearAllPoints()
	money:Point("BOTTOMLEFT", button, "BOTTOMRIGHT", 3, 0)

	--S:HandleMerchantItem(i)
	S:HandleIconBorder(button.IconBorder)
end

function S:UpdateMerchantPositions()
	for i = 1, _G.MERCHANT_ITEMS_PER_PAGE do
		local button = _G["MerchantItem" .. i]
		button:Show()
		button:ClearAllPoints()

		if (i % BLIZZARD_MERCHANT_ITEMS_PER_PAGE) == 1 then
			if i == 1 then
				button:SetPoint("TOPLEFT", _G.MerchantFrame, "TOPLEFT", 24, -70)
			else
				button:SetPoint(
					"TOPLEFT",
					_G["MerchantItem" .. (i - (BLIZZARD_MERCHANT_ITEMS_PER_PAGE - 1))],
					"TOPRIGHT",
					12,
					0
				)
			end
		else
			if (i % 2) == 1 then
				button:SetPoint("TOPLEFT", _G["MerchantItem" .. (i - 2)], "BOTTOMLEFT", 0, -16)
			else
				button:SetPoint("TOPLEFT", _G["MerchantItem" .. (i - 1)], "TOPRIGHT", 12, 0)
			end
		end
	end
end

function S:UpdateBuybackPositions()
	for i = 1, _G.MERCHANT_ITEMS_PER_PAGE do
		local button = _G["MerchantItem" .. i]
		button:ClearAllPoints()

		local contentWidth = 3 * _G["MerchantItem1"]:GetWidth() + 2 * 50
		local firstButtonOffsetX = (_G.MerchantFrame:GetWidth() - contentWidth) / 2

		if i > _G.BUYBACK_ITEMS_PER_PAGE then
			button:Hide()
		else
			if i == 1 then
				button:SetPoint("TOPLEFT", _G.MerchantFrame, "TOPLEFT", firstButtonOffsetX, -105)
			else
				if (i % 3) == 1 then
					button:SetPoint("TOPLEFT", _G["MerchantItem" .. (i - 3)], "BOTTOMLEFT", 0, -30)
				else
					button:SetPoint("TOPLEFT", _G["MerchantItem" .. (i - 1)], "TOPRIGHT", 50, 0)
				end
			end
		end
	end
end

local function HandleIconButton(button)
	BORDER:CreateBorder(button, nil, nil, nil, nil, nil, false, true)

	BORDER:HandleIcon(button.Icon, true)
end

function S:MerchantFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.merchant) then return end
	if not E.db.ProjectHopes.skins.merchant then return end

	_G.MERCHANT_ITEMS_PER_PAGE = 2 * 10
	_G.MerchantFrame:SetWidth(30 + 2 * 330)

	for i = 1, _G.MERCHANT_ITEMS_PER_PAGE do
		if not _G["MerchantItem" .. i] then
			CreateFrame("Frame", "MerchantItem" .. i, _G.MerchantFrame, "MerchantItemTemplate")
			S:SkinButton(i)
		end
	end

	_G.MerchantBuyBackItem:ClearAllPoints()
	_G.MerchantBuyBackItem:SetPoint("TOPLEFT", _G.MerchantItem10, "BOTTOMLEFT", 0, -20)
	_G.MerchantPrevPageButton:ClearAllPoints()
	_G.MerchantPrevPageButton:SetPoint("CENTER", _G.MerchantFrame, "BOTTOM", 30, 55)
	_G.MerchantPageText:ClearAllPoints()
	_G.MerchantPageText:SetPoint("BOTTOM", _G.MerchantFrame, "BOTTOM", 160, 50)
	_G.MerchantNextPageButton:ClearAllPoints()
	_G.MerchantNextPageButton:SetPoint("CENTER", _G.MerchantFrame, "BOTTOM", 290, 55)

	S:SecureHook("MerchantFrame_UpdateMerchantInfo", "UpdateMerchantPositions")
	S:SecureHook("MerchantFrame_UpdateBuybackInfo", "UpdateBuybackPositions")

	BORDER:CreateBorder(_G.MerchantFrame)

	BORDER:CreateBorder(_G.MerchantFrame.FilterDropdown, nil, nil, nil, nil, nil, true, true)

	-- Skin tabs
	for i = 1, 2 do
		BORDER:CreateBorder(_G['MerchantFrameTab'..i], nil, nil, nil, nil, nil, true, true)
	end

	-- Reposition tabs
	_G.MerchantFrameTab1:ClearAllPoints()
	_G.MerchantFrameTab2:ClearAllPoints()
	_G.MerchantFrameTab1:Point('TOPLEFT', _G.MerchantFrame, 'BOTTOMLEFT', -3, -5)
	_G.MerchantFrameTab2:Point('TOPLEFT', _G.MerchantFrameTab1, 'TOPRIGHT', 0, 0)

	-- Skin icons / merchant slots
	for i = 1, 20 do
		local item = _G['MerchantItem'..i]
		--BORDER:CreateBorder(item)
		item.backdrop:Hide()

		local slot = _G['MerchantItem'..i..'SlotTexture']
		item.Name:Point('LEFT', slot, 'RIGHT', -5, 5)
		item.Name:Size(110, 30)

		local button = _G['MerchantItem'..i..'ItemButton']
		BORDER:CreateBorder(button)
		button.border:SetBackdrop(Private.BorderLight)

		BORDER:HandleIconBorder(button.IconBorder, button.border)
	end

	-- Skin buyback item frame + icon
	BORDER:CreateBorder(_G.MerchantBuyBackItemItemButton)
	_G.MerchantBuyBackItem.backdrop:Hide()

	BORDER:HandleIconBorder(_G.MerchantBuyBackItemItemButton.IconBorder, _G.MerchantBuyBackItemItemButton.border)

	HandleIconButton(_G.MerchantRepairItemButton)
	HandleIconButton(_G.MerchantRepairAllButton)
	HandleIconButton(_G.MerchantGuildBankRepairButton)

	if _G.MerchantSellAllJunkButton then
		HandleIconButton(_G.MerchantSellAllJunkButton)
	end
end

S:AddCallback('MerchantFrame')
