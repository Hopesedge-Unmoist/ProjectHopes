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

        for i = 2, 5 do
            local unitButton = _G["ElvUF_PartyGroup1UnitButton" .. i] -- Dynamically fetch the button
            if unitButton then
                if E.db.unitframe.units.party.growthDirection == "UP_RIGHT" or 
                   E.db.unitframe.units.party.growthDirection == "UP_LEFT" or 
                   E.db.unitframe.units.party.growthDirection == "DOWN_LEFT" or 
                   E.db.unitframe.units.party.growthDirection == "DOWN_RIGHT" then
                    BORDER:CreateSeparator(unitButton, 22, nil, PartyFrame)
                else
                    BORDER:CreateVSeparator(unitButton, 22, nil, PartyFrame)
                end
            end
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
        BORDER:CreateBorder(Raid1Frames, 20, -9, 9, 9, -9)
        if E.db.ProjectHopes.border.raidbackdrop then
            BORDER:CreateBackground(Raid1Frames, -2, 2, 2, -2)
        end

        local Raid1BorderVSeparator = {}
        for i = 1, 5 do
            Raid1BorderVSeparator[i] = CreateFrame("Frame", nil, Raid1Frames, BackdropTemplateMixin and "BackdropTemplate")
            Raid1BorderVSeparator[i]:SetBackdrop(Private.vSeparator)
            Raid1BorderVSeparator[i]:SetWidth(16)
            Raid1BorderVSeparator[i]:SetFrameLevel(Raid1Frames:GetFrameLevel() + 22)
            Raid1BorderVSeparator[i]:SetPoint("TOPLEFT", _G["ElvUF_Raid1Group1UnitButton"..i], -4, 0)
            Raid1BorderVSeparator[i]:SetPoint("BOTTOMLEFT", Raid1Frames, 0, 0)
            Raid1BorderVSeparator[i]:Hide()
        end

        local Raid1BorderHSeparator = {}
        for i = 2, 8 do
            Raid1BorderHSeparator[i] = CreateFrame("Frame", nil, Raid1Frames, BackdropTemplateMixin and "BackdropTemplate")
            Raid1BorderHSeparator[i]:SetBackdrop(Private.Separator)
            Raid1BorderHSeparator[i]:SetHeight(16)
            Raid1BorderHSeparator[i]:SetFrameLevel(Raid1Frames:GetFrameLevel() + 21)
            Raid1BorderHSeparator[i]:SetPoint("TOPRIGHT", _G["ElvUF_Raid1Group"..i], 0, 4)
            Raid1BorderHSeparator[i]:SetPoint("LEFT", Raid1Frames, 0, 0)
            Raid1BorderHSeparator[i]:Hide()
        end

        local function UpdateRaid1Border()
            local members = GetNumGroupMembers()
            local maxSubgroup = 1
            for j = 1, members do
                local _, rank, subgroup = GetRaidRosterInfo(j)
                if subgroup > maxSubgroup then
                    maxSubgroup = subgroup
                end
            end
            for i = 2, 8 do
                if i <= maxSubgroup then
                    Raid1BorderHSeparator[i]:Show() 
                else
                    Raid1BorderHSeparator[i]:Hide()
                end
            end
                
            for i = 1, 5 do
                if i <= 4 then -- And this condition
                    Raid1BorderVSeparator[i]:Show()
                    Raid1BorderVSeparator[i]:SetPoint("BOTTOMLEFT", _G["ElvUF_Raid1Group"..maxSubgroup], 0, 0)
                else
                    Raid1BorderVSeparator[i]:Hide()
                end
            end
            
            local groupnum = "ElvUF_Raid1Group" .. maxSubgroup
            Raid1Frames.border:SetPoint("TOPLEFT", Raid1Frames, -9, 9)
            Raid1Frames.border:SetPoint("TOPRIGHT", Raid1Frames, 9, -9)
            Raid1Frames.border:SetPoint("BOTTOMRIGHT", groupnum, 9, -9)
            if E.db.ProjectHopes.border.raidbackdrop then
                Raid1Frames.background:SetPoint("TOPLEFT", Raid1Frames, -3, 3)
                Raid1Frames.background:SetPoint("TOPRIGHT", Raid1Frames, 3, -3)
                Raid1Frames.background:SetPoint("BOTTOMRIGHT", groupnum, 3, -3)	
            end
        end

        Raid1Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
        Raid1Frames.border:SetScript("OnEvent", function(self, event, ...)
                UpdateRaid1Border()
        end)
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

    if name == "Raid2" and enable and E.db.ProjectHopes.border.raid then
        local Raid2Frames = _G["ElvUF_Raid2"]
        BORDER:CreateBorder(Raid2Frames, 20, -9, 9, 9, -9)
        if E.db.ProjectHopes.border.raidbackdrop then
            BORDER:CreateBackground(Raid2Frames, -2, 2, 2, -2)
        end

        local Raid2BorderVSeparator = {}
        for i = 1, 5 do
            Raid2BorderVSeparator[i] = CreateFrame("Frame", nil, Raid2Frames, BackdropTemplateMixin and "BackdropTemplate")
            Raid2BorderVSeparator[i]:SetBackdrop(Private.vSeparator)
            Raid2BorderVSeparator[i]:SetWidth(16)
            Raid2BorderVSeparator[i]:SetFrameLevel(Raid2Frames:GetFrameLevel() + 22)
            Raid2BorderVSeparator[i]:SetPoint("TOPLEFT", _G["ElvUF_Raid2Group1UnitButton"..i], -4, 0)
            Raid2BorderVSeparator[i]:SetPoint("BOTTOMLEFT", Raid2Frames, 0, 0)
            Raid2BorderVSeparator[i]:Hide()
        end

        local Raid2BorderHSeparator = {}
        for i = 2, 8 do
            Raid2BorderHSeparator[i] = CreateFrame("Frame", nil, Raid2Frames, BackdropTemplateMixin and "BackdropTemplate")
            Raid2BorderHSeparator[i]:SetBackdrop(Private.Separator)
            Raid2BorderHSeparator[i]:SetHeight(16)
            Raid2BorderHSeparator[i]:SetFrameLevel(Raid2Frames:GetFrameLevel() + 21)
            Raid2BorderHSeparator[i]:SetPoint("TOPRIGHT", _G["ElvUF_Raid2Group"..i], 0, 4)
            Raid2BorderHSeparator[i]:SetPoint("LEFT", Raid2Frames, 0, 0)
            Raid2BorderHSeparator[i]:Hide()
        end

        local function UpdateRaid3Border()
            local members = GetNumGroupMembers()
            local maxSubgroup = 1
            for j = 1, members do
                local _, rank, subgroup = GetRaidRosterInfo(j)
                if subgroup > maxSubgroup then
                    maxSubgroup = subgroup
                end
            end
            for i = 2, 8 do
                if i <= maxSubgroup then
                    Raid2BorderHSeparator[i]:Show() 
                else
                    Raid2BorderHSeparator[i]:Hide()
                end
            end
                
            for i = 1, 5 do
                if i <= 4 then -- And this condition
                    Raid2BorderVSeparator[i]:Show()
                    Raid2BorderVSeparator[i]:SetPoint("BOTTOMLEFT", _G["ElvUF_Raid2Group"..maxSubgroup], 0, 0)
                else
                    Raid2BorderVSeparator[i]:Hide()
                end
            end
            
            local groupnum = "ElvUF_Raid2Group" .. maxSubgroup
            Raid2Frames.border:SetPoint("TOPLEFT", Raid2Frames, -9, 9)
            Raid2Frames.border:SetPoint("TOPRIGHT", Raid2Frames, 9, -9)
            Raid2Frames.border:SetPoint("BOTTOMRIGHT", groupnum, 9, -9)
            if E.db.ProjectHopes.border.raidbackdrop then
                Raid2Frames.background:SetPoint("TOPLEFT", Raid2Frames, -3, 3)
                Raid2Frames.background:SetPoint("TOPRIGHT", Raid2Frames, 3, -3)
                Raid2Frames.background:SetPoint("BOTTOMRIGHT", groupnum, 3, -3)	
            end
        end

        Raid2Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
        Raid2Frames.border:SetScript("OnEvent", function(self, event, ...)
                UpdateRaid3Border()
        end)
    end

    if name == "Raid2" and enable and E.db.ProjectHopes.border.raiddps then
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

    if name == "Raid3" and enable and E.db.ProjectHopes.border.raid then
        local Raid3Frames = _G["ElvUF_Raid3"]
        BORDER:CreateBorder(Raid3Frames, 20, -9, 9, 9, -9)
        if E.db.ProjectHopes.border.raidbackdrop then
            BORDER:CreateBackground(Raid3Frames, -2, 2, 2, -2)
        end

        local Raid3BorderVSeparator = {}
        for i = 1, 5 do
            Raid3BorderVSeparator[i] = CreateFrame("Frame", nil, Raid3Frames, BackdropTemplateMixin and "BackdropTemplate")
            Raid3BorderVSeparator[i]:SetBackdrop(Private.vSeparator)
            Raid3BorderVSeparator[i]:SetWidth(16)
            Raid3BorderVSeparator[i]:SetFrameLevel(Raid3Frames:GetFrameLevel() + 22)
            Raid3BorderVSeparator[i]:SetPoint("TOPLEFT", _G["ElvUF_Raid3Group1UnitButton"..i], -4, 0)
            Raid3BorderVSeparator[i]:SetPoint("BOTTOMLEFT", Raid3Frames, 0, 0)
            Raid3BorderVSeparator[i]:Hide()
        end

        local Raid3BorderHSeparator = {}
        for i = 2, 8 do
            Raid3BorderHSeparator[i] = CreateFrame("Frame", nil, Raid3Frames, BackdropTemplateMixin and "BackdropTemplate")
            Raid3BorderHSeparator[i]:SetBackdrop(Private.Separator)
            Raid3BorderHSeparator[i]:SetHeight(16)
            Raid3BorderHSeparator[i]:SetFrameLevel(Raid3Frames:GetFrameLevel() + 21)
            Raid3BorderHSeparator[i]:SetPoint("TOPRIGHT", _G["ElvUF_Raid3Group"..i], 0, 4)
            Raid3BorderHSeparator[i]:SetPoint("LEFT", Raid3Frames, 0, 0)
            Raid3BorderHSeparator[i]:Hide()
        end

        local function UpdateRaid3Border()
            local members = GetNumGroupMembers()
            local maxSubgroup = 1
            for j = 1, members do
                local _, rank, subgroup = GetRaidRosterInfo(j)
                if subgroup > maxSubgroup then
                    maxSubgroup = subgroup
                end
            end
            for i = 2, 8 do
                if i <= maxSubgroup then
                    Raid3BorderHSeparator[i]:Show() 
                else
                    Raid3BorderHSeparator[i]:Hide()
                end
            end
                
            for i = 1, 5 do
                if i <= 4 then -- And this condition
                    Raid3BorderVSeparator[i]:Show()
                    Raid3BorderVSeparator[i]:SetPoint("BOTTOMLEFT", _G["ElvUF_Raid3Group"..maxSubgroup], 0, 0)
                else
                    Raid3BorderVSeparator[i]:Hide()
                end
            end
            
            local groupnum = "ElvUF_Raid3Group" .. maxSubgroup
            Raid3Frames.border:SetPoint("TOPLEFT", Raid3Frames, -9, 9)
            Raid3Frames.border:SetPoint("TOPRIGHT", Raid3Frames, 9, -9)
            Raid3Frames.border:SetPoint("BOTTOMRIGHT", groupnum, 9, -9)
            if E.db.ProjectHopes.border.raidbackdrop then
                Raid3Frames.background:SetPoint("TOPLEFT", Raid3Frames, -3, 3)
                Raid3Frames.background:SetPoint("TOPRIGHT", Raid3Frames, 3, -3)
                Raid3Frames.background:SetPoint("BOTTOMRIGHT", groupnum, 3, -3)	
            end
        end

        Raid3Frames.border:RegisterEvent("GROUP_ROSTER_UPDATE")
        Raid3Frames.border:SetScript("OnEvent", function(self, event, ...)
                UpdateRaid3Border()
        end)
    end

    if name == "Raid3" and enable and E.db.ProjectHopes.border.raiddps then
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
    if not E.db.ProjectHopes or not E.db.ProjectHopes.border.AuraUF then return end
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
    if not E.db.ProjectHopes.border.AuraUF then
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