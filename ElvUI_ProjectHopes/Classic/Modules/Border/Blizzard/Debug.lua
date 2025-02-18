local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')
local TT = E:GetModule('Tooltip')

local _G = _G
local hooksecurefunc = hooksecurefunc
local IsAddOnLoaded = C_AddOns.IsAddOnLoaded

local function SkinTableAttributeDisplay(frame)
	BORDER:CreateBorder(frame)
	BORDER:CreateBorder(frame.ScrollFrameArt, nil, -10, nil, 0, nil)
	BORDER:CreateBorder(frame.LinesScrollFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)

	BORDER:CreateBorder(frame.VisibilityButton, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(frame.HighlightButton, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(frame.DynamicUpdateButton, nil, nil, nil, nil, nil, true, true)
	BORDER:CreateBorder(frame.FilterBox, nil, nil, nil, nil, nil, true, false)

	frame.IsBorder = true
end

function S:Blizzard_DebugTools()
	if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.debug) then return end
    if not E.db.ProjectHopes.skins.debugTools then return end

	-- Tooltips
	if E.private.skins.blizzard.tooltip then
		BORDER:CreateBorder(_G.FrameStackTooltip)
	end

	--New Table Attribute Display: mouse over frame and (/tableinspect or [/fstack -> then Ctrl])
	SkinTableAttributeDisplay(_G.TableAttributeDisplay)
	hooksecurefunc(_G.TableInspectorMixin, 'OnLoad', function(frame)
		if frame.ScrollFrameArt and not frame.IsBorder then
			SkinTableAttributeDisplay(frame)
		end
	end)
end

-- FrameStack, TableInspect Skins
if IsAddOnLoaded('Blizzard_DebugTools') then
	S:AddCallback('Blizzard_DebugTools')
else
	S:AddCallbackForAddon('Blizzard_DebugTools')
end
