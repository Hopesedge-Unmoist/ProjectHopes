local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')
local S = E:GetModule('Skins')

local _G = _G
local pairs = pairs

function S:OpenAll()
	if not E.db.ProjectHopes.skins.openall then return end

	--skin and position Open All Cash button
	S:HandleButton(_G.OpenAllCashButton)
	BORDER:CreateBorder(_G.OpenAllCashButton, nil, nil, nil, nil, nil, false, true)
	_G.OpenAllCashButton:ClearAllPoints()
	_G.OpenAllCashButton:Point("CENTER", _G.InboxFrame, "BOTTOM", 20, 104)
	_G.OpenAllMail:ClearAllPoints()
	_G.OpenAllMail:Point("CENTER", _G.InboxFrame, "BOTTOM", -60, 104)
 end

S:AddCallbackForAddon("OpenAll")
