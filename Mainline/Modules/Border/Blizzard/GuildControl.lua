local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local unpack = unpack
local hooksecurefunc = hooksecurefunc
local GuildControlGetNumRanks = GuildControlGetNumRanks
local GetNumGuildBankTabs = GetNumGuildBankTabs

local function SkinGuildRanks()
	for i=1, GuildControlGetNumRanks() do
		local rankFrame = _G['GuildControlUIRankOrderFrameRank'..i]
		if rankFrame then
			if not rankFrame.nameBox.backdrop then
				BORDER:CreateBorder(rankFrame.nameBox, nil, nil, nil, nil, nil, true, false)

				BORDER:CreateBorder(rankFrame.downButton, nil, nil, nil, nil, nil, false, true)
				BORDER:CreateBorder(rankFrame.upButton, nil, nil, nil, nil, nil, false, true)
				BORDER:CreateBorder(rankFrame.deleteButton, nil, nil, nil, nil, nil, false, true)
			end
		end
	end
end

local function SkinBankTabs()
	local numTabs = GetNumGuildBankTabs()
	if numTabs < _G.MAX_BUY_GUILDBANK_TABS then
		numTabs = numTabs + 1
	end

	for i=1, numTabs do
		local tab = _G['GuildControlBankTab'..i]
		if not tab then break end

		local buy = tab.buy
		if buy and buy.button and not buy.button.IsBorder then
			BORDER:CreateBorder(buy.button, nil, nil, nil, nil, nil, false, true)
			buy.button.IsBorder = true
		end

		local owned = tab.owned
		if owned then
			owned.tabIcon:SetTexCoord(unpack(E.TexCoords))

			if owned.editBox and not owned.editBox.backdrop then
				BORDER:CreateBorder(owned.editBox, nil, nil, nil, nil, nil, true, true)
			end
			if owned.viewCB and not owned.viewCB.IsBorder then
				BORDER:CreateBorder(owned.viewCB, nil, nil, nil, nil, nil, true, true)
				owned.viewCB.IsBorder = true
			end
			if owned.depositCB and not owned.depositCB.IsBorder then
				BORDER:CreateBorder(owned.depositCB, nil, nil, nil, nil, nil, true, true)
				owned.depositCB.IsBorder = true
			end
		end
	end
end

function S:Blizzard_GuildControlUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.guildcontrol) then return end
	if not E.db.ProjectHopes.skins.guildControl then return end

	BORDER:CreateBorder(_G.GuildControlUI)

	local RankSettingsFrameGoldBox = _G.GuildControlUIRankSettingsFrameGoldBox
	BORDER:CreateBorder(RankSettingsFrameGoldBox, nil, nil, nil, nil, nil, true, false)

	BORDER:CreateBorder(_G.GuildControlUIRankOrderFrameNewButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.GuildControlUIRankBankFrameRankDropdown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.GuildControlUIRankBankFrameInsetScrollFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.GuildControlUINavigationDropdown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.GuildControlUIRankSettingsFrameRankDropdown, nil, nil, nil, nil, nil, true, true)

	_G.GuildControlUIRankOrderFrameNewButton:HookScript('OnClick', function()
		E:Delay(1, SkinGuildRanks)
	end)

	BORDER:CreateBorder(_G.GuildControlUIRankSettingsFrameOfficerCheckbox, nil, nil, nil, nil, nil, true, true)

	for i=1, _G.NUM_RANK_FLAGS do
		local checkbox = _G['GuildControlUIRankSettingsFrameCheckbox'..i]
		if checkbox then BORDER:CreateBorder(checkbox, nil, nil, nil, nil, nil, true, true) end
	end

	hooksecurefunc('GuildControlUI_BankTabPermissions_Update', SkinBankTabs)
	hooksecurefunc('GuildControlUI_RankOrder_Update', SkinGuildRanks)
end

S:AddCallbackForAddon('Blizzard_GuildControlUI')
