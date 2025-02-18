local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

if not E.ClassicSOD then return end

local _G = _G
local hooksecurefunc = hooksecurefunc
local C_Engraving_GetRuneCategories = C_Engraving.GetRuneCategories

local function UpdateRuneList()
	local categories = C_Engraving_GetRuneCategories(true, true)
	for i = 1, (categories and #categories or 0) do
		local header = _G['EngravingFrameHeader'..i]
		if header and header.template then
			BORDER:CreateBorder(header, nil, -7, 7, 7, -7, false, true)
		end
	end

	local frame = _G.EngravingFrame
	local buttons = frame and frame.scrollFrame and frame.scrollFrame.buttons
	for i = 1, (buttons and #buttons or 0) do
		local button = _G['EngravingFrameScrollFrameButton'..i]
		local icon = _G['EngravingFrameScrollFrameButton'..i..'Icon']
		S:HandleIcon(icon, true)

		if button and not button.IsBorder then

			button:SetBackdrop()
			BORDER:CreateBorder(icon.backdrop, nil, -7, 7, 7, -7, false, true)
			button.IsBorder = true
		end
	end
end

function S:SkinEngravings()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.engraving) then return end
	if not E.db.ProjectHopes.skins.engraving then return end

	BORDER:CreateBorder(_G.EngravingFrame.backdrop)
	BORDER:CreateBorder(_G.EngravingFrameSearchBox, nil, nil, nil, nil, nil, false, false)
	BORDER:CreateBorder(_G.EngravingFrame.FilterDropdown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.EngravingFrameScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)

	hooksecurefunc('EngravingFrame_UpdateRuneList', UpdateRuneList)
end

S:AddCallbackForAddon('Blizzard_EngravingUI', 'SkinEngravings')
