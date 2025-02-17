local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local unpack = unpack
local hooksecurefunc = hooksecurefunc

local function HandleNextPrev(button)
	BORDER:CreateBorder(button, nil, nil, nil, nil, nil, false, true)
end

local function SetSelectedCategory(list)
	if list.selectionPopoutPool then
		for frame in list.selectionPopoutPool:EnumerateActive() do
			if not frame.IsBorder then
				if frame.DecrementButton then
					HandleNextPrev(frame.DecrementButton)
					HandleNextPrev(frame.IncrementButton)
				end

				local button = frame.Button
				if button then                              
					BORDER:CreateBorder(button, nil, nil, nil, nil, nil, false, true)
				end

				frame.IsBorder = true
			end
		end
	end

	if list.dropdownPool then
		for option in list.dropdownPool:EnumerateActive() do
			if not option.IsBorder then
				BORDER:CreateBorder(option.Dropdown, 1, nil, nil, nil, nil, false, true)
				option.Dropdown:Size(122, 24)
				BORDER:CreateBorder(option.DecrementButton, nil, nil, nil, nil, nil, false, true)
				option.DecrementButton:Size(24, 24)
				BORDER:CreateBorder(option.IncrementButton, nil, nil, nil, nil, nil, false, true)
				option.IncrementButton:Size(24, 24)

				option.IsBorder = true
			end
		end
	end

	if list.sliderPool then
		for slider in list.sliderPool:EnumerateActive() do
			if not slider.IsBorder then
				BORDER:CreateBorder(slider, nil, nil, nil, nil, nil, false, true)

				slider.IsBorder = true
			end
		end
	end

	local pool = list.pools and list.pools:GetPool('CharCustomizeOptionCheckButtonTemplate')
	if pool then
		for frame in pool:EnumerateActive() do
			if not frame.IsBorder then
				if frame.Button then
					BORDER:CreateBorder(frame.Button, nil, nil, nil, nil, nil, false, true)
				end
			end
		end
	end
end

function S:Blizzard_CharacterCustomize()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.barber) then return end -- yes, it belongs also to tbe BarberUI
	if not E.db.ProjectHopes.skins.barbershop then return end

	local CharCustomizeFrame = _G.CharCustomizeFrame

	BORDER:CreateBorder(CharCustomizeFrame.SmallButtons.ResetCameraButton, nil, -0, 0, 0, -0)
	BORDER:CreateBorder(CharCustomizeFrame.SmallButtons.ZoomOutButton, nil, -0, 0, 0, -0)
	BORDER:CreateBorder(CharCustomizeFrame.SmallButtons.ZoomInButton, nil, -0, 0, 0, -0)
	BORDER:CreateBorder(CharCustomizeFrame.SmallButtons.RotateLeftButton, nil, -0, 0, 0, -0)
	BORDER:CreateBorder(CharCustomizeFrame.SmallButtons.RotateRightButton, nil, -0, 0, 0, -0)

	hooksecurefunc(CharCustomizeFrame, 'AddMissingOptions', SetSelectedCategory)
end

function S:Blizzard_BarbershopUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.barber) then return end
	if not E.db.ProjectHopes.skins.barbershop then return end

	local BarberShopFrame = _G.BarberShopFrame

	BORDER:CreateBorder(BarberShopFrame.ResetButton, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(BarberShopFrame.CancelButton, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(BarberShopFrame.AcceptButton, nil, nil, nil, nil, nil, true, true)
end

S:AddCallbackForAddon('Blizzard_BarbershopUI')
S:AddCallbackForAddon('Blizzard_CharacterCustomize')
