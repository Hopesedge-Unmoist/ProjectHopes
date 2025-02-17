local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc

function S:Blizzard_TorghastLevelPicker()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.torghastLevelPicker) then return end
	if not E.db.ProjectHopes.skins.torghastLevelPicker then return end

	local TorghastLevelPickerFrame = _G.TorghastLevelPickerFrame
	BORDER:CreateBorder(TorghastLevelPickerFrame.OpenPortalButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallbackForAddon('Blizzard_TorghastLevelPicker')
