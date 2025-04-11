local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI);
local TG = E:NewModule('TargetGlow', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0');

local UF = E:GetModule('UnitFrames')

function TG:FrameGlow_UpdateSingleFrame(frame)
    if frame.TargetGlow then
        frame.TargetGlow:SetBackdrop(Private.TargetGlow)
        frame.TargetGlow:SetFrameLevel(21)
        frame.TargetGlow:SetFrameStrata("LOW")

        UF:FrameGlow_SetGlowColor(frame.TargetGlow, frame.unit, 'targetGlow')
    end
end

function TG:Initialize()
    if not E.db.ProjectHopes.targetGlow.foreground then return end

	self:SecureHook(UF, "FrameGlow_ElementHook", TG.FrameGlow_UpdateSingleFrame)
end

E:RegisterModule(TG:GetName())