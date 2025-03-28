local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI);
local UGL = E:NewModule('UnitFramesGlowline', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0');

local EP = LibStub("LibElvUIPlugin-1.0");
local UF = E:GetModule("UnitFrames");

local function UpdateGlowLinePosition(healthBar)
    if not healthBar.glowLine then return end

    local currentHealth = healthBar:GetValue()
    local maxHealth = select(2, healthBar:GetMinMaxValues())
    local healthPercentage = currentHealth / maxHealth

    local height = healthBar:GetHeight()
    local width = E.db.ProjectHopes.unitframe.unitFramesGlowlineWidth
    healthBar.glowLine:SetSize(width, height)

    if healthPercentage == 0 or healthPercentage == 1 then
        healthBar.glowLine:Hide()
    else
        healthBar.glowLine:Show()
        local xOffset = math.floor(healthBar:GetWidth() * healthPercentage - 5 + 0.5)
        healthBar.glowLine:SetPoint("LEFT", healthBar, "LEFT", xOffset, 0)    end
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