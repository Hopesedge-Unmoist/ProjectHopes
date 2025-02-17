local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

-- /run SubscriptionInterstitial_LoadUI(); _G.SubscriptionInterstitialFrame:Show()

function S:Blizzard_SubscriptionInterstitialUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.subscriptionInterstitial) then return end
	if not E.db.ProjectHopes.skins.subscriptionInterstitial then return end

	local SubscriptionInterstitial = _G.SubscriptionInterstitialFrame
	BORDER:CreateBorder(SubscriptionInterstitial)

	BORDER:CreateBorder(SubscriptionInterstitial.ClosePanelButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallbackForAddon('Blizzard_SubscriptionInterstitialUI')
