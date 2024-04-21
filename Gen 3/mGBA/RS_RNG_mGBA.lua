local JUMP_DATA = {
 {0x41C64E6D, 0x6073}, {0xC2A29A69, 0xE97E7B6A}, {0xEE067F11, 0x31B0DDE4}, {0xCFDDDF21, 0x67DBB608},
 {0x5F748241, 0xCBA72510}, {0x8B2E1481, 0x1D29AE20}, {0x76006901, 0xBA84EC40}, {0x1711D201, 0x79F01880},
 {0xBE67A401, 0x8793100}, {0xDDDF4801, 0x6B566200}, {0x3FFE9001, 0x803CC400}, {0x90FD2001, 0xA6B98800},
 {0x65FA4001, 0xE6731000}, {0xDBF48001, 0x30E62000}, {0xF7E90001, 0xF1CC4000}, {0xEFD20001, 0x23988000},
 {0xDFA40001, 0x47310000}, {0xBF480001, 0x8E620000}, {0x7E900001, 0x1CC40000}, {0xFD200001, 0x39880000},
 {0xFA400001, 0x73100000}, {0xF4800001, 0xE6200000}, {0xE9000001, 0xCC400000}, {0xD2000001, 0x98800000},
 {0xA4000001, 0x31000000}, {0x48000001, 0x62000000}, {0x90000001, 0xC4000000}, {0x20000001, 0x88000000},
 {0x40000001, 0x10000000}, {0x80000001, 0x20000000}, {0x1, 0x40000000}, {0x1, 0x80000000}}

local natureNamesList = {
 "Hardy", "Lonely", "Brave", "Adamant", "Naughty",
 "Bold", "Docile", "Relaxed", "Impish", "Lax",
 "Timid", "Hasty", "Serious", "Jolly", "Naive",
 "Modest", "Mild", "Quiet", "Bashful", "Rash",
 "Calm", "Gentle", "Sassy", "Careful", "Quirky"}

local HPTypeNamesList = {
 "Fighting", "Flying", "Poison", "Ground",
 "Rock", "Bug", "Ghost", "Steel",
 "Fire", "Water", "Grass", "Electric",
 "Psychic", "Ice", "Dragon", "Dark"}

local speciesNamesList = {
 -- Gen 1
 "Bulbasaur", "Ivysaur", "Venusaur", "Charmander", "Charmeleon", "Charizard", "Squirtle", "Wartortle", "Blastoise",
 "Caterpie", "Metapod", "Butterfree", "Weedle", "Kakuna", "Beedrill", "Pidgey", "Pidgeotto", "Pidgeot", "Rattata",
 "Raticate", "Spearow", "Fearow", "Ekans", "Arbok", "Pikachu", "Raichu", "Sandshrew", "Sandslash", "Nidoran♀",
 "Nidorina", "Nidoqueen", "Nidoran♂", "Nidorino", "Nidoking", "Clefairy", "Clefable", "Vulpix", "Ninetales",
 "Jigglypuff", "Wigglytuff", "Zubat", "Golbat", "Oddish", "Gloom", "Vileplume", "Paras", "Parasect", "Venonat",
 "Venomoth", "Diglett", "Dugtrio", "Meowth", "Persian", "Psyduck", "Golduck", "Mankey", "Primeape", "Growlithe",
 "Arcanine", "Poliwag", "Poliwhirl", "Poliwrath", "Abra", "Kadabra", "Alakazam", "Machop", "Machoke", "Machamp",
 "Bellsprout", "Weepinbell", "Victreebel", "Tentacool", "Tentacruel", "Geodude", "Graveler", "Golem", "Ponyta",
 "Rapidash", "Slowpoke", "Slowbro", "Magnemite", "Magneton", "Farfetch'd", "Doduo", "Dodrio", "Seel", "Dewgong",
 "Grimer", "Muk", "Shellder", "Cloyster", "Gastly", "Haunter", "Gengar", "Onix", "Drowzee", "Hypno", "Krabby",
 "Kingler", "Voltorb", "Electrode", "Exeggcute", "Exeggutor", "Cubone", "Marowak", "Hitmonlee", "Hitmonchan",
 "Lickitung", "Koffing", "Weezing", "Rhyhorn", "Rhydon", "Chansey", "Tangela", "Kangaskhan", "Horsea", "Seadra",
 "Goldeen", "Seaking", "Staryu", "Starmie", "Mr. Mime", "Scyther", "Jynx", "Electabuzz", "Magmar", "Pinsir",
 "Tauros", "Magikarp", "Gyarados", "Lapras", "Ditto", "Eevee", "Vaporeon", "Jolteon", "Flareon", "Porygon",
 "Omanyte", "Omastar", "Kabuto", "Kabutops", "Aerodactyl", "Snorlax", "Articuno", "Zapdos", "Moltres", "Dratini",
 "Dragonair", "Dragonite", "Mewtwo", "Mew",
 -- Gen 2
 "Chikorita", "Bayleef", "Meganium", "Cyndaquil", "Quilava", "Typhlosion", "Totodile", "Croconaw", "Feraligatr",
 "Sentret", "Furret", "Hoothoot", "Noctowl", "Ledyba", "Ledian", "Spinarak", "Ariados", "Crobat", "Chinchou",
 "Lanturn", "Pichu", "Cleffa", "Igglybuff", "Togepi", "Togetic", "Natu", "Xatu", "Mareep", "Flaaffy", "Ampharos",
 "Bellossom", "Marill", "Azumarill", "Sudowoodo", "Politoed", "Hoppip", "Skiploom", "Jumpluff", "Aipom", "Sunkern",
 "Sunflora", "Yanma", "Wooper", "Quagsire", "Espeon", "Umbreon", "Murkrow", "Slowking", "Misdreavus", "Unown",
 "Wobbuffet", "Girafarig", "Pineco", "Forretress", "Dunsparce", "Gligar", "Steelix", "Snubbull", "Granbull",
 "Qwilfish", "Scizor", "Shuckle", "Heracross", "Sneasel", "Teddiursa", "Ursaring", "Slugma", "Magcargo", "Swinub",
 "Piloswine", "Corsola", "Remoraid", "Octillery", "Delibird", "Mantine", "Skarmory", "Houndour", "Houndoom",
 "Kingdra", "Phanpy", "Donphan", "Porygon2", "Stantler", "Smeargle", "Tyrogue", "Hitmontop", "Smoochum", "Elekid",
 "Magby", "Miltank", "Blissey", "Raikou", "Entei", "Suicune", "Larvitar", "Pupitar", "Tyranitar", "Lugia", "Ho-Oh",
 "Celebi",
 -- Gen 3
 "Treecko", "Grovyle", "Sceptile", "Torchic", "Combusken", "Blaziken", "Mudkip", "Marshtomp", "Swampert",
 "Poochyena", "Mightyena", "Zigzagoon", "Linoone", "Wurmple", "Silcoon", "Beautifly", "Cascoon", "Dustox", "Lotad",
 "Lombre", "Ludicolo", "Seedot", "Nuzleaf", "Shiftry", "Taillow", "Swellow", "Wingull", "Pelipper", "Ralts",
 "Kirlia", "Gardevoir", "Surskit", "Masquerain", "Shroomish", "Breloom", "Slakoth", "Vigoroth", "Slaking",
 "Nincada", "Ninjask", "Shedinja", "Whismur", "Loudred", "Exploud", "Makuhita", "Hariyama", "Azurill", "Nosepass",
 "Skitty", "Delcatty", "Sableye", "Mawile", "Aron", "Lairon", "Aggron", "Meditite", "Medicham", "Electrike",
 "Manectric", "Plusle", "Minun", "Volbeat", "Illumise", "Roselia", "Gulpin", "Swalot", "Carvanha", "Sharpedo",
 "Wailmer", "Wailord", "Numel", "Camerupt", "Torkoal", "Spoink", "Grumpig", "Spinda", "Trapinch", "Vibrava",
 "Flygon", "Cacnea", "Cacturne", "Swablu", "Altaria", "Zangoose", "Seviper", "Lunatone", "Solrock", "Barboach",
 "Whiscash", "Corphish", "Crawdaunt", "Baltoy", "Claydol", "Lileep", "Cradily", "Anorith", "Armaldo", "Feebas",
 "Milotic", "Castform", "Kecleon", "Shuppet", "Banette", "Duskull", "Dusclops", "Tropius", "Chimecho", "Absol",
 "Wynaut", "Snorunt", "Glalie", "Spheal", "Sealeo", "Walrein", "Clamperl", "Huntail", "Gorebyss", "Relicanth",
 "Luvdisc", "Bagon", "Shelgon", "Salamence", "Beldum", "Metang", "Metagross", "Regirock", "Regice", "Registeel",
 "Latias", "Latios",  "Kyogre", "Groudon", "Rayquaza", "Jirachi", "Deoxys"}

local abilityNamesList = {
 "Stench", "Drizzle", "Speed Boost", "Battle Armor", "Sturdy", "Damp", "Limber", "Sand Veil", "Static",
 "Volt Absorb", "Water Absorb", "Oblivious", "Cloud Nine", "Compound Eyes", "Insomnia", "Color Change", "Immunity",
 "Flash Fire", "Shield Dust", "Own Tempo", "Suction Cups", "Intimidate", "Shadow Tag", "Rough Skin", "Wonder Guard",
 "Levitate", "Effect Spore", "Synchronize", "Clear Body", "Natural Cure", "Lightning Rod", "Serene Grace",
 "Swift Swim", "Chlorophyll", "Illuminate", "Trace", "Huge Power", "Poison Point", "Inner Focus", "Magma Armor",
 "Water Veil", "Magnet Pull", "Soundproof", "Rain Dish", "Sand Stream", "Pressure", "Thick Fat", "Early Bird",
 "Flame Body", "Run Away", "Keen Eye", "Hyper Cutter", "Pickup", "Truant", "Hustle", "Cute Charm", "Plus", "Minus",
 "Forecast", "Sticky Hold", "Shed Skin", "Guts", "Marvel Scale", "Liquid Ooze", "Overgrow", "Blaze", "Torrent",
 "Swarm", "Rock Head", "Drought", "Arena Trap", "Vital Spirit", "White Smoke", "Pure Power", "Shell Armor",
 "Cacophony", "Air Lock"}

local moveNamesList = {
 "--" , "Pound", "Karate Chop", "Double Slap", "Comet Punch", "Mega Punch", "Pay Day", "Fire Punch", "Ice Punch",
 "Thunder Punch", "Scratch", "Vice Grip", "Guillotine", "Razor Wind", "Swords Dance", "Cut", "Gust", "Wing Attack",
 "Whirlwind", "Fly", "Bind", "Slam", "Vine Whip", "Stomp", "Double Kick", "Mega Kick", "Jump Kick", "Rolling Kick",
 "Sand Attack", "Headbutt", "Horn Attack", "Fury Attack", "Horn Drill", "Tackle", "Body Slam", "Wrap", "Take Down",
 "Thrash", "Double-Edge", "Tail Whip", "Poison Sting", "Twineedle", "Pin Missile", "Leer", "Bite", "Growl", "Roar",
 "Sing", "Supersonic", "Sonic Boom", "Disable", "Acid", "Ember", "Flamethrower", "Mist", "Water Gun", "Hydro Pump",
 "Surf", "Ice Beam", "Blizzard", "Psybeam", "Bubble Beam", "Aurora Beam", "Hyper Beam", "Peck", "Drill Peck",
 "Submission", "Low Kick", "Counter", "Seismic Toss", "Strength", "Absorb", "Mega Drain", "Leech Seed", "Growth",
 "Razor Leaf", "Solar Beam", "Poison Powder", "Stun Spore", "Sleep Powder", "Petal Dance", "String Shot",
 "Dragon Rage", "Fire Spin", "Thunder Shock", "Thunderbolt", "Thunder Wave", "Thunder", "Rock Throw", "Earthquake",
 "Fissure", "Dig", "Toxic", "Confusion", "Psychic", "Hypnosis", "Meditate", "Agility", "Quick Attack", "Rage",
 "Teleport", "Night Shade", "Mimic", "Screech", "Double Team", "Recover", "Harden", "Minimize", "Smokescreen",
 "Confuse Ray", "Withdraw", "Defense Curl", "Barrier", "Light Screen", "Haze", "Reflect", "Focus Energy", "Bide",
 "Metronome", "Mirror Move", "Self-Destruct", "Egg Bomb", "Lick", "Smog", "Sludge", "Bone Club", "Fire Blast",
 "Waterfall", "Clamp", "Swift", "Skull Bash", "Spike Cannon", "Constrict", "Amnesia", "Kinesis", "Soft-Boiled",
 "High Jump Kick", "Glare", "Dream Eater", "Poison Gas", "Barrage", "Leech Life", "Lovely Kiss", "Sky Attack",
 "Transform", "Bubble", "Dizzy Punch", "Spore", "Flash", "Psywave", "Splash", "Acid Armor", "Crabhammer",
 "Explosion", "Fury Swipes", "Bonemerang", "Rest", "Rock Slide", "Hyper Fang", "Sharpen", "Conversion", "Tri Attack",
 "Super Fang", "Slash", "Substitute", "Struggle", "Sketch", "Triple Kick", "Thief", "Spider Web", "Mind Reader",
 "Nightmare", "Flame Wheel", "Snore", "Curse", "Flail", "Conversion 2", "Aeroblast", "Cotton Spore", "Reversal",
 "Spite", "Powder Snow", "Protect", "Mach Punch", "Scary Face", "Feint Attack", "Sweet Kiss", "Belly Drum",
 "Sludge Bomb", "Mud-Slap", "Octazooka", "Spikes", "Zap Cannon", "Foresight", "Destiny Bond", "Perish Song",
 "Icy Wind", "Detect", "Bone Rush", "Lock-On", "Outrage", "Sandstorm", "Giga Drain", "Endure", "Charm", "Rollout",
 "False Swipe", "Swagger", "Milk Drink", "Spark", "Fury Cutter", "Steel Wing", "Mean Look", "Attract", "Sleep Talk",
 "Heal Bell", "Return", "Present", "Frustration", "Safeguard", "Pain Split", "Sacred Fire", "Magnitude",
 "Dynamic Punch", "Megahorn", "Dragon Breath", "Baton Pass", "Encore", "Pursuit", "Rapid Spin", "Sweet Scent",
 "Iron Tail", "Metal Claw", "Vital Throw", "Morning Sun", "Synthesis", "Moonlight", "Hidden Power", "Cross Chop",
 "Twister", "Rain Dance", "Sunny Day", "Crunch", "Mirror Coat", "Psych Up", "Extreme Speed", "Ancient Power",
 "Shadow Ball", "Future Sight", "Rock Smash", "Whirlpool", "Beat Up", "Fake Out", "Uproar", "Stockpile", "Spit Up",
 "Swallow", "Heat Wave", "Hail", "Torment", "Flatter", "Will-O-Wisp", "Memento", "Facade", "Focus Punch",
 "Smelling Salts", "Follow Me", "Nature Power", "Charge", "Taunt", "Helping Hand", "Trick", "Role Play", "Wish",
 "Assist", "Ingrain", "Superpower", "Magic Coat", "Recycle", "Revenge", "Brick Break", "Yawn", "Knock Off", "Endeavor",
 "Eruption", "Skill Swap", "Imprison", "Refresh", "Grudge", "Snatch", "Secret Power", "Dive", "Arm Thrust", "Camouflage",
 "Tail Glow", "Luster Purge", "Mist Ball", "Feather Dance", "Teeter Dance", "Blaze Kick", "Mud Sport", "Ice Ball",
 "Needle Arm", "Slack Off", "Hyper Voice", "Poison Fang", "Crush Claw", "Blast Burn", "Hydro Cannon", "Meteor Mash",
 "Astonish", "Weather Ball", "Aromatherapy", "Fake Tears", "Air Cutter", "Overheat", "Odor Sleuth", "Rock Tomb",
 "Silver Wind", "Metal Sound", "Grass Whistle", "Tickle", "Cosmic Power", "Water Spout", "Signal Beam", "Shadow Punch",
 "Extrasensory", "Sky Uppercut", "Sand Tomb", "Sheer Cold", "Muddy Water", "Bullet Seed", "Aerial Ace", "Icicle Spear",
 "Iron Defense", "Block", "Howl", "Dragon Claw", "Frenzy Plant", "Bulk Up", "Bounce", "Mud Shot", "Poison Tail", "Covet",
 "Volt Tackle", "Magical Leaf", "Water Sport", "Calm Mind", "Leaf Blade", "Dragon Dance", "Rock Blast", "Shock Wave",
 "Water Pulse", "Doom Desire", "Psycho Boost"}

local nationalDexList = {
 1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26,
 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74,
 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99,
 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119,
 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139,
 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159,
 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179,
 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199,
 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219,
 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239,
 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 387, 388, 389, 390, 391, 392, 393, 394,
 395, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 252, 253, 254,
 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274,
 275, 290, 291, 292, 276, 277, 285, 286, 327, 278, 279, 283, 284, 320, 321, 300, 301, 352, 343, 344,
 299, 324, 302, 339, 340, 370, 341, 342, 349, 350, 318, 319, 328, 329, 330, 296, 297, 309, 310, 322,
 323, 363, 364, 365, 331, 332, 361, 362, 337, 338, 298, 325, 326, 311, 312, 303, 307, 308, 333, 334,
 360, 355, 356, 315, 287, 288, 289, 316, 317, 357, 293, 294, 295, 366, 367, 368, 359, 353, 354, 336,
 335, 369, 304, 305, 306, 351, 313, 314, 345, 346, 347, 348, 280, 281, 282, 371, 372, 373, 374, 375,
 376, 377, 378, 379, 382, 383, 384, 380, 381, 385, 386, 358}

local pokemonAbilities = {
 [001] = {65, 34}, [002] = {65, 34}, [003] = {65, 34}, [004] = {66}, [005] = {66}, [006] = {66}, [007] = {67, 44},
 [008] = {67, 44}, [009] = {67, 44}, [010] = {19, 50}, [011] = {61}, [012] = {14}, [013] = {19, 50}, [014] = {61},
 [015] = {68}, [016] = {51}, [017] = {51}, [018] = {51}, [019] = {50, 62, 55}, [020] = {50, 62, 55}, [021] = {51},
 [022] = {51}, [023] = {22, 61}, [024] = {22, 61}, [025] = {9, 31}, [026] = {9, 31}, [027] = {8}, [028] = {8},
 [029] = {38, 55}, [030] = {38, 55}, [031] = {38}, [032] = {38, 55}, [033] = {38, 55}, [034] = {38}, [035] = {56},
 [036] = {56}, [037] = {18, 70}, [038] = {18, 70}, [039] = {56}, [040] = {56}, [041] = {39}, [042] = {39},
 [043] = {34, 50}, [044] = {34, 1}, [045] = {34, 27}, [046] = {27, 6}, [047] = {27, 6}, [048] = {14, 50},
 [049] = {19}, [050] = {8, 71}, [051] = {8, 71}, [052] = {53}, [053] = {7}, [054] = {6, 13, 33},
 [055] = {6, 13, 33}, [056] = {72}, [057] = {72}, [058] = {22, 18}, [059] = {22, 18}, [060] = {11, 6, 33},
 [061] = {11, 6, 33}, [062] = {11, 6, 33}, [063] = {28, 39}, [064] = {28, 39}, [065] = {28, 39}, [066] = {62},
 [067] = {62}, [068] = {62}, [069] = {34}, [070] = {34}, [071] = {34}, [072] = {29, 64, 44}, [073] = {29, 64, 44},
 [074] = {69, 5, 8}, [075] = {69, 5, 8}, [076] = {69, 5, 8}, [077] = {50, 18, 49}, [078] = {50, 18, 49},
 [079] = {12, 20}, [080] = {12, 20}, [081] = {42, 5}, [082] = {42, 5}, [083] = {51, 39}, [084] = {50, 48},
 [085] = {50, 48}, [086] = {47}, [087] = {47}, [088] = {1, 60}, [089] = {1, 60}, [090] = {75}, [091] = {75},
 [092] = {26}, [093] = {26}, [094] = {26}, [095] = {69, 5}, [096] = {15, 39}, [097] = {15, 39}, [098] = {52, 75},
 [099] = {52, 75}, [100] = {43, 9}, [101] = {43, 9}, [102] = {34}, [103] = {34}, [104] = {69, 31, 4},
 [105] = {69, 31, 4}, [106] = {7}, [107] = {51, 39}, [108] = {20, 12, 13}, [109] = {26, 1}, [110] = {26, 1},
 [111] = {31, 69}, [112] = {31, 69}, [113] = {30, 32}, [114] = {34}, [115] = {48, 39}, [116] = {33, 6},
 [117] = {38, 6}, [230] = {33, 6}, [118] = {33, 41, 31}, [119] = {33, 41, 31}, [120] = {35, 30}, [121] = {35, 30},
 [122] = {43}, [123] = {68}, [212] = {68}, [238] = {12}, [124] = {12}, [239] = {9, 72}, [125] = {9, 72},
 [240] = {49, 72}, [126] = {49, 72}, [127] = {52}, [128] = {22}, [129] = {33}, [130] = {22}, [131] = {11, 75},
 [132] = {7}, [133] = {50}, [134] = {11}, [135] = {10}, [136] = {18, 62}, [196] = {28}, [197] = {28, 39},
 [137] = {36}, [233] = {36}, [138] = {33, 75}, [139] = {33, 75}, [140] = {33, 4}, [141] = {33, 4}, [142] = {69, 46},
 [143] = {17, 47}, [144] = {46}, [145] = {46, 9}, [146] = {46, 49}, [147] = {61, 63}, [148] = {61, 63}, [149] = {39},
 [150] = {46}, [151] = {28}, [152] = {65}, [153] = {65}, [154] = {65}, [155] = {66, 18}, [156] = {66, 18},
 [157] = {66, 18}, [158] = {67}, [159] = {67}, [160] = {67}, [161] = {50, 51}, [162] = {50, 51}, [163] = {15, 51},
 [164] = {15, 51}, [165] = {68, 48}, [166] = {68, 48}, [167] = {68, 15}, [168] = {68, 15}, [169] = {39},
 [170] = {10, 35, 11}, [171] = {10, 35, 11}, [172] = {9, 31}, [173] = {56}, [174] = {56}, [175] = {55, 32},
 [176] = {55, 32}, [177] = {28, 48}, [178] = {28, 48}, [179] = {9, 57}, [180] = {9, 57}, [181] = {9, 57}, [182] = {34},
 [183] = {47, 37}, [184] = {47, 37}, [185] = {5, 69}, [186] = {11, 6, 2}, [187] = {34}, [188] = {34}, [189] = {34},
 [190] = {50, 53}, [191] = {34, 48}, [192] = {34, 48}, [193] = {3, 14}, [194] = {6, 11}, [195] = {6, 11}, [198] = {15},
 [199] = {12, 20}, [200] = {26}, [201] = {26}, [202] = {23}, [203] = {39, 48}, [204] = {5}, [205] = {5},
 [206] = {32, 50}, [207] = {52, 8, 17}, [208] = {69, 5}, [209] = {22, 50}, [210] = {22}, [211] = {38, 33, 22},
 [213] = {5}, [214] = {68, 62}, [215] = {39, 51}, [216] = {53}, [217] = {62}, [218] = {40, 49}, [219] = {40, 49},
 [220] = {12, 47}, [221] = {12, 47}, [222] = {55, 30}, [223] = {55}, [224] = {21}, [225] = {72, 55, 15},
 [226] = {33, 11, 41}, [227] = {51, 5}, [228] = {48, 18}, [229] = {48, 18}, [231] = {53, 8}, [232] = {5, 8},
 [234] = {22}, [235] = {20}, [236] = {62, 72}, [237] = {22}, [241] = {47}, [242] = {30, 32}, [243] = {46, 39},
 [244] = {46, 39}, [245] = {46, 39}, [246] = {62, 8}, [247] = {61}, [248] = {45}, [249] = {46}, [250] = {46},
 [251] = {30}, [252] = {65}, [253] = {65}, [254] = {65}, [255] = {66, 3}, [256] = {66, 3}, [257] = {66, 3},
 [258] = {67, 6}, [259] = {67, 6}, [260] = {67, 6}, [261] = {50}, [262] = {22}, [263] = {53}, [264] = {53},
 [265] = {19, 50}, [266] = {61}, [267] = {68}, [268] = {61}, [269] = {19, 14}, [270] = {33, 44, 20}, [271] = {33, 44, 20},
 [272] = {33, 44, 20}, [273] = {34, 48}, [274] = {34, 48}, [275] = {34, 48}, [276] = {62}, [277] = {62}, [278] = {51, 44},
 [279] = {51, 2, 44}, [280] = {28, 36}, [281] = {28, 36}, [282] = {28, 36}, [283] = {33, 44}, [284] = {22}, [285] = {27},
 [286] = {27}, [287] = {54}, [288] = {72}, [289] = {54}, [290] = {14, 50}, [291] = {3}, [292] = {25}, [293] = {43},
 [294] = {43}, [295] = {43}, [296] = {47, 62}, [297] = {47, 62}, [298] = {47, 37}, [299] = {5, 42}, [300] = {56},
 [301] = {56}, [302] = {51}, [303] = {52, 22}, [304] = {5, 69}, [305] = {5, 69}, [306] = {5, 69}, [307] = {74},
 [308] = {74}, [309] = {9, 31, 58}, [310] = {9, 31, 58}, [311] = {57, 31}, [312] = {58, 10}, [313] = {35, 68},
 [314] = {12}, [315] = {30, 38}, [316] = {64, 60}, [317] = {64, 60}, [318] = {24, 3}, [319] = {24, 3},
 [320] = {41, 12, 46}, [321] = {41, 12, 46}, [322] = {12, 20}, [323] = {40}, [324] = {73, 70, 75}, [325] = {47, 20},
 [326] = {47, 20}, [327] = {20}, [328] = {52, 71}, [329] = {26}, [330] = {26}, [331] = {8, 11}, [332] = {8, 11},
 [333] = {30, 13}, [334] = {30, 13}, [335] = {17}, [336] = {61}, [337] = {26}, [338] = {26}, [339] = {12}, [340] = {12},
 [341] = {52, 75}, [342] = {52, 75}, [343] = {26}, [344] = {26}, [345] = {21}, [346] = {21}, [347] = {4, 33},
 [348] = {4, 33}, [349] = {33, 12}, [350] = {63, 56}, [351] = {59}, [352] = {16}, [353] = {15}, [354] = {15},
 [355] = {26}, [356] = {46}, [357] = {34}, [358] = {26}, [359] = {46}, [360] = {23}, [361] = {39}, [362] = {39},
 [363] = {47, 12}, [364] = {47, 12}, [365] = {47, 12}, [366] = {75}, [367] = {33, 41}, [368] = {33}, [369] = {33, 69, 5},
 [370] = {33}, [371] = {69}, [372] = {69}, [373] = {22}, [374] = {29}, [375] = {29}, [376] = {29}, [377] = {29, 5},
 [378] = {29}, [379] = {29}, [380] = {26}, [381] = {26}, [382] = {2}, [383] = {70}, [384] = {77}, [385] = {32}, [386] = {46}}

local itemNamesList = {
 "None", "Master Ball", "Ultra Ball", "Great Ball", "Poke Ball", "Safari Ball", "Net Ball", "Dive Ball", "Nest Ball",
 "Repeat Ball", "Timer Ball", "Luxury Ball", "Premier Ball", "Potion", "Antidote", "Burn Heal", "Ice Heal", "Awakening",
 "Parlyz Heal", "Full Restore", "Max Potion", "Hyper Potion", "Super Potion", "Full Heal", "Revive", "Max Revive",
 "Fresh Water", "Soda Pop", "Lemonade", "Moomoo Milk", "EnergyPowder", "Energy Root", "Heal Powder", "Revival Herb",
 "Ether", "Max Ether", "Elixir", "Max Elixir", "Lava Cookie", "Blue Flute", "Yellow Flute", "Red Flute", "Black Flute",
 "White Flute", "Berry Juice", "Sacred Ash", "Shoal Salt", "Shoal Shell", "Red Shard", "Blue Shard", "Yellow Shard",
 "Green Shard", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown",
 "unknown", "unknown", "HP Up", "Protein", "Iron", "Carbos", "Calcium", "Rare Candy", "PP Up", "Zinc", "PP Max",
 "unknown", "Guard Spec.", "Dire Hit", "X Attack", "X Defend", "X Speed", "X Accuracy", "X Special", "Poke Doll",
 "Fluffy Tail", "unknown", "Super Repel", "Max Repel", "Escape Rope", "Repel", "unknown", "unknown", "unknown",
 "unknown", "unknown", "unknown", "Sun Stone", "Moon Stone", "Fire Stone", "Thunderstone", "Water Stone", "Leaf Stone",
 "unknown", "unknown", "unknown", "unknown", "TinyMushroom", "Big Mushroom", "unknown", "Pearl", "Big Pearl", "Stardust",
 "Star Piece", "Nugget", "Heart Scale", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown",
 "unknown", "unknown", "Orange Mail", "Harbor Mail", "Glitter Mail", "Mech Mail", "Wood Mail", "Wave Mail", "Bead Mail",
 "Shadow Mail", "Tropic Mail", "Dream Mail", "Fab Mail", "Retro Mail", "Cheri Berry", "Chesto Berry", "Pecha Berry",
 "Rawst Berry", "Aspear Berry", "Leppa Berry", "Oran Berry", "Persim Berry", "Lum Berry", "Sitrus Berry", "Figy Berry",
 "Wiki Berry", "Mago Berry", "Aguav Berry", "Iapapa Berry", "Razz Berry", "Bluk Berry", "Nanab Berry", "Wepear Berry",
 "Pinap Berry", "Pomeg Berry", "Kelpsy Berry", "Qualot Berry", "Hondew Berry", "Grepa Berry", "Tamato Berry",
 "Cornn Berry", "Magost Berry", "Rabuta Berry", "Nomel Berry", "Spelon Berry", "Pamtre Berry", "Watmel Berry",
 "Durin Berry", "Belue Berry", "Liechi Berry", "Ganlon Berry", "Salac Berry", "Petaya Berry", "Apicot Berry",
 "Lansat Berry", "Starf Berry", "Enigma Berry", "unknown", "unknown", "unknown", "BrightPowder", "White Herb",
 "Macho Brace", "Exp. Share", "Quick Claw", "Soothe Bell", "Mental Herb", "Choice Band", "King's Rock", "SilverPowder",
 "Amulet Coin", "Cleanse Tag", "Soul Dew", "DeepSeaTooth", "DeepSeaScale", "Smoke Ball", "Everstone", "Focus Band",
 "Lucky Egg", "Scope Lens", "Metal Coat", "Leftovers", "Dragon Scale", "Light Ball", "Soft Sand", "Hard Stone",
 "Miracle Seed", "BlackGlasses", "Black Belt", "Magnet", "Mystic Water", "Sharp Beak", "Poison Barb", "NeverMeltIce",
 "Spell Tag", "TwistedSpoon", "Charcoal", "Dragon Fang", "Silk Scarf", "Up-Grade", "Shell Bell", "Sea Incense",
 "Lax Incense", "Lucky Punch", "Metal Powder", "Thick Club", "Stick", "unknown", "unknown", "unknown", "unknown",
 "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown",
 "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown",
 "unknown", "unknown", "Red Scarf", "Blue Scarf", "Pink Scarf", "Green Scarf", "Yellow Scarf", "Mach Bike", "Coin Case",
 "Itemfinder", "Old Rod", "Good Rod", "Super Rod", "S.S. Ticket", "Contest Pass", "unknown", "Wailmer Pail", "Devon Goods",
 "Soot Sack", "Basement Key", "Acro Bike", "Pokeblock Case", "Letter", "Eon Ticket", "Red Orb", "Blue Orb", "Scanner",
 "Go-Goggles", "Meteorite", "Rm. 1 Key", "Rm. 2 Key", "Rm. 4 Key", "Rm. 6 Key", "Storage Key", "Root Fossil", "Claw Fossil",
 "Devon Scope", "TM 01", "TM 02", "TM 03", "TM 04", "TM 05", "TM 06", "TM 07", "TM 08", "TM 09", "TM 10", "TM 11", "TM 12",
 "TM 13", "TM 14", "TM 15", "TM 16", "TM 17", "TM 18", "TM 19", "TM 20", "TM 21", "TM 22", "TM 23", "TM 24", "TM 25",
 "TM 26", "TM 27", "TM 28", "TM 29", "TM 30", "TM 31", "TM 32", "TM 33", "TM 34", "TM 35", "TM 36", "TM 37", "TM 38", "TM 39",
 "TM 40", "TM 41", "TM 42", "TM 43", "TM 44", "TM 45", "TM 46", "TM 47", "TM 48", "TM 49", "TM 50", "HM 01", "HM 02", "HM 03",
 "HM 04", "HM 05", "HM 06", "HM 07", "HM 08", "unknown", "unknown", "Oak's Parcel", "Poke Flute", "Secret Key", "Bike Voucher",
 "Gold Teeth", "Old Amber", "Card Key", "Lift Key", "Helix Fossil", "Dome Fossil", "Silph Scope", "Bicycle", "Town Map",
 "VS Seeker", "Fame Checker", "TM Case", "Berry Pouch", "Teachy TV", "Tri-Pass", "Rainbow Pass", "Tea", "MysticTicket",
 "AuroraTicket", "Powder Jar", "Ruby", "Sapphire", "Magma Emblem", "Old Sea Map"}

local catchRatesList = {
 -- Gen 1
 45, 45, 45, 45, 45, 45, 45, 45, 45, 255, 120, 45, 255, 120, 45, 255, 120, 45, 255, 127, 255, 90, 255,
 90, 190, 75, 255, 90, 235, 120, 45, 235, 120, 45, 150, 25, 190, 75, 170, 50, 255, 90, 255, 120, 45,
 190, 75, 190, 75, 255, 50, 255, 90, 190, 75, 190, 75, 190, 75, 255, 120, 45, 200, 100, 50, 180, 90,
 45, 255, 120, 45, 190, 60, 255, 120, 45, 190, 60, 190, 75, 190, 60, 45, 190, 45, 190, 75, 190, 75,
 190, 60, 190, 90, 45, 45, 190, 75, 225, 60, 190, 60, 90, 45, 190, 75, 45, 45, 45, 190, 60, 120, 60,
 30, 45, 45, 225, 75, 225, 60, 225, 60, 45, 45, 45, 45, 45, 45, 45, 255, 45, 45, 35, 45, 45, 45, 45,
 45, 45, 45, 45, 45, 45, 25, 3, 3, 3, 45, 45, 45, 3, 45,
 -- Gen 2
 45, 45, 45, 45, 45, 45, 45, 45, 45, 255, 90, 255, 90, 255, 90, 255, 90, 90, 190, 75, 190, 150, 170,
 190, 75, 190, 75, 235, 120, 45, 45, 190, 75, 65, 45, 255, 120, 45, 45, 235, 120, 75, 255, 90, 45, 45,
 30, 70, 45, 225, 45, 60, 190, 75, 190, 60, 25, 190, 75, 45, 25, 190, 45, 60, 120, 60, 190, 75, 225,
 75, 60, 190, 75, 45, 25, 25, 120, 45, 45, 120, 60, 45, 45, 45, 75, 45, 45, 45, 45, 45, 30, 3, 3, 3, 45,
 45, 45, 3, 3, 45,
 -- Gen 3
 45, 45, 45, 45, 45, 45, 45, 45, 45, 255, 127, 255, 90, 255, 120, 45, 120, 45, 255, 120, 45, 255, 120,
 45, 200, 45, 190, 45, 235, 120, 45, 200, 75, 255, 90, 255, 120, 45, 255, 120, 45, 190, 120, 45, 180,
 200, 150, 255, 255, 60, 45, 45, 180, 90, 45, 180, 90, 120, 45, 200, 200, 150, 150, 150, 225, 75, 225,
 60, 125, 60, 255, 150, 90, 255, 60, 255, 255, 120, 45, 190, 60, 255, 45, 90, 90, 45, 45, 190, 75, 205,
 155, 255, 90, 45, 45, 45, 45, 255, 60, 45, 200, 225, 45, 190, 90, 200, 45, 30, 125, 190, 75, 255, 120,
 45, 255, 60, 60, 25, 225, 45, 45, 45, 3, 3, 3, 3, 3, 3, 3, 3, 5, 5, 3, 3, 3}

local locationNamesList = {
 "Petalburg City", "Slateport City", "Mauville City", "Rustboro City", "Fortree City", "Lilycove City",
 "Mossdeep City", "Sootopolis City", "Ever Grande City", "Littleroot Town", "Oldale Town", "Dewford Town",
 "Lavaridge Town", "Fallarbor Town", "Verdanturf Town", "Pacifidlog Town", "Route 101", "Route 102",
 "Route 103", "Route 104", "Route 105", "Route 106", "Route 107", "Route 108", "Route 109", "Route 110",
 "Route 111", "Route 112", "Route 113", "Route 114", "Route 115", "Route 116", "Route 117", "Route 118",
 "Route 119", "Route 120", "Route 121", "Route 122", "Route 123", "Route 124", "Route 125", "Route 126",
 "Route 127", "Route 128", "Route 129", "Route 130", "Route 131", "Route 132", "Route 133", "Route 134",
 "Underwater 1", "Underwater 2", "Underwater 3", "Underwater 4"}

local statusConditionNamesList = {"None", "SLP", "PSN", "BRN", "FRZ", "PAR", "PSN"}

local speciesDexIndexAddr, wildTypeAddr, saveBlock2Addr, saveBlock1Addr, eggLowPIDAddr, mapTypeAddr, currBoxIndexAddr, boxSelectedSlotIndexAddr,
      selectedItemAddr, safariZoneStepsCounterAddr, roamerMapGroupAndNumAddr, timerAddr, battleTurnsCounterAddr, partySlotsCounterAddr,
      partyAddr, enemyAddr, currentSeedAddr

local GameInfo, CaptureInfo, RoamerInfo, BreedingInfo, PandoraInfo, PokemonInfo

function initializeBuffers()
 GameInfo = console:createBuffer("Game Info")
 GameInfo:setSize(100, 100)
 CaptureInfo = console:createBuffer("Capture")
 CaptureInfo:setSize(100, 100)
 BreedingInfo = console:createBuffer("Breeding")
 BreedingInfo:setSize(100, 100)
 RoamerInfo = console:createBuffer("Roamer")
 RoamerInfo:setSize(100, 100)
 PandoraInfo = console:createBuffer("Pandora")
 PandoraInfo:setSize(100, 100)
 PokemonInfo = console:createBuffer("Pokemon Info")
 PokemonInfo:setSize(100, 100)
end

local gameVersion, gameLanguage = "", ""
local wrongGameVersion

function setGameVersion()
 local gameVersionCode = emu:read8(0x80000AE)
 local gameLanguageCode = emu:read8(0x80000AF)

 if gameVersionCode == 0x45 then  -- Check game version
  gameVersion = "Emerald"
 elseif gameVersionCode == 0x47 then
  gameVersion = "LeafGreen"
 elseif gameVersionCode == 0x50 then
  gameVersion = "Sapphire"
 elseif gameVersionCode == 0x52 then
  gameVersion = "FireRed"
 elseif gameVersionCode == 0x56 then
  gameVersion = "Ruby"
 end

 if gameLanguageCode == 0x45 then  -- Check game language and set addresses
  gameLanguage = "USA"
  speciesDexIndexAddr = 0x2024464
  wildTypeAddr = 0x2024AF9
  saveBlock2Addr = 0x2024EA4
  saveBlock1Addr = 0x2025734
  eggLowPIDAddr = 0x20287E8
  mapTypeAddr = 0x202E83F
  currBoxIndexAddr = 0x20300A0
  boxSelectedSlotIndexAddr = 0x20384E5
  selectedItemAddr = 0x203855E
  safariZoneStepsCounterAddr = 0x203880A
  roamerMapGroupAndNumAddr = 0x2039302
  timerAddr = 0x3001790
  battleTurnsCounterAddr = 0x30042F3
  partySlotsCounterAddr = 0x3004350
  partyAddr = 0x3004360
  enemyAddr = 0x30045C0
  currentSeedAddr = 0x3004818
 elseif gameLanguageCode == 0x4A then
  gameLanguage = "JPN"
  speciesDexIndexAddr = 0x20241C4
  wildTypeAddr = 0x2024859
  saveBlock2Addr = 0x2024C04
  saveBlock1Addr = 0x2025494
  eggLowPIDAddr = 0x2028548
  mapTypeAddr = 0x202E59F
  currBoxIndexAddr = 0x202FDBC
  boxSelectedSlotIndexAddr = 0x2038201
  selectedItemAddr = 0x203825C
  safariZoneStepsCounterAddr = 0x2038506
  roamerMapGroupAndNumAddr = 0x2038FFA
  timerAddr = 0x3001700
  battleTurnsCounterAddr = 0x3004223
  partySlotsCounterAddr = 0x3004280
  partyAddr = 0x3004290
  enemyAddr = 0x30044F0
  currentSeedAddr = 0x3004748
 elseif gameLanguageCode == 0x44 or gameLanguageCode == 0x46 or gameLanguageCode == 0x49 or gameLanguageCode == 0x53 then
  gameLanguage = "EUR"
  speciesDexIndexAddr = 0x2024464
  wildTypeAddr = 0x2024AF9
  saveBlock2Addr = 0x2024EA4
  saveBlock1Addr = 0x2025734
  eggLowPIDAddr = 0x20287E8
  mapTypeAddr = 0x202E83F
  currBoxIndexAddr = 0x20300A0
  boxSelectedSlotIndexAddr = 0x20384E5
  selectedItemAddr = 0x203855E
  safariZoneStepsCounterAddr = 0x203880A
  roamerMapGroupAndNumAddr = 0x2039302
  timerAddr = 0x3001790
  battleTurnsCounterAddr = 0x3004303
  partySlotsCounterAddr = 0x3004360
  partyAddr = 0x3004370
  enemyAddr = 0x30045D0
  currentSeedAddr = 0x3004828
 end
end

function printGameInfo()
 setGameVersion()
 wrongGameVersion = true
 GameInfo:clear()

 if gameVersion == "" then  -- Print game info
  GameInfo:print("Version: Unknown game")
 elseif gameVersion ~= "Ruby" and gameVersion ~= "Sapphire" then
  GameInfo:print(string.format("Version: %s - Wrong game version! Use Ruby/Sapphire instead\n", gameVersion))
 elseif gameLanguage == "" then
  GameInfo:print("Version: "..gameVersion.."\n".."Language: Unknown language\n")
 else
  wrongGameVersion = false
  GameInfo:print("Version: "..gameVersion.."\n"..string.format("Language: %s\n", gameLanguage))
 end
end

function LCRNG(s, mul, sum)
 local a = (mul >> 16) * (s % 0x10000) + (s >> 16) * (mul % 0x10000)
 local b = (mul % 0x10000) * (s % 0x10000) + (a % 0x10000) * 0x10000 + sum

 return b % 0x100000000
end

local tempCurrentSeed = 0

function LCRNGDistance(state0, state1)
 local mask = 1
 local dist = 0

 if state0 ~= state1 then
  for _, data in ipairs(JUMP_DATA) do
   local mult, add = table.unpack(data)

   if state0 == state1 then
    break
   end

   if ((state0 ~ state1) & mask) ~= 0 then
    state0 = LCRNG(state0, mult, add)
    dist = dist + mask
   end

   mask = mask << 1
  end

  tempCurrentSeed = state1
 end

 return dist > 999 and dist - 0x100000000 or dist
end

local initialSeed, advances = 0, 0

function getRngInfo()
 local timer = emu:read16(timerAddr)
 local current = emu:read32(currentSeedAddr)

 if (timer == 0 and current <= 0xFFFF) or current == timer then
  initialSeed = current
  tempCurrentSeed = current
 end

 advances = initialSeed == current and 0 or advances + LCRNGDistance(tempCurrentSeed, current)

 return timer, current, advances
end

function showRngInfo(buffer)
 local paintingTimer, currentSeed, currentAdvances = getRngInfo()
 buffer:clear()
 buffer:print(string.format("Initial Seed: %04X\nPainting Timer: %04X\nCurrent Seed: %08X\nAdvances: %d\n\n\n", initialSeed, paintingTimer, currentSeed, currentAdvances))
end

function getPokemonIDs(addr)
 local pokemonIDs = emu:read32(addr + 0x4)
 local TID = pokemonIDs & 0xFFFF
 local SID = pokemonIDs >> 16

 return TID, SID
end

function getTrainerIDs()
 local trainerIDsAddr = saveBlock2Addr + 0xA
 local TID = emu:read16(trainerIDsAddr)
 local SID = emu:read16(trainerIDsAddr + 0x2)

 return TID, SID
end

function shinyCheck(PID, addr)
 addr = addr or nil

 local trainerTID, trainerSID

 if addr then
  trainerTID, trainerSID = getPokemonIDs(addr)
 else
  trainerTID, trainerSID = getTrainerIDs()
 end

 local lowPID = PID & 0xFFFF
 local highPID = PID >> 16
 local shinyTypeValue = (trainerSID ~ trainerTID) ~ (lowPID ~ highPID)

 if shinyTypeValue < 8 then
  return shinyTypeValue == 0 and " (Square)" or " (Star)"
 end

 return ""
end

function getOffset(offsetType, orderIndex)
 local offsets = {["growth"] = {0,0,0,0,0,0, 1,1,2,3,2,3, 1,1,2,3,2,3, 1,1,2,3,2,3},
                  ["attack"] = {1,1,2,3,2,3, 0,0,0,0,0,0, 2,3,1,1,3,2, 2,3,1,1,3,2},
                  ["misc"]   = {3,2,3,2,1,1, 3,2,3,2,1,1, 3,2,3,2,1,1, 0,0,0,0,0,0}}

 return offsets[offsetType][orderIndex] * 12
end

function getIVs(ivsValue)
 local hpIV = ivsValue & 0x1F
 local atkIV = (ivsValue & (0x1F * 0x20)) / 0x20
 local defIV = (ivsValue & (0x1F * 0x400)) / 0x400
 local spAtkIV = (ivsValue & (0x1F * 0x100000)) / 0x100000
 local spDefIV = (ivsValue & (0x1F * 0x2000000)) / 0x2000000
 local spdIV = (ivsValue & (0x1F * 0x8000)) / 0x8000

 return hpIV, atkIV, defIV, spAtkIV, spDefIV, spdIV
end

function getHPTypeAndPower(hpIV, atkIV, defIV, spAtkIV, spDefIV, spdIV)
 local hpType = (((hpIV & 1) + (2 * (atkIV & 1)) + (4 * (defIV & 1)) + (8 * (spdIV & 1)) + (16 * (spAtkIV & 1))
                + (32 * (spDefIV & 1))) * 15) // 63
 local hpPower = (((((hpIV >> 1) & 1) + (2 * ((atkIV >> 1) & 1)) + (4 * ((defIV >> 1) & 1)) + (8 * ((spdIV >> 1) & 1))
                 + (16 * ((spAtkIV >> 1) & 1)) + (32 * ((spDefIV >> 1) & 1))) * 40) // 63) + 30

 return hpType, hpPower
end

function showIVsAndHP(ivsValue, buffer)
 local hpIV, atkIV, defIV, spAtkIV, spDefIV, spdIV = getIVs(ivsValue)
 local hpType, hpPower = getHPTypeAndPower(hpIV, atkIV, defIV, spAtkIV, spDefIV, spdIV)
 buffer:print(string.format("IVs: %02d/%02d/%02d/%02d/%02d/%02d\nHPower: %s %d\n",
              hpIV, atkIV, defIV, spAtkIV, spDefIV, spdIV, HPTypeNamesList[hpType + 1], hpPower))
end

function getMoves(value1, value2)
 local move1 = value1 & 0xFFF
 local move2 = value1 >> 16
 local move3 = value2 & 0xFFF
 local move4 = value2 >> 16

 return move1, move2, move3, move4
end

function getPP(value)
 local PP1 = value & 0xFF
 local PP2 = (value >> 8) & 0xFF
 local PP3 = (value >> 16) & 0xFF
 local PP4 = value >> 24

 return PP1, PP2, PP3, PP4
end

function strPadding(moveStr, maxLength)
 local spaces = ""
 local moveStrLength = string.len(moveStr)

 if moveStrLength < maxLength then
  local padding = maxLength - moveStrLength

  for i = 0, padding do
   spaces = spaces.." "
  end
 end

 return moveStr..spaces
end

function showMovesAndPP(movesValue1, movesValue2, ppValue, buffer)
 local move1Index, move2Index, move3Index, move4Index = getMoves(movesValue1, movesValue2)
 local PPmove1, PPmove2, PPmove3, PPmove4 = getPP(ppValue)
 buffer:print(string.format("Move: %sPP: %d\n", strPadding(moveNamesList[move1Index <= 354 and move1Index + 1 or 1], 15), PPmove1))
 buffer:print(string.format("Move: %sPP: %d\n", strPadding(moveNamesList[move2Index <= 354 and move2Index + 1 or 1], 15), PPmove2))
 buffer:print(string.format("Move: %sPP: %d\n", strPadding(moveNamesList[move3Index <= 354 and move3Index + 1 or 1], 15), PPmove3))
 buffer:print(string.format("Move: %sPP: %d\n\n\n", strPadding(moveNamesList[move4Index <= 354 and move4Index + 1 or 1], 15), PPmove4))
end

function showInfo(pidAddr, buffer)
 local pokemonPID = emu:read32(pidAddr)
 local shinyType = shinyCheck(pokemonPID, pidAddr)
 local natureIndex = pokemonPID % 25
 local pokemonIDs = emu:read32(pidAddr + 0x4)
 local orderIndex = (pokemonPID % 24) + 1
 local decryptionKey = pokemonPID ~ pokemonIDs
 local growthOffset = getOffset("growth", orderIndex)
 local attacksOffset = getOffset("attack", orderIndex)
 local miscOffset = getOffset("misc", orderIndex)

 local ivsAndAbilityValue = emu:read32(pidAddr + 0x20 + miscOffset + 0x4) ~ decryptionKey
 local speciesAndItemValue = emu:read32(pidAddr + 0x20 + growthOffset) ~ decryptionKey
 local movesValue1 = emu:read32(pidAddr + 0x20 + attacksOffset) ~ decryptionKey
 local movesValue2 = emu:read32(pidAddr + 0x20 + attacksOffset + 0x4) ~ decryptionKey
 local PPValue = emu:read32(pidAddr + 0x20 + attacksOffset + 0x8) ~ decryptionKey

 local speciesDexIndex = speciesAndItemValue & 0xFFFF
 local speciesDexNumber = nationalDexList[speciesDexIndex + 1]
 local speciesName = speciesNamesList[speciesDexNumber]

 local itemIndex = speciesAndItemValue >> 16
 local itemName = itemNamesList[itemIndex + 1]

 local abilityNumber = (ivsAndAbilityValue >> 0x1F) + 1
 local abilityName = abilityNamesList[pokemonAbilities[(speciesDexNumber ~= nil and speciesDexNumber < 387) and speciesDexNumber or 1][abilityNumber]]

 buffer:print(string.format("Species: %s\n", speciesName ~= nil and speciesName or "--"))
 buffer:print(string.format("PID: %08X%s\n", pokemonPID, shinyType))
 buffer:print(string.format("Nature: %s\n", natureNamesList[natureIndex + 1]))
 buffer:print(string.format("Ability: %s (%d)\n", abilityName == nil and "--" or abilityName, abilityNumber))
 showIVsAndHP(ivsAndAbilityValue, buffer)
 buffer:print(string.format("Held item: %s\n\n", itemName ~= nil and itemName or "--"))
 showMovesAndPP(movesValue1, movesValue2, PPValue, buffer)
end

function showTrainerIDs(buffer)
 local trainerTID, trainerSID = getTrainerIDs()
 buffer:print(string.format("TID: %d\nSID: %d", trainerTID, trainerSID))
end

function getDayCareInfo()
 local eggStepsCounter = 255 - emu:read8(eggLowPIDAddr - 0x4)
 local eggFlagAddr = saveBlock1Addr + 0x1230
 local isEggReady = (emu:read8(eggFlagAddr) >> 6) & 0x1 == 1

 return isEggReady, eggStepsCounter
end

function showDayCareInfo(buffer)
 local isEggReady, eggStepsCounter = getDayCareInfo()

 if not isEggReady then
  buffer:print(string.format("Steps Counter: %d\nEgg is not ready\n", eggStepsCounter))
 end

 if isEggReady then
  local eggLowPid = emu:read16(eggLowPIDAddr)
  buffer:print(string.format("Egg generated, go get it!\nEgg lower PID: %04X\n\n\n", eggLowPid))
 elseif eggStepsCounter == 1 then
  buffer:print("Next step might generate an egg!\n\n\n")
 elseif eggStepsCounter == 0 then
  buffer:print("255th step taken\n\n\n")
 else
  buffer:print("Keep on steppin'\n\n\n")
 end
end

function isEgg(addr)
 return emu:read16(addr + 0x12) == 0x601
end

function showPartyEggInfo(buffer)
 local partySlotsCounter = emu:read8(partySlotsCounterAddr) - 1
 local lastPartySlotAddr = partyAddr + (partySlotsCounter * 0x64)

 if isEgg(lastPartySlotAddr) then
  showInfo(lastPartySlotAddr, buffer)
 end
end

function getRoamerInfo()
 local roamerAddr = saveBlock1Addr + 0x3144
 local roamerIVsValue = emu:read32(roamerAddr) & 0xFF  -- Raomes IVs bug (RS/FRLG only)
 local roamerPID = emu:read32(roamerAddr + 0x4)
 local roamerShinyType = shinyCheck(roamerPID)
 local roamerNatureIndex = roamerPID % 25
 local roamerSpeciesIndex = emu:read16(roamerAddr + 0x8)
 local roamerDexIndex = nationalDexList[roamerSpeciesIndex + 1]
 local roamerSpeciesName = speciesNamesList[roamerDexIndex]
 local roamerHP = emu:read16(roamerAddr + 0xA)
 local roamerLevel = emu:read8(roamerAddr + 0xC)
 local roamerStatusIndex = emu:read8(roamerAddr + 0xD)
 local roamerStatus = statusConditionNamesList[1]  -- No altered status condition

 local roamerMapGroupAndNum = emu:read16(roamerMapGroupAndNumAddr)
 local roamerMapIndex = roamerMapGroupAndNum >> 8
 local playerMapGroupAndNumAddr = saveBlock1Addr + 0x4
 local playerMapGroupAndNum = emu:read16(playerMapGroupAndNumAddr)

 if roamerStatusIndex > 0 and roamerStatusIndex < 0x8 then  -- Sleep
  roamerStatus = statusConditionNamesList[2]
 elseif roamerStatusIndex == 0x8 then  -- Poison
  roamerStatus = statusConditionNamesList[3]
 elseif roamerStatusIndex == 0x10 then  -- Burn
  roamerStatus = statusConditionNamesList[4]
 elseif roamerStatusIndex == 0x20 then  -- Freeze
  roamerStatus = statusConditionNamesList[5]
 elseif roamerStatusIndex == 0x40 then  -- Paralysis
  roamerStatus = statusConditionNamesList[6]
 elseif roamerStatusIndex == 0x80 then  -- Bad Poison
  roamerStatus = statusConditionNamesList[7]
 end

 local isRoamerActive = emu:read8(roamerAddr + 0x13) == 1

 return roamerSpeciesName, roamerPID, roamerShinyType, roamerNatureIndex, roamerIVsValue, isRoamerActive,
        roamerLevel, roamerHP, roamerStatus, roamerMapIndex, roamerMapGroupAndNum, playerMapGroupAndNum
end

function showRoamerInfo(buffer)
 local roamerSpeciesName, roamerPID, roamerShinyType, roamerNatureIndex, roamerIVsValue, isRoamerActive,
       roamerLevel, roamerHP, roamerStatus, roamerMapIndex, roamerMapGroupAndNum, playerMapGroupAndNum = getRoamerInfo()

 if isRoamerActive then
  buffer:print("Active Roamer? Yes\n")
  buffer:print(string.format("Species: %s\n", roamerSpeciesName))
  buffer:print(string.format("PID: %08X%s\n", roamerPID, roamerShinyType))
  buffer:print(string.format("Nature: %s\n", natureNamesList[roamerNatureIndex + 1]))
  showIVsAndHP(roamerIVsValue, buffer)
  buffer:print(string.format("Level: %d\n", roamerLevel))
  buffer:print(string.format("HP: %d\n", roamerHP))
  buffer:print(string.format("Status condition: %s\n", roamerStatus))
  buffer:print(string.format("Current position: %s%s\n\n\n", locationNamesList[roamerMapIndex + 1],
                              roamerMapGroupAndNum == playerMapGroupAndNum and " (!!!)" or ""))
 else
  buffer:print("Active Roamer? No\n\n\n")
 end
end

local prevKeyInfo, infoIndex, infoMode = {}, 1, {"Gift", "Party", "Stats", "Box"}

function getInfoInput(buffer)
 local key = emu:getKeys()

 if key == 0x120 and prevKeyInfo ~= key then
  infoIndex = infoIndex - 1 < 1 and 4 or infoIndex - 1
 elseif key == 0x110 and prevKeyInfo ~= key then
  infoIndex = infoIndex + 1 > 4 and 1 or infoIndex + 1
 end

 prevKeyInfo = key
 buffer:print(string.format("Mode: %s(Change mode pressing R+Right/R+Left)\n\n", strPadding(infoMode[infoIndex], 6)))
end

function showPokemonIDs(addr, buffer)
 local pokemonTID, pokemonSID = getPokemonIDs(addr)
 buffer:print(string.format("TID: %d\nSID: %d", pokemonTID, pokemonSID))
end

function showPokemonInfo(buffer)
 getInfoInput(buffer)

 if infoMode[infoIndex] == "Gift" then
  local partySlotsCounter = emu:read8(partySlotsCounterAddr) - 1
  local lastPartySlotAddr = partyAddr + (partySlotsCounter * 0x64)

  showInfo(lastPartySlotAddr, buffer)
  showPokemonIDs(lastPartySlotAddr, buffer)
 elseif infoMode[infoIndex] == "Party" then
  local partySlotsCounter = emu:read8(partySlotsCounterAddr) - 1
  local partySelectedSlotIndex = emu:read8(0x20200BA + (partySlotsCounter * 0x88))
  local partySelectedPokemonAddr = partyAddr + (partySelectedSlotIndex * 0x64)

  showInfo(partySelectedPokemonAddr, buffer)
  showPokemonIDs(partySelectedPokemonAddr, buffer)
 elseif infoMode[infoIndex] == "Box" then
  local currBoxIndex = emu:read8(currBoxIndexAddr)
  local boxAddr = currBoxIndexAddr + 0x4
  local boxSelectedSlotIndex = emu:read8(boxSelectedSlotIndexAddr)
  local boxSelectedPokemonAddr = boxAddr + (0x1E * currBoxIndex * 0x50) + (boxSelectedSlotIndex * 0x50)

  showInfo(boxSelectedPokemonAddr, buffer)
  showPokemonIDs(boxSelectedPokemonAddr, buffer)
 elseif infoMode[infoIndex] == "Stats" then
  local pokemonStatsScreenAddr = 0x2018010
  showInfo(pokemonStatsScreenAddr, buffer)
  showPokemonIDs(pokemonStatsScreenAddr, buffer)
 end
end

function updateCaptureBuffer()
 showRngInfo(CaptureInfo)
 showInfo(enemyAddr, CaptureInfo)
 showTrainerIDs(CaptureInfo)
end

function updateBreedingBuffer()
 showRngInfo(BreedingInfo)
 showDayCareInfo(BreedingInfo)
 showPartyEggInfo(BreedingInfo)
 showTrainerIDs(BreedingInfo)
end

function updateRoamerBuffer()
 showRngInfo(RoamerInfo)
 showRoamerInfo(RoamerInfo)
 showTrainerIDs(RoamerInfo)
end

function updatePandoraBuffer()
 showRngInfo(PandoraInfo)
 showTrainerIDs(PandoraInfo)
end

function updatePokemonInfoBuffer()
 showRngInfo(PokemonInfo)
 showPokemonInfo(PokemonInfo)
end

function createStateFile(statesFileName, stateSlot)
 os.execute("mkdir states")
 local statesFile = io.open(statesFileName, "w")

 if statesFile then  -- Check if the state file has been created correctly
  for slotNumber = 1, 9 do
   if slotNumber == stateSlot then  -- Write only in the line of the saved slot
    statesFile:write(string.format("%08X %08X %d\n", initialSeed, tempCurrentSeed, advances))
   else  -- Fill with empty data the lines of not saved state
    statesFile:write("00000000 00000000 0\n")
   end
  end

  statesFile:close()
 end
end

function writeStateFile(statesFileName, stateSlot)
 local statesFile = io.open(statesFileName, "r")
 local line_num = 1
 local lines = ""

 for line in statesFile:lines() do
  if line_num == stateSlot then  -- Overwrite only the line of the saved slot
   line = string.format("%08X %08X %d", initialSeed, tempCurrentSeed, advances)
  end

  lines = lines..line.."\n"
  line_num = line_num + 1
 end

 statesFile:close()
 statesFile = io.open(statesFileName, "w")
 statesFile:write(lines)
 statesFile:close()
end

function writeSaveStateValues(statesFileName, stateSlot)
 local statesFileCheck = io.open(statesFileName, "r")

 if not statesFileCheck then  -- Check if the states file does not exist
  createStateFile(statesFileName, stateSlot)
 else  -- States file already exists
  statesFileCheck:close()
  writeStateFile(statesFileName, stateSlot)
 end
end

function setSaveStateValues(statesFileName, stateSlot)
 local statesFile = io.open(statesFileName, "r")

 if statesFile then
  local line_num = 1
  local values = {}

  for line in statesFile:lines() do
   if line_num == stateSlot then  -- Load values from the line of the loaded slot only
    for value in line:gmatch("%S+") do
     table.insert(values, value)
    end

    break
   end

   line_num = line_num + 1
  end

  statesFile:close()
  initialSeed = tonumber(values[1], 16)
  tempCurrentSeed = tonumber(values[2], 16)
  advances = tonumber(values[3])
 end
end

function getSaveStateInput()
 local slotNumber = nil

 if input:isKeyActive(49) or input:isKeyActive(33) then  -- Check if (n) is being pressed
  slotNumber = 1
 elseif input:isKeyActive(50) or input:isKeyActive(34) then
  slotNumber = 2
 elseif input:isKeyActive(51) or input:isKeyActive(163) then
  slotNumber = 3
 elseif input:isKeyActive(52) or input:isKeyActive(36) then
  slotNumber = 4
 elseif input:isKeyActive(53) or input:isKeyActive(37) then
  slotNumber = 5
 elseif input:isKeyActive(54) or input:isKeyActive(38) then
  slotNumber = 6
 elseif input:isKeyActive(55) or input:isKeyActive(47) then
  slotNumber = 7
 elseif input:isKeyActive(56) or input:isKeyActive(40) then
  slotNumber = 8
 elseif input:isKeyActive(57) or input:isKeyActive(41) then
  slotNumber = 9
 end

 if slotNumber ~= nil then
  local savingStateFlag = input:isKeyActive(8388658)  -- Check if Shift is being pressed
  local statesFileName = string.format("states/%s_%s_states_values.txt", gameVersion, string.gsub(gameLanguage, "/", "_"))

  if savingStateFlag then  -- Saving a state
   emu:saveStateSlot(slotNumber)
   writeSaveStateValues(statesFileName, slotNumber)
  else  -- Loading a state
   emu:loadStateSlot(slotNumber)
   setSaveStateValues(statesFileName, slotNumber)
  end
 end
end

function updateBuffers()
 if (not wrongGameVersion) then
  updateCaptureBuffer()
  updateBreedingBuffer()
  updateRoamerBuffer()
  updatePandoraBuffer()
  updatePokemonInfoBuffer()
  getSaveStateInput()
 end
end

emu:reset()
initializeBuffers()
printGameInfo()
callbacks:add("frame", updateBuffers)
callbacks:add("reset", printGameInfo)