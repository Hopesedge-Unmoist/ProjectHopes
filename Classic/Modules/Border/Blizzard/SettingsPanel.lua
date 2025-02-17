local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next = next
local hooksecurefunc = hooksecurefunc


local function HandleOptionDropDown(option)
	local button = option.Button
	BORDER:CreateBorder(button)
end

local function HandleDropdown(option)
	BORDER:CreateBorder(option.Dropdown)
	BORDER:CreateBorder(option.DecrementButton)
	BORDER:CreateBorder(option.IncrementButton)
end

local function UpdateKeybindButtons(self)
	if not self.bindingsPool then return end
	for panel in self.bindingsPool:EnumerateActive() do
		if not panel.IsBorder then
			BORDER:CreateBorder(panel.Button1)
			BORDER:CreateBorder(panel.Button2)

			if panel.CustomButton then 
				BORDER:CreateBorder(panel.CustomButton)
			end
			panel.IsBorder = true
		end
	end
end

local function UpdateHeaderExpand(self, expanded)
	UpdateKeybindButtons(self)
end

local function HandleCheckbox(checkbox)
	BORDER:CreateBorder(checkbox.backdrop, nil, nil, nil, nil, nil, false, true)
end

local function HandleControlGroup(controls)
	for _, child in next, { controls:GetChildren() } do
		if child.SliderWithSteppers then
			BORDER:CreateBorder(child.SliderWithSteppers.Slider.backdrop)
		end
		if child.Checkbox then
			BORDER:CreateBorder(child.Checkbox, nil, nil, nil, nil, nil, false, true)
		end
		if child.Control then
			HandleDropdown(child.Control)
		end
	end
end

local function HandleControlTab(tab)
	BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)
end

function S:SettingsPanel()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.blizzardOptions) then return end
	if not E.db.ProjectHopes.skins.settingsPanel then return end

	local SettingsPanel = _G.SettingsPanel
	BORDER:CreateBorder(SettingsPanel)

	BORDER:CreateBorder(SettingsPanel.SearchBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(SettingsPanel.ApplyButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(SettingsPanel.CloseButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(SettingsPanel.CategoryList)
	BORDER:CreateBorder(SettingsPanel.CategoryList.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(SettingsPanel.Container.SettingsList)
	BORDER:CreateBorder(SettingsPanel.Container.SettingsList.Header.DefaultsButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(SettingsPanel.Container.SettingsList.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	hooksecurefunc(SettingsPanel.Container.SettingsList.ScrollBox, 'Update', function(frame)
		for _, child in next, { frame.ScrollTarget:GetChildren() } do
			if not child.IsBorder then
				if child.Checkbox then
					BORDER:CreateBorder(child.Checkbox, nil, -7, 7, 7, -7, true, true)
				end
				if child.Dropdown then
					BORDER:CreateBorder(child.Dropdown.Button, nil, nil, nil, nil, nil, false, true)
				end
				if child.Control then
					BORDER:CreateBorder(child.Control.Dropdown)
					BORDER:CreateBorder(child.Control.DecrementButton)
					BORDER:CreateBorder(child.Control.IncrementButton)
				end
				if child.ColorBlindFilterDropDown then
					BORDER:CreateBorder(child.ColorBlindFilterDropDown.Button, nil, nil, nil, nil, nil, false, true)
				end
				if child.Button then
					if child.Button:GetWidth() < 250 then
						BORDER:CreateBorder(child.Button, nil, nil, nil, nil, nil, false, true)
					else  
						UpdateHeaderExpand(child, false)
						hooksecurefunc(child, 'EvaluateVisibility', UpdateHeaderExpand)
					end
				end
				if child.ToggleTest then
					BORDER:CreateBorder(child.ToggleTest, nil, nil, nil, nil, nil, false, true)
					BORDER:CreateBorder(child.VUMeter.Status)
				end
				if child.PushToTalkKeybindButton then
					BORDER:CreateBorder(child.PushToTalkKeybindButton, nil, nil, nil, nil, nil, false, true)
				end
				if child.SliderWithSteppers then
					BORDER:CreateBorder(child.SliderWithSteppers.Slider.backdrop)
				end
				if child.Button1 and child.Button2 then
					BORDER:CreateBorder(child.Button1, nil, nil, nil, nil, nil, false, true)
					BORDER:CreateBorder(child.Button2, nil, nil, nil, nil, nil, false, true)
				end
				if child.Controls then
					for i = 1, #child.Controls do
						local control = child.Controls[i]
						if control.SliderWithSteppers then
							BORDER:CreateBorder(control.SliderWithSteppers.Slider.backdrop)
						end
					end
				end
				if child.BaseTab then
					BORDER:CreateBorder(child.BaseTab, nil, nil, nil, nil, nil, true, false)
				end
				if child.RaidTab then
					BORDER:CreateBorder(child.RaidTab, nil, nil, nil, nil, nil, true, false)
				end
				if child.BaseQualityControls then
					HandleControlGroup(child.BaseQualityControls)
				end
				if child.RaidQualityControls then
					HandleControlGroup(child.RaidQualityControls)
				end

				child.IsBorder = true
			end
		end
	end)

	for _, frame in next, { _G.CompactUnitFrameProfiles, _G.CompactUnitFrameProfilesGeneralOptionsFrame } do
		for _, child in next, { frame:GetChildren() } do
			if child:IsObjectType('CheckButton') then
				BORDER:CreateBorder(child, nil, nil, nil, nil, nil, true, true)
			elseif child:IsObjectType('Button') then
				BORDER:CreateBorder(child, nil, nil, nil, nil, nil, false, true)
			elseif child:IsObjectType('Frame') and (child.Left and child.Middle and child.Right) then
				BORDER:CreateBorder(child, nil, nil, nil, nil, nil, true, true)
			end
		end
	end
end

S:AddCallback('SettingsPanel')
