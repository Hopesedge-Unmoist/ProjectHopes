local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local PORTRAIT = E:GetModule('Portrait')
local UF = E:GetModule('UnitFrames')

local FP = E:NewModule('Focus Portrait', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0');

function FP:PortraitCreation()
    local unit = "focus"
    local parent = UF[unit]

    if UnitExists(unit) then
         PORTRAIT:CreatePortrait(unit,
            parent,
            E.db.ProjectHopes.portraits.focusSize, 
            E.db.ProjectHopes.portraits.focusframelevel, 
            E.db.ProjectHopes.portraits.focusClassBackdropColor, 
            E.db.ProjectHopes.portraits.focusClass, 
            E.db.ProjectHopes.portraits.focusMirror, 
            E.db.ProjectHopes.portraits.focusClassTexture,
            E.db.ProjectHopes.portraits.focusBorderColor
        )

        PORTRAIT:UpdatePosition(unit, 
        E.db.ProjectHopes.portraits.focusPosition, 
        E.db.ProjectHopes.portraits.focusOffsetX, 
        E.db.ProjectHopes.portraits.focusOffsetY
        )
    else
        if PORTRAIT.frames[unit] and PORTRAIT.frames[unit].frame then
            PORTRAIT.frames[unit].frame:Hide()
        end
    end
end

function FP:Initialize()
    if not (E.db.ProjectHopes.portraits.focuspor and E.db.unitframe.units.focus.enable and E.private.unitframe.enable) then return end

    if not PORTRAIT.frames["focus"] then
        self:PortraitCreation()
    end

	local events = { "UNIT_PORTRAIT_UPDATE", "PORTRAITS_UPDATED", "UNIT_MODEL_CHANGED", "UNIT_CONNECTION", "PLAYER_FOCUS_CHANGED" }
    PORTRAIT:RegisterPortraitEvents(self, events)
end

E:RegisterModule(FP:GetName())
