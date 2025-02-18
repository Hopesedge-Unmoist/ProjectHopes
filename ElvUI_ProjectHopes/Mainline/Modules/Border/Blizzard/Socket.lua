local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local format = format
local ipairs, unpack = ipairs, unpack
local GetSocketTypes = GetSocketTypes
local hooksecurefunc = hooksecurefunc

function S:Blizzard_ItemSocketingUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.socket) then return end
	if not E.db.ProjectHopes.skins.itemSocketing then return end

	local ItemSocketingFrame = _G.ItemSocketingFrame
	BORDER:CreateBorder(ItemSocketingFrame)
	BORDER:CreateBorder(_G.ItemSocketingScrollFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	_G.ItemSocketingScrollFrame:SetBackdrop()

	for i = 1, _G.MAX_NUM_SOCKETS do
		local button = _G[format('ItemSocketingSocket%d', i)]

		BORDER:CreateBorder(button)
	end

	hooksecurefunc('ItemSocketingFrame_Update', function()
		for i, socket in ipairs(_G.ItemSocketingFrame.Sockets) do
			for j = 1, _G.MAX_NUM_SOCKETS do
				local button = _G[format('ItemSocketingSocket%d', j)]
				local gemColor = GetSocketTypes(i)
				local color = E.GemTypeInfo[gemColor]
				if color then
					button.border:SetBackdropBorderColor(color.r, color.g, color.b)
				else
					button.border:SetBackdropBorderColor(1, 1, 1)
				end
			end
		end
	end)

	BORDER:CreateBorder(_G.ItemSocketingSocketButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallbackForAddon('Blizzard_ItemSocketingUI')
