local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local unpack = unpack
local hooksecurefunc = hooksecurefunc

function S:Blizzard_Channels()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.channels) then return end
	if not E.db.ProjectHopes.skins.channels then return end

	local channelFrame = _G.ChannelFrame
	if channelFrame then
		BORDER:CreateBorder(channelFrame.backdrop)

		BORDER:CreateBorder(channelFrame.SettingsButton, nil, nil, nil, nil, nil, false, true)
		BORDER:CreateBorder(channelFrame.NewButton, nil, nil, nil, nil, nil, false, true)

		BORDER:CreateBorder(channelFrame.ChannelRoster.ScrollFrame.scrollBar, nil, nil, nil, nil, nil, false, true)

		local channelList = channelFrame.ChannelList
		if channelList then
			BORDER:CreateBorder(channelFrame.ChannelList.ScrollBar, nil, nil, nil, nil, nil, false, true)
		end
	end

	local createChannelPopup = _G.CreateChannelPopup
	if createChannelPopup then
		BORDER:CreateBorder(createChannelPopup.backdrop)

		BORDER:CreateBorder(createChannelPopup.OKButton, nil, nil, nil, nil, nil, false, true)
		BORDER:CreateBorder(createChannelPopup.CancelButton, nil, nil, nil, nil, nil, false, true)

		BORDER:CreateBorder(createChannelPopup.Name, nil, nil, nil, nil, nil, false, true)
		BORDER:CreateBorder(createChannelPopup.Password, nil, nil, nil, nil, nil, false, true)
	end

	local voiceChatPrompt = _G.VoiceChatPromptActivateChannel
	if voiceChatPrompt then
		BORDER:CreateBorder(voiceChatPrompt.backdrop)

		BORDER:CreateBorder(voiceChatPrompt.AcceptButton, nil, nil, nil, nil, nil, false, true)
	end
end

S:AddCallbackForAddon('Blizzard_Channels')
