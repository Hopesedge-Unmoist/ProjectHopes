local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

function S:TalkingHead()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.talkinghead) then return end
	if not E.db.ProjectHopes.skins.talkingHead then return end

	local TalkingHeadFrame = _G.TalkingHeadFrame

	if E.db.general.talkingHeadFrameBackdrop then
		BORDER:CreateBorder(TalkingHeadFrame)
	else
		BORDER:CreateBorder(TalkingHeadFrame.MainFrame.Model, nil, nil, nil, nil, nil, true)
	end
end

S:AddCallback('TalkingHead')
