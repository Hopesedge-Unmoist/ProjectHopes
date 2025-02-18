local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local pairs, next = pairs, next
local hooksecurefunc = hooksecurefunc

local function ReskinQualityContainer(container)
	local button = container.Button

	BORDER:CreateBorder(button, nil, -9, 9, 9, -9)
	if button.backdrop then
		button.backdrop:Hide()
		button.IconBorder:Hide()
	end
	BORDER:HandleIconBorder(button.IconBorder, button.border)
	BORDER:CreateBorder(container.EditBox)
end

local function ReskinSlotButton(button)
	local icon = button and button.Icon
	if not icon then return end

	if not button.IsBorder then
		if icon.backdrop then
			icon.backdrop:Hide()
		end
		BORDER:CreateBorder(button, nil, -9, 9, 9, -9)
		BORDER:HandleIconBorder(button.IconBorder, button.border)
		button.IsBorder = true
	end
end

local function HandleRewardButton(button)
	if not button then return end

	BORDER:CreateBorder(button.Icon.backdrop, nil, -8, 8, 8, -7)
	BORDER:HandleIconBorder(button.IconBorder, button.Icon.backdrop.border)
end

local function HandleOutputButtons(frame)
	for _, child in next, { frame.ScrollTarget:GetChildren() } do
		if not child.IsBorder then
			BORDER:CreateBorder(child)
			
			local itemContainer = child.ItemContainer
			if itemContainer then
				local item = itemContainer.Item            
				local icon = item:GetRegions()

				BORDER:HandleIcon(icon)
				icon.backdrop.border:SetBackdrop(Private.BorderLight)
				icon.backdrop.border:SetBackdropBorderColor(itemContainer.Text:GetTextColor())
			end

			local bonus = child.CreationBonus
			if bonus then
				local item = bonus.Item
				local icon = item:GetRegions()
				BORDER:CreateBorder(icon)
			end

			child.IsBorder = true
		end

		local itemContainer = child.ItemContainer
		if itemContainer then          
			local itemBG = itemContainer.border
			if itemBG then
				if itemContainer.CritFrame:IsShown() then
					itemBG:SetBackdropBorderColor(1, .8, 0)
				else
					itemBG:SetBackdropBorderColor(0, 0, 0)
				end
			end
		end
	end
end

local function ReskinOutputLog(outputlog)
	BORDER:CreateBorder(outputlog.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(outputlog)
	hooksecurefunc(outputlog.ScrollBox, 'Update', HandleOutputButtons)
end

function S:Blizzard_Professions()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.tradeskill) then return end
	if not E.db.ProjectHopes.skins.professions then return end

	local ProfessionsFrame = _G.ProfessionsFrame
	BORDER:CreateBorder(ProfessionsFrame)

	local CraftingPage = ProfessionsFrame.CraftingPage
	BORDER:CreateBorder(CraftingPage.CreateButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(CraftingPage.CreateAllButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(CraftingPage.ViewGuildCraftersButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(CraftingPage.MinimizedSearchBox)
	BORDER:CreateBorder(CraftingPage.CreateMultipleInputBox)

	local CraftingRankBar = CraftingPage.RankBar
	BORDER:CreateBorder(CraftingRankBar.Fill.backdrop, 3)

	-- Skins Tabs.
	for _, tab in next, {_G.ProfessionsFrame.TabSystem:GetChildren()} do
		BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)
	end

	-- Reposition Tabs. 
	ProfessionsFrame.TabSystem:ClearAllPoints()
	ProfessionsFrame.TabSystem:Point('TOPLEFT', ProfessionsFrame, 'BOTTOMLEFT', -3, -4)

	for _, name in pairs({'Prof0ToolSlot', 'Prof0Gear0Slot', 'Prof0Gear1Slot', 'Prof1ToolSlot', 'Prof1Gear0Slot', 'Prof1Gear1Slot', 'CookingToolSlot', 'CookingGear0Slot', 'FishingToolSlot', 'FishingGear0Slot', 'FishingGear1Slot'}) do
		local button = CraftingPage[name]
		if button then
			BORDER:CreateBorder(button)
			BORDER:HandleIconBorder(button.IconBorder, button.border)
			if button.icon.backdrop then
				button.icon.backdrop:Hide()
				button.IconBorder:Hide()
			end
		end
	end

	local CraftList = CraftingPage.RecipeList
	if CraftList.backdrop then 
		CraftList.backdrop:Hide()
	end
	
	BORDER:CreateBorder(CraftList.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(CraftList.SearchBox)
	BORDER:CreateBorder(CraftList.FilterDropdown, nil, nil, nil, nil, nil, false, true)

	local SchematicForm = CraftingPage.SchematicForm
	SchematicForm.backdrop:Hide()

	hooksecurefunc(SchematicForm, 'Init', function(frame)
		for slot in frame.reagentSlotPool:EnumerateActive() do
			ReskinSlotButton(slot.Button)
		end

		local salvageSlot = SchematicForm.salvageSlot
		if salvageSlot then
			ReskinSlotButton(salvageSlot.Button)
		end

		local enchantSlot = SchematicForm.enchantSlot
		if enchantSlot then
			ReskinSlotButton(enchantSlot.Button)
		end
	end)

	local TrackRecipeCheckBox = SchematicForm.TrackRecipeCheckbox
	if TrackRecipeCheckBox then
		BORDER:CreateBorder(TrackRecipeCheckBox, nil, nil, nil, nil, nil, true, true)
	end

	local QualityCheckBox = SchematicForm.AllocateBestQualityCheckbox
	if QualityCheckBox then
		BORDER:CreateBorder(QualityCheckBox, nil, nil, nil, nil, nil, true, true)
	end

	local QualityDialog = SchematicForm.QualityDialog
	if QualityDialog then
		BORDER:CreateBorder(QualityDialog)
		BORDER:CreateBorder(QualityDialog.AcceptButton, nil, nil, nil, nil, nil, false, true)
		BORDER:CreateBorder(QualityDialog.CancelButton, nil, nil, nil, nil, nil, false, true)

		ReskinQualityContainer(QualityDialog.Container1)
		ReskinQualityContainer(QualityDialog.Container2)
		ReskinQualityContainer(QualityDialog.Container3)
	end

	local OutputIcon = SchematicForm.OutputIcon
	if OutputIcon then
		BORDER:CreateBorder(OutputIcon, nil, -9, 9, 9, -9)
		if OutputIcon.Icon.backdrop then
			OutputIcon.Icon.backdrop:Hide()
			OutputIcon.IconBorder:Hide()
		end
		BORDER:HandleIconBorder(OutputIcon.IconBorder, OutputIcon.border)
	end

	local SpecPage = ProfessionsFrame.SpecPage
	BORDER:CreateBorder(SpecPage.ViewTreeButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(SpecPage.UnlockTabButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(SpecPage.ApplyButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(SpecPage.ViewPreviewButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(SpecPage.BackToFullTreeButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(SpecPage.BackToPreviewButton, nil, nil, nil, nil, nil, false, true)

	hooksecurefunc(SpecPage, 'UpdateTabs', function(frame)
		for tab in frame.tabsPool:EnumerateActive() do
			if not tab.IsBorder then
				BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)
				tab.IsBorder = true
			end
		end
	end)

	local DetailedView = SpecPage.DetailedView
	BORDER:CreateBorder(DetailedView.UnlockPathButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(DetailedView.SpendPointsButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(DetailedView.UnspentPoints.Icon)

	ReskinOutputLog(CraftingPage.CraftingOutputLog)

	local Orders = ProfessionsFrame.OrdersPage
	BORDER:CreateBorder(Orders.BrowseFrame.PublicOrdersButton, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(Orders.BrowseFrame.GuildOrdersButton, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(Orders.BrowseFrame.PersonalOrdersButton, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(Orders.BrowseFrame.NpcOrdersButton, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(Orders.BrowseFrame.OrdersRemainingDisplay, nil, nil, nil, nil, nil, true)
	
	local BrowseFrame = Orders.BrowseFrame
	BORDER:CreateBorder(BrowseFrame.SearchButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(BrowseFrame.FavoritesSearchButton, nil, nil, nil, nil, nil, false, true)

	local BrowseList = Orders.BrowseFrame.RecipeList
	BrowseList.BackgroundNineSlice:Hide()

	BORDER:CreateBorder(BrowseList.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(BrowseList.SearchBox)
	BORDER:CreateBorder(BrowseList.FilterDropdown, nil, nil, nil, nil, nil, false, true)

	local OrderList = Orders.BrowseFrame.OrderList
	BORDER:CreateBorder(OrderList.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	local OrderView = Orders.OrderView

	local DeclineOrderDialog = OrderView.DeclineOrderDialog
	BORDER:CreateBorder(DeclineOrderDialog.NoteEditBox.ScrollingEditBox)
	BORDER:CreateBorder(DeclineOrderDialog.ConfirmButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(DeclineOrderDialog.CancelButton, nil, nil, nil, nil, nil, false, true)

	local OrderRankBar = OrderView.RankBar
	ReskinOutputLog(OrderView.CraftingOutputLog)

	BORDER:CreateBorder(OrderView.CreateButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(OrderView.StartRecraftButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(OrderView.CompleteOrderButton, nil, nil, nil, nil, nil, false, true)

	local OrderInfo = OrderView.OrderInfo
	OrderInfo.backdrop:Kill()
	BORDER:CreateBorder(OrderInfo.BackButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(OrderInfo.StartOrderButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(OrderInfo.DeclineOrderButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(OrderInfo.ReleaseOrderButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(OrderInfo.NoteBox)

	local RewardsFrame = OrderInfo.NPCRewardsFrame
	if RewardsFrame then
		BORDER:CreateBorder(RewardsFrame)

		HandleRewardButton(RewardsFrame.RewardItem1)
		HandleRewardButton(RewardsFrame.RewardItem2)
	end

	local OrderDetails = OrderView.OrderDetails
	BORDER:CreateBorder(OrderDetails)

	local OrderSchematicForm = OrderDetails.SchematicForm
	BORDER:CreateBorder(OrderSchematicForm.AllocateBestQualityCheckbox, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(OrderSchematicForm.TrackRecipeCheckbox, nil, nil, nil, nil, nil, true, true)

	hooksecurefunc(OrderSchematicForm, 'Init', function(frame)
		for slot in frame.reagentSlotPool:EnumerateActive() do
			ReskinSlotButton(slot.Button)
		end

		local slot = OrderSchematicForm.salvageSlot
		if slot then
			ReskinSlotButton(slot.Button)
		end
	end)

	local OrderOutputIcon = OrderSchematicForm.OutputIcon
	if OrderOutputIcon then
		BORDER:CreateBorder(OrderOutputIcon, nil, -9, 9, 9, -9)
		if OrderOutputIcon.Icon.backdrop then
			OrderOutputIcon.Icon.backdrop:Hide()
			OrderOutputIcon.IconBorder:Hide()
		end
		BORDER:HandleIconBorder(OrderOutputIcon.IconBorder, OrderOutputIcon.border)
	end

	local FulfillmentForm = OrderDetails.FulfillmentForm
	BORDER:CreateBorder(FulfillmentForm.NoteEditBox)

	local OrderItemIcon = OrderDetails.FulfillmentForm.ItemIcon
	if OrderItemIcon then
		BORDER:CreateBorder(OrderItemIcon, nil, -9, 9, 9, -9)
		if OrderItemIcon.Icon.backdrop then
			OrderItemIcon.Icon.backdrop:Hide()
			OrderItemIcon.IconBorder:Hide()
		end
		BORDER:HandleIconBorder(OrderItemIcon.IconBorder, OrderItemIcon.border)
	end
end

S:AddCallbackForAddon('Blizzard_Professions')
