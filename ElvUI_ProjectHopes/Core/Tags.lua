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

E:AddTag("Hopes:leader", "GROUP_ROSTER_UPDATE", function(unit)
	local leader = UnitIsGroupLeader(unit)
	local assist = UnitIsGroupAssistant(unit)
	local isTank = GetPartyAssignment("MAINTANK", unit)
	local isMainAssist = GetPartyAssignment("MAINASSIST", unit)
	if leader and not assist and not isTank and not isMainAssist then
		return "|TInterface\\GROUPFRAME\\UI-GROUP-LEADERICON.BLP:0:0:0:0|t"
	elseif assist and not leader and not isTank and not isMainAssist then
		return "|TInterface\\GROUPFRAME\\UI-GROUP-ASSISTANTICON.BLP:0:0:0:0|t"
	elseif isTank and isMainAssist and not leader and not assist then
		return "|TInterface\\GROUPFRAME\\UI-GROUP-MAINTANKICON.BLP:0:0:0:0|t".."|TInterface\\GROUPFRAME\\UI-GROUP-MAINASSISTICON.BLP:0:0:0:0|t"
	elseif isTank and not isMainAssist and not leader and not assist then
		return "|TInterface\\GROUPFRAME\\UI-GROUP-MAINTANKICON.BLP:0:0:0:0|t"
	elseif isMainAssist and not isTank and not leader and not assist then
		return "|TInterface\\GROUPFRAME\\UI-GROUP-MAINASSISTICON.BLP:0:0:0:0|t"
	elseif leader and isTank then
		return "|TInterface\\GROUPFRAME\\UI-GROUP-LEADERICON.BLP:0:0:0:0|t".."|TInterface\\GROUPFRAME\\UI-GROUP-MAINTANKICON.BLP:0:0:0:0|t"
	elseif assist and isTank and not isMainAssist and not leader then
		return "|TInterface\\GROUPFRAME\\UI-GROUP-ASSISTANTICON.BLP:0:0:0:0|t".."|TInterface\\GROUPFRAME\\UI-GROUP-MAINTANKICON.BLP:0:0:0:0|t"
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