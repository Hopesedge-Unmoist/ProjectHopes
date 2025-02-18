local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local AceGUI = LibStub("AceGUI-3.0")
local originalCreate = AceGUI.Create

function S:ChoreTracker()
	if not E.db.ProjectHopes.skins.choreTracker then return end

    AceGUI.Create = function(self, widgetType)
        local widget = originalCreate(self, widgetType)
        
        if widgetType == "ChoreFrame" then
            -- Hook into this widget's frame after creation
            local frame = widget.frame
            S:HandleFrame(frame)
            BORDER:CreateBorder(frame)
            
        end

        return widget
    end
end

S:AddCallbackForAddon("ChoreTracker")
