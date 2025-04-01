local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc
local pairs = pairs
local type = type
local unpack = unpack

-- Tables to store the references to created frames
local createdPanels = {}
local createdSeparators = {}

local function CreateDetailsBarPanel()
	-- Iterate through each barra
	for i = 1, 2 do
			for j = 1, 4 do
					local barFrame = _G["DetailsBarra_"..i.."_"..j]
					if barFrame and not createdSeparators[barFrame] then
							local Panel_barSeparator = CreateFrame("Frame", nil, barFrame, "BackdropTemplate")
							Panel_barSeparator:SetHeight(16)
							Panel_barSeparator:SetBackdrop(Private.Separator)
							Panel_barSeparator:SetFrameLevel(barFrame:GetFrameLevel() + 3)
							Panel_barSeparator:SetPoint("BOTTOMLEFT", 0, -15)
							Panel_barSeparator:SetPoint("BOTTOMRIGHT", 0, 0)
							createdSeparators[barFrame] = Panel_barSeparator
					end
			end
	end
end

local function CreatePanel(panelName, baseFrame, border, separator, background)
	if createdPanels[panelName] then return end -- Prevent duplicate creation

	local Panel = CreateFrame("Frame", panelName, baseFrame, "BackdropTemplate")
	Panel:SetBackdrop(Private.Border)
	Panel:SetFrameLevel(baseFrame:GetFrameLevel() + 6)
	Panel:SetPoint("TOPLEFT", -9, 16)
	Panel:SetPoint("BOTTOMRIGHT", 9, -6)

	local Panel_Separator = CreateFrame("Frame", nil, baseFrame, "BackdropTemplate")
	Panel_Separator:SetHeight(16)
	Panel_Separator:SetBackdrop(separator)
	Panel_Separator:SetFrameLevel(baseFrame:GetFrameLevel() + 5)
	Panel_Separator:SetPoint("TOPLEFT", 0, -13)
	Panel_Separator:SetPoint("TOPRIGHT", 0, -13)

	local Panel_Background = CreateFrame("Frame", nil, baseFrame, "BackdropTemplate")
	Panel_Background:SetBackdrop(background)
	Panel_Background:SetFrameLevel(baseFrame:GetFrameLevel() - 1)
	Panel_Background:SetPoint("TOPLEFT", -1, 8)
	Panel_Background:SetPoint("BOTTOMRIGHT", 1, 0)
	Panel_Background:SetBackdropColor(0.125, 0.125, 0.125, 1)

	createdPanels[panelName] = {
			Panel = Panel,
			Panel_Separator = Panel_Separator,
			Panel_Background = Panel_Background
	}
end


local function DetailsSkin()
	for i = 1, 5 do
		if _G["DetailsBaseFrame"..i] then
			CreatePanel("Details_Panel"..i, _G["DetailsBaseFrame"..i.."FullWindowFrame"], Private.Border, Private.Separator, Private.BackgroundTexture)
		end
	end
    CreateDetailsBarPanel()
end

local function DetailsResizer()
	local frame = CreateFrame("Frame")

	local function ResizeDetailsWindow()
			if not Details then return end

			local window2 = Details:GetWindow(2)
			if not window2 then return end

			local zoneType = Details.zone_type
			local width, height = 236, (zoneType == "raid") and 141 or 57

			window2:SetSize(width, height)
			DetailsBaseFrame2:ClearAllPoints()
			DetailsBaseFrame2:SetPoint("BOTTOMRIGHT", -45, 213)
	end

	local function eventHandler(self, event)
			if event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_ENTERING_WORLD" then
					-- Unregister the events to prevent redundant calls
					self:UnregisterEvent("PLAYER_ENTERING_WORLD")
					self:UnregisterEvent("ZONE_CHANGED_NEW_AREA")

					E:Delay(1.2, function()
							if E.db.ProjectHopes.skins.details then
									DetailsSkin()
							end
							ResizeDetailsWindow()
					end)
			end
	end

	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	frame:SetScript("OnEvent", eventHandler)
end


function S:Details()
  if E.db.ProjectHopes.skins.details then
    DetailsSkin()
  end
    
  if E.private.ProjectHopes.qualityOfLife.detailsResize then
     DetailsResizer()
  end
end

S:AddCallbackForAddon("Details")
