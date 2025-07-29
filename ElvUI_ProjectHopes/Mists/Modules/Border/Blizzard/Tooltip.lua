local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local TT = E:GetModule('Tooltip')

local _G = _G
local next = next

function S:StyleTooltips()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.tooltip) then return end
	if not E.db.ProjectHopes.skins.tooltips then return end

	for _, tt in next, {
		_G.ItemRefTooltip,
		_G.ItemRefShoppingTooltip1,
		_G.ItemRefShoppingTooltip2,
		_G.FriendsTooltip,
		_G.EmbeddedItemTooltip,
		_G.ReputationParagonTooltip,
		_G.GameTooltip,
		_G.WorldMapTooltip,
		_G.ShoppingTooltip1,
		_G.ShoppingTooltip2,
		_G.QuickKeybindTooltip,
		-- ours
		E.ConfigTooltip,
		E.SpellBookTooltip,
		-- libs
		_G.LibDBIconTooltip,
		_G.SettingsTooltip,
	} do
			BORDER:CreateBorder(tt)
	end
end

function S:TooltipFrames()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.tooltip) then return end
	if not E.db.ProjectHopes.skins.tooltips then return end

	S:StyleTooltips()

	-- EmbeddedItemTooltip (also Paragon Reputation)
	local EmbeddedTT = _G.EmbeddedItemTooltip.ItemTooltip
	BORDER:HandleIcon(EmbeddedTT.Icon, true)
	BORDER:HandleIconBorder(EmbeddedTT.IconBorder, EmbeddedTT.Icon.backdrop.border)

	-- Skin GameTooltip Status Bar
	BORDER:CreateBorder(_G.GameTooltipStatusBar.backdrop)
end

S:AddCallback('TooltipFrames')
