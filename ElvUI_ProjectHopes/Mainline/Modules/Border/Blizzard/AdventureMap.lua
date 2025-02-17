local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local pairs = pairs
local hooksecurefunc = hooksecurefunc

local function SkinRewards()
    local pool = _G.AdventureMapQuestChoiceDialog.rewardPool
    local objects = pool and pool.activeObjects
    if not objects then return end

    for reward in pairs(objects) do
        if not reward.IsBorder then
            BORDER:CreateBorder(reward)
            BORDER:CreateBorder(reward.Icon)
            reward.IsBorder = true
        end
    end
end

function S:Blizzard_AdventureMap()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.adventureMap) then return end
    if not E.db.ProjectHopes.skins.adventureMap then return end

    local AdventureMapQuestChoiceDialog = _G.AdventureMapQuestChoiceDialog
    BORDER:CreateBorder(AdventureMapQuestChoiceDialog)
    -- Rewards
    hooksecurefunc(AdventureMapQuestChoiceDialog, 'RefreshRewards', SkinRewards)

    --Buttons
    BORDER:CreateBorder(AdventureMapQuestChoiceDialog.AcceptButton, nil, nil, nil, nil, nil, false, true)
    BORDER:CreateBorder(AdventureMapQuestChoiceDialog.DeclineButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallbackForAddon('Blizzard_AdventureMap')
