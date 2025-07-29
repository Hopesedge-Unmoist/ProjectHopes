local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local unpack = unpack
local hooksecurefunc = hooksecurefunc

local function Skin_SendMail()
	for i = 1, _G.ATTACHMENTS_MAX_SEND do
		local btn = _G['SendMailAttachment'..i]
		if btn.template then
			BORDER:HandleIcon(btn, true)
		end
	end
end

local function Skin_OpenMail()
	for i = 1, _G.ATTACHMENTS_MAX_RECEIVE do
		local btn = _G['OpenMailAttachmentButton'..i]
		if btn.template then
			BORDER:HandleIcon(btn, true)
		end
	end
end

local function Skin_InboxItems()
	for i = 1, _G.INBOXITEMS_TO_DISPLAY do
		local item = _G['MailItem'..i]
		local btn = item.Button
		if btn.template then
			BORDER:HandleIcon(btn, true)
		end
	end
end

function S:MailFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.mail) then return end
	if not E.db.ProjectHopes.skins.mail then return end

	local MailFrame = _G.MailFrame
	BORDER:CreateBorder(MailFrame)

	for i = 1, 2 do
		local tab = _G['MailFrameTab'..i]
		BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)
	end

	-- Reposition Tabs
	_G.MailFrameTab1:ClearAllPoints()
	_G.MailFrameTab2:ClearAllPoints()
	_G.MailFrameTab1:Point('TOPLEFT', _G.MailFrame, 'BOTTOMLEFT', -10, -5)
	_G.MailFrameTab2:Point('TOPLEFT', _G.MailFrameTab1, 'TOPRIGHT', -15, 0)

	-- send mail

	BORDER:CreateBorder(_G.SendMailNameEditBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(_G.SendMailSubjectEditBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(_G.SendMailMoneyGold, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(_G.SendMailMoneySilver, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(_G.SendMailMoneyCopper, nil, nil, nil, nil, nil, true, false)

	Skin_SendMail()
	Skin_OpenMail()
	Skin_InboxItems()

	hooksecurefunc('SendMailFrame_Update', Skin_SendMail)
	hooksecurefunc('OpenMail_Update', Skin_OpenMail)
	hooksecurefunc('InboxFrame_Update', Skin_InboxItems)

	BORDER:CreateBorder(_G.SendMailMailButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.SendMailCancelButton, nil, nil, nil, nil, nil, false, true)

	-- open mail (cod)
	BORDER:CreateBorder(_G.OpenMailReportSpamButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.OpenMailReplyButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.OpenMailDeleteButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.OpenMailCancelButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.OpenAllMail, nil, nil, nil, nil, nil, false, true)


	_G.OpenMailReplyButton:Point('RIGHT', _G.OpenMailDeleteButton, 'LEFT', -5, 0)
	_G.OpenMailDeleteButton:Point('RIGHT', _G.OpenMailCancelButton, 'LEFT', -5, 0)
	_G.SendMailMailButton:Point('RIGHT', _G.SendMailCancelButton, 'LEFT', -5, 0)
end

S:AddCallback('MailFrame')
