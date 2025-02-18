local Name, Private = ...

local E, L, V, P, G = unpack(ElvUI);
local TG = E:NewModule('TargetGlow', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0');
local EP = LibStub("LibElvUIPlugin-1.0") 
local UF = E:GetModule('UnitFrames')
local LSM = E.Libs.LSM

function TG:Update()
    for groupName in pairs(UF.headers) do  
        local group = UF[groupName]
        
        if group.GetNumChildren then
            for i=1, group:GetNumChildren() do
                local frame = select(i, group:GetChildren())
                
                if frame and frame.Health then
                    FrameGlow_UpdateSingleFrame(frame)
                elseif frame then
                    for n = 1, frame:GetNumChildren() do
                        local child = select(n, frame:GetChildren())
                        if child and child.Health then
                            FrameGlow_UpdateSingleFrame(child)
                        end
                    end
                end
            end
        end
    end
    local focusFrame = UF["focus"]
    if focusFrame and focusFrame.Health then
        FrameGlow_UpdateSingleFrame(focusFrame)
    end
    for i = 1, 8 do
        local bossFrame = UF["boss" .. i]
        if bossFrame and bossFrame.Health then
            FrameGlow_UpdateSingleFrame(bossFrame)
        end
    end
    for i = 1, 5 do
        local arenaFrame = UF["arena" .. i]
        if arenaFrame and arenaFrame.Health then
            FrameGlow_UpdateSingleFrame(arenaFrame)
        end
    end
end

function FrameGlow_UpdateSingleFrame(frame)
    if frame.TargetGlow then
        local color = E.db.unitframe.colors.frameGlow.targetGlow.color;
        frame.TargetGlow:Point("TOPLEFT", frame, -7, 7)
        frame.TargetGlow:Point("TOPRIGHT", frame, 7, 7)
        frame.TargetGlow:Point("BOTTOMRIGHT", frame, -7, -7) 
        frame.TargetGlow:Point("BOTTOMLEFT", frame, -7, -7) 

        frame.TargetGlow:SetBackdrop(Private.TargetGlow)

        frame.TargetGlow:SetFrameLevel(21)
        if E.db.ProjectHopes.targetGlow.foreground == true then
            frame.TargetGlow:SetFrameStrata("LOW")
        else 
            frame.TargetGlow:SetFrameStrata("BACKGROUND")
        end
        
        UF:FrameGlow_SetGlowColor(frame.TargetGlow, frame.unit, 'targetGlow')
    end
end

function TG:PLAYER_REGEN_DISABLED()
    self:ScheduleTimer(function()
        for i = 1, 8 do
            local bossFrame = UF["boss" .. i]
            if bossFrame and bossFrame.Health then
                FrameGlow_UpdateSingleFrame(bossFrame)
            end
        end
    end, 0.1) -- delay of 0.5 seconds
    self:Update()
end


function TG:Initialize()
    self:RegisterEvent("PLAYER_REGEN_DISABLED", "PLAYER_REGEN_DISABLED") -- Register event for entering combat
    self:RegisterEvent("PLAYER_REGEN_ENABLED", "Update") -- Register event for leaving combat
    self:RegisterEvent("PLAYER_TARGET_CHANGED", "Update")
    self:RegisterEvent("GROUP_ROSTER_UPDATE", "Update")
    self:RegisterEvent("PLAYER_ENTERING_WORLD", "Update")
    self:RegisterEvent("PLAYER_FLAGS_CHANGED", "Update")
end

E:RegisterModule(TG:GetName())
