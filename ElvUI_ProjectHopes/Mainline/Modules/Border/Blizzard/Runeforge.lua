local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc

function S:Blizzard_RuneforgeUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.runeforge) then return end
	if not E.db.ProjectHopes.skins.runeforge then return end

	local frame = _G.RuneforgeFrame
	BORDER:CreateBorder(frame)

	BORDER:CreateBorder(frame.CreateFrame.CraftItemButton, nil, nil, nil, nil, nil, false, true)

	local powerFrame = frame.CraftingFrame.PowerFrame
	local pageControl = powerFrame.PageControl            
	hooksecurefunc(powerFrame.PowerList, 'RefreshListDisplay', function(list)
		if not list.elements then return end

		for i = 1, list:GetNumElementFrames() do
			local button = list.elements[i]
			if button and not button.IsBorder then
				BORDER:HandleIcon(button.Icon)

				button.IsBorder = true
			end
		end
	end)
end

S:AddCallbackForAddon('Blizzard_RuneforgeUI')
