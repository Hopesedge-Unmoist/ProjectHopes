local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

function S:DressUpFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.dressingroom) then return end
	if not E.db.ProjectHopes.skins.dressingRoom then return end

	local DressUpFrame = _G.DressUpFrame
	BORDER:CreateBorder(DressUpFrame.backdrop)

	DressUpFrame.BGBottomLeft:Hide()
	DressUpFrame.BGBottomRight:Hide()
	DressUpFrame.BGTopLeft:Hide()
	DressUpFrame.BGTopRight:Hide()

	BORDER:CreateBorder(_G.DressUpFrameCancelButton, nil, nil, nil, nil, nil, false, true)
	_G.DressUpFrameCancelButton:Point('BOTTOMRIGHT', -35, 80)
	BORDER:CreateBorder(_G.DressUpFrameResetButton, nil, nil, nil, nil, nil, false, true)
	_G.DressUpFrameResetButton:Point('RIGHT', _G.DressUpFrameCancelButton, 'LEFT', -3, 0)

	_G.DressUpModelFrame.backdrop:Hide()
end

S:AddCallback('DressUpFrame')
