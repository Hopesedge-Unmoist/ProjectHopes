local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next, pairs, unpack = next, pairs, unpack

local CreateFrame = CreateFrame
local hooksecurefunc = hooksecurefunc

function S:Blizzard_GuildUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.guild) then return end
	if not E.db.ProjectHopes.skins.guild then return end

	local GuildFrame = _G.GuildFrame
	BORDER:CreateBorder(_GuildFrame)

	local buttons = {
		'GuildMemberRemoveButton',
		'GuildMemberGroupInviteButton',
		'GuildAddMemberButton',
		'GuildViewLogButton',
		'GuildControlButton',
		'GuildTextEditFrameAcceptButton',
	}

	for i, button in pairs(buttons) do
		if i == 1 then
			BORDER:CreateBorder(_G[button], nil, nil, nil, nil, nil, false, true)
		else
			BORDER:CreateBorder(_G[button], nil, nil, nil, nil, nil, true, true)
		end
	end

	for i = 1, 5 do
		BORDER:CreateBorder(_G["GuildFrameTab" .. i], nil, nil, nil, nil, nil, true, true)
	end
end

function S:GuildInviteFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.guild) then return end
	if not E.db.ProjectHopes.skins.guild then return end

	local GuildInviteFrame = _G.GuildInviteFrame
	BORDER:CreateBorder(GuildInviteFrame)
	BORDER:CreateBorder(_G.GuildInviteFrameJoinButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.GuildInviteFrameDeclineButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallbackForAddon('Blizzard_GuildUI')
S:AddCallback('GuildInviteFrame')
