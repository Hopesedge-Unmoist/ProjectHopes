local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local unpack = unpack
local hooksecurefunc = hooksecurefunc

local GetInboxHeaderInfo = GetInboxHeaderInfo
local GetInboxItemLink = GetInboxItemLink
local GetInboxNumItems = GetInboxNumItems
local GetSendMailItem = GetSendMailItem

local GetItemQualityByID = C_Item.GetItemQualityByID
local GetItemQualityColor = C_Item.GetItemQualityColor

local function MailFrameSkin()
	for i = 1, _G.ATTACHMENTS_MAX_SEND do
		local button = _G['SendMailAttachment'..i]
		BORDER:CreateBorder(button)        


		local name = GetSendMailItem(i)
		if name then
			local quality = GetItemQualityByID(name)
			if quality and quality > 1 then
				local r, g, b = GetItemQualityColor(quality)
				button.border:SetBackdrop(Private.BorderLight)
				button.border:SetBackdropBorderColor(r, g, b)
			end
		end
	end
end

function S:MailFrame()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.mail) then return end
	if not E.db.ProjectHopes.skins.mail then return end

	-- Mail Frame / Inbox Frame
	local MailFrame = _G.MailFrame
	BORDER:CreateBorder(MailFrame.backdrop)

	for i = 1, _G.INBOXITEMS_TO_DISPLAY do
		local mail = _G['MailItem'..i]
		local button = _G['MailItem'..i..'Button']
		local icon = _G['MailItem'..i..'ButtonIcon']
		
		mail.backdrop:Hide()
		BORDER:CreateBorder(button)
	end

	hooksecurefunc('InboxFrame_Update', function()
		local numItems = GetInboxNumItems()
		local index = ((_G.InboxFrame.pageNum - 1) * _G.INBOXITEMS_TO_DISPLAY) + 1

		for i = 1, _G.INBOXITEMS_TO_DISPLAY do
			local mail = _G['MailItem'..i]
			local button = _G['MailItem'..i..'Button']
			
			if index <= numItems then
				local packageIcon, _, _, _, _, _, _, _, _, _, _, _, isGM = GetInboxHeaderInfo(index)
				if packageIcon and not isGM then
					local itemlink = GetInboxItemLink(index, 1)
					if itemlink then
						local quality = GetItemQualityByID(itemlink)
						if quality and quality > 1 then
							local r, g, b = GetItemQualityColor(quality)
							button.border:SetBackdrop(Private.BorderLight)
							button.border:SetBackdropBorderColor(r, g, b)
						else
							button.border:SetBackdropBorderColor(1, 1, 1)
						end
					end
				elseif isGM then
					button.border:SetBackdrop(Private.BorderLight)
					button.border:SetBackdropBorderColor(0, 0.56, 0.94)
				end
			end

			index = index + 1
		end
	end)

	BORDER:CreateBorder(_G.OpenAllMail, nil, nil, nil, nil, nil, false, true)

	_G.OpenAllMail:Point('CENTER', _G.InboxFrame, 'BOTTOM', -20, 104)

	for i = 1, 2 do
		local tab = _G['MailFrameTab'..i]
		BORDER:CreateBorder(tab, nil, nil, nil, nil, nil, true, true)
	end

	-- Reposition Tabs
	_G.MailFrameTab1:Point('TOPLEFT', _G.MailFrame, 'BOTTOMLEFT', -15, -5)
	_G.MailFrameTab2:Point('TOPLEFT', _G.MailFrameTab1, 'TOPRIGHT', -14, 0)

	-- Send Mail Frame

	_G.SendMailTitleText:Point('CENTER', _G.SendMailFrame, 'TOP', -10, -17)

	hooksecurefunc('SendMailFrame_Update', MailFrameSkin)

	BORDER:CreateBorder(_G.MailEditBoxScrollBar, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(_G.SendMailNameEditBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(_G.SendMailSubjectEditBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(_G.SendMailMoneyGold, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(_G.SendMailMoneySilver, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(_G.SendMailMoneyCopper, nil, nil, nil, nil, nil, true, false)

	BORDER:CreateBorder(_G.SendMailMailButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.SendMailCancelButton, nil, nil, nil, nil, nil, false, true)

	-- Reposition send mail button
	S:HandleButton(_G.SendMailMailButton)
	_G.SendMailMailButton:Point('RIGHT', _G.SendMailCancelButton, 'LEFT', -4, 0)
	
	-- Open Mail Frame
	local OpenMailFrame = _G.OpenMailFrame
	BORDER:CreateBorder(OpenMailFrame.backdrop)
	BORDER:CreateBorder(_G.OpenMailScrollFrame)

	for i = 1, _G.ATTACHMENTS_MAX_RECEIVE do
		local button = _G['OpenMailAttachmentButton'..i]
		BORDER:CreateBorder(button)
	end

	hooksecurefunc('OpenMailFrame_UpdateButtonPositions', function()
		for i = 1, _G.ATTACHMENTS_MAX_RECEIVE do
			local itemLink = GetInboxItemLink(_G.InboxFrame.openMailID, i)
			local button = _G['OpenMailAttachmentButton'..i]
			BORDER:CreateBorder(button)

			if itemLink then
				local quality = GetItemQualityByID(itemLink)
				if quality and quality > 1 then
					local r, g, b = GetItemQualityColor(quality)
					button.border:SetBackdrop(Private.BorderLight)
					button.border:SetBackdropBorderColor(r, g, b)
				end
			end
		end
	end)

	BORDER:CreateBorder(_G.OpenMailReportSpamButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.OpenMailReplyButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.OpenMailDeleteButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.OpenMailCancelButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.OpenMailScrollFrameScrollBar, nil, nil, nil, nil, nil, true, true)

	-- Repositions
	S:HandleButton(_G.OpenMailReplyButton)
	_G.OpenMailReplyButton:Point('RIGHT', _G.OpenMailDeleteButton, 'LEFT', -4, 0)

	S:HandleButton(_G.OpenMailDeleteButton)
	_G.OpenMailDeleteButton:Point('RIGHT', _G.OpenMailCancelButton, 'LEFT', -4, 0)

end

S:AddCallback('MailFrame')
