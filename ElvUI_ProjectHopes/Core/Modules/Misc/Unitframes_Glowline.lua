local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI);
local UGL = E:NewModule('UnitFramesGlowline', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0');

local EP = LibStub("LibElvUIPlugin-1.0");
local UF = E:GetModule("UnitFrames");
local S = E:GetModule('Skins')

local function UpdateGlowLinePosition(healthBar)
    if not healthBar.glowLine then return end

    local currentHealth = healthBar:GetValue()
    local minHealth, maxHealth = healthBar:GetMinMaxValues()
    if maxHealth == 0 then return end

    local healthPercentage = currentHealth / maxHealth

    local height = healthBar:GetHeight()
    local width = E.db.ProjectHopes.unitframe.unitFramesGlowlineWidth
    healthBar.glowLine:SetSize(width, height)

    if healthPercentage == 0 or healthPercentage == 1 then
        healthBar.glowLine:Hide()
    else
        healthBar.glowLine:Show()

        local reverse = false
        if healthBar.__owner and healthBar.__owner.db and healthBar.__owner.db.health then
            reverse = healthBar.__owner.db.health.reverseFill
        end

        local barWidth = healthBar:GetWidth()
        local xOffset
        if reverse then
            xOffset = -math.floor(barWidth * healthPercentage - 5 + 0.5)
            healthBar.glowLine:ClearAllPoints()
            healthBar.glowLine:SetPoint("RIGHT", healthBar, "RIGHT", xOffset, 0)
        else
            xOffset = math.floor(barWidth * healthPercentage - 5 + 0.5)
            healthBar.glowLine:ClearAllPoints()
            healthBar.glowLine:SetPoint("LEFT", healthBar, "LEFT", xOffset, 0)
        end
    end
end

local function CreateGlowLine(frame)
    if not frame.glowLine then
        frame.glowLine = frame:CreateTexture(nil, "OVERLAY")
        frame.glowLine:SetTexture(Private.Glowline);
        frame.glowLine:SetBlendMode("BLEND")

        local db = E.db.ProjectHopes.unitframe.unitFramesGlowlinecolor
        frame.glowLine:SetVertexColor(db.r, db.g, db.b, db.a)
    end

    frame:HookScript("OnValueChanged", UpdateGlowLinePosition)
end

function UGL:ElvUI_UnitFrames_Health_GlowLine(_, f)
    CreateGlowLine(f.Health)
end

function UGL:Initialize()
	if not E.db.ProjectHopes.unitframe.unitFramesGlowline then return end
    
    UGL:SecureHook(UF, "UpdateNameSettings", "ElvUI_UnitFrames_Health_GlowLine")

end

E:RegisterModule(UGL:GetName());
