local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

function S:Blizzard_ArchaeologyUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.archaeology) then return end
    if not E.db.ProjectHopes.skins.archaeologyFrame then return end

	local ArchaeologyFrame = _G.ArchaeologyFrame

	BORDER:CreateBorder(ArchaeologyFrame)
	BORDER:CreateBorder(ArchaeologyFrame.artifactPage.solveFrame.solveButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(ArchaeologyFrame.artifactPage.backButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(_G.ArchaeologyFrameRaceFilter, nil, nil, nil, nil, nil, true, true)

	for i = 1, _G.ARCHAEOLOGY_MAX_RACES do
		local frame = ArchaeologyFrame.summaryPage['race'..i]
		local artifact = ArchaeologyFrame.completedPage['artifact'..i]

		BORDER:HandleIcon(artifact.icon)
	end

	BORDER:CreateBorder(ArchaeologyFrame.rankBar)
	BORDER:CreateBorder(ArchaeologyFrame.artifactPage.solveFrame.statusBar)
	S:HandleIcon(_G.ArchaeologyFrameArtifactPageIcon, true)
	BORDER:HandleIcon(_G.ArchaeologyFrameArtifactPageIcon)
	BORDER:CreateBorder(_G.ArcheologyDigsiteProgressBar.FillBar)
end

S:AddCallbackForAddon('Blizzard_ArchaeologyUI')
