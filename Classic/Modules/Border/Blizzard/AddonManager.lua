local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local unpack = unpack
local hooksecurefunc = hooksecurefunc

local GetAddOnInfo = C_AddOns.GetAddOnInfo
local GetNumAddOns = C_AddOns.GetNumAddOns

function S:AddonList()
	if not E.db.ProjectHopes.skins.addonList then return end

	local AddonList = _G.AddonList
	local maxShown = _G.MAX_ADDONS_DISPLAYED

	BORDER:CreateBorder(AddonList)
	BORDER:CreateBorder(AddonList.EnableAllButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(AddonList.DisableAllButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(AddonList.OkayButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(AddonList.CancelButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.AddonListScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(AddonList.Dropdown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.AddonListForceLoad, nil, nil, nil, nil, nil, true, true)

	AddonList.DisableAllButton:ClearAllPoints()
	AddonList.DisableAllButton:Point('LEFT', AddonList.EnableAllButton, 'RIGHT', 5, 0)

	AddonList.OkayButton:ClearAllPoints()
	AddonList.OkayButton:Point('RIGHT', AddonList.CancelButton, 'LEFT', -5, 0)


	hooksecurefunc('AddonList_Update', function()
		local numEntrys = GetNumAddOns()
		for i = 1, maxShown do
			local index = AddonList.offset + i
			if index <= numEntrys then
				local entry = _G['AddonListEntry'..i]
				local checkbox = _G['AddonListEntry'..i..'Enabled']

				if not entry.IsBorder then
					BORDER:CreateBorder(entry.LoadAddonButton, nil, nil, nil, nil, nil, false, true)
					BORDER:CreateBorder(checkbox, nil, nil, nil, nil, nil, true, true)

					entry.IsBorder = true
				end
			end
		end
	end)
end

S:AddCallback('AddonList')
