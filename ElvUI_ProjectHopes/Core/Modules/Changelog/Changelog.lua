
--[[
	**********************************************************************************************************
	*** 																																																   ***
	***  Disclaimer: Based on Repooc's Changelog code, just modified it to my liking and added my border.  ***
	*** 																																																   ***
	**********************************************************************************************************
]]

local Name, Private = ...
local E = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local Changelog = E:NewModule('ProjectHopes_Changelog', 'AceEvent-3.0', 'AceTimer-3.0')
local format, gsub, find = string.format, string.gsub, string.find

local function ModifiedLine(string)
	return string
end

local changelogLines = {}
local function GetNumLines()
   local index = 1
   for i = 1, #ProjectHopes.ChangelogTBL do
		local line = ModifiedLine(ProjectHopes.ChangelogTBL[i])
		changelogLines[index] = line

		index = index + 1
   end
   return index - 1
end

function Changelog:CountDown()
	Changelog.time = Changelog.time - 1

	if Changelog.time == 0 then
		Changelog:CancelAllTimers()
		ProjectHopes_Changelog.close:Enable()
		ProjectHopes_Changelog.close:SetText(CLOSE)
		ProjectHopes_Changelog.confirm:Enable()
		ProjectHopes_Changelog.confirm:SetText("Apply Changes")
	else
		ProjectHopes_Changelog.close:Disable()
		ProjectHopes_Changelog.close:SetText(CLOSE..format(' (%s)', Changelog.time))
		ProjectHopes_Changelog.confirm:Disable()
		ProjectHopes_Changelog.confirm:SetText("Apply Changes"..format(' (%s)', Changelog.time))
	end
end

function Changelog:CreateChangelog()
	local Size = 500
	local frame = CreateFrame('Frame', 'ProjectHopes_Changelog', E.UIParent)
	tinsert(_G.UISpecialFrames, 'ProjectHopes_Changelog')
	BORDER:CreateBorder(frame)
	frame:SetTemplate('Transparent')
	frame:Size(Size, Size)
	frame:Point('CENTER', 0, 0)
	frame:Hide()
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:SetResizable(true)
	frame:SetResizeBounds(350, 100)
	frame:SetScript('OnMouseDown', function(changelog, button)
		if button == 'LeftButton' and not changelog.isMoving then
			changelog:StartMoving()
			changelog.isMoving = true
		end
	end)
	frame:SetScript('OnMouseUp', function(changelog, button)
		if button == 'LeftButton' and changelog.isMoving then
			changelog:StopMovingOrSizing()
			changelog.isMoving = false
		end
	end)

	frame:SetFrameStrata('DIALOG')

	local header = CreateFrame('Frame', 'ProjectHopes_ChangelogHeader', frame, 'BackdropTemplate')
	header:Point('TOPLEFT', frame, 0, 0)
	header:Point('TOPRIGHT', frame, 0, 0)
	header:Point('TOP')
	header:SetHeight(25)
	header:SetTemplate('Transparent')
	header:SetBackdrop(nil)
	header.text = header:CreateFontString(nil, 'OVERLAY')
	header.text:FontTemplate(nil, 15, 'OUTLINE')
	header.text:SetHeight(header.text:GetStringHeight()+30)
	header.text:SetText(format('%s - Changelog |cff99ff33%s|r', Private.Name, ProjectHopes.versionString))
	header.text:SetTextColor(1, 0.8, 0)
	header.text:Point('CENTER', header, 0, -1)

	local footer = CreateFrame('Frame', 'ProjectHopes_ChangelogFooter', frame)
	footer:Point('BOTTOMLEFT', frame, 0, 0)
	footer:Point('BOTTOMRIGHT', frame, 0, 0)
	footer:Point('BOTTOM')
	footer:SetHeight(30)
	footer:SetTemplate('Transparent')
	footer:SetBackdrop(nil)

	local close = CreateFrame('Button', nil, footer, 'UIPanelButtonTemplate, BackdropTemplate')
	close:SetPoint('RIGHT', footer, 'RIGHT', -5, 0)
	close:SetText(CLOSE)
	close:Size(80, 20)
	close:SetScript('OnClick', function()
		_G.ProjectHopesDB['Version'] = ProjectHopes.versionString
		frame:Hide()
	end)
	S:HandleButton(close)
	BORDER:CreateBorder(close, nil, nil, nil, nil, nil, nil, true)
	close:SetBackdrop(nil)
	close:Disable()
	frame.close = close

	local confirm = CreateFrame('Button', nil, footer, 'UIPanelButtonTemplate, BackdropTemplate')
	confirm:SetPoint('LEFT', footer, 'LEFT', 5, 0)
	confirm:SetText(CONFIRM)
	confirm:Size(120, 20)
	confirm:SetScript('OnClick', function()
		_G.ProjectHopesDB['Version'] = ProjectHopes.versionString
		ProjectHopes:LoadNewSettings()
		frame:Hide()
	end)
	S:HandleButton(confirm)
	BORDER:CreateBorder(confirm, nil, nil, nil, nil, nil, nil, true)
	confirm:SetBackdrop(nil)
	confirm:Disable()
	frame.confirm = confirm

	local scrollArea = CreateFrame('ScrollFrame', 'ProjectHopes_ChangelogScrollFrame', frame, 'UIPanelScrollFrameTemplate')
	scrollArea:Point('TOPLEFT', header, 'BOTTOMLEFT', 8, -3)
	scrollArea:Point('BOTTOMRIGHT', footer, 'TOPRIGHT', -25, 3)

	local scrollBar = _G.ProjectHopes_ChangelogScrollFrameScrollBar
	S:HandleScrollBar(scrollBar, nil, nil, 'Transparent')
	scrollBar:SetAlpha(0)
	scrollArea:HookScript('OnVerticalScroll', function(scroll, offset)
		_G.ProjectHopes_ChangelogFrameEditBox:SetHitRectInsets(0, 0, offset, (_G.ProjectHopes_ChangelogFrameEditBox:GetHeight() - offset - scroll:GetHeight()))
	end)

	local editBox = CreateFrame('EditBox', 'ProjectHopes_ChangelogFrameEditBox', frame)
	editBox:SetMultiLine(true)
	editBox:SetMaxLetters(99999)
	editBox:EnableMouse(true)
	editBox:SetAutoFocus(false)
	editBox:SetFontObject('ChatFontNormal')
	editBox:SetTextColor(1, 0.8, 0)
	editBox:Width(scrollArea:GetWidth())
	editBox:Height(scrollArea:GetHeight())
	scrollArea:SetScrollChild(editBox)
end

function Changelog:ToggleChangeLog()
	local lineCt = GetNumLines(frame)
	local text = table.concat(changelogLines, ' \n', 1, lineCt)
	_G.ProjectHopes_ChangelogFrameEditBox:SetText(text)

	PlaySound(888)

	local fadeInfo = {}
	fadeInfo.mode = 'IN'
	fadeInfo.timeToFade = 0.5
	fadeInfo.startAlpha = 0
	fadeInfo.endAlpha = 1
	ProjectHopes_Changelog:Show()
	E:UIFrameFade(ProjectHopes_Changelog, fadeInfo)

	Changelog.time = 6
	Changelog:CancelAllTimers()
	Changelog:CountDown()
	Changelog:ScheduleRepeatingTimer('CountDown', 1)
end

function Changelog:CheckVersion()
	if E.version < Private.RequiredElvUI then
		E:StaticPopup_Show('ProjectHopes_VC')
		Private:Print(format('|cffbf0008%s|r', L["Your ElvUI is outdated - please update and reload."]))
	end

	if not InCombatLockdown() then
		if not ProjectHopesDB['Version'] or (ProjectHopesDB['Version'] and ProjectHopesDB['Version'] ~= ProjectHopes.versionString) then
			Changelog:ToggleChangeLog()
		end
	else
			Changelog:RegisterEvent('PLAYER_REGEN_ENABLED', function(event)
				Changelog:CheckVersion()
				Changelog:UnregisterEvent(event)
		end)
	end
end

function Changelog:Initialize()
	if not ProjectHopes_Changelog then
		Changelog:CreateChangelog()
	end
	Changelog:RegisterEvent('PLAYER_REGEN_DISABLED', function()
		if ProjectHopes_Changelog and not ProjectHopes_Changelog:IsVisible() then return end
		Changelog:RegisterEvent('PLAYER_REGEN_ENABLED', function(event) ProjectHopes_Changelog:Show() Changelog:UnregisterEvent(event) end)
		ProjectHopes_Changelog:Hide()
	end)
	E:Delay(6, function() Changelog:CheckVersion() end)
end

E:RegisterModule(Changelog:GetName())
