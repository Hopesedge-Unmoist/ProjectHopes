local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')
local S = E:GetModule('Skins')

local _G = _G
local pairs = pairs

function S:NovaSpellRankChecker()
	if not E.db.ProjectHopes.skins.novaspellrankchecker then return end

	--style Nova Spell Rank Checker button
	S:HandleButton(_G.SpellBookFrameButton)
	BORDER:CreateBorder(_G.SpellBookFrameButton, nil, nil, nil, nil, nil, false, true)
	_G.SpellBookFrameButton:SetFrameStrata('HIGH')
	_G.SpellBookFrameButton:Width(140)
	_G.SpellBookFrameButton:Height(32)

	--handle Nova Spell Rank Checker position
	_G.SpellBookFrameButton:ClearAllPoints()
	_G.SpellBookFrameButton:Point('BOTTOMLEFT', _G.SpellBookFrame, 'BOTTOMLEFT', 25, 100)
end

function S:NovaWorldBuffs()
	if not E.db.ProjectHopes.skins.novaworldbuffs then return end

	E:Delay(1, function()
		--style minimap layer frame
		_G.MinimapLayerFrame:Width(100)
		_G.MinimapLayerFrame:Height(18)
		S:HandleFrame(_G.MinimapLayerFrame)
		BORDER:CreateBorder(_G.MinimapLayerFrame, nil, nil, nil, nil, nil, false, true)

		--handle minimap layer position
		if E.db.ProjectHopes.skins.novaworldbuffsposition then
			if E.db.ProjectHopes.minimap.Rectangle then
				_G.MinimapLayerFrame:ClearAllPoints()
				_G.MinimapLayerFrame:Point('TOPRIGHT', _G.Minimap, 1, -16)
				_G.MinimapLayerFrame:SetMovable(false)
			else
				_G.MinimapLayerFrame:ClearAllPoints()
				_G.MinimapLayerFrame:Point('TOPRIGHT', _G.Minimap, 1, 27)
				_G.MinimapLayerFrame:SetMovable(false)
			end
		end
	end)
end

S:AddCallbackForAddon('NovaSpellRankChecker')
S:AddCallbackForAddon("NovaWorldBuffs")
