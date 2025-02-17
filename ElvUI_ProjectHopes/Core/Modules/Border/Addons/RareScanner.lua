local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc
local pairs = pairs
local type = type
local unpack = unpack

function PositionIcons()
	local previousIcon
	for _, v in pairs{_G["LootBar"]:GetChildren()} do
		if v and v.Icon then
			if previousIcon then
				v:ClearAllPoints()
				v:SetPoint("LEFT", previousIcon, "RIGHT", 7, 0)
			else
				v:ClearAllPoints()
				v:SetPoint("TOPLEFT", RARESCANNER, "BOTTOMLEFT", -6, -6)
			end
			previousIcon = v
		end
	end
end

function S:RareScanner()
	if not E.db.ProjectHopes.skins.rareScanner then return end

	local RARESCANNER = _G.RARESCANNER_BUTTON
	if RARESCANNER and not RARESCANNER.IsSkinned then
		S:HandleFrame(RARESCANNER, "Transparent")
		--button is too small sometimes, resize
		RARESCANNER.CloseButton:SetSize(25,25)

		-- the minus button
		if RARESCANNER.FilterEntityButton then
			S:HandleButton(RARESCANNER.FilterEntityButton)
			BORDER:CreateBorder(RARESCANNER.FilterEntityButton)
			RARESCANNER.FilterEntityButton:SetNormalTexture([[Interface\WorldMap\Dash_64Grey]])
			RARESCANNER.FilterEntityButton:SetPushedTexture([[Interface\WorldMap\Dash_64Grey]])
		end

		if RARESCANNER.UnfilterEnabledButton then
			S:HandleButton(RARESCANNER.UnfilterEnabledButton)
			RARESCANNER.UnfilterEnabledButton:SetNormalTexture([[Interface\WorldMap\Skull_64]])
			RARESCANNER.UnfilterEnabledButton:SetPushedTexture([[Interface\WorldMap\Skull_64]])
		end

		if RARESCANNER and not RARESCANNER.border then
			BORDER:CreateBorder(RARESCANNER)
			RARESCANNER:Size(202, 50)
		end

		RARESCANNER.IsSkinned = true
	end

	-- Hook the function to skin the icons
	hooksecurefunc(RARESCANNER.LootBar.itemFramesPool, "ShowIfReady", function()
		E:Delay(0, function()
			if _G["LootBar"] and _G["LootBar"]:IsVisible() then
				for _, v in pairs{_G["LootBar"]:GetChildren()} do
					if v and v.Icon and not v.IsSkinned then
						v.Icon:SetTexCoord(unpack(E.TexCoords))
						v:CreateBackdrop()
						if not v.backdrop.border then
							BORDER:CreateBorder(v.backdrop)
						end
						v.IsSkinned = true
					end
				end
				-- Call the function to position the icons
				--PositionIcons()
			end
		end)
	end)
end

S:AddCallbackForAddon("RareScanner")
