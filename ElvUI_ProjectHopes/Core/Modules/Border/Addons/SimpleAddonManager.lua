local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')
local S = E:GetModule('Skins')

local _G = _G

function S:SimpleAddonManager()
	if not E.db.ProjectHopes.skins.simpleaddonmanager then return end

	local function SkinOnFrameShow()
		local frameData = {
			{frame = _G.SimpleAddonManager},
		}

		local editboxData = {
			{editbox = _G.SimpleAddonManager.SearchBox},
		}

		local buttonData = {
			{button = _G.SimpleAddonManager.EnableAllButton},
			{button = _G.SimpleAddonManager.DisableAllButton},
			{button = _G.SimpleAddonManager.OkButton},
			{button = _G.SimpleAddonManager.CancelButton},
			{button = _G.SimpleAddonManager.SetsButton},
			{button = _G.SimpleAddonManager.ConfigButton},
			{button = _G.SimpleAddonManager.CategoryButton},
			{button = _G.SimpleAddonManager.CategoryFrame.NewButton},
			{button = _G.SimpleAddonManager.CategoryFrame.SelectAllButton},
			{button = _G.SimpleAddonManager.CategoryFrame.ClearSelectionButton},
		}

		local dropdownData = {
			{dropdown = _G.SAM_CharacterDropDown, dropdownbutton = _G.SAM_CharacterDropDownButton, borderParams = {nil, nil, nil, nil, nil, true, true}},
		}

		-- Apply the skinning
		BORDER:SkinDropDownList(dropdownData)
		BORDER:SkinButtonList(buttonData)
		BORDER:SkinFrameList(frameData)
		BORDER:SkinEditboxList(editboxData)

		-- Adjust Sizes
		BORDER:AdjustSize(_G.SAM_CharacterDropDown,-10,0)

		-- Positions
		BORDER:ClearAndSetPoint(_G.SimpleAddonManager.OkButton, "RIGHT", _G.SimpleAddonManager.CancelButton, "LEFT", -5, 0)
		BORDER:ClearAndSetPoint(_G.SimpleAddonManager.SetsButton, "LEFT", _G.SAM_CharacterDropDown, "RIGHT", 8, 0)
		BORDER:ClearAndSetPoint(_G.SimpleAddonManager.DisableAllButton, "LEFT", _G.SimpleAddonManager.EnableAllButton, "RIGHT", 5, 0)
		BORDER:ClearAndSetPoint(_G.SimpleAddonManager.CategoryFrame.SelectAllButton, "TOPRIGHT", _G.SimpleAddonManager.CategoryFrame.NewButton, "CENTER", -2, -15)
		BORDER:ClearAndSetPoint(_G.SimpleAddonManager.CategoryFrame.ClearSelectionButton, "TOPLEFT", _G.SimpleAddonManager.CategoryFrame.NewButton, "CENTER", 2, -15)
		BORDER:ClearAndSetPoint(_G.SimpleAddonManager.ConfigButton, "RIGHT", _G.SimpleAddonManager.CategoryButton, "LEFT", -5, 0)
		BORDER:ClearAndSetPoint(_G.SAM_CharacterDropDown, "TOPLEFT", 5, -20)

		-- Additional
		S:HandleScrollBar(_G.SimpleAddonManager.CategoryFrame.ScrollFrame.ScrollBar)
		BORDER:CreateBorder(_G.SimpleAddonManager.CategoryFrame.ScrollFrame.ScrollBar, nil, nil, nil, nil, nil, true, true)
		S:HandleScrollBar(_G.SimpleAddonManager.AddonListFrame.ScrollFrame.ScrollBar)
		BORDER:CreateBorder(_G.SimpleAddonManager.AddonListFrame.ScrollFrame.ScrollBar, nil, nil, nil, nil, nil, true, true)

		-- Skin ElioteDropDownMenu dropdowns
		local edd = _G.LibStub("ElioteDropDownMenu-1.0", true)
		if edd then
			hooksecurefunc(edd, "UIDropDownMenu_CreateFrames", function(level)
				local dropdown = _G["ElioteDDM_DropDownList" .. level]
				if dropdown then
					local backdrop = _G[dropdown:GetName() .. "Backdrop"]
					local menuBackdrop = _G[dropdown:GetName() .. "MenuBackdrop"]
					if backdrop then backdrop:SetTemplate("Transparent") end
					if menuBackdrop then menuBackdrop:SetTemplate("Transparent") end
				end
			end)
		end

		S:Unhook(_G.SimpleAddonManager, "OnShow")
	end

	S:SecureHookScript(_G.SimpleAddonManager, "OnShow", SkinOnFrameShow)


end

S:AddCallbackForAddon("SimpleAddonManager")
