read32Bit = ReadValue32
read8Bit = ReadValue8

local JUMP_DATA = {
 {0X343FD, 0X269EC3}, {0XA9FC6809, 0X1E278E7A}, {0XDDFF5051, 0X98520C4}, {0XF490B9A1, 0X7E1DBEC8},
 {0X43BA1741, 0X3E314290}, {0XD290BE81, 0X824E1920}, {0X82E3BD01, 0X844E8240}, {0XBF507A01, 0XFD864480},
 {0XF8C4F401, 0XDFB18900}, {0X7A19E801, 0XD9F71200}, {0X1673D001, 0X5E3E2400}, {0XB5E7A001, 0X65BC4800},
 {0X8FCF4001, 0X70789000}, {0XAF9E8001, 0X74F12000}, {0X9F3D0001, 0X39E24000}, {0X3E7A0001, 0XB3C48000},
 {0X7CF40001, 0X67890000}, {0XF9E80001, 0XCF120000}, {0XF3D00001, 0X9E240000}, {0XE7A00001, 0X3C480000},
 {0XCF400001, 0X78900000}, {0X9E800001, 0XF1200000}, {0X3D000001, 0XE2400000}, {0X7A000001, 0XC4800000},
 {0XF4000001, 0X89000000}, {0XE8000001, 0X12000000}, {0XD0000001, 0X24000000}, {0XA0000001, 0X48000000},
 {0X40000001, 0X90000000}, {0X80000001, 0X20000000}, {0X1, 0X40000000}, {0X1, 0X80000000}}

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

function LCRNG(s, mul, sum)
 local a = (mul >> 16) * (s % 0x10000) + (s >> 16) * (mul % 0x10000)
 local b = (mul % 0x10000) * (s % 0x10000) + (a % 0x10000) * 0x10000 + sum

 return b % 0x100000000
end

local tempCurrentSeed
 
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

function getIVs(seed)
 local ivs = {0, 0, 0, 0, 0, 0}
 seed = LCRNG(seed, 0x45C82BE5, 0xD2F65B55)  -- 3 cycle

 for i = 1, 6 do
  seed = LCRNG(seed, 0x343FD, 0x269EC3)
  ivs[i == 4 and 6 or i == 5 and 4 or i == 6 and 5 or i] = string.format("%02d", (seed >> 16) >> 11)
 end

 return ivs
end

function shinyCheck(highPID, lowPID, trainerID, trainerSID)
 local shinyTypeValue = trainerID ~ trainerSID ~ highPID ~ lowPID

 if shinyTypeValue < 8 then
  return shinyTypeValue == 0 and " (Square Shiny)" or " (Star Shiny)"
 end

 return ""
end

function getHPTypeAndPower(hpIV, atkIV, defIV, spAtkIV, spDefIV, spdIV)
 local hpType = (((hpIV & 1) + (2 * (atkIV & 1)) + (4 * (defIV & 1)) + (8 * (spdIV & 1)) + (16 * (spAtkIV & 1))
                + (32 * (spDefIV & 1))) * 15) // 63
 local hpPower = (((((hpIV >> 1) & 1) + (2 * ((atkIV >> 1) & 1)) + (4 * ((defIV >> 1) & 1)) + (8 * ((spdIV >> 1) & 1))
                 + (16 * ((spAtkIV >> 1) & 1)) + (32 * ((spDefIV >> 1) & 1))) * 40) // 63) + 30

 return string.format("HPower: %s %02d", HPTypeNamesList[hpType + 1], hpPower)
end

function getJirachiInfo(seed)
 local OTID = 40122
 seed = LCRNG(seed, 0x343FD, 0x269EC3)
 local OTSID = seed >> 16
 seed = LCRNG(seed, 0x343FD, 0x269EC3)
 local pokemonHighPID = seed >> 16
 seed = LCRNG(seed, 0x343FD, 0x269EC3)
 local pokemonLowPID = seed >> 16

 if (pokemonLowPID < 8 and 1 or 0) ~= (pokemonHighPID ~ OTID ~ OTSID) then
  pokemonHighPID = pokemonHighPID ~ 0x8000
 end

 local ivs = getIVs(seed)
 local pokemonPID = (pokemonHighPID << 16) + pokemonLowPID
 local shinyType = shinyCheck(pokemonHighPID, pokemonLowPID, OTID, OTSID)
 local natureIndex = pokemonPID % 25
 local info = string.format("PID: %08X %s\nNature: %s\nIVs: %s", pokemonPID, shinyType, natureNamesList[natureIndex + 1], table.concat(ivs, "/"))
 local hpTypeAndPower = getHPTypeAndPower(ivs[1], ivs[2], ivs[3], ivs[4], ivs[5], ivs[6])
 info = info.."\n"..hpTypeAndPower

 return info
end

local currentSeedAddr, initialSeed, advances

function onScriptStart()
 local gameLang = read8Bit(0x3)

 if gameLang == 0x45 then  -- U
  currentSeedAddr = 0x3502C8
 elseif gameLang == 0x4A then  -- J
  currentSeedAddr = read8Bit(0x0) == 0x47 and 0x387C18 or 0x387C38  -- Japan has two games editions
 elseif gameLang == 0x50 then  -- E
  currentSeedAddr = 0x33D888
 else  -- A
  currentSeedAddr = 0x337568
 end

 initialSeed = read32Bit(currentSeedAddr)
 tempCurrentSeed = initialSeed
 advances = 0
end

function onScriptUpdate()
 local currentSeed = read32Bit(currentSeedAddr)
 advances = advances + LCRNGDistance(tempCurrentSeed, currentSeed)
 local jirachiInfo = getJirachiInfo(currentSeed)
 local text = string.format("Initial Seed: %08X\nCurrent Seed: %08X\nAdvances: %d\n\nJirachi Info:\n%s",
                            initialSeed, currentSeed, advances, jirachiInfo)
 SetScreenText(text)
end

function onScriptCancel()
 SetScreenText("")
end

function onStateLoaded()
end

function onStateSaved()
end