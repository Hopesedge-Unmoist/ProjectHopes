local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next, pairs, unpack = next, pairs, unpack
local hooksecurefunc = hooksecurefunc
local CreateFrame = CreateFrame

local function HandleTabs()
	-- Bottom tabs
	for _, tab in next, {
		_G.AuctionHouseFrameBuyTab,
		_G.AuctionHouseFrameSellTab,
		_G.AuctionHouseFrameAuctionsTab,
		
	} do
		BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)
	end

	_G.AuctionHouseFrameBuyTab:ClearAllPoints()
	_G.AuctionHouseFrameBuyTab:Point('TOPLEFT', _G.AuctionHouseFrame, 'BOTTOMLEFT', -3, -4)
	_G.AuctionHouseFrameSellTab:ClearAllPoints()
	_G.AuctionHouseFrameSellTab:Point('LEFT', _G.AuctionHouseFrameBuyTab, 'RIGHT', 0, 0)
	_G.AuctionHouseFrameAuctionsTab:ClearAllPoints()
	_G.AuctionHouseFrameAuctionsTab:Point('LEFT', _G.AuctionHouseFrameSellTab, 'RIGHT', 0, 0)
end

local function SkinItemDisplay(frame)
	local ItemDisplay = frame.ItemDisplay
	local ItemButton = ItemDisplay.ItemButton
	BORDER:CreateBorder(ItemButton, nil, -5, 5, 5, -5)
	BORDER:HandleIconBorder(ItemButton.IconBorder, ItemButton.border)
end

local function HandleHeaders(frame)
	local maxHeaders = frame.HeaderContainer:GetNumChildren()
	for i, header in next, { frame.HeaderContainer:GetChildren() } do
		BORDER:CreateBorder(header, nil, -7, 7, 7, -7, true, true)
	end
end

local function HandleSellFrame(frame)
	local ItemDisplay = frame.ItemDisplay                    
	local ItemButton = ItemDisplay.ItemButton                    

	ItemDisplay:SetBackdrop(nil)
	BORDER:HandleIcon(ItemButton.Icon, true)
	BORDER:CreateBorder(frame.QuantityInput.InputBox, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(frame.QuantityInput.MaxButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(frame.PriceInput.MoneyInputFrame.GoldBox, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(frame.PriceInput.MoneyInputFrame.SilverBox, nil, nil, nil, nil, nil, true, true)

	if ItemButton.IconBorder then
		BORDER:HandleIconBorder(ItemButton.IconBorder, ItemButton.Icon.backdrop.border)
	end

	if frame.SecondaryPriceInput then
		BORDER:CreateBorder(frame.SecondaryPriceInput.MoneyInputFrame.GoldBox)
		BORDER:CreateBorder(frame.SecondaryPriceInput.MoneyInputFrame.SilverBox)
	end

	BORDER:CreateBorder(frame.Duration.Dropdown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(frame.PostButton, nil, nil, nil, nil, nil, false, true)

	if frame.BuyoutModeCheckButton then
		BORDER:CreateBorder(frame.BuyoutModeCheckButton, nil, nil, nil, nil, nil, true, true)
		frame.BuyoutModeCheckButton:Size(25)
	end
end

local function HandleAuctionButtons(button)
	BORDER:CreateBorder(button)
	button:Size(22)
end

local function HandleSummaryIcons(frame)
	for _, child in next, { frame.ScrollTarget:GetChildren() } do
		if child.Icon then
			if not child.IsBorder then
				BORDER:CreateBorder(child.Icon)

				if child.IconBorder then
					child.IconBorder:Kill()
				end

				child.IsBorder = true
			end
		end
	end
end

local function HandleTokenSellFrame(frame)
	local ItemDisplay = frame.ItemDisplay
	local ItemButton = ItemDisplay.ItemButton

	BORDER:CreateBorder(ItemButton, nil, -5, 5, 5, -5)

	if ItemButton.IconBorder then
		BORDER:HandleIconBorder(ItemButton.IconBorder, ItemButton.border)
	end

	BORDER:CreateBorder(frame.PostButton, nil, nil, nil, nil, nil, false, true)
	HandleAuctionButtons(frame.DummyRefreshButton)
end

local function HandleSellList(frame, hasHeader, fitScrollBar)

	if frame.RefreshFrame then
		HandleAuctionButtons(frame.RefreshFrame.RefreshButton)
	end

	BORDER:CreateBorder(frame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	if hasHeader then
		frame.ScrollBox:SetBackdrop(nil)
		hooksecurefunc(frame, 'RefreshScrollFrame', HandleHeaders)
	end
end

local function LoadSkin()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.auctionhouse) then return end
    if not E.db.ProjectHopes.skins.auctionHouse then return end

	local AuctionHouseFrame = _G.AuctionHouseFrame
	BORDER:CreateBorder(AuctionHouseFrame)
	--BORDER:CreateBorder(_G.Auction)

	-- SearchBarFrame
	BORDER:CreateBorder(AuctionHouseFrame.SearchBar.FilterButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(AuctionHouseFrame.SearchBar.SearchButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(AuctionHouseFrame.SearchBar.SearchBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(AuctionHouseFrame.SearchBar.FavoritesSearchButton, nil, nil, nil, nil, nil, false, true)


	-- Categories List
	local Categories = AuctionHouseFrame.CategoriesList
	BORDER:CreateBorder(Categories.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	Categories.NineSlice:SetBackdrop(nil)

	-- Browse Frame
	local Browse = AuctionHouseFrame.BrowseResultsFrame
	local BrowseList = Browse.ItemList
	BrowseList:SetBackdrop(nil)

	hooksecurefunc(BrowseList, 'RefreshScrollFrame', HandleHeaders)
	BORDER:CreateBorder(BrowseList.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	-- BuyOut Frame
	local CommoditiesBuyFrame = AuctionHouseFrame.CommoditiesBuyFrame
	BORDER:CreateBorder(CommoditiesBuyFrame.BackButton, nil, nil, nil, nil, nil, false, true)

	local CommoditiesBuyList = AuctionHouseFrame.CommoditiesBuyFrame.ItemList
	BORDER:CreateBorder(CommoditiesBuyList.RefreshFrame.RefreshButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(CommoditiesBuyList.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(CommoditiesBuyList)

	local BuyDisplay = AuctionHouseFrame.CommoditiesBuyFrame.BuyDisplay
	BORDER:CreateBorder(BuyDisplay.QuantityInput.InputBox)
	BORDER:CreateBorder(BuyDisplay.BuyButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(BuyDisplay.ItemDisplay, nil, nil, nil, nil, nil, true, false)

	SkinItemDisplay(BuyDisplay)

	-- ItemBuyOut Frame
	local ItemBuyFrame = AuctionHouseFrame.ItemBuyFrame
	BORDER:CreateBorder(ItemBuyFrame.BackButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(ItemBuyFrame.ItemDisplay.backdrop)
	SkinItemDisplay(ItemBuyFrame)

	local ItemBuyList = ItemBuyFrame.ItemList
	BORDER:CreateBorder(ItemBuyList.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(ItemBuyList.RefreshFrame.RefreshButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(ItemBuyList, nil, -7, 7, 7, -7)
	hooksecurefunc(ItemBuyList, 'RefreshScrollFrame', HandleHeaders)

	local EditBoxes = {
		_G.AuctionHouseFrameGold,
		_G.AuctionHouseFrameSilver,
	}

	for _, EditBox in pairs(EditBoxes) do
		BORDER:CreateBorder(EditBox)
	end
	BORDER:CreateBorder(ItemBuyFrame.BidFrame.BidButton, nil, -7, 7, 7, -7, false, true)
	ItemBuyFrame.BidFrame.BidButton:ClearAllPoints()
	ItemBuyFrame.BidFrame.BidButton:Point('LEFT', ItemBuyFrame.BidFrame.BidAmount, 'RIGHT', 6, -2)
	BORDER:CreateBorder(ItemBuyFrame.BuyoutFrame.BuyoutButton, nil, -7, 7, 7, -7, false, true)
	ItemBuyFrame.BuyoutFrame.BuyoutButton:Point('RIGHT', nil, 'RIGHT', -4, -2)
	_G.AuctionHouseFrameGold:Point('TOPLEFT', nil, 'TOPLEFT', 0, -1)

	-- Item Sell Frame | TAB 2
	local SellFrame = AuctionHouseFrame.ItemSellFrame
	SellFrame:SetBackdrop(nil)
	HandleSellFrame(SellFrame)

	local ItemSellList = AuctionHouseFrame.ItemSellList
	HandleSellList(ItemSellList, true, true)

	local CommoditiesSellFrame = AuctionHouseFrame.CommoditiesSellFrame
	HandleSellFrame(CommoditiesSellFrame)

	local CommoditiesSellList = AuctionHouseFrame.CommoditiesSellList
	HandleSellList(CommoditiesSellList, true)

	local TokenSellFrame = AuctionHouseFrame.WoWTokenSellFrame
	HandleTokenSellFrame(TokenSellFrame)

	-- Auctions Frame | TAB 3
	local AuctionsFrame = _G.AuctionHouseFrameAuctionsFrame
	SkinItemDisplay(AuctionsFrame)
	BORDER:CreateBorder(AuctionsFrame.BuyoutFrame.BuyoutButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(AuctionsFrame.ItemDisplay.backdrop)

	local CommoditiesList = AuctionsFrame.CommoditiesList
	HandleSellList(CommoditiesList, true)
	BORDER:CreateBorder(CommoditiesList.RefreshFrame.RefreshButton, nil, nil, nil, nil, nil, false, true)

	local AuctionsList = AuctionsFrame.ItemList
	HandleSellList(AuctionsList, true)
	BORDER:CreateBorder(AuctionsList.RefreshFrame.RefreshButton, nil, nil, nil, nil, nil, false, true)

	local AuctionsFrameTabs = {
		_G.AuctionHouseFrameAuctionsFrameAuctionsTab,
		_G.AuctionHouseFrameAuctionsFrameBidsTab,
	}

	for _, tab in pairs(AuctionsFrameTabs) do
		if tab then
			BORDER:CreateBorder(tab, 3, nil, nil, nil, nil, true, true)
		end
	end

	local SummaryList = AuctionsFrame.SummaryList
	HandleSellList(SummaryList)
	SummaryList:SetBackdrop(nil)

	BORDER:CreateBorder(AuctionsFrame.CancelAuctionButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(SummaryList.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	local AllAuctionsList = AuctionsFrame.AllAuctionsList
	HandleSellList(AllAuctionsList, true, true)
	BORDER:CreateBorder(AllAuctionsList.RefreshFrame.RefreshButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(AuctionsFrame.CancelAuctionButton, nil, nil, nil, nil, nil, false, true)
	if AuctionsFrame.CancelAuctionButton then 
		AuctionsFrame.CancelAuctionButton:ClearAllPoints()
		AuctionsFrame.CancelAuctionButton:SetPoint('TOPRIGHT', AllAuctionsList, 'BOTTOMRIGHT', -27, 0)
		AuctionsFrame.BidFrame.BidButton:SetPoint('LEFT', AuctionsFrame.BidFrame.BidAmount, 'RIGHT', 6, -1)
	end

	BORDER:CreateBorder(AuctionsFrame.BidFrame.BidButton, nil, nil, nil, nil, nil, false, true)

	local BidsList = AuctionsFrame.BidsList
	HandleSellList(BidsList, true, true)
	BORDER:CreateBorder(BidsList.RefreshFrame.RefreshButton, nil, nil, nil, nil, nil, false, true)

	local EditBoxesAuctions = {
		_G.AuctionHouseFrameAuctionsFrameGold,
		_G.AuctionHouseFrameAuctionsFrameSilver,
	}

	for _, EditBoxAuction in pairs(EditBoxesAuctions) do
		BORDER:CreateBorder(EditBoxAuction)
	end
	
	-- WoW Token Category
	local TokenFrame = AuctionHouseFrame.WoWTokenResults
	BORDER:CreateBorder(TokenFrame.Buyout, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(TokenFrame.DummyScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	local Token = TokenFrame.TokenDisplay
	BORDER:CreateBorder(Token)

	local ItemButton = Token.ItemButton
	BORDER:CreateBorder(ItemButton.Icon.backdrop)
	ItemButton.Icon.backdrop.border:SetBackdrop(Private.BorderLight)
	ItemButton.Icon.backdrop.border:SetBackdropBorderColor(0, .8, 1)

	-- WoW Token Tutorial Frame
	local WowTokenGameTimeTutorial = AuctionHouseFrame.WoWTokenResults.GameTimeTutorial
	BORDER:CreateBorder(WowTokenGameTimeTutorial)
	BORDER:CreateBorder(WowTokenGameTimeTutorial.RightDisplay.StoreButton, nil, nil, nil, nil, nil, false, true)

	-- Dialogs
	BORDER:CreateBorder(AuctionHouseFrame.BuyDialog)
	BORDER:CreateBorder(AuctionHouseFrame.BuyDialog.BuyNowButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(AuctionHouseFrame.BuyDialog.CancelButton, nil, nil, nil, nil, nil, false, true)

	HandleTabs()
end

S:AddCallbackForAddon('Blizzard_AuctionHouseUI', 'AuctionHouse', LoadSkin)
