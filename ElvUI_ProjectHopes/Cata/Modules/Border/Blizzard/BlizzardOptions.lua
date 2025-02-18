local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local _G = _G
local ipairs, pairs, next = ipairs, pairs, next

local hooksecurefunc = hooksecurefunc

function S:BlizzardOptions()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.blizzardOptions) then return end
	if not E.db.ProjectHopes.skins.settingsPanel then return end

	-- Chat Config
	local ChatConfigFrame = _G.ChatConfigFrame

	local ChatFrames = {
		_G.ChatConfigFrame,
		_G.ChatConfigCategoryFrame,
		_G.ChatConfigBackgroundFrame,
		_G.ChatConfigCombatSettingsFilters,
		_G.ChatConfigCombatSettingsFiltersScrollFrame,
		_G.CombatConfigColorsHighlighting,
		_G.CombatConfigColorsColorizeUnitName,
		_G.CombatConfigColorsColorizeSpellNames,
		_G.CombatConfigColorsColorizeDamageNumber,
		_G.CombatConfigColorsColorizeDamageSchool,
		_G.CombatConfigColorsColorizeEntireLine,
		_G.ChatConfigChatSettingsLeft,
		_G.ChatConfigOtherSettingsCombat,
		_G.ChatConfigOtherSettingsPVP,
		_G.ChatConfigOtherSettingsSystem,
		_G.ChatConfigOtherSettingsCreature,
		_G.ChatConfigChannelSettingsAvailable,
		_G.ChatConfigChannelSettingsAvailableBox,
		_G.ChatConfigChannelSettingsLeft,
		_G.CombatConfigMessageSourcesDoneBy,
		_G.CombatConfigColorsUnitColors,
		_G.CombatConfigMessageSourcesDoneTo,
		_G.ChatConfigTextToSpeechChannelSettingsLeft
	}

	local ChatButtons = {
		_G.ChatConfigFrameDefaultButton,
		_G.ChatConfigFrameRedockButton,
		_G.ChatConfigFrameOkayButton,
		_G.ChatConfigFrame.ToggleChatButton,
		_G.ChatConfigCombatSettingsFiltersDeleteButton,
		_G.ChatConfigCombatSettingsFiltersAddFilterButton,
		_G.ChatConfigCombatSettingsFiltersCopyFilterButton,
		_G.CombatConfigSettingsSaveButton,
		_G.CombatLogDefaultButton,
	}

	local ChatCheckBoxs = {
		_G.CombatConfigColorsHighlightingLine,
		_G.CombatConfigColorsHighlightingAbility,
		_G.CombatConfigColorsHighlightingDamage,
		_G.CombatConfigColorsHighlightingSchool,
		_G.CombatConfigColorsColorizeUnitNameCheck,
		_G.CombatConfigColorsColorizeSpellNamesCheck,
		_G.CombatConfigColorsColorizeSpellNamesSchoolColoring,
		_G.CombatConfigColorsColorizeDamageNumberCheck,
		_G.CombatConfigColorsColorizeDamageNumberSchoolColoring,
		_G.CombatConfigColorsColorizeDamageSchoolCheck,
		_G.CombatConfigColorsColorizeEntireLineCheck,
		_G.CombatConfigFormattingShowTimeStamp,
		_G.CombatConfigFormattingShowBraces,
		_G.CombatConfigFormattingUnitNames,
		_G.CombatConfigFormattingSpellNames,
		_G.CombatConfigFormattingItemNames,
		_G.CombatConfigFormattingFullText,
		_G.CombatConfigSettingsShowQuickButton,
		_G.CombatConfigSettingsSolo,
		_G.CombatConfigSettingsParty,
		_G.CombatConfigSettingsRaid,
	}

	for _, Frame in pairs(ChatFrames) do
		BORDER:CreateBorder(Frame)
	end

	for _, CheckBox in pairs(ChatCheckBoxs) do
		BORDER:CreateBorder(CheckBox, nil, nil, nil, nil, nil, true, true)
	end

	for _, Button in pairs(ChatButtons) do
		BORDER:CreateBorder(Button, nil, nil, nil, nil, nil, false, true)
	end

	for i in pairs(_G.COMBAT_CONFIG_TABS) do
		BORDER:CreateBorder(_G['CombatConfigTab'..i], nil, nil, nil, nil, nil, true, true)

		_G['CombatConfigTab'..i].backdrop:Point('TOPLEFT', 0, -10)
		_G['CombatConfigTab'..i].backdrop:Point('BOTTOMRIGHT', -2, 3)
		_G['CombatConfigTab'..i..'Text']:Point('BOTTOM', 0, 10)
	end

	_G.ChatConfigChatSettingsClassColorLegend.NineSlice:Hide()
	_G.ChatConfigChannelSettingsClassColorLegend.NineSlice:Hide()

	BORDER:CreateBorder(_G.CombatConfigSettingsNameEditBox.backdrop)

	ChatConfigFrame:HookScript('OnShow', function()
		for tab in _G.ChatConfigFrameChatTabManager.tabPool:EnumerateActive() do
			BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, false, true)
		end
	end)

	hooksecurefunc('ChatConfig_UpdateCheckboxes', function(frame)
		if not _G.FCF_GetCurrentChatFrame() then
			return
		end
		for index in ipairs(frame.checkBoxTable) do
			local checkBoxNameString = frame:GetName()..'Checkbox'
			local checkBoxName = checkBoxNameString..index
			local checkBox = _G[checkBoxName]
			local check = _G[checkBoxName..'Check']
			if checkBox and not checkBox.IsBorder then
				BORDER:CreateBorder(check, nil, nil, nil, nil, nil, true, true)
				if _G[checkBoxName..'ColorClasses'] then
					BORDER:CreateBorder(_G[checkBoxName..'ColorClasses'], nil, nil, nil, nil, nil, true, true)
				end
				checkBox.IsBorder = true
			end
		end
	end)

	hooksecurefunc('ChatConfig_UpdateTieredCheckboxes', function(frame, index)
		local group = frame.checkBoxTable[index]
		local checkBox = _G[frame:GetName()..'Checkbox'..index]
		if checkBox then
			BORDER:CreateBorder(checkBox, nil, nil, nil, nil, nil, true, true)
		end
		if group.subTypes then
			for k in ipairs(group.subTypes) do
				BORDER:CreateBorder(_G[frame:GetName()..'Checkbox'..index..'_'..k], nil, nil, nil, nil, nil, true, true)
			end
		end
	end)

	hooksecurefunc('ChatConfig_CreateBoxes', function(frame)
		local boxName = frame:GetName()..'Box'

		if frame.boxTable then
			for index in next, frame.boxTable do
				local box = _G[boxName..index]
				if box then
					if box.Button then
						BORDER:CreateBorder(box.Button, nil, nil, nil, nil, nil, false, true)
					end
				end
			end
		end
	end)

	local OptionsFrames = { _G.InterfaceOptionsFrame, _G.InterfaceOptionsFrameCategories, _G.InterfaceOptionsFramePanelContainer, _G.InterfaceOptionsFrameAddOns, _G.VideoOptionsFrame, _G.VideoOptionsFrameCategoryFrame, _G.VideoOptionsFramePanelContainer, _G.Display_, _G.Graphics_, _G.RaidGraphics_ }
	local OptionsFrameBackdrops = { _G.AudioOptionsSoundPanelHardware, _G.AudioOptionsSoundPanelVolume, _G.AudioOptionsSoundPanelPlayback, _G.AudioOptionsVoicePanelTalking, _G.AudioOptionsVoicePanelListening, _G.AudioOptionsVoicePanelBinding }
	local OptionsButtons = { _G.GraphicsButton, _G.RaidButton }

	local InterfaceOptions = {
		_G.InterfaceOptionsFrame,
		_G.InterfaceOptionsControlsPanel,
		_G.InterfaceOptionsCombatPanel,
		_G.InterfaceOptionsDisplayPanel,
		_G.InterfaceOptionsSocialPanel,
		_G.InterfaceOptionsActionBarsPanel,
		_G.InterfaceOptionsNamesPanel,
		_G.InterfaceOptionsNamesPanelFriendly,
		_G.InterfaceOptionsNamesPanelEnemy,
		_G.InterfaceOptionsNamesPanelUnitNameplates,
		_G.InterfaceOptionsCameraPanel,
		_G.InterfaceOptionsMousePanel,
		_G.InterfaceOptionsAccessibilityPanel,
		_G.VideoOptionsFrame,
		_G.Display_,
		_G.Graphics_,
		_G.RaidGraphics_,
		_G.Advanced_,
		_G.NetworkOptionsPanel,
		_G.InterfaceOptionsLanguagesPanel,
		_G.AudioOptionsSoundPanel,
		_G.AudioOptionsSoundPanelHardware,
		_G.AudioOptionsSoundPanelVolume,
		_G.AudioOptionsSoundPanelPlayback,
		_G.AudioOptionsVoicePanel,
		_G.CompactUnitFrameProfiles,
		_G.CompactUnitFrameProfilesGeneralOptionsFrame,
	}

	for _, Frame in pairs(OptionsFrames) do
		BORDER:CreateBorder(Frame)
	end

	for _, Frame in pairs(OptionsFrameBackdrops) do
		BORDER:CreateBorder(Frame)
	end

	for _, Tab in pairs(OptionsButtons) do
		BORDER:CreateBorder(Button, nil, nil, nil, nil, nil, false, true)
	end

	for _, Panel in pairs(InterfaceOptions) do
		if Panel then
			for _, Child in next, { Panel:GetChildren() } do
				if Child:IsObjectType('CheckButton') then
					BORDER:CreateBorder(Child, nil, nil, nil, nil, nil, true, true)
				elseif Child:IsObjectType('Button') then
					BORDER:CreateBorder(Child, nil, nil, nil, nil, nil, false, true)
				elseif Child:IsObjectType('Slider') then
					BORDER:CreateBorder(Child, nil, nil, nil, nil, nil, false, true)
				elseif Child:IsObjectType('Tab') then
					BORDER:CreateBorder(Child, nil, nil, nil, nil, nil, true, true)
				elseif Child:IsObjectType('Frame') and (Child.Left and Child.Middle and Child.Right) then
					BORDER:CreateBorder(Child, nil, nil, nil, nil, nil, true, true)
				end
			end
		end
	end

	-- Create New Raid Profle
	local newProfileDialog = _G.CompactUnitFrameProfilesNewProfileDialog
	if newProfileDialog then
		BORDER:CreateBorder(newProfileDialog.backdrop)

		BORDER:CreateBorder(_G.CompactUnitFrameProfilesNewProfileDialogCreateButton, nil, nil, nil, nil, nil, false, true)
		BORDER:CreateBorder(_G.CompactUnitFrameProfilesNewProfileDialogCancelButton, nil, nil, nil, nil, nil, false, true)

		if newProfileDialog.editBox then
			BORDER:CreateBorder(newProfileDialog.editBox, nil, nil, nil, nil, nil, true, false)
		end
	end

	-- Delete Raid Profile
	local deleteProfileDialog = _G.CompactUnitFrameProfilesDeleteProfileDialog
	if deleteProfileDialog then
		BORDER:CreateBorder(deleteProfileDialog.backdrop)

		BORDER:CreateBorder(_G.CompactUnitFrameProfilesDeleteProfileDialogDeleteButton, nil, nil, nil, nil, nil, false, true)
		BORDER:CreateBorder(_G.CompactUnitFrameProfilesDeleteProfileDialogCancelButton, nil, nil, nil, nil, nil, false, true)
	end

	-- TextToSpeech
	BORDER:CreateBorder(_G.TextToSpeechFramePlaySampleButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.TextToSpeechFramePlaySampleAlternateButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.TextToSpeechDefaultButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.TextToSpeechCharacterSpecificButton, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(_G.TextToSpeechFrameAdjustRateSlider, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.TextToSpeechFrameAdjustVolumeSlider, nil, nil, nil, nil, nil, false, true)

	for _, checkbox in pairs({ -- check boxes
		'PlayActivitySoundWhenNotFocusedCheckButton',
		'PlaySoundSeparatingChatLinesCheckButton',
		'AddCharacterNameToSpeechCheckButton',
		'NarrateMyMessagesCheckButton',
		'UseAlternateVoiceForSystemMessagesCheckButton',
	}) do
		BORDER:CreateBorder(_G.TextToSpeechFramePanelContainer[checkbox], nil, nil, nil, nil, nil, true, true)
	end

	hooksecurefunc('TextToSpeechFrame_UpdateMessageCheckboxes', function(frame)
		if not frame.checkBoxTable then return end

		local nameString = frame:GetName()..'CheckBox'
		for index in ipairs(frame.checkBoxTable) do
			local checkBox = _G[nameString..index]
			if checkBox and not checkBox.IsBorder then
				BORDER:CreateBorder(checkBox, nil, nil, nil, nil, nil, true, true)

				checkBox.IsBorder = true
			end
		end
	end)
end

S:AddCallback('BlizzardOptions')
