local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next = next
local unpack = unpack

local CreateColor = CreateColor
local hooksecurefunc = hooksecurefunc

local function StyleSearchButton(button)
    if not button then return end

    BORDER:CreateBorder(button, nil, nil, nil, nil, nil, true, true)
end

local function UpdateDisplayObjectives(frame)
    local objectives = frame:GetObjectiveFrame()
    if objectives and objectives.progressBars then
        for _, bar in next, objectives.progressBars do
            if not bar.IsBorder then
                BORDER:CreateBorder(bar)
                bar.IsBorder = true
            end
        end
    end
end 

function S:Blizzard_AchievementUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.achievement) then return end
    if not E.db.ProjectHopes.skins.achievementFrame then return end
    
    local AchievementFrame = _G.AchievementFrame
    BORDER:CreateBorder(AchievementFrame)

    BORDER:CreateBorder(AchievementFrame.SearchBox)
    AchievementFrame.SearchBox:ClearAllPoints()
    AchievementFrame.SearchBox:Point('TOPRIGHT', AchievementFrame, 'TOPRIGHT', -25, -5)
    AchievementFrame.SearchBox:Point('BOTTOMLEFT', AchievementFrame, 'TOPRIGHT', -130, -20)

    BORDER:CreateBorder(_G.AchievementFrameFilterDropdown, nil, nil, nil, nil, nil, false, true)
    _G.AchievementFrameFilterDropdown:Size(112, 16)
    _G.AchievementFrameFilterDropdown:ClearAllPoints()
    _G.AchievementFrameFilterDropdown:Point('RIGHT', AchievementFrame.SearchBox, 'LEFT', -5, 0)

    -- Bottom Tabs
    for i = 1, 3 do
        local tab = _G['AchievementFrameTab'..i]
        BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)
        tab:ClearAllPoints()
    end

    -- Reposition Tabs
    _G.AchievementFrameTab1:Point('TOPLEFT', _G.AchievementFrame, 'BOTTOMLEFT', -3, -5)
    _G.AchievementFrameTab2:Point('TOPLEFT', _G.AchievementFrameTab1, 'TOPRIGHT', 0, 0)
    _G.AchievementFrameTab3:Point('TOPLEFT', _G.AchievementFrameTab2, 'TOPRIGHT', 0, 0)

    local PreviewContainer = AchievementFrame.SearchPreviewContainer
    local ShowAllSearchResults = PreviewContainer.ShowAllSearchResults
    BORDER:CreateBorder(PreviewContainer.backdrop)
    PreviewContainer:ClearAllPoints()
    PreviewContainer:Point('TOPLEFT', AchievementFrame, 'TOPRIGHT', 9, -3)

    if not PreviewContainer.backdrop then
        E:Delay(0.1, function()
            PreviewContainer.backdrop:Point('BOTTOMRIGHT', ShowAllSearchResults, 5, -8)
        end)
    else
        PreviewContainer.backdrop:Point('BOTTOMRIGHT', ShowAllSearchResults, 5, -8)
    end

    ShowAllSearchResults:Point('TOP', nil, 'BOTTOM', 0, -138)

    for i = 1, 5 do
        StyleSearchButton(PreviewContainer['SearchPreview'..i])
    end
    StyleSearchButton(ShowAllSearchResults)

    do 
        local i = 1
        local tab, prev = PreviewContainer['SearchPreview'..i]
        while tab do
            tab:ClearAllPoints()
    
            if prev then -- Reposition Tabs
                tab:Point('TOPLEFT', prev, 'BOTTOMLEFT', 0, -5)
            else
                tab:Point('TOPLEFT', PreviewContainer, 'TOPLEFT', 3, -5)
            end
    
            prev = tab
    
            i = i + 1
            tab = PreviewContainer['SearchPreview'..i]
        end
    end

    local Result = AchievementFrame.SearchResults
    Result:Point('BOTTOMLEFT', AchievementFrame, 'BOTTOMRIGHT', 15, -1)
    BORDER:CreateBorder(Result, nil, nil, nil, nil, nil, true)
    BORDER:CreateBorder(Result.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

    hooksecurefunc(Result.ScrollBox, 'Update', function(frame)
        for _, child in next, { frame.ScrollTarget:GetChildren() } do
            if not child.IsBorder then
                BORDER:CreateBorder(child, nil, -7, 7, 7, -7, true, true)

                child.IsBorder = true
            end
        end
    end)

    BORDER:CreateBorder(_G.AchievementFrameCategories.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
    BORDER:CreateBorder(_G.AchievementFrameAchievements.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

    hooksecurefunc('AchievementFrameSummary_UpdateAchievements', function()
        for i = 1, _G.ACHIEVEMENTUI_MAX_SUMMARY_ACHIEVEMENTS do
            local buSummary = _G['AchievementFrameSummaryAchievement'..i]
            if buSummary and not buSummary.border then
                BORDER:CreateBorder(buSummary, nil, -4, 4, 4, -4, false, true)
            end

            if buSummary and not buSummary.Icon.borderFrame then
                buSummary.Icon:Size(45)
                buSummary.Icon:ClearAllPoints()
                buSummary.Icon:Point('LEFT', buSummary.backdrop, 'LEFT', 0, -3)
    
                buSummary.Icon.borderFrame = CreateFrame("Frame", nil, buSummary.Icon, "BackdropTemplate")
                buSummary.Icon.borderFrame:SetPoint("TOPLEFT", buSummary.Icon, "TOPLEFT", -4, 6)
                buSummary.Icon.borderFrame:SetPoint("BOTTOMRIGHT", buSummary.Icon, "BOTTOMRIGHT", 4, 0)
                buSummary.Icon.borderFrame:SetBackdrop(Private.Border)
                buSummary.Icon.borderFrame:SetFrameLevel(buSummary.Icon:GetFrameLevel() + 1)
            end
        end
    end)

    for i = 1, 12 do
        local name = 'AchievementFrameSummaryCategoriesCategory'..i

        local bu = _G[name]
        BORDER:CreateBorder(bu, nil, nil, nil, nil, nil, true)
    end

    hooksecurefunc(_G.AchievementFrameAchievements.ScrollBox, 'Update', function(frame)
        for _, child in next, { frame.ScrollTarget:GetChildren() } do
            if not child.IsBorder then
                BORDER:CreateBorder(child, nil, -6, 6, 6, -6, false, true)
                child.backdrop:Hide()
                BORDER:CreateBorder(child.Icon.texture.backdrop)

                BORDER:CreateBorder(child.Tracked, nil, nil, nil, nil, nil, true, true)
                child.Tracked:SetScale(1)
                child.Tracked:Size(24)

                child.Tracked:ClearAllPoints()
                child.Tracked:Point('TOPLEFT', child.Icon, 'TOPRIGHT', -3, 2)

                hooksecurefunc(child, 'DisplayObjectives', UpdateDisplayObjectives)

                child.IsBorder = true
            end
        end
    end)

    hooksecurefunc(_G.AchievementFrameCategories.ScrollBox, 'Update', function(frame)
        for _, child in next, { frame.ScrollTarget:GetChildren() } do
            local button = child.Button
            if button and not button.IsBorder then
                BORDER:CreateBorder(button, nil, -6, 6, 6, -6, false, true)

                button.IsBorder = true
            end
        end
    end)

    BORDER:CreateBorder(_G.AchievementFrameSummaryCategoriesStatusBar)
    BORDER:CreateBorder(_G.AchievementFrameStats.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
    hooksecurefunc(_G.AchievementFrameStats.ScrollBox, 'Update', function(frame)
        for _, child in next, { frame.ScrollTarget:GetChildren() } do
            if not child.IsBorder then
                BORDER:CreateBorder(child, nil, -6, 6, 6, -6, false, true)
                child.backdrop:Hide()

                child.IsBorder = true
            end
        end
    end)

       -- Comparison
    local Comparison = _G.AchievementFrameComparison
    hooksecurefunc(Comparison.AchievementContainer.ScrollBox, 'Update', function(frame)
        for _, child in next, { frame.ScrollTarget:GetChildren() } do
            if not child.IsBorder then
                BORDER:CreateBorder(child.Player, nil, -6, 6, 6, -6, false, true)
                BORDER:CreateBorder(child.Friend, nil, -6, 6, 6, -6, false, true)
                
                child.Player.backdrop:Hide()
                child.Friend.backdrop:Hide()

                BORDER:CreateBorder(child.Player.Icon.texture, nil, -2, 5, 2, 0)
                BORDER:CreateBorder(child.Friend.Icon.texture, nil, -2, 5, 2, 0)

                child.IsBorder = true
            end
        end
    end)

    hooksecurefunc(Comparison.StatContainer.ScrollBox, 'Update', function(frame)
        for _, child in next, { frame.ScrollTarget:GetChildren() } do
            if not child.IsBorder then
                BORDER:CreateBorder(child, nil, -6, 6, 6, -6, false, true)
                child.backdrop:Hide()

                child.IsBorder = true
            end
        end
    end)

    BORDER:CreateBorder(Comparison.AchievementContainer.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
   
    _G.AchievementFrameComparisonHeader:Point('BOTTOMRIGHT', Comparison, 'TOPRIGHT', 50, 30)
    BORDER:CreateBorder(_G.AchievementFrameComparisonHeader, nil, nil, nil, nil, nil, true)

    BORDER:CreateBorder(Comparison.Summary.Player.StatusBar)
    BORDER:CreateBorder(Comparison.Summary.Friend.StatusBar)

    BORDER:CreateBorder(Comparison.StatContainer.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

end

S:AddCallbackForAddon('Blizzard_AchievementUI')