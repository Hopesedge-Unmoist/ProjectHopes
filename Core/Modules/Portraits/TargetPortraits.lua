local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local ElvUF = E.oUF

local TP = E:NewModule('Target Portrait', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0');

-- Helper Functions
local function SetTargetTexture(texture)
    if UnitExists('target') then
        SetPortraitTexture(texture, "target")
        return true
    end
end

local function SetClassIconTexture(texture)
    if UnitExists('target') then
        local _, unitClass = UnitClass("target")
        if unitClass then
            texture:SetTexture(Private.ClassIcon[unitClass])
            return true
        end
    end
end

local function CreateTextureFrame(parent, texture)
    local frame = parent:CreateTexture(nil, "OVERLAY")
    frame:SetAllPoints(parent)
    frame:SetTexture(texture)
    return frame
end

local function CreateFrameWithTexture(parent, size, texture)
    local frame = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    frame:SetSize(size, size)
    frame:SetPoint("CENTER", parent, "CENTER")
    local textureFrame = CreateTextureFrame(frame, texture)
    return frame, textureFrame
end

-- Main Function
function TP:Initialize()
    if not (E.db.ProjectHopes.border.targetpor and E.db.unitframe.units.target.enable and E.private.unitframe.enable) then return end
    local TargetPortrait

    local TargetframeEvent = CreateFrame("Frame")
    TargetframeEvent:RegisterEvent("PLAYER_TARGET_CHANGED")
    TargetframeEvent:RegisterEvent("PLAYER_ENTERING_WORLD")
    TargetframeEvent:RegisterEvent("PORTRAITS_UPDATED")
    TargetframeEvent:SetScript("OnEvent", function(self, event)
        if TargetPortrait then
            TargetPortrait:Hide()
            TargetPortrait = nil
        end
        if UnitExists("target") then
            local targetHeight = ElvUF_Target:GetHeight()
            TargetPortrait = CreateFrame("Frame", nil, ElvUF_Target, "BackdropTemplate")
            TargetPortrait:SetSize(targetHeight + 8, targetHeight + 8)
            if E.db.unitframe.units.target.infoPanel.enable and E.db.ProjectHopes.unitframe.infopanelontop then
                TargetPortrait:SetPoint("CENTER", ElvUF_Target, "RIGHT", E.db.ProjectHopes.unitframe.targetpositionPortraits, E.db.unitframe.units.target.infoPanel.height)
            else
                TargetPortrait:SetPoint("CENTER", ElvUF_Target, "RIGHT", E.db.ProjectHopes.unitframe.targetpositionPortraits, 0)
            end

            TargetPortrait:SetFrameLevel(ElvUF_Target:GetFrameLevel() + E.db.ProjectHopes.unitframe.framelevelPortraits)

            if E.db.ProjectHopes.border.classPortraits and UnitIsPlayer("target") then
                TargetPortrait.ClassPortrait = CreateFrame("Frame", "Target_ClassPortrait", TargetPortrait)
                TargetPortrait.ClassPortrait:SetSize(65, 65)
                TargetPortrait.ClassPortrait:SetPoint("CENTER", TargetPortrait, 0, 0)
                TargetPortrait.ClassPortrait:SetFrameLevel(ElvUF_Target:GetFrameLevel() + E.db.ProjectHopes.unitframe.framelevelPortraits)

                -- Store the texture reference
                TargetPortrait.ClassPortraitIconTexture = TargetPortrait.ClassPortrait:CreateTexture(nil, "BACKGROUND")
                SetClassIconTexture(TargetPortrait.ClassPortraitIconTexture)
                TargetPortrait.ClassPortraitIconTexture:SetAllPoints(true)
            else
                local TargetPortraitTextureFrame = CreateTextureFrame(TargetPortrait, Private.Portrait)
                SetTargetTexture(TargetPortraitTextureFrame)
            end

            local TargetBorderColor, TargetBorderColorTextureFrame = CreateFrameWithTexture(TargetPortrait, TargetPortrait:GetHeight() + 19, Private.PortraitBorderColor)
            TargetBorderColor:SetFrameLevel(TargetPortrait:GetFrameLevel() + 1)  -- Set frame level relative to TargetPortrait
                
            local TargetBorder = CreateFrameWithTexture(TargetPortrait, TargetPortrait:GetHeight() + 25, Private.PortraitBorder)
            TargetBorder:SetFrameLevel(TargetBorderColor:GetFrameLevel() + 1)  -- Set frame level relative to TargetBorderColor

            local _, unitClass = UnitClass("target")
            local isPlayer = UnitIsPlayer("target")

            local color
            if isPlayer then
                color = ElvUF.colors.class[unitClass]
            else
                color = ElvUF.colors.reaction[UnitReaction("target", 'player')]
            end
            TargetBorderColorTextureFrame:SetVertexColor((color and color.r) or 0.8, (color and color.g) or 0.8, (color and color.b) or 0.8, 1)
        end
    end)
end

E:RegisterModule(TP:GetName());
