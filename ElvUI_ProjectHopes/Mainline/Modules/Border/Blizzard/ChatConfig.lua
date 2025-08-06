local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local ipairs, pairs, next = ipairs, pairs, next

local FCF_GetCurrentChatFrame = FCF_GetCurrentChatFrame
local hooksecurefunc = hooksecurefunc

function S:ChatConfig()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.blizzardOptions) then return end
	if not E.db.ProjectHopes.skins.blizzardOptions then return end

	local ChatConfigFrame = _G.ChatConfigFrame

	BORDER:CreateBorder(ChatConfigFrame)

	hooksecurefunc('ChatConfig_UpdateCheckboxes', function(frame)
		if not FCF_GetCurrentChatFrame() then return end

		local nameString = frame:GetName()..'Checkbox'
		for index in ipairs(frame.checkBoxTable) do
			local checkboxName = nameString..index
			local checkbox = _G[checkboxName]
			if checkbox and not checkbox.IsBorder then
				BORDER:CreateBorder(_G[checkboxName..'Check'], nil, nil, nil, nil, nil, true, true)

				checkbox.IsBorder = true
			end
		end
	end)

	hooksecurefunc('ChatConfig_CreateTieredCheckboxes', function(frame, checkBoxTable)
		if frame.IsBorder then return end

		local nameString = frame:GetName()..'Checkbox'
		for index, value in ipairs(checkBoxTable) do
			local checkboxName = nameString..index
			BORDER:CreateBorder(_G[checkboxName], nil, nil, nil, nil, nil, true, true)

			if value.subTypes then
				for i in ipairs(value.subTypes) do
					BORDER:CreateBorder(_G[checkboxName..'_'..i], nil, nil, nil, nil, nil, true, true)
				end
			end
		end

		frame.IsBorder = true
	end)
	
	for _, frame in pairs({ -- backdrops
	_G.ChatConfigCategoryFrame,
	_G.ChatConfigBackgroundFrame,
	_G.ChatConfigCombatSettingsFilters,
	}) do
		BORDER:CreateBorder(frame, nil, -7, 7, 7, -7)
	end

	for _, box in pairs({ -- combat boxes
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
		_G.CombatConfigSettingsRaid
	}) do
		BORDER:CreateBorder(box, nil, nil, nil, nil, nil, true, true)
	end

	BORDER:CreateBorder(_G.CombatLogDefaultButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.ChatConfigCombatSettingsFiltersCopyFilterButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.ChatConfigCombatSettingsFiltersAddFilterButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.ChatConfigCombatSettingsFiltersDeleteButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.CombatConfigSettingsSaveButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.ChatConfigFrameOkayButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.ChatConfigFrameDefaultButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.ChatConfigFrameRedockButton, nil, nil, nil, nil, nil, false, true)

	_G.ChatConfigFrameDefaultButton:ClearAllPoints()
	_G.ChatConfigFrameDefaultButton:SetPoint("TOPLEFT", _G.ChatConfigCategoryFrame, "BOTTOMLEFT", 0, -5)
	_G.ChatConfigFrameRedockButton:ClearAllPoints()
	_G.ChatConfigFrameRedockButton:SetPoint("LEFT", _G.ChatConfigFrameDefaultButton, "RIGHT", 5, 0)
	_G.ChatConfigFrameOkayButton:ClearAllPoints()
	_G.ChatConfigFrameOkayButton:SetPoint("TOPRIGHT", _G.ChatConfigBackgroundFrame, "BOTTOMRIGHT", 0, -5)

	_G.ChatConfigCombatSettingsFiltersDeleteButton:ClearAllPoints()
	_G.ChatConfigCombatSettingsFiltersDeleteButton:SetPoint("TOPRIGHT", _G.ChatConfigCombatSettingsFilters, "BOTTOMRIGHT", 0, -5)
	_G.ChatConfigCombatSettingsFiltersAddFilterButton:ClearAllPoints()
	_G.ChatConfigCombatSettingsFiltersAddFilterButton:SetPoint("RIGHT", _G.ChatConfigCombatSettingsFiltersDeleteButton, "LEFT", -5, 0)
	_G.ChatConfigCombatSettingsFiltersCopyFilterButton:ClearAllPoints()
	_G.ChatConfigCombatSettingsFiltersCopyFilterButton:SetPoint("RIGHT", _G.ChatConfigCombatSettingsFiltersAddFilterButton, "LEFT", -5, 0)

	BORDER:CreateBorder(_G.CombatConfigSettingsNameEditBox.backdrop)
	BORDER:CreateBorder(_G.ChatConfigCombatSettingsFilters.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	-- TextToSpeech    


		if _G.TextToSpeechFramePlaySampleButton then
			BORDER:CreateBorder(_G.TextToSpeechFramePlaySampleButton, nil, nil, nil, nil, nil, false, true)
			BORDER:CreateBorder(_G.TextToSpeechFramePlaySampleAlternateButton, nil, nil, nil, nil, nil, false, true)
			BORDER:CreateBorder(_G.TextToSpeechDefaultButton, nil, nil, nil, nil, nil, false, true)
			BORDER:CreateBorder(_G.TextToSpeechCharacterSpecificButton, nil, nil, nil, nil, nil, true, true)

			BORDER:CreateBorder(_G.TextToSpeechFrameTtsVoiceDropdown)
			BORDER:CreateBorder(_G.TextToSpeechFrameTtsVoiceAlternateDropdown)
			BORDER:CreateBorder(_G.TextToSpeechFrameAdjustRateSlider)
			BORDER:CreateBorder(_G.TextToSpeechFrameAdjustVolumeSlider)
	end



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

S:AddCallback('ChatConfig')
