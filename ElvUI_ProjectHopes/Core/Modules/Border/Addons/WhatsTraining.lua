local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')
local S = E:GetModule('Skins')

local _G = _G
local pairs = pairs

function S:WhatsTraining()
	if not E.db.ProjectHopes.skins.whatstraining then return end

	E:Delay(1, function()
		--main frame
		S:HandleFrame(_G.WhatsTrainingFrame, true, true, 11, -50, -32, 76)
		BORDER:CreateBorder(_G.WhatsTrainingFrame, nil, 3, -42, -24, 68)

		--position main frame
		_G.WhatsTrainingFrame:Point('TOPLEFT', _G.SpellBookFrame, 'TOPLEFT', 0, 38)

		--scroll bar
		S:HandleScrollBar(_G.WhatsTrainingFrameScrollBarScrollBar)
		BORDER:CreateBorder(_G.WhatsTrainingFrameScrollBarScrollBarThumbTexture)

		--position search box
		_G.WhatsTrainingFrameSearchBox:ClearAllPoints()
		WhatsTrainingFrameSearchBox:Point('TOPLEFT', _G.SpellBookFrame, 'TOPLEFT', 20, -10)

		--raise strata of close button
		SpellBookCloseButton:SetFrameStrata('HIGH')
	end)
end

S:AddCallbackForAddon("WhatsTraining")
