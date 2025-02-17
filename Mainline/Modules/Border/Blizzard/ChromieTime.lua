local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

function S:Blizzard_ChromieTimeUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.chromieTime) then return end
    if not E.db.ProjectHopes.skins.chromieTime then return end

	local ChromieTimeFrame = _G.ChromieTimeFrame
	BORDER:CreateBorder(ChromieTimeFrame)
	BORDER:CreateBorder(ChromieTimeFrame.SelectButton, nil, nil, nil, nil, nil, false, true)

	local Title = ChromieTimeFrame.Title
	BORDER:CreateBorder(Title)

	local InfoFrame = ChromieTimeFrame.CurrentlySelectedExpansionInfoFrame
	BORDER:CreateBorder(InfoFrame)
end

S:AddCallbackForAddon('Blizzard_ChromieTimeUI')
