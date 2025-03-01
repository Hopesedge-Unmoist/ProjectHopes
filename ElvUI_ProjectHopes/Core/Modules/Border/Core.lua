local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:NewModule('BORDER', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0');

local S = E:GetModule('Skins')
local B = E:GetModule('Bags')
local UF = E:GetModule("UnitFrames")

local LibStub = _G.LibStub

local _G = _G
local hooksecurefunc = hooksecurefunc
local tinsert, xpcall, next, ipairs, pairs = tinsert, xpcall, next, ipairs, pairs
local unpack, assert, type, gsub, rad, strfind = unpack, assert, type, gsub, rad, strfind

local CreateFrame = CreateFrame
local ITEM_QUALITY_COLORS = ITEM_QUALITY_COLORS

-- Functions
function BORDER:CreateBorder(frame, frameLevel, SetPoint1, SetPoint2, SetPoint3, SetPoint4, backdrop, event, Point1, Point2)
    if not frame or frame.border then
        return
    end

    if frame:GetObjectType() == "Texture" then
        frame = frame:GetParent()
    end

    if backdrop then
        local border = CreateFrame("Frame", nil, frame.backdrop, "BackdropTemplate")
        border:SetFrameLevel((frameLevel and frame:GetFrameLevel() + frameLevel) or frame:GetFrameLevel() + 2)
        border:SetBackdrop(Private.Border)
        border:SetPoint("TOPLEFT" , Point1 or frame.backdrop, "TOPLEFT", SetPoint1 or -8, SetPoint2 or 8)
        border:SetPoint("BOTTOMRIGHT", Point2 or frame.backdrop, "BOTTOMRIGHT", SetPoint3 or 8, SetPoint4 or -8)
        border:SetBackdropBorderColor(1, 1, 1)
        if event then
            frame:HookScript("OnEnter", function()
                if frame then
                    border:SetBackdrop(Private.BorderLight)
                    border:SetBackdropBorderColor(1, 0.78, 0.03)
                end
            end)
            frame:HookScript("OnLeave", function()
                if frame then
                    border:SetBackdrop(Private.Border)
                    border:SetBackdropBorderColor(1, 1, 1)
                end
            end)
        end
        frame.border = border
    else
        local border = CreateFrame("Frame", nil, frame, "BackdropTemplate")
        border:SetFrameLevel((frameLevel and frame:GetFrameLevel() + frameLevel) or frame:GetFrameLevel() + 2)
        border:SetBackdrop(Private.Border)
        border:SetPoint("TOPLEFT" , Point1 or frame, "TOPLEFT", SetPoint1 or -8, SetPoint2 or 8)
        border:SetPoint("BOTTOMRIGHT", Point2 or frame, "BOTTOMRIGHT", SetPoint3 or 8, SetPoint4 or -8)
        border:SetBackdropBorderColor(1, 1, 1)
        frame.border = border
        if event then
            frame:HookScript("OnEnter", function()
                if frame then
                    border:SetBackdrop(Private.BorderLight)
                    border:SetBackdropBorderColor(1, 0.78, 0.03)
                end
            end)
            frame:HookScript("OnLeave", function()
                if frame then
                    border:SetBackdrop(Private.Border)
                    border:SetBackdropBorderColor(1, 1, 1)
                end
            end)
        end
    end
end

do
	local keys = {
		'zoomInButton',
		'zoomOutButton',
		'rotateLeftButton',
		'rotateRightButton',
		'resetButton',
	}

	local function UpdateLayout(frame)
		local last
		for _, name in next, keys do
			local button = frame[name]
			if button then
				if not button.IsBorder then
					BORDER:CreateBorder(button, nil, nil, nil, nil, nil, false, true)
					button:Size(24)

				end

				if button:IsShown() then
					button:ClearAllPoints()

					if last then
						button:Point('LEFT', last, 'RIGHT', 6, 0)
					else
						button:Point('LEFT', 6, 0)
					end

					last = button
				end
			end
		end
	end

	function BORDER:HandleModelSceneControlButtons(frame)
		if not frame.IsBorder then
			frame.IsBorder = true
			hooksecurefunc(frame, 'UpdateLayout', UpdateLayout)
		end
	end
end

function BORDER:HandleIcon(icon, backdrop)
    if backdrop and not icon.backdrop then
		icon:CreateBackdrop()
	end

	if icon.backdrop and not icon.backdrop.border then
        local border = CreateFrame("Frame", nil, icon.backdrop, "BackdropTemplate")
        border:SetFrameLevel(icon.backdrop:GetFrameLevel() + 2)
        border:SetBackdrop(Private.Border)
        border:SetPoint("TOPLEFT" , icon.backdrop, "TOPLEFT", -8, 8)
        border:SetPoint("BOTTOMRIGHT", icon.backdrop, "BOTTOMRIGHT", 8, -8)
        border:SetBackdropBorderColor(1, 1, 1)
        icon.backdrop.border = border
    end
end

do
    local quality = Enum.ItemQuality
    local iconColors = {
        ['auctionhouse-itemicon-border-gray']        = E.QualityColors[quality.Poor],
        ['auctionhouse-itemicon-border-white']       = E.QualityColors[quality.Common],
        ['auctionhouse-itemicon-border-green']       = E.QualityColors[quality.Uncommon],
        ['auctionhouse-itemicon-border-blue']        = E.QualityColors[quality.Rare],
        ['auctionhouse-itemicon-border-purple']      = E.QualityColors[quality.Epic],
        ['auctionhouse-itemicon-border-orange']      = E.QualityColors[quality.Legendary],
        ['auctionhouse-itemicon-border-artifact']    = E.QualityColors[quality.Artifact],
        ['auctionhouse-itemicon-border-account']     = E.QualityColors[quality.Heirloom]
    }

    local function colorAtlas(border, atlas)
        local color = iconColors[atlas]
        if not color then return end

        if border.customFunc then
            local br, bg, bb = 1, 1, 1
            border.customFunc(border, color.r, color.g, color.b, 1, br, bg, bb)
        elseif border.customBackdrop then
            if color.r == 0 and color.g == 0 and color.b == 0 then
                color.r, color.g, color.b = 1, 1, 1
            end
            border.customBackdrop:SetBackdrop(Private.BorderLight)
            border.customBackdrop:SetBackdropBorderColor(color.r, color.g, color.b)
        end
    end

    local function colorVertex(border, r, g, b, a)
        if border.customFunc then
            local br, bg, bb = 1, 1, 1
            border.customFunc(border, r, g, b, a, br, bg, bb)
        elseif border.customBackdrop then
            border.customBackdrop:SetBackdrop(Private.BorderLight)
            border.customBackdrop:SetBackdropBorderColor(r, g, b)
        end
    end

    local function borderHide(border, value)
        if value == 0 then return end -- hiding blizz border

        local br, bg, bb = 1, 1, 1
        if border.customFunc then
            local r, g, b, a = 1, 1, 1, 1
            border.customFunc(border, r, g, b, a, br, bg, bb)
        elseif border.customBackdrop then
            border.customBackdrop:SetBackdrop(Private.Border)
            border.customBackdrop:SetBackdropBorderColor(br, bg, bb)
        end
    end

    local function borderShow(border)
        border:Hide(0)
    end

    local function borderShown(border, show)
        if show then
            border:Hide(0)
        else
            borderHide(border)
        end
    end

    function BORDER:HandleIconBorder(border, backdrop, customFunc)
        if not backdrop then
            local parent = border:GetParent()
            backdrop = parent.backdrop or parent
        end

		local r, g, b, a = border:GetVertexColor()
        local atlas = iconColors[border.GetAtlas and border:GetAtlas()]
        if customFunc then
            border.customFunc = customFunc
            local br, bg, bb = 1, 1, 1
            customFunc(border, r, g, b, a, br, bg, bb)
        elseif atlas then
            backdrop:SetBackdropBorderColor(atlas.r, atlas.g, atlas.b, 1)
        elseif r then
            backdrop:SetBackdrop(Private.BorderLight)
            backdrop:SetBackdropBorderColor(r, g, b, a)
        else
            local br, bg, bb = 1, 1, 1
            backdrop:SetBackdropBorderColor(br, bg, bb)
        end

        if border.customBackdrop ~= backdrop then
            border.customBackdrop = backdrop
        end

        if not border.IconBorderHooked_hope then
            border.IconBorderHooked_hope = true
            border:Hide()

            hooksecurefunc(border, 'SetAtlas', colorAtlas)
            hooksecurefunc(border, 'SetVertexColor', colorVertex)
            hooksecurefunc(border, 'SetShown', borderShown)
            hooksecurefunc(border, 'Show', borderShow)
            hooksecurefunc(border, 'Hide', borderHide)
        end
    end
end

do
	local NavBarCheck = {
		EncounterJournal = function()
			return E.private.skins.blizzard.encounterjournal
		end,
		WorldMapFrame = function()
			return E.private.skins.blizzard.worldmap
		end,
		HelpFrameKnowledgebase = function()
			return E.private.skins.blizzard.help
		end
	}

	local function NavButtonXOffset(button, point, anchor, point2, _, yoffset, skip)
		if not skip then
			button:Point(point, anchor, point2, 5, yoffset, true)
		end
	end

	function BORDER:HandleNavBarButtons()
		local func = NavBarCheck[self:GetParent():GetName()]
		if func and not func() then return end

		local total = #self.navList
		local button = self.navList[total]
		if button and not button.IsBorder then
			BORDER:CreateBorder(button, nil, nil, nil, nil, nil, false, true)

			local arrow = button.MenuArrowButton
			if arrow then
				arrow:StripTextures()

				local art = arrow.Art
				if art then
					art:SetTexture(E.Media.Textures.ArrowUp)
					art:SetTexCoord(0, 1, 0, 1)
					art:SetRotation(3.14)
				end
			end

			-- setting the xoffset will cause a taint, use the hook below instead to lock the xoffset to 1
			if total > 1 then
				NavButtonXOffset(button, button:GetPoint())
				hooksecurefunc(button, 'SetPoint', NavButtonXOffset)
			end

			button.IsBorder = true
		end
	end
end

function BORDER:SetBackdropBorderColor(frame, script)
	if frame.border then
        frame = frame.border
    end

	if frame.SetBackdropBorderColor then
        if script == 'OnEnter' then
            frame:SetBackdrop(Private.BorderLight)
            frame:SetBackdropBorderColor(unpack(E.media.rgbvaluecolor))
        else
            frame:SetBackdrop(Private.Border)
            frame:SetBackdropBorderColor(1, 1, 1)
        end
    end
end

function BORDER:SetModifiedBackdrop()
	if self:IsEnabled() then
		BORDER:SetBackdropBorderColor(self, 'OnEnter')
	end
end

function BORDER:SetOriginalBackdrop()
	if self:IsEnabled() then
		BORDER:SetBackdropBorderColor(self, 'OnLeave')
	end
end

function BORDER:SetDisabledBackdrop()
	if self:IsMouseOver() then
		BORDER:SetBackdropBorderColor(self, 'OnDisable')
	end
end

function BORDER:UpdateBorderColor(border, r, g, b)
    if not border then
        return
    end

    r = r or 1
    g = g or 1
    b = b or 1

    border:SetBackdropColor(r, g, b, 0)
    border:SetBackdropBorderColor(r, g, b, 1)
end

do
    local function colorCallback(border, r, g, b)
        if not r or not g or not b then
            return
        end

        if r == E.db.general.bordercolor.r and g == E.db.general.bordercolor.g and b == E.db.general.bordercolor.b then
            BORDER:UpdateBorderColor(border)
        else
            border:SetBackdrop(Private.BorderLight)
            BORDER:UpdateBorderColor(border, r / 0.6, g / 0.6, b / 0.6)
        end
    end

    function BORDER:BindBorderColorWithBorder(border, borderParent)
        if not border or not borderParent or not borderParent.SetBackdropBorderColor then
            return
        end

        hooksecurefunc(
            borderParent,
            "SetBackdropBorderColor",
            function(_, ...)
                colorCallback(border, ...)
            end
        )

        colorCallback(border, borderParent:GetBackdropBorderColor())
    end
end

function BORDER:CreateSeparator(frame, frameLevel, Point1, Point2)
    if not frame or frame.separator then
        return
    end

    if frame:GetObjectType() == "Texture" then
        frame = frame:GetParent()
    end
    local separator = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    separator:SetBackdrop(Private.Separator)
    separator:SetFrameLevel((frameLevel and frame:GetFrameLevel() + frameLevel) or frame:GetFrameLevel() + 5)
    separator:SetHeight(16)
    separator:SetPoint("TOPRIGHT", Point1 or frame, 0, 4)
    separator:SetPoint("LEFT", Point2 or frame, 0, 0)
    separator:SetIgnoreParentAlpha(true)

    frame.separator = separator
end

function BORDER:CreateVSeparator(frame, frameLevel, Point1, Point2)
    if not frame or frame.vseparator then
        return
    end

    if frame:GetObjectType() == "Texture" then
        frame = frame:GetParent()
    end

    local vseparator = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    vseparator:SetBackdrop(Private.vSeparator)
    vseparator:SetFrameLevel((frameLevel and frame:GetFrameLevel() + frameLevel) or frame:GetFrameLevel() + 5)
    vseparator:SetWidth(16)
    vseparator:SetPoint("TOPLEFT", Point1 or frame, -4, 0)
    vseparator:SetPoint("BOTTOMLEFT", Point2 or frame, 0, 0)
    vseparator:SetIgnoreParentAlpha(true)
    frame.vseparator = vseparator
end

do
	function BORDER:HandleIconSelectionFrame(frame, numIcons, buttonNameTemplate, nameOverride, dontOffset)
		assert(frame, 'doesn\'t exist!')

		if frame.IsBorder then return end


		local borderBox = frame.BorderBox or _G.BorderBox -- it's a sub frame only on retail, on wrath it's a global?
		local frameName = nameOverride or frame:GetName() -- we need override in case Blizzard fucks up the naming (guild bank)
		local scrollFrame = frame.ScrollFrame or (frameName and _G[frameName..'ScrollFrame'])
		local editBox = (borderBox and borderBox.IconSelectorEditBox) or frame.EditBox or (frameName and _G[frameName..'EditBox'])
		local cancel = frame.CancelButton or (borderBox and borderBox.CancelButton) or (frameName and _G[frameName..'Cancel'])
		local okay = frame.OkayButton or (borderBox and borderBox.OkayButton) or (frameName and _G[frameName..'Okay'])
        self:CreateBorder(frame)


		if borderBox then
			local dropdown = borderBox.IconTypeDropdown or (borderBox.IconTypeDropDown and borderBox.IconTypeDropDown.DropDownMenu)
			if dropdown then
				self:CreateBorder(dropdown, nil, nil, nil, nil, nil, true, true)
			end

			local button = borderBox.SelectedIconArea and borderBox.SelectedIconArea.SelectedIconButton
			if button then
                self:CreateBorder(button, nil, nil, nil, nil, nil, true, true)
			end
		end

		self:CreateBorder(cancel, nil, nil, nil, nil, nil, false, true)
		self:CreateBorder(okay, nil, nil, nil, nil, nil, false, true)

		if editBox then
			self:CreateBorder(editBox, nil, nil, nil, nil, nil, true, false)
		end

		if numIcons then
			if scrollFrame then
				self:CreateBorder(scrollFrame.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
			end
		else
			self:CreateBorder(frame.IconSelector.ScrollBar.Track.Thumb, nil, nil, nil, nil, nil, true, true)
		end

        for _, button in next, { frame.IconSelector.ScrollBox.ScrollTarget:GetChildren() } do
            self:CreateBorder(button, nil, nil, nil, nil, nil, false, true)
        end

		frame.IsBorder = true
	end
end

function BORDER:CreateBackground(frame, xx, yy, xy, yx)
    if not frame or frame.background then
        return
    end

    local background = CreateFrame("Frame", nil, frame, "BackdropTemplate")
    background:SetBackdrop(Private.BackgroundTexture)
	background:SetFrameLevel(frame:GetFrameLevel() + 1)
	background:SetPoint("TOPLEFT", frame, xx, yy)
	background:SetPoint("BOTTOMRIGHT", frame, xy, yx)
	background:SetBackdropColor(0.1254901960784314, 0.1254901960784314, 0.1254901960784314)
    frame.background = background
end

do
	local regions = {
		"Center",
		"BottomEdge",
		"LeftEdge",
		"RightEdge",
		"TopEdge",
		"BottomLeftCorner",
		"BottomRightCorner",
		"TopLeftCorner",
		"TopRightCorner",
	}
	function BORDER:StripEdgeTextures(frame)
		for _, regionKey in pairs(regions) do
			if frame[regionKey] then
				frame[regionKey]:Kill()
			end
		end
	end
end


-- Helper function to skin an element with optional border
local function SkinElement(element, skinFunction, params)
    if element and not element.IsSkinned then
        skinFunction(element)
        if params and next(params) then -- Apply specific border if param exists, else generic
            BORDER:CreateBorder(element, unpack(params))
        else
            BORDER:CreateBorder(element)
        end
        element.IsSkinned = true
    end
end

-- Function to skin multiple dropdowns with unique parameters
function BORDER:SkinDropDownList(dropdownData)
    for _, data in ipairs(dropdownData) do
        local dropdown = data.dropdown
        local dropdownButton = data.dropdownbutton
        local params = data.borderParams

        -- Skin the dropdown box
        SkinElement(dropdown, function(dropdown) S:HandleDropDownBox(dropdown) end, params)

        -- Position the dropdown button if provided
        if dropdownButton then
            BORDER:ClearAndSetPoint(dropdownButton, "RIGHT", dropdown, "RIGHT", 0, 0)
        end
    end
end

-- Function to skin multiple buttons with unique parameters
function BORDER:SkinButtonList(buttonData)
    for _, data in ipairs(buttonData) do
        local button = data.button
        local params = data.borderParams

        -- Skin the button box
        SkinElement(button, function(button) S:HandleButton(button) end, params)
    end
end

-- Function to skin multiple frames with unique parameters
function BORDER:SkinFrameList(frameData)
    for _, data in ipairs(frameData) do
        local frame = data.frame
        local scrollBar = data.scrollbar
        local params = data.borderParams

        -- Skin the frame box
        SkinElement(frame, function(frame) S:HandleFrame(frame) end, params)

         -- Skin scrollbar if provided
        if scrollBar then
            SkinElement(scrollBar, function(scrollBar) S:HandleScrollBar(scrollBar) end, params)
        end
    end
end

-- Function to skin multiple editboxs with unique parameters
function BORDER:SkinEditboxList(editboxData)
    for _, data in ipairs(editboxData) do
        local editbox = data.editbox
        local params = data.borderParams

        -- Skin the editbox box
        SkinElement(editbox, function(editbox) S:HandleEditBox(editbox) end, params)
    end
end

-- Function to skin multiple tabs with unique parameters
function BORDER:SkinTabList(tabData)
    for _, data in ipairs(tabData) do
        local tab = data.tab
        local params = data.borderParams

        -- Skin the tab box
        SkinElement(tab, function(tab) S:HandleTab(tab) end, params)
    end
end

-- Function to clean all points and position elements
function BORDER:ClearAndSetPoint(element, anchor, relativeElement, relativeElementAnchor, x, y)
    if element then
		element:ClearAllPoints()

		-- If relativeElement is provided and is a valid frame, use full SetPoint method
		if type(relativeElement) == "table" then
			element:SetPoint(anchor, relativeElement, relativeElementAnchor, x, y)
		else
			-- If relativeElement is missing, assume x and y are direct offsets
			element:SetPoint(anchor, relativeElement, relativeElementAnchor) -- Adjusts parameters
		end
	end
end

-- Function to resize a frame
function BORDER:AdjustSize(element,width,height)
	if element then
    	element:SetSize(element:GetWidth() + width, element:GetHeight() + height)
	end
end

E:RegisterModule(BORDER:GetName())
