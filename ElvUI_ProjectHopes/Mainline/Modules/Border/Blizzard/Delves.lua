local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc

local function HandleButton(button)
	if button.IsBorder then return end

	if button.Icon then
		BORDER:HandleIcon(button.Icon, true)
	end

	button.IsBorder = true
end

local function UpdateButton(self)
	self:ForEachFrame(HandleButton)
end

local function HandleOptionSlot(frame, skip) 
	local option = frame.OptionsList
	BORDER:CreateBorder(option)
	option:SetFrameLevel(3)
	
	if not skip then
		hooksecurefunc(option.ScrollBox, 'Update', UpdateButton)
	end
end

local function SetRewards(rewardFrame)
	if rewardFrame.backdrop then
		rewardFrame.backdrop:Kill()
		
		BORDER:HandleIcon(rewardFrame.Icon, true)
		rewardFrame.Icon.backdrop.border:SetBackdrop(Private.BorderLight)
		S:HandleIconBorder(rewardFrame.IconBorder, rewardFrame.Icon.backdrop.border)
	end
end

local function DifficultyPickerFrame_Update(frame)
	frame:ForEachFrame(SetRewards)
end

function S:Blizzard_DelvesCompanionConfiguration()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.lfg) then return end
	if not E.db.ProjectHopes.skins.lookingForGroup then return end

	local CompanionConfigurationFrame = _G.DelvesCompanionConfigurationFrame
	
	BORDER:CreateBorder(CompanionConfigurationFrame)
	CompanionConfigurationFrame.CompanionPortraitFrame:SetFrameLevel(CompanionConfigurationFrame.border:GetFrameLevel() + 1)
	BORDER:CreateBorder(CompanionConfigurationFrame.CompanionConfigShowAbilitiesButton, 1, nil, nil, nil, nil, false, true)

	HandleOptionSlot(CompanionConfigurationFrame.CompanionCombatRoleSlot, true)
	HandleOptionSlot(CompanionConfigurationFrame.CompanionUtilityTrinketSlot)
	HandleOptionSlot(CompanionConfigurationFrame.CompanionCombatTrinketSlot)
	
	local CompanionAbilityListFrame = _G.DelvesCompanionAbilityListFrame

	if CompanionAbilityListFrame then
		BORDER:CreateBorder(CompanionAbilityListFrame)

		CompanionAbilityListFrame:HookScript("OnShow", function()
			BORDER:CreateBorder(CompanionAbilityListFrame.DelvesCompanionRoleDropdown, nil, nil, nil, nil, nil, true, true)

			if CompanionAbilityListFrame.ButtonsParent then
				for _, frame in next, { CompanionAbilityListFrame.ButtonsParent:GetChildren() } do
					local Icon = frame.Icon
					if Icon then
						BORDER:HandleIcon(Icon, true)
					end
				end
			end
		end)
	end
end

S:AddCallbackForAddon('Blizzard_DelvesCompanionConfiguration')

function S:Blizzard_DelvesDifficultyPicker()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.lfg) then return end
	if not E.db.ProjectHopes.skins.lookingForGroup then return end

	local DifficultyPickerFrame = _G.DelvesDifficultyPickerFrame

	BORDER:CreateBorder(DifficultyPickerFrame)

	BORDER:CreateBorder(DifficultyPickerFrame.Dropdown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(DifficultyPickerFrame.EnterDelveButton, nil, nil, nil, nil, nil, false, true)

	hooksecurefunc(DifficultyPickerFrame.DelveRewardsContainerFrame.ScrollBox, 'Update', DifficultyPickerFrame_Update)
end

S:AddCallbackForAddon('Blizzard_DelvesDifficultyPicker')

function S:Blizzard_DelvesDashboardUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.lfg) then return end
	if not E.db.ProjectHopes.skins.lookingForGroup then return end

	local Dashboard = _G.DelvesDashboardFrame
	
	BORDER:CreateBorder(Dashboard)
	Dashboard.ButtonPanelLayoutFrame.CompanionConfigButtonPanel.CompanionModelScene:SetFrameLevel(6)
	BORDER:CreateBorder(Dashboard.ButtonPanelLayoutFrame.CompanionConfigButtonPanel.CompanionConfigButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallbackForAddon('Blizzard_DelvesDashboardUI')
