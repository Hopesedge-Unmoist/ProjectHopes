local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next, pairs, unpack = next, pairs, unpack
local hooksecurefunc = hooksecurefunc

local function SkinFilterButton(Button)
	BORDER:CreateBorder(Button, nil, nil, nil, nil, nil, false, true)
end

local function HandleSearchBarFrame(Frame)
	SkinFilterButton(Frame.FilterButton)

	BORDER:CreateBorder(Frame.SearchButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(Frame.SearchBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(Frame.FavoritesSearchButton, nil, nil, nil, nil, nil, false, true)

	Frame.FavoritesSearchButton:Size(22)
end

local function HandleListIcon(frame)
	if not frame.tableBuilder then return end

	for i = 1, 22 do
		local row = frame.tableBuilder.rows[i]
		if row then
			for j = 1, 4 do
				local cell = row.cells and row.cells[j]
				if cell and cell.Icon then
					if not cell.IsBorder then
						if not cell.Icon.backdrop then

							BORDER:HandleIcon(cell.Icon, true)
						end
						cell.IsBorder = true
					end
					if not cell.Icon then
						if cell.Icon.backdrop.border then
							cell.Icon.backdrop.border:Kill()
						end
					end
				end
			end
		end
	end
end

local function HandleSummaryIcon(child)
	if child.Icon then
		if not child.IsBorder then
			BORDER:HandleIcon(child.Icon)

			child.IsBorder = true
		end
	end
end

local function HandleSummaryIcons(frame)
	frame:ForEachFrame(HandleSummaryIcon)
end

local function SkinItemDisplay(frame)
	local ItemDisplay = frame.ItemDisplay
	local ItemButton = ItemDisplay.ItemButton

	BORDER:HandleIcon(ItemButton.Icon, true)
	BORDER:HandleIconBorder(ItemButton.IconBorder, ItemButton.Icon.backdrop.border)
end

local function HandleAuctionButtons(button)
	if button.backdrop then
		BORDER:CreateBorder(button, nil, nil, nil, nil, nil, true, true)
	elseif button then
		BORDER:CreateBorder(button, nil, nil, nil, nil, nil, false, true)
	end
end

local function HandleSellFrame(frame)
	local ItemDisplay = frame.ItemDisplay
	local ItemButton = ItemDisplay.ItemButton

	BORDER:HandleIcon(ItemButton.Icon, true)
	BORDER:CreateBorder(frame.QuantityInput.InputBox, nil, nil, nil, nil, nil, true, false)

	BORDER:CreateBorder(frame.QuantityInput.MaxButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(frame.PriceInput.MoneyInputFrame.GoldBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(frame.PriceInput.MoneyInputFrame.SilverBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(frame.PriceInput.MoneyInputFrame.CopperBox, nil, nil, nil, nil, nil, true, false)

	if ItemButton.IconBorder then
		BORDER:HandleIconBorder(ItemButton.IconBorder, ItemButton.Icon.backdrop.border)
	end

	if frame.SecondaryPriceInput then
		BORDER:CreateBorder(frame.SecondaryPriceInput.MoneyInputFrame.GoldBox, nil, nil, nil, nil, nil, true, false)
		BORDER:CreateBorder(frame.SecondaryPriceInput.MoneyInputFrame.SilverBox, nil, nil, nil, nil, nil, true, false)
		BORDER:CreateBorder(frame.SecondaryPriceInput.MoneyInputFrame.CopperBox, nil, nil, nil, nil, nil, true, false)
	end

	BORDER:CreateBorder(frame.Duration.Dropdown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(frame.PostButton, nil, nil, nil, nil, nil, false, true)

	if frame.BuyoutModeCheckButton then
		BORDER:CreateBorder(frame.BuyoutModeCheckButton, nil, nil, nil, nil, nil, true, true)
	end
end

local function HandleTokenSellFrame(frame)
	local ItemDisplay = frame.ItemDisplay
	local ItemButton = ItemDisplay.ItemButton

	BORDER:HandleIcon(ItemButton.Icon, true)

	if ItemButton.IconBorder then
		BORDER:HandleIconBorder(ItemButton.IconBorder, ItemButton.Icon.backdrop.border)
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
		return
	else
		hooksecurefunc(frame.ScrollBox, 'Update', HandleSummaryIcons)
	end
end

local function HandleTabs(arg1)
	local frame = _G.AuctionHouseFrame
	if not arg1 or arg1 ~= frame then return end

	local lastTab = _G.AuctionHouseFrameBuyTab
	for index, tab in next, frame.Tabs do
		-- we can move addon tabs but only skin the blizzard ones (AddonSkins handles the rest)
		local blizzTab = tab == _G.AuctionHouseFrameBuyTab or tab == _G.AuctionHouseFrameSellTab or tab == _G.AuctionHouseFrameAuctionsTab
		if blizzTab and tab.backdrop then
			BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)
		end

		-- tab positions
		tab:ClearAllPoints()

		if index == 1 then
			tab:Point('BOTTOMLEFT', frame, 'BOTTOMLEFT', -10, -37)
		else -- skinned ones can be closer together
			tab:Point('TOPLEFT', lastTab, 'TOPRIGHT', (tab.backdrop or tab.Backdrop) and -15 or 0, 0)
		end

		lastTab = tab
	end
end

local function LoadSkin()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.auctionhouse) then return end
  if not E.db.ProjectHopes.skins.auctionHouse then return end

	--[[ Main Frame | TAB 1]]--
	local Frame = _G.AuctionHouseFrame
	BORDER:CreateBorder(Frame)

	-- handle tab spacing
	hooksecurefunc('PanelTemplates_SetNumTabs', HandleTabs)
	HandleTabs(Frame) -- call it once to setup our tabs

	-- SearchBar Frame
	HandleSearchBarFrame(Frame.SearchBar)

	--[[ Categorie List ]]--
	local Categories = Frame.CategoriesList
	BORDER:CreateBorder(Categories.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	--[[ Browse Frame ]]--
	local Browse = Frame.BrowseResultsFrame

	local BrowseList = Browse.ItemList

	BORDER:CreateBorder(BrowseList.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	--[[ BuyOut Frame]]
	local CommoditiesBuyFrame = Frame.CommoditiesBuyFrame
	BORDER:CreateBorder(CommoditiesBuyFrame.BackButton, nil, nil, nil, nil, nil, false, true)

	local CommoditiesBuyList = Frame.CommoditiesBuyFrame.ItemList
	BORDER:CreateBorder(CommoditiesBuyList.RefreshFrame.RefreshButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(CommoditiesBuyList.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	local BuyDisplay = Frame.CommoditiesBuyFrame.BuyDisplay
	BORDER:CreateBorder(BuyDisplay.QuantityInput.InputBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(BuyDisplay.BuyButton, nil, nil, nil, nil, nil, false, true)

	SkinItemDisplay(BuyDisplay)

	--[[ ItemBuyOut Frame]]
	local ItemBuyFrame = Frame.ItemBuyFrame
	BORDER:CreateBorder(ItemBuyFrame.BackButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(ItemBuyFrame.BuyoutFrame.BuyoutButton, nil, nil, nil, nil, nil, false, true)

	SkinItemDisplay(ItemBuyFrame)

	local ItemBuyList = ItemBuyFrame.ItemList
	BORDER:CreateBorder(ItemBuyList.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(ItemBuyList.RefreshFrame.RefreshButton, nil, nil, nil, nil, nil, false, true)

	local EditBoxes = {
		_G.AuctionHouseFrameGold,
		_G.AuctionHouseFrameSilver,
	}

	for _, EditBox in pairs(EditBoxes) do
		BORDER:CreateBorder(EditBox, nil, nil, nil, nil, nil, true, false)
	end

	BORDER:CreateBorder(ItemBuyFrame.BidFrame.BidButton, nil, nil, nil, nil, nil, false, true)

	--[[ Item Sell Frame | TAB 2 ]]--
	local SellFrame = Frame.ItemSellFrame
	HandleSellFrame(SellFrame)

	local ItemSellList = Frame.ItemSellList
	HandleSellList(ItemSellList)

	local CommoditiesSellFrame = Frame.CommoditiesSellFrame
	HandleSellFrame(CommoditiesSellFrame)

	local CommoditiesSellList = Frame.CommoditiesSellList
	HandleSellList(CommoditiesSellList, true)

	local TokenSellFrame = Frame.WoWTokenSellFrame
	HandleTokenSellFrame(TokenSellFrame)

	--[[ Auctions Frame | TAB 3 ]]--
	local AuctionsFrame = _G.AuctionHouseFrameAuctionsFrame
	SkinItemDisplay(AuctionsFrame)
	BORDER:CreateBorder(AuctionsFrame.BuyoutFrame.BuyoutButton, nil, nil, nil, nil, nil, false, true)

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
			BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)
		end
	end

	local SummaryList = AuctionsFrame.SummaryList
	HandleSellList(SummaryList)
	BORDER:CreateBorder(AuctionsFrame.CancelAuctionButton, nil, nil, nil, nil, nil, false, true)

	local AllAuctionsList = AuctionsFrame.AllAuctionsList
	HandleSellList(AllAuctionsList, true, true)
	BORDER:CreateBorder(AllAuctionsList.RefreshFrame.RefreshButton, nil, nil, nil, nil, nil, false, true)

	local BidsList = AuctionsFrame.BidsList
	HandleSellList(BidsList, true, true)
	BORDER:CreateBorder(BidsList.RefreshFrame.RefreshButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(AuctionsFrame.BidFrame.BidButton, nil, nil, nil, nil, nil, false, true)


	--[[ WoW Token Category ]]--
	local TokenFrame = Frame.WoWTokenResults
	BORDER:CreateBorder(TokenFrame.Buyout, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(TokenFrame.DummyScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	local Token = TokenFrame.TokenDisplay
	local ItemButton = Token.ItemButton
	BORDER:HandleIcon(ItemButton.Icon, true)

	--WoW Token Tutorial Frame
	local WowTokenGameTimeTutorial = Frame.WoWTokenResults.GameTimeTutorial
	BORDER:CreateBorder(WowTokenGameTimeTutorial.RightDisplay.StoreButton, nil, nil, nil, nil, nil, false, true)

	--[[ Dialogs ]]--
	BORDER:CreateBorder(Frame.BuyDialog.BuyNowButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(Frame.BuyDialog.CancelButton, nil, nil, nil, nil, nil, false, true)

	--[[ Multisell ]]--
	local multisellFrame = _G.AuctionHouseMultisellProgressFrame
	local progressBar = multisellFrame.ProgressBar

	BORDER:HandleIcon(progressBar.Icon)
end

S:AddCallbackForAddon('Blizzard_AuctionHouseUI', 'AuctionHouse', LoadSkin)
