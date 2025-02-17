local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next = next

function S:BattleNetFrames()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.misc) then return end
	if not E.db.ProjectHopes.skins.battleNet then return end

	local skins = {
		_G.BNToastFrame,
		_G.TimeAlertFrame,
		_G.TicketStatusFrameButton.NineSlice
	}

	for i = 1, #skins do
		BORDER:CreateBorder(skins[i])
	end

	local PlayerReportFrame = _G.PlayerReportFrame
	BORDER:CreateBorder(PlayerReportFrame.backdrop)

	BORDER:CreateBorder(PlayerReportFrame.Comment)

	BORDER:CreateBorder(PlayerReportFrame.ReportButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(PlayerReportFrame.CancelButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(_G.ReportCheatingDialog.backdrop)

	BORDER:CreateBorder(_G.ReportCheatingDialogReportButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.ReportCheatingDialogCancelButton, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(_G.ReportCheatingDialogCommentFrameEditBox)

	local BattleTagInviteFrame = _G.BattleTagInviteFrame
	BORDER:CreateBorder(BattleTagInviteFrame.backdrop)

	for _, child in next, { BattleTagInviteFrame:GetChildren() } do
		if child:IsObjectType('Button') then
			BORDER:CreateBorder(child, nil, nil, nil, nil, nil, false, true)
		end
	end
end

S:AddCallback('BattleNetFrames')
