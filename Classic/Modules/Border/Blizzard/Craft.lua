local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local unpack = unpack
local hooksecurefunc = hooksecurefunc

local GetCraftNumReagents = GetCraftNumReagents
local GetCraftItemLink = GetCraftItemLink
local GetCraftReagentInfo = GetCraftReagentInfo
local GetCraftReagentItemLink = GetCraftReagentItemLink

local GetItemQualityByID = C_Item.GetItemQualityByID
local GetItemQualityColor = C_Item.GetItemQualityColor

function S:SkinCraft()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.craft) then return end
	if not E.db.ProjectHopes.skins.craft then return end

	local CraftFrame = _G.CraftFrame
	BORDER:CreateBorder(AddonList.backdrop)

	local CraftRankFrame = _G.CraftRankFrame
	BORDER:CreateBorder(CraftRankFrame)
	BORDER:CreateBorder(_G.CraftListScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.CraftDetailScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.CraftCancelButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.CraftCreateButton, nil, nil, nil, nil, nil, false, true)

	local CraftIcon = _G.CraftIcon
	local CraftCollapseAllButton = _G.CraftCollapseAllButton

	for i = 1, _G.CRAFTS_DISPLAYED do
		local button = _G['Craft'..i]
		BORDER:CreateBorder(button)
	end

	for i = 1, _G.MAX_CRAFT_REAGENTS do
		local icon = _G['CraftReagent'..i..'IconTexture']

		BORDER:HandleIcon(icon, true)
	end

	BORDER:CreateBorder(CraftIcon)

	hooksecurefunc('CraftFrame_SetSelection', function(id)
		if not id then return end

		local CraftReagentLabel = _G.CraftReagentLabel
		if CraftIcon:GetNormalTexture() then
			BORDER:HandleIcon(CraftIcon:GetNormalTexture())
		end

		local skillLink = GetCraftItemLink(id)
		if skillLink then
			local quality = GetItemQualityByID(skillLink)
			if quality and quality > 1 then
				local r, g, b = GetItemQualityColor(quality)
				CraftIcon.border:SetBackdrop(Private.BorderLight)
				CraftIcon.border:SetBackdropBorderColor(r, g, b)
			end
		end

		local numReagents = GetCraftNumReagents(id)
		for i = 1, numReagents do
			local _, _, reagentCount, playerReagentCount = GetCraftReagentInfo(id, i)
			local reagentLink = GetCraftReagentItemLink(id, i)
			local icon = _G['CraftReagent'..i..'IconTexture']
			BORDER:CreateBorder(icon)

			if reagentLink then
				local quality = GetItemQualityByID(reagentLink)
				if quality and quality > 1 then
					local r, g, b = GetItemQualityColor(quality)
					icon.border:SetBackdrop(Private.BorderLight)
					icon.border:SetBackdropBorderColor(r, g, b)
				end
			end
		end
	end)
end

S:AddCallbackForAddon('Blizzard_CraftUI', 'SkinCraft')
