local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

function S:Blizzard_NewPlayerExperience()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.guide) then return end
	if not E.db.ProjectHopes.skins.guide then return end

	BORDER:CreateBorder(_G.KeyboardMouseConfirmButton, nil, nil, nil, nil, nil, false, true)
end

function S:Blizzard_NewPlayerExperienceGuide()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.guide) then return end
	if not E.db.ProjectHopes.skins.guide then return end

	local GuideFrame = _G.GuideFrame
	BORDER:CreateBorder(GuideFrame)

	local scrollFrame = GuideFrame.ScrollFrame
	BORDER:CreateBorder(scrollFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(scrollFrame.ConfirmationButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallbackForAddon('Blizzard_NewPlayerExperience')
S:AddCallbackForAddon('Blizzard_NewPlayerExperienceGuide')
