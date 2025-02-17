local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next = next
local hooksecurefunc = hooksecurefunc

function S:TabardFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.tabard) then return end
	if not E.db.ProjectHopes.skins.tabard then return end

	local TabardFrame = _G.TabardFrame
	BORDER:CreateBorder(TabardFrame)

	local TabardModel = _G.TabardModel
	BORDER:CreateBorder(TabardModel)

	BORDER:CreateBorder(_G.TabardFrameCancelButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.TabardFrameAcceptButton, nil, nil, nil, nil, nil, false, true)

	_G.TabardFrameAcceptButton:ClearAllPoints()
	_G.TabardFrameAcceptButton:SetPoint("RIGHT", _G.TabardFrameCancelButton, "LEFT", -5, 0)

	BORDER:CreateBorder(_G.TabardCharacterModelRotateLeftButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.TabardCharacterModelRotateRightButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallback('TabardFrame')
