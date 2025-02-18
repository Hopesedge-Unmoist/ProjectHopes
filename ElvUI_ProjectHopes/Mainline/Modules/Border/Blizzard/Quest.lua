local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local gsub, next, strmatch, strfind = gsub, next, strmatch, strfind
local pairs, ipairs, unpack = pairs, ipairs, unpack

local GetMoney = GetMoney
local GetQuestID = GetQuestID
local CreateFrame = CreateFrame
local GetNumQuestLeaderBoards = GetNumQuestLeaderBoards
local GetQuestBackgroundMaterial = GetQuestBackgroundMaterial
local GetQuestLogLeaderBoard = GetQuestLogLeaderBoard
local hooksecurefunc = hooksecurefunc

local C_QuestLog_GetRequiredMoney = C_QuestLog.GetRequiredMoney
local C_QuestLog_GetNextWaypointText = C_QuestLog.GetNextWaypointText
local C_QuestLog_GetSelectedQuest = C_QuestLog.GetSelectedQuest
local C_QuestInfoSystem_GetQuestRewardSpells = C_QuestInfoSystem.GetQuestRewardSpells

local sealFrameTextColor = {
	['480404'] = 'c20606',
	['042c54'] = '1c86ee',
}

local function Quest_GetQuestID()
	if _G.QuestInfoFrame.questLog then
		return C_QuestLog_GetSelectedQuest()
	else
		return GetQuestID()
	end
end

local function HandleReward(frame)
	if not frame then 
		return 
	end 

	if frame.Icon then
		BORDER:HandleIcon(frame.Icon)
		if frame.IconBorder then
			frame.Icon.backdrop.border:SetBackdrop(Private.BorderLight)
			S:HandleIconBorder(frame.IconBorder, frame.Icon.backdrop.border)
		end
	end
end

function BORDER:QuestInfo_Display(parentFrame) -- self is template, not S
	local rewardsFrame = _G.QuestInfoFrame.rewardsFrame
	for i, questItem in ipairs(rewardsFrame.RewardButtons) do       
		HandleReward(questItem)
	end

	local questID = Quest_GetQuestID()
	local spellRewards = C_QuestInfoSystem_GetQuestRewardSpells(questID)
	if spellRewards and (#spellRewards > 0) then
		for spellIcon in rewardsFrame.spellRewardPool:EnumerateActive() do
			HandleReward(spellIcon)
		end
	end
	-- MajorFaction Rewards thing
	for spellIcon in rewardsFrame.reputationRewardPool:EnumerateActive() do
		HandleReward(spellIcon)
	end
end

function S:BlizzardQuestFrames()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.quest) then return end
	if not E.db.ProjectHopes.skins.quest then return end

	BORDER:CreateBorder(_G.QuestProgressScrollFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.QuestRewardScrollFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.QuestDetailScrollFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.QuestGreetingScrollFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.QuestLogPopupDetailFrameScrollFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	local QuestInfoSkillPointFrame = _G.QuestInfoSkillPointFrame
	local QuestInfoSkillPointFrameIconTexture = _G.QuestInfoSkillPointFrameIconTexture
	local QuestInfoItemHighlight = _G.QuestInfoItemHighlight

	hooksecurefunc('QuestInfo_Display', BORDER.QuestInfo_Display)

	for _, frame in pairs({'HonorFrame', 'XPFrame', 'SpellFrame', 'SkillPointFrame', 'ArtifactXPFrame', 'TitleFrame', 'WarModeBonusFrame'}) do
		HandleReward(_G.MapQuestInfoRewardsFrame[frame])
		HandleReward(_G.QuestInfoRewardsFrame[frame])
	end
	HandleReward(_G.MapQuestInfoRewardsFrame.MoneyFrame)

	--Reward: Title
	local QuestInfoPlayerTitleFrame = _G.QuestInfoPlayerTitleFrame

	--Quest Frame
	local QuestFrame = _G.QuestFrame
	BORDER:CreateBorder(QuestFrame)
	BORDER:CreateBorder(_G.QuestModelScene)
	BORDER:CreateBorder(_G.QuestModelScene.ModelTextFrame.TextBackground)

	BORDER:CreateBorder(_G.QuestFrameGreetingGoodbyeButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(_G.QuestFrameAcceptButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.QuestFrameDeclineButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.QuestFrameCompleteButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.QuestFrameGoodbyeButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.QuestFrameCompleteQuestButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(_G.QuestNPCModelTextScrollFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	local QuestLogPopupDetailFrame = _G.QuestLogPopupDetailFrame
	BORDER:CreateBorder(QuestLogPopupDetailFrame)

	BORDER:CreateBorder(_G.QuestLogPopupDetailFrameAbandonButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.QuestLogPopupDetailFrameShareButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.QuestLogPopupDetailFrameTrackButton, nil, nil, nil, nil, nil, false, true)
	
	BORDER:CreateBorder(QuestLogPopupDetailFrame.ShowMapButton, nil, nil, nil, nil, nil, false, true)

	for i = 1, 6 do
		local icon = _G['QuestProgressItem'..i..'IconTexture']

		BORDER:HandleIcon(icon, true)
	end
end

S:AddCallback('BlizzardQuestFrames')
