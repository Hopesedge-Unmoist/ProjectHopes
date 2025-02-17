local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next = next
local select = select
local unpack = unpack
local tostring = tostring
local strmatch = strmatch
local GetItemInfo = GetItemInfo
local hooksecurefunc = hooksecurefunc
local tabSkinned = false

local function handlechildtab(frame)
	for _, tab in pairs{frame:GetChildren()} do
		if tab:IsObjectType('Button') then
			if tab.Text then
				S:HandleTab(tab)
				BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)

				tab.Text:ClearAllPoints()
				tab.Text:SetPoint("CENTER", tab, "CENTER", 0, 0)

				tab.Arrow:ClearAllPoints()
				tab.Arrow:SetPoint("CENTER", tab, "RIGHT", -10, 0)
			end
		end
	end
end

local function viewItem(frame)
	if frame.Icon.GetNumPoints and frame.Icon:GetNumPoints() > 0 then
		local pointsCache = {}

		for i = 1, frame.Icon:GetNumPoints() do
			local point, relativeTo, relativePoint, xOfs, yOfs = frame.Icon:GetPoint(i)

			if relativePoint == "TOPLEFT" then
				xOfs = xOfs + 2
				yOfs = yOfs - 2
			elseif relativePoint == "BOTTOMRIGHT" then
				xOfs = xOfs - 2
				yOfs = yOfs + 2
			end

			pointsCache[i] = {point, relativeTo, relativePoint, xOfs, yOfs}
		end

		frame.Icon:ClearAllPoints()

		for i = 1, #pointsCache do
			local pointData = pointsCache[i]
			frame.Icon:SetPoint(pointData[1], pointData[2], pointData[3], pointData[4], pointData[5])
		end
	end

	frame.EmptySlot:SetTexture(nil)
	frame.EmptySlot:Hide()
	
	S:HandleIcon(frame.Icon, true)
	BORDER:CreateBorder(frame.Icon.backdrop, nil, -7, 7, 7, -7)
	frame.Icon.backdrop.border:SetBackdrop(Private.BorderLight)
	BORDER:HandleIconBorder(frame.IconBorder, frame.Icon.backdrop.border)
end

local function handlesubframe(frame)
	if frame.Icon then
		if frame.NormalTexture then
			frame.NormalTexture:SetAlpha(0)
			frame.NormalTexture.SetAlpha = E.noop
		end
		if frame.HighlightTexture then
			frame.HighlightTexture:SetAlpha(0)
			frame.HighlightTexture.SetAlpha = E.noop
		end
	end

	if frame:GetObjectType() ~= "Texture" then
		for i = 1, frame:GetNumChildren() do
			local subframe = select(i, frame:GetChildren())
			if subframe then
				if subframe:GetObjectType() == "Frame" then
					S:HandleFrame(subframe) --causes erors in non pixel perfect mode (non thin mode)
					subframe:SetBackdrop()
					if subframe.NormalTexture then
						subframe.NormalTexture:SetAlpha(0)
						subframe.NormalTexture.SetAlpha = E.noop
					end
					if subframe.HighlightTexture then
						subframe.HighlightTexture:SetAlpha(0)
						subframe.HighlightTexture.SetAlpha = E.noop
					end
				elseif subframe:GetObjectType() == "Button" then
					--subframe:StripTextures()
					S:HandleButton(subframe)
				elseif subframe:GetObjectType() == "EditBox" then
					S:HandleEditBox(subframe)
					subframe:SetTemplate()
				elseif subframe:GetObjectType() == "CheckButton" then
					S:HandleButton(subframe)
				end
				handlesubframe(subframe)
			end
		end
	end
end

local function viewGroup(frame)
	if frame.GroupTitle then
		frame.GroupTitle:StripTextures()
		
		S:HandleButton(frame.GroupTitle)
		frame.GroupTitle:SetBackdrop()
		if frame.GroupTitle.NormalTexture then
			frame.GroupTitle.NormalTexture:Hide()
		end

		BORDER:CreateBorder(frame.GroupTitle, nil, -7.5, 7, 7.5, -7, false, true)
	end
end

local function tryPostHook(...)
	local frame, method, hookFunc = ...
	if frame and method and _G[frame] and _G[frame][method] then
		hooksecurefunc(
			_G[frame],
			method,
			function(frame, ...)
				if not frame.IsBorder then
					hookFunc(frame, ...)
					frame.IsBorder = true
				end
			end
		)
	end
end

function S:Auctionator()
	if not E.db.ProjectHopes.skins.auctionator then return end
	if not E.private.skins.blizzard.enable then return end

	local AuctionatorShoppingFrame = _G.AuctionatorShoppingFrame
	if AuctionatorShoppingFrame and not AuctionatorShoppingFrame.IsBorder then

		--scanning thing
		if not E.Retail then
			local AuctionatorPageStatusDialogFrame = _G.AuctionatorPageStatusDialogFrame
			S:HandleFrame(AuctionatorPageStatusDialogFrame)
			BORDER:CreateBorder(AuctionatorPageStatusDialogFrame)
		end

		--shopping
		S:HandleFrame(AuctionatorShoppingFrame)
		S:HandleFrame(AuctionatorShoppingFrame.ShoppingResultsInset)
		AuctionatorShoppingFrame.ShoppingResultsInset:Hide()

		if not E.Retail then
			AuctionatorShoppingFrame.ShoppingResultsInset:SetBackdrop()
			AuctionatorShoppingFrame.ListsContainer:CreateBackdrop()
			S:HandleButton(AuctionatorShoppingFrame.LoadAllPagesButton)
			--BORDER:CreateBorder(AuctionatorShoppingFrame.LoadAllPagesButton, nil, nil, nil, nil, nil, false, true)

			for _, v in pairs{AuctionatorShoppingFrame.ShoppingResultsInset:GetChildren()} do
				if v.BorderBottomLeft then
					v:Kill()
				end
			end
		else
			AuctionatorShoppingFrame.ShoppingResultsInset:CreateBackdrop()
		end

		S:HandleFrame(AuctionatorShoppingFrame.SearchOptions)
		AuctionatorShoppingFrame.SearchOptions:SetBackdrop()
		AuctionatorShoppingFrame.RecentsContainer.Inset:Hide()
		S:HandleFrame(AuctionatorShoppingFrame.ListsContainer)
		AuctionatorShoppingFrame.ListsContainer.Inset:Hide()
		AuctionatorShoppingFrame.ListsContainer:SetBackdrop()

		if not E.Retail then
			AuctionatorShoppingFrame.ListsContainer.Inset:Hide()
			AuctionatorShoppingFrame.ListsContainer:CreateBackdrop()
		end

		AuctionatorShoppingFrame.RecentsContainer.ScrollBox:CreateBackdrop()
		handlechildtab(AuctionatorShoppingFrame.ResultsListing.HeaderContainer)

		S:HandleButton(AuctionatorShoppingFrame.ExportButton)
		BORDER:CreateBorder(AuctionatorShoppingFrame.ExportButton, nil, nil, nil, nil, nil, false, true)
		S:HandleButton(AuctionatorShoppingFrame.ImportButton)
		BORDER:CreateBorder(AuctionatorShoppingFrame.ImportButton, nil, nil, nil, nil, nil, false, true)
		AuctionatorShoppingFrame.ImportButton:ClearAllPoints()
		AuctionatorShoppingFrame.ImportButton:SetPoint("RIGHT", AuctionatorShoppingFrame.ExportButton, "LEFT", -5, 0)
		S:HandleButton(AuctionatorShoppingFrame.NewListButton)
		BORDER:CreateBorder(AuctionatorShoppingFrame.NewListButton, nil, nil, nil, nil, nil, false, true)
		S:HandleButton(AuctionatorShoppingFrame.ExportCSV)
		BORDER:CreateBorder(AuctionatorShoppingFrame.ExportCSV, nil, nil, nil, nil, nil, false, true)
		S:HandleButton(AuctionatorShoppingFrame.SearchOptions.SearchButton)
		BORDER:CreateBorder(AuctionatorShoppingFrame.SearchOptions.SearchButton, nil, nil, nil, nil, nil, false, true)
		S:HandleButton(AuctionatorShoppingFrame.SearchOptions.MoreButton)
		BORDER:CreateBorder(AuctionatorShoppingFrame.SearchOptions.MoreButton, nil, nil, nil, nil, nil, false, true)
		S:HandleButton(AuctionatorShoppingFrame.SearchOptions.AddToListButton)
		BORDER:CreateBorder(AuctionatorShoppingFrame.SearchOptions.AddToListButton, nil, nil, nil, nil, nil, false, true)

		local AuctionatorImportListFrame = _G.AuctionatorImportListFrame
		S:HandleFrame(AuctionatorImportListFrame)
		BORDER:CreateBorder(AuctionatorImportListFrame)
		S:HandleCloseButton(AuctionatorImportListFrame.CloseDialog)
		S:HandleButton(AuctionatorImportListFrame.Import)
		BORDER:CreateBorder(AuctionatorImportListFrame.Import, nil, nil, nil, nil, nil, false, true)
		S:HandleTrimScrollBar(AuctionatorImportListFrame.ScrollBar)
		BORDER:CreateBorder(AuctionatorImportListFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
		AuctionatorImportListFrame.Inset:Hide()

		local AuctionatorExportListFrame = _G.AuctionatorExportListFrame
		S:HandleFrame(AuctionatorExportListFrame)
		BORDER:CreateBorder(AuctionatorExportListFrame)
		S:HandleCloseButton(AuctionatorExportListFrame.CloseDialog)
		S:HandleButton(AuctionatorExportListFrame.Export)
		BORDER:CreateBorder(AuctionatorExportListFrame.Export, nil, nil, nil, nil, nil, false, true)
		S:HandleButton(AuctionatorExportListFrame.UnselectAll)
		BORDER:CreateBorder(AuctionatorExportListFrame.UnselectAll, nil, nil, nil, nil, nil, false, true)
		AuctionatorExportListFrame.UnselectAll:ClearAllPoints()
		AuctionatorExportListFrame.UnselectAll:SetPoint("LEFT", AuctionatorExportListFrame.SelectAll, "RIGHT", 5, 0)
		S:HandleButton(AuctionatorExportListFrame.SelectAll)
		BORDER:CreateBorder(AuctionatorExportListFrame.SelectAll, nil, nil, nil, nil, nil, false, true)
		S:HandleTrimScrollBar(AuctionatorExportListFrame.ScrollBar)
		BORDER:CreateBorder(AuctionatorExportListFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
		AuctionatorExportListFrame.Inset:Hide()

		S:HandleTab(AuctionatorShoppingFrame.ContainerTabs.ListsTab)
		BORDER:CreateBorder(AuctionatorShoppingFrame.ContainerTabs.ListsTab, nil, nil, nil, nil, nil, true, true)

		AuctionatorShoppingFrame.ContainerTabs.ListsTab:SetHeight(25)
		AuctionatorShoppingFrame.ContainerTabs.ListsTab.Text:ClearAllPoints()
		AuctionatorShoppingFrame.ContainerTabs.ListsTab.Text:SetPoint("CENTER",AuctionatorShoppingFrame.ContainerTabs.ListsTab)
		AuctionatorShoppingFrame.ContainerTabs.ListsTab.Text.SetPoint = E.noop
		S:HandleTab(AuctionatorShoppingFrame.ContainerTabs.RecentsTab)
		BORDER:CreateBorder(AuctionatorShoppingFrame.ContainerTabs.RecentsTab, nil, nil, nil, nil, nil, true, true)

		AuctionatorShoppingFrame.ContainerTabs.RecentsTab:SetHeight(25)
		AuctionatorShoppingFrame.ContainerTabs.RecentsTab.Text:ClearAllPoints()
		AuctionatorShoppingFrame.ContainerTabs.RecentsTab.Text:SetPoint("CENTER",AuctionatorShoppingFrame.ContainerTabs.RecentsTab)
		AuctionatorShoppingFrame.ContainerTabs.RecentsTab.Text.SetPoint = E.noop

		S:HandleEditBox(AuctionatorShoppingFrame.SearchOptions.SearchString)
		BORDER:CreateBorder(AuctionatorShoppingFrame.SearchOptions.SearchString, nil, nil, nil, nil, nil, true, false)

		S:HandleTrimScrollBar(AuctionatorShoppingFrame.ResultsListing.ScrollArea.ScrollBar)
		BORDER:CreateBorder(AuctionatorShoppingFrame.ResultsListing.ScrollArea.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

		S:HandleTrimScrollBar(AuctionatorShoppingFrame.RecentsContainer.ScrollBar)
		BORDER:CreateBorder(AuctionatorShoppingFrame.RecentsContainer.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

		S:HandleTrimScrollBar(AuctionatorShoppingFrame.ListsContainer.ScrollBar)
		BORDER:CreateBorder(AuctionatorShoppingFrame.ListsContainer.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
		
		S:HandleFrame(AuctionatorShoppingFrame.exportCSVDialog)
		BORDER:CreateBorder(AuctionatorShoppingFrame.exportCSVDialog)

		S:HandleTrimScrollBar(AuctionatorShoppingFrame.exportCSVDialog.ScrollBar)
		BORDER:CreateBorder(AuctionatorShoppingFrame.exportCSVDialog.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

		S:HandleButton(AuctionatorShoppingFrame.exportCSVDialog.Close)
		BORDER:CreateBorder(AuctionatorShoppingFrame.exportCSVDialog.Close, nil, nil, nil, nil, nil, false, true)
		
		--shopping tab frame
		local AuctionatorShoppingTabItemFrame = _G.AuctionatorShoppingTabItemFrame
		S:HandleFrame(AuctionatorShoppingTabItemFrame)
		BORDER:CreateBorder(AuctionatorShoppingTabItemFrame)

		S:HandleButton(AuctionatorShoppingTabItemFrame.Cancel)
		BORDER:CreateBorder(AuctionatorShoppingTabItemFrame.Cancel, nil, nil, nil, nil, nil, false, true)

		S:HandleButton(AuctionatorShoppingTabItemFrame.ResetAllButton)
		BORDER:CreateBorder(AuctionatorShoppingTabItemFrame.ResetAllButton, nil, nil, nil, nil, nil, false, true)
		AuctionatorShoppingTabItemFrame.ResetAllButton:ClearAllPoints()
		AuctionatorShoppingTabItemFrame.ResetAllButton:SetPoint("LEFT", AuctionatorShoppingTabItemFrame.Cancel, "RIGHT", 5, 0)
		
		S:HandleButton(AuctionatorShoppingTabItemFrame.Finished)
		BORDER:CreateBorder(AuctionatorShoppingTabItemFrame.Finished, nil, nil, nil, nil, nil, false, true)

		S:HandleEditBox(AuctionatorShoppingTabItemFrame.SearchContainer.SearchString)
		BORDER:CreateBorder(AuctionatorShoppingTabItemFrame.SearchContainer.SearchString, nil, nil, nil, nil, nil, true, false)

		S:HandleCheckBox(AuctionatorShoppingTabItemFrame.SearchContainer.IsExact)
		BORDER:CreateBorder(AuctionatorShoppingTabItemFrame.SearchContainer.IsExact, nil, nil, nil, nil, nil, true, true)

		S:HandleEditBox(AuctionatorShoppingTabItemFrame.LevelRange.MinBox)
		BORDER:CreateBorder(AuctionatorShoppingTabItemFrame.LevelRange.MinBox, nil, nil, nil, nil, nil, true, false)

		S:HandleEditBox(AuctionatorShoppingTabItemFrame.LevelRange.MaxBox)
		BORDER:CreateBorder(AuctionatorShoppingTabItemFrame.LevelRange.MaxBox, nil, nil, nil, nil, nil, true, false)

		S:HandleEditBox(AuctionatorShoppingTabItemFrame.ItemLevelRange.MinBox)
		BORDER:CreateBorder(AuctionatorShoppingTabItemFrame.ItemLevelRange.MinBox, nil, nil, nil, nil, nil, true, false)

		S:HandleEditBox(AuctionatorShoppingTabItemFrame.ItemLevelRange.MaxBox)
		BORDER:CreateBorder(AuctionatorShoppingTabItemFrame.ItemLevelRange.MaxBox, nil, nil, nil, nil, nil, true, false)

		S:HandleEditBox(AuctionatorShoppingTabItemFrame.PriceRange.MinBox)
		BORDER:CreateBorder(AuctionatorShoppingTabItemFrame.PriceRange.MinBox, nil, nil, nil, nil, nil, true, false)

		S:HandleEditBox(AuctionatorShoppingTabItemFrame.PriceRange.MaxBox)
		BORDER:CreateBorder(AuctionatorShoppingTabItemFrame.PriceRange.MaxBox, nil, nil, nil, nil, nil, true, false)

		S:HandleEditBox(AuctionatorShoppingTabItemFrame.CraftedLevelRange.MinBox)
		BORDER:CreateBorder(AuctionatorShoppingTabItemFrame.CraftedLevelRange.MinBox, nil, nil, nil, nil, nil, true, false)

		S:HandleEditBox(AuctionatorShoppingTabItemFrame.CraftedLevelRange.MaxBox)
		BORDER:CreateBorder(AuctionatorShoppingTabItemFrame.CraftedLevelRange.MaxBox, nil, nil, nil, nil, nil, true, false)

		S:HandleEditBox(AuctionatorShoppingTabItemFrame.PurchaseQuantity.InputBox)
		BORDER:CreateBorder(AuctionatorShoppingTabItemFrame.PurchaseQuantity.InputBox, nil, nil, nil, nil, nil, true, false)

		S:HandleDropDownBox(_G.AuctionatorShoppingTabItemFrame_FilterKeySelector, 213)
		BORDER:CreateBorder(_G.AuctionatorShoppingTabItemFrame_FilterKeySelector, nil, nil, nil, nil, nil, true, true)
		_G.AuctionatorShoppingTabItemFrame_FilterKeySelector.ResetButton:ClearAllPoints()
		_G.AuctionatorShoppingTabItemFrame_FilterKeySelector.ResetButton:SetPoint("LEFT", _G.AuctionatorShoppingTabItemFrame_FilterKeySelector, "RIGHT", 5, 0)
		
		S:HandleDropDownBox(AuctionatorShoppingTabItemFrame.QualityContainer.DropDown.DropDown,180)
		BORDER:CreateBorder(AuctionatorShoppingTabItemFrame.QualityContainer.DropDown.DropDown, nil, nil, nil, nil, nil, true, true)
		AuctionatorShoppingTabItemFrame.QualityContainer.ResetQualityButton:ClearAllPoints()
		AuctionatorShoppingTabItemFrame.QualityContainer.ResetQualityButton:SetPoint("LEFT", AuctionatorShoppingTabItemFrame.QualityContainer.DropDown.DropDown, "RIGHT", 5, 0)
		
		S:HandleDropDownBox(AuctionatorShoppingTabItemFrame.ExpansionContainer.DropDown.DropDown,180)
		BORDER:CreateBorder(AuctionatorShoppingTabItemFrame.ExpansionContainer.DropDown.DropDown, nil, nil, nil, nil, nil, true, true)
		AuctionatorShoppingTabItemFrame.ExpansionContainer.ResetExpansionButton:ClearAllPoints()
		AuctionatorShoppingTabItemFrame.ExpansionContainer.ResetExpansionButton:SetPoint("LEFT", AuctionatorShoppingTabItemFrame.ExpansionContainer.DropDown.DropDown, "RIGHT", 5, 0)
		
		S:HandleDropDownBox(AuctionatorShoppingTabItemFrame.TierContainer.DropDown.DropDown,180)
		BORDER:CreateBorder(AuctionatorShoppingTabItemFrame.TierContainer.DropDown.DropDown, nil, nil, nil, nil, nil, true, true)
		AuctionatorShoppingTabItemFrame.TierContainer.ResetTierButton:ClearAllPoints()
		AuctionatorShoppingTabItemFrame.TierContainer.ResetTierButton:SetPoint("LEFT", AuctionatorShoppingTabItemFrame.TierContainer.DropDown.DropDown, "RIGHT", 5, 0)
		
		if AuctionatorShoppingTabItemFrame.Inset then
			AuctionatorShoppingTabItemFrame.Inset:Hide()
		end

		--selling
		local AuctionatorSellingFrame = _G.AuctionatorSellingFrame

		if not AuctionatorSellingFrame.BagListing.IsBorder then --items (can) update late, and they might also change, so hook view
			handlesubframe(AuctionatorSellingFrame.BagListing.View.ScrollBox.ItemListingFrame) --seems like if selling is the default view they update earlier
			AuctionatorSellingFrame.BagListing:HookScript("OnShow", function()
				if not AuctionatorSellingFrame.BagListing.IsBorder then
					E:Delay(0.1, function()
						handlesubframe(AuctionatorSellingFrame.BagListing.View.ScrollBox.ItemListingFrame)
					end)
					AuctionatorSellingFrame.BagListing.IsBorder = true
				end
			end)
			AuctionatorSellingFrame.BagListing.IsBorder = true
		end

		tryPostHook("AuctionatorGroupsViewGroupMixin", "SetName", viewGroup)
		tryPostHook("AuctionatorGroupsViewItemMixin", "SetItemInfo", viewItem)

		S:HandleTrimScrollBar(AuctionatorSellingFrame.BagListing.View.ScrollBar)
		BORDER:CreateBorder(AuctionatorSellingFrame.BagListing.View.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

		local AuctionatorItemHistoryFrame = _G.AuctionatorItemHistoryFrame
		if AuctionatorItemHistoryFrame then
			S:HandleFrame(AuctionatorItemHistoryFrame)
			BORDER:CreateBorder(AuctionatorItemHistoryFrame)

			S:HandleButton(AuctionatorItemHistoryFrame.Close)
			BORDER:CreateBorder(AuctionatorItemHistoryFrame.Close, nil, nil, nil, nil, nil, false, true)

			S:HandleButton(AuctionatorItemHistoryFrame.Dock)
			BORDER:CreateBorder(AuctionatorItemHistoryFrame.Dock, nil, nil, nil, nil, nil, false, true)

			S:HandleTrimScrollBar(AuctionatorItemHistoryFrame.ResultsListing.ScrollArea.ScrollBar)
			BORDER:CreateBorder(AuctionatorItemHistoryFrame.ResultsListing.ScrollArea.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

			handlechildtab(AuctionatorItemHistoryFrame.ResultsListing.HeaderContainer)
		end

		local AuctionatorBuyFrame = _G.AuctionatorBuyFrame
		if AuctionatorBuyFrame then
			if AuctionatorBuyFrame.CurrentPrices then
				S:HandleTrimScrollBar(AuctionatorBuyFrame.CurrentPrices.SearchResultsListing.ScrollArea.ScrollBar)
				BORDER:CreateBorder(AuctionatorBuyFrame.CurrentPrices.SearchResultsListing.ScrollArea.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

				S:HandleButton(AuctionatorBuyFrame.CurrentPrices.RefreshButton)
				BORDER:CreateBorder(AuctionatorBuyFrame.CurrentPrices.RefreshButton, nil, nil, nil, nil, nil, false, true)

				S:HandleButton(AuctionatorBuyFrame.CurrentPrices.BuyButton)
				BORDER:CreateBorder(AuctionatorBuyFrame.CurrentPrices.BuyButton, nil, nil, nil, nil, nil, false, true)

				S:HandleButton(AuctionatorBuyFrame.CurrentPrices.CancelButton)
				BORDER:CreateBorder(AuctionatorBuyFrame.CurrentPrices.CancelButton, nil, nil, nil, nil, nil, false, true)

				handlechildtab(AuctionatorBuyFrame.CurrentPrices.SearchResultsListing.HeaderContainer)
				AuctionatorBuyFrame.CurrentPrices.Inset:Hide()
				AuctionatorBuyFrame.CurrentPrices:CreateBackdrop()
			end
			S:HandleButton(AuctionatorBuyFrame.ReturnButton)
			BORDER:CreateBorder(AuctionatorBuyFrame.ReturnButton, nil, nil, nil, nil, nil, false, true)

			S:HandleButton(AuctionatorBuyFrame.HistoryButton)
			BORDER:CreateBorder(AuctionatorBuyFrame.HistoryButton, nil, nil, nil, nil, nil, false, true)

			if AuctionatorBuyFrame.HistoryPrices then
				S:HandleButton(AuctionatorBuyFrame.HistoryPrices.RealmHistoryButton)
				BORDER:CreateBorder(AuctionatorBuyFrame.HistoryPrices.RealmHistoryButton, nil, nil, nil, nil, nil, false, true)

				S:HandleButton(AuctionatorBuyFrame.HistoryPrices.PostingHistoryButton)
				BORDER:CreateBorder(AuctionatorBuyFrame.HistoryPrices.PostingHistoryButton, nil, nil, nil, nil, nil, false, true)

				handlechildtab(AuctionatorBuyFrame.HistoryPrices.RealmHistoryResultsListing.HeaderContainer)
				handlechildtab(AuctionatorBuyFrame.HistoryPrices.ResultsListing.HeaderContainer)
				S:HandleTrimScrollBar(AuctionatorBuyFrame.HistoryPrices.RealmHistoryResultsListing.ScrollArea.ScrollBar)
				BORDER:CreateBorder(AuctionatorBuyFrame.HistoryPrices.RealmHistoryResultsListing.ScrollArea.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
				
				S:HandleTrimScrollBar(AuctionatorBuyFrame.HistoryPrices.ResultsListing.ScrollArea.ScrollBar)
				BORDER:CreateBorder(AuctionatorBuyFrame.HistoryPrices.ResultsListing.ScrollArea.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
				
				AuctionatorBuyFrame.HistoryPrices.Inset:Hide()
				AuctionatorBuyFrame.HistoryPrices:CreateBackdrop()
			end
		end

		local AuctionatorBuyItemFrame = _G.AuctionatorBuyItemFrame
		if AuctionatorBuyItemFrame then
			S:HandleButton(AuctionatorBuyItemFrame.BackButton)
			BORDER:CreateBorder(AuctionatorBuyItemFrame.BackButton, nil, nil, nil, nil, nil, false, true)

			S:HandleButton(AuctionatorBuyItemFrame.BuyDialog.Buy)
			BORDER:CreateBorder(AuctionatorBuyItemFrame.BuyDialog.Buy, nil, nil, nil, nil, nil, false, true)

			S:HandleButton(AuctionatorBuyItemFrame.BuyDialog.Cancel)
			BORDER:CreateBorder(AuctionatorBuyItemFrame.BuyDialog.Cancel, nil, nil, nil, nil, nil, false, true)

			S:HandleFrame(AuctionatorBuyItemFrame.BuyDialog)
			BORDER:CreateBorder(AuctionatorBuyItemFrame.BuyDialog)

			if AuctionatorBuyItemFrame.ResultsListing then
				S:HandleFrame(AuctionatorBuyItemFrame.ResultsListing)
				BORDER:CreateBorder(AuctionatorBuyItemFrame.ResultsListing)

				handlechildtab(AuctionatorBuyItemFrame.ResultsListing.HeaderContainer)
				S:HandleTrimScrollBar(AuctionatorBuyItemFrame.ResultsListing.ScrollArea.ScrollBar)
				BORDER:CreateBorder(AuctionatorBuyItemFrame.ResultsListing.ScrollArea.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

				AuctionatorBuyItemFrame.Inset:Hide()
			end
		end

		if AuctionatorSellingFrame.CurrentPricesListing then
			S:HandleFrame(AuctionatorSellingFrame.CurrentPricesListing.ScrollArea)
			BORDER:CreateBorder(AuctionatorSellingFrame.CurrentPricesListing.ScrollArea)
			S:HandleTrimScrollBar(AuctionatorSellingFrame.CurrentPricesListing.ScrollArea.ScrollBar)
			BORDER:CreateBorder(AuctionatorSellingFrame.CurrentPricesListing.ScrollArea.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
			
			handlechildtab(AuctionatorSellingFrame.CurrentPricesListing.HeaderContainer)
		end

		if AuctionatorSellingFrame.HistoricalPriceListing then
			BORDER:CreateBorder(AuctionatorSellingFrame.HistoricalPriceListing.ScrollArea)
			S:HandleTrimScrollBar(AuctionatorSellingFrame.HistoricalPriceListing.ScrollArea.ScrollBar)
			BORDER:CreateBorder(AuctionatorSellingFrame.HistoricalPriceListing.ScrollArea.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

			handlechildtab(AuctionatorSellingFrame.HistoricalPriceListing.HeaderContainer)
		end

		if AuctionatorSellingFrame.PostingHistoryListing then
			BORDER:CreateBorder(AuctionatorSellingFrame.PostingHistoryListing.ScrollArea)
			S:HandleTrimScrollBar(AuctionatorSellingFrame.PostingHistoryListing.ScrollArea.ScrollBar)
			BORDER:CreateBorder(AuctionatorSellingFrame.PostingHistoryListing.ScrollArea.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

			handlechildtab(AuctionatorSellingFrame.PostingHistoryListing.HeaderContainer)
		end

		if AuctionatorSellingFrame.SaleItemFrame.Quantity then
			S:HandleEditBox(AuctionatorSellingFrame.SaleItemFrame.Quantity.InputBox)
			BORDER:CreateBorder(AuctionatorSellingFrame.SaleItemFrame.Quantity.InputBox, nil, nil, nil, nil, nil, true, false)
		end

		if AuctionatorSellingFrame.SaleItemFrame.Price then
			S:HandleEditBox(AuctionatorSellingFrame.SaleItemFrame.Price.MoneyInput.GoldBox)
			BORDER:CreateBorder(AuctionatorSellingFrame.SaleItemFrame.Price.MoneyInput.GoldBox, nil, nil, nil, nil, nil, true, false)

			S:HandleEditBox(AuctionatorSellingFrame.SaleItemFrame.Price.MoneyInput.SilverBox)
			BORDER:CreateBorder(AuctionatorSellingFrame.SaleItemFrame.Price.MoneyInput.SilverBox, nil, nil, nil, nil, nil, true, false)
		end

		--handle radio buttons
		if AuctionatorSellingFrame.SaleItemFrame.Duration then
			for i = 1, AuctionatorSellingFrame.SaleItemFrame.Duration:GetNumChildren() do
				local subframe = select(i, AuctionatorSellingFrame.SaleItemFrame.Duration:GetChildren())
				if subframe and subframe.RadioButton then
					S:HandleRadioButton(subframe.RadioButton)
				end
			end
		end

		if AuctionatorSellingFrame.PricesTabsContainer then
			S:HandleTab(AuctionatorSellingFrame.PricesTabsContainer.CurrentPricesTab)
			BORDER:CreateBorder(AuctionatorSellingFrame.PricesTabsContainer.CurrentPricesTab, nil, nil, nil, nil, nil, true, true)

			S:HandleTab(AuctionatorSellingFrame.PricesTabsContainer.PriceHistoryTab)
			BORDER:CreateBorder(AuctionatorSellingFrame.PricesTabsContainer.PriceHistoryTab, nil, nil, nil, nil, nil, true, true)

			S:HandleTab(AuctionatorSellingFrame.PricesTabsContainer.YourHistoryTab)
			BORDER:CreateBorder(AuctionatorSellingFrame.PricesTabsContainer.YourHistoryTab, nil, nil, nil, nil, nil, true, true)
		end
		
		if AuctionatorSellingFrame.SaleItemFrame then
			if AuctionatorSellingFrame.SaleItemFrame.MaxButton then
				S:HandleButton(AuctionatorSellingFrame.SaleItemFrame.MaxButton)
				BORDER:CreateBorder(AuctionatorSellingFrame.SaleItemFrame.MaxButton, nil, nil, nil, nil, nil, false, true)
			end

			if AuctionatorSellingFrame.HistoricalPriceInset then
				AuctionatorSellingFrame.HistoricalPriceInset:Hide()
			end

			AuctionatorSellingFrame.BagInset:Hide()
			S:HandleButton(_G.AuctionatorPostButton)
			BORDER:CreateBorder(_G.AuctionatorPostButton, nil, nil, nil, nil, nil, false, true)

			S:HandleButton(_G.AuctionatorSkipPostingButton)
			BORDER:CreateBorder(_G.AuctionatorSkipPostingButton, nil, nil, nil, nil, nil, false, true)
			
			for _, child in pairs({AuctionatorSellingFrame.SaleItemFrame:GetChildren()}) do
				if child:IsObjectType("Button") and child.Icon then
					S:HandleButton(child)
					BORDER:CreateBorder(child, nil, nil, nil, nil, nil, false, true)
				end
			end
		end

		if AuctionatorSellingFrame.BuyFrame then
			S:HandleButton(AuctionatorSellingFrame.BuyFrame.HistoryButton)
			BORDER:CreateBorder(AuctionatorSellingFrame.BuyFrame.HistoryButton, nil, nil, nil, nil, nil, false, true)

			S:HandleButton(AuctionatorSellingFrame.BuyFrame.CurrentPrices.RefreshButton)
			BORDER:CreateBorder(AuctionatorSellingFrame.BuyFrame.CurrentPrices.RefreshButton, nil, nil, nil, nil, nil, false, true)

			S:HandleButton(AuctionatorSellingFrame.BuyFrame.CurrentPrices.BuyButton)
			BORDER:CreateBorder(AuctionatorSellingFrame.BuyFrame.CurrentPrices.BuyButton, nil, nil, nil, nil, nil, false, true)

			S:HandleButton(AuctionatorSellingFrame.BuyFrame.CurrentPrices.CancelButton)
			BORDER:CreateBorder(AuctionatorSellingFrame.BuyFrame.CurrentPrices.CancelButton, nil, nil, nil, nil, nil, false, true)

			S:HandleButton(AuctionatorSellingFrame.BuyFrame.HistoryPrices.RealmHistoryButton)
			BORDER:CreateBorder(AuctionatorSellingFrame.BuyFrame.HistoryPrices.RealmHistoryButton, nil, nil, nil, nil, nil, false, true)

			S:HandleButton(AuctionatorSellingFrame.BuyFrame.HistoryPrices.PostingHistoryButton)
			BORDER:CreateBorder(AuctionatorSellingFrame.BuyFrame.HistoryPrices.PostingHistoryButton, nil, nil, nil, nil, nil, false, true)

			S:HandleEditBox(AuctionatorSellingFrame.SaleItemFrame.UnitPrice.MoneyInput.GoldBox)
			BORDER:CreateBorder(AuctionatorSellingFrame.SaleItemFrame.UnitPrice.MoneyInput.GoldBox, nil, nil, nil, nil, nil, true, false)

			S:HandleEditBox(AuctionatorSellingFrame.SaleItemFrame.UnitPrice.MoneyInput.SilverBox)
			BORDER:CreateBorder(AuctionatorSellingFrame.SaleItemFrame.UnitPrice.MoneyInput.SilverBox, nil, nil, nil, nil, nil, true, false)

			S:HandleEditBox(AuctionatorSellingFrame.SaleItemFrame.UnitPrice.MoneyInput.CopperBox)
			BORDER:CreateBorder(AuctionatorSellingFrame.SaleItemFrame.UnitPrice.MoneyInput.CopperBox, nil, nil, nil, nil, nil, true, false)

			S:HandleEditBox(AuctionatorSellingFrame.SaleItemFrame.StackPrice.MoneyInput.GoldBox)
			BORDER:CreateBorder(AuctionatorSellingFrame.SaleItemFrame.StackPrice.MoneyInput.GoldBox, nil, nil, nil, nil, nil, true, false)

			S:HandleEditBox(AuctionatorSellingFrame.SaleItemFrame.StackPrice.MoneyInput.SilverBox)
			BORDER:CreateBorder(AuctionatorSellingFrame.SaleItemFrame.StackPrice.MoneyInput.SilverBox, nil, nil, nil, nil, nil, true, false)

			S:HandleEditBox(AuctionatorSellingFrame.SaleItemFrame.StackPrice.MoneyInput.CopperBox)
			BORDER:CreateBorder(AuctionatorSellingFrame.SaleItemFrame.StackPrice.MoneyInput.CopperBox, nil, nil, nil, nil, nil, true, false)

			S:HandleEditBox(AuctionatorSellingFrame.SaleItemFrame.Stacks.NumStacks)
			BORDER:CreateBorder(AuctionatorSellingFrame.SaleItemFrame.Stacks.NumStacks, nil, nil, nil, nil, nil, true, false)

			S:HandleEditBox(AuctionatorSellingFrame.SaleItemFrame.Stacks.StackSize)
			BORDER:CreateBorder(AuctionatorSellingFrame.SaleItemFrame.Stacks.StackSize, nil, nil, nil, nil, nil, true, false)

			S:HandleTrimScrollBar(AuctionatorSellingFrame.BuyFrame.HistoryPrices.RealmHistoryResultsListing.ScrollArea.ScrollBar)
			BORDER:CreateBorder(AuctionatorSellingFrame.BuyFrame.HistoryPrices.RealmHistoryResultsListing.ScrollArea.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

			S:HandleTrimScrollBar(AuctionatorSellingFrame.BuyFrame.CurrentPrices.SearchResultsListing.ScrollArea.ScrollBar)
			BORDER:CreateBorder(AuctionatorSellingFrame.BuyFrame.CurrentPrices.SearchResultsListing.ScrollArea.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

			handlechildtab(AuctionatorSellingFrame.BuyFrame.HistoryPrices.RealmHistoryResultsListing.HeaderContainer)
			
			handlechildtab(AuctionatorSellingFrame.BuyFrame.CurrentPrices.SearchResultsListing.HeaderContainer)
			for _, v in pairs{AuctionatorSellingFrame.BuyFrame.CurrentPrices.Inset:GetChildren()} do
				if v.BorderBottomLeft then
					v:Kill()
				end
			end
			
			for _, v in pairs{AuctionatorSellingFrame.BuyFrame.HistoryPrices.Inset:GetChildren()} do
				if v.BorderBottomLeft then
					v:Kill()
				end
			end

			AuctionatorSellingFrame.BuyFrame.CurrentPrices.Inset:Hide()
			S:HandleFrame(AuctionatorSellingFrame.BuyFrame.HistoryPrices)
			BORDER:CreateBorder(AuctionatorSellingFrame.BuyFrame.HistoryPrices)

			S:HandleFrame(AuctionatorSellingFrame.BuyFrame.HistoryPrices.ResultsListing)
			BORDER:CreateBorder(AuctionatorSellingFrame.BuyFrame.HistoryPrices.ResultsListing)

			AuctionatorSellingFrame.BuyFrame.HistoryPrices.ResultsListing.Center:Hide()

			S:HandleTrimScrollBar(AuctionatorSellingFrame.BuyFrame.HistoryPrices.ResultsListing.ScrollArea.ScrollBar)
			BORDER:CreateBorder(AuctionatorSellingFrame.BuyFrame.HistoryPrices.ResultsListing.ScrollArea.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

			handlechildtab(AuctionatorSellingFrame.BuyFrame.HistoryPrices.ResultsListing.HeaderContainer)
		end

		--buying
		if E.Retail then
			local AuctionatorBuyCommodityFrame = _G.AuctionatorBuyCommodityFrame

			for _, child in pairs({AuctionatorBuyCommodityFrame:GetChildren()}) do
				if child:IsObjectType("Button") and child.Icon then
					S:HandleButton(child)
					BORDER:CreateBorder(child, nil, nil, nil, nil, nil, false, true)
				end
			end

			S:HandleButton(AuctionatorBuyCommodityFrame.BackButton)
			BORDER:CreateBorder(AuctionatorBuyCommodityFrame.BackButton, nil, nil, nil, nil, nil, false, true)

			S:HandleButton(AuctionatorBuyCommodityFrame.DetailsContainer.BuyButton)
			BORDER:CreateBorder(AuctionatorBuyCommodityFrame.DetailsContainer.BuyButton, nil, nil, nil, nil, nil, false, true)

			S:HandleEditBox(AuctionatorBuyCommodityFrame.DetailsContainer.Quantity)
			BORDER:CreateBorder(AuctionatorBuyCommodityFrame.DetailsContainer.Quantity, nil, nil, nil, nil, nil, true, false)

			S:HandleTrimScrollBar(AuctionatorBuyCommodityFrame.ResultsListing.ScrollArea.ScrollBar)
			BORDER:CreateBorder(AuctionatorBuyCommodityFrame.ResultsListing.ScrollArea.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

			AuctionatorBuyCommodityFrame.Inset:Hide()
			S:HandleFrame(AuctionatorBuyCommodityFrame.ResultsListing.ScrollArea)
			BORDER:CreateBorder(AuctionatorBuyCommodityFrame.ResultsListing.ScrollArea)

			AuctionatorBuyCommodityFrame.ResultsListing.ScrollArea:SetBackdrop()
		
			handlechildtab(AuctionatorBuyCommodityFrame.ResultsListing.HeaderContainer)

			S:HandleFrame(AuctionatorBuyCommodityFrame.FinalConfirmationDialog)
			BORDER:CreateBorder(AuctionatorBuyCommodityFrame.FinalConfirmationDialog)

			S:HandleButton(AuctionatorBuyCommodityFrame.FinalConfirmationDialog.AcceptButton)
			BORDER:CreateBorder(AuctionatorBuyCommodityFrame.FinalConfirmationDialog.AcceptButton, nil, nil, nil, nil, nil, false, true)

			S:HandleButton(AuctionatorBuyCommodityFrame.FinalConfirmationDialog.CancelButton)
			BORDER:CreateBorder(AuctionatorBuyCommodityFrame.FinalConfirmationDialog.CancelButton, nil, nil, nil, nil, nil, false, true)

			--based on simpy's skin
			if AuctionatorBuyCommodityFrame.IconAndName and not AuctionatorBuyCommodityFrame.IconAndName.backdrop then
				BORDER:HandleIcon(AuctionatorBuyCommodityFrame.IconAndName.Icon, true)

				BORDER:HandleIconBorder(AuctionatorBuyCommodityFrame.IconAndName.QualityBorder, AuctionatorBuyCommodityFrame.IconAndName.Icon.backdrop.border)
			end
		end

		--cancelling
		local AuctionatorCancellingFrame = _G.AuctionatorCancellingFrame
		S:HandleEditBox(AuctionatorCancellingFrame.SearchFilter)
		BORDER:CreateBorder(AuctionatorCancellingFrame.SearchFilter, nil, nil, nil, nil, nil, true, false)

		S:HandleTrimScrollBar(AuctionatorCancellingFrame.ResultsListing.ScrollArea.ScrollBar)
		BORDER:CreateBorder(AuctionatorCancellingFrame.ResultsListing.ScrollArea.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

		AuctionatorCancellingFrame.HistoricalPriceInset:Hide()
		handlechildtab(AuctionatorCancellingFrame.ResultsListing.HeaderContainer)

		for _, v in pairs{AuctionatorCancellingFrame:GetChildren()} do
			if v.CancelNextButton then
				S:HandleButton(v.CancelNextButton)
				BORDER:CreateBorder(v.CancelNextButton, nil, nil, nil, nil, nil, false, true)

				S:HandleButton(v.StartScanButton)
				BORDER:CreateBorder(v.StartScanButton, nil, nil, nil, nil, nil, false, true)

				v.StartScanButton:ClearAllPoints()
				v.StartScanButton:SetPoint("RIGHT", v.CancelNextButton, "LEFT", -5, 0)
			end
		end

		for _, child in pairs({AuctionatorCancellingFrame:GetChildren()}) do
			if child:IsObjectType("Button") and child.Icon then
				S:HandleButton(child)
				BORDER:CreateBorder(child, nil, nil, nil, nil, nil, false, true)
			end
		end

		--config
		local AuctionatorConfigFrame = _G.AuctionatorConfigFrame
		S:HandleFrame(AuctionatorConfigFrame)
		AuctionatorConfigFrame:SetBackdrop()
		
		S:HandleEditBox(AuctionatorConfigFrame.ContributeLink.InputBox)
		BORDER:CreateBorder(AuctionatorConfigFrame.ContributeLink.InputBox, nil, nil, nil, nil, nil, true, false)

		S:HandleEditBox(AuctionatorConfigFrame.DiscordLink.InputBox)
		BORDER:CreateBorder(AuctionatorConfigFrame.DiscordLink.InputBox, nil, nil, nil, nil, nil, true, false)

		S:HandleEditBox(AuctionatorConfigFrame.BugReportLink.InputBox)
		BORDER:CreateBorder(AuctionatorConfigFrame.BugReportLink.InputBox, nil, nil, nil, nil, nil, true, false)

		S:HandleButton(AuctionatorConfigFrame.ScanButton)
		BORDER:CreateBorder(AuctionatorConfigFrame.ScanButton, nil, nil, nil, nil, nil, false, true)

		S:HandleButton(AuctionatorConfigFrame.OptionsButton)
		BORDER:CreateBorder(AuctionatorConfigFrame.OptionsButton, nil, nil, nil, nil, nil, false, true)


		for _,v in pairs{AuctionatorConfigFrame:GetChildren()} do
			if v.BorderLeftMiddle then
				v:Hide()
			end
		end

		AuctionatorShoppingFrame:SetBackdrop()

		if E.Retail then
			S:HandleButton(_G.AuctionatorCraftingInfoObjectiveTrackerFrame.SearchButton)
			BORDER:CreateBorder(_G.AuctionatorCraftingInfoObjectiveTrackerFrame.SearchButton, nil, nil, nil, nil, nil, false, true)
		end

		_G.AuctionatorShoppingFrame.IsBorder = true
	end
end

--simple tab skin
function S:AuctionFrame()
	if not E.db.ProjectHopes.skins.auctionator then return end
	if not E.private.skins.blizzard.enable then return end
	
	S:Auctionator()
	if E.Retail then
		_G["AuctionHouseFrame"]:HookScript("OnShow",function()
			if not tabSkinned then
				E:Delay(0, function()
					S:Auctionator()
					for _, j in pairs{_G["AuctionHouseFrame"]:GetChildren()} do
						if j:GetNumChildren() >= 3 then
							for _, v in pairs{j:GetChildren()} do
								if v:IsObjectType('Button') then
									if v.tabHeader then
										S:HandleTab(v)
										if v.backdrop and not v.backdrop.border then
											BORDER:CreateBorder(v, nil, nil, nil, nil, nil, true, true)
										end
										tabSkinned = true
									end
								end
							end
						end
					end
				end)
			end
		end)
		if not InCombatLockdown then
			_G.AuctionHouseFrame:SetMovable(true)
			_G.AuctionHouseFrame:EnableMouse(true)
			_G.AuctionHouseFrame:RegisterForDrag("LeftButton")
			_G.AuctionHouseFrame:SetScript("OnDragStart", _G.AuctionHouseFrame.StartMoving)
			_G.AuctionHouseFrame:SetScript("OnDragStop", _G.AuctionHouseFrame.StopMovingOrSizing)
			_G.AuctionHouseFrame:SetClampedToScreen(true)
		end
	else
		_G["AuctionFrame"]:HookScript("OnShow",function()
			if not tabSkinned then
				E:Delay(0, function()
					S:Auctionator()
					for i = 4, 8 do
						if _G["AuctionFrameTab"..i] then
							S:HandleTab(_G["AuctionFrameTab"..i])
							if _G["AuctionFrameTab"..i].backdrop and not _G["AuctionFrameTab"..i].backdrop.border then
								BORDER:CreateBorder(_G["AuctionFrameTab"..i], nil, nil, nil, nil, nil, true, true)
							end
							tabSkinned = true
						end
					end
				end)
			end
		end)
		
		if not InCombatLockdown then
			_G.AuctionFrame:SetMovable(true)
			_G.AuctionFrame:EnableMouse(true)
			_G.AuctionFrame:RegisterForDrag("LeftButton")
			_G.AuctionFrame:SetScript("OnDragStart", _G.AuctionFrame.StartMoving)
			_G.AuctionFrame:SetScript("OnDragStop", _G.AuctionFrame.StopMovingOrSizing)
			_G.AuctionFrame:SetClampedToScreen(true)
		end
	end
end

S:AddCallbackForAddon('Blizzard_AuctionHouseUI', "AuctionFrame", S.AuctionFrame)
S:AddCallbackForAddon('Blizzard_AuctionUI', "AuctionFrame", S.AuctionFrame)
S:AddCallbackForAddon("Auctionator")