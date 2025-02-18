local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local pairs = pairs

function S:Blizzard_VoidStorageUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.voidstorage) then return end
	if not E.db.ProjectHopes.skins.voidstorage then return end


	local VSFrame = _G.VoidStorageFrame
	BORDER:CreateBorder(VSFrame)

	BORDER:CreateBorder(_G.VoidStoragePurchaseButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.VoidStorageTransferButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.VoidItemSearchBox, nil, nil, nil, nil, nil, true, false)

	for storageType, numSlots in pairs({ Deposit = 9, Withdraw = 9, Storage = 80 }) do
		for i = 1, numSlots do
			local btn = _G['VoidStorage'..storageType..'Button'..i]

			BORDER:HandleIcon(btn.icon, true)
			BORDER:HandleIconBorder(btn.IconBorder, btn.icon.backdrop.border)
		end
	end

	-- Handle Frame Tabs
	local num = 1
	local tab = VSFrame['Page'..num]
	while tab do
		local icon = tab:GetNormalTexture()

		if num == 1 then
			tab:ClearAllPoints()
			tab:Point('TOPLEFT', '$parent', 'TOPRIGHT', 7, 0)
		end

		BORDER:HandleIcon(icon)

		BORDER:HandleIcon(tab.pushed, true)

		num = num + 1
		tab = VSFrame['Page'..num]
	end
end

S:AddCallbackForAddon('Blizzard_VoidStorageUI')
