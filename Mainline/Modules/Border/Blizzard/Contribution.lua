local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local TT = E:GetModule('Tooltip')

local _G = _G
local unpack = unpack
local hooksecurefunc = hooksecurefunc

function S:Blizzard_Contribution()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.contribution) then return end
    if not E.db.ProjectHopes.skins.contribution then return end

	local MainFrame = _G.ContributionCollectionFrame
	BORDER:CreateBorder(MainFrame)

	-- Reward Tooltip
	if E.private.skins.blizzard.tooltip then
		local tt = _G.ContributionBuffTooltip
		BORDER:HandleIcon(tt.Icon)
		TT:SetStyle(tt)
	end

	hooksecurefunc(_G.ContributionMixin, 'SetupContributeButton', function(s)
		-- Skin the Contribute Buttons
		if not s.IsBorder then
			BORDER:CreateBorder(s.ContributeButton)
			s.IsBorder = true
		end

		-- Skin the StatusBar
		local statusBar = s.Status
		if statusBar and not statusBar.backdrop then
			BORDER:CreateBorder(statusBar)
		end
	end)

	-- Skin the reward icons
	hooksecurefunc(_G.ContributionMixin, 'AddReward', function(s, _, rewardID)
		local reward = s:FindOrAcquireReward(rewardID)
		if reward and not reward.backdrop then
			BORDER:CreateBorder(reward.backdrop)
		end
	end)
end

S:AddCallbackForAddon('Blizzard_Contribution')
