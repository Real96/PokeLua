read16Bit = memory.readwordunsigned
read8Bit = memory.readbyte
rshift = bit.rshift
band = bit.band

local speciesNamesList = {
 "Rhydon", "Kangaskhan", "Nidoran♂", "Clefairy", "Spearow", "Voltorb", "Nidoking", "Slowbro",
 "Ivysaur", "Exeggutor", "Lickitung", "Exeggcute", "Grimer", "Gengar", "Nidoran♀", "Nidoqueen",
 "Cubone", "Rhyhorn", "Lapras", "Arcanine", "Mew", "Gyarados", "Shellder", "Tentacool", "Gastly",
 "Scyther", "Staryu", "Blastoise", "Pinsir", "Tangela", "MissingNo.", "MissingNo.", "Growlithe",
 "Onix", "Fearow", "Pidgey", "Slowpoke", "Kadabra", "Graveler", "Chansey", "Machoke", "Mr. Mime",
 "Hitmonlee", "Hitmonchan", "Arbok", "Parasect", "Psyduck", "Drowzee", "Golem", "MissingNo.",
 "Magmar", "MissingNo.", "Electabuzz", "Magneton", "Koffing", "MissingNo.", "Mankey", "Seel",
 "Diglett", "Tauros", "MissingNo.", "MissingNo.", "MissingNo.", "Farfetch'd", "Venonat",
 "Dragonite", "MissingNo.", "MissingNo.", "MissingNo.", "Doduo", "Poliwag", "Jynx", "Moltres",
 "Articuno", "Zapdos", "Ditto", "Meowth", "Krabby", "MissingNo.", "MissingNo.", "MissingNo.",
 "Vulpix", "Ninetales", "Pikachu", "Raichu", "MissingNo.", "MissingNo.", "Dratini", "Dragonair",
 "Kabuto", "Kabutops", "Horsea", "Seadra", "MissingNo.", "MissingNo.", "Sandshrew", "Sandslash",
 "Omanyte", "Omastar", "Jigglypuff", "Wigglytuff", "Eevee", "Flareon", "Jolteon", "Vaporeon",
 "Machop", "Zubat", "Ekans", "Paras", "Poliwhirl", "Poliwrath", "Weedle", "Kakuna", "Beedrill",
 "MissingNo.", "Dodrio", "Primeape", "Dugtrio", "Venomoth", "Dewgong", "MissingNo.", "MissingNo.",
 "Caterpie", "Metapod", "Butterfree", "Machamp", "MissingNo.", "Golduck", "Hypno", "Golbat",
 "Mewtwo", "Snorlax", "Magikarp", "MissingNo.", "MissingNo.", "Muk", "MissingNo.", "Kingler",
 "Cloyster", "MissingNo.", "Electrode", "Clefable", "Weezing", "Persian", "Marowak", "MissingNo.",
 "Haunter", "Abra", "Alakazam", "Pidgeotto", "Pidgeot", "Starmie", "Bulbasaur", "Venusaur",
 "Tentacruel", "MissingNo.", "Goldeen", "Seaking", "MissingNo.", "MissingNo.", "MissingNo.",
 "MissingNo.", "Ponyta", "Rapidash", "Rattata", "Raticate", "Nidorino", "Nidorina", "Geodude",
 "Porygon", "Aerodactyl", "MissingNo.", "Magnemite", "MissingNo.", "MissingNo.", "Charmander",
 "Squirtle", "Charmeleon", "Wartortle", "Charizard", "MissingNo.", "MissingNo.", "MissingNo.",
 "MissingNo.", "Oddish", "Gloom", "Vileplume", "Bellsprout", "Weepinbell", "Victreebel"}

local natureNamesList = {
 "Hardy", "Lonely", "Brave", "Adamant", "Naughty",
 "Bold", "Docile", "Relaxed", "Impish", "Lax",
 "Timid", "Hasty", "Serious", "Jolly", "Naive",
 "Modest", "Mild", "Quiet", "Bashful", "Rash",
 "Calm", "Gentle", "Sassy", "Careful", "Quirky"}

local versionAddr = read16Bit(0x13C)
local version
local languageAddr = read8Bit(0x14E)
local language = ""
local warning

local mode = {"None", "Gift Bot", "Stationary Bot", "Fishing Bot", "In-Game Trade Bot", "TID Bot", "Pokemon Info"}
local index = 1
local prevKey = {}
local showInstructionsText = false
local leftArrowColor
local rightArrowColor

local botState = savestate.create()
local botOneTime = false

local partyAddr
local partySlotsCounterAddr
local wildDVsAddr
local shinyFound = {false, "None"}

local botTargetFishingSpecies = 27  -- Input here the fishing bot target species index. You can find it in the link below
                                    -- https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_index_number_(Generation_I)
local fishedSpeciesAddr
local biteFlagAddr = 0xCD3D

local tidAddr
local TIDFound = false
local botTargetTIDs = {0, 1, 1337, 8453, 8411, 11233, 11111, 22222, 33333}  -- Input here the bot target TIDs

if versionAddr == 0x4C41 then  -- Check game version
 version = "Crystal"
elseif versionAddr == 0x4C42 then
 version = "Blue"
elseif versionAddr == 0x4C47 then
 version = "Gold"
elseif versionAddr == 0x4552 then
 version = "Red"
elseif versionAddr == 0x5247 then
 version = "Green"
elseif versionAddr == 0x4C53 then
 version = "Silver"
elseif versionAddr == 0x4559 then
 version = "Yellow"
else
 version = "Unknown"
end

if languageAddr == 0x04 or languageAddr == 0x91 or languageAddr == 0x9D then  -- Check game language and set addresses
 language = "USA"

 if version == "Blue" or version == "Red" then
  partyAddr = 0xD16B
  partySlotsCounterAddr = 0xD163
  wildDVsAddr = 0xCFF1
  fishedSpeciesAddr = 0xD059
  tidAddr = 0xD359
 elseif version == "Yellow" then
  partyAddr = 0xD16A
  partySlotsCounterAddr = 0xD162
  wildDVsAddr = 0xCFF0
  fishedSpeciesAddr = 0xD058
  tidAddr = 0xD358
 end
elseif languageAddr == 0xB8 or languageAddr == 0xD9 or languageAddr == 0xDC or languageAddr == 0xF5 then
 language = "JPN"
 partyAddr = 0xD12B
 partySlotsCounterAddr = 0xD123
 wildDVsAddr = 0xCFD8
 fishedSpeciesAddr = 0xD036
 tidAddr = 0xD2D8
else
 language = "EUR"

 if version == "Blue" or version == "Red" then
  partyAddr = 0xD170
  partySlotsCounterAddr = 0xD168
  wildDVsAddr = 0xCFF6
  fishedSpeciesAddr = 0xD05E
  tidAddr = 0xD35E
 elseif version == "Yellow" then
  partyAddr = 0xD16F
  partySlotsCounterAddr = 0xD167
  wildDVsAddr = 0xCFF5
  fishedSpeciesAddr = 0xD05D
  tidAddr = 0xD35D
 end
end

if version ~= "Blue" and version ~= "Red" and version ~= "Green" and version ~= "Yellow" then
 warning = " - Wrong game version! Use Blue/Red/Green/Yellow instead"
else
 warning = ""
end

print("Game Version: "..version..warning)
print("Language: "..language)
print()

function getInput()
 leftArrowColor = "gray"
 rightArrowColor = "gray"

 local key = input.get()

 if (key["1"] or key["numpad1"]) and (not prevKey["1"] and not prevKey["numpad1"]) then
  leftArrowColor = "orange"
  index = index - 1 < 1 and 7 or index - 1
 elseif (key["2"] or key["numpad2"]) and (not prevKey["2"] and not prevKey["numpad2"]) then
  rightArrowColor = "orange"
  index = index + 1 > 7 and 1 or index + 1
 end

 prevKey = key
 gui.text(1, 1, "Mode: "..mode[index])
 drawArrowLeft(100, 1, leftArrowColor)
 gui.text(110, 1, "1 - 2")
 drawArrowRight(138, 1, rightArrowColor)
end

function drawArrowLeft(a, b, c)
 gui.line(a, b + 3, a + 2, b + 5, c)
 gui.line(a, b + 3, a + 2, b + 1, c)
 gui.line(a, b + 3, a + 6, b + 3, c)
end

function drawArrowRight(a, b, c)
 gui.line(a, b + 3, a - 2, b + 5, c)
 gui.line(a, b + 3, a - 2, b + 1, c)
 gui.line(a, b + 3, a - 6, b + 3, c)
end

function getDVs(DVsAddr)
 local atkDefDVs = read8Bit(DVsAddr)
 local speSpcDVs = read8Bit(DVsAddr + 0x1)
 local atkDV = rshift(atkDefDVs, 4)
 local defDV = band(atkDefDVs, 0xF)
 local speDV = rshift(speSpcDVs, 4)
 local spcDV = band(speSpcDVs, 0xF)

 return atkDV, defDV, speDV, spcDV
end

function isShiny(atkDV, defDV, speDV, spcDV)
 return {defDV == 0xA and speDV == 0xA and spcDV == 0xA and
        (atkDV == 0x2 or atkDV == 0x3 or atkDV == 0x6 or atkDV == 0x7 or
         atkDV == 0xA or atkDV == 0xB or atkDV == 0xE or atkDV == 0xF), mode[index]}
end

function shinyBotLoop(pokemonDVsAddr)
 shinyFound = {false, "None"}
 botOneTime = false

 while not shinyFound[1] do
  savestate.save(botState)
  joypad.set(1, {A = true})
  local frameLimit

  if mode[index] == "Gift Bot" or mode[index] == "Stationary Bot" then
   frameLimit = 35
  elseif mode[index] == "Fishing Bot"  then
   frameLimit = 55
  elseif mode[index] == "In-Game Trade Bot" then
   frameLimit = 2560
  end

  local atkDefDVs = read8Bit(pokemonDVsAddr)
  local speSpcDVs = read8Bit(pokemonDVsAddr + 1)
  local previousAtkDefDVs = atkDefDVs
  local previousSpeSpcDVs = speSpcDVs

  local i = 0
  while atkDefDVs == previousAtkDefDVs and speSpcDVs == previousSpeSpcDVs and i < frameLimit do
   atkDefDVs = read8Bit(pokemonDVsAddr)
   speSpcDVs = read8Bit(pokemonDVsAddr + 1)
   emu.frameadvance()
   i = i + 1
  end

  if atkDefDVs ~= previousAtkDefDVs or speSpcDVs ~= previousSpeSpcDVs then
   local atkDV, defDV, speDV, spcDV = getDVs(pokemonDVsAddr)
   --print(atkDV.." "..defDV.." "..speDV.." "..spcDV)
   shinyFound = isShiny(atkDV, defDV, speDV, spcDV)
  end

  if not shinyFound[1] then
   savestate.load(botState)
   emu.frameadvance()
  end
 end
end

function showFoundShiny(pokemonDVsAddr)
 if shinyFound[1] and shinyFound[2] == mode[index] then
  local atkDV, defDV, speDV, spcDV = getDVs(pokemonDVsAddr)
  local hpDV = ((atkDV % 2) * 8) + ((defDV % 2) * 4) + ((speDV % 2) * 2) + (spcDV % 2)

  gui.text(1, 91, "Shiny Found!")
  gui.text(1, 100, string.format("Hp: %d", hpDV))
  gui.text(1, 109, string.format("Atk: %d", atkDV))
  gui.text(1, 118, string.format("Def: %d", defDV))
  gui.text(1, 127, string.format("SpC: %d", spcDV))
  gui.text(1, 136, string.format("Spe: %d", speDV))

  if not botOneTime then
   print("Shiny Found!")
   emu.pause()
   botOneTime = true
  end
 end
end

function shinyBot(pokemonDVsAddr)
 local key = joypad.get(1)

 if key.select then
  shinyBotLoop(pokemonDVsAddr)
 end

 showFoundShiny(pokemonDVsAddr)
end

function fishingBotBiteLoop()
 local biteFlag = false

 while not biteFlag do
  savestate.save(botState)
  joypad.set(1, {A = true})

  local i = 0
  while not biteFlag and i < 110 do
   biteFlag = read8Bit(biteFlagAddr) == 0x1
   emu.frameadvance()
   i = i + 1
  end

  if not biteFlag then
   savestate.load(botState)
   emu.frameadvance()
  end
 end
end

function fishingBotLoop()
 local targetFishedSpeciesCheck = read8Bit(fishedSpeciesAddr) == botTargetFishingSpecies

 while not targetFishedSpeciesCheck do
  fishingBotBiteLoop()
  targetFishedSpeciesCheck = read8Bit(fishedSpeciesAddr) == botTargetFishingSpecies

  if not targetFishedSpeciesCheck then
   savestate.load(botState)
   emu.frameadvance()
  end
 end

 for i = 1, 240 do
  emu.frameadvance()
 end

 shinyBotLoop(wildDVsAddr)
end

function fishingBot(pokemonDVsAddr)
 local key = joypad.get(1)

 if key.select then
  fishingBotLoop()
 end

 showFoundShiny(pokemonDVsAddr)
end

function reverseWord(word)
 return band(word, 0xFF) * 0x100 + rshift(word, 8)
end

function isTIDFound()
 local TID = reverseWord(read16Bit(tidAddr))

 for i = 1, table.getn(botTargetTIDs) do
  if TID == botTargetTIDs[i] then
   return true
  end
 end

 return false
end

function TIDBotLoop()
 TIDFound = false
 botOneTime = false

 while not TIDFound do
  savestate.save(botState)
  joypad.set(1, {A = true})

  local isTIDSet = read16Bit(tidAddr + 0x4) ~= 0

  local i = 0
  while not isTIDSet and i < 35 do
   isTIDSet = read16Bit(tidAddr + 0x4) ~= 0
   emu.frameadvance()
   i = i + 1
  end

  if isTIDSet then
   --print(reverseWord(read16Bit(tidAddr)))
   TIDFound = isTIDFound()
  end

  if not TIDFound then
   savestate.load(botState)
   emu.frameadvance()
  end
 end
end

function showFoundTID()
 if TIDFound then
  local TID = reverseWord(read16Bit(tidAddr))

  gui.text(1, 100, "TID Found!")
  gui.text(1, 109, "TID: "..TID)

  if not botOneTime then
   print("TID Found!")
   emu.pause()
   botOneTime = true
  end
 end
end

function TIDBot()
 local key = joypad.get(1)

 if key.select then
  TIDBotLoop()
 end

 showFoundTID()
end

function shinyText(atkDV, defDV, speDV, spcDV)
 return isShiny(atkDV, defDV, speDV, spcDV)[1] and "\tShiny" or ""
end

function showPartyPokemonInfo()
 local partySlotsCounter = read8Bit(partySlotsCounterAddr) - 1

 gui.text(1, 18, "Party natures:")

 for i = 0, partySlotsCounter do
  local pokemonSpeciesName = speciesNamesList[read8Bit(partyAddr + (i * 0x2C))]
  local pokemonEXPAddr = partyAddr + 0xE + (i * 0x2C)
  local pokemonDVsAddr = partyAddr + 0x1B + (i * 0x2C)
  local atkDV, defDV, speDV, spcDV = getDVs(pokemonDVsAddr)
  local pokemonEXP =  (0x10000 * read8Bit(pokemonEXPAddr)) + (0x100 * read8Bit(pokemonEXPAddr + 0x1)) + read8Bit(pokemonEXPAddr + 0x2)
  local pokemonNatureName = natureNamesList[(pokemonEXP % 25) + 1]

  if pokemonSpeciesName ~= nil then
   gui.text(1, (i + 3) * 9, tostring(i + 1).." "..pokemonSpeciesName.."\t"..pokemonNatureName..shinyText(atkDV, defDV, speDV, spcDV))
  end
 end
end

while warning == "" do
 getInput()

 if mode[index] == "Gift Bot" or mode[index] == "In-Game Trade Bot" then
  local partySlotsCounter = read8Bit(partySlotsCounterAddr) - 1
  local lastPartySlotDVsAddr = partyAddr + 0x1B + (partySlotsCounter * 0x2C)
  shinyBot(lastPartySlotDVsAddr)
 elseif mode[index] == "Stationary Bot" then
  shinyBot(wildDVsAddr)
 elseif mode[index] == "Fishing Bot" then
  fishingBot(wildDVsAddr)
 elseif mode[index] == "TID Bot" then
  TIDBot()
 elseif mode[index] == "Pokemon Info" then
  showPartyPokemonInfo()
 end

 emu.frameadvance()
end