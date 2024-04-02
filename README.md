# PokeLua
Lua scripts useful for RNG abusing in Pokémon games.

Join [Pokemon RNG](https://www.pokemonrng.com) or [Devon Studios](https://devonstudios.it) discord servers to talk about RNG or for assistance!

[![PokemonRNG](https://discordapp.com/assets/07dca80a102d4149e9736d4b162cff6f.ico)](https://www.discord.gg/d8JuAvg)
[![Devon Studios](https://discordapp.com/assets/07dca80a102d4149e9736d4b162cff6f.ico)](https://discord.gg/7gNVdkdBwA)

## Gen 1
### RBG/Y
* Gift Bot
* Stationary Bot
* Fishing Bot
* In-Game Trade Bot
* TID Bot
* Party Pokemon Info checking

## Gen 2 - _soon_
### GS/C

## Gen 3
### RS/FRLG/E
* Rng info checking
* Wild Pokemon info checking
* Breeding info checking
* Roamer Pokemon info checking
* Trainer info checking
* TID Bot (FRLG/E only)
* Party Pokemon info checking
* Box Pokemon info checking

## Gen 4
### DP/Pt/HGSS
* Rng info checking
* Wild Pokemon info checking
* Breeding info checking
* Roamer Pokemon info checking
* Trainer info checking
* Party Pokemon info checking
* Box Pokemon info checking

## Gen 5
### BW/B2W2
* Rng info checking
* Wild Pokemon info checking
* Breeding info checking
* Roamer Pokemon info checking (BW)
* C-Gear Pokemon info checking
* Trainer info checking
* Party Pokemon info checking
* Box Pokemon info checking

## Supported emulators
### mGBA
Use development vesion of date `19/03/2024`: [link](https://s3.amazonaws.com/mgba/build/mGBA-build-2024-03-19-win64-8335-c80f3afd7708e2e7d2f0f5175ba21fa2b70a424c.7z)

Latest dev version has a [bug](https://github.com/mgba-emu/mgba/issues/3178) bug which causes the app to crash. Once the error is fixed, you'll be able to use latest development build.

### Dolphin
Use this build which supports lua core: [link](https://github.com/Real96/Dolphin-Lua-Core/releases)

### DeSmuMe
Use version `0.9.11_x86_dev+`: [link](https://sourceforge.net/projects/desmume/files/desmume/0.9.11/desmume-0.9.11-win32-dev.zip/download)

1) Download the file `lua5.1.dll`: [link](https://sourceforge.net/projects/luabinaries/files/5.1.5/Windows%20Libraries/Dynamic/lua-5.1.5_Win32_dll17_lib.zip/download)
2) Move it in DeSmuMe folder
3) Rename it as `lua51.dll`

#### Final folder:
![image](https://github.com/Real96/PokeLua/assets/20956021/e6a21f63-ba96-4cc6-82fa-e9fba93537c6)

### BizHawk
Use latest release: [link](https://github.com/TASEmulators/BizHawk/releases)

## Notes for mGBA scripts
* Be sure to enlarge enough the lua window to avoid text flickering or emulation lagging
* Every time you need to save or load a state, hold `Shift` + `(n)`/`(n)` (ex. `Shift` + `1` to save a state in slot 1 or `1` to load the state in slot 1) with game unpaused

## Notes for DeSmuMe scripts
* Everytime you need to restart the game, press the button `Restart` in the lua window
* Every time you need to save or load a state, pause the game and hold `Shift` + `F(n)`/`F(n)` (ex. `Shift` + `F1` to save a state in slot 1 or `F1` to load the state in slot 1) for some seconds, until you see the message `Saved State (n)`/`Loaded State (n)` appearing on the screen for less than a second


## Credits:
* [Kaphotics](https://github.com/kwsch) for the research and for his [gen3](https://projectpokemon.org/home/forums/topic/15187-gen-3-lua-scripts/) and [gen5](https://projectpokemon.org/home/forums/topic/15140-pokemon-bw-lua-scripts/) scripts
* [Admiral_Fish](https://github.com/Admiral-Fish), [bumba](https://github.com/pkmnbumba), and [EzPzStreamz](https://github.com/SteveCookTU) for the research and for their great app [PokeFinder](https://github.com/Admiral-Fish/PokeFinder) always up to date
* [zep715](https://github.com/zep715) for his [gen1](https://github.com/zep715/rbylua) scripts
* [wwwwwwzx](https://github.com/wwwwwwzx) for his [gen2](https://github.com/wwwwwwzx/gsclua) scripts
* [SciresM](https://github.com/SciresM), Zari, [amab](https://github.com/AskMeAboutBirds), [OmegaDonut](https://github.com/OmegaDonut), [Bond697](https://github.com/Bond697), [Lincoln-LM](https://github.com/Lincoln-LM), [StarfBerry](https://github.com/StarfBerry) and all the other Pokémon researchers!
* [MKDasher](https://github.com/mkdasher) for his [gen4/gen5](https://www.dropbox.com/s/qx2fo1zc44p1jr7/Pokemon%20Gen%204-5%20Lua%20script.rar) scripts
* [BizHawk](https://github.com/TASEmulators/BizHawk), [DeSmuMe](https://github.com/TASEmulators/desmume), [mGBA](https://github.com/mgba-emu/mgba), [VBA-ReRecording](https://github.com/TASEmulators/vba-rerecording) devs
* [SwareJonge](https://github.com/SwareJonge) for his [Dolphin version](https://github.com/SwareJonge/Dolphin-Lua-Core) with lua scripts support
