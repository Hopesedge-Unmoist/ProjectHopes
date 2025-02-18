local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local pairs = pairs
local hooksecurefunc = hooksecurefunc

function S:LookingForGuildFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.lfguild) then return end
	if not E.db.ProjectHopes.skins.lfguild then return end

	local LookingForGuildFrame = _G.LookingForGuildFrame
	BORDER:CreateBorder(LookingForGuildFrame)

	local checkbox = {
		'LookingForGuildPvPButton',
		'LookingForGuildWeekendsButton',
		'LookingForGuildWeekdaysButton',
		'LookingForGuildRPButton',
		'LookingForGuildRaidButton',
		'LookingForGuildQuestButton',
		'LookingForGuildDungeonButton',
	}

	-- skin checkboxes
	for _, v in pairs(checkbox) do
		BORDER:CreateBorder(_G[v], nil, nil, nil, nil, nil, true, true)
	end

	-- have to skin these checkboxes separate for some reason o_O
	BORDER:CreateBorder(_G.LookingForGuildTankButton.checkButton, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.LookingForGuildHealerButton.checkButton, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.LookingForGuildDamagerButton.checkButton, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(_G.LookingForGuildBrowseFrameContainerScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.LookingForGuildBrowseButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.LookingForGuildRequestButton, nil, nil, nil, nil, nil, false, true)

	_G.LookingForGuildCommentInputFrame:StripTextures()
	_G.LookingForGuildCommentInputFrame:SetTemplate()

	-- skin container buttons on browse and request page
	for i = 1, 5 do
		BORDER:CreateBorder(_G['LookingForGuildBrowseFrameContainerButton'..i], nil, nil, nil, nil, nil, false, true)
		BORDER:CreateBorder(_G['LookingForGuildAppsFrameContainerButton'..i], nil, nil, nil, nil, nil, false, true)
	end

	-- skin tabs
	for i = 1, 3 do
		BORDER:CreateBorder(_G['LookingForGuildFrameTab'..i], nil, nil, nil, nil, nil, true, true)
	end

	BORDER:CreateBorder(_G.GuildFinderRequestMembershipFrameAcceptButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.GuildFinderRequestMembershipFrameCancelButton, nil, nil, nil, nil, nil, false, true)
end

function BORDER:Blizzard_LookingForGuildUI()
	if _G.LookingForGuildFrame then -- frame exists
		BORDER:LookingForGuildFrame()
	else -- not yet, wait until it is exists
		hooksecurefunc('LookingForGuildFrame_CreateUIElements', BORDER.LookingForGuildFrame)
	end
end

S:AddCallbackForAddon('Blizzard_LookingForGuildUI')
