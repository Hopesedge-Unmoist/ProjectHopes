local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local UF = E:GetModule("UnitFrames")
local GetTime = GetTime

local function BorderAndSeparator(f)
    if f then
        if f.POWERBAR_DETACHED or f.USE_POWERBAR_OFFSET then
            if f.border then
                f.border:Hide()
            end

            BORDER:CreateBorder(f.Health.backdrop)
        else
            if f.Health.border then
                f.Health.border:Hide()
            end

            BORDER:CreateBorder(f, 15)
        end

        if f.USE_POWERBAR and (f.border or f.Health.backdrop.border) then
            local border = f.Power.border
            local separator = f.Power.separator
            if f.POWERBAR_DETACHED or f.USE_POWERBAR_OFFSET then
                if not border then
                    BORDER:CreateBorder(f.Power.backdrop)
                else
                    border:Show()
                end
                if separator then
                    separator:Hide()
                end
            else
                if not separator then
                    BORDER:CreateSeparator(f.Power)
                else
                    separator:Show()
                end
                if border then
                    border:Hide()
                end
            end
        end
    end
end


function S:ElvUI_UnitFrames(_, unit)
    local frameName = gsub(E:StringTitle(unit), 't(arget)', 'T%1')
    local enabled = UF.db.units[unit].enable

    local config = E.db.ProjectHopes and E.db.ProjectHopes.border
    if not config then return end

    local f = UF[unit]
    if not f then return end

    if frameName == 'Player' and enabled and config.Player then
        BorderAndSeparator(f)
        if config.Playersep and f.Power and f.Power.separator then
            f.Power.separator:Show()
            f.Power.separator:SetIgnoreParentAlpha(false)
        elseif f.Power and f.Power.separator then
            f.Power.separator:Hide()
        end
    elseif frameName == 'Target' and enabled and config.Target then
        BorderAndSeparator(f)
        if config.Targetsep and f.Power and f.Power.separator then
            f.Power.separator:Show()
            f.Power.separator:SetIgnoreParentAlpha(false)
        elseif f.Power and f.Power.separator then
            f.Power.separator:Hide()
        end
    elseif frameName == 'TargetTarget' and enabled and config.TargetofTarget then
        BorderAndSeparator(f)
    elseif frameName == 'Focus' and enabled and config.Focus then
        BorderAndSeparator(f)
    elseif frameName == 'FocusTarget' and enabled and config.FocusTarget then
        BorderAndSeparator(f)
    elseif frameName == 'Pet' and enabled and config.Pet then
        BorderAndSeparator(f)
    elseif frameName == 'PetTarget' and enabled and config.PetTarget then
        BorderAndSeparator(f)
    elseif frameName == 'TargetTargetTarget' and enabled and config.TargetofTargetofTarget then
        BorderAndSeparator(f)
    end
end

function S:ElvUI_UnitFramesGroup(_, group, numGroup)
    local config = E.db.ProjectHopes and E.db.ProjectHopes.border
    if not config then return end

    for i = 1, numGroup do
        local unit = group .. i
        local enabled = UF.db.units[group].enable

        if unit == "boss"..i and enabled and config.Boss and E.db.unitframe.units.boss.enable then
            local BF = _G["ElvUF_Boss"..i]
            BorderAndSeparator(BF)
            if BF.Power and BF.Power.separator then
                BF.Power.separator:SetIgnoreParentAlpha(false)
            end
            if BF.border then
                BF.border:SetFrameLevel(22)
            end
        end

        if unit == "arena"..i and enabled and config.Arena and E.db.unitframe.units.arena.enable then
            local AF = _G["ElvUF_Arena"..i]
            BorderAndSeparator(AF)
        end
    end
end

function S:ElvUI_UnitFramesGroupRaidParty(_, group, groupFilter, template, headerTemplate, skip)
	local db = UF.db.units[group]
    local config = E.db.ProjectHopes and E.db.ProjectHopes.border
    if not config then return end

	local Header = UF[group]

	local enable = db.enable
	local name, isRaidFrames = E:StringTitle(group), strmatch(group, '^raid(%d)') and true

    if name == "Party" and enable and E.db.ProjectHopes.border.Party then
        local PartyFrame = _G["ElvUF_PartyGroup1"]
            
        BORDER:CreateBorder(PartyFrame, 20, -9, 9, 9, -9)
        BORDER:CreateBackground(PartyFrame, -2, 2, 2, -2)

        if E.db.unitframe.units.party.growthDirection == "UP_LEFT" or E.db.unitframe.units.party.growthDirection == "UP_RIGHT" then
            for i = 1, 4 do 
                local unitButton = _G["ElvUF_PartyGroup1UnitButton" .. i]
                BORDER:CreateSeparator(unitButton, 22, nil, PartyFrame)
            end
        elseif E.db.unitframe.units.party.growthDirection == "DOWN_LEFT" or E.db.unitframe.units.party.growthDirection == "DOWN_RIGHT" then
            for i = 2, 5 do
                local unitButton = _G["ElvUF_PartyGroup1UnitButton" .. i]
                BORDER:CreateSeparator(unitButton, 22, nil, PartyFrame)
            end
        else 
            BORDER:CreateVSeparator(unitButton, 22, nil, PartyFrame)
        end
    elseif name == "Party" and enable and E.db.ProjectHopes.border.PartySpaced then
        for i = 1,5 do
            local f = _G["ElvUF_PartyGroup1UnitButton"..i]
            if f then
                BORDER:CreateBorder(f, 22, -9, 9, 9, -9)
                BORDER:CreateBackground(f, -2, 2, 2, -2)
                BORDER:CreateSeparator(f.Power)

            end
        end
    end

    if name == "Raid1" and enable and E.db.ProjectHopes.border.raid then
        local Raid1Frames = _G["ElvUF_Raid1"]
        local raid1width = E.db.unitframe.units.raid1.width
        local raid1height = E.db.unitframe.units.raid1.height

        E.db.unitframe.units.raid1.horizontalSpacing = 3
        E.db.unitframe.units.raid1.verticalSpacing = 3

        BORDER:CreateBorder(Raid1Frames, 20, -9, 9, 9, -9)
        if E.db.ProjectHopes.border.raidbackdrop then
            BORDER:CreateBackground(Raid1Frames, -4, 4, 4, -4)
        end

        local growth = E.db.unitframe.units.raid1.growthDirection
        local numGroups = E.db.unitframe.units.raid1.numGroups

        if growth == "LEFT_DOWN" then
            local numSeparators = 4
            for i = 1, numSeparators do
                local separatorName = "separator" .. i
                local xPosition = i * raid1width + (i + 2) * 3 - 1
                
                if not Raid1Frames.border[separatorName] then
                    Raid1Frames.border[separatorName] = CreateFrame("Frame", nil, Raid1Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid1Frames.border[separatorName]:SetBackdrop(Private.vSeparator)
                    Raid1Frames.border[separatorName]:SetFrameLevel(Raid1Frames.border:GetFrameLevel() - 1)

                    Raid1Frames.border[separatorName]:SetWidth(16)
                end
                Raid1Frames.border[separatorName]:SetPoint("BOTTOMLEFT", Raid1Frames.border, 0, 8)
                Raid1Frames.border[separatorName]:SetPoint("TOPLEFT", Raid1Frames.border, xPosition, - 8)
            end

            for k = 2, numGroups do 
                local vseparatorName = "vseparator" .. k

                if not Raid1Frames.border[vseparatorName] then
                    Raid1Frames.border[vseparatorName] = CreateFrame("Frame", nil, Raid1Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid1Frames.border[vseparatorName]:SetBackdrop(Private.Separator)
                    Raid1Frames.border[vseparatorName]:SetFrameLevel(Raid1Frames.border:GetFrameLevel() - 1)
                    Raid1Frames.border[vseparatorName]:SetHeight(16)

                end
                Raid1Frames.border[vseparatorName]:SetPoint("LEFT", Raid1Frames.border, 8, 0)
                Raid1Frames.border[vseparatorName]:SetPoint("TOPRIGHT", _G["ElvUF_Raid1Group"..k], 0, 4)
            end
            
            local function LEFT_DOWN_UpdateRaid1Border()
                local members = GetNumGroupMembers()
                if members == 0 then return end
                
                local maxSubgroup = 1
                for j = 1, members do
                    local _, rank, subgroup = GetRaidRosterInfo(j)
                    if subgroup and subgroup > maxSubgroup then
                        maxSubgroup = subgroup
                    end
                end
                    
                for i = 2, numGroups do
                    local vseparatorName = "vseparator" .. i
                    if Raid1Frames.border[vseparatorName] then
                        if i <= maxSubgroup then
                            Raid1Frames.border[vseparatorName]:Show()
                        else
                            Raid1Frames.border[vseparatorName]:Hide()
                        end
                    end
                end
                
                local groupnum = "ElvUF_Raid1Group" .. maxSubgroup
                local lastGroup = _G[groupnum]
                
                if lastGroup then
                    Raid1Frames.border:ClearAllPoints()
                    Raid1Frames.border:SetPoint("TOPLEFT", Raid1Frames, -9, 9)
                    Raid1Frames.border:SetPoint("TOPRIGHT", Raid1Frames, 9, -9)
                    Raid1Frames.border:SetPoint("BOTTOMRIGHT", lastGroup, 9, -9)
                    
                    if E.db.ProjectHopes.border.raidbackdrop and Raid1Frames.background then
                        Raid1Frames.background:ClearAllPoints()
                        Raid1Frames.background:SetPoint("TOPLEFT", Raid1Frames, -4, 4)
                        Raid1Frames.background:SetPoint("TOPRIGHT", Raid1Frames, 4, -4)
                        Raid1Frames.background:SetPoint("BOTTOMRIGHT", lastGroup, 4, -4)	
                    end
                end
            end

            Raid1Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
            Raid1Frames.border:RegisterEvent("RAID_ROSTER_UPDATE")
            if IsInRaid() then
                Raid1Frames.border:RegisterEvent("PLAYER_ENTERING_WORLD")
            end
            Raid1Frames.border:SetScript("OnEvent", function(self, event, ...)
                LEFT_DOWN_UpdateRaid1Border()
            end)
        end

        if growth == "LEFT_UP" then
            local numSeparators = 4
            for i = 1, numSeparators do
                local separatorName = "separator" .. i
                local xPosition = i * raid1width + (i + 2) * 3 - 1
                
                if not Raid1Frames.border[separatorName] then
                    Raid1Frames.border[separatorName] = CreateFrame("Frame", nil, Raid1Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid1Frames.border[separatorName]:SetBackdrop(Private.vSeparator)
                    Raid1Frames.border[separatorName]:SetFrameLevel(Raid1Frames.border:GetFrameLevel() - 1)

                    Raid1Frames.border[separatorName]:SetWidth(16)
                end
                Raid1Frames.border[separatorName]:SetPoint("BOTTOMLEFT", Raid1Frames.border, 0, 8)
                Raid1Frames.border[separatorName]:SetPoint("TOPLEFT", Raid1Frames.border, xPosition, - 8)
            end

            for k = 1, numGroups - 1 do 
                local vseparatorName = "vseparator" .. k

                if not Raid1Frames.border[vseparatorName] then
                    Raid1Frames.border[vseparatorName] = CreateFrame("Frame", nil, Raid1Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid1Frames.border[vseparatorName]:SetBackdrop(Private.Separator)
                    Raid1Frames.border[vseparatorName]:SetFrameLevel(Raid1Frames.border:GetFrameLevel() - 1)
                    Raid1Frames.border[vseparatorName]:SetHeight(16)

                end
                Raid1Frames.border[vseparatorName]:SetPoint("LEFT", Raid1Frames.border, 8, 0)
                Raid1Frames.border[vseparatorName]:SetPoint("TOPRIGHT", _G["ElvUF_Raid1Group"..k], 0, 4)
            end
            
            local function LEFT_UP_UpdateRaid1Border()
                local members = GetNumGroupMembers()
                if members == 0 then return end
                
                local maxSubgroup = 1
   
                for j = 1, members do
                    local _, rank, subgroup = GetRaidRosterInfo(j)
                    if subgroup and subgroup > maxSubgroup then
                        maxSubgroup = subgroup
                    end
                end
                
                local groupnum = "ElvUF_Raid1Group" .. maxSubgroup
                local lastGroup = _G[groupnum]
                    
                for k = 1, numGroups - 1 do
                    local vseparatorName = "vseparator" .. k
                    if Raid1Frames.border[vseparatorName] then
                      if k < maxSubgroup then
                            Raid1Frames.border[vseparatorName]:Show()
                        else
                            Raid1Frames.border[vseparatorName]:Hide()
                        end
                    end
                end
                
                if lastGroup then
                    Raid1Frames.border:ClearAllPoints()
                    Raid1Frames.border:SetPoint("BOTTOMLEFT", Raid1Frames, -9, -9)
                    Raid1Frames.border:SetPoint("BOTTOMRIGHT", Raid1Frames, -9, 9)
                    Raid1Frames.border:SetPoint("TOPRIGHT", lastGroup, 9, 9)
                    
                    if E.db.ProjectHopes.border.raidbackdrop and Raid1Frames.background then
                        Raid1Frames.background:ClearAllPoints()
                        Raid1Frames.background:SetPoint("BOTTOMLEFT", Raid1Frames, -4, -4)
                        Raid1Frames.background:SetPoint("BOTTOMRIGHT", Raid1Frames, -4, 4)
                        Raid1Frames.background:SetPoint("TOPRIGHT", lastGroup, 4, 4)	
                    end
                end
            end

            Raid1Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
            Raid1Frames.border:RegisterEvent("RAID_ROSTER_UPDATE")
            if IsInRaid() then
                Raid1Frames.border:RegisterEvent("PLAYER_ENTERING_WORLD")
            end
            Raid1Frames.border:SetScript("OnEvent", function(self, event, ...)
                LEFT_UP_UpdateRaid1Border()
            end)
        end

        if growth == "RIGHT_DOWN" then
            local numSeparators = 4
            for i = 1, numSeparators do
                local separatorName = "separator" .. i
                local xPosition = i * raid1width + (i + 2) * 3 - 1
                
                if not Raid1Frames.border[separatorName] then
                    Raid1Frames.border[separatorName] = CreateFrame("Frame", nil, Raid1Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid1Frames.border[separatorName]:SetBackdrop(Private.vSeparator)
                    Raid1Frames.border[separatorName]:SetFrameLevel(Raid1Frames.border:GetFrameLevel() - 1)

                    Raid1Frames.border[separatorName]:SetWidth(16)
                end
                Raid1Frames.border[separatorName]:SetPoint("BOTTOMLEFT", Raid1Frames.border, 0, 8)
                Raid1Frames.border[separatorName]:SetPoint("TOPLEFT", Raid1Frames.border, xPosition, - 8)
            end

            for k = 2, numGroups do 
                local vseparatorName = "vseparator" .. k

                if not Raid1Frames.border[vseparatorName] then
                    Raid1Frames.border[vseparatorName] = CreateFrame("Frame", nil, Raid1Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid1Frames.border[vseparatorName]:SetBackdrop(Private.Separator)
                    Raid1Frames.border[vseparatorName]:SetFrameLevel(Raid1Frames.border:GetFrameLevel() - 1)
                    Raid1Frames.border[vseparatorName]:SetHeight(16)

                end
                Raid1Frames.border[vseparatorName]:SetPoint("RIGHT", Raid1Frames.border, -8, 0)
                Raid1Frames.border[vseparatorName]:SetPoint("TOPLEFT", _G["ElvUF_Raid1Group"..k], 0, 4)
            end
            
            local function RIGHT_DOWN_UpdateRaid1Border()
                local members = GetNumGroupMembers()
                if members == 0 then return end
                
                local maxSubgroup = 1
                for j = 1, members do
                    local _, rank, subgroup = GetRaidRosterInfo(j)
                    if subgroup and subgroup > maxSubgroup then
                        maxSubgroup = subgroup
                    end
                end
                    
                for i = 2, numGroups do
                    local vseparatorName = "vseparator" .. i
                    if Raid1Frames.border[vseparatorName] then
                        if i <= maxSubgroup then
                            Raid1Frames.border[vseparatorName]:Show()
                        else
                            Raid1Frames.border[vseparatorName]:Hide()
                        end
                    end
                end
                
                local groupnum = "ElvUF_Raid1Group" .. maxSubgroup
                local lastGroup = _G[groupnum]
                
                if lastGroup then
                    Raid1Frames.border:ClearAllPoints()
                    Raid1Frames.border:SetPoint("TOPLEFT", Raid1Frames, -9, 9)
                    Raid1Frames.border:SetPoint("TOPRIGHT", Raid1Frames, 9, -9)
                    Raid1Frames.border:SetPoint("BOTTOMLEFT", lastGroup, 9, -9)
                    
                    if E.db.ProjectHopes.border.raidbackdrop and Raid1Frames.background then
                        Raid1Frames.background:ClearAllPoints()
                        Raid1Frames.background:SetPoint("TOPLEFT", Raid1Frames, -4, 4)
                        Raid1Frames.background:SetPoint("TOPRIGHT", Raid1Frames, 4, -4)
                        Raid1Frames.background:SetPoint("BOTTOMRIGHT", lastGroup, 4, -4)	
                    end
                end
            end

            Raid1Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
            Raid1Frames.border:RegisterEvent("RAID_ROSTER_UPDATE")
            if IsInRaid() then
                Raid1Frames.border:RegisterEvent("PLAYER_ENTERING_WORLD")
            end
            Raid1Frames.border:SetScript("OnEvent", function(self, event, ...)
                RIGHT_DOWN_UpdateRaid1Border()
            end)
        end

        if growth == "RIGHT_UP" then
            local numSeparators = 4
            for i = 1, numSeparators do
                local separatorName = "separator" .. i
                local xPosition = i * raid1width + (i + 2) * 3 - 1
                
                if not Raid1Frames.border[separatorName] then
                    Raid1Frames.border[separatorName] = CreateFrame("Frame", nil, Raid1Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid1Frames.border[separatorName]:SetBackdrop(Private.vSeparator)
                    Raid1Frames.border[separatorName]:SetFrameLevel(Raid1Frames.border:GetFrameLevel() - 1)

                    Raid1Frames.border[separatorName]:SetWidth(16)
                end
                Raid1Frames.border[separatorName]:SetPoint("BOTTOMLEFT", Raid1Frames.border, 0, 8)
                Raid1Frames.border[separatorName]:SetPoint("TOPLEFT", Raid1Frames.border, xPosition, - 8)
            end

            for k = 1, numGroups - 1 do 
                local vseparatorName = "vseparator" .. k

                if not Raid1Frames.border[vseparatorName] then
                    Raid1Frames.border[vseparatorName] = CreateFrame("Frame", nil, Raid1Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid1Frames.border[vseparatorName]:SetBackdrop(Private.Separator)
                    Raid1Frames.border[vseparatorName]:SetFrameLevel(Raid1Frames.border:GetFrameLevel() - 1)
                    Raid1Frames.border[vseparatorName]:SetHeight(16)

                end
                Raid1Frames.border[vseparatorName]:SetPoint("RIGHT", Raid1Frames.border, -8, 0)
                Raid1Frames.border[vseparatorName]:SetPoint("TOPLEFT", _G["ElvUF_Raid1Group"..k], 0, 4)
            end
            
            local function RIGHT_UP_UpdateRaid1Border()
                local members = GetNumGroupMembers()
                if members == 0 then return end
                
                local maxSubgroup = 1
   
                for j = 1, members do
                    local _, rank, subgroup = GetRaidRosterInfo(j)
                    if subgroup and subgroup > maxSubgroup then
                        maxSubgroup = subgroup
                    end
                end
                
                local groupnum = "ElvUF_Raid1Group" .. maxSubgroup
                local lastGroup = _G[groupnum]
                    
                for k = 1, numGroups - 1 do
                    local vseparatorName = "vseparator" .. k
                    if Raid1Frames.border[vseparatorName] then
                      if k < maxSubgroup then
                            print(maxSubgroup)
                            Raid1Frames.border[vseparatorName]:Show()
                        else
                            Raid1Frames.border[vseparatorName]:Hide()
                        end
                    end
                end
                
                if lastGroup then
                    Raid1Frames.border:ClearAllPoints()
                    Raid1Frames.border:SetPoint("BOTTOMRIGHT", Raid1Frames, 9, -9)
                    Raid1Frames.border:SetPoint("BOTTOMLEFT", Raid1Frames, 9, -9)
                    Raid1Frames.border:SetPoint("TOPLEFT", lastGroup, -9, 9)
                    
                    if E.db.ProjectHopes.border.raidbackdrop and Raid1Frames.background then
                        Raid1Frames.background:ClearAllPoints()
                        Raid1Frames.background:SetPoint("BOTTOMRIGHT", Raid1Frames, 4, -4)
                        Raid1Frames.background:SetPoint("BOTTOMLEFT", Raid1Frames, 4, -4)
                        Raid1Frames.background:SetPoint("TOPLEFT", lastGroup, -4, 4)	
                    end
                end
            end

            Raid1Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
            Raid1Frames.border:RegisterEvent("RAID_ROSTER_UPDATE")
            if IsInRaid() then
                Raid1Frames.border:RegisterEvent("PLAYER_ENTERING_WORLD")
            end
            Raid1Frames.border:SetScript("OnEvent", function(self, event, ...)
                RIGHT_UP_UpdateRaid1Border()
            end)
        end

        if growth == "DOWN_LEFT" then
            local numSeparators = 4
            for i = 1, numSeparators do
                local separatorName = "separator" .. i
                local xPosition = i * raid1height + (i + 2) * 3 - 1
                
                if not Raid1Frames.border[separatorName] then
                    Raid1Frames.border[separatorName] = CreateFrame("Frame", nil, Raid1Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid1Frames.border[separatorName]:SetBackdrop(Private.Separator)
                    Raid1Frames.border[separatorName]:SetFrameLevel(Raid1Frames.border:GetFrameLevel() - 1)
                    Raid1Frames.border[separatorName]:SetHeight(16)
                end
                Raid1Frames.border[separatorName]:SetPoint("LEFT", Raid1Frames.border, 8, -8)
                Raid1Frames.border[separatorName]:SetPoint("TOPRIGHT", Raid1Frames.border, -8, - xPosition)
            end

            for k = 1, numGroups - 1 do 
                local vseparatorName = "vseparator" .. k

                if not Raid1Frames.border[vseparatorName] then
                    Raid1Frames.border[vseparatorName] = CreateFrame("Frame", nil, Raid1Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid1Frames.border[vseparatorName]:SetBackdrop(Private.vSeparator)
                    Raid1Frames.border[vseparatorName]:SetFrameLevel(Raid1Frames.border:GetFrameLevel() - 1)
                    Raid1Frames.border[vseparatorName]:SetWidth(16)
                end

                Raid1Frames.border[vseparatorName]:SetPoint("BOTTOM", Raid1Frames.border, 0, 8)
                Raid1Frames.border[vseparatorName]:SetPoint("TOPLEFT", _G["ElvUF_Raid1Group"..k], -4, 0)
            end
            
            local function DOWN_LEFT_UpdateRaid1Border()
                local members = GetNumGroupMembers()
                if members == 0 then return end
                
                local maxSubgroup = 1
   
                for j = 1, members do
                    local _, rank, subgroup = GetRaidRosterInfo(j)
                    if subgroup and subgroup > maxSubgroup then
                        maxSubgroup = subgroup
                    end
                end
                
                local groupnum = "ElvUF_Raid1Group" .. maxSubgroup
                local lastGroup = _G[groupnum]
                    
                for k = 1, numGroups - 1 do
                    local vseparatorName = "vseparator" .. k
                    if Raid1Frames.border[vseparatorName] then
                      if k < maxSubgroup then
                            Raid1Frames.border[vseparatorName]:Show()
                        else
                            Raid1Frames.border[vseparatorName]:Hide()
                        end
                    end
                end
                
                if lastGroup then
                    Raid1Frames.border:ClearAllPoints()
                    Raid1Frames.border:SetPoint("TOPRIGHT", Raid1Frames, 9, -9)
                    Raid1Frames.border:SetPoint("BOTTOMRIGHT", Raid1Frames, 9, -9)
                    Raid1Frames.border:SetPoint("TOPLEFT", lastGroup, -9, 9)
                    
                    if E.db.ProjectHopes.border.raidbackdrop and Raid1Frames.background then
                        Raid1Frames.background:ClearAllPoints()
                        Raid1Frames.background:SetPoint("TOPRIGHT", Raid1Frames, 4, -4)
                        Raid1Frames.background:SetPoint("BOTTOMRIGHT", Raid1Frames, 4, -4)
                        Raid1Frames.background:SetPoint("TOPLEFT", lastGroup, -4, 4)	
                    end
                end
            end

            Raid1Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
            Raid1Frames.border:RegisterEvent("RAID_ROSTER_UPDATE")
            if IsInRaid() then
                Raid1Frames.border:RegisterEvent("PLAYER_ENTERING_WORLD")
            end
            Raid1Frames.border:SetScript("OnEvent", function(self, event, ...)
                DOWN_LEFT_UpdateRaid1Border()
            end)
        end

        if growth == "DOWN_RIGHT" then
            local numSeparators = 4
            for i = 1, numSeparators do
                local separatorName = "separator" .. i
                local xPosition = i * raid1height + (i + 2) * 3 - 1
                
                if not Raid1Frames.border[separatorName] then
                    Raid1Frames.border[separatorName] = CreateFrame("Frame", nil, Raid1Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid1Frames.border[separatorName]:SetBackdrop(Private.Separator)
                    Raid1Frames.border[separatorName]:SetFrameLevel(Raid1Frames.border:GetFrameLevel() - 1)
                    Raid1Frames.border[separatorName]:SetHeight(16)
                end
                Raid1Frames.border[separatorName]:SetPoint("LEFT", Raid1Frames.border, 8, -8)
                Raid1Frames.border[separatorName]:SetPoint("TOPRIGHT", Raid1Frames.border, -8, - xPosition)
            end

            for k = 1, numGroups - 1 do 
                local vseparatorName = "vseparator" .. k

                if not Raid1Frames.border[vseparatorName] then
                    Raid1Frames.border[vseparatorName] = CreateFrame("Frame", nil, Raid1Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid1Frames.border[vseparatorName]:SetBackdrop(Private.vSeparator)
                    Raid1Frames.border[vseparatorName]:SetFrameLevel(Raid1Frames.border:GetFrameLevel() - 1)
                    Raid1Frames.border[vseparatorName]:SetWidth(16)
                end
                Raid1Frames.border[vseparatorName]:ClearAllPoints()
                Raid1Frames.border[vseparatorName]:SetPoint("BOTTOM", Raid1Frames.border, 0, 8)
                Raid1Frames.border[vseparatorName]:SetPoint("TOPRIGHT", _G["ElvUF_Raid1Group"..k], 15, 0)
            end
            
            local function DOWN_RIGHT_UpdateRaid1Border()
                local members = GetNumGroupMembers()
                if members == 0 then return end
                
                local maxSubgroup = 1
   
                for j = 1, members do
                    local _, rank, subgroup = GetRaidRosterInfo(j)
                    if subgroup and subgroup > maxSubgroup then
                        maxSubgroup = subgroup
                    end
                end
                
                local groupnum = "ElvUF_Raid1Group" .. maxSubgroup
                local lastGroup = _G[groupnum]
                    
                for k = 1, numGroups - 1 do
                    local vseparatorName = "vseparator" .. k
                    if Raid1Frames.border[vseparatorName] then
                      if k < maxSubgroup then
                            Raid1Frames.border[vseparatorName]:Show()
                        else
                            Raid1Frames.border[vseparatorName]:Hide()
                        end
                    end
                end
                
                if lastGroup then
                    Raid1Frames.border:ClearAllPoints()
                    Raid1Frames.border:SetPoint("TOPLEFT", Raid1Frames, -9, 9)
                    Raid1Frames.border:SetPoint("BOTTOMLEFT", Raid1Frames, 9, -9)
                    Raid1Frames.border:SetPoint("TOPRIGHT", lastGroup, 9, -9)
                    
                    if E.db.ProjectHopes.border.raidbackdrop and Raid1Frames.background then
                        Raid1Frames.background:ClearAllPoints()
                        Raid1Frames.background:SetPoint("TOPLEFT", Raid1Frames, -4, 4)
                        Raid1Frames.background:SetPoint("BOTTOMLEFT", Raid1Frames, -4, -4)
                        Raid1Frames.background:SetPoint("TOPRIGHT", lastGroup, 5, 4)	
                    end
                end
            end

            Raid1Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
            Raid1Frames.border:RegisterEvent("RAID_ROSTER_UPDATE")
            if IsInRaid() then
                Raid1Frames.border:RegisterEvent("PLAYER_ENTERING_WORLD")
            end
            Raid1Frames.border:SetScript("OnEvent", function(self, event, ...)
                DOWN_RIGHT_UpdateRaid1Border()
            end)
        end

        if growth == "UP_LEFT" then
            local numSeparators = 4
            for i = 1, numSeparators do
                local separatorName = "separator" .. i
                local xPosition = i * raid1height + (i + 2) * 3 - 1
                  
                if not Raid1Frames.border[separatorName] then
                    Raid1Frames.border[separatorName] = CreateFrame("Frame", nil, Raid1Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid1Frames.border[separatorName]:SetBackdrop(Private.Separator)
                    Raid1Frames.border[separatorName]:SetFrameLevel(Raid1Frames.border:GetFrameLevel() - 1)
                    Raid1Frames.border[separatorName]:SetHeight(16)
                end
                Raid1Frames.border[separatorName]:SetPoint("LEFT", Raid1Frames.border, 8, -8)
                Raid1Frames.border[separatorName]:SetPoint("TOPRIGHT", Raid1Frames.border, -8, - xPosition)
            end

            for k = 1, numGroups - 1 do 
                local vseparatorName = "vseparator" .. k

                if not Raid1Frames.border[vseparatorName] then
                    Raid1Frames.border[vseparatorName] = CreateFrame("Frame", nil, Raid1Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid1Frames.border[vseparatorName]:SetBackdrop(Private.vSeparator)
                    Raid1Frames.border[vseparatorName]:SetFrameLevel(Raid1Frames.border:GetFrameLevel() - 1)
                    Raid1Frames.border[vseparatorName]:SetWidth(16)
                end
                Raid1Frames.border[vseparatorName]:ClearAllPoints()
                Raid1Frames.border[vseparatorName]:SetPoint("TOP", Raid1Frames.border, 0, -8)
                Raid1Frames.border[vseparatorName]:SetPoint("BOTTOMLEFT", _G["ElvUF_Raid1Group"..k], -4, 0)
            end
            
            local function UP_LEFT_UpdateRaid1Border()
                local members = GetNumGroupMembers()
                if members == 0 then return end
                
                local maxSubgroup = 1
   
                for j = 1, members do
                    local _, rank, subgroup = GetRaidRosterInfo(j)
                    if subgroup and subgroup > maxSubgroup then
                        maxSubgroup = subgroup
                    end
                end
                
                local groupnum = "ElvUF_Raid1Group" .. maxSubgroup
                local lastGroup = _G[groupnum]
                    
                for k = 1, numGroups - 1 do
                    local vseparatorName = "vseparator" .. k
                    if Raid1Frames.border[vseparatorName] then
                      if k < maxSubgroup then
                            Raid1Frames.border[vseparatorName]:Show()
                        else
                            Raid1Frames.border[vseparatorName]:Hide()
                        end
                    end
                end
                
                if lastGroup then
                    Raid1Frames.border:ClearAllPoints()
                    Raid1Frames.border:SetPoint("BOTTOMRIGHT", Raid1Frames, -9, 9)
                    Raid1Frames.border:SetPoint("TOPRIGHT", Raid1Frames, 9, 9)
                    Raid1Frames.border:SetPoint("BOTTOMLEFT", lastGroup, -9, -9)
                    
                    if E.db.ProjectHopes.border.raidbackdrop and Raid1Frames.background then
                        Raid1Frames.background:ClearAllPoints()
                        Raid1Frames.background:SetPoint("BOTTOMRIGHT", Raid1Frames, -4, 4)
                        Raid1Frames.background:SetPoint("TOPRIGHT", Raid1Frames, 4, 4)
                        Raid1Frames.background:SetPoint("BOTTOMLEFT", lastGroup, -4, -4)	
                    end
                end
            end

            Raid1Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
            Raid1Frames.border:RegisterEvent("RAID_ROSTER_UPDATE")
            if IsInRaid() then
                Raid1Frames.border:RegisterEvent("PLAYER_ENTERING_WORLD")
            end
            Raid1Frames.border:SetScript("OnEvent", function(self, event, ...)
                UP_LEFT_UpdateRaid1Border()
            end)
        end

        if growth == "UP_RIGHT" then
            local numSeparators = 4
            for i = 1, numSeparators do
                local separatorName = "separator" .. i
                local xPosition = i * raid1height + (i + 2) * 3 - 1
                
                if not Raid1Frames.border[separatorName] then
                    Raid1Frames.border[separatorName] = CreateFrame("Frame", nil, Raid1Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid1Frames.border[separatorName]:SetBackdrop(Private.Separator)
                    Raid1Frames.border[separatorName]:SetFrameLevel(Raid1Frames.border:GetFrameLevel() - 1)
                    Raid1Frames.border[separatorName]:SetHeight(16)
                end
                Raid1Frames.border[separatorName]:SetPoint("LEFT", Raid1Frames.border, 8, -8)
                Raid1Frames.border[separatorName]:SetPoint("TOPRIGHT", Raid1Frames.border, -8, - xPosition)
            end

            for k = 1, numGroups - 1 do 
                local vseparatorName = "vseparator" .. k

                if not Raid1Frames.border[vseparatorName] then
                    Raid1Frames.border[vseparatorName] = CreateFrame("Frame", nil, Raid1Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid1Frames.border[vseparatorName]:SetBackdrop(Private.vSeparator)
                    Raid1Frames.border[vseparatorName]:SetFrameLevel(Raid1Frames.border:GetFrameLevel() - 1)
                    Raid1Frames.border[vseparatorName]:SetWidth(16)
                end
                Raid1Frames.border[vseparatorName]:SetPoint("TOP", Raid1Frames.border, 0, -8)
                Raid1Frames.border[vseparatorName]:SetPoint("BOTTOMRIGHT", _G["ElvUF_Raid1Group"..k], 15, 0)
            end
            
            local function UP_RIGHT_UpdateRaid1Border()
                local members = GetNumGroupMembers()
                if members == 0 then return end
                
                local maxSubgroup = 1
   
                for j = 1, members do
                    local _, rank, subgroup = GetRaidRosterInfo(j)
                    if subgroup and subgroup > maxSubgroup then
                        maxSubgroup = subgroup
                    end
                end
                
                local groupnum = "ElvUF_Raid1Group" .. maxSubgroup
                local lastGroup = _G[groupnum]
                    
                for k = 1, numGroups - 1 do
                    local vseparatorName = "vseparator" .. k
                    if Raid1Frames.border[vseparatorName] then
                      if k < maxSubgroup then
                            Raid1Frames.border[vseparatorName]:Show()
                        else
                            Raid1Frames.border[vseparatorName]:Hide()
                        end
                    end
                end
                
                if lastGroup then
                    Raid1Frames.border:ClearAllPoints()
                    Raid1Frames.border:SetPoint("BOTTOMLEFT", Raid1Frames, 9, -9)
                    Raid1Frames.border:SetPoint("TOPLEFT", Raid1Frames, -9, 9)
                    Raid1Frames.border:SetPoint("BOTTOMRIGHT", lastGroup, 9, 9)
                    
                    if E.db.ProjectHopes.border.raidbackdrop and Raid1Frames.background then
                        Raid1Frames.background:ClearAllPoints()
                        Raid1Frames.background:SetPoint("BOTTOMLEFT", Raid1Frames, 4, -4)
                        Raid1Frames.background:SetPoint("TOPLEFT", Raid1Frames, -4, 4)
                        Raid1Frames.background:SetPoint("BOTTOMRIGHT", lastGroup, 5, 4)	
                    end
                end
            end

            Raid1Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
            Raid1Frames.border:RegisterEvent("RAID_ROSTER_UPDATE")
            if IsInRaid() then
                Raid1Frames.border:RegisterEvent("PLAYER_ENTERING_WORLD")
            end
            Raid1Frames.border:SetScript("OnEvent", function(self, event, ...)
                UP_RIGHT_UpdateRaid1Border()
            end)
        end
    end 

    if name == "Raid2" and enable and E.db.ProjectHopes.border.raid2 then
        local Raid2Frames = _G["ElvUF_Raid2"]
        local raid2width = E.db.unitframe.units.raid2.width
        local raid2height = E.db.unitframe.units.raid2.height

        E.db.unitframe.units.raid2.horizontalSpacing = 3
        E.db.unitframe.units.raid2.verticalSpacing = 3

        BORDER:CreateBorder(Raid2Frames, 20, -9, 9, 9, -9)
        if E.db.ProjectHopes.border.raid2backdrop then
            BORDER:CreateBackground(Raid2Frames, -4, 4, 4, -4)
        end

        local growth = E.db.unitframe.units.raid2.growthDirection
        local numGroups = E.db.unitframe.units.raid2.numGroups
        
        if growth == "LEFT_DOWN" then
            local numSeparators = 4
            for i = 1, numSeparators do
                local separatorName = "separator" .. i
                local xPosition = i * raid2width + (i + 2) * 3 - 1
                
                if not Raid2Frames.border[separatorName] then
                    Raid2Frames.border[separatorName] = CreateFrame("Frame", nil, Raid2Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid2Frames.border[separatorName]:SetBackdrop(Private.vSeparator)
                    Raid2Frames.border[separatorName]:SetFrameLevel(Raid2Frames.border:GetFrameLevel() - 1)

                    Raid2Frames.border[separatorName]:SetWidth(16)
                end
                Raid2Frames.border[separatorName]:SetPoint("BOTTOMLEFT", Raid2Frames.border, 0, 8)
                Raid2Frames.border[separatorName]:SetPoint("TOPLEFT", Raid2Frames.border, xPosition, - 8)
            end

            for k = 2, numGroups do 
                local vseparatorName = "vseparator" .. k

                if not Raid2Frames.border[vseparatorName] then
                    Raid2Frames.border[vseparatorName] = CreateFrame("Frame", nil, Raid2Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid2Frames.border[vseparatorName]:SetBackdrop(Private.Separator)
                    Raid2Frames.border[vseparatorName]:SetFrameLevel(Raid2Frames.border:GetFrameLevel() - 1)
                    Raid2Frames.border[vseparatorName]:SetHeight(16)

                end
                Raid2Frames.border[vseparatorName]:SetPoint("LEFT", Raid2Frames.border, 8, 0)
                Raid2Frames.border[vseparatorName]:SetPoint("TOPRIGHT", _G["ElvUF_Raid2Group"..k], 0, 4)
            end
            
            local function LEFT_DOWN_UpdateRaid2Border()
                local members = GetNumGroupMembers()
                if members == 0 then return end
                
                local maxSubgroup = 1
                for j = 1, members do
                    local _, rank, subgroup = GetRaidRosterInfo(j)
                    if subgroup and subgroup > maxSubgroup then
                        maxSubgroup = subgroup
                    end
                end
                    
                for i = 2, numGroups do
                    local vseparatorName = "vseparator" .. i
                    if Raid2Frames.border[vseparatorName] then
                        if i <= maxSubgroup then
                            Raid2Frames.border[vseparatorName]:Show()
                        else
                            Raid2Frames.border[vseparatorName]:Hide()
                        end
                    end
                end
                
                local groupnum = "ElvUF_Raid2Group" .. maxSubgroup
                local lastGroup = _G[groupnum]
                
                if lastGroup then
                    Raid2Frames.border:ClearAllPoints()
                    Raid2Frames.border:SetPoint("TOPLEFT", Raid2Frames, -9, 9)
                    Raid2Frames.border:SetPoint("TOPRIGHT", Raid2Frames, 9, -9)
                    Raid2Frames.border:SetPoint("BOTTOMRIGHT", lastGroup, 9, -9)
                    
                    if E.db.ProjectHopes.border.raid2backdrop and Raid2Frames.background then
                        Raid2Frames.background:ClearAllPoints()
                        Raid2Frames.background:SetPoint("TOPLEFT", Raid2Frames, -4, 4)
                        Raid2Frames.background:SetPoint("TOPRIGHT", Raid2Frames, 4, -4)
                        Raid2Frames.background:SetPoint("BOTTOMRIGHT", lastGroup, 4, -4)	
                    end
                end
            end

            Raid2Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
            Raid2Frames.border:RegisterEvent("RAID_ROSTER_UPDATE")
            if IsInRaid() then
                Raid2Frames.border:RegisterEvent("PLAYER_ENTERING_WORLD")
            end
            Raid2Frames.border:SetScript("OnEvent", function(self, event, ...)
                LEFT_DOWN_UpdateRaid2Border()
            end)
        end

        if growth == "LEFT_UP" then
            local numSeparators = 4
            for i = 1, numSeparators do
                local separatorName = "separator" .. i
                local xPosition = i * raid2width + (i + 2) * 3 - 1
                
                
                if not Raid2Frames.border[separatorName] then
                    Raid2Frames.border[separatorName] = CreateFrame("Frame", nil, Raid2Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid2Frames.border[separatorName]:SetBackdrop(Private.vSeparator)
                    Raid2Frames.border[separatorName]:SetFrameLevel(Raid2Frames.border:GetFrameLevel() - 1)

                    Raid2Frames.border[separatorName]:SetWidth(16)
                end
                Raid2Frames.border[separatorName]:SetPoint("BOTTOMLEFT", Raid2Frames.border, 0, 8)
                Raid2Frames.border[separatorName]:SetPoint("TOPLEFT", Raid2Frames.border, xPosition, - 8)
            end

            for k = 1, numGroups - 1 do 
                local vseparatorName = "vseparator" .. k

                if not Raid2Frames.border[vseparatorName] then
                    Raid2Frames.border[vseparatorName] = CreateFrame("Frame", nil, Raid2Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid2Frames.border[vseparatorName]:SetBackdrop(Private.Separator)
                    Raid2Frames.border[vseparatorName]:SetFrameLevel(Raid2Frames.border:GetFrameLevel() - 1)
                    Raid2Frames.border[vseparatorName]:SetHeight(16)

                end
                Raid2Frames.border[vseparatorName]:SetPoint("LEFT", Raid2Frames.border, 8, 0)
                Raid2Frames.border[vseparatorName]:SetPoint("TOPRIGHT", _G["ElvUF_Raid2Group"..k], 0, 4)
            end
            
            local function LEFT_UP_UpdateRaid2Border()
                local members = GetNumGroupMembers()
                if members == 0 then return end -- Exit if no group members
                
                local maxSubgroup = 1
   
                for j = 1, members do
                    local _, rank, subgroup = GetRaidRosterInfo(j)
                    if subgroup and subgroup > maxSubgroup then
                        maxSubgroup = subgroup
                    end
                end
                
                local groupnum = "ElvUF_Raid2Group" .. maxSubgroup
                local lastGroup = _G[groupnum]
                    
                for k = 1, numGroups - 1 do
                    local vseparatorName = "vseparator" .. k
                    if Raid2Frames.border[vseparatorName] then
                      if k < maxSubgroup then
                            Raid2Frames.border[vseparatorName]:Show()
                        else
                            Raid2Frames.border[vseparatorName]:Hide()
                        end
                    end
                end
                
                if lastGroup then
                    Raid2Frames.border:ClearAllPoints()
                    Raid2Frames.border:SetPoint("BOTTOMLEFT", Raid2Frames, -9, -9)
                    Raid2Frames.border:SetPoint("BOTTOMRIGHT", Raid2Frames, -9, 9)
                    Raid2Frames.border:SetPoint("TOPRIGHT", lastGroup, 9, 9)
                    
                    if E.db.ProjectHopes.border.raid2backdrop and Raid2Frames.background then
                        Raid2Frames.background:ClearAllPoints()
                        Raid2Frames.background:SetPoint("BOTTOMLEFT", Raid2Frames, -4, -4)
                        Raid2Frames.background:SetPoint("BOTTOMRIGHT", Raid2Frames, -4, 4)
                        Raid2Frames.background:SetPoint("TOPRIGHT", lastGroup, 4, 4)	
                    end
                end
            end

            -- Register events and set up initial state
            Raid2Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
            Raid2Frames.border:RegisterEvent("RAID_ROSTER_UPDATE") -- Additional event for raid changes
            if IsInRaid() then
                Raid2Frames.border:RegisterEvent("PLAYER_ENTERING_WORLD")
            end
            Raid2Frames.border:SetScript("OnEvent", function(self, event, ...)
                LEFT_UP_UpdateRaid2Border()
            end)
        end

        if growth == "RIGHT_DOWN" then
            local numSeparators = 4
            for i = 1, numSeparators do
                local separatorName = "separator" .. i
                local xPosition = i * raid2width + (i + 2) * 3 - 1
                
                
                if not Raid2Frames.border[separatorName] then
                    Raid2Frames.border[separatorName] = CreateFrame("Frame", nil, Raid2Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid2Frames.border[separatorName]:SetBackdrop(Private.vSeparator)
                    Raid2Frames.border[separatorName]:SetFrameLevel(Raid2Frames.border:GetFrameLevel() - 1)

                    Raid2Frames.border[separatorName]:SetWidth(16)
                end
                Raid2Frames.border[separatorName]:SetPoint("BOTTOMLEFT", Raid2Frames.border, 0, 8)
                Raid2Frames.border[separatorName]:SetPoint("TOPLEFT", Raid2Frames.border, xPosition, - 8)
            end

            for k = 2, numGroups do 
                local vseparatorName = "vseparator" .. k

                if not Raid2Frames.border[vseparatorName] then
                    Raid2Frames.border[vseparatorName] = CreateFrame("Frame", nil, Raid2Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid2Frames.border[vseparatorName]:SetBackdrop(Private.Separator)
                    Raid2Frames.border[vseparatorName]:SetFrameLevel(Raid2Frames.border:GetFrameLevel() - 1)
                    Raid2Frames.border[vseparatorName]:SetHeight(16)

                end
                Raid2Frames.border[vseparatorName]:SetPoint("RIGHT", Raid2Frames.border, -8, 0)
                Raid2Frames.border[vseparatorName]:SetPoint("TOPLEFT", _G["ElvUF_Raid2Group"..k], 0, 4)
            end
            
            local function RIGHT_DOWN_UpdateRaid2Border()
                local members = GetNumGroupMembers()
                if members == 0 then return end
                
                local maxSubgroup = 1
                for j = 1, members do
                    local _, rank, subgroup = GetRaidRosterInfo(j)
                    if subgroup and subgroup > maxSubgroup then
                        maxSubgroup = subgroup
                    end
                end
                    
                for i = 2, numGroups do
                    local vseparatorName = "vseparator" .. i
                    if Raid2Frames.border[vseparatorName] then
                        if i <= maxSubgroup then
                            Raid2Frames.border[vseparatorName]:Show()
                        else
                            Raid2Frames.border[vseparatorName]:Hide()
                        end
                    end
                end
                
                local groupnum = "ElvUF_Raid2Group" .. maxSubgroup
                local lastGroup = _G[groupnum]
                
                if lastGroup then
                    Raid2Frames.border:ClearAllPoints()
                    Raid2Frames.border:SetPoint("TOPLEFT", Raid2Frames, -9, 9)
                    Raid2Frames.border:SetPoint("TOPRIGHT", Raid2Frames, 9, -9)
                    Raid2Frames.border:SetPoint("BOTTOMLEFT", lastGroup, 9, -9)
                    
                    if E.db.ProjectHopes.border.raid2backdrop and Raid2Frames.background then
                        Raid2Frames.background:ClearAllPoints()
                        Raid2Frames.background:SetPoint("TOPLEFT", Raid2Frames, -4, 4)
                        Raid2Frames.background:SetPoint("TOPRIGHT", Raid2Frames, 4, -4)
                        Raid2Frames.background:SetPoint("BOTTOMRIGHT", lastGroup, 4, -4)	
                    end
                end
            end

            Raid2Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
            Raid2Frames.border:RegisterEvent("RAID_ROSTER_UPDATE")
            if IsInRaid() then
                Raid2Frames.border:RegisterEvent("PLAYER_ENTERING_WORLD")
            end
            Raid2Frames.border:SetScript("OnEvent", function(self, event, ...)
                RIGHT_DOWN_UpdateRaid2Border()
            end)
        end

        if growth == "RIGHT_UP" then
            local numSeparators = 4
            for i = 1, numSeparators do
                local separatorName = "separator" .. i
                local xPosition = i * raid2width + (i + 2) * 3 - 1
                
                
                if not Raid2Frames.border[separatorName] then
                    Raid2Frames.border[separatorName] = CreateFrame("Frame", nil, Raid2Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid2Frames.border[separatorName]:SetBackdrop(Private.vSeparator)
                    Raid2Frames.border[separatorName]:SetFrameLevel(Raid2Frames.border:GetFrameLevel() - 1)

                    Raid2Frames.border[separatorName]:SetWidth(16)
                end
                Raid2Frames.border[separatorName]:SetPoint("BOTTOMLEFT", Raid2Frames.border, 0, 8)
                Raid2Frames.border[separatorName]:SetPoint("TOPLEFT", Raid2Frames.border, xPosition, - 8)
            end

            for k = 1, numGroups - 1 do 
                local vseparatorName = "vseparator" .. k

                if not Raid2Frames.border[vseparatorName] then
                    Raid2Frames.border[vseparatorName] = CreateFrame("Frame", nil, Raid2Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid2Frames.border[vseparatorName]:SetBackdrop(Private.Separator)
                    Raid2Frames.border[vseparatorName]:SetFrameLevel(Raid2Frames.border:GetFrameLevel() - 1)
                    Raid2Frames.border[vseparatorName]:SetHeight(16)

                end
                Raid2Frames.border[vseparatorName]:SetPoint("RIGHT", Raid2Frames.border, 8, 0)
                Raid2Frames.border[vseparatorName]:SetPoint("TOPLEFT", _G["ElvUF_Raid2Group"..k], 0, 4)
            end
            
            local function LEFT_UP_RIGHT_UP_UpdateRaid2Border()
                local members = GetNumGroupMembers()
                if members == 0 then return end
                
                local maxSubgroup = 1
   
                for j = 1, members do
                    local _, rank, subgroup = GetRaidRosterInfo(j)
                    if subgroup and subgroup > maxSubgroup then
                        maxSubgroup = subgroup
                    end
                end
                
                local groupnum = "ElvUF_Raid2Group" .. maxSubgroup
                local lastGroup = _G[groupnum]
                    
                for k = 1, numGroups - 1 do
                    local vseparatorName = "vseparator" .. k
                    if Raid2Frames.border[vseparatorName] then
                      if k < maxSubgroup then
                            print(maxSubgroup)
                            Raid2Frames.border[vseparatorName]:Show()
                        else
                            Raid2Frames.border[vseparatorName]:Hide()
                        end
                    end
                end
                
                if lastGroup then
                    Raid2Frames.border:ClearAllPoints()
                    Raid2Frames.border:SetPoint("BOTTOMRIGHT", Raid2Frames, 9, -9)
                    Raid2Frames.border:SetPoint("BOTTOMLEFT", Raid2Frames, 9, -9)
                    Raid2Frames.border:SetPoint("TOPLEFT", lastGroup, -9, 9)
                    
                    if E.db.ProjectHopes.border.raid2backdrop and Raid2Frames.background then
                        Raid2Frames.background:ClearAllPoints()
                        Raid2Frames.background:SetPoint("BOTTOMRIGHT", Raid2Frames, 4, -4)
                        Raid2Frames.background:SetPoint("BOTTOMLEFT", Raid2Frames, 4, -4)
                        Raid2Frames.background:SetPoint("TOPLEFT", lastGroup, -4, 4)	
                    end
                end
            end

            Raid2Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
            Raid2Frames.border:RegisterEvent("RAID_ROSTER_UPDATE")
            if IsInRaid() then
                Raid2Frames.border:RegisterEvent("PLAYER_ENTERING_WORLD")
            end
            Raid2Frames.border:SetScript("OnEvent", function(self, event, ...)
                LEFT_UP_RIGHT_UP_UpdateRaid2Border()
            end)
        end

        if growth == "DOWN_LEFT" then
            local numSeparators = 4
            for i = 1, numSeparators do
                local separatorName = "separator" .. i
                local xPosition = i * raid2height + (i + 2) * 3 - 1
                
                
                if not Raid2Frames.border[separatorName] then
                    Raid2Frames.border[separatorName] = CreateFrame("Frame", nil, Raid2Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid2Frames.border[separatorName]:SetBackdrop(Private.Separator)
                    Raid2Frames.border[separatorName]:SetFrameLevel(Raid2Frames.border:GetFrameLevel() - 1)
                    Raid2Frames.border[separatorName]:SetHeight(16)
                end
                Raid2Frames.border[separatorName]:SetPoint("LEFT", Raid2Frames.border, 8, -8)
                Raid2Frames.border[separatorName]:SetPoint("TOPRIGHT", Raid2Frames.border, -8, - xPosition)
            end

            for k = 1, numGroups - 1 do 
                local vseparatorName = "vseparator" .. k

                if not Raid2Frames.border[vseparatorName] then
                    Raid2Frames.border[vseparatorName] = CreateFrame("Frame", nil, Raid2Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid2Frames.border[vseparatorName]:SetBackdrop(Private.vSeparator)
                    Raid2Frames.border[vseparatorName]:SetFrameLevel(Raid2Frames.border:GetFrameLevel() - 1)
                    Raid2Frames.border[vseparatorName]:SetWidth(16)
                end

                Raid2Frames.border[vseparatorName]:SetPoint("BOTTOM", Raid2Frames.border, 0, 8)
                Raid2Frames.border[vseparatorName]:SetPoint("TOPLEFT", _G["ElvUF_Raid2Group"..k], -4, 0)
            end
            
            local function DOWN_LEFT_UpdateRaid2Border()
                local members = GetNumGroupMembers()
                if members == 0 then return end
                
                local maxSubgroup = 1
   
                for j = 1, members do
                    local _, rank, subgroup = GetRaidRosterInfo(j)
                    if subgroup and subgroup > maxSubgroup then
                        maxSubgroup = subgroup
                    end
                end
                
                local groupnum = "ElvUF_Raid2Group" .. maxSubgroup
                local lastGroup = _G[groupnum]
                    
                for k = 1, numGroups - 1 do
                    local vseparatorName = "vseparator" .. k
                    if Raid2Frames.border[vseparatorName] then
                      if k < maxSubgroup then
                            Raid2Frames.border[vseparatorName]:Show()
                        else
                            Raid2Frames.border[vseparatorName]:Hide()
                        end
                    end
                end
                
                if lastGroup then
                    Raid2Frames.border:ClearAllPoints()
                    Raid2Frames.border:SetPoint("TOPRIGHT", Raid2Frames, 9, -9)
                    Raid2Frames.border:SetPoint("BOTTOMRIGHT", Raid2Frames, 9, -9)
                    Raid2Frames.border:SetPoint("TOPLEFT", lastGroup, -9, 9)
                    
                    if E.db.ProjectHopes.border.raid2backdrop and Raid2Frames.background then
                        Raid2Frames.background:ClearAllPoints()
                        Raid2Frames.background:SetPoint("TOPRIGHT", Raid2Frames, 4, -4)
                        Raid2Frames.background:SetPoint("BOTTOMRIGHT", Raid2Frames, 4, -4)
                        Raid2Frames.background:SetPoint("TOPLEFT", lastGroup, -4, 4)	
                    end
                end
            end

            Raid2Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
            Raid2Frames.border:RegisterEvent("RAID_ROSTER_UPDATE")
            if IsInRaid() then
                Raid2Frames.border:RegisterEvent("PLAYER_ENTERING_WORLD")
            end
            Raid2Frames.border:SetScript("OnEvent", function(self, event, ...)
                DOWN_LEFT_UpdateRaid2Border()
            end)
        end

        if growth == "DOWN_RIGHT" then
            local numSeparators = 4
            for i = 1, numSeparators do
                local separatorName = "separator" .. i
                local xPosition = i * raid2height + (i + 2) * 3 - 1
                
                
                if not Raid2Frames.border[separatorName] then
                    Raid2Frames.border[separatorName] = CreateFrame("Frame", nil, Raid2Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid2Frames.border[separatorName]:SetBackdrop(Private.Separator)
                    Raid2Frames.border[separatorName]:SetFrameLevel(Raid2Frames.border:GetFrameLevel() - 1)
                    Raid2Frames.border[separatorName]:SetHeight(16)
                end
                Raid2Frames.border[separatorName]:SetPoint("LEFT", Raid2Frames.border, 8, -8)
                Raid2Frames.border[separatorName]:SetPoint("TOPRIGHT", Raid2Frames.border, -8, - xPosition)
            end

            for k = 1, numGroups - 1 do 
                local vseparatorName = "vseparator" .. k

                if not Raid2Frames.border[vseparatorName] then
                    Raid2Frames.border[vseparatorName] = CreateFrame("Frame", nil, Raid2Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid2Frames.border[vseparatorName]:SetBackdrop(Private.vSeparator)
                    Raid2Frames.border[vseparatorName]:SetFrameLevel(Raid2Frames.border:GetFrameLevel() - 1)
                    Raid2Frames.border[vseparatorName]:SetWidth(16)
                end
                Raid2Frames.border[vseparatorName]:ClearAllPoints()
                Raid2Frames.border[vseparatorName]:SetPoint("BOTTOM", Raid2Frames.border, 0, 8)
                Raid2Frames.border[vseparatorName]:SetPoint("TOPRIGHT", _G["ElvUF_Raid2Group"..k], 15, 0)
            end
            
            local function DOWN_RIGHT_UpdateRaid2Border()
                local members = GetNumGroupMembers()
                if members == 0 then return end
                
                local maxSubgroup = 1
   
                for j = 1, members do
                    local _, rank, subgroup = GetRaidRosterInfo(j)
                    if subgroup and subgroup > maxSubgroup then
                        maxSubgroup = subgroup
                    end
                end
                
                local groupnum = "ElvUF_Raid2Group" .. maxSubgroup
                local lastGroup = _G[groupnum]
                    
                for k = 1, numGroups - 1 do
                    local vseparatorName = "vseparator" .. k
                    if Raid2Frames.border[vseparatorName] then
                      if k < maxSubgroup then
                            Raid2Frames.border[vseparatorName]:Show()
                        else
                            Raid2Frames.border[vseparatorName]:Hide()
                        end
                    end
                end
                
                if lastGroup then
                    Raid2Frames.border:ClearAllPoints()
                    Raid2Frames.border:SetPoint("TOPLEFT", Raid2Frames, -9, 9)
                    Raid2Frames.border:SetPoint("BOTTOMLEFT", Raid2Frames, 9, -9)
                    Raid2Frames.border:SetPoint("TOPRIGHT", lastGroup, 9, -9)
                    
                    if E.db.ProjectHopes.border.raid2backdrop and Raid2Frames.background then
                        Raid2Frames.background:ClearAllPoints()
                        Raid2Frames.background:SetPoint("TOPLEFT", Raid2Frames, -4, 4)
                        Raid2Frames.background:SetPoint("BOTTOMLEFT", Raid2Frames, -4, -4)
                        Raid2Frames.background:SetPoint("TOPRIGHT", lastGroup, 5, 4)	
                    end
                end
            end

            Raid2Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
            Raid2Frames.border:RegisterEvent("RAID_ROSTER_UPDATE")
            if IsInRaid() then
                Raid2Frames.border:RegisterEvent("PLAYER_ENTERING_WORLD")
            end
            Raid2Frames.border:SetScript("OnEvent", function(self, event, ...)
                DOWN_RIGHT_UpdateRaid2Border()
            end)
        end

        if growth == "UP_LEFT" then
            local numSeparators = 4
            for i = 1, numSeparators do
                local separatorName = "separator" .. i
                local xPosition = i * raid2height + (i + 2) * 3 - 1
                
                
                if not Raid2Frames.border[separatorName] then
                    Raid2Frames.border[separatorName] = CreateFrame("Frame", nil, Raid2Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid2Frames.border[separatorName]:SetBackdrop(Private.Separator)
                    Raid2Frames.border[separatorName]:SetFrameLevel(Raid2Frames.border:GetFrameLevel() - 1)
                    Raid2Frames.border[separatorName]:SetHeight(16)
                end
                Raid2Frames.border[separatorName]:SetPoint("LEFT", Raid2Frames.border, 8, -8)
                Raid2Frames.border[separatorName]:SetPoint("TOPRIGHT", Raid2Frames.border, -8, - xPosition)
            end

            for k = 1, numGroups - 1 do 
                local vseparatorName = "vseparator" .. k

                if not Raid2Frames.border[vseparatorName] then
                    Raid2Frames.border[vseparatorName] = CreateFrame("Frame", nil, Raid2Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid2Frames.border[vseparatorName]:SetBackdrop(Private.vSeparator)
                    Raid2Frames.border[vseparatorName]:SetFrameLevel(Raid2Frames.border:GetFrameLevel() - 1)
                    Raid2Frames.border[vseparatorName]:SetWidth(16)
                end
                Raid2Frames.border[vseparatorName]:ClearAllPoints()
                Raid2Frames.border[vseparatorName]:SetPoint("TOP", Raid2Frames.border, 0, -8)
                Raid2Frames.border[vseparatorName]:SetPoint("BOTTOMLEFT", _G["ElvUF_Raid2Group"..k], -4, 0)
            end
            
            local function UP_LEFT_UpdateRaid2Border()
                local members = GetNumGroupMembers()
                if members == 0 then return end
                
                local maxSubgroup = 1
   
                for j = 1, members do
                    local _, rank, subgroup = GetRaidRosterInfo(j)
                    if subgroup and subgroup > maxSubgroup then
                        maxSubgroup = subgroup
                    end
                end
                
                local groupnum = "ElvUF_Raid2Group" .. maxSubgroup
                local lastGroup = _G[groupnum]
                    
                for k = 1, numGroups - 1 do
                    local vseparatorName = "vseparator" .. k
                    if Raid2Frames.border[vseparatorName] then
                      if k < maxSubgroup then
                            Raid2Frames.border[vseparatorName]:Show()
                        else
                            Raid2Frames.border[vseparatorName]:Hide()
                        end
                    end
                end
                
                if lastGroup then
                    Raid2Frames.border:ClearAllPoints()
                    Raid2Frames.border:SetPoint("BOTTOMRIGHT", Raid2Frames, -9, 9)
                    Raid2Frames.border:SetPoint("TOPRIGHT", Raid2Frames, 9, 9)
                    Raid2Frames.border:SetPoint("BOTTOMLEFT", lastGroup, -9, -9)
                    
                    if E.db.ProjectHopes.border.raid2backdrop and Raid2Frames.background then
                        Raid2Frames.background:ClearAllPoints()
                        Raid2Frames.background:SetPoint("BOTTOMRIGHT", Raid2Frames, -4, 4)
                        Raid2Frames.background:SetPoint("TOPRIGHT", Raid2Frames, 4, 4)
                        Raid2Frames.background:SetPoint("BOTTOMLEFT", lastGroup, -4, -4)	
                    end
                end
            end

            Raid2Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
            Raid2Frames.border:RegisterEvent("RAID_ROSTER_UPDATE")
            if IsInRaid() then
                Raid2Frames.border:RegisterEvent("PLAYER_ENTERING_WORLD")
            end
            Raid2Frames.border:SetScript("OnEvent", function(self, event, ...)
                UP_LEFT_UpdateRaid2Border()
            end)
        end

        if growth == "UP_RIGHT" then
            local numSeparators = 4
            for i = 1, numSeparators do
                local separatorName = "separator" .. i
                local xPosition = i * raid2height + (i + 2) * 3 - 1
                
                
                if not Raid2Frames.border[separatorName] then
                    Raid2Frames.border[separatorName] = CreateFrame("Frame", nil, Raid2Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid2Frames.border[separatorName]:SetBackdrop(Private.Separator)
                    Raid2Frames.border[separatorName]:SetFrameLevel(Raid2Frames.border:GetFrameLevel() - 1)
                    Raid2Frames.border[separatorName]:SetHeight(16)
                end
                Raid2Frames.border[separatorName]:SetPoint("LEFT", Raid2Frames.border, 8, -8)
                Raid2Frames.border[separatorName]:SetPoint("TOPRIGHT", Raid2Frames.border, -8, - xPosition)
            end

            for k = 1, numGroups - 1 do 
                local vseparatorName = "vseparator" .. k

                if not Raid2Frames.border[vseparatorName] then
                    Raid2Frames.border[vseparatorName] = CreateFrame("Frame", nil, Raid2Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid2Frames.border[vseparatorName]:SetBackdrop(Private.vSeparator)
                    Raid2Frames.border[vseparatorName]:SetFrameLevel(Raid2Frames.border:GetFrameLevel() - 1)
                    Raid2Frames.border[vseparatorName]:SetWidth(16)
                end
                Raid2Frames.border[vseparatorName]:SetPoint("TOP", Raid2Frames.border, 0, -8)
                Raid2Frames.border[vseparatorName]:SetPoint("BOTTOMRIGHT", _G["ElvUF_Raid2Group"..k], 15, 0)
            end
            
            local function UP_RIGHT_UpdateRaid2Border()
                local members = GetNumGroupMembers()
                if members == 0 then return end
                
                local maxSubgroup = 1
   
                for j = 1, members do
                    local _, rank, subgroup = GetRaidRosterInfo(j)
                    if subgroup and subgroup > maxSubgroup then
                        maxSubgroup = subgroup
                    end
                end
                
                local groupnum = "ElvUF_Raid2Group" .. maxSubgroup
                local lastGroup = _G[groupnum]
                    
                for k = 1, numGroups - 1 do
                    local vseparatorName = "vseparator" .. k
                    if Raid2Frames.border[vseparatorName] then
                      if k < maxSubgroup then
                            Raid2Frames.border[vseparatorName]:Show()
                        else
                            Raid2Frames.border[vseparatorName]:Hide()
                        end
                    end
                end
                
                if lastGroup then
                    Raid2Frames.border:ClearAllPoints()
                    Raid2Frames.border:SetPoint("BOTTOMLEFT", Raid2Frames, 9, -9)
                    Raid2Frames.border:SetPoint("TOPLEFT", Raid2Frames, -9, 9)
                    Raid2Frames.border:SetPoint("BOTTOMRIGHT", lastGroup, 9, 9)
                    
                    if E.db.ProjectHopes.border.raid2backdrop and Raid2Frames.background then
                        Raid2Frames.background:ClearAllPoints()
                        Raid2Frames.background:SetPoint("BOTTOMLEFT", Raid2Frames, 4, -4)
                        Raid2Frames.background:SetPoint("TOPLEFT", Raid2Frames, -4, 4)
                        Raid2Frames.background:SetPoint("BOTTOMRIGHT", lastGroup, 5, 4)	
                    end
                end
            end

            Raid2Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
            Raid2Frames.border:RegisterEvent("RAID_ROSTER_UPDATE")
            if IsInRaid() then
                Raid2Frames.border:RegisterEvent("PLAYER_ENTERING_WORLD")
            end
            Raid2Frames.border:SetScript("OnEvent", function(self, event, ...)
                UP_RIGHT_UpdateRaid2Border()
            end)
        end
    end

    if name == "Raid3" and enable and E.db.ProjectHopes.border.raid3 then
        local Raid3Frames = _G["ElvUF_Raid3"]
        local raid3width = E.db.unitframe.units.raid3.width
        local raid3height = E.db.unitframe.units.raid3.height

        E.db.unitframe.units.raid3.horizontalSpacing = 3
        E.db.unitframe.units.raid3.verticalSpacing = 3

        BORDER:CreateBorder(Raid3Frames, 20, -9, 9, 9, -9)
        if E.db.ProjectHopes.border.raid3backdrop then
            BORDER:CreateBackground(Raid3Frames, -4, 4, 4, -4)
        end

        local growth = E.db.unitframe.units.raid3.growthDirection
        local numGroups = E.db.unitframe.units.raid3.numGroups

        if growth == "LEFT_DOWN" then
            local numSeparators = 4
            for i = 1, numSeparators do
                local separatorName = "separator" .. i
                local xPosition = i * raid3width + (i + 2) * 3 - 1
                
                if not Raid3Frames.border[separatorName] then
                    Raid3Frames.border[separatorName] = CreateFrame("Frame", nil, Raid3Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid3Frames.border[separatorName]:SetBackdrop(Private.vSeparator)
                    Raid3Frames.border[separatorName]:SetFrameLevel(Raid3Frames.border:GetFrameLevel() - 1)

                    Raid3Frames.border[separatorName]:SetWidth(16)
                end
                Raid3Frames.border[separatorName]:SetPoint("BOTTOMLEFT", Raid3Frames.border, 0, 8)
                Raid3Frames.border[separatorName]:SetPoint("TOPLEFT", Raid3Frames.border, xPosition, - 8)
            end

            for k = 2, numGroups do 
                local vseparatorName = "vseparator" .. k

                if not Raid3Frames.border[vseparatorName] then
                    Raid3Frames.border[vseparatorName] = CreateFrame("Frame", nil, Raid3Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid3Frames.border[vseparatorName]:SetBackdrop(Private.Separator)
                    Raid3Frames.border[vseparatorName]:SetFrameLevel(Raid3Frames.border:GetFrameLevel() - 1)
                    Raid3Frames.border[vseparatorName]:SetHeight(16)

                end
                Raid3Frames.border[vseparatorName]:SetPoint("LEFT", Raid3Frames.border, 8, 0)
                Raid3Frames.border[vseparatorName]:SetPoint("TOPRIGHT", _G["ElvUF_Raid3Group"..k], 0, 4)
            end
            
            local function LEFT_DOWN_UpdateRaid3Border()
                local members = GetNumGroupMembers()
                if members == 0 then return end
                
                local maxSubgroup = 1
                for j = 1, members do
                    local _, rank, subgroup = GetRaidRosterInfo(j)
                    if subgroup and subgroup > maxSubgroup then
                        maxSubgroup = subgroup
                    end
                end
                    
                for i = 2, numGroups do
                    local vseparatorName = "vseparator" .. i
                    if Raid3Frames.border[vseparatorName] then
                        if i <= maxSubgroup then
                            Raid3Frames.border[vseparatorName]:Show()
                        else
                            Raid3Frames.border[vseparatorName]:Hide()
                        end
                    end
                end
                
                local groupnum = "ElvUF_Raid3Group" .. maxSubgroup
                local lastGroup = _G[groupnum]
                
                if lastGroup then
                    Raid3Frames.border:ClearAllPoints()
                    Raid3Frames.border:SetPoint("TOPLEFT", Raid3Frames, -9, 9)
                    Raid3Frames.border:SetPoint("TOPRIGHT", Raid3Frames, 9, -9)
                    Raid3Frames.border:SetPoint("BOTTOMRIGHT", lastGroup, 9, -9)
                    
                    if E.db.ProjectHopes.border.raid3backdrop and Raid3Frames.background then
                        Raid3Frames.background:ClearAllPoints()
                        Raid3Frames.background:SetPoint("TOPLEFT", Raid3Frames, -4, 4)
                        Raid3Frames.background:SetPoint("TOPRIGHT", Raid3Frames, 4, -4)
                        Raid3Frames.background:SetPoint("BOTTOMRIGHT", lastGroup, 4, -4)	
                    end
                end
            end

            Raid3Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
            Raid3Frames.border:RegisterEvent("RAID_ROSTER_UPDATE")
            if IsInRaid() then
                Raid3Frames.border:RegisterEvent("PLAYER_ENTERING_WORLD")
            end
            Raid3Frames.border:SetScript("OnEvent", function(self, event, ...)
                LEFT_DOWN_UpdateRaid3Border()
            end)
        end

        if growth == "LEFT_UP" then
            local numSeparators = 4
            for i = 1, numSeparators do
                local separatorName = "separator" .. i
                local xPosition = i * raid3width + (i + 2) * 3 - 1
                
                if not Raid3Frames.border[separatorName] then
                    Raid3Frames.border[separatorName] = CreateFrame("Frame", nil, Raid3Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid3Frames.border[separatorName]:SetBackdrop(Private.vSeparator)
                    Raid3Frames.border[separatorName]:SetFrameLevel(Raid3Frames.border:GetFrameLevel() - 1)

                    Raid3Frames.border[separatorName]:SetWidth(16)
                end
                Raid3Frames.border[separatorName]:SetPoint("BOTTOMLEFT", Raid3Frames.border, 0, 8)
                Raid3Frames.border[separatorName]:SetPoint("TOPLEFT", Raid3Frames.border, xPosition, - 8)
            end

            for k = 1, numGroups - 1 do 
                local vseparatorName = "vseparator" .. k

                if not Raid3Frames.border[vseparatorName] then
                    Raid3Frames.border[vseparatorName] = CreateFrame("Frame", nil, Raid3Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid3Frames.border[vseparatorName]:SetBackdrop(Private.Separator)
                    Raid3Frames.border[vseparatorName]:SetFrameLevel(Raid3Frames.border:GetFrameLevel() - 1)
                    Raid3Frames.border[vseparatorName]:SetHeight(16)

                end
                Raid3Frames.border[vseparatorName]:SetPoint("LEFT", Raid3Frames.border, 8, 0)
                Raid3Frames.border[vseparatorName]:SetPoint("TOPRIGHT", _G["ElvUF_Raid3Group"..k], 0, 4)
            end
            
            local function LEFT_UP_UpdateRaid3Border()
                local members = GetNumGroupMembers()
                if members == 0 then return end
                
                local maxSubgroup = 1
   
                for j = 1, members do
                    local _, rank, subgroup = GetRaidRosterInfo(j)
                    if subgroup and subgroup > maxSubgroup then
                        maxSubgroup = subgroup
                    end
                end
                
                local groupnum = "ElvUF_Raid3Group" .. maxSubgroup
                local lastGroup = _G[groupnum]
                    
                for k = 1, numGroups - 1 do
                    local vseparatorName = "vseparator" .. k
                    if Raid3Frames.border[vseparatorName] then
                      if k < maxSubgroup then
                            Raid3Frames.border[vseparatorName]:Show()
                        else
                            Raid3Frames.border[vseparatorName]:Hide()
                        end
                    end
                end
                
                if lastGroup then
                    Raid3Frames.border:ClearAllPoints()
                    Raid3Frames.border:SetPoint("BOTTOMLEFT", Raid3Frames, -9, -9)
                    Raid3Frames.border:SetPoint("BOTTOMRIGHT", Raid3Frames, -9, 9)
                    Raid3Frames.border:SetPoint("TOPRIGHT", lastGroup, 9, 9)
                    
                    if E.db.ProjectHopes.border.raid3backdrop and Raid3Frames.background then
                        Raid3Frames.background:ClearAllPoints()
                        Raid3Frames.background:SetPoint("BOTTOMLEFT", Raid3Frames, -4, -4)
                        Raid3Frames.background:SetPoint("BOTTOMRIGHT", Raid3Frames, -4, 4)
                        Raid3Frames.background:SetPoint("TOPRIGHT", lastGroup, 4, 4)	
                    end
                end
            end

            Raid3Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
            Raid3Frames.border:RegisterEvent("RAID_ROSTER_UPDATE")
            if IsInRaid() then
                Raid3Frames.border:RegisterEvent("PLAYER_ENTERING_WORLD")
            end
            Raid3Frames.border:SetScript("OnEvent", function(self, event, ...)
                LEFT_UP_UpdateRaid3Border()
            end)
        end

        if growth == "RIGHT_DOWN" then
            local numSeparators = 4
            for i = 1, numSeparators do
                local separatorName = "separator" .. i
                local xPosition = i * raid3width + (i + 2) * 3 - 1
                
                if not Raid3Frames.border[separatorName] then
                    Raid3Frames.border[separatorName] = CreateFrame("Frame", nil, Raid3Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid3Frames.border[separatorName]:SetBackdrop(Private.vSeparator)
                    Raid3Frames.border[separatorName]:SetFrameLevel(Raid3Frames.border:GetFrameLevel() - 1)

                    Raid3Frames.border[separatorName]:SetWidth(16)
                end
                Raid3Frames.border[separatorName]:SetPoint("BOTTOMLEFT", Raid3Frames.border, 0, 8)
                Raid3Frames.border[separatorName]:SetPoint("TOPLEFT", Raid3Frames.border, xPosition, - 8)
            end

            for k = 2, numGroups do 
                local vseparatorName = "vseparator" .. k

                if not Raid3Frames.border[vseparatorName] then
                    Raid3Frames.border[vseparatorName] = CreateFrame("Frame", nil, Raid3Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid3Frames.border[vseparatorName]:SetBackdrop(Private.Separator)
                    Raid3Frames.border[vseparatorName]:SetFrameLevel(Raid3Frames.border:GetFrameLevel() - 1)
                    Raid3Frames.border[vseparatorName]:SetHeight(16)

                end
                Raid3Frames.border[vseparatorName]:SetPoint("RIGHT", Raid3Frames.border, -8, 0)
                Raid3Frames.border[vseparatorName]:SetPoint("TOPLEFT", _G["ElvUF_Raid3Group"..k], 0, 4)
            end
            
            local function RIGHT_DOWN_UpdateRaid3Border()
                local members = GetNumGroupMembers()
                if members == 0 then return end
                
                local maxSubgroup = 1
                for j = 1, members do
                    local _, rank, subgroup = GetRaidRosterInfo(j)
                    if subgroup and subgroup > maxSubgroup then
                        maxSubgroup = subgroup
                    end
                end
                    
                for i = 2, numGroups do
                    local vseparatorName = "vseparator" .. i
                    if Raid3Frames.border[vseparatorName] then
                        if i <= maxSubgroup then
                            Raid3Frames.border[vseparatorName]:Show()
                        else
                            Raid3Frames.border[vseparatorName]:Hide()
                        end
                    end
                end
                
                local groupnum = "ElvUF_Raid3Group" .. maxSubgroup
                local lastGroup = _G[groupnum]
                
                if lastGroup then
                    Raid3Frames.border:ClearAllPoints()
                    Raid3Frames.border:SetPoint("TOPLEFT", Raid3Frames, -9, 9)
                    Raid3Frames.border:SetPoint("TOPRIGHT", Raid3Frames, 9, -9)
                    Raid3Frames.border:SetPoint("BOTTOMLEFT", lastGroup, 9, -9)
                    
                    if E.db.ProjectHopes.border.raid3backdrop and Raid3Frames.background then
                        Raid3Frames.background:ClearAllPoints()
                        Raid3Frames.background:SetPoint("TOPLEFT", Raid3Frames, -4, 4)
                        Raid3Frames.background:SetPoint("TOPRIGHT", Raid3Frames, 4, -4)
                        Raid3Frames.background:SetPoint("BOTTOMRIGHT", lastGroup, 4, -4)	
                    end
                end
            end

            Raid3Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
            Raid3Frames.border:RegisterEvent("RAID_ROSTER_UPDATE")
            if IsInRaid() then
                Raid3Frames.border:RegisterEvent("PLAYER_ENTERING_WORLD")
            end
            Raid3Frames.border:SetScript("OnEvent", function(self, event, ...)
                RIGHT_DOWN_UpdateRaid3Border()
            end)
        end

        if growth == "RIGHT_UP" then
            local numSeparators = 4
            for i = 1, numSeparators do
                local separatorName = "separator" .. i
                local xPosition = i * raid3width + (i + 2) * 3 - 1
                
                if not Raid3Frames.border[separatorName] then
                    Raid3Frames.border[separatorName] = CreateFrame("Frame", nil, Raid3Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid3Frames.border[separatorName]:SetBackdrop(Private.vSeparator)
                    Raid3Frames.border[separatorName]:SetFrameLevel(Raid3Frames.border:GetFrameLevel() - 1)

                    Raid3Frames.border[separatorName]:SetWidth(16)
                end
                Raid3Frames.border[separatorName]:SetPoint("BOTTOMLEFT", Raid3Frames.border, 0, 8)
                Raid3Frames.border[separatorName]:SetPoint("TOPLEFT", Raid3Frames.border, xPosition, - 8)
            end

            for k = 1, numGroups - 1 do 
                local vseparatorName = "vseparator" .. k

                if not Raid3Frames.border[vseparatorName] then
                    Raid3Frames.border[vseparatorName] = CreateFrame("Frame", nil, Raid3Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid3Frames.border[vseparatorName]:SetBackdrop(Private.Separator)
                    Raid3Frames.border[vseparatorName]:SetFrameLevel(Raid3Frames.border:GetFrameLevel() - 1)
                    Raid3Frames.border[vseparatorName]:SetHeight(16)

                end
                Raid3Frames.border[vseparatorName]:SetPoint("RIGHT", Raid3Frames.border, 8, 0)
                Raid3Frames.border[vseparatorName]:SetPoint("TOPLEFT", _G["ElvUF_Raid3Group"..k], 0, 4)
            end
            
            local function LEFT_UP_RIGHT_UP_UpdateRaid3Border()
                local members = GetNumGroupMembers()
                if members == 0 then return end
                
                local maxSubgroup = 1
   
                for j = 1, members do
                    local _, rank, subgroup = GetRaidRosterInfo(j)
                    if subgroup and subgroup > maxSubgroup then
                        maxSubgroup = subgroup
                    end
                end
                
                local groupnum = "ElvUF_Raid3Group" .. maxSubgroup
                local lastGroup = _G[groupnum]
                    
                for k = 1, numGroups - 1 do
                    local vseparatorName = "vseparator" .. k
                    if Raid3Frames.border[vseparatorName] then
                      if k < maxSubgroup then
                            print(maxSubgroup)
                            Raid3Frames.border[vseparatorName]:Show()
                        else
                            Raid3Frames.border[vseparatorName]:Hide()
                        end
                    end
                end
                
                if lastGroup then
                    Raid3Frames.border:ClearAllPoints()
                    Raid3Frames.border:SetPoint("BOTTOMRIGHT", Raid3Frames, 9, -9)
                    Raid3Frames.border:SetPoint("BOTTOMLEFT", Raid3Frames, 9, -9)
                    Raid3Frames.border:SetPoint("TOPLEFT", lastGroup, -9, 9)
                    
                    if E.db.ProjectHopes.border.raid3backdrop and Raid3Frames.background then
                        Raid3Frames.background:ClearAllPoints()
                        Raid3Frames.background:SetPoint("BOTTOMRIGHT", Raid3Frames, 4, -4)
                        Raid3Frames.background:SetPoint("BOTTOMLEFT", Raid3Frames, 4, -4)
                        Raid3Frames.background:SetPoint("TOPLEFT", lastGroup, -4, 4)	
                    end
                end
            end

            Raid3Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
            Raid3Frames.border:RegisterEvent("RAID_ROSTER_UPDATE")
            if IsInRaid() then
                Raid3Frames.border:RegisterEvent("PLAYER_ENTERING_WORLD")
            end
            Raid3Frames.border:SetScript("OnEvent", function(self, event, ...)
                LEFT_UP_RIGHT_UP_UpdateRaid3Border()
            end)
        end

        if growth == "DOWN_LEFT" then
            local numSeparators = 4
            for i = 1, numSeparators do
                local separatorName = "separator" .. i
                local xPosition = i * raid3height + (i + 2) * 3 - 1
                
                if not Raid3Frames.border[separatorName] then
                    Raid3Frames.border[separatorName] = CreateFrame("Frame", nil, Raid3Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid3Frames.border[separatorName]:SetBackdrop(Private.Separator)
                    Raid3Frames.border[separatorName]:SetFrameLevel(Raid3Frames.border:GetFrameLevel() - 1)
                    Raid3Frames.border[separatorName]:SetHeight(16)
                end
                Raid3Frames.border[separatorName]:SetPoint("LEFT", Raid3Frames.border, 8, -8)
                Raid3Frames.border[separatorName]:SetPoint("TOPRIGHT", Raid3Frames.border, -8, - xPosition)
            end

            for k = 1, numGroups - 1 do 
                local vseparatorName = "vseparator" .. k

                if not Raid3Frames.border[vseparatorName] then
                    Raid3Frames.border[vseparatorName] = CreateFrame("Frame", nil, Raid3Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid3Frames.border[vseparatorName]:SetBackdrop(Private.vSeparator)
                    Raid3Frames.border[vseparatorName]:SetFrameLevel(Raid3Frames.border:GetFrameLevel() - 1)
                    Raid3Frames.border[vseparatorName]:SetWidth(16)
                end

                Raid3Frames.border[vseparatorName]:SetPoint("BOTTOM", Raid3Frames.border, 0, 8)
                Raid3Frames.border[vseparatorName]:SetPoint("TOPLEFT", _G["ElvUF_Raid3Group"..k], -4, 0)
            end
            
            local function DOWN_LEFT_UpdateRaid3Border()
                local members = GetNumGroupMembers()
                if members == 0 then return end
                
                local maxSubgroup = 1
   
                for j = 1, members do
                    local _, rank, subgroup = GetRaidRosterInfo(j)
                    if subgroup and subgroup > maxSubgroup then
                        maxSubgroup = subgroup
                    end
                end
                
                local groupnum = "ElvUF_Raid3Group" .. maxSubgroup
                local lastGroup = _G[groupnum]
                    
                for k = 1, numGroups - 1 do
                    local vseparatorName = "vseparator" .. k
                    if Raid3Frames.border[vseparatorName] then
                      if k < maxSubgroup then
                            Raid3Frames.border[vseparatorName]:Show()
                        else
                            Raid3Frames.border[vseparatorName]:Hide()
                        end
                    end
                end
                
                if lastGroup then
                    Raid3Frames.border:ClearAllPoints()
                    Raid3Frames.border:SetPoint("TOPRIGHT", Raid3Frames, 9, -9)
                    Raid3Frames.border:SetPoint("BOTTOMRIGHT", Raid3Frames, 9, -9)
                    Raid3Frames.border:SetPoint("TOPLEFT", lastGroup, -9, 9)
                    
                    if E.db.ProjectHopes.border.raid3backdrop and Raid3Frames.background then
                        Raid3Frames.background:ClearAllPoints()
                        Raid3Frames.background:SetPoint("TOPRIGHT", Raid3Frames, 4, -4)
                        Raid3Frames.background:SetPoint("BOTTOMRIGHT", Raid3Frames, 4, -4)
                        Raid3Frames.background:SetPoint("TOPLEFT", lastGroup, -4, 4)	
                    end
                end
            end

            Raid3Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
            Raid3Frames.border:RegisterEvent("RAID_ROSTER_UPDATE")
            if IsInRaid() then
                Raid3Frames.border:RegisterEvent("PLAYER_ENTERING_WORLD")
            end
            Raid3Frames.border:SetScript("OnEvent", function(self, event, ...)
                DOWN_LEFT_UpdateRaid3Border()
            end)
        end

        if growth == "DOWN_RIGHT" then
            local numSeparators = 4
            for i = 1, numSeparators do
                local separatorName = "separator" .. i
                local xPosition = i * raid3height + (i + 2) * 3 - 1
                
                if not Raid3Frames.border[separatorName] then
                    Raid3Frames.border[separatorName] = CreateFrame("Frame", nil, Raid3Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid3Frames.border[separatorName]:SetBackdrop(Private.Separator)
                    Raid3Frames.border[separatorName]:SetFrameLevel(Raid3Frames.border:GetFrameLevel() - 1)
                    Raid3Frames.border[separatorName]:SetHeight(16)
                end
                Raid3Frames.border[separatorName]:SetPoint("LEFT", Raid3Frames.border, 8, -8)
                Raid3Frames.border[separatorName]:SetPoint("TOPRIGHT", Raid3Frames.border, -8, - xPosition)
            end

            for k = 1, numGroups - 1 do 
                local vseparatorName = "vseparator" .. k

                if not Raid3Frames.border[vseparatorName] then
                    Raid3Frames.border[vseparatorName] = CreateFrame("Frame", nil, Raid3Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid3Frames.border[vseparatorName]:SetBackdrop(Private.vSeparator)
                    Raid3Frames.border[vseparatorName]:SetFrameLevel(Raid3Frames.border:GetFrameLevel() - 1)
                    Raid3Frames.border[vseparatorName]:SetWidth(16)
                end
                Raid3Frames.border[vseparatorName]:ClearAllPoints()
                Raid3Frames.border[vseparatorName]:SetPoint("BOTTOM", Raid3Frames.border, 0, 8)
                Raid3Frames.border[vseparatorName]:SetPoint("TOPRIGHT", _G["ElvUF_Raid3Group"..k], 15, 0)
            end
            
            local function DOWN_RIGHT_UpdateRaid3Border()
                local members = GetNumGroupMembers()
                if members == 0 then return end
                
                local maxSubgroup = 1
   
                for j = 1, members do
                    local _, rank, subgroup = GetRaidRosterInfo(j)
                    if subgroup and subgroup > maxSubgroup then
                        maxSubgroup = subgroup
                    end
                end
                
                local groupnum = "ElvUF_Raid3Group" .. maxSubgroup
                local lastGroup = _G[groupnum]
                    
                for k = 1, numGroups - 1 do
                    local vseparatorName = "vseparator" .. k
                    if Raid3Frames.border[vseparatorName] then
                      if k < maxSubgroup then
                            Raid3Frames.border[vseparatorName]:Show()
                        else
                            Raid3Frames.border[vseparatorName]:Hide()
                        end
                    end
                end
                
                if lastGroup then
                    Raid3Frames.border:ClearAllPoints()
                    Raid3Frames.border:SetPoint("TOPLEFT", Raid3Frames, -9, 9)
                    Raid3Frames.border:SetPoint("BOTTOMLEFT", Raid3Frames, 9, -9)
                    Raid3Frames.border:SetPoint("TOPRIGHT", lastGroup, 9, -9)
                    
                    if E.db.ProjectHopes.border.raid3backdrop and Raid3Frames.background then
                        Raid3Frames.background:ClearAllPoints()
                        Raid3Frames.background:SetPoint("TOPLEFT", Raid3Frames, -4, 4)
                        Raid3Frames.background:SetPoint("BOTTOMLEFT", Raid3Frames, -4, -4)
                        Raid3Frames.background:SetPoint("TOPRIGHT", lastGroup, 5, 4)	
                    end
                end
            end

            Raid3Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
            Raid3Frames.border:RegisterEvent("RAID_ROSTER_UPDATE")
            if IsInRaid() then
                Raid3Frames.border:RegisterEvent("PLAYER_ENTERING_WORLD")
            end
            Raid3Frames.border:SetScript("OnEvent", function(self, event, ...)
                DOWN_RIGHT_UpdateRaid3Border()
            end)
        end

        if growth == "UP_LEFT" then
            local numSeparators = 4
            for i = 1, numSeparators do
                local separatorName = "separator" .. i
                local xPosition = i * raid3height + (i + 2) * 3 - 1
                
                if not Raid3Frames.border[separatorName] then
                    Raid3Frames.border[separatorName] = CreateFrame("Frame", nil, Raid3Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid3Frames.border[separatorName]:SetBackdrop(Private.Separator)
                    Raid3Frames.border[separatorName]:SetFrameLevel(Raid3Frames.border:GetFrameLevel() - 1)
                    Raid3Frames.border[separatorName]:SetHeight(16)
                end
                Raid3Frames.border[separatorName]:SetPoint("LEFT", Raid3Frames.border, 8, -8)
                Raid3Frames.border[separatorName]:SetPoint("TOPRIGHT", Raid3Frames.border, -8, - xPosition)
            end

            for k = 1, numGroups - 1 do 
                local vseparatorName = "vseparator" .. k

                if not Raid3Frames.border[vseparatorName] then
                    Raid3Frames.border[vseparatorName] = CreateFrame("Frame", nil, Raid3Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid3Frames.border[vseparatorName]:SetBackdrop(Private.vSeparator)
                    Raid3Frames.border[vseparatorName]:SetFrameLevel(Raid3Frames.border:GetFrameLevel() - 1)
                    Raid3Frames.border[vseparatorName]:SetWidth(16)
                end
                Raid3Frames.border[vseparatorName]:ClearAllPoints()
                Raid3Frames.border[vseparatorName]:SetPoint("TOP", Raid3Frames.border, 0, -8)
                Raid3Frames.border[vseparatorName]:SetPoint("BOTTOMLEFT", _G["ElvUF_Raid3Group"..k], -4, 0)
            end
            
            local function UP_LEFT_UpdateRaid3Border()
                local members = GetNumGroupMembers()
                if members == 0 then return end
                
                local maxSubgroup = 1
   
                for j = 1, members do
                    local _, rank, subgroup = GetRaidRosterInfo(j)
                    if subgroup and subgroup > maxSubgroup then
                        maxSubgroup = subgroup
                    end
                end
                
                local groupnum = "ElvUF_Raid3Group" .. maxSubgroup
                local lastGroup = _G[groupnum]
                    
                for k = 1, numGroups - 1 do
                    local vseparatorName = "vseparator" .. k
                    if Raid3Frames.border[vseparatorName] then
                      if k < maxSubgroup then
                            Raid3Frames.border[vseparatorName]:Show()
                        else
                            Raid3Frames.border[vseparatorName]:Hide()
                        end
                    end
                end
                
                if lastGroup then
                    Raid3Frames.border:ClearAllPoints()
                    Raid3Frames.border:SetPoint("BOTTOMRIGHT", Raid3Frames, -9, 9)
                    Raid3Frames.border:SetPoint("TOPRIGHT", Raid3Frames, 9, 9)
                    Raid3Frames.border:SetPoint("BOTTOMLEFT", lastGroup, -9, -9)
                    
                    if E.db.ProjectHopes.border.raid3backdrop and Raid3Frames.background then
                        Raid3Frames.background:ClearAllPoints()
                        Raid3Frames.background:SetPoint("BOTTOMRIGHT", Raid3Frames, -4, 4)
                        Raid3Frames.background:SetPoint("TOPRIGHT", Raid3Frames, 4, 4)
                        Raid3Frames.background:SetPoint("BOTTOMLEFT", lastGroup, -4, -4)	
                    end
                end
            end

            Raid3Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
            Raid3Frames.border:RegisterEvent("RAID_ROSTER_UPDATE")
            if IsInRaid() then
                Raid3Frames.border:RegisterEvent("PLAYER_ENTERING_WORLD")
            end
            Raid3Frames.border:SetScript("OnEvent", function(self, event, ...)
                UP_LEFT_UpdateRaid3Border()
            end)
        end

        if growth == "UP_RIGHT" then
            local numSeparators = 4
            for i = 1, numSeparators do
                local separatorName = "separator" .. i
                local xPosition = i * raid3height + (i + 2) * 3 - 1
                
                if not Raid3Frames.border[separatorName] then
                    Raid3Frames.border[separatorName] = CreateFrame("Frame", nil, Raid3Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid3Frames.border[separatorName]:SetBackdrop(Private.Separator)
                    Raid3Frames.border[separatorName]:SetFrameLevel(Raid3Frames.border:GetFrameLevel() - 1)
                    Raid3Frames.border[separatorName]:SetHeight(16)
                end
                Raid3Frames.border[separatorName]:SetPoint("LEFT", Raid3Frames.border, 8, -8)
                Raid3Frames.border[separatorName]:SetPoint("TOPRIGHT", Raid3Frames.border, -8, - xPosition)
            end

            for k = 1, numGroups - 1 do 
                local vseparatorName = "vseparator" .. k

                if not Raid3Frames.border[vseparatorName] then
                    Raid3Frames.border[vseparatorName] = CreateFrame("Frame", nil, Raid3Frames, BackdropTemplateMixin and "BackdropTemplate")
                    Raid3Frames.border[vseparatorName]:SetBackdrop(Private.vSeparator)
                    Raid3Frames.border[vseparatorName]:SetFrameLevel(Raid3Frames.border:GetFrameLevel() - 1)
                    Raid3Frames.border[vseparatorName]:SetWidth(16)
                end
                Raid3Frames.border[vseparatorName]:SetPoint("TOP", Raid3Frames.border, 0, -8)
                Raid3Frames.border[vseparatorName]:SetPoint("BOTTOMRIGHT", _G["ElvUF_Raid3Group"..k], 15, 0)
            end
            
            local function UP_RIGHT_UpdateRaid3Border()
                local members = GetNumGroupMembers()
                if members == 0 then return end
                
                local maxSubgroup = 1
   
                for j = 1, members do
                    local _, rank, subgroup = GetRaidRosterInfo(j)
                    if subgroup and subgroup > maxSubgroup then
                        maxSubgroup = subgroup
                    end
                end
                
                local groupnum = "ElvUF_Raid3Group" .. maxSubgroup
                local lastGroup = _G[groupnum]
                    
                for k = 1, numGroups - 1 do
                    local vseparatorName = "vseparator" .. k
                    if Raid3Frames.border[vseparatorName] then
                      if k < maxSubgroup then
                            Raid3Frames.border[vseparatorName]:Show()
                        else
                            Raid3Frames.border[vseparatorName]:Hide()
                        end
                    end
                end
                
                if lastGroup then
                    Raid3Frames.border:ClearAllPoints()
                    Raid3Frames.border:SetPoint("BOTTOMLEFT", Raid3Frames, 9, -9)
                    Raid3Frames.border:SetPoint("TOPLEFT", Raid3Frames, -9, 9)
                    Raid3Frames.border:SetPoint("BOTTOMRIGHT", lastGroup, 9, 9)
                    
                    if E.db.ProjectHopes.border.raid3backdrop and Raid3Frames.background then
                        Raid3Frames.background:ClearAllPoints()
                        Raid3Frames.background:SetPoint("BOTTOMLEFT", Raid3Frames, 4, -4)
                        Raid3Frames.background:SetPoint("TOPLEFT", Raid3Frames, -4, 4)
                        Raid3Frames.background:SetPoint("BOTTOMRIGHT", lastGroup, 5, 4)	
                    end
                end
            end

            Raid3Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
            Raid3Frames.border:RegisterEvent("RAID_ROSTER_UPDATE")
            if IsInRaid() then
                Raid3Frames.border:RegisterEvent("PLAYER_ENTERING_WORLD")
            end
            Raid3Frames.border:SetScript("OnEvent", function(self, event, ...)
                UP_RIGHT_UpdateRaid3Border()
            end)
        end
    end

    if name == "Raid1" and enable and E.db.ProjectHopes.border.raiddps then
        for k = 1, 8 do
            for l = 1, 5 do
                local slots = {_G["ElvUF_Raid1Group"..k..'UnitButton'..l]}
                for _, button in pairs(slots) do
                    if button and not button.border then
                        if button.db.power.enable then
                            if button.db.power.width == "spaced" then
                                BORDER:CreateBorder(button.Health)

                                BORDER:CreateBorder(button.Power)
                            elseif button.db.power.width == "offset" then
                                BORDER:CreateBorder(button)

                                if button.db.power.offset > 0 then
                                    if not button.Power.border then
                                        BORDER:CreateBorder(button.Power)
                                    end
                                end
                            else
                                BORDER:CreateBorder(button)
                            end
                        else
                            BORDER:CreateBorder(button, 22, -9, 9, 9, -9)
                        end
                    end
                end
            end
        end
    end

    if name == "Raid2" and enable and E.db.ProjectHopes.border.raid2dps then
        for k = 1, 8 do
            for l = 1, 5 do
                local slots = {_G["ElvUF_Raid2Group"..k..'UnitButton'..l]}
                for _, button in pairs(slots) do
                    if button and not button.border then
                        if button.db.power.enable then
                            if button.db.power.width == "spaced" then
                                BORDER:CreateBorder(button.Health)

                                BORDER:CreateBorder(button.Power)
                            elseif button.db.power.width == "offset" then
                                BORDER:CreateBorder(button)

                                if button.db.power.offset > 0 then
                                    if not button.Power.border then
                                        BORDER:CreateBorder(button.Power)
                                    end
                                end
                            else
                                BORDER:CreateBorder(button)
                            end
                        else
                            BORDER:CreateBorder(button, 22, -9, 9, 9, -9)
                        end
                    end
                end
            end
        end
    end

    if name == "Raid3" and enable and E.db.ProjectHopes.border.raid3dps then
        for k = 1, 8 do
            for l = 1, 5 do
                local slots = {_G["ElvUF_Raid3Group"..k..'UnitButton'..l]}
                for _, button in pairs(slots) do
                    if button and not button.border then
                        if button.db.power.enable then
                            if button.db.power.width == "spaced" then
                                BORDER:CreateBorder(button.Health)

                                BORDER:CreateBorder(button.Power)
                            elseif button.db.power.width == "offset" then
                                BORDER:CreateBorder(button)

                                if button.db.power.offset > 0 then
                                    if not button.Power.border then
                                        BORDER:CreateBorder(button.Power)
                                    end
                                end
                            else
                                BORDER:CreateBorder(button)
                            end
                        else
                            BORDER:CreateBorder(button, 22, -9, 9, 9, -9)
                        end
                    end
                end
            end
        end
    end
end

function S:ElvUI_UnitFrames_PostUpdateAura(uf, _, button)
    if not E.db.ProjectHopes or not E.db.ProjectHopes.skins.unitframeAuras then return end
    if uf.isNameplate then return end

    if not button.IsBorder then
        BORDER:CreateBorder(button)
        BORDER:BindBorderColorWithBorder(button.border, button)
        button.IsBorder = true
    end

    if not button.lastColorUpdate or GetTime() - button.lastColorUpdate > 0.1 then
        local r, g, b, a = button.border:GetBackdropBorderColor()
        button.Count:SetTextColor(r, g, b, a)
        button.lastColorUpdate = GetTime()
    end
end


function S:ElvUI_UnitFrames_Configure_AuraBars(_, f)
    if not f.db or not f.db.aurabar or not f.db.aurabar.enable then return end
    for _, statusBar in ipairs(f.AuraBars) do
        S:ElvUI_UnitFrames_Construct_AuraBars(nil, statusBar)
    end
end

function S:ElvUI_UnitFrames_Construct_AuraBars(_, f)
    if not f then return end
    f.icon:SetPoint("RIGHT", f, "LEFT", -9, 0)
    for _, child in next, { f:GetChildren() } do
        if not child.IsBorder then
            BORDER:CreateBorder(child)
            child.IsBorder = true
        end
    end
end

function S:ElvUI_UnitFrames_Buffindicator(_, button)
    if not E.db.ProjectHopes.skins.unitframeAuras then
        return
    end
    
    BORDER:CreateBorder(button)
end

function S:ProfileUpdate()
    local config = E.db.ProjectHopes and E.db.ProjectHopes.border
    if not config then return end

    local units = { "player", "target", "targettarget", "focus", "focustarget", "pet", "pettarget", "targettargettarget" }
    for _, unit in ipairs(units) do
        local f = UF[unit]
        if f and UF.db.units[unit] and UF.db.units[unit].enable then
            BorderAndSeparator(f)
        end
    end

    for i = 1, 5 do
        local boss = _G["ElvUF_Boss"..i]
        if boss and config.Boss and E.db.unitframe.units.boss.enable then
            BorderAndSeparator(boss)
        end
        local arena = _G["ElvUF_Arena"..i]
        if arena and config.Arena and E.db.unitframe.units.arena.enable then
            BorderAndSeparator(arena)
        end
    end

    for i = 1, 2 do
        local tank = _G["ElvUF_TankUnitButton"..i]
        if tank and config.Maintankofftank then
            BorderAndSeparator(tank)
        end
        local assist = _G["ElvUF_AssistUnitButton"..i]
        if assist and config.AssistUnits then
            BorderAndSeparator(assist)
        end
    end
end

function S:UnitFrames()
    -- Player, Target, Target of Target, Focus, Focus Target, Pet, Pet Target, Target of Target of Target. 
	S:SecureHook(UF, "CreateAndUpdateUF", "ElvUI_UnitFrames")
    
    -- Boss and Arena.
    S:SecureHook(UF, "CreateAndUpdateUFGroup", "ElvUI_UnitFramesGroup")

    -- Party and Raid.
    S:SecureHook(UF, "CreateAndUpdateHeaderGroup", "ElvUI_UnitFramesGroupRaidParty")

    -- Aura's on Unitframes. 
    S:SecureHook(UF, "PostUpdateAura", "ElvUI_UnitFrames_PostUpdateAura")

    -- Buff indicator 
    S:SecureHook(UF, "BuffIndicator_PostCreateIcon", "ElvUI_UnitFrames_Buffindicator")

    -- Status bar
	S:SecureHook(UF, "Configure_AuraBars", "ElvUI_UnitFrames_Configure_AuraBars")
	S:SecureHook(UF, "Construct_AuraBars", "ElvUI_UnitFrames_Construct_AuraBars")

     hooksecurefunc(E, "StaggeredUpdateAll", function() S:ProfileUpdate() end)
end

S:AddCallback("UnitFrames")