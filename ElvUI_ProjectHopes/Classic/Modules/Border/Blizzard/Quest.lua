local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local unpack, gsub = unpack, gsub
local pairs, next, strmatch = pairs, next, strmatch
local hooksecurefunc = hooksecurefunc

local GetMoney = GetMoney
local GetNumQuestLeaderBoards = GetNumQuestLeaderBoards
local GetNumQuestLogEntries = GetNumQuestLogEntries
local GetQuestItemLink = GetQuestItemLink
local GetQuestLogItemLink = GetQuestLogItemLink
local GetQuestLogLeaderBoard = GetQuestLogLeaderBoard
local GetQuestLogRequiredMoney = GetQuestLogRequiredMoney
local GetQuestLogTitle = GetQuestLogTitle
local GetQuestMoneyToGet = GetQuestMoneyToGet
local IsQuestComplete = IsQuestComplete

local GetItemQualityByID = C_Item.GetItemQualityByID
local GetItemQualityColor = C_Item.GetItemQualityColor

local MAX_NUM_ITEMS = MAX_NUM_ITEMS
local MAX_NUM_QUESTS = MAX_NUM_QUESTS
local MAX_REQUIRED_ITEMS = MAX_REQUIRED_ITEMS

local function handleItemButton(item, text, link)
	if not item then return end
	item:SetBackdrop()

	if item.Icon then
		BORDER:HandleIcon(item.Icon, true)
	end

	if item.IconBorder then
		BORDER:HandleIconBorder(item.IconBorder, item.Icon.backdrop.border)
	end

	if link then
		local quality = GetItemQualityByID(link or 0)
		if quality and quality > 1 then
			local r, g, b = GetItemQualityColor(quality)
			item.Icon.backdrop.border:SetBackdrop(Private.BorderLight)
			item.Icon.backdrop.border:SetBackdropBorderColor(r, g, b)
		end
	end
end

local function questQualityColors(frame, text, link)
	if not frame.template then
		handleItemButton(frame)
	end

	local quality = GetItemQualityByID(link or 0)
	if quality and quality > 1 then
		local r, g, b = GetItemQualityColor(quality)
		frame.border:SetBackdrop(Private.BorderLight)
		frame.border:SetBackdropBorderColor(r, g, b)
	end
end

function S:BlizzardQuestFrames()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.quest) then return end
	if not E.db.ProjectHopes.skins.quest then return end

	local QuestButtons = {
		_G.QuestFrameAcceptButton,
		_G.QuestFrameCancelButton,
		_G.QuestFrameCompleteButton,
		_G.QuestFrameCompleteQuestButton,
		_G.QuestFrameDeclineButton,
		_G.QuestFrameExitButton,
		_G.QuestFrameGoodbyeButton,
		_G.QuestFrameGreetingGoodbyeButton,
		_G.QuestFramePushQuestButton,
		_G.QuestLogFrameAbandonButton
	}
	for _, button in pairs(QuestButtons) do
		BORDER:CreateBorder(button, nil, nil, nil, nil, nil, false, true)
	end

	local ScrollBars = {
		_G.QuestDetailScrollFrameScrollBar,
		_G.QuestGreetingScrollFrameScrollBar,
		_G.QuestLogDetailScrollFrameScrollBar,
		_G.QuestLogListScrollFrameScrollBar,
		_G.QuestProgressScrollFrameScrollBar,
		_G.QuestRewardScrollFrameScrollBar
	}
	for _, object in pairs(ScrollBars) do
		BORDER:CreateBorder(object, nil, nil, nil, nil, nil, true, true)
	end

	for frame, numItems in pairs({ QuestLogItem = MAX_NUM_ITEMS, QuestProgressItem = MAX_REQUIRED_ITEMS }) do
		for i = 1, numItems do
			handleItemButton(_G[frame..i])
		end
	end

	hooksecurefunc('QuestInfo_GetRewardButton', function(rewardsFrame, index)
		local button = rewardsFrame.RewardButtons[index]
		if not button and button.template then return end

		handleItemButton(button)
	end)

	hooksecurefunc('QuestInfoItem_OnClick', function(frame)
		if frame.type == 'choice' then
			for i = 1, #_G.QuestInfoRewardsFrame.RewardButtons do
				local item = _G['QuestInfoRewardsFrameQuestInfoItem'..i]
				if item ~= frame then
					local name = _G['QuestInfoRewardsFrameQuestInfoItem'..i..'Name']
					local link = item.type and (_G.QuestInfoFrame.questLog and GetQuestLogItemLink or GetQuestItemLink)(item.type, item:GetID())

					handleItemButton(item, name, link)
				end
			end
		end
	end)

	hooksecurefunc('QuestInfo_ShowRewards', function()
		for i = 1, #_G.QuestInfoRewardsFrame.RewardButtons do
			local item = _G['QuestInfoRewardsFrameQuestInfoItem'..i]
			local name = _G['QuestInfoRewardsFrameQuestInfoItem'..i..'Name']
			local link = item.type and (_G.QuestInfoFrame.questLog and GetQuestLogItemLink or GetQuestItemLink)(item.type, item:GetID())

			handleItemButton(item, name, link)
		end
	end)

	hooksecurefunc('QuestFrameProgressItems_Update', function()
		for i = 1, _G.MAX_REQUIRED_ITEMS do
			local item = _G['QuestProgressItem'..i]
			local name = _G['QuestProgressItem'..i..'Name']
			local link = item.type and GetQuestItemLink(item.type, item:GetID())

			handleItemButton(item, name, link)
		end
	end)

	hooksecurefunc('QuestFrameItems_Update', function()
		for i = 1, _G.MAX_NUM_ITEMS do
			local item = _G['QuestLogItem'..i]
			local name = _G['QuestLogItem'..i..'Name']
			local link = item.type and (GetQuestLogItemLink or GetQuestItemLink)(item.type, item:GetID())

			handleItemButton(item, name, link)
		end
	end)

	hooksecurefunc('QuestInfo_Display', function()
		for spellIcon, _ in _G.QuestInfoFrame.rewardsFrame.spellRewardPool:EnumerateActive() do
			if not spellIcon.template then
				handleItemButton(spellIcon)
			end
		end

		for i = 1, #_G.QuestInfoRewardsFrame.RewardButtons do
			local item = _G['QuestInfoRewardsFrameQuestInfoItem'..i]
			local name = _G['QuestInfoRewardsFrameQuestInfoItem'..i..'Name']
			local link = item.type and (_G.QuestInfoFrame.questLog and GetQuestLogItemLink or GetQuestItemLink)(item.type, item:GetID())

			handleItemButton(item, name, link)
		end
	end)

	BORDER:CreateBorder(_G.QuestFrame, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(_G.QuestLogFrame, nil, nil, nil, nil, nil, true, false)
	_G.QuestLogListScrollFrame.backdrop:SetBackdrop()
	_G.QuestLogDetailScrollFrame.backdrop:SetBackdrop()
	_G.QuestDetailScrollFrame.backdrop:SetBackdrop()
	_G.QuestRewardScrollFrame.backdrop:SetBackdrop()
	_G.QuestProgressScrollFrame.backdrop:SetBackdrop()
	_G.QuestGreetingScrollFrame.backdrop:SetBackdrop()

	-- Repositions
	_G.QuestLogFrameAbandonButton:Width(108)
	_G.QuestFramePushQuestButton:Width(108)
	_G.QuestFrameExitButton:Width(108)

	_G.QuestFramePushQuestButton:ClearAllPoints()
	_G.QuestFramePushQuestButton:Point('RIGHT', _G.QuestFrameExitButton, 'LEFT', -5, 0)

	_G.QuestLogFrameAbandonButton:ClearAllPoints()
	_G.QuestLogFrameAbandonButton:Point('RIGHT', _G.QuestFramePushQuestButton, 'LEFT', -5, 0)
end

S:AddCallback('BlizzardQuestFrames')
