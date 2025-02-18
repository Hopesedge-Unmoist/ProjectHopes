local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local pairs, next = pairs, next
local hooksecurefunc = hooksecurefunc

local function ReskinEventTraceButton(button)
	BORDER:CreateBorder(button, nil, nil, nil, nil, nil, false, true)
end

local function reskinScrollChild(self)
	for _, child in next, { self.ScrollTarget:GetChildren() } do
		local button = child.HideButton
		if button and not button.IsBorder then               
			local checkButton = child.CheckButton
			if checkButton then
				BORDER:CreateBorder(checkButton, nil, nil, nil, nil, nil, true, true)
				checkButton:Size(24)
			end

			button.IsBorder = true
		end
	end
end

local function ReskinEventTraceScrollBox(frame)               
	hooksecurefunc(frame, 'Update', reskinScrollChild)
end

local function ReskinEventTraceFrame(frame)
	ReskinEventTraceScrollBox(frame.ScrollBox)
	BORDER:CreateBorder(frame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
end

function S:Blizzard_EventTrace()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.eventLog) then return end
    if not E.db.ProjectHopes.skins.eventTrace then return end

    -- Frame
    local EventTrace = _G.EventTrace
    BORDER:CreateBorder(EventTrace)

    -- Top Buttons
    local SubtitleBar = EventTrace.SubtitleBar
    BORDER:CreateBorder(EventTrace.SubtitleBar.ViewLog, nil, nil, nil, nil, nil, false, true)
    BORDER:CreateBorder(EventTrace.SubtitleBar.ViewFilter, nil, nil, nil, nil, nil, false, true)

    -- Options Dropdown
    BORDER:CreateBorder(EventTrace.SubtitleBar.OptionsDropdown, nil, nil, nil, nil, nil, false, true)

    -- Log Bar
    local LogBar = EventTrace.Log.Bar
    BORDER:CreateBorder(LogBar.SearchBox)
    BORDER:CreateBorder(LogBar.DiscardAllButton, nil, nil, nil, nil, nil, false, true)
    BORDER:CreateBorder(LogBar.PlaybackButton, nil, nil, nil, nil, nil, false, true)
    BORDER:CreateBorder(LogBar.MarkButton, nil, nil, nil, nil, nil, false, true)

    -- Filter Bar
    local FilterBar = EventTrace.Filter.Bar
    BORDER:CreateBorder(FilterBar.DiscardAllButton, nil, nil, nil, nil, nil, false, true)
    BORDER:CreateBorder(FilterBar.UncheckAllButton, nil, nil, nil, nil, nil, false, true)
    BORDER:CreateBorder(FilterBar.CheckAllButton, nil, nil, nil, nil, nil, false, true)

    -- Resize Button
    ReskinEventTraceFrame(EventTrace.Log.Events)
    ReskinEventTraceFrame(EventTrace.Log.Search)
    ReskinEventTraceFrame(EventTrace.Filter)

    local buttons = {
        SubtitleBar.ViewLog,
        SubtitleBar.ViewFilter,
        LogBar.DiscardAllButton,
        LogBar.PlaybackButton,
        LogBar.MarkButton,
        FilterBar.DiscardAllButton,
        FilterBar.UncheckAllButton,
        FilterBar.CheckAllButton,
    }

    for _, button in pairs(buttons) do
        ReskinEventTraceButton(button)
    end
end

S:AddCallbackForAddon('Blizzard_EventTrace')
