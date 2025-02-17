local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G

function S:PetitionFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.petition) then return end
	if not E.db.ProjectHopes.skins.petition then return end

	local PetitionFrame = _G.PetitionFrame
	BORDER:CreateBorder(PetitionFrame)

	BORDER:CreateBorder(PetitionFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(_G.PetitionFrameSignButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.PetitionFrameRequestButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.PetitionFrameRenameButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.PetitionFrameCancelButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallback('PetitionFrame')
