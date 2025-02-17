local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next = next
local pairs = pairs
local unpack = unpack

local CreateFrame = CreateFrame
local GetAuctionSellItemInfo = GetAuctionSellItemInfo
local GetItemQualityColor = C_Item.GetItemQualityColor

function S:Blizzard_AuctionUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.auctionhouse) then return end
    if not E.db.ProjectHopes.skins.auctionHouse then return end

	local AuctionFrame = _G.AuctionFrame
	BORDER:CreateBorder(AuctionFrame, nil, nil, nil, nil, nil, true, false)

	local Buttons = {
		_G.BrowseSearchButton,
		_G.BrowseBidButton,
		_G.BrowseBuyoutButton,
		_G.BrowseCloseButton,
		_G.BrowseResetButton,
		_G.BidBidButton,
		_G.BidBuyoutButton,
		_G.BidCloseButton,
		_G.AuctionsCreateAuctionButton,
		_G.AuctionsCancelAuctionButton,
		_G.AuctionsStackSizeMaxButton,
		_G.AuctionsNumStacksMaxButton,
		_G.AuctionsCloseButton
	}

	local CheckBoxes = {
		_G.SortByBidPriceButton,
		_G.SortByBuyoutPriceButton,
		_G.SortByTotalPriceButton,
		_G.SortByUnitPriceButton,
		_G.IsUsableCheckButton,
		_G.ShowOnPlayerCheckButton
	}

	local EditBoxes = {
		_G.BrowseName,
		_G.BrowseMinLevel,
		_G.BrowseMaxLevel,
		_G.BrowseBidPriceGold,
		_G.BrowseBidPriceSilver,
		_G.BrowseBidPriceCopper,
		_G.BidBidPriceGold,
		_G.BidBidPriceSilver,
		_G.BidBidPriceCopper,
		_G.AuctionsStackSizeEntry,
		_G.AuctionsNumStacksEntry,
		_G.StartPriceGold,
		_G.StartPriceSilver,
		_G.StartPriceCopper,
		_G.BuyoutPriceGold,
		_G.BuyoutPriceCopper,
		_G.BuyoutPriceSilver
	}

	local SortTabs = {
		_G.BrowseQualitySort,
		_G.BrowseLevelSort,
		_G.BrowseDurationSort,
		_G.BrowseHighBidderSort,
		_G.BrowseCurrentBidSort,
		_G.BidQualitySort,
		_G.BidLevelSort,
		_G.BidDurationSort,
		_G.BidBuyoutSort,
		_G.BidStatusSort,
		_G.BidBidSort,
		_G.AuctionsQualitySort,
		_G.AuctionsDurationSort,
		_G.AuctionsHighBidderSort,
		_G.AuctionsBidSort,
	}

	for _, Button in pairs(Buttons) do
		BORDER:CreateBorder(Button, nil, nil, nil, nil, nil, false, true)
	end

	for i, CheckBox in pairs(CheckBoxes) do
		BORDER:CreateBorder(CheckBox, nil, nil, nil, nil, nil, true, true)
	end

	for _, EditBox in pairs(EditBoxes) do
		BORDER:CreateBorder(EditBox, nil, nil, nil, nil, nil, true, false)
	end

	for i = 1, AuctionFrame.numTabs do
		local tab = _G['AuctionFrameTab'..i]

		BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)
		 
	end

	-- Reposition Tabs
	_G.AuctionFrameTab2:Point('TOPLEFT', _G.AuctionFrameTab1, 'TOPRIGHT', -15, 0)
	_G.AuctionFrameTab3:Point('TOPLEFT', _G.AuctionFrameTab2, 'TOPRIGHT', -15, 0)

	BORDER:CreateBorder(_G.BrowsePriceOptionsFrame)

	for _, child in next, { _G.BrowsePriceOptionsFrame:GetChildren() } do
		if child:IsObjectType('Button') then
			BORDER:CreateBorder(child, nil, nil, nil, nil, nil, false, true)
		end
	end

	BORDER:CreateBorder(_G.BrowsePriceOptionsButtonFrame.Button, nil, nil, nil, nil, nil, false, true)

	-- Browse Frame
	_G.BrowseSearchButton:ClearAllPoints()
	_G.BrowseSearchButton:SetPoint('TOPRIGHT', AuctionFrame, 'TOPRIGHT', -50, -20)

	BORDER:CreateBorder(_G.BrowseFilterScrollFrameScrollBar.backdrop)
	BORDER:CreateBorder(_G.BrowseScrollFrameScrollBar.backdrop)

	-- Bid Frame
	BORDER:CreateBorder(_G.BidScrollFrameScrollBar.backdrop)

	-- Auctions Frame
	BORDER:CreateBorder(_G.AuctionsScrollFrameScrollBar.backdrop)
	BORDER:CreateBorder(_G.AuctionsItemButton)

	_G.AuctionsItemButton:HookScript('OnEvent', function(button, event)
		local normal = event == 'NEW_AUCTION_UPDATE' and button:GetNormalTexture()
		if normal then
			button.border:SetBackdrop(Private.BorderLight)
			local _, _, _, quality = GetAuctionSellItemInfo()
			if quality and quality > 1 then
				local r, g, b = GetItemQualityColor(quality)
				button.border:SetBackdropBorderColor(r, g, b)
			else
				button.border:SetBackdrop(Private.Border)
				button.border:SetBackdropBorderColor(1, 1, 1)
			end
		else
			button.border:SetBackdrop(Private.Border)
			button.border:SetBackdropBorderColor(1, 1, 1)
		end
	end)

	BORDER:CreateBorder(_G.BrowseDropdown, nil, nil, nil, nil, nil, true, true)

	-- Progress Frame
	local AuctionProgressFrameCancelButton = _G.AuctionProgressFrameCancelButton
	BORDER:CreateBorder(AuctionProgressFrameCancelButton, nil, nil, nil, nil, nil, false, true)

	for Frame, NumButtons in pairs({
		Browse = _G.NUM_BROWSE_TO_DISPLAY,
		Auctions = _G.NUM_AUCTIONS_TO_DISPLAY,
		Bid = _G.NUM_BIDS_TO_DISPLAY
	}) do
		for i = 1, NumButtons do
			local ItemButton = _G[Frame..'Button'..i..'Item']

			BORDER:CreateBorder(ItemButton)
		end
	end

	-- Custom Backdrops
	for _, Frame in pairs({_G.AuctionFrameBrowse, _G.AuctionFrameAuctions}) do
		Frame.LeftBackground:Kill()
		Frame.RightBackground:Kill()
	end

	local AuctionFrameBid = _G.AuctionFrameBid
	AuctionFrameBid.Background:Kill()
end

S:AddCallbackForAddon('Blizzard_AuctionUI')
