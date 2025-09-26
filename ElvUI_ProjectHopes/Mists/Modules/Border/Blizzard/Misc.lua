local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next, unpack = next, unpack

local hooksecurefunc = hooksecurefunc
local UnitIsUnit = UnitIsUnit
local CreateFrame = CreateFrame

function S:BlizzardMiscFrames()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.misc) then return end
	if not E.db.ProjectHopes.skins.misc then return end

	for _, frame in next, { _G.AutoCompleteBox, _G.ReadyCheckFrame } do
		BORDER:CreateBorder(frame)
	end

	-- here we reskin all 'normal' buttons
	BORDER:CreateBorder(_G.ReadyCheckFrameYesButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.ReadyCheckFrameNoButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(_G.PVPReadyDialog)
	BORDER:CreateBorder(_G.PVPReadyDialogEnterBattleButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.PVPReadyDialogHideButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(_G.StaticPopup1ExtraButton, nil, nil, nil, nil, nil, false, true)

	if not E:IsAddOnEnabled('ConsolePort_Menu') then
		-- reskin all esc/menu buttons
		for _, Button in next, { _G.GameMenuFrame:GetChildren() } do
			if Button.IsObjectType and Button:IsObjectType('Button') then
				Button:SetBackdrop()
				BORDER:CreateBorder(Button, nil, -7, 7, 7, -7, false, true)		
			end
		end

		BORDER:CreateBorder(_G.GameMenuFrame)
	end

	if E:IsAddOnEnabled('OptionHouse') then
		BORDER:CreateBorder(_G.GameMenuButtonOptionHouse, nil, nil, nil, nil, nil, false, true)
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
			local button = StaticPopup['button'..j]
			BORDER:CreateBorder(button, nil, nil, nil, nil, nil, false, true)
		end

		BORDER:CreateBorder(_G['StaticPopup'..i..'EditBox'], nil, nil, nil, nil, nil, true, false)
		BORDER:CreateBorder(_G['StaticPopup'..i..'MoneyInputFrameGold'], nil, nil, nil, nil, nil, true, false)
		BORDER:CreateBorder(_G['StaticPopup'..i..'MoneyInputFrameSilver'], nil, nil, nil, nil, nil, true, false)
		BORDER:CreateBorder(_G['StaticPopup'..i..'MoneyInputFrameCopper'], nil, nil, nil, nil, nil, true, false)

		--local itemFrame = _G['StaticPopup'..i..'ItemFrame']
		--BORDER:CreateBorder(itemFrame, nil, -8, 8, 7, -8)
		--BORDER:HandleIconBorder(itemFrame.IconBorder, itemFrame.border)
	end

	--DropDownMenu
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

	local StackSplitFrame = _G.StackSplitFrame
	BORDER:CreateBorder(StackSplitFrame)
	BORDER:CreateBorder(StackSplitFrame.bg1)

	BORDER:CreateBorder(_G.StackSplitOkayButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.StackSplitCancelButton, nil, nil, nil, nil, nil, false, true)

	-- Color Picker
	local ColorPickerFrame = _G.ColorPickerFrame
	BORDER:CreateBorder(ColorPickerFrame)
	BORDER:CreateBorder(_G.ColorPickerOkayButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.ColorPickerCancelButton, nil, nil, nil, nil, nil, false, true)
   
	BORDER:HandleIcon(ColorPPCopyColorSwatch, true)

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
	
	-- NavBar Buttons (Used in WorldMapFrame, EncounterJournal and HelpFrame)
	hooksecurefunc('NavBar_AddButton', BORDER.HandleNavBarButtons)

	-- Icon Selection Frames (After ElvUI Skin)
	BORDER:SecureHook(S, "HandleIconSelectionFrame", function(_, frame)
		BORDER:HandleIconSelectionFrame(frame)
	end)
end

S:AddCallback('BlizzardMiscFrames')
