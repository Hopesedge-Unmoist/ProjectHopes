local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local UF = E:GetModule("UnitFrames")
local GetTime = GetTime

local function BorderAndSeparator(f)
    if not f then return end
    
    -- Cache border states to prevent redundant updates
    local hasBorder = f.border and f.border:IsShown()
    local hasHealthBorder = f.Health.border and f.Health.border:IsShown()
    local hasPowerBorder = f.Power.border and f.Power.border:IsShown()
    local hasPowerSeparator = f.Power.separator and f.Power.separator:IsShown()

    if f.POWERBAR_DETACHED or f.USE_POWERBAR_OFFSET then
        if hasBorder then
            f.border:Hide()
        end

        if not f.Health.backdrop.border then
            BORDER:CreateBorder(f.Health.backdrop)
        end
    else
        if hasHealthBorder then
            f.Health.border:Hide()
        end

        if not hasBorder then
            BORDER:CreateBorder(f, 15)
        end
    end

    if f.USE_POWERBAR and (hasBorder or f.Health.backdrop.border) then
        if f.POWERBAR_DETACHED or f.USE_POWERBAR_OFFSET then
            if not hasPowerBorder then
                BORDER:CreateBorder(f.Power.backdrop)
            end
            if hasPowerSeparator then
                f.Power.separator:Hide()
            end
        else
            if not hasPowerSeparator then
                BORDER:CreateSeparator(f.Power)
            end
            if hasPowerBorder then
                f.Power.border:Hide()
            end
        end
    end
end

function S:ElvUI_UnitFrames(_, unit)
    local frameName = gsub(E:StringTitle(unit), 't(arget)', 'T%1')
    local frame = UF[unit]
    local enabled = UF.db.units[unit].enable

    -- Player
    if frameName == 'Player' and enabled then
        if E.db.ProjectHopes.border.Player then
            local PF = UF['player']
            BorderAndSeparator(PF)
            if E.db.ProjectHopes.border.Playersep then
                if PF.Power.separator then
                    PF.Power.separator:Show()
                    PF.Power.separator:SetIgnoreParentAlpha(false)
                end
            else
                if PF.Power.separator then
                    PF.Power.separator:Hide()
                end
            end

            if E.db.unitframe.units.player.infoPanel.enable and E.db.ProjectHopes.border.infopanelontop then
                PF.border:SetPoint("TOPLEFT", PF.InfoPanel, "TOPLEFT", -8, 8)
                PF.border:SetPoint("BOTTOMRIGHT", PF.Power, "BOTTOMRIGHT", 8, -8)
                BORDER:CreateSeparator(PF.Health)
            end
        end
    end

    -- Target
    if frameName == 'Target' and enabled then
        if E.db.ProjectHopes.border.Target then
            local TF = UF['target']
            BorderAndSeparator(TF)
            if E.db.ProjectHopes.border.Targetsep then
                if TF.Power.separator then
                    TF.Power.separator:Show()
                    TF.Power.separator:SetIgnoreParentAlpha(false)
                end
            else
                if TF.Power.separator then
                    TF.Power.separator:Hide()
                end
            end
            if E.db.unitframe.units.target.infoPanel.enable and E.db.ProjectHopes.border.infopanelontop then
                TF.border:SetPoint("TOPLEFT", TF.InfoPanel, "TOPLEFT", -8, 8)
                TF.border:SetPoint("BOTTOMRIGHT", TF.Power, "BOTTOMRIGHT", 8, -8)
                BORDER:CreateSeparator(TF.Health)
            end
        end
    end

    -- Target of Target
    if frameName == 'TargetTarget' and enabled then
        if E.db.ProjectHopes.border.TargetofTarget then
            local TTF = UF['targettarget']
            BorderAndSeparator(TTF)
        end
        if E.db.unitframe.units.targettarget.infoPanel.enable and E.db.ProjectHopes.border.infopanelontop then
            TTF.border:SetPoint("TOPLEFT", TTF.InfoPanel, "TOPLEFT", -8, 8)
            TTF.border:SetPoint("BOTTOMRIGHT", TTF.Power, "BOTTOMRIGHT", 8, -8)
            BORDER:CreateSeparator(TTF.Health)
        end
    end

    -- Focus
    if frameName == 'Focus' and enabled then
        if E.db.ProjectHopes.border.Focus then
            local FF = UF['focus']
            BorderAndSeparator(FF)
        end
        if E.db.unitframe.units.focus.infoPanel.enable and E.db.ProjectHopes.border.infopanelontop then
            FF.border:SetPoint("TOPLEFT", FF.InfoPanel, "TOPLEFT", -8, 8)
            FF.border:SetPoint("BOTTOMRIGHT", FF.Power, "BOTTOMRIGHT", 8, -8)
            BORDER:CreateSeparator(FF.Health)
        end
    end

    -- Focus Target
    if frameName == 'FocusTarget' and enabled then
        if E.db.ProjectHopes.border.FocusTarget then
            local FTF = UF['focustarget']
            BorderAndSeparator(FTF)
        end
        if E.db.unitframe.units.focustarget.infoPanel.enable and E.db.ProjectHopes.border.infopanelontop then
            FTF.border:SetPoint("TOPLEFT", FTF.InfoPanel, "TOPLEFT", -8, 8)
            FTF.border:SetPoint("BOTTOMRIGHT", FTF.Power, "BOTTOMRIGHT", 8, -8)
            BORDER:CreateSeparator(FTF.Health)
        end
    end

    -- Pet
    if frameName == 'Pet' and enabled then
        if E.db.ProjectHopes.border.Pet then
            local PetFrame = UF['pet']
            BorderAndSeparator(PetFrame)
        end
        if E.db.unitframe.units.pet.infoPanel.enable and E.db.ProjectHopes.border.infopanelontop then
            PetFrame.border:SetPoint("TOPLEFT", PetFrame.InfoPanel, "TOPLEFT", -8, 8)
            PetFrame.border:SetPoint("BOTTOMRIGHT", PetFrame.Power, "BOTTOMRIGHT", 8, -8)
            BORDER:CreateSeparator(PetFrame.Health)
        end
    end

    -- Pet Target
    if frameName == 'PetTarget' and enabled then
        if E.db.ProjectHopes.border.PetTarget then
            local PettargetFrame = UF['pettarget']
            BorderAndSeparator(PettargetFrame)
        end
    end

    -- Target of Target of Target
    if frameName == 'TargetTargetTarget' and enabled then
        if E.db.ProjectHopes.border.TargetofTargetofTarget  then
            local TTTF = UF['targettargettarget']
            BorderAndSeparator(TTTF)
        end
        if E.db.unitframe.units.targettargettarget.infoPanel.enable and E.db.ProjectHopes.border.infopanelontop then
            TTTF.border:SetPoint("TOPLEFT", TTTF.InfoPanel, "TOPLEFT", -8, 8)
            TTTF.border:SetPoint("BOTTOMRIGHT", TTTF.Power, "BOTTOMRIGHT", 8, -8)
            BORDER:CreateSeparator(TTTF.Health)
        end
    end
end

function S:ElvUI_UnitFramesGroup (_, group, numGroup)
	for i = 1, numGroup do
		local unit = group..i
		local frame = UF[unit]
		local enabled = UF.db.units[group].enable

        if unit == "boss"..i and enabled then
            if E.db.ProjectHopes.border.Boss and E.db.unitframe.units.boss.enable then
                local BF = _G["ElvUF_Boss"..i]
                BorderAndSeparator(BF)
                if BF.Power.separator then
                    BF.Power.separator:SetIgnoreParentAlpha(false)
                end
                if BF.border then
                    BF.border:SetFrameLevel(22)
                    BF.border:SetPoint("TOPLEFT", BF, "TOPLEFT", -9, 9) 
                    BF.border:SetPoint("BOTTOMRIGHT", BF, "BOTTOMRIGHT", 9, -9) 
                end
            end
        end

        if unit == "arena"..i and enabled then
            if E.db.ProjectHopes.border.Arena and E.db.unitframe.units.arena.enable then
                for i = 1, 5 do
                    local AF = _G["ElvUF_Arena"..i]
                    BorderAndSeparator(AF)
                end
            end
        end
    end
end

function S:ElvUI_UnitFramesGroupRaidParty(_, group, groupFilter, template, headerTemplate, skip)
	local db = UF.db.units[group]
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

    if name == "Tank" and enable and E.db.ProjectHopes.border.Maintankofftank then
        for i = 1, 2 do 
            local TankFrame = _G["ElvUF_TankUnitButton"..i]
            BorderAndSeparator(TankFrame)
        end
    end

    if name == "Assist" and enable and E.db.ProjectHopes.border.AssistUnits then
        for i = 1, 2 do 
            local AssistFrame = _G["ElvUF_AssistUnitButton"..i]
            BorderAndSeparator(AssistFrame)
        end
    end
end

function S:ElvUI_UnitFrames_PostUpdateAura(uf, _, button)
    if not E.db.ProjectHopes.border.AuraUF then
        return
    end

    if uf.isNameplate then
        return
    end

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
	local auraBars = f.AuraBars
	local db = f.db
	if db.aurabar.enable then
		for _, statusBar in ipairs(auraBars) do
			S:ElvUI_UnitFrames_Construct_AuraBars(nil, statusBar)
		end
	end
end

function S:ElvUI_UnitFrames_Construct_AuraBars(_, f)
    if not f then return end
    
    f.icon:SetPoint("RIGHT", f, "LEFT", -9, 0)

    -- Cache processed children to prevent redundant updates
    for _, child in next, { f:GetChildren() } do
        if not child.IsBorder then
            BORDER:CreateBorder(child)
            child.IsBorder = true
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

    --Aura's on Unitframes. 
    S:SecureHook(UF, "PostUpdateAura", "ElvUI_UnitFrames_PostUpdateAura")

    -- Status bar
	S:SecureHook(UF, "Configure_AuraBars", "ElvUI_UnitFrames_Configure_AuraBars")
	S:SecureHook(UF, "Construct_AuraBars", "ElvUI_UnitFrames_Construct_AuraBars")
end

S:AddCallback("UnitFrames")