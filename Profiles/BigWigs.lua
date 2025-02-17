local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

local IsAddOnLoaded = IsAddOnLoaded

local function NameplatesRemover()
	BigWigs3DB["namespaces"] = BigWigs3DB["namespaces"] or {}
	BigWigs3DB["namespaces"]["ProjectHopes"] = BigWigs3DB["profiles"]["ProjectHopes"] or {}

	-- Disable Trash/Boss nameplate icons. 
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Amarth, The Harvester"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Amarth, The Harvester"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Amarth, The Harvester"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Amarth, The Harvester"]["profiles"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Amarth, The Harvester"]["profiles"]["ProjectHopes"] = {
		[328667] = 0,
	}


	BigWigs3DB["namespaces"]["BigWigs_Bosses_Grim Batol Trash"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Grim Batol Trash"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Grim Batol Trash"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Grim Batol Trash"]["profiles"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Grim Batol Trash"]["profiles"]["ProjectHopes"] = {
		[456711] = 0,
		[451395] = 0,
		[451613] = 0,
		[456713] = 0,
		[462216] = 0,
		[451971] = 0,
		[451871] = 0,
		[451391] = 0,
		[451965] = 0,
		[456696] = 0,
		[451241] = 0,
		[451378] = 0,
		[451612] = 0,
		[76711] = 0,
		[451939] = 0,
		[451224] = 0,
	}

	BigWigs3DB["namespaces"]["BigWigs_Bosses_Ara-Kara, City of Echoes Trash"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Ara-Kara, City of Echoes Trash"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Ara-Kara, City of Echoes Trash"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Ara-Kara, City of Echoes Trash"]["profiles"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Ara-Kara, City of Echoes Trash"]["profiles"]["ProjectHopes"] = {
		[448248] = 0,
		[434802] = 0,
		[434252] = 0,
		[465012] = 0,
		[434793] = 0,
		[438877] = 0,
		[434824] = 0,
		[433841] = 0,
		[453161] = 0,
		[433845] = 0,
		[438826] = 0,
	}

	BigWigs3DB["namespaces"]["BigWigs_Bosses_Drahga Shadowburner"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Drahga Shadowburner"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Drahga Shadowburner"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Drahga Shadowburner"]["profiles"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Drahga Shadowburner"]["profiles"]["ProjectHopes"] = {
		[82850] = 0,
	}

	BigWigs3DB["namespaces"]["BigWigs_Bosses_Cinderbrew Meadery Trash"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Cinderbrew Meadery Trash"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Cinderbrew Meadery Trash"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Cinderbrew Meadery Trash"]["profiles"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Cinderbrew Meadery Trash"]["profiles"]["ProjectHopes"] = {
		[437956] = 0,
		[442995] = 0,
		[440687] = 0,
		[434706] = 0,
		[437721] = 0,
		[441627] = 0,
		[441434] = 0,
		[442589] = 0,
		[440876] = 0,
		[448619] = 0,
		[441119] = 0,
		[439467] = 0,
	}

	BigWigs3DB["namespaces"]["BigWigs_Bosses_Priory of the Sacred Flame Trash"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Priory of the Sacred Flame Trash"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Priory of the Sacred Flame Trash"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Priory of the Sacred Flame Trash"]["profiles"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Priory of the Sacred Flame Trash"]["profiles"]["ProjectHopes"] = {
		[427346] = 0,
		[424429] = 0,
		[427609] = 0,
		[427342] = 0,
		[427356] = 0,
		[427484] = 0,
		[444743] = 0,
	}

	BigWigs3DB["namespaces"]["BigWigs_Bosses_Surgeon Stitchflesh"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Surgeon Stitchflesh"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Surgeon Stitchflesh"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Surgeon Stitchflesh"]["profiles"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Surgeon Stitchflesh"]["profiles"]["ProjectHopes"] = {
		[322681] = 0,
	}

	BigWigs3DB["namespaces"]["BigWigs_Bosses_Mists of Tirna Scithe Trash"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Mists of Tirna Scithe Trash"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Mists of Tirna Scithe Trash"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Mists of Tirna Scithe Trash"]["profiles"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Mists of Tirna Scithe Trash"]["profiles"]["ProjectHopes"] = {
		[326046] = 0,
		[340289] = 0,
		[324923] = 0,
		[324776] = 0,
		[340160] = 0,
		[340300] = 0,
		[460092] = 0,
		[322569] = 0,
		[463217] = 0,
		[322938] = 0,
		[325224] = 0,
		[463248] = 0,
		[463256] = 0,
		[340208] = 0,
		[340304] = 0,
		[321968] = 0,
		[322486] = 0,
		[326090] = 0,
		[340544] = 0,
		[325021] = 0,
		[326021] = 0,
		[322557] = 0,
		[340305] = 0,
		[340189] = 0,
		[324914] = 0,
		[325418] = 0,
		[340279] = 0,
	}

	BigWigs3DB["namespaces"]["BigWigs_Bosses_Awakening the Machine"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Awakening the Machine"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Awakening the Machine"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Awakening the Machine"]["profiles"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Awakening the Machine"]["profiles"]["ProjectHopes"] = {
		[462983] = 0,
	}

	BigWigs3DB["namespaces"]["BigWigs_Bosses_The Necrotic Wake Trash"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_The Necrotic Wake Trash"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_The Necrotic Wake Trash"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_The Necrotic Wake Trash"]["profiles"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_The Necrotic Wake Trash"]["profiles"]["ProjectHopes"] = {
		[338353] = 0,
		[321807] = 0,
		[327240] = 0,
		[333479] = 0,
		[327396] = 0,
		[343470] = 0,
		[338456] = 0,
		[323347] = 0,
		[328667] = 0,
		[322756] = 0,
		[338357] = 0,
		[321780] = 0,
		[345623] = 0,
		[323471] = 0,
		[338606] = 0,
		[335143] = 0,
		[320464] = 0,
		[334748] = 0,
		[324293] = 0,
		[324394] = 0,
		[327130] = 0,
		[333477] = 0,
		[324387] = 0,
		[324372] = 0,
		[335141] = 0,
	}

	BigWigs3DB["namespaces"]["BigWigs_Bosses_The Stonevault Trash"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_The Stonevault Trash"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_The Stonevault Trash"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_The Stonevault Trash"]["profiles"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_The Stonevault Trash"]["profiles"]["ProjectHopes"] = {
		[426308] = 0,
		[428703] = 0,
		[447141] = 0,
		[459210] = 0,
		[429427] = 0,
		[448640] = 0,
		[445207] = 0,
		[449130] = 0,
		[429545] = 0,
		[449455] = 0,
		[426771] = 0,
		[426345] = 0,
		[428879] = 0,
		[429109] = 0,
		[449154] = 0,
		[425974] = 0,
		[425027] = 0,
	}

	BigWigs3DB["namespaces"]["BigWigs_Bosses_Blightbone"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Blightbone"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Blightbone"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Blightbone"]["profiles"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Blightbone"]["profiles"]["ProjectHopes"] = {
		[320717] = 0,
	}

	BigWigs3DB["namespaces"]["BigWigs_Bosses_The Dawnbreaker Trash"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_The Dawnbreaker Trash"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_The Dawnbreaker Trash"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_The Dawnbreaker Trash"]["profiles"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_The Dawnbreaker Trash"]["profiles"]["ProjectHopes"] = {
		[431494] = 0,
		[450854] = 0,
		[432448] = 0,
		[431309] = 0,
		[432565] = 0,
		[431364] = 0,
		[451119] = 0,
		[431349] = 0,
		[451112] = 0,
		[432520] = 0,
		[450756] = 0,
		[431304] = 0,
		[451098] = 0,
		[431491] = 0,
		[451107] = 0,
		[451097] = 0,
		[451117] = 0,
		[451102] = 0,
	}

	BigWigs3DB["namespaces"]["BigWigs_Bosses_Tred'ova"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Tred'ova"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Tred'ova"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Tred'ova"]["profiles"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Tred'ova"]["profiles"]["ProjectHopes"] = {
		[322563] = 0,
	}

	BigWigs3DB["namespaces"]["BigWigs_Bosses_Chopper Redhook"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Chopper Redhook"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Chopper Redhook"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Chopper Redhook"]["profiles"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Chopper Redhook"]["profiles"]["ProjectHopes"] = {
		[257288] = 0,
	}

	BigWigs3DB["namespaces"]["BigWigs_Bosses_Darkflame Cleft Trash"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Darkflame Cleft Trash"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Darkflame Cleft Trash"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Darkflame Cleft Trash"]["profiles"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Darkflame Cleft Trash"]["profiles"]["ProjectHopes"] = {
		[424322] = 0,
		[440652] = 0,
		[425536] = 0,
		[422414] = 0,
		[423501] = 0,
		[426883] = 0,
	}

	BigWigs3DB["namespaces"]["BigWigs_Bosses_The Rookery Trash"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_The Rookery Trash"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_The Rookery Trash"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_The Rookery Trash"]["profiles"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_The Rookery Trash"]["profiles"]["ProjectHopes"] = {
		[430754] = 0,
		[427323] = 0,
		[427616] = 0,
		[427260] = 0,
		[423979] = 0,
		[430013] = 0,
		[430812] = 0,
		[432781] = 0,
		[430179] = 0,
		[432638] = 0,
		[432959] = 0,
		[427404] = 0,
	}

	BigWigs3DB["namespaces"]["BigWigs_Bosses_City of Threads Trash"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_City of Threads Trash"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_City of Threads Trash"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_City of Threads Trash"]["profiles"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_City of Threads Trash"]["profiles"]["ProjectHopes"] = {
		[452162] = 0,
		[436205] = 0,
		[451543] = 0,
		[434137] = 0,
		[443507] = 0,
		[443430] = 0,
		[443500] = 0,
		[446717] = 0,
		[443397] = 0,
		[451423] = 0,
		[451222] = 0,
		[445813] = 0,
		[446086] = 0,
		[450784] = 0,
		[447271] = 0,
		[443437] = 0,
	}

	BigWigs3DB["namespaces"]["BigWigs_Bosses_Siege of Boralus Trash"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Siege of Boralus Trash"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Siege of Boralus Trash"]["profiles"] = BigWigs3DB["namespaces"]["BigWigs_Bosses_Siege of Boralus Trash"]["profiles"] or {}
	BigWigs3DB["namespaces"]["BigWigs_Bosses_Siege of Boralus Trash"]["profiles"]["ProjectHopes"] = {
		[272571] = 0,
		[272711] = 0,
		[275835] = 0,
		[256640] = 0,
		[257288] = 0,
		[272662] = 0,
		[454437] = 0,
		[256616] = 0,
		[272421] = 0,
		[257169] = 0,
		[268260] = 0,
		[272546] = 0,
		[256627] = 0,
		[256957] = 0,
		[257170] = 0,
		[257732] = 0,
		[454440] = 0,
		[275826] = 0,
	}
end

-- Runs after successful profile import
local function CallbackFunction(accepted)
	if not accepted then return end

	-- Handle Minimap icon
	local LDBI = LibStub('LibDBIcon-1.0')
	BigWigsIconDB.hide = true
	LDBI:Hide('BigWigs')
	NameplatesRemover()
	Private:Print(L["BigWigs Profile has been set."])
end



-- BigWigs profiles
function ProjectHopes:Setup_BigWigs(layout)
	if not E:IsAddOnEnabled('BigWigs') then Private:Print('BigWigs ' .. L["is not installed or enabled."]) return end

	-- Profile names
	local name = 'ProjectHopes'

	-- Profile string
	local profile_main = 'BW1:LvvqVTrru4UABoGGQANqsPsn0asbuLOvedbercfLnXPoHKyl7102CAhVE8UdD2DgMz24yo6tC2s8hiIFb(aNr(cIdvALL4pqK4pqoZbM3SEx72mhwnV38M37799EZBT(dEPiSuIcWnysIIWILF2eCepmx84kU1BKAB9O1VoMjIq0Id6SF1ZCR2mDjR)7otN5K9zuMqErhEIGtX70W(lF23Az(60HMKPOc85RTBgiW44mn2MVo(dq5kS7matPS(7yBoBRombkoaVJrABJQkcC3mzJhRCZmm0cRuK4a5VwsWsuusmwuVT7jhDw1H9yXQwKFb)jtHuSnNJf(ij2BypuxSIeHByV1ZQCnC4PSyMFOGfHdn8XH6REgkcFv1l5cDG6JgyChOlDnh)qKkCCxIKtrdapT0y4w1ZaqAPXbcw)28(irxz4WejM4RP6WR8PiP0hynVIWai8jnrusqC6sxfnhi8YX6OPJGAEs(0Pk8Lk4AgU)yB9IVk49NRPVgcMFlfsO2lMe5XxZOxJKdicSpufnh6Cs1dDhd(PEVEsS6Lw3agUNKRnQjsBNhFfqZ(mgTlRF8zjrDWcP2HWLUTdtThdMN5TxDYDMas5miV8zmfBJwOy5gnXbjuK4A4CnXQDcGApE5fJwR(eo2ZajhMOlwKLPwww2xbkRHjbHQhFtEqki9j5udWOBwizkzFX1G4cvzdgoalrQeHMGdn868weE5BLQFA7glqAVYkd1qcCOa)Zj4y)bnURUXCB(YVD(5oGJBYjxIPxppPamANzPPYbhFIonKLVAUrEzgazXcqN)rlwVHs9bqoOHO9mmTiSt3mRyopk44av47XlTiPxTBa2BAEWM3Bvukb8E)P5okZaiD)UTN)9RQyZFyUj7LOy7JKQg6geIpvNyZ6hZXHBiX)16ewANrRzLXjU1oA)Fy2lyZbT4iFDVV1i42VG0vf(4HW2ZzSiltJ3mlwSl8LzMVWJK3QJ(O4l0n0AQC13fUT8ruS9OoOS2o5povV1b5)A9l6K4UhxB3)SeSkF7n2GPUaIdr6Gy6yfZuzWWWCVQ9Y)02SwCZVzwgVuvpBaj1uoeW)nXSQT7F9aZQ2UVzDy9X2cil014koVyl(Y(AaQGSRy2(Ad55JVtTHP6F(yTZlgM8O07NwAeopwE3Cbrs6qXoiXjKiI6VhzMk5QNV1S5rpVM7i8L8SNFp10yKhO0nVPWlqZxc3ZbMk6nuFbtjR7hWlvystSegB45a(Wtaf5ebwuJXXY2hbSul1akEIU9(N0nXg9czwr(EtY(VugmEY4mjtmo4EDcYdU2LEPpiDTzzGwmDtNEeknCAbmG8Av(kVtsdu)7NUryA5hoj)hiGU15RuCZttOkcNsWc75U7u2fAkSOiK1(S2OE5VN(ML7uu5woOOAUSOOcprN5Z)V8yn3LlDE6sPl97FO1W2hPFpHJvP398Xo1DDRFQPWmu)xBZgRVNx(aScrOsh9CSdf6HFv4LlqvETVhu6tlJNwCcWgM8wZAnVGr8XtQghqjYWD2yVOb)p'

	-- Set profile
	BigWigsAPI.RegisterProfile(Private.Name, profile_main, name, CallbackFunction)
end
