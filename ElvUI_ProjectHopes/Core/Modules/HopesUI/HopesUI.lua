local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local WMF = E:NewModule('WeakauraMainFrame', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0');

local C_UnitAuras = C_UnitAuras
local C_UIWidgetManager = C_UIWidgetManager
local pairs = pairs
local ipairs = ipairs
local C_PlayerInfo = C_PlayerInfo
local BASE_MOVEMENT_SPEED = BASE_MOVEMENT_SPEED

local UIParent = UIParent
local CreateFrame = CreateFrame
local CreateTexture = CreateTexture
local CreateFontString = CreateFontString
local SetGradient = SetGradient

local IsMounted = IsMounted
local UnitAffectingCombat = UnitAffectingCombat
local UnitClass = UnitClass
local GetShapeshiftFormID = GetShapeshiftFormID
local GetSpecialization = GetSpecialization
local UnitPowerMax = UnitPowerMax
local UnitPower = UnitPower
local GetRuneCooldown = GetRuneCooldown
if E.Retail then
    local heroSpecID = C_ClassTalents.GetActiveHeroTalentSpec()
    local configID = C_ClassTalents.GetActiveConfigID()
end

-- Main border frame
local function MainBorder()
    local HopesUIMainFrame = CreateFrame("Frame", "HopesUIMainFrame", UIParent, "BackdropTemplate")
    HopesUIMainFrame:SetBackdrop(Private.Border)
    HopesUIMainFrame:SetFrameStrata("LOW")
    HopesUIMainFrame:SetFrameLevel(30)
    HopesUIMainFrame:SetSize(470, 38)
    HopesUIMainFrame:SetScale(E.db.ProjectHopes.weakauramainframe.scaleSlider)
    HopesUIMainFrame:SetPoint("CENTER", HopesUIAnchor, 0, 0)
end

-- Separator for the Main border frame. 
local function Separator()
    local Separator = CreateFrame("Frame", "HopesUISeparatorFrame", HopesUIMainFrame, "BackdropTemplate")
    Separator:SetBackdrop(Private.Separator)
    Separator:SetFrameLevel(HopesUIMainFrame:GetFrameLevel() - 1)
    Separator:SetSize(100, 18)
    Separator:SetPoint("LEFT", HopesUIMainFrame, 9, -12)
    Separator:SetPoint("RIGHT", HopesUIMainFrame, -9, 0)

    HopesUIMainFrame.Separator = Separator
end

-- Background for the Main border frame. 
local function Background()
    local Background = CreateFrame("Frame", nil, HopesUIMainFrame, "BackdropTemplate")
    Background:SetBackdrop(Private.BackgroundTexture)
    Background:SetFrameStrata("BACKGROUND")
    Background:SetPoint("TOPLEFT", HopesUIMainFrame, 7, -7)
    Background:SetPoint("BOTTOMRIGHT", HopesUIMainFrame, -7, 7)
    Background:SetBackdropColor(0.125, 0.125, 0.125, 1)
    --Background:SetBackdropColor(1, 1, 1, 1) -- Used for debugging. 

    HopesUIMainFrame.Background = Background
end

-- Circle for the Main border frame.
local function Circle()
    local Circle = CreateFrame("Frame", "HopesUIMainFrame", HopesUIMainFrame)
    Circle:SetSize(65, 65)
    Circle:SetPoint("CENTER", HopesUIMainFrame, 0, 0)
    Circle:SetFrameStrata("MEDIUM")
    Circle:SetFrameLevel(20)
    --Circle:SetScale(E.db.ProjectHopes.weakauramainframe.scaleSlider)

    local texture = Circle:CreateTexture("HopesUICircleMainTexture", "BACKGROUND")
    texture:SetTexture(Private.Circle)
    texture:SetAllPoints(true)

    HopesUIMainFrame.Circle = Circle
end

-- Class Circle Icon for the Circle frame.
local function CircleClass()
    local CircleClass = CreateFrame("Frame", "HopesUIClass", UIParent)
    CircleClass:SetSize(65, 65)
    CircleClass:SetPoint("CENTER", HopesUIMainFrame, 0, 0)
    CircleClass:SetFrameStrata("LOW")
    CircleClass:SetFrameLevel(31)
    CircleClass:SetScale(HopesUIMainFrame:GetScale())
    local _, classID = UnitClass("player")
    local classIconTexture = CircleClass:CreateTexture(nil, "BACKGROUND")
    classIconTexture:SetAllPoints(true)
    if not E.db.ProjectHopes.weakauramainframe.HeroTalent then
        classIconTexture:SetTexture(Private.ClassIcon[classID])
    end

    CircleClass.classIconTexture = classIconTexture
    HopesUIMainFrame.CircleClass = CircleClass
end

-- Using this event to change to Hero Talent if enabled. 
function WMF:SPELLS_CHANGED()
    if E.db.ProjectHopes.weakauramainframe.HeroTalent then 
        local configID = C_ClassTalents.GetActiveConfigID()
        local heroSpecID = C_ClassTalents.GetActiveHeroTalentSpec()
    
        if configID and heroSpecID then
            local subTreeInfo = C_Traits.GetSubTreeInfo(configID, heroSpecID)
            if subTreeInfo then
                local iconElementID = subTreeInfo.iconElementID
                if iconElementID then
                    HopesUIMainFrame.CircleClass.classIconTexture:SetAtlas(iconElementID)
                    HopesUIMainFrame.CircleClass:SetSize(50, 50)
                end
            end
        else
            local _, classID = UnitClass("player")
            HopesUIMainFrame.CircleClass.classIconTexture:SetTexture(Private.ClassIcon[classID])
        end
    end
end

-- Bottom bar for the Main border frame. 
local function Bottombar()
    Bottombar = CreateFrame("Frame", nil, HopesUIMainFrame)
    Bottombar:SetSize(HopesUIMainFrame:GetWidth() - 18, 4)
    Bottombar:SetPoint("CENTER", HopesUIMainFrame, "CENTER", 0, -8)
    Bottombar:SetFrameLevel(HopesUIMainFrame:GetFrameLevel() - 3)

    -- Bottombar Background
    Bottombar.bg = Bottombar:CreateTexture(nil, "BACKGROUND")
    Bottombar.bg:SetAllPoints(true)
    Bottombar.bg:SetTexture(Private.HopesUI)
    Bottombar.bg:SetGradient("VERTICAL", CreateColor(unpack(E.media.rgbvaluecolor)), CreateColor(1, 1, 0, 1))


    -- Bottom bar coloring events. 
    local function UpdateBottombarColor()
        if UnitAffectingCombat("player") then
            -- Player is in combat
            Bottombar.bg:SetGradient("VERTICAL", CreateColor(0.4705882352941176, 0.203921568627451, 0.2313725490196078, 1), CreateColor(0.6705882352941176, 0.1803921568627451, 0.2274509803921569, 1))
        elseif IsMounted() then
            -- Player is mounted
            Bottombar.bg:SetGradient("VERTICAL", CreateColor(0.207843137254902, 0.4980392156862745, 0.5529411764705882, 1), CreateColor(0.203921568627451, 0.7647058823529412, 0.8705882352941176, 1))
        else
            -- Default color
            Bottombar.bg:SetGradient("VERTICAL", CreateColor(unpack(E.media.rgbvaluecolor)), CreateColor(1, 1, 0, 1))
        end
    end

    -- Event registration and handling
    local events = {
        "PLAYER_REGEN_DISABLED",
        "PLAYER_REGEN_ENABLED",
        "PLAYER_MOUNT_DISPLAY_CHANGED",
    }

    for _, event in ipairs(events) do
        Bottombar:RegisterEvent(event)
    end

    Bottombar:SetScript("OnEvent", function(self, event, ...)
        UpdateBottombarColor()
    end)

    -- Initial color update
    UpdateBottombarColor()

    HopesUIMainFrame.Bottombar = Bottombar
end

-- Class bar for the Main border frame.
local function Classbar()
    -- Start of Classbar
    local Classbar = CreateFrame("Frame", "PHClassBar", _G.HopesUIMainFrame)
    if not E.db.ProjectHopes.weakauramainframe.Bottombar then
        Classbar:SetSize(203, 20)
        Classbar:SetPoint("LEFT", _G.HopesUIMainFrame, "LEFT", 8, 0)
    else 
        Classbar:SetSize(203, 16)
        Classbar:SetPoint("LEFT", _G.HopesUIMainFrame, "LEFT", 8, 3)
    end
    Classbar:SetFrameLevel(_G.HopesUIMainFrame:GetFrameLevel() - 3)

    -- Classbar StatusBar
    Classbar.classBar = CreateFrame("StatusBar", nil, Classbar)
    Classbar.classBar:SetMinMaxValues(0, 1)
    Classbar.classBar:SetValue(0)
    Classbar.classBar:SetAllPoints(true)
    Classbar.classBar:SetStatusBarTexture(Private.HopesUI)
    Classbar.classBar:SetReverseFill(true) -- Set the bar to fill from right to left

    -- Power percent Text
    Classbar.percentTextFrame = CreateFrame("Frame", nil, Classbar)
    Classbar.percentTextFrame:SetSize(16, 37)
    Classbar.percentTextFrame:SetFrameLevel(Classbar:GetFrameLevel() + 4)

    local classBarfontSize = E.private.ProjectHopes.weakauramainframe.classBarFont.size or 18

    Classbar.percentText = Classbar.percentTextFrame:CreateFontString(nil, "OVERLAY")
    Classbar.percentText:SetFont(E.media.normFont, classBarfontSize, E.db.general.fontStyle)
    Classbar.percentText:SetPoint("CENTER", Classbar.classBar, "TOP", 0, 0)

    -- Glow Line
    Classbar.glowLine = Classbar.classBar:CreateTexture(nil, "OVERLAY")
    Classbar.glowLine:SetAtlas("!CalloutGlow-NineSlice-EdgeLeft")
    if not E.db.ProjectHopes.weakauramainframe.Bottombar then
        Classbar.glowLine:SetSize(10, Classbar:GetHeight())
    else 
        Classbar.glowLine:SetSize(10, 16)
    end

    Classbar.glowLine:SetPoint("CENTER", Classbar.classBar, "LEFT", 5, 5) -- Adjusted to the left side
    Classbar.glowLine:SetBlendMode("ADD")
    Classbar.glowLine:SetTexCoord(1, 0, 0, 1)
    Classbar.glowLine:Hide()

    local function GetClassPowerType()
        local _, playerClass = UnitClass("player")
        
        if playerClass == "ROGUE" then
            return Enum.PowerType.ComboPoints
        elseif playerClass == "DRUID" then
            local index = GetShapeshiftFormID()
    
            if index == 1 then -- cat
                return Enum.PowerType.ComboPoints
            elseif index == 5 then -- bear
                return Enum.PowerType.Rage
            else
                return Enum.PowerType.LunarPower
            end
        elseif playerClass == "MONK" then
            local spec = GetSpecialization()
            if spec == 3 then -- Windwalker
                return Enum.PowerType.Chi
            else
                return nil
            end
        elseif playerClass == "WARRIOR" then
            return Enum.PowerType.Rage
        elseif playerClass == "PALADIN" then
            return Enum.PowerType.HolyPower
        elseif playerClass == "WARLOCK" then
            return Enum.PowerType.SoulShards
        elseif playerClass == "DEATHKNIGHT" then
            return Enum.PowerType.Runes
        elseif playerClass == "MAGE" then
            return Enum.PowerType.ArcaneCharges
        elseif playerClass == "EVOKER" then
            return Enum.PowerType.Essence
        elseif playerClass == "SHAMAN" then
            return Enum.PowerType.Maelstrom
        elseif playerClass == "PRIEST" then
            return Enum.PowerType.Insanity
        else
            return nil
        end
    end
        
    -- Function to update the class bar color based on specialization
    local function UpdateClassBarColor(statusBar, classResource, powerType)
        local _, playerClass = UnitClass("player")
        if E.Retail then
            local spec = GetSpecialization()
        end
        
        if powerType == Enum.PowerType.HolyPower then
            if classResource <= 2 then
                color = {0.6235294342041, 0.59607845544815, 0.59607845544815, 1}
            elseif classResource == 3 or classResource == 4 then
                color = {1, 0.78823536634445, 0.027450982481241, 1}
            elseif classResource == 5 then
                color = {0.67058825492859, 0.1803921610117, 0.22745099663734, 1}
            end
        elseif powerType == Enum.PowerType.Essence then
            local colors = {
                [1] = {0.1019607843137255, 0.9215686274509804, 1, 1},
                [2] = {0.1686274509803922, 0.9411764705882353, 0.8392156862745098, 1},
                [3] = {0.2392156862745098, 0.9607843137254902, 0.6901960784313725, 1},
                [4] = {0.3098039215686275, 0.9803921568627451, 0.5294117647058824, 1},
                [5] = {0.3411764705882353, 0.9882352941176471, 0.4509803921568627, 1},
                [6] = {0.3803921568627451, 1, 0.3803921568627451, 1},
            }
            statusBar:SetStatusBarColor(unpack(colors[classResource]))
        elseif powerType == Enum.PowerType.Chi then
            local colors = {
                [1] = {0.7098039215686275, 0.7607843137254902, 0.3215686274509804, 1},
                [2] = {0.5803921568627451, 0.7294117647058824, 0.3607843137254902, 1},
                [3] = {0.4901960784313725, 0.7098039215686275, 0.3882352941176471, 1},
                [4] = {0.3882352941176471, 0.6901960784313725, 0.4196078431372549, 1},
                [5] = {0.2705882352941176, 0.6588235294117647, 0.4588235294117647, 1},
                [6] = {0.1411764705882353, 0.6313725490196078, 0.5019607843137255, 1},
            }
            statusBar:SetStatusBarColor(unpack(colors[classResource]))
        elseif powerType == Enum.PowerType.ComboPoints then
            local colors = {
                [1] = {0.7490196078431373, 0.3098039215686275, 0.3098039215686275, 1},
                [2] = {0.7803921568627451, 0.5607843137254902, 0.3098039215686275, 1},
                [3] = {0.8117647058823529, 0.8117647058823529, 0.3098039215686275, 1},
                [4] = {0.5607843137254902, 0.7803921568627451, 0.3098039215686275, 1},
                [5] = {0.4313725490196078, 0.7607843137254902, 0.3098039215686275, 1},
                [6] = {0.3098039215686275, 0.7490196078431373, 0.3098039215686275, 1},
                [7] = {0.3607843137254902, 0.8117647058823529, 0.5411764705882353, 1},
            }
            statusBar:SetStatusBarColor(unpack(colors[classResource]))
        elseif powerType == Enum.PowerType.ArcaneCharges then
            statusBar:SetStatusBarColor(0, 0.6196078431372549, 1, 1)
        elseif powerType == Enum.PowerType.SoulShards then
            statusBar:SetStatusBarColor(0.5803921568627451, 0.5098039215686275, 0.7882352941176471, 1)
        elseif powerType == Enum.PowerType.Runes and E.Retail then
            if spec == 1 then -- Blood
                statusBar:SetStatusBarColor(1, 0.2509803921568627, 0.2509803921568627, 1)
            elseif spec == 2 then -- Frost
                statusBar:SetStatusBarColor(0.2509803921568627, 1, 1, 1)
            elseif spec == 3 then -- Unholy
                statusBar:SetStatusBarColor(0.2509803921568627, 1, 0.2509803921568627, 1)
            end
        elseif powerType == Enum.PowerType.Maelstrom then
            Classbar.classBar:SetStatusBarColor(0, 0.4901960784313725, 1, 1)
        elseif powerType == Enum.PowerType.LunarPower then
            Classbar.classBar:SetStatusBarColor(0.3019607843137255, 0.5215686274509804, 0.9019607843137255)
        elseif powerType == Enum.PowerType.Insanity then
            Classbar.classBar:SetStatusBarColor(0.4, 0, 0.8)
        elseif powerType == Enum.PowerType.Rage then
            Classbar.classBar:SetStatusBarColor(0.9019607843137255, 0.2, 0.3019607843137255)
        else
            statusBar:SetStatusBarColor(1, 0, 1)
        end
    end
    
    local function UpdateClassBar()
        local powerType = GetClassPowerType()
        if not powerType then return end
    
        local _, playerClass = UnitClass("player")
        local maxClassResource = UnitPowerMax("player", powerType)
        local classResource = UnitPower("player", powerType)
        if E.Retail then
            local spec = GetSpecialization()
        end

        -- Hide all statusBars initially
        if Classbar.statusBars then
            for _, statusBar in ipairs(Classbar.statusBars) do
                statusBar:Hide()
            end
        end
    
        -- Reset visibility of Classbar.classBar
        Classbar.classBar:Hide()
        Classbar.percentText:Hide()
    
        -- Determine handling based on playerClass and powerType
        local useStatusBar = false
        local useClassBar = false
    
        if (playerClass == "PALADIN" and powerType == Enum.PowerType.HolyPower) or
           (playerClass == "ROGUE" and powerType == Enum.PowerType.ComboPoints) or
           (playerClass == "MONK" and powerType == Enum.PowerType.Chi) or
           (playerClass == "WARLOCK" and powerType == Enum.PowerType.SoulShards) or
           (playerClass == "DEATHKNIGHT" and powerType == Enum.PowerType.Runes) or
           (playerClass == "DRUID" and powerType == Enum.PowerType.ComboPoints) or
           (playerClass == "EVOKER" and powerType == Enum.PowerType.Essence) or
           (playerClass == "MAGE" and powerType == Enum.PowerType.ArcaneCharges) then
    
            useStatusBar = true
        elseif (playerClass == "SHAMAN" and powerType == Enum.PowerType.Maelstrom) or
               (playerClass == "PRIEST" and powerType == Enum.PowerType.Insanity and spec == 3) or
               (playerClass == "DRUID" and (powerType == Enum.PowerType.Rage or powerType == Enum.PowerType.LunarPower)) then
    
            useClassBar = true
        end
    
        -- Special handling for Druid's Rage and Lunar Power using Classbar.classBar
        if useClassBar then
            
            Classbar.classBar:SetMinMaxValues(0, maxClassResource)
            Classbar.classBar:SetValue(classResource)
            Classbar.classBar:Show()
    
            local powerPercent = math.floor((classResource / maxClassResource) * 100)
    
            if classResource == maxClassResource or classResource == 0 then
                Classbar.percentText:Hide()
                Classbar.glowLine:Hide()
            else
                Classbar.percentText:Show()
                Classbar.percentText:SetText(classResource)  -- Show current power value
                Classbar.glowLine:Show()
                local glowPosition = (1 - (classResource / maxClassResource)) * Classbar:GetWidth()
                Classbar.glowLine:SetPoint("CENTER", Classbar.classBar, "LEFT", glowPosition - 1.5, 0)
            end
    
            UpdateClassBarColor(Classbar.classBar, classResource, powerType)
        
        elseif useStatusBar then
            -- Handle using statusBars
            if not Classbar.statusBars then
                Classbar.statusBars = {}
            end
        
            if powerType == Enum.PowerType.Runes then
                classResource = 0
                for i = 1, maxClassResource do
                    local start, duration, runeReady = GetRuneCooldown(i)
                    if runeReady then
                        classResource = classResource + 1
                    end
                end
            end
        
            local color
            if powerType == Enum.PowerType.HolyPower then
                if classResource <= 2 then
                    color = {0.6235294342041, 0.59607845544815, 0.59607845544815, 1}
                elseif classResource == 3 or classResource == 4 then
                    color = {1, 0.78823536634445, 0.027450982481241, 1}
                elseif classResource == 5 then
                    color = {0.67058825492859, 0.1803921610117, 0.22745099663734, 1}
                end
            end
        
            for i = 1, maxClassResource do
                local statusBar = Classbar.statusBars[i]
            
                if not statusBar then
                    statusBar = CreateFrame("StatusBar", nil, Classbar)
                    statusBar:SetStatusBarTexture(Private.HopesUI)
                    statusBar:SetReverseFill(true) -- Left-to-right filling
                    statusBar:SetOrientation("HORIZONTAL")
            
                    -- Set minimum and maximum values for the bar
                    statusBar:SetMinMaxValues(0, 1)

                    if powerType == Enum.PowerType.Runes then
                        -- Attach an OnUpdate script for updating recharge progress
                        statusBar:SetScript("OnUpdate", function(self, elapsed)
                            local start, duration, runeReady = GetRuneCooldown(self.index)
                            if not runeReady and start and duration then
                                local remaining = duration - (GetTime() - start)
                                if remaining > 0 then
                                    self:SetValue((duration - remaining) / duration) -- Progress based on time elapsed
                                    -- Set the status bar color to grey while the rune is charging
                                    self:SetStatusBarColor(0.5, 0.5, 0.5) -- Gray color
                                else
                                    self:SetValue(1) -- Fully recharged
                                    -- Set the color back to its normal state once the rune is ready
                                    UpdateClassBarColor(self, self.index, powerType)
                                end
                            else
                                self:SetValue(1) -- Fully recharged
                                -- Set the color back to its normal state once the rune is ready
                                UpdateClassBarColor(self, self.index, powerType)
                            end
                        end)
                    end

                    table.insert(Classbar.statusBars, statusBar)
                end
            
                -- Assign the rune index to the status bar
                statusBar.index = i
            
                local width = (Classbar:GetWidth() - (maxClassResource - 0)) / maxClassResource + 1
                statusBar:SetSize(width, Classbar:GetHeight())
                statusBar:SetPoint("RIGHT", Classbar, "RIGHT", -((i - 1) * (width + 0)), 0)
            
                local resourceValue = (classResource >= i) and 1 or 0
                statusBar:SetMinMaxValues(0, 1)
                statusBar:SetValue(resourceValue)
            
                if powerType == Enum.PowerType.HolyPower then
                    statusBar:SetStatusBarColor(unpack(color))
                else
                    UpdateClassBarColor(statusBar, i, powerType)
                end
            
                statusBar:Show()
            end
        elseif playerClass == "WARRIOR" then
            -- Warriors use nil, nothing needs to be done.
            return
        end
    end

    -- Event registration and handling
    local events = {
        "UNIT_POWER_UPDATE",
        "PLAYER_ENTERING_WORLD",
        "RUNE_POWER_UPDATE",
        "UPDATE_SHAPESHIFT_FORM",
        "PLAYER_TALENT_UPDATE",
        "SPELLS_CHANGED",
    }

    for _, event in ipairs(events) do
        Classbar:RegisterEvent(event)
    end

    Classbar:SetScript("OnEvent", function(self, event, ...)
        UpdateClassBar()
    end)

    -- Initial update
    UpdateClassBar()
end

-- Power bar for the Main border frame.
local function Powerbar()
    -- Start of Powerbar
    local Powerbar = CreateFrame("Frame", "PHPowerbar", _G.HopesUIMainFrame)
    if not E.db.ProjectHopes.weakauramainframe.Bottombar then
        Powerbar:SetSize(203, 20)
        Powerbar:SetPoint("RIGHT", _G.HopesUIMainFrame, "RIGHT", -8, 0)
    else 
        Powerbar:SetSize(203, 16)
        Powerbar:SetPoint("RIGHT", _G.HopesUIMainFrame, "RIGHT", -8, 3)
    end
    Powerbar:SetFrameLevel(_G.HopesUIMainFrame:GetFrameLevel() - 3)

    -- Powerbar
    Powerbar.powerBar = CreateFrame("StatusBar", nil, Powerbar)
    Powerbar.powerBar:SetMinMaxValues(0, 1)
    Powerbar.powerBar:SetValue(0)
    Powerbar.powerBar:SetAllPoints(true)
    Powerbar.powerBar:SetStatusBarTexture(Private.HopesUI)

    -- Power percent Text
    Powerbar.percentTextFrame = CreateFrame("Frame", nil, Powerbar)
    Powerbar.percentTextFrame:SetSize(16, 37)
    Powerbar.percentTextFrame:SetFrameLevel(Powerbar:GetFrameLevel() + 4)

    local powerBarfontSize = E.private.ProjectHopes.weakauramainframe.powerBarFont.size or 18

    Powerbar.percentText = Powerbar.percentTextFrame:CreateFontString(nil, "OVERLAY")
    Powerbar.percentText:SetFont(E.media.normFont, powerBarfontSize, E.db.general.fontStyle)
    Powerbar.percentText:SetPoint("CENTER", Powerbar.powerBar, "TOP", 0, 0)

    -- Glow Line
    Powerbar.glowLine = Powerbar.powerBar:CreateTexture(nil, "OVERLAY")
    Powerbar.glowLine:SetAtlas("!CalloutGlow-NineSlice-EdgeLeft")
    Powerbar.glowLine:SetSize(10, Powerbar:GetHeight())
    Powerbar.glowLine:SetPoint("CENTER", Powerbar.powerBar, "LEFT", 5, 5)
    Powerbar.glowLine:SetBlendMode("ADD")

    local function UpdatePowerBar()
        local power, maxPower
        local powerType
        local index = GetShapeshiftFormID()
        
        -- Check if the player is in a vehicle
        if UnitHasVehicleUI("player") then
            powerType = UnitPowerType("vehicle")
            power = UnitPower("vehicle", powerType)
            maxPower = UnitPowerMax("vehicle", powerType)
            energycolor = {
                r =  E.db.unitframe.colors.power.ENERGY.r,
                g =  E.db.unitframe.colors.power.ENERGY.g,
                b =  E.db.unitframe.colors.power.ENERGY.b
            }
            Powerbar.powerBar:SetStatusBarColor(energycolor.r, energycolor.g, energycolor.b)

        else
            powerType = UnitPowerType("player") -- Get the player's current power type
            
            -- Check for shapeshift forms that change power types
            if (UnitClass("player") == "Shaman" and powerType == 11) or 
               (UnitClass("player") == "Priest" and powerType == 13) or
               (UnitClass("player") == "Druid" and powerType == 3 and index == 1) or
               (UnitClass("player") == "Druid" and powerType == 1) or
               (UnitClass("player") == "Druid" and powerType == 8) then
                powerType = 0 
            end
            
            -- Check if the player is a Druid and in Cat Form
            if UnitClass("player") == "Druid" then
                if index == 1 then -- Cat Form
                    powerType = 3 -- Energy
                else
                    powerType = 0 -- Mana
                end
            end
            
            -- Get the power and max power based on the possibly overridden power type
            power = UnitPower("player", powerType)
            maxPower = UnitPowerMax("player", powerType)
        end
        
        local powerPercent = math.floor((power / maxPower) * 100) -- Calculate the percentage of power
        
        Powerbar.powerBar:SetMinMaxValues(0, maxPower)
        Powerbar.powerBar:SetValue(power)
        
        -- Set the color based on power type
        if powerType == 0 then -- mana
            manacolor = {
                r =  E.db.unitframe.colors.power.MANA.r,
                g =  E.db.unitframe.colors.power.MANA.g,
                b =  E.db.unitframe.colors.power.MANA.b
            }
            Powerbar.powerBar:SetStatusBarColor(manacolor.r, manacolor.g, manacolor.b)
        elseif powerType == 1 then -- rage
            ragecolor = {
                r =  E.db.unitframe.colors.power.RAGE.r,
                g =  E.db.unitframe.colors.power.RAGE.g,
                b =  E.db.unitframe.colors.power.RAGE.b
            }
            Powerbar.powerBar:SetStatusBarColor(ragecolor.r, ragecolor.g, ragecolor.b)
        elseif powerType == 2 then -- focus
            focuscolor = {
                r =  E.db.unitframe.colors.power.FOCUS.r,
                g =  E.db.unitframe.colors.power.FOCUS.g,
                b =  E.db.unitframe.colors.power.FOCUS.b
            }
            Powerbar.powerBar:SetStatusBarColor(focuscolor.r, focuscolor.g, focuscolor.b)
        elseif powerType == 3 then -- energy
            energycolor = {
                r =  E.db.unitframe.colors.power.ENERGY.r,
                g =  E.db.unitframe.colors.power.ENERGY.g,
                b =  E.db.unitframe.colors.power.ENERGY.b
            }
            if UnitHasVehicleUI("player") then
                Powerbar.powerBar:SetStatusBarColor(energycolor.r, energycolor.g, energycolor.b)
            else
                Powerbar.powerBar:SetStatusBarColor(energycolor.r, energycolor.g, energycolor.b)
            end
        elseif powerType == 6 then -- runic power
            runiccolor = {
                r =  E.db.unitframe.colors.power.RUNIC_POWER.r,
                g =  E.db.unitframe.colors.power.RUNIC_POWER.g,
                b =  E.db.unitframe.colors.power.RUNIC_POWER.b
            }
            Powerbar.powerBar:SetStatusBarColor(runiccolor.r, runiccolor.g, runiccolor.b)
        elseif powerType == 17 then -- fury
            furycolor = {
                r =  E.db.unitframe.colors.power.FURY.r,
                g =  E.db.unitframe.colors.power.FURY.g,
                b =  E.db.unitframe.colors.power.FURY.b
            }
            Powerbar.powerBar:SetStatusBarColor(furycolor.r, furycolor.g, furycolor.b)
        elseif powerType == 18 then -- pain
            paincolor = {
                r =  E.db.unitframe.colors.power.PAIN.r,
                g =  E.db.unitframe.colors.power.PAIN.g,
                b =  E.db.unitframe.colors.power.PAIN.b
            }
            Powerbar.powerBar:SetStatusBarColor(paincolor.r, paincolor.g, paincolor.b)
        end
        
        -- Manage visibility of percent text and glow line
        if powerPercent == 100 or powerPercent == 0 then
            Powerbar.percentText:Hide() -- Hide the text if power is 100
            Powerbar.glowLine:Hide() -- Hide the glow line if power is 100
        else
            Powerbar.percentText:Show() -- Show the text if power is below 100
            if powerType == 1 or powerType == 17 then -- rage and fury
                Powerbar.percentText:SetText(power) -- Show current power for rage
            else
                Powerbar.percentText:SetText(powerPercent) -- Show percentage for other power types
            end
            Powerbar.glowLine:Show() -- Show the glow line if power is below 100
            local glowPosition = (power / maxPower) * Powerbar:GetWidth() -- Calculate the position of the glow line
            Powerbar.glowLine:SetPoint("CENTER", Powerbar.powerBar, "LEFT", glowPosition - 1.5, 0) -- Set the glow line position
        end
    end

    -- Event registration and handling
    local events = {
        "UNIT_POWER_UPDATE",
        "UNIT_ENTERING_VEHICLE",
        "UNIT_EXITING_VEHICLE",
    }

    for _, event in ipairs(events) do
        Powerbar:RegisterEvent(event)
    end

    Powerbar:SetScript("OnEvent", function(self, event, ...)
        UpdatePowerBar()
    end)

    -- Initial update
    UpdatePowerBar()
end

-- Cast bar for the Main border frame.
local function CastBar()
   -- Start of Castbar
   local CastBar = CreateFrame("Frame", nil, _G.HopesUIMainFrame)
   if not E.db.ProjectHopes.weakauramainframe.Bottombar then
       CastBar:SetSize(203, 20)
       CastBar:SetPoint("RIGHT", _G.HopesUIMainFrame, "RIGHT", -8, 0)
   else 
       CastBar:SetSize(203, 16)
       CastBar:SetPoint("RIGHT", _G.HopesUIMainFrame, "RIGHT", -8, 3)
   end
   CastBar:SetFrameLevel(_G.HopesUIMainFrame:GetFrameLevel() - 3)

   -- Background
   CastBar.bg = CastBar:CreateTexture(nil, "BACKGROUND")
   CastBar.bg:SetAllPoints(true)
   CastBar.bg:SetTexture("Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Statusbar\\blizzcastback.tga")

   -- Castbar
   CastBar.castBar = CreateFrame("StatusBar", nil, CastBar)
   CastBar.castBar:SetMinMaxValues(0, 1)
   CastBar.castBar:SetValue(0)
   CastBar.castBar:SetAllPoints(true)

   -- Create a table to hold stage status bars
   CastBar.stageBars = {}
   -- Create a table to hold references to dividers
   CastBar.dividers = {}

   -- Glow Line
   CastBar.glowLineFrame = CreateFrame("Frame", nil, CastBar)
   CastBar.glowLineFrame:SetSize(16, 37)
   CastBar.glowLineFrame:SetFrameLevel(CastBar:GetFrameLevel() + 4)
   CastBar.glowLine = CastBar.glowLineFrame:CreateTexture(nil, "OVERLAY")
   CastBar.glowLine:SetTexture(Private.CastbarGlow)
   if not E.db.ProjectHopes.weakauramainframe.Bottombar then
       CastBar.glowLine:SetSize(64, CastBar:GetHeight() + 51)
   else 
       CastBar.glowLine:SetSize(64, CastBar:GetHeight() + 41)
   end
   CastBar.glowLine:SetPoint("CENTER", CastBar.castBar, "LEFT")

   -- Cast Text
   CastBar.castText = CastBar.castBar:CreateFontString(nil, "OVERLAY")

   -- Get the user's font settings
   local castbarfontSize = E.private.ProjectHopes.weakauramainframe.castbarfont.size or 12

   CastBar.castText:SetFont(E.media.normFont, castbarfontSize, E.db.general.fontStyle)
   CastBar.castText:SetPoint("LEFT", CastBar.castBar, "LEFT", 4, -0.5)

   local function LimitTextLength(text, maxLength)
       if #text > maxLength then
           return string.sub(text, 1, maxLength)
       else
           return text
       end
   end
   
   -- Cast Time
   CastBar.castTime = CastBar.castBar:CreateFontString(nil, "OVERLAY")
   CastBar.castTime:SetFont(E.media.normFont, castbarfontSize, E.db.general.fontStyle)
   CastBar.castTime:SetPoint("RIGHT", CastBar.castBar, "RIGHT", -4, -0.5)

   -- Cast Icon
   CastBar.iconFrame = CreateFrame("Frame", nil, CastBar)
   CastBar.iconFrame:SetSize(65, 65)
   CastBar.iconFrame:SetPoint("CENTER", _G.HopesUIMainFrame, "CENTER", 0, 0)
   CastBar.iconFrame:SetFrameLevel(CastBar:GetFrameLevel() + 4)

   CastBar.icon = CastBar.iconFrame:CreateTexture(nil, "OVERLAY")
   CastBar.icon:SetAllPoints(true)
   CastBar.icon:SetMask("Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\CastIcon.tga")

   -- Event registration and handling
   local events

   if E.Retail then 
        events = {
            "UNIT_SPELLCAST_START",
            "UNIT_SPELLCAST_STOP",
            "UNIT_SPELLCAST_FAILED",
            "UNIT_SPELLCAST_INTERRUPTED",
            "UNIT_SPELLCAST_DELAYED",
            "UNIT_SPELLCAST_CHANNEL_START",
            "UNIT_SPELLCAST_CHANNEL_UPDATE",
            "UNIT_SPELLCAST_CHANNEL_STOP",
            "UNIT_SPELLCAST_EMPOWER_START",
            "UNIT_SPELLCAST_EMPOWER_UPDATE",
            "UNIT_SPELLCAST_EMPOWER_STOP",
        }
    else 
        events = {
            "UNIT_SPELLCAST_START",
            "UNIT_SPELLCAST_STOP",
            "UNIT_SPELLCAST_FAILED",
            "UNIT_SPELLCAST_INTERRUPTED",
            "UNIT_SPELLCAST_DELAYED",
            "UNIT_SPELLCAST_CHANNEL_START",
            "UNIT_SPELLCAST_CHANNEL_UPDATE",
            "UNIT_SPELLCAST_CHANNEL_STOP",
        }
    end

   for _, event in ipairs(events) do
       CastBar:RegisterEvent(event)
   end

   CastBar:SetScript("OnEvent", function(self, event, ...)
       if self[event] then
           self[event](self, ...)
       end
   end)

   local function resetCastBar(self)
       if _G.PHPowerbar then
           _G.PHPowerbar:Show()
       end
       if not UnitCastingInfo("player") and not UnitChannelInfo("player") then
            self.castBar:Hide()
            self.castText:Hide()
            self.glowLine:Hide()
            self.bg:Hide()

            self:SetScript("OnUpdate", nil)
            
            -- Reset texture and values
            self.castBar:SetStatusBarTexture("Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Statusbar\\blizzcastback.tga") -- Or a default texture
            self.castBar:SetValue(0) -- Reset the value
            self.castBar:SetStatusBarColor(1, 1, 1) -- Reset color
            
            self.castTime:SetText("")
            for _, stageBar in ipairs(self.stageBars) do
                stageBar:SetValue(0)
                stageBar:Hide()
            end
            
            -- Hide the dividers
            for _, divider in ipairs(self.dividers) do
                divider:Hide()
           end

            C_Timer.After(0.1, function()
                if not UnitCastingInfo("player") and not UnitChannelInfo("player") then
                    self.icon:Hide()
                end
            end)
           
       end
   end

   local function startCast(self, unit, name, icon, startTime, endTime, notInterruptible, isChannel)
       if unit == "player" then
           self.startTime = startTime / 1000
           self.endTime = endTime / 1000
           self.duration = self.endTime - self.startTime
           self.isChannel = isChannel
           self.castBar:SetMinMaxValues(0, self.duration)
           self.castBar:SetValue(isChannel and self.duration or 0)
           self.castText:SetText(LimitTextLength(name, 25))
           self.icon:SetTexture(icon)

           local texture
           if isChannel then
               texture = notInterruptible and "blizzcastnonbreakable.tga" or "blizzcastchannel.tga"
           else
               texture = notInterruptible and "blizzcastnonbreakable.tga" or "blizzcast.tga"
           end
           self.castBar:SetStatusBarTexture("Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Statusbar\\" .. texture)

           self.castBar:Show()
           self.castText:Show()
           self.icon:Show()
           self.glowLine:Show()
           self.bg:Show()

           self:SetScript("OnUpdate", self.OnUpdate)
       end
   end

   -- Event Handlers
   function CastBar:UNIT_SPELLCAST_START(unit)
       local name, _, icon, startTime, endTime, _, _, notInterruptible = UnitCastingInfo(unit)
       startCast(self, unit, name, icon, startTime, endTime, notInterruptible, false)
   end

   function CastBar:UNIT_SPELLCAST_STOP(unit) resetCastBar(self) end
   function CastBar:UNIT_SPELLCAST_FAILED(unit) resetCastBar(self) end
   function CastBar:UNIT_SPELLCAST_INTERRUPTED(unit) resetCastBar(self) end

   function CastBar:UNIT_SPELLCAST_DELAYED(unit)
       local name, _, icon, startTime, endTime, _, _, notInterruptible = UnitCastingInfo(unit)
       startCast(self, unit, name, icon, startTime, endTime, notInterruptible, false)
   end

   function CastBar:UNIT_SPELLCAST_CHANNEL_START(unit)
       local name, _, icon, startTime, endTime, _, notInterruptible = UnitChannelInfo(unit)
       startCast(self, unit, name, icon, startTime, endTime, notInterruptible, true)
   end

   function CastBar:UNIT_SPELLCAST_CHANNEL_UPDATE(unit)
       local name, _, icon, startTime, endTime, _, notInterruptible = UnitChannelInfo(unit)
       startCast(self, unit, name, icon, startTime, endTime, notInterruptible, true)
   end

   function CastBar:UNIT_SPELLCAST_CHANNEL_STOP(unit) resetCastBar(self) end

   local function createStageBars(self, numStages)
       -- Clear previous stage bars
       for _, stageBar in ipairs(self.stageBars) do
           stageBar:Hide()
       end
       wipe(self.stageBars)
       
       -- Create new stage bars with red lines in between
       local stageWidth = self:GetWidth() / numStages
       for i = 1, numStages do
           -- Create the stage bar
           local stageBar = CreateFrame("StatusBar", nil, self)
           stageBar:SetSize(stageWidth - 2, self:GetHeight())
           stageBar:SetPoint("LEFT", self, "LEFT", (i-1) * stageWidth + 1, 0)
           stageBar:SetMinMaxValues(0, 1)
           stageBar:SetValue(0)
           stageBar:Show()
           table.insert(self.stageBars, stageBar)
           
           -- Create the red line (divider) if it's not the last stage
           if i < numStages then
               local divider = self:CreateTexture(nil, "OVERLAY")
               divider:SetColorTexture(0.1254901960784314, 0.1254901960784314, 0.1254901960784314)  -- Red color
               divider:SetSize(2, self:GetHeight())
               divider:SetPoint("LEFT", self, "LEFT", i * stageWidth - 1, 0)
               table.insert(self.dividers, divider)  -- Store reference to the divider
           end
       end
   end
   
   -- Define colors for each stage
   local stageColors = {
       {r = 1, g = 0.2588235294117647, b = 0.3568627450980392},  -- Stage 1: Red
       {r = 1, g = 0.8, b = 0.2588235294117647},  -- Stage 2: Orange
       {r = 1, g = 1, b = 0.2588235294117647},  -- Stage 3: Yellow
       {r = 0.6588235294117647, g = 1, b = 0.4},  -- Stage 4: Green
       {r = 0, g = 0, b = 1},  -- Stage 5: Blue
   }

   function CastBar:UNIT_SPELLCAST_EMPOWER_START(unit)
       if unit == "player" then
           local name, _, icon, startTime, endTime, _, notInterruptible, _, _, numStages = UnitChannelInfo(unit)
           if name then
               local holdAtMaxTime = GetUnitEmpowerHoldAtMaxTime(unit) / 1000
               self.startTime = startTime / 1000
               self.endTime = (endTime / 1000) + holdAtMaxTime
               self.duration = self.endTime - self.startTime
               self.isEmpowered = numStages > 0
               self.numStages = numStages
               self.castText:SetText(LimitTextLength(name, 25))
               self.icon:SetTexture(icon)
   
               -- Update the texture for empowered cast
               local texture = notInterruptible and "blizzcastnonbreakable.tga" or "blizzcast.tga"
               self.castBar:SetStatusBarTexture("Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Statusbar\\" .. texture)
   
               createStageBars(self, numStages)
   
               for i, stageBar in ipairs(self.stageBars) do
                   stageBar:SetStatusBarTexture("Interface\\AddOns\\ElvUI_ProjectHopes\\Media\\Statusbar\\" .. texture)
                   stageBar:SetStatusBarColor(stageColors[i].r, stageColors[i].g, stageColors[i].b)
                   stageBar:SetValue(0)
                   stageBar:Show()
               end
   
               self.castBar:Show()
               self.castText:Show()
               self.icon:Show()
               self.glowLine:Show()
               self.bg:Show()
               self:SetScript("OnUpdate", self.OnUpdate)
           end
       end
   end

   function CastBar:UNIT_SPELLCAST_EMPOWER_STOP(unit)
       resetCastBar(self)
       self.isEmpowered = false
   end

   function CastBar:OnUpdate(elapsed)
       local currentTime = GetTime()
       local progress = currentTime - self.startTime
   
       if _G.PHPowerbar then
           _G.PHPowerbar:Hide()
       end
   
       if self.isEmpowered then
           local stageDuration = self.duration / self.numStages
           local currentStage = math.floor(progress / stageDuration) + 1
   
           for i, stageBar in ipairs(self.stageBars) do
               if i < currentStage then
                   stageBar:SetValue(1) -- Fully completed
               elseif i == currentStage then
                   stageBar:SetValue((progress % stageDuration) / stageDuration) -- Current stage progress
               else
                   stageBar:SetValue(0) -- Not started
               end
               stageBar:Show()
           end
   
           self.castTime:SetText(currentStage)
   
           -- Update glow line position for empowered stages
           local glowPosition = ((currentStage - 1) * stageDuration) + (progress % stageDuration)
           local width = self.castBar:GetWidth()
           local glowX = (glowPosition / self.duration) * width
           self.glowLine:SetPoint("CENTER", self.castBar, "LEFT", glowX, 0)
   
       else
           if progress < self.duration then
               if self.isChannel then
                   self.castBar:SetValue(self.duration - progress)
               else
                   self.castBar:SetValue(progress)
               end
               
               local remaining = self.duration - progress
               self.castTime:SetText(string.format("%.1f", remaining))
   
               local width = self.castBar:GetWidth()
               local position = (progress / self.duration) * width
               if self.isChannel then
                   position = width - position
               end
               self.glowLine:SetPoint("CENTER", self.castBar, "LEFT", position, 0)
           else
               resetCastBar(self)
           end
       end
   end

   resetCastBar(CastBar) 
end

-- Vigor bar for the Main border frame.
local function VigorBar()
    -- Start of vigorBar
    local vigorBar = CreateFrame("Frame", nil, _G.HopesUIMainFrame)
    vigorBar:SetSize(202, 16)
    if not E.db.ProjectHopes.weakauramainframe.Bottombar then
        vigorBar:SetSize(203, 20)
        vigorBar:SetPoint("LEFT", _G.HopesUIMainFrame, "LEFT", 8, 0)
    else 
        vigorBar:SetSize(203, 16)
        vigorBar:SetPoint("LEFT", _G.HopesUIMainFrame, "LEFT", 8, 3)
    end
    vigorBar:SetFrameLevel(_G.HopesUIMainFrame:GetFrameLevel() - 3)

    -- Speed percent Text
    vigorBar.speedTextFrame = CreateFrame("Frame", nil, vigorBar)
    vigorBar.speedTextFrame:SetSize(16, 37)
    vigorBar.speedTextFrame:SetFrameLevel(vigorBar:GetFrameLevel() + 4)

    -- Get the user's font settings
    local vigorBarfontSize = E.private.ProjectHopes.weakauramainframe.vigorBarFont.size or 18

    vigorBar.speedText = vigorBar.speedTextFrame:CreateFontString(nil, "OVERLAY")
    vigorBar.speedText:SetFont(E.media.normFont, vigorBarfontSize, E.db.general.fontStyle)
    vigorBar.speedText:SetPoint("CENTER", vigorBar, "TOP", 0, 0)

    -- Function to get widget info
    local function GetWidgetInfo()
        local widgetSetID = C_UIWidgetManager.GetPowerBarWidgetSetID()
        local widgets = C_UIWidgetManager.GetAllWidgetsBySetID(widgetSetID)

        local widgetInfo = nil
        for _, w in pairs(widgets) do
            local tempInfo = C_UIWidgetManager.GetFillUpFramesWidgetVisualizationInfo(w.widgetID)
            if tempInfo and tempInfo.shownState == 1 then
                widgetInfo = tempInfo
            end
        end

        return widgetInfo
    end

    -- Function to create vigor segments
    local function CreateVigorSegments(vigorBar)
        local segments = {}
        local widgetInfo = GetWidgetInfo()
        if not widgetInfo then return end

        local maxVigor = widgetInfo.numTotalFrames
        local segmentWidth = (vigorBar:GetWidth() / maxVigor)

        for i = 1, maxVigor do
            local segment = CreateFrame("StatusBar", nil, vigorBar)
            segment:SetSize(segmentWidth, vigorBar:GetHeight())
            segment:SetStatusBarTexture(Private.HopesUI)
            segment:GetStatusBarTexture():SetHorizTile(false)
            segment:SetMinMaxValues(0, 1)
            segment:SetValue(1)
            segment:Show()
            segment:SetReverseFill(true)

            if i == 1 then
                segment:SetPoint("RIGHT", vigorBar, "RIGHT", 0, 0)
            else
                segment:SetPoint("RIGHT", segments[i - 1], "LEFT", 0, 0)
            end

            table.insert(segments, segment)
        end

        vigorBar.segments = segments
    end

    -- Create the segments
    CreateVigorSegments(vigorBar)

    -- Function to update speed text
    local function UpdateSpeedText()
        if not vigorBar then return end
        local isGliding, _, forwardSpeed = C_PlayerInfo.GetGlidingInfo()
        local base = isGliding and forwardSpeed or GetUnitSpeed("player")
        local movespeed = math.floor(base / BASE_MOVEMENT_SPEED * 100 + 0.5)
    
        vigorBar.speedText:SetText(format("%d", movespeed))
        local thrillActive = C_UnitAuras.GetPlayerAuraBySpellID(377234)
        if thrillActive then
            local r, g, b = 0, 0.792156862745098, 1
            vigorBar.speedText:SetTextColor(r, g, b)
        else
            vigorBar.speedText:SetTextColor(1, 1, 1)
        end

        if movespeed == 0 then
            vigorBar.speedTextFrame:Hide()
        else
            vigorBar.speedTextFrame:Show()
        end
    end

    vigorBar:UnregisterAllEvents()
    vigorBar:RegisterEvent("UPDATE_UI_WIDGET")
    -- Event handler function
    vigorBar:SetScript("OnEvent", function(self, event, ...)
        if event == "UPDATE_UI_WIDGET" then
            local defaultVigorBar = _G["UIWidgetPowerBarContainerFrame"]
            if defaultVigorBar then defaultVigorBar:Hide() end

            local widgetInfo = GetWidgetInfo()
            if widgetInfo then
                if _G.PHClassBar then
                    _G.PHClassBar:Hide()
                end
                self:Show()
                local numFullFrames = widgetInfo.numFullFrames
                local fillValue = widgetInfo.fillValue

                -- Ensure segments are created or recreated if needed
                if not self.segments or #self.segments < widgetInfo.numTotalFrames then
                    -- Clear existing segments
                    if self.segments then
                        for _, segment in ipairs(self.segments) do
                            segment:Hide()
                            segment:SetParent(nil)
                        end
                    end
                    self.segments = {} -- Clear the table

                    -- Create new segments
                    CreateVigorSegments(self)
                end

                for i, segment in ipairs(self.segments) do
                    if i <= numFullFrames then
                        segment:SetValue(1)
                        segment:SetStatusBarColor(0.4470588235294118, 0.7803921568627451, 0.4156862745098039, 1)
                    elseif i == numFullFrames + 1 then
                        segment:SetValue(fillValue / 100)
                        if fillValue < 100 then
                            segment:SetStatusBarColor(1, 0.7882352941176471, 0.0274509803921569, 1)
                        else
                            segment:SetStatusBarColor(0.4470588235294118, 0.7803921568627451, 0.4156862745098039, 1)
                        end
                    else
                        segment:SetValue(0)
                        segment:SetStatusBarColor(1, 0.7882352941176471, 0.0274509803921569, 1)
                    end
                end

                -- Update speed text
                UpdateSpeedText()
            else
                if _G.PHClassBar then
                    _G.PHClassBar:Show()
                end
                self:Hide()
            end
        end
    end)
end

-- Combat Timer for the Main border frame.
local function CombatTimer()
    local combatTimer = CreateFrame("Frame")
    combatTimer.inCombat = false
    combatTimer.startTime = 0
    
    combatTimer:RegisterEvent("PLAYER_REGEN_DISABLED") -- Event for entering combat
    combatTimer:RegisterEvent("PLAYER_REGEN_ENABLED")  -- Event for leaving combat
    
    combatTimer:SetScript("OnEvent", function(self, event)
        if event == "PLAYER_REGEN_DISABLED" then
            self:StartCombat()
        elseif event == "PLAYER_REGEN_ENABLED" then
            self:EndCombat()
        end
    end)
    
    function combatTimer:StartCombat()
        if not self.inCombat then
            self.startTime = GetTime()
            self.inCombat = true
            self:ShowTimer()
            self.text:SetText("00:00")  -- Reset the timer text
            self.textFrame.timeSinceLastUpdate = 1  -- Force immediate update
        end
    end
    
    function combatTimer:EndCombat()
        if self.inCombat then
            local combatDuration = GetTime() - self.startTime
            self.inCombat = false
            self:HideTimer()
        end
    end
    
    function combatTimer:GetCombatDuration()
        if self.inCombat then
            return GetTime() - self.startTime
        end
        return 0
    end
    
    function combatTimer:ShowTimer()
        if not self.textFrame then
            self.textFrame = CreateFrame("Frame", nil, _G.HopesUIMainFrame.Circle)
            self.textFrame:SetSize(50, 50)
            self.textFrame:SetPoint("CENTER", _G.HopesUIMainFrame.Circle, "BOTTOM", 0, 11)
            self.textFrame:SetFrameLevel(_G.HopesUIMainFrame.Circle:GetFrameLevel() + 1)

            local combatTimerfontSize = E.private.ProjectHopes.weakauramainframe.combatTimerFont.size or 18

            self.text = self.textFrame:CreateFontString(nil, "OVERLAY")
            self.text:SetFont(E.media.normFont, combatTimerfontSize, E.db.general.fontStyle)
            self.text:SetTextColor(1, 0.7882352941176471, 0.0274509803921569, 1)
            self.text:SetPoint("CENTER", self.textFrame, "CENTER")
        end
        
        self.textFrame.updateInterval = 1  -- Update every second
        self.textFrame.timeSinceLastUpdate = 0
    
        self.textFrame:SetScript("OnUpdate", function(frame, elapsed)
            frame.timeSinceLastUpdate = frame.timeSinceLastUpdate + elapsed
            if frame.timeSinceLastUpdate >= frame.updateInterval then
                local duration = self:GetCombatDuration()
                local minutes = math.floor(duration / 60)
                local seconds = math.floor(duration % 60)
                self.text:SetText(string.format("%02d:%02d", minutes, seconds))
                frame.timeSinceLastUpdate = 0
            end
        end)
        self.textFrame:Show()
    end
    
    function combatTimer:HideTimer()
        if self.textFrame then
            self.textFrame:SetScript("OnUpdate", nil)
            self.textFrame:Hide()
        end
    end
end

-- Initilize
function WMF:Initialize()
    if not E.db.ProjectHopes.weakauramainframe.Frame then 
        return 
    end

    -- Mover for HopesUI
    HopesUIAnchor = CreateFrame("Frame", "HopesUIAnchor", E.UIParent, 'BackdropTemplate')
    HopesUIAnchor:Point('CENTER', UIParent, 'CENTER')
    HopesUIAnchor:Size(470, 38)
    HopesUIAnchor:SetFrameStrata("BACKGROUND")

    E:CreateMover(HopesUIAnchor, "HopesUIAnchorMover", L["HopesUIMover"], nil, nil, nil, "ALL")

    MainBorder()
    Separator()
    Background()
    Circle()
    CircleClass()

    if not E.db.ProjectHopes.weakauramainframe.Bottombar then
        HopesUIMainFrame.Separator:Hide()
    else 
        HopesUIMainFrame.Separator:Show()
        Bottombar()
    end

    if E.db.ProjectHopes.weakauramainframe.Classbar and E.Retail then 
        Classbar()
    end

    if E.db.ProjectHopes.weakauramainframe.PowerBar then 
        Powerbar()
    end

    if E.db.ProjectHopes.weakauramainframe.Castbar then 
        CastBar()
    end

    if E.db.ProjectHopes.weakauramainframe.vigorBar and E.Retail then 
        VigorBar()
    end

    if E.db.ProjectHopes.weakauramainframe.combatTimer then 
        CombatTimer()
    end

    if E.db.ProjectHopes.weakauramainframe.HeroTalent and E.Retail then 
        WMF:RegisterEvent("SPELLS_CHANGED")
    end
end

E:RegisterModule(WMF:GetName());
