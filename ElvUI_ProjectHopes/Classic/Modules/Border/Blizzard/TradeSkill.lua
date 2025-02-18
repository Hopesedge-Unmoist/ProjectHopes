local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local unpack, select = unpack, select
local hooksecurefunc = hooksecurefunc

local GetTradeSkillNumReagents = GetTradeSkillNumReagents
local GetTradeSkillInfo = GetTradeSkillInfo
local GetTradeSkillItemLink = GetTradeSkillItemLink
local GetTradeSkillReagentInfo = GetTradeSkillReagentInfo
local GetTradeSkillReagentItemLink = GetTradeSkillReagentItemLink

local GetItemQualityByID = C_Item.GetItemQualityByID
local GetItemQualityColor = C_Item.GetItemQualityColor

function S:Blizzard_TradeSkillUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.tradeskill) then return end
	if not E.db.ProjectHopes.skins.tradeskill then return end

	local TradeSkillFrame = _G.TradeSkillFrame
	BORDER:CreateBorder(TradeSkillFrame.backdrop)

	local TradeSkillRankFrame = _G.TradeSkillRankFrame
	BORDER:CreateBorder(TradeSkillRankFrame)

	BORDER:CreateBorder(_G.TradeSkillInvSlotDropdown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.TradeSkillSubClassDropdown, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(_G.TradeSkillListScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.TradeSkillDetailScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)

	for i = 1, _G.MAX_TRADE_SKILL_REAGENTS do
		local icon = _G['TradeSkillReagent'..i..'IconTexture']
		BORDER:HandleIcon(icon, true)
	end

	BORDER:CreateBorder(_G.TradeSkillCancelButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.TradeSkillCreateButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.TradeSkillCreateAllButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(_G.TradeSkillInputBox, nil, nil, nil, nil, nil, true, false)

	BORDER:CreateBorder(_G.TradeSkillSkillIcon)

	hooksecurefunc('TradeSkillFrame_SetSelection', function(id)
		local skillType = select(2, GetTradeSkillInfo(id))
		if skillType == 'header' then return end

		if _G.TradeSkillSkillIcon:GetNormalTexture() then
			BORDER:HandleIcon(_G.TradeSkillSkillIcon:GetNormalTexture())
		end

		local skillLink = GetTradeSkillItemLink(id)
		if skillLink then
			local quality = GetItemQualityByID(skillLink)
			if quality and quality > 1 then
				local r, g, b = GetItemQualityColor(quality)
				_G.TradeSkillSkillIcon.border:SetBackdrop(Private.BorderLight)
				_G.TradeSkillSkillIcon.border:SetBackdropBorderColor(r, g, b)
			end
		end

		for i = 1, GetTradeSkillNumReagents(id) do
			local _, _, reagentCount, playerReagentCount = GetTradeSkillReagentInfo(id, i)
			local reagentLink = GetTradeSkillReagentItemLink(id, i)

			if reagentLink then
				local icon = _G['TradeSkillReagent'..i..'IconTexture']
				local quality = GetItemQualityByID(reagentLink)
				BORDER:CreateBorder(icon)

				if quality and quality > 1 then
					local name = _G['TradeSkillReagent'..i..'Name']
					local r, g, b = GetItemQualityColor(quality)
					icon.border:SetBackdrop(Private.BorderLight)
					icon.border:SetBackdropBorderColor(r, g, b)
				end
			end
		end
	end)
end

S:AddCallbackForAddon('Blizzard_TradeSkillUI')
