local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local _G = _G
local hooksecurefunc = hooksecurefunc
local pairs = pairs
local strfind = strfind

local skinned = false

function S:RaiderIO_DelayedSkinning()
	if skinned then
		return
	end
	skinned = true
	if _G.RaiderIO_ProfileTooltip then
		_G.RaiderIO_ProfileTooltip.NineSlice:Kill()
		_G.RaiderIO_ProfileTooltip:SetTemplate("Transparent")
		BORDER:CreateBorder(_G.RaiderIO_ProfileTooltip)

		local point, relativeTo, relativePoint, xOffset, yOffset = _G.RaiderIO_ProfileTooltip:GetPoint()
		_G.RaiderIO_ProfileTooltip:SetPoint(point, relativeTo, relativePoint, 6, 0)
		if xOffset and yOffset and xOffset == 0 and yOffset == 0 then
			_G.RaiderIO_ProfileTooltip.__SetPoint = _G.RaiderIO_ProfileTooltip.SetPoint
			hooksecurefunc(
				_G.RaiderIO_ProfileTooltip,
				"SetPoint",
				function(self, point, relativeTo, relativePoint, xOffset, yOffset)
					if xOffset and yOffset and xOffset == 0 and yOffset == 0 then
						self:__SetPoint(point, relativeTo, relativePoint, 6, 0)
					end
	
				end
			)
		end
	end

	if _G.RaiderIO_SearchFrame then
		_G.RaiderIO_SearchFrame:StripTextures()
		_G.RaiderIO_SearchFrame:SetTemplate("Transparent")
		BORDER:CreateBorder(_G.RaiderIO_SearchFrame)
		S:HandleCloseButton(_G.RaiderIO_SearchFrame.close)

		for _, child in pairs({_G.RaiderIO_SearchFrame:GetChildren()}) do
			local numRegions = child:GetNumRegions()
			if numRegions == 9 then
				if child and child:GetObjectType() == "EditBox" then
					if not child.IsSkinned then
						child:DisableDrawLayer("BACKGROUND")
						child:DisableDrawLayer("BORDER")
						S:HandleEditBox(child)
						BORDER:CreateBorder(child, nil, nil, nil, nil, nil, true, true)

						child:SetTextInsets(2, 2, 2, 2)
						child:SetHeight(30)

						if child:GetNumPoints() == 1 then
							local point, relativeTo, relativePoint, xOffset, yOffset = child:GetPoint(1)
							yOffset = -3
							child:ClearAllPoints()
							child:SetPoint(point, relativeTo, relativePoint, xOffset, yOffset)
						end

						child.IsSkinned = true
					end
				end
			end
		end
	end
end

function S:RaiderIO_GuildWeeklyFrame()
	S:RaiderIO_DelayedSkinning()
	E:Delay(0.15, function()
		if _G.RaiderIO_GuildWeeklyFrame then
			local frame = _G.RaiderIO_GuildWeeklyFrame
			frame:StripTextures()
			frame:SetTemplate("Transparent")
			frame.SwitchGuildBest:SetSize(18, 18)
			S:HandleCheckBox(frame.SwitchGuildBest)
			BORDER:CreateBorder(frame)
		end
	end)
end

function S:RaiderIO()
	if not E.db.ProjectHopes.skins.raiderio then return end

	S:SecureHook(_G.PVEFrame, "Show", "RaiderIO_GuildWeeklyFrame")

	if _G.RaiderIO_SettingsPanel then
		for _, child in pairs({ _G.RaiderIO_SettingsPanel:GetChildren() }) do
			if child:GetObjectType("Button") then
				S:HandleButton(child)
				BORDER:CreateBorder(child, nil, nil, nil, nil, nil, false, true)
			end
		end
	end
end

S:AddCallbackForAddon("RaiderIO")
