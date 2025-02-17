local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next = next
local unpack = unpack
local hooksecurefunc = hooksecurefunc

function S:Blizzard_MacroUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.macro) then return end
	if not E.db.ProjectHopes.skins.macro then return end

	local MacroFrame = _G.MacroFrame
	BORDER:CreateBorder(MacroFrame)

	BORDER:CreateBorder(MacroFrame.MacroSelector.ScrollBar, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.MacroFrameScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)

	for _, button in next, {
		_G.MacroSaveButton,
		_G.MacroCancelButton,
		_G.MacroDeleteButton,
		_G.MacroNewButton,
		_G.MacroExitButton,
		_G.MacroEditButton,
		_G.MacroFrameTab1,
		_G.MacroFrameTab2,
	} do
		BORDER:CreateBorder(button, nil, nil, nil, nil, nil, false, true)
	end

	_G.MacroNewButton:ClearAllPoints()
	_G.MacroNewButton:Point('RIGHT', _G.MacroExitButton, 'LEFT', -5 , 0)

	-- Big icon
	BORDER:CreateBorder(_G.MacroFrameSelectedMacroButton)

	-- handle the macro buttons
	hooksecurefunc(MacroFrame.MacroSelector.ScrollBox, 'Update', function()
		for _, button in next, { MacroFrame.MacroSelector.ScrollBox.ScrollTarget:GetChildren() } do
			if button.Icon and not button.IsBorder then
				BORDER:CreateBorder(button, nil, nil, nil, nil, nil, false, true)
			end
		end
	end)

	-- New icon selection
	_G.MacroPopupFrame:HookScript('OnShow', function(frame)
		if not frame.IsBorder then -- set by HandleIconSelectionFrame
			BORDER:HandleIconSelectionFrame(frame, nil, nil, 'MacroPopup')
			frame.IsBorder = true
		end
	end)
end

S:AddCallbackForAddon('Blizzard_MacroUI')
