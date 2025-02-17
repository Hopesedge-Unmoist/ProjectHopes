local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local _G = _G
local select = select
local hooksecurefunc = hooksecurefunc

function S:Blizzard_GMChatUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.gmChat) then return end
	if not E.db.ProjectHopes.skins.gmChat then return end

	local GMChatFrame = _G.GMChatFrame
	BORDER:CreateBorder(GMChatFrame.backdrop)

	local GMChatFrameEditBox = _G.GMChatFrameEditBox
	BORDER:CreateBorder(GMChatFrameEditBox)

	local GMChatFrameEditBoxLanguage = _G.GMChatFrameEditBoxLanguage
	BORDER:CreateBorder(GMChatFrameEditBoxLanguage)

	local GMChatTab = _G.GMChatTab
	BORDER:CreateBorder(GMChatTab)
end

function S:Blizzard_GMSurveyUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.gmChat) then return end

	BORDER:CreateBorder(_G.GMSurveyFrame.backdrop)
	BORDER:CreateBorder(_G.GMSurveyScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.GMSurveyCancelButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.GMSurveySubmitButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallbackForAddon('Blizzard_GMChatUI')
S:AddCallbackForAddon('Blizzard_GMSurveyUI')
