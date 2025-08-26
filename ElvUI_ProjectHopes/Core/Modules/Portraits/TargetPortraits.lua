local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local PORTRAIT = E:GetModule('Portrait')
local UF = E:GetModule('UnitFrames')

local TP = E:NewModule('Target Portrait', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0');

function TP:PortraitCreation()
    local unit = "target"
    local parent = UF[unit]

    if UnitExists(unit) then
         PORTRAIT:CreatePortrait(unit,
            parent,
            E.db.ProjectHopes.portraits.targetSize, 
            E.db.ProjectHopes.portraits.targetframelevel, 
            E.db.ProjectHopes.portraits.targetClassBackdropColor, 
            E.db.ProjectHopes.portraits.targetClass, 
            E.db.ProjectHopes.portraits.targetMirror, 
            E.db.ProjectHopes.portraits.targetClassTexture,
            E.db.ProjectHopes.portraits.targetBorderColor
        )

        PORTRAIT:UpdatePosition(unit, 
        E.db.ProjectHopes.portraits.targetPosition, 
        E.db.ProjectHopes.portraits.targetOffsetX, 
        E.db.ProjectHopes.portraits.targetOffsetY
        )
    else
        if PORTRAIT.frames[unit] and PORTRAIT.frames[unit].frame then
            PORTRAIT.frames[unit].frame:Hide()
        end
    end

end

function TP:Initialize()
    if not (E.db.ProjectHopes.portraits.targetpor and E.db.unitframe.units.target.enable and E.private.unitframe.enable) then return end

    if not PORTRAIT.frames["target"] then
        self:PortraitCreation()
    end

	local events = { "UNIT_PORTRAIT_UPDATE", "PORTRAITS_UPDATED", "UNIT_MODEL_CHANGED", "UNIT_CONNECTION", "PLAYER_TARGET_CHANGED" }
    PORTRAIT:RegisterPortraitEvents(self, events)
end

E:RegisterModule(TP:GetName())