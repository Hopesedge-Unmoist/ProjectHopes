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
	BORDER:CreateBorder(GossipFrame.backdrop)
	BORDER:CreateBorder(_G.ItemTextScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)

	local GreetingPanel = _G.GossipFrame.GreetingPanel
	GreetingPanel.backdrop:SetBackdrop()
	BORDER:CreateBorder(GreetingPanel.ScrollBar, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(GreetingPanel.GoodbyeButton, nil, nil, nil, nil, nil, false, true)

	local ItemTextFrame = _G.ItemTextFrame
	BORDER:CreateBorder(ItemTextFrame.backdrop)
end

S:AddCallback('GossipFrame')
