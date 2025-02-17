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

    --/run LossOfControlFrame.fadeTime = 2000; LossOfControlFrame_SetUpDisplay(LossOfControlFrame, true, 'CONFUSE', 2094, 'Disoriented', [[Interface\Icons\Spell_Shadow_MindSteal]], 72101.9765625, 7.9950003623962, 8, 0, 5, 2)
    hooksecurefunc('LossOfControlFrame_SetUpDisplay', function(s)
        if not s.Icon.backdrop then
            s.Icon:CreateBackdrop()
        end
        BORDER:CreateBorder(s.Icon.backdrop)

        s.AbilityName:ClearAllPoints()
        s.AbilityName:Point("TOPLEFT", s.Icon, "TOPRIGHT", 10, 0)
    
        s.TimeLeft:ClearAllPoints()
        s.TimeLeft.NumberText:ClearAllPoints()
        s.TimeLeft.NumberText:Point("BOTTOMLEFT", s.Icon, "BOTTOMRIGHT", 10, 0)
    
        s.TimeLeft.SecondsText:ClearAllPoints()
        s.TimeLeft.SecondsText:Point("TOPLEFT", s.TimeLeft.NumberText, "TOPRIGHT", 3, 0)
    
        s:Size(s.Icon:GetWidth() + 10 + s.AbilityName:GetWidth(), s.Icon:GetHeight())
    end)
end

S:AddCallback('LossOfControlFrame')
