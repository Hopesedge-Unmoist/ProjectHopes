local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local NP = E:GetModule('NamePlates')

function S:ElvUI_Nameplates_StylePlate(_, nameplate)
    if not E.db.ProjectHopes.skins.nameplates then return end

    if nameplate.Health then
        if nameplate.Health.backdrop and not nameplate.Health.backdrop.border then
            BORDER:CreateBorder(nameplate.Health.backdrop, 3)
        end
    end

    if nameplate.Castbar then
        if nameplate.Castbar.backdrop and not nameplate.Castbar.backdrop.border then
            BORDER:CreateBorder(nameplate.Castbar.backdrop)
        end

        if nameplate.Castbar.Icon and not nameplate.Castbar.Icon.border then
            BORDER:CreateBorder(nameplate.Castbar.Icon)
        end
    end

    if nameplate.Power then
        if nameplate.Power.backdrop and not nameplate.Power.backdrop.border then
            BORDER:CreateBorder(nameplate.Power.backdrop, 3)
        end
    end

end

S:SecureHook(NP, "StylePlate", "ElvUI_Nameplates_StylePlate") -- Bordering all the elements for nameplate. 

function S:ElvUI_Nameplates_Construct_AuraIcon(_, button)
    if not E.db.ProjectHopes.skins.nameplates then
        return
    end

	if not button then return end
	if button and not button.border then
        BORDER:CreateBorder(button, 3)
        BORDER:BindBorderColorWithBorder(button.border, button)
	end
end

S:SecureHook(NP, 'Construct_AuraIcon', "ElvUI_Nameplates_Construct_AuraIcon") -- Buffs and Debuffs.

function S:ElvUI_Nameplates_Health_UpdateColor(nameplate, unit)
    if not E.db.ProjectHopes.skins.nameplates then return end
    if not nameplate or not nameplate.Health then return end

    local element = nameplate.Health
    local child = element.ClipFrame and select(1, element.ClipFrame:GetChildren())
    if not child then return end

    if not element.glowLine then
        local glow = element:CreateTexture(nil, "OVERLAY")
        glow:SetTexture(Private.Glowline)
        glow:SetBlendMode("BLEND")
        glow:SetVertexColor(1, 1, 1, 1)
        element.glowLine = glow
    end

    element.glowLine:ClearAllPoints()
    element.glowLine:SetPoint("LEFT", child, "LEFT", -5, 0)
    element.glowLine:SetSize(6, element.ClipFrame:GetHeight())

    local cur = element.cur or 0
    local max = element.max or 1
    local hpPercent = (cur / max) * 100

    if hpPercent == 0 or hpPercent == 100 then
        element.glowLine:Hide()
    else
        element.glowLine:Show()
    end
end

S:SecureHook(NP, "Health_UpdateColor", "ElvUI_Nameplates_Health_UpdateColor") -- Glowline for healthbar. 

function S:ElvUI_Nameplates_Power_PostUpdate(element, unit, cur, min, max)
    if not E.db.ProjectHopes.skins.nameplates then return end

    if not element.glowLine then
        local glow = element:CreateTexture(nil, "OVERLAY")
        glow:SetTexture(Private.Glowline)
        glow:SetBlendMode("BLEND")
        glow:SetVertexColor(1, 1, 1, 1)
        element.glowLine = glow
    end

    element.glowLine:ClearAllPoints()
    element.glowLine:SetPoint("LEFT", element:GetStatusBarTexture(), "RIGHT", -5, 0)
    element.glowLine:SetSize(6, element.ClipFrame and element.ClipFrame:GetHeight() or element:GetHeight())

    local ppPercent = ((cur or 0) / (max or 1)) * 100
    if ppPercent == 0 or ppPercent == 100 then
        element.glowLine:Hide()
    else
        element.glowLine:Show()
    end
end

S:SecureHook(NP, "Power_PostUpdate", "ElvUI_Nameplates_Power_PostUpdate") -- Glowline for Powerbar. 

function S:ElvUI_Nameplates_StyleFilterBorderLock(_, backdrop, r, g, b, a)
    if not E.db.ProjectHopes.skins.nameplates then return end

    if not backdrop.border then return end
	if r then
        backdrop.border:SetBackdrop(Private.BorderLight)
        BORDER:BindBorderColorWithBorder(backdrop.border, backdrop)
	else
        backdrop.border:SetBackdrop(Private.Border)
		backdrop.border:SetBackdropColor(1, 1, 1, 1)
	end
end

S:SecureHook(NP, "StyleFilterBorderLock", "ElvUI_Nameplates_StyleFilterBorderLock") -- Border color for target. 



function S:ElvUI_Nameplates_Update_Castbar(_, nameplate)
    if not E.db.ProjectHopes.skins.nameplates then return end

    local element = nameplate.Castbar
    local child = element and select(1, element:GetChildren())

    if not element.glowLine then
        local glow = element:CreateTexture(nil, "OVERLAY")
        glow:SetTexture(Private.Glowline)
        glow:SetBlendMode("BLEND")
        glow:SetVertexColor(1, 1, 1, 1)
        element.glowLine = glow
    end

    element.glowLine:ClearAllPoints()
    element.glowLine:SetPoint("LEFT", element:GetStatusBarTexture(), "RIGHT", -5, 0)
    element.glowLine:SetSize(6, element:GetHeight())
end

S:SecureHook(NP, "Update_Castbar", "ElvUI_Nameplates_Update_Castbar") -- Glowline for Castbar. 

