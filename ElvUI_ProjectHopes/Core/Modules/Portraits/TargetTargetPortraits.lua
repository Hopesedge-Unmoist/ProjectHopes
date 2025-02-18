local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local ElvUF = E.oUF

local TTP = E:NewModule('TargetTarget Portrait', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0');

-- Helper Functions
local function SetToTTexture(texture)
    if UnitExists ('targettarget') then
        SetPortraitTexture(texture, "targettarget")
        return true
    end
end

local function SetClassIconTexture(texture)
    if UnitExists('targettarget') then
        local _, unitClass = UnitClass("targettarget")
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
function TTP:Initialize()
    if not (E.db.ProjectHopes.border.targettargetpor and E.db.unitframe.units.targettarget.enable and E.private.unitframe.enable) then return end
    local ToTPortrait
    local ToTframeEvent = CreateFrame("Frame")
    ToTframeEvent:RegisterEvent("UNIT_TARGET")
    ToTframeEvent:RegisterEvent("PLAYER_TARGET_CHANGED")
    ToTframeEvent:RegisterEvent("PLAYER_ENTERING_WORLD")
    ToTframeEvent:RegisterEvent("PLAYER_LEAVING_WORLD")
    ToTframeEvent:SetScript("OnEvent", function(self, event)
        if ToTPortrait then
            ToTPortrait:Hide()
            ToTPortrait = nil
        end
        if UnitExists("targettarget") then
            local totHeight = ElvUF_TargetTarget:GetHeight()
            ToTPortrait = CreateFrame("Frame", nil, ElvUF_TargetTarget, "BackdropTemplate")
            ToTPortrait:SetSize(totHeight + 8, totHeight + 8)
            if E.db.unitframe.units.target.infoPanel.enable and E.db.ProjectHopes.unitframe.infopanelontop then
                ToTPortrait:SetPoint("CENTER", ElvUF_TargetTarget, "RIGHT", E.db.ProjectHopes.unitframe.targettargetpositionPortraits, E.db.unitframe.units.target.infoPanel.height)
            else
                ToTPortrait:SetPoint("CENTER", ElvUF_TargetTarget, "RIGHT", E.db.ProjectHopes.unitframe.targettargetpositionPortraits, 0)
            end
            ToTPortrait:SetFrameLevel(ElvUF_TargetTarget:GetFrameLevel() + E.db.ProjectHopes.unitframe.framelevelPortraits)
            
            if E.db.ProjectHopes.border.classPortraits and UnitIsPlayer("targettarget") then
                ToTPortrait.ClassPortrait = CreateFrame("Frame", "TargetTarget_ClassPortrait", ToTPortrait)
                ToTPortrait.ClassPortrait:SetSize(65, 65)
                ToTPortrait.ClassPortrait:SetPoint("CENTER", ToTPortrait, 0, 0)
                ToTPortrait.ClassPortrait:SetFrameLevel(ElvUF_TargetTarget:GetFrameLevel() + E.db.ProjectHopes.unitframe.framelevelPortraits)

                -- Store the texture reference
                ToTPortrait.ClassPortraitIconTexture = ToTPortrait.ClassPortrait:CreateTexture(nil, "BACKGROUND")
                SetClassIconTexture(ToTPortrait.ClassPortraitIconTexture)
                ToTPortrait.ClassPortraitIconTexture:SetAllPoints(true)
            else
                local ToTPortraitTextureFrame = CreateTextureFrame(ToTPortrait, Private.Portrait)
                SetToTTexture(ToTPortraitTextureFrame)  -- Call SetToTTexture here
            end

            local ToTPortraitHeight = ToTPortrait:GetHeight()
            local ToTBorderColor, ToTBorderColorTextureFrame = CreateFrameWithTexture(ToTPortrait, ToTPortraitHeight + 19, Private.PortraitBorderColor)
            ToTBorderColor:SetFrameLevel(ToTPortrait:GetFrameLevel() + 1)  -- Set frame level relative to ToTPortrait
                
            local ToTBorder = CreateFrameWithTexture(ToTPortrait, ToTPortraitHeight + 25, Private.PortraitBorder)
            ToTBorder:SetFrameLevel(ToTBorderColor:GetFrameLevel() + 1)  -- Set frame level relative to ToTBorderColor

            local _, unitClass = UnitClass("targettarget")
            local isPlayer = UnitIsPlayer("targettarget")
            local color
            if isPlayer then
                color = ElvUF.colors.class[unitClass]
            else
                color = ElvUF.colors.reaction[UnitReaction("targettarget", 'player')]
            end
            ToTBorderColorTextureFrame:SetVertexColor((color and color.r) or 0.8, (color and color.g) or 0.8, (color and color.b) or 0.8, 1)
        end
    end)
end

E:RegisterModule(TTP:GetName());
