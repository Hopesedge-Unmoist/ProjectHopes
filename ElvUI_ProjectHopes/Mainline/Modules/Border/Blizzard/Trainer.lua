local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next, unpack = next, unpack
local hooksecurefunc = hooksecurefunc

function S:Blizzard_TrainerUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.trainer) then return end
	if not E.db.ProjectHopes.skins.trainer then return end

	for _, button in next, { _G.ClassTrainerTrainButton } do
		BORDER:CreateBorder(button, nil, nil, nil, nil, nil, false, true)
	end

	local ClassTrainerFrame = _G.ClassTrainerFrame
	BORDER:CreateBorder(ClassTrainerFrame)

	hooksecurefunc(ClassTrainerFrame.ScrollBox, 'Update', function(frame)
		for _, button in next, { frame.ScrollTarget:GetChildren() } do
			if not button.IsBorder then
				BORDER:HandleIcon(button.icon)
				button.backdrop:SetBackdrop(nil)

				hooksecurefunc(button.selectedTex, "Show", function()
					if button.icon.backdrop and button.icon.backdrop.border then
						button.icon.backdrop.border:SetBackdrop(Private.BorderLight)
						button.icon.backdrop.border:SetBackdropBorderColor(1, 0.78, 0.03)
					end
				end)
				
				hooksecurefunc(button.selectedTex, "Hide", function()
					if button.icon.backdrop and button.icon.backdrop.border then
						button.icon.backdrop.border:SetBackdrop(Private.Border)
						button.icon.backdrop.border:SetBackdropBorderColor(1, 1, 1)
					end
				end)

				local r, g, b = unpack(E.media.rgbvaluecolor)
				button.selectedTex:SetColorTexture(r, g, b, 0)

				button.IsBorder = true
			end
		end
	end)

	BORDER:CreateBorder(_G.ClassTrainerFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.ClassTrainerFrame.FilterDropdown, nil, nil, nil, nil, nil, false, true)

	local stepButton = _G.ClassTrainerFrameSkillStepButton
	stepButton:SetBackdrop(nil)
	BORDER:HandleIcon(stepButton.icon, true)

	hooksecurefunc(stepButton.selectedTex, "Show", function()
		if stepButton.icon.backdrop and stepButton.icon.backdrop.border then
			stepButton.icon.backdrop.border:SetBackdrop(Private.BorderLight)
			stepButton.icon.backdrop.border:SetBackdropBorderColor(1, 0.78, 0.03)
		end
	end)
	
	hooksecurefunc(stepButton.selectedTex, "Hide", function()
		if stepButton.icon.backdrop and stepButton.icon.backdrop.border then
			stepButton.icon.backdrop.border:SetBackdrop(Private.Border)
			stepButton.icon.backdrop.border:SetBackdropBorderColor(1, 1, 1)
		end
	end)
		
	_G.ClassTrainerFrameSkillStepButtonHighlight:SetColorTexture(1,1,1,0)
	stepButton.selectedTex:SetColorTexture(1,1,1,0)


	local ClassTrainerStatusBar = _G.ClassTrainerStatusBar
	BORDER:CreateBorder(ClassTrainerStatusBar)
end

S:AddCallbackForAddon('Blizzard_TrainerUI')
