local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next = next
local hooksecurefunc = hooksecurefunc

local function HandleDialogs()
	local dialog = _G.EditModeSystemSettingsDialog
	for _, button in next, { dialog.Buttons:GetChildren() } do
		if button.Controller and not button.IsBorder then
			BORDER:CreateBorder(button, nil, nil, nil, nil, nil, false, true)
		end
	end

	for _, frame in next, { dialog.Settings:GetChildren() } do
		local dd = frame.Dropdown
		if dd and (dd.DropDownMenu and not dd.IsBorder) then
			BORDER:CreateBorder(dd.DropDownMenu, nil, nil, nil, nil, nil, true, true)
			dd.IsBorder = true
		end
	end
end

function S:EditorManagerFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.editor) then return end
    if not E.db.ProjectHopes.skins.editModeManager then return end

    -- Main Window
    local editMode = _G.EditModeManagerFrame
    BORDER:CreateBorder(editMode)

    BORDER:CreateBorder(editMode.RevertAllChangesButton, nil, nil, nil, nil, nil, false, true)
    BORDER:CreateBorder(editMode.SaveChangesButton, nil, nil, nil, nil, nil, false, true)
    BORDER:CreateBorder(editMode.LayoutDropdown, nil, nil, nil, nil, nil, true, true)

    BORDER:CreateBorder(editMode.ShowGridCheckButton.Button, nil, nil, nil, nil, nil, true, true)
    BORDER:CreateBorder(editMode.EnableSnapCheckButton.Button, nil, nil, nil, nil, nil, true, true)
    BORDER:CreateBorder(editMode.EnableAdvancedOptionsCheckButton.Button, nil, nil, nil, nil, nil, true, true)

    BORDER:CreateBorder(editMode.AccountSettings.SettingsContainer.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
    BORDER:CreateBorder(editMode.AccountSettings.SettingsContainer.ScrollChild, nil, -7, 7, 20, -7)

    -- Group Containers (Basic, Frames, Combat, Misc)
    for _, frames in next, { editMode.AccountSettings.SettingsContainer.ScrollChild:GetChildren() } do
        for _, frame in next, { frames:GetChildren() } do
            if frame.Button then -- BasicOptionsContainer
                BORDER:CreateBorder(frame.Button, nil, nil, nil, nil, nil, true, true)
            else -- AdvancedOptionsContainer
                for _, child in next, { frame:GetChildren() } do
                    if child.Button then
                        BORDER:CreateBorder(child.Button, nil, nil, nil, nil, nil, true, true)
                    end
                end
            end
        end
    end

    -- Layout Creator
    local layout = _G.EditModeNewLayoutDialog
	BORDER:CreateBorder(layout.AcceptButton, nil, nil, nil, nil, nil, false, true)
    BORDER:CreateBorder(layout.CancelButton, nil, nil, nil, nil, nil, false, true)
    BORDER:CreateBorder(layout.LayoutNameEditBox.backdrop)
    BORDER:CreateBorder(layout.CharacterSpecificLayoutCheckButton.Button)

    -- Layout Unsaved
    local unsaved = _G.EditModeUnsavedChangesDialog
    BORDER:CreateBorder(unsaved.CancelButton, nil, nil, nil, nil, nil, false, true)
    BORDER:CreateBorder(unsaved.ProceedButton, nil, nil, nil, nil, nil, false, true)
    BORDER:CreateBorder(unsaved.SaveAndProceedButton, nil, nil, nil, nil, nil, false, true)

    -- Layout Importer
    local import = _G.EditModeImportLayoutDialog
    BORDER:CreateBorder(import)

    BORDER:CreateBorder(import.AcceptButton, nil, nil, nil, nil, nil, false, true)
    BORDER:CreateBorder(import.CancelButton, nil, nil, nil, nil, nil, false, true)
    BORDER:CreateBorder(import.CharacterSpecificLayoutCheckButton.Button, nil, nil, nil, nil, nil, true, true)

    local importBox = import.ImportBox
    local importBackdrop = importBox.backdrop
    BORDER:CreateBorder(importBackdrop)


    local scrollbar = importBox.ScrollBar
    --BORDER:CreateBorder(scrollbar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

    local editbox = import.LayoutNameEditBox
    BORDER:CreateBorder(editbox.backdrop)

    local editbackdrop = editbox.backdrop

    -- Dialog (Mover Settings)
    local dialog = _G.EditModeSystemSettingsDialog
        
    hooksecurefunc(dialog.Buttons, 'AddLayoutChildren', HandleDialogs)
    HandleDialogs()
end

S:AddCallback('EditorManagerFrame')
