local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc
local pairs = pairs
local type = type
local unpack = unpack

function S:WeakAurasOptions()
	if not E.db.ProjectHopes.skins.weakAurasOptions then return end

	E:Delay(0, function()
		if _G.WeakAurasOptions then
			S:HandleFrame(_G.WeakAurasOptions)
			S:HandleEditBox(_G.WeakAurasFilterInput)
			S:HandleMaxMinFrame(_G.WeakAurasOptions.MaxMinButtonFrame)
			S:HandleCloseButton(_G.WeakAurasOptionsCloseButton)

			if _G.WeakAurasOptions.border then
				_G.WeakAurasOptions.border = nil
				BORDER:CreateBorder(_G.WeakAurasOptions)
				BORDER:CreateBorder(_G.WeakAurasFilterInput, nil, nil, nil, nil, nil, true)
			else
				BORDER:CreateBorder(_G.WeakAurasOptions)
				BORDER:CreateBorder(_G.WeakAurasFilterInput, nil, nil, nil, nil, nil, true)
			end
		end
	end)
end

S:AddCallbackForAddon("WeakAurasOptions")
