local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next = next

function S:GuildRegistrarFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.guildregistrar) then return end
	if not E.db.ProjectHopes.skins.guildRegistrar then return end

	local GuildRegistrarFrame = _G.GuildRegistrarFrame
	BORDER:CreateBorder(GuildRegistrarFrame)
	BORDER:CreateBorder(GuildRegistrarFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(_G.GuildRegistrarFrameGoodbyeButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.GuildRegistrarFrameCancelButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.GuildRegistrarFramePurchaseButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.GuildRegistrarFrameEditBox, nil, nil, nil, nil, nil, true, false)
end

S:AddCallback('GuildRegistrarFrame')
