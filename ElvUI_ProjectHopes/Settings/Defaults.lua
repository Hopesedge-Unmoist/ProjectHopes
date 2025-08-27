local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

local MiniMapButtonSelect = {NOANCHOR = 'No Anchor Bar', HORIZONTAL = 'Horizontal', VERTICAL = 'Vertical'}
local MiniMapButtonDirection = {NORMAL = 'Normal', REVERSED = 'Reversed'}
local norm = format("|cff1eff00%s|r", L["[ABBR] Normal"])
local hero = format("|cff0070dd%s|r", L["[ABBR] Heroic"])
local myth = format("|cffa335ee%s|r", L["[ABBR] Mythic"])
local lfr = format("|cffff8000%s|r", L["[ABBR] Looking for raid"])

-- Defaults: E.global.ProjectHopes
G.ProjectHopes = {
	dev = false,
	install_version = nil,
}

-- Defaults: E.private.ProjectHopes
V.ProjectHopes = {
	qualityOfLife = {
		frameMover = {
		
		},
		borederDarkmode = false,
		automation = {
			resurrect = false,
			combatresurrect = false,
			easyDelete = false,
			autoAcceptQuests = false,
			detailsResize = false,
		}
	},
}

-- Defaults: E.db.ProjectHopes
P.ProjectHopes = {
	-- UnitFrame Generals
	portraits = {
				--player portrait
		playerpor = false
		playerframelevel = 20,
		playerSize = 50, 
		playerMirror = false,
		playerClass = false,
		playerClassTexture = "hd",
		playerClassBackdropColor = { r = 1, g = 1, b = 1, a = 1 },
		playerBorderColor = false,
		playerUnitframeAnchor = false,
		playerPosition = "left",
		playerOffsetX = 12,
		playerOffsetY = 0,
		playerStrata = "HIGH",

				--target portrait
		targetpor = false
		targetframelevel = 20,
		targetSize = 50, 
		targetMirror = false,
		targetClass = false,
		targetClassTexture = "hd",
		targetClassBackdropColor = { r = 1, g = 1, b = 1, a = 1 },
		targetBorderColor = false,
		targetUnitframeAnchor = false,
		targetPosition = "right",
		targetOffsetX = -12,
		targetOffsetY = 0,
		targetStrata = "HIGH",

		--focus portrait
		focuspor = false
		focusframelevel = 20,
		focusSize = 50, 
		focusMirror = false,
		focusClass = false,
		focusClassTexture = "hd",
		focusClassBackdropColor = { r = 1, g = 1, b = 1, a = 1 },
		focusBorderColor = false,
		focusUnitframeAnchor = false,
		focusPosition = "right",
		focusOffsetX = -12,
		focusOffsetY = 0,
		focusStrata = "HIGH",

		--targettarget portrait
		targettargetpor = false
		targettargetframelevel = 20,
		targettargetSize = 50, 
		targettargetMirror = false,
		targettargetClass = false,
		targettargetClassTexture = "hd",
		targettargetClassBackdropColor = { r = 1, g = 1, b = 1, a = 1 },
		targettargetBorderColor = false,
		targettargetUnitframeAnchor = false,
		targettargetPosition = "right",
		targettargetOffsetX = -12,
		targettargetOffsetY = 0,
		targettargetStrata = "HIGH",

		--boss portrait
		bosspor = false
		bossframelevel = 20,
		bossSize = 50, 
		bossMirror = false,
		bossBorderColor = false,
		bossUnitframeAnchor = false,
		bossPosition = "right",
		bossOffsetX = -12,
		bossOffsetY = 0,
		bossStrata = "HIGH",

		--pet portrait
		petpor = false
		petframelevel = 20,
		petSize = 50, 
		petMirror = false,
		petBorderColor = false,
		petUnitframeAnchor = false,
		petPosition = "right",
		petOffsetX = -12,
		petOffsetY = 0,
		petStrata = "HIGH",
	},

	unitframe = {
		unitFramesGlowline = false,
		unitFramesGlowlinecolor = { r = 1, g = 1, b = 1, a = 1 },
		unitFramesGlowlineWidth = 5,
		infopanelontop = false,

	},
	-- qualityOfLife
	qualityOfLife = {
		mplusimprovements = false,
		driveButton = false,
		BigWigsIcons = false,
	},
	-- Rectangle Minimap
	minimap = {
		Rectangle = false,
	},
	-- Minimap Buttons
	minimapbutton = {
		enable = false,
		skinStyle = "HORIZONTAL",
		buttonSize = 40,
		backdrop = false,
		layoutDirection = "NORMAL",
		border = true,
		buttonsPerRow = 4,
		mouseover = false,
	},
	-- Minimap Instance Difficulty
	["minimapid"] = {
		["enable"] = false,
		["hideBlizzard"] = true,
		["align"] = "LEFT",
		["font"] = {
			["size"] = 20,
			},
	},
	-- Overshield Absorb
	overshield = {
		Absorb = false,
	},
	-- Custom Target Border
	targetGlow = {
		foreground = false,
	},
	-- Custom Health Backdrop
	cbackdrop = {
		Backdrop = false,
		customtexture = 'Health Background',
	},
	-- border
	border = {
		-- Player
		Player = false,
		Playersep = false,
		playerpor = false,
		playerporframelevel = 25,
		-- Raid
		raid = false,
		raiddps = false,
		raid2 = false,
		raid2dps = false,
		raid3 = false,
		raid3dps = false,
		-- Pet
		Pet = false,
		Petsep = false,
		-- Pet target
		PetTarget = false,
		-- Target
		Target = false,
		Targetsep = false,
		targetpor = false,
		-- Focus
		Focus = false,
		Focussep = false,
		focuspor = false,
		-- Focus Target
		FocusTarget = false,
		-- Target Target
		TargetofTarget = false,
		TargetofTargetsep = false,
		targettargetpor = false,
		-- Target of Target of Target
		TargetofTargetofTarget = false,
		-- Party
		Party = false,
		Partysep = false,
		PartySpaced = false,
		-- Offtank and Main Tank
		maintankofftank = false,
		-- Assist Units
		AssistUnits = false,
		-- Boss
		Boss = false,
		Bosssep = false,
		-- Arena
		Arena = false,
		Arenasep = false,
		-- Buffs/Debuffs
		Aura = false, 
		AuraUF = false, 
		-- Minimap
		-- Bag
		Bag = false,
		Bagslot = false,
		-- OmniCD
		OmniCD = false,
	},
	skins = {
		-- Addons
		warpdeplete = false,
		bigwigsqueue = false,
		auctionator = false,
		bugsack = false,
		raiderio = false,
		rareScanner = false, 
		hekili = false, 
		weakAurasOptions = false, 
		simulationcraft = false, 
		Baganator = false,
		details = false,
		mazeHelper = false,
		talentTreeTweaks = false,
		choreTracker = false,
		spy = false,
		threatClassic2 = false,
		dbm = false,
		ranker = false,
		
		-- Blizzard 
		achievementFrame = false,
		adventureMap = false,
		addonList = false,
		alertframes = false,
		alliedRaces = false,
		animaDiversionFrame = false,
		artifactFrame = false,
		auctionHouse = false,
		archaeologyFrame = false,
		azerite = false,
		azeriteEssence = false,
		azeriteRespec = false,
		barbershop = false,
		bag = false,
		battleNet = false,
		chatConfig = false,
		binding = false,
		blackMarket = false,
		calendar = false,
		challenges = false,
		channels = false,
		character = false,
		chromieTime = false,
		classTalent = false,
		clickBinding = false,
		collections = false,
		contribution = false,
		transmogrify = false,
		communities = false,
		covenantPreview = false,
		covenantRenown = false,
		covenantSanctum = false,
		debugTools = false,
		dressingRoom = false,
		editModeManager = false,
		encounterJournal = false,
		eventTrace = false,
		expansionLandingPage = false,
		flightMap = false,
		friends = false,
		garrison = false,
		genericTrait = false,
		gossip = false,
		guild = false,
		guildBank = false,
		guildControl = false,
		guildRegistrar = false,
		guide = false,
		help = false,
		inputMethodEditor = false,
		inspect = false,
		itemInteraction = false,
		itemSocketing = false,
		itemUpgrade = false,
		islandsPartyPose = false,
		islandQueue = false,
		lookingForGroup = false,
		lfguild = false,
		loot = false,
		lossOfControl = false,
		macro = false,
		mail = false,
		majorFactions = false,
		merchant = false,
		microButtons = false,
		mirrorTimers = false,
		misc = false,
		objectiveTracker = false,
		obliterum = false,
		orderHall = false,
		perksProgram = false,
		petBattle = false,
		petition = false,
		playerChoice = false,
		professions = false,
		professionsCustomerOrders = false,
		pvp = false,
		bgscore = false, 
		quest = false,
		questChoice = false,
		raidInfo = false,
		runeforge = false,
		reforge = false,
		scenario = false,
		scrappingMachine = false,
		blizzardOptions = false,
		soulbinds = false,
		spellBook = false,
		stable = false,
		blizzardstaticPopup = false,
		subscriptionInterstitial = false,
		tabard = false,
		talkingHead = false,
		taxi = false,
		ticketStatus = false,
		timeManager = false,
		tooltips = false,
		tooltipscolor = false,
		torghastLevelPicker = false,
		trade = false,
		trainer = false,
		tutorial = false,
		voidstorage = false,
		warboard = false,
		weeklyRewards = false,
		worldMap = false,

		-- ElvUI
		actionBarsBackdrop = false,
		actionBarsButton = false,
		afk = false,
		altPowerBar = false,
		castbar = false,
		chatDataPanels = false,
		chatPanels = false,
		chatVoicePanel = false,
		chatCopyFrame = false,
		classBars = false,
		dataPanels = false,
		dataBars = false,
		lootRoll = false,
		options = false,
		panels = false,
		raidUtility = false,
		staticPopup = false,
		statusReport = false,
		totemTracker = false,
		Minimap = false,
	},
}
