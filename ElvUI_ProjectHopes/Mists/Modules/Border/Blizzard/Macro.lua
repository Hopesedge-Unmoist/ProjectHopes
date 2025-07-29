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

	BORDER:CreateBorder(_G.MacroFrame.MacroSelector.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.MacroFrameScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.MacroFrameTextBackground)
	
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

	for i = 1, 2 do
		_G['MacroFrameTab'..i]:Height(22)
	end

	_G.MacroFrameTab1:Point('TOPLEFT', MacroFrame, 'TOPLEFT', 12, -39)
	_G.MacroFrameTab2:ClearAllPoints()

	_G.MacroFrameTab2:Point('LEFT', _G.MacroFrameTab1, 'RIGHT', 5, 0)

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
end

S:AddCallbackForAddon('Blizzard_MacroUI')
