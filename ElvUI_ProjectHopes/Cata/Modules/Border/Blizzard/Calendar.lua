local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local next, unpack = next, unpack

local CLASS_SORT_ORDER = CLASS_SORT_ORDER

function S:Blizzard_Calendar()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.calendar) then return end
	if not E.db.ProjectHopes.skins.calendar then return end

	local CalendarFrame = _G.CalendarFrame

	BORDER:CreateBorder(CalendarFrame)

	BORDER:CreateBorder(CalendarFrame.FilterButton, nil, nil, nil, nil, nil, false, true)
	   
	--CreateEventFrame
	local CalendarCreateEventFrame = _G.CalendarCreateEventFrame
	CalendarCreateEventFrame:HookScript('OnShow', function()
		BORDER:CreateBorder(CalendarCreateEventFrame, 1)
	end)
	
	BORDER:CreateBorder(_G.CalendarCreateEventInviteList.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(_G.CalendarCreateEventCreateButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.CalendarCreateEventMassInviteButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.CalendarCreateEventInviteButton, nil, nil, nil, nil, nil, false, true)


	_G.CalendarCreateEventInviteButton:Point('TOPLEFT', _G.CalendarCreateEventInviteEdit, 'TOPRIGHT', 4, 0)
	_G.CalendarCreateEventInviteEdit:Width(_G.CalendarCreateEventInviteEdit:GetWidth() - 2)

	BORDER:CreateBorder(_G.CalendarCreateEventInviteEdit)
	BORDER:CreateBorder(_G.CalendarCreateEventTitleEdit)
	BORDER:CreateBorder(_G.CalendarCreateEventFrame.EventTypeDropdown, nil, nil, nil, nil, nil, false, true)
	_G.CalendarCreateEventFrame.EventTypeDropdown.backdrop:Kill()
	BORDER:CreateBorder(_G.CalendarCreateEventCommunityDropDown)

	BORDER:CreateBorder(_G.CalendarCreateEventLockEventCheck.backdrop)
	BORDER:CreateBorder(_G.CalendarViewEventDescriptionContainer)
	BORDER:CreateBorder(_G.CalendarViewEventDescriptionScrollFrame)
	BORDER:CreateBorder(_G.CalendarCreateEventDescriptionContainer)
	BORDER:CreateBorder(_G.CalendarCreateEventDescriptionScrollFrame)
	BORDER:CreateBorder(_G.CalendarViewEventInviteList)
	BORDER:CreateBorder(_G.CalendarCreateEventInviteList)

	BORDER:CreateBorder(_G.CalendarCreateEventFrame.HourDropdown.backdrop)
	BORDER:CreateBorder(_G.CalendarCreateEventFrame.MinuteDropdown.backdrop)
	BORDER:CreateBorder(_G.CalendarCreateEventAMPMDropDown)
	BORDER:CreateBorder(_G.CalendarCreateEventDifficultyOptionDropDown)

	BORDER:CreateBorder(_G.CalendarViewEventIcon)

	BORDER:CreateBorder(_G.CalendarCreateEventIcon.backdrop)
			
	local lastClassButton
	for i, class in next, CLASS_SORT_ORDER do
		local button = _G['CalendarClassButton'..i]
		if button then
			BORDER:CreateBorder(button)
		end

		lastClassButton = button
	end

	BORDER:CreateBorder(_G.CalendarClassTotalsButton)

	--Texture Picker Frame
	BORDER:CreateBorder(_G.CalendarTexturePickerFrame)
	BORDER:CreateBorder(_G.CalendarTexturePickerFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(_G.CalendarTexturePickerAcceptButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.CalendarTexturePickerCancelButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.CalendarCreateEventInviteButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.CalendarCreateEventRaidInviteButton, nil, nil, nil, nil, nil, false, true)

	--Mass Invite Frame
	BORDER:CreateBorder(_G.CalendarMassInviteFrame)

	BORDER:CreateBorder(_G.CalendarMassInviteFrame.CommunityDropdown, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G._G.CalendarMassInviteFrame.RankDropdown, nil, nil, nil, nil, nil, false, true)

	BORDER:CreateBorder(_G.CalendarMassInviteMinLevelEdit, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(_G.CalendarMassInviteMaxLevelEdit, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(_G.CalendarMassInviteAcceptButton, nil, nil, nil, nil, nil, false, true)

	--Raid View
	BORDER:CreateBorder(_G.CalendarViewRaidFrame)

	--Holiday View
	BORDER:CreateBorder(_G.CalendarViewHolidayFrame)

	-- Event View
	BORDER:CreateBorder(_G.CalendarViewEventFrame)

	BORDER:CreateBorder(_G.CalendarViewEventAcceptButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.CalendarViewEventTentativeButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.CalendarViewEventRemoveButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(_G.CalendarViewEventDeclineButton, nil, nil, nil, nil, nil, false, true)

	--Event Picker Frame
	BORDER:CreateBorder(_G.CalendarEventPickerFrame)

	BORDER:CreateBorder(_G.CalendarEventPickerFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.CalendarEventPickerCloseButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallbackForAddon('Blizzard_Calendar')
