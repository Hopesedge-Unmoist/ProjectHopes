local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc

local function HandleRewardButton(box)
	local container = box.ContentsContainer
	if container and not container.IsBorder then
		container.IsBorder = true

		BORDER:HandleIcon(container.Icon, true)
	end
end

local function HandleRewards(box)
	if box then
		box:ForEachFrame(HandleRewardButton)
	end
end

function S:Blizzard_PerksProgram()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.perks) then return end
	if not E.db.ProjectHopes.skins.perksProgram then return end

	local PerksProgramFrame = _G.PerksProgramFrame

	local products = PerksProgramFrame.ProductsFrame
	BORDER:CreateBorder(products)

	if products then
		BORDER:CreateBorder(products.PerksProgramFilter, nil, nil, nil, nil, nil, false, true)

		local currency = products.PerksProgramCurrencyFrame
		if currency then
			BORDER:HandleIcon(currency.Icon)
		end

		local details = products.PerksProgramProductDetailsContainerFrame
		BORDER:CreateBorder(details)

		if details then
			BORDER:CreateBorder(details.SetDetailsScrollBoxContainer.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

			local carousel = details.CarouselFrame
		end

		local container = products.ProductsScrollBoxContainer
		BORDER:CreateBorder(container)

		if container then
			BORDER:CreateBorder(container.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
			
			hooksecurefunc(container.ScrollBox, 'Update', HandleRewards)
		end
	end

	local footer = PerksProgramFrame.FooterFrame
	if footer then
		BORDER:CreateBorder(footer.TogglePlayerPreview, nil, nil, nil, nil, nil, true, true)
		BORDER:CreateBorder(footer.ToggleMountSpecial, nil, nil, nil, nil, nil, true, true)
		BORDER:CreateBorder(footer.ToggleHideArmor, nil, nil, nil, nil, nil, true, true)
		BORDER:CreateBorder(footer.ToggleAttackAnimation, nil, nil, nil, nil, nil, true, true)
		   
		local purchase = footer.PurchaseButton
		if purchase then
			BORDER:CreateBorder(footer.LeaveButton, nil, nil, nil, nil, nil, false, true)
			BORDER:CreateBorder(footer.RefundButton, nil, nil, nil, nil, nil, false, true)
			BORDER:CreateBorder(footer.PurchaseButton, nil, nil, nil, nil, nil, false, true)           
		end

		local rotate = footer.RotateButtonContainer
		if rotate and rotate.RotateLeftButton then
			BORDER:CreateBorder(rotate.RotateLeftButton, nil, nil, nil, nil, nil, false, true)
			BORDER:CreateBorder(rotate.RotateRightButton, nil, nil, nil, nil, nil, false, true)
		end
	end
end

S:AddCallbackForAddon('Blizzard_PerksProgram')
