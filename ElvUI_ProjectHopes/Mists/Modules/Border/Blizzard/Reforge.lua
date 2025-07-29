local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local unpack = unpack
local hooksecurefunc = hooksecurefunc

local GetItemIconByID = C_Item.GetItemIconByID
local GetReforgeItemInfo = C_Reforge.GetReforgeItemInfo
local GetItemQualityColor = C_Item.GetItemQualityColor

local function ReforgingFrameUpdate()
	local _, itemID, _, quality = GetReforgeItemInfo()
	local texture = itemID and GetItemIconByID(itemID) or nil
	BORDER:CreateBorder(_G.ReforgingFrameItemButton)

	if quality then
		local r, g, b = GetItemQualityColor(quality)
		_G.ReforgingFrameItemButton.border:SetBackdropBorderColor(r, g, b)
	else
		_G.ReforgingFrameItemButton.border:SetBackdropBorderColor(1, 1, 1)
	end
end

function S:Blizzard_ReforgingUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.reforge) then return end
	if not E.db.ProjectHopes.skins.reforge then return end

	local ReforgingFrame = _G.ReforgingFrame
	BORDER:CreateBorder(ReforgingFrame)

	BORDER:CreateBorder(_G.ReforgingFrameRestoreButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.ReforgingFrameReforgeButton, nil, nil, nil, nil, nil, false, true)

	hooksecurefunc('ReforgingFrame_Update', ReforgingFrameUpdate)
end

S:AddCallbackForAddon('Blizzard_ReforgingUI')
