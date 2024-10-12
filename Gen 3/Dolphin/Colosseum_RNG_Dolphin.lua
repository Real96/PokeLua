read32Bit = ReadValue32
read16Bit = ReadValue16
read8Bit = ReadValue8

local JUMP_DATA = {
 {0x343FD, 0x269EC3}, {0xA9FC6809, 0x1E278E7A}, {0xDDFF5051, 0x98520C4}, {0xF490B9A1, 0x7E1DBEC8},
 {0x43BA1741, 0x3E314290}, {0xD290BE81, 0x824E1920}, {0x82E3BD01, 0x844E8240}, {0xBF507A01, 0xFD864480},
 {0xF8C4F401, 0xDFB18900}, {0x7A19E801, 0xD9F71200}, {0x1673D001, 0x5E3E2400}, {0xB5E7A001, 0x65BC4800},
 {0x8FCF4001, 0x70789000}, {0xAF9E8001, 0x74F12000}, {0x9F3D0001, 0x39E24000}, {0x3E7A0001, 0xB3C48000},
 {0x7CF40001, 0x67890000}, {0xF9E80001, 0xCF120000}, {0xF3D00001, 0x9E240000}, {0xE7A00001, 0x3C480000},
 {0xCF400001, 0x78900000}, {0x9E800001, 0xF1200000}, {0x3D000001, 0xE2400000}, {0x7A000001, 0xC4800000},
 {0xF4000001, 0x89000000}, {0xE8000001, 0x12000000}, {0xD0000001, 0x24000000}, {0xA0000001, 0x48000000},
 {0x40000001, 0x90000000}, {0x80000001, 0x20000000}, {0x1, 0x40000000}, {0x1, 0x80000000}}

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
 "NONE", "BULBASAUR", "IVYSAUR", "VENUSAUR", "CHARMANDER", "CHARMELEON", "CHARIZARD", "SQUIRTLE", "WARTORTLE", "BLASTOISE",
 "CATERPIE", "METAPOD", "BUTTERFREE", "WEEDLE", "KAKUNA", "BEEDRILL", "PIDGEY", "PIDGEOTTO", "PIDGEOT", "RATTATA", "RATICATE",
 "SPEAROW", "FEAROW", "EKANS", "ARBOK", "PIKACHU", "RAICHU", "SANDSHREW", "SANDSLASH", "NIDORAN♀", "NIDORINA", "NIDOQUEEN",
 "NIDORAN♂", "NIDORINO", "NIDOKING", "CLEFAIRY", "CLEFABLE", "VULPIX", "NINETALES", "JIGGLYPUFF", "WIGGLYTUFF", "ZUBAT", "GOLBAT",
 "ODDISH", "GLOOM", "VILEPLUME", "PARAS", "PARASECT", "VENONAT", "VENOMOTH", "DIGLETT", "DUGTRIO", "MEOWTH", "PERSIAN", "PSYDUCK",
 "GOLDUCK", "MANKEY", "PRIMEAPE", "GROWLITHE", "ARCANINE", "POLIWAG", "POLIWHIRL", "POLIWRATH", "ABRA", "KADABRA", "ALAKAZAM",
 "MACHOP", "MACHOKE", "MACHAMP", "BELLSPROUT", "WEEPINBELL", "VICTREEBEL", "TENTACOOL", "TENTACRUEL", "GEODUDE", "GRAVELER",
 "GOLEM", "PONYTA", "RAPIDASH", "SLOWPOKE", "SLOWBRO", "MAGNEMITE", "MAGNETON", "FARFETCH'D", "DODUO", "DODRIO", "SEEL", "DEWGONG",
 "GRIMER", "MUK", "SHELLDER", "CLOYSTER", "GASTLY", "HAUNTER", "GENGAR", "ONIX", "DROWZEE", "HYPNO", "KRABBY", "KINGLER", "VOLTORB",
 "ELECTRODE", "EXEGGCUTE", "EXEGGUTOR", "CUBONE", "MAROWAK", "HITMONLEE", "HITMONCHAN", "LICKITUNG", "KOFFING", "WEEZING", "RHYHORN",
 "RHYDON", "CHANSEY", "TANGELA", "KANGASKHAN", "HORSEA", "SEADRA", "GOLDEEN", "SEAKING", "STARYU", "STARMIE", "MR.MIME", "SCYTHER",
 "JYNX", "ELECTABUZZ", "MAGMAR", "PINSIR", "TAUROS", "MAGIKARP", "GYARADOS", "LAPRAS", "DITTO", "EEVEE", "VAPOREON", "JOLTEON",
 "FLAREON", "PORYGON", "OMANYTE", "OMASTAR", "KABUTO", "KABUTOPS", "AERODACTYL", "SNORLAX", "ARTICUNO", "ZAPDOS", "MOLTRES",
 "DRATINI", "DRAGONAIR", "DRAGONITE", "MEWTWO", "MEW",
 -- Gen 2
 "CHIKORITA", "BAYLEEF", "MEGANIUM", "CYNDAQUIL", "QUILAVA", "TYPHLOSION", "TOTODILE", "CROCONAW", "FERALIGATR", "SENTRET", "FURRET",
 "HOOTHOOT", "NOCTOWL", "LEDYBA", "LEDIAN", "SPINARAK", "ARIADOS", "CROBAT", "CHINCHOU", "LANTURN", "PICHU", "CLEFFA", "IGGLYBUFF",
 "TOGEPI", "TOGETIC", "NATU", "XATU", "MAREEP", "FLAAFFY", "AMPHAROS", "BELLOSSOM", "MARILL", "AZUMARILL", "SUDOWOODO", "POLITOED",
 "HOPPIP", "SKIPLOOM", "JUMPLUFF", "AIPOM", "SUNKERN", "SUNFLORA", "YANMA", "WOOPER", "QUAGSIRE", "ESPEON", "UMBREON", "MURKROW",
 "SLOWKING", "MISDREAVUS", "UNOWN", "WOBBUFFET", "GIRAFARIG", "PINECO", "FORRETRESS", "DUNSPARCE", "GLIGAR", "STEELIX", "SNUBBULL",
 "GRANBULL", "QWILFISH", "SCIZOR", "SHUCKLE", "HERACROSS", "SNEASEL", "TEDDIURSA", "URSARING", "SLUGMA", "MAGCARGO", "SWINUB",
 "PILOSWINE", "CORSOLA", "REMORAID", "OCTILLERY", "DELIBIRD", "MANTINE", "SKARMORY", "HOUNDOUR", "HOUNDOOM", "KINGDRA", "PHANPY",
 "DONPHAN", "PORYGON2", "STANTLER", "SMEARGLE", "TYROGUE", "HITMONTOP", "SMOOCHUM", "ELEKID", "MAGBY", "MILTANK", "BLISSEY", "RAIKOU",
 "ENTEI", "SUICUNE", "LARVITAR", "PUPITAR", "TYRANITAR", "LUGIA", "HO-OH", "CELEBI",
 -- Gen 3
 "TREECKO", "GROVYLE", "SCEPTILE", "TORCHIC", "COMBUSKEN", "BLAZIKEN", "MUDKIP", "MARSHTOMP", "SWAMPERT", "POOCHYENA", "MIGHTYENA",
 "ZIGZAGOON", "LINOONE", "WURMPLE", "SILCOON", "BEAUTIFLY", "CASCOON", "DUSTOX", "LOTAD", "LOMBRE", "LUDICOLO", "SEEDOT", "NUZLEAF",
 "SHIFTRY", "TAILLOW", "SWELLOW", "WINGULL", "PELIPPER", "RALTS", "KIRLIA", "GARDEVOIR", "SURSKIT", "MASQUERAIN", "SHROOMISH", "BRELOOM",
 "SLAKOTH", "VIGOROTH", "SLAKING", "NINCADA", "NINJASK", "SHEDINJA", "WHISMUR", "LOUDRED", "EXPLOUD", "MAKUHITA", "HARIYAMA", "AZURILL",
 "NOSEPASS", "SKITTY", "DELCATTY", "SABLEYE", "MAWILE", "ARON", "LAIRON", "AGGRON", "MEDITITE", "MEDICHAM", "ELECTRIKE", "MANECTRIC",
 "PLUSLE", "MINUN", "VOLBEAT", "ILLUMISE", "ROSELIA", "GULPIN", "SWALOT", "CARVANHA", "SHARPEDO", "WAILMER", "WAILORD", "NUMEL",
 "CAMERUPT", "TORKOAL", "SPOINK", "GRUMPIG", "SPINDA", "TRAPINCH", "VIBRAVA", "FLYGON", "CACNEA", "CACTURNE", "SWABLU", "ALTARIA",
 "ZANGOOSE", "SEVIPER", "LUNATONE", "SOLROCK", "BARBOACH", "WHISCASH", "CORPHISH", "CRAWDAUNT", "BALTOY", "CLAYDOL", "LILEEP", "CRADILY",
 "ANORITH", "ARMALDO", "FEEBAS", "MILOTIC", "CASTFORM", "KECLEON", "SHUPPET", "BANETTE", "DUSKULL", "DUSCLOPS", "TROPIUS", "CHIMECHO",
 "ABSOL", "WYNAUT", "SNORUNT", "GLALIE", "SPHEAL", "SEALEO", "WALREIN", "CLAMPERL", "HUNTAIL", "GOREBYSS", "RELICANTH", "LUVDISC", "BAGON",
 "SHELGON", "SALAMENCE", "BELDUM", "METANG", "METAGROSS", "REGIROCK", "REGICE", "REGISTEEL", "LATIAS", "LATIOS", "KYOGRE", "GROUDON",
 "RAYQUAZA", "JIRACHI", "DEOXYS"}

local nationalDexList = {
 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26,
 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
 51,  52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74,
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

local catchRatesList = {
 -- Gen 1
 0, 45, 45, 45, 45, 45, 45, 45, 45, 45, 255, 120, 90, 255, 120, 90, 255, 120,
 45, 255, 127, 255, 90, 255, 90, 190, 75, 255, 90, 235, 120, 45, 235, 120,
 45, 150, 25, 190, 75, 170, 50, 255, 90, 255, 120, 45, 190, 75, 190, 120,
 255, 100, 255, 90, 190, 120, 190, 80, 190, 75, 255, 120, 90, 200, 100, 50,
 180, 90, 45, 255, 120, 45, 190, 60, 255, 120, 45, 190, 110, 190, 75, 190,
 110, 80, 190, 90, 190, 75, 190, 75, 190, 60, 190, 90, 45, 45, 190, 80, 225,
 60, 190, 60, 90, 80, 190, 110, 90, 90, 90, 190, 60, 120, 100, 70, 90, 90,
 225, 75, 225, 60, 225, 110, 90, 90, 45, 90, 90, 90, 80, 255, 45, 80, 35, 45,
 45, 45, 45, 45, 45, 45, 45, 45, 45, 70, 25, 25, 25, 45, 45, 45, 3, 45,
 -- Gen2
 45, 180, 45, 45, 180, 45, 45, 180, 45, 255, 90, 255, 90, 255, 90, 255, 90,
 90, 190, 75, 190, 150, 170, 190, 45, 190, 75, 235, 120, 45, 45, 190, 75, 65,
 45, 255, 120, 45, 45, 235, 120, 75, 255, 90, 45, 45, 30, 70, 90, 225, 45, 60,
 190, 75, 190, 60, 25, 190, 75, 45, 25, 190, 45, 60, 120, 60, 190, 120, 225,
 75, 60, 190, 75, 45, 90, 15, 225, 45, 45, 120, 60, 45, 45, 45, 75, 45, 45, 45,
 45, 45, 30, 15, 15, 15, 45, 45, 10, 3, 3, 45,
 -- Gen3
 45, 45, 45, 45, 45, 45, 45, 45, 45, 255, 127, 255, 90, 255, 120, 45, 120, 45,
 255, 120, 45, 255, 120, 45, 200, 90, 255, 45, 235, 120, 45, 200, 75, 255, 90,
 255, 120, 45, 255, 120, 45, 190, 120, 45, 255, 200, 150, 255, 255, 120, 90, 120,
 180, 90, 45, 180, 90, 120, 80, 200, 200, 150, 150, 150, 225, 75, 225, 60, 125,
 60, 255, 150, 90, 255, 60, 255, 255, 120, 45, 190, 60, 255, 80, 90, 90, 100, 90,
 190, 75, 205, 155, 255, 90, 45, 45, 45, 45, 255, 60, 45, 200, 225, 90, 190, 90,
 45, 45, 30, 125, 190, 75, 255, 120, 45, 255, 60, 60, 25, 225, 45, 45, 80, 3, 3,
 15, 3, 3, 3, 3, 3, 5, 5, 3, 3, 3}

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

 return dist > 1000000 and dist - 0x100000000 or dist
end

local boxSelectedPokemonAddr, enemyAddr, boxFlagAddr, currentSeedAddr, boxPointerAddr, pointerAddr, initialSeed, advances

function onScriptStart()
 local gameLang = read8Bit(0x3)

 if gameLang == 0x45 then -- U
  boxSelectedPokemonAddr = 0x3A95EC
  enemyAddr = 0x473070
  boxFlagAddr = 0x478B1A
  currentSeedAddr = 0x478C90
  boxPointerAddr = 0x47ADB8
  pointerAddr = 0x7EFDCC
 elseif gameLang == 0x4A then -- J
  boxSelectedPokemonAddr = 0x395CBC
  enemyAddr = 0x45E750
  boxFlagAddr = 0x4641EA
  currentSeedAddr = 0x464360
  boxPointerAddr = 0x466468
  pointerAddr = 0x75E088
 else -- E
  boxSelectedPokemonAddr = 0x3F6A6C
  enemyAddr = 0x4C0508
  boxFlagAddr = 0x4C5FBA
  currentSeedAddr = 0x4C6130
  boxPointerAddr = 0x4C8268
  pointerAddr = 0x90C300
 end

 initialSeed = read32Bit(currentSeedAddr)
 tempCurrentSeed = initialSeed
 advances = 0
end

function getTrainerIDs(pointer)
 local trainerIDsAddr = pointer + 0x7FFE42E0
 local trainerIDs = read32Bit(trainerIDsAddr)
 local TID = trainerIDs & 0xFFFF
 local SID = trainerIDs >> 16

 return TID, SID
end

function setPadding(maxLength, goodSpacing, stringVar)
 local spaces = ""
 local stringVarLength = string.len(stringVar)

 if stringVarLength <= maxLength then
  local padding = maxLength - stringVarLength

  for i = 0, padding + goodSpacing do
   spaces = spaces.." "
  end
 end

 return spaces
end

function calcCatchRate(HP, bonusBall, rate)
 if HP ~= 0 then
  local a = (HP * rate * bonusBall) // (3 * HP)

  return 1048560 // math.sqrt(math.sqrt(16711680 // a))
 end

 return 0
end

function getPokemonInfo(addr, trainerTID, trainerSID)
 trainerTID = trainerTID or nil
 trainerSID = trainerSID or nil

 local pokemonPID = read32Bit(addr)
 local speciesDexIndex = read16Bit(addr - 0x4)
 local OTSID = trainerSID and trainerSID or read16Bit(addr + 0x10)
 local OTID = trainerTID and trainerTID or read16Bit(addr + 0x12)

 local ivsAddr = addr + 0xA1
 local hpIV = read8Bit(ivsAddr)
 local atkIV = read8Bit(ivsAddr + 0x2)
 local defIV = read8Bit(ivsAddr + 0x4)
 local spAtkIV = read8Bit(ivsAddr + 0x6)
 local spDefIV = read8Bit(ivsAddr + 0x8)
 local spdIV = read8Bit(ivsAddr + 0xA)

 local speciesDexNumber = nationalDexList[((speciesDexIndex > 411 or speciesDexIndex < 1) and 0 or speciesDexIndex) + 1] + 1
 local speciesName = speciesNamesList[speciesDexNumber]
 speciesName = speciesName..setPadding(10, 5, speciesName)
 local natureName = natureNamesList[(pokemonPID % 25) + 1]
 natureName = natureName..setPadding(7, 9, natureName)

 local hpType = (((hpIV & 1) + (2 * (atkIV & 1)) + (4 * (defIV & 1)) + (8 * (spdIV & 1)) + (16 * (spAtkIV & 1))
                + (32 * (spDefIV & 1))) * 15) // 63
 local hpPower = (((((hpIV >> 1) & 1) + (2 * ((atkIV >> 1) & 1)) + (4 * ((defIV >> 1) & 1)) + (8 * ((spdIV >> 1) & 1))
                 + (16 * ((spAtkIV >> 1) & 1)) + (32 * ((spDefIV >> 1) & 1))) * 40) // 63) + 30

 local catchRateValue = calcCatchRate(read16Bit(addr + 0x86), 1, catchRatesList[speciesDexNumber])

 return pokemonPID, OTSID, OTID, speciesName, natureName, hpIV, atkIV, defIV, spAtkIV, spDefIV, spdIV, hpType, hpPower, catchRateValue
end

function isBoxOpened()
 return read16Bit(boxFlagAddr) == 0x391
end

function shinyCheck(PID, trainerID, trainerSID)
 local lowPID = PID & 0xFFFF
 local highPID = PID >> 16
 local shinyTypeValue = trainerID ~ trainerSID ~ lowPID ~ highPID

 if shinyTypeValue < 8 then
  return shinyTypeValue == 0 and " (Square)   " or " (Star)     "
 end

 return "            "
end

function getPokemonInfoText(pointer, trainerTID, trainerSID)
 local text = ""

 local boxPID, boxOTID, boxOTSID, boxSpeciesName, boxNatureName, boxHpIV, boxAtkIV, boxDefIV, boxSpAtkIV, boxSpDefIV, boxSpdIV, boxHpType,
       boxHpPower, boxCatchRateValue = getPokemonInfo(isBoxOpened() and boxSelectedPokemonAddr or read32Bit(boxPointerAddr) + 0xBA0)  -- Current selected Pokémon or 1st slot of 1st box

 for i = 0, 5 do
  local enemyPID, enemyOTID, enemyOTSID, enemySpeciesName, enemyNatureName, enemyHpIV, enemyAtkIV, enemyDefIV, enemySpAtkIV, enemySpDefIV,
        enemySpdIV, enemyHpType, enemyHpPower, enemyCatchRateValue = getPokemonInfo(enemyAddr + (0x138 * i), trainerTID, trainerSID)

  local partyAddr = pointer + 0x7FFE42E8
  local partyPID, partyOTID, partyOTSID, partySpeciesName, partyNatureName, partyHpIV, partyAtkIV, partyDefIV, partySpAtkIV, partySpDefIV,
        partySpdIV, partyHpType, partyHpPower, partyCatchRateValue = getPokemonInfo(partyAddr + (0x138 * i))

  local speciesText = string.format("Species: %sSpecies: %s", enemySpeciesName, partySpeciesName)..(i == 0 and string.format("Species: %s", boxSpeciesName) or "")
  local PIDsText = string.format("\nPID: %08X%sPID: %08X%s", enemyPID, shinyCheck(enemyPID, enemyOTID, enemyOTSID), partyPID, shinyCheck(partyPID, partyOTID, partyOTSID))..
                   (i == 0 and string.format("PID: %08X%s", boxPID, shinyCheck(boxPID, boxOTID, boxOTSID)) or "")
  local naturesText = string.format("\nNature: %sNature: %s", enemyNatureName, partyNatureName)..(i == 0 and string.format("Nature: %s", boxNatureName) or "")
  local ivsText = string.format("\nIVs: %02d/%02d/%02d/%02d/%02d/%02d   IVs: %02d/%02d/%02d/%02d/%02d/%02d",
                                enemyHpIV, enemyAtkIV, enemyDefIV, enemySpAtkIV, enemySpDefIV, enemySpdIV, partyHpIV, partyAtkIV, partyDefIV, partySpAtkIV, partySpDefIV, partySpdIV)..
                                (i == 0 and string.format("   IVs: %02d/%02d/%02d/%02d/%02d/%02d", boxHpIV, boxAtkIV, boxDefIV, boxSpAtkIV, boxSpDefIV, boxSpdIV) or "")
  local HPText = string.format("\nHPower: %s %02d", HPTypeNamesList[enemyHpType + 1], enemyHpPower)..setPadding(11, 5, string.format("%s %02d", HPTypeNamesList[enemyHpType + 1], enemyHpPower))..
                 string.format("HPower: %s %02d", HPTypeNamesList[partyHpType + 1], partyHpPower)..
                 (i == 0 and setPadding(11, 5, string.format("%s %02d", HPTypeNamesList[partyHpType + 1], partyHpPower))..
                 string.format("HPower: %s %02d", HPTypeNamesList[boxHpType + 1], boxHpPower) or "")
  local catchRngText = string.format("\nCatch Rate Value: %d\n\n", enemyCatchRateValue)

  text = text..speciesText..PIDsText..naturesText..ivsText..HPText..catchRngText
 end

 return text
end

function onScriptUpdate()
 local currentSeed = read32Bit(currentSeedAddr)
 advances = advances + LCRNGDistance(tempCurrentSeed, currentSeed)
 local pointer = read32Bit(pointerAddr)
 local trainerTID, trainerSID = 0, 0

 local RNGInfoText = string.format("Initial Seed: %08X\nCurrent Seed: %08X\nAdvances: %d", initialSeed, currentSeed, advances)
 local infoText = "\n\n"

 if pointer ~= 0 then
  trainerTID, trainerSID = getTrainerIDs(pointer)
  infoText = string.format("\n\nOpponent                 Party                    Box\n\n")..getPokemonInfoText(pointer, trainerTID, trainerSID)
 end

 local IDsInfoText = string.format("\nTID: %05d\nSID: %05d", trainerTID, trainerSID)

 SetScreenText(RNGInfoText..infoText..IDsInfoText)
end

function onScriptCancel()
 SetScreenText("")
end

function onStateLoaded()
end

function onStateSaved()
end