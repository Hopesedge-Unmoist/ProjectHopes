local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next = next
local hooksecurefunc = hooksecurefunc
local C_AzeriteEssence_CanOpenUI = C_AzeriteEssence.CanOpenUI

function S:Blizzard_AzeriteEssenceUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.azeriteEssence) then return end
	if not E.db.ProjectHopes.skins.azeriteEssence then return end

	if not C_AzeriteEssence_CanOpenUI() then return end
	

	local AzeriteEssenceUI = _G.AzeriteEssenceUI
	self:CreateBorder(AzeriteEssenceUI)

	self:CreateBorder(AzeriteEssenceUI.EssenceList.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	-- Essence List on the right
	hooksecurefunc(AzeriteEssenceUI.EssenceList.ScrollBox, 'Update', function(box)
		if not box.ScrollTarget then return end

		for _, button in next, { box.ScrollTarget:GetChildren() } do
			if not button.IsBorder then
				local icon = button.Icon
				if icon and not icon.backdrop.border then
					self:HandleIcon(icon)
				end
				
				if button.backdrop then
					self:CreateBorder(button.backdrop)
				end

				button.IsBorder = true
			end
		end
	end)
end

S:AddCallbackForAddon('Blizzard_AzeriteEssenceUI')
