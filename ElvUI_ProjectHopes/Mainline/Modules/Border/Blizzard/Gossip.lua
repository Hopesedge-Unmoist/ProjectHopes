local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local gsub, next = gsub, next
local hooksecurefunc = hooksecurefunc

function S:GossipFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.gossip) then return end
	if not E.db.ProjectHopes.skins.gossip then return end

	local GossipFrame = _G.GossipFrame
	BORDER:CreateBorder(GossipFrame)

	BORDER:CreateBorder(_G.ItemTextFrame)
	BORDER:CreateBorder(_G.ItemTextScrollFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.GossipFrame.GreetingPanel.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.GossipFrame.GreetingPanel.GoodbyeButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallback('GossipFrame')
