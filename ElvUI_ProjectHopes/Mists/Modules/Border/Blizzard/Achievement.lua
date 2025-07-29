local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local pairs = pairs
local unpack = unpack
local select = select
local bitband = bit.band

local hooksecurefunc = hooksecurefunc
local IsInGuild = IsInGuild
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local GetAchievementNumCriteria = GetAchievementNumCriteria

local FLAG_PROGRESS_BAR = EVALUATION_TREE_FLAG_PROGRESS_BAR

local function skinAch(Achievement, BiggerIcon)
	if Achievement.IsBorder then return end

    BORDER:CreateBorder(Achievement, nil, nil, nil, nil, nil, true, true)
    BORDER:CreateBorder(Achievement.icon.backdrop)

	if Achievement.tracked then
		BORDER:CreateBorder(Achievement.tracked, nil, nil, nil, nil, nil, false, true)
	end

	Achievement.IsBorder = true
end

local function SkinStatusBar(bar)
    BORDER:CreateBorder(bar)
end

local function playerSaturate(frame) -- frame is Achievement.player
	local Achievement = frame:GetParent()

	local r, g, b = unpack(E.media.backdropcolor)
	Achievement.player.backdrop.callbackBackdropColor = nil
	Achievement.friend.backdrop.callbackBackdropColor = nil

	if Achievement.player.accountWide then
		r, g, b = blueAchievement.r, blueAchievement.g, blueAchievement.b
	end

	Achievement.player.backdrop:SetBackdropColor(r, g, b)
	Achievement.friend.backdrop:SetBackdropColor(r, g, b)
end

local function skinAchievementButton(button)
	if button.IsBorder then return end

	skinAch(button.player)
	skinAch(button.friend)

	hooksecurefunc(button.player, 'Saturate', playerSaturate)

	button.IsBorder = true
end

local function hookHybridScrollButtons()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.achievement) then return end

	hooksecurefunc('HybridScrollFrame_CreateButtons', function(frame, template)
		if template == 'AchievementTemplate' then
			for _, achievement in pairs(frame.buttons) do
				if not achievement.IsBorder then
					skinAch(achievement, true)
				end
			end
		elseif template == 'ComparisonTemplate' then
			for _, comparison in pairs(frame.buttons) do
				if not comparison.IsBorder then
					skinAchievementButton(comparison)
				end
			end
		end
	end)

	-- if AchievementUI was loaded by another addon before us, these buttons won't exist when Blizzard_AchievementUI is called.
	-- however, it can also be too late to hook HybridScrollFrame_CreateButtons, so we need to skin them here, weird...
	for i = 1, 20 do
		if i <= 10 then
			local achievement = _G['AchievementFrameAchievementsContainerButton'..i]
			if achievement and not achievement.IsBorder then
				skinAch(achievement, true)
			end

			local comparison = _G['AchievementFrameComparisonContainerButton'..i]
			if comparison and not comparison.IsBorder then
				skinAchievementButton(comparison)
			end
		end
	end
end

function S:Blizzard_AchievementUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.achievement) then return end
    if not E.db.ProjectHopes.skins.achievementFrame then return end

	_G.AchievementFrameStatsContainer:CreateBackdrop('Transparent')

	_G.AchievementFrameComparisonSummaryPlayer.NineSlice:SetTemplate('Transparent')
	_G.AchievementFrameComparisonSummaryFriend.NineSlice:SetTemplate('Transparent')

	SkinStatusBar(_G.AchievementFrameComparisonSummaryPlayerStatusBar)
	SkinStatusBar(_G.AchievementFrameComparisonSummaryFriendStatusBar)
	_G.AchievementFrameComparisonSummaryFriendStatusBar.text:ClearAllPoints()
	_G.AchievementFrameComparisonSummaryFriendStatusBar.text:Point('CENTER')


	local AchievementFrame = _G.AchievementFrame
	BORDER:CreateBorder(AchievementFrame.backdrop)

	-- Backdrops
	_G.AchievementFrameCategoriesContainer.backdrop:Kill()
	_G.AchievementFrameAchievementsContainer.backdrop:Kill()

    BORDER:CreateBorder(_G.AchievementFrameFilterDropdown, nil, nil, nil, nil, nil, true, true)

	-- ScrollBars
	local scrollBars = {
		_G.AchievementFrameCategoriesContainerScrollBar,
		_G.AchievementFrameAchievementsContainerScrollBar,
		_G.AchievementFrameStatsContainerScrollBar,
		_G.AchievementFrameComparisonContainerScrollBar,
		_G.AchievementFrameComparisonStatsContainerScrollBar,
	}

	for _, scrollbar in pairs(scrollBars) do
		if scrollbar then
			BORDER:CreateBorder(scrollbar, nil, nil, nil, nil, nil, true, true)
		end
	end

	-- Tabs
	for i = 1, 3 do
		BORDER:CreateBorder(_G['AchievementFrameTab'..i], nil, nil, nil, nil, nil, true, true)
	end

	-- Reposition Tabs
	_G.AchievementFrameTab1:ClearAllPoints()
	_G.AchievementFrameTab1:Point('TOPLEFT', _G.AchievementFrame, 'BOTTOMLEFT', -10, -5)
	_G.AchievementFrameTab2:Point('TOPLEFT', _G.AchievementFrameTab1, 'TOPRIGHT', -14, 0)
	_G.AchievementFrameTab3:Point('TOPLEFT', IsInGuild() and _G.AchievementFrameTab2 or _G.AchievementFrameTab1, 'TOPRIGHT', -14, 0)

	SkinStatusBar(_G.AchievementFrameSummaryCategoriesStatusBar)

	for i = 1, 8 do
		local frame = _G['AchievementFrameSummaryCategoriesCategory'..i]

		SkinStatusBar(frame)
	end

	hooksecurefunc('AchievementFrameSummary_UpdateAchievements', function()
		for i = 1, _G.ACHIEVEMENTUI_MAX_SUMMARY_ACHIEVEMENTS do
			local frame = _G['AchievementFrameSummaryAchievement'..i]
			if not frame.IsBorder then
				skinAch(frame)
			end

			--The backdrop borders tend to overlap so add a little more space between summary achievements
			local prevFrame = _G['AchievementFrameSummaryAchievement'..i-1]
			if i ~= 1 then
				frame:ClearAllPoints()
				frame:Point('TOPLEFT', prevFrame, 'BOTTOMLEFT', 0, -3)
				frame:Point('TOPRIGHT', prevFrame, 'BOTTOMRIGHT', 0, -3)
			end

		end
	end)

	for i = 1, 20 do
		if i <= 10 then
			local achievement = _G['AchievementFrameAchievementsContainerButton'..i]
			if achievement and not achievement.IsBorder then
				skinAch(achievement, true)

			end

			local comparison = _G['AchievementFrameComparisonContainerButton'..i]
			if comparison and not comparison.IsBorder then
				skinAchievementButton(comparison)
			end
		end
	end

	hooksecurefunc('AchievementButton_GetProgressBar', function(index)
		local frame = _G['AchievementFrameProgressBar'..index]
		if frame and not frame.IsBorder then
			BORDER:CreateBorder(frame)

			frame.IsBorder = true
		end
	end)
end


S:AddCallbackForAddon('Blizzard_AchievementUI')
