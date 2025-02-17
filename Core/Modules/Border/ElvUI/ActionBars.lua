local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local AB = E:GetModule('ActionBars')

local _G = _G
local pairs = pairs
local NUM_STANCE_SLOTS = NUM_STANCE_SLOTS or 10
local NUM_PET_ACTION_SLOTS = NUM_PET_ACTION_SLOTS or 10
local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS

function S:ElvUI_ActionBar_SkinButton(button, useBackdrop)
	if button.border then
		if useBackdrop then
			button.border:Hide()
		else
			button.border:Show()
		end
	else
		BORDER:CreateBorder(button, 1)
	end

	local function MouseUp()
		button:GetPushedTexture():SetAlpha(0)
		button.border:SetBackdrop(Private.Border)
		if E.private.ProjectHopes.qualityOfLife.borederDarkmode then
			button.border:SetBackdropBorderColor(0, 0, 0)
		else
			button.border:SetBackdropBorderColor(1, 1, 1)
		end
	end

	local function MouseDown()
		button:GetPushedTexture():SetAlpha(0)
		button.border:SetBackdrop(Private.BorderLight)
		button.border:SetBackdropBorderColor(1, 0.78, 0.03)
	end

	button:RegisterEvent("GLOBAL_MOUSE_UP")
	button:HookScript('OnMouseUp', MouseUp)
	button:HookScript('OnMouseDown', MouseDown)
	button:SetScript("OnEvent", function(_, event)
		if event == "GLOBAL_MOUSE_UP" then
			MouseUp()
		end
	end)
end

function S:ElvUI_ActionBar_SkinBar(bar, type)
	if not bar and bar.backdrop then
		return
	end

	if E.db.ProjectHopes.skins.actionBarsBackdrop then
		bar.backdrop:SetTemplate("Transparent")
		if bar.db.backdrop then
			if not bar.backdrop.border then
				BORDER:CreateBorder(bar.backdrop)
			end
			if bar.backdrop.border then
				bar.backdrop.border:Show()
			end
		else
			if bar.backdrop.border then
				bar.backdrop.border:Hide()
			end
		end
		
	end

	if E.db.ProjectHopes.skins.actionBarsButton then
		if type == "PLAYER" then
			for i = 1, NUM_ACTIONBAR_BUTTONS do
				local button = bar.buttons[i]
				self:ElvUI_ActionBar_SkinButton(button, bar.db.backdrop)
			end
		elseif type == "PET" then
			for i = 1, NUM_PET_ACTION_SLOTS do
				local button = _G["PetActionButton" .. i]
				self:ElvUI_ActionBar_SkinButton(button, bar.db.backdrop)
			end
		elseif type == "STANCE" then
			for i = 1, NUM_STANCE_SLOTS do
				local button = _G["ElvUI_StanceBarButton" .. i]
				self:ElvUI_ActionBar_SkinButton(button, bar.db.backdrop)
			end
		end
	end
end

function S:ElvUI_ActionBar_PositionAndSizeBar(actionBarModule, barName)
	local bar = actionBarModule.handledBars[barName]
	self:ElvUI_ActionBar_SkinBar(bar, "PLAYER")
end

function S:ElvUI_ActionBar_PositionAndSizeBarPet()
	self:ElvUI_ActionBar_SkinBar(_G.ElvUI_BarPet, "PET")
end

function S:ElvUI_ActionBar_PositionAndSizeBarShapeShift()
	self:ElvUI_ActionBar_SkinBar(_G.ElvUI_StanceBar, "STANCE")
end

function S:SkinZoneAbilities(button)
	for spellButton in button.SpellButtonContainer:EnumerateActive() do
		if spellButton then
			BORDER:CreateBorder(spellButton)
		end
	end
end

function S:ElvUI_ActionBar_LoadKeyBinder()
	local frame = _G.ElvUIBindPopupWindow
	if not frame then
		S:SecureHook(AB, "LoadKeyBinder", "ElvUI_ActionBar_LoadKeyBinder")
		return
	end
	frame:SetSize(400, 150)
	frame.header:SetFrameLevel(101)
	BORDER:CreateBorder(frame, 1)
	BORDER:CreateBorder(frame.header, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.ElvUIBindPopupWindowCheckButton, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.ElvUIBindPopupWindowDiscardButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.ElvUIBindPopupWindowSaveButton, nil, nil, nil, nil, nil, false, true)
end

function S:ElvUI_ActionBars()
	if not (E.db.ProjectHopes.skins.actionBarsButton or E.db.ProjectHopes.skins.actionBarsBackdrop) then
		return 
	end

    -- ElvUI action bar
    if not E.private.actionbar.masque.actionbars then
        for id = 1, 15 do
            local bar = _G["ElvUI_Bar" .. id]
            if bar then
                S:ElvUI_ActionBar_SkinBar(bar, "PLAYER")
            end
        end

        S:SecureHook(AB, "PositionAndSizeBar", "ElvUI_ActionBar_PositionAndSizeBar")
    end

    -- Pet bar
    if not E.private.actionbar.masque.petBar then
        S:ElvUI_ActionBar_SkinBar(_G.ElvUI_BarPet, "PET")
        S:SecureHook(AB, "PositionAndSizeBarPet", "ElvUI_ActionBar_PositionAndSizeBarPet")
    end

    -- Stance bar
    if not E.private.actionbar.masque.stanceBar then
        S:ElvUI_ActionBar_SkinBar(_G.ElvUI_StanceBar, "STANCE")
        S:SecureHook(AB, "PositionAndSizeBarShapeShift", "ElvUI_ActionBar_PositionAndSizeBarShapeShift")
    end


    if not E.db.ProjectHopes.skins.actionBarsButton then
        return
    end

	if E.Retail then
		-- Extra action bar
		S:SecureHook(_G.ZoneAbilityFrame, "UpdateDisplayedZoneAbilities", "SkinZoneAbilities")

		for i = 1, _G.ExtraActionBarFrame:GetNumChildren() do
			local button = _G["ExtraActionButton" .. i]
			if button then
				BORDER:CreateBorder(button)
			end
		end
	end

    -- Vehicle leave button
    do
        local button = _G.MainMenuBarVehicleLeaveButton
        BORDER:CreateBorder(button, nil, nil, nil, nil, nil, true, true)
    end

	if E.Retail then
		-- Flyout
		S:SecureHook(
			AB,
			"SetupFlyoutButton",
			function(_, button)
				BORDER:CreateBorder(button)
			end
		)
	end

    -- Keybind
    S:ElvUI_ActionBar_LoadKeyBinder()
end

S:AddCallback("ElvUI_ActionBars")
