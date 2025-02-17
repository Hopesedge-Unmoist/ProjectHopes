local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local _G = _G
local unpack = unpack

local NUM_SLOTS_PER_GUILDBANK_GROUP = 14
local NUM_GUILDBANK_COLUMNS = 7

function S:Blizzard_GuildBankUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.gbank) then return end
	if not E.db.ProjectHopes.skins.guildBank then return end

	local GuildBankFrame = _G.GuildBankFrame

	BORDER:CreateBorder(GuildBankFrame)

	BORDER:CreateBorder(GuildBankFrame.DepositButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(GuildBankFrame.WithdrawButton, nil, nil, nil, nil, nil, false, true)
	GuildBankFrame.WithdrawButton:Point('RIGHT', GuildBankFrame.DepositButton, 'LEFT', -5, 0)

	BORDER:CreateBorder(_G.GuildBankInfoSaveButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(GuildBankFrame.BuyInfo.PurchaseButton, nil, nil, nil, nil, nil, false, true)
			
	BORDER:CreateBorder(GuildBankFrame.Log.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(_G.GuildBankInfoScrollFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	local GuildItemSearchBox = _G.GuildItemSearchBox
	BORDER:CreateBorder(GuildItemSearchBox)

	for i = 1, _G.MAX_GUILDBANK_TABS do
		local tab = _G['GuildBankTab'..i]           
		local button = tab.Button
		BORDER:CreateBorder(tab.Button, nil, nil, nil, nil, nil, false, true)
	end

	for i = 1, NUM_GUILDBANK_COLUMNS do
		local column = GuildBankFrame['Column'..i]
		column:StripTextures()

		for x = 1, NUM_SLOTS_PER_GUILDBANK_GROUP do
			local button = column['Button'..x]

			BORDER:CreateBorder(button)
			BORDER:HandleIconBorder(button.IconBorder, button.border)
		end
	end

	for i = 1, 4 do
		BORDER:CreateBorder(_G['GuildBankFrameTab'..i], nil, nil, nil, nil, nil, true, true)
	end

	local tab = _G.GuildBankTab1
	local index, lastTab = 1, tab
	while tab do
		tab:ClearAllPoints()

		if index == 1 then
			tab:Point('TOPLEFT', _G.GuildBankFrame, 'TOPRIGHT', 5, 8)
		else
			tab:Point('TOPLEFT', lastTab, 'BOTTOMLEFT', 0, 9)
			lastTab = tab
		end

		index = index + 1
		tab = _G['GuildBankTab'..index]
	end

	_G.GuildBankFrameTab1:ClearAllPoints()
	_G.GuildBankFrameTab1:Point('TOPLEFT', _G.GuildBankFrame, 'BOTTOMLEFT', -3, -5)
end

S:AddCallbackForAddon('Blizzard_GuildBankUI')
