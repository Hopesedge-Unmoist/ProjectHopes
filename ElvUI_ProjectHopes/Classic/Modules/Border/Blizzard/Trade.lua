local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local unpack = unpack
local CreateFrame = CreateFrame

function S:TradeFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.trade) then return end
	if not E.db.ProjectHopes.skins.trade then return end

	local TradeFrame = _G.TradeFrame
	BORDER:CreateBorder(TradeFrame)

	BORDER:CreateBorder(_G.TradeFrameTradeButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.TradeFrameCancelButton, nil, nil, nil, nil, nil, false, true)

	--BORDER:CreateBorder(_G.TradePlayerInputMoneyFrameGold, nil, nil, nil, nil, nil, true, true)
	--BORDER:CreateBorder(_G.TradePlayerInputMoneyFrameSilver, nil, nil, nil, nil, nil, true, true)
	--BORDER:CreateBorder(_G.TradePlayerInputMoneyFrameCopper, nil, nil, nil, nil, nil, true, true)

	for i = 1, _G.MAX_TRADE_ITEMS do
		local player = _G['TradePlayerItem'..i..'ItemButton']
		local recipient = _G['TradeRecipientItem'..i..'ItemButton']

		if player and recipient then
			
			BORDER:CreateBorder(player)
			BORDER:CreateBorder(player.bg)
			BORDER:CreateBorder(recipient)
			BORDER:CreateBorder(recipient.bg)

			BORDER:HandleIconBorder(player.IconBorder, player.border)
			BORDER:HandleIconBorder(recipient.IconBorder, recipient.border)
		end
	end
end

S:AddCallback('TradeFrame')
