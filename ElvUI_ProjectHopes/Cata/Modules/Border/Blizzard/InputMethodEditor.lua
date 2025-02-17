local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local NUM_CHAT_WINDOWS = NUM_CHAT_WINDOWS

function S:InputMethodEditor()
	if not E.db.ProjectHopes.skins.inputMethodEditor then return end

	for i = 1, NUM_CHAT_WINDOWS do
		local editBox = _G["ChatFrame" .. i .. "EditBox"]
		local langIcon = _G["ChatFrame" .. i .. "EditBoxLanguage"]

		if editBox then
			BORDER:CreateBorder(editBox)
			if langIcon then
				langIcon:StripTextures()
				langIcon:CreateBackdrop("Transparent")
				langIcon:Size(20, 22)
				langIcon:ClearAllPoints()
				langIcon:Point("TOPLEFT", editBox, "TOPRIGHT", 7, 0)
				BORDER:CreateBorder(langIcon)
			end
		end
	end

	if E.db.chat.panelBackdrop == "LEFT" then
		BORDER:CreateBorder(_G.LeftChatPanel)
	end


	local IMECandidatesFrame = _G.IMECandidatesFrame
	if not IMECandidatesFrame then
		return
	end

	IMECandidatesFrame:StripTextures()
	IMECandidatesFrame:SetTemplate()
	BORDER:CreateBorder(IMECandidatesFrame)

	for i = 1, 10 do
		local cf = IMECandidatesFrame["c" .. i]
		if cf then
			cf.candidate:Width(1000)
		end
	end
end

S:AddCallback("InputMethodEditor")
