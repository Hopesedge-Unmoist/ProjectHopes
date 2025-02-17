local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local unpack = unpack

local MAX_TALENT_TABS = MAX_TALENT_TABS

function S:Blizzard_TalentUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.talent) then return end
	if not E.db.ProjectHopes.skins.talent then return end

	BORDER:CreateBorder(_G.PlayerTalentFrame.backdrop)

	for i = 1, 4 do
		BORDER:CreateBorder(_G['PlayerTalentFrameTab'..i], nil, nil, nil, nil, nil, true, true)
	end

	-- Reposition Tabs
	_G.PlayerTalentFrameTab1:ClearAllPoints()
	_G.PlayerTalentFrameTab1:Point('TOPLEFT', _G.PlayerTalentFrame, 'BOTTOMLEFT', 1, 74)
	_G.PlayerTalentFrameTab2:Point('TOPLEFT', _G.PlayerTalentFrameTab1, 'TOPRIGHT', -14, 0)
	_G.PlayerTalentFrameTab3:Point('TOPLEFT', _G.PlayerTalentFrameTab2, 'TOPRIGHT', -14, 0)

	if _G.PlayerTalentFrameActivateButton then
		BORDER:CreateBorder(_G.PlayerTalentFrameActivateButton, nil, nil, nil, nil, nil, false, true)
	end

	BORDER:CreateBorder(_G.PlayerTalentFrameScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)

	for i = 1, _G.MAX_NUM_TALENTS do
		local talent = _G['PlayerTalentFrameTalent'..i]

		if talent and not talent.backdrop then
			talent:CreateBackdrop()
			BORDER:CreateBorder(talent, 0, nil, nil, nil, nil, true, true)		
		end
	end

	-- Talent preview section / E:SetCVar('previewTalents', 1)
	BORDER:CreateBorder(_G.PlayerTalentFrameLearnButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.PlayerTalentFrameResetButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallbackForAddon('Blizzard_TalentUI')
