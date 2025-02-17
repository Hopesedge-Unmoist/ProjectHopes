local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc
local pairs = pairs
local type = type
local unpack = unpack
local IsAddOnLoaded = C_AddOns.IsAddOnLoaded

local function reskinTlxScrollChild(self)
	for _, child in next, { self.ScrollTarget:GetChildren() } do
		local top = child.BgTop
		local middle = child.BgMiddle
		local bottom = child.BgBottom
		
		if child and not child.Border then
			BORDER:CreateBorder(child, nil, -6, 6, 6, -6, false, true)
			child.Border = true
		end

		if top and not top.Skinned then
			top:Hide()
			top.Skinned = true
		end

		if middle and not middle.Skinned then
			middle:Hide()
			middle.Skinned = true
		end
		
		if bottom and not bottom.Skinned then
			bottom:Hide()
			bottom.Skinned = true
		end
	end
end

local function ReskinTlxScrollBox(frame)
	frame:DisableDrawLayer('BACKGROUND')
	frame:StripTextures()
	hooksecurefunc(frame, 'Update', reskinTlxScrollChild)
end

function S:Blizzard_PlayerSpells()
	if not E.db.ProjectHopes.skins.talentLoadoutsEx then return end

	if not IsAddOnLoaded("TalentLoadoutsEx") then
		return
	end

	E:Delay(0.1, function()
		_G.TalentLoadoutExMainFrame:StripTextures()
		_G.TalentLoadoutExMainFrame:SetTemplate('Transparent')
		BORDER:CreateBorder(_G.TalentLoadoutExMainFrame)
	
		_G.TalentLoadoutExMainFrame.PvpFrame:StripTextures()
		_G.TalentLoadoutExMainFrame.PvpFrame:SetTemplate('Transparent')
		BORDER:CreateBorder(_G.TalentLoadoutExMainFrame.PvpFrame)
	
		S:HandleCheckBox(_G.TalentLoadoutExMainFrame.PvpFrame.CheckButton)
		BORDER:CreateBorder(_G.TalentLoadoutExMainFrame.PvpFrame.CheckButton, nil, nil, nil, nil, nil, true, true)
	
		local buttons = {
			_G.TalentLoadoutExMainFrame.ImportButton,
			_G.TalentLoadoutExMainFrame.ExportButton,
			_G.TalentLoadoutExMainFrame.LoadButton,
			_G.TalentLoadoutExMainFrame.EditButton,
			_G.TalentLoadoutExMainFrame.UpButton,
			_G.TalentLoadoutExMainFrame.SaveButton,
			_G.TalentLoadoutExMainFrame.DeleteButton,
			_G.TalentLoadoutExMainFrame.DownButton,
		}
	
		for i = 1, #buttons do
			S:HandleButton(buttons[i])
			BORDER:CreateBorder(buttons[i], nil, -6, 6, 6, -6, false, true)
			buttons[i]:SetBackdrop()
		end
	
		hooksecurefunc(_G.TalentLoadoutExMainFrame.ScrollBox, 'Update', function()
			for _, child in next, { _G.TalentLoadoutExMainFrame.ScrollBox.ScrollTarget:GetChildren() } do
				local top = child.BgTop
				local middle = child.BgMiddle
				local bottom = child.BgBottom
				
				if child and not child.Border then
					BORDER:CreateBorder(child, nil, -6, 6, 6, -6, false, true)
					child.Border = true
				end
	
				if top and not top.Skinned then
					top:Hide()
					top.Skinned = true
				end
	
				if middle and not middle.Skinned then
					middle:Hide()
					middle.Skinned = true
				end
				
				if bottom and not bottom.Skinned then
					bottom:Hide()
					bottom.Skinned = true
				end
			end
		end)

		ReskinTlxScrollBox(_G.TalentLoadoutExMainFrame.ScrollBox)

		S:HandleScrollBar(_G.TalentLoadoutExMainFrame.ScrollBar)
		BORDER:CreateBorder(_G.TalentLoadoutExMainFrame.ScrollBar, nil, nil, nil, nil, nil, true, true)
	
		local Popup = _G.TalentLoadoutExMainFrame.EditPopupFrame
		S:HandleIconSelectionFrame(Popup)
	
		S:HandleFrame(Popup.TalentTextFrame)
		BORDER:CreateBorder(Popup.TalentTextFrame)
	
		S:HandleFrame(Popup.IconListFrame)
		BORDER:CreateBorder(Popup.IconListFrame)
	
		S:HandleEditBox(Popup.TalentTextFrame.Main.EditBox)
		Popup.TalentTextFrame:SetHeight(30)
		Popup.TalentTextFrame.Main:StripTextures()
	
		Popup.IconListFrame:SetPoint("TOPLEFT", Popup, "BOTTOMLEFT", 1, 0)
		Popup.TalentTextFrame:SetPoint("BOTTOMLEFT", Popup, "TOPLEFT", 1, 0)
	
		S:HandleFrame(_G.TalentLoadoutExMainFrame.TextPopupFrame)
		BORDER:CreateBorder(_G.TalentLoadoutExMainFrame.TextPopupFrame, 0)
	
		_G.TalentLoadoutExMainFrame.TextPopupFrame.Main:StripTextures()
		S:HandleEditBox(_G.TalentLoadoutExMainFrame.TextPopupFrame.Main.ScrollFrame)
		BORDER:CreateBorder(_G.TalentLoadoutExMainFrame.TextPopupFrame.Main.ScrollFrame)
		S:HandleButton(_G.TalentLoadoutExMainFrame.TextPopupFrame.Main.CloseButton)
		BORDER:CreateBorder(_G.TalentLoadoutExMainFrame.TextPopupFrame.Main.CloseButton, nil, nil, nil, nil, nil, false, true)
	
		S:HandleButton(_G.TalentLoadoutExMainFrame.TextPopupFrame.Main.ImportButton)
		BORDER:CreateBorder(_G.TalentLoadoutExMainFrame.TextPopupFrame.Main.ImportButton, nil, nil, nil, nil, nil, false, true)
	
		S:HandleButton(_G.TalentLoadoutExMainFrame.TextPopupFrame.Main.CancelButton)
		BORDER:CreateBorder(_G.TalentLoadoutExMainFrame.TextPopupFrame.Main.CancelButton, nil, nil, nil, nil, nil, false, true)
	
		_G.TalentLoadoutExMainFrame.TextPopupFrame.Header:StripTextures()
		_G.TalentLoadoutExMainFrame.TextPopupFrame.Header:SetTemplate('Transparent')
		BORDER:CreateBorder(_G.TalentLoadoutExMainFrame.TextPopupFrame.Header)
	
		S:HandleScrollBar(_G.TalentLoadoutExMainFrameScrollBar)
		BORDER:CreateBorder(_G.TalentLoadoutExMainFrameScrollBar, nil, nil, nil, nil, nil, true, true)
	
		-- Reposition for pixel perfect style
		_G.TalentLoadoutExMainFrame:ClearAllPoints()
		_G.TalentLoadoutExMainFrame:Point('TOPLEFT', _G.ClassTalentFrame, 'TOPRIGHT', 6, 0)
	end)
end

-- Using "Blizzard_PlayerSpells" because TalentLoadoutsEx load is fucking weird as fuck. 
S:AddCallbackForAddon('Blizzard_PlayerSpells')
