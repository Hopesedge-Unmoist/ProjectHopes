local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local unpack = unpack
local hooksecurefunc = hooksecurefunc

function S:AddonList()
	if not E.db.ProjectHopes.skins.addonList then return end

	local AddonList = _G.AddonList
	if AddonList then 
		BORDER:CreateBorder(AddonList)
		BORDER:CreateBorder(_G.AddonCharacterDropDown, nil, nil, nil, nil, nil, true, true)
		BORDER:CreateBorder(_G.AddonListForceLoad, nil, nil, nil, nil, nil, true, true)
		BORDER:CreateBorder(AddonList.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
		BORDER:CreateBorder(AddonList.EnableAllButton, nil, nil, nil, nil, nil, true, true)
		BORDER:CreateBorder(AddonList.DisableAllButton, nil, nil, nil, nil, nil, true, true)
		BORDER:CreateBorder(AddonList.OkayButton, nil, nil, nil, nil, nil, true, true)
		BORDER:CreateBorder(AddonList.CancelButton, nil, nil, nil, nil, nil, true, true)
	
		AddonList.DisableAllButton:ClearAllPoints()
		AddonList.DisableAllButton:Point('LEFT', AddonList.EnableAllButton, 'RIGHT', 5, 0)
	
		AddonList.OkayButton:ClearAllPoints()
		AddonList.OkayButton:Point('RIGHT', AddonList.CancelButton, 'LEFT', -5, 0)
	
		hooksecurefunc(AddonList.ScrollBox, 'Update', function(frame)
			for _, child in next, { frame.ScrollTarget:GetChildren() } do
				local button = child.Enabled
				if button then
					BORDER:CreateBorder(button, nil, nil, nil, nil, nil, true, true)
				end
			end
		end)
	end
end

S:AddCallback('AddonList')
