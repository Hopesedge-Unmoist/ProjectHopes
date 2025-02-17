local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local ElvUF = E.oUF

local PP = E:NewModule('Player Portrait', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0');

-- Helper Functions
local function SetTargetTexture(texture)
    if UnitExists('player') then
        SetPortraitTexture(texture, "player")
        return true
    end
end

local function SetClassIconTexture(texture)
    if UnitExists('player') then
        local _, unitClass = UnitClass("player")
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
function PP:Initialize()
    if not (E.db.ProjectHopes.border.playerpor and E.db.unitframe.units.player.enable and E.private.unitframe.enable) then return end
    local PlayerPortrait

    local PlayerframeEvent = CreateFrame("Frame")
    PlayerframeEvent:RegisterEvent("PLAYER_ENTERING_WORLD")
    PlayerframeEvent:RegisterEvent("PORTRAITS_UPDATED")
    PlayerframeEvent:SetScript("OnEvent", function(self, event)
        if PlayerPortrait then
            PlayerPortrait:Hide()
            PlayerPortrait = nil
        end
        if UnitExists("player") then
            local playerHeight = ElvUF_Player:GetHeight()
            PlayerPortrait = CreateFrame("Frame", nil, ElvUF_Player, "BackdropTemplate")
            if E.db.unitframe.units.player.infoPanel.enable and E.db.ProjectHopes.unitframe.infopanelontop then
                PlayerPortrait:SetPoint("CENTER", ElvUF_Player, "LEFT", E.db.ProjectHopes.unitframe.playerpositionPortraits, E.db.unitframe.units.player.infoPanel.height)
            else
                PlayerPortrait:SetPoint("CENTER", ElvUF_Player, "LEFT", E.db.ProjectHopes.unitframe.playerpositionPortraits, 0)
            end

            PlayerPortrait:SetSize(playerHeight + 8, playerHeight + 8)
            PlayerPortrait:SetFrameLevel(ElvUF_Player:GetFrameLevel() + E.db.ProjectHopes.unitframe.framelevelPortraits)

            if E.db.ProjectHopes.border.classPortraits and UnitIsPlayer("player") then
                PlayerPortrait.ClassPortrait = CreateFrame("Frame", "Player_ClassPortrait", PlayerPortrait)
                PlayerPortrait.ClassPortrait:SetSize(65, 65)
                PlayerPortrait.ClassPortrait:SetPoint("CENTER", PlayerPortrait, 0, 0)
                PlayerPortrait.ClassPortrait:SetFrameLevel(ElvUF_Player:GetFrameLevel() + E.db.ProjectHopes.unitframe.framelevelPortraits)

                -- Store the texture reference
                PlayerPortrait.ClassPortraitIconTexture = PlayerPortrait.ClassPortrait:CreateTexture(nil, "BACKGROUND")
                SetClassIconTexture(PlayerPortrait.ClassPortraitIconTexture)
                PlayerPortrait.ClassPortraitIconTexture:SetAllPoints(true)
            else
                local PlayerPortraitTextureFrame = CreateTextureFrame(PlayerPortrait, Private.Portrait)
                SetTargetTexture(PlayerPortraitTextureFrame)
            end

            local PlayerBorderColor, PlayerBorderColorTextureFrame = CreateFrameWithTexture(PlayerPortrait, PlayerPortrait:GetHeight() + 19, Private.PortraitBorderColor)
            PlayerBorderColor:SetFrameLevel(PlayerPortrait:GetFrameLevel() + 1)  -- Set frame level relative to PlayerPortrait
                
            local PlayerBorder = CreateFrameWithTexture(PlayerPortrait, PlayerPortrait:GetHeight() + 25, Private.PortraitBorder)
            PlayerBorder:SetFrameLevel(PlayerBorderColor:GetFrameLevel() + 1)  -- Set frame level relative to PlayerBorderColor

            local _, unitClass = UnitClass("player")
            local isPlayer = UnitIsPlayer("player")

            local color
            if isPlayer then
                color = ElvUF.colors.class[unitClass]
            else
                color = ElvUF.colors.reaction[UnitReaction("player", 'player')]
            end
            PlayerBorderColorTextureFrame:SetVertexColor((color and color.r) or 0.8, (color and color.g) or 0.8, (color and color.b) or 0.8, 1)
        end
    end)
end

E:RegisterModule(PP:GetName());
