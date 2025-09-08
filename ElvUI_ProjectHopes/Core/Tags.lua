local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)
local Translit = E.Libs.Translit
local translitMark = "!"

local strfind, strmatch, utf8lower, utf8sub = strfind, strmatch, string.utf8lower, string.utf8sub
local gmatch, gsub, format, tonumber, strsplit = gmatch, gsub, format, tonumber, strsplit

local UnitName = UnitName
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax
local UnitIsConnected = UnitIsConnected
local UnitIsDead = UnitIsDead
local UnitIsGhost = UnitIsGhost
local UnitPower = UnitPower
local UnitIsPlayer = UnitIsPlayer
local UnitPowerType = UnitPowerType
local UnitPowerMax = UnitPowerMax
local UnitGetIncomingHeals = UnitGetIncomingHeals
local UnitGetTotalAbsorbs = UnitGetTotalAbsorbs
local UnitGetTotalHealAbsorbs = UnitGetTotalHealAbsorbs
local UnitClass = UnitClass
local UnitGUID = UnitGUID
local UnitIsAFK = UnitIsAFK
local UnitIsDND = UnitIsDND

local strupper = strupper
local UnitGroupRolesAssigned = UnitGroupRolesAssigned
local UnitIsGroupLeader = UnitIsGroupLeader
local UnitIsGroupAssistant = UnitIsGroupAssistant
local GetPartyAssignment = GetPartyAssignment
local GetRaidTargetIndex = GetRaidTargetIndex

local function abbrev(name)
	local letters, lastWord = '', strmatch(name, '.+%s(.+)$')
	if lastWord then
		for word in gmatch(name, '.-%s') do
			local firstLetter = utf8sub(gsub(word, '^[%s%p]*', ''), 1, 1)
			if firstLetter ~= utf8lower(firstLetter) then
				letters = format('%s%s. ', letters, firstLetter)
			end
		end
		name = format('%s%s', letters, lastWord)
	end
	return name
end

E:AddTag('Hopes:perhp', 'UNIT_HEALTH UNIT_MAXHEALTH UNIT_ABSORB_AMOUNT_CHANGED UNIT_CONNECTION UNIT_NAME_UPDATE', function(unit)
	local status = UnitIsDead(unit) and L["Dead"] or UnitIsGhost(unit) and L["Ghost"] or not UnitIsConnected(unit) and L["Offline"]
	local absorb = UnitGetTotalAbsorbs(unit) or 0
	local health = UnitHealth(unit)
	local max = UnitHealthMax(unit)
	local CurrentPercent = (health/max)*100
	local absorbper = (absorb/max)*100
	local tper = CurrentPercent + absorbper
	if (status) then
		return status
	elseif	absorb == 0 then
		return format("%.0f", CurrentPercent)
	else
		return format("%.0f", tper)
	end
end, not E.Retail)

E:AddTag('Hopes:maxhealth:percent', 'UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION UNIT_NAME_UPDATE', function(unit)
	local status = UnitIsDead(unit) and L["Dead"] or UnitIsGhost(unit) and L["Ghost"] or not UnitIsConnected(unit) and L["Offline"]
	local health = UnitHealth(unit)
	local max = UnitHealthMax(unit)
	local CurrentPercent = (health/max)*100
	
	if (status) then
		return status
	elseif health == max then
		return E:ShortValue(health)
	else
		return format("%.0f", CurrentPercent)
	end
end)

E:AddTag('Hopes:healabsorbs', 'UNIT_HEAL_ABSORB_AMOUNT_CHANGED', function(unit)
    local healAbsorb = UnitGetTotalHealAbsorbs(unit) or 0
    if healAbsorb ~= 0 then
        return E:ShortValue(healAbsorb)
	end
end, not E.Retail)

E:AddTag('Hopes:role', 'UNIT_NAME_UPDATE PLAYER_ROLES_ASSIGNED GROUP_ROSTER_UPDATE', function(unit, _, args)
	local v = tonumber(args) or 1
	local role = UnitGroupRolesAssigned(unit)

	if v == 1 then
		do
			local icon = { HEALER = "|TInterface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\Roles\\HEALER:0:0:0:0|t",
							DAMAGER = "|TInterface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\Roles\\DPS:0:0:0:0|t",
							TANK = "|TInterface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\Roles\\TANK:0:0:0:0|t"
		}
			return icon[role]
		end
	end
end)

E:AddTag('Hopes:roletext', 'UNIT_NAME_UPDATE PLAYER_ROLES_ASSIGNED GROUP_ROSTER_UPDATE', function(unit, _, args)
	local v = tonumber(args) or 1
	local role = UnitGroupRolesAssigned(unit)

	if v == 1 then
		local roleText = {
			HEALER = "|cff00ff96HEALER|r",
			TANK = "|cff00a5ffTANK|r"
		}
		return roleText[role]
	end
end)

E:AddTag("Hopes:leader", "GROUP_ROSTER_UPDATE", function(unit)
    local leader = UnitIsGroupLeader(unit)
    local assist = UnitIsGroupAssistant(unit)

    local icon = { 
        leader = "|TInterface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\Roles\\LEADER:0:0:0:0|t",
        assist = "|TInterface\\AddOns\\ElvUI_ProjectHopes\\Media\\Textures\\Roles\\ASSIST:0:0:0:0|t",
    }

    if leader then
        return icon.leader
    elseif assist then
        return icon.assist
    end
end)


E:AddTag("Hopes:raidmarker", 'RAID_TARGET_UPDATE', function(unit)
	local index = GetRaidTargetIndex(unit)
	local mark
	if index then
		mark = "|TINTERFACE\\TARGETINGFRAME\\UI-RaidTargetingIcon_"..index..".blp:0:0:0:0|t"
	end
	return mark
end)

E:AddTag('Hopes:perpp', 'UNIT_POWER_FREQUENT UNIT_MAXPOWER UNIT_DISPLAYPOWER UNIT_CONNECTION', function(unit)
    local status = UnitIsDead(unit) and L["Dead"] or UnitIsGhost(unit) and L["Ghost"] or not UnitIsConnected(unit) and L["Offline"]
    local powerType = UnitPowerType(unit)
    local cur = UnitPower(unit, powerType)
    local max = UnitPowerMax(unit, powerType)

    if status or (powerType ~= 0 and cur == 0) or max == 0 then
        return nil
    else
        return format("%.0f", (cur / max) * 100)
    end
end)

-- Hex colors for raid markers
local markerToHex = {
	[1] = "|cFFEAEA0D", -- Yellow Star
	[2] = "|cFFEAB10D", -- Orange Circle
	[3] = "|cFFCD00FF", -- Purple Diamond
	[4] = "|cFF06D425", -- Green Triangle
	[5] = "|cFFB3E3D8", -- Light Blue Moon
	[6] = "|cFF0CD2EA", -- Blue Square
	[7] = "|cFFD6210B", -- Red Cross
	[8] = "|cFFFFFFFF", -- White Skull
}

-- Words to remove from names
local nameBlacklist = {
	["the"] = true, ["of"] = true, ["Tentacle"] = true,
	["Apprentice"] = true, ["Denizen"] = true, ["Emissary"] = true,
	["Howlis"] = true, ["Terror"] = true, ["Totem"] = true,
	["Waycrest"] = true, ["Aspect"] = true
}

E:AddTag("Hopes:name", "UNIT_NAME_UPDATE UNIT_HEALTH UNIT_TARGET PLAYER_FLAGS_CHANGED RAID_TARGET_UPDATE", function(unit)
	local name = UnitName(unit)
	if not name then
			return ""
	end
	
	local a, b, c, d, e, f = strsplit(" ", name, 5)

	if nameBlacklist[b] then
			name = a or b or c or d or e or f or name
	else
			name = f or e or d or c or b or a or name
	end

	local marker = GetRaidTargetIndex(unit)
	if marker and markerToHex[marker] then
			name = markerToHex[marker] .. name .. "|r"
	end

	return name
end)

local unitStatus = {}
E:AddTag("Hopes:statustimer", 1, function(unit)
	if not UnitIsPlayer(unit) then return end
	
	local guid = UnitGUID(unit)
	if not guid then return end
	
	local currentStatus = unitStatus[guid]
	local newStatusType
	
	if not UnitIsConnected(unit) then
		newStatusType = "Offline"
	elseif UnitIsDead(unit) or UnitIsGhost(unit) then
		newStatusType = "Dead"
	elseif UnitIsAFK(unit) then
		newStatusType = "AFK"
	elseif UnitIsDND(unit) then
		newStatusType = "DND"
	end
	
	if newStatusType then
		if not currentStatus or currentStatus[1] ~= newStatusType then
			unitStatus[guid] = { newStatusType, GetTime() }
		end
	else
		unitStatus[guid] = nil
		return
	end
	
	local timer = GetTime() - unitStatus[guid][2]
	local mins = floor(timer / 60)
	local secs = floor(timer % 60)
	return format("%01.f:%02.f", mins, secs)
end)