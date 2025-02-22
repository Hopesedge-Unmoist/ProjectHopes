local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')
local S = E:GetModule('Skins')

local _G = _G
local pairs = pairs

function S:Leatrix_Plus()
	if not E.db.ProjectHopes.skins.leatrix_plus then return end

	E:Delay(1, function()
		--style quest log enhancer
		if _G.LeaPlusDB["EnhanceQuestLog"] == "On" and _G.LeaPlusDB["EnhanceQuestTaller"] == "On" then
			--position and add border to share button
			_G.QuestFramePushQuestButton:ClearAllPoints()
			_G.QuestFramePushQuestButton:SetPoint("LEFT", _G.QuestLogFrameAbandonButton, "RIGHT", 7, 0)

			--position and add border to map button
			_G.LeaPlusGlobalQuestLogMapButton:ClearAllPoints()
			_G.LeaPlusGlobalQuestLogMapButton:SetPoint("LEFT", _G.QuestFramePushQuestButton, "RIGHT", 7, 0)
			BORDER:CreateBorder(_G.LeaPlusGlobalQuestLogMapButton, nil, nil, nil, nil, nil, false, true)
		end

		--style flight map enhancer
		if _G.LeaPlusDB["EnhanceFlightMap"] == "On" then
			BORDER:CreateBorder(_G.TaxiMap, nil, 15, -62, -36, 80)
		end
		
		--style Cloak and Helm checkboxes
		if _G.LeaPlusDB["ShowVanityControls"] == "On" then
			for _, checkbox in pairs({ PaperDollFrame:GetChildren() }) do
				if checkbox:IsObjectType('CheckButton') and not checkbox.isSkinned then
					S:HandleCheckBox(checkbox)
					BORDER:CreateBorder(checkbox, nil, nil, nil, nil, nil, true, true)
				end
			end
		end
    end)
end

function S:Blizzard_TrainerUI()
	if not E.db.ProjectHopes.skins.leatrix_plus then return end

	--style trainner enhancer
	if _G.LeaPlusDB["EnhanceTrainers"] == "On" and _G.LeaPlusDB["ShowTrainAllBtn"] == "On" then
		-- Position and add border to train all button
		_G.LeaPlusGlobalTrainAllButton:ClearAllPoints()
		_G.LeaPlusGlobalTrainAllButton:SetPoint("RIGHT", _G.ClassTrainerTrainButton, "LEFT", -7, 0)
		BORDER:CreateBorder(_G.LeaPlusGlobalTrainAllButton, nil, nil, nil, nil, nil, false, true)
	end
end

S:AddCallbackForAddon('Blizzard_TrainerUI')
S:AddCallbackForAddon("Leatrix_Plus")
