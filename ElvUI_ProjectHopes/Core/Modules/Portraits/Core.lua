local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local ElvUF = E.oUF
local UF = E:GetModule('UnitFrames')

local PORTRAIT = E:NewModule('Portrait', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0')

local UnitClass = UnitClass
local UnitReaction = UnitReaction
local UnitIsDead = UnitIsDead
local UnitExists = UnitExists

PORTRAIT.frames = PORTRAIT.frames or {}

function PORTRAIT:UpdateSize(unit, size)
    local refs = self.frames[unit]
    if not refs then return end

    refs.frame:SetSize(size, size)

    local width = refs.frame:GetWidth()
    refs.borderTex:SetSize(width * 1.12, width * 1.12)
end

function PORTRAIT:UpdatePosition(unit, position, offsetX, offsetY, strata)
    local refs = self.frames[unit]
    if not refs or not refs.frame then 
        return
    end
    
    if not UF or not UF[unit] then 
        refs.frame:ClearAllPoints()
        refs.frame:SetPoint("CENTER", UIParent, "CENTER", offsetX or 0, offsetY or 0)
        refs.frame:SetFrameStrata(strata or "MEDIUM")
        return
    end
    
    local parent = UF[unit]
    local frame = refs.frame
    
    position = position or "center"
    offsetX = offsetX or 0
    offsetY = offsetY or 0
    strata  = strata or "MEDIUM"
    
    local gap = 5
    
    frame:ClearAllPoints()
    
    if position == "left" then
        frame:SetPoint("RIGHT", parent, "LEFT", offsetX - gap, offsetY)
    elseif position == "right" then
        frame:SetPoint("LEFT", parent, "RIGHT", offsetX + gap, offsetY)
    elseif position == "top" then
        frame:SetPoint("BOTTOM", parent, "TOP", offsetX, offsetY + gap)
    elseif position == "bottom" then
        frame:SetPoint("TOP", parent, "BOTTOM", offsetX, offsetY - gap)
    elseif position == "topleft" then
        frame:SetPoint("BOTTOMRIGHT", parent, "TOPLEFT", offsetX - gap, offsetY + gap)
    elseif position == "topright" then
        frame:SetPoint("BOTTOMLEFT", parent, "TOPRIGHT", offsetX + gap, offsetY + gap)
    elseif position == "bottomleft" then
        frame:SetPoint("TOPRIGHT", parent, "BOTTOMLEFT", offsetX - gap, offsetY - gap)
    elseif position == "bottomright" then
        frame:SetPoint("TOPLEFT", parent, "BOTTOMRIGHT", offsetX + gap, offsetY - gap)
    elseif position == "overlay" or position == "center" then
        frame:SetPoint("CENTER", parent, "CENTER", offsetX, offsetY)
    elseif position == "leftoverlay" then
        frame:SetPoint("LEFT", parent, "LEFT", offsetX, offsetY)
    elseif position == "rightoverlay" then
        frame:SetPoint("RIGHT", parent, "RIGHT", offsetX, offsetY)
    elseif position == "topoverlay" then
        frame:SetPoint("TOP", parent, "TOP", offsetX, offsetY)
    elseif position == "bottomoverlay" then
        frame:SetPoint("BOTTOM", parent, "BOTTOM", offsetX, offsetY)
    else
        frame:SetPoint("CENTER", parent, "CENTER", offsetX, offsetY)
    end

    frame:SetFrameStrata(strata)
end

function PORTRAIT:UpdatePortrait(unit, color, classIcon, mirror, classIconTexture, borderColor, displayUnit)
    local refs = self.frames[unit]
    if not refs then return end

    local portraitUnit = unit
    if not UnitExists(unit) and displayUnit then
        portraitUnit = displayUnit
    end
    
    local media, coords = self:GetClassMedia(portraitUnit, classIconTexture)
    local c = color or { r = 1, g = 1, b = 1, a = 1 }

    self:HandleBackground(refs.bgTex, media, c)

    if classIcon and media and coords then
        self:SetPortraitTexture(refs.portraitTex, media, coords)
    else
        refs.portraitTex:SetTexCoord(0, 1, 0, 1)
        SetPortraitTexture(refs.portraitTex, portraitUnit)
    end
    
    -- Always apply mirroring last to ensure it's not overridden
    if classIcon and media and coords then
        self:Mirror(refs.portraitTex, mirror, coords)
    else
        self:Mirror(refs.portraitTex, mirror)
    end

    if borderColor then 
        local BorderColor = self:GetUnitColor(portraitUnit)
        refs.borderColorTex:SetVertexColor(BorderColor.r or 0.8, BorderColor.g or 0.8, BorderColor.b or 0.8, 1)
        refs.borderColorTex:Show()
    end

    if UnitIsDead(portraitUnit) or UnitIsGhost(portraitUnit) then
        refs.portraitTex:SetDesaturated(true)
    else
        refs.portraitTex:SetDesaturated(false)
    end
end

function PORTRAIT:CreatePortrait(unit, parent, size, framelevel, color, classIcon, mirror, classIconTexture, borderColor, displayUnit)
    parent = parent or UIParent

    local fName = unit .. "PortraitFrame"
    if self.frames[unit] and self.frames[unit].frame then
        self.frames[unit].frame:Hide()
        self.frames[unit].frame:SetParent(nil)
    end

    local portrait = CreateFrame("Frame", fName, parent)
    portrait:SetPoint("CENTER", parent, "CENTER", 0, 0)
    portrait:SetSize(size, size)
    portrait:SetFrameLevel(parent:GetFrameLevel() + framelevel)

    portrait.tex = portrait:CreateTexture(nil, "ARTWORK", nil, 2)
    portrait.tex:SetAllPoints(portrait)

    portrait.mask = portrait:CreateMaskTexture()
    portrait.mask:SetAllPoints(portrait.tex)
    portrait.mask:SetTexture(Private.Portraits.Mask, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    portrait.tex:AddMaskTexture(portrait.mask)

    portrait.bgTex = portrait:CreateTexture(nil, "BACKGROUND")
    portrait.bgTex:SetAllPoints()
    portrait.bgTex:SetTexture(Private.Portraits.Background)

    if borderColor then
        portrait.borderColor = portrait:CreateTexture(nil, "OVERLAY", nil, 2)
        portrait.borderColor:SetAllPoints()
        portrait.borderColor:SetTexture(Private.Portraits.BorderColor)
    end

    portrait.border = portrait:CreateTexture(nil, "OVERLAY", nil, 3)
    portrait.border:SetTexture(Private.Portraits.Border)
    portrait.border:SetSize(portrait:GetWidth() * 1.12 , portrait:GetWidth() * 1.12)
    portrait.border:SetPoint("CENTER", portrait, "CENTER", 0, 0)

    -- Store the displayUnit for later reference
    portrait.displayUnit = displayUnit

    self.frames[unit] = {
        frame = portrait,
        bgTex = portrait.bgTex,
        portraitTex = portrait.tex,
        borderColorTex = portrait.borderColor,
        borderTex = portrait.border,
        displayUnit = displayUnit  -- Store displayUnit in the frame reference
    }

    self:UpdateSize(unit, size)
    self:UpdatePortrait(unit, color, classIcon, mirror, classIconTexture, borderColor, displayUnit)

    if borderColor then
        local portraitUnit = (not UnitExists(unit) and displayUnit) and displayUnit or unit
        local c = self:GetUnitColor(portraitUnit)
        portrait.borderColor:SetVertexColor(c.r or 0.8, c.g or 0.8, c.b or 0.8, 1)
    end

    return portrait
end

function PORTRAIT:GetClassMedia(unit, classIconTexture)
    local _, classToken = UnitClass(unit or "player")
    local style = classIconTexture or "hd"
    local media = Private.Media.Class[style]
    local coords = media and media.texCoords and media.texCoords[classToken]
    return media, coords, classToken
end

function PORTRAIT:SetPortraitTexture(texture, media, coords)
    if not texture then return end

    if media then
        texture:SetTexture(media.texture)
        if coords then
            texture:SetTexCoord(unpack(coords))
        else
            texture:SetTexCoord(0, 1, 0, 1)
        end
    else
        texture:SetTexture(nil)
        texture:SetTexCoord(0, 1, 0, 1)
        SetPortraitTexture(texture, "player")
    end
end

function PORTRAIT:HandleBackground(background, media, color)
    if not background then return end

    local isTransparent = media and media.transparent
    local backgroundcolor = color

    if isTransparent then
        background:SetVertexColor(backgroundcolor.r, backgroundcolor.g, backgroundcolor.b, backgroundcolor.a)
        background:Show()
    else
        background:Hide()
    end
end

function PORTRAIT:GetUnitColor(unit)
    if not unit or not UnitExists(unit) then
        return { r = 0.8, g = 0.8, b = 0.8 }
    end

    local isPlayer = UnitIsPlayer(unit)
    local _, unitClass = UnitClass(unit)

    local color
    if isPlayer and unitClass then
        color = ElvUF.colors.class[unitClass]
    else
        local reaction = UnitReaction(unit, "player") or 5
        color = ElvUF.colors.reaction[reaction]
    end

    if not color then
        color = { r = 0.8, g = 0.8, b = 0.8 }
    end

    return color
end

function PORTRAIT:Mirror(texture, mirror, texCoords)
    if not texture then return end
    if texCoords then
        if #texCoords == 8 then
            if mirror then
                texture:SetTexCoord(texCoords[5], texCoords[6], texCoords[7], texCoords[8], texCoords[1], texCoords[2], texCoords[3], texCoords[4])
            else
                texture:SetTexCoord(unpack(texCoords))
            end
        elseif #texCoords == 4 then
            if mirror then
                texture:SetTexCoord(texCoords[2], texCoords[1], texCoords[3], texCoords[4])
            else
                texture:SetTexCoord(unpack(texCoords))
            end
        end
    else
        texture:SetTexCoord(mirror and 1 or 0, mirror and 0 or 1, 0, 1)
    end
end

function PORTRAIT:RegisterPortraitEvents(target, events)
    for _, event in ipairs(events) do
        target:RegisterEvent(event, "PortraitCreation")
    end
end

E:RegisterModule(PORTRAIT:GetName())