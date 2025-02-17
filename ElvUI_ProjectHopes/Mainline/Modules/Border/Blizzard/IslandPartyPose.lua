local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

function S:Blizzard_IslandsPartyPoseUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.islandsPartyPose) then return end
	if not E.db.ProjectHopes.skins.islandsPartyPose then return end

	local IslandsPartyPoseFrame = _G.IslandsPartyPoseFrame
	BORDER:CreateBorder(IslandsPartyPoseFrame)

	BORDER:CreateBorder(IslandsPartyPoseFrame.LeaveButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallbackForAddon('Blizzard_IslandsPartyPoseUI')
