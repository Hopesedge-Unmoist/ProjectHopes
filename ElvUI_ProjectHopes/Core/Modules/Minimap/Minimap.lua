local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local UF = E:GetModule('UnitFrames')
local _G = _G

local RMM = E:NewModule('Rectangle Minimap', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0');
local IconParents = {}

function RMM:UpdateMoverSize()
	if E.db.datatexts.panels.MinimapPanel.enable then
		_G.ElvUI_MinimapHolder:Height((_G.Minimap:GetHeight() + (_G.MinimapPanel and (_G.MinimapPanel:GetHeight() + E.Border) or 24)) + E.Spacing*3-((E.MinimapSize/6.1)))
	else
		_G.ElvUI_MinimapHolder:Height((_G.Minimap:GetHeight() + E.Border + E.Spacing*3)-(E.MinimapSize/6.1))
	end
end

function RMM:UpdateLocationText()
	_G.Minimap.location:ClearAllPoints()
	_G.Minimap.location:Point('TOP', _G.Minimap, 'TOP', 0, -45)
end

function RMM:RightClickVault()
	local function CloseAll()
		if GarrisonLandingPage and GarrisonLandingPage:IsShown() then
			GarrisonLandingPage_Toggle()
		end
		if WeeklyRewardsFrame and WeeklyRewardsFrame:IsShown() then
			HideUIPanel(WeeklyRewardsFrame)
		end
		if ExpansionLandingPage and ExpansionLandingPage:IsShown() then
			ToggleExpansionLandingPage();
		end
		if GenericTraitFrame and GenericTraitFrame:IsShown() then
			DragonridingPanelSkillsButtonMixin:OnClick()
		end
	end
	
	local function OpenVault()
		C_AddOns.LoadAddOn("Blizzard_WeeklyRewards")
		WeeklyRewardsFrame:Show()
		tinsert(UISpecialFrames, WeeklyRewardsFrame:GetName())   
	end
	
	local function onButtonClick(self, button)
		local WRF = WeeklyRewardsFrame
		if button == "LeftButton" then
			if WRF and WRF:IsShown() then HideUIPanel(WRF) end
		elseif button == "RightButton" then
			if WRF and WRF:IsShown() then
				CloseAll()
			else
				CloseAll()
				OpenVault()
			end
		elseif button == "MiddleButton" then
			local hasAchievement = select(4, GetAchievementInfo(15794))
			if hasAchievement then
				if GenericTraitFrame and GenericTraitFrame:IsShown() then
					CloseAll()
				else
					CloseAll()
					DragonridingPanelSkillsButtonMixin:OnClick()
				end
			end
		end
	end
	if E.Retail then
		local btn = ExpansionLandingPageMinimapButton
		btn:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp")
		btn:HookScript("OnClick", onButtonClick)
	end
end

function RMM:Initialize()
	if E.db.ProjectHopes.minimap.Rectangle then

		local diff = E.MinimapSize - E.MinimapSize * 87 / 128
		local halfDiff = ceil(diff / 2)
		local mmOffset = E.PixelMode and 1 or 3
		local mmScale = E.db.general.minimap.scale

		_G.Minimap:SetClampedToScreen(true)
		_G.Minimap:SetMaskTexture(Private.MinimapRectangle)
		_G.Minimap:SetHitRectInsets(0, 0, halfDiff, halfDiff)
		_G.Minimap:SetClampRectInsets(0, 0, 0, 0)
		_G.Minimap:ClearAllPoints()
		_G.Minimap:Point('TOPRIGHT', _G.ElvUI_MinimapHolder, 'TOPRIGHT', -E.Border, E.Border)
		
		-- Update the size and position of the Minimap
		_G.Minimap.backdrop:ClearAllPoints()
		_G.Minimap.backdrop:SetOutside(Minimap, mmOffset, -halfDiff * mmScale + mmOffset)

		RMM:UpdateLocationText()
		RMM:UpdateMoverSize()
		RMM:RightClickVault()
		
		_G.MinimapPanel:ClearAllPoints()
		_G.MinimapPanel:Point('TOPLEFT', _G.Minimap, 'BOTTOMLEFT', -E.Border, (E.MinimapSize/6.1)-1)
		_G.MinimapPanel:Point('BOTTOMRIGHT', _G.Minimap, 'BOTTOMRIGHT', E.Border, ((E.MinimapSize/6.1)-22)-1)
	end
end

E:RegisterModule(RMM:GetName());
