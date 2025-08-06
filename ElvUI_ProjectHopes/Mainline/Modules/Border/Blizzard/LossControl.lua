local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local CreateFrame = CreateFrame
local hooksecurefunc = hooksecurefunc

function S:LossOfControlFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.losscontrol) then return end
	if not E.db.ProjectHopes.skins.lossOfControl then return end


    local LossOfControlFrame = _G.LossOfControlFrame
    BORDER:CreateBorder(LossOfControlFrame.Icon)
end

S:AddCallback('LossOfControlFrame')
