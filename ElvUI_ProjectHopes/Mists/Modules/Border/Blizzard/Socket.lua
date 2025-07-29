local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local format = format
local unpack = unpack

local GetNumSockets = GetNumSockets
local GetSocketTypes = GetSocketTypes
local hooksecurefunc = hooksecurefunc

function S:Blizzard_ItemSocketingUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.socket) then return end
	if not E.db.ProjectHopes.skins.itemSocketing then return end

	local ItemSocketingFrame = _G.ItemSocketingFrame
	BORDER:CreateBorder(ItemSocketingFrame)
	BORDER:CreateBorder(_G.ItemSocketingScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)

	_G.ItemSocketingScrollFrame.backdrop:SetBackdrop(nil)

	for i = 1, _G.MAX_NUM_SOCKETS do
		local button = _G[format('ItemSocketingSocket%d', i)]

		BORDER:CreateBorder(button.backdrop)
	end

	hooksecurefunc('ItemSocketingFrame_Update', function()
		local numSockets = GetNumSockets()
		for i = 1, numSockets do
			local socket = _G['ItemSocketingSocket'..i]
			local gemColor = GetSocketTypes(i)
			local color = E.GemTypeInfo[gemColor]
			socket.backdrop.border:SetBackdrop(Private.BorderLight)
			socket.backdrop.border:SetBackdropBorderColor(color.r, color.g, color.b)
		end
	end)

	BORDER:CreateBorder(_G.ItemSocketingSocketButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallbackForAddon('Blizzard_ItemSocketingUI')
