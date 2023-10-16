read32Bit = memory.read_u32_le
read16Bit = memory.read_u16_le
read8Bit = memory.readbyte
memoryWriteCheck = event.onmemorywrite
floor = math.floor

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
 "Latias", "Latios",  "Kyogre", "Groudon", "Rayquaza", "Jirachi", "Deoxys",
 -- Gen 4
 "Turtwig", "Grotle", "Torterra", "Chimchar", "Monferno", "Infernape", "Piplup", "Prinplup", "Empoleon", "Starly",
 "Staravia", "Staraptor", "Bidoof", "Bibarel", "Kricketot", "Kricketune", "Shinx", "Luxio", "Luxray", "Budew",
 "Roserade", "Cranidos", "Rampardos", "Shieldon", "Bastiodon", "Burmy", "Wormadam", "Mothim", "Combee", "Vespiquen",
 "Pachirisu", "Buizel", "Floatzel", "Cherubi", "Cherrim", "Shellos", "Gastrodon", "Ambipom", "Drifloon", "Drifblim",
 "Buneary", "Lopunny", "Mismagius", "Honchkrow", "Glameow", "Purugly", "Chingling", "Stunky", "Skuntank", "Bronzor",
 "Bronzong", "Bonsly", "Mime Jr.", "Happiny", "Chatot", "Spiritomb", "Gible", "Gabite", "Garchomp", "Munchlax",
 "Riolu", "Lucario", "Hippopotas", "Hippowdon", "Skorupi", "Drapion", "Croagunk", "Toxicroak", "Carnivine", "Finneon",
 "Lumineon", "Mantyke", "Snover", "Abomasnow", "Weavile", "Magnezone", "Lickilicky", "Rhyperior", "Tangrowth",
 "Electivire", "Magmortar", "Togekiss", "Yanmega", "Leafeon", "Glaceon", "Gliscor", "Mamoswine", "Porygon-Z",
 "Gallade", "Probopass", "Dusknoir", "Froslass", "Rotom", "Uxie", "Mesprit", "Azelf", "Dialga", "Palkia", "Heatran",
 "Regigigas", "Giratina", "Cresselia", "Phione", "Manaphy", "Darkrai", "Shaymin", "Arceus"}

local abilityNamesList = {
 -- Gen 3
 "Stench", "Drizzle", "Speed Boost", "Battle Armor", "Sturdy", "Damp", "Limber", "Sand Veil", "Static",
 "Volt Absorb", "Water Absorb", "Oblivious", "Cloud Nine", "Compound Eyes", "Insomnia", "Color Change", "Immunity",
 "Flash Fire", "Shield Dust", "Own Tempo", "Suction Cups", "Intimidate", "Shadow Tag", "Rough Skin", "Wonder Guard",
 "Levitate", "Effect Spore", "Synchronize", "Clear Body", "Natural Cure", "Lightning Rod", "Serene Grace",
 "Swift Swim", "Chlorophyll", "Illuminate", "Trace", "Huge Power", "Poison Point", "Inner Focus", "Magma Armor",
 "Water Veil", "Magnet Pull", "Soundproof", "Rain Dish", "Sand Stream", "Pressure", "Thick Fat", "Early Bird",
 "Flame Body", "Run Away", "Keen Eye", "Hyper Cutter", "Pickup", "Truant", "Hustle", "Cute Charm", "Plus", "Minus",
 "Forecast", "Sticky Hold", "Shed Skin", "Guts", "Marvel Scale", "Liquid Ooze", "Overgrow", "Blaze", "Torrent",
 "Swarm", "Rock Head", "Drought", "Arena Trap", "Vital Spirit", "White Smoke", "Pure Power", "Shell Armor",
 "Air Lock",
 -- Gen 4
 "Tangled Feet", "Motor Drive", "Rivalry", "Steadfast", "Snow Cloak", "Gluttony", "Anger Point", "Unburden",
 "Heatproof", "Simple", "Dry Skin", "Download", "Iron Fist", "Poison Heal", "Adaptability", "Skill Link", "Hydration",
 "Solar Power", "Quick Feet", "Normalize", "Sniper", "Magic Guard", "No Guard", "Stall", "Technician", "Leaf Guard",
 "Klutz", "Mold Breaker", "Super Luck", "Aftermath", "Anticipation", "Forewarn", "Unaware", "Tinted Lens", "Filter",
 "Slow Start", "Scrappy", "Storm Drain", "Ice Body", "Solid Rock", "Snow Warning", "Honey Gather", "Frisk", "Reckless",
 "Multitype", "Flower Gift", "Bad Dreams"}

local pokemonAbilities = {
 [1] = {65}, [2] = {65}, [3] = {65}, [4] = {66}, [5] = {66}, [6] = {66}, [7] = {67}, [8] = {67},
 [9] = {67}, [10] = {19}, [11] = {61}, [12] = {14}, [13] = {19}, [14] = {61}, [15] = {68}, [16] = {51, 77},
 [17] = {51, 77}, [18] = {51, 77}, [19] = {50, 62}, [20] = {50, 62}, [21] = {51}, [22] = {51}, [23] = {22, 61},
 [24] = {22, 61}, [25] = {9}, [26] = {9}, [27] = {8}, [28] = {8}, [29] = {38, 79}, [30] = {38, 79},
 [31] = {38, 79}, [32] = {38, 79}, [33] = {38, 79}, [34] = {38, 79}, [35] = {56, 98}, [36] = {56, 98}, [37] = {18},
 [38] = {18}, [39] = {56}, [40] = {56}, [41] = {39}, [42] = {39}, [43] = {34}, [44] = {34}, [45] = {34},
 [46] = {27, 87}, [47] = {27, 87}, [48] = {14, 110}, [49] = {19, 110}, [50] = {8, 71}, [51] = {8, 71}, [52] = {53, 101},
 [53] = {7, 101}, [54] = {6, 13}, [55] = {6, 13}, [56] = {72, 83}, [57] = {72, 83}, [58] = {22, 18}, [59] = {22, 18},
 [60] = {11, 6}, [61] = {11, 6}, [62] = {11, 6}, [63] = {28, 39}, [64] = {28, 39}, [65] = {28, 39}, [66] = {62, 99},
 [67] = {62, 99}, [68] = {62, 99}, [69] = {34}, [70] = {34}, [71] = {34}, [72] = {29, 64}, [73] = {29, 64}, [74] = {69, 5},
 [75] = {69, 5}, [76] = {69, 5}, [77] = {50, 18}, [78] = {50, 18}, [79] = {12, 20}, [80] = {12, 20}, [81] = {42, 5},
 [82] = {42, 5}, [83] = {51, 39}, [84] = {50, 48}, [85] = {50, 48}, [86] = {47, 93}, [87] = {47, 93}, [88] = {1, 60},
 [89] = {1, 60}, [90] = {75, 92}, [91] = {75, 92}, [92] = {26}, [93] = {26}, [94] = {26}, [95] = {69, 5}, [96] = {15, 108},
 [97] = {15, 108}, [98] = {52, 75}, [99] = {52, 75}, [100] = {43, 9}, [101] = {43, 9}, [102] = {34}, [103] = {34}, [104] = {69, 31},
 [105] = {69, 31}, [106] = {7, 120}, [107] = {51, 89}, [108] = {20, 12}, [109] = {26}, [110] = {26}, [111] = {31, 69}, [112] = {31, 69},
 [113] = {30, 32}, [114] = {34, 102}, [115] = {48, 113}, [116] = {33, 97}, [117] = {38, 97}, [118] = {33, 41}, [119] = {33, 41},
 [120] = {35, 30}, [121] = {35, 30}, [122] = {43, 111}, [123] = {68, 101}, [124] = {12, 108}, [125] = {9}, [126] = {49}, [127] = {52, 104},
 [128] = {22, 83}, [129] = {33}, [130] = {22}, [131] = {11, 75}, [132] = {7}, [133] = {50, 91}, [134] = {11}, [135] = {10}, [136] = {18},
 [137] = {36, 88}, [138] = {33, 75}, [139] = {33, 75}, [140] = {33, 4}, [141] = {33, 4}, [142] = {69, 46}, [143] = {17, 47}, [144] = {46},
 [145] = {46}, [146] = {46}, [147] = {61}, [148] = {61}, [149] = {39}, [150] = {46}, [151] = {28}, [152] = {65}, [153] = {65}, [154] = {65},
 [155] = {66}, [156] = {66}, [157] = {66}, [158] = {67}, [159] = {67}, [160] = {67}, [161] = {50, 51}, [162] = {50, 51}, [163] = {15, 51},
 [164] = {15, 51}, [165] = {68, 48}, [166] = {68, 48}, [167] = {68, 15}, [168] = {68, 15}, [169] = {39}, [170] = {10, 35}, [171] = {10, 35},
 [172] = {9}, [173] = {56, 98}, [174] = {56}, [175] = {55, 32}, [176] = {55, 32}, [177] = {28, 48}, [178] = {28, 48}, [179] = {9},
 [180] = {9}, [181] = {9}, [182] = {34}, [183] = {47, 37}, [184] = {47, 37}, [185] = {5, 69}, [186] = {11, 6}, [187] = {34, 102},
 [188] = {34, 102}, [189] = {34, 102}, [190] = {50, 53}, [191] = {34, 94}, [192] = {34, 94}, [193] = {3, 14}, [194] = {6, 11}, [195] = {6, 11},
 [196] = {28}, [197] = {28}, [198] = {15, 105}, [199] = {12, 20}, [200] = {26}, [201] = {26}, [202] = {23}, [203] = {39, 48}, [204] = {5},
 [205] = {5}, [206] = {32, 50}, [207] = {52, 8}, [208] = {69, 5}, [209] = {22, 50}, [210] = {22, 95}, [211] = {38, 33}, [212] = {68, 101},
 [213] = {5, 82}, [214] = {68, 62}, [215] = {39, 51}, [216] = {53, 95}, [217] = {62, 95}, [218] = {40, 49}, [219] = {40, 49}, [220] = {12, 81},
 [221] = {12, 81}, [222] = {55, 30}, [223] = {55, 97}, [224] = {21, 97}, [225] = {72, 55}, [226] = {33, 11}, [227] = {51, 5}, [228] = {48, 18},
 [229] = {48, 18}, [230] = {33, 97}, [231] = {53}, [232] = {5}, [233] = {36, 88}, [234] = {22, 119}, [235] = {20, 101}, [236] = {62, 80},
 [237] = {22, 101}, [238] = {12, 108}, [239] = {9}, [240] = {49}, [241] = {47, 113}, [242] = {30, 32}, [243] = {46}, [244] = {46}, [245] = {46},
 [246] = {62}, [247] = {61}, [248] = {45}, [249] = {46}, [250] = {46}, [251] = {30}, [252] = {65}, [253] = {65}, [254] = {65}, [255] = {66},
 [256] = {66}, [257] = {66}, [258] = {67}, [259] = {67}, [260] = {67}, [261] = {50, 95}, [262] = {22, 95}, [263] = {53, 82}, [264] = {53, 82},
 [265] = {19}, [266] = {61}, [267] = {68}, [268] = {61}, [269] = {19}, [270] = {33, 44}, [271] = {33, 44}, [272] = {33, 44}, [273] = {34, 48},
 [274] = {34, 48}, [275] = {34, 48}, [276] = {62}, [277] = {62}, [278] = {51}, [279] = {51}, [280] = {28, 36}, [281] = {28, 36}, [282] = {28, 36},
 [283] = {33}, [284] = {22}, [285] = {27, 90}, [286] = {27, 90}, [287] = {54}, [288] = {72}, [289] = {54}, [290] = {14}, [291] = {3}, [292] = {25},
 [293] = {43}, [294] = {43}, [295] = {43}, [296] = {47, 62}, [297] = {47, 62}, [298] = {47, 37}, [299] = {5, 42}, [300] = {56, 96}, [301] = {56, 96},
 [302] = {51, 100}, [303] = {52, 22}, [304] = {5, 69}, [305] = {5, 69}, [306] = {5, 69}, [307] = {74}, [308] = {74}, [309] = {9, 31}, [310] = {9, 31},
 [311] = {57}, [312] = {58}, [313] = {35, 68}, [314] = {12, 110}, [315] = {30, 38}, [316] = {64, 60}, [317] = {64, 60}, [318] = {24}, [319] = {24},
 [320] = {41, 12}, [321] = {41, 12}, [322] = {12, 86}, [323] = {40, 116}, [324] = {73}, [325] = {47, 20}, [326] = {47, 20}, [327] = {20, 77},
 [328] = {52, 71}, [329] = {26}, [330] = {26}, [331] = {8}, [332] = {8}, [333] = {30}, [334] = {30}, [335] = {17}, [336] = {61}, [337] = {26},
 [338] = {26}, [339] = {12, 107}, [340] = {12, 107}, [341] = {52, 75}, [342] = {52, 75}, [343] = {26}, [344] = {26}, [345] = {21}, [346] = {21},
 [347] = {4}, [348] = {4}, [349] = {33}, [350] = {63}, [351] = {59}, [352] = {16}, [353] = {15, 119}, [354] = {15, 119}, [355] = {26}, [356] = {46},
 [357] = {34, 94}, [358] = {26}, [359] = {46, 105}, [360] = {23}, [361] = {39, 115}, [362] = {39, 115}, [363] = {47, 115}, [364] = {47, 115},
 [365] = {47, 115}, [366] = {75}, [367] = {33}, [368] = {33}, [369] = {33, 69}, [370] = {33}, [371] = {69}, [372] = {69}, [373] = {22}, [374] = {29},
 [375] = {29}, [376] = {29}, [377] = {29}, [378] = {29}, [379] = {29}, [380] = {26}, [381] = {26}, [382] = {2}, [383] = {70}, [384] = {76},
 [385] = {32}, [386] = {46}, [387] = {65}, [388] = {65}, [389] = {65}, [390] = {66}, [391] = {66}, [392] = {66}, [393] = {67}, [394] = {67},
 [395] = {67}, [396] = {51}, [397] = {22}, [398] = {22}, [399] = {86, 109}, [400] = {86, 109}, [401] = {61}, [402] = {68}, [403] = {79, 22},
 [404] = {79, 22}, [405] = {79, 22}, [406] = {30, 38}, [407] = {30, 38}, [408] = {104}, [409] = {104}, [410] = {5}, [411] = {5}, [412] = {61},
 [413] = {107}, [414] = {68}, [415] = {118}, [416] = {46}, [417] = {50, 53}, [418] = {33}, [419] = {33}, [420] = {34}, [421] = {122},
 [422] = {60, 114}, [423] = {60, 114}, [424] = {101, 53}, [425] = {106, 84}, [426] = {106, 84}, [427] = {50, 103}, [428] = {56, 103}, [429] = {26},
 [430] = {15, 105}, [431] = {7, 20}, [432] = {47, 20}, [433] = {26}, [434] = {1, 106}, [435] = {1, 106}, [436] = {26, 85}, [437] = {26, 85},
 [438] = {5, 69}, [439] = {43, 111}, [440] = {30, 32}, [441] = {51, 77}, [442] = {46}, [443] = {8}, [444] = {8}, [445] = {8}, [446] = {53, 47},
 [447] = {80, 39}, [448] = {80, 39}, [449] = {45}, [450] = {45}, [451] = {4, 97}, [452] = {4, 97}, [453] = {107, 87}, [454] = {107, 87}, [455] = {26},
 [456] = {33, 114}, [457] = {33, 114}, [458] = {33, 11}, [459] = {117}, [460] = {117}, [461] = {46}, [462] = {42, 5}, [463] = {20, 12},
 [464] = {31, 116}, [465] = {34, 102}, [466] = {78}, [467] = {49}, [468] = {55, 32}, [469] = {3, 110}, [470] = {102}, [471] = {81}, [472] = {52, 8},
 [473] = {12, 81}, [474] = {91, 88}, [475] = {80}, [476] = {5, 42}, [477] = {46}, [478] = {81}, [479] = {26}, [480] = {26}, [481] = {26}, [482] = {26},
 [483] = {46}, [484] = {46}, [485] = {18}, [486] = {112}, [487] = {46}, [488] = {26}, [489] = {93}, [490] = {93}, [491] = {123}, [492] = {30},
 [493] = {121}}

local moveNamesList = {
 -- Gen 1
 "--", "Pound", "Karate Chop", "Double Slap", "Comet Punch", "Mega Punch", "Pay Day", "Fire Punch", "Ice Punch",
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
 "Super Fang", "Slash", "Substitute", "Struggle",
 -- Gen 2
 "Sketch", "Triple Kick", "Thief", "Spider Web", "Mind Reader",
 "Nightmare", "Flame Wheel", "Snore", "Curse", "Flail", "Conversion 2", "Aeroblast", "Cotton Spore", "Reversal",
 "Spite", "Powder Snow", "Protect", "Mach Punch", "Scary Face", "Feint Attack", "Sweet Kiss", "Belly Drum",
 "Sludge Bomb", "Mud-Slap", "Octazooka", "Spikes", "Zap Cannon", "Foresight", "Destiny Bond", "Perish Song",
 "Icy Wind", "Detect", "Bone Rush", "Lock-On", "Outrage", "Sandstorm", "Giga Drain", "Endure", "Charm", "Rollout",
 "False Swipe", "Swagger", "Milk Drink", "Spark", "Fury Cutter", "Steel Wing", "Mean Look", "Attract", "Sleep Talk",
 "Heal Bell", "Return", "Present", "Frustration", "Safeguard", "Pain Split", "Sacred Fire", "Magnitude",
 "Dynamic Punch", "Megahorn", "Dragon Breath", "Baton Pass", "Encore", "Pursuit", "Rapid Spin", "Sweet Scent",
 "Iron Tail", "Metal Claw", "Vital Throw", "Morning Sun", "Synthesis", "Moonlight", "Hidden Power", "Cross Chop",
 "Twister", "Rain Dance", "Sunny Day", "Crunch", "Mirror Coat", "Psych Up", "Extreme Speed", "Ancient Power",
 "Shadow Ball", "Future Sight", "Rock Smash", "Whirlpool", "Beat Up",
 -- Gen 3
 "Fake Out", "Uproar", "Stockpile", "Spit Up", "Swallow", "Heat Wave", "Hail", "Torment", "Flatter", "Will-O-Wisp",
 "Memento", "Facade", "Focus Punch", "Smelling Salts", "Follow Me", "Nature Power", "Charge", "Taunt", "Helping Hand",
 "Trick", "Role Play", "Wish", "Assist", "Ingrain", "Superpower", "Magic Coat", "Recycle", "Revenge", "Brick Break",
 "Yawn", "Knock Off", "Endeavor", "Eruption", "Skill Swap", "Imprison", "Refresh", "Grudge", "Snatch", "Secret Power",
 "Dive", "Arm Thrust", "Camouflage", "Tail Glow", "Luster Purge", "Mist Ball", "Feather Dance", "Teeter Dance",
 "Blaze Kick", "Mud Sport", "Ice Ball", "Needle Arm", "Slack Off", "Hyper Voice", "Poison Fang", "Crush Claw",
 "Blast Burn", "Hydro Cannon", "Meteor Mash", "Astonish", "Weather Ball", "Aromatherapy", "Fake Tears", "Air Cutter",
 "Overheat", "Odor Sleuth", "Rock Tomb", "Silver Wind", "Metal Sound", "Grass Whistle", "Tickle", "Cosmic Power",
 "Water Spout", "Signal Beam", "Shadow Punch", "Extrasensory", "Sky Uppercut", "Sand Tomb", "Sheer Cold", "Muddy Water",
 "Bullet Seed", "Aerial Ace", "Icicle Spear", "Iron Defense", "Block", "Howl", "Dragon Claw", "Frenzy Plant", "Bulk Up",
 "Bounce", "Mud Shot", "Poison Tail", "Covet", "Volt Tackle", "Magical Leaf", "Water Sport", "Calm Mind", "Leaf Blade",
 "Dragon Dance", "Rock Blast", "Shock Wave", "Water Pulse", "Doom Desire", "Psycho Boost",
 -- Gen 4
 "Roost", "Gravity", "Miracle Eye", "Wake-Up Slap", "Hammer Arm", "Gyro Ball", "Healing Wish", "Brine", "Natural Gift",
 "Feint", "Pluck", "Tailwind", "Acupressure", "Metal Burst", "U-turn", "Close Combat", "Payback", "Assurance", "Embargo",
 "Fling", "Psycho Shift", "Trump Card", "Heal Block", "Wring Out", "Power Trick", "Gastro Acid", "Lucky Chant", "Me First",
 "Copycat", "Power Swap", "Guard Swap", "Punishment", "Last Resort", "Worry Seed", "Sucker Punch", "Toxic Spikes",
 "Heart Swap", "Aqua Ring", "Magnet Rise", "Flare Blitz", "Force Palm", "Aura Sphere", "Rock Polish", "Poison Jab",
 "Dark Pulse", "Night Slash", "Aqua Tail", "Seed Bomb", "Air Slash", "X-Scissor", "Bug Buzz", "Dragon Pulse", "Dragon Rush",
 "Power Gem", "Drain Punch", "Vacuum Wave", "Focus Blast", "Energy Ball", "Brave Bird", "Earth Power", "Switcheroo",
 "Giga Impact", "Nasty Plot", "Bullet Punch", "Avalanche", "Ice Shard", "Shadow Claw", "Thunder Fang", "Ice Fang",
 "Fire Fang", "Shadow Sneak", "Mud Bomb", "Psycho Cut", "Zen Headbutt", "Mirror Shot", "Flash Cannon", "Rock Climb",
 "Defog", "Trick Room", "Draco Meteor", "Discharge", "Lava Plume", "Leaf Storm", "Power Whip", "Rock Wrecker",
 "Cross Poison", "Gunk Shot", "Iron Head", "Magnet Bomb", "Stone Edge", "Captivate", "Stealth Rock", "Grass Knot", "Chatter",
 "Judgment", "Bug Bite", "Charge Beam", "Wood Hammer", "Aqua Jet", "Attack Order", "Defend Order", "Heal Order", "Head Smash",
 "Double Hit", "Roar of Time", "Spacial Rend", "Lunar Dance", "Crush Grip", "Magma Storm", "Dark Void", "Seed Flare",
 "Ominous Wind", "Shadow Force"}

local itemNamesList = {
 "None", "Master Ball", "Ultra Ball", "Great Ball", "Poké Ball", "Safari Ball", "Net Ball", "Dive Ball",
 "Nest Ball", "Repeat Ball", "Timer Ball", "Luxury Ball", "Premier Ball", "Dusk Ball", "Heal Ball",
 "Quick Ball", "Cherish Ball", "Potion", "Antidote", "Burn Heal", "Ice Heal", "Awakening", "Parlyz Heal",
 "Full Restore", "Max Potion", "Hyper Potion", "Super Potion", "Full Heal", "Revive", "Max Revive",
 "Fresh Water", "Soda Pop", "Lemonade", "Moomoo Milk", "EnergyPowder", "Energy Root", "Heal Powder",
 "Revival Herb", "Ether", "Max Ether", "Elixir", "Max Elixir", "Lava Cookie", "Berry Juice",
 "Sacred Ash", "HP Up", "Protein", "Iron", "Carbos", "Calcium", "Rare Candy", "PP Up", "Zinc",
 "PP Max", "Old Gateau", "Guard Spec.", "Dire Hit", "X Attack", "X Defend", "X Speed", "X Accuracy",
 "X Special", "X Sp. Def", "Poké Doll", "Fluffy Tail", "Blue Flute", "Yellow Flute", "Red Flute",
 "Black Flute", "White Flute", "Shoal Salt", "Shoal Shell", "Red Shard", "Blue Shard", "Yellow Shard",
 "Green Shard", "Super Repel", "Max Repel", "Escape Rope", "Repel", "Sun Stone", "Moon Stone",
 "Fire Stone", "Thunderstone", "Water Stone", "Leaf Stone", "TinyMushroom", "Big Mushroom", "Pearl",
 "Big Pearl", "Stardust", "Star Piece", "Nugget", "Heart Scale", "Honey", "Growth Mulch",
 "Damp Mulch", "Stable Mulch", "Gooey Mulch", "Root Fossil", "Claw Fossil", "Helix Fossil", "Dome Fossil",
 "Old Amber", "Armor Fossil", "Skull Fossil", "Rare Bone", "Shiny Stone", "Dusk Stone", "Dawn Stone",
 "Oval Stone", "Odd Keystone", "Griseous Orb", "unknown1", "unknown2", "unknown3", "unknown4", "unknown5",
 "unknown6", "unknown7", "unknown8", "unknown9", "unknown10", "unknown11", "unknown12", "unknown13",
 "unknown14", "unknown15", "unknown16", "unknown17", "unknown18", "unknown19", "unknown20", "unknown21",
 "unknown22", "Adamant Orb", "Lustrous Orb", "Grass Mail", "Flame Mail", "Bubble Mail", "Bloom Mail",
 "Tunnel Mail", "Steel Mail", "Heart Mail", "Snow Mail", "Space Mail", "Air Mail", "Mosaic Mail", "Brick Mail",
 "Cheri Berry", "Chesto Berry", "Pecha Berry", "Rawst Berry", "Aspear Berry", "Leppa Berry", "Oran Berry",
 "Persim Berry", "Lum Berry", "Sitrus Berry", "Figy Berry", "Wiki Berry", "Mago Berry", "Aguav Berry",
 "Iapapa Berry", "Razz Berry", "Bluk Berry", "Nanab Berry", "Wepear Berry", "Pinap Berry", "Pomeg Berry",
 "Kelpsy Berry", "Qualot Berry", "Hondew Berry", "Grepa Berry", "Tamato Berry", "Cornn Berry", "Magost Berry",
 "Rabuta Berry", "Nomel Berry", "Spelon Berry", "Pamtre Berry", "Watmel Berry", "Durin Berry",
 "Belue Berry", "Occa Berry", "Passho Berry", "Wacan Berry", "Rindo Berry", "Yache Berry",
 "Chople Berry", "Kebia Berry", "Shuca Berry", "Coba Berry", "Payapa Berry", "Tanga Berry",
 "Charti Berry", "Kasib Berry", "Haban Berry", "Colbur Berry", "Babiri Berry", "Chilan Berry", "Liechi Berry",
 "Ganlon Berry", "Salac Berry", "Petaya Berry", "Apicot Berry", "Lansat Berry", "Starf Berry",
 "Enigma Berry", "Micle Berry", "Custap Berry", "Jaboca Berry", "Rowap Berry", "BrightPowder",
 "White Herb", "Macho Brace", "Exp. Share", "Quick Claw", "Soothe Bell", "Mental Herb", "Choice Band",
 "King's Rock", "SilverPowder", "Amulet Coin", "Cleanse Tag", "Soul Dew", "DeepSeaTooth",
 "DeepSeaScale", "Smoke Ball", "Everstone", "Focus Band", "Lucky Egg", "Scope Lens", "Metal Coat",
 "Leftovers", "Dragon Scale", "Light Ball", "Soft Sand", "Hard Stone", "Miracle Seed", "BlackGlasses",
 "Black Belt", "Magnet", "Mystic Water", "Sharp Beak", "Poison Barb", "NeverMeltIce", "Spell Tag",
 "TwistedSpoon", "Charcoal", "Dragon Fang", "Silk Scarf", "Up-Grade", "Shell Bell", "Sea Incense",
 "Lax Incense", "Lucky Punch", "Metal Powder", "Thick Club", "Stick", "Red Scarf", "Blue Scarf",
 "Pink Scarf", "Green Scarf", "Yellow Scarf", "Wide Lens", "Muscle Band", "Wise Glasses", "Expert Belt",
 "Light Clay", "Life Orb", "Power Herb", "Toxic Orb", "Flame Orb", "Quick Powder", "Focus Sash",
 "Zoom Lens", "Metronome", "Iron Ball", "Lagging Tail", "Destiny Knot", "Black Sludge", "Icy Rock",
 "Smooth Rock", "Heat Rock", "Damp Rock", "Grip Claw", "Choice Scarf", "Sticky Barb", "Power Bracer",
 "Power Belt", "Power Lens", "Power Band", "Power Anklet", "Power Weight", "Shed Shell",
 "Big Root", "Choice Specs", "Flame Plate", "Splash Plate", "Zap Plate", "Meadow Plate", "Icicle Plate",
 "Fist Plate", "Toxic Plate", "Earth Plate", "Sky Plate", "Mind Plate", "Insect Plate",
 "Stone Plate", "Spooky Plate", "Draco Plate", "Dread Plate", "Iron Plate", "Odd Incense",
 "Rock Incense", "Full Incense", "Wave Incense", "Rose Incense", "Luck Incense", "Pure Incense",
 "Protector", "Electirizer", "Magmarizer", "Dubious Disc", "Reaper Cloth", "Razor Claw", "Razor Fang",
 "TM01", "TM02", "TM03", "TM04", "TM05", "TM06", "TM07", "TM08", "TM09", "TM10", "TM11", "TM12",
 "TM13", "TM14", "TM15", "TM16", "TM17", "TM18", "TM19", "TM20", "TM21", "TM22", "TM23", "TM24",
 "TM25", "TM26", "TM27", "TM28", "TM29", "TM30", "TM31", "TM32", "TM33", "TM34", "TM35", "TM36",
 "TM37", "TM38", "TM39", "TM40", "TM41", "TM42", "TM43", "TM44", "TM45", "TM46", "TM47", "TM48",
 "TM49", "TM50", "TM51", "TM52", "TM53", "TM54", "TM55", "TM56", "TM57", "TM58", "TM59", "TM60",
 "TM61", "TM62", "TM63", "TM64", "TM65", "TM66", "TM67", "TM68", "TM69", "TM70", "TM71", "TM72",
 "TM73", "TM74", "TM75", "TM76", "TM77", "TM78", "TM79", "TM80", "TM81", "TM82", "TM83", "TM84",
 "TM85", "TM86", "TM87", "TM88", "TM89", "TM90", "TM91", "TM92", "HM01", "HM02", "HM03", "HM04",
 "HM05", "HM06", "HM07", "HM08", "Explorer Kit", "Loot Sack", "Rule Book", "Poké Radar", "Point Card",
 "Journal", "Seal Case", "Fashion Case", "Seal Bag", "Pal Pad", "Works Key", "Old Charm",
 "Galactic Key", "Red Chain", "Town Map", "Vs. Seeker", "Coin Case", "Old Rod", "Good Rod", "Super Rod",
 "Sprayduck", "Poffin Case", "Bicycle", "Suite Key", "Oak's Letter", "Lunar Wing", "Member Card",
 "Azure Flute", "S.S. Ticket", "Contest Pass", "Magma Stone", "Parcel", "Coupon 1", "Coupon 2",
 "Coupon 3", "Storage Key", "SecretPotion", "Vs. Recorder", "Gracidea", "Secret Key",
 "Apricorn Box", "Unown Report", "Berry Pots", "Dowsing MCHN", "Blue Card", "Slowpoke Tail",
 "Clear Bell", "Card Key", "Basement Key", "SquirtBottle", "Red Scale", "Lost Item", "Pass",
 "Machine Part", "Silver Wing", "Rainbow Wing", "Mystery Egg", "Red Apricorn", "Yellow Apricorn",
 "Blue Apricorn", "Green Apricorn", "Pink Apricorn", "White Apricorn", "Black Apricorn", "Fast Ball",
 "Level Ball", "Lure Ball", "Heavy Ball", "Love Ball", "Friend Ball", "Moon Ball",
 "Sport Ball", "Park Ball", "Photo Album", "GB Sounds", "Tidal Bell", "RageCandyBar", "Data Card 01",
 "Data Card 02", "Data Card 03", "Data Card 04", "Data Card 05", "Data Card 06", "Data Card 07",
 "Data Card 08", "Data Card 09", "Data Card 10", "Data Card 11", "Data Card 12", "Data Card 13",
 "Data Card 14", "Data Card 15", "Data Card 16", "Data Card 17", "Data Card 18", "Data Card 19",
 "Data Card 20", "Data Card 21", "Data Card 22", "Data Card 23", "Data Card 24", "Data Card 25",
 "Data Card 26", "Data Card 27", "Jade Orb", "Lock Capsule", "Red Orb", "Blue Orb", "Enigma Stone"}

local locationNamesList = {
 "Mystery Zone", "Mystery Zone", "Mystery Zone", "Jubilife City", "Jubilife City", "Jubilife City",
 "Jubilife City", "Jubilife City", "Pokétch Co.", "Pokétch Co.", "Pokétch Co.", "Jubilife TV",
 "Jubilife TV", "Jubilife TV", "Jubilife TV", "Jubilife TV", "Jubilife TV", "Jubilife TV",
 "Jubilife TV", "Jubilife City", "Jubilife City", "Jubilife City", "Jubilife City", "Jubilife City",
 "Jubilife City", "Jubilife City", "Jubilife City", "Jubilife City", "Global Terminal",
 "Trainers’ School", "Jubilife City", "Jubilife City", "Jubilife City", "Canalave City",
 "Canalave City", "Canalave City", "Canalave City", "Canalave City", "Canalave Library",
 "Canalave Library", "Canalave Library", "Canalave City", "Canalave City", "Canalave City",
 "Canalave City", "Oreburgh City", "Oreburgh City", "Oreburgh City", "Oreburgh City", "Oreburgh City",
 "Oreburgh City", "Oreburgh City", "Oreburgh City", "Oreburgh City", "Oreburgh City", "Oreburgh City",
 "Oreburgh City", "Oreburgh City", "Oreburgh City", "Mining Museum", "Oreburgh City", "Oreburgh City",
 "Oreburgh City", "Oreburgh City", "Oreburgh City", "Eterna City", "Eterna City", "Eterna City",
 "Eterna City", "Eterna City", "Eterna City", "Cycle Shop", "T.G. Eterna Bldg", "T.G. Eterna Bldg",
 "T.G. Eterna Bldg", "T.G. Eterna Bldg", "Eterna City", "Eterna City", "Eterna City", "Eterna City",
 "Route 206", "Eterna City", "Eterna City", "Eterna City", "Eterna City", "Eterna City", "Hearthome City",
 "Hearthome City", "Hearthome City", "Hearthome City", "Hearthome City", "Hearthome City",
 "Hearthome City", "Hearthome City", "Hearthome City", "Hearthome City", "Hearthome City",
 "Hearthome City", "Hearthome City", "Hearthome City", "Hearthome City", "Hearthome City",
 "Hearthome City", "Hearthome City", "Hearthome City", "Hearthome City", "Hearthome City",
 "Hearthome City", "Hearthome City", "Route 208", "Route 209", "Route 212", "Hearthome City",
 "Hearthome City", "Hearthome City", "Hearthome City", "Poffin House", "Contest Hall", "Contest Hall",
 "Foreign Building", "Pastoria City", "Pastoria City", "Pastoria City", "Pastoria City", "Pastoria City",
 "Pastoria City", "Pastoria City", "Pastoria City", "Pastoria City", "Pastoria City", "Pastoria City",
 "Pastoria City", "Veilstone City", "Veilstone City", "Veilstone City", "Veilstone City", "Game Corner",
 "Veilstone Store", "Veilstone Store", "Veilstone Store", "Veilstone Store", "Veilstone Store",
 "Veilstone Store", "Veilstone City", "Veilstone City", "Veilstone City", "Veilstone City", "Veilstone City",
 "Veilstone City", "Route 215", "Sunyshore City", "Sunyshore City", "Sunyshore City", "Sunyshore City",
 "Sunyshore City", "Sunyshore City", "Sunyshore City", "Sunyshore Market", "Sunyshore City", "Sunyshore City",
 "Sunyshore City", "Sunyshore City", "Sunyshore City", "Sunyshore City", "Vista Lighthouse", "Snowpoint City",
 "Snowpoint City", "Snowpoint City", "Snowpoint City", "Snowpoint City", "Snowpoint City", "Snowpoint City",
 "Pokémon League", "Pokémon League", "Pokémon League", "Pokémon League", "Pokémon League", "Pokémon League",
 "Pokémon League", "Pokémon League", "Pokémon League", "Pokémon League", "Pokémon League", "Pokémon League",
 "Pokémon League", "Pokémon League", "Pokémon League", "Pokémon League", "Fight Area", "Fight Area",
 "Fight Area", "Fight Area", "Battle Park", "Route 225", "Fight Area", "Fight Area", "Mystery Zone",
 "Oreburgh Mine", "Oreburgh Mine", "Oreburgh Mine", "Valley Windworks", "Valley Windworks", "Eterna Forest",
 "Eterna Forest", "Fuego Ironworks", "Fuego Ironworks", "Mystery Zone", "Mt. Coronet", "Mt. Coronet",
 "Mt. Coronet", "Mt. Coronet", "Mt. Coronet", "Mt. Coronet", "Mt. Coronet", "Mt. Coronet", "Mt. Coronet",
 "Mt. Coronet", "Mt. Coronet", "Mt. Coronet", "Mt. Coronet", "Spear Pillar", "Spear Pillar", "Mystery Zone",
 "Pastoria City", "Mystery Zone", "Solaceon Ruins", "Solaceon Ruins", "Solaceon Ruins", "Solaceon Ruins",
 "Solaceon Ruins", "Solaceon Ruins", "Solaceon Ruins", "Solaceon Ruins", "Solaceon Ruins", "Solaceon Ruins",
 "Solaceon Ruins", "Solaceon Ruins", "Solaceon Ruins", "Solaceon Ruins", "Solaceon Ruins", "Solaceon Ruins",
 "Solaceon Ruins", "Solaceon Ruins", "Mystery Zone", "Victory Road", "Victory Road", "Victory Road",
 "Victory Road", "Victory Road", "Victory Road", "Mystery Zone", "Pal Park", "Mystery Zone", "Amity Square",
 "Ravaged Path", "Mystery Zone", "Floaroma Meadow", "Floaroma Meadow", "Oreburgh Gate", "Oreburgh Gate",
 "Fullmoon Island", "Fullmoon Island", "Stark Mountain", "Stark Mountain", "Stark Mountain", "Stark Mountain",
 "Mystery Zone", "Sendoff Spring", "Turnback Cave", "Turnback Cave", "Turnback Cave", "Turnback Cave",
 "Turnback Cave", "Turnback Cave", "Flower Paradise", "Mystery Zone", "Mystery Zone", "Mystery Zone",
 "Snowpoint Temple", "Snowpoint Temple", "Snowpoint Temple", "Snowpoint Temple", "Snowpoint Temple",
 "Snowpoint Temple", "Wayward Cave", "Wayward Cave", "Ruin Maniac Cave", "Trophy Garden", "Iron Island",
 "Iron Island", "Iron Island", "Iron Island", "Iron Island", "Iron Island", "Iron Island", "Old Chateau",
 "Old Chateau", "Old Chateau", "Old Chateau", "Old Chateau", "Old Chateau", "Old Chateau", "Old Chateau",
 "Old Chateau", "Mystery Zone", "Galactic HQ", "Galactic HQ", "Galactic HQ", "Galactic HQ", "Galactic HQ",
 "Galactic HQ", "Lake Verity", "Lake Verity", "Verity Cavern", "Lake Valor", "Lake Valor", "Valor Cavern",
 "Lake Acuity", "Lake Acuity", "Acuity Cavern", "Newmoon Island", "Newmoon Island", "Battle Park", "Battle Park",
 "Mystery Zone", "Mystery Zone", "Battle Tower", "Battle Tower", "Battle Tower", "Battle Tower", "Battle Tower",
 "Battle Tower", "Mystery Zone", "Mystery Zone", "Verity Lakefront", "Verity Lakefront", "Valor Lakefront",
 "Restaurant", "Grand Lake", "Grand Lake", "Acuity Lakefront", "Spring Path", "Route 201", "Route 202",
 "Route 203", "Route 204", "Route 204", "Route 205", "Route 205", "Route 205", "Route 206", "Route 206",
 "Mystery Zone", "Route 207", "Route 208", "Route 208", "Route 209", "Route 209", "Route 209", "Route 209",
 "Route 209", "Route 209", "Route 210", "Route 210", "Route 210", "Route 211", "Route 211", "Route 212",
 "Pokémon Mansion", "Pokémon Mansion", "Pokémon Mansion", "Route 212", "Route 212", "Route 213", "Route 213",
 "Footstep House", "Grand Lake", "Grand Lake", "Grand Lake", "Grand Lake", "Route 214", "Route 214", "Route 215",
 "Route 216", "Route 216", "Route 217", "Route 217", "Route 217", "Route 218", "Route 218", "Route 218",
 "Route 219", "Route 221", "Pal Park", "Route 221", "Route 222", "Route 222", "Route 222", "Route 222",
 "Route 224", "Route 225", "Mystery Zone", "Mystery Zone", "Route 227", "Mystery Zone", "Mystery Zone",
 "Route 228", "Route 229", "Mystery Zone", "Mystery Zone", "Mystery Zone", "Twinleaf Town", "Twinleaf Town",
 "Twinleaf Town", "Twinleaf Town", "Twinleaf Town", "Twinleaf Town", "Twinleaf Town", "Sandgem Town",
 "Sandgem Town", "Sandgem Town", "Sandgem Town", "Sandgem Town", "Sandgem Town", "Sandgem Town", "Sandgem Town",
 "Floaroma Town", "Floaroma Town", "Floaroma Town", "Floaroma Town", "Flower Shop", "Floaroma Town",
 "Floaroma Town", "Solaceon Town", "Solaceon Town", "Solaceon Town", "Solaceon Town", "Pokémon Day Care",
 "Solaceon Town", "Solaceon Town", "Solaceon Town", "Solaceon Town", "Celestic Town", "Celestic Town",
 "Celestic Town", "Celestic Town", "Celestic Town", "Celestic Town", "Celestic Town", "Celestic Town",
 "Survival Area", "Survival Area", "Survival Area", "Survival Area", "Battleground", "Survival Area",
 "Survival Area", "Resort Area", "Resort Area", "Resort Area", "Resort Area", "Resort Area", "Resort Area",
 "Resort Area", "Villa", "Resort Area", "Mystery Zone", "Route 220", "Route 223", "Route 226", "Mystery Zone",
 "Route 230", "Seabreak Path", "Mystery Zone", "Jubilife City", "Canalave City", "Oreburgh City", "Eterna City",
 "Hearthome City", "Pastoria City", "Veilstone City", "Sunyshore City", "Snowpoint City", "Pokémon League",
 "Fight Area", "Sandgem Town", "Floaroma Town", "Solaceon Town", "Celestic Town", "Survival Area", "Resort Area",
 "Canalave City", "Café", "Battle Tower", "Galactic HQ", "Pokémon League", "Pokémon League", "Galactic HQ",
 "Route 225", "Route 226", "Route 227", "Route 228", "Route 228", "Route 228", "Great Marsh", "Great Marsh",
 "Great Marsh", "Great Marsh", "Great Marsh", "Great Marsh", "Hall of Origin", "Hall of Origin",
 "Ruin Maniac Cave", "Maniac Tunnel", "Iron Island", "Solaceon Ruins", "Vista Lighthouse", "Jubilife City",
 "Turnback Cave", "Turnback Cave", "Turnback Cave", "Turnback Cave", "Turnback Cave", "Turnback Cave",
 "Turnback Cave", "Turnback Cave", "Turnback Cave", "Turnback Cave", "Turnback Cave", "Turnback Cave",
 "Turnback Cave", "Turnback Cave", "Turnback Cave", "Turnback Cave", "Turnback Cave", "Turnback Cave",
 "Turnback Cave", "Turnback Cave", "Turnback Cave", "Turnback Cave", "Turnback Cave", "Turnback Cave",
 "Turnback Cave", "Turnback Cave", "Turnback Cave", "Turnback Cave", "Turnback Cave", "Turnback Cave",
 "Turnback Cave", "Turnback Cave", "Turnback Cave", "Turnback Cave", "Turnback Cave", "Turnback Cave",
 "Turnback Cave", "Turnback Cave", "Turnback Cave", "Turnback Cave", "Contest Hall", "Battle Frontier",
 "Battle Frontier", "Battle Tower", "Battle Factory", "Battle Hall", "Battle Castle", "Battle Arcade",
 "Veilstone Store", "Global Terminal", "Global Terminal", "Galactic HQ", "Distortion World", "ROTOM’s Room",
 "T.G. Eterna Bldg", "Distortion World", "Distortion World", "Distortion World", "Distortion World",
 "Distortion World", "Distortion World", "Distortion World", "Distortion World", "Distortion World",
 "Distortion World", "Distortion World", "Spear Pillar", "Spear Pillar", "Jubilife City", "Iron Island",
 "Iron Ruins", "Mt. Coronet", "Iceberg Ruins", "Route 228", "Rock Peak Ruins"}

local statusConditionNamesList = {"None", "SLP", "PSN", "BRN", "FRZ", "PAR", "PSN"}

client.reboot_core()

local gameCode = read32Bit(0x02FFFE0C)
local gameVersionCode = gameCode & 0xFFFFFF
local gameVersion = ""
local gameLanguageCode = gameCode >> 24
local gameLanguage = ""
local wrongGameVersion = true

if gameVersionCode == 0x414441 then  -- Check game version
 gameVersion = "Diamond"
elseif gameVersionCode == 0x415041 then
 gameVersion = "Pearl"
elseif gameVersionCode == 0x555043 then
 gameVersion = "Platinum"
elseif gameVersionCode == 0x475049 then
 gameVersion = "SoulSilver"
elseif gameVersionCode == 0x4B5049 then
 gameVersion = "HeartGold"
end

local mtIndexAddr, pidPointerAddr, delayAddr, currentSeedAddr, mtSeedAddr, trainerIDsPointerAddr, tempCurrentSeedDuringBattleAddr
local koreanOffset = 0

if gameLanguageCode == 0x44 then  -- Check game language and set addresses
 gameLanguage = "GER"
 mtIndexAddr = 0x021009D0
 pidPointerAddr = 0x02101ECC
 delayAddr = 0x021BF848
 currentSeedAddr = 0x021BFCB4
 mtSeedAddr = 0x021BFCB8
 trainerIDsPointerAddr = 0x021C0934
 tempCurrentSeedDuringBattleAddr = 0x027E3634
elseif gameLanguageCode == 0x45 then
 gameLanguage = "EUR/USA"
 mtIndexAddr = 0x02100834
 pidPointerAddr = 0x02101D2C
 delayAddr = 0x021BF6A8
 currentSeedAddr = 0x021BFB14
 mtSeedAddr = 0x021BFB18
 trainerIDsPointerAddr = 0x021C0794
 tempCurrentSeedDuringBattleAddr = 0x027E3634
elseif gameLanguageCode == 0x46 then
 gameLanguage = "FRE"
 mtIndexAddr = 0x02100A10
 pidPointerAddr = 0x02101F0C
 delayAddr = 0x021BF888
 currentSeedAddr = 0x021BFCF4
 mtSeedAddr = 0x021BFCF8
 trainerIDsPointerAddr = 0x021C0974
 tempCurrentSeedDuringBattleAddr = 0x027E3634
elseif gameLanguageCode == 0x49 then
 gameLanguage = "ITA"
 mtIndexAddr = 0x02100990
 pidPointerAddr = 0x02101E8C
 delayAddr = 0x021BF808
 currentSeedAddr = 0x021BFC74
 mtSeedAddr = 0x021BFC78
 trainerIDsPointerAddr = 0x021C08F4
 tempCurrentSeedDuringBattleAddr = 0x027E3634
elseif gameLanguageCode == 0x4A then
 gameLanguage = "JPN"
 mtIndexAddr = 0x020FFC28
 pidPointerAddr = 0x0210112C
 delayAddr = 0x021BEAA8
 currentSeedAddr = 0x021BEF14
 mtSeedAddr = 0x021BEF18
 trainerIDsPointerAddr = 0x021BFB94
 tempCurrentSeedDuringBattleAddr = 0x027E3634
elseif gameLanguageCode == 0x4B then
 gameLanguage = "KOR"
 koreanOffset = 0x44
 mtIndexAddr = 0x02101710
 pidPointerAddr = 0x02102C2C
 delayAddr = 0x021C05A8
 currentSeedAddr = 0x021C0A14
 mtSeedAddr = 0x021C0A18
 trainerIDsPointerAddr = 0x021C1694
 tempCurrentSeedDuringBattleAddr = 0x027E3634
elseif gameLanguageCode == 0x53 then
 gameLanguage = "SPA"
 mtIndexAddr = 0x02100A30
 pidPointerAddr = 0x02101F2C
 delayAddr = 0x021BF8A8
 currentSeedAddr = 0x021BFD14
 mtSeedAddr = 0x021BFD18
 trainerIDsPointerAddr = 0x021C0994
 tempCurrentSeedDuringBattleAddr = 0x027E3634
end

function printGameInfo()
 console.clear()

 if gameVersion == "" then  -- Print game info
  print("Version: Unknown game")
 elseif gameVersion ~= "Platinum" then
  print(string.format("Version: %s - Wrong game version! Use Platinum instead\n", gameVersion))
 elseif gameLanguage == "" then
  print("Version: "..gameVersion)
  print("Language: Unknown language\n")
 else
  wrongGameVersion = false
  print("Version: "..gameVersion)
  print(string.format("Language: %s\n", gameLanguage))
 end
end

printGameInfo()

local mode, index = {"None", "Capture", "Breeding", "Roamer", "Pandora", "Pokemon Info"}, 1

function setBackgroundBoxes()  -- Set transparent black boxes
 gui.defaultTextBackground("clear")
 gui.defaultPixelFont("gens")

 if mode[index] == "None" or mode[index] == "Pandora" then
  gui.drawBox(1, 1, 113, 8, 0x7F000000, 0x7F000000)
 elseif mode[index] == "Capture" or mode[index] == "Breeding" or mode[index] == "Pokemon Info" then
  gui.drawBox(1, 1, 113, 92, 0x7F000000, 0x7F000000)
 elseif mode[index] == "Roamer" then
  gui.drawBox(1, 1, 113, 85, 0x7F000000, 0x7F000000)
 end

 if mode[index] ~= "None" then
  gui.drawBox(110, 183, 178, 190, 0x7F000000, 0x7F000000)
  gui.drawBox(214, 176, 254, 190, 0x7F000000, 0x7F000000)
 end
end

local dateTime = {["month"] = 1, ["day"] = 1, ["year"] = 0, ["hour"] = 0, ["minute"] = 0, ["second"] = 0}

function setDateTime()
 local dateTimeAddr = 0x023FFDE8

 dateTime["year"] = string.format("%02X", read8Bit(dateTimeAddr))
 dateTime["month"] = string.format("%02X", read8Bit(dateTimeAddr + 0x1))
 dateTime["day"] = string.format("%02X", read8Bit(dateTimeAddr + 0x2))
 dateTime["hour"] = string.format("%02X", read8Bit(dateTimeAddr + 0x4) % 0x40)
 dateTime["minute"] = string.format("%02X", read8Bit(dateTimeAddr + 0x5))
 dateTime["second"] = string.format("%02X", read8Bit(dateTimeAddr + 0x6))
end

function drawArrowLeft(a, b, c)
 gui.drawLine(a, b + 3, a + 2, b + 5, c)
 gui.drawLine(a, b + 3, a + 2, b + 1, c)
 gui.drawLine(a, b + 3, a + 6, b + 3, c)
end

function drawArrowRight(a, b, c)
 gui.drawLine(a, b + 3, a - 2, b + 5, c)
 gui.drawLine(a, b + 3, a - 2, b + 1, c)
 gui.drawLine(a, b + 3, a - 6, b + 3, c)
end

local prevKey = {}

function getTabInput()
 local leftArrowColor = "gray"
 local rightArrowColor = "gray"
 local key = input.get()

 if (key["Number1"] or key["Keypad1"]) and (not prevKey["Number1"] and not prevKey["Keypad1"]) then
  leftArrowColor = "orange"
  index = index - 1 < 1 and 6 or index - 1
 elseif (key["Number2"] or key["Keypad2"]) and (not prevKey["Number2"] and not prevKey["Keypad2"]) then
  rightArrowColor = "orange"
  index = index + 1 > 6 and 1 or index + 1
 end

 prevKey = key
 gui.pixelText(1, 1, "Mode: "..mode[index])
 drawArrowLeft(76, 1, leftArrowColor)
 gui.pixelText(84, 1, "1 - 2")
 drawArrowRight(112, 1, rightArrowColor)
end

function buildSeedFromDelay(delay)
 local ab = ((dateTime["month"] * dateTime["day"]) + dateTime["minute"] + dateTime["second"]) % 0x100
 local cd = dateTime["hour"]
 local efgh = dateTime["year"] + delay

 return ((ab * 0x1000000) + (cd * 0x10000) + efgh) % 0x100000000
end

local prevMTSeed, initialSeed, tempCurrentSeed, mtCounter, hitDelay , hitDate = 0, 0, 0, 0, 0, "01/01/2000\n00:00:00"

function setInitialSeed(mtSeed, delay)
 if prevMTSeed ~= mtSeed and delay ~= 0 then
  prevMTSeed = mtSeed
  initialSeed = mtSeed
  tempCurrentSeed = mtSeed
  hitDelay = delay
  hitDate = string.format("%s/%s/20%s\n%s:%s:%s", dateTime["day"], dateTime["month"], dateTime["year"],
                          dateTime["hour"], dateTime["minute"], dateTime["second"])

  if mtSeed == buildSeedFromDelay(delay) then
   print(string.format("Initial Seed: %08X", initialSeed))
  end
 elseif delay == 0 then
  prevMTSeed = 0
  initialSeed = 0
  tempCurrentSeed = 0
  mtCounter = 0
  hitDelay = 0
  hitDate = "01/01/2000\n00:00:00"
 end

 userdata.set("initialSeed", initialSeed)
 userdata.set("hitDelay", hitDelay)
 userdata.set("hitDate", hitDate)
end

function LCRNG(s, mul, sum)
 local a = (mul >> 16) * (s % 0x10000) + (s >> 16) * (mul % 0x10000)
 local b = (mul % 0x10000) * (s % 0x10000) + (a % 0x10000) * 0x10000 + sum

 return b % 0x100000000
end

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

local lastCurrentSeedBeforeBattle, battleStartJump, advances = nil, false, 0

function getRngInfo()
 local mtSeed = read32Bit(mtSeedAddr)
 local current = read32Bit(currentSeedAddr)
 local delay = read32Bit(delayAddr)
 local mtIndex = read32Bit(mtIndexAddr)

 if mtSeed == current then  -- Set the initial seed when the MT seed is equal to the LCRNG current seed
  setInitialSeed(mtSeed, delay)
 elseif prevMTSeed ~= mtSeed then  -- Check when the value of the MT seed changes in RAM
  if mtIndex ~= 624 then  -- Avoid advancing the MT counter when the MT seed changes the first time
   mtCounter = mtCounter + 1
  end

  prevMTSeed = mtSeed
 elseif tempCurrentSeed == read32Bit(tempCurrentSeedDuringBattleAddr) and tempCurrentSeed ~= 0 then  -- Check when current seed is set on battle temp current seed address
  lastCurrentSeedBeforeBattle = tempCurrentSeed
  battleStartJump = true
 elseif current == lastCurrentSeedBeforeBattle then  -- Check when battle ends
  battleStartJump = false
 end

 if not battleStartJump then  -- Calculate prng jumps only when not in battle
  advances = mtSeed == current and 0 or advances + LCRNGDistance(tempCurrentSeed, current)
 end

 local mtAdvances = (mtIndex - 624) + (mtCounter * 624)

 if mtAdvances < 0 then  -- Avoid negative MT advances (this may happens in korean games)
  mtCounter = mtCounter + 1
 end

 userdata.set("tempCurrentSeed", tempCurrentSeed)
 userdata.set("advances", advances)
 userdata.set("mtCounter", mtCounter)
 userdata.set("lastCurrentSeedBeforeBattle", lastCurrentSeedBeforeBattle)
 userdata.set("battleStartJump", battleStartJump)

 return current, mtAdvances, delay
end

local showInitialSeedInfoText = true

function getInitialSeedInfoInput()
 local key = input.get()

 if key["Number7"] or key["Keypad7"] then
  showInitialSeedInfoText = false
 elseif key["Number8"] or key["Keypad8"] then
  showInitialSeedInfoText = true
 end

 gui.drawBox(1, 376, 105, 383, 0x7F000000, 0x7F000000)
 gui.pixelText(1, 376, showInitialSeedInfoText and "7 - Hide Initial Seed info" or "8 - Show Initial Seed info")
end

function showInitialSeedInfo(delay)
 local delayOffset = mode[index] == "Pandora" and 43 or 21

 gui.drawBox(1, 192, 109, 248, 0x7F000000, 0x7F000000)
 gui.pixelText(1, 192, string.format("Next Initial Seed: %08X", buildSeedFromDelay(delay + delayOffset)))
 gui.pixelText(1, 199, string.format("Next Delay: %d", delay + delayOffset))
 gui.pixelText(1, 206, string.format("Delay: %d", delay))
 gui.pixelText(1, 220, string.format("Hit Delay: %d", hitDelay))
 gui.pixelText(1, 227, string.format("Hit Date/Hour:\n%s", hitDate))
end

function showDateTime()
 if mode[index] ~= "None" then
  gui.drawBox(214, 192, 254, 206, 0x7F000000, 0x7F000000)
  gui.pixelText(214, 192, string.format("%s/%s/20%s", dateTime["day"], dateTime["month"], dateTime["year"]))
  gui.pixelText(214, 199, string.format("%s:%s:%s", dateTime["hour"], dateTime["minute"], dateTime["second"]))
 end
end

local showRngInfoText = true

function showRngInfo()
 local currentSeed, mtAdvances, delay = getRngInfo()

 if showRngInfoText and mode[index] ~= "None" then
  gui.drawBox(1, 162, 89, 190, 0x7F000000, 0x7F000000)
  gui.pixelText(0, 162, string.format("Initial Seed: %08X", initialSeed))
  gui.pixelText(1, 169, string.format("Current Seed: %08X", currentSeed))
  gui.pixelText(1, 176, string.format("LCRNG Advances: %d", advances))
  gui.pixelText(1, 183, string.format("MT Advances: %d", mtAdvances))

  getInitialSeedInfoInput()

  if showInitialSeedInfoText then
   showInitialSeedInfo(delay)
   showDateTime()
  end
 end
end

function getRngInfoInput()
 local key = input.get()

 if key["Number6"] or key["Keypad6"] then
  showRngInfoText = true
 elseif key["Number5"] or key["Keypad5"] then
  showRngInfoText = false
 end

 gui.pixelText(110, 183, showRngInfoText and "5 - Hide RNG info" or "6 - Show RNG info")
end

function getTrainerIDs()
 local trainerIDsAddr = read32Bit(trainerIDsPointerAddr) + 0x8C
 local trainerIDs = read32Bit(trainerIDsAddr)
 local TID = trainerIDs & 0xFFFF
 local SID = trainerIDs >> 16

 return TID, SID
end

function showTrainerIDs()
 local trainerTID, trainerSID = getTrainerIDs()

 gui.pixelText(214, 176, string.format("TID: %d", trainerTID))
 gui.pixelText(214, 183, string.format("SID: %d", trainerSID))
end

local prevKeySlot, slotIndex = {}, 0

function getSlotInput()
 local leftSlotArrowColor = "gray"
 local rightSlotArrowColor = "gray"
 local key = input.get()

 if (key["Number3"] or key["Keypad3"]) and (not prevKeySlot["Keypad3"] and not prevKeySlot["Keypad3"]) then
  leftSlotArrowColor = "orange"
  slotIndex = slotIndex - 1 < 0 and 1 or slotIndex - 1
 elseif (key["Number4"] or key["Keypad4"]) and (not prevKeySlot["Keypad4"] and not prevKeySlot["Keypad4"]) then
  rightSlotArrowColor = "orange"
  slotIndex = slotIndex + 1 > 1 and 0 or slotIndex + 1
 end

 prevKeySlot = key
 gui.drawBox(182, 1, 254, 8, 0x7F000000, 0x7F000000)
 drawArrowLeft(183, 1, leftSlotArrowColor)
 gui.pixelText(191, 1, "3 - 4")
 drawArrowRight(219, 1, rightSlotArrowColor)
 gui.pixelText(226, 1, "Slot: "..slotIndex + 1)

 return slotIndex
end

function getOffset(offsetType, orderIndex)
 local offsets = {["growth"] = {0,0,0,0,0,0, 1,1,2,3,2,3, 1,1,2,3,2,3, 1,1,2,3,2,3},
                  ["attack"] = {1,1,2,3,2,3, 0,0,0,0,0,0, 2,3,1,1,3,2, 2,3,1,1,3,2}}

 return offsets[offsetType][orderIndex]
end

function shinyCheck(PID, trainerTID, trainerSID)
 trainerTID = trainerTID or nil
 trainerSID = trainerSID or nil

 if not trainerTID then
  trainerTID, trainerSID = getTrainerIDs()
 end

 local lowPID = PID & 0xFFFF
 local highPID = PID >> 16
 local shinyTypeValue = (trainerTID ~ trainerSID) ~ (lowPID ~ highPID)

 if shinyTypeValue < 8 then
  return "limegreen", shinyTypeValue == 0 and " (Square)" or " (Star)"
 end

 return nil, ""
end

function getBits(a, b, d)
 return (a >> b) % (1 << d)
end

function getIVs(ivsValue)
 local hpIV  = getBits(ivsValue, 0, 5)
 local atkIV = getBits(ivsValue, 5, 5)
 local defIV = getBits(ivsValue, 10, 5)
 local spdIV = getBits(ivsValue, 15, 5)
 local spAtkIV = getBits(ivsValue, 20, 5)
 local spDefIV = getBits(ivsValue, 25, 5)

 return hpIV, atkIV, defIV, spAtkIV, spDefIV, spdIV
end

function getHPTypeAndPower(hpIV, atkIV, defIV, spAtkIV, spDefIV, spdIV)
 local hpType = floor(((hpIV % 2) + 2 * (atkIV % 2) + 4 * (defIV % 2) + 8 * (spdIV % 2) + 16 * (spAtkIV % 2)
                + 32 * (spDefIV % 2)) * 15 / 63)
 local hpPower = 30 + floor((((hpIV >> 1) % 2) + 2 * ((atkIV >> 1) % 2) + 4 * ((defIV >> 1) % 2) + 8 * ((spdIV >> 1) % 2)
                 + 16 * ((spAtkIV >> 1) % 2) + 32 * ((spDefIV >> 1) % 2)) * 40 / 63)

 return hpType, hpPower
end

function getIVColor(value)
 if value >= 30 then
  return "limegreen"
 elseif value >= 1 and value <= 5 then
  return "orange"
 elseif value < 1 then
  return "red"
 end

 return nil  -- IV value from 6 to 29
end

function showIVsAndHP(ivsValue)
 local hpIV, atkIV, defIV, spAtkIV, spDefIV, spdIV = getIVs(ivsValue)
 local hpType, hpPower = getHPTypeAndPower(hpIV, atkIV, defIV, spAtkIV, spDefIV, spdIV)

 gui.pixelText(0, 36, "IVs:")
 gui.pixelText(20, 36, string.format("%02d", hpIV), getIVColor(hpIV))
 gui.pixelText(28, 36, "/")
 gui.pixelText(32, 36, string.format("%02d", atkIV), getIVColor(atkIV))
 gui.pixelText(40, 36, "/")
 gui.pixelText(44, 36, string.format("%02d", defIV), getIVColor(defIV))
 gui.pixelText(52, 36, "/")
 gui.pixelText(56, 36, string.format("%02d", spAtkIV), getIVColor(spAtkIV))
 gui.pixelText(64, 36, "/")
 gui.pixelText(68, 36, string.format("%02d", spDefIV), getIVColor(spDefIV))
 gui.pixelText(76, 36, "/")
 gui.pixelText(80, 36, string.format("%02d", spdIV), getIVColor(spdIV))

 gui.pixelText(1, 43, "HPower: "..HPTypeNamesList[hpType + 1].." "..hpPower)
end

function showMoves(moveIndexesList)
 gui.pixelText(1, 64, "Move: "..moveNamesList[moveIndexesList[1] > 468 and 1 or moveIndexesList[1]])
 gui.pixelText(1, 71, "Move: "..moveNamesList[moveIndexesList[2] > 468 and 1 or moveIndexesList[2]])
 gui.pixelText(1, 78, "Move: "..moveNamesList[moveIndexesList[3] > 468 and 1 or moveIndexesList[3]])
 gui.pixelText(1, 85, "Move: "..moveNamesList[moveIndexesList[4] > 468 and 1 or moveIndexesList[4]])
end

function showPP(movePPList)
 gui.pixelText(88, 64, "PP: "..(movePPList[1] < 100 and movePPList[1] or 0))
 gui.pixelText(88, 71, "PP: "..(movePPList[2] < 100 and movePPList[2] or 0))
 gui.pixelText(88, 78, "PP: "..(movePPList[3] < 100 and movePPList[3] or 0))
 gui.pixelText(88, 85, "PP: "..(movePPList[4] < 100 and movePPList[4] or 0))
end

function showPokemonIDs(trainerTID, trainerSID)
 gui.pixelText(214, 176, string.format("TID: %d", trainerTID))
 gui.pixelText(214, 183, string.format("SID: %d", trainerSID))
end

function showInfo(pidAddr)
 local pokemonPID = read32Bit(pidAddr)
 local checksum = read16Bit(pidAddr + 0x6)
 local orderIndex = (((pokemonPID & 0x3E000) >> 0xD) % 24) + 1
 local move = {}
 local movePP = {}
 local ivsPart = {}

 local growthOffset = getOffset("growth", orderIndex) * 32
 local attacksOffset = getOffset("attack", orderIndex) * 32
 local prng = checksum

 for i = 1, getOffset("growth", orderIndex) do
  prng = LCRNG(prng, 0x5F748241, 0xCBA72510)  -- 16 cycles
 end

 prng = LCRNG(prng, 0x41C64E6D, 0x6073)
 local speciesDexIndex = read16Bit(pidAddr + growthOffset + 0x8) ~ (prng >> 16)

 prng = LCRNG(prng, 0x41C64E6D, 0x6073)
 local heldItemIndex = (read16Bit(pidAddr + growthOffset + 0xA) ~ (prng >> 16)) + 1

 local OTID, OTSID = nil, nil

 if mode[index] == "Pokemon Info" then
  prng = LCRNG(prng, 0x41C64E6D, 0x6073)
  OTID = read16Bit(pidAddr + growthOffset + 0xC) ~ (prng >> 16)
  prng = LCRNG(prng, 0x41C64E6D, 0x6073)
  OTSID = read16Bit(pidAddr + growthOffset + 0xE) ~ (prng >> 16)
 else
  prng = LCRNG(prng, 0xC2A29A69, 0xE97E7B6A)  -- 2 cycles
 end

 local shinyTypeTextColor, shinyType = shinyCheck(pokemonPID, OTID, OTSID)

 prng = LCRNG(prng, 0x807DBCB5, 0x52713895)  -- 3 cycles
 local abilityIndex = read16Bit(pidAddr + growthOffset + 0x14) ~ (prng >> 16)
 abilityIndex = getBits(abilityIndex, 8, 8)

 prng = checksum

 for i = 1, getOffset("attack", orderIndex) do
  prng = LCRNG(prng, 0x5F748241, 0xCBA72510)  -- 16 cycles
 end

 prng = LCRNG(prng, 0x41C64E6D, 0x6073)
 move[1] = (read16Bit(pidAddr + attacksOffset + 0x8) ~ (prng >> 16)) + 1
 prng = LCRNG(prng, 0x41C64E6D, 0x6073)
 move[2] = (read16Bit(pidAddr + attacksOffset + 0xA) ~ (prng >> 16)) + 1
 prng = LCRNG(prng, 0x41C64E6D, 0x6073)
 move[3] = (read16Bit(pidAddr + attacksOffset + 0xC) ~ (prng >> 16)) + 1
 prng = LCRNG(prng, 0x41C64E6D, 0x6073)
 move[4] = (read16Bit(pidAddr + attacksOffset + 0xE) ~ (prng >> 16)) + 1

 prng = LCRNG(prng, 0x41C64E6D, 0x6073)
 local movePPAux = read16Bit(pidAddr + attacksOffset + 0x10) ~ (prng >> 16)
 movePP[1] = getBits(movePPAux, 0, 8)
 movePP[2] = getBits(movePPAux, 8, 8)
 prng = LCRNG(prng, 0x41C64E6D, 0x6073)
 movePPAux = read16Bit(pidAddr + attacksOffset + 0x12) ~ (prng >> 16)
 movePP[3] = getBits(movePPAux, 0, 8)
 movePP[4] = getBits(movePPAux, 8, 8)

 prng = LCRNG(prng, 0x807DBCB5, 0x52713895)  -- 3 cycles
 ivsPart[1] = read16Bit(pidAddr + attacksOffset + 0x18) ~ (prng >> 16)
 prng = LCRNG(prng, 0x41C64E6D, 0x6073)
 ivsPart[2] = read16Bit(pidAddr + attacksOffset + 0x1A) ~ (prng >> 16)
 local ivsValue = (ivsPart[2] << 16) + ivsPart[1]

 local isEgg = getBits(ivsValue, 30, 1) == 1
 local natureIndex = (pokemonPID % 25) + 1

 if mode[index] ~= "Breeding" or isEgg then
  gui.pixelText(1, 8, "Species: "..speciesNamesList[(speciesDexIndex > 493 or speciesDexIndex < 1) and 1 or speciesDexIndex])
  gui.pixelText(1, 15, "PID:")
  gui.pixelText(21, 15, string.format("%08X%s", pokemonPID, shinyType), shinyTypeTextColor)
  gui.pixelText(1, 22, "Nature: "..natureNamesList[(natureIndex > 25 or natureIndex == nil) and 1 or natureIndex])
  gui.pixelText(1, 29, string.format("Ability: %s (%s)", abilityNamesList[(abilityIndex > 123 or abilityIndex < 1) and 1 or abilityIndex],
                abilityIndex == pokemonAbilities[(speciesDexIndex > 493 or speciesDexIndex < 1) and 1 or speciesDexIndex][1] and "0" or "1"))

  showIVsAndHP(ivsValue)

  gui.pixelText(1, 50, "Held item: "..itemNamesList[(heldItemIndex > 537) and 1 or heldItemIndex])

  showMoves(move)
  showPP(movePP)

  if mode[index] == "Pokemon Info" then
   showPokemonIDs(OTID, OTSID)
  end
 end
end

function showPartyEggInfo(pidAddr)
 local partyAddr = pidAddr + 0xD094
 local partySlotsCounterAddr = pidAddr + 0xD090
 local partySlotsCounter = read8Bit(partySlotsCounterAddr) - 1
 local lastPartySlotAddr = partyAddr + (partySlotsCounter * 0xEC)

 showInfo(lastPartySlotAddr)
end

local prevKeyRoamerSlot, roamerSlotIndex = {}, 0

function getRoamerSlotInput()
 local leftRoamerSlotArrowColor = "gray"
 local rightRoamerSlotArrowColor = "gray"
 local key = input.get()

 if (key["Number3"] or key["Keypad3"]) and (not prevKeyRoamerSlot["Keypad3"] and not prevKeyRoamerSlot["Keypad3"]) then
  leftRoamerSlotArrowColor = "orange"
  roamerSlotIndex = roamerSlotIndex - 1 < 0 and 4 or roamerSlotIndex - 1
 elseif (key["Number4"] or key["Keypad4"]) and (not prevKeyRoamerSlot["Keypad4"] and not prevKeyRoamerSlot["Keypad4"]) then
  rightRoamerSlotArrowColor = "orange"
  roamerSlotIndex = roamerSlotIndex + 1 > 4 and 0 or roamerSlotIndex + 1
 end

 prevKeyRoamerSlot = key
 gui.drawBox(182, 1, 254, 8, 0x7F000000, 0x7F000000)
 drawArrowLeft(183, 1, leftRoamerSlotArrowColor)
 gui.pixelText(191, 1, "3 - 4")
 drawArrowRight(219, 1, rightRoamerSlotArrowColor)
 gui.pixelText(226, 1, "Slot: "..roamerSlotIndex + 1)

 return roamerSlotIndex > 1 and roamerSlotIndex + 1 or roamerSlotIndex
end

function getRoamerInfo(roamerAddr)
 local isRoamerActive = read8Bit(roamerAddr + 0x12) == 1

 if isRoamerActive then
  local roamerMapIndex = read16Bit(roamerAddr)
  local roamerIVsValue = read32Bit(roamerAddr + 0x4)
  local roamerPID = read32Bit(roamerAddr + 0x8)
  local roamerShinyTypeTextColor, roamerShinyType = shinyCheck(roamerPID)
  local roamerSpeciesIndex = read16Bit(roamerAddr + 0xC)
  local roamerHP = read16Bit(roamerAddr + 0xE)
  local roamerLevel = read8Bit(roamerAddr + 0x10)
  local roamerStatusIndex = read8Bit(roamerAddr + 0x11)
  local roamerStatus = statusConditionNamesList[1]  -- No altered status condition by default
  local roamerNatureIndex = (roamerPID % 25) + 1

  local playerMapIndexAddr = read32Bit(trainerIDsPointerAddr) + 0x1294
  local playerMapIndex = read16Bit(playerMapIndexAddr)

  if roamerStatusIndex > 0 and roamerStatusIndex < 0x8 then  -- Check altered status condition
   roamerStatus = statusConditionNamesList[2]
  elseif roamerStatusIndex == 0x8 then
   roamerStatus = statusConditionNamesList[3]
  elseif roamerStatusIndex == 0x10 then
   roamerStatus = statusConditionNamesList[4]
  elseif roamerStatusIndex == 0x20 then
   roamerStatus = statusConditionNamesList[5]
  elseif roamerStatusIndex == 0x40 then
   roamerStatus = statusConditionNamesList[6]
  elseif roamerStatusIndex == 0x80 then
   roamerStatus = statusConditionNamesList[7]
  end

  return isRoamerActive, roamerPID, (roamerSpeciesIndex > 493 or roamerSpeciesIndex < 1) and 1 or roamerSpeciesIndex, roamerShinyType,
         roamerShinyTypeTextColor, (roamerNatureIndex > 25 or roamerNatureIndex == nil) and 1 or roamerNatureIndex, roamerIVsValue, roamerLevel, roamerHP,
         roamerStatus, roamerMapIndex, playerMapIndex
 end

 return nil
end

function showRoamerInfo(roamerAddr)
 local isRoamerActive, roamerPID, roamerSpeciesIndex, roamerShinyType, roamerShinyTypeTextColor, roamerNatureIndex,
       roamerIVsValue, roamerLevel, roamerHP, roamerStatus, roamerMapIndex, playerMapIndex = getRoamerInfo(roamerAddr)

 if isRoamerActive then
  gui.pixelText(1, 8, "Active Roamer? Yes")
  gui.pixelText(1, 15, "Species: "..speciesNamesList[roamerSpeciesIndex])
  gui.pixelText(1, 22, "PID:")
  gui.pixelText(21, 22, string.format("%08X%s", roamerPID, roamerShinyType), roamerShinyTypeTextColor)
  gui.pixelText(1, 29, "Nature: "..natureNamesList[roamerNatureIndex])
  showIVsAndHP(roamerIVsValue)
  gui.pixelText(1, 50, "Level: "..roamerLevel)
  gui.pixelText(1, 57, "HP: "..roamerHP)
  gui.pixelText(1, 64, "Status condition: "..roamerStatus)
  gui.pixelText(1, 71, "Current position:")
  gui.pixelText(1, 78, locationNamesList[roamerMapIndex + 1], roamerMapIndex == playerMapIndex and "limegreen" or nil)
 else
  gui.pixelText(1, 8, "Active Roamer? No")
 end
end

local prevKeyInfo, infoIndex, infoMode = {}, 1, {"Gift", "Party", "Party Stats", "Box", "Box Stats"}

function getInfoInput()
 local leftInfoArrowColor = "gray"
 local rightInfoArrowColor = "gray"
 key = input.get()

 if (key["Number3"] or key["Keypad3"]) and (not prevKeyInfo["Number3"] and not prevKeyInfo["Keypad3"]) then
  leftInfoArrowColor = "orange"
  infoIndex = infoIndex - 1 < 1 and 5 or infoIndex - 1
 elseif (key["Number4"] or key["Keypad4"]) and (not prevKeyInfo["Number4"] and not prevKeyInfo["Keypad4"]) then
  rightInfoArrowColor = "orange"
  infoIndex = infoIndex + 1 > 5 and 1 or infoIndex + 1
 end

 prevKeyInfo = key
 gui.drawBox(167, 1, 254, 16, 0x7F000000, 0x7F000000)
 gui.pixelText(166, 1, "Info Mode: "..infoMode[infoIndex])
 drawArrowLeft(217, 9, leftInfoArrowColor)
 gui.pixelText(225, 9, "3 - 4")
 drawArrowRight(253, 9, rightInfoArrowColor)
end

function showPokemonInfo(pidAddr)
 local partyAddr = pidAddr + 0xD094
 local boxAddr = pidAddr + 0x19F24
 local currBoxIndexAddr = pidAddr + 0x19F20
 local currBoxIndex = read8Bit(currBoxIndexAddr)

 if infoMode[infoIndex] == "Gift" then
  local partySlotsCounterAddr = pidAddr + 0xD090
  local partySlotsCounter = read8Bit(partySlotsCounterAddr) - 1
  local lastPartySlotAddr = partyAddr + (partySlotsCounter * 0xEC)

  showInfo(lastPartySlotAddr)
 elseif infoMode[infoIndex] == "Party" then
  local partySelectedSlotIndexAddr = pidAddr + 0x4F379 + koreanOffset
  local partySelectedSlotIndex = read8Bit(partySelectedSlotIndexAddr)
  local partySelectedPokemonAddr = partyAddr + (partySelectedSlotIndex * 0xEC)

  showInfo(partySelectedPokemonAddr)
 elseif infoMode[infoIndex] == "Party Stats" then
  local partyStatsSelectedSlotIndexAddr = pidAddr + 0x35558 + koreanOffset
  local partyStatsSelectedSlotIndex = read8Bit(partyStatsSelectedSlotIndexAddr)
  local pokemonPartyStatsAddr = partyAddr + (partyStatsSelectedSlotIndex * 0xEC)

  showInfo(pokemonPartyStatsAddr)
 elseif infoMode[infoIndex] == "Box" then
  local boxSelectedSlotIndexAddr = pidAddr + 0x4E7EB + koreanOffset
  local boxSelectedSlotIndex = read8Bit(boxSelectedSlotIndexAddr)
  local boxSelectedPokemonAddr = boxAddr + (0x88 * boxSelectedSlotIndex) + ((0xFF0 * currBoxIndex))

  showInfo(boxSelectedPokemonAddr)
 elseif infoMode[infoIndex] == "Box Stats" then
  local boxStatsSelectedSlotIndexAddr = pidAddr + 0x4E91C + koreanOffset
  local boxStatsSelectedSlotIndex = read8Bit(boxStatsSelectedSlotIndexAddr)
  local pokemonBoxStatsAddr = boxAddr + (0x88 * boxStatsSelectedSlotIndex) + ((0xFF0 * currBoxIndex))

  showInfo(pokemonBoxStatsAddr)
 end
end

function setSaveStateValues()
 local prevInitialSeed = initialSeed
 initialSeed = userdata.get("initialSeed")
 tempCurrentSeed = userdata.get("tempCurrentSeed")
 advances = userdata.get("advances")
 mtCounter = userdata.get("mtCounter")
 hitDelay = userdata.get("hitDelay")
 hitDate = userdata.get("hitDate")
 lastCurrentSeedBeforeBattle = userdata.get("lastCurrentSeedBeforeBattle")
 battleStartJump = userdata.get("battleStartJump")
 prevMTSeed = read32Bit(mtSeedAddr)

 if prevInitialSeed ~= initialSeed then
  printGameInfo()

  if initialSeed ~= 0 then
   print(string.format("Initial Seed: %08X", initialSeed))
  end
 end
end

event.onloadstate(setSaveStateValues)

while not wrongGameVersion do
 setBackgroundBoxes()
 setDateTime()
 getTabInput()
 showRngInfo()
 local pidAddr = read32Bit(pidPointerAddr)

 if mode[index] ~= "None" then
  getRngInfoInput()

  if mode[index] ~= "Pokemon Info" then
   showTrainerIDs()
  end
 end

 if mode[index] == "Capture" then
  local enemyAddr = pidAddr + 0x58E3C + koreanOffset
  showInfo(enemyAddr + (0xEC * getSlotInput()))
 elseif mode[index] == "Breeding" then
  showPartyEggInfo(pidAddr)
 elseif mode[index] == "Roamer" then
  local roamerAddr = pidAddr + 0x14FE8
  showRoamerInfo(roamerAddr + (0x14 * getRoamerSlotInput()))
 elseif mode[index] == "Pokemon Info" then
  getInfoInput()
  showPokemonInfo(pidAddr)
 end

 emu.frameadvance()
end