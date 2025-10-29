local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local format = format
local ipairs, unpack = ipairs, unpack
local hooksecurefunc = hooksecurefunc
local C_ItemSocketInfo_GetSocketItemInfo = C_ItemSocketInfo.GetSocketItemInfo

function S:Blizzard_ItemSocketingUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.socket) then return end
	if not E.db.ProjectHopes.skins.itemSocketing then return end

	local ItemSocketingFrame = _G.ItemSocketingFrame
	BORDER:CreateBorder(ItemSocketingFrame)
	BORDER:CreateBorder(_G.ItemSocketingScrollFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	_G.ItemSocketingScrollFrame:SetBackdrop()

	for i = 1, _G.MAX_NUM_SOCKETS do
		local button = _G.ItemSocketingFrame.SocketingContainer['Socket'..i]

		BORDER:CreateBorder(button)
	end

	hooksecurefunc('ItemSocketingFrame_Update', function()
		for i, socket in ipairs(_G.ItemSocketingFrame.SocketingContainer.SocketFrames) do
			for j = 1, _G.MAX_NUM_SOCKETS do
				local gemColor = C_ItemSocketInfo_GetSocketItemInfo(i)
				local color = E.GemTypeInfo[gemColor]
				if color then
					socket.border:SetBackdropBorderColor(color.r, color.g, color.b)
				else
					socket.border:SetBackdropBorderColor(1, 1, 1)
				end
			end
		end
	end)

	BORDER:CreateBorder(_G.ItemSocketingFrame.SocketingContainer.ApplySocketsButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallbackForAddon('Blizzard_ItemSocketingUI')
