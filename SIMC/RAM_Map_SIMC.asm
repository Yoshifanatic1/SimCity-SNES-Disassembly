
!RAM_SIMC_TitleScreenAndMenu_Layer1XPosLo = $000016
!RAM_SIMC_TitleScreenAndMenu_Layer1XPosHi = !RAM_SIMC_TitleScreenAndMenu_Layer1XPosLo+$01
!RAM_SIMC_TitleScreenAndMenu_Layer1YPosLo = $000018
!RAM_SIMC_TitleScreenAndMenu_Layer1YPosHi = !RAM_SIMC_TitleScreenAndMenu_Layer1YPosLo+$01
!RAM_SIMC_TitleScreenAndMenu_Layer2XPosLo = $00001A
!RAM_SIMC_TitleScreenAndMenu_Layer2XPosHi = !RAM_SIMC_TitleScreenAndMenu_Layer2XPosLo+$01
!RAM_SIMC_TitleScreenAndMenu_Layer2YPosLo = $00001C
!RAM_SIMC_TitleScreenAndMenu_Layer2YPosHi = !RAM_SIMC_TitleScreenAndMenu_Layer2YPosLo+$01
!RAM_SIMC_TitleScreenAndMenu_Layer3XPosLo = $00001E
!RAM_SIMC_TitleScreenAndMenu_Layer3XPosHi = !RAM_SIMC_TitleScreenAndMenu_Layer3XPosLo+$01
!RAM_SIMC_TitleScreenAndMenu_Layer3YPosLo = $000020
!RAM_SIMC_TitleScreenAndMenu_Layer3YPosHi = !RAM_SIMC_TitleScreenAndMenu_Layer3YPosLo+$01

!RAM_SIMC_Global_CurrentScenario = $000040

!RAM_SIMC_Global_ScreenDisplayRegister = $00005F
!RAM_SIMC_Global_OAMSizeAndDataAreaDesignation = $000060
!RAM_SIMC_Global_BGModeAndTileSizeSetting = $000061
!RAM_SIMC_Global_BG1AddressAndSize = $000062
!RAM_SIMC_Global_BG2AddressAndSize = $000063
!RAM_SIMC_Global_BG3AddressAndSize = $000064
!RAM_SIMC_Global_BG4AddressAndSize = $000065
!RAM_SIMC_Global_BG1And2TileDataDesignation = $000066
!RAM_SIMC_Global_BG3And4TileDataDesignation = $000067
!RAM_SIMC_Global_MainScreenLayers = $000068
!RAM_SIMC_Global_SubScreenLayers = $000069
!RAM_SIMC_Global_MainScreenWindowMask = $00006A
!RAM_SIMC_Global_SubScreenWindowMask = $00006B
!RAM_SIMC_Global_ColorMathInitialSettings = $00006C
!RAM_SIMC_Global_ColorMathSelectAndEnable = $00006D
!RAM_SIMC_Global_FixedColorData = $00006E
!RAM_SIMC_Global_ObjectAndColorWindowSettings = $00006F
!RAM_SIMC_Global_BGWindowLogicSettings = $000070
!RAM_SIMC_Global_BG1And2WindowMaskSettings = $000071
!RAM_SIMC_Global_BG3And4WindowMaskSettings = $000072

!RAM_SIMC_Global_HDMAEnable = $0000B5

; $0000D7 = HDMA related
; #$01 = Map view
; #$02 = Magnifying glass view

!RAM_SIMC_Global_OnScreenCursorXPosLo = $00025D
!RAM_SIMC_Global_OnScreenCursorXPosHi = !RAM_SIMC_Global_OnScreenCursorXPosLo+$01
!RAM_SIMC_Global_OnScreenCursorYPosLo = $00025F
!RAM_SIMC_Global_OnScreenCursorYPosHi = !RAM_SIMC_Global_OnScreenCursorYPosLo+$01

!RAM_SIMC_City_TriggerWrightMessageFlagLo = $000395
!RAM_SIMC_City_TriggerWrightMessageFlagHi = !RAM_SIMC_City_TriggerWrightMessageFlagLo+$01
!RAM_SIMC_City_CurrentWrightMessage = $000397

!RAM_SIMC_Global_MapNumOnesDigit = $000B27
!RAM_SIMC_Global_MapNumTensDigit = $000B28
!RAM_SIMC_Global_MapNumHundredsDigit = $000B29

!RAM_SIMC_City_CurrentYearLo = $000B53
!RAM_SIMC_City_CurrentYearHi = !RAM_SIMC_City_CurrentYearLo+$01
!RAM_SIMC_City_CurrentMonthLo = $000B55
!RAM_SIMC_City_CurrentMonthHi = !RAM_SIMC_City_CurrentMonthLo+$01
!RAM_SIMC_City_DifficultyLevel = $000B57

!RAM_SIMC_City_CurrentFundsLo = $000B9D
!RAM_SIMC_City_CurrentFundsMid = !RAM_SIMC_City_CurrentFundsLo+$01
!RAM_SIMC_City_CurrentFundsHi = !RAM_SIMC_City_CurrentFundsLo+$02

!RAM_SIMC_City_CurrentPopulationLo = $000BA5
!RAM_SIMC_City_CurrentPopulationMid = !RAM_SIMC_City_CurrentPopulationLo+$01
!RAM_SIMC_City_CurrentPopulationHi = !RAM_SIMC_City_CurrentPopulationLo+$02

!RAM_SIMC_City_DisplayedTaxRateLo = $000D6D
!RAM_SIMC_City_DisplayedTaxRateHi = !RAM_SIMC_City_DisplayedTaxRateLo+$01
!RAM_SIMC_City_DisplayedTransportFundingLo = $000D6F
!RAM_SIMC_City_DisplayedTransportFundingHi = !RAM_SIMC_City_DisplayedTransportFundingLo+$01
!RAM_SIMC_City_DisplayedPoliceFundingLo = $000D71
!RAM_SIMC_City_DisplayedPoliceFundingHi = !RAM_SIMC_City_DisplayedPoliceFundingLo+$01
!RAM_SIMC_City_DisplayedFireFundingLo = $000D73
!RAM_SIMC_City_DisplayedFireFundingHi = !RAM_SIMC_City_DisplayedFireFundingLo+$01

!RAM_SIMC_City_TransportFundingLevelLo = $000D79
!RAM_SIMC_City_TransportFundingLevelHi = !RAM_SIMC_City_TransportFundingLevel+$01
!RAM_SIMC_City_PoliceFundingLevelLo = $000D7B
!RAM_SIMC_City_PoliceFundingLevelHi = !RAM_SIMC_City_PoliceFundingLevel+$01
!RAM_SIMC_City_FireFundingLevelLo = $000D7D
!RAM_SIMC_City_FireFundingLevelHi = !RAM_SIMC_City_FireFundingLevel+$01

; $000D94 = City Evaluation Digits

!RAM_SIMC_City_1stWorstProblemPercent = $000DA1
!RAM_SIMC_City_1stWorstProblem = $000DA2
!RAM_SIMC_City_2ndWorstProblemPercent = $000DA3
!RAM_SIMC_City_2ndWorstProblem = $000DA4
!RAM_SIMC_City_3rdWorstProblemPercent = $000DA5
!RAM_SIMC_City_3rdWorstProblem = $000DA6
!RAM_SIMC_City_4thWorstProblemPercent = $000DA7
!RAM_SIMC_City_4thWorstProblem = $000DA8

!RAM_SIMC_City_TaxRateLo = $000DC5
!RAM_SIMC_City_TaxRateHi = !RAM_SIMC_City_TaxRateLo+$01
; $000DC7 = Accumulated tax money?

!RAM_SIMC_City_AllocatedTransportFundsLo = $000DCD
!RAM_SIMC_City_AllocatedTransportFundsHi = !RAM_SIMC_City_AllocatedTransportFundsLo+$01
!RAM_SIMC_City_AllocatedPoliceFundsLo = $000DCF
!RAM_SIMC_City_AllocatedPoliceFundsHi = !RAM_SIMC_City_AllocatedPoliceFundsLo+$01
!RAM_SIMC_City_AllocatedFireFundsLo = $000DD1
!RAM_SIMC_City_AllocatedFireFundsHi = !RAM_SIMC_City_AllocatedFireFundsLo+$01

!RAM_SIMC_City_PercentOfPeopleThatApproveOfMayorLo = $000DDF
!RAM_SIMC_City_PercentOfPeopleThatApproveOfMayorHi = !RAM_SIMC_City_PercentOfPeopleThatApproveOfMayorLo+$01
!RAM_SIMC_City_PercentOfPeopleThatDisapproveOfMayorLo = $000DE1
!RAM_SIMC_City_PercentOfPeopleThatDisapproveOfMayorHi = !RAM_SIMC_City_PercentOfPeopleThatDisapproveOfMayorLo+$01
!RAM_SIMC_City_LastYearsNetMigrationLo = $000DE3
!RAM_SIMC_City_LastYearsNetMigrationMid = !RAM_SIMC_City_LastYearsNetMigrationLo+$01
!RAM_SIMC_City_LastYearsNetMigrationHi = !RAM_SIMC_City_LastYearsNetMigrationLo+$02
!RAM_SIMC_City_AssessedValueLo = $000DE7
!RAM_SIMC_City_AssessedValueMidLo = !RAM_SIMC_City_AssessedValueLo+$01
!RAM_SIMC_City_AssessedValueMidHi = !RAM_SIMC_City_AssessedValueLo+$02
!RAM_SIMC_City_AssessedValueHi = !RAM_SIMC_City_AssessedValueLo+$03
!RAM_SIMC_City_CityCategory = $000DEB
!RAM_SIMC_City_CurrentCityScoreLo = $000DED
!RAM_SIMC_City_CurrentCityScoreHi = !RAM_SIMC_City_CurrentCityScoreLo+$01
!RAM_SIMC_City_AnnualCityScoreChangeLo = $000DEF
!RAM_SIMC_City_AnnualCityScoreChangeHi = !RAM_SIMC_City_AnnualCityScoreChangeLo+$01

!RAM_SIMC_City_PoliceStationCountLo = $000E07
!RAM_SIMC_City_PoliceStationCountHi = !RAM_SIMC_City_PoliceStationCountLo+$01
!RAM_SIMC_City_FireStationCountLo = $000E09
!RAM_SIMC_City_FireStationCountHi = !RAM_SIMC_City_FireStationCountLo+$01

!RAM_SIMC_Global_OAMBuffer = $7E2000
!RAM_SIMC_Global_CopyOfOAMBuffer = $7E2220
!RAM_SIMC_Global_PaletteMirror = $7E2440
!RAM_SIMC_Global_CopyOfPaletteMirror = $7E2640
!RAM_SIMC_Global_Layer1TilemapBuffer = $7E2840
!RAM_SIMC_Global_Layer2TilemapBuffer = $7E3040
!RAM_SIMC_Global_Layer3TilemapBuffer = $7E3840
!RAM_SIMC_Global_Layer4TilemapBuffer = $7E4040

!RAM_SIMC_Global_GeneralPurposeBuffer = $7E8000

!RAM_SIMC_City_MapDataBuffer = $7F0200

struct SIMC_Global_OAMBuffer !RAM_SIMC_Global_OAMBuffer
	.XDisp: skip $01
	.YDisp: skip $01
	.Tile: skip $01
	.Prop: skip $01
endstruct align $04

struct SIMC_Global_UpperOAMBuffer !RAM_SIMC_Global_OAMBuffer+$0200
	.Slot: skip $01
endstruct align $01

struct SIMC_Global_PaletteMirror !RAM_SIMC_Global_PaletteMirror
	.LowByte: skip $01
	.HighByte: skip $01
endstruct align $02
