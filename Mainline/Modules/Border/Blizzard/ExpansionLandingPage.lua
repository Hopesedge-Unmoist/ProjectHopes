local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next = next
local hooksecurefunc = hooksecurefunc

local function HandlePanel(panel)
	if panel.DragonridingPanel then
		S:HandleButton(panel.DragonridingPanel.SkillsButton)
		BORDER:CreateBorder(panel.DragonridingPanel.SkillsButton, nil, nil, nil, nil, nil, false, true)
		panel.DragonridingPanel.SkillsButton.YellowGlow:Hide()
	end

	if panel.CloseButton then
		S:HandleCloseButton(panel.CloseButton)
	end
end

local function HandleScrollBar(frame)
	if frame.MajorFactionList then
		S:HandleTrimScrollBar(frame.MajorFactionList.ScrollBar)
		BORDER:CreateBorder(frame.MajorFactionList.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	end
end

local function DelayedMajorFactionList(frame)
	E:Delay(0.1, HandleScrollBar, frame)
end

function S:Blizzard_ExpansionLandingPage()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.expansionLanding) then return end
    if not E.db.ProjectHopes.skins.expansionLandingPage then return end

	local factionList = _G.LandingPageMajorFactionList
	if factionList then
		hooksecurefunc(factionList, 'Create', DelayedMajorFactionList)
	end

	local overlay = _G.ExpansionLandingPage.Overlay
	if overlay then
		overlay:HookScript('OnShow', function(frame)
			local clean = E.private.skins.parchmentRemoverEnable
			for _, child in next, { frame:GetChildren() } do
				if clean then
					BORDER:CreateBorder(child)
				end
	
				if child.DragonridingPanel then
					HandlePanel(child)
				end
			end

			local factionList = _G.LandingPageMajorFactionList
			if factionList then	
				hooksecurefunc(factionList, 'Create', DelayedMajorFactionList)
			end
	
			local landingOverlay = overlay.WarWithinLandingOverlay
			if landingOverlay then
				S:HandleCloseButton(landingOverlay.CloseButton)
			end
		end)
	end
end

S:AddCallbackForAddon('Blizzard_ExpansionLandingPage')
