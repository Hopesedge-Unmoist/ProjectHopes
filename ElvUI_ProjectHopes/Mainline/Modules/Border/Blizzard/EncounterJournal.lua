local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local unpack, select = unpack, select
local ipairs, next, rad = ipairs, next, rad
local hooksecurefunc = hooksecurefunc

local GetItemQualityByID = C_Item.GetItemQualityByID
local GetItemQualityColor = C_Item.GetItemQualityColor

local lootQuality = {
	['loottab-set-itemborder-white'] = nil, -- dont show white
	['loottab-set-itemborder-green'] = 2,
	['loottab-set-itemborder-blue'] = 3,
	['loottab-set-itemborder-purple'] = 4,
	['loottab-set-itemborder-orange'] = 5,
	['loottab-set-itemborder-artifact'] = 6,
}

local function HandleButton(btn, strip, ...)
	BORDER:CreateBorder(btn, nil, nil, nil, nil, nil, false, true)
end

local function ReskinHeader(header)                
	BORDER:CreateBorder(header.button, 1, -7, nil, nil, nil, false, true)
end

local function SkinAbilitiesInfo()
	local index = 1
	local header = _G['EncounterJournalInfoHeader'..index]
	while header do
		if not header.IsBorder then
			ReskinHeader(header)
			header.IsBorder = true
		end

		index = index + 1
		header = _G['EncounterJournalInfoHeader'..index]
	end
end

local function ItemSetsItemBorder(border, atlas)
	local parent = border:GetParent()
	local backdrop = parent and parent.Icon and parent.Icon.backdrop.border
	if backdrop then
		local color = E.QualityColors[lootQuality[atlas]]
		if color then
			backdrop:SetBackdrop(Private.BorderLight)
			backdrop:SetBackdropBorderColor(color.r, color.g, color.b)
		else
			backdrop:SetBackdropBorderColor(1, 1, 1)
		end
	end
end

local function ItemSetElements(set)
	local parchment = E.private.skins.parchmentRemoverEnable
	if parchment and set.backdrop then
		set.backdrop:Hide()
	end

	if set.ItemButtons then
		for _, button in next, set.ItemButtons do
			local icon = button.Icon
			if icon and not icon.backdrop.border then
				BORDER:HandleIcon(icon)
			end

			local border = button.Border
			if border and not border.IsBorder then
				ItemSetsItemBorder(border, border:GetAtlas()) -- handle first one
				hooksecurefunc(border, 'SetAtlas', ItemSetsItemBorder)

				border.IsBorder = true
			end
		end
	end
end

local function HandleItemSetsElements(scrollBox)
	if scrollBox then
		scrollBox:ForEachFrame(ItemSetElements)
	end
end

function S:Blizzard_EncounterJournal()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.encounterjournal) then return end
	if not E.db.ProjectHopes.skins.encounterJournal then return end

	local EJ = _G.EncounterJournal

	BORDER:CreateBorder(EJ)

	if EJ.navBar.backdrop then
		EJ.navBar.backdrop:Hide()
	end 

	HandleButton(EJ.navBar.home)

	BORDER:CreateBorder(EJ.searchBox.backdrop)
	BORDER:CreateBorder(EJ.MonthlyActivitiesFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(EJ.MonthlyActivitiesFrame.FilterList.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	local InstanceSelect = EJ.instanceSelect
	BORDER:CreateBorder(InstanceSelect.ExpansionDropdown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(InstanceSelect.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	-- Bottom tabs
	for _, tab in next, {
		_G.EncounterJournalSuggestTab,
		_G.EncounterJournalDungeonTab,
		_G.EncounterJournalRaidTab,
		_G.EncounterJournalLootJournalTab,
		_G.EncounterJournalMonthlyActivitiesTab
	} do
		BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)
	end

	_G.EncounterJournalMonthlyActivitiesTab:ClearAllPoints()
	_G.EncounterJournalMonthlyActivitiesTab:Point('TOPLEFT', _G.EncounterJournal, 'BOTTOMLEFT', -3, -5)

	_G.EncounterJournalSuggestTab:ClearAllPoints()
	_G.EncounterJournalSuggestTab:Point('LEFT', _G.EncounterJournalMonthlyActivitiesTab, 'RIGHT', -5, 0)

	_G.EncounterJournalDungeonTab:ClearAllPoints()
	_G.EncounterJournalDungeonTab:Point('LEFT', _G.EncounterJournalSuggestTab, 'RIGHT', -5, 0)

	_G.EncounterJournalRaidTab:ClearAllPoints()
	_G.EncounterJournalRaidTab:Point('LEFT', _G.EncounterJournalDungeonTab, 'RIGHT', 0, 0)

	_G.EncounterJournalLootJournalTab:ClearAllPoints()
	_G.EncounterJournalLootJournalTab:Point('LEFT', _G.EncounterJournalRaidTab, 'RIGHT', 0, 0)

	--Encounter Info Frame
	local EncounterInfo = EJ.encounter.info

	-- Buttons
	BORDER:CreateBorder(EncounterInfo.difficulty, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(EncounterInfo.LootContainer.filter, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(EncounterInfo.LootContainer.slotFilter, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(EncounterInfo.BossesScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.EncounterJournalEncounterFrameInstanceFrame.LoreScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(EncounterInfo.overviewScroll.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(EncounterInfo.detailsScroll.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(EncounterInfo.LootContainer.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	-- Tabs
	if E.Retail then
		for _, name in next, { 'overviewTab', 'modelTab', 'bossTab', 'lootTab' } do
			local info = _G.EncounterJournal.encounter.info
			local tab = info[name]
			BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)

			tab:ClearAllPoints()
			if name == 'overviewTab' then
				tab:Point('TOPLEFT', _G.EncounterJournal, 'TOPRIGHT', 6, 0)
			elseif name == 'lootTab' then
				tab:Point('TOPLEFT', info.overviewTab, 'BOTTOMLEFT', 0, -6)
			elseif name == 'bossTab' then
				tab:Point('TOPLEFT', info.lootTab, 'BOTTOMLEFT', 0, -6)
			elseif name == 'modelTab' then
				tab:Point('TOPLEFT', info.bossTab, 'BOTTOMLEFT', 0, -6)

			end
		end
	end

	-- Search            
	BORDER:CreateBorder(_G.EncounterJournalSearchResults.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	-- Suggestions
	for i = 1, _G.AJ_MAX_NUM_SUGGESTIONS do
		local suggestion = EJ.suggestFrame['Suggestion'..i]
		if i == 1 then
			HandleButton(suggestion.button)
		else
			HandleButton(suggestion.centerDisplay.button)
		end
	end

	if E.private.skins.parchmentRemoverEnable then            
		local suggestFrame = EJ.suggestFrame

		-- Suggestion 1
		local suggestion = suggestFrame.Suggestion1
		BORDER:CreateBorder(suggestion)

		-- Suggestion 2 and 3
		for i = 2, 3 do
			suggestion = suggestFrame['Suggestion'..i]
			BORDER:CreateBorder(suggestion)
		end

		hooksecurefunc('EJSuggestFrame_RefreshDisplay', function()
			for i, data in ipairs(suggestFrame.suggestions) do
				local sugg = next(data) and suggestFrame['Suggestion'..i]
				if sugg then
					if not sugg.icon.backdrop.border then
						BORDER:CreateBorder(sugg.icon.backdrop)
					end
				end
			end
		end)

		hooksecurefunc('EJSuggestFrame_UpdateRewards', function(sugg)
			local rewardData = sugg.reward.data
			local icon = sugg.reward.icon.backdrop
			if rewardData then
				if not icon.IsBorder then
					BORDER:CreateBorder(icon)
					icon.border:SetBackdrop(Private.BorderLight)
					icon.IsBorder = true
				end
			
				local r, g, b = 132/255, 132/255, 132/255
				if rewardData.itemID then
					local quality = GetItemQualityByID(rewardData.itemID)
					if quality and quality > 1 then
						r, g, b = GetItemQualityColor(quality)
					end
				end

				icon.border:SetBackdropBorderColor(r, g, b)
			end
		end)
	end

	-- Suggestion Reward Tooltips
	if E.private.skins.blizzard.tooltip then
		local tooltip = _G.EncounterJournalTooltip
		local item1 = tooltip.Item1
		local item2 = tooltip.Item2
		BORDER:HandleIcon(item1.icon, true)
		BORDER:HandleIcon(item2.icon, true)
	end

	local LJ = EJ.LootJournal
	BORDER:CreateBorder(LJ.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(_G.EncounterJournalEncounterFrame)
	for _, button in next, { _G.EncounterJournalEncounterFrameInfoFilterToggle, _G.EncounterJournalEncounterFrameInfoSlotFilterToggle } do
		HandleButton(button, true)
	end

	hooksecurefunc(_G.EncounterJournal.instanceSelect.ScrollBox, 'Update', function(frame)
		for _, child in next, { frame.ScrollTarget:GetChildren() } do
			if not child.IsBorder then
				BORDER:CreateBorder(child, 1, -5, 5, 4, -5, false, true)

				child.IsBorder = true
			end
		end
	end)

	if E.private.skins.parchmentRemoverEnable then
		hooksecurefunc(_G.EncounterJournal.encounter.info.BossesScrollBox, 'Update', function(frame)
			for _, child in next, { frame.ScrollTarget:GetChildren() } do
				if not child.IsBorder then
					BORDER:CreateBorder(child, 1, -7, nil, nil, nil, false, true)
					child:HookScript("OnUpdate", function()
						for i = 1, 3 do 
							local HeaderButton = _G["EncounterJournalOverviewInfoHeader".. i .."HeaderButton"]
							if HeaderButton and not HeaderButton.isBorder then
								BORDER:CreateBorder(HeaderButton, nil, -7)

								HeaderButton.isBorder = true
							end
						end
					end)
					child.IsBorder = true
				end
			end
		end)

		hooksecurefunc(_G.EncounterJournal.encounter.info.LootContainer.ScrollBox, 'Update', function(frame)
			for _, child in next, { frame.ScrollTarget:GetChildren() } do
				if not child.IsBorder then

					if child.name and child.icon then
						BORDER:HandleIcon(child.icon, true)
						BORDER:HandleIconBorder(child.IconBorder, child.icon.backdrop.border)
						-- we only want this when name and icon both exist
						if child.backdrop then
							child.backdrop:Hide()
						end
					end

					child.IsBorder = true
				end
			end
		end)

		hooksecurefunc('EncounterJournal_ToggleHeaders', SkinAbilitiesInfo)
	end

	do -- Item Sets
		local ItemSetsFrame = EJ.LootJournalItems.ItemSetsFrame
		BORDER:CreateBorder(ItemSetsFrame)
		BORDER:CreateBorder(ItemSetsFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
		BORDER:CreateBorder(ItemSetsFrame.ClassDropdown, nil, nil, nil, nil, nil, true, true)

		hooksecurefunc(ItemSetsFrame.ScrollBox, 'Update', HandleItemSetsElements)
	end
end

S:AddCallbackForAddon('Blizzard_EncounterJournal')
