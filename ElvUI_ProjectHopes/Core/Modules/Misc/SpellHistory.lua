local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

local SpellHistory = E:NewModule('SpellHistory', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0')
local BORDER = E:GetModule('BORDER')

local ICON_SIZE = E.db.ProjectHopes.gcd.historyIconSize or 36
local ICON_GAP = 6
local GROWTH_DIRECTION = E.db.ProjectHopes.gcd.growth or "LEFT"
local HISTORY_COUNT = E.db.ProjectHopes.gcd.historyCount or 5  
local MAIN_ICON_SIZE = E.db.ProjectHopes.gcd.mainIconSize or 47
local MAX_HISTORY_COUNT = 10

-- Classic compatibility layer
local GetItemInfo = C_Item and C_Item.GetItemInfo or _G.GetItemInfo
local GetItemSpell = C_Item and C_Item.GetItemSpell or _G.GetItemSpell

local EquippedItems = {}

local equipmentSlots = {
	"HeadSlot", "NeckSlot", "ShoulderSlot",	"BackSlot", 
	"ChestSlot", "WristSlot",	"MainHandSlot",	"SecondaryHandSlot", 
	"HandsSlot",	"WaistSlot",	"LegsSlot",	"FeetSlot",
	"Finger0Slot",	"Finger1Slot",	"Trinket0Slot",	"Trinket1Slot",
}

local function IsSpellBlacklisted(spellID)
  if not spellID then return false end
  return E.db.ProjectHopes.gcd.blacklist and E.db.ProjectHopes.gcd.blacklist[spellID] or false
end

-- Classic-compatible spell info fetcher
local fetchSpellInfo = function(spellID)
	if not spellID then
		return nil
	end

	if E.Retail and C_Spell and C_Spell.GetSpellInfo then
		-- Retail version
		local spellInfo = C_Spell.GetSpellInfo(spellID)
		if spellInfo then
			return spellInfo.name, nil, spellInfo.iconID, spellInfo.castTime, spellInfo.minRange, spellInfo.maxRange,
				spellInfo.spellID, spellInfo.originalIconID
		end
	else
		-- Classic version
		return GetSpellInfo(spellID)
	end
end

-- Classic-compatible spell cooldown fetcher
local fetchSpellCooldown = function(spellID)
	if not spellID then
		return nil
	end
	
	if E.Retail and C_Spell and C_Spell.GetSpellCooldown then
		-- Retail version
		local spellCooldownInfo = C_Spell.GetSpellCooldown(spellID)
		if spellCooldownInfo then
			return spellCooldownInfo.startTime, spellCooldownInfo.duration, spellCooldownInfo.isEnabled,
				spellCooldownInfo.modRate
		end
	else
		-- Classic version
		return GetSpellCooldown(spellID)
	end
end

local function scanEquipment()
	for _, v in pairs(equipmentSlots) do
		local idx = GetInventorySlotInfo(string.upper(v))
		local itemid = GetInventoryItemID("player", idx)

		if itemid then
			local _, id = GetItemSpell(itemid)
			if id then
				EquippedItems[id] = itemid
			end
		end
	end
end

local function clearCooldown(self)
	self:Clear()
end

local function applyCooldown(self, start, duration, enable, forceShowDrawEdge, modRate)
	if enable and enable ~= 0 and start > 0 and duration > 0 then
		self:SetDrawEdge(forceShowDrawEdge)
		self:SetCooldown(start, duration, modRate)
	else
		clearCooldown(self)
	end
end

local function BuildIconFrame(parent, name)
	local frame = CreateFrame("Button", name, parent)
	
	frame.icon = frame:CreateTexture(nil, "BACKGROUND")
	frame.icon:SetAllPoints(frame)
	
	frame.cooldown = CreateFrame("Cooldown", nil, frame, "CooldownFrameTemplate")
	frame.cooldown:SetAllPoints(frame)
	frame.cooldown:SetReverse(true)
	frame.cooldown:SetDrawEdge(false)
			
	BORDER:CreateBorder(frame)
	
	return frame
end

function SpellHistory:Initialize()
	if not E.db.ProjectHopes.gcd.enable then return end
	
	self.lastSpellID = nil
	self.recentCasts = {}
	self.lastInterruptedIcon = nil
	self.lastInterruptedTime = 0
	self.lastSuccessIcon = nil
	self.lastSuccessTime = 0
	self.currentGCD = 1.5 / ((GetHaste() / 100) + 1)
	self.testMode = false

	self:BuildDisplay()
	self:SetupEventHandler()
	self:HookEvents()
	
	self.refreshTimer = self:ScheduleRepeatingTimer("RefreshDisplay", 0.25)
	
	scanEquipment()
end

function SpellHistory:BuildDisplay()
	self.display = {}
	self.mainAnchor = CreateFrame("Frame", "SpellHistoryAnchor", UIParent)
	
	-- Get size based on ratio setting
	local mainWidth, mainHeight
	if E.db.ProjectHopes.gcd.keepRatio then
		mainWidth = E.db.ProjectHopes.gcd.mainIconSize
		mainHeight = E.db.ProjectHopes.gcd.mainIconSize
	else
		mainWidth = E.db.ProjectHopes.gcd.mainIconWidth or MAIN_ICON_SIZE
		mainHeight = E.db.ProjectHopes.gcd.mainIconHeight or MAIN_ICON_SIZE
	end
	
	self.mainAnchor:SetSize(mainWidth, mainHeight)
	self.mainAnchor:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    
	E:CreateMover(self.mainAnchor, "SpellHistoryMover", "Spell History Tracker", nil, nil, nil, "ALL,GENERAL")

	for i = 0, MAX_HISTORY_COUNT do
		self.display[i] = BuildIconFrame(UIParent, "SpellHistoryDisplay"..i)

		if i == 0 then
			self.display[i]:SetPoint("CENTER", self.mainAnchor, "CENTER", 0, 0)
		else
			if GROWTH_DIRECTION == "LEFT" then
				self.display[i]:SetPoint("RIGHT", self.display[i - 1], "LEFT", -ICON_GAP, 0)
			elseif GROWTH_DIRECTION == "RIGHT" then
				self.display[i]:SetPoint("LEFT", self.display[i - 1], "RIGHT", ICON_GAP, 0)
			elseif GROWTH_DIRECTION == "UP" then
				self.display[i]:SetPoint("BOTTOM", self.display[i - 1], "TOP", 0, ICON_GAP)
			elseif GROWTH_DIRECTION == "DOWN" then
				self.display[i]:SetPoint("TOP", self.display[i - 1], "BOTTOM", 0, -ICON_GAP)
			end
		end

		-- Set size based on ratio or custom dimensions
		local width, height
		if i == 0 then
			if E.db.ProjectHopes.gcd.keepRatio then
				width = E.db.ProjectHopes.gcd.mainIconSize
				height = E.db.ProjectHopes.gcd.mainIconSize
			else
				width = E.db.ProjectHopes.gcd.mainIconWidth or MAIN_ICON_SIZE
				height = E.db.ProjectHopes.gcd.mainIconHeight or MAIN_ICON_SIZE
			end
		else
			if E.db.ProjectHopes.gcd.keepRatio then
				width = E.db.ProjectHopes.gcd.historyIconSize
				height = E.db.ProjectHopes.gcd.historyIconSize
			else
				width = E.db.ProjectHopes.gcd.historyIconWidth or ICON_SIZE
				height = E.db.ProjectHopes.gcd.historyIconHeight or ICON_SIZE
			end
		end
		
		self.display[i]:SetSize(width, height)
		self.display[i]:SetScale(1)
		self.display[i]:SetAlpha(1)
		self.display[i]:EnableMouse(false)
		self.display[i].icon:SetTexCoord(.08, .92, .08, .92)
		self.display[i]:Hide()

		self.display[i]:SetScript("OnEnter", function(s)
			if s.spellid and s.spellid > 0 then
				GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
				GameTooltip:SetSpellByID(s.spellid)
			elseif s.itemid and s.itemid > 0 then
				GameTooltip:SetOwner(s, "ANCHOR_RIGHT")
				GameTooltip:SetItemByID(s.itemid)
			end
		end)

		self.display[i]:SetScript("OnLeave", GameTooltip_Hide)
		self.display[i]:SetMouseMotionEnabled(true)
	end
end

function SpellHistory:SetupEventHandler()
	self.eventHandler = CreateFrame("Frame")
	self.eventHandler:SetScript("OnEvent", function(_, event, ...)
		if self[event] then
			self[event](self, event, ...)
		end
	end)
end

function SpellHistory:HookEvents()
	self.eventHandler:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")
	self.eventHandler:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED", "player")
	self.eventHandler:RegisterUnitEvent("UNIT_SPELLCAST_START", "player")
	self.eventHandler:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_START", "player")
	self.eventHandler:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_STOP", "player")
	self.eventHandler:RegisterUnitEvent("UNIT_SPELLCAST_STOP", "player")
	self.eventHandler:RegisterEvent("PLAYER_ENTERING_WORLD")
	self.eventHandler:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
end

function SpellHistory:RecordCast(spellid, wasFailed, isItem)
	if not spellid then return end

	local spellIDsToRecord = {}

	if isItem then
		local _, itemSpellID = GetItemSpell(spellid)
		if itemSpellID then
			if type(itemSpellID) == "table" then
				for _, id in ipairs(itemSpellID) do
					table.insert(spellIDsToRecord, id)
				end
			else
				table.insert(spellIDsToRecord, itemSpellID)
			end
		end
	else
		table.insert(spellIDsToRecord, spellid)
	end

	for _, id in ipairs(spellIDsToRecord) do
		if not IsSpellBlacklisted(id) then
			local name, discard, icon = fetchSpellInfo(id)
			if not icon or icon == 136243 then
				icon = nil
			end

			if icon then
				local timestamp = GetTime()
				local currentCount = E.db.ProjectHopes.gcd.historyCount or HISTORY_COUNT
				if #self.recentCasts >= currentCount then
					table.remove(self.recentCasts, currentCount)
				end
				table.insert(self.recentCasts, 1, { icon, _, wasFailed, timestamp, id })
			end
		end
	end
end

function SpellHistory:RefreshDisplay()
	local timestamp = GetTime()
	local currentCount = E.db.ProjectHopes.gcd.historyCount or HISTORY_COUNT
    
	for i = 1, MAX_HISTORY_COUNT do
		local cast = self.recentCasts[i]  
		local iconFrame = self.display[i]

		if i > currentCount then
			iconFrame:Hide()
		elseif cast then
			if not self.testMode and cast[4] and timestamp - cast[4] > 5 then
				iconFrame:Hide()
			else
				iconFrame.icon:SetTexture(cast[1])
				iconFrame.spellid = cast[5]
				iconFrame.itemid = cast[6] or nil  
				iconFrame:Show()

				if cast[3] then
					iconFrame.icon:SetDesaturated(true)
					iconFrame.icon:SetVertexColor(0.6352941176470588, 0.2196078431372549, 0.2196078431372549) 
				else
					iconFrame.icon:SetDesaturated(false)
					iconFrame.icon:SetVertexColor(1, 1, 1)
				end
			end
		else
			iconFrame:Hide()
		end
	end
end

function SpellHistory:UNIT_SPELLCAST_START(event, unit)
	if unit ~= "player" then return end
	
	local name, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible, spellid = UnitCastingInfo("player")
	local iconFrame = self.display[0]
	local frameIcon = iconFrame.icon
	local frameCooldown = iconFrame.cooldown

	if name and frameIcon then

		if IsSpellBlacklisted(spellid) then
			frameIcon:Hide()
			iconFrame:Hide()
			return
		end

		frameIcon:SetTexture(texture)
		iconFrame.spellid = spellid
		frameIcon:SetDesaturated(true)

		frameIcon:Show()
		local duration = (endTime - startTime) / 1000
		endTime = endTime / 1000
		applyCooldown(frameCooldown, endTime - duration, duration, duration > 0, true)
		frameCooldown:SetHideCountdownNumbers(true)
		iconFrame:Show()
	else
		frameIcon:Hide()
		iconFrame:Hide()
	end
end

function SpellHistory:UNIT_SPELLCAST_CHANNEL_START(event, unit)
	if unit ~= "player" then return end
	
	local name, text, texture, startTime, endTime, isTradeSkill, notInterruptible, spellid = UnitChannelInfo("player")
	local iconFrame = self.display[0]
	local frameIcon = iconFrame.icon
	local frameCooldown = iconFrame.cooldown

	if name and frameIcon then
		frameIcon:SetTexture(texture)
		iconFrame.spellid = spellid
		frameIcon:SetDesaturated(true)

		frameIcon:Show()
		local duration = (endTime - startTime) / 1000
		endTime = endTime / 1000
		applyCooldown(frameCooldown, endTime - duration, duration, duration > 0, true)
		frameCooldown:SetHideCountdownNumbers(true)
		iconFrame:Show()
	else
		frameIcon:Hide()
		iconFrame:Hide()
	end
end

function SpellHistory:UNIT_SPELLCAST_STOP(event, unit)
	if unit ~= "player" then return end
	
	local name = UnitCastingInfo("player")
	if not name then
		self.display[0]:Hide()
	end
end

function SpellHistory:UNIT_SPELLCAST_CHANNEL_STOP(event, unit)
	if unit ~= "player" then return end
	
	local name = UnitChannelInfo("player")
	if not name then
		self.display[0]:Hide()
	end
end

function SpellHistory:UNIT_SPELLCAST_SUCCEEDED(event, unit, castGUID, spellid)
	if unit ~= "player" then return end
	
	local name, discard, icon = fetchSpellInfo(spellid)
	local gcd = select(2, fetchSpellCooldown(61304))
	local curtime = GetTime()

	if gcd > 0 then
		self.currentGCD = gcd
	end

	if (self.lastSuccessIcon and self.lastSuccessIcon == icon and (curtime - self.lastSuccessTime) < self.currentGCD) then
		return
	end

	local itemid = EquippedItems[spellid]

	if itemid then
		self:RecordCast(itemid, nil, true)
	else
		self:RecordCast(spellid, nil)
	end
	
	self.lastSuccessIcon = icon
	self.lastSuccessTime = curtime
end

function SpellHistory:UNIT_SPELLCAST_INTERRUPTED(event, unit, castGUID, spellid)
	if unit ~= "player" then return end
	
	local name, discard, icon = fetchSpellInfo(spellid)
	local gcd = select(2, fetchSpellCooldown(61304))
	local curtime = GetTime()

	if gcd > 0 then
		self.currentGCD = gcd
	end

	if (self.lastInterruptedIcon and self.lastInterruptedIcon == icon and (curtime - self.lastInterruptedTime) < self.currentGCD) then
		return
	end
	
	local itemid = EquippedItems[spellid]

	if itemid then
		self:RecordCast(itemid, true, true)
	else
		self:RecordCast(spellid, true)
	end
	
	self.lastInterruptedIcon = icon
	self.lastInterruptedTime = curtime
end

function SpellHistory:PLAYER_ENTERING_WORLD()
	scanEquipment()
end

function SpellHistory:PLAYER_EQUIPMENT_CHANGED()
	scanEquipment()
end

function SpellHistory:UpdateMainIconSize()
	if not self.display or not self.display[0] then return end
	
	local width, height
	if E.db.ProjectHopes.gcd.keepRatio then
		MAIN_ICON_SIZE = E.db.ProjectHopes.gcd.mainIconSize
		width = MAIN_ICON_SIZE
		height = MAIN_ICON_SIZE
	else
		width = E.db.ProjectHopes.gcd.mainIconWidth or MAIN_ICON_SIZE
		height = E.db.ProjectHopes.gcd.mainIconHeight or MAIN_ICON_SIZE
	end
	
	self.display[0]:SetSize(width, height)
	self.mainAnchor:SetSize(width, height)
end

function SpellHistory:UpdateHistoryIconSize()
	if not self.display then return end
	
	local width, height
	if E.db.ProjectHopes.gcd.keepRatio then
		ICON_SIZE = E.db.ProjectHopes.gcd.historyIconSize
		width = ICON_SIZE
		height = ICON_SIZE
	else
		width = E.db.ProjectHopes.gcd.historyIconWidth or ICON_SIZE
		height = E.db.ProjectHopes.gcd.historyIconHeight or ICON_SIZE
	end
	
	for i = 1, MAX_HISTORY_COUNT do
		self.display[i]:SetSize(width, height)
	end
end

function SpellHistory:UpdateHistoryCount()
	HISTORY_COUNT = E.db.ProjectHopes.gcd.historyCount
	
	if not self.display then return end
	
	while #self.recentCasts > HISTORY_COUNT do
		table.remove(self.recentCasts)
	end
	
	self:RefreshDisplay()
end

function SpellHistory:UpdateGrowthDirection()
	GROWTH_DIRECTION = E.db.ProjectHopes.gcd.growth or "LEFT"
	
	if not self.display then return end
	
	for i = 1, MAX_HISTORY_COUNT do
		self.display[i]:ClearAllPoints()
		
		if GROWTH_DIRECTION == "LEFT" then
			self.display[i]:SetPoint("RIGHT", self.display[i - 1], "LEFT", -ICON_GAP, 0)
		elseif GROWTH_DIRECTION == "RIGHT" then
			self.display[i]:SetPoint("LEFT", self.display[i - 1], "RIGHT", ICON_GAP, 0)
		elseif GROWTH_DIRECTION == "UP" then
			self.display[i]:SetPoint("BOTTOM", self.display[i - 1], "TOP", 0, ICON_GAP)
		elseif GROWTH_DIRECTION == "DOWN" then
			self.display[i]:SetPoint("TOP", self.display[i - 1], "BOTTOM", 0, -ICON_GAP)
		end
	end
end

function SpellHistory:TestDisplay()
	if self.testMode then
		self.testMode = false
		wipe(self.recentCasts)
		self.display[0]:Hide()
		self:RefreshDisplay()
	else
		self.testMode = true
		local HistoryIcon = 136183
		local CastIcon = 136243
		local timestamp = GetTime()
		wipe(self.recentCasts)
		
		local currentCount = E.db.ProjectHopes.gcd.historyCount or HISTORY_COUNT
		for i = 1, currentCount do
			table.insert(self.recentCasts, { HistoryIcon, nil, false, timestamp, 0 })
		end
		
		local iconFrame = self.display[0]
		iconFrame.icon:SetTexture(CastIcon)
		iconFrame.icon:SetDesaturated(false)
		iconFrame.icon:SetVertexColor(1, 1, 1)
		iconFrame.spellid = 0
		iconFrame:Show()
		
		self:RefreshDisplay()
	end
end

E:RegisterModule(SpellHistory:GetName())