local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc

function S:Blizzard_MajorFactions()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.majorFactions) then return end
	if not E.db.ProjectHopes.skins.majorFactions then return end

	local MajorFactionRenownFrame = _G.MajorFactionRenownFrame
	BORDER:CreateBorder(MajorFactionRenownFrame)

	if MajorFactionRenownFrame.LevelSkipButton then
		BORDER:CreateBorder(MajorFactionRenownFrame.LevelSkipButton, nil, nil, nil, nil, nil, false, true)
	end
end

S:AddCallbackForAddon('Blizzard_MajorFactions')
