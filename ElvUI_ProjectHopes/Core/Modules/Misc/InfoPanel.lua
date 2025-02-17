local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local IP = E:NewModule('InfoPanelTop', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0')

local UF = E:GetModule('UnitFrames')
local BORDER = E:GetModule('BORDER')

--modify the position of the information panel
local allowedunits = {
	['ElvUF_Player'] = true,
	['ElvUF_Target'] = true,
	['ElvUF_TargetTarget'] = true,
	['ElvUF_Focus'] = true,
	['ElvUF_FocusTarget'] = true,
	['ElvUF_Pet'] = true,
	['ElvUF_TargetTargetTarget'] = true,
}

local function Configure_InfoPanel(_, frame)
	local db = frame.db
	local isShown = frame.USE_INFO_PANEL

	frame.InfoPanel:SetShown(isShown)
    local portrait = (db.portrait.style == '3D' and frame.Portrait3D) or frame.Portrait2D
    portrait.db = db.portrait

	if isShown then
		local allowed = allowedunits[tostring(frame:GetName())] and true or false
		if allowed then
			frame.InfoPanel:ClearAllPoints()
			frame.InfoPanel:Point('BOTTOMLEFT', frame, 'TOPLEFT', 1, 0)
			frame.InfoPanel:Point('BOTTOMRIGHT', frame, 'TOPRIGHT', -1, 0)
			frame.InfoPanel:Point('TOPRIGHT', frame, 'TOPRIGHT', -1, db.infoPanel.height)
			frame.InfoPanel:Point('TOPLEFT', frame, 'TOPLEFT', 1, db.infoPanel.height)
		end
	end
end

function IP:Initialize()
	if not E.db.ProjectHopes.unitframe.infopanelontop then return end

    hooksecurefunc(UF, 'Configure_InfoPanel', Configure_InfoPanel)
end

E:RegisterModule(IP:GetName())