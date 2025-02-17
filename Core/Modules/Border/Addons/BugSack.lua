local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local pairs = pairs

function S:BugSack()
	if not E.db.ProjectHopes.skins.bugsack then return end

	hooksecurefunc(BugSack, "OpenSack", function()
		if BugSackFrame.IsBorder then return end
		S:HandleFrame(BugSackFrame)
		BORDER:CreateBorder(BugSackFrame)

		S:HandleTab(BugSackTabAll)
		BORDER:CreateBorder(BugSackTabAll, nil, nil, nil, nil, nil, true, true)
		BugSackTabAll:SetPoint("TOPLEFT", BugSackFrame, "BOTTOMLEFT", -3, -5)
		S:HandleTab(BugSackTabSession)
		S:HandleTab(BugSackTabLast)
		S:HandleButton(BugSackNextButton)
		S:HandleButton(BugSackSendButton)
		S:HandleButton(BugSackPrevButton)
		S:HandleScrollBar(BugSackScrollScrollBar)

		if _G.BugSackNextButton and _G.BugSackPrevButton and _G.BugSackSendButton then
			local width, height = _G.BugSackSendButton:GetSize()
			_G.BugSackSendButton:SetSize(width - 8, height)
			_G.BugSackSendButton:ClearAllPoints()
			_G.BugSackSendButton:SetPoint("LEFT", _G.BugSackPrevButton, "RIGHT", 4, 0)
			_G.BugSackSendButton:SetPoint("RIGHT", _G.BugSackNextButton, "LEFT", -4, 0)
		end

		BORDER:CreateBorder(BugSackTabSession, nil, nil, nil, nil, nil, true, true)
		BORDER:CreateBorder(BugSackTabLast, nil, nil, nil, nil, nil, true, true)
		BORDER:CreateBorder(BugSackNextButton, nil, nil, nil, nil, nil, false, true)
		BORDER:CreateBorder(BugSackSendButton, nil, nil, nil, nil, nil, false, true)
		BORDER:CreateBorder(BugSackPrevButton, nil, nil, nil, nil, nil, false, true)
		BORDER:CreateBorder(BugSackScrollScrollBarThumbTexture)

		--S:HandleScrollBar(BugSackScrollScrollBar)
		for _, child in pairs({BugSackFrame:GetChildren()}) do
			if (child:IsObjectType('Button') and child:GetScript('OnClick') == BugSack.CloseSack) then
				S:HandleCloseButton(child)
				break
			end
		end
		BugSackFrame.IsBorder = true
	end)
end

S:AddCallbackForAddon("BugSack")
