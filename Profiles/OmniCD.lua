local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

local pairs = pairs

-- OmniCD profile
function ProjectHopes:Setup_OmniCD(layout)
	if not E:IsAddOnEnabled('OmniCD') and E.Retail then Private:Print('OmniCD ' .. L["is not installed or enabled."]) return end

	-- Profile names
	local name = 'ProjectHopes'

	-- Disable LibDualSpec to set the profile
	if E.Retail then
		OmniCDDB['namespaces']['LibDualSpec-1.0'] = {}
		OmniCDDB['namespaces']['LibDualSpec-1.0']['char'] = {}
		OmniCDDB['namespaces']['LibDualSpec-1.0']['char'][E.mynameRealm] = {}
		OmniCDDB['namespaces']['LibDualSpec-1.0']['char'][E.mynameRealm]['enabled'] = false
	end
	-- Global db
	OmniCDDB['cooldowns'] = {}
	OmniCDDB['global']['disableElvMsg'] = true
	OmniCDDB['version'] = 4

	-- Profile creation
	for _, profile in pairs({ name }) do
		OmniCDDB['profiles'][profile] = {}
		OmniCDDB['profiles'][profile]['General'] = {}
		OmniCDDB['profiles'][profile]['Party'] = {}
	end

	-- Main profile
	OmniCDDB['profiles'][name]['Party'] = {
        ["party"] = {
            ["extraBars"] = {
				["raidBar2"] = {
					["enabled"] = true,
					["manualPos"] = {
					["raidBar2"] = {
					["y"] = 476.5332930823133,
					["x"] = 419.4667861998132,
					},
					},
					["paddingX"] = 6,
					["scale"] = 1.04,
					["layout"] = "horizontal",
					["progressBar"] = false,
					["showName"] = false,
					["name"] = "Crowd Control",
					["locked"] = true,
					["columns"] = 4,
					["growUpward"] = true,
					["paddingY"] = 6,
					},
                ["raidBar3"] = {
                    ["progressBar"] = false,
                    ["paddingY"] = 1,
                    ["enabled"] = true,
                    ["paddingX"] = 6,
                    ["layout"] = "horizontal",
                    ["name"] = "Raid Movement",
                    ["locked"] = true,
                    ["manualPos"] = {
                        ["raidBar3"] = {
                            ["y"] = 608.7999666472242,
                            ["x"] = 462.6667884528688,
                        },
                    },
                    ["scale"] = 0.99,
                    ["showName"] = false,
                },
                ["raidBar1"] = {
                    ["truncateIconName"] = 0,
                    ["statusBarWidth"] = 60,
                    ["showRaidTargetMark"] = true,
                    ["barColors"] = {
                        ["rechargeColor"] = {
                            ["a"] = 0,
                            ["g"] = 0.7019608020782471,
                        },
                        ["activeColor"] = {
                            ["a"] = 0,
                        },
                        ["inactiveColor"] = {
                            ["a"] = 0,
                        },
                    },
                    ["anchor"] = "BOTTOMLEFT",
                    ["paddingY"] = 6,
                    ["reverseFill"] = false,
                    ["invertNameBar"] = false,
                    ["scale"] = 0.99,
                    ["growUpward"] = true,
                    ["textColors"] = {
                        ["useClassColor"] = {
                            ["inactive"] = true,
                            ["active"] = true,
                        },
                        ["activeColor"] = {
                            ["a"] = 1,
                            ["b"] = 0,
                            ["g"] = 0,
                            ["r"] = 0,
                        },
                    },
                    ["locked"] = true,
                    ["manualPos"] = {
                        ["raidBar1"] = {
                            ["y"] = 237.5998821834655,
                            ["x"] = 512.8001244008592,
                        },
                    },
                    ["attach"] = "BOTTOMLEFT",
                    ["nameBar"] = true,
                    ["hideBorder"] = true,
                    ["bgColors"] = {
                        ["useClassColor"] = {
                            ["recharge"] = false,
                        },
                        ["rechargeColor"] = {
                            ["a"] = 0,
                            ["g"] = 0.7019608020782471,
                        },
                        ["activeColor"] = {
                            ["a"] = 0,
                        },
                    },
                    ["nameOfsY"] = -5,
                    ["hideSpark"] = true,
                    ["truncateStatusBarName"] = 4,
                    ["paddingX"] = 0,
                },
				["raidBar4"] = {
					["enabled"] = false,
					["manualPos"] = {
					["raidBar4"] = {
					["y"] = 215.7333120326184,
					["x"] = 419.4667861998132,
					},
					},
					["paddingX"] = 6,
					["scale"] = 1.04,
					["layout"] = "horizontal",
					["progressBar"] = false,
					["showName"] = false,
					["name"] = "Group Defensive",
					["locked"] = true,
					["columns"] = 4,
					["paddingY"] = 6,
					}
            },
            ["highlight"] = {
            ["glowBuffTypes"] = {
                ["trinket"] = true,
                ["offensive"] = true,
                ["raidMovement"] = true,
            },
            ["glowBuffs"] = false,
            ["glow"] = false,
            },
            ["spellFrame"] = {
                [388615] = 4,
                [51052] = 4,
                [196718] = 4,
                [102793] = 2,
                [370665] = 4,
                [108199] = 2,
                [47788] = 4,
                [408] = 2,
                [15286] = 4,
                [97462] = 4,
                [221562] = 2,
                [213871] = 4,
                [107570] = 2,
                [19577] = 2,
                [198838] = 4,
                [265202] = 4,
                [368412] = 4,
                [53480] = 4,
                [49576] = 2,
                [108968] = 4,
                [202162] = 4,
                [207399] = 4,
                [88625] = 2,
                [33206] = 4,
                [211881] = 2,
                [374227] = 4,
                [357170] = 4,
                [5211] = 2,
                [102342] = 4,
                [363534] = 4,
                [1022] = 4,
                [108280] = 4,
                [6940] = 4,
                [47476] = 2,
                [414660] = 4,
                [360827] = 4,
                [199448] = 4,
                [392060] = 2,
                [116849] = 4,
                [305483] = 2,
                [271466] = 4,
                [62618] = 4,
                [98008] = 4,
                [108281] = 4,
                [197268] = 4,
                [236273] = 4,
                [124974] = 4,
                [740] = 4,
                [148039] = 4,
                [31821] = 4,
                [64843] = 4,
                [115310] = 4,
                [204018] = 4,
            },
            ["icons"] = {
                ["chargeScale"] = 1,
                ["scale"] = 1.05,
                ["showTooltip"] = true,
                ["swipeAlpha"] = 0.7000000000000001,
                ["markEnhanced"] = false,
                ["desaturateActive"] = true,
            },
            ["general"] = {
                ["showRange"] = true,
            },
            ["position"] = {
                ["layout"] = "doubleRow",
                ["paddingX"] = 6,
                ["breakPoint"] = "defensive",
                ["preset"] = "TOPLEFT",
                ["offsetX"] = 7,
                ["anchor"] = "TOPRIGHT",
                ["attach"] = "TOPLEFT",
                ["paddingY"] = 6,
            },
            ["priority"] = {
                ["racial"] = 1,
                ["immunity"] = 5,
                ["defensive"] = 20,
                ["covenant"] = 14,
                ["offensive"] = 100,
            },

        },
		['arena'] = {
			['extraBars'] = {
				['raidBar0'] = {
					['hideSpark'] = true,
					['statusBarWidth'] = 280,
					['barColors'] = {
						['classColor'] = false,
						['inactiveColor'] = {
							['a'] = 0.90,
							['b'] = 0.05,
							['g'] = 0.05,
							['r'] = 0.05,
						},
						['rechargeColor'] = {
							['a'] = 0.90,
							['r'] = 0.05,
							['g'] = 0.05,
							['b'] = 0.05,
						},
						['activeColor'] = {
							['r'] = 0.05,
							['g'] = 0.05,
							['b'] = 0.05,
						},
						['useClassColor'] = {
							['inactive'] = false,
							['recharge'] = false,
							['active'] = false,
						},
					},
					['locked'] = true,
					['paddingY'] = 1,
					['manualPos'] = {
						['raidBar0'] = {
							['y'] = 417.7780917134624,
							['x'] = 256.3552796449858,
						},
					},
					['columns'] = 10,
					['bgColors'] = {
						['classColor'] = true,
						['rechargeColor'] = {
							['r'] = 0.54,
							['g'] = 0.56,
							['b'] = 0.61,
						},
						['activeColor'] = {
							['a'] = 1,
							['r'] = 0.54,
							['g'] = 0.56,
							['b'] = 0.61,
						},
						['useClassColor'] = {
							['recharge'] = false,
						},
					},
					['textColors'] = {
						['classColor'] = true,
						['inactiveColor'] = {
							['a'] = 1,
						},
						['rechargeColor'] = {
							['a'] = 1,
						},
						['activeColor'] = {
							['a'] = 1,
						},
						['useClassColor'] = {
							['inactive'] = true,
							['recharge'] = true,
							['active'] = true,
						},
					},
					['showInterruptedSpell'] = false,
					['scale'] = 0.6000000000000001,
				},
			},
			["highlight"] = {
				["glowBuffs"] = false,
				["glow"] = false,
				["glowBuffTypes"] = {
				["offensive"] = true,
				["trinket"] = true,
				["raidMovement"] = true,
				},
				["glowType"] = "actionBar",
				},
			['icons'] = {
				["swipeAlpha"] = 0.7000000000000001,
				["displayBorder"] = false,
				["chargeScale"] = 1,
				["showTooltip"] = true,
				["desaturateActive"] = true,
				["showForbearanceCounter"] = false,
				["markEnhanced"] = false,
				["scale"] = 0.99,
			},
			['position'] = {
				["anchor"] = "RIGHT",
				["paddingY"] = 1,
				["attachMore"] = "LEFT",
				["columns"] = 4,
				["paddingX"] = 1,
				["attach"] = "LEFT",
				["preset"] = "manual",
				["offsetX"] = 1,
				["anchorMore"] = "RIGHT",
			},
			
			['general'] = {
				['showPlayer'] = true,
			},
		},
	}

	-- Additional data
	for _, profile in pairs({ name }) do
		-- General db
		OmniCDDB['profiles'][profile]['General']['fonts'] = {
			['statusBar'] = {
				['font'] = 'Expressway',
				['ofsX'] = 0,
				['flag'] = 'OUTLINE',
				['size'] = 18,
			},
			['optionSmall'] = {
				['flag'] = 'OUTLINE',
				['font'] = 'Expressway',
			},
			['anchor'] = {
				['font'] = 'Expressway',
				['ofsX'] = 0,
				['flag'] = 'OUTLINE',
			},
			['icon'] = {
				['font'] = 'Expressway',
				['size'] = 12,
			},
			['option'] = {
				['flag'] = 'OUTLINE',
				['font'] = 'Expressway',
			},
		}
		OmniCDDB['profiles'][profile]['General']['textures'] = {
			['statusBar'] = {
				['BG'] = 'HopesUI',
				['bar'] = 'HopesUI',
			},
		}

		-- Party db
		OmniCDDB['profiles'][profile]['Party']['visibility'] = {
			["none"] = true,
		}
		OmniCDDB['profiles'][profile]['Party']['groupSize'] = {
			["party"] = 5,
			["scenario"] = 5,
			["raid"] = 5,
			["pvp"] = 5,
			["none"] = 5,
		}
		OmniCDDB['profiles'][profile]['Party']['noneZoneSetting'] = 'party'
		OmniCDDB['profiles'][profile]['Party']['scenarioZoneSetting'] = 'party'



		for _, frame in pairs({ 'party', 'arena' }) do
			OmniCDDB['profiles'][profile]['Party'][frame]['highlight'] = OmniCDDB['profiles'][profile]['Party'][frame]['highlight'] or {}
			OmniCDDB['profiles'][profile]['Party'][frame]['highlight'] = {
				["glowBuffs"] = false,
				["glow"] = false,
				["glowBuffTypes"] = {
				["offensive"] = true,
				["trinket"] = true,
				["raidMovement"] = true,
				}
			}
		end




		-- Spell IDs
		for _, frame in pairs({ 'party', 'arena' }) do
			OmniCDDB['profiles'][profile]['Party'][frame]['spells'] = {}
			OmniCDDB['profiles'][profile]['Party'][frame]['spells'] = {
				["31661"] = true,
				["114018"] = true,
				["51490"] = true,
				["12975"] = true,
				["384352"] = true,
				["200851"] = true,
				["108199"] = true,
				["124974"] = true,
				["19577"] = true,
				["368970"] = true,
				["235219"] = false,
				["205180"] = true,
				["48020"] = false,
				["1122"] = true,
				["102793"] = true,
				["64901"] = true,
				["336126"] = false,
				["322507"] = true,
				["59752"] = false,
				["357170"] = false,
				["221562"] = true,
				["7744"] = false,
				["345231"] = false,
				["55233"] = true,
				["207167"] = true,
				["375576"] = true,
				["209258"] = false,
				["383013"] = true,
				["102560"] = true,
				["107574"] = true,
				["108281"] = true,
				["404381"] = false,
				["179057"] = true,
				["47568"] = true,
				["5211"] = true,
				["22842"] = true,
				["498"] = true,
				["132578"] = true,
				["13750"] = true,
				["325197"] = true,
				["246287"] = true,
				["194679"] = true,
				["102558"] = true,
				["47482"] = false,
				["198111"] = false,
				["200183"] = true,
				["116841"] = true,
				["213644"] = true,
				["219809"] = true,
				["31230"] = false,
				["194223"] = true,
				["204336"] = false,
				["377509"] = false,
				["375087"] = true,
				["211881"] = true,
				["403631"] = true,
				["198013"] = true,
				["132469"] = true,
				["80313"] = true,
				["203720"] = true,
				["388007"] = true,
				["408234"] = false,
				["1044"] = true,
				["360952"] = true,
				["106898"] = true,
				["202137"] = true,
				["55342"] = true,
				["204018"] = true,
				["414660"] = true,
				["46968"] = true,
				["49206"] = true,
				["408"] = true,
				["86659"] = true,
				["365350"] = true,
				["157981"] = true,
				["119381"] = true,
				["19574"] = true,
				["198103"] = true,
				["192058"] = true,
				["374251"] = true,
				["107570"] = true,
				["50334"] = true,
				["47476"] = true,
				["357214"] = true,
				["197721"] = true,
				["198067"] = true,
				["389539"] = true,
				["30884"] = false,
				["265187"] = true,
				["42650"] = true,
				["152279"] = true,
				["102342"] = false,
				["99"] = true,
				["6940"] = true,
				["392966"] = true,
				["305483"] = true,
				["205636"] = true,
				["197862"] = true,
				["20594"] = true,
				["192249"] = true,
				["114050"] = true,
				["114556"] = false,
				["16191"] = true,
				["4987"] = true,
				["264735"] = true,
				["49576"] = true,
				["86949"] = false,
				["102543"] = true,
				["205604"] = false,
				["204021"] = true,
				["378464"] = false,
				["114051"] = true,
				["336135"] = false,
				["184662"] = true,
				["31850"] = true,
				["228260"] = true,
				["12472"] = true,
				["123904"] = true,
				["305497"] = true,
				["88625"] = true,
				["375982"] = true,
				["108416"] = true,
				["370665"] = true,
				["378441"] = false,
				["391109"] = true,
				["49028"] = true,
				["288613"] = true,
				["29166"] = true,
				["32375"] = true,
				["370511"] = true,
				["116844"] = true,
				["113724"] = true,
				["212084"] = true,
				["415569"] = true,
				["392060"] = true,
				["191634"] = true,
				["10060"] = true,
				["391528"] = true,
				["359844"] = true,
				["110959"] = true,
				["30283"] = true,
				["740"] = false,
				["121471"] = true,
				["109248"] = true,
			}
		end

		-- Spell IDs
		for _, frame in pairs({ 'party', 'arena' }) do
			OmniCDDB['profiles'][profile]['Party'][frame]['raidCDS'] = {}
			OmniCDDB['profiles'][profile]['Party'][frame]['raidCDS'] = {
				["47476"] = true,
				["853"] = true,
				["207167"] = true,
				["31661"] = true,
				["383013"] = true,
				["114018"] = true,
				["99"] = true,
				["211881"] = true,
				["357210"] = true,
				["108281"] = true,
				["51490"] = true,
				["179057"] = true,
				["113724"] = true,
				["64843"] = false,
				["5211"] = true,
				["132469"] = true,
				["49576"] = true,
				["108968"] = true,
				["115750"] = true,
				["108199"] = true,
				["124974"] = true,
				["2094"] = true,
				["19577"] = true,
				["187650"] = true,
				["1044"] = true,
				["368970"] = true,
				["88625"] = true,
				["106898"] = true,
				["8122"] = true,
				["370665"] = true,
				["202137"] = true,
				["6940"] = true,
				["372048"] = true,
				["204018"] = true,
				["64044"] = true,
				["357214"] = true,
				["414660"] = true,
				["205636"] = true,
				["119381"] = true,
				["46968"] = true,
				["5246"] = true,
				["408"] = true,
				["265202"] = false,
				["29166"] = true,
				["157981"] = true,
				["116841"] = true,
				["221562"] = true,
				["116844"] = true,
				["102793"] = true,
				["115310"] = false,
				["107570"] = true,
				["30283"] = true,
				["192058"] = true,
				["392060"] = true,
				["109248"] = true,
			}
		end

		for _, frame in pairs({ 'party', 'arena' }) do
			OmniCDDB['profiles'][profile]['Party'][frame]['priority'] = {}
			OmniCDDB['profiles'][profile]['Party'][frame]['priority'] = {
				["racial"] = 1,
				["immunity"] = 5,
				["externalDefensive"] = 0,
				["defensive"] = 0,
				["covenant"] = 14,
				["offensive"] = 20,
				["raidDefensive"] = 0,
			}
		end
	end

	-- Set profile
	if layout == 'main' then
		OmniCDDB['profileKeys'][E.mynameRealm] = name
	end

	Private:Print(L["OmniCD profile has been set."])
end
