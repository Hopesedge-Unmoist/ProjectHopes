-- Credits go to AcidWeb for baseline code, and for allowing me to use the code as baseline.
-- Credits go to foxlit for allow me to use the code to create this aswell. 

local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local BORDER = E:GetModule('BORDER')
local S = E:GetModule('Skins')

local _G = _G
local pairs = pairs
local FRAME_BUFFER_OK = Name == 40400

local function GetShortKeybindText(bind)
	return GetBindingText(bind, 1)
end

--========================================================--
-- CreateScalableTexture
--========================================================--
local CreateScalableTexture do
	local function ApplyToAllPieces(methodName)
		return function(self, ...)
			for i = 1, 4 do
				local texturePiece = self[i]
				texturePiece[methodName](texturePiece, ...)
			end
		end
	end

	local cornerPoints = {
		"BOTTOMRIGHT",
		"BOTTOMLEFT",
		"TOPLEFT",
		"TOPRIGHT"
	}

	local textureTemplate = {
		__index = {
			SetVertexColor = ApplyToAllPieces("SetVertexColor"),
			SetAlpha      = ApplyToAllPieces("SetAlpha"),
			SetShown      = ApplyToAllPieces("SetShown"),
		}
	}

	function CreateScalableTexture(layer, size, file, parent, qparent)
		local textureGroup, halfSize = setmetatable({}, textureTemplate), size/2

		for i = 1, 4 do
			local texture = (parent or qparent[i]):CreateTexture(nil, layer)
			local isBottom = i > 2
			local isLeft   = 2 > i or i > 3

			texture:SetSize(halfSize, halfSize)
			texture:SetTexture(file)
			texture:SetTexCoord(
				isLeft and 0 or 1, isLeft and 1 or 0,
				isBottom and 1 or 0, isBottom and 0 or 1
			)
			texture:SetTexelSnappingBias(0)
			texture:SetSnapToPixelGrid(false)
			texture:SetPoint(
				cornerPoints[i],
				parent or qparent[i],
				parent and "CENTER" or cornerPoints[i]
			)

			textureGroup[i] = texture
		end

		return textureGroup
	end

	CreateScalableTexture = CreateScalableTexture
end

-- Helper function to create quad texture (for outer glow)
local function CreateQuadTexture(layer, size, file, parent)
	return CreateScalableTexture(layer, size, file, parent)
end

--========================================================--
-- Item quality atlas
--========================================================--
local itemQualityAtlas = {}
do
	for i = 1, 5 do
		itemQualityAtlas[i] = "Professions-Icon-Quality-Tier" .. i .. "-Small"
	end
end

--========================================================--
-- Icon Aspect Ratio
--========================================================--
local function AdjustIconAspectRatio(buttonIndicator, aspectRatio)
	if buttonIndicator.iconAspect ~= aspectRatio then
		buttonIndicator.iconAspect = aspectRatio

		local width, height = buttonIndicator.iconBackground:GetSize()
		buttonIndicator.icon:SetSize(
			aspectRatio < 1 and height * aspectRatio or width,
			aspectRatio > 1 and width / aspectRatio or height
		)
	end
end

--========================================================--
-- Button API
--========================================================--
local buttonAPI = {}
do
	local frameMetatable = getmetatable(UIParent).__index
	for methodName in ("SetPoint SetScale GetScale SetShown SetParent"):gmatch("%S+") do
		local frameMethod = frameMetatable[methodName]
		buttonAPI[methodName] = function(self, ...)
			return frameMethod(self[0], ...)
		end
	end
end

function buttonAPI:SetIcon(texture, aspectRatio)
	self.icon:SetTexture(texture)
	self.icon:SetTexCoord(unpack(E.TexCoords))
	return AdjustIconAspectRatio(self, aspectRatio)
end

function buttonAPI:SetIconAtlas(atlas, aspectRatio)
	self.icon:SetAtlas(atlas)
	return AdjustIconAspectRatio(self, aspectRatio)
end

function buttonAPI:SetIconTexCoord(a, b, c, d, e, f, g, h)
	if a and b and c and d then
		if e and f and g and h then
			self.icon:SetTexCoord(a, b, c, d, e, f, g, h)
		else
			self.icon:SetTexCoord(a, b, c, d)
		end
	end
end

function buttonAPI:SetIconVertexColor(r, g, b)
	self.icon:SetVertexColor(r, g, b)
end

function buttonAPI:SetUsable(usable, _usableCharge, _cd, nomana, norange)
	-- Determine usability state: 0=usable, 1=out of range, 2=no mana, 3=other issue
	local state = usable and 0 or (norange and 1 or (nomana and 2 or 3))
	if self.ustate == state then return end -- No change needed
	self.ustate = state
	
	-- Show colored ribbon for mana/range issues
	if not usable and (nomana or norange) then
		self.ribbon:Show()
		if norange then
			self.ribbon:SetVertexColor(1, 0.20, 0.15) -- Red for out of range
		else
			self.ribbon:SetVertexColor(0.15, 0.75, 1) -- Blue for no mana
		end
	else
		self.ribbon:Hide()
	end
	-- Dim the button when not usable
	self.veil:SetAlpha(usable and 0 or 0.40)
end

function buttonAPI:SetDominantColor(r, g, b)
	r, g, b = r or 1, g or 1, b or 0.6
	self.hiEdge:SetVertexColor(r, g, b)    -- Bright edge color
	self.iglow:SetVertexColor(r, g, b)     -- Inner glow color
	self.oglow:SetVertexColor(r, g, b)     -- Outer glow color
	self[0].border:SetBackdropBorderColor(r, g, b)
end

function buttonAPI:SetOverlayIcon(texture, width, height, ...)
	local overlayIcon = self.overlayIcon
	if not texture then
		return overlayIcon:Hide()
	end

	overlayIcon:Show()
	overlayIcon:SetTexture(texture)
	overlayIcon:SetSize(width, height)

	if ... then
		overlayIcon:SetTexCoord(...)
	else
		overlayIcon:SetTexCoord(0, 1, 0, 1)
	end
end

function buttonAPI:SetOverlayIconVertexColor(...)
	self.overlayIcon:SetVertexColor(...)
end

function buttonAPI:SetCount(count)
	self.countText:SetText(count or "")
end

function buttonAPI:SetBinding(binding)
	self.keybindText:SetText(binding and GetShortKeybindText(binding) or "")
end

function buttonAPI:SetCooldown(remainingTime, totalDuration, isUsable)
	if totalDuration and remainingTime and totalDuration > 0 and remainingTime > 0 then
		local startTime = GetTime() + remainingTime - totalDuration

		if isUsable then
			self.cooldownFrame:SetDrawEdge(true)
			self.cooldownFrame:SetDrawSwipe(false)
		else
			self.cooldownFrame:SetDrawEdge(false)
			self.cooldownFrame:SetDrawSwipe(true)
			self.cooldownFrame:SetSwipeColor(0, 0, 0, 0.8)
		end

		self.cooldownFrame:SetCooldown(startTime, totalDuration)
		self.cooldownFrame:Show()
	else
		self.cooldownFrame:Hide()
	end
end

function buttonAPI:SetHighlighted(highlight)
	self.hiEdge:SetShown(highlight)
end

function buttonAPI:SetActive(active)
	self.iglow:SetShown(active)
end

function buttonAPI:SetOuterGlow(shown)
	self.oglow:SetShown(shown)
end

function buttonAPI:SetEquipState(isInContainer, isInInventory)
	local banner = self.equipmentBanner
	local shouldShow = isInContainer or isInInventory
	local red, green, blue = 0.1, 0.9, 0.15

	banner:SetShown(shouldShow)

	if shouldShow then
		if not isInInventory then
			red, green, blue = 1, 0.9, 0.2
		end
		banner:SetVertexColor(red, green, blue)
	end
end

function buttonAPI:SetShortLabel(text)
	self.labelText:SetText(text)
end

function buttonAPI:SetQualityOverlay(qualityLevel)
	local qualityMark = self.qualityMark
	local atlasName   = itemQualityAtlas[qualityLevel]

	qualityMark:SetAtlas(atlasName)
	qualityMark:SetShown(atlasName ~= nil)
end

--========================================================--
-- CreateButtonIndicator
--========================================================--
local CreateButtonIndicator do
	local apiMetatable = { __index = buttonAPI }

	function CreateButtonIndicator(name, parent, buttonSize, nested)
		local mainFrame = CreateFrame("Frame", name, parent)
		mainFrame:SetSize(buttonSize, buttonSize)

		local bufferFrame = CreateFrame("Frame", nil, mainFrame)
		bufferFrame:SetAllPoints()
		bufferFrame:SetFlattensRenderLayers(true)
		bufferFrame:SetIsFrameBuffer(FRAME_BUFFER_OK)

		local visualFrame = CreateFrame("Frame", nil, bufferFrame)
		visualFrame:SetAllPoints()

		local uiFrame = CreateFrame("Frame", nil, mainFrame)
		uiFrame:SetAllPoints()
		uiFrame:SetFrameLevel(bufferFrame:GetFrameLevel() + 5)

		local buttonIndicator = setmetatable({
			[0] = mainFrame,
			cooldownFrame = CreateFrame("Cooldown", nil, visualFrame, "CooldownFrameTemplate"),
			bufferFrame   = bufferFrame,
		}, apiMetatable)

		-- cooldown
		buttonIndicator.cooldownFrame:ClearAllPoints()
		buttonIndicator.cooldownFrame:SetSize(buttonSize - 4, buttonSize - 4)
		buttonIndicator.cooldownFrame:SetPoint("CENTER")

		-- Outer glow effect (highlight border, hidden by default)
		buttonIndicator.hiEdge = CreateQuadTexture("BACKGROUND", buttonSize * 2, "Interface\\AddOns\\OPie\\gfx\\oglow", mainFrame)
		buttonIndicator.hiEdge:SetShown(false)

		-- icon layers
		local workingTexture = visualFrame:CreateTexture(nil, "OVERLAY")
		workingTexture:SetAllPoints()

		workingTexture, buttonIndicator.icon = visualFrame:CreateTexture(nil, "ARTWORK", nil, -2), workingTexture
		workingTexture:SetPoint("CENTER")
		workingTexture:SetSize(60 * buttonSize/64, 60 * buttonSize/64)
		workingTexture:SetColorTexture(0.15, 0.15, 0.15, 0.85)

		workingTexture, buttonIndicator.iconBackground = visualFrame:CreateTexture(nil, "ARTWORK", nil, 2), workingTexture
		workingTexture:SetSize(60 * buttonSize/64, 60 * buttonSize/64)
		workingTexture:SetPoint("CENTER")
		workingTexture:SetColorTexture(0, 0, 0)

		-- Inner glow background
		buttonIndicator.oglow = visualFrame:CreateTexture(nil, "ARTWORK", nil, 1)
		buttonIndicator.oglow:SetAllPoints()
		buttonIndicator.oglow:SetTexture("Interface\\AddOns\\OPie\\gfx\\iglow")
		buttonIndicator.oglow:SetAlpha(nested and 0.6 or 1) -- Dimmer for nested buttons

				-- Additional inner glow (centered, slightly smaller)
		buttonIndicator.iglow = visualFrame:CreateTexture(nil, "ARTWORK")
		buttonIndicator.iglow:SetPoint("CENTER")
		buttonIndicator.iglow:SetSize(60 * buttonSize/64, 60 * buttonSize/64) -- Slightly smaller than button

				-- Dimming overlay when not usable
		buttonIndicator.veil = visualFrame:CreateTexture(nil, "ARTWORK", nil, 3)
		buttonIndicator.veil:SetAllPoints()
		buttonIndicator.veil:SetTexture("Interface\\AddOns\\OPie\\gfx\\ribbon") -- Using ribbon texture as referenced
		buttonIndicator.veil:Hide()

		-- Status ribbon (mana/range indicators)
		buttonIndicator.ribbon = visualFrame:CreateTexture(nil, "ARTWORK", nil, 4)
		buttonIndicator.ribbon:SetPoint("BOTTOMLEFT", 4, 4)

		-- overlay icon
		buttonIndicator.overlayIcon = visualFrame:CreateTexture(nil, "ARTWORK", nil, 5)
		buttonIndicator.overlayIcon:SetPoint("TOPRIGHT", -2, -2)
		buttonIndicator.overlayIcon:SetSize(16, 16)
		buttonIndicator.overlayIcon:Hide()

		-- count
		buttonIndicator.countText = visualFrame:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
		buttonIndicator.countText:SetJustifyH("RIGHT")
		buttonIndicator.countText:SetPoint("BOTTOMRIGHT", -2, 1)

		-- keybind
		buttonIndicator.keybindText = visualFrame:CreateFontString(nil, "OVERLAY", "NumberFontNormalSmallGray")
		buttonIndicator.keybindText:SetJustifyH("RIGHT")
		buttonIndicator.keybindText:SetPoint("TOPRIGHT", -2, -3)

		-- equipment banner
		buttonIndicator.equipmentBanner = visualFrame:CreateTexture(nil, "ARTWORK", nil, 2)
		buttonIndicator.equipmentBanner:SetSize(buttonSize/5, buttonSize/4)
		buttonIndicator.equipmentBanner:SetTexture("Interface\\GuildFrame\\GuildDifficulty")
		buttonIndicator.equipmentBanner:SetTexCoord(0, 42/128, 6/64, 52/64)
		buttonIndicator.equipmentBanner:SetPoint("TOPLEFT", 6 * buttonSize/64, -3 * buttonSize/64)
		buttonIndicator.equipmentBanner:Hide()

		-- label
		buttonIndicator.labelText = visualFrame:CreateFontString(nil, "OVERLAY", "TextStatusBarText")
		buttonIndicator.labelText:SetSize(buttonSize - 4, 12)
		buttonIndicator.labelText:SetJustifyH("CENTER")
		buttonIndicator.labelText:SetJustifyV("BOTTOM")
		buttonIndicator.labelText:SetMaxLines(1)
		buttonIndicator.labelText:SetPoint("BOTTOMLEFT", 3, 2)
		buttonIndicator.labelText:SetPoint("BOTTOMRIGHT", buttonIndicator.countText, "BOTTOMLEFT", 2, 0)

		-- quality
		buttonIndicator.qualityMark = visualFrame:CreateTexture(nil, "ARTWORK", nil, 3)
		buttonIndicator.qualityMark:SetPoint("TOPLEFT", 4, -4)
		buttonIndicator.qualityMark:SetSize(14, 14)
		buttonIndicator.qualityMark:Hide()

		-- mask
		local iconMask = visualFrame:CreateMaskTexture()
		iconMask:SetTexture(Private.Background)
		iconMask:SetAllPoints()
		buttonIndicator.icon:AddMaskTexture(iconMask)

		-- border
		BORDER:CreateBorder(mainFrame)
		mainFrame.border:SetBackdrop(Private.BorderLight)

		buttonIndicator.cooldownText = buttonIndicator.cooldownFrame.cdText
		buttonIndicator.iconAspect = 1

		E:RegisterCooldown(buttonIndicator.cooldownFrame, "OPie")

		return buttonIndicator
	end
end

--========================================================--
-- OPie registration
--========================================================--
local function OnParentAlphaChanged(button, alpha)
	button:SetAlpha(alpha)
end

function S:OPie()
	if not E.db.ProjectHopes.skins.opie then return end

	OPie.UI:RegisterIndicatorConstructor("projecthopes", {
		name                        = "ProjectHopes",
		apiLevel                    = 3,
		CreateIndicator             = CreateButtonIndicator,
		supportsCooldownNumbers     = false,
		supportsShortLabels         = true,
		fixedFrameBuffering         = true,
		fixedFrameBufferingClassic  = true,
		fixedFrameBufferingEra      = true,
		onParentAlphaChanged        = FRAME_BUFFER_OK and function(self, pea)
			self.bufferFrame:SetAlpha(pea)
		end or nil,
	})
end

S:AddCallbackForAddon("OPie")