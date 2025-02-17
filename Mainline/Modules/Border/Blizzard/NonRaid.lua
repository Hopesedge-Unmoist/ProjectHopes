local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next = next

function S:RaidInfoFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.nonraid) then return end
	if not E.db.ProjectHopes.skins.friends then return end

	for _, button in next, {
		_G.RaidFrameConvertToRaidButton,
		_G.RaidFrameRaidInfoButton,
		_G.RaidInfoExtendButton,
		_G.RaidInfoCancelButton,
	} do
		BORDER:CreateBorder(button, nil, nil, nil, nil, nil, false, true)
	end

	local RaidInfoFrame = _G.RaidInfoFrame
	BORDER:CreateBorder(RaidInfoFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.RaidFrameAllAssistCheckButton, nil, nil, nil, nil, nil, true, true)
end

S:AddCallback('RaidInfoFrame')
