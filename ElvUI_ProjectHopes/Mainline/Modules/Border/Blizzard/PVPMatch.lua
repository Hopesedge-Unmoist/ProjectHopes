local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local pairs = pairs

function S:Blizzard_PVPMatch()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.bgscore) then return end
	if not E.db.ProjectHopes.skins.bgscore then return end

    -- Macro to show the PVPMatchScoreboard: /run PVPMatchScoreboard:Show()
    local PVPMatchScoreboard = _G.PVPMatchScoreboard
    BORDER:CreateBorder(PVPMatchScoreboard)
    BORDER:CreateBorder(PVPMatchScoreboard.Content.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
            
    --Also have a look at the tabs
    local tabs = {
        PVPMatchScoreboard.Content.TabContainer.TabGroup.Tab1,
        PVPMatchScoreboard.Content.TabContainer.TabGroup.Tab2,
        PVPMatchScoreboard.Content.TabContainer.TabGroup.Tab3,
    }
            
    for _, tab in pairs(tabs) do
        BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)
    end
    
    PVPMatchScoreboard.Content.TabContainer.MatchmakingText:FontTemplate()
            
    -- Macro to show the PVPMatchResults: /run PVPMatchResults:Show()
    local PVPMatchResults = _G.PVPMatchResults   
    BORDER:CreateBorder(PVPMatchResults)
    
    BORDER:CreateBorder(PVPMatchResults.buttonContainer.leaveButton, nil, nil, nil, nil, nil, false, true)
    BORDER:CreateBorder(PVPMatchResults.buttonContainer.requeueButton, nil, nil, nil, nil, nil, false, true)
    BORDER:CreateBorder(PVPMatchResults.content.scrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
            
    local tabz = {
        PVPMatchResults.content.tabContainer.tabGroup.tab1,
        PVPMatchResults.content.tabContainer.tabGroup.tab2,
        PVPMatchResults.content.tabContainer.tabGroup.tab3,
    }
            
    for _, tab in pairs(tabz) do
        BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)
    end
end

S:AddCallbackForAddon('Blizzard_PVPMatch')
