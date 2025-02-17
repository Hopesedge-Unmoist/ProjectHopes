local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local unpack = unpack
local hooksecurefunc = hooksecurefunc

function S:Blizzard_TimeManager()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.timemanager) then return end
	if not E.db.ProjectHopes.skins.timeManager then return end

	local TimeManagerFrame = _G.TimeManagerFrame
	BORDER:CreateBorder(TimeManagerFrame)

	local Alarm = _G.TimeManagerAlarmTimeFrame
	BORDER:CreateBorder(Alarm.HourDropdown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(Alarm.MinuteDropdown, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(Alarm.AMPMDropdown, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(_G.TimeManagerAlarmMessageEditBox, nil, nil, nil, nil, nil, true, false)
	BORDER:CreateBorder(_G.TimeManagerAlarmEnabledButton, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.TimeManagerMilitaryTimeCheck, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(_G.TimeManagerLocalTimeCheck, nil, nil, nil, nil, nil, true, true)
			
	local StopwatchFrame = _G.StopwatchFrame
	BORDER:CreateBorder(StopwatchFrame, nil, nil, nil, nil, nil, true, false)

	--Play/Pause and Reset buttons
	local StopwatchPlayPauseButton = _G.StopwatchPlayPauseButton
	local StopwatchResetButton = _G.StopwatchResetButton

	BORDER:CreateBorder(StopwatchResetButton, nil, nil, nil, nil, nil, false, true)
	BORDER:CreateBorder(StopwatchPlayPauseButton, nil, nil, nil, nil, nil, false, true)
end

S:AddCallbackForAddon('Blizzard_TimeManager')
