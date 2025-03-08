local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')
local S = E:GetModule('Skins')

local _G = _G

function S:AtlasLootClassic()
	if not E.db.ProjectHopes.skins.atlaslootclassic then return end

	local function SkinOnFrameShow()
		local frameData = {
			{frame = _G["AtlasLoot_GUI-Frame"]},
			{frame = _G["AtlasLoot-Select-1"]},
			{frame = _G["AtlasLoot-Select-2"]},
			{frame = _G["AtlasLoot-Select-3"]},
			{frame = _G["AtlasLoot_GUI-Frame"].titleFrame},
		}

		local editboxData = {
			{editbox = _G["AtlasLoot_GUI-ItemFrame-SearchBox"]},
		}

		local buttonData = {
			{button = _G["AtlasLoot-Button-1"]},
			{button = _G["AtlasLoot-Button-2"]},
			{button = _G["AtlasLoot-Button-3"]},
		}

		local dropdownData = {
			{dropdown = _G["AtlasLoot-DropDown-1"], borderParams = {nil, nil, nil, nil, nil, true, true}},
			{dropdown = _G["AtlasLoot-DropDown-2"], borderParams = {nil, nil, nil, nil, nil, true, true}},
		}

		-- Apply the skinning
		BORDER:SkinDropDownList(dropdownData)
		BORDER:SkinButtonList(buttonData)
		BORDER:SkinFrameList(frameData)
		BORDER:SkinEditboxList(editboxData)

		-- Adjust Sizes
		BORDER:AdjustSize(_G["AtlasLoot_GUI-ItemFrame-SearchBox"],0,-14)

		-- Additional Things
		-- Stip Dropdown Game Buttons
		_G["AtlasLoot-DropDown-1-button"]:StripTextures()
		_G["AtlasLoot-DropDown-1-button"]:SetTemplate('Transparent')
		_G["AtlasLoot-DropDown-1-button"]:SetBackdrop(nil)
		_G["AtlasLoot-DropDown-2-button"]:StripTextures()
		_G["AtlasLoot-DropDown-2-button"]:SetTemplate('Transparent')
		_G["AtlasLoot-DropDown-2-button"]:SetBackdrop(nil)

		-- GameVersionButton/Logo
		S:HandleButton(_G["AtlasLoot_GUI-Frame-gameVersionButton"])
		_G["AtlasLoot_GUI-Frame-gameVersionButton"]:SetBackdrop(nil)
		local transparentTexture = _G["AtlasLoot_GUI-Frame-gameVersionButton"]:CreateTexture(nil, "ARTWORK")
		transparentTexture:SetAlpha(0)  -- Set the texture to be fully transparent

		_G["AtlasLoot_GUI-Frame-gameVersionButton"]:SetHighlightTexture(transparentTexture)
		_G["AtlasLoot_GUI-Frame-gameVersionButton"]:SetNormalTexture(538639)
		_G["AtlasLoot_GUI-Frame-gameVersionButton"]:SetPushedTexture(538639)
		_G["AtlasLoot_GUI-Frame-gameVersionLogo"]:Hide()  -- Hide the texture

		-- Clear Extra lines on GameVersionButton
		if _G["AtlasLoot_GUI-Frame"].gameVersionButton.Box then
			for i, line in ipairs(_G["AtlasLoot_GUI-Frame"].gameVersionButton.Box) do
				line:ClearAllPoints()  -- Remove any points the lines have
				line:SetParent(nil)    -- Remove lines from their parent
			end
			_G["AtlasLoot_GUI-Frame"].gameVersionButton.Box = {}  -- Clear the Box table
		end

		-- Skin next/prev buttons
        local navButtons = {
            _G["AtlasLoot_GUI-ItemFrame-nextPageButton"],
            _G["AtlasLoot_GUI-ItemFrame-prevPageButton"],
        }
        for _, button in ipairs(navButtons) do
            S:HandleNextPrevButton(button)
        end

		-- Add backdrop to item frame
		_G["AtlasLoot_GUI-ItemFrame"]:CreateBackdrop()
		BORDER:CreateBorder(_G["AtlasLoot_GUI-ItemFrame"], nil, nil, nil, nil, nil, true, true)

		S:Unhook(_G["AtlasLoot_GUI-Frame"], "OnShow")
	end

	S:SecureHookScript(_G["AtlasLoot_GUI-Frame"], "OnShow", SkinOnFrameShow)
end

S:AddCallbackForAddon("AtlasLootClassic")
