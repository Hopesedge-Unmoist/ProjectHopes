local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')
local S = E:GetModule('Skins')

local _G = _G

function S:Atlas()
	if not E.db.ProjectHopes.skins.atlas then return end
	
	local function SkinOnFrameShow()
		local frameData = {
			{frame = _G.AtlasFrame},
			{frame = _G.AtlasFrameSmall},

		}

		local editboxData = {
			{editbox = _G.AtlasSearchEditBox},
		}

		local buttonData = {
			{button = _G.AtlasFrameOptionsButton},
			{button = _G.AtlasFrameLFGButton},
			{button = _G.AtlasSearchButton},
			{button = _G.AtlasSearchClearButton},
			{button = _G.AtlasFrameCollapseButton},
			{button = _G.AtlasFrameSmallExpandButton},
			{button = _G.AtlasFrameSmallOptionsButton},
			{button = _G.AtlasSwitchButton},
		}

		local dropdownData = {
			{dropdown = _G.AtlasFrameDropDown, size = 235, dropdownbutton = _G.AtlasFrameDropDownButton, borderParams = {nil, nil, nil, nil, nil, true, true}},
			{dropdown = _G.AtlasFrameDropDownType, size = 235, dropdownbutton = _G.AtlasFrameDropDownTypeButton, borderParams = {nil, nil, nil, nil, nil, true, true}},
			{dropdown = _G.AtlasFrameSmallDropDown, size = 235, dropdownbutton = _G.AtlasFrameSmallDropDownButton, borderParams = {nil, nil, nil, nil, nil, true, true}},
			{dropdown = _G.AtlasFrameSmallDropDownType, size = 235, dropdownbutton = _G.AtlasFrameSmallDropDownTypeButton, borderParams = {nil, nil, nil, nil, nil, true, true}},
		}

		-- Apply the skinning
		BORDER:SkinDropDownList(dropdownData)
		BORDER:SkinButtonList(buttonData)
		BORDER:SkinFrameList(frameData)
		BORDER:SkinEditboxList(editboxData)

		-- Adjust Sizes
		BORDER:AdjustSize(_G.AtlasFrameSmall,15,0)
		BORDER:AdjustSize(_G.AtlasSearchEditBox,-40,-8)

		-- Positions
		BORDER:ClearAndSetPoint(_G.AtlasSearchClearButton, 'BOTTOMRIGHT', _G.AtlasFrame, 'BOTTOMRIGHT', -30, 8)
		BORDER:ClearAndSetPoint(_G.AtlasSearchButton, 'RIGHT', _G.AtlasSearchClearButton, 'LEFT', -5, 0)
		BORDER:ClearAndSetPoint(_G.AtlasSearchEditBox, 'RIGHT', _G.AtlasSearchButton, 'LEFT', -5, 0)
		BORDER:ClearAndSetPoint(_G.AtlasSwitchButton, 'RIGHT', _G.AtlasSearchEditBox, 'LEFT', -5, 0)
		BORDER:ClearAndSetPoint(_G.AtlasFrameCollapseButton, 'BOTTOMRIGHT', _G.AtlasFrameMapFrame, 'BOTTOMRIGHT', -10, 10)
		BORDER:ClearAndSetPoint(_G.AtlasFrameSmallExpandButton, 'BOTTOMRIGHT', _G.AtlasFrameSmallMapFrame, 'BOTTOMRIGHT', -10, 10)
		BORDER:ClearAndSetPoint(_G.AtlasFrameDropDown, 'TOPLEFT', _G.AtlasFrame, 'TOPLEFT', 30, -45)
		BORDER:ClearAndSetPoint(_G.AtlasFrameDropDownType, 'LEFT', _G.AtlasFrameDropDown, 'RIGHT', 10, 0)
		BORDER:ClearAndSetPoint(_G.AtlasFrameSmallDropDown, 'TOPLEFT', _G.AtlasFrameSmall, 'TOPLEFT', 30, -45)
		BORDER:ClearAndSetPoint(_G.AtlasFrameSmallDropDownType, 'LEFT', _G.AtlasFrameSmallDropDown, 'RIGHT', 10, 0)
		BORDER:ClearAndSetPoint(_G.AtlasFrameLockButton, 'RIGHT', _G.AtlasFrameCloseButton, 'LEFT', 5, 0)
		BORDER:ClearAndSetPoint(_G.AtlasFrameOptionsButton, 'RIGHT', _G.AtlasFrameLockButton, 'LEFT', -2, -1)
		BORDER:ClearAndSetPoint(_G.AtlasFrameSmallLockButton, 'RIGHT', _G.AtlasFrameSmallCloseButton, 'LEFT', 5, 0)
		BORDER:ClearAndSetPoint(_G.AtlasFrameSmallOptionsButton, 'RIGHT', _G.AtlasFrameSmallLockButton, 'LEFT', -2, -1)

		-- Additional Things

		-- Skin next/prev buttons
        local navButtons = {
            _G.AtlasFrameNextMapButton,
            _G.AtlasFramePrevMapButton,
            _G.AtlasFrameSmallNextMapButton,
            _G.AtlasFrameSmallPrevMapButton
        }
        for _, button in ipairs(navButtons) do
            S:HandleNextPrevButton(button)
        end

		-- Add backdrop to mapframe
		_G.AtlasFrameMapFrame:CreateBackdrop()
		_G.AtlasFrameSmallMapFrame:CreateBackdrop()
		BORDER:CreateBorder(_G.AtlasFrameMapFrame, nil, nil, nil, nil, nil, true, true)
		BORDER:CreateBorder(_G.AtlasFrameSmallMapFrame, nil, nil, nil, nil, nil, true, true)

		-- Collapse & Expand Button Arrow Fix
		local collapseButton = _G.AtlasFrameCollapseButton
		local expandButton = _G.AtlasFrameSmallExpandButton

		collapseButton:SetNormalTexture("Interface\\AddOns\\ElvUI\\Core\\Media\\Textures\\ArrowRight")
		collapseButton:GetNormalTexture():SetTexCoord(1, 0, 0, 1) -- Flip it correctly
		collapseButton:SetPushedTexture("Interface\\AddOns\\ElvUI\\Core\\Media\\Textures\\ArrowRight")
		collapseButton:GetPushedTexture():SetVertexColor(0.8, 0.8, 0.8)

		expandButton:SetNormalTexture("Interface\\AddOns\\ElvUI\\Core\\Media\\Textures\\ArrowRight")
		expandButton:SetPushedTexture("Interface\\AddOns\\ElvUI\\Core\\Media\\Textures\\ArrowRight")
		expandButton:GetPushedTexture():SetTexCoord(0, 1, 1, 0) -- Flip differently for expanding
		expandButton:GetPushedTexture():SetVertexColor(0.8, 0.8, 0.8)
		S:Unhook(_G.AtlasFrame, "OnShow")
	end

	S:SecureHookScript(_G.AtlasFrame, "OnShow", SkinOnFrameShow)

	-- Function to skin dropdown lists
	local function SkinDropDownLists()
		for i = 1, 2 do
			local list = _G["L_DropDownList" .. i]
			if list and not list.IsSkinned then
				list:StripTextures()
				list:SetTemplate("Transparent")
				S:HandleFrame(list)
				list.IsSkinned = true
			end
			if list.Backdrop then
				list.Backdrop:Hide()
			end
			for j = 1, list.numButtons or 10 do
				local button = _G["L_DropDownList" .. i .. "Button" .. j]
				if button and not button.IsSkinned then
					button.IsSkinned = true
				end
			end
		end
	end

	S:SecureHookScript(_G.L_DropDownList1, "OnShow", SkinDropDownLists)
end

S:AddCallbackForAddon("Atlas")
