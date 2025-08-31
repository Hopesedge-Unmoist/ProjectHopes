local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local CreateFrame = CreateFrame
local hooksecurefunc = hooksecurefunc

local function MoveText(f)

    if f.AbilityName then
		f.AbilityName:ClearAllPoints()
		f.AbilityName:Point('BOTTOM', f, 0, 0)
	end

	if f.TimeLeft then
		f.TimeLeft.NumberText:ClearAllPoints()
		f.TimeLeft.NumberText:Point('TOP', f.AbilityName, 'BOTTOM', 4, 0)

		f.TimeLeft.SecondsText:ClearAllPoints()
		f.TimeLeft.SecondsText:Point('TOP', f.TimeLeft.NumberText, 'BOTTOM', 0, 0)
	end
end


function S:LossOfControlFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.losscontrol) then return end
	if not E.db.ProjectHopes.skins.lossOfControl then return end

    local LossOfControlFrame = _G.LossOfControlFrame
    LossOfControlFrame:CreateBackdrop()
    LossOfControlFrame.backdrop:SetOutside(LossOfControlFrame.Icon)
    BORDER:CreateBorder(LossOfControlFrame.backdrop)

    hooksecurefunc(LossOfControlFrame, 'SetUpDisplay', MoveText)


    -- Debug test

    --Run this first: /run LossOfControlFrame.fadeTime = 2000; LossOfControlFrame:SetUpDisplay(true, 'CONFUSE', 2094, 'Disoriented', 136208, GetTime() + 8, 8, 0, 5, 2)
    --Run this second: /run LossOfControlFrame:Show(); LossOfControlFrame.Icon:SetTexture(136208); LossOfControlFrame.AbilityName:SetText("Disoriented")
end

S:AddCallback('LossOfControlFrame')
