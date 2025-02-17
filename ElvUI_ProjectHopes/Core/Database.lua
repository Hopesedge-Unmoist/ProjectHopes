local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

-- Dragonflight layout
function ProjectHopes:Setup_ElvUI(layout)
	-- AB conversion
	E.db["convertPages"] = true
	-- Protect movers error
	E.db.movers = E.db.movers or {}
	-- UI Scale
	E.global["general"]["UIScale"] = 0.53333333333333
	E.db["general"]["loginmessage"] = false

	-- Custom Texts 
	if E.Retail or E.Cata then
		-- Boss
		E.db["unitframe"]["units"]["boss"]["customTexts"] = E.db["unitframe"]["units"]["boss"]["customTexts"] or {}
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Name"] = {["enable"] = true}
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Health"] = {["enable"] = true}
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:HealthCurrent"] = {["enable"] = true}

		-- Focus
		E.db["unitframe"]["units"]["focus"]["customTexts"] = E.db["unitframe"]["units"]["focus"]["customTexts"] or {}
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Name"] = {["enable"] = true}
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Health"] = {["enable"] = true}
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:HealthCurrent"] = {["enable"] = true}
	end
	-- Party
	E.db["unitframe"]["units"]["party"]["customTexts"] = E.db["unitframe"]["units"]["party"]["customTexts"] or {}
	E.db["unitframe"]["units"]["party"]["customTexts"]["Party:Name"] = {["enable"] = true}
	E.db["unitframe"]["units"]["party"]["customTexts"]["Party:Health"] = {["enable"] = true}
	E.db["unitframe"]["units"]["party"]["customTexts"]["Party:HealAbsorb"] = {["enable"] = true}
	-- Raid1
	E.db["unitframe"]["units"]["raid1"]["customTexts"] = E.db["unitframe"]["units"]["raid1"]["customTexts"] or {}
	E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Health"] = {["enable"] = true}
	E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Name"] = {["enable"] = true}
	E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:HealAbsorb"] = {["enable"] = true}
	-- Player
	E.db["unitframe"]["units"]["player"]["customTexts"] = E.db["unitframe"]["units"]["player"]["customTexts"] or {}
	E.db["unitframe"]["units"]["player"]["customTexts"]["Player:Name"] = {["enable"] = true}
	E.db["unitframe"]["units"]["player"]["customTexts"]["Player:Health"] = {["enable"] = true}
	E.db["unitframe"]["units"]["player"]["customTexts"]["Player:HealthCurrent"] = {["enable"] = true}
		-- Target
	E.db["unitframe"]["units"]["target"]["customTexts"] = E.db["unitframe"]["units"]["target"]["customTexts"] or {}
	E.db["unitframe"]["units"]["target"]["customTexts"]["Target:Name"] = {["enable"] = true}
	E.db["unitframe"]["units"]["target"]["customTexts"]["Target:Health"] = {["enable"] = true}
	E.db["unitframe"]["units"]["target"]["customTexts"]["Target:HealthCurrent"] = {["enable"] = true}

	-- Target of Target
	E.db["unitframe"]["units"]["targettarget"]["customTexts"] = E.db["unitframe"]["units"]["targettarget"]["customTexts"] or {}
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["TargetTarget:Name"] = {["enable"] = true}


	-- Data Texts
	E.db["datatexts"]["font"] = "Expressway"
	E.db["datatexts"]["fontOutline"] = "OUTLINE"
	E.db["datatexts"]["panels"]["LeftChatDataPanel"]["enable"] = false
	E.db["datatexts"]["panels"]["RightChatDataPanel"]["enable"] = false
	E.db["datatexts"]["panels"]["MinimapPanel"]["enable"] = false
	E.db["datatexts"]["panels"]["MinimapTime"] = E.db["datatexts"]["panels"]["MinimapTime"] or {}
	E.db["datatexts"]["panels"]["MinimapTime"] = {["enable"] = true}
	E.db["datatexts"]["panels"]["MinimapTime"][1] = "Time"
	E.db["datatexts"]["panels"]["MinimapTime"]["battleground"] = false
	E.db["datatexts"]["panels"]["MinimapTime"]["visibility"] = ""

	
	-- Actionbars
	E.db["WeakAuras"]["cooldown"]["showModRate"] = true
	E.db["actionbar"]["colorSwipeNormal"]["a"] = 0.80000001192093
	E.db["actionbar"]["cooldown"]["fonts"]["font"] = "Expressway"
	E.db["actionbar"]["cooldown"]["fonts"]["fontSize"] = 28
	E.db["actionbar"]["cooldown"]["override"] = false
	E.db["actionbar"]["desaturateOnCooldown"] = true
	E.db["actionbar"]["extraActionButton"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["extraActionButton"]["hotkeyFontSize"] = 12
	E.db["actionbar"]["font"] = "Expressway"
	E.db["actionbar"]["fontOutline"] = "OUTLINE"
	E.db["actionbar"]["fontSize"] = 12
	E.db["actionbar"]["globalFadeAlpha"] = 0
	E.db["actionbar"]["handleOverlay"] = false
	E.db["actionbar"]["hideCooldownBling"] = true
	E.db["actionbar"]["extraActionButton"]["clean"] = true
	E.db["actionbar"]["zoneActionButton"]["clean"] = true
		-- Actionbars placement
	E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,356"
	E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,0,314"
	E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,-405,9"
	E.db["movers"]["ElvAB_4"] = "BOTTOM,ElvUIParent,BOTTOM,405,9"
	E.db["movers"]["ElvAB_5"] = "BOTTOM,ElvUIParent,BOTTOM,0,53"
	E.db["movers"]["ElvAB_6"] = "BOTTOM,ElvUIParent,BOTTOM,0,9"
	E.db["movers"]["ElvAB_7"] = "TOPRIGHT,UIParent,TOPRIGHT,-4,-495"
	E.db["movers"]["PetAB"] = "TOPRIGHT,UIParent,TOPRIGHT,-45,-549"
	E.db["movers"]["ShiftAB"] = "BOTTOM,ElvUIParent,BOTTOM,225,98"
		-- Actionbar 1
	E.db["actionbar"]["bar1"]["enabled"] = true
	E.db["actionbar"]["bar1"]["buttonSize"] = 40
	E.db["actionbar"]["bar1"]["buttonSpacing"] = 6
	E.db["actionbar"]["bar1"]["buttons"] = 10
	E.db["actionbar"]["bar1"]["countFont"] = "Expressway"
	E.db["actionbar"]["bar1"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar1"]["countFontSize"] = 15
	E.db["actionbar"]["bar1"]["hotkeyFont"] = "Expressway"
	E.db["actionbar"]["bar1"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar1"]["hotkeyFontSize"] = 12
	E.db["actionbar"]["bar1"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar1"]["macroFontSize"] = 12
		-- Actionbar 2
	E.db["actionbar"]["bar2"]["enabled"] = true
	E.db["actionbar"]["bar2"]["buttonSize"] = 36
	E.db["actionbar"]["bar2"]["buttonSpacing"] = 6
	E.db["actionbar"]["bar2"]["buttons"] = 11
	E.db["actionbar"]["bar2"]["countFont"] = "Expressway"
	E.db["actionbar"]["bar2"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar2"]["countFontSize"] = 14
	E.db["actionbar"]["bar2"]["hotkeyFont"] = "Expressway"
	E.db["actionbar"]["bar2"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar2"]["hotkeyFontSize"] = 12
	E.db["actionbar"]["bar2"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar2"]["macroFontSize"] = 12
		-- Actionbar 3
	E.db["actionbar"]["bar3"]["enabled"] = true
	E.db["actionbar"]["bar3"]["buttonSize"] = 39
	E.db["actionbar"]["bar3"]["buttonSpacing"] = 6
	E.db["actionbar"]["bar3"]["buttons"] = 12
	E.db["actionbar"]["bar3"]["buttonsPerRow"] = 6
	E.db["actionbar"]["bar3"]["countFont"] = "Expressway"
	E.db["actionbar"]["bar3"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar3"]["countFontSize"] = 12
	E.db["actionbar"]["bar3"]["hotkeyFont"] = "Expressway"
	E.db["actionbar"]["bar3"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar3"]["hotkeyFontSize"] = 12
	E.db["actionbar"]["bar3"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar3"]["macroFontSize"] = 12
	E.db["actionbar"]["bar3"]["mouseover"] = true
		-- Actionbar 4
	E.db["actionbar"]["bar4"]["enabled"] = true
	E.db["actionbar"]["bar4"]["backdrop"] = false
	E.db["actionbar"]["bar4"]["buttonSize"] = 39
	E.db["actionbar"]["bar4"]["buttonSpacing"] = 6
	E.db["actionbar"]["bar4"]["buttons"] = 12
	E.db["actionbar"]["bar4"]["buttonsPerRow"] = 6
	E.db["actionbar"]["bar4"]["countFont"] = "Expressway"
	E.db["actionbar"]["bar4"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar4"]["countFontSize"] = 12
	E.db["actionbar"]["bar4"]["hotkeyFont"] = "Expressway"
	E.db["actionbar"]["bar4"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar4"]["hotkeyFontSize"] = 12
	E.db["actionbar"]["bar4"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar4"]["macroFontSize"] = 12
	E.db["actionbar"]["bar4"]["mouseover"] = true
		-- Actionbar 5
	E.db["actionbar"]["bar5"]["enabled"] = true
	E.db["actionbar"]["bar5"]["buttonSize"] = 39
	E.db["actionbar"]["bar5"]["buttonSpacing"] = 6
	E.db["actionbar"]["bar5"]["buttons"] = 12
	E.db["actionbar"]["bar5"]["buttonsPerRow"] = 12
	E.db["actionbar"]["bar5"]["countFont"] = "Expressway"
	E.db["actionbar"]["bar5"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar5"]["countFontSize"] = 12
	E.db["actionbar"]["bar5"]["hotkeyFont"] = "Expressway"
	E.db["actionbar"]["bar5"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar5"]["hotkeyFontSize"] = 12
	E.db["actionbar"]["bar5"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar5"]["macroFontSize"] = 12
	E.db["actionbar"]["bar5"]["mouseover"] = true
		-- Actionbar 6
	E.db["actionbar"]["bar6"]["enabled"] = true
	E.db["actionbar"]["bar6"]["buttonSize"] = 39
	E.db["actionbar"]["bar6"]["buttonSpacing"] = 6
	E.db["actionbar"]["bar6"]["countFont"] = "Expressway"
	E.db["actionbar"]["bar6"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar6"]["countFontSize"] = 12
	E.db["actionbar"]["bar6"]["hotkeyFont"] = "Expressway"
	E.db["actionbar"]["bar6"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar6"]["hotkeyFontSize"] = 12
	E.db["actionbar"]["bar6"]["buttons"] = 12
	E.db["actionbar"]["bar6"]["buttonsPerRow"] = 12
	E.db["actionbar"]["bar6"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar6"]["macroFontSize"] = 12
	E.db["actionbar"]["bar6"]["mouseover"] = true
		-- Actionbar 7
	E.db["actionbar"]["bar7"]["enabled"] = true
	E.db["actionbar"]["bar7"]["buttonSize"] = 32
	E.db["actionbar"]["bar7"]["buttonSpacing"] = 6
	E.db["actionbar"]["bar7"]["countFont"] = "Expressway"
	E.db["actionbar"]["bar7"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar7"]["countFontSize"] = 12
	E.db["actionbar"]["bar7"]["hotkeyFont"] = "Expressway"
	E.db["actionbar"]["bar7"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar7"]["hotkeyFontSize"] = 12
	E.db["actionbar"]["bar7"]["buttons"] = 12
	E.db["actionbar"]["bar7"]["buttonsPerRow"] = 1
	E.db["actionbar"]["bar7"]["macroFontOutline"] = "OUTLINE"
	E.db["actionbar"]["bar7"]["macroFontSize"] = 12
	E.db["actionbar"]["bar7"]["mouseover"] = true
		-- Actionbar 8
	E.db["actionbar"]["bar8"]["enabled"] = false
		-- Actionbar 9
	E.db["actionbar"]["bar9"]["enabled"] = false
		-- Actionbar 10
	E.db["actionbar"]["bar10"]["enabled"] = false
		-- Actionbar 13
	E.db["actionbar"]["bar13"]["enabled"] = false
		-- Actionbar 14
	E.db["actionbar"]["bar14"]["enabled"] = false
		-- Actionbar 15
	E.db["actionbar"]["bar15"]["enabled"] = false
		-- Actionbar Pet
	E.db["actionbar"]["barPet"]["enabled"] = true
	E.db["actionbar"]["barPet"]["countFontOutline"] = "OUTLINE"
	E.db["actionbar"]["barPet"]["countFontSize"] = 12
	E.db["actionbar"]["barPet"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["barPet"]["hotkeyFontSize"] = 12
	E.db["actionbar"]["barPet"]["mouseover"] = true
		-- Actionbar Stance
	E.db["actionbar"]["stanceBar"]["enabled"] = true
	E.db["actionbar"]["stanceBar"]["buttonSize"] = 39
	E.db["actionbar"]["stanceBar"]["buttonSpacing"] = 6
	E.db["actionbar"]["stanceBar"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["stanceBar"]["hotkeyFontSize"] = 12
	E.db["actionbar"]["stanceBar"]["mouseover"] = true
		-- Actionbar Vehicle
	E.db["actionbar"]["vehicleExitButton"]["hotkeyFontOutline"] = "OUTLINE"
	E.db["actionbar"]["vehicleExitButton"]["hotkeyFontSize"] = 12

	-- Auras
	E.db["auras"]["buffs"]["countFont"] = "Expressway"
	E.db["auras"]["buffs"]["countFontOutline"] = "OUTLINE"
	E.db["auras"]["buffs"]["countFontSize"] = 12
	E.db["auras"]["buffs"]["fadeThreshold"] = -1
	E.db["auras"]["buffs"]["maxWraps"] = 2
	E.db["auras"]["buffs"]["size"] = 38
	E.db["auras"]["buffs"]["timeFont"] = "Expressway"
	E.db["auras"]["buffs"]["timeFontOutline"] = "OUTLINE"
	E.db["auras"]["buffs"]["timeFontSize"] = 12
	E.db["auras"]["buffs"]["timeYOffset"] = -3
	E.db["auras"]["buffs"]["verticalSpacing"] = 21
	E.db["auras"]["buffs"]["wrapAfter"] = 15
	E.db["auras"]["debuffs"]["countFont"] = "Expressway"
	E.db["auras"]["debuffs"]["countFontSize"] = 12
	E.db["auras"]["debuffs"]["size"] = 59
	E.db["auras"]["debuffs"]["timeFont"] = "Expressway"
	E.db["auras"]["debuffs"]["timeFontOutline"] = "OUTLINE"
	E.db["auras"]["debuffs"]["timeFontSize"] = 12
	E.db["auras"]["debuffs"]["timeYOffset"] = -5

	-- Bags
	E.db["bags"]["bagButtonSpacing"] = 6
	E.db["bags"]["bagSize"] = 37
	E.db["bags"]["bagWidth"] = 487
	E.db["bags"]["bankButtonSpacing"] = 6
	E.db["bags"]["bankSize"] = 37
	E.db["bags"]["bankWidth"] = 698
	E.db["bags"]["clearSearchOnClose"] = true
	E.db["bags"]["colors"]["assignment"]["junk"]["b"] = 1
	E.db["bags"]["colors"]["assignment"]["junk"]["g"] = 1
	E.db["bags"]["colors"]["assignment"]["junk"]["r"] = 1
	E.db["bags"]["colors"]["assignment"]["tradegoods"]["b"] = 0.49019610881805
	E.db["bags"]["colors"]["assignment"]["tradegoods"]["g"] = 0.23137256503105
	E.db["bags"]["colors"]["assignment"]["tradegoods"]["r"] = 0.74117648601532
	E.db["bags"]["colors"]["items"]["questStarter"]["b"] = 0.41176474094391
	E.db["bags"]["colors"]["items"]["questStarter"]["g"] = 0.96078437566757
	E.db["bags"]["countFont"] = "Expressway"
	E.db["bags"]["countFontOutline"] = "OUTLINE"
	E.db["bags"]["countFontSize"] = 12
	E.db["bags"]["disableBagSort"] = true
	E.db["bags"]["itemInfoFont"] = "Expressway"
	E.db["bags"]["itemInfoFontOutline"] = "OUTLINE"
	E.db["bags"]["itemLevelFont"] = "Expressway"
	E.db["bags"]["itemLevelFontOutline"] = "OUTLINE"
	E.db["bags"]["itemLevelFontSize"] = 12
	E.db["bags"]["junkDesaturate"] = true
	E.db["bags"]["split"]["bag5"] = true
	E.db["bags"]["split"]["bagSpacing"] = 8
	E.db["bags"]["split"]["player"] = true
	E.db["bags"]["vendorGrays"]["details"] = true
	E.db["bags"]["vendorGrays"]["enable"] = true

	-- Chat
	E.db["chat"]["font"] = "Expressway"
	E.db["chat"]["fontOutline"] = "OUTLINE"
	E.db["chat"]["fontSize"] = 12
	E.db["chat"]["lfgIcons"] = false
	E.db["chat"]["panelBackdrop"] = "HIDEBOTH"
	E.db["chat"]["panelColor"]["a"] = 1
	E.db["chat"]["panelColor"]["b"] = 0.12549020349979
	E.db["chat"]["panelColor"]["g"] = 0.12549020349979
	E.db["chat"]["panelColor"]["r"] = 0.12549020349979
	E.db["chat"]["panelHeight"] = 210
	E.db["chat"]["panelWidth"] = 508
	E.db["chat"]["tabFont"] = "Expressway"
	E.db["chat"]["tabFontOutline"] = "OUTLINE"
	E.db["chat"]["tabSelector"] = "NONE"
	E.db["chat"]["hideVoiceButtons"] = true

	-- Cooldown
	E.db["cooldown"]["daysColor"]["b"] = 0.7294117808342
	E.db["cooldown"]["daysColor"]["g"] = 0.54901963472366
	E.db["cooldown"]["daysColor"]["r"] = 0.95686280727386
	E.db["cooldown"]["expiringColor"]["b"] = 0.22745099663734
	E.db["cooldown"]["expiringColor"]["g"] = 0.1803921610117
	E.db["cooldown"]["expiringColor"]["r"] = 0.67058825492859
	E.db["cooldown"]["fonts"]["enable"] = true
	E.db["cooldown"]["fonts"]["font"] = "Expressway"
	E.db["cooldown"]["fonts"]["fontSize"] = 20
	E.db["cooldown"]["hideBlizzard"] = true
	E.db["cooldown"]["hoursColor"]["b"] = 0.7294117808342
	E.db["cooldown"]["hoursColor"]["g"] = 0.54901963472366
	E.db["cooldown"]["hoursColor"]["r"] = 0.95686280727386
	E.db["cooldown"]["minutesColor"]["b"] = 0.027450982481241
	E.db["cooldown"]["minutesColor"]["g"] = 0.77647066116333
	E.db["cooldown"]["secondsColor"]["b"] = 0.027450982481241
	E.db["cooldown"]["secondsColor"]["g"] = 0.77647066116333
	E.db["cooldown"]["showModRate"] = true
	E.db["cooldown"]["threshold"] = 4
	E.db["cooldown"]["useIndicatorColor"] = true

	-- Data Bars
	E.db["databars"]["azerite"]["enable"] = false
	E.db["databars"]["experience"]["enable"] = false
	E.db["databars"]["honor"]["enable"] = false
	E.db["databars"]["threat"]["enable"] = false



	-- General
	E.db["general"]["altPowerBar"]["enable"] = true
	E.db["general"]["altPowerBar"]["width"] = 250
	E.db["general"]["altPowerBar"]["height"] = 20
	E.db["general"]["altPowerBar"]["smoothbars"] = false
	E.db["general"]["altPowerBar"]["statusBar"] = "HopesUI"
	E.db["general"]["altPowerBar"]["statusBarColor"]["b"] = 0.027450982481241
	E.db["general"]["altPowerBar"]["statusBarColor"]["g"] = 0.77647066116333
	E.db["general"]["altPowerBar"]["statusBarColor"]["r"] = 1
	E.db["general"]["altPowerBar"]["statusBarColorGradient"] = false
	E.db["general"]["altPowerBar"]["font"] = "Expressway"
	E.db["general"]["altPowerBar"]["fontSize"] = 12
	E.db["general"]["altPowerBar"]["fontOutline"] = "OUTLINE"
	E.db["general"]["altPowerBar"]["textFormat"] = "NAMECURMAX"
	E.db["general"]["tagUpdateRate"] = 0.5

	E.db["general"]["autoRepair"] = "PLAYER"
	E.db["general"]["autoAcceptInvite"] = true
	E.db["general"]["autoTrackReputation"] = false
	E.db["general"]["interruptAnnounce"] = "NONE"

	E.db["general"]["backdropcolor"]["b"] = 0.14117647707462
	E.db["general"]["backdropcolor"]["g"] = 0.14117647707462
	E.db["general"]["backdropcolor"]["r"] = 0.14117647707462

	E.db["general"]["backdropfadecolor"]["a"] = 1
	E.db["general"]["backdropfadecolor"]["b"] = 0.12549020349979
	E.db["general"]["backdropfadecolor"]["g"] = 0.12549020349979
	E.db["general"]["backdropfadecolor"]["r"] = 0.12549020349979

	E.db["general"]["bottomPanel"] = false
	E.db["general"]["bottomPanelSettings"]["transparent"] = false
	E.db["general"]["bottomPanelSettings"]["height"] = 5
	E.db["general"]["bottomPanelSettings"]["width"] = 0

	E.db["general"]["topPanel"] = false
	E.db["general"]["topPanelSettings"]["transparent"] = false
	E.db["general"]["topPanelSettings"]["height"] = 5
	E.db["general"]["topPanelSettings"]["width"] = 0

	E.db["general"]["afk"] = false
	E.db["general"]["afkChat"] = false
	E.db["general"]["afkSpin"] = false

	E.db["general"]["customGlow"]["duration"] = 1
	E.db["general"]["customGlow"]["startAnimation"] = true
	E.db["general"]["customGlow"]["style"] = "Proc Glow"
	E.db["general"]["customGlow"]["useColor"] = false
	E.db["general"]["customGlow"]["color"]["a"] = 1
	E.db["general"]["customGlow"]["color"]["b"] = 0
	E.db["general"]["customGlow"]["color"]["g"] = 0
	E.db["general"]["customGlow"]["color"]["r"] = 0

	E.db["general"]["font"] = "Expressway"
	E.db["general"]["fonts"]["cooldown"]["enable"] = true
	E.db["general"]["fonts"]["cooldown"]["font"] = "Expressway"
	E.db["general"]["fonts"]["cooldown"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["cooldown"]["size"] = 20

	E.db["general"]["fonts"]["errortext"]["enable"] = true
	E.db["general"]["fonts"]["errortext"]["font"] = "Expressway"
	E.db["general"]["fonts"]["errortext"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["errortext"]["size"] = 18

	E.db["general"]["fonts"]["mailbody"]["enable"] = false
	E.db["general"]["fonts"]["mailbody"]["font"] = "Expressway"
	E.db["general"]["fonts"]["mailbody"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["mailbody"]["size"] = 14

	E.db["general"]["fonts"]["objective"]["enable"] = false
	E.db["general"]["fonts"]["objective"]["font"] = "Expressway"
	E.db["general"]["fonts"]["objective"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["objective"]["size"] = 14

	E.db["general"]["fonts"]["pvpsubzone"]["enable"] = false
	E.db["general"]["fonts"]["pvpsubzone"]["font"] = "Expressway"
	E.db["general"]["fonts"]["pvpsubzone"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["pvpsubzone"]["size"] = 24

	E.db["general"]["fonts"]["pvpzone"]["enable"] = false
	E.db["general"]["fonts"]["pvpzone"]["font"] = "Expressway"
	E.db["general"]["fonts"]["pvpzone"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["pvpzone"]["size"] = 24

	E.db["general"]["fonts"]["questtitle"]["enable"] = false
	E.db["general"]["fonts"]["questtitle"]["font"] = "Expressway"
	E.db["general"]["fonts"]["questtitle"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["questtitle"]["size"] = 18

	E.db["general"]["fonts"]["questtext"]["enable"] = false
	E.db["general"]["fonts"]["questtext"]["font"] = "Expressway"
	E.db["general"]["fonts"]["questtext"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["questtext"]["size"] = 14

	E.db["general"]["fonts"]["questsmall"]["enable"] = false
	E.db["general"]["fonts"]["questsmall"]["font"] = "Expressway"
	E.db["general"]["fonts"]["questsmall"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["questsmall"]["size"] = 13

	E.db["general"]["fonts"]["talkingtitle"]["enable"] = false
	E.db["general"]["fonts"]["talkingtitle"]["font"] = "Expressway"
	E.db["general"]["fonts"]["talkingtitle"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["talkingtitle"]["size"] = 20

	E.db["general"]["fonts"]["talkingtext"]["enable"] = false
	E.db["general"]["fonts"]["talkingtext"]["font"] = "Expressway"
	E.db["general"]["fonts"]["talkingtext"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["talkingtext"]["size"] = 18

	E.db["general"]["fonts"]["worldsubzone"]["enable"] = false
	E.db["general"]["fonts"]["worldsubzone"]["font"] = "Expressway"
	E.db["general"]["fonts"]["worldsubzone"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["worldsubzone"]["size"] = 24

	E.db["general"]["fonts"]["worldzone"]["enable"] = false
	E.db["general"]["fonts"]["worldzone"]["font"] = "Expressway"
	E.db["general"]["fonts"]["worldzone"]["outline"] = "OUTLINE"
	E.db["general"]["fonts"]["worldzone"]["size"] = 26

	E.db["general"]["lootRoll"]["buttonSize"] = 19
	E.db["general"]["lootRoll"]["height"] = 22
	E.db["general"]["lootRoll"]["maxBars"] = 6
	E.db["general"]["lootRoll"]["spacing"] = 8
	E.db["general"]["lootRoll"]["statusBarTexture"] = "HopesUI"
	E.db["general"]["lootRoll"]["width"] = 325
	E.db["general"]["lootRoll"]["qualityItemLevel"] = true
	E.db["general"]["lootRoll"]["qualityName"] = true
	E.db["general"]["lootRoll"]["qualityStatusBar"] = true
	E.db["general"]["lootRoll"]["qualityStatusBarBackdrop"] = false
	E.db["general"]["lootRoll"]["style"] = "fullbar"
	E.db["general"]["lootRoll"]["statusBarTexture"] = "HopesUI"
	E.db["general"]["lootRoll"]["leftButtons"] = false

	E.db["general"]["itemLevel"]["displayCharacterInfo"] = true
	E.db["general"]["itemLevel"]["displayInspectInfo"] = true
	E.db["general"]["itemLevel"]["itemLevelRarity"] = true
	E.db["general"]["itemLevel"]["itemLevelFont"] = "Expressway"
	E.db["general"]["itemLevel"]["itemLevelFontOutline"] = "OUTLINE"
	E.db["general"]["itemLevel"]["itemLevelFontSize"] = 12
	E.db["general"]["itemLevel"]["totalLevelFont"] = "Expressway"
	E.db["general"]["itemLevel"]["totalLevelFontOutline"] = "OUTLINE"
	E.db["general"]["itemLevel"]["totalLevelFontSize"] = 20

	E.db["general"]["objectiveFrameAutoHide"] = true
	E.db["general"]["objectiveFrameAutoHideInKeystone"] = false
	E.db["general"]["bonusObjectivePosition"] = "LEFT"

	E.db["general"]["addonCompartment"]["frameStrata"] = "MEDIUM"
	E.db["general"]["addonCompartment"]["hide"] = true
	E.db["general"]["addonCompartment"]["frameLevel"] = 20
	E.db["general"]["addonCompartment"]["size"] = 18
	E.db["general"]["addonCompartment"]["font"] = "Expressway"
	E.db["general"]["addonCompartment"]["fontOutline"] = "OUTLINE"
	E.db["general"]["addonCompartment"]["fontSize"] = 14

	E.db["general"]["queueStatus"]["frameStrata"] = "MEDIUM"
	E.db["general"]["queueStatus"]["frameLevel"] = 20
	E.db["general"]["queueStatus"]["scale"] = 0.5
	E.db["general"]["queueStatus"]["enable"] = true
	E.db["general"]["queueStatus"]["font"] = "Expressway"
	E.db["general"]["queueStatus"]["fontOutline"] = "OUTLINE"
	E.db["general"]["queueStatus"]["fontSize"] = 11
	E.db["general"]["queueStatus"]["position"] = "BOTTOMRIGHT"
	E.db["general"]["queueStatus"]["xOffset"] = -2
	E.db["general"]["queueStatus"]["yOffset"] = 2

	E.db["general"]["guildBank"]["itemLevel"] = true
	E.db["general"]["guildBank"]["itemLevelCustomColorEnable"] = false
	E.db["general"]["guildBank"]["itemLevelCustomColor"]["b"] = 1
	E.db["general"]["guildBank"]["itemLevelCustomColor"]["g"] = 1
	E.db["general"]["guildBank"]["itemLevelCustomColor"]["r"] = 1
	E.db["general"]["guildBank"]["itemLevelThreshold"] = 1
	E.db["general"]["guildBank"]["itemLevelFontSize"] = 10
	E.db["general"]["guildBank"]["itemLevelFont"] = "Expressway"
	E.db["general"]["guildBank"]["itemLevelFontOutline"] = "OUTLINE"
	E.db["general"]["guildBank"]["itemLevelPosition"] = "BOTTOMRIGHT"
	E.db["general"]["guildBank"]["itemLevelxOffset"] = 0
	E.db["general"]["guildBank"]["itemLevelyOffset"] = 2
	E.db["general"]["guildBank"]["countFont"] = "Expressway"
	E.db["general"]["guildBank"]["countFontColor"]["b"] = 1
	E.db["general"]["guildBank"]["countFontColor"]["g"] = 1
	E.db["general"]["guildBank"]["countFontColor"]["r"] = 1
	E.db["general"]["guildBank"]["countFontOutline"] = "OUTLINE"
	E.db["general"]["guildBank"]["countFontSize"] = 10
	E.db["general"]["guildBank"]["countPosition"] = "BOTTOMRIGHT"
	E.db["general"]["guildBank"]["countxOffset"] = 0
	E.db["general"]["guildBank"]["countyOffset"] = 2

	-- Totems Tracker
	E.db["general"]["totems"]["sortDirection"] = "ASCENDING"
	E.db["general"]["totems"]["growthDirection"] = "HORIZONTAL"
	E.db["general"]["totems"]["keepSizeRatio"] = false
	E.db["general"]["totems"]["size"] = 40 -- width
	E.db["general"]["totems"]["height"] = 40
	E.db["general"]["totems"]["spacing"] = 6

	-- Minimap
	E.global["general"]["fadeMapDuration"] = 1
	E.global["general"]["mapAlphaWhenMoving"] = 1
	E.db["general"]["minimap"]["clusterBackdrop"] = false
	E.db["general"]["minimap"]["clusterDisable"] = true
	E.db["general"]["minimap"]["size"] = 260
	E.db["general"]["minimap"]["scale"] = 1
	E.db["general"]["minimap"]["resetZoom"]["enable"] = true
	E.db["general"]["minimap"]["resetZoom"]["time"] = 3
	E.db["general"]["minimap"]["locationText"] = "SHOW"
	E.db["general"]["minimap"]["locationFont"] = "Expressway"
	E.db["general"]["minimap"]["locationFontSize"] = 17
	E.db["general"]["minimap"]["locationFontOutline"] = "OUTLINE"

	E.db["general"]["minimap"]["icons"]["classHall"]["position"] = "BOTTOMLEFT"
	E.db["general"]["minimap"]["icons"]["classHall"]["scale"] = 1
	E.db["general"]["minimap"]["icons"]["classHall"]["xOffset"] = 0
	E.db["general"]["minimap"]["icons"]["classHall"]["yOffset"] = 42

	E.db["general"]["minimap"]["icons"]["mail"]["position"] = "RIGHT"
	E.db["general"]["minimap"]["icons"]["mail"]["scale"] = 1.2
	E.db["general"]["minimap"]["icons"]["mail"]["texture"] = "Mail1"
	E.db["general"]["minimap"]["icons"]["mail"]["xOffset"] = -5
	E.db["general"]["minimap"]["icons"]["mail"]["yOffset"] = 0

	E.db["general"]["minimap"]["icons"]["crafting"]["position"] = "TOPRIGHT"
	E.db["general"]["minimap"]["icons"]["crafting"]["scale"] = 1
	E.db["general"]["minimap"]["icons"]["crafting"]["xOffset"] = -23
	E.db["general"]["minimap"]["icons"]["crafting"]["yOffset"] = -3

	E.db["general"]["minimap"]["icons"]["difficulty"]["position"] = "TOPLEFT"
	E.db["general"]["minimap"]["icons"]["difficulty"]["scale"] = 1
	E.db["general"]["minimap"]["icons"]["difficulty"]["xOffset"] = 10
	E.db["general"]["minimap"]["icons"]["difficulty"]["yOffset"] = 1

	E.db["general"]["privateAuras"]["countdownFrame"] = false

	E.db["general"]["valuecolor"]["b"] = 0.027450982481241
	E.db["general"]["valuecolor"]["g"] = 0.77647066116333
	E.db["general"]["valuecolor"]["r"] = 1

	E.db["movers"]["AlertFrameMover"] = "TOP,UIParent,TOP,0,-192"
	E.db["movers"]["AltPowerBarMover"] = "TOP,UIParent,TOP,0,-78"
	E.db["movers"]["BNETMover"] = "BOTTOMLEFT,UIParent,BOTTOMLEFT,46,280"
	E.db["movers"]["BelowMinimapContainerMover"] = "TOPRIGHT,UIParent,TOPRIGHT,-294,-316"
	E.db["movers"]["BossBannerMover"] = "TOP,UIParent,TOP,0,-51"
	E.db["movers"]["BossButton"] = "BOTTOM,UIParent,BOTTOM,86,560"
	E.db["movers"]["BossHeaderMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-572,497"
	E.db["movers"]["BuffsMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-311,-43"
	E.db["movers"]["DTPanelMinimapTimeMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-215,-223"
	E.db["movers"]["DebuffsMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-311,-160"

	E.db["movers"]["ElvUF_PetMover"] = "BOTTOMLEFT,UIParent,BOTTOMLEFT,634,78"
	E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,372,278"
	E.db["movers"]["ElvUIBagMover"] = "BOTTOMRIGHT,UIParent,BOTTOMRIGHT,-418,209"
	E.db["movers"]["ElvUIBankMover"] = "BOTTOMLEFT,UIParent,BOTTOMLEFT,45,256"
	E.db["movers"]["EventToastMover"] = "TOP,UIParent,TOP, 0,-149"
	E.db["movers"]["LeftChatMover"] = "BOTTOMLEFT,UIParent,BOTTOMLEFT,43,44"
	E.db["movers"]["MinimapButtonAnchor"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-34,-218"
	E.db["movers"]["MinimapMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-43,0"
	E.db["movers"]["MoverUIERRORS"] = "TOP,UIParent,TOP,-321,-123"
	E.db["movers"]["PHInstanceDifficultyFrameMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-46,-192"
	E.db["movers"]["PowerBarContainerMover"] = "BOTTOMLEFT,UIParent,BOTTOMLEFT,427,599"
	E.db["movers"]["PrivateAurasMover"] = "TOPRIGHT,UIParent,TOPRIGHT,-338,-263"
	E.db["movers"]["QueueStatusMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-265,-55"
	E.db["movers"]["RightChatMover"] = "BOTTOMRIGHT,UIParent,BOTTOMRIGHT,-4,4"

	E.db["movers"]["TooltipMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-287,5"
	E.db["movers"]["TopCenterContainerMover"] = "TOP,UIParent,TOP,0,-124"
	E.db["movers"]["TotemTrackerMover"] = "BOTTOMLEFT,UIParent,BOTTOMLEFT,564,4"
	E.db["movers"]["VehicleLeaveButton"] = "BOTTOM,UIParent,BOTTOM,0,123"
	E.db["movers"]["ZoneAbility"] = "BOTTOM,UIParent,BOTTOM,140,560"
	E.db["movers"]["QuestWatchFrameMover"] = "TOPRIGHT,UIParent,TOPRIGHT,-102,-378"

	E.db["tooltip"]["colorAlpha"] = 1
	E.db["tooltip"]["font"] = "Expressway"
	E.db["tooltip"]["headerFont"] = "Expressway"
	E.db["tooltip"]["headerFontSize"] = 12
	E.db["tooltip"]["healthBar"]["font"] = "Expressway"
	E.db["tooltip"]["healthBar"]["statusPosition"] = "DISABLED"
	E.db["tooltip"]["role"] = false
	E.db["tooltip"]["showMount"] = false
	E.db["tooltip"]["targetInfo"] = false

	E.db["unitframe"]["thinBorders"] = true
	E.db["unitframe"]["colors"]["aurabar_backdrop"]["b"] = 0.43137258291245
	E.db["unitframe"]["colors"]["aurabar_backdrop"]["g"] = 0.43137258291245
	E.db["unitframe"]["colors"]["aurabar_backdrop"]["r"] = 0.43137258291245
	E.db["unitframe"]["colors"]["colorhealthbyvalue"] = false
	E.db["unitframe"]["colors"]["customaurabarbackdrop"] = true
	E.db["unitframe"]["colors"]["customhealthbackdrop"] = true
	E.db["unitframe"]["colors"]["custompowerbackdrop"] = true
	E.db["unitframe"]["colors"]["debuffHighlight"]["Bleed"]["a"] = 1
	E.db["unitframe"]["colors"]["debuffHighlight"]["Bleed"]["b"] = 0.60000002384186
	E.db["unitframe"]["colors"]["debuffHighlight"]["Bleed"]["g"] = 0.20000001788139
	E.db["unitframe"]["colors"]["debuffHighlight"]["Curse"]["a"] = 1
	E.db["unitframe"]["colors"]["debuffHighlight"]["Curse"]["r"] = 0.60000002384186
	E.db["unitframe"]["colors"]["debuffHighlight"]["Disease"]["a"] = 1
	E.db["unitframe"]["colors"]["debuffHighlight"]["Disease"]["g"] = 0.40000003576279
	E.db["unitframe"]["colors"]["debuffHighlight"]["Disease"]["r"] = 0.60000002384186
	E.db["unitframe"]["colors"]["debuffHighlight"]["Magic"]["a"] = 1
	E.db["unitframe"]["colors"]["debuffHighlight"]["Magic"]["g"] = 0.60000002384186
	E.db["unitframe"]["colors"]["debuffHighlight"]["Magic"]["r"] = 0.20000001788139
	E.db["unitframe"]["colors"]["debuffHighlight"]["Poison"]["a"] = 1
	E.db["unitframe"]["colors"]["debuffHighlight"]["Poison"]["g"] = 0.60000002384186
	E.db["unitframe"]["colors"]["frameGlow"]["mouseoverGlow"]["enable"] = false
	E.db["unitframe"]["colors"]["frameGlow"]["targetGlow"]["class"] = false
	E.db["unitframe"]["colors"]["frameGlow"]["targetGlow"]["enable"] = true

	E.db["unitframe"]["colors"]["healPrediction"]["absorbs"]["a"] = 1
	E.db["unitframe"]["colors"]["healPrediction"]["absorbs"]["b"] = 1
	E.db["unitframe"]["colors"]["healPrediction"]["absorbs"]["g"] = 0.86274516582489
	E.db["unitframe"]["colors"]["healPrediction"]["absorbs"]["r"] = 0.47450983524323
	E.db["unitframe"]["colors"]["healPrediction"]["healAbsorbs"]["a"] = 1
	E.db["unitframe"]["colors"]["healPrediction"]["healAbsorbs"]["b"] = 0.21960785984993
	E.db["unitframe"]["colors"]["healPrediction"]["healAbsorbs"]["g"] = 0.21960785984993
	E.db["unitframe"]["colors"]["healPrediction"]["healAbsorbs"]["r"] = 0.63529413938522
	E.db["unitframe"]["colors"]["healPrediction"]["overabsorbs"]["a"] = 0
	E.db["unitframe"]["colors"]["healPrediction"]["overabsorbs"]["b"] = 1
	E.db["unitframe"]["colors"]["healPrediction"]["overabsorbs"]["g"] = 0.99607849121094
	E.db["unitframe"]["colors"]["healPrediction"]["overabsorbs"]["r"] = 0.96470594406128
	E.db["unitframe"]["colors"]["healPrediction"]["overhealabsorbs"]["a"] = 1
	E.db["unitframe"]["colors"]["healPrediction"]["overhealabsorbs"]["b"] = 0.21960785984993
	E.db["unitframe"]["colors"]["healPrediction"]["overhealabsorbs"]["g"] = 0.21960785984993
	E.db["unitframe"]["colors"]["healPrediction"]["overhealabsorbs"]["r"] = 0.63529413938522
	E.db["unitframe"]["colors"]["healPrediction"]["personal"]["b"] = 0.50196078431373
	E.db["unitframe"]["colors"]["health"]["b"] = 0.12549020349979
	E.db["unitframe"]["colors"]["health"]["g"] = 0.12549020349979
	E.db["unitframe"]["colors"]["health"]["r"] = 0.12549020349979
	E.db["unitframe"]["colors"]["health_backdrop"]["b"] = 0.30196079611778
	E.db["unitframe"]["colors"]["health_backdrop"]["g"] = 0.30196079611778
	E.db["unitframe"]["colors"]["health_backdrop"]["r"] = 0.30196079611778
	E.db["unitframe"]["colors"]["power"]["ENERGY"]["b"] = 0.10196079313755
	E.db["unitframe"]["colors"]["power"]["ENERGY"]["g"] = 0.85098046064377
	E.db["unitframe"]["colors"]["power"]["FOCUS"]["b"] = 0.25098040699959
	E.db["unitframe"]["colors"]["power"]["FOCUS"]["g"] = 0.50196081399918
	E.db["unitframe"]["colors"]["power"]["FURY"]["b"] = 0.99215692281723
	E.db["unitframe"]["colors"]["power"]["FURY"]["g"] = 0.258823543787
	E.db["unitframe"]["colors"]["power"]["FURY"]["r"] = 0.78823536634445
	E.db["unitframe"]["colors"]["power"]["INSANITY"]["b"] = 0.80000007152557
	E.db["unitframe"]["colors"]["power"]["INSANITY"]["r"] = 0.40000003576279
	E.db["unitframe"]["colors"]["power"]["MANA"]["b"] = 0.90196084976196
	E.db["unitframe"]["colors"]["power"]["MANA"]["g"] = 0.79215693473816
	E.db["unitframe"]["colors"]["power"]["MANA"]["r"] = 0.04313725605607
	E.db["unitframe"]["colors"]["power"]["PAIN"]["g"] = 0.61176472902298
	E.db["unitframe"]["colors"]["power"]["RAGE"]["b"] = 0.30196079611778
	E.db["unitframe"]["colors"]["power"]["RAGE"]["g"] = 0.20000001788139
	E.db["unitframe"]["colors"]["power"]["RAGE"]["r"] = 0.90196084976196
	E.db["unitframe"]["colors"]["power"]["RUNIC_POWER"]["b"] = 0.60000002384186
	E.db["unitframe"]["colors"]["power"]["RUNIC_POWER"]["g"] = 0.45098042488098
	E.db["unitframe"]["colors"]["power"]["RUNIC_POWER"]["r"] = 0.34901961684227
	E.db["unitframe"]["colors"]["power_backdrop"]["b"] = 0.30196079611778
	E.db["unitframe"]["colors"]["power_backdrop"]["g"] = 0.30196079611778
	E.db["unitframe"]["colors"]["power_backdrop"]["r"] = 0.30196079611778
	E.db["unitframe"]["colors"]["reaction"]["BAD"]["b"] = 0.21960785984993
	E.db["unitframe"]["colors"]["reaction"]["BAD"]["g"] = 0.21960785984993
	E.db["unitframe"]["colors"]["reaction"]["BAD"]["r"] = 0.63529413938522
	E.db["unitframe"]["colors"]["reaction"]["GOOD"]["b"] = 0.5137255191803
	E.db["unitframe"]["colors"]["reaction"]["GOOD"]["g"] = 0.78039222955704
	E.db["unitframe"]["colors"]["reaction"]["GOOD"]["r"] = 0.50588238239288
	E.db["unitframe"]["colors"]["reaction"]["NEUTRAL"]["b"] = 0.027450982481241
	E.db["unitframe"]["colors"]["reaction"]["NEUTRAL"]["g"] = 0.77647066116333
	E.db["unitframe"]["colors"]["reaction"]["NEUTRAL"]["r"] = 1
	E.db["unitframe"]["colors"]["tapped"]["b"] = 0.43137258291245
	E.db["unitframe"]["colors"]["tapped"]["g"] = 0.43137258291245
	E.db["unitframe"]["colors"]["tapped"]["r"] = 0.43137258291245
	E.db["unitframe"]["colors"]["transparentCastbar"] = true
	E.db["unitframe"]["cooldown"]["override"] = false
	E.db["unitframe"]["cooldown"]["showModRate"] = true
	E.db["unitframe"]["font"] = "Expressway"
	E.db["unitframe"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["maxAllowedGroups"] = false
	E.db["unitframe"]["statusbar"] = "HopesUI"
	E.db["unitframe"]["units"]["arena"]["colorOverride"] = "FORCE_OFF"
	E.db["unitframe"]["units"]["arena"]["width"] = 240
	E.db["unitframe"]["units"]["assist"]["colorOverride"] = "FORCE_OFF"
	E.db["unitframe"]["units"]["assist"]["enable"] = false

	-- Boss
	if E.Retail then
		E.db["unitframe"]["units"]["boss"]["buffIndicator"]["enable"] = false
		E.db["unitframe"]["units"]["boss"]["buffs"]["enable"] = false
		E.db["unitframe"]["units"]["boss"]["castbar"]["enable"] = false
		E.db["unitframe"]["units"]["boss"]["colorOverride"] = "FORCE_OFF"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Health"]["attachTextTo"] = "Health"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Health"]["font"] = "Expressway"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Health"]["fontOutline"] = "OUTLINE"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Health"]["justifyH"] = "RIGHT"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Health"]["size"] = 15
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Health"]["text_format"] = "[Hopes:perhp]"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Health"]["xOffset"] = -8
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Health"]["yOffset"] = 0
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:HealthCurrent"]["attachTextTo"] = "Health"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:HealthCurrent"]["font"] = "Expressway"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:HealthCurrent"]["fontOutline"] = "OUTLINE"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:HealthCurrent"]["justifyH"] = "LEFT"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:HealthCurrent"]["size"] = 15
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:HealthCurrent"]["text_format"] = "[health:current:shortvalue]"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:HealthCurrent"]["xOffset"] = 4
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:HealthCurrent"]["yOffset"] = 0
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Name"]["attachTextTo"] = "Power"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Name"]["font"] = "Expressway"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Name"]["fontOutline"] = "OUTLINE"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Name"]["justifyH"] = "LEFT"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Name"]["size"] = 16
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Name"]["text_format"] = "[Hopes:raidmarker][classcolor][name:abbrev]"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Name"]["xOffset"] = 4
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Name"]["yOffset"] = 36
		E.db["unitframe"]["units"]["boss"]["debuffs"]["enable"] = false
		E.db["unitframe"]["units"]["boss"]["debuffs"]["sizeOverride"] = 48
		E.db["unitframe"]["units"]["boss"]["debuffs"]["spacing"] = 6
		E.db["unitframe"]["units"]["boss"]["debuffs"]["xOffset"] = -7
		E.db["unitframe"]["units"]["boss"]["debuffs"]["yOffset"] = -1
		E.db["unitframe"]["units"]["boss"]["healPrediction"]["enable"] = true
		E.db["unitframe"]["units"]["boss"]["health"]["text_format"] = ""
		E.db["unitframe"]["units"]["boss"]["height"] = 37
		E.db["unitframe"]["units"]["boss"]["name"]["text_format"] = ""
		E.db["unitframe"]["units"]["boss"]["power"]["text_format"] = ""
		E.db["unitframe"]["units"]["boss"]["privateAuras"]["enable"] = false
		E.db["unitframe"]["units"]["boss"]["raidicon"]["enable"] = false
		E.db["unitframe"]["units"]["boss"]["spacing"] = 8
		E.db["unitframe"]["units"]["boss"]["width"] = 210

		E.db["unitframe"]["units"]["focus"]["aurabar"]["detachedWidth"] = 270
		E.db["unitframe"]["units"]["focus"]["aurabar"]["maxBars"] = 6
		E.db["unitframe"]["units"]["focus"]["buffs"]["anchorPoint"] = "TOPLEFT"
		E.db["unitframe"]["units"]["focus"]["buffs"]["height"] = 24
		E.db["unitframe"]["units"]["focus"]["buffs"]["keepSizeRatio"] = false
		E.db["unitframe"]["units"]["focus"]["buffs"]["maxDuration"] = 0
		E.db["unitframe"]["units"]["focus"]["buffs"]["perrow"] = 5
		E.db["unitframe"]["units"]["focus"]["buffs"]["priority"] = "Blacklist,Personal,nonPersonal"
		E.db["unitframe"]["units"]["focus"]["buffs"]["sizeOverride"] = 24
		E.db["unitframe"]["units"]["focus"]["buffs"]["spacing"] = 6
		E.db["unitframe"]["units"]["focus"]["buffs"]["xOffset"] = -1
		E.db["unitframe"]["units"]["focus"]["buffs"]["yOffset"] = 6
		E.db["unitframe"]["units"]["focus"]["castbar"]["enable"] = false
		E.db["unitframe"]["units"]["focus"]["castbar"]["width"] = 140
		E.db["unitframe"]["units"]["focus"]["colorOverride"] = "FORCE_ON"

		E.db["unitframe"]["units"]["focus"]["debuffs"]["anchorPoint"] = "TOPLEFT"
		E.db["unitframe"]["units"]["focus"]["debuffs"]["countFont"] = "Expressway"
		E.db["unitframe"]["units"]["focus"]["debuffs"]["countFontSize"] = 18
		E.db["unitframe"]["units"]["focus"]["debuffs"]["countPosition"] = "TOP"
		E.db["unitframe"]["units"]["focus"]["debuffs"]["countYOffset"] = 12
		E.db["unitframe"]["units"]["focus"]["debuffs"]["growthX"] = "RIGHT"
		E.db["unitframe"]["units"]["focus"]["debuffs"]["height"] = 32
		E.db["unitframe"]["units"]["focus"]["debuffs"]["keepSizeRatio"] = false
		E.db["unitframe"]["units"]["focus"]["debuffs"]["maxDuration"] = 0
		E.db["unitframe"]["units"]["focus"]["debuffs"]["perrow"] = 4
		E.db["unitframe"]["units"]["focus"]["debuffs"]["priority"] = "Blacklist,Dispellable,Personal,RaidDebuffs,CCDebuffs,Friendly:Dispellable"
		E.db["unitframe"]["units"]["focus"]["debuffs"]["sizeOverride"] = 32
		E.db["unitframe"]["units"]["focus"]["debuffs"]["spacing"] = 6
		E.db["unitframe"]["units"]["focus"]["debuffs"]["yOffset"] = 6
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Health"]["attachTextTo"] = "Health"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Health"]["enable"] = true
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Health"]["font"] = "Expressway"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Health"]["fontOutline"] = "OUTLINE"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Health"]["justifyH"] = "RIGHT"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Health"]["size"] = 15
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Health"]["text_format"] = "[Hopes:perhp]"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Health"]["xOffset"] = -8
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Health"]["yOffset"] = 0
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:HealthCurrent"]["attachTextTo"] = "Health"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:HealthCurrent"]["enable"] = true
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:HealthCurrent"]["font"] = "Expressway"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:HealthCurrent"]["fontOutline"] = "OUTLINE"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:HealthCurrent"]["justifyH"] = "LEFT"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:HealthCurrent"]["size"] = 15
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:HealthCurrent"]["text_format"] = "[health:current:shortvalue]"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:HealthCurrent"]["xOffset"] = 4
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:HealthCurrent"]["yOffset"] = 0
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Name"]["attachTextTo"] = "Power"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Name"]["enable"] = true
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Name"]["font"] = "Expressway"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Name"]["fontOutline"] = "OUTLINE"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Name"]["justifyH"] = "LEFT"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Name"]["size"] = 16
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Name"]["text_format"] = "[classcolor][name:abbrev]"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Name"]["xOffset"] = 4
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Name"]["yOffset"] = 36
		E.db["unitframe"]["units"]["focus"]["disableTargetGlow"] = true
		E.db["unitframe"]["units"]["focus"]["height"] = 37
		E.db["unitframe"]["units"]["focus"]["infoPanel"]["height"] = 20
		E.db["unitframe"]["units"]["focus"]["name"]["text_format"] = ""
		E.db["unitframe"]["units"]["focus"]["orientation"] = "RIGHT"
		E.db["unitframe"]["units"]["focus"]["portrait"]["overlayAlpha"] = 0.3
		E.db["unitframe"]["units"]["focus"]["power"]["detachedWidth"] = 268
		E.db["unitframe"]["units"]["focus"]["strataAndLevel"]["frameLevel"] = 2
		E.db["unitframe"]["units"]["focus"]["strataAndLevel"]["frameStrata"] = "HIGH"
		E.db["unitframe"]["units"]["focus"]["threatStyle"] = "NONE"
		E.db["unitframe"]["units"]["focus"]["width"] = 140
	elseif E.Cata then
		E.db["unitframe"]["units"]["boss"]["buffIndicator"]["enable"] = false
		E.db["unitframe"]["units"]["boss"]["buffs"]["enable"] = false
		E.db["unitframe"]["units"]["boss"]["castbar"]["enable"] = false
		E.db["unitframe"]["units"]["boss"]["colorOverride"] = "FORCE_OFF"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Health"]["attachTextTo"] = "Health"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Health"]["font"] = "Expressway"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Health"]["fontOutline"] = "OUTLINE"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Health"]["justifyH"] = "RIGHT"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Health"]["size"] = 15
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Health"]["text_format"] = "[perhp]"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Health"]["xOffset"] = -8
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Health"]["yOffset"] = 0
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:HealthCurrent"]["attachTextTo"] = "Health"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:HealthCurrent"]["font"] = "Expressway"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:HealthCurrent"]["fontOutline"] = "OUTLINE"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:HealthCurrent"]["justifyH"] = "LEFT"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:HealthCurrent"]["size"] = 15
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:HealthCurrent"]["text_format"] = "[health:current:shortvalue]"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:HealthCurrent"]["xOffset"] = 4
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:HealthCurrent"]["yOffset"] = 0
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Name"]["attachTextTo"] = "Power"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Name"]["font"] = "Expressway"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Name"]["fontOutline"] = "OUTLINE"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Name"]["justifyH"] = "LEFT"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Name"]["size"] = 16
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Name"]["text_format"] = "[Hopes:raidmarker][classcolor][name:abbrev]"
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Name"]["xOffset"] = 4
		E.db["unitframe"]["units"]["boss"]["customTexts"]["Boss:Name"]["yOffset"] = 36
		E.db["unitframe"]["units"]["boss"]["debuffs"]["enable"] = false
		E.db["unitframe"]["units"]["boss"]["debuffs"]["sizeOverride"] = 48
		E.db["unitframe"]["units"]["boss"]["debuffs"]["spacing"] = 6
		E.db["unitframe"]["units"]["boss"]["debuffs"]["xOffset"] = -7
		E.db["unitframe"]["units"]["boss"]["debuffs"]["yOffset"] = -1
		E.db["unitframe"]["units"]["boss"]["healPrediction"]["enable"] = true
		E.db["unitframe"]["units"]["boss"]["health"]["text_format"] = ""
		E.db["unitframe"]["units"]["boss"]["height"] = 37
		E.db["unitframe"]["units"]["boss"]["name"]["text_format"] = ""
		E.db["unitframe"]["units"]["boss"]["power"]["text_format"] = ""
		E.db["unitframe"]["units"]["boss"]["privateAuras"]["enable"] = false
		E.db["unitframe"]["units"]["boss"]["raidicon"]["enable"] = false
		E.db["unitframe"]["units"]["boss"]["spacing"] = 8
		E.db["unitframe"]["units"]["boss"]["width"] = 210

		E.db["unitframe"]["units"]["focus"]["aurabar"]["detachedWidth"] = 270
		E.db["unitframe"]["units"]["focus"]["aurabar"]["maxBars"] = 6
		E.db["unitframe"]["units"]["focus"]["buffs"]["anchorPoint"] = "TOPLEFT"
		E.db["unitframe"]["units"]["focus"]["buffs"]["height"] = 24
		E.db["unitframe"]["units"]["focus"]["buffs"]["keepSizeRatio"] = false
		E.db["unitframe"]["units"]["focus"]["buffs"]["maxDuration"] = 0
		E.db["unitframe"]["units"]["focus"]["buffs"]["perrow"] = 5
		E.db["unitframe"]["units"]["focus"]["buffs"]["priority"] = "Blacklist,Personal,nonPersonal"
		E.db["unitframe"]["units"]["focus"]["buffs"]["sizeOverride"] = 24
		E.db["unitframe"]["units"]["focus"]["buffs"]["spacing"] = 6
		E.db["unitframe"]["units"]["focus"]["buffs"]["xOffset"] = -1
		E.db["unitframe"]["units"]["focus"]["buffs"]["yOffset"] = 6
		E.db["unitframe"]["units"]["focus"]["castbar"]["enable"] = false
		E.db["unitframe"]["units"]["focus"]["castbar"]["width"] = 140
		E.db["unitframe"]["units"]["focus"]["colorOverride"] = "FORCE_ON"

		E.db["unitframe"]["units"]["focus"]["debuffs"]["anchorPoint"] = "TOPLEFT"
		E.db["unitframe"]["units"]["focus"]["debuffs"]["countFont"] = "Expressway"
		E.db["unitframe"]["units"]["focus"]["debuffs"]["countFontSize"] = 18
		E.db["unitframe"]["units"]["focus"]["debuffs"]["countPosition"] = "TOP"
		E.db["unitframe"]["units"]["focus"]["debuffs"]["countYOffset"] = 12
		E.db["unitframe"]["units"]["focus"]["debuffs"]["growthX"] = "RIGHT"
		E.db["unitframe"]["units"]["focus"]["debuffs"]["height"] = 32
		E.db["unitframe"]["units"]["focus"]["debuffs"]["keepSizeRatio"] = false
		E.db["unitframe"]["units"]["focus"]["debuffs"]["maxDuration"] = 0
		E.db["unitframe"]["units"]["focus"]["debuffs"]["perrow"] = 4
		E.db["unitframe"]["units"]["focus"]["debuffs"]["priority"] = "Blacklist,Dispellable,Personal,RaidDebuffs,CCDebuffs,Friendly:Dispellable"
		E.db["unitframe"]["units"]["focus"]["debuffs"]["sizeOverride"] = 32
		E.db["unitframe"]["units"]["focus"]["debuffs"]["spacing"] = 6
		E.db["unitframe"]["units"]["focus"]["debuffs"]["yOffset"] = 6
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Health"]["attachTextTo"] = "Health"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Health"]["enable"] = true
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Health"]["font"] = "Expressway"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Health"]["fontOutline"] = "OUTLINE"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Health"]["justifyH"] = "RIGHT"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Health"]["size"] = 15
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Health"]["text_format"] = "[perhp]"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Health"]["xOffset"] = -8
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Health"]["yOffset"] = 0
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:HealthCurrent"]["attachTextTo"] = "Health"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:HealthCurrent"]["enable"] = true
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:HealthCurrent"]["font"] = "Expressway"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:HealthCurrent"]["fontOutline"] = "OUTLINE"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:HealthCurrent"]["justifyH"] = "LEFT"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:HealthCurrent"]["size"] = 15
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:HealthCurrent"]["text_format"] = "[health:current:shortvalue]"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:HealthCurrent"]["xOffset"] = 4
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:HealthCurrent"]["yOffset"] = 0
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Name"]["attachTextTo"] = "Power"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Name"]["enable"] = true
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Name"]["font"] = "Expressway"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Name"]["fontOutline"] = "OUTLINE"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Name"]["justifyH"] = "LEFT"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Name"]["size"] = 16
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Name"]["text_format"] = "[classcolor][name:abbrev]"
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Name"]["xOffset"] = 4
		E.db["unitframe"]["units"]["focus"]["customTexts"]["Focus:Name"]["yOffset"] = 36
		E.db["unitframe"]["units"]["focus"]["disableTargetGlow"] = true
		E.db["unitframe"]["units"]["focus"]["height"] = 37
		E.db["unitframe"]["units"]["focus"]["infoPanel"]["height"] = 20
		E.db["unitframe"]["units"]["focus"]["name"]["text_format"] = ""
		E.db["unitframe"]["units"]["focus"]["orientation"] = "RIGHT"
		E.db["unitframe"]["units"]["focus"]["portrait"]["overlayAlpha"] = 0.3
		E.db["unitframe"]["units"]["focus"]["power"]["detachedWidth"] = 268
		E.db["unitframe"]["units"]["focus"]["strataAndLevel"]["frameLevel"] = 2
		E.db["unitframe"]["units"]["focus"]["strataAndLevel"]["frameStrata"] = "HIGH"
		E.db["unitframe"]["units"]["focus"]["threatStyle"] = "NONE"
		E.db["unitframe"]["units"]["focus"]["width"] = 140
	end
	-- Party
	E.db["unitframe"]["units"]["party"]["groupBy"] = "ROLE"
	E.db["unitframe"]["units"]["party"]["ROLE1"] = "TANK"
	E.db["unitframe"]["units"]["party"]["ROLE2"] = "DAMAGER"
	E.db["unitframe"]["units"]["party"]["ROLE3"] = "HEALER"
	E.db["unitframe"]["units"]["party"]["buffIndicator"]["enable"] = false
	E.db["unitframe"]["units"]["party"]["buffs"]["anchorPoint"] = "BOTTOMLEFT"
	E.db["unitframe"]["units"]["party"]["buffs"]["attachTo"] = "HEALTH"
	E.db["unitframe"]["units"]["party"]["buffs"]["priority"] = ""
	E.db["unitframe"]["units"]["party"]["buffs"]["sizeOverride"] = 34
	E.db["unitframe"]["units"]["party"]["buffs"]["spacing"] = 3
	E.db["unitframe"]["units"]["party"]["buffs"]["xOffset"] = 3
	E.db["unitframe"]["units"]["party"]["buffs"]["yOffset"] = -50
	E.db["unitframe"]["units"]["party"]["classbar"]["altPowerTextFormat"] = ""
	E.db["unitframe"]["units"]["party"]["classbar"]["enable"] = false
	E.db["unitframe"]["units"]["party"]["colorOverride"] = "FORCE_OFF"
	E.db["unitframe"]["units"]["party"]["customTexts"]["Party:Health"]["attachTextTo"] = "Health"
	E.db["unitframe"]["units"]["party"]["customTexts"]["Party:Health"]["font"] = "Expressway"
	E.db["unitframe"]["units"]["party"]["customTexts"]["Party:Health"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["party"]["customTexts"]["Party:Health"]["justifyH"] = "CENTER"
	E.db["unitframe"]["units"]["party"]["customTexts"]["Party:Health"]["size"] = 25
	
	if E.Retail then
		E.db["unitframe"]["units"]["party"]["customTexts"]["Party:Health"]["text_format"] = "||cffffc607[Hopes:perhp]||r"
	elseif E.Classic or E.Cata then
		E.db["unitframe"]["units"]["party"]["customTexts"]["Party:Health"]["text_format"] = "||cffffc607[perhp]||r"
	end

	E.db["unitframe"]["units"]["party"]["customTexts"]["Party:Health"]["xOffset"] = 0
	E.db["unitframe"]["units"]["party"]["customTexts"]["Party:Health"]["yOffset"] = 0
	E.db["unitframe"]["units"]["party"]["customTexts"]["Party:Name"]["attachTextTo"] = "Health"
	E.db["unitframe"]["units"]["party"]["customTexts"]["Party:Name"]["font"] = "Expressway"
	E.db["unitframe"]["units"]["party"]["customTexts"]["Party:Name"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["party"]["customTexts"]["Party:Name"]["justifyH"] = "LEFT"
	E.db["unitframe"]["units"]["party"]["customTexts"]["Party:Name"]["size"] = 17
	E.db["unitframe"]["units"]["party"]["customTexts"]["Party:Name"]["text_format"] = "[classcolor][Hopes:role][name:abbrev][Hopes:leader][Hopes:raidmarker]"
	E.db["unitframe"]["units"]["party"]["customTexts"]["Party:Name"]["xOffset"] = 2
	E.db["unitframe"]["units"]["party"]["customTexts"]["Party:Name"]["yOffset"] = 30
	
	if E.Retail then
		E.db["unitframe"]["units"]["party"]["customTexts"]["Party:HealAbsorb"]["attachTextTo"] = "Health"
		E.db["unitframe"]["units"]["party"]["customTexts"]["Party:HealAbsorb"]["enable"] = true
		E.db["unitframe"]["units"]["party"]["customTexts"]["Party:HealAbsorb"]["font"] = "Expressway"
		E.db["unitframe"]["units"]["party"]["customTexts"]["Party:HealAbsorb"]["fontOutline"] = "OUTLINE"
		E.db["unitframe"]["units"]["party"]["customTexts"]["Party:HealAbsorb"]["justifyH"] = "CENTER"
		E.db["unitframe"]["units"]["party"]["customTexts"]["Party:HealAbsorb"]["size"] = 14
		E.db["unitframe"]["units"]["party"]["customTexts"]["Party:HealAbsorb"]["text_format"] = "||cFFa23838[Hopes:healabsorbs]||r"
		E.db["unitframe"]["units"]["party"]["customTexts"]["Party:HealAbsorb"]["xOffset"] = 0
		E.db["unitframe"]["units"]["party"]["customTexts"]["Party:HealAbsorb"]["yOffset"] = -22
	end

	E.db["unitframe"]["units"]["party"]["debuffs"]["anchorPoint"] = "BOTTOMLEFT"
	E.db["unitframe"]["units"]["party"]["debuffs"]["attachTo"] = "HEALTH"
	E.db["unitframe"]["units"]["party"]["debuffs"]["clickThrough"] = true
	E.db["unitframe"]["units"]["party"]["debuffs"]["countFont"] = "Expressway"
	E.db["unitframe"]["units"]["party"]["debuffs"]["countFontSize"] = 18
	E.db["unitframe"]["units"]["party"]["debuffs"]["countPosition"] = "TOP"
	E.db["unitframe"]["units"]["party"]["debuffs"]["countYOffset"] = 10
	E.db["unitframe"]["units"]["party"]["debuffs"]["maxDuration"] = 0
	E.db["unitframe"]["units"]["party"]["debuffs"]["perrow"] = 3
	E.db["unitframe"]["units"]["party"]["debuffs"]["priority"] = "Blacklist,Dispellable,RaidDebuffs"
	E.db["unitframe"]["units"]["party"]["debuffs"]["sizeOverride"] = 35
	E.db["unitframe"]["units"]["party"]["debuffs"]["sortMethod"] = "INDEX"
	E.db["unitframe"]["units"]["party"]["debuffs"]["spacing"] = 6
	E.db["unitframe"]["units"]["party"]["debuffs"]["xOffset"] = 3
	E.db["unitframe"]["units"]["party"]["debuffs"]["yOffset"] = 3
	E.db["unitframe"]["units"]["party"]["growthDirection"] = "DOWN_LEFT"
	E.db["unitframe"]["units"]["party"]["healPrediction"]["enable"] = true
	E.db["unitframe"]["units"]["party"]["health"]["text_format"] = ""
	E.db["unitframe"]["units"]["party"]["height"] = 85
	E.db["unitframe"]["units"]["party"]["horizontalSpacing"] = -1
	E.db["unitframe"]["units"]["party"]["name"]["position"] = "TOPLEFT"
	E.db["unitframe"]["units"]["party"]["name"]["text_format"] = ""
	E.db["unitframe"]["units"]["party"]["power"]["enable"] = false
	E.db["unitframe"]["units"]["party"]["power"]["text_format"] = ""
	E.db["unitframe"]["units"]["party"]["privateAuras"]["enable"] = false
	E.db["unitframe"]["units"]["party"]["raidRoleIcons"]["enable"] = false
	E.db["unitframe"]["units"]["party"]["raidicon"]["enable"] = false
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["enable"] = false
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["font"] = "Expressway"
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["showDispellableDebuff"] = false
	E.db["unitframe"]["units"]["party"]["readycheckIcon"]["position"] = "CENTER"
	E.db["unitframe"]["units"]["party"]["readycheckIcon"]["size"] = 40
	E.db["unitframe"]["units"]["party"]["resurrectIcon"]["size"] = 40
	E.db["unitframe"]["units"]["party"]["roleIcon"]["enable"] = false
	E.db["unitframe"]["units"]["party"]["summonIcon"]["size"] = 40
	E.db["unitframe"]["units"]["party"]["targetsGroup"]["threatStyle"] = "HEALTHBORDER"
	E.db["unitframe"]["units"]["party"]["threatPrimary"] = false
	E.db["unitframe"]["units"]["party"]["threatStyle"] = "HEALTHBORDER"
	E.db["unitframe"]["units"]["party"]["width"] = 166

	E.db["unitframe"]["units"]["pet"]["colorOverride"] = "FORCE_OFF"

	-- Player
	E.db["movers"]["ElvUF_PlayerMover"] = "BOTTOM,ElvUIParent,BOTTOM,-305,357"
	E.db["unitframe"]["units"]["player"]["RestIcon"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["aurabar"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["buffs"]["attachTo"] = "FRAME"
	E.db["unitframe"]["units"]["player"]["buffs"]["clickThrough"] = true
	E.db["unitframe"]["units"]["player"]["buffs"]["countFont"] = "Expressway"
	E.db["unitframe"]["units"]["player"]["buffs"]["countFontSize"] = 18
	E.db["unitframe"]["units"]["player"]["buffs"]["countPosition"] = "TOP"
	E.db["unitframe"]["units"]["player"]["buffs"]["countYOffset"] = 12
	E.db["unitframe"]["units"]["player"]["buffs"]["height"] = 32
	E.db["unitframe"]["units"]["player"]["buffs"]["keepSizeRatio"] = false
	E.db["unitframe"]["units"]["player"]["buffs"]["perrow"] = 4
	E.db["unitframe"]["units"]["player"]["buffs"]["sizeOverride"] = 32
	E.db["unitframe"]["units"]["player"]["buffs"]["spacing"] = 6
	E.db["unitframe"]["units"]["player"]["buffs"]["xOffset"] = -1
	E.db["unitframe"]["units"]["player"]["buffs"]["yOffset"] = 6
	E.db["unitframe"]["units"]["player"]["castbar"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["castbar"]["width"] = 140
	E.db["unitframe"]["units"]["player"]["classbar"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["colorOverride"] = "FORCE_ON"
	E.db["unitframe"]["units"]["player"]["customTexts"]["Player:Health"]["attachTextTo"] = "Health"
	E.db["unitframe"]["units"]["player"]["customTexts"]["Player:Health"]["font"] = "Expressway"
	E.db["unitframe"]["units"]["player"]["customTexts"]["Player:Health"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["player"]["customTexts"]["Player:Health"]["justifyH"] = "LEFT"
	E.db["unitframe"]["units"]["player"]["customTexts"]["Player:Health"]["size"] = 15
	if E.Retail then
		E.db["unitframe"]["units"]["player"]["customTexts"]["Player:Health"]["text_format"] = "[Hopes:perhp]"
	elseif E.Classic or E.Cata then
		E.db["unitframe"]["units"]["player"]["customTexts"]["Player:Health"]["text_format"] = "[perhp]"
	end
	E.db["unitframe"]["units"]["player"]["customTexts"]["Player:Health"]["xOffset"] = 8
	E.db["unitframe"]["units"]["player"]["customTexts"]["Player:Health"]["yOffset"] = 0
	E.db["unitframe"]["units"]["player"]["customTexts"]["Player:HealthCurrent"]["attachTextTo"] = "Health"
	E.db["unitframe"]["units"]["player"]["customTexts"]["Player:HealthCurrent"]["font"] = "Expressway"
	E.db["unitframe"]["units"]["player"]["customTexts"]["Player:HealthCurrent"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["player"]["customTexts"]["Player:HealthCurrent"]["justifyH"] = "RIGHT"
	E.db["unitframe"]["units"]["player"]["customTexts"]["Player:HealthCurrent"]["size"] = 15
	E.db["unitframe"]["units"]["player"]["customTexts"]["Player:HealthCurrent"]["text_format"] = "[health:current:shortvalue]"
	E.db["unitframe"]["units"]["player"]["customTexts"]["Player:HealthCurrent"]["xOffset"] = -4
	E.db["unitframe"]["units"]["player"]["customTexts"]["Player:HealthCurrent"]["yOffset"] = 0
	E.db["unitframe"]["units"]["player"]["customTexts"]["Player:Name"]["attachTextTo"] = "Power"
	E.db["unitframe"]["units"]["player"]["customTexts"]["Player:Name"]["font"] = "Expressway"
	E.db["unitframe"]["units"]["player"]["customTexts"]["Player:Name"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["player"]["customTexts"]["Player:Name"]["justifyH"] = "LEFT"
	E.db["unitframe"]["units"]["player"]["customTexts"]["Player:Name"]["size"] = 16
	E.db["unitframe"]["units"]["player"]["customTexts"]["Player:Name"]["text_format"] = "[classcolor][name:abbrev][Hopes:leader][Hopes:raidmarker]"
	E.db["unitframe"]["units"]["player"]["customTexts"]["Player:Name"]["xOffset"] = 4
	E.db["unitframe"]["units"]["player"]["customTexts"]["Player:Name"]["yOffset"] = 36
	E.db["unitframe"]["units"]["player"]["debuffs"]["attachTo"] = "BUFFS"
	E.db["unitframe"]["units"]["player"]["debuffs"]["countFont"] = "Expressway"
	E.db["unitframe"]["units"]["player"]["debuffs"]["countFontSize"] = 18
	E.db["unitframe"]["units"]["player"]["debuffs"]["countPosition"] = "TOP"
	E.db["unitframe"]["units"]["player"]["debuffs"]["countYOffset"] = 12
	E.db["unitframe"]["units"]["player"]["debuffs"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["debuffs"]["height"] = 32
	E.db["unitframe"]["units"]["player"]["debuffs"]["keepSizeRatio"] = false
	E.db["unitframe"]["units"]["player"]["debuffs"]["perrow"] = 4
	E.db["unitframe"]["units"]["player"]["debuffs"]["sizeOverride"] = 32
	E.db["unitframe"]["units"]["player"]["debuffs"]["spacing"] = 6
	E.db["unitframe"]["units"]["player"]["debuffs"]["yOffset"] = 6
	E.db["unitframe"]["units"]["player"]["disableMouseoverGlow"] = true
	E.db["unitframe"]["units"]["player"]["fader"]["casting"] = false
	E.db["unitframe"]["units"]["player"]["fader"]["combat"] = false
	E.db["unitframe"]["units"]["player"]["fader"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["fader"]["health"] = false
	E.db["unitframe"]["units"]["player"]["fader"]["hover"] = false
	E.db["unitframe"]["units"]["player"]["fader"]["instanceDifficulties"]["none"] = true
	E.db["unitframe"]["units"]["player"]["fader"]["instanceDifficulties"]["raidHeroic"] = true
	E.db["unitframe"]["units"]["player"]["fader"]["instanceDifficulties"]["raidMythic"] = true
	E.db["unitframe"]["units"]["player"]["fader"]["instanceDifficulties"]["raidNormal"] = true
	E.db["unitframe"]["units"]["player"]["fader"]["minAlpha"] = 0
	E.db["unitframe"]["units"]["player"]["fader"]["playertarget"] = false
	E.db["unitframe"]["units"]["player"]["fader"]["power"] = false
	E.db["unitframe"]["units"]["player"]["fader"]["smooth"] = 0
	E.db["unitframe"]["units"]["player"]["fader"]["vehicle"] = false
	E.db["unitframe"]["units"]["player"]["health"]["position"] = "RIGHT"
	E.db["unitframe"]["units"]["player"]["health"]["text_format"] = ""
	E.db["unitframe"]["units"]["player"]["health"]["xOffset"] = -2
	E.db["unitframe"]["units"]["player"]["height"] = 37
	E.db["unitframe"]["units"]["player"]["portrait"]["overlayAlpha"] = 0.3
	E.db["unitframe"]["units"]["player"]["power"]["detachedWidth"] = 268
	E.db["unitframe"]["units"]["player"]["power"]["position"] = "LEFT"
	E.db["unitframe"]["units"]["player"]["power"]["text_format"] = ""
	E.db["unitframe"]["units"]["player"]["power"]["xOffset"] = 2
	E.db["unitframe"]["units"]["player"]["pvp"]["position"] = "CENTER"
	E.db["unitframe"]["units"]["player"]["raidRoleIcons"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["raidicon"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["resurrectIcon"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["smartAuraPosition"] = "FLUID_DEBUFFS_ON_BUFFS"
	E.db["unitframe"]["units"]["player"]["strataAndLevel"]["frameLevel"] = 2
	E.db["unitframe"]["units"]["player"]["strataAndLevel"]["frameStrata"] = "HIGH"
	E.db["unitframe"]["units"]["player"]["threatStyle"] = "NONE"
	E.db["unitframe"]["units"]["player"]["width"] = 140

	E.db["unitframe"]["units"]["raid2"]["colorOverride"] = "FORCE_OFF"
	E.db["unitframe"]["units"]["raid2"]["enable"] = false
	E.db["unitframe"]["units"]["raid2"]["rdebuffs"]["font"] = "Expressway"
	E.db["unitframe"]["units"]["raid3"]["colorOverride"] = "FORCE_OFF"
	E.db["unitframe"]["units"]["raid3"]["enable"] = false
	E.db["unitframe"]["units"]["raid3"]["rdebuffs"]["font"] = "Expressway"

	E.db["unitframe"]["units"]["tank"]["colorOverride"] = "FORCE_OFF"
	E.db["unitframe"]["units"]["tank"]["enable"] = false
	E.db["unitframe"]["units"]["tank"]["name"]["text_format"] = ""

	E.db["unitframe"]["units"]["target"]["aurabar"]["enable"] = false
	E.db["unitframe"]["units"]["target"]["buffs"]["anchorPoint"] = "TOPLEFT"
	E.db["unitframe"]["units"]["target"]["buffs"]["countFont"] = "Expressway"
	E.db["unitframe"]["units"]["target"]["buffs"]["countFontSize"] = 18
	E.db["unitframe"]["units"]["target"]["buffs"]["countPosition"] = "TOP"
	E.db["unitframe"]["units"]["target"]["buffs"]["countYOffset"] = 12
	E.db["unitframe"]["units"]["target"]["buffs"]["growthX"] = "RIGHT"
	E.db["unitframe"]["units"]["target"]["buffs"]["height"] = 32
	E.db["unitframe"]["units"]["target"]["buffs"]["keepSizeRatio"] = false
	E.db["unitframe"]["units"]["target"]["buffs"]["perrow"] = 4
	E.db["unitframe"]["units"]["target"]["buffs"]["sizeOverride"] = 32
	E.db["unitframe"]["units"]["target"]["buffs"]["spacing"] = 6
	E.db["unitframe"]["units"]["target"]["buffs"]["xOffset"] = -1
	E.db["unitframe"]["units"]["target"]["buffs"]["yOffset"] = 6
	E.db["unitframe"]["units"]["target"]["castbar"]["enable"] = false
	E.db["unitframe"]["units"]["target"]["castbar"]["width"] = 140
	E.db["unitframe"]["units"]["target"]["colorOverride"] = "FORCE_ON"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Target:Health"]["attachTextTo"] = "Health"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Target:Health"]["font"] = "Expressway"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Target:Health"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Target:Health"]["justifyH"] = "RIGHT"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Target:Health"]["size"] = 15
	if E.Retail then
		E.db["unitframe"]["units"]["target"]["customTexts"]["Target:Health"]["text_format"] = "[Hopes:perhp]"
	elseif E.Classic or E.Cata then
		E.db["unitframe"]["units"]["target"]["customTexts"]["Target:Health"]["text_format"] = "[perhp]"
	end
	E.db["unitframe"]["units"]["target"]["customTexts"]["Target:Health"]["xOffset"] = -8
	E.db["unitframe"]["units"]["target"]["customTexts"]["Target:Health"]["yOffset"] = 0
	E.db["unitframe"]["units"]["target"]["customTexts"]["Target:HealthCurrent"]["attachTextTo"] = "Health"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Target:HealthCurrent"]["font"] = "Expressway"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Target:HealthCurrent"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Target:HealthCurrent"]["justifyH"] = "LEFT"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Target:HealthCurrent"]["size"] = 15
	E.db["unitframe"]["units"]["target"]["customTexts"]["Target:HealthCurrent"]["text_format"] = "[health:current:shortvalue]"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Target:HealthCurrent"]["xOffset"] = 4
	E.db["unitframe"]["units"]["target"]["customTexts"]["Target:HealthCurrent"]["yOffset"] = 0
	E.db["unitframe"]["units"]["target"]["customTexts"]["Target:Name"]["attachTextTo"] = "Power"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Target:Name"]["font"] = "Expressway"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Target:Name"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Target:Name"]["justifyH"] = "LEFT"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Target:Name"]["size"] = 16
	E.db["unitframe"]["units"]["target"]["customTexts"]["Target:Name"]["text_format"] = "[classcolor][name:abbrev:veryshort][Hopes:leader][Hopes:raidmarker] [||cffFFFFFF»||r >classcolor:target][target:abbrev:veryshort] "
	E.db["unitframe"]["units"]["target"]["customTexts"]["Target:Name"]["xOffset"] = 4
	E.db["unitframe"]["units"]["target"]["customTexts"]["Target:Name"]["yOffset"] = 36
	E.db["unitframe"]["units"]["target"]["debuffs"]["anchorPoint"] = "TOPLEFT"
	E.db["unitframe"]["units"]["target"]["debuffs"]["countFont"] = "Expressway"
	E.db["unitframe"]["units"]["target"]["debuffs"]["countFontSize"] = 18
	E.db["unitframe"]["units"]["target"]["debuffs"]["countPosition"] = "TOP"
	E.db["unitframe"]["units"]["target"]["debuffs"]["countYOffset"] = 12
	E.db["unitframe"]["units"]["target"]["debuffs"]["growthX"] = "RIGHT"
	E.db["unitframe"]["units"]["target"]["debuffs"]["height"] = 32
	E.db["unitframe"]["units"]["target"]["debuffs"]["keepSizeRatio"] = false
	E.db["unitframe"]["units"]["target"]["debuffs"]["maxDuration"] = 0
	E.db["unitframe"]["units"]["target"]["debuffs"]["perrow"] = 4
	E.db["unitframe"]["units"]["target"]["debuffs"]["priority"] = "Blacklist,Dispellable,Personal,RaidDebuffs,CCDebuffs,Friendly:Dispellable"
	E.db["unitframe"]["units"]["target"]["debuffs"]["sizeOverride"] = 32
	E.db["unitframe"]["units"]["target"]["debuffs"]["spacing"] = 6
	E.db["unitframe"]["units"]["target"]["debuffs"]["yOffset"] = 6
	E.db["unitframe"]["units"]["target"]["health"]["text_format"] = ""
	E.db["unitframe"]["units"]["target"]["height"] = 37
	E.db["unitframe"]["units"]["target"]["name"]["text_format"] = ""
	E.db["unitframe"]["units"]["target"]["portrait"]["overlayAlpha"] = 0.3
	E.db["unitframe"]["units"]["target"]["power"]["detachedWidth"] = 268
	E.db["unitframe"]["units"]["target"]["power"]["text_format"] = ""
	E.db["unitframe"]["units"]["target"]["raidRoleIcons"]["enable"] = false
	E.db["unitframe"]["units"]["target"]["raidicon"]["enable"] = false
	E.db["unitframe"]["units"]["target"]["resurrectIcon"]["enable"] = false
	E.db["unitframe"]["units"]["target"]["smartAuraPosition"] = "FLUID_DEBUFFS_ON_BUFFS"
	E.db["unitframe"]["units"]["target"]["strataAndLevel"]["frameLevel"] = 2
	E.db["unitframe"]["units"]["target"]["strataAndLevel"]["frameStrata"] = "HIGH"
	E.db["unitframe"]["units"]["target"]["threatStyle"] = "NONE"
	E.db["unitframe"]["units"]["target"]["width"] = 140

	E.db["unitframe"]["units"]["targettarget"]["enable"] = false
	E.db["unitframe"]["units"]["targettarget"]["colorOverride"] = "FORCE_ON"
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["TargetTarget:Name"]["attachTextTo"] = "Power"
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["TargetTarget:Name"]["font"] = "Expressway"
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["TargetTarget:Name"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["TargetTarget:Name"]["justifyH"] = "LEFT"
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["TargetTarget:Name"]["size"] = 15
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["TargetTarget:Name"]["text_format"] = "[classcolor][name:abbrev]"
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["TargetTarget:Name"]["xOffset"] = 2
	E.db["unitframe"]["units"]["targettarget"]["customTexts"]["TargetTarget:Name"]["yOffset"] = 28
	E.db["unitframe"]["units"]["targettarget"]["height"] = 28
	E.db["unitframe"]["units"]["targettarget"]["name"]["text_format"] = ""
	E.db["unitframe"]["units"]["targettarget"]["power"]["height"] = 6
	
	-- Blacklist auras. 
	E.global["unitframe"]["aurafilters"]["Blacklist"]["spells"] = E.global["unitframe"]["aurafilters"]["Blacklist"]["spells"] or {}
	E.global["unitframe"]["aurafilters"]["Blacklist"]["spells"][25771] = {["enable"] = false}
	E.global["unitframe"]["aurafilters"]["Blacklist"]["spells"][264689] = {["enable"] = true, ["priority"] = 0, ["stackThreshold"] = 0}
	E.global["unitframe"]["aurafilters"]["Blacklist"]["spells"][371070] = {["enable"] = true, ["priority"] = 0, ["stackThreshold"] = 0}
	E.global["unitframe"]["aurafilters"]["Blacklist"]["spells"][374609] = {["enable"] = true, ["priority"] = 0, ["stackThreshold"] = 0}
	E.global["unitframe"]["aurafilters"]["Blacklist"]["spells"][382912] = {["enable"] = true, ["priority"] = 0, ["stackThreshold"] = 0}
	E.global["unitframe"]["aurafilters"]["Blacklist"]["spells"][387441] = {["enable"] = true, ["priority"] = 0, ["stackThreshold"] = 0}
	E.global["unitframe"]["aurafilters"]["Blacklist"]["spells"][387847] = {["enable"] = true, ["priority"] = 0, ["stackThreshold"] = 0}
	E.global["unitframe"]["aurafilters"]["Blacklist"]["spells"][390435] = {["enable"] = true, ["priority"] = 0, ["stackThreshold"] = 0}
	E.global["unitframe"]["aurafilters"]["Blacklist"]["spells"][407475] = {["enable"] = true, ["priority"] = 0, ["stackThreshold"] = 0}
	E.global["unitframe"]["aurafilters"]["Blacklist"]["spells"][426897] = {["enable"] = true, ["priority"] = 0, ["stackThreshold"] = 0}
	E.global["unitframe"]["aurafilters"]["Blacklist"]["spells"][449042] = {["enable"] = true, ["priority"] = 0, ["stackThreshold"] = 0}
	E.global["unitframe"]["aurafilters"]["Blacklist"]["spells"][440313] = {["enable"] = true, ["priority"] = 0, ["stackThreshold"] = 0}
	E.global["unitframe"]["aurafilters"]["Blacklist"]["spells"][441795] = {["enable"] = true, ["priority"] = 0, ["stackThreshold"] = 0}
	E.global["unitframe"]["aurafilters"]["Blacklist"]["spells"][449042] = {["enable"] = true, ["priority"] = 0, ["stackThreshold"] = 0}
	E.global["unitframe"]["aurafilters"]["Blacklist"]["spells"][463767] = {["enable"] = true, ["priority"] = 0, ["stackThreshold"] = 0}
	E.global["unitframe"]["aurafilters"]["Blacklist"]["spells"][245102] = {["enable"] = true, ["priority"] = 0, ["stackThreshold"] = 0}
	
	-- ProjectHopes Plugin (Modules)
		-- unitframe glowline.
	E.db["ProjectHopes"]["unitframe"]["unitFramesGlowline"] = true
		-- Rectangle Minimap
	E.db["ProjectHopes"]["minimap"]["Rectangle"] = true
		-- Minimap Buttons
	E.db["ProjectHopes"]["minimapbutton"]["enable"] = true
	E.db["ProjectHopes"]["minimapbutton"]["skinStyle"] = 'HORIZONTAL'
	E.db["ProjectHopes"]["minimapbutton"]["layoutDirection"] = 'NORMAL'
	E.db["ProjectHopes"]["minimapbutton"]["backdrop"] = false
	E.db["ProjectHopes"]["minimapbutton"]["buttonSize"] = 40
	E.db["ProjectHopes"]["minimapbutton"]["mouseover"] = false
	E.db["ProjectHopes"]["minimapbutton"]["border"] = true
	E.db["ProjectHopes"]["minimapbutton"]["buttonsPerRow"] = 4
		-- Minimap Instance Difficulty
	E.db["ProjectHopes"]["minimapid"]["enable"] = true
	E.db["ProjectHopes"]["minimapid"]["hideBlizzard"] = true
	E.db["ProjectHopes"]["minimapid"]["align"] = "RIGHT"
	E.db["ProjectHopes"]["minimapid"]["font"]["name"] = "Expressway"
	E.db["ProjectHopes"]["minimapid"]["font"]["size"] = 20
	E.db["ProjectHopes"]["minimapid"]["font"]["style"] = "OUTLINE"
		-- Overshield Absorb
	E.db["ProjectHopes"]["overshield"]["Absorb"] = true
		-- Custom Target Border
	E.db["ProjectHopes"]["targetGlow"]["foreground"] = true
		-- Custom Health Backdrop
	E.db["ProjectHopes"]["cbackdrop"]["Backdrop"] = true
	E.db["ProjectHopes"]["cbackdrop"]["customtexture"] = 'Health Background'
		-- Weakaura Main frame
	E.db["ProjectHopes"]["weakauramainframe"]["Frame"] = false

	-- ProjectHopes Plugin (Borders)
		-- Player
	E.db["ProjectHopes"]["border"]["Player"] = true
	E.db["ProjectHopes"]["border"]["Playersep"] = true
	E.db["ProjectHopes"]["border"]["playerpor"] = true
	E.db["ProjectHopes"]["border"]["playerporframelevel"] = 1
		-- Pet
	E.db["ProjectHopes"]["border"]["Pet"] = true
	E.db["ProjectHopes"]["border"]["Petsep"] = true
		-- Target
	E.db["ProjectHopes"]["border"]["Target"] = true
	E.db["ProjectHopes"]["border"]["Targetsep"] = true
	E.db["ProjectHopes"]["border"]["targetpor"] = true
		-- Focus
	E.db["ProjectHopes"]["border"]["Focus"] = true
	E.db["ProjectHopes"]["border"]["Focussep"] = true
	E.db["ProjectHopes"]["border"]["focuspor"] = true
		-- Target Target
	E.db["ProjectHopes"]["border"]["TargetofTarget"] = true
	E.db["ProjectHopes"]["border"]["TargetofTargetsep"] = true
	E.db["ProjectHopes"]["border"]["targettargetpor"] = true
		-- Party
	E.db["ProjectHopes"]["border"]["Party"] = true
	E.db["ProjectHopes"]["border"]["Partysep"] = true
		-- Off tank and main tank
	E.db["ProjectHopes"]["border"]["Maintankofftank"] = true
		-- Assist Units
	E.db["ProjectHopes"]["border"]["AssistUnits"] = true
		-- Boss
	E.db["ProjectHopes"]["border"]["Boss"] = true
	E.db["ProjectHopes"]["border"]["Bosssep"] = true
		-- Arena
	E.db["ProjectHopes"]["border"]["Arena"] = true
	E.db["ProjectHopes"]["border"]["Arenasep"] = true
		-- Buffs/Debuffs
	E.db["ProjectHopes"]["border"]["Aura"] = true
	E.db["ProjectHopes"]["border"]["AuraUF"] = true

	-- ProjectHopes Plugin (Skins)
	-- Addons
	E.db["ProjectHopes"]["skins"]["warpdeplete"] = true
	E.db["ProjectHopes"]["skins"]["bigwigsqueue"] = true
	E.db["ProjectHopes"]["skins"]["auctionator"] = true
	E.db["ProjectHopes"]["skins"]["bugsack"] = true
	E.db["ProjectHopes"]["skins"]["raiderio"] = true
	E.db["ProjectHopes"]["skins"]["omnicd"] = true
	E.db["ProjectHopes"]["skins"]["rareScanner"] = true
	E.db["ProjectHopes"]["skins"]["hekili"] = true
	E.db["ProjectHopes"]["skins"]["weakAurasOptions"] = true
	E.db["ProjectHopes"]["skins"]["simulationcraft"] = true
	E.db["ProjectHopes"]["skins"]["Baganator"] = true
	E.db["ProjectHopes"]["skins"]["details"] = true
	E.db["ProjectHopes"]["skins"]["detailsresize"] = true
	E.db["ProjectHopes"]["skins"]["mazeHelper"] = true
	E.db["ProjectHopes"]["skins"]["talentTreeTweaks"] = true
	E.db["ProjectHopes"]["skins"]["talentLoadoutsEx"] = true
	E.db["ProjectHopes"]["skins"]["choreTracker"] = true
	
	-- Blizzard
	if E.Retail then
		E.db["ProjectHopes"]["skins"]["achievementFrame"] = true
		E.db["ProjectHopes"]["skins"]["adventureMap"] = true
		E.db["ProjectHopes"]["skins"]["addonList"] = true
		E.db["ProjectHopes"]["skins"]["alertframes"] = true
		E.db["ProjectHopes"]["skins"]["alliedRaces"] = true
		E.db["ProjectHopes"]["skins"]["animaDiversionFrame"] = true
		E.db["ProjectHopes"]["skins"]["artifactFrame"] = true
		E.db["ProjectHopes"]["skins"]["auctionHouse"] = true
		E.db["ProjectHopes"]["skins"]["azerite"] = true
		E.db["ProjectHopes"]["skins"]["archaeologyFrame"] = true
		E.db["ProjectHopes"]["skins"]["azeriteEssence"] = true
		E.db["ProjectHopes"]["skins"]["azeriteRespec"] = true
		E.db["ProjectHopes"]["skins"]["barbershop"] = true
		E.db["ProjectHopes"]["skins"]["bag"] = true
		E.db["ProjectHopes"]["skins"]["battleNet"] = true
		E.db["ProjectHopes"]["skins"]["binding"] = true
		E.db["ProjectHopes"]["skins"]["blackMarket"] = true
		E.db["ProjectHopes"]["skins"]["calendar"] = true
		E.db["ProjectHopes"]["skins"]["challenges"] = true
		E.db["ProjectHopes"]["skins"]["chatConfig"] = true
		E.db["ProjectHopes"]["skins"]["channels"] = true
		E.db["ProjectHopes"]["skins"]["character"] = true
		E.db["ProjectHopes"]["skins"]["chromieTime"] = true
		E.db["ProjectHopes"]["skins"]["classTalent"] = true
		E.db["ProjectHopes"]["skins"]["clickBinding"] = true
		E.db["ProjectHopes"]["skins"]["collections"] = true
		E.db["ProjectHopes"]["skins"]["contribution"] = true
		E.db["ProjectHopes"]["skins"]["transmogrify"] = true
		E.db["ProjectHopes"]["skins"]["communities"] = true
		E.db["ProjectHopes"]["skins"]["covenantPreview"] = true
		E.db["ProjectHopes"]["skins"]["covenantRenown"] = true
		E.db["ProjectHopes"]["skins"]["covenantSanctum"] = true
		E.db["ProjectHopes"]["skins"]["debugTools"] = true
		E.db["ProjectHopes"]["skins"]["deathRecap"] = true
		E.db["ProjectHopes"]["skins"]["dressingRoom"] = true
		E.db["ProjectHopes"]["skins"]["editModeManager"] = true
		E.db["ProjectHopes"]["skins"]["encounterJournal"] = true
		E.db["ProjectHopes"]["skins"]["eventTrace"] = true
		E.db["ProjectHopes"]["skins"]["expansionLandingPage"] = true
		E.db["ProjectHopes"]["skins"]["flightMap"] = true
		E.db["ProjectHopes"]["skins"]["friends"] = true
		E.db["ProjectHopes"]["skins"]["garrison"] = true
		E.db["ProjectHopes"]["skins"]["genericTrait"] = true
		E.db["ProjectHopes"]["skins"]["gossip"] = true
		E.db["ProjectHopes"]["skins"]["guild"] = true
		E.db["ProjectHopes"]["skins"]["guildBank"] = true
		E.db["ProjectHopes"]["skins"]["guildControl"] = true
		E.db["ProjectHopes"]["skins"]["guildRegistrar"] = true
		E.db["ProjectHopes"]["skins"]["guide"] = true
		E.db["ProjectHopes"]["skins"]["help"] = true
		E.db["ProjectHopes"]["skins"]["inputMethodEditor"] = true
		E.db["ProjectHopes"]["skins"]["inspect"] = true
		E.db["ProjectHopes"]["skins"]["itemInteraction"] = true
		E.db["ProjectHopes"]["skins"]["islandsPartyPose"] = true
		E.db["ProjectHopes"]["skins"]["islandQueue"] = true
		E.db["ProjectHopes"]["skins"]["itemSocketing"] = true
		E.db["ProjectHopes"]["skins"]["itemUpgrade"] = true
		E.db["ProjectHopes"]["skins"]["lookingForGroup"] = true
		E.db["ProjectHopes"]["skins"]["lfguild"] = true
		E.db["ProjectHopes"]["skins"]["loot"] = true
		E.db["ProjectHopes"]["skins"]["lossOfControl"] = true
		E.db["ProjectHopes"]["skins"]["macro"] = true
		E.db["ProjectHopes"]["skins"]["mail"] = true
		E.db["ProjectHopes"]["skins"]["majorFactions"] = true
		E.db["ProjectHopes"]["skins"]["merchant"] = true
		E.db["ProjectHopes"]["skins"]["microButtons"] = true
		E.db["ProjectHopes"]["skins"]["mirrorTimers"] = true
		E.db["ProjectHopes"]["skins"]["misc"] = true
		E.db["ProjectHopes"]["skins"]["objectiveTracker"] = true
		E.db["ProjectHopes"]["skins"]["obliterum"] = true
		E.db["ProjectHopes"]["skins"]["orderHall"] = true
		E.db["ProjectHopes"]["skins"]["perksProgram"] = true
		E.db["ProjectHopes"]["skins"]["petBattle"] = true
		E.db["ProjectHopes"]["skins"]["petition"] = true
		E.db["ProjectHopes"]["skins"]["playerChoice"] = true
		E.db["ProjectHopes"]["skins"]["professions"] = true
		E.db["ProjectHopes"]["skins"]["professionsCustomerOrders"] = true
		E.db["ProjectHopes"]["skins"]["bgscore"] = true
		E.db["ProjectHopes"]["skins"]["quest"] = true
		E.db["ProjectHopes"]["skins"]["questChoice"] = true
		E.db["ProjectHopes"]["skins"]["raidInfo"] = true
		E.db["ProjectHopes"]["skins"]["runeforge"] = true	
		E.db["ProjectHopes"]["skins"]["scenario"] = true
		E.db["ProjectHopes"]["skins"]["scrappingMachine"] = true
		E.db["ProjectHopes"]["skins"]["settingsPanel"] = true
		E.db["ProjectHopes"]["skins"]["soulbinds"] = true
		E.db["ProjectHopes"]["skins"]["spellBook"] = true
		E.db["ProjectHopes"]["skins"]["stable"] = true
		E.db["ProjectHopes"]["skins"]["blizzardstaticPopup"] = true
		E.db["ProjectHopes"]["skins"]["subscriptionInterstitial"] = true
		E.db["ProjectHopes"]["skins"]["tabard"] = true
		E.db["ProjectHopes"]["skins"]["talkingHead"] = true
		E.db["ProjectHopes"]["skins"]["taxi"] = true
		E.db["ProjectHopes"]["skins"]["ticketStatus"] = true
		E.db["ProjectHopes"]["skins"]["timeManager"] = true
		E.db["ProjectHopes"]["skins"]["tooltips"] = true
		E.db["ProjectHopes"]["skins"]["tooltipscolor"] = true
		E.db["ProjectHopes"]["skins"]["torghastLevelPicker"] = true	
		E.db["ProjectHopes"]["skins"]["trade"] = true
		E.db["ProjectHopes"]["skins"]["trainer"] = true
		E.db["ProjectHopes"]["skins"]["tutorial"] = true
		E.db["ProjectHopes"]["skins"]["voidstorage"] = true
		E.db["ProjectHopes"]["skins"]["warboard"] = true
		E.db["ProjectHopes"]["skins"]["weeklyRewards"] = true
		E.db["ProjectHopes"]["skins"]["worldMap"] = true
	elseif E.Classic then
		E.db["ProjectHopes"]["skins"]["addonList"] = true
		E.db["ProjectHopes"]["skins"]["auctionHouse"] = true
		E.db["ProjectHopes"]["skins"]["battleNet"] = true
		E.db["ProjectHopes"]["skins"]["bgscore"] = true
		E.db["ProjectHopes"]["skins"]["channels"] = true
		E.db["ProjectHopes"]["skins"]["character"] = true
		E.db["ProjectHopes"]["skins"]["communities"] = true
		E.db["ProjectHopes"]["skins"]["debugTools"] = true
		E.db["ProjectHopes"]["skins"]["dressingRoom"] = true
		E.db["ProjectHopes"]["skins"]["eventTrace"] = true
		E.db["ProjectHopes"]["skins"]["flightMap"] = true
		E.db["ProjectHopes"]["skins"]["friends"] = true
		E.db["ProjectHopes"]["skins"]["gossip"] = true
		E.db["ProjectHopes"]["skins"]["guild"] = true
		E.db["ProjectHopes"]["skins"]["guildControl"] = true
		E.db["ProjectHopes"]["skins"]["guildRegistrar"] = true
		E.db["ProjectHopes"]["skins"]["help"] = true
		E.db["ProjectHopes"]["skins"]["inputMethodEditor"] = true
		E.db["ProjectHopes"]["skins"]["inspect"] = true
		E.db["ProjectHopes"]["skins"]["lookingForGroup"] = true
		E.db["ProjectHopes"]["skins"]["loot"] = true
		E.db["ProjectHopes"]["skins"]["macro"] = true
		E.db["ProjectHopes"]["skins"]["mail"] = true
		E.db["ProjectHopes"]["skins"]["merchant"] = true
		E.db["ProjectHopes"]["skins"]["mirrorTimers"] = true
		E.db["ProjectHopes"]["skins"]["misc"] = true
		E.db["ProjectHopes"]["skins"]["options"] = true
		E.db["ProjectHopes"]["skins"]["petition"] = true
		E.db["ProjectHopes"]["skins"]["quest"] = true
		E.db["ProjectHopes"]["skins"]["settingsPanel"] = true
		E.db["ProjectHopes"]["skins"]["spellBook"] = true
		E.db["ProjectHopes"]["skins"]["stable"] = true
		E.db["ProjectHopes"]["skins"]["subscriptionInterstitial"] = true
		E.db["ProjectHopes"]["skins"]["tabard"] = true
		E.db["ProjectHopes"]["skins"]["taxi"] = true
		E.db["ProjectHopes"]["skins"]["timeManager"] = true
		E.db["ProjectHopes"]["skins"]["tooltips"] = true
		E.db["ProjectHopes"]["skins"]["trade"] = true
		E.db["ProjectHopes"]["skins"]["trainer"] = true
		E.db["ProjectHopes"]["skins"]["tutorial"] = true
		E.db["ProjectHopes"]["skins"]["worldMap"] = true
	elseif E.Cata then
		E.db["ProjectHopes"]["skins"]["achievementFrame"] = true
		E.db["ProjectHopes"]["skins"]["addonList"] = true
		E.db["ProjectHopes"]["skins"]["auctionHouse"] = true
		E.db["ProjectHopes"]["skins"]["battleNet"] = true
		E.db["ProjectHopes"]["skins"]["bgscore"] = true
		E.db["ProjectHopes"]["skins"]["channels"] = true
		E.db["ProjectHopes"]["skins"]["character"] = true
		E.db["ProjectHopes"]["skins"]["bgmap"] = true
		E.db["ProjectHopes"]["skins"]["barbershop"] = true
		E.db["ProjectHopes"]["skins"]["communities"] = true
		E.db["ProjectHopes"]["skins"]["calendar"] = true
		E.db["ProjectHopes"]["skins"]["debugTools"] = true
		E.db["ProjectHopes"]["skins"]["collections"] = true
		E.db["ProjectHopes"]["skins"]["transmogrify"] = true
		E.db["ProjectHopes"]["skins"]["dressingRoom"] = true
		E.db["ProjectHopes"]["skins"]["eventTrace"] = true
		E.db["ProjectHopes"]["skins"]["flightMap"] = true
		E.db["ProjectHopes"]["skins"]["friends"] = true
		E.db["ProjectHopes"]["skins"]["gossip"] = true
		E.db["ProjectHopes"]["skins"]["guild"] = true
		E.db["ProjectHopes"]["skins"]["encounterJournal"] = true
		E.db["ProjectHopes"]["skins"]["guildControl"] = true
		E.db["ProjectHopes"]["skins"]["guildRegistrar"] = true
		E.db["ProjectHopes"]["skins"]["help"] = true
		E.db["ProjectHopes"]["skins"]["inputMethodEditor"] = true
		E.db["ProjectHopes"]["skins"]["inspect"] = true
		E.db["ProjectHopes"]["skins"]["lookingForGroup"] = true
		E.db["ProjectHopes"]["skins"]["loot"] = true
		E.db["ProjectHopes"]["skins"]["runeforge"] = true
		E.db["ProjectHopes"]["skins"]["macro"] = true
		E.db["ProjectHopes"]["skins"]["mail"] = true
		E.db["ProjectHopes"]["skins"]["merchant"] = true
		E.db["ProjectHopes"]["skins"]["mirrorTimers"] = true
		E.db["ProjectHopes"]["skins"]["itemSocketing"] = true
		E.db["ProjectHopes"]["skins"]["misc"] = true
		E.db["ProjectHopes"]["skins"]["options"] = true
		E.db["ProjectHopes"]["skins"]["petition"] = true
		E.db["ProjectHopes"]["skins"]["talent"] = true
		E.db["ProjectHopes"]["skins"]["quest"] = true
		E.db["ProjectHopes"]["skins"]["settingsPanel"] = true
		E.db["ProjectHopes"]["skins"]["spellBook"] = true
		E.db["ProjectHopes"]["skins"]["stable"] = true
		E.db["ProjectHopes"]["skins"]["subscriptionInterstitial"] = true
		E.db["ProjectHopes"]["skins"]["tabard"] = true
		E.db["ProjectHopes"]["skins"]["taxi"] = true
		E.db["ProjectHopes"]["skins"]["timeManager"] = true
		E.db["ProjectHopes"]["skins"]["tooltips"] = true
		E.db["ProjectHopes"]["skins"]["trade"] = true
		E.db["ProjectHopes"]["skins"]["trainer"] = true
		E.db["ProjectHopes"]["skins"]["tutorial"] = true
		E.db["ProjectHopes"]["skins"]["tradeskill"] = true
		E.db["ProjectHopes"]["skins"]["worldMap"] = true
	end
	-- ElvUI
	E.db["ProjectHopes"]["skins"]["actionBarsBackdrop"] = true
	E.db["ProjectHopes"]["skins"]["actionBarsButton"] = true
	E.db["ProjectHopes"]["skins"]["afk"] = true
	E.db["ProjectHopes"]["skins"]["altPowerBar"] = true
	E.db["ProjectHopes"]["skins"]["chatDataPanels"] = true
	E.db["ProjectHopes"]["skins"]["chatPanels"] = true
	E.db["ProjectHopes"]["skins"]["chatVoicePanel"] = true
	E.db["ProjectHopes"]["skins"]["chatCopyFrame"] = true
	E.db["ProjectHopes"]["skins"]["lootRoll"] = true
	E.db["ProjectHopes"]["skins"]["options"] = true
	E.db["ProjectHopes"]["skins"]["panels"] = true
	E.db["ProjectHopes"]["skins"]["raidUtility"] = true
	E.db["ProjectHopes"]["skins"]["staticPopup"] = true
	E.db["ProjectHopes"]["skins"]["statusReport"] = true
	E.db["ProjectHopes"]["skins"]["totemTracker"] = true
	E.db["ProjectHopes"]["skins"]["Minimap"] = true
	E.db["ProjectHopes"]["skins"]["dataPanels"] = true

	if layout == 'main' then
		E.db["unitframe"]["units"]["player"]["enable"] = true
		E.db["unitframe"]["units"]["targettarget"]["enable"] = true

		-- Raid
		E.db["ProjectHopes"]["border"]["raiddps"] = true

		-- Raid 1
		E.db["unitframe"]["units"]["raid1"]["buffIndicator"]["enable"] = false
		E.db["unitframe"]["units"]["raid1"]["colorOverride"] = "FORCE_ON"
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Health"]["attachTextTo"] = "Health"
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Health"]["enable"] = true
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Health"]["font"] = "Expressway"
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Health"]["fontOutline"] = "OUTLINE"
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Health"]["justifyH"] = "CENTER"
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Health"]["size"] = 16
		if E.Retail then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Health"]["text_format"] = "||cffffc607[Hopes:perhp]||r"
		elseif E.Classic or E.Cata then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Health"]["text_format"] = "||cffffc607[perhp]||r"
		end
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Health"]["xOffset"] = 0
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Health"]["yOffset"] = 0
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Name"]["attachTextTo"] = "Health"
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Name"]["enable"] = true
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Name"]["font"] = "Expressway"
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Name"]["fontOutline"] = "OUTLINE"
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Name"]["justifyH"] = "LEFT"
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Name"]["size"] = 13
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Name"]["text_format"] = "[group][classcolor][Hopes:role][name:abbrev][Hopes:leader][Hopes:raidmarker]"
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Name"]["xOffset"] = 2
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Name"]["yOffset"] = 20

		E.db["unitframe"]["units"]["raid1"]["debuffs"]["clickThrough"] = true
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["countFont"] = "Expressway"
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["countFontSize"] = 16
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["countPosition"] = "TOP"
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["countYOffset"] = 8
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["enable"] = true
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["growthX"] = "LEFT"
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["maxDuration"] = 0
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["perrow"] = 2
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["priority"] = "Blacklist,Dispellable,RaidDebuffs"
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["sizeOverride"] = 32
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["sortMethod"] = "INDEX"

		E.db["unitframe"]["units"]["raid1"]["debuffs"]["spacing"] = 6
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["xOffset"] = 7
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["yOffset"] = -1
		E.db["unitframe"]["units"]["raid1"]["disableFocusGlow"] = true
		E.db["unitframe"]["units"]["raid1"]["groupsPerRowCol"] = 4
		E.db["unitframe"]["units"]["raid1"]["groupSpacing"] = 15

		E.db["unitframe"]["units"]["raid1"]["growthDirection"] = "DOWN_RIGHT"
		E.db["unitframe"]["units"]["raid1"]["healPrediction"]["enable"] = true
		E.db["unitframe"]["units"]["raid1"]["health"]["text_format"] = ""
		E.db["unitframe"]["units"]["raid1"]["height"] = 30
		E.db["unitframe"]["units"]["raid1"]["horizontalSpacing"] = 100
		E.db["unitframe"]["units"]["raid1"]["name"]["text_format"] = ""
		E.db["unitframe"]["units"]["raid1"]["numGroups"] = 8
		E.db["unitframe"]["units"]["raid1"]["orientation"] = "LEFT"
		E.db["unitframe"]["units"]["raid1"]["power"]["enable"] = false
		E.db["unitframe"]["units"]["raid1"]["raidRoleIcons"]["enable"] = false
		E.db["unitframe"]["units"]["raid1"]["raidicon"]["enable"] = false
		E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["enable"] = false
		E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["font"] = "Expressway"
		E.db["unitframe"]["units"]["raid1"]["readycheckIcon"]["position"] = "CENTER"
		E.db["unitframe"]["units"]["raid1"]["readycheckIcon"]["size"] = 40
		E.db["unitframe"]["units"]["raid1"]["resurrectIcon"]["size"] = 40
		E.db["unitframe"]["units"]["raid1"]["roleIcon"]["enable"] = false
		E.db["unitframe"]["units"]["raid1"]["summonIcon"]["size"] = 40
		E.db["unitframe"]["units"]["raid1"]["threatStyle"] = "HEALTHBORDER"
		E.db["unitframe"]["units"]["raid1"]["verticalSpacing"] = 10
		E.db["unitframe"]["units"]["raid1"]["visibility"] = "[@raid6,noexists] hide;show"
		E.db["unitframe"]["units"]["raid1"]["width"] = 160

		E.db["unitframe"]["units"]["party"]["visibility"] = "[@raid6,exists][@party1,noexists] hide;show"
		
		-- Movers for DPS/TANK layout.
		E.db["movers"]["ElvUF_PartyMover"] = "BOTTOM,ElvUIParent,BOTTOM,-409,412"
		E.db["movers"]["ElvUF_TargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,305,357"
		E.db["movers"]["ElvUF_FocusMover"] = "TOP,ElvUIParent,TOP,-248,-591"
		E.db["movers"]["ElvUF_Raid1Mover"] = "TOPLEFT,UIParent,TOPLEFT,43,-287"
		
	elseif layout == 'healing' then
		E.db["unitframe"]["units"]["player"]["enable"] = false

		-- Raid
		E.db["ProjectHopes"]["border"]["raid"] = true
		E.db["ProjectHopes"]["border"]["raidbackdrop"] = true

		-- Raid 1
		E.db["unitframe"]["units"]["raid1"]["buffIndicator"]["enable"] = false
		E.db["unitframe"]["units"]["raid1"]["colorOverride"] = "FORCE_OFF"
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Health"]["attachTextTo"] = "Health"
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Health"]["font"] = "Expressway"
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Health"]["fontOutline"] = "OUTLINE"
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Health"]["justifyH"] = "CENTER"
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Health"]["size"] = 23
		if E.Retail then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Health"]["text_format"] = "||cffffc607[Hopes:perhp]||r"
		elseif E.Classic or E.Cata then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Health"]["text_format"] = "||cffffc607[perhp]||r"
		end
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Health"]["xOffset"] = 0
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Health"]["yOffset"] = 0
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Name"]["attachTextTo"] = "Health"
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Name"]["font"] = "Expressway"
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Name"]["fontOutline"] = "OUTLINE"
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Name"]["justifyH"] = "LEFT"
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Name"]["size"] = 15
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Name"]["text_format"] = "[classcolor][Hopes:role][name:abbrev][Hopes:leader][Hopes:raidmarker]"
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Name"]["xOffset"] = 2
		E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:Name"]["yOffset"] = 29

		if E.Retail then
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:HealAbsorb"]["attachTextTo"] = "Health"
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:HealAbsorb"]["enable"] = true
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:HealAbsorb"]["font"] = "Expressway"
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:HealAbsorb"]["fontOutline"] = "OUTLINE"
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:HealAbsorb"]["justifyH"] = "CENTER"
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:HealAbsorb"]["size"] = 14
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:HealAbsorb"]["text_format"] = "||cFFa23838[Hopes:healabsorbs]||r"
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:HealAbsorb"]["xOffset"] = 0
			E.db["unitframe"]["units"]["raid1"]["customTexts"]["Raid1:HealAbsorb"]["yOffset"] = -22
		end

		E.db["unitframe"]["units"]["raid1"]["debuffs"]["anchorPoint"] = "BOTTOMLEFT"
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["attachTo"] = "HEALTH"
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["clickThrough"] = true
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["countFont"] = "Expressway"
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["countFontSize"] = 15
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["countPosition"] = "TOP"
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["countYOffset"] = 8
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["enable"] = true
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["maxDuration"] = 0
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["priority"] = "Blacklist,Dispellable,RaidDebuffs"
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["sizeOverride"] = 30
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["spacing"] = 6
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["xOffset"] = 4
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["yOffset"] = 3
		E.db["unitframe"]["units"]["raid1"]["debuffs"]["yOffset"] = 3
		E.db["unitframe"]["units"]["raid1"]["disableFocusGlow"] = true
		E.db["unitframe"]["units"]["raid1"]["growthDirection"] = "LEFT_DOWN"
		E.db["unitframe"]["units"]["raid1"]["healPrediction"]["enable"] = true
		E.db["unitframe"]["units"]["raid1"]["health"]["text_format"] = ""
		E.db["unitframe"]["units"]["raid1"]["height"] = 80
		E.db["unitframe"]["units"]["raid1"]["name"]["text_format"] = ""
		E.db["unitframe"]["units"]["raid1"]["numGroups"] = 8
		E.db["unitframe"]["units"]["raid1"]["orientation"] = "LEFT"
		E.db["unitframe"]["units"]["raid1"]["power"]["enable"] = false
		E.db["unitframe"]["units"]["raid1"]["raidRoleIcons"]["enable"] = false
		E.db["unitframe"]["units"]["raid1"]["raidicon"]["enable"] = false
		E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["enable"] = false
		E.db["unitframe"]["units"]["raid1"]["rdebuffs"]["font"] = "Expressway"
		E.db["unitframe"]["units"]["raid1"]["readycheckIcon"]["position"] = "CENTER"
		E.db["unitframe"]["units"]["raid1"]["readycheckIcon"]["size"] = 40
		E.db["unitframe"]["units"]["raid1"]["resurrectIcon"]["size"] = 40
		E.db["unitframe"]["units"]["raid1"]["roleIcon"]["enable"] = false
		E.db["unitframe"]["units"]["raid1"]["summonIcon"]["size"] = 40
		E.db["unitframe"]["units"]["raid1"]["threatStyle"] = "HEALTHBORDER"
		E.db["unitframe"]["units"]["raid1"]["visibility"] = "[@raid6,noexists] hide;show"
		E.db["unitframe"]["units"]["raid1"]["width"] = 160
		
		-- Movers for Healing layout. 
		E.db["movers"]["ElvUF_PartyMover"] = "BOTTOM,ElvUIParent,BOTTOM,-409,412"
		E.db["movers"]["ElvUF_Raid1Mover"] = "BOTTOMLEFT,UIParent,BOTTOMLEFT,142,188"
		E.db["movers"]["ElvUF_TargetMover"] = "TOP,ElvUIParent,TOP,-248,-591"
		E.db["movers"]["ElvUF_FocusMover"] = "BOTTOM,ElvUIParent,BOTTOM,-248,673"


		E.db["unitframe"]["units"]["party"]["visibility"] = "[@raid6,exists] hide;show"
		E.db["unitframe"]["units"]["party"]["showPlayer"] = true

	end
end

