local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc
local ipairs = ipairs
local next = next
local pairs = pairs
local tostring = tostring
local unpack = unpack

local function HandleListIcon(frame)
	if not frame.tableBuilder then
		return
	end

	for i = 1, 22 do
		local row = frame.tableBuilder.rows[i]
		if row then
			for j = 1, 5 do
				local cell = row.cells and row.cells[j]
				if cell and cell.Icon then
					if not cell.IsSkinned then
						S:HandleIcon(cell.Icon)
						BORDER:HandleIcon(cell.Icon, true)

						if cell.IconBorder then
							cell.IconBorder:Kill()
						end

						cell.IsSkinned = true
					end
				end
			end
		end
	end
end

-- modified from ElvUI Auction House Skin
local function HandleHeaders(frame)
	local maxHeaders = frame.HeaderContainer:GetNumChildren()
	for i, header in next, {frame.HeaderContainer:GetChildren()} do
		if not header.IsSkinned then
			header:DisableDrawLayer("BACKGROUND")

			BORDER:CreateBorder(header, nil, -6, 8, 6, -8)

			if not header.backdrop then
				header:CreateBackdrop("Transparent")
			end

			header.IsSkinned = true
		end

		if header.backdrop then
			header.backdrop:Point("BOTTOMRIGHT", i < maxHeaders and -5 or 0, -2)
			header.backdrop:Hide()
		end
	end

	HandleListIcon(frame)
end

local function HandleTab(tab)
	S:HandleTab(tab)
	BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)
	tab.Text:ClearAllPoints()
	tab.Text:SetPoint("CENTER", tab, "CENTER", 0, 0)
	tab.Text.__SetPoint = tab.Text.SetPoint
	tab.Text.SetPoint = E.noop
end

local function buyIconName(frame)
	S:HandleIcon(frame.Icon, true)
	BORDER:HandleIcon(frame.Icon)
	frame.Icon.backdrop.border:SetBackdrop(Private.BorderLight)

	S:HandleIconBorder(frame.QualityBorder, frame.Icon.backdrop.border)
end

local function viewGroup(frame)
	if frame.GroupTitle then
		frame.GroupTitle:StripTextures()
		
		S:HandleButton(frame.GroupTitle)
		if frame.GroupTitle.NormalTexture then
			frame.GroupTitle.NormalTexture:Hide()
		end

		BORDER:CreateBorder(frame.GroupTitle, nil, -7.5, 7, 7.5, -7, false, true)
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

	frame:GetHighlightTexture():SetTexture(E.Media.Textures.White8x8)
	frame:GetHighlightTexture():SetVertexColor(1, 1, 1, 0.3)

	frame.IconSelectedHighlight:SetTexture(E.Media.Textures.White8x8)
	frame.IconSelectedHighlight:SetVertexColor(1, 1, 1, 0.4)

	frame:GetPushedTexture():SetTexture(E.Media.Textures.White8x8)
	frame:GetPushedTexture():SetVertexColor(1, 1, 0, 0.3)


	
	
	S:HandleIcon(frame.Icon, true)
	BORDER:CreateBorder(frame.Icon.backdrop, nil, -7, 7, 7, -7)
	frame.Icon.backdrop.border:SetBackdrop(Private.BorderLight)
	S:HandleIconBorder(frame.IconBorder, frame.Icon.backdrop.border)

	--frame.Icon.backdrop.border:SetBackdropBorderColor(frame.Icon.backdrop:GetBackdropBorderColor())
end

local function configRadioButtonGroup(frame)
	for _, child in pairs(frame.radioButtons) do
		S:HandleRadioButton(child.RadioButton)
	end
end

local function configCheckbox(frame)
	S:HandleCheckBox(frame.CheckBox)
	BORDER:CreateBorder(frame.CheckBox, nil, nil, nil, nil, nil, true, true)
end

local function dropDownInternal(frame)
	S:HandleDropDownBox(frame, frame:GetWidth(), nil, true)
	BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true, true)
end

local function keyBindingConfig(frame)
	S:HandleButton(frame.Button)
	BORDER:CreateBorder(frame.Button, nil, nil, nil, nil, nil, false, true)
end

local function bagUse(frame)
	frame.View:CreateBackdrop("Transparent")
	if frame.View.backdrop then
		frame.View.backdrop:Hide()
	end
	
	S:HandleTrimScrollBar(frame.View.ScrollBar)
	BORDER:CreateBorder(frame.View.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	for _, child in pairs({frame:GetChildren()}) do
		if child ~= frame.View then
			S:HandleButton(child)
			BORDER:CreateBorder(child, nil, nil, nil, nil, nil, false, true)
		end
	end
end

local function configNumericInput(frame)
	S:HandleEditBox(frame.InputBox)
	frame.InputBox:SetTextInsets(0, 0, 0, 0)
	BORDER:CreateBorder(frame.InputBox, nil, nil, nil, nil, nil, true, true)
end

local function configMoneyInput(frame)
	S:HandleEditBox(frame.MoneyInput.CopperBox)
	S:HandleEditBox(frame.MoneyInput.GoldBox)
	S:HandleEditBox(frame.MoneyInput.SilverBox)
	BORDER:CreateBorder(frame.MoneyInput.CopperBox, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(frame.MoneyInput.GoldBox, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(frame.MoneyInput.SilverBox, nil, nil, nil, nil, nil, true, true)

	frame.MoneyInput.CopperBox:SetTextInsets(3, 0, 0, 0)
	frame.MoneyInput.GoldBox:SetTextInsets(3, 0, 0, 0)
	frame.MoneyInput.SilverBox:SetTextInsets(3, 0, 0, 0)

	frame.MoneyInput.CopperBox:SetHeight(24)
	frame.MoneyInput.GoldBox:SetHeight(24)
	frame.MoneyInput.SilverBox:SetHeight(24)

	frame.MoneyInput.CopperBox.Icon:ClearAllPoints()
	frame.MoneyInput.CopperBox.Icon:SetPoint("RIGHT", frame.MoneyInput.CopperBox, "RIGHT", -10, 0)
	frame.MoneyInput.GoldBox.Icon:ClearAllPoints()
	frame.MoneyInput.GoldBox.Icon:SetPoint("RIGHT", frame.MoneyInput.GoldBox, "RIGHT", -10, 0)
	frame.MoneyInput.SilverBox.Icon:ClearAllPoints()
	frame.MoneyInput.SilverBox.Icon:SetPoint("RIGHT", frame.MoneyInput.SilverBox, "RIGHT", -10, 0)
end

local function configMinMax(frame)
	S:HandleEditBox(frame.MinBox)
	S:HandleEditBox(frame.MaxBox)
	BORDER:CreateBorder(frame.MaxBox, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(frame.MinBox, nil, nil, nil, nil, nil, true, true)
end

local function filterKeySelector(frame)
	S:HandleDropDownBox(frame, frame:GetWidth(), nil, true)
	BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true, true)
end

local function undercutScan(frame)
	for _, child in pairs({frame:GetChildren()}) do
		if child:IsObjectType("Button") then
			S:HandleButton(child)
			BORDER:CreateBorder(child, nil, nil, nil, nil, nil, false, true)
		end
	end
	frame.StartScanButton:ClearAllPoints()
	frame.StartScanButton:SetPoint("RIGHT", AuctionatorCancelUndercutButton, "LEFT", -5, 0)
end

local function saleItem(frame)
	frame.Icon:StripTextures()

	S:HandleIcon(frame.Icon.Icon, true)
	BORDER:HandleIcon(frame.Icon.Icon)
	frame.Icon.Icon.backdrop.border:SetBackdrop(Private.BorderLight)
	S:HandleIconBorder(frame.Icon.IconBorder, frame.Icon.Icon.backdrop.border)

	if frame.MaxButton then
		S:HandleButton(frame.MaxButton)
		BORDER:CreateBorder(frame.MaxButton, nil, nil, nil, nil, nil, false, true)
		frame.MaxButton:ClearAllPoints()
		frame.MaxButton:SetPoint("TOPLEFT", frame.Quantity, "TOPRIGHT", 0, 0)
	end
	S:HandleButton(frame.PostButton)
	BORDER:CreateBorder(frame.PostButton, nil, nil, nil, nil, nil, false, true)
	S:HandleButton(frame.SkipButton)
	BORDER:CreateBorder(frame.SkipButton, nil, nil, nil, nil, nil, false, true)

	for _, child in pairs({frame:GetChildren()}) do
		if child:IsObjectType("Button") and child.Icon then
			S:HandleButton(child)
			--BORDER:CreateBorder(child, nil, nil, nil, nil, nil, false, true)
		end
	end
end

local function bottomTabButtons(frame)
	for _, details in ipairs(_G.Auctionator.Tabs.State.knownTabs) do
		local tabButtonFrameName = "AuctionatorTabs_" .. details.name
		local tabButton = _G[tabButtonFrameName]

		if tabButton and not tabButton.IsSkinned then
			S:HandleTab(tabButton, nil, "Transparent")
			BORDER:CreateBorder(tabButton, nil, nil, nil, nil, nil, true, true)
			if tabButton.Text then 
				tabButton.Text:SetWidth(tabButton:GetWidth())
				if details.tabOrder > 1 then
					local pointData = {tabButton:GetPoint(1)}
					pointData[4] = -1
					tabButton:ClearAllPoints()
					tabButton:SetPoint(unpack(pointData))
				end
			end
			tabButton.IsSkinned = true
		end
	end
end

local function sellingTabPricesContainer(frame)
	HandleTab(frame.CurrentPricesTab)
	HandleTab(frame.PriceHistoryTab)
	HandleTab(frame.YourHistoryTab)
end

local function resultsListing(frame)
	S:HandleTrimScrollBar(frame.ScrollArea.ScrollBar)
	BORDER:CreateBorder(frame.ScrollArea.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	
	HandleHeaders(frame)
	hooksecurefunc(frame, "UpdateTable", HandleHeaders)
end

local function shoppingTabFrame(frame)
	S:HandleButton(frame.NewListButton)
	S:HandleButton(frame.ImportButton)
	S:HandleButton(frame.ExportButton)
	S:HandleButton(frame.ExportCSV)
	BORDER:CreateBorder(frame.NewListButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(frame.ImportButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(frame.ExportButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(frame.ExportCSV, nil, nil, nil, nil, nil, false, true)

	frame.ImportButton:ClearAllPoints()
	frame.ImportButton:SetPoint("RIGHT", frame.ExportButton, "LEFT", -6, 0)
	frame.ShoppingResultsInset:StripTextures()
end

local function shoppingTabSearchOptions(frame)
	S:HandleEditBox(frame.SearchString)
	S:HandleButton(frame.ResetSearchStringButton)
	S:HandleButton(frame.SearchButton)
	S:HandleButton(frame.MoreButton)
	S:HandleButton(frame.AddToListButton)
	BORDER:CreateBorder(frame.SearchString, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(frame.ResetSearchStringButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(frame.SearchButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(frame.MoreButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(frame.AddToListButton, nil, nil, nil, nil, nil, false, true)

end

local function shoppingTabContainer(frame)
	frame.Inset:StripTextures()

	S:HandleTrimScrollBar(frame.ScrollBar)
	BORDER:CreateBorder(frame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
end

local function shoppingTabContainerTabs(frame)
	HandleTab(frame.ListsTab)
	HandleTab(frame.RecentsTab)

	frame.ListsTab:SetSize(10, 25)
	frame.RecentsTab:SetSize(10, 25)
end

local function sellingTab(frame)
	frame.BagInset:StripTextures()
	if frame.HistoricalPriceInset then
		frame.HistoricalPriceInset:StripTextures()
	end
end

local function cancellingFrame(frame)
	S:HandleEditBox(frame.SearchFilter)
	BORDER:CreateBorder(frame.SearchFilter, nil, nil, nil, nil, nil, true, true)

	for _, child in pairs({frame:GetChildren()}) do
		if child:IsObjectType("Button") and child.Icon then
			S:HandleButton(child)
			BORDER:CreateBorder(child, nil, nil, nil, nil, nil, false, true)
		end
	end

	frame.HistoricalPriceInset:StripTextures()
	--frame.HistoricalPriceInset:SetTemplate("Transparent")
end

local function configTab(frame)
	frame.Bg:SetTexture(nil)
	if frame.NineSlice then
		frame.NineSlice:SetTemplate("Transparent")
	end
	S:HandleButton(frame.OptionsButton)
	S:HandleButton(frame.ScanButton)
	BORDER:CreateBorder(frame.OptionsButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(frame.ScanButton, nil, nil, nil, nil, nil, false, true)

	S:HandleEditBox(frame.DiscordLink.InputBox)
	S:HandleEditBox(frame.BugReportLink.InputBox)
	BORDER:CreateBorder(frame.DiscordLink.InputBox, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(frame.BugReportLink.InputBox, nil, nil, nil, nil, nil, true, true)
end

local function shoppingItem(frame)
	frame:StripTextures()
	frame:SetTemplate("Transparent")

	local function reskinResetButton(f, anchor, x, y)
		S:HandleButton(f)
		BORDER:CreateBorder(f, nil, nil, nil, nil, nil, false, true)

		f:Size(20, 20)
		f:ClearAllPoints()
		f:SetPoint("LEFT", anchor, "RIGHT", x, y)
	end

	S:HandleEditBox(frame.SearchContainer.SearchString)
	BORDER:CreateBorder(frame.SearchContainer.SearchString, nil, nil, nil, nil, nil, true, true)

	S:HandleCheckBox(frame.SearchContainer.IsExact)
	BORDER:CreateBorder(frame.SearchContainer.IsExact, nil, nil, nil, nil, nil, true, true)

	reskinResetButton(frame.SearchContainer.ResetSearchStringButton, frame.SearchContainer.SearchString, 3, 0)
	reskinResetButton(frame.FilterKeySelector.ResetButton, frame.FilterKeySelector, 0, 3)
	reskinResetButton(frame.LevelRange.ResetButton, frame.LevelRange.MaxBox, 3, 0)
	reskinResetButton(frame.ItemLevelRange.ResetButton, frame.ItemLevelRange.MaxBox, 3, 0)
	reskinResetButton(frame.PriceRange.ResetButton, frame.PriceRange.MaxBox, 3, 0)
	reskinResetButton(frame.CraftedLevelRange.ResetButton, frame.CraftedLevelRange.MaxBox, 3, 0)
	reskinResetButton(frame.QualityContainer.ResetQualityButton, frame.QualityContainer, 200, 5)
	reskinResetButton(frame.ExpansionContainer.ResetExpansionButton, frame.ExpansionContainer, 200, 5)
	reskinResetButton(frame.TierContainer.ResetTierButton, frame.TierContainer, 200, 5)

	S:HandleButton(frame.Finished)
	S:HandleButton(frame.Cancel)
	S:HandleButton(frame.ResetAllButton)
	BORDER:CreateBorder(frame.Finished, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(frame.Cancel, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(frame.ResetAllButton, nil, nil, nil, nil, nil, false, true)
end

local function exportTextFrame(frame)
	frame:StripTextures()
	frame:SetTemplate("Transparent")
	BORDER:CreateBorder(frame)

	S:HandleButton(frame.Close)
	BORDER:CreateBorder(frame.Close, nil, nil, nil, nil, nil, false, true)

	S:HandleTrimScrollBar(frame.ScrollBar)
	BORDER:CreateBorder(frame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

end

local function listExportFrame(frame)
	frame:StripTextures()
	frame:SetTemplate("Transparent")
	BORDER:CreateBorder(frame)

	S:HandleButton(frame.SelectAll)
	S:HandleButton(frame.UnselectAll)
	S:HandleButton(frame.Export)
	S:HandleCloseButton(frame.CloseDialog)
	S:HandleTrimScrollBar(frame.ScrollBar)

	BORDER:CreateBorder(frame.SelectAll, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(frame.UnselectAll, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(frame.Export, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(frame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	frame.UnselectAll:ClearAllPoints()
	frame.UnselectAll:SetPoint("LEFT", frame.SelectAll, "RIGHT", 6, 0)
end

local function listImportFrame(frame)
	frame:StripTextures()
	frame:SetTemplate("Transparent")
	BORDER:CreateBorder(frame)

	S:HandleButton(frame.Import)
	BORDER:CreateBorder(frame.Import, nil, nil, nil, nil, nil, false, true)

	S:HandleCloseButton(frame.CloseDialog)
	S:HandleTrimScrollBar(frame.ScrollBar)
	BORDER:CreateBorder(frame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

end

local function splashFrame(frame)
	frame:StripTextures()
	frame:SetTemplate("Transparent")

	S:HandleCloseButton(frame.Close)
	S:HandleCheckBox(frame.HideCheckbox.CheckBox)
	BORDER:CreateBorder(frame.HideCheckbox.CheckBox, nil, nil, nil, nil, nil, true, true)
	S:HandleTrimScrollBar(frame.ScrollBar)
	BORDER:CreateBorder(frame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
end

local function itemHistoryFrame(frame)
	frame:StripTextures()
	frame:SetTemplate("Transparent")

	S:HandleButton(frame.Close)
	S:HandleButton(frame.Dock)
	BORDER:CreateBorder(frame.Close, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(frame.Dock, nil, nil, nil, nil, nil, false, true)
end

local function configSellingFrame(frame)
	S:HandleButton(frame.UnhideAll)
	BORDER:CreateBorder(frame.UnhideAll, nil, nil, nil, nil, nil, false, true)
end

local function craftingInfoObjectiveTrackerFrame(frame)
	S:HandleButton(frame.SearchButton)
	BORDER:CreateBorder(frame.SearchButton, nil, nil, nil, nil, nil, false, true)
end

local function craftingInfoProfessionsFrame(frame)
	S:HandleButton(frame.SearchButton)
	BORDER:CreateBorder(frame.SearchButton, nil, nil, nil, nil, nil, false, true)
end

local function buyCommodity(frame)
	S:HandleButton(frame.BackButton)
	BORDER:CreateBorder(frame.BackButton, nil, nil, nil, nil, nil, false, true)
	frame:StripTextures()

	local container = frame.DetailsContainer
	if not container then
		return
	end

	S:HandleButton(container.BuyButton)
	BORDER:CreateBorder(container.BuyButton, nil, nil, nil, nil, nil, false, true)
	S:HandleEditBox(container.Quantity)
	BORDER:CreateBorder(container.Quantity, nil, nil, nil, nil, nil, true, true)
	container.Quantity:SetTextInsets(0, 0, 0, 0)

	for _, child in pairs({frame:GetChildren()}) do
		if child:IsObjectType("Button") and child.iconAtlas and child.iconAtlas == "UI-RefreshButton" then
			S:HandleButton(child)
			BORDER:CreateBorder(child, nil, nil, nil, nil, nil, false, true)
			break
		end
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

	-- widgets
	tryPostHook("AuctionatorBuyIconNameTemplateMixin", "SetItem", buyIconName)
	tryPostHook("AuctionatorGroupsViewGroupMixin", "SetName", viewGroup)
	tryPostHook("AuctionatorGroupsViewItemMixin", "SetItemInfo", viewItem)
	tryPostHook("AuctionatorConfigCheckboxMixin", "OnLoad", configCheckbox)
	tryPostHook("AuctionatorConfigHorizontalRadioButtonGroupMixin", "SetupRadioButtons", configRadioButtonGroup)
	tryPostHook("AuctionatorConfigMinMaxMixin", "OnLoad", configMinMax)
	tryPostHook("AuctionatorConfigMoneyInputMixin", "OnLoad", configMoneyInput)
	tryPostHook("AuctionatorConfigNumericInputMixin", "OnLoad", configNumericInput)
	tryPostHook("AuctionatorConfigRadioButtonGroupMixin", "SetupRadioButtons", configRadioButtonGroup)
	tryPostHook("AuctionatorDropDownInternalMixin", "Initialize", dropDownInternal)
	tryPostHook("AuctionatorFilterKeySelectorMixin", "OnLoad", filterKeySelector)
	tryPostHook("AuctionatorKeyBindingConfigMixin", "OnLoad", keyBindingConfig)
	tryPostHook("AuctionatorResultsListingMixin", "OnShow", resultsListing)
	tryPostHook("AuctionatorSaleItemMixin", "OnLoad", saleItem)
	tryPostHook("AuctionatorShoppingTabFrameMixin", "OnLoad", shoppingTabFrame)
	tryPostHook("AuctionatorShoppingTabSearchOptionsMixin", "OnLoad", shoppingTabSearchOptions)
	tryPostHook("AuctionatorShoppingTabListsContainerMixin", "OnLoad", shoppingTabContainer)
	tryPostHook("AuctionatorShoppingTabRecentsContainerMixin", "OnLoad", shoppingTabContainer)
	tryPostHook("AuctionatorShoppingTabContainerTabsMixin", "OnLoad", shoppingTabContainerTabs)
	tryPostHook("AuctionatorBagUseMixin", "OnLoad", bagUse)
	tryPostHook("AuctionatorSellingTabPricesContainerMixin", "OnLoad", sellingTabPricesContainer)
	tryPostHook("AuctionatorTabContainerMixin", "OnLoad", bottomTabButtons)
	tryPostHook("AuctionatorUndercutScanMixin", "OnLoad", undercutScan)

	-- tab frames
	tryPostHook("AuctionatorCancellingFrameMixin", "OnLoad", cancellingFrame)
	tryPostHook("AuctionatorConfigTabMixin", "OnLoad", configTab)
	tryPostHook("AuctionatorSellingTabMixin", "OnLoad", sellingTab)

	-- frames
	tryPostHook("AuctionatorConfigSellingFrameMixin", "OnLoad", configSellingFrame)
	tryPostHook("AuctionatorExportTextFrameMixin", "OnLoad", exportTextFrame)
	tryPostHook("AuctionatorListExportFrameMixin", "OnLoad", listExportFrame)
	tryPostHook("AuctionatorListImportFrameMixin", "OnLoad", listImportFrame)
	tryPostHook("AuctionatorItemHistoryFrameMixin", "Init", itemHistoryFrame)
	tryPostHook("AuctionatorCraftingInfoObjectiveTrackerFrameMixin", "OnLoad", craftingInfoObjectiveTrackerFrame)
	tryPostHook("AuctionatorCraftingInfoProfessionsFrameMixin", "OnLoad", craftingInfoProfessionsFrame)
	tryPostHook("AuctionatorShoppingItemMixin", "OnLoad", shoppingItem)
	tryPostHook("AuctionatorSplashScreenMixin", "OnLoad", splashFrame)
	tryPostHook("AuctionatorBuyCommodityFrameTemplateMixin", "OnLoad", buyCommodity)
end

S:AddCallbackForAddon("Auctionator")
