local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next, pairs = next, pairs
local gsub, strmatch, unpack = gsub, strmatch, unpack
local hooksecurefunc = hooksecurefunc

local GetQuestItemLink = GetQuestItemLink
local GetQuestLogItemLink = GetQuestLogItemLink

local MAX_NUM_ITEMS = MAX_NUM_ITEMS
local MAX_REQUIRED_ITEMS = MAX_REQUIRED_ITEMS

local function handleItemButton(item)
	if not item then return end

	if item.Icon then
		BORDER:HandleIcon(item.Icon)
	end

	if item.IconBorder then
		BORDER:HandleIconBorder(item.IconBorder, item.Icon.border)
	end
end

local function questQualityColors(frame, text, link)
	if not frame.template then
		handleItemButton(frame)
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
		_G.QuestFrameGoodbyeButton,
		_G.QuestFrameGreetingGoodbyeButton,
		_G.QuestFramePushQuestButton,
		_G.QuestLogFrameAbandonButton,
		_G.QuestLogFrameTrackButton,
		_G.QuestLogFrameCancelButton
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

	_G.QuestModelScene:StripTextures()
	_G.QuestModelScene:SetTemplate('Transparent')

	S:HandleScrollBar(_G.QuestNPCModelTextScrollFrame.ScrollBar)

	hooksecurefunc('QuestInfo_GetRewardButton', function(rewardsFrame, index)
		local button = rewardsFrame.RewardButtons[index]
		if not button and button.template then return end

		handleItemButton(button)
	end)

	hooksecurefunc('QuestInfoItem_OnClick', function(frame)
		if frame.type == 'choice' then
			frame:SetBackdropBorderColor(1, 0.80, 0.10)

			for i = 1, #_G.QuestInfoRewardsFrame.RewardButtons do
				local item = _G['QuestInfoRewardsFrameQuestInfoItem'..i]

				if item ~= frame then
					local name = _G['QuestInfoRewardsFrameQuestInfoItem'..i..'Name']
					local link = item.type and (_G.QuestInfoFrame.questLog and GetQuestLogItemLink or GetQuestItemLink)(item.type, item:GetID())

					questQualityColors(item, name, link)
				end
			end
		end
	end)

	hooksecurefunc('QuestInfo_ShowRewards', function()
		for i = 1, #_G.QuestInfoRewardsFrame.RewardButtons do
			local item = _G['QuestInfoRewardsFrameQuestInfoItem'..i]
			local name = _G['QuestInfoRewardsFrameQuestInfoItem'..i..'Name']
			local link = item.type and (_G.QuestInfoFrame.questLog and GetQuestLogItemLink or GetQuestItemLink)(item.type, item:GetID())

			questQualityColors(item, name, link)
		end
	end)


	hooksecurefunc('QuestFrameProgressItems_Update', function()
		for i = 1, _G.MAX_REQUIRED_ITEMS do
			local item = _G['QuestProgressItem'..i]
			local name = _G['QuestProgressItem'..i..'Name']
			local link = item.type and GetQuestItemLink(item.type, item:GetID())

			questQualityColors(item, name, link)
		end
	end)


	hooksecurefunc('QuestLogUpdateQuestCount', function()
		_G.QuestLogCount:ClearAllPoints()
		_G.QuestLogCount:Point('BOTTOMLEFT', _G.QuestLogListScrollFrame.backdrop, 'TOPLEFT', 0, 5)
	end)

	local textR, textG, textB = 1, 1, 1
	local titleR, titleG, titleB = 1, 0.80, 0.10
	hooksecurefunc('QuestFrameItems_Update', function()
		for i = 1, _G.MAX_NUM_ITEMS do
			local item = _G['QuestLogItem'..i]
			local name = _G['QuestLogItem'..i..'Name']
			local link = item.type and (GetQuestLogItemLink or GetQuestItemLink)(item.type, item:GetID())

			questQualityColors(item, name, link)
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

			questQualityColors(item, name, link)
		end
	end)

	local QuestLogDetailFrame = _G.QuestLogDetailFrame
	BORDER:CreateBorder(QuestLogDetailFrame, nil, nil, nil, nil, nil, true, false)

	BORDER:CreateBorder(_G.QuestFrame)
	BORDER:CreateBorder(_G.QuestLogCount)
	BORDER:CreateBorder(_G.QuestLogFrame)

	BORDER:CreateBorder(_G.QuestLogListScrollFrame, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(_G.QuestLogDetailScrollFrame, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(_G.QuestDetailScrollFrame, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(_G.QuestRewardScrollFrame, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(_G.QuestProgressScrollFrame, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(_G.QuestGreetingScrollFrame, nil, nil, nil, nil, nil, true, false)

end

S:AddCallback('BlizzardQuestFrames')
