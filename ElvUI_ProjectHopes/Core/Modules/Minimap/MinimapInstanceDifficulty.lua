local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

local ID = E:NewModule("InstanceDifficulty", "AceEvent-3.0", "AceHook-3.0")
local M = E:GetModule("Minimap")
local EP = LibStub("LibElvUIPlugin-1.0")
local LSM = E.Libs.LSM

local format = format
local select = select
local IsInInstance = IsInInstance
local GetInstanceInfo = GetInstanceInfo
local C_ChallengeMode_GetActiveKeystoneInfo = C_ChallengeMode.GetActiveKeystoneInfo

function ID:CreateDifficultyFrame()
    difficultyFrame = CreateFrame("Frame", "InstanceDifficultyFrame", MinimapCluster)
    difficultyFrame:SetSize(50, 20)
    difficultyFrame:SetPoint("CENTER", UIParent, "CENTER", 0, -5)

    difficultyText = difficultyFrame:CreateFontString(nil, "OVERLAY")
    difficultyText:SetPoint("CENTER", difficultyFrame, "CENTER")

    E:CreateMover(difficultyFrame, "PHInstanceDifficultyFrameMover", L["Instance Difficulty"], nil, nil, nil, "ALL,PROJECTHOPES", function() return E.db.ProjectHopes.minimapid.difficulty.enable end, "ProjectHopes,maps")
end

function ID:UpdateDifficultyText(font, outline, size, align)
    if not difficultyText then return end

    difficultyText:SetFont(LSM:Fetch("font", font), size or 20, outline)

    -- Align text
    difficultyText:ClearAllPoints()
    if align == "LEFT" then
        difficultyText:SetJustifyH("LEFT")
        difficultyText:SetPoint("LEFT", difficultyFrame, "LEFT", 0, 0)
    elseif align == "CENTER" then
        difficultyText:SetJustifyH("CENTER")
        difficultyText:SetPoint("CENTER", difficultyFrame, "CENTER", 0, 0)
    elseif align == "RIGHT" then
        difficultyText:SetJustifyH("RIGHT")
        difficultyText:SetPoint("RIGHT", difficultyFrame, "RIGHT", 0, 0)
    end
end


-- Function to get formatted difficulty string
local function GetDifficultyText()
    local inInstance, instanceType = IsInInstance()
    if not inInstance then return "" end

    local difficulty = select(3, GetInstanceInfo())
    local numplayers = select(9, GetInstanceInfo())
    local mplusdiff = select(1, C_ChallengeMode_GetActiveKeystoneInfo()) or ""

    local norm = format("|cff1eff00%s|r", "N")
    local hero = format("|cff0070dd%s|r", "H")
    local lfr = format("|cffff8000%s|r", "LFR")
    local myth = format("|cffa335ee%s|r", "M")
    local mplus = format("|cffff3860%s|r", "M")

    if instanceType == "party" or instanceType == "raid" or instanceType == "scenario" then
        if difficulty == 1 then return "5" .. norm
        elseif difficulty == 2 then return "5" .. hero
        elseif difficulty == 3 then return "10" .. norm
        elseif difficulty == 4 then return "10" .. norm
        elseif difficulty == 5 then return "10" .. hero
        elseif difficulty == 6 then return "25" .. hero
        elseif difficulty == 8 then return mplus .. "+" .. mplusdiff
        elseif difficulty == 14 then return numplayers .. norm
        elseif difficulty == 15 then return numplayers .. hero
        elseif difficulty == 16 then return numplayers .. myth
        elseif difficulty == 17 then return numplayers .. lfr
        elseif difficulty == 23 then return numplayers .. myth
        end
    else
        return ("")
    end
end

function ID:UpdateDifficulty()
    local text = GetDifficultyText()
    difficultyText:SetText(text)
end

function ID:OnDifficultyFrameSetShown(frame, shown)
    if E.db.ProjectHopes.minimapid.hideBlizzard and shown then
        frame:Hide()
    end
end

function ID:HookDifficultyFrames()
    local difficulty = MinimapCluster.InstanceDifficulty
    local frames = {
        difficulty.Default,
        difficulty.Instance,
        difficulty.Guild,
        difficulty.ChallengeMode
    }

    for _, frame in pairs(frames) do
        if frame and not self:IsHooked(frame, "SetShown") then
            self:SecureHook(frame, "SetShown", "OnDifficultyFrameSetShown")
            if E.db.ProjectHopes.minimapid.hideBlizzard then
                frame:Hide()
            else
                frame:Show()
            end
        end
    end
end


function ID:Initialize()
    if not E.Retail then return end
    if not E.db.ProjectHopes or not E.db.ProjectHopes.minimapid.enable then return end


    self:CreateDifficultyFrame()
    self:UpdateDifficultyText(E.db.ProjectHopes.minimapid.font.name, E.db.ProjectHopes.minimapid.font.style, E.db.ProjectHopes.minimapid.font.size, E.db.ProjectHopes.minimapid.align)

    self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "UpdateDifficulty")
    self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateDifficulty")
    self:RegisterEvent("CHALLENGE_MODE_START", "UpdateDifficulty")
    self:RegisterEvent("CHALLENGE_MODE_COMPLETED", "UpdateDifficulty")
    self:RegisterEvent("CHALLENGE_MODE_RESET", "UpdateDifficulty")
    self:RegisterEvent("PLAYER_DIFFICULTY_CHANGED", "UpdateDifficulty")
    self:RegisterEvent("GROUP_ROSTER_UPDATE", "UpdateDifficulty")
    self:RegisterEvent("GUILD_PARTY_STATE_UPDATED", "UpdateDifficulty")

    self:UpdateDifficulty()
    self:HookDifficultyFrames()
end

E:RegisterModule(ID:GetName())