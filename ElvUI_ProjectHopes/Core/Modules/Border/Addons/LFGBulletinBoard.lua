local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')
local S = E:GetModule('Skins')

local _G = _G
local pairs = pairs

function S:LFGBulletinBoard()
	if not E.db.ProjectHopes.skins.lfgbulletinboard then return end

	local frameData = {
    	{frame = _G.GroupBulletinBoardFrame, scrollbar = _G.GroupBulletinBoardFrame_ScrollFrameScrollBar},
	}

	local tabData = {
		{tab = _G.GroupBulletinBoardFrameTab1, borderParams = {nil, nil, nil, nil, nil, true, true}},
		{tab = _G.GroupBulletinBoardFrameTab2, borderParams = {nil, nil, nil, nil, nil, true, true}},
	}

	local editboxData = {
		{editbox = _G.GroupBulletinBoardFrameResultsFilter},
	}

	local buttonData = {
		{button = _G.GroupBulletinBoardFrameSettingsButton},
		{button = _G.GroupBulletinBoardFrameRefreshButton},
	}

	-- Apply the skinning
	BORDER:SkinTabList(tabData)
	BORDER:SkinFrameList(frameData)
	BORDER:SkinEditboxList(editboxData)
	BORDER:SkinButtonList(buttonData)

	-- Adjust sizes
	BORDER:AdjustSize(_G.GroupBulletinBoardFrameResultsFilter,0,5)

	-- Position
	BORDER:ClearAndSetPoint(_G.GroupBulletinBoardFrameSettingsButton, 'BOTTOMRIGHT', _G.GroupBulletinBoardFrameCloseButton, 'BOTTOMLEFT', -3, 0)
	BORDER:ClearAndSetPoint(_G.GroupBulletinBoardFrameRefreshButton, 'BOTTOMRIGHT', _G.GroupBulletinBoardFrameSettingsButton, 'BOTTOMLEFT', -3, 0)
	BORDER:ClearAndSetPoint(_G.GroupBulletinBoardFrameTab1, 'TOPLEFT', _G.GroupBulletinBoardFrame, 'BOTTOMLEFT', -10, -6)
	BORDER:ClearAndSetPoint(_G.GroupBulletinBoardFrameTab2, 'BOTTOMLEFT', _G.GroupBulletinBoardFrameTab1, 'BOTTOMRIGHT', -10, 0)

	-- Additional Things
	-- Handle Close Button
	local closebutton = _G.GroupBulletinBoardFrameCloseButton
	if (closebutton) then
		S:HandleCloseButton(closebutton)

		-- Reset font styling in case it's missing
		if closebutton:GetFontString() then
			closebutton:GetFontString():SetFont(E.LSM:Fetch("font", E.db.general.font), 14, "NONE")
			closebutton:GetFontString():SetTextColor(1, 1, 1)
			closebutton:GetFontString():SetText("X")
		end

		-- Hide any child textures
		for i = 1, closebutton:GetNumRegions() do
			local region = select(i, closebutton:GetRegions())
			if region and region:IsObjectType("Texture") then
				region:SetTexture(nil)
				region:Hide()
			end
		end
	end
end

S:AddCallbackForAddon("LFGBulletinBoard")
