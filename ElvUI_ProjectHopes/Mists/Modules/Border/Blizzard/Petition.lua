local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local ipairs = ipairs

function S:PetitionFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.petition) then return end
	if not E.db.ProjectHopes.skins.petition then return end

	local PetitionFrame = _G.PetitionFrame
	BORDER:CreateBorder(PetitionFrame)

	-- Buttons
	local buttons = {
		_G.PetitionFrameSignButton,
		_G.PetitionFrameRequestButton,
		_G.PetitionFrameRenameButton,
		_G.PetitionFrameCancelButton
	}

	for _, button in ipairs(buttons) do
		BORDER:CreateBorder(button, nil, nil, nil, nil, nil, false, true)
	end
end

S:AddCallback('PetitionFrame')
