read32Bit = memory.read_u32_le
read16Bit = memory.read_u16_le
read8Bit = memory.readbyte
floor = math.floor

local JUMP_DATA = {
 {0x6C078965, 0x269EC3}, {0x54341D9, 0x55AE9CB2}, {0x285E9F1, 0xC910A194}, {0xAE3294E1, 0x4EAC71E8},
 {0x5A78EDC1, 0x1566AED0}, {0x75BEEB81, 0x592709A0}, {0x56221701, 0x6068C340}, {0xCA552E01, 0x98DC4680},
 {0x28EE5C01, 0x2EE38D00}, {0x82ECB801, 0x3A731A00}, {0xCA197001, 0x27963400}, {0xA532E001, 0x19EC6800},
 {0x8E65C001, 0x5ED8D000}, {0x2CCB8001, 0x69B1A000}, {0x99970001, 0x83634000}, {0x332E0001, 0xC6C68000},
 {0x665C0001, 0x8D8D0000}, {0xCCB80001, 0x1B1A0000}, {0x99700001, 0x36340000}, {0x32E00001, 0x6C680000},
 {0x65C00001, 0xD8D00000}, {0xCB800001, 0xB1A00000}, {0x97000001, 0x63400000}, {0x2E000001, 0xC6800000},
 {0x5C000001, 0x8D000000}, {0xB8000001, 0x1A000000}, {0x70000001, 0x34000000}, {0xE0000001, 0x68000000},
 {0xC0000001, 0xD0000000}, {0x80000001, 0xA0000000}, {0x1, 0x40000000}, {0x1, 0x80000000}}

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
 "Regigigas", "Giratina", "Cresselia", "Phione", "Manaphy", "Darkrai", "Shaymin", "Arceus",
 -- Gen 5
 "Victini", "Snivy", "Servine", "Serperior", "Tepig", "Pignite", "Emboar", "Oshawott", "Dewott", "Samurott", "Patrat",
 "Watchog", "Lillipup", "Herdier", "Stoutland", "Purrloin", "Liepard", "Pansage", "Simisage", "Pansear", "Simisear",
 "Panpour", "Simipour", "Munna", "Musharna", "Pidove", "Tranquill", "Unfezant", "Blitzle", "Zebstrika", "Roggenrola",
 "Boldore", "Gigalith", "Woobat", "Swoobat", "Drilbur", "Excadrill", "Audino", "Timburr", "Gurdurr", "Conkeldurr",
 "Tympole", "Palpitoad", "Seismitoad", "Throh", "Sawk", "Sewaddle", "Swadloon", "Leavanny", "Venipede", "Whirlipede",
 "Scolipede", "Cottonee", "Whimsicott", "Petilil", "Lilligant", "Basculin", "Sandile", "Krokorok", "Krookodile",
 "Darumaka", "Darmanitan", "Maractus", "Dwebble", "Crustle", "Scraggy", "Scrafty", "Sigilyph", "Yamask", "Cofagrigus",
 "Tirtouga", "Carracosta", "Archen", "Archeops", "Trubbish", "Garbodor", "Zorua", "Zoroark", "Minccino", "Cinccino",
 "Gothita", "Gothorita", "Gothitelle", "Solosis", "Duosion", "Reuniclus", "Ducklett", "Swanna", "Vanillite", "Vanillish",
 "Vanilluxe", "Deerling", "Sawsbuck", "Emolga", "Karrablast", "Escavalier", "Foongus", "Amoonguss", "Frillish", "Jellicent",
 "Alomomola", "Joltik", "Galvantula", "Ferroseed", "Ferrothorn", "Klink", "Klang", "Klinklang", "Tynamo", "Eelektrik",
 "Eelektross", "Elgyem", "Beheeyem", "Litwick", "Lampent", "Chandelure", "Axew", "Fraxure", "Haxorus", "Cubchoo", "Beartic",
 "Cryogonal", "Shelmet", "Accelgor", "Stunfisk", "Mienfoo", "Mienshao", "Druddigon", "Golett", "Golurk", "Pawniard",
 "Bisharp", "Bouffalant", "Rufflet", "Braviary", "Vullaby", "Mandibuzz", "Heatmor", "Durant", "Deino", "Zweilous",
 "Hydreigon", "Larvesta", "Volcarona", "Cobalion", "Terrakion", "Virizion", "Tornadus", "Thundurus", "Reshiram", "Zekrom",
 "Landorus", "Kyurem", "Keldeo", "Meloetta", "Genesect"}

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
 "Multitype", "Flower Gift", "Bad Dreams",
 -- Gen 5
 "Pickpocket", "Sheer Force", "Contrary", "Unnerve", "Defiant", "Defeatist", "Cursed Body", "Healer", "Friend Guard",
 "Weak Armor", "Heavy Metal", "Light Metal", "Multiscale", "Toxic Boost", "Flare Boost", "Harvest", "Telepathy", "Moody",
 "Overcoat", "Poison Touch", "Regenerator", "Big Pecks", "Sand Rush", "Wonder Skin", "Analytic", "Illusion", "Imposter",
 "Infiltrator", "Mummy", "Moxie", "Justified", "Rattled", "Magic Bounce", "Sap Sipper", "Prankster", "Sand Force",
 "Iron Barbs", "Zen Mode", "Victory Star", "Turboblaze", "Teravolt"}

local pokemonAbilities = {
 [1] = {65, 34}, [2] = {65, 34}, [3] = {65, 34}, [4] = {66, 94}, [5] = {66, 94}, [6] = {66, 94}, [7] = {67, 44}, [8] = {67, 44},
 [9] = {67, 44}, [10] = {19, 50}, [11] = {61, 61}, [12] = {14, 110}, [13] = {19, 50}, [14] = {61, 61}, [15] = {68, 97}, [16] = {51, 77, 145},
 [17] = {51, 77, 145}, [18] = {51, 77, 145}, [19] = {50, 62, 55}, [20] = {50, 62, 55}, [21] = {51, 97}, [22] = {51, 97}, [23] = {22, 61, 127},
 [24] = {22, 61, 127}, [25] = {9, 31}, [26] = {9, 31}, [27] = {8, 146}, [28] = {8, 146}, [29] = {38, 79, 55}, [30] = {38, 79, 55}, [31] = {38, 79, 125},
 [32] = {38, 79, 55}, [33] = {38, 79, 55}, [34] = {38, 79, 125}, [35] = {56, 98, 132}, [36] = {56, 98, 109}, [37] = {18, 70}, [38] = {18, 70},
 [39] = {56, 132}, [40] = {56, 119}, [41] = {39, 151}, [42] = {39, 151}, [43] = {34, 50}, [44] = {34, 1}, [45] = {34, 27}, [46] = {27, 87, 6},
 [47] = {27, 87, 6}, [48] = {14, 110, 50}, [49] = {19, 110, 147}, [50] = {8, 71, 159}, [51] = {8, 71, 159}, [52] = {53, 101, 127}, [53] = {7, 101, 127},
 [54] = {6, 13, 33}, [55] = {6, 13, 33}, [56] = {72, 83, 128}, [57] = {72, 83, 128}, [58] = {22, 18, 154}, [59] = {22, 18, 154}, [60] = {11, 6, 33},
 [61] = {11, 6, 33}, [62] = {11, 6, 33}, [63] = {28, 39, 98}, [64] = {28, 39, 98}, [65] = {28, 39, 98}, [66] = {62, 99, 80}, [67] = {62, 99, 80},
 [68] = {62, 99, 80}, [69] = {34, 82}, [70] = {34, 82}, [71] = {34, 82}, [72] = {29, 64, 44}, [73] = {29, 64, 44}, [74] = {69, 5, 8}, [75] = {69, 5, 8},
 [76] = {69, 5, 8}, [77] = {50, 18, 49}, [78] = {50, 18, 49}, [79] = {12, 20, 144}, [80] = {12, 20, 144}, [81] = {42, 5, 148}, [82] = {42, 5, 148},
 [83] = {51, 39, 128}, [84] = {50, 48, 77}, [85] = {50, 48, 77}, [86] = {47, 93, 115}, [87] = {47, 93, 115}, [88] = {1, 60, 143}, [89] = {1, 60, 143},
 [90] = {75, 92, 142}, [91] = {75, 92, 142}, [92] = {26}, [93] = {26}, [94] = {26}, [95] = {69, 5, 133}, [96] = {15, 108, 39}, [97] = {15, 108, 39},
 [98] = {52, 75, 125}, [99] = {52, 75, 125}, [100] = {43, 9, 106}, [101] = {43, 9, 106}, [102] = {34, 139}, [103] = {34, 139}, [104] = {69, 31, 4},
 [105] = {69, 31, 4}, [106] = {7, 120, 84}, [107] = {51, 89, 39}, [108] = {20, 12, 13}, [109] = {26}, [110] = {26}, [111] = {31, 69, 120}, [112] = {31, 69, 120},
 [113] = {30, 32, 131}, [114] = {34, 102, 144}, [115] = {48, 113, 39}, [116] = {33, 97, 6}, [117] = {38, 97, 6}, [118] = {33, 41, 31}, [119] = {33, 41, 31},
 [120] = {35, 30, 148}, [121] = {35, 30, 148}, [122] = {43, 111, 101}, [123] = {68, 101, 80}, [124] = {12, 108, 87}, [125] = {9, 72}, [126] = {49, 72},
 [127] = {52, 104, 153}, [128] = {22, 83, 125}, [129] = {33, 155}, [130] = {22, 153}, [131] = {11, 75, 93}, [132] = {7, 150}, [133] = {50, 91, 107},
 [134] = {11, 11, 93}, [135] = {10, 10, 95}, [136] = {18, 18, 62}, [137] = {36, 88, 148}, [138] = {33, 75, 133}, [139] = {33, 75, 133}, [140] = {33, 4, 133},
 [141] = {33, 4, 133}, [142] = {69, 46, 127}, [143] = {17, 47, 82}, [144] = {46, 81}, [145] = {46, 31}, [146] = {46, 49}, [147] = {61, 63}, [148] = {61, 63},
 [149] = {39, 136}, [150] = {46, 127}, [151] = {28}, [152] = {65, 102}, [153] = {65, 102}, [154] = {65, 102}, [155] = {66, 18}, [156] = {66, 18}, [157] = {66, 18},
 [158] = {67, 125}, [159] = {67, 125}, [160] = {67, 125}, [161] = {50, 51, 119}, [162] = {50, 51, 119}, [163] = {15, 51, 110}, [164] = {15, 51, 110},
 [165] = {68, 48, 155}, [166] = {68, 48, 89}, [167] = {68, 15, 97}, [168] = {68, 15, 97}, [169] = {39, 151}, [170] = {10, 35, 11}, [171] = {10, 35, 11}, [172] = {9, 31},
 [173] = {56, 98, 132}, [174] = {56, 132}, [175] = {55, 32, 105}, [176] = {55, 32, 105}, [177] = {28, 48, 156}, [178] = {28, 48, 156}, [179] = {9, 57},
 [180] = {9, 57}, [181] = {9, 57}, [182] = {34, 131}, [183] = {47, 37, 157}, [184] = {47, 37, 157}, [185] = {5, 69, 155}, [186] = {11, 6, 2}, [187] = {34, 102, 151},
 [188] = {34, 102, 151}, [189] = {34, 102, 151}, [190] = {50, 53, 92}, [191] = {34, 94, 48}, [192] = {34, 94, 48}, [193] = {3, 14, 119}, [194] = {6, 11, 109},
 [195] = {6, 11, 109}, [196] = {28, 28, 156}, [197] = {28, 28, 39}, [198] = {15, 105, 158}, [199] = {12, 20, 144}, [200] = {26}, [201] = {26}, [202] = {23, 140},
 [203] = {39, 48, 157}, [204] = {5, 142}, [205] = {5, 142}, [206] = {32, 50, 155}, [207] = {52, 8, 17}, [208] = {69, 5, 125}, [209] = {22, 50, 155},
 [210] = {22, 95, 155}, [211] = {38, 33, 22}, [212] = {68, 101, 135}, [213] = {5, 82, 126}, [214] = {68, 62, 153}, [215] = {39, 51, 124}, [216] = {53, 95, 118},
 [217] = {62, 95, 127}, [218] = {40, 49, 133}, [219] = {40, 49, 133}, [220] = {12, 81, 47}, [221] = {12, 81, 47}, [222] = {55, 30, 144}, [223] = {55, 97, 141},
 [224] = {21, 97, 141}, [225] = {72, 55, 15}, [226] = {33, 11, 41}, [227] = {51, 5, 133}, [228] = {48, 18, 127}, [229] = {48, 18, 127}, [230] = {33, 97, 6},
 [231] = {53, 8}, [232] = {5, 8}, [233] = {36, 88, 148}, [234] = {22, 119, 157}, [235] = {20, 101, 141}, [236] = {62, 80, 72}, [237] = {22, 101, 80},
 [238] = {12, 108, 93}, [239] = {9, 72}, [240] = {49, 72}, [241] = {47, 113, 157}, [242] = {30, 32, 131}, [243] = {46, 10}, [244] = {46, 18}, [245] = {46, 11},
 [246] = {62, 8}, [247] = {61, 61}, [248] = {45, 127}, [249] = {46, 136}, [250] = {46, 144}, [251] = {30}, [252] = {65, 84}, [253] = {65, 84}, [254] = {65, 84},
 [255] = {66, 3}, [256] = {66, 3}, [257] = {66, 3}, [258] = {67, 6}, [259] = {67, 6}, [260] = {67, 6}, [261] = {50, 95, 155}, [262] = {22, 95, 153},
 [263] = {53, 82, 95}, [264] = {53, 82, 95}, [265] = {19, 50}, [266] = {61, 61}, [267] = {68, 79}, [268] = {61, 61}, [269] = {19, 14}, [270] = {33, 44, 20},
 [271] = {33, 44, 20}, [272] = {33, 44, 20}, [273] = {34, 48, 124}, [274] = {34, 48, 124}, [275] = {34, 48, 124}, [276] = {62, 113}, [277] = {62, 113},
 [278] = {51, 44}, [279] = {51, 44}, [280] = {28, 36, 140}, [281] = {28, 36, 140}, [282] = {28, 36, 140}, [283] = {33, 44}, [284] = {22, 127}, [285] = {27, 90, 95},
 [286] = {27, 90, 101}, [287] = {54}, [288] = {72}, [289] = {54}, [290] = {14, 50}, [291] = {3, 151}, [292] = {25, 25}, [293] = {43, 155}, [294] = {43, 113},
 [295] = {43, 113}, [296] = {47, 62, 125}, [297] = {47, 62, 125}, [298] = {47, 37, 157}, [299] = {5, 42, 159}, [300] = {56, 96, 147}, [301] = {56, 96, 147},
 [302] = {51, 100, 158}, [303] = {52, 22, 125}, [304] = {5, 69, 134}, [305] = {5, 69, 134}, [306] = {5, 69, 134}, [307] = {74, 140}, [308] = {74, 140},
 [309] = {9, 31, 58}, [310] = {9, 31, 58}, [311] = {57}, [312] = {58}, [313] = {35, 68, 158}, [314] = {12, 110, 158}, [315] = {30, 38, 102}, [316] = {64, 60, 82},
 [317] = {64, 60, 82}, [318] = {24, 3}, [319] = {24, 3}, [320] = {41, 12, 46}, [321] = {41, 12, 46}, [322] = {12, 86, 20}, [323] = {40, 116, 83}, [324] = {73, 75},
 [325] = {47, 20, 82}, [326] = {47, 20, 82}, [327] = {20, 77, 126}, [328] = {52, 71, 125}, [329] = {26, 26, 26}, [330] = {26, 26, 26}, [331] = {8, 11}, [332] = {8, 11},
 [333] = {30, 13}, [334] = {30, 13}, [335] = {17, 137}, [336] = {61, 151}, [337] = {26}, [338] = {26}, [339] = {12, 107, 93}, [340] = {12, 107, 93}, [341] = {52, 75, 91},
 [342] = {52, 75, 91}, [343] = {26}, [344] = {26}, [345] = {21, 114}, [346] = {21, 114}, [347] = {4, 33}, [348] = {4, 33}, [349] = {33, 91}, [350] = {63, 56},
 [351] = {59}, [352] = {16}, [353] = {15, 119, 130}, [354] = {15, 119, 130}, [355] = {26}, [356] = {46}, [357] = {34, 94, 139}, [358] = {26}, [359] = {46, 105, 154},
 [360] = {23, 140}, [361] = {39, 115, 141}, [362] = {39, 115, 141}, [363] = {47, 115, 12}, [364] = {47, 115, 12}, [365] = {47, 115, 12}, [366] = {75, 155},
 [367] = {33, 41}, [368] = {33, 93}, [369] = {33, 69, 5}, [370] = {33, 93}, [371] = {69, 125}, [372] = {69, 142}, [373] = {22, 153}, [374] = {29, 135}, [375] = {29, 135},
 [376] = {29, 135}, [377] = {29, 5}, [378] = {29, 115}, [379] = {29, 135}, [380] = {26}, [381] = {26}, [382] = {2}, [383] = {70}, [384] = {76}, [385] = {32}, [386] = {46},
 [387] = {65, 75}, [388] = {65, 75}, [389] = {65, 75}, [390] = {66, 89}, [391] = {66, 89}, [392] = {66, 89}, [393] = {67, 128}, [394] = {67, 128}, [395] = {67, 128},
 [396] = {51, 51}, [397] = {22, 120}, [398] = {22, 120}, [399] = {86, 109, 141}, [400] = {86, 109, 141}, [401] = {61, 50}, [402] = {68, 101}, [403] = {79, 22, 62},
 [404] = {79, 22, 62}, [405] = {79, 22, 62}, [406] = {30, 38, 102}, [407] = {30, 38, 101}, [408] = {104, 125}, [409] = {104, 125}, [410] = {5, 43}, [411] = {5, 43},
 [412] = {61, 142}, [413] = {107, 142}, [414] = {68, 110}, [415] = {118, 55}, [416] = {46, 127}, [417] = {50, 53, 10}, [418] = {33, 41}, [419] = {33, 41}, [420] = {34},
 [421] = {122}, [422] = {60, 114, 159}, [423] = {60, 114, 159}, [424] = {101, 53, 92}, [425] = {106, 84, 138}, [426] = {106, 84, 138}, [427] = {50, 103, 7},
 [428] = {56, 103, 7}, [429] = {26}, [430] = {15, 105, 153}, [431] = {7, 20, 51}, [432] = {47, 20, 128}, [433] = {26}, [434] = {1, 106, 51}, [435] = {1, 106, 51},
 [436] = {26, 85, 134}, [437] = {26, 85, 134}, [438] = {5, 69, 155}, [439] = {43, 111, 101}, [440] = {30, 32, 132}, [441] = {51, 77, 145}, [442] = {46, 151},
 [443] = {8, 24}, [444] = {8, 24}, [445] = {8, 24}, [446] = {53, 47, 82}, [447] = {80, 39, 158}, [448] = {80, 39, 154}, [449] = {45, 159}, [450] = {45, 159},
 [451] = {4, 97, 51}, [452] = {4, 97, 51}, [453] = {107, 87, 143}, [454] = {107, 87, 143}, [455] = {26}, [456] = {33, 114, 41}, [457] = {33, 114, 41},
 [458] = {33, 11, 41}, [459] = {117, 43}, [460] = {117, 43}, [461] = {46, 46, 124}, [462] = {42, 5, 148}, [463] = {20, 12, 13}, [464] = {31, 116, 120},
 [465] = {34, 102, 144}, [466] = {78, 72}, [467] = {49, 72}, [468] = {55, 32, 105}, [469] = {3, 110, 119}, [470] = {102, 102, 34}, [471] = {81, 81, 115},
 [472] = {52, 8, 90}, [473] = {12, 81, 47}, [474] = {91, 88, 148}, [475] = {80, 80, 154}, [476] = {5, 42, 159}, [477] = {46}, [478] = {81, 81, 130}, [479] = {26},
 [480] = {26}, [481] = {26}, [482] = {26}, [483] = {46, 140}, [484] = {46, 140}, [485] = {18, 49}, [486] = {112}, [487] = {46, 140}, [488] = {26}, [489] = {93},
 [490] = {93}, [491] = {123}, [492] = {30}, [493] = {121}, [494] = {162}, [495] = {65, 65, 126}, [496] = {65, 65, 126}, [497] = {65, 65, 126}, [498] = {66, 66, 47},
 [499] = {66, 66, 47}, [500] = {66, 66, 120}, [501] = {67, 67, 75}, [502] = {67, 67, 75}, [503] = {67, 67, 75}, [504] = {50, 51, 148}, [505] = {35, 51, 148},
 [506] = {72, 53, 50}, [507] = {22, 146, 113}, [508] = {22, 146, 113}, [509] = {7, 84, 158}, [510] = {7, 84, 158}, [511] = {82, 65}, [512] = {82, 65}, [513] = {82, 66},
 [514] = {82, 66}, [515] = {82, 67}, [516] = {82, 67}, [517] = {108, 28, 140}, [518] = {108, 28, 140}, [519] = {145, 105, 79}, [520] = {145, 105, 79},
 [521] = {145, 105, 79}, [522] = {31, 78, 157}, [523] = {31, 78, 157}, [524] = {5, 159}, [525] = {5, 159}, [526] = {5, 159}, [527] = {109, 103, 86},
 [528] = {109, 103, 86}, [529] = {146, 159, 104}, [530] = {146, 159, 104}, [531] = {131, 144, 103}, [532] = {62, 125, 89}, [533] = {62, 125, 89}, [534] = {62, 125, 89},
 [535] = {33, 93, 11}, [536] = {33, 93, 11}, [537] = {33, 143, 11}, [538] = {62, 39, 104}, [539] = {5, 39, 104}, [540] = {68, 34, 142}, [541] = {102, 34, 142},
 [542] = {68, 34, 142}, [543] = {38, 68, 95}, [544] = {38, 68, 95}, [545] = {38, 68, 95}, [546] = {158, 151, 34}, [547] = {158, 151, 34}, [548] = {34, 20, 102},
 [549] = {34, 20, 102}, [550] = {120, 91, 104}, [551] = {22, 153, 83}, [552] = {22, 153, 83}, [553] = {22, 153, 83}, [554] = {55, 39}, [555] = {125, 161},
 [556] = {11, 34, 114}, [557] = {5, 75, 133}, [558] = {5, 75, 133}, [559] = {61, 153, 22}, [560] = {61, 153, 22}, [561] = {147, 98, 110}, [562] = {152}, [563] = {152},
 [564] = {116, 5, 33}, [565] = {116, 5, 33}, [566] = {129}, [567] = {129}, [568] = {1, 60, 106}, [569] = {1, 133, 106}, [570] = {149}, [571] = {149},
 [572] = {56, 101, 92}, [573] = {56, 101, 92}, [574] = {119, 23}, [575] = {119, 23}, [576] = {119, 23}, [577] = {142, 98, 144}, [578] = {142, 98, 144},
 [579] = {142, 98, 144}, [580] = {51, 145, 93}, [581] = {51, 145, 93}, [582] = {115, 133}, [583] = {115, 133}, [584] = {115, 133}, [585] = {34, 157, 32},
 [586] = {34, 157, 32}, [587] = {9, 78}, [588] = {68, 61, 99}, [589] = {68, 75, 142}, [590] = {27, 144}, [591] = {27, 144}, [592] = {11, 130, 6}, [593] = {11, 130, 6},
 [594] = {131, 93, 144}, [595] = {14, 127, 68}, [596] = {14, 127, 68}, [597] = {160}, [598] = {160}, [599] = {57, 58, 29}, [600] = {57, 58, 29}, [601] = {57, 58, 29},
 [602] = {26}, [603] = {26}, [604] = {26}, [605] = {140, 28, 148}, [606] = {140, 28, 148}, [607] = {18, 49, 23}, [608] = {18, 49, 23}, [609] = {18, 49, 23},
 [610] = {79, 104, 127}, [611] = {79, 104, 127}, [612] = {79, 104, 127}, [613] = {81, 155}, [614] = {81, 33}, [615] = {26}, [616] = {93, 75, 142}, [617] = {93, 60, 84},
 [618] = {9, 7, 8}, [619] = {39, 144, 120}, [620] = {39, 144, 120}, [621] = {24, 125, 104}, [622] = {89, 103, 99}, [623] = {89, 103, 99}, [624] = {128, 39, 46},
 [625] = {128, 39, 46}, [626] = {120, 157, 43}, [627] = {51, 125, 55}, [628] = {51, 125, 128}, [629] = {145, 142, 133}, [630] = {145, 142, 133}, [631] = {82, 18, 73},
 [632] = {68, 55, 54}, [633] = {55}, [634] = {55}, [635] = {26}, [636] = {49, 68}, [637] = {49, 68}, [638] = {154}, [639] = {154}, [640] = {154}, [641] = {158, 128},
 [642] = {158, 128}, [643] = {163}, [644] = {164}, [645] = {159, 125}, [646] = {46}, [647] = {154}, [648] = {32}, [649] = {88}}

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
 "Ominous Wind", "Shadow Force",
 -- Gen 5
 "Hone Claws", "Wide Guard", "Guard Split", "Power Split", "Wonder Room", "Psyshock", "Venoshock", "Autotomize", "Rage Powder",
 "Telekinesis", "Magic Room", "Smack Down", "Storm Throw", "Flame Burst", "Sludge Wave", "Quiver Dance", "Heavy Slam",
 "Synchronoise", "Electro Ball", "Soak", "Flame Charge", "Coil", "Low Sweep", "Acid Spray", "Foul Play", "Simple Beam",
 "Entrainment", "After You", "Round", "Echoed Voice", "Chip Away", "Clear Smog", "Stored Power", "Quick Guard", "Ally Switch",
 "Scald", "Shell Smash", "Heal Pulse", "Hex", "Sky Drop", "Shift Gear", "Circle Throw", "Incinerate", "Quash", "Acrobatics",
 "Reflect Type", "Retaliate", "Final Gambit", "Bestow", "Inferno", "Water Pledge", "Fire Pledge", "Grass Pledge",
 "Volt Switch", "Struggle Bug", "Bulldoze", "Frost Breath", "Dragon Tail", "Work Up", "Electroweb", "Wild Charge",
 "Drill Run", "Dual Chop", "Heart Stamp", "Horn Leech", "Sacred Sword", "Razor Shell", "Heat Crash", "Leaf Tornado",
 "Steamroller", "Cotton Guard", "Night Daze", "Psystrike", "Tail Slap", "Hurricane", "Head Charge", "Gear Grind",
 "Searing Shot", "Techno Blast", "Relic Song", "Secret Sword", "Glaciate", "Bolt Strike", "Blue Flare", "Fiery Dance",
 "Freeze Shock", "Ice Burn", "Snarl", "Icicle Crash", "V-create", "Fusion Flare", "Fusion Bolt"}

local itemNamesList = {
 "None", "Master Ball", "Ultra Ball", "Great Ball", "Poké Ball", "Safari Ball", "Net Ball", "Dive Ball",
 "Nest Ball", "Repeat Ball", "Timer Ball", "Luxury Ball", "Premier Ball", "Dusk Ball", "Heal Ball", "Quick Ball",
 "Cherish Ball", "Potion", "Antidote", "Burn Heal", "Ice Heal", "Awakening", "Parlyz Heal", "Full Restore",
 "Max Potion", "Hyper Potion", "Super Potion", "Full Heal", "Revive", "Max Revive", "Fresh Water", "Soda Pop",
 "Lemonade", "Moomoo Milk", "EnergyPowder", "Energy Root", "Heal Powder", "Revival Herb", "Ether", "Max Ether", "Elixir",
 "Max Elixir", "Lava Cookie", "Berry Juice", "Sacred Ash", "HP Up", "Protein", "Iron", "Carbos", "Calcium", "Rare Candy",
 "PP Up", "Zinc", "PP Max", "Old Gateau", "Guard Spec.", "Dire Hit", "X Attack", "X Defend", "X Speed", "X Accuracy", "X Special",
 "X Sp. Def", "Poké Doll", "Fluffy Tail", "Blue Flute", "Yellow Flute", "Red Flute", "Black Flute", "White Flute", "Shoal Salt",
 "Shoal Shell", "Red Shard", "Blue Shard", "Yellow Shard", "Green Shard", "Super Repel", "Max Repel", "Escape Rope", "Repel",
 "Sun Stone", "Moon Stone", "Fire Stone", "Thunder Stone", "Water Stone", "Leaf Stone", "TinyMushroom", "Big Mushroom", "Pearl",
 "Big Pearl", "Stardust", "Star Piece", "Nugget", "Heart Scale", "Honey", "Growth Mulch", "Damp Mulch", "Stable Mulch",
 "Gooey Mulch", "Root Fossil", "Claw Fossil", "Helix Fossil", "Dome Fossil", "Old Amber", "Armor Fossil", "Skull Fossil",
 "Rare Bone", "Shiny Stone", "Dusk Stone", "Dawn Stone", "Oval Stone", "Odd Keystone", "Griseous Orb", "unknown", "unknown",
 "unknown", "Douse Drive", "Shock Drive", "Burn Drive", "Chill Drive", "unknown", "unknown", "unknown", "unknown", "unknown",
 "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "Sweet Heart", "Adamant Orb",
 "Lustrous Orb", "Greet Mail", "Favored Mail", "RSVP Mail", "Thanks Mail", "Inquiry Mail", "Like Mail", "Reply Mail",
 "BridgeMail S", "BridgeMail D", "BridgeMail T", "BridgeMail V", "BridgeMail M", "Cheri Berry", "Chesto Berry", "Pecha Berry",
 "Rawst Berry", "Aspear Berry", "Leppa Berry", "Oran Berry", "Persim Berry", "Lum Berry", "Sitrus Berry", "Figy Berry", "Wiki Berry",
 "Mago Berry", "Aguav Berry", "Iapapa Berry", "Razz Berry", "Bluk Berry", "Nanab Berry", "Wepear Berry", "Pinap Berry", "Pomeg Berry",
 "Kelpsy Berry","Qualot Berry", "Hondew Berry", "Grepa Berry", "Tamato Berry", "Cornn Berry", "Magost Berry", "Rabuta Berry",
 "Nomel Berry", "Spelon Berry", "Pamtre Berry", "Watmel Berry", "Durin Berry", "Belue Berry", "Occa Berry", "Passho Berry",
 "Wacan Berry", "Rindo Berry", "Yache Berry", "Chople Berry", "Kebia Berry", "Shuca Berry", "Coba Berry", "Payapa Berry", "Tanga Berry",
 "Charti Berry", "Kasib Berry", "Haban Berry", "Colbur Berry", "Babiri Berry", "Chilan Berry", "Liechi Berry", "Ganlon Berry",
 "Salac Berry", "Petaya Berry", "Apicot Berry", "Lansat Berry", "Starf Berry", "Enigma Berry", "Micle Berry", "Custap Berry",
 "Jaboca Berry", "Rowap Berry", "BrightPowder", "White Herb", "Macho Brace", "Exp. Share", "Quick Claw", "Soothe Bell", "Mental Herb",
 "Choice Band", "King's Rock", "SilverPowder", "Amulet Coin", "Cleanse Tag", "Soul Dew", "DeepSeaTooth", "DeepSeaScale", "Smoke Ball",
 "Everstone", "Focus Band", "Lucky Egg", "Scope Lens", "Metal Coat", "Leftovers", "Dragon Scale", "Light Ball", "Soft Sand", "Hard Stone",
 "Miracle Seed", "BlackGlasses", "Black Belt", "Magnet", "Mystic Water", "Sharp Beak", "Poison Barb", "NeverMeltIce", "Spell Tag",
 "TwistedSpoon", "Charcoal", "Dragon Fang", "Silk Scarf", "Up-Grade", "Shell Bell", "Sea Incense", "Lax Incense", "Lucky Punch",
 "Metal Powder", "Thick Club", "Stick", "Red Scarf", "Blue Scarf", "Pink Scarf", "Green Scarf", "Yellow Scarf", "Wide Lens",
 "Muscle Band", "Wise Glasses", "Expert Belt", "Light Clay", "Life Orb", "Power Herb", "Toxic Orb", "Flame Orb", "Quick Powder",
 "Focus Sash", "Zoom Lens", "Metronome", "Iron Ball", "Lagging Tail", "Destiny Knot", "Black Sludge", "Icy Rock", "Smooth Rock",
 "Heat Rock", "Damp Rock", "Grip Claw", "Choice Scarf", "Sticky Barb", "Power Bracer", "Power Belt", "Power Lens", "Power Band",
 "Power Anklet", "Power Weight", "Shed Shell", "Big Root", "Choice Specs", "Flame Plate", "Splash Plate", "Zap Plate", "Meadow Plate",
 "Icicle Plate", "Fist Plate", "Toxic Plate", "Earth Plate", "Sky Plate", "Mind Plate", "Insect Plate", "Stone Plate", "Spooky Plate",
 "Draco Plate", "Dread Plate", "Iron Plate", "Odd Incense", "Rock Incense", "Full Incense", "Wave Incense", "Rose Incense",
 "Luck Incense", "Pure Incense", "Protector", "Electirizer", "Magmarizer", "Dubious Disc", "Reaper Cloth", "Razor Claw", "Razor Fang",
 "TM01", "TM02", "TM03", "TM04", "TM05", "TM06", "TM07", "TM08", "TM09", "TM10", "TM11", "TM12", "TM13", "TM14", "TM15", "TM16", "TM17",
 "TM18", "TM19", "TM20", "TM21", "TM22", "TM23", "TM24", "TM25", "TM26", "TM27", "TM28", "TM29", "TM30", "TM31", "TM32", "TM33", "TM34",
 "TM35", "TM36", "TM37", "TM38", "TM39", "TM40", "TM41", "TM42", "TM43", "TM44", "TM45", "TM46", "TM47", "TM48", "TM49", "TM50", "TM51",
 "TM52", "TM53", "TM54", "TM55", "TM56", "TM57", "TM58", "TM59", "TM60", "TM61", "TM62", "TM63", "TM64", "TM65", "TM66", "TM67", "TM68",
 "TM69", "TM70", "TM71", "TM72", "TM73", "TM74", "TM75", "TM76", "TM77", "TM78", "TM79", "TM80", "TM81", "TM82", "TM83", "TM84", "TM85",
 "TM86", "TM87", "TM88", "TM89", "TM90", "TM91", "TM92", "HM01", "HM02", "HM03", "HM04", "HM05", "HM06", "unknown", "unknown",
 "Explorer Kit", "Loot Sack", "Rule Book", "Poké Radar", "Point Card", "Journal", "Seal Case", "Fashion Case", "Seal Bag", "Pal Pad",
 "Works Key", "Old Charm", "Galactic Key", "Red Chain", "Town Map", "Vs. Seeker", "Coin Case", "Old Rod", "Good Rod", "Super Rod",
 "Sprayduck", "Poffin Case", "Bicycle", "Suite Key", "Oak's Letter", "Lunar Wing", "Member Card", "Azure Flute", "S.S. Ticket",
 "Contest Pass", "Magma Stone", "Parcel", "Coupon 1", "Coupon 2", "Coupon 3", "Storage Key", "SecretPotion", "Vs. Recorder", "Gracidea",
 "Secret Key", "Apricorn Box", "Unown Report", "Berry Pots", "Dowsing MCHN", "Blue Card", "SlowpokeTail", "Clear Bell", "Card Key",
 "Basement Key", "SquirtBottle", "Red Scale", "Lost Item", "Pass", "Machine Part", "Silver Wing", "Rainbow Wing", "Mystery Egg",
 "Red Apricorn", "Ylw Apricorn", "Blu Apricorn", "Grn Apricorn", "Pnk Apricorn", "Wht Apricorn", "Blk Apricorn", "Fast Ball", "Level Ball",
 "Lure Ball", "Heavy Ball", "Love Ball", "Friend Ball", "Moon Ball", "Sport Ball", "Park Ball", "Photo Album", "GB Sounds", "Tidal Bell",
 "RageCandyBar", "Data Card 01", "Data Card 02", "Data Card 03", "Data Card 04", "Data Card 05", "Data Card 06", "Data Card 07",
 "Data Card 08", "Data Card 09", "Data Card 10", "Data Card 11", "Data Card 12", "Data Card 13", "Data Card 14", "Data Card 15",
 "Data Card 16", "Data Card 17", "Data Card 18", "Data Card 19", "Data Card 20", "Data Card 21", "Data Card 22", "Data Card 23",
 "Data Card 24", "Data Card 25", "Data Card 26", "Data Card 27", "Jade Orb", "Lock Capsule", "Red Orb", "Blue Orb", "Enigma Stone",
 "Prism Scale", "Eviolite", "Float Stone", "Rocky Helmet", "Air Balloon", "Red Card", "Ring Target", "Binding Band", "Absorb Bulb",
 "Cell Battery", "Eject Button", "Fire Gem", "Water Gem", "Electric Gem", "Grass Gem", "Ice Gem", "Fighting Gem", "Poison Gem",
 "Ground Gem", "Flying Gem", "Psychic Gem", "Bug Gem", "Rock Gem", "Ghost Gem", "Dragon Gem", "Dark Gem", "Steel Gem", "Normal Gem",
 "Health Wing", "Muscle Wing", "Resist Wing", "Genius Wing", "Clever Wing", "Swift Wing", "Pretty Wing", "Cover Fossil", "Plume Fossil",
 "Liberty Pass", "Pass Orb", "Dream Ball", "Poké Toy", "Prop Case", "Dragon Skull", "BalmMushroom", "Big Nugget", "Pearl String",
 "Comet Shard", "Relic Copper", "Relic Silver", "Relic Gold", "Relic Vase", "Relic Band", "Relic Statue", "Relic Crown", "Casteliacone",
 "Dire Hit 2", "X Speed 2", "X Special 2", "X Sp. Def 2", "X Defend 2", "X Attack 2", "X Accuracy 2", "X Speed 3", "X Special 3",
 "X Sp. Def 3", "X Defend 3", "X Attack 3", "X Accuracy 3", "X Speed 6", "X Special 6", "X Sp. Def 6", "X Defend 6", "X Attack 6",
 "X Accuracy 6", "Ability Urge", "Item Drop", "Item Urge", "Reset Urge", "Dire Hit 3", "Light Stone", "Dark Stone", "TM93", "TM94",
 "TM95", "Xtransceiver", "God Stone", "Gram 1", "Gram 2", "Gram 3", "Xtransceiver", "Medal Box", "DNA Splicers", "DNA Splicers", "Permit",
 "Oval Charm", "Shiny Charm", "Plasma Card", "Grubby Hanky", "Colress MCHN", "Dropped Item", "Dropped Item", "Reveal Glass"}

local locationNamesList = {"Black City", "Black City", "Black City", "Black City", "Black City", "Black City", "Striaton City", "Striaton City", "Striaton City",
 "Striaton City", "Striaton City", "Striaton City", "Striaton City", "Striaton City", "Striaton City", "Striaton City", "Nacrene City", "Nacrene City", "Nacrene City",
 "Nacrene City", "Nacrene City", "Nacrene City", "Nacrene City", "Nacrene City", "Nacrene City", "Nacrene City", "Nacrene City", "Nacrene Gate", "Castelia City",
 "Castelia City", "Castelia City", "Castelia City", "Castelia City", "Castelia City", "Castelia City", "Castelia City", "Castelia City", "Castelia City", "Castelia City",
 "Castelia City", "Castelia City", "Castelia City", "Castelia City", "Castelia City", "Castelia City", "Castelia City", "Castelia City", "Castelia City", "Castelia City",
 "Castelia City", "Castelia City", "Castelia Gate", "Royal Unova", "Castelia City", "Castelia City", "Castelia City", "Castelia City", "Castelia City", "Castelia City",
 "Castelia City", "Castelia City", "Castelia City", "Nimbasa City", "Nimbasa City", "Nimbasa City", "Nimbasa City", "Gear Station", "Gear Station", "Gear Station",
 "Gear Station", "Gear Station", "Gear Station", "Gear Station", "Gear Station", "Gear Station", "Battle Subway", "Battle Subway", "Musical Theater", "Musical Theater",
 "Nimbasa City", "Nimbasa City", "Nimbasa City", "Nimbasa City", "Nimbasa City", "Nimbasa City", "Nimbasa City", "Nimbasa City", "Nimbasa City", "Nimbasa City",
 "Nimbasa City", "Nimbasa Gate", "Nimbasa Gate", "Nimbasa Gate", "Nimbasa City", "Nimbasa City", "Nimbasa City", "Driftveil City", "Driftveil City", "Driftveil City",
 "Driftveil City", "Driftveil City", "Driftveil City", "Driftveil City", "Driftveil City", "Driftveil City", "Driftveil City", "Driftveil City", "Mistralton City",
 "Mistralton City", "Mistralton City", "Mistralton City", "Mistralton City", "Mistralton City", "Icirrus City", "Icirrus City", "Icirrus City", "Icirrus City",
 "Icirrus City", "Icirrus City", "Icirrus City", "Opelucid City", "Opelucid City", "Opelucid City", "Opelucid City", "Opelucid City", "Opelucid City", "Opelucid City",
 "Opelucid City", "Opelucid City", "Opelucid City", "Opelucid City", "Opelucid Gate", "Opelucid Gate", "Opelucid Gate", "Opelucid City", "Opelucid City", "Pokémon League",
 "Pokémon League", "Pokémon League", "Pokémon League", "Pokémon League", "Pokémon League", "Pokémon League", "Pokémon League", "Pokémon League", "Pokémon League",
 "Pokémon League", "Unity Tower", "Unity Tower", "Unity Tower", "－－－－－－－－－－", "－－－－－－－－－－", "Dreamyard", "Dreamyard", "Pinwheel Forest", "Pinwheel Forest",
 "Rumination Field", "Desert Resort", "Desert Resort", "Route Gate", "Relic Castle", "Relic Castle", "Relic Castle", "Relic Castle", "Relic Castle", "Relic Castle",
 "Relic Castle", "Relic Castle", "Relic Castle", "Relic Castle", "Relic Castle", "Relic Castle", "Relic Castle", "Relic Castle", "Relic Castle", "Relic Castle", "Relic Castle",
 "Relic Castle", "Relic Castle", "Relic Castle", "Relic Castle", "Relic Castle", "Relic Castle", "Relic Castle", "Relic Castle", "Relic Castle", "Relic Castle", "Relic Castle",
 "Relic Castle", "Relic Castle", "Relic Castle", "Cold Storage", "Cold Storage", "Cold Storage", "Chargestone Cave", "Chargestone Cave", "Chargestone Cave", "Chargestone Cave",
 "Twist Mountain", "Twist Mountain", "Twist Mountain", "Twist Mountain", "Twist Mountain", "Twist Mountain", "Twist Mountain", "Dragonspiral Tower", "Dragonspiral Tower",
 "Dragonspiral Tower", "Dragonspiral Tower", "Dragonspiral Tower", "Dragonspiral Tower", "Dragonspiral Tower", "Dragonspiral Tower", "Dragonspiral Tower", "Victory Road", "Victory Road",
 "Victory Road", "Victory Road", "Victory Road", "Victory Road", "Victory Road", "Victory Road", "Victory Road", "Victory Road", "Victory Road", "Victory Road", "Victory Road",
 "Victory Road", "Victory Road", "Trial Chamber", "Giant Chasm", "Giant Chasm", "Giant Chasm", "Giant Chasm", "Giant Chasm", "Liberty Garden", "Liberty Garden", "Liberty Garden",
 "P2 Laboratory", "P2 Laboratory", "Undella Bay", "Abyssal Ruins", "Abyssal Ruins", "Abyssal Ruins", "Abyssal Ruins", "Abyssal Ruins", "Abyssal Ruins", "Abyssal Ruins", "Abyssal Ruins",
 "Skyarrow Bridge", "Bridge Gate", "Bridge Gate", "Bridge Gate", "Driftveil Drawbridge", "Tubeline Bridge", "Village Bridge", "Village Bridge", "Village Bridge", "Village Bridge",
 "Village Bridge", "Village Bridge", "Village Bridge", "Village Bridge", "Marvelous Bridge", "N's Castle", "N's Castle", "N's Castle", "N's Castle", "N's Castle", "N's Castle",
 "N's Castle", "N's Castle", "N's Castle", "N's Castle", "N's Castle", "N's Castle", "N's Castle", "N's Castle", "N's Castle", "Entralink", "Entree Forest", "Entree Forest",
 "Entree Forest", "Entree Forest", "Entree Forest", "Entree Forest", "Entree Forest", "Entree Forest", "Entree Forest", "Nimbasa City", "Driftveil City", "Mistralton City",
 "Icirrus City", "Opelucid City", "Black City", "White Forest", "Cold Storage", "Chargestone Cave", "Twist Mountain", "Dragonspiral Tower", "Giant Chasm", "Driftveil Drawbridge",
 "Tubeline Bridge", "Marvelous Bridge", "Route 5", "Route 6", "Route 7", "Route 8", "Route 9", "Route 11", "Route 12", "Route 13", "Route 14", "Route 15", "Route 16", "Lacunosa Town",
 "Undella Town", "Route 1", "Route Gate", "Route 2", "Accumula Gate", "Route 3", "Route 3", "Route 3", "Wellspring Cave", "Wellspring Cave", "Route 4", "Route 4", "Route 4", "Route 5",
 "Route 5", "Route 6", "Route 6", "Mistralton Cave", "Mistralton Cave", "Guidance Chamber", "Route 6", "Route 7", "Celestial Tower", "Celestial Tower", "Celestial Tower",
 "Celestial Tower", "Celestial Tower", "Route 7", "Route 7", "Route 8", "Moor of Icirrus", "Bridge Gate", "Route 9", "Bridge Gate", "Shopping Mall", "Shopping Mall", "Challenger's Cave",
 "Challenger's Cave", "Challenger's Cave", "Route 10", "Route 10", "Route 10", "Route 10", "Route 10", "Route 10", "Route 10", "Route 10", "Route 10", "Route 10", "Route 11",
 "Bridge Gate", "Route 11", "Route 12", "Bridge Gate", "Route 13", "Route 13", "Undella Gate", "Route 13", "Route 14", "Black Gate", "Abundant Shrine", "Abundant Shrine", "Route 15",
 "Black Gate", "Bridge Gate", "Poké Transfer Lab", "Route 15", "Route 16", "Bridge Gate", "Lostlorn Forest", "Lostlorn Forest", "Route 18", "Route 18", "Nuvema Town", "Nuvema Town",
 "Nuvema Town", "Nuvema Town", "Nuvema Town", "Nuvema Town", "Nuvema Town", "Nuvema Town", "Accumula Town", "Accumula Town", "Accumula Town", "Accumula Town", "Accumula Town",
 "Accumula Town", "Accumula Town", "Accumula Town", "Accumula Town", "Lacunosa Town", "Lacunosa Town", "Lacunosa Town", "Lacunosa Town", "Lacunosa Town", "Lacunosa Town", "Undella Town",
 "Undella Town", "Undella Town", "Undella Town", "Undella Town", "Undella Town", "Anville Town", "Anville Town", "Anville Town", "Anville Town", "－－－－－－－－－－", "Route 17",
 "White Forest", "White Forest", "White Forest"}

local statusConditionNamesList = {"None", "PAR", "SLP", "FRZ", "BRN", "PSN"}

client.reboot_core()

local gameCode = read32Bit(0x2FFFE0C)
local gameVersionCode = (gameCode >> 16) & 0xFF
local gameVersion = ""
local gameLanguageCode = gameCode >> 24
local gameLanguage = ""
local wrongGameVersion = true

if gameVersionCode == 0x41 then  -- Check game version
 gameVersion = "White"
elseif gameVersionCode == 0x42 then
 gameVersion = "Black"
elseif gameVersionCode == 0x44 then
 gameVersion = "White 2"
elseif gameVersionCode == 0x45 then
 gameVersion = "Black 2"
end

function getGameAddrOffset(version, offset)
 return gameVersion == version and offset or 0
end

local mtSeedAddr, mtIndexAddr, currentSeedAddr, boxAddr, partySlotsCounterAddr, partyAddr, trainerIDsAddr, roamerAddr, playerMapIndexAddr, cgearEnemyAddr,
      currBoxIndexAddr, partySelectedSlotIndexAddr, partyStatsSelectedSlotIndexAddr, enemyAddr, pokemonBoxStatsAddr, boxSelectedSlotIndexAddr

if gameLanguageCode == 0x44 then  -- Check game language and set addresses
 gameLanguage = "GER"
 mtSeedAddr = 0x2215294 + getGameAddrOffset("White", 0x20)
 mtIndexAddr = 0x2215C54 + getGameAddrOffset("White", 0x20)
 currentSeedAddr = 0x2216164 + getGameAddrOffset("White", 0x20)
 boxAddr = 0x221BEEC + getGameAddrOffset("White", 0x20)
 partySlotsCounterAddr = 0x22348F0 + getGameAddrOffset("White", 0x20)
 partyAddr = 0x22348F4 + getGameAddrOffset("White", 0x20)
 trainerIDsAddr = 0x2234F00 + getGameAddrOffset("White", 0x20)
 roamerAddr = 0x223D604 + getGameAddrOffset("White", 0xC)
 playerMapIndexAddr = 0x224F84C + getGameAddrOffset("White", 0x20)
 cgearEnemyAddr = 0x225CE50 + getGameAddrOffset("White", 0x20)
 currBoxIndexAddr = 0x22696C0 + getGameAddrOffset("White", 0x20)
 partyStatsSelectedSlotIndexAddr = 0x22696C4 + getGameAddrOffset("White", 0x20)
 partySelectedSlotIndexAddr = 0x22696D8 + getGameAddrOffset("White", 0x20)
 enemyAddr = 0x226AC34 + getGameAddrOffset("White", 0x20)
 pokemonBoxStatsAddr = 0x227994C + getGameAddrOffset("White", 0x20)
 boxSelectedSlotIndexAddr = 0x22EB81D + getGameAddrOffset("White", 0x20)
elseif gameLanguageCode == 0x46 then
 gameLanguage = "FRE"
 mtSeedAddr = 0x22152D4 + getGameAddrOffset("White", 0x20)
 mtIndexAddr = 0x2215C94 + getGameAddrOffset("White", 0x20)
 currentSeedAddr = 0x22161A4 + getGameAddrOffset("White", 0x20)
 boxAddr = 0x221BF2C + getGameAddrOffset("White", 0x20)
 partySlotsCounterAddr = 0x2234930 + getGameAddrOffset("White", 0x20)
 partyAddr = 0x2234934 + getGameAddrOffset("White", 0x20)
 trainerIDsAddr = 0x2234F40 + getGameAddrOffset("White", 0x20)
 roamerAddr = 0x223D644 + getGameAddrOffset("White", 0xC)
 playerMapIndexAddr = 0x224F88C + getGameAddrOffset("White", 0x20)
 cgearEnemyAddr = 0x225CE90 + getGameAddrOffset("White", 0x20)
 currBoxIndexAddr = 0x2269700 + getGameAddrOffset("White", 0x20)
 partyStatsSelectedSlotIndexAddr = 0x2269704 + getGameAddrOffset("White", 0x20)
 partySelectedSlotIndexAddr = 0x2269718 + getGameAddrOffset("White", 0x20)
 enemyAddr = 0x226AC74 + getGameAddrOffset("White", 0x20)
 pokemonBoxStatsAddr = 0x227998C + getGameAddrOffset("White", 0x20)
 boxSelectedSlotIndexAddr = 0x22EB85D + getGameAddrOffset("White", 0x20)
elseif gameLanguageCode == 0x49 then
 gameLanguage = "ITA"
 mtSeedAddr = 0x2215254 + getGameAddrOffset("White", 0x20)
 mtIndexAddr = 0x2215C14 + getGameAddrOffset("White", 0x20)
 currentSeedAddr = 0x2216124 + getGameAddrOffset("White", 0x20)
 boxAddr = 0x221BEAC + getGameAddrOffset("White", 0x20)
 partySlotsCounterAddr = 0x22348B0 + getGameAddrOffset("White", 0x20)
 partyAddr = 0x22348B4 + getGameAddrOffset("White", 0x20)
 trainerIDsAddr = 0x2234EC0 + getGameAddrOffset("White", 0x20)
 roamerAddr = 0x223D5C4 + getGameAddrOffset("White", 0xC)
 playerMapIndexAddr = 0x224F80C + getGameAddrOffset("White", 0x20)
 cgearEnemyAddr = 0x225CE10 + getGameAddrOffset("White", 0x20)
 currBoxIndexAddr = 0x2269680 + getGameAddrOffset("White", 0x20)
 partyStatsSelectedSlotIndexAddr = 0x2269684 + getGameAddrOffset("White", 0x20)
 partySelectedSlotIndexAddr = 0x2269698 + getGameAddrOffset("White", 0x20)
 enemyAddr = 0x226ABF4 + getGameAddrOffset("White", 0x20)
 pokemonBoxStatsAddr = 0x227990C + getGameAddrOffset("White", 0x20)
 boxSelectedSlotIndexAddr = 0x22EB7DD + getGameAddrOffset("White", 0x20)
elseif gameLanguageCode == 0x4A then
 gameLanguage = "JPN"
 mtSeedAddr = 0x22151B4 + getGameAddrOffset("White", 0x20)
 mtIndexAddr = 0x2215B74 + getGameAddrOffset("White", 0x20)
 currentSeedAddr = 0x2216084 + getGameAddrOffset("White", 0x20)
 boxAddr = 0x221BE0C + getGameAddrOffset("White", 0x20)
 partySlotsCounterAddr = 0x2234810 + getGameAddrOffset("White", 0x20)
 partyAddr = 0x2234814 + getGameAddrOffset("White", 0x20)
 trainerIDsAddr = 0x2234E20 + getGameAddrOffset("White", 0x20)
 roamerAddr = 0x223D524 + getGameAddrOffset("White", 0xC)
 playerMapIndexAddr = 0x224F76C + getGameAddrOffset("White", 0x20)
 cgearEnemyAddr = 0x225CC84 + getGameAddrOffset("White", 0x20)
 currBoxIndexAddr = 0x22695E0 + getGameAddrOffset("White", 0x20)
 partyStatsSelectedSlotIndexAddr = 0x22695E4 + getGameAddrOffset("White", 0x20)
 partySelectedSlotIndexAddr = 0x22695F8 + getGameAddrOffset("White", 0x20)
 enemyAddr = 0x226AB54 + getGameAddrOffset("White", 0x20)
 pokemonBoxStatsAddr = 0x227986C + getGameAddrOffset("White", 0x20)
 boxSelectedSlotIndexAddr = 0x22EB745 + getGameAddrOffset("White", 0x20)
elseif gameLanguageCode == 0x4B then
 gameLanguage = "KOR"
 mtSeedAddr = 0x2215A54
 mtIndexAddr = 0x2216414
 currentSeedAddr = 0x2216924
 boxAddr = 0x221C6AC
 partySlotsCounterAddr = 0x22350B0
 partyAddr = 0x22350B4
 trainerIDsAddr = 0x22356C0
 roamerAddr = 0x223DDB0 + getGameAddrOffset("Black", 0x14)
 playerMapIndexAddr = 0x225000C
 cgearEnemyAddr = 0x225D610
 currBoxIndexAddr = 0x2269E80
 partyStatsSelectedSlotIndexAddr = 0x2269E84
 partySelectedSlotIndexAddr = 0x2269E98
 enemyAddr = 0x226B3F4
 pokemonBoxStatsAddr = 0x227A10C
 boxSelectedSlotIndexAddr = 0x22EBFE1
elseif gameLanguageCode == 0x4F then
 gameLanguage = "USA"
 mtSeedAddr = 0x2215354 + getGameAddrOffset("White", 0x20)
 mtIndexAddr = 0x2215D14 + getGameAddrOffset("White", 0x20)
 currentSeedAddr = 0x2216224 + getGameAddrOffset("White", 0x20)
 boxAddr = 0x221BFAC + getGameAddrOffset("White", 0x20)
 partySlotsCounterAddr = 0x22349B0 + getGameAddrOffset("White", 0x20)
 partyAddr = 0x22349B4 + getGameAddrOffset("White", 0x20)
 trainerIDsAddr = 0x2234FC0 + getGameAddrOffset("White", 0x20)
 roamerAddr = 0x223D6C4 + getGameAddrOffset("White", 0xC)
 playerMapIndexAddr = 0x224F90C + getGameAddrOffset("White", 0x20)
 cgearEnemyAddr = 0x225CF10 + getGameAddrOffset("White", 0x20)
 currBoxIndexAddr = 0x2269780 + getGameAddrOffset("White", 0x20)
 partyStatsSelectedSlotIndexAddr = 0x2269784 + getGameAddrOffset("White", 0x20)
 partySelectedSlotIndexAddr = 0x2269798 + getGameAddrOffset("White", 0x20)
 enemyAddr = 0x226ACF4 + getGameAddrOffset("White", 0x20)
 pokemonBoxStatsAddr = 0x2279A0C + getGameAddrOffset("White", 0x20)
 boxSelectedSlotIndexAddr = 0x22EB8E1 + getGameAddrOffset("White", 0x20)
elseif gameLanguageCode == 0x53 then
 gameLanguage = "SPA"
 mtSeedAddr = 0x2215314
 mtIndexAddr = 0x2215CD4
 currentSeedAddr = 0x22161E4
 boxAddr = 0x221BF6C
 partySlotsCounterAddr = 0x2234970
 partyAddr = 0x2234974
 trainerIDsAddr = 0x2234F80
 roamerAddr = 0x223D670 + getGameAddrOffset("Black", 0x14)
 playerMapIndexAddr = 0x224F8CC
 cgearEnemyAddr = 0x225CED0
 currBoxIndexAddr = 0x2269740
 partyStatsSelectedSlotIndexAddr = 0x2269744
 partySelectedSlotIndexAddr = 0x2269758
 enemyAddr = 0x226ACB4
 pokemonBoxStatsAddr = 0x22799CC
 boxSelectedSlotIndexAddr = 0x22EB8A1
end

function printGameInfo()
 console.clear()

 if gameVersion == "" then  -- Print game info
  print("Version: Unknown game")
 elseif gameVersion ~= "Black" and gameVersion ~= "White" then
  print(string.format("Version: %s - Wrong game version! Use Black/White instead\n", gameVersion))
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

local mode, index = {"None", "Capture", "Breeding", "Roamer", "C-Gear", "Pandora", "Pokemon Info"}, 1

function setBackgroundBoxes()  -- Set transparent black boxes
 gui.defaultTextBackground("clear")
 gui.defaultPixelFont("gens")

 if mode[index] == "None" or mode[index] == "Pandora" then
  gui.drawBox(1, 1, 113, 8, 0x7F000000, 0x7F000000)
 elseif mode[index] == "Capture" or mode[index] == "Breeding" or mode[index] == "C-Gear" or mode[index] == "Pokemon Info" then
  gui.drawBox(1, 1, 113, 92, 0x7F000000, 0x7F000000)
 elseif mode[index] == "Roamer" then
  gui.drawBox(1, 1, 113, 85, 0x7F000000, 0x7F000000)
 end

 if mode[index] ~= "None" then
  gui.drawBox(125, 183, 193, 190, 0x7F000000, 0x7F000000)
  gui.drawBox(214, 176, 254, 190, 0x7F000000, 0x7F000000)
 end
end

local dateTime = {["month"] = 1, ["day"] = 1, ["year"] = 0, ["hour"] = 0, ["minute"] = 0, ["second"] = 0}

function setDateTime()
 local dateTimeAddr = 0x23FFDE8

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
  index = index - 1 < 1 and 7 or index - 1
 elseif (key["Number2"] or key["Keypad2"]) and (not prevKey["Number2"] and not prevKey["Keypad2"]) then
  rightArrowColor = "orange"
  index = index + 1 > 7 and 1 or index + 1
 end

 prevKey = key
 gui.pixelText(1, 1, "Mode: "..mode[index])
 drawArrowLeft(76, 1, leftArrowColor)
 gui.pixelText(84, 1, "1 - 2")
 drawArrowRight(112, 1, rightArrowColor)
end

local initialSeedFlag, prevMTSeed, initialSeedHigh, initialSeedLow, tempCurrentSeedLow = false, 0, 0, 0, 0

function checkInitialSeedGeneration(mtSeed, currentHigh, currentLow)
 if currentLow ~= 0 and not initialSeedFlag then  -- Set the initial seed when the LCRNG current seed address is initialized in RAM
  initialSeedFlag = true
  prevMTSeed = mtSeed
  initialSeedHigh = currentHigh
  initialSeedLow = currentLow
  tempCurrentSeedLow = currentLow
  print(string.format("Initial Seed: %08X%08X", initialSeedHigh, initialSeedLow))
 end

 userdata.set("initialSeedHigh", initialSeedHigh)
 userdata.set("initialSeedLow", initialSeedLow)
end

local UPPER_MASK = 0x80000000

function tobit(value)
 return (value % 0x100000000) - (value >= UPPER_MASK and 0x100000000 or 0)
end

local N = 624

function initializeMTArray(seed)
 local mt = {}
 mt[1] = seed

 for i = 1, N - 1 do
  seed = seed ~ (seed >> 30)
  local seedLow = seed & 0xFFFF
  local seedHigh = seed >> 16
  local seedLow2 = (0x6C078965 * seedLow) & 0xFFFFFFFF
  local seedHigh2 = (0x6C078965 * seedHigh) & 0xFFFF
  seed = ((((seedLow2 >> 16) + seedHigh2) << 16) | (seedLow2 & 0xFFFF)) & 0xFFFFFFFF
  local seedLim = -tobit(seed)
  seed = (seedLim > 0 and seedLim <= i) and i - seedLim or seed + i
  mt[i + 1] = seed
 end

 return mt
end

local M, LOWER_MASK, mag01 = 397, 0x7FFFFFFF, {0, 0x9908B0DF}

function getMTArrayFistSeed(seed)
 local mt = initializeMTArray(seed)
 local y = (mt[1] & UPPER_MASK) | (mt[2] & LOWER_MASK)
 mt[1] = mt[M + 1] ~ (y >> 1) ~ mag01[1 + (y & 1)]

 return mt[1]
end

function setPredictedDateTime()
 local nextSeconds, nextMinutes, nextHours, nextDays = dateTime["second"], dateTime["minute"], dateTime["hour"], dateTime["day"]

 if dateTime["second"] + 6 >= 60 then
  nextSeconds = (dateTime["second"] + 6) - 60
  nextMinutes = dateTime["minute"] + 1
 else
  nextSeconds = dateTime["second"] + 6
  nextMinutes = dateTime["minute"]
 end

 if nextMinutes == 60 then
  nextMinutes = nextMinutes - 60
  nextHours = dateTime["hour"] + 1
 else
  nextMinutes = dateTime["minute"]
  nextHours = dateTime["hour"]
 end

 if nextHours == 24 then
  nextHours = nextHours - 24
  nextDays = dateTime["day"] + 1
 else
  nextHours = dateTime["hour"]
  nextDays = dateTime["day"]
 end

 return nextSeconds, nextMinutes, nextHours, nextDays
end

function buildSeedFromDelay(delay, predictSeedFlag)
 predictSeedFlag = predictSeedFlag or false

 local nextSeconds, nextMinutes, nextHours, nextDays = dateTime["second"], dateTime["minute"], dateTime["hour"], dateTime["day"]

 if predictSeedFlag then
  nextSeconds, nextMinutes, nextHours, nextDays = setPredictedDateTime()
 end

 local ab = ((dateTime["month"] * nextDays) + nextMinutes + nextSeconds) % 0x100
 local cd = nextHours
 local efgh = dateTime["year"] + delay
 local macAddr = 0xE4916  -- BizHawk MAC addres

 return ((ab * 0x1000000) + (cd * 0x10000) + efgh + macAddr) % 0x100000000
end

function convertToString(seed)
 return string.format("%08X", seed)
end

local cgearSeed, mtCounter, hitDelay , hitDate = 0, 0, 0, "2000/01/01\n00:00:00"

function handleMTAdvances(mtSeed, delay)
 if prevMTSeed ~= mtSeed and delay > 200 then  -- Check when the value of the MT seed changes in RAM
  local cgearSeedTest = buildSeedFromDelay(delay - 1)

  if convertToString(mtSeed) == convertToString(getMTArrayFistSeed(cgearSeedTest)) then  -- Check C-Gear MT seeding
   mtCounter = 0
   cgearSeed = cgearSeedTest
   hitDelay = delay - 1
   hitDate = string.format("20%s/%s/%s\n%s:%s:%s", dateTime["year"], dateTime["month"], dateTime["day"],
                           dateTime["hour"], dateTime["minute"], dateTime["second"])
  end

  mtCounter = mtCounter + 1
  prevMTSeed = mtSeed
 end
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

  tempCurrentSeedLow = state1
 end

 return dist > 999 and dist - 0x100000000 or dist
end

local advances = 0

function getRngInfo()
 local mtSeed = read32Bit(mtSeedAddr)
 local currentHigh = read32Bit(currentSeedAddr + 0x4)
 local currentLow = read32Bit(currentSeedAddr)
 local mtIndex = read32Bit(mtIndexAddr)
 local delay = read32Bit(0x2FFFC3C)

 checkInitialSeedGeneration(mtSeed, currentHigh, currentLow)
 handleMTAdvances(mtSeed, delay)

 advances = mtSeed == currentHigh and 0 or advances + LCRNGDistance(tempCurrentSeedLow, currentLow)
 local mtAdvances = (mtIndex - 624) + (mtCounter * 624)

 userdata.set("tempCurrentSeedLow", tempCurrentSeedLow)
 userdata.set("advances", advances)
 userdata.set("mtCounter", mtCounter)
 userdata.set("cgearSeed", cgearSeed)
 userdata.set("hitDelay", hitDelay)
 userdata.set("hitDate", hitDate)

 return currentHigh, currentLow, mtAdvances, delay
end

function showDateTime()
 if mode[index] ~= "None" then
  gui.drawBox(214, 192, 254, 206, 0x7F000000, 0x7F000000)
  gui.pixelText(214, 192, string.format("20%s/%s/%s", dateTime["year"], dateTime["month"], dateTime["day"]))
  gui.pixelText(214, 199, string.format("%s:%s:%s", dateTime["hour"], dateTime["minute"], dateTime["second"]))
 end
end

local showCGearSeedInfoText = true

function getInitialSeedInfoInput()
 local key = input.get()

 if key["Number7"] or key["Keypad7"] then
  showCGearSeedInfoText = false
 elseif key["Number8"] or key["Keypad8"] then
  showCGearSeedInfoText = true
 end

 gui.drawBox(1, 376, 101, 383, 0x7F000000, 0x7F000000)
 gui.pixelText(1, 376, showCGearSeedInfoText and "7 - Hide C-Gear Seed info" or "8 - Show C-Gear Seed info")
end

function showCGearSeedInfo(delay)
 if showCGearSeedInfoText then
  gui.drawBox(1, 192, 109, 255, 0x7F000000, 0x7F000000)
  gui.pixelText(1, 192, string.format("Next Initial Seed: %08X", buildSeedFromDelay(delay + 349, true)))
  gui.pixelText(1, 199, string.format("Next Delay: %d", delay + 349))
  gui.pixelText(1, 206, string.format("Delay: %d", delay))
  gui.pixelText(1, 220, string.format("C-Gear Seed: %08X", cgearSeed))
  gui.pixelText(1, 227, string.format("Hit Delay: %d", hitDelay))
  gui.pixelText(1, 234, string.format("Hit Date/Hour:\n%s", hitDate))
 end
end

local showRngInfoText = true

function showRngInfo()
 local currentSeedHigh, currentSeedLow, mtAdvances, delay = getRngInfo()

 if showRngInfoText and mode[index] ~= "None" then
  gui.drawBox(1, 162, 121, 190, 0x7F000000, 0x7F000000)
  gui.pixelText(0, 162, string.format("Initial Seed: %08X%08X", initialSeedHigh, initialSeedLow))
  gui.pixelText(1, 169, string.format("Current Seed: %08X%08X", currentSeedHigh, currentSeedLow))
  gui.pixelText(1, 176, string.format("LCRNG Advances: %d", advances))
  gui.pixelText(1, 183, string.format("MT Advances: %d", mtAdvances))

  showDateTime()

  if mode[index] == "C-Gear" then
   getInitialSeedInfoInput()
   showCGearSeedInfo(delay)
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

 gui.pixelText(125, 183, showRngInfoText and "5 - Hide RNG info" or "6 - Show RNG info")
end

function getTrainerIDs()
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

 if (key["Number3"] or key["Keypad3"]) and (not prevKeySlot["Number3"] and not prevKeySlot["Keypad3"]) then
  leftSlotArrowColor = "orange"
  slotIndex = slotIndex - 1 < 0 and 2 or slotIndex - 1
 elseif (key["Number4"] or key["Keypad4"]) and (not prevKeySlot["Number4"] and not prevKeySlot["Keypad4"]) then
  rightSlotArrowColor = "orange"
  slotIndex = slotIndex + 1 > 2 and 0 or slotIndex + 1
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

function getIVs(ivsValue, isRoamer)
 local hpIV  = getBits(ivsValue, 0, 5)
 local atkIV = getBits(ivsValue, 5, 5)
 local defIV = getBits(ivsValue, 10, 5)
 local spdIV = isRoamer and getBits(ivsValue, 25, 5) or getBits(ivsValue, 15, 5)
 local spAtkIV = isRoamer and getBits(ivsValue, 15, 5) or getBits(ivsValue, 20, 5)
 local spDefIV = isRoamer and getBits(ivsValue, 20, 5) or getBits(ivsValue, 25, 5)

 return hpIV, atkIV, defIV, spAtkIV, spDefIV, spdIV
end

function getHPTypeAndPower(hpIV, atkIV, defIV, spAtkIV, spDefIV, spdIV)
 local hpType = floor((((hpIV & 1) + (2 * (atkIV & 1)) + (4 * (defIV & 1)) + (8 * (spdIV & 1)) + (16 * (spAtkIV & 1))
                + (32 * (spDefIV & 1))) * 15) / 63)
 local hpPower = floor((((((hpIV >> 1) & 1) + (2 * ((atkIV >> 1) & 1)) + (4 * ((defIV >> 1) & 1)) + (8 * ((spdIV >> 1) & 1))
                 + (16 * ((spAtkIV >> 1) & 1)) + (32 * ((spDefIV >> 1) & 1))) * 40) / 63)) + 30

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

function showIVsAndHP(ivsValue, isRoamer)
 isRoamer = isRoamer or nil

 local hpIV, atkIV, defIV, spAtkIV, spDefIV, spdIV = getIVs(ivsValue, isRoamer)
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
 gui.pixelText(1, 64, "Move: "..moveNamesList[moveIndexesList[1] > 560 and 1 or moveIndexesList[1]])
 gui.pixelText(1, 71, "Move: "..moveNamesList[moveIndexesList[2] > 560 and 1 or moveIndexesList[2]])
 gui.pixelText(1, 78, "Move: "..moveNamesList[moveIndexesList[3] > 560 and 1 or moveIndexesList[3]])
 gui.pixelText(1, 85, "Move: "..moveNamesList[moveIndexesList[4] > 560 and 1 or moveIndexesList[4]])
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

 prng = LCRNG(prng, 0x807DBCB5, 0x52713895)  -- 3 cycles
 local natureIndex = read16Bit(pidAddr + attacksOffset + 0x20) ~ (prng >> 16)
 natureIndex = getBits(natureIndex, 8, 8) + 1

 prng = LCRNG(prng, 0x41C64E6D, 0x6073)
 local hiddenAbilityFlag = (read16Bit(pidAddr + attacksOffset + 0x22) ~ (prng >> 16)) & 1 == 1

 if mode[index] ~= "Breeding" or isEgg then
  gui.pixelText(1, 8, "Species: "..speciesNamesList[(speciesDexIndex > 649 or speciesDexIndex < 1) and 1 or speciesDexIndex])
  gui.pixelText(1, 15, "PID:")
  gui.pixelText(21, 15, string.format("%08X%s", pokemonPID, shinyType), shinyTypeTextColor)
  gui.pixelText(1, 22, "Nature: "..natureNamesList[(natureIndex > 25 or natureIndex == nil) and 1 or natureIndex])
  gui.pixelText(1, 29, string.format("Ability: %s (%s)", abilityNamesList[(abilityIndex > 164 or abilityIndex < 1) and 1 or abilityIndex],
                hiddenAbilityFlag and "H" or abilityIndex == pokemonAbilities[(speciesDexIndex > 649 or speciesDexIndex < 1) and 1 or speciesDexIndex][1] and "0" or "1"))

  showIVsAndHP(ivsValue)

  gui.pixelText(1, 50, "Held item: "..itemNamesList[(heldItemIndex > 639) and 1 or heldItemIndex])

  showMoves(move)
  showPP(movePP)

  if mode[index] == "Pokemon Info" then
   showPokemonIDs(OTID, OTSID)
  end
 end
end

function showPartyEggInfo()
 local partySlotsCounter = read8Bit(partySlotsCounterAddr) - 1
 local lastPartySlotAddr = partyAddr + (partySlotsCounter * 0xDC)

 showInfo(lastPartySlotAddr)
end

function getRoamerInfo(roamerAddr)
 local isRoamerActive = read8Bit(roamerAddr + 0x12) == 1

 if isRoamerActive then
  local roamerMapIndex = read16Bit(roamerAddr)
  local roamerNatureIndex = read8Bit(roamerAddr + 0x2) + 1
  local roamerIVsValue = read32Bit(roamerAddr + 0x4)
  local roamerPID = read32Bit(roamerAddr + 0x8)
  local roamerShinyTypeTextColor, roamerShinyType = shinyCheck(roamerPID)
  local roamerSpeciesIndex = read16Bit(roamerAddr + 0xC)
  local roamerHP = read16Bit(roamerAddr + 0xE)
  local roamerLevel = read8Bit(roamerAddr + 0x10)
  local roamerStatusIndex = read8Bit(roamerAddr + 0x11)
  local roamerStatus = statusConditionNamesList[1]  -- No altered status condition by default
  local playerMapIndex = read16Bit(playerMapIndexAddr)

  if roamerStatusIndex == 0x1 then  -- Paralized status condition
   roamerStatus = statusConditionNamesList[2]
  elseif roamerStatusIndex == 0x2 then  -- Sleeping status condition
   roamerStatus = statusConditionNamesList[3]
  elseif roamerStatusIndex == 0x3 then  -- Freezed status condition
   roamerStatus = statusConditionNamesList[4]
  elseif roamerStatusIndex == 0x4 then  -- Burned status condition
   roamerStatus = statusConditionNamesList[5]
  elseif roamerStatusIndex == 0x5 then  -- Poisoned status condition
   roamerStatus = statusConditionNamesList[6]
  end

  return isRoamerActive, roamerMapIndex, (roamerNatureIndex > 25 or roamerNatureIndex == nil) and 1 or roamerNatureIndex, roamerIVsValue,
         roamerPID, roamerShinyTypeTextColor, roamerShinyType, (roamerSpeciesIndex > 649 or roamerSpeciesIndex < 1) and 1 or roamerSpeciesIndex,
         roamerHP, roamerLevel, roamerStatus, playerMapIndex
 end

 return nil
end

function showRoamerInfo(roamerAddr)
 local isRoamerActive, roamerMapIndex, roamerNatureIndex, roamerIVsValue, roamerPID, roamerShinyTypeTextColor,
       roamerShinyType, roamerSpeciesIndex, roamerHP, roamerLevel, roamerStatus, playerMapIndex = getRoamerInfo(roamerAddr)

 if isRoamerActive then
  gui.pixelText(1, 8, "Active Roamer? Yes")
  gui.pixelText(1, 15, "Species: "..speciesNamesList[roamerSpeciesIndex])
  gui.pixelText(1, 22, "PID:")
  gui.pixelText(21, 22, string.format("%08X%s", roamerPID, roamerShinyType), roamerShinyTypeTextColor)
  gui.pixelText(1, 29, "Nature: "..natureNamesList[roamerNatureIndex])
  showIVsAndHP(roamerIVsValue, true)
  gui.pixelText(1, 50, "Level: "..roamerLevel)
  gui.pixelText(1, 57, "HP: "..roamerHP)
  gui.pixelText(1, 64, "Status condition: "..roamerStatus)
  gui.pixelText(1, 71, "Current position:")
  gui.pixelText(1, 78, (roamerMapIndex > 427 or roamerMapIndex < 1) and "" or locationNamesList[roamerMapIndex + 1],
                        roamerMapIndex == playerMapIndex and "limegreen" or nil)
 else
  gui.pixelText(1, 8, "Active Roamer? No")
 end
end

local prevKeyInfo, infoIndex, infoMode = {}, 1, {"Gift", "Party", "Party Stats", "Box", "Box Stats"}

function getInfoInput()
 local leftInfoArrowColor = "gray"
 local rightInfoArrowColor = "gray"
 local key = input.get()

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

function showPokemonInfo()
 if infoMode[infoIndex] == "Gift" then
  local partySlotsCounter = read8Bit(partySlotsCounterAddr) - 1
  local lastPartySlotAddr = partyAddr + (partySlotsCounter * 0xDC)

  showInfo(lastPartySlotAddr)
 elseif infoMode[infoIndex] == "Party" then
  local partySelectedSlotIndex = read8Bit(partySelectedSlotIndexAddr)
  local partySelectedPokemonAddr = partyAddr + (partySelectedSlotIndex * 0xDC)

  showInfo(partySelectedPokemonAddr)
 elseif infoMode[infoIndex] == "Party Stats" then
  local partyStatsSelectedSlotIndex = read8Bit(partyStatsSelectedSlotIndexAddr)
  local pokemonPartyStatsAddr = partyAddr + (partyStatsSelectedSlotIndex * 0xDC)

  showInfo(pokemonPartyStatsAddr)
 elseif infoMode[infoIndex] == "Box" then
  local currBoxIndex = read8Bit(currBoxIndexAddr)
  local boxSelectedSlotIndex = read8Bit(boxSelectedSlotIndexAddr)
  local boxSelectedPokemonAddr = boxAddr + (0x88 * boxSelectedSlotIndex) + (0x10 * currBoxIndex) + (0x88 * currBoxIndex * 0x1E)

  showInfo(boxSelectedPokemonAddr)
 elseif infoMode[infoIndex] == "Box Stats" then
  showInfo(pokemonBoxStatsAddr)
 end
end

function setSaveStateValues()
 local prevInitialSeedHigh = initialSeedHigh
 initialSeedHigh = userdata.get("initialSeedHigh")
 initialSeedLow = userdata.get("initialSeedLow")
 tempCurrentSeedLow = userdata.get("tempCurrentSeedLow")
 advances = userdata.get("advances")
 mtCounter = userdata.get("mtCounter")
 cgearSeed = userdata.get("cgearSeed")
 hitDelay = userdata.get("hitDelay")
 hitDate = userdata.get("hitDate")
 prevMTSeed = read32Bit(mtSeedAddr)

 if prevInitialSeedHigh ~= initialSeedHigh then
  printGameInfo()

  if initialSeedHigh ~= 0 then
   print(string.format("Initial Seed: %08X%08X", initialSeedHigh, initialSeedLow))
  end
 end
end

event.onloadstate(setSaveStateValues)

while not wrongGameVersion do
 setBackgroundBoxes()
 setDateTime()
 getTabInput()
 showRngInfo()

 if mode[index] ~= "None" then
  getRngInfoInput()

  if mode[index] ~= "Pokemon Info" then
   showTrainerIDs()
  end
 end

 if mode[index] == "Capture" then
  showInfo(enemyAddr + (0xDC * getSlotInput()))
 elseif mode[index] == "Breeding" then
  showPartyEggInfo()
 elseif mode[index] == "Roamer" then
  showRoamerInfo(roamerAddr)
 elseif mode[index] == "C-Gear" then
  showInfo(cgearEnemyAddr)
 elseif mode[index] == "Pokemon Info" then
  getInfoInput()
  showPokemonInfo()
 end

 emu.frameadvance()
end