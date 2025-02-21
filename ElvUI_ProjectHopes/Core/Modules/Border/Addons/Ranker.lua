local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local pairs = pairs

function S:Ranker()
	if not E.db.ProjectHopes.skins.ranker then return end
	
	E:Delay(1, function()
		--skin main frame & scrollbar
		S:HandleFrame(_G.RankerMainFrame)
		S:HandleScrollBar(_G.RankerMainFrameScrollBar)
		BORDER:CreateBorder(_G.RankerMainFrame)
		BORDER:CreateBorder(_G.RankerMainFrameScrollBarThumbTexture)
		--position main frame
		_G.RankerMainFrame:ClearAllPoints()
		RankerMainFrame:Point('TOPLEFT', _G.HonorFrame, 'TOPRIGHT', -26, -12)
		
		--skin outer buttons
		S:HandleButton(_G.RankerToggleButton, nil, nil, nil, true)
		BORDER:CreateBorder(_G.RankerToggleButton, nil, nil, nil, nil, nil, false, true)
		S:HandleButton(_G.RankerWhatIfButton, nil, nil, nil, true)
		BORDER:CreateBorder(_G.RankerWhatIfButton, nil, nil, nil, nil, nil, false, true)
		_G.RankerToggleButton:ClearAllPoints()
		_G.RankerToggleButton:Point('TOPRIGHT', _G.HonorFrame, 'TOPRIGHT', -32, 15)
		_G.RankerWhatIfButton:ClearAllPoints()
		_G.RankerWhatIfButton:Point('TOPRIGHT', _G.RankerMainFrame, 'TOPRIGHT', 0, 27)
		
		--skin main frame elements
		if _G.RankerWhatIfRankListButton then
			local width, height = _G.RankerWhatIfRankListButton:GetSize()
			_G.RankerWhatIfRankListButton:SetSize(width, height + 4)
		end
		BORDER:CreateBorder(_G.RankerLimit, nil, 11, 5, -10, 1)
		BORDER:CreateBorder(_G.RankerObjective, nil, 11, 5, -10, 1)
		BORDER:CreateBorder(_G.RankerLimitMaxRank, nil, 11, 5, -10, 1)
		BORDER:CreateBorder(_G.RankerObjectiveMaxRank, nil, 11, 5, -10, 1)
		BORDER:CreateBorder(_G.RankerWhatIfRankList, nil, 11, 3, -10, -1)
    end)
end

S:AddCallbackForAddon("Ranker")
