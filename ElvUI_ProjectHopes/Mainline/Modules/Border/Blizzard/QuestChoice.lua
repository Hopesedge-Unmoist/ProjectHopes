local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

function S:Blizzard_QuestChoice()
	if not E.private.skins.blizzard.questChoice then return end
	if not E.db.ProjectHopes.skins.questChoice then return end

	local QuestChoiceFrame = _G.QuestChoiceFrame
	for i = 1, 4 do
		local option = QuestChoiceFrame['Option'..i]
		local rewards = option.Rewards
		local item = rewards.Item
		local icon = item.Icon
		local currencies = rewards.Currencies

		BORDER:HandleIcon(icon)

		for j = 1, 3 do
			local cu = currencies['Currency'..j]
			BORDER:HandleIcon(cu.Icon)
		end
	end

	BORDER:CreateBorder(_G.QuestChoiceFrameOption1.OptionButtonsContainer.OptionButton1, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.QuestChoiceFrameOption2.OptionButtonsContainer.OptionButton1, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.QuestChoiceFrameOption3.OptionButtonsContainer.OptionButton1, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.QuestChoiceFrameOption4.OptionButtonsContainer.OptionButton1, nil, nil, nil, nil, nil, false, true)
end

S:AddCallbackForAddon('Blizzard_QuestChoice')
