local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local TT = E:GetModule('Tooltip')

local _G = _G
local next, pairs = next, pairs

local function HandleRoleButton(button)
	local checkbox = button.checkButton
	BORDER:CreateBorder(checkbox, nil, nil, nil, nil, nil, true, true)
end

local function HandleHonorDropdown(dropdown)
	BORDER:CreateBorder(dropdown, nil, nil, nil, nil, nil, true, true)
end

function S:Blizzard_PVPUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.pvp) then return end
	if not E.db.ProjectHopes.skins.pvp then return end

	for i = 1, 4 do
		local bu = _G['PVPQueueFrameCategoryButton'..i]
		if bu then
			BORDER:CreateBorder(bu, nil, nil, nil, nil, nil, false, true)
			BORDER:HandleIcon(bu.Icon, true)
		end
	end

	local PVPQueueFrame = _G.PVPQueueFrame

	-- Casual Tab
	local HonorFrame = _G.HonorQueueFrame
	HonorFrame:StripTextures()

	_G.HonorQueueFrame.RoleInset.NineSlice:StripTextures()
	S:HandleScrollBar(_G.HonorQueueFrameSpecificFrameScrollBar)

	local BonusFrame = HonorFrame.BonusFrame
	BonusFrame:StripTextures()

	-- TODO: This is a fake dropdown
	HandleHonorDropdown(_G.HonorQueueFrameTypeDropDown)

	for _, bonusButton in pairs({'RandomBGButton', 'CallToArmsButton', 'WorldPVP1Button', 'WorldPVP2Button'}) do
		local bu = BonusFrame[bonusButton]
		local reward = bu.Reward

		if bu then
			BORDER:CreateBorder(bu, nil, -7, 7, 7, -7, false, true)
			bu:SetBackdropColor(1,1,1,0)
		end

		if reward then
			BORDER:HandleIcon(reward.Icon, true)
		end
	end

	BORDER:CreateBorder(_G.HonorQueueFrameSoloQueueButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.HonorQueueFrameGroupQueueButton, nil, nil, nil, nil, nil, false, true)

	HandleRoleButton(HonorFrame.RoleInset.TankIcon)
	HandleRoleButton(HonorFrame.RoleInset.HealerIcon)
	HandleRoleButton(HonorFrame.RoleInset.DPSIcon)

	-- Rated Tab
	local ConquestFrame = _G.ConquestQueueFrame
	BORDER:CreateBorder(_G.ConquestJoinButton, nil, nil, nil, nil, nil, false, true)

	for _, bu in pairs({ConquestFrame.Arena2v2, ConquestFrame.Arena3v3, ConquestFrame.Arena5v5, ConquestFrame.RatedBG}) do
		local reward = bu.Reward
		BORDER:CreateBorder(bu, nil, -7, 7, 7, -7, false, true)
		bu:SetBackdropColor(1,1,1,0)
		if reward then
			BORDER:HandleIcon(reward.Icon, true)
		end
	end

	-- War Games Tab
	local WarGamesQueueFrame = _G.WarGamesQueueFrame
	for _, child in next, { WarGamesQueueFrame:GetChildren() } do
		if child:GetName() == 'WarGameStartButton' then
			BORDER:CreateBorder(child, nil, nil, nil, nil, nil, false, true)

			break -- no need to continue
		end
	end
end

function S:PVPReadyDialog()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.pvp) then return end
	if not E.db.ProjectHopes.skins.pvp then return end

	BORDER:CreateBorder(_G.PVPReadyDialogEnterBattleButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.PVPReadyDialogHideButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallback('PVPReadyDialog')
S:AddCallbackForAddon('Blizzard_PVPUI')