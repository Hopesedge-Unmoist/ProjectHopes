local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local _G = _G
local unpack = unpack

function S:Blizzard_IslandsQueueUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.islandQueue) then return end
	if not E.db.ProjectHopes.skins.islandQueue then return end

	local IslandsFrame = _G.IslandsQueueFrame
	BORDER:CreateBorder(IslandsFrame)

	local selectorFrame = IslandsFrame.DifficultySelectorFrame
	local queueButton = selectorFrame and selectorFrame.QueueButton
	if queueButton then
		BORDER:CreateBorder(queueButton, nil, nil, nil, nil, nil, false, true)
	end

	local WeeklyQuest = IslandsFrame.WeeklyQuest
	local StatusBar = WeeklyQuest.StatusBar
	WeeklyQuest.OverlayFrame:StripTextures()

	-- StatusBar
	BORDER:CreateBorder(StatusBar)

	--StatusBar Icon
	BORDER:CreateBorder(WeeklyQuest.QuestReward.Icon)

	-- Maybe Adjust me
	local TutorialFrame = IslandsFrame.TutorialFrame
	BORDER:CreateBorder(TutorialFrame.Leave, nil, nil, nil, nil, nil, false, true)
end

S:AddCallbackForAddon('Blizzard_IslandsQueueUI')
