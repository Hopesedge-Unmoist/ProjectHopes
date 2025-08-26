local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local PORTRAIT = E:GetModule('Portrait')
local UF = E:GetModule('UnitFrames')

local TTP = E:NewModule('TargetTarget Portrait', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0');

function TTP:PortraitCreation()
    local unit = "targettarget"
    local parent = UF[unit]

    if UnitExists(unit) then
         PORTRAIT:CreatePortrait(unit,
            parent,
            E.db.ProjectHopes.portraits.targettargetSize, 
            E.db.ProjectHopes.portraits.targettargetframelevel, 
            E.db.ProjectHopes.portraits.targettargetClassBackdropColor, 
            E.db.ProjectHopes.portraits.targettargetClass, 
            E.db.ProjectHopes.portraits.targettargetMirror, 
            E.db.ProjectHopes.portraits.targettargetClassTexture,
            E.db.ProjectHopes.portraits.targettargetBorderColor
        )

        PORTRAIT:UpdatePosition(unit, 
        E.db.ProjectHopes.portraits.targettargetPosition, 
        E.db.ProjectHopes.portraits.targettargetOffsetX, 
        E.db.ProjectHopes.portraits.targettargetOffsetY
        )
    else
        if PORTRAIT.frames[unit] and PORTRAIT.frames[unit].frame then
            PORTRAIT.frames[unit].frame:Hide()
        end
    end

end

function TTP:Initialize()
    if not (E.db.ProjectHopes.portraits.targettargetpor and E.db.unitframe.units.targettarget.enable and E.private.unitframe.enable) then return end

    if not PORTRAIT.frames["targettarget"] then
        self:PortraitCreation()
    end

	local events = { "UNIT_PORTRAIT_UPDATE", "PORTRAITS_UPDATED", "UNIT_MODEL_CHANGED", "UNIT_CONNECTION", "UNIT_TARGET", "PLAYER_TARGET_CHANGED" }
    PORTRAIT:RegisterPortraitEvents(self, events)
end

E:RegisterModule(TTP:GetName())
