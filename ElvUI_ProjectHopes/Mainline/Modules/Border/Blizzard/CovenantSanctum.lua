local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local gsub, ipairs = gsub, ipairs
local hooksecurefunc = hooksecurefunc

local function ReskinTalents(self)
	for frame in self.talentPool:EnumerateActive() do
		if not frame.IsBorder then
			BORDER:HandleIcon(frame.Icon)

			frame.IsBorder = true
		end
	end
end

function S:Blizzard_CovenantSanctum()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.covenantSanctum) then return end
    if not E.db.ProjectHopes.skins.covenantSanctum then return end

	local CovenantSanctumFrame = _G.CovenantSanctumFrame

	BORDER:CreateBorder(CovenantSanctumFrame)

	local UpgradesTab = CovenantSanctumFrame.UpgradesTab
	BORDER:CreateBorder(UpgradesTab.DepositButton, nil, nil, nil, nil, nil, false, true)

	local TalentList = CovenantSanctumFrame.UpgradesTab.TalentsList
	BORDER:CreateBorder(TalentList.UpgradeButton, nil, nil, nil, nil, nil, false, true)
	hooksecurefunc(TalentList, 'Refresh', ReskinTalents)
end

S:AddCallbackForAddon('Blizzard_CovenantSanctum')
