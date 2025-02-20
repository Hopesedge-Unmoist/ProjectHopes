local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local format = format
local pairs = pairs
local tinsert = tinsert
local tremove = tremove
local unpack = unpack
local MAX_OPTIONS = 500

function S:DBMSkin_StatusBarTimers()
	if not E.db.ProjectHopes.skins.dbm then return end
    if not _G.DBT then return end

    hooksecurefunc(_G.DBT, 'CreateBar', function(bars) --line 248
        for bar in bars:GetBarIterator() do --line 560, returns pairs(self.bars)
            if not bar.BORDER then
                hooksecurefunc(bar, "ApplyStyle", function() --line 927
                    local statusbar = _G[bar.frame:GetName()..'Bar']
                    local leftIcon = _G[bar.frame:GetName()..'BarIcon1']
                    local rightIcon = _G[bar.frame:GetName()..'BarIcon2']
                    local spark = _G[bar.frame:GetName().."BarSpark"]

                    bar.frame:SetTemplate("Transparent")
                    statusbar:SetOutside(bar.frame)
                    BORDER:CreateBorder(bar.frame)
                    
                    if _G.DBT_AllPersistentOptions.Default.DBM.IconRight then
                        if leftIcon.backdrop then
                            leftIcon.backdrop:Hide()
                            leftIcon.backdrop.border:Hide()
                        end

                        rightIcon:SetTexCoord(0.92, 0.08, 0.92, 0.08)
                        rightIcon:ClearAllPoints()
                        rightIcon:SetPoint("BOTTOMLEFT", bar.frame, "BOTTOMRIGHT", 7, 0)
                        rightIcon:CreateBackdrop()
                        BORDER:CreateBorder(rightIcon.backdrop)

                    elseif _G.DBT_AllPersistentOptions.Default.DBM.IconLeft then
                        if rightIcon.backdrop then
                            rightIcon.backdrop:Hide()
                            rightIcon.backdrop.border:Hide()
                        end

                        leftIcon:SetTexCoord(0.08,0.92,0.08,0.92)
                        leftIcon:ClearAllPoints()
                        leftIcon:SetPoint("BOTTOMRIGHT", bar.frame, "BOTTOMLEFT", -7, 0)
                        leftIcon:CreateBackdrop()
                        BORDER:CreateBorder(leftIcon.backdrop)
                    end
                    
                    bar.BORDER = true
                end)
                bar:ApplyStyle()
            end
        end
    end)
end

S:AddCallbackForAddon('DBM-StatusBarTimers', S.DBMSkin_StatusBarTimers)

local function HandleGUIOption(option)
    if option:GetObjectType() == "Button" then
        S:HandleButton(option)
        
        if option:GetHeight() == 30 then 
            option:SetHeight(20)
        elseif option:GetHeight() < 16 then
            option:SetHeight(16)
        end
        option:SetBackdrop()
        BORDER:CreateBorder(option, nil, -7, 7, 7, -7, false, true)
    elseif option:GetObjectType() == "EditBox" then
        S:HandleEditBox(option)
        BORDER:CreateBorder(option, nil, nil, nil, nil, nil, true)
    elseif option:GetObjectType() == "Slider" then
        S:HandleSliderFrame(option)
        BORDER:CreateBorder(option, nil, nil, nil, nil, nil, true, true)
    elseif option:GetObjectType() == "CheckButton" then
        S:HandleCheckBox(option)
        BORDER:CreateBorder(option, nil, nil, nil, nil, nil, true, true)
    end
end

local function HandleGUIDropDown(dropdown)
    local width = dropdown:GetWidth()
    S:HandleDropDownBox(dropdown, width, true)
    BORDER:CreateBorder(option, nil, nil, nil, nil, nil, true, true)

    if _G[dropdown:GetName().."Text"] then
        _G[dropdown:GetName().."Text"]:ClearAllPoints()
        _G[dropdown:GetName().."Text"]:SetPoint("CENTER", dropdown.backdrop, "CENTER", 0, 0)
    end
end

local function SkinGUI()
    for i = 1, MAX_OPTIONS do
        local option = _G["DBM_GUI_Option_"..i]
        if option and not option.BORDER then           
            HandleGUIOption(option)
            option.BORDER = true
        end

        local dropdown = _G["DBM_GUI_DropDown"..i]
        if dropdown and not dropdown.BORDER then
            HandleGUIDropDown(dropdown)
            dropdown.BORDER = true
        end
    end
end

function S:DBMSkin_Options()
    if not E.db.ProjectHopes.skins.dbm then return end
    if not _G.DBM_GUI then return end

    hooksecurefunc(_G.DBM_GUI, "ShowHide", function()
        local Options = _G.DBM_GUI_OptionsFrame
        S:HandleFrame(Options)
        BORDER:CreateBorder(Options)
        SkinGUI()

        S:HandleScrollBar(_G.DBM_GUI_OptionsFramePanelContainerFOVScrollBar)
        BORDER:CreateBorder(_G.DBM_GUI_OptionsFramePanelContainerFOVScrollBar)
        S:HandleButton(_G.DBM_GUI_OptionsFrameWebsiteButton)
        BORDER:CreateBorder(_G.DBM_GUI_OptionsFrameWebsiteButton, nil, nil, nil, nil, nil, false, true)
        S:HandleButton(_G.DBM_GUI_OptionsFrameOkay)
        BORDER:CreateBorder(_G.DBM_GUI_OptionsFrameOkay, nil, nil, nil, nil, nil, false, true)
    end)
end

S:AddCallbackForAddon('DBM-GUI', S.DBMSkin_Options)