local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next = next
local hooksecurefunc = hooksecurefunc

local function HandleTalentFrameDialog(dialog)
	if not dialog then return end

	if dialog.AcceptButton then 
		BORDER:CreateBorder(dialog.AcceptButton, nil, nil, nil, nil, nil, false, true) 
	end
	if dialog.CancelButton then 
		BORDER:CreateBorder(dialog.CancelButton, nil, nil, nil, nil, nil, false, true)
	end
	if dialog.DeleteButton then 
		BORDER:CreateBorder(dialog.DeleteButton, nil, nil, nil, nil, nil, false, true)
	end

	BORDER:CreateBorder(dialog.NameControl.EditBox, nil, nil, nil, nil, nil, true, false)
end

local function UpdateSpecFrame(frame)
	if not frame.SpecContentFramePool then return end

	for specContentFrame in frame.SpecContentFramePool:EnumerateActive() do
		if not specContentFrame.IsBorder then
			BORDER:CreateBorder(specContentFrame.ActivateButton, nil, nil, nil, nil, nil, false, true)

			if specContentFrame.SpellButtonPool then
				for button in specContentFrame.SpellButtonPool:EnumerateActive() do               
					BORDER:HandleIcon(button.Icon)
				end
			end

			specContentFrame.IsBorder = true
		end
	end
end

local function HandleHeroTalents(frame)
	if not frame then return end

	for specFrame in frame.SpecContentFramePool:EnumerateActive() do
		if specFrame and not specFrame.IsBorder then
			BORDER:CreateBorder(specFrame.ActivateButton, nil, nil, nil, nil, nil, false, true)
			BORDER:CreateBorder(specFrame.ApplyChangesButton, nil, nil, nil, nil, nil, false, true)

			specFrame.IsBorder = true
		end
	end
end

function S:Blizzard_PlayerSpells()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.talent) then return end
	if not E.db.ProjectHopes.skins.spellBook then return end

	local PlayerSpellsFrame = _G.PlayerSpellsFrame
	BORDER:CreateBorder(PlayerSpellsFrame)
	
	-- Specialisation
	hooksecurefunc(PlayerSpellsFrame.SpecFrame, 'UpdateSpecFrame', UpdateSpecFrame)

	-- TalentsFrame
	local TalentsFrame = PlayerSpellsFrame.TalentsFrame
	BORDER:CreateBorder(TalentsFrame, 1, nil, nil, nil, 75)

	BORDER:CreateBorder(TalentsFrame.ApplyButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(TalentsFrame.LoadSystem.Dropdown, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(TalentsFrame.InspectCopyButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(TalentsFrame.SearchBox, nil, nil, nil, nil, nil, true, false)

	BORDER:CreateBorder(TalentsFrame.PvPTalentList.backdrop)

	local TalentsSelect = _G.HeroTalentsSelectionDialog
	if TalentsSelect then
		BORDER:CreateBorder(TalentsSelect)
	end

	for _, tab in next, { PlayerSpellsFrame.TabSystem:GetChildren() } do
		BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)
	end

	PlayerSpellsFrame.TabSystem:ClearAllPoints()
	PlayerSpellsFrame.TabSystem:Point('TOPLEFT', PlayerSpellsFrame, 'BOTTOMLEFT', -3, -5)

	local ImportDialog = _G.ClassTalentLoadoutImportDialog
	if ImportDialog then
		BORDER:CreateBorder(ImportDialog)
		BORDER:CreateBorder(ImportDialog.ImportControl.InputContainer, nil, nil, nil, nil, nil, true, false)

		HandleTalentFrameDialog(ImportDialog)
	end

	local CreateDialog = _G.ClassTalentLoadoutCreateDialog
	if CreateDialog then
		BORDER:CreateBorder(CreateDialog)

		HandleTalentFrameDialog(CreateDialog)
	end

	local EditDialog = _G.ClassTalentLoadoutEditDialog
	if EditDialog then
		BORDER:CreateBorder(EditDialog)

		HandleTalentFrameDialog(EditDialog)

		local editbox = EditDialog.LoadoutName
		if editbox then
			BORDER:CreateBorder(editbox, nil, nil, nil, nil, nil, true, false)
		end

		local check = EditDialog.UsesSharedActionBars
		if check then
			BORDER:CreateBorder(check.CheckButton, nil, nil, nil, nil, nil, true, true)
		end
	end

	-- Hero Talents
	local HeroTalentContainer = TalentsFrame.HeroTalentsContainer
	local TalentsSelect = _G.HeroTalentsSelectionDialog
	if TalentsSelect then
		hooksecurefunc(TalentsSelect, 'ShowDialog', HandleHeroTalents)
	end

	-- SpellBook
	local SpellBookFrame = PlayerSpellsFrame.SpellBookFrame
	if SpellBookFrame then
		BORDER:CreateBorder(SpellBookFrame.SearchBox, nil, nil, nil, nil, nil, true, false)

		for _, tab in next, { SpellBookFrame.CategoryTabSystem:GetChildren() } do
			BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)
		end
	end
end

S:AddCallbackForAddon('Blizzard_PlayerSpells')