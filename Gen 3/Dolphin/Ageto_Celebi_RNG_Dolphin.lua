read32Bit = ReadValue32
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

local initialSeed, tempCurrentSeed, advances

function setInitialSeed(seed)
 initialSeed = seed
 tempCurrentSeed = initialSeed
 advances = 0
end

local prevInitialSeed, initalSeedSetFlag

function getInitialSeeding(seed)
 if initialSeed == 0 and prevInitialSeed ~= seed then
  initalSeedSetFlag = initalSeedSetFlag + 1

  if initalSeedSetFlag == 2 then
    setInitialSeed(seed)
  end

  prevInitialSeed = seed
 end

 return prevInitialSeed
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

 return dist > 1000000 and dist - 0x100000000 or dist
end

function getIVs(iv1, iv2)
 local ivs = {0, 0, 0, 0, 0, 0}
 ivs[1] = string.format("%02d", iv1 & 0x1F)
 ivs[2] = string.format("%02d", (iv1 >> 5) & 0x1F)
 ivs[3] = string.format("%02d", (iv1 >> 10) & 0x1F)
 ivs[4] = string.format("%02d", (iv2 >> 5) & 0x1F)
 ivs[5] = string.format("%02d", (iv2 >> 10) & 0x1F)
 ivs[6] = string.format("%02d", iv2 & 0x1F)

 return ivs
end

function getPID(seed)
 local trainerID = 31121
 local trainerSID = 0

 repeat  -- Shiny lock reroll
  seed = LCRNG(seed, 0x343FD, 0x269EC3)
  highPID = seed >> 16
  seed = LCRNG(seed, 0x343FD, 0x269EC3)
  lowPID = seed >> 16
 until (trainerID ~ trainerSID ~ highPID ~ lowPID) > 8

 return (highPID << 16) + lowPID
end

function getHPTypeAndPower(hpIV, atkIV, defIV, spAtkIV, spDefIV, spdIV)
 local hpType = (((hpIV & 1) + (2 * (atkIV & 1)) + (4 * (defIV & 1)) + (8 * (spdIV & 1)) + (16 * (spAtkIV & 1))
                + (32 * (spDefIV & 1))) * 15) // 63
 local hpPower = (((((hpIV >> 1) & 1) + (2 * ((atkIV >> 1) & 1)) + (4 * ((defIV >> 1) & 1)) + (8 * ((spdIV >> 1) & 1))
                 + (16 * ((spAtkIV >> 1) & 1)) + (32 * ((spDefIV >> 1) & 1))) * 40) // 63) + 30

 return string.format("HPower: %s %02d", HPTypeNamesList[hpType + 1], hpPower)
end

function getCelebiInfo(seed)
 seed = LCRNG(seed, 0x3C78F019, 0x7C93616E)  -- 22 cycles
 seed = LCRNG(seed, 0x343FD, 0x269EC3)
 local iv1 = seed >> 16
 seed = LCRNG(seed, 0x343FD, 0x269EC3)
 local iv2 = seed >> 16
 local ivs = getIVs(iv1, iv2)
 seed = LCRNG(seed, 0x343FD, 0x269EC3)
 local ability = (seed >> 16) & 1
 local pokemonPID = getPID(seed)
 local natureIndex = pokemonPID % 25
 local info = string.format("PID: %08X\nNature: %s\nIVs: %s", pokemonPID, natureNamesList[natureIndex + 1], table.concat(ivs, "/"))
 local hpTypeAndPower = getHPTypeAndPower(ivs[1], ivs[2], ivs[3], ivs[4], ivs[5], ivs[6])
 info = info.."\n"..hpTypeAndPower

 return info
end

function onScriptStart()
 initialSeed = 0
 prevInitialSeed = 0
 tempCurrentSeed = 0
 initalSeedSetFlag = 0
 advances = 0
end

function onScriptUpdate()
 local currentSeed = read32Bit(0x477098)
 getInitialSeeding(currentSeed)
 advances = advances + LCRNGDistance(tempCurrentSeed, currentSeed)
 local celebiInfo = getCelebiInfo(currentSeed)
 local text = string.format("Visual Advances: %d\n\nInitial Seed: %08X\nCurrent Seed: %08X\nAdvances: %d\n\nCelebi Info:\n%s",
                            GetFrameCount(), initialSeed, currentSeed, advances, celebiInfo)
 SetScreenText(text)
end

function onScriptCancel()
 SetScreenText("")
end

function onStateLoaded()
end

function onStateSaved()
end