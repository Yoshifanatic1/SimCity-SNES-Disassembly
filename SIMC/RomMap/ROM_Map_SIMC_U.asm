
macro SIMC_GameSpecificAssemblySettings()
	!ROM_SIMC_U = $0001							;\ These defines assign each ROM version with a different bit so version difference checks will work. Do not touch them!
	!ROM_SIMC_E = $0002							;|
	!ROM_SIMC_J = $0004							;|
	!ROM_SIMC_F = $0008							;|
	!ROM_SIMC_G = $0010							;/

	%SetROMToAssembleForHack(SIMC_U, !ROMID)
endmacro

macro SIMC_LoadGameSpecificMainSNESFiles()
	incsrc ../Misc_Defines_SIMC.asm
	incsrc ../RAM_Map_SIMC.asm
	incsrc ../Routine_Macros_SIMC.asm
	incsrc ../SNES_Macros_SIMC.asm
endmacro

macro SIMC_LoadGameSpecificMainSPC700Files()
	incsrc ../SPC700/ARAM_Map_SIMC.asm
	incsrc ../Misc_Defines_SIMC.asm
	incsrc ../SPC700/SPC700_Macros_SIMC.asm
endmacro

macro SIMC_LoadGameSpecificMainExtraHardwareFiles()
endmacro

macro SIMC_LoadGameSpecificMSU1Files()
endmacro

macro SIMC_GlobalAssemblySettings()
	!Define_Global_ApplyAsarPatches = !FALSE
	!Define_Global_InsertRATSTags = !TRUE
	!Define_Global_IgnoreCodeAlignments = !FALSE
	!Define_Global_IgnoreOriginalFreespace = !FALSE
	!Define_Global_CompatibleControllers = !Controller_StandardJoypad
	!Define_Global_DisableROMMirroring = !FALSE
	!Define_Global_CartridgeHeaderVersion = $00
	!Define_Global_FixIncorrectChecksumHack = !FALSE
	!Define_Global_ROMFrameworkVer = 1
	!Define_Global_ROMFrameworkSubVer = 0
	!Define_Global_ROMFrameworkSubSubVer = 1
	!Define_Global_AsarChecksum = $0000
	!Define_Global_LicenseeName = "Nintendo"
	!Define_Global_DeveloperName = "Nintendo/Maxis"
	!Define_Global_ReleaseDate = "1991"
	!Define_Global_BaseROMMD5Hash = "23715fc7ef700b3999384d5be20f4db5"

	!Define_Global_MakerCode = "01"
	!Define_Global_GameCode = "xxxx"
	!Define_Global_ReservedSpace = $00,$00,$00,$00,$00,$00
	!Define_Global_ExpansionFlashSize = !ExpansionMemorySize_0KB
	!Define_Global_ExpansionRAMSize = !ExpansionMemorySize_0KB
	!Define_Global_IsSpecialVersion = $00
	!Define_Global_InternalName = "SIMCITY              "
	!Define_Global_ROMLayout = !ROMLayout_LoROM
	!Define_Global_ROMType = !ROMType_ROM_RAM_SRAM
	!Define_Global_CustomChip = !Chip_None
	!Define_Global_ROMSize = !ROMSize_512KB
	!Define_Global_SRAMSize = !SRAMSize_32KB
	!Define_Global_Region = !Region_NorthAmerica
	!Define_Global_LicenseeID = $01
	!Define_Global_VersionNumber = $00
	!Define_Global_ChecksumCompliment = !Define_Global_Checksum^$FFFF
	!Define_Global_Checksum = $39B3
	!UnusedNativeModeVector1 = $FFFF
	!UnusedNativeModeVector2 = $FFFF
	!NativeModeCOPVector = CODE_008211
	!NativeModeBRKVector = CODE_008239
	!NativeModeAbortVector = CODE_008000
	!NativeModeNMIVector = CODE_0080B2
	!NativeModeResetVector = CODE_008000
	!NativeModeIRQVector = CODE_008210
	!UnusedEmulationModeVector1 = $FFFF
	!UnusedEmulationModeVector2 = $FFFF
	!EmulationModeCOPVector = CODE_008000
	!EmulationModeBRKVector = CODE_008000
	!EmulationModeAbortVector = CODE_008000
	!EmulationModeNMIVector = CODE_0080B2
	!EmulationModeResetVector = CODE_008000
	!EmulationModeIRQVector = CODE_008210
	%LoadExtraRAMFile("SRAM_Map_SIMC.asm")
endmacro

macro SIMC_LoadROMMap()
	%SIMCBank00Macros(!BANK_00, !BANK_00)
	%SIMCBank01Macros(!BANK_01, !BANK_01)
	%SIMCBank02Macros(!BANK_02, !BANK_02)
	%SIMCBank03Macros(!BANK_03, !BANK_03)
	%SIMCBank04Macros(!BANK_04, !BANK_04)
	%SIMCBank05Macros(!BANK_05, !BANK_05)
	%SIMCBank06Macros(!BANK_06, !BANK_06)
	%SIMCBank07Macros(!BANK_07, !BANK_0F)
endmacro
