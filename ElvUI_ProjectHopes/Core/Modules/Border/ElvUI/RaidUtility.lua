local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local pairs = pairs

local function RaidUtility_ShowButton_OnClick()
	if InCombatLockdown() then
		return
	end

	_G.RaidUtilityTargetIcons:ClearAllPoints()
	_G.RaidUtilityTargetIcons:SetPoint('TOP', _G.RaidUtilityPanel, 'BOTTOM', 0, -6)

	_G.RaidUtilityRoleIcons:ClearAllPoints()
	_G.RaidUtilityRoleIcons:SetPoint('TOPLEFT', _G.RaidUtilityTargetIcons, 'BOTTOMLEFT', 0, -6)

	_G.RaidUtility_CloseButton:ClearAllPoints()
	_G.RaidUtility_CloseButton:SetPoint('TOPRIGHT', _G.RaidUtilityTargetIcons, 'BOTTOMRIGHT', 0, -6)

	_G.RaidUtility_CloseButton:SetWidth(144)
end

function S:RaidUtility()
	if not E.db.ProjectHopes.skins.raidUtility then return end

	BORDER:CreateBorder(_G.RaidUtilityPanel)
	BORDER:CreateBorder(_G.RaidUtilityTargetIcons)
	BORDER:CreateBorder(_G.RaidUtilityRoleIcons)

	local buttons = {
		_G.RaidUtility_ShowButton,
		_G.RaidUtility_CloseButton,
		_G.RaidUtility_RaidControlButton,
		_G.RaidUtility_ReadyCheckButton,
		_G.RaidUtility_DisbandRaidButton,
		_G.RaidUtility_MainTankButton,
		_G.RaidUtility_MainAssistButton,
		_G.RaidUtility_RaidCountdownButton,
		_G.RaidUtility_RoleCheckButton,
	}

	for _, button in pairs(buttons) do
		BORDER:CreateBorder(button, nil, nil, nil, nil, nil, false, true)
	end

 if E.Retail then
		local dropdowns = {
		_G.RaidUtility_RestrictPings,
		_G.RaidUtility_DungeonDifficulty,
		_G.RaidUtility_ModeControl,
		}	

		for _, dropdown in pairs(dropdowns) do
			BORDER:CreateBorder(dropdown, nil, nil, nil, nil, nil, true, true)
		end
	end

	-- Checkbox
	BORDER:CreateBorder(_G.RaidUtility_EveryoneAssist, nil, nil, nil, nil, nil, true, true)

	if _G.RaidUtility_ShowButton then
		BORDER:SecureHookScript(_G.RaidUtility_ShowButton, "OnClick", RaidUtility_ShowButton_OnClick)
	end
end

S:AddCallback("RaidUtility")
