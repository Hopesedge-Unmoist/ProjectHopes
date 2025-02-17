local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc

function S:Blizzard_Channels()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.channels) then return end
	if not E.db.ProjectHopes.skins.channels then return end

	local ChannelFrame = _G.ChannelFrame
	local CreateChannelPopup = _G.CreateChannelPopup

	BORDER:CreateBorder(ChannelFrame)
	BORDER:CreateBorder(CreateChannelPopup)

	BORDER:CreateBorder(ChannelFrame.SettingsButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(ChannelFrame.NewButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(ChannelFrame.ChannelRoster.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(ChannelFrame.ChannelList.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(CreateChannelPopup.OKButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(CreateChannelPopup.CancelButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(CreateChannelPopup.Name)
	BORDER:CreateBorder(CreateChannelPopup.Password)

	BORDER:CreateBorder(_G.VoiceChatPromptActivateChannel.AcceptButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallbackForAddon('Blizzard_Channels')
