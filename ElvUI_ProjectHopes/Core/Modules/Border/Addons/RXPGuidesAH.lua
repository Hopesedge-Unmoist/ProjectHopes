local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')
local S = E:GetModule('Skins')

local _G = _G
local pairs = pairs

function S:RXPGuides()
	if not E.db.ProjectHopes.skins.rxpguides then return end

	_G.RXP_IU_AH_SearchButton:StripTextures()
	_G.RXP_IU_AH_BuyButton:StripTextures()
	_G.RXP_IU_AH_CloseButton:StripTextures()

	S:HandleButton(_G.RXP_IU_AH_SearchButton, nil, nil, nil, true)
	S:HandleButton(_G.RXP_IU_AH_BuyButton, nil, nil, nil, true)
	S:HandleButton(_G.RXP_IU_AH_CloseButton, nil, nil, nil, true)
	BORDER:CreateBorder(_G.RXP_IU_AH_SearchButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.RXP_IU_AH_BuyButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.RXP_IU_AH_CloseButton, nil, nil, nil, nil, nil, false, true)

	_G.RXP_IU_AH_CloseButton:ClearAllPoints()
	_G.RXP_IU_AH_CloseButton:Point('BOTTOMRIGHT', _G.RXP_IU_AH, 'BOTTOMRIGHT', -30, 5)
	_G.RXP_IU_AH_BuyButton:ClearAllPoints()
	_G.RXP_IU_AH_BuyButton:Point('BOTTOMRIGHT', _G.RXP_IU_AH_CloseButton, 'BOTTOMLEFT', -10, 0)
	_G.RXP_IU_AH_SearchButton:ClearAllPoints()
	_G.RXP_IU_AH_SearchButton:Point('BOTTOMRIGHT', _G.RXP_IU_AH_BuyButton, 'BOTTOMLEFT', -10, 0)

	S:HandleScrollBar(_G.RXP_IU_AH_FrameScrollFrameScrollBar)
	BORDER:CreateBorder(_G.RXP_IU_AH_FrameScrollFrameScrollBar.Track)

	--I dont know how to make this work, I need to somehow wait until it loads(RXPGuides create those)
	--_G.RXP_IU_AH_ItemKindHeader:StripTextures()
	--_G.RXP_IU_AH_ItemRow:StripTextures()
end

S:AddCallbackForAddon("RXPGuides")
