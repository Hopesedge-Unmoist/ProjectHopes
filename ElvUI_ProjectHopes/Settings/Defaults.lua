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
		easyDelete = false,
		autoAcceptQuests = false,
		frameMover = {
		
		},
		borederDarkmode = false,
		automation = {
			resurrect = false,
			combatresurrect = false,
		}
	},

}

-- Defaults: E.db.ProjectHopes
P.ProjectHopes = {
	-- UnitFrame Generals
	unitframe = {
		unitFramesGlowline = false,
		infopanelontop = false,
		framelevelPortraits = 20,
		classPortraits = false, 
		playerpositionPortraits = -20,
		targetpositionPortraits = 20,
		focuspositionPortraits = 20,
		targettargetpositionPortraits = 20.
	},
	-- qualityOfLife
	qualityOfLife = {
		mplusimprovements = false,
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
		detailsresize = false,
		mazeHelper = false,
		talentTreeTweaks = false,
		choreTracker = false,

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
		bgscore = false, 
		quest = false,
		questChoice = false,
		raidInfo = false,
		runeforge = false,
		scenario = false,
		scrappingMachine = false,
		settingsPanel = false,
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
		chatDataPanels = false,
		chatPanels = false,
		chatVoicePanel = false,
		chatCopyFrame = false,
		lootRoll = false,
		options = false,
		panels = false,
		raidUtility = false,
		staticPopup = false,
		statusReport = false,
		totemTracker = false,
		Minimap = false,
		dataPanels = false,
	},
}
