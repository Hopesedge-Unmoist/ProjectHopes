local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next = next
local hooksecurefunc = hooksecurefunc

local function updateNewGlow(self)
	self.border:SetBackdropBorderColor(1, self.NewOutline:IsShown() and 0.8 or 1, 1)
end

local function HandleScrollChild(self)
	for _, child in next, { self.ScrollTarget:GetChildren() } do
		local icon = child.Icon
		if icon and not icon.IsBorder then
			BORDER:CreateBorder(child)

			BORDER:HandleIcon(icon)
			BORDER:CreateBorder(child.DeleteButton, nil, nil, nil, nil, nil, false, true)

			hooksecurefunc(child, 'Init', updateNewGlow)

			icon.IsBorder = true
		end
	end
end

local function UpdateButtonColor(button, isSelected)
	if isSelected then
		button.Portrait.backdrop.border:SetBackdrop(Private.BorderLight)
		button.Portrait.backdrop.border:SetBackdropBorderColor(unpack(E.media.rgbvaluecolor))
	else
		button.Portrait.backdrop.border:SetBackdrop(Private.Border)
		button.Portrait.backdrop.border:SetBackdropBorderColor(1, 1, 1)
	end
end

local function HandlePortraitIcon(button)
	BORDER:HandleIcon(button.Portrait)

	hooksecurefunc(button, 'SetSelectedState', UpdateButtonColor)
end

function S:Blizzard_ClickBindingUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.binding) then return end
	if not E.db.ProjectHopes.skins.clickBinding then return end

	local ClickBindingFrame = _G.ClickBindingFrame
	BORDER:CreateBorder(ClickBindingFrame.Bg)

	for _, v in next, { 'ResetButton', 'AddBindingButton', 'SaveButton' } do
		BORDER:CreateBorder(ClickBindingFrame[v], nil, nil, nil, nil, nil, false, true)
	end
	ClickBindingFrame.AddBindingButton:ClearAllPoints()
	ClickBindingFrame.AddBindingButton:SetPoint("RIGHT", ClickBindingFrame.SaveButton, "LEFT", -5, 0)

	--BORDER:CreateBorder(ClickBindingFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	hooksecurefunc(ClickBindingFrame.ScrollBox, 'Update', HandleScrollChild)

	local tutorial = ClickBindingFrame.TutorialFrame
	BORDER:CreateBorder(tutorial)

	HandlePortraitIcon(ClickBindingFrame.PlayerSpellsPortrait)
	HandlePortraitIcon(ClickBindingFrame.MacrosPortrait)
	ClickBindingFrame.MacrosPortrait:SetPoint("RIGHT", ClickBindingFrame.PlayerSpellsPortrait, "LEFT", -8, 0)

	if ClickBindingFrame.EnableMouseoverCastCheckbox then
		BORDER:CreateBorder(ClickBindingFrame.EnableMouseoverCastCheckbox.backdrop, nil, nil, nil, nil, nil, false, true)
		BORDER:CreateBorder(ClickBindingFrame.MouseoverCastKeyDropdown.backdrop, nil, nil, nil, nil, nil, false, true)
	end
end

S:AddCallbackForAddon('Blizzard_ClickBindingUI')
