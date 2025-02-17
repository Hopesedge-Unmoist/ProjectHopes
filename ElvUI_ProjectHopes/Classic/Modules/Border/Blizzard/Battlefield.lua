local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

function S:SkinBattlefield()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.battlefield) then return end
	if not E.db.ProjectHopes.skins.battlefield then return end

	local BattlefieldFrame = _G.BattlefieldFrame
	BORDER:CreateBorder(BattlefieldFrame.backdrop)

	S:HandleScrollBar(_G.BattlefieldListScrollFrameScrollBar)
	BORDER:CreateBorder(BattlefieldListScrollFrameScrollBar, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(_G.BattlefieldFrameCancelButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.BattlefieldFrameJoinButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.BattlefieldFrameGroupJoinButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallback('SkinBattlefield')
