local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc
local pairs = pairs
local type = type
local unpack = unpack

local function ConvertTags(tags)
	local res = {}
	for _, tag in ipairs(tags) do
	  res[tag] = true
	end
	return res
end

function S:Baganator()

	if not E.db.ProjectHopes.skins.Baganator then return end

	local skinners = {
		ItemButton = function(frame, tags)
			frame.IconBorder:Hide()
			E:Delay(1, function()
				if frame.backup then
					frame.backdrop:SetBackdrop()
				end
			end)

			if frame.widgetContainer then
				frame.widgetContainer:SetFrameLevel(13)
			end

			BORDER:CreateBorder(frame.backdrop)
			BORDER:HandleIconBorder(frame.IconBorder, frame.backdrop.border)
		end,
		IconButton = function(frame)
			BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, false, true)
		end,
		Button = function(frame)
			BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, false, true)
		end,
		ButtonFrame = function(frame)
			BORDER:CreateBorder(frame)
		end,
		SearchBox = function(frame)
			BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true, false)
		end,
		EditBox = function(frame)
			BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true, false)
		end,
		TabButton = function(frame)
			BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true, true)
		end,
		TopTabButton = function(frame)
			BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true, true)
		end,
		SideTabButton = function(frame)
			BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, false, true)
		end,
		TrimScrollBar = function(frame)
			BORDER:CreateBorder(frame.Track.Thumb, nil, nil, nil, nil, nil, false, true)

		end,
		CheckBox = function(frame)
			BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true, true)
		end,
		Slider = function(frame)
			BORDER:CreateBorder(frame, nil, nil, nil, nil, nil, true, true)
		end,
	}

    local function SkinFrame(details)
        local func = skinners[details.regionType]
        if func then
          func(details.region, details.tags and ConvertTags(details.tags) or {})
        end
    end

    for _, details in ipairs(Baganator.API.Skins.GetAllFrames()) do
      SkinFrame(details)
    end

	-- Reposition Category View Buttons
	_G.Baganator_CategoryViewBackpackViewFrameelvui.ToggleBankButton:ClearAllPoints()
	_G.Baganator_CategoryViewBackpackViewFrameelvui.ToggleBankButton:Point('TOPLEFT', _G.Baganator_CategoryViewBackpackViewFrameelvui, 'TOPLEFT', 4, -2)

	_G.Baganator_CategoryViewBackpackViewFrameelvui.ToggleAllCharacters:ClearAllPoints()
	_G.Baganator_CategoryViewBackpackViewFrameelvui.ToggleAllCharacters:Point('LEFT', _G.Baganator_CategoryViewBackpackViewFrameelvui.ToggleBankButton, 'RIGHT', 4, 0)

	_G.Baganator_CategoryViewBackpackViewFrameelvui.ToggleBagSlotsButton:ClearAllPoints()
	_G.Baganator_CategoryViewBackpackViewFrameelvui.ToggleBagSlotsButton:Point('LEFT', _G.Baganator_CategoryViewBackpackViewFrameelvui.ToggleAllCharacters, 'RIGHT', 4, 0)

	_G.Baganator_CategoryViewBackpackViewFrameelvui.CustomiseButton:ClearAllPoints()
	_G.Baganator_CategoryViewBackpackViewFrameelvui.CustomiseButton:Point('RIGHT', _G.Baganator_CategoryViewBackpackViewFrameelvuiCloseButton, 'LEFT', -2, -2)

	_G.Baganator_CategoryViewBackpackViewFrameelvui.SortButton:ClearAllPoints()
	_G.Baganator_CategoryViewBackpackViewFrameelvui.SortButton:Point('RIGHT', _G.Baganator_CategoryViewBackpackViewFrameelvui.CustomiseButton, 'LEFT', -4, 0)

	--cant make this work, need your help Hopes
	--_G.Baganator_CategoryViewBackpackViewFrameelvui.CurrencyButton:ClearAllPoints()
	--_G.Baganator_CategoryViewBackpackViewFrameelvui.CurrencyButton:Point('BOTTOMRIGHT', _G.Baganator_CategoryViewBackpackViewFrameelvui, 'BOTTOMLEFT', 2, 5)

	-- Repoistion Single View Buttons
	_G.Baganator_SingleViewBackpackViewFrameelvui.ToggleBankButton:ClearAllPoints()
	_G.Baganator_SingleViewBackpackViewFrameelvui.ToggleBankButton:Point('TOPLEFT', _G.Baganator_SingleViewBackpackViewFrameelvui, 'TOPLEFT', 4, -2)

	_G.Baganator_SingleViewBackpackViewFrameelvui.ToggleAllCharacters:ClearAllPoints()
	_G.Baganator_SingleViewBackpackViewFrameelvui.ToggleAllCharacters:Point('LEFT', _G.Baganator_SingleViewBackpackViewFrameelvui.ToggleBankButton, 'RIGHT', 4, 0)

	_G.Baganator_SingleViewBackpackViewFrameelvui.ToggleBagSlotsButton:ClearAllPoints()
	_G.Baganator_SingleViewBackpackViewFrameelvui.ToggleBagSlotsButton:Point('LEFT', _G.Baganator_SingleViewBackpackViewFrameelvui.ToggleAllCharacters, 'RIGHT', 4, 0)

	_G.Baganator_SingleViewBackpackViewFrameelvui.CustomiseButton:ClearAllPoints()
	_G.Baganator_SingleViewBackpackViewFrameelvui.CustomiseButton:Point('RIGHT', _G.Baganator_SingleViewBackpackViewFrameelvuiCloseButton, 'LEFT', -2, -2)

	_G.Baganator_SingleViewBackpackViewFrameelvui.SortButton:ClearAllPoints()
	_G.Baganator_SingleViewBackpackViewFrameelvui.SortButton:Point('RIGHT', _G.Baganator_SingleViewBackpackViewFrameelvui.CustomiseButton, 'LEFT', -4, 0)

    Baganator.API.Skins.RegisterListener(SkinFrame)
	
end


S:AddCallbackForAddon("Baganator")
