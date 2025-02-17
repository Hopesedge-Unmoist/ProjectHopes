local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next = next
local hooksecurefunc = hooksecurefunc

local GetItemQualityByID = C_Item.GetItemQualityByID
local GetItemQualityColor = C_Item.GetItemQualityColor

function S:Blizzard_BlackMarketUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.bmah) then return end
    if not E.db.ProjectHopes.skins.blackMarket then return end

	local BlackMarketFrame = _G.BlackMarketFrame
	BORDER:CreateBorder(BlackMarketFrame)

	BORDER:CreateBorder(BlackMarketFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(_G.BlackMarketBidPriceGold)            
	BORDER:CreateBorder(BlackMarketFrame.BidButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(BlackMarketFrame.Inset)

	hooksecurefunc('BlackMarketScrollFrame_Update', function()
		for _, button in next, { BlackMarketFrame.ScrollBox.ScrollTarget:GetChildren() } do
			if not button.IsBorder then
				local button = button.Item
				BORDER:CreateBorder(button, nil, -9, 9, 9, -9)
				button.border:SetBackdrop(Private.BorderLight)
				button.border:SetBackdropBorderColor(button.IconBorder:GetVertexColor())             
				button.IsBorder = true
			end
		end
	end)
			
	BORDER:CreateBorder(BlackMarketFrame.HotDeal)
	BORDER:CreateBorder(BlackMarketFrame.HotDeal.Item)
	BlackMarketFrame.HotDeal.Item.border:SetBackdrop(Private.BorderLight)

	hooksecurefunc('BlackMarketFrame_UpdateHotItem', function(s)
		local deal = s.HotDeal
		local link = deal and deal.Name and deal:IsShown() and deal.itemLink
		if link then
			local quality = GetItemQualityByID(link)
			local r, g, b = GetItemQualityColor(quality)
			BlackMarketFrame.HotDeal.Item.border:SetBackdropBorderColor(r, g, b)
		end
	end)
end

S:AddCallbackForAddon('Blizzard_BlackMarketUI')
