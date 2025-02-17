local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

-- WarpDeplete Profile
function ProjectHopes:Setup_WarpDeplete()
	if not E:IsAddOnEnabled('WarpDeplete') and E.Retail then Private:Print('WarpDeplete ' .. L["is not installed or enabled."]) return end

	-- Profile name
	local name = 'ProjectHopes'

	-- Profile data
	WarpDepleteDB['profiles'][name] = WarpDepleteDB['profiles'][name] or {}
	WarpDepleteDB['profiles'][name] = {
		["timerSuccessColor"] = "ffffc809",
		["bar2FontSize"] = 13,
		["deathsFontSize"] = 14,
		["frameX"] = -25.00000953674316,
		["completedObjectivesColor"] = "ff82c884",
		["keyDetailsFontSize"] = 15,
		["bar3FontSize"] = 13,
		["bar1Texture"] = "HopesUI",
		["bar3TextureColor"] = "ff565657",
		["bar2Texture"] = "HopesUI",
		["frameAnchor"] = "TOPRIGHT",
		["frameY"] = -272.6998596191406,
		["timerExpiredColor"] = "ffac2f3b",
		["forcesTexture"] = "HopesUI",
		["keyFontSize"] = 15,
		["forcesOverlayTexture"] = "Health Fill",
		["timingsImprovedTimeColor"] = "ff82c884",
		["bar1FontSize"] = 13,
		["completedForcesColor"] = "ff82c884",
		["objectivesFontSize"] = 17,
		["forcesOverlayTextureColor"] = "ffff5616",
		["barHeight"] = 20,
		["timingsWorseTimeColor"] = "ffac2f3b",
		["timerFontSize"] = 30,
		["forcesTextureColor"] = "ffffc809",
		["bar1TextureColor"] = "ff565657",
		["bar2TextureColor"] = "ff565657",
		["forcesFontSize"] = 12,
		["timingsDisplayStyle"] = "hidden",
		["bar3Texture"] = "HopesUI",
		["barWidth"] = 261,
	}

	-- Profile key
	WarpDepleteDB['profileKeys'][E.mynameRealm] = name

	Private:Print(L["WarpDeplete profile has been set."])
end
