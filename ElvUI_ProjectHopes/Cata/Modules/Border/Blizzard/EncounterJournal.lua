local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local unpack = unpack
local select = select
local next = next
local rad = rad

local CreateFrame = CreateFrame
local hooksecurefunc = hooksecurefunc

local function HandleButton(btn, strip, ...)
	BORDER:CreateBorder(btn, nil, nil, nil, nil, nil, false, true)
end

local SkinOverviewInfo
do -- this prevents a taint trying to force a color lock by setting it to E.noop
	SkinOverviewInfo = function(frame, _, index)
		local header = frame.overviews[index]
		if not header.IsBorder then

			HandleButton(header.button)

			header.IsBorder = true
		end
	end
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

function S:Blizzard_EncounterJournal()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.encounterjournal) then return end
	if not E.db.ProjectHopes.skins.encounterJournal then return end

	local EJ = _G.EncounterJournal
	BORDER:CreateBorder(EJ)

	if EJ.navBar.backdrop then
		EJ.navBar.backdrop:Hide()
	end 

	EJ.navBar:CreateBackdrop()
	EJ.navBar.backdrop:Point('TOPLEFT', -2, 0)
	EJ.navBar.backdrop:Point('BOTTOMRIGHT')
	HandleButton(EJ.navBar.home)

	BORDER:CreateBorder(EJ.searchBox.backdrop)

	local InstanceSelect = EJ.instanceSelect
	BORDER:CreateBorder(InstanceSelect.ExpansionDropdown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(InstanceSelect.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	S:HandleDropDownBox(InstanceSelect.ExpansionDropdown)
	S:HandleTrimScrollBar(InstanceSelect.ScrollBar)

	_G.EncounterJournalEncounterFrameInfo:SetBackdrop(nil)
	-- Bottom tabs
	for _, tab in next, {
		_G.EncounterJournalDungeonTab,
		_G.EncounterJournalRaidTab,
	} do
		BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)
	end

	_G.EncounterJournalDungeonTab:ClearAllPoints()
	_G.EncounterJournalDungeonTab:Point('TOPLEFT', _G.EncounterJournal, 'BOTTOMLEFT', -10, -5)

	_G.EncounterJournalRaidTab:ClearAllPoints()
	_G.EncounterJournalRaidTab:Point('LEFT', _G.EncounterJournalDungeonTab, 'RIGHT', -14, 0)

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

	-- Search
	BORDER:CreateBorder(_G.EncounterJournalSearchResults.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	for _, button in next, { _G.EncounterJournalEncounterFrameInfoFilterToggle, _G.EncounterJournalEncounterFrameInfoSlotFilterToggle } do
		HandleButton(button)
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
					end

					if child.backdrop then
						child.backdrop:Hide()
					end
					child.IsBorder = true
				end
			end
		end)

		hooksecurefunc('EncounterJournal_SetUpOverview', SkinOverviewInfo)
		hooksecurefunc('EncounterJournal_ToggleHeaders', SkinAbilitiesInfo)
	end
end

S:AddCallbackForAddon('Blizzard_EncounterJournal')
