local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')

local S = E:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc
local pairs = pairs
local type = type
local unpack = unpack

local Baganator = Baganator

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
			BORDER:CreateBorder(frame, nil, -5, 6, 5, -6, false, true)
      frame:SetBackdrop(nil)
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

  Baganator.API.Skins.RegisterListener(SkinFrame)
end


S:AddCallbackForAddon("Baganator")
