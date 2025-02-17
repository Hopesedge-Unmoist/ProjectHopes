local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next = next
local unpack = unpack
local hooksecurefunc = hooksecurefunc

function S:Blizzard_ArtifactUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.artifact) then return end
    if not E.db.ProjectHopes.skins.artifactFrame then return end

	local ArtifactFrame = _G.ArtifactFrame
	BORDER:CreateBorder(ArtifactFrame.BorderFrame)

	-- Skin Tabs. 
	for i = 1, 2 do
		BORDER:CreateBorder(_G['ArtifactFrameTab' .. i], nil, nil, nil, nil, nil, true, true)
	end

	-- Reposition Tabs.
	local ArtifactFrameTab1 = _G.ArtifactFrameTab1
	ArtifactFrameTab1:ClearAllPoints()
	ArtifactFrameTab1:Point('TOPLEFT', ArtifactFrame, 'BOTTOMLEFT', -3, -5)

	ArtifactFrame.AppearancesTab:HookScript('OnShow', function(frame)
		for _, child in next, { frame:GetChildren() } do
			if child.appearanceID and not child.border then
				BORDER:CreateBorder(child)
				child.backdrop:Hide()

				if child.Selected:IsShown() then
					child.border:SetBackdrop(Private.BorderLight)
					child.border:SetBackdropBorderColor(unpack(E.media.rgbvaluecolor))
				end

				hooksecurefunc(child.Selected, 'SetShown', function(_, isActive)
					if isActive then
						child.border:SetBackdrop(Private.BorderLight)
						child.border:SetBackdropBorderColor(unpack(E.media.rgbvaluecolor))
					else
						child.border:SetBackdrop(Private.Border)
						child.border:SetBackdropBorderColor(1,1,1)
					end
				end)
			end
		end
	end)
end

S:AddCallbackForAddon('Blizzard_ArtifactUI')
