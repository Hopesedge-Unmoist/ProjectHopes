local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc

function S:Blizzard_CovenantPreviewUI()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.covenantPreview) then return end
    if not E.db.ProjectHopes.skins.covenantPreview then return end

	local CovenantPreviewFrame = _G.CovenantPreviewFrame
            
	hooksecurefunc(CovenantPreviewFrame, 'TryShow', function(covenantInfo)
		if covenantInfo and not CovenantPreviewFrame.IsBorder then
			BORDER:CreateBorder(CovenantPreviewFrame)
			BORDER:CreateBorder(CovenantPreviewFrame.InfoPanel)

			BORDER:CreateBorder(CovenantPreviewFrame.SelectButton, nil, nil, nil, nil, nil, false, true)

			CovenantPreviewFrame.IsBorder = true
		end
	end)
			
	BORDER:CreateBorder(_G.TransmogAndMountDressupFrame.ShowMountCheckButton, nil, nil, nil, nil, nil, true, true)
end

S:AddCallbackForAddon('Blizzard_CovenantPreviewUI')
