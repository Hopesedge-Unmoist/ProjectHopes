local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local TT = E:GetModule('Tooltip')

local _G = _G
local next = next
local GetDisplayedItem = TooltipUtil and TooltipUtil.GetDisplayedItem
local GameTooltip, GameTooltipStatusBar = GameTooltip, GameTooltipStatusBar

function BORDER:TT_SetStyle(tt)
	if tt and tt ~= E.ScanTooltip and not tt.IsEmbedded and not tt:IsForbidden() then
		BORDER:CreateBorder(tt)
	end
end

function BORDER:TT_GameTooltip_SetDefaultAnchor(tt)
	if tt.StatusBar then
		BORDER:CreateBorder(tt.StatusBar)
	end
end

local function StyleTooltips()       
	local styleTT = {
		_G.AceConfigDialogTooltip,
		_G.AceGUITooltip,
		_G.BattlePetTooltip,
		_G.DataTextTooltip,
		_G.ElvUIConfigTooltip,
		_G.ElvUISpellBookTooltip,
		_G.EmbeddedItemTooltip,
		_G.FriendsTooltip,
		_G.FloatingBattlePetTooltip,
		_G.GameSmallHeaderTooltip,
		_G.GameTooltip,
		_G.ItemRefShoppingTooltip1,
		_G.ItemRefShoppingTooltip2,
		_G.ItemRefTooltip,
		_G.LibDBIconTooltip,
		_G.QuestScrollFrame and _G.QuestScrollFrame.CampaignTooltip,
		_G.QuestScrollFrame and _G.QuestScrollFrame.StoryTooltip,
		_G.QuickKeybindTooltip,
		_G.ReputationParagonTooltip,
		_G.SettingsTooltip,
		_G.ShoppingTooltip1,
		_G.ShoppingTooltip2,
		_G.WarCampaignTooltip
	}

	for _, tt in pairs(styleTT) do
		if tt and tt ~= E.ScanTooltip and not tt.IsEmbedded and not tt:IsForbidden() then
			BORDER:CreateBorder(tt)
		end
	end

	BORDER:SecureHook(TT, "SetStyle", BORDER.TT_SetStyle)
	BORDER:SecureHook(TT, "GameTooltip_SetDefaultAnchor", BORDER.TT_GameTooltip_SetDefaultAnchor)
	BORDER:SecureHook(_G.QueueStatusFrame, "Update", BORDER.CreateBorder)
end

function S:TooltipFrames()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.tooltip) then return end
	if not E.db.ProjectHopes.skins.tooltips then return end

	StyleTooltips()
	BORDER:CreateBorder(_G.GameTooltip)
	
	-- EmbeddedItemTooltip (also Paragon Reputation)
	local EmbeddedTT = _G.EmbeddedItemTooltip.ItemTooltip
	BORDER:HandleIcon(EmbeddedTT.Icon)
	BORDER:HandleIconBorder(EmbeddedTT.IconBorder, EmbeddedTT.Icon.backdrop.border)
	if EmbeddedTT.IconBorder then
		EmbeddedTT.IconBorder:Hide()
	end

	-- Save the original function
	local original_GameTooltip_ShowProgressBar = TT.GameTooltip_ShowProgressBar
	-- Override the function
	function TT:GameTooltip_ShowProgressBar(tt)
		if not tt or not tt.progressBarPool or tt:IsForbidden() then return end

		local sb = tt.progressBarPool:GetNextActive()
		if not sb or not sb.Bar then return end

		tt.progressBar = sb.Bar

		if not sb.Bar.backdrop then
			sb.Bar:StripTextures()
			sb.Bar:CreateBackdrop('Transparent', nil, true)
			sb.Bar:SetStatusBarTexture(E.media.normTex)
		end

		if not sb.Bar.backdrop.border then
			BORDER:CreateBorder(sb.Bar.backdrop)
		end

		-- Call the original function to ensure any other functionality is preserved
		original_GameTooltip_ShowProgressBar(self, tt)
	end
	-- Skin GameTooltip Status Bar
	BORDER:CreateBorder(_G.GameTooltipStatusBar.backdrop)
end

S:AddCallback('TooltipFrames')
