local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc
local pairs = pairs
local type = type
local unpack = unpack

local function ConvertTags(tags)
	local res = {}
	for _, tag in ipairs(tags) do
		res[tag] = true
	end
  return res
end

function S:Baganator()
	if not E.db.ProjectHopes.skins.Baganator then return end

	local icons = {}
	local frame = CreateFrame("Frame")
	frame:RegisterEvent("UI_SCALE_CHANGED")
	frame:SetScript("OnEvent", function()
		C_Timer.After(0, function()
			for _, frame in ipairs(icons) do
			local c1, c2, c3 = frame.backdrop:GetBackdropBorderColor()
			frame.backdrop:SetTemplate(nil, true, nil, nil, nil, nil, nil, true)
			frame.backdrop:SetIgnoreParentScale(true)
			frame.backdrop:SetScale(UIParent:GetScale())
			frame.backdrop:SetBackdropBorderColor(c1, c2, c3)
			end
		end)
	end)
	
	local skinners = {
		ItemButton = function(frame)
			frame.bgrElvUISkin = true
			S:HandleItemButton(frame, true)
			BORDER:CreateBorder(frame, 0)

			frame.border:SetBackdrop(Private.BorderLight)
			frame.backdrop:SetBackdrop()
			BORDER:HandleIconBorder(frame.IconBorder, frame.border)

			if frame.SetItemButtonTexture then
			hooksecurefunc(frame, "SetItemButtonTexture", function()
				frame.icon:SetTexCoord(unpack(E.TexCoords))
			end)
			end
			if frame.JunkIcon then
			frame.JunkIcon:SetAtlas('bags-junkcoin', true)
			end
			-- Fix search overlay being removed by ElvUI in classic
			if Baganator.Constants.IsClassic then
			frame.searchOverlay:SetColorTexture(0, 0, 0, 0.8)
			end
			local cooldown = frame.Cooldown or frame:GetName() and _G[frame:GetName() .. "Cooldown"]
			if cooldown then
			E:RegisterCooldown(cooldown)
			end
			table.insert(icons, frame)
			frame.backdrop:SetIgnoreParentScale(true)
			frame.backdrop:SetScale(UIParent:GetScale())
		end,

		IconButton = function(frame)
			S:HandleButton(frame)
			BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, false, true)
		end,

		Button = function(frame)
			S:HandleButton(frame)
			BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, false, true)
		end,

		ButtonFrame = function(frame)
			S:HandlePortraitFrame(frame)
			BORDER:CreateBorder(frame)
		end,

		SearchBox = function(frame)
			S:HandleEditBox(frame)
			BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true, false)
		end,

		EditBox = function(frame)
			S:HandleEditBox(frame)
			BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true, false)
		end,

		TabButton = function(frame)
			S:HandleTab(frame)
			BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true, true)
		end,

		TopTabButton = function(frame)
			S:HandleTab(frame)
			BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true, true)
		end,

		SideTabButton = function(frame)
			frame.Background:Hide()
		
			frame.Icon:ClearAllPoints()
			frame.Icon:SetPoint("CENTER")
			frame.Icon:SetSize(25, 25)
			frame.Icon:SetTexCoord(unpack(E.TexCoords))
		
			frame.SelectedTexture:ClearAllPoints()
			frame.SelectedTexture:SetPoint("CENTER")
			frame.SelectedTexture:SetSize(25, 25)
			frame.SelectedTexture:SetTexture(E.Media.Textures.Melli)
			frame.SelectedTexture:SetVertexColor(1, .82, 0, 0.6)
		
			S:HandleTab(frame)
			BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, false, true)

			frame:SetTemplate("Transparent")
		end,

		TrimScrollBar = function(frame)
			S:HandleTrimScrollBar(frame)
			--BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true, true)
		end,

		CheckBox = function(frame)
			S:HandleCheckBox(frame)
			BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true, true)
		end,

		Slider = function(frame)
			S:HandleSliderFrame(frame)
			--BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true, true)
		end,

		InsetFrame = function(frame)
			if frame.NineSlice then
			frame.NineSlice:SetTemplate("Transparent")
			else
			S:HandleInsetFrame(frame)
			end
		end,

		CornerWidget = function(frame, tags)
			if frame:IsObjectType("FontString") and BAGANATOR_ELVUI_USE_BAG_FONT then
			frame:FontTemplate(LSM:Fetch('font', E.db.bags.countFont), BAGANATOR_CONFIG["icon_text_font_size"], E.db.bags.countFontOutline)
			end
		end,

		DropDownWithPopout = function(button)
			button.HighlightTexture:SetAlpha(0)
			button.NormalTexture:SetAlpha(0)
		
			local r, g, b, a = unpack(E.media.backdropfadecolor)
			button.Popout:StripTextures()
			button.Popout:SetTemplate('Transparent')
			button.Popout:SetBackdropColor(r, g, b, max(a, 0.9))
		
			local expandArrow = button:CreateTexture(nil, "ARTWORK")
			expandArrow:SetTexture(E.Media.Textures.ArrowUp)
			expandArrow:SetRotation(S.ArrowRotation.down)
			expandArrow:Size(15)
			expandArrow:SetPoint("RIGHT", -10, 0)
		
			S:HandleButton(button, nil, nil, nil, true)
			BORDER:CreateBorder(button, nil, nil, nil, nil, nil, false, true)

			button.backdrop:SetInside(nil, 4, 4)
		end,
	}
	
	if C_AddOns.IsAddOnLoaded("Masque") then
		local Masque = LibStub("Masque", true)
		local masqueGroup = Masque:Group("Baganator", "Bag")
		if not masqueGroup.db.Disabled then
			skinners.ItemButton = function() end
		else
			BAGANATOR_CONFIG["empty_slot_background"] = true
		end
	else
		BAGANATOR_CONFIG["empty_slot_background"] = true
		hooksecurefunc("SetItemButtonTexture", function(frame)
			if frame.bgrElvUISkin then
			(frame.icon or frame.Icon):SetTexCoord(unpack(E.TexCoords))
			end
		end)
	end
	
	local function SkinFrame(details)
		local func = skinners[details.regionType]
		if func then
			func(details.region, details.tags and ConvertTags(details.tags) or {})
		end
	end
	
	Baganator.API.Skins.RegisterListener(SkinFrame)
	
	for _, details in ipairs(Baganator.API.Skins.GetAllFrames()) do
		SkinFrame(details)
	end

	-- Baganator Bag
--[[
	local Baganator = _G.Baganator_CategoryViewBackpackViewFrameelvui
	
	Baganator.ToggleBankButton:SetSize(20, 20)
	Baganator.ToggleGuildBankButton:SetSize(20, 20)
	Baganator.ToggleAllCharacters:SetSize(20, 20)
	Baganator.ToggleBagSlotsButton:SetSize(20, 20)
	Baganator.SortButton:SetSize(20, 20)
	Baganator.CustomiseButton:SetSize(20, 20)
	Baganator.TransferButton:SetSize(20, 20)

	Baganator.ToggleBankButton:ClearAllPoints()
	Baganator.ToggleBankButton:SetPoint("TOPLEFT", Baganator, "TOPLEFT", 4, -4)

	Baganator.ToggleGuildBankButton:ClearAllPoints()
	Baganator.ToggleGuildBankButton:SetPoint("LEFT", Baganator.ToggleBankButton, "RIGHT", 4, 0)

	Baganator.ToggleAllCharacters:ClearAllPoints()
	Baganator.ToggleAllCharacters:SetPoint("LEFT", Baganator.ToggleGuildBankButton, "RIGHT", 4, 0)

	Baganator.ToggleBagSlotsButton:ClearAllPoints()
	Baganator.ToggleBagSlotsButton:SetPoint("LEFT", Baganator.ToggleAllCharacters, "RIGHT", 4, 0)

	Baganator.CustomiseButton:ClearAllPoints()
	Baganator.CustomiseButton:SetPoint("TOPRIGHT", Baganator, "TOPRIGHT", -24, -4)
	
	Baganator.SortButton:ClearAllPoints()
	Baganator.SortButton:SetPoint("RIGHT", Baganator.CustomiseButton, "LEFT", -4, 0)

	-- Baganator Bank
	local Bankanator = _G.Baganator_CategoryViewBankViewFrame
	Bankanator.Character.ToggleAllCharacters:SetSize(20, 20)
	Bankanator.Character.ToggleBagSlotsButton:SetSize(20, 20)
	Bankanator.CustomiseButton:SetSize(20, 20)

	Bankanator.Character.ToggleAllCharacters:ClearAllPoints()
	Bankanator.Character.ToggleAllCharacters:SetPoint("TOPLEFT", Bankanator, "TOPLEFT", 4, -4)

	Bankanator.Character.ToggleBagSlotsButton:ClearAllPoints()
	Bankanator.Character.ToggleBagSlotsButton:SetPoint("LEFT", Bankanator.Character.ToggleAllCharacters, "RIGHT", 4, 0)

	Bankanator.CustomiseButton:ClearAllPoints()
	Bankanator.CustomiseButton:SetPoint("TOPRIGHT", Bankanator, "TOPRIGHT", -24, -4)

	-- Baganator GuildBank
	local Guildanator = _G.Baganator_SingleViewGuildViewFrame
	Guildanator.ToggleTabTextButton:SetSize(20, 20)
	Guildanator.ToggleTabLogsButton:SetSize(20, 20)
	Guildanator.ToggleGoldLogsButton:SetSize(20, 20)
	Guildanator.CustomiseButton:SetSize(20, 20)

	Guildanator.ToggleTabTextButton:ClearAllPoints()
	Guildanator.ToggleTabTextButton:SetPoint("TOPLEFT", Guildanator, "TOPLEFT", 4, -4)

	Guildanator.ToggleTabLogsButton:ClearAllPoints()
	Guildanator.ToggleTabLogsButton:SetPoint("LEFT", Guildanator.ToggleTabTextButton, "RIGHT", 4, 0)

	Guildanator.ToggleGoldLogsButton:ClearAllPoints()
	Guildanator.ToggleGoldLogsButton:SetPoint("LEFT", Guildanator.ToggleTabLogsButton, "RIGHT", 4, 0)

	Guildanator.CustomiseButton:ClearAllPoints()
	Guildanator.CustomiseButton:SetPoint("TOPRIGHT", Guildanator, "TOPRIGHT", -24, -4)

	Guildanator.WithdrawButton:ClearAllPoints()
	Guildanator.WithdrawButton:SetPoint("RIGHT", Guildanator.DepositButton, "LEFT", -4, 0)
	]]
end

S:AddCallbackForAddon("Baganator")
