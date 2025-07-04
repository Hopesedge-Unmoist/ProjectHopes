local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local NP = E:GetModule('NamePlates')

function S:ElvUI_Nameplates_StylePlate(_, nameplate)
    if not E.db.ProjectHopes.skins.nameplates then
        return
    end

    if not nameplate.Health then return end
    if nameplate.Health.backdrop and not nameplate.Health.backdrop.border then
        BORDER:CreateBorder(nameplate.Health.backdrop, 3)

        -- Create an event frame once
        if not nameplate._targetEventFrame then
            nameplate._targetEventFrame = CreateFrame("Frame")
            nameplate._targetEventFrame.nameplate = nameplate

            nameplate._targetEventFrame:RegisterEvent("UNIT_TARGET")
            nameplate._targetEventFrame:RegisterEvent("PLAYER_TARGET_CHANGED") -- also needed for accurate updates

            nameplate._targetEventFrame:SetScript("OnEvent", function(self, event, unit)
                local np = self.nameplate
                if not np or not np.unit or not np.Health or not np.Health.backdrop or not np.Health.backdrop.border then return end

                -- Check if this nameplate is the target
                if UnitIsUnit("target", np.unit) then
                    BORDER:BindBorderColorWithBorder(np.Health.backdrop.border, np.Health.backdrop)
                else
                    np.Health.backdrop.border:SetBackdrop(Private.Border)
                end
            end)
        end
    end


    if nameplate.Castbar.backdrop and not nameplate.Castbar.backdrop.border then
        BORDER:CreateBorder(nameplate.Castbar.backdrop)
    end

    if nameplate.Castbar.Icon and not nameplate.Castbar.Icon.border then
        BORDER:CreateBorder(nameplate.Castbar.Icon)
    end
end

S:SecureHook(NP, "StylePlate", "ElvUI_Nameplates_StylePlate") -- Health Bar.

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

function S:ElvUI_Nameplates_Update_Health(_, nameplate, skipUpdate)
    if not E.db.ProjectHopes.skins.nameplates then
        return
    end

    if not nameplate.Health.glowLine then
        nameplate.Health.glowLine = nameplate.Health:CreateTexture(nil, "OVERLAY")
        nameplate.Health.glowLine:SetTexture(Private.Glowline);
        nameplate.Health.glowLine:SetBlendMode("BLEND")
        nameplate.Health.glowLine:SetVertexColor(1, 1, 1, 1)

    end

    local child = select(1, nameplate.Health.ClipFrame:GetChildren())
    nameplate.Health.glowLine:SetPoint("LEFT", child, "LEFT", -5, 0)
        
    nameplate.Health.glowLine:SetSize(6, nameplate.Health.ClipFrame:GetHeight())

end

S:SecureHook(NP, 'Update_Health', "ElvUI_Nameplates_Update_Health") -- Buffs and Debuffs.
