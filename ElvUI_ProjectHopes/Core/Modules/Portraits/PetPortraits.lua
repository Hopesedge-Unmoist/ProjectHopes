local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local PORTRAIT = E:GetModule('Portrait')
local UF = E:GetModule('UnitFrames')

local PEP = E:NewModule('Pet Portrait', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0')

function PEP:PortraitCreation()
    local unit = "pet"
    local parent = UF[unit]

    if UnitExists(unit) then
         PORTRAIT:CreatePortrait(unit,
            parent,
            E.db.ProjectHopes.portraits.petSize, 
            E.db.ProjectHopes.portraits.petframelevel, 
            E.db.ProjectHopes.portraits.petClassBackdropColor, 
            E.db.ProjectHopes.portraits.petClass, 
            E.db.ProjectHopes.portraits.petMirror, 
            E.db.ProjectHopes.portraits.petClassTexture,
            E.db.ProjectHopes.portraits.petBorderColor
        )

        PORTRAIT:UpdatePosition(unit, 
        E.db.ProjectHopes.portraits.petPosition, 
        E.db.ProjectHopes.portraits.petOffsetX, 
        E.db.ProjectHopes.portraits.petOffsetY
        )
    else
        if PORTRAIT.frames[unit] and PORTRAIT.frames[unit].frame then
            PORTRAIT.frames[unit].frame:Hide()
        end
    end

end

function PEP:Initialize()
    if not (E.db.ProjectHopes.portraits.petpor and E.db.unitframe.units.pet.enable and E.private.unitframe.enable) then return end

    if not PORTRAIT.frames["pet"] then
        self:PortraitCreation()
    end

	local events = { "UNIT_PORTRAIT_UPDATE", "PORTRAITS_UPDATED", "UNIT_MODEL_CHANGED", "UNIT_CONNECTION", "UNIT_ENTERED_VEHICLE", "UNIT_EXITING_VEHICLE", "UNIT_EXITED_VEHICLE", "VEHICLE_UPDATE" }
    PORTRAIT:RegisterPortraitEvents(self, events)
end

E:RegisterModule(PEP:GetName())
