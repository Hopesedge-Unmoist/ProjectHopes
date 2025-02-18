local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local _G = _G
local HideUIPanel = HideUIPanel
local ReloadUI = ReloadUI
local S = E:GetModule('Skins')

local GM = E:NewModule('BuildGameMenu', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0');

function GM:Initialize()
    --from elvui api, add button to game menu
    local ProjectHopesMenuButton = CreateFrame('Button', nil, GameMenuFrame, 'GameMenuButtonTemplate')
    local ProjectHopesGameMenu = CreateFrame("Frame")
    if E.Retail then
        local EM = E:GetModule('EditorMode')
        local Menubutton

        if not _G["ProjectHopesGameMenu"] then
            Menubutton = CreateFrame('Button', 'ProjectHopesGameMenu', GameMenuFrame, 'MainMenuFrameButtonTemplate')
            Menubutton:SetScript('OnClick', function()
                if InCombatLockdown() then return end
                E:ToggleOptions()
                E.Libs['AceConfigDialog']:SelectGroup('ElvUI', 'ProjectHopes')
                HideUIPanel(_G.GameMenuFrame)
            end)
            Menubutton:SetText("|TInterface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\phlogotiny.tga:0:0:0:0|t".. Private.Name)
            S:HandleButton(Menubutton, nil, nil, nil, true)

			Menubutton:Size(200, 36)

			GameMenuFrame.ProjectHopes = Menubutton
            GameMenuFrame.MenuButtons.ProjectHopes = Menubutton

            hooksecurefunc(_G.GameMenuFrame, 'Layout', function()
                GameMenuFrame.MenuButtons.ProjectHopes:SetPoint("CENTER", _G.GameMenuFrame, "TOP", 0, -30)
                for _, button in pairs(GameMenuFrame.MenuButtons) do
                    if button then
                        local point, anchor, point2, x, y = button:GetPoint()
                        button:SetPoint(point, anchor, point2, x, y - 15)
                    end
                end

                local EditModeButton = EM:GetGameMenuEditModeButton()
                if EditModeButton then
                    EditModeButton:RegisterForClicks("AnyUp")
                    EditModeButton:SetScript("OnClick", function(_, button)
                        if not InCombatLockdown() then
                            if button == "LeftButton" then
                                E:ToggleMoveMode()
                                HideUIPanel(_G["GameMenuFrame"])
                            else
                                ShowUIPanel(EditModeManagerFrame)
                            end
                        end
                    end)
                    EditModeButton:HookScript("OnEnter", function()
                        _G["GameTooltip"]:SetOwner(EditModeButton, 'ANCHOR_RIGHT')
                        _G["GameTooltip"]:AddDoubleLine(L["Left Click:"], L["Toggle ElvUI Anchors"], 1, 1, 1)
                        _G["GameTooltip"]:AddDoubleLine(L["Right Click:"], L["Toggle Edit Mode"], 1, 1, 1)
                        _G["GameTooltip"]:Show()
                    end)
                    EditModeButton:HookScript("OnLeave", function()
                        _G["GameTooltip"]:Hide()
                    end)
                end
            end)
        end
    end
end

E:RegisterModule(GM:GetName())
