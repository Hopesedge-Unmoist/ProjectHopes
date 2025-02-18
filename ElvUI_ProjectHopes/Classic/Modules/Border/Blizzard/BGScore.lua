local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

function S:SkinWorldStateScore()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.bgscore) then return end
	if not E.db.ProjectHopes.skins.bgscore then return end

	local WorldStateScoreFrame = _G.WorldStateScoreFrame
	BORDER:CreateBorder(WorldStateScoreFrame.backdrop)

	BORDER:CreateBorder(_G.WorldStateScoreScrollFrameScrollBar, nil, nil, nil, nil, nil, false, true)

	for i = 1, 3 do
		BORDER:CreateBorder(G['WorldStateScoreFrameTab'..i], nil, nil, nil, nil, nil, true, true)

	end

	-- Reposition Tabs
	_G.WorldStateScoreFrameTab1:ClearAllPoints()
	_G.WorldStateScoreFrameTab1:Point('TOPLEFT', _G.WorldStateScoreFrame, 'BOTTOMLEFT', -10, 25)
	_G.WorldStateScoreFrameTab2:Point('TOPLEFT', _G.WorldStateScoreFrameTab1, 'TOPRIGHT', -14, 0)
	_G.WorldStateScoreFrameTab3:Point('TOPLEFT', _G.WorldStateScoreFrameTab2, 'TOPRIGHT', -14, 0)

	BORDER:CreateBorder(_G.WorldStateScoreFrameLeaveButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallback('SkinWorldStateScore')
