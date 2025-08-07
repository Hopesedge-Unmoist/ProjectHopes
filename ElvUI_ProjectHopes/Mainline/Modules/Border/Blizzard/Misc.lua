local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local _G = _G
local next = next
local unpack = unpack

local CreateFrame = CreateFrame
local hooksecurefunc = hooksecurefunc

function S:BlizzardMiscFrames()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.misc) then return end
	if not E.db.ProjectHopes.skins.misc then return end

	for _, frame in next, { _G.AutoCompleteBox, _G.QueueStatusFrame } do
		BORDER:CreateBorder(frame)
		frame:SetFrameLevel(2)
	end

	-- ReadyCheck thing
	BORDER:CreateBorder(_G.ReadyCheckFrameYesButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.ReadyCheckFrameNoButton, nil, nil, nil, nil, nil, false, true)

	local ReadyCheckFrame = _G.ReadyCheckFrame
	BORDER:CreateBorder(ReadyCheckFrame)

	local ListenerFrame = _G.ReadyCheckListenerFrame
	BORDER:CreateBorder(ListenerFrame)

	BORDER:CreateBorder(_G.StaticPopup1ExtraButton, nil, nil, nil, nil, nil, false, true)


	if _G.TimerTrackerTimer1StatusBar then 
		BORDER:CreateBorder(_G.TimerTrackerTimer1StatusBar)
		TimerTrackerTimer1StatusBar:SetHeight(16)
	end
	
	local timermonitor = CreateFrame("FRAME")
	timermonitor:RegisterEvent("START_TIMER")
	timermonitor:SetScript("OnEvent", function()
		if _G.TimerTracker and _G.TimerTracker.timerList then
			for _, b in pairs(_G.TimerTracker.timerList) do
				if b.bar and not b.bar.border then
					BORDER:CreateBorder(b.bar)
				end
			end
		end
	end)

	-- reskin all esc/menu buttons
	if not E:IsAddOnEnabled('ConsolePort_Menu') then
		local GameMenuFrame = _G.GameMenuFrame
		BORDER:CreateBorder(GameMenuFrame)

		local function ClearedHooks(button, script)
			if script == 'OnEnter' then
				button:HookScript('OnEnter', BORDER.SetModifiedBackdrop)
			elseif script == 'OnLeave' then
				button:HookScript('OnLeave', BORDER.SetOriginalBackdrop)
			elseif script == 'OnDisable' then
				button:HookScript('OnDisable', BORDER.SetDisabledBackdrop)
			end
		end

		hooksecurefunc(GameMenuFrame, 'InitButtons', function(menu)
			if not menu.buttonPool then return end

			for button in menu.buttonPool:EnumerateActive() do
				if not button.IsBorder then
					button.backdrop:Hide()

					BORDER:CreateBorder(button, nil, -5, 5, 5, -5, false, true)
					hooksecurefunc(button, 'SetScript', ClearedHooks)
				end
			end

			if menu.ElvUI and not menu.ElvUI.IsBorder then
				menu.ElvUI.backdrop:Hide()

				BORDER:CreateBorder(menu.ElvUI, nil, -5, 5, 5, -5, false, true)
			end

			if menu.ProjectHopes and not menu.ProjectHopes.IsBorder then
				menu.ProjectHopes.backdrop:Hide()

				BORDER:CreateBorder(menu.ProjectHopes, nil, -5, 5, 5, -5, false, true)
			end

		end)
	end

	-- since we cant hook `CinematicFrame_OnShow` or `CinematicFrame_OnEvent` directly
	-- we can just hook onto this function so that we can get the correct `self`
	-- this is called through `CinematicFrame_OnShow` so the result would still happen where we want
	hooksecurefunc('CinematicFrame_UpdateLettboxForAspectRatio', function(s)
		if s and s.closeDialog and s.closeDialog.template then
			local dialogName = s.closeDialog.GetName and s.closeDialog:GetName()
			local closeButton = s.closeDialog.ConfirmButton or (dialogName and _G[dialogName..'ConfirmButton'])
			local resumeButton = s.closeDialog.ResumeButton or (dialogName and _G[dialogName..'ResumeButton'])
			if s.closeDialog then
				BORDER:CreateBorder(s.closeDialog)
			end
			if closeButton then
				BORDER:CreateBorder(closeButton, nil, nil, nil, nil, nil, false, true) 
			end

			if resumeButton then 
				BORDER:CreateBorder(resumeButton, nil, nil, nil, nil, nil, false, true) 
			end

		end
	end)

	-- same as above except `MovieFrame_OnEvent` and `MovieFrame_OnShow`
	-- cant be hooked directly so we can just use this
	-- this is called through `MovieFrame_OnEvent` on the event `PLAY_MOVIE`
	hooksecurefunc('MovieFrame_PlayMovie', function(s)
		if s and s.CloseDialog and s.CloseDialog.template then
			BORDER:CreateBorder(s.CloseDialog)

			BORDER:CreateBorder(s.CloseDialog.ConfirmButton, nil, nil, nil, nil, nil, false, true)
			BORDER:CreateBorder(s.CloseDialog.ResumeButton, nil, nil, nil, nil, nil, false, true)
		end
	end)

	--LFD Role Picker frame
	BORDER:CreateBorder(_G.LFDRoleCheckPopup)

	BORDER:CreateBorder(_G.LFDRoleCheckPopupAcceptButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.LFDRoleCheckPopupDeclineButton, nil, nil, nil, nil, nil, false, true)

	for _, roleButton in next, {
		_G.LFDRoleCheckPopupRoleButtonTank,
		_G.LFDRoleCheckPopupRoleButtonDPS,
		_G.LFDRoleCheckPopupRoleButtonHealer
	} do
		BORDER:CreateBorder(roleButton.checkButton or roleButton.CheckButton, nil, nil, nil, nil, nil, true, true)
	end

	-- reskin popup buttons
	for i = 1, 4 do
		local StaticPopup = _G['StaticPopup'..i]
		BORDER:CreateBorder(StaticPopup)

		StaticPopup:HookScript('OnShow', function() -- UpdateRecapButton is created OnShow
			if StaticPopup.UpdateRecapButton and (not StaticPopup.UpdateRecapButtonHookedBorder) then
				StaticPopup.UpdateRecapButtonHookedBorder = true -- we should only hook this once
				hooksecurefunc(StaticPopup, 'UpdateRecapButton', S.UpdateRecapButton)
			end
		end)

		for j = 1, 4 do
			local button = _G["StaticPopup"..i.."Button"..j]
			BORDER:CreateBorder(button, nil, nil, nil, nil, nil, false, true)
		end


		local editbox = _G['StaticPopup'..i..'EditBox']
		BORDER:CreateBorder(_G['StaticPopup'..i..'MoneyInputFrameGold'], nil, nil, nil, nil, nil, true, false)
		BORDER:CreateBorder(_G['StaticPopup'..i..'MoneyInputFrameSilver'], nil, nil, nil, nil, nil, true, false)
		BORDER:CreateBorder(_G['StaticPopup'..i..'MoneyInputFrameCopper'], nil, nil, nil, nil, nil, true, false)
		BORDER:CreateBorder(editbox, nil, nil, nil, nil, nil, true, false)

		local ItemFrame = _G['StaticPopup'..i..'ItemFrame']
		local IconTexture = _G['StaticPopup'..i..'ItemFrameIconTexture']

		BORDER:CreateBorder(IconTexture, nil, -8, 8, 7, -8)
	end

	-- UIWidget
	S:SecureHook(
		S,
		"SkinStatusBarWidget",
		function(_, widgetFrame)
			if widgetFrame.Bar then
				BORDER:CreateBorder(widgetFrame.Bar, nil, nil, nil, nil, nil, true, false)
			end
		end
	)

	for _, child in ipairs({_G.UIWidgetTopCenterContainerFrame:GetChildren()}) do
		if child.Item and not child.IsBorder then
			child.Item.Icon:CreateBackdrop()
			BORDER:CreateBorder(child.Item.Icon.backdrop)
			BORDER:HandleIconBorder(child.Item.IconBorder, child.Item.Icon.backdrop.border)
			child.IsBorder = true
		end
	end

	S:SecureHook(
		_G.UIWidgetTemplateStatusBarMixin,
		"Setup",
		function(widget)
			local forbidden = widget:IsForbidden()
			local bar = widget.Bar
			local id = widget.widgetSetID

			if forbidden or id == 283 or not bar or not bar.backdrop then
				return
			end

			BORDER:CreateBorder(bar, nil, nil, nil, nil, nil, true, false)
			bar:SetStatusBarTexture(Private.HopesUI)

			if widget.isJailersTowerBar and BORDER:CheckDB(nil, "scenario") then
				bar:SetWidth(234)
			end
		end
	)

	S:SecureHook(
		_G.UIWidgetTemplateCaptureBarMixin,
		"Setup",
		function(widget)
			local bar = widget.Bar
			if bar then
				BORDER:CreateBorder(bar, nil, nil, nil, nil, nil, true, false)
			end
		end
	)

	local function ReskinBar(bar)
		if bar and bar.backdrop then
			BORDER:CreateBorder(bar)
		end
	end

	S:SecureHook(S, "SkinDoubleStatusBarWidget", function(_, widget)
		
		ReskinBar(widget.LeftBar)
		ReskinBar(widget.RightBar)
	end)

	-- skin return to graveyard button
	do
		BORDER:CreateBorder(_G.GhostFrameContentsFrame)
		BORDER:CreateBorder(_G.GhostFrameContentsFrameIcon)
	end

	hooksecurefunc('UIDropDownMenu_CreateFrames', function(level, index)
		local listFrame = _G['DropDownList'..level]
		local listFrameName = listFrame:GetName()

		local Backdrop = _G[listFrameName..'Backdrop']
		if Backdrop and Backdrop.template then
			BORDER:CreateBorder(Backdrop)
		end

		local menuBackdrop = _G[listFrameName..'MenuBackdrop']
		if menuBackdrop and menuBackdrop.template then
			BORDER:CreateBorder(menuBackdrop)
		end
	end)

	local SideDressUpFrame = _G.SideDressUpFrame
	BORDER:CreateBorder(SideDressUpFrame)
	BORDER:CreateBorder(SideDressUpFrame.ResetButton, nil, nil, nil, nil, nil, false, true)
	BORDER:HandleModelSceneControlButtons(SideDressUpFrame.ModelScene.ControlFrame)

	local StackSplitFrame = _G.StackSplitFrame
	BORDER:CreateBorder(StackSplitFrame)
	BORDER:CreateBorder(StackSplitFrame.bg1)

	BORDER:CreateBorder(StackSplitFrame.OkayButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(StackSplitFrame.CancelButton, nil, nil, nil, nil, nil, false, true)

	-- NavBar Buttons (Used in WorldMapFrame, EncounterJournal and HelpFrame)
	hooksecurefunc('NavBar_AddButton', BORDER.HandleNavBarButtons)

	-- Basic Message Dialog
	local MessageDialog = _G.BasicMessageDialog
	if MessageDialog then
		BORDER:CreateBorder(MessageDialog)
		BORDER:CreateBorder(_G.BasicMessageDialogButton, nil, nil, nil, nil, nil, false, true)
	end

	-- Color Picker
	local ColorPickerFrame = _G.ColorPickerFrame
	BORDER:CreateBorder(ColorPickerFrame)
	BORDER:CreateBorder(ColorPickerFrame.Footer.OkayButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(ColorPickerFrame.Footer.CancelButton, nil, nil, nil, nil, nil, false, true)

	BORDER:HandleIcon(ColorPickerFrame.Content.ColorPicker.Value, true)
	
	BORDER:HandleIcon(ColorPickerFrame.Content.ColorPicker.Alpha, true)
	ColorPickerFrame.Content.ColorPicker.Alpha.backdrop.border:Hide()

	ColorPickerFrame:HookScript('OnShow', function(frame)
		if frame.hasOpacity then
			ColorPickerFrame.Content.ColorPicker.Alpha.backdrop.border:Show()
			ColorPickerFrame.Content.ColorPicker.Alpha.backdrop:Show()
		else
			ColorPickerFrame.Content.ColorPicker.Alpha.backdrop.border:Hide()
			ColorPickerFrame.Content.ColorPicker.Alpha.backdrop:Hide()
		end
	end)
   
	BORDER:HandleIcon(ColorPickerFrame.Content.ColorSwatchCurrent, true)
	BORDER:HandleIcon(ColorPickerFrame.Content.ColorSwatchOriginal, true)
	if ColorPPCopyColorSwatch then
		BORDER:HandleIcon(ColorPPCopyColorSwatch, true)
	end

	ColorPickerFrame.Content.ColorSwatchCurrent:Point('TOPLEFT', ColorPickerFrame.Content, 'TOPRIGHT', -120, -32)
	ColorPickerFrame.Content.ColorSwatchOriginal:Point('TOPLEFT', ColorPickerFrame.Content.ColorSwatchCurrent, 'BOTTOMLEFT', 0, -5)

	BORDER:CreateBorder(ColorPPBoxR, nil, nil, nil, nil, nil, true)
	BORDER:CreateBorder(ColorPPBoxG, nil, nil, nil, nil, nil, true)
	BORDER:CreateBorder(ColorPPBoxB, nil, nil, nil, nil, nil, true)
	BORDER:CreateBorder(ColorPPBoxA, nil, nil, nil, nil, nil, true)
	
	BORDER:CreateBorder(ColorPPCopy, nil, -7, 7, 7, -7, false, true)
	ColorPPCopy:SetBackdrop('')
	BORDER:CreateBorder(ColorPPClass, nil, -7, 7, 7, -7, false, true)
	ColorPPClass:SetBackdrop('')
	BORDER:CreateBorder(ColorPPPaste, nil, -7, 7, 7, -7, false, true)
	ColorPPPaste:SetBackdrop('')
	BORDER:CreateBorder(ColorPPDefault, nil, -7, 7, 7, -7, false, true)
	ColorPPDefault:SetBackdrop('')
	
	BORDER:CreateBorder(ColorPickerFrame.Content.HexBox, nil, -9, 7, 8, -7, true)

	-- SplashFrame (Whats New)
	local SplashFrame = _G.SplashFrame
	BORDER:CreateBorder(SplashFrame.BottomCloseButton, nil, nil, nil, nil, nil, false, true)

	-- Icon Selection Frames (After ElvUI Skin)
	BORDER:SecureHook(S, "HandleIconSelectionFrame", function(_, frame)
		BORDER:HandleIconSelectionFrame(frame)
	end)
end

S:AddCallback('BlizzardMiscFrames')