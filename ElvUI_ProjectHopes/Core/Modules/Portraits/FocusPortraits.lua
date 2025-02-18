local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local ElvUF = E.oUF

local FP = E:NewModule('Focus Portrait', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0');

-- Helper Functions
local function SetFocusTexture(texture)
    if UnitExists ('focus') then
        SetPortraitTexture(texture, "focus")
        return true
    end
end

local function SetClassIconTexture(texture)
    if UnitExists('focus') then
        local _, unitClass = UnitClass("focus")
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
function FP:Initialize()
    if not (E.db.ProjectHopes.border.focuspor and E.db.unitframe.units.focus.enable and E.private.unitframe.enable) then return end
    local FocusPortrait
    local FocusframeEvent = CreateFrame("Frame")
    FocusframeEvent:RegisterEvent("PLAYER_FOCUS_CHANGED")
    FocusframeEvent:RegisterEvent("PORTRAITS_UPDATED")
    FocusframeEvent:SetScript("OnEvent", function(self, event)
        if FocusPortrait then
            FocusPortrait:Hide()
            FocusPortrait = nil
        end
        if UnitExists("focus") then
            local focusHeight = ElvUF_Focus:GetHeight()
            FocusPortrait = CreateFrame("Frame", nil, ElvUF_Focus, "BackdropTemplate")
            FocusPortrait:SetSize(focusHeight + 8, focusHeight + 8)
            if E.db.unitframe.units.focus.infoPanel.enable and E.db.ProjectHopes.unitframe.infopanelontop then
                FocusPortrait:SetPoint("CENTER", ElvUF_Focus, "RIGHT", E.db.ProjectHopes.unitframe.focuspositionPortraits, E.db.unitframe.units.focus.infoPanel.height)
            else
                FocusPortrait:SetPoint("CENTER", ElvUF_Focus, "RIGHT", E.db.ProjectHopes.unitframe.focuspositionPortraits, 0)
            end
            FocusPortrait:SetFrameLevel(ElvUF_Focus:GetFrameLevel() + E.db.ProjectHopes.unitframe.framelevelPortraits)
            
            if E.db.ProjectHopes.border.classPortraits and UnitIsPlayer("focus") then
                FocusPortrait.ClassPortrait = CreateFrame("Frame", "Focus_ClassPortrait", FocusPortrait)
                FocusPortrait.ClassPortrait:SetSize(65, 65)
                FocusPortrait.ClassPortrait:SetPoint("CENTER", FocusPortrait, 0, 0)
                FocusPortrait.ClassPortrait:SetFrameLevel(ElvUF_Focus:GetFrameLevel() + E.db.ProjectHopes.unitframe.framelevelPortraits)

                -- Store the texture reference
                FocusPortrait.ClassPortraitIconTexture = FocusPortrait.ClassPortrait:CreateTexture(nil, "BACKGROUND")
                SetClassIconTexture(FocusPortrait.ClassPortraitIconTexture)
                FocusPortrait.ClassPortraitIconTexture:SetAllPoints(true)
            else
                local FocusPortraitTextureFrame = CreateTextureFrame(FocusPortrait, Private.Portrait)
                SetFocusTexture(FocusPortraitTextureFrame)  -- Call SetFocusTexture here
            end

            local FocusPortraitHeight = FocusPortrait:GetHeight()
            local FocusBorderColor, FocusBorderColorTextureFrame = CreateFrameWithTexture(FocusPortrait, FocusPortraitHeight + 19, Private.PortraitBorderColor)
            FocusBorderColor:SetFrameLevel(FocusPortrait:GetFrameLevel() + 1)  -- Set frame level relative to FocusPortrait
                
            local FocusBorder = CreateFrameWithTexture(FocusPortrait, FocusPortraitHeight + 25, Private.PortraitBorder)
            FocusBorder:SetFrameLevel(FocusBorderColor:GetFrameLevel() + 1)  -- Set frame level relative to FocusBorderColor

            local _, unitClass = UnitClass("focus")
            local isPlayer = UnitIsPlayer("focus")
            local color
            if isPlayer then
                color = ElvUF.colors.class[unitClass]
            else
                color = ElvUF.colors.reaction[UnitReaction("focus", 'player')]
            end
            FocusBorderColorTextureFrame:SetVertexColor((color and color.r) or 0.8, (color and color.g) or 0.8, (color and color.b) or 0.8, 1)
        end
    end)
end

E:RegisterModule(FP:GetName());
