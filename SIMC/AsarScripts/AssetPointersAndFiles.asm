; Note: This file is used by the ExtractAssets.bat batch script to define where each file is, how large they are, and their filenames.

lorom
;!ROMVer = $0000						; Note: This is set within the batch script
!SIMC_U = $0001
!SIMC_E = $0002
!SIMC_J = $0004
!SIMC_F = $0008
!SIMC_G = $0010

org $008000
MainPointerTableStart:
	dl MainPointerTableStart,MainPointerTableEnd-MainPointerTableStart
	dl GFXPointersStart,(GFXPointersEnd-GFXPointersStart)/$0C
	dl TilemapsPointersStart,(TilemapsPointersEnd-TilemapsPointersStart)/$0C
	dl PalettesPointersStart,(PalettesPointersEnd-PalettesPointersStart)/$0C
	dl MapPointersStart,(MapPointersEnd-MapPointersStart)/$0C
	dl CompressedSPCDataPointersStart,(CompressedSPCDataPointersEnd-CompressedSPCDataPointersStart)/$0C
	dl MusicPointersStart,(MusicPointersEnd-MusicPointersStart)/$0C
	dl UnknownSPCDataPointersStart,(UnknownSPCDataPointersEnd-UnknownSPCDataPointersStart)/$0C
	dl BRRPointersStart,(BRRPointersEnd-BRRPointersStart)/$0C
MainPointerTableEnd:

;--------------------------------------------------------------------

GFXPointersStart:
	dl $048000,$058000,GFX_Sprite_Bowser,GFX_Sprite_BowserEnd
	dl $05A000,$05B000,GFX_Sprite_UFO,GFX_Sprite_UFOEnd
	dl $05B000,$068000,GFX_Layer2_AnimatedCitySimulationTiles,GFX_Layer2_AnimatedCitySimulationTilesEnd
	dl $068000,$068800,GFX_Sprite_Tornado,GFX_Sprite_TornadoEnd
	dl $068800,$069200,GFX_Sprite_Boat,GFX_Sprite_BoatEnd
	dl $069200,$069E00,GFX_Sprite_Airplane,GFX_Sprite_AirplaneEnd
	dl $069E00,$06A000,GFX_Sprite_Train,GFX_Sprite_TrainEnd
	dl $06A000,$06A800,GFX_Sprite_Tornado_01,GFX_Sprite_Tornado_01End
	dl $06A800,$06B200,GFX_Sprite_Boat_01,GFX_Sprite_Boat_01End
	dl $06B200,$06BE00,GFX_Sprite_Airplane_01,GFX_Sprite_Airplane_01End
	dl $06BE00,$06C000,GFX_Sprite_Train_01,GFX_Sprite_Train_01End
	dl $06C000,$078000,GFX_Sprite_StatusBarUI,GFX_Sprite_StatusBarUIEnd
	dl $078000,$07A680,GFX_Sprite_StatusBarUIButtons,GFX_Sprite_StatusBarUIButtonsEnd
	dl $07A680,$07C930,GFX_Sprite_TitleScreen,GFX_Sprite_TitleScreenEnd
	dl $07C930,$07C9E0,GFX_Layer3_TitleScreen,GFX_Layer3_TitleScreenEnd
	dl $07C9E0,$07E584,GFX_Layer1_TitleScreen,GFX_Layer1_TitleScreenEnd
	dl $07E584,$08C4DB,GFX_Layer1_CitySimulationTiles,GFX_Layer1_CitySimulationTilesEnd
	dl $08C4DB,$08DEA2,GFX_LayerX_MainMenu,GFX_LayerX_MainMenuEnd
	dl $08DEA2,$08E422,GFX_Layer1_MapSelectScreen,GFX_Layer1_MapSelectScreenEnd
	dl $08E422,$09875C,GFX_Layer1_InformationAndBankLoanSubScreens,GFX_Layer1_InformationAndBankLoanSubScreensEnd
	dl $09875C,$09A571,GFX_Layer3_InformationAndBankLoanSubScreens,GFX_Layer3_InformationAndBankLoanSubScreensEnd
	dl $09A571,$09C0FB,GFX_Sprite_ScenarioSelectScreen,GFX_Sprite_ScenarioSelectScreenEnd
	dl $09C0FB,$09D650,GFX_Layer3_CitySimulationTiles,GFX_Layer3_CitySimulationTilesEnd
	dl $09D650,$09EBC1,GFX_Sprite_WillWrightMessageScreen1,GFX_Sprite_WillWrightMessageScreen1End
	dl $09EBC1,$0A81E9,GFX_Sprite_WillWrightMessageScreen2,GFX_Sprite_WillWrightMessageScreen2End
	dl $0A81E9,$0A8F68,GFX_Sprite_WillWrightMessageScreen3,GFX_Sprite_WillWrightMessageScreen3End
	dl $0A8F68,$0A9C34,GFX_Sprite_WillWrightMessageScreen4,GFX_Sprite_WillWrightMessageScreen4End
	dl $0A9C34,$0AA523,GFX_Sprite_WillWrightMessageScreen5,GFX_Sprite_WillWrightMessageScreen5End
	dl $0AA523,$0AC460,GFX_Sprite_StatusBarSubMenuButtons,GFX_Sprite_StatusBarSubMenuButtonsEnd
	dl $0AC460,$0AC4CF,GFX_Sprite_FamicomLogoAndFaxMachineCord,GFX_Sprite_FamicomLogoAndFaxMachineCordEnd
	dl $0AC4CF,$0AD381,GFX_Sprite_SpecialBuildingButtons,GFX_Sprite_SpecialBuildingButtonsEnd
	dl $0AD381,$0AF80B,GFX_Sprite_MapScreenButtons,GFX_Sprite_MapScreenButtonsEnd
	dl $0AF80B,$0AFCE1,GFX_Sprite_MapScreenHeaders,GFX_Sprite_MapScreenHeadersEnd
	dl $0AFCE1,$0B86F7,GFX_Sprite_GraphScreenButtons,GFX_Sprite_GraphScreenButtonsEnd
	dl $0B86F7,$0B9224,GFX_Sprite_StatusBarSaveMenuButtons,GFX_Sprite_StatusBarSaveMenuButtonsEnd
GFXPointersEnd:

;--------------------------------------------------------------------

TilemapsPointersStart:
	dl $00CE78,$00CFB8,DATA_00CE78,DATA_00CE78End
	dl $00D4E9,$00D559,DATA_00D4E9,DATA_00D4E9End
	dl $019524,$019594,DATA_019524,DATA_019524End
	dl $019594,$01961C,DATA_019594,DATA_019594End
	dl $01961C,$0196C4,DATA_01961C,DATA_01961CEnd
	dl $0196C4,$01978C,DATA_0196C4,DATA_0196C4End
	dl $01CB00,$01CBC8,DATA_01CB00,DATA_01CB00End
	dl $01D0F0,$01D2C4,DATA_01D0F0,DATA_01D0F0End
	dl $01D2C4,$01D42C,DATA_01D2C4,DATA_01D2C4End
	dl $01D42C,$01D66C,DATA_01D42C,DATA_01D42CEnd
	dl $0B9224,$0B942B,TM_Layer3_TitleScreen,TM_Layer3_TitleScreenEnd
	dl $0B942B,$0B966B,TM_Layer2_TitleScreen,TM_Layer2_TitleScreenEnd
	dl $0B966B,$0B9BA4,TM_Layer1_TitleScreen,TM_Layer1_TitleScreenEnd
	dl $0B9BA4,$0BA10B,TM_Layer1_MapSelectScreen,TM_Layer1_MapSelectScreenEnd
	dl $0BA10B,$0BA5A1,TM_Layer3_MapSelectScreen,TM_Layer3_MapSelectScreenEnd
	dl $0BA5A1,$0BABF1,TM_ScenarioSelectScreen,TM_ScenarioSelectScreenEnd
	dl $0BABF1,$0BADAE,TM_GameModeSelectScreen,TM_GameModeSelectScreenEnd
	dl $0BADAE,$0BAFCE,TM_Layer1_FiscalBudgetSubScreen,TM_Layer1_FiscalBudgetSubScreenEnd
	dl $0BAFCE,$0BB1EB,TM_Layer1_CityEvaluationSubScreen,TM_Layer1_CityEvaluationSubScreenEnd
	dl $0BB1EB,$0BB408,TM_Layer1_CityOverviewSubScreen,TM_Layer1_CityOverviewSubScreenEnd
	dl $0BB408,$0BB5F3,TM_Layer1_HistorySubScreen,TM_Layer1_HistorySubScreenEnd
	dl $0BB5F3,$0BBCAD,TM_Layer1_BankLoanSubScreen,TM_Layer1_BankLoanSubScreenEnd
	dl $0BBCAD,$0BBF0E,TM_Layer3_BankLoanText,TM_Layer3_BankLoanTextEnd
	dl $0BBF0E,$0BC0C9,TM_Layer3_FiscalBudgetSubScreen,TM_Layer3_FiscalBudgetSubScreenEnd
	dl $0BC0C9,$0BC29F,TM_Layer3_CityEvaluationSubScreen,TM_Layer3_CityEvaluationSubScreenEnd
	dl $0BC29F,$0BC488,TM_Layer3_CityOverviewSubScreen,TM_Layer3_CityOverviewSubScreenEnd
	dl $0BC488,$0BC51C,TM_Layer3_HistorySubScreen,TM_Layer3_HistorySubScreenEnd
	dl $0BC51C,$0BC7BD,TM_Layer3_ScaleModelSubScreen,TM_Layer3_ScaleModelSubScreenEnd
	dl $0BC7BD,$0BC91F,TM_Layer3_LShapedStatusBar,TM_Layer3_LShapedStatusBarEnd
	dl $0BC91F,$0BCE02,TM_Layer3_WillWriteMessageBoxVillageBG,TM_Layer3_WillWriteMessageBoxVillageBGEnd
	dl $0BCE02,$0BD2F6,TM_Layer3_WillWriteMessageBoxTownBG,TM_Layer3_WillWriteMessageBoxTownBGEnd
	dl $0BD2F6,$0BD84D,TM_Layer3_WillWriteMessageBoxCityBG,TM_Layer3_WillWriteMessageBoxCityBGEnd
	dl $0BD84D,$0BDDD2,TM_Layer3_WillWriteMessageBoxCapitalBG,TM_Layer3_WillWriteMessageBoxCapitalBGEnd
	dl $0BDDD2,$0BE417,TM_Layer3_WillWriteMessageBoxMetropolisBG,TM_Layer3_WillWriteMessageBoxMetropolisBGEnd
	dl $0BE417,$0BEAA8,TM_Layer3_WillWriteMessageBoxMegalopolisBG,TM_Layer3_WillWriteMessageBoxMegalopolisBGEnd
	dl $0BEAA8,$0BEE30,TM_Layer3_WillWriteMessageBoxOfficeBG,TM_Layer3_WillWriteMessageBoxOfficeBGEnd
	dl $0BEE30,$0BF06A,TM_RioDeJaneiroScenarioIntroText,TM_RioDeJaneiroScenarioIntroTextEnd
	dl $0BF06A,$0BF2EA,TM_BostonScenarioIntroText,TM_BostonScenarioIntroTextEnd
	dl $0BF2EA,$0BF543,TM_BernScenarioIntroText,TM_BernScenarioIntroTextEnd
	dl $0BF543,$0BF764,TM_DetroitScenarioIntroText,TM_DetroitScenarioIntroTextEnd
	dl $0BF764,$0BF972,TM_SanFrancicsoScenarioIntroText,TM_SanFrancicsoScenarioIntroTextEnd
	dl $0BF972,$0BFBE7,TM_TokyoScenarioIntroText,TM_TokyoScenarioIntroTextEnd
	dl $0BFBE7,$0BFE00,TM_PracticeCityIntroText,TM_PracticeCityIntroTextEnd
	dl $0BFE00,$0C8066,TM_LasVegasScenarioIntroText,TM_LasVegasScenarioIntroTextEnd
	dl $0C8066,$0C82AD,TM_FreeCityScenarioIntroText,TM_FreeCityScenarioIntroTextEnd
	dl $0C82AD,$0C83CE,TM_CompleteScenarioText,TM_CompleteScenarioTextEnd
	dl $0C83CE,$0C8539,TM_UnlockBonusScenariosText,TM_UnlockBonusScenariosTextEnd
	dl $0C8539,$0C869D,TM_FailedScenarioText,TM_FailedScenarioTextEnd
	dl $0C869D,$0C87CB,TM_FaxPaper,TM_FaxPaperEnd
	dl $0C87CB,$0C89B9,TM_FaxMachineAndWoodTable,TM_FaxMachineAndWoodTableEnd
	dl $0C89B9,$0C89D8,TM_FaxMachineGlass,TM_FaxMachineGlassEnd
TilemapsPointersEnd:

;--------------------------------------------------------------------

PalettesPointersStart:
	dl $0088B4,$008924,DATA_0088B4,DATA_0088B4End
	dl $00896A,$008982,DATA_00896A,DATA_00896AEnd
	dl $0089C8,$0089E0,DATA_0089C8,DATA_0089C8End
	dl $00C305,$00C385,DATA_00C305,DATA_00C305End
	dl $00D87A,$00D89A,DATA_00D87A,DATA_00D87AEnd
	dl $01A84C,$01A86C,DATA_01A84C,DATA_01A84CEnd
	dl $01D8AF,$01D94F,DATA_01D8AF,DATA_01D8AFEnd
	dl $01DA85,$01DAE5,DATA_01DA85,DATA_01DA85End
	dl $01DB96,$01DBF6,DATA_01DB96,DATA_01DB96End
	dl $01DBF6,$01DC76,DATA_01DBF6,DATA_01DBF6End
	dl $01DC76,$01DCB6,DATA_01DC76,DATA_01DC76End
	dl $01DCB6,$01DD76,DATA_01DCB6,DATA_01DCB6End
	dl $058000,$058100,DATA_058000,DATA_058000End
	dl $058100,$058200,DATA_058100,DATA_058100End
	dl $058200,$058300,DATA_058200,DATA_058200End
	dl $058300,$058400,DATA_058300,DATA_058300End
	dl $058400,$058500,DATA_058400,DATA_058400End
	dl $058500,$058600,DATA_058500,DATA_058500End
	dl $058600,$058700,DATA_058600,DATA_058600End
	dl $058700,$058800,DATA_058700,DATA_058700End
	dl $058800,$058900,DATA_058800,DATA_058800End
	dl $058900,$058A00,DATA_058900,DATA_058900End
	dl $058A00,$058B00,DATA_058A00,DATA_058A00End
	dl $058B00,$058C00,DATA_058B00,DATA_058B00End
	dl $058C00,$058D00,DATA_058C00,DATA_058C00End
	dl $058D00,$058E00,DATA_058D00,DATA_058D00End
	dl $0C89D8,$0C8AD8,PAL_TitleScreen,PAL_TitleScreenEnd
	dl $0C8AD8,$0C8C44,PAL_MainMenu,PAL_MainMenuEnd
	dl $0C8C44,$0C8CEE,PAL_FiscalBudgetSubScreen,PAL_FiscalBudgetSubScreenEnd
	dl $0C8CEE,$0C8D50,PAL_CityEvaluationSubScreen,PAL_CityEvaluationSubScreenEnd
	dl $0C8D50,$0C8DAB,PAL_CityOverviewSubScreen,PAL_CityOverviewSubScreenEnd
	dl $0C8DAB,$0C8E00,PAL_HistorySubScreen,PAL_HistorySubScreenEnd
	dl $0C8E00,$0C8ED8,PAL_BankLoanScreen,PAL_BankLoanScreenEnd
	dl $0C8ED8,$0C8F27,PAL_FaxMachineScreen,PAL_FaxMachineScreenEnd
PalettesPointersEnd:

;--------------------------------------------------------------------

MapPointersStart:
	dl $0C8F27,$0CA8E8,Map_Tokyo,Map_TokyoEnd
	dl $0CA8E8,$0CC5A2,Map_Boston,Map_BostonEnd
	dl $0CC5A2,$0CE30B,Map_Detroit,Map_DetroitEnd
	dl $0CE30B,$0D816E,Map_Bern,Map_BernEnd
	dl $0D816E,$0D9F23,Map_RioDeJaneiro,Map_RioDeJaneiroEnd
	dl $0D9F23,$0DB987,Map_SanFrancicso,Map_SanFrancicsoEnd
	dl $0DB987,$0DCB15,Map_LasVegas,Map_LasVegasEnd
	dl $0DCB15,$0DD131,Map_FreeCity,Map_FreeCityEnd
	dl $0DD131,$0DD77C,Map_PracticeCity,Map_PracticeCityEnd
MapPointersEnd:

;--------------------------------------------------------------------

CompressedSPCDataPointersStart:
	dl $0DD77C,$0EC242,CompressedSPCBlock1,CompressedSPCBlock1End
	dl $0EC242,$0F9B98,CompressedSPCBlock2,CompressedSPCBlock2End
CompressedSPCDataPointersEnd:

;--------------------------------------------------------------------

MusicPointersStart:				; Note: These files need to be decompressed first, then extracted from the decompressed file.
	dl $0093BD,$00AA9F,MusicData,MusicDataEnd
MusicPointersEnd:

;--------------------------------------------------------------------

UnknownSPCDataPointersStart:			; Note: Same as with music.
	dl $00AAA3,$00D1FD,UnknownSPCData,UnknownSPCDataEnd
UnknownSPCDataPointersEnd:

;--------------------------------------------------------------------

BRRPointersStart:			; Note: Same as with music.
	dl $00D275,$00D2AB,BRRSample00,BRRSample00End
	dl $00D2AB,$00D710,BRRSample01,BRRSample01End
	dl $00D710,$00D746,BRRSample02,BRRSample02End
	dl $00D746,$00D77C,BRRSample03,BRRSample03End
	dl $00D77C,$00E1FF,BRRSample04,BRRSample04End
	dl $00E1FF,$00E463,BRRSample05,BRRSample05End
	dl $00E463,$00E96A,BRRSample06,BRRSample06End
	dl $00E96A,$00F699,BRRSample07,BRRSample07End
	dl $00F699,$00FAE3,BRRSample08,BRRSample08End
	dl $00FAE3,$00FB46,BRRSample09,BRRSample09End
	dl $00FB46,$01824E,BRRSample0A,BRRSample0AEnd
	dl $01824E,$01A420,BRRSample0B,BRRSample0BEnd
	dl $01A420,$01A5FD,BRRSample0C,BRRSample0CEnd
	dl $01A5FD,$01A67B,BRRSample0D,BRRSample0DEnd
	dl $01A67B,$01A6B1,BRRSample0E,BRRSample0EEnd
	dl $01A6B1,$01AE25,BRRSample0F,BRRSample0FEnd
	dl $01AE25,$01B656,BRRSample10,BRRSample10End
	dl $01B656,$01BBD2,BRRSample11,BRRSample11End
	dl $01BBD2,$01BED8,BRRSample12,BRRSample12End
	dl $01BED8,$01BF29,BRRSample13,BRRSample13End
	dl $01BF29,$01C466,BRRSample14,BRRSample14End
	dl $01C466,$01C58F,BRRSample15,BRRSample15End
	dl $01C58F,$01CE59,BRRSample16,BRRSample16End
	dl $01CE59,$01D27F,BRRSample17,BRRSample17End
	dl $01D27F,$01DC25,BRRSample18,BRRSample18End
BRRPointersEnd:

;--------------------------------------------------------------------

GFX_Sprite_Bowser:
	db "GFX_Sprite_Bowser.bin"
GFX_Sprite_BowserEnd:
GFX_Sprite_UFO:
	db "GFX_Sprite_UFO.bin"
GFX_Sprite_UFOEnd:
GFX_Layer2_AnimatedCitySimulationTiles:
	db "GFX_Layer2_AnimatedCitySimulationTiles.bin"
GFX_Layer2_AnimatedCitySimulationTilesEnd:
GFX_Sprite_Tornado:
	db "GFX_Sprite_Tornado.bin"
GFX_Sprite_TornadoEnd:
GFX_Sprite_Boat:
	db "GFX_Sprite_Boat.bin"
GFX_Sprite_BoatEnd:
GFX_Sprite_Airplane:
	db "GFX_Sprite_Airplane.bin"
GFX_Sprite_AirplaneEnd:
GFX_Sprite_Train:
	db "GFX_Sprite_Train.bin"
GFX_Sprite_TrainEnd:
GFX_Sprite_Tornado_01:
	db "GFX_Sprite_Tornado_01.bin"
GFX_Sprite_Tornado_01End:
GFX_Sprite_Boat_01:
	db "GFX_Sprite_Boat_01.bin"
GFX_Sprite_Boat_01End:
GFX_Sprite_Airplane_01:
	db "GFX_Sprite_Airplane_01.bin"
GFX_Sprite_Airplane_01End:
GFX_Sprite_Train_01:
	db "GFX_Sprite_Train_01.bin"
GFX_Sprite_Train_01End:
GFX_Sprite_StatusBarUI:
	db "GFX_Sprite_StatusBarUI.bin"
GFX_Sprite_StatusBarUIEnd:
GFX_Sprite_StatusBarUIButtons:
	db "GFX_Sprite_StatusBarUIButtons.bin"
GFX_Sprite_StatusBarUIButtonsEnd:
GFX_Sprite_TitleScreen:
	db "GFX_Sprite_TitleScreen.lz5"
GFX_Sprite_TitleScreenEnd:
GFX_Layer3_TitleScreen:
	db "GFX_Layer3_TitleScreen.lz5"
GFX_Layer3_TitleScreenEnd:
GFX_Layer1_TitleScreen:
	db "GFX_Layer1_TitleScreen.lz5"
GFX_Layer1_TitleScreenEnd:
GFX_Layer1_CitySimulationTiles:
	db "GFX_Layer1_CitySimulationTiles.lz5"
GFX_Layer1_CitySimulationTilesEnd:
GFX_LayerX_MainMenu:
	db "GFX_LayerX_MainMenu.lz5"
GFX_LayerX_MainMenuEnd:
GFX_Layer1_MapSelectScreen:
	db "GFX_Layer1_MapSelectScreen.lz5"
GFX_Layer1_MapSelectScreenEnd:
GFX_Layer1_InformationAndBankLoanSubScreens:
	db "GFX_Layer1_InformationAndBankLoanSubScreens.lz5"
GFX_Layer1_InformationAndBankLoanSubScreensEnd:
GFX_Layer3_InformationAndBankLoanSubScreens:
	db "GFX_Layer3_InformationAndBankLoanSubScreens.lz5"
GFX_Layer3_InformationAndBankLoanSubScreensEnd:
GFX_Sprite_ScenarioSelectScreen:
	db "GFX_Sprite_ScenarioSelectScreen.lz5"
GFX_Sprite_ScenarioSelectScreenEnd:
GFX_Layer3_CitySimulationTiles:
	db "GFX_Layer3_CitySimulationTiles.lz5"
GFX_Layer3_CitySimulationTilesEnd:
GFX_Sprite_WillWrightMessageScreen1:
	db "GFX_Sprite_WillWrightMessageScreen1.lz5"
GFX_Sprite_WillWrightMessageScreen1End:
GFX_Sprite_WillWrightMessageScreen2:
	db "GFX_Sprite_WillWrightMessageScreen2.lz5"
GFX_Sprite_WillWrightMessageScreen2End:
GFX_Sprite_WillWrightMessageScreen3:
	db "GFX_Sprite_WillWrightMessageScreen3.lz5"
GFX_Sprite_WillWrightMessageScreen3End:
GFX_Sprite_WillWrightMessageScreen4:
	db "GFX_Sprite_WillWrightMessageScreen4.lz5"
GFX_Sprite_WillWrightMessageScreen4End:
GFX_Sprite_WillWrightMessageScreen5:
	db "GFX_Sprite_WillWrightMessageScreen5.lz5"
GFX_Sprite_WillWrightMessageScreen5End:
GFX_Sprite_StatusBarSubMenuButtons:
	db "GFX_Sprite_StatusBarSubMenuButtons.lz5"
GFX_Sprite_StatusBarSubMenuButtonsEnd:
GFX_Sprite_FamicomLogoAndFaxMachineCord:
	db "GFX_Sprite_FamicomLogoAndFaxMachineCord.lz5"
GFX_Sprite_FamicomLogoAndFaxMachineCordEnd:
GFX_Sprite_SpecialBuildingButtons:
	db "GFX_Sprite_SpecialBuildingButtons.lz5"
GFX_Sprite_SpecialBuildingButtonsEnd:
GFX_Sprite_MapScreenButtons:
	db "GFX_Sprite_MapScreenButtons.lz5"
GFX_Sprite_MapScreenButtonsEnd:
GFX_Sprite_MapScreenHeaders:
	db "GFX_Sprite_MapScreenHeaders.lz5"
GFX_Sprite_MapScreenHeadersEnd:
GFX_Sprite_GraphScreenButtons:
	db "GFX_Sprite_GraphScreenButtons.lz5"
GFX_Sprite_GraphScreenButtonsEnd:
GFX_Sprite_StatusBarSaveMenuButtons:
	db "GFX_Sprite_StatusBarSaveMenuButtons.lz5"
GFX_Sprite_StatusBarSaveMenuButtonsEnd:

;--------------------------------------------------------------------

DATA_00CE78:
	db "DATA_00CE78.bin"
DATA_00CE78End:
DATA_00D4E9:
	db "DATA_00D4E9.bin"
DATA_00D4E9End:
DATA_019524:
	db "DATA_019524.bin"
DATA_019524End:
DATA_019594:
	db "DATA_019594.bin"
DATA_019594End:
DATA_01961C:
	db "DATA_01961C.bin"
DATA_01961CEnd:
DATA_0196C4:
	db "DATA_0196C4.bin"
DATA_0196C4End:
DATA_01CB00:
	db "DATA_01CB00.bin"
DATA_01CB00End:
DATA_01D0F0:
	db "DATA_01D0F0.bin"
DATA_01D0F0End:
DATA_01D2C4:
	db "DATA_01D2C4.bin"
DATA_01D2C4End:
DATA_01D42C:
	db "DATA_01D42C.bin"
DATA_01D42CEnd:
TM_Layer3_TitleScreen:
	db "Layer3_TitleScreen.lz5"
TM_Layer3_TitleScreenEnd:
TM_Layer2_TitleScreen:
	db "Layer2_TitleScreen.lz5"
TM_Layer2_TitleScreenEnd:
TM_Layer1_TitleScreen:
	db "Layer1_TitleScreen.lz5"
TM_Layer1_TitleScreenEnd:
TM_Layer1_MapSelectScreen:
	db "Layer1_MapSelectScreen.lz5"
TM_Layer1_MapSelectScreenEnd:
TM_Layer3_MapSelectScreen:
	db "Layer3_MapSelectScreen.lz5"
TM_Layer3_MapSelectScreenEnd:
TM_ScenarioSelectScreen:
	db "ScenarioSelectScreen.lz5"
TM_ScenarioSelectScreenEnd:
TM_GameModeSelectScreen:
	db "GameModeSelectScreen.lz5"
TM_GameModeSelectScreenEnd:
TM_Layer1_FiscalBudgetSubScreen:
	db "Layer1_FiscalBudgetSubScreen.lz5"
TM_Layer1_FiscalBudgetSubScreenEnd:
TM_Layer1_CityEvaluationSubScreen:
	db "Layer1_CityEvaluationSubScreen.lz5"
TM_Layer1_CityEvaluationSubScreenEnd:
TM_Layer1_CityOverviewSubScreen:
	db "Layer1_CityOverviewSubScreen.lz5"
TM_Layer1_CityOverviewSubScreenEnd:
TM_Layer1_HistorySubScreen:
	db "Layer1_HistorySubScreen.lz5"
TM_Layer1_HistorySubScreenEnd:
TM_Layer1_BankLoanSubScreen:
	db "Layer1_BankLoanSubScreen.lz5"
TM_Layer1_BankLoanSubScreenEnd:
TM_Layer3_BankLoanText:
	db "Layer3_BankLoanText.lz5"
TM_Layer3_BankLoanTextEnd:
TM_Layer3_FiscalBudgetSubScreen:
	db "Layer3_FiscalBudgetSubScreen.lz5"
TM_Layer3_FiscalBudgetSubScreenEnd:
TM_Layer3_CityEvaluationSubScreen:
	db "Layer3_CityEvaluationSubScreen.lz5"
TM_Layer3_CityEvaluationSubScreenEnd:
TM_Layer3_CityOverviewSubScreen:
	db "Layer3_CityOverviewSubScreen.lz5"
TM_Layer3_CityOverviewSubScreenEnd:
TM_Layer3_HistorySubScreen:
	db "Layer3_HistorySubScreen.lz5"
TM_Layer3_HistorySubScreenEnd:
TM_Layer3_ScaleModelSubScreen:
	db "Layer3_ScaleModelSubScreen.lz5"
TM_Layer3_ScaleModelSubScreenEnd:
TM_Layer3_LShapedStatusBar:
	db "Layer3_LShapedStatusBar.lz5"
TM_Layer3_LShapedStatusBarEnd:
TM_Layer3_WillWriteMessageBoxVillageBG:
	db "Layer3_WillWriteMessageBoxVillageBG.lz5"
TM_Layer3_WillWriteMessageBoxVillageBGEnd:
TM_Layer3_WillWriteMessageBoxTownBG:
	db "Layer3_WillWriteMessageBoxTownBG.lz5"
TM_Layer3_WillWriteMessageBoxTownBGEnd:
TM_Layer3_WillWriteMessageBoxCityBG:
	db "Layer3_WillWriteMessageBoxCityBG.lz5"
TM_Layer3_WillWriteMessageBoxCityBGEnd:
TM_Layer3_WillWriteMessageBoxCapitalBG:
	db "Layer3_WillWriteMessageBoxCapitalBG.lz5"
TM_Layer3_WillWriteMessageBoxCapitalBGEnd:
TM_Layer3_WillWriteMessageBoxMetropolisBG:
	db "Layer3_WillWriteMessageBoxMetropolisBG.lz5"
TM_Layer3_WillWriteMessageBoxMetropolisBGEnd:
TM_Layer3_WillWriteMessageBoxMegalopolisBG:
	db "Layer3_WillWriteMessageBoxMegalopolisBG.lz5"
TM_Layer3_WillWriteMessageBoxMegalopolisBGEnd:
TM_Layer3_WillWriteMessageBoxOfficeBG:
	db "Layer3_WillWriteMessageBoxOfficeBG.lz5"
TM_Layer3_WillWriteMessageBoxOfficeBGEnd:
TM_RioDeJaneiroScenarioIntroText:
	db "RioDeJaneiroScenarioIntroText.lz5"
TM_RioDeJaneiroScenarioIntroTextEnd:
TM_BostonScenarioIntroText:
	db "BostonScenarioIntroText.lz5"
TM_BostonScenarioIntroTextEnd:
TM_BernScenarioIntroText:
	db "BernScenarioIntroText.lz5"
TM_BernScenarioIntroTextEnd:
TM_DetroitScenarioIntroText:
	db "DetroitScenarioIntroText.lz5"
TM_DetroitScenarioIntroTextEnd:
TM_SanFrancicsoScenarioIntroText:
	db "SanFrancicsoScenarioIntroText.lz5"
TM_SanFrancicsoScenarioIntroTextEnd:
TM_TokyoScenarioIntroText:
	db "TokyoScenarioIntroText.lz5"
TM_TokyoScenarioIntroTextEnd:
TM_PracticeCityIntroText:
	db "PracticeCityIntroText.lz5"
TM_PracticeCityIntroTextEnd:
TM_LasVegasScenarioIntroText:
	db "LasVegasScenarioIntroText.lz5"
TM_LasVegasScenarioIntroTextEnd:
TM_FreeCityScenarioIntroText:
	db "FreeCityScenarioIntroText.lz5"
TM_FreeCityScenarioIntroTextEnd:
TM_CompleteScenarioText:
	db "CompleteScenarioText.lz5"
TM_CompleteScenarioTextEnd:
TM_UnlockBonusScenariosText:
	db "UnlockBonusScenariosText.lz5"
TM_UnlockBonusScenariosTextEnd:
TM_FailedScenarioText:
	db "FailedScenarioText.lz5"
TM_FailedScenarioTextEnd:
TM_FaxPaper:
	db "FaxPaper.lz5"
TM_FaxPaperEnd:
TM_FaxMachineAndWoodTable:
	db "FaxMachineAndWoodTable.lz5"
TM_FaxMachineAndWoodTableEnd:
TM_FaxMachineGlass:
	db "FaxMachineGlass.lz5"
TM_FaxMachineGlassEnd:

;--------------------------------------------------------------------

DATA_0088B4:
	db "DATA_0088B4.bin"
DATA_0088B4End:
DATA_00896A:
	db "DATA_00896A.bin"
DATA_00896AEnd:
DATA_0089C8:
	db "DATA_0089C8.bin"
DATA_0089C8End:
DATA_00C305:
	db "DATA_00C305.bin"
DATA_00C305End:
DATA_00D87A:
	db "DATA_00D87A.bin"
DATA_00D87AEnd:
DATA_01A84C:
	db "DATA_01A84C.bin"
DATA_01A84CEnd:
DATA_01D8AF:
	db "DATA_01D8AF.bin"
DATA_01D8AFEnd:
DATA_01DA85:
	db "DATA_01DA85.bin"
DATA_01DA85End:
DATA_01DB96:
	db "DATA_01DB96.bin"
DATA_01DB96End:
DATA_01DBF6:
	db "DATA_01DBF6.bin"
DATA_01DBF6End:
DATA_01DC76:
	db "DATA_01DC76.bin"
DATA_01DC76End:
DATA_01DCB6:
	db "DATA_01DCB6.bin"
DATA_01DCB6End:
DATA_058000:
	db "DATA_058000.bin"
DATA_058000End:
DATA_058100:
	db "DATA_058100.bin"
DATA_058100End:
DATA_058200:
	db "DATA_058200.bin"
DATA_058200End:
DATA_058300:
	db "DATA_058300.bin"
DATA_058300End:
DATA_058400:
	db "DATA_058400.bin"
DATA_058400End:
DATA_058500:
	db "DATA_058500.bin"
DATA_058500End:
DATA_058600:
	db "DATA_058600.bin"
DATA_058600End:
DATA_058700:
	db "DATA_058700.bin"
DATA_058700End:
DATA_058800:
	db "DATA_058800.bin"
DATA_058800End:
DATA_058900:
	db "DATA_058900.bin"
DATA_058900End:
DATA_058A00:
	db "DATA_058A00.bin"
DATA_058A00End:
DATA_058B00:
	db "DATA_058B00.bin"
DATA_058B00End:
DATA_058C00:
	db "DATA_058C00.bin"
DATA_058C00End:
DATA_058D00:
	db "DATA_058D00.bin"
DATA_058D00End:
PAL_TitleScreen:
	db "TitleScreen.lz5"
PAL_TitleScreenEnd:
PAL_MainMenu:
	db "MainMenu.lz5"
PAL_MainMenuEnd:
PAL_FiscalBudgetSubScreen:
	db "FiscalBudgetSubScreen.lz5"
PAL_FiscalBudgetSubScreenEnd:
PAL_CityEvaluationSubScreen:
	db "CityEvaluationSubScreen.lz5"
PAL_CityEvaluationSubScreenEnd:
PAL_CityOverviewSubScreen:
	db "CityOverviewSubScreen.lz5"
PAL_CityOverviewSubScreenEnd:
PAL_HistorySubScreen:
	db "HistorySubScreen.lz5"
PAL_HistorySubScreenEnd:
PAL_BankLoanScreen:
	db "BankLoanScreen.lz5"
PAL_BankLoanScreenEnd:
PAL_FaxMachineScreen:
	db "FaxMachineScreen.lz5"
PAL_FaxMachineScreenEnd:

;--------------------------------------------------------------------

Map_Tokyo:
	db "Tokyo.lz5"
Map_TokyoEnd:
Map_Boston:
	db "Boston.lz5"
Map_BostonEnd:
Map_Detroit:
	db "Detroit.lz5"
Map_DetroitEnd:
Map_Bern:
	db "Bern.lz5"
Map_BernEnd:
Map_RioDeJaneiro:
	db "RioDeJaneiro.lz5"
Map_RioDeJaneiroEnd:
Map_SanFrancicso:
	db "SanFrancicso.lz5"
Map_SanFrancicsoEnd:
Map_LasVegas:
	db "LasVegas.lz5"
Map_LasVegasEnd:
Map_FreeCity:
	db "FreeCity.lz5"
Map_FreeCityEnd:
Map_PracticeCity:
	db "PracticeCity.lz5"
Map_PracticeCityEnd:

;--------------------------------------------------------------------

CompressedSPCBlock1:
	db "CompressedSPCBlock1.lz5"
CompressedSPCBlock1End:
CompressedSPCBlock2:
	db "CompressedSPCBlock2.lz5"
CompressedSPCBlock2End:

;--------------------------------------------------------------------

MusicData:
	db "MusicData.bin"
MusicDataEnd:

;--------------------------------------------------------------------

UnknownSPCData:
	db "UnknownSPCData.bin"
UnknownSPCDataEnd:

;--------------------------------------------------------------------

BRRSample00:
	db "00.brr"
BRRSample00End:
BRRSample01:
	db "01.brr"
BRRSample01End:
BRRSample02:
	db "02.brr"
BRRSample02End:
BRRSample03:
	db "03.brr"
BRRSample03End:
BRRSample04:
	db "04.brr"
BRRSample04End:
BRRSample05:
	db "05.brr"
BRRSample05End:
BRRSample06:
	db "06.brr"
BRRSample06End:
BRRSample07:
	db "07.brr"
BRRSample07End:
BRRSample08:
	db "08.brr"
BRRSample08End:
BRRSample09:
	db "09.brr"
BRRSample09End:
BRRSample0A:
	db "0A.brr"
BRRSample0AEnd:
BRRSample0B:
	db "0B.brr"
BRRSample0BEnd:
BRRSample0C:
	db "0C.brr"
BRRSample0CEnd:
BRRSample0D:
	db "0D.brr"
BRRSample0DEnd:
BRRSample0E:
	db "0E.brr"
BRRSample0EEnd:
BRRSample0F:
	db "0F.brr"
BRRSample0FEnd:
BRRSample10:
	db "10.brr"
BRRSample10End:
BRRSample11:
	db "11.brr"
BRRSample11End:
BRRSample12:
	db "12.brr"
BRRSample12End:
BRRSample13:
	db "13.brr"
BRRSample13End:
BRRSample14:
	db "14.brr"
BRRSample14End:
BRRSample15:
	db "15.brr"
BRRSample15End:
BRRSample16:
	db "16.brr"
BRRSample16End:
BRRSample17:
	db "17.brr"
BRRSample17End:
BRRSample18:
	db "18.brr"
BRRSample18End:

;--------------------------------------------------------------------
