local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local PORTRAIT = E:GetModule('Portrait')
local UF = E:GetModule('UnitFrames')

local PP = E:NewModule('Player Portrait', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0')

function PP:PortraitCreation()
    local unit = "player"
    local parent = UF[unit]

    if UnitExists(unit) then
         PORTRAIT:CreatePortrait(unit,
            parent,
            E.db.ProjectHopes.portraits.playerSize, 
            E.db.ProjectHopes.portraits.playerframelevel, 
            E.db.ProjectHopes.portraits.playerClassBackdropColor, 
            E.db.ProjectHopes.portraits.playerClass, 
            E.db.ProjectHopes.portraits.playerMirror, 
            E.db.ProjectHopes.portraits.playerClassTexture,
            E.db.ProjectHopes.portraits.playerBorderColor
        )

        PORTRAIT:UpdatePosition(unit, 
        E.db.ProjectHopes.portraits.playerPosition, 
        E.db.ProjectHopes.portraits.playerOffsetX, 
        E.db.ProjectHopes.portraits.playerOffsetY
        )
    else
        if PORTRAIT.frames[unit] and PORTRAIT.frames[unit].frame then
            PORTRAIT.frames[unit].frame:Hide()
        end
    end

end

function PP:Initialize()
    if not (E.db.ProjectHopes.portraits.playerpor and E.db.unitframe.units.player.enable and E.private.unitframe.enable) then return end

    if not PORTRAIT.frames["player"] then
        self:PortraitCreation()
    end

	local events = { "UNIT_PORTRAIT_UPDATE", "PORTRAITS_UPDATED", "UNIT_MODEL_CHANGED", "UNIT_CONNECTION", "UNIT_ENTERED_VEHICLE", "UNIT_EXITING_VEHICLE", "UNIT_EXITED_VEHICLE", "VEHICLE_UPDATE" }
    PORTRAIT:RegisterPortraitEvents(self, events)
end

E:RegisterModule(PP:GetName())
