local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local unpack = unpack
local hooksecurefunc = hooksecurefunc

local CreateFrame = CreateFrame
local GetMerchantNumItems = GetMerchantNumItems
local GetBuybackItemInfo = GetBuybackItemInfo
local GetNumBuybackItems = GetNumBuybackItems

local GetItemQualityByID = C_Item.GetItemQualityByID
local GetItemQualityColor = C_Item.GetItemQualityColor

local MERCHANT_ITEMS_PER_PAGE = MERCHANT_ITEMS_PER_PAGE

function S:MerchantFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.merchant) then return end
	if not E.db.ProjectHopes.skins.merchant then return end

	local MerchantFrame = _G.MerchantFrame
	BORDER:CreateBorder(MerchantFrame.backdrop)

	-- skin icons / merchant slots
	for i = 1, _G.BUYBACK_ITEMS_PER_PAGE do
		local item = _G['MerchantItem'..i]
		BORDER:CreateBorder(item)
	end

	BORDER:CreateBorder(_G.MerchantRepairItemButton, nil, -7, 7, 7, -7, false, true)
	BORDER:CreateBorder(_G.MerchantRepairAllButton, nil, -7, 7, 7, -7, false, true)
	BORDER:CreateBorder(_G.MerchantBuyBackItem.backdrop)

	_G.MerchantRepairAllButton:ClearAllPoints()
	_G.MerchantRepairAllButton:Point('BOTTOMLEFT', _G.MerchantFrame, 'BOTTOMLEFT', 124, 57)
	
	-- skin tabs
	for i = 1, 2 do
		BORDER:CreateBorder(_G['MerchantFrameTab'..i], nil, nil, nil, nil, nil, true, true)
	end

	-- Reposition Tabs
	_G.MerchantFrameTab1:ClearAllPoints()
	_G.MerchantFrameTab1:Point('TOPLEFT', _G.MerchantFrame, 'BOTTOMLEFT', -15, -5)
	_G.MerchantFrameTab2:Point('TOPLEFT', _G.MerchantFrameTab1, 'TOPRIGHT', -14, 0)

	hooksecurefunc('MerchantFrame_UpdateMerchantInfo', function()
		local numMerchantItems = GetMerchantNumItems()
		local index = (MerchantFrame.page - 1) * MERCHANT_ITEMS_PER_PAGE

		for i = 1, _G.BUYBACK_ITEMS_PER_PAGE do
			index = index + 1

			if index <= numMerchantItems then
				local button = _G['MerchantItem'..i..'ItemButton']
				BORDER:CreateBorder(button)

				if button.link then
					local quality = GetItemQualityByID(button.link)
					if quality and quality > 1 then
						local r, g, b = GetItemQualityColor(quality)
						button.border:SetBackdrop(Private.BorderLight)
						button.border:SetBackdropBorderColor(r, g, b)
					end
				end
			end
			BORDER:CreateBorder(_G.MerchantBuyBackItemItemButton)

			local itemName = GetBuybackItemInfo(GetNumBuybackItems())
			if itemName then
				local quality = GetItemQualityByID(itemName)
				if quality and quality > 1 then
					local r, g, b = GetItemQualityColor(quality)
					_G.MerchantBuyBackItemItemButton.border:SetBackdropBorderColor(r, g, b)
				end
			end
		end
	end)

	hooksecurefunc('MerchantFrame_UpdateBuybackInfo', function()
		local numBuybackItems = GetNumBuybackItems()

		for i = 1, _G.BUYBACK_ITEMS_PER_PAGE do
			if i <= numBuybackItems then
				local itemName = GetBuybackItemInfo(i)

				if itemName then
					local button = _G['MerchantItem'..i..'ItemButton']
					local quality = GetItemQualityByID(itemName)
					BORDER:CreateBorder(button)

					if quality and quality > 1 then
						local r, g, b = GetItemQualityColor(quality)
						button.border:SetBackdrop(Private.BorderLight)
						button.border:SetBackdropBorderColor(r, g, b)
					end
				end
			end
		end
	end)
end

S:AddCallback('MerchantFrame')
