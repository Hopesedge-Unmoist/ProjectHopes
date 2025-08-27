local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local PORTRAIT = E:GetModule('Portrait')
local UF = E:GetModule('UnitFrames')

local BP = E:NewModule('Boss Portrait', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0');

function BP:PortraitCreation(forceShow, displayUnit)
    for i = 1, 8 do
        local unit = "boss" .. i
        local parent = UF[unit]

        if UnitExists(unit) or forceShow then
            PORTRAIT:CreatePortrait(unit,
                parent,
                E.db.ProjectHopes.portraits.bossSize,
                E.db.ProjectHopes.portraits.bossframelevel,
                E.db.ProjectHopes.portraits.bossClassBackdropColor,
                E.db.ProjectHopes.portraits.bossClass,
                E.db.ProjectHopes.portraits.bossMirror,
                E.db.ProjectHopes.portraits.bossClassTexture,
                E.db.ProjectHopes.portraits.bossBorderColor,
                displayUnit -- only passed in if hook says so
            )

            PORTRAIT:UpdatePosition(unit, 
                E.db.ProjectHopes.portraits.bossPosition, 
                E.db.ProjectHopes.portraits.bossOffsetX, 
                E.db.ProjectHopes.portraits.bossOffsetY
            )

            if forceShow and PORTRAIT.frames[unit] and PORTRAIT.frames[unit].frame then
                PORTRAIT.frames[unit].frame:Show()
            end
        else
            if PORTRAIT.frames[unit] and PORTRAIT.frames[unit].frame then
                PORTRAIT.frames[unit].frame:Hide()
                -- Clear stored displayUnit when test mode ends
                PORTRAIT.frames[unit].displayUnit = nil
                PORTRAIT.frames[unit].frame.displayUnit = nil
            end
        end
    end

    -- If no displayUnit was passed, clear all existing ones
    if not displayUnit then
        for i = 1, 8 do
            local unit = "boss" .. i
            if PORTRAIT.frames[unit] then
                PORTRAIT.frames[unit].displayUnit = nil
                if PORTRAIT.frames[unit].frame then
                    PORTRAIT.frames[unit].frame.displayUnit = nil
                end
            end
        end
    end
end

function BP:Initialize()
    if not (E.db.ProjectHopes.portraits.bosspor and E.db.unitframe.units.boss.enable and E.private.unitframe.enable) then return end

    for i = 1, 8 do
        if not PORTRAIT.frames["boss" .. i] then
            self:PortraitCreation()
        end
    end

    local events = { "UNIT_PORTRAIT_UPDATE", "PORTRAITS_UPDATED", "UNIT_MODEL_CHANGED", "UNIT_TARGETABLE_CHANGED", "INSTANCE_ENCOUNTER_ENGAGE_UNIT" }
    PORTRAIT:RegisterPortraitEvents(self, events)

    hooksecurefunc(UF, "ToggleForceShowGroupFrames", function(_, groupType, maxFrames)
        if groupType == "boss" then
            -- only here we decide to use "player"
            self:PortraitCreation(true, "player")
        end
    end)
end

E:RegisterModule(BP:GetName())
