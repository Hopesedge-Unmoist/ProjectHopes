local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next = next
local hooksecurefunc = hooksecurefunc
local CreateFrame = CreateFrame

local function HandleListIcon(frame)
	local builder = frame.tableBuilder
	if not builder then return end

	for i = 1, 22 do
		local row = builder.rows[i]
		if row then
			local cell = row.cells and row.cells[1]
			if cell and cell.Icon then
				if not cell.IsBorder then
					BORDER:HandleIcon(cell.Icon)

					cell.IsBorder = true
				end

				cell.Icon.backdrop:SetShown(cell.Icon:IsShown())
			end
		end
	end
end

local function HandleListHeader(headerContainer)
	local maxHeaders = headerContainer:GetNumChildren()
	for i, header in next, { headerContainer:GetChildren() } do
		if not header.IsBorder then
			BORDER:CreateBorder(header, nil, -7, 7, 7, -7, true, true)

			header.IsBorder = true
		end
	end
end

local function HandleMoneyInput(box)
	BORDER:CreateBorder(box, nil, nil, nil, nil, nil, true, true)
end

local function HandleBrowseOrders(frame)
	local headerContainer = frame.RecipeList and frame.RecipeList.HeaderContainer
	if headerContainer then
		HandleListHeader(headerContainer)
	end
end

local function RefreshFlyoutButtons(box)
	for _, button in next, { box.ScrollTarget:GetChildren() } do
		if button.IconBorder and not button.IsBorder then
			BORDER:HandleIcon(button.icon)
			BORDER:HandleIconBorder(button.IconBorder, button.icon.backdrop.border)
				
			button.IsBorder = true
		end
	end
end

local function HandleFlyouts(flyout)
	if not flyout.IsBorder then

		BORDER:CreateBorder(flyout.HideUnownedCheckBox, nil, nil, nil, nil, nil, true, true)

		hooksecurefunc(flyout.ScrollBox, 'Update', RefreshFlyoutButtons)

		flyout.IsBorder = true
	end
end

local flyoutFrame
local function OpenItemFlyout(frame)
	if flyoutFrame then return end

	for _, child in next, { frame:GetChildren() } do
		if child.HideUnownedCheckBox then
			flyoutFrame = child

			HandleFlyouts(flyoutFrame)

			break
		end
	end
end

local function FormInit(form)
	for slot in form.reagentSlotPool:EnumerateActive() do
		local button = slot and slot.Button
		local icon = button and button.Icon
		if icon then
			if not button.IsBorder then
				BORDER:CreateBorder(icon.backdrop, nil, -8, 7, 8, -7)
				icon.backdrop.border:SetBackdrop(Private.BorderLight)
				S:HandleIconBorder(button.IconBorder, icon.backdrop.border)

				if slot.Checkbox then
					BORDER:CreateBorder(slot.Checkbox, nil, nil, nil, nil, nil, true, true)
				end

				button.IsBorder = true
			end
		end
	end
end

local function HandleInputBox(box)
	BORDER:CreateBorder(box, nil, nil, nil, nil, nil, true, false)
end

local function ReskinQualityContainer(container)
	local button = container.Button
	BORDER:HandleIcon(button.Icon)
	BORDER:HandleIconBorder(button.IconBorder, button.Icon.backdrop.border)
	HandleInputBox(container.EditBox)
end

local function HandleTabs(frame)
	local lastTab               
	for index, tab in next, frame.Tabs do
		tab:ClearAllPoints()

		if index == 1 then
			tab:Point('TOPLEFT', frame, 'BOTTOMLEFT', -3, -5)
		else
			tab:Point('TOPLEFT', lastTab, 'TOPRIGHT', 0, 0)
		end

		lastTab = tab

		BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)
	end
end

function S:Blizzard_ProfessionsCustomerOrders()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.tradeskill) then return end
	if not E.db.ProjectHopes.skins.professionsCustomerOrders then return end

	local frame = _G.ProfessionsCustomerOrdersFrame
	if frame then
		BORDER:CreateBorder(frame)
	
		HandleTabs(frame)
	
		-- Item flyout
		if _G.OpenProfessionsItemFlyout then
			hooksecurefunc('OpenProfessionsItemFlyout', OpenItemFlyout)
		end
	
		local browseOrders = frame.BrowseOrders
		BORDER:CreateBorder(browseOrders.CategoryList.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
		browseOrders.CategoryList.backdrop:Kill()

		local search = browseOrders.SearchBar
		BORDER:CreateBorder(search.FavoritesSearchButton, nil, nil, nil, nil, nil, false, true)
		BORDER:CreateBorder(search.SearchBox, nil, nil, nil, nil, nil, false, true)
		BORDER:CreateBorder(search.SearchButton, nil, nil, nil, nil, nil, false, true)
	
		local filter = search.FilterDropdown
		BORDER:CreateBorder(filter, nil, nil, nil, nil, nil, false, true)
			
		local recipeList = frame.BrowseOrders.RecipeList
		recipeList.ScrollBox.backdrop:Kill()
		BORDER:CreateBorder(recipeList.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	
		hooksecurefunc(frame.BrowseOrders, 'SetupTable', HandleBrowseOrders)
		hooksecurefunc(frame.BrowseOrders, 'StartSearch', HandleListIcon)
	
		-- Form
		local form = frame.Form
		form.RecipeHeader.backdrop:Kill()

		BORDER:CreateBorder(form.BackButton, nil, nil, nil, nil, nil, false, true)
		BORDER:CreateBorder(form.TrackRecipeCheckbox.Checkbox, nil, nil, nil, nil, nil, true, true)
		BORDER:CreateBorder(form.AllocateBestQualityCheckbox, nil, nil, nil, nil, nil, true, true)
		form.LeftPanelBackground:Hide()
		form.RightPanelBackground:Hide()
	
		local itemButton = form.OutputIcon
		BORDER:HandleIcon(itemButton.Icon)
		BORDER:HandleIconBorder(itemButton.IconBorder, itemButton.Icon.backdrop.border)
	
		BORDER:CreateBorder(form.OrderRecipientTarget, nil, nil, nil, nil, nil, true, false)
	
		local payment = form.PaymentContainer
		if payment then
			BORDER:CreateBorder(payment.NoteEditBox.backdrop)
	
			  if payment.CancelOrderButton then
				BORDER:CreateBorder(payment.CancelOrderButton, nil, nil, nil, nil, nil, false, true)
			end
		end

		BORDER:CreateBorder(form.MinimumQuality.Dropdown, nil, nil, nil, nil, nil, true, true)
		BORDER:CreateBorder(form.OrderRecipientDropdown, nil, nil, nil, nil, nil, true, true)
		BORDER:CreateBorder(payment.TipMoneyInputFrame.GoldBox, nil, nil, nil, nil, nil, true, true)
		BORDER:CreateBorder(payment.TipMoneyInputFrame.SilverBox, nil, nil, nil, nil, nil, true, true)
		BORDER:CreateBorder(payment.DurationDropdown, nil, nil, nil, nil, nil, true, true)
		BORDER:CreateBorder(payment.ListOrderButton, nil, nil, nil, nil, nil, false, true)
						
		local currentListings = form.CurrentListings
		if currentListings then
			BORDER:CreateBorder(currentListings.CloseButton, nil, nil, nil, nil, nil, false, true)
			BORDER:CreateBorder(currentListings.OrderList.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
			HandleListHeader(currentListings.OrderList.HeaderContainer)
		end
	
		local qualityDialog = form.QualityDialog
		if qualityDialog then
			BORDER:CreateBorder(qualityDialog.AcceptButton, nil, nil, nil, nil, nil, false, true)
			BORDER:CreateBorder(qualityDialog.CancelButton, nil, nil, nil, nil, nil, false, true)
		
			ReskinQualityContainer(qualityDialog.Container1)
			ReskinQualityContainer(qualityDialog.Container2)
			ReskinQualityContainer(qualityDialog.Container3)
		end
	
		hooksecurefunc(form, 'Init', FormInit)
	
		-- Orders
		frame.MyOrdersPage.OrderList.backdrop:Hide()
	
		BORDER:CreateBorder(frame.MyOrdersPage.RefreshButton, nil, nil, nil, nil, nil, false, true)
		HandleListHeader(frame.MyOrdersPage.OrderList.HeaderContainer)
		BORDER:CreateBorder(frame.MyOrdersPage.OrderList.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	end
end

S:AddCallbackForAddon('Blizzard_ProfessionsCustomerOrders')
