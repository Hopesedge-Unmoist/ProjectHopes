local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local pairs = pairs
local hooksecurefunc = hooksecurefunc

function S:TabardFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.tabard) then return end
	if not E.db.ProjectHopes.skins.tabard then return end

	local TabardFrame = _G.TabardFrame
	BORDER:CreateBorder(TabardFrame.backdrop)

	BORDER:CreateBorder(_G.TabardFrameCancelButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.TabardFrameAcceptButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallback('TabardFrame')
