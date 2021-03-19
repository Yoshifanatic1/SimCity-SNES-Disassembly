
; Note: This game uses the COP opcode quite a bit. They're not disassembly mistakes.
; Optimization: There are a lot of unnecessary REP/SEP opcodes throughout the ROM.
; Note: The SPC engine, music, and samples are compressed in LC_LZ5 format and split into two pieces. It'd be wise to edit the code to change this if you plan on editing these things.

;#############################################################################################################
;#############################################################################################################

macro SIMCBank00Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

CODE_008000:
	CLC
	XCE
	SEI
	REP.b #$10
	SEP.b #$20
	LDX.w #$1FFF
	TXS
	LDA.b #CODE_008000>>16
	PHA
	PLB
	LDA.b #$8F
	STA.w !REGISTER_ScreenDisplayRegister
	LDA.b #$00
	STA.b $B1
	STA.w !REGISTER_IRQNMIAndJoypadEnableFlags
	LDY.w #$2000
	LDX.w #$0000
	LDA.b #$00
CODE_008023:
	STA.b $00,x
	INX
	DEY
	BNE.b CODE_008023
	LDY.w #$6000
	LDX.w #$0000
CODE_00802F:
	STA.l SIMC_Global_OAMBuffer[$00].XDisp,x
	INX
	DEY
	BNE.b CODE_00802F
	REP.b #$20
	LDA.w #$0000
	STA.w $0465
	SEP.b #$20
	INC.w $0B25
	LDA.b #$81
	STA.b $B3
	STA.b $B1
	STA.w !REGISTER_IRQNMIAndJoypadEnableFlags
CODE_00804D:
	LDA.b $12
	BNE.b CODE_00805C
	STZ.b $B7
	JSR.w CODE_008D65
	JSL.l CODE_03D283
	BRA.b CODE_00804D

CODE_00805C:
	JSR.w CODE_008061
	BRA.b CODE_00804D

CODE_008061:
	JSR.w CODE_008288
	JSR.w CODE_008690
	REP.b #$20
	LDA.w #$0001
	COP.b #$00
	JSR.w CODE_00825F
	SEP.b #$20
	JSR.w CODE_0096BE
	JSL.l CODE_01C6C8
	JSR.w CODE_00961C
	REP.b #$20
	LDA.w #$0080
	STA.w $02BF
	SEP.b #$20
	LDA.w $0195
	AND.b #$08
	BEQ.b CODE_008092
	LDA.b #$02
	BRA.b CODE_008094

CODE_008092:
	LDA.b #$01
CODE_008094:
	STA.b $04
	LDA.b #$81
	STA.b $B1
	STA.b $B3
	STA.w !REGISTER_IRQNMIAndJoypadEnableFlags
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	JSL.l CODE_018907
	RTS

CODE_0080B2:
	SEI
	SEP.b #$20
	PHA
	LDA.l $0000B1
	BMI.b CODE_0080C0
	INC.b $B9
	PLA
	RTI

CODE_0080C0:
	PLA
	REP.b #$30
	PHD
	PHB
	PHA
	PHX
	PHY
	LDA.w #$0000
	TCD
	SEP.b #$20
if !CurrentBank != $00
	LDA.b #CODE_0080B2>>16
endif
	PHA
	PLB
	LDA.w !REGISTER_NMIEnable
	LDA.b $12
	BNE.b CODE_0080DA
	JMP.w CODE_0081B5

CODE_0080DA:
	JSR.w CODE_00BADA
	JSR.w CODE_008C28
	JSR.w CODE_008CDD
	JSR.w CODE_008707
	JSR.w CODE_00833A
	JSR.w CODE_009318
	JSR.w CODE_008A14
	JSR.w CODE_008C42
	JSR.w CODE_008397
	JSR.w CODE_008851
	JSR.w CODE_00BC3F
	REP.b #$20
	LDA.w $0379
	BNE.b CODE_008122
	JSR.w CODE_008924
	JSR.w CODE_008982
	REP.b #$20
	LDA.w $0103
	BEQ.b CODE_008112
	DEC.w $0103
CODE_008112:
	LDA.w $010F
	BEQ.b CODE_00811A
	DEC.w $010F
CODE_00811A:
	LDA.w $038B
	BEQ.b CODE_008122
	DEC.w $038B
CODE_008122:
	LDA.b $56
	BEQ.b CODE_008128
	DEC.b $56
CODE_008128:
	LDA.w $038D
	BEQ.b CODE_008130
	DEC.w $038D
CODE_008130:
	JSR.w CODE_00C1FA
	BCC.b CODE_008151
	LDA.w $0AF1
	BEQ.b CODE_00813F
	JSR.w CODE_00C3F9
	BRA.b CODE_008151

CODE_00813F:
	JSR.w CODE_00B502
	JSR.w CODE_00B743
	JSR.w CODE_00B1AB
	JSR.w CODE_00AE83
	JSR.w CODE_00AB92
	JSR.w CODE_00B0C1
CODE_008151:
	JSR.w CODE_00927C
	JSR.w CODE_0086F6
	JSR.w CODE_0092CC
	LDA.b $C3
	BNE.b CODE_0081A4
	LDA.w $01FF
	BNE.b CODE_008193
	LDX.b $AD
	BNE.b CODE_00817C
	LDA.w $011B
	AND.w #$FFF0
	BNE.b CODE_008193
	TSC
	STA.b $A9
	LDA.b $AB
	TCS
	LDA.w #$0001
	STA.b $AD
	BRA.b CODE_008193

CODE_00817C:
	LDA.w $011B
	AND.w #$FFF0
	BNE.b CODE_00818B
	LDA.b $D1
	AND.w #$0003
	BNE.b CODE_008193
CODE_00818B:
	STZ.b $AD
	TSC
	STA.b $AB
	LDA.b $A9
	TCS
CODE_008193:
	JSR.w CODE_009870
	SEP.b #$20
	LDA.b #$01
	STA.b $B9
	REP.b #$30
	PLY
	PLX
	PLA
	PLB
	PLD
	RTI

CODE_0081A4:
	JSR.w CODE_009870
	SEP.b #$20
	LDA.b #$01
	STA.b $B9
	REP.b #$30
	PLY
	PLX
	PLA
	PLB
	PLD
	RTI

CODE_0081B5:
	SEP.b #$20
	LDA.b !RAM_SIMC_Global_HDMAEnable
	STA.w !REGISTER_HDMAEnable
	JSR.w CODE_008CDD
	LDA.b !RAM_SIMC_TitleScreenAndMenu_Layer1XPosLo
	STA.w !REGISTER_BG1HorizScrollOffset
	LDA.b !RAM_SIMC_TitleScreenAndMenu_Layer1XPosHi
	STA.w !REGISTER_BG1HorizScrollOffset
	LDA.b !RAM_SIMC_TitleScreenAndMenu_Layer2XPosLo
	STA.w !REGISTER_BG2HorizScrollOffset
	LDA.b !RAM_SIMC_TitleScreenAndMenu_Layer2XPosHi
	STA.w !REGISTER_BG2HorizScrollOffset
	LDA.b !RAM_SIMC_TitleScreenAndMenu_Layer3XPosLo
	STA.w !REGISTER_BG3HorizScrollOffset
	LDA.b !RAM_SIMC_TitleScreenAndMenu_Layer3XPosHi
	STA.w !REGISTER_BG3HorizScrollOffset
	LDA.b !RAM_SIMC_TitleScreenAndMenu_Layer1YPosLo
	STA.w !REGISTER_BG1VertScrollOffset
	LDA.b !RAM_SIMC_TitleScreenAndMenu_Layer1YPosHi
	STA.w !REGISTER_BG1VertScrollOffset
	LDA.b !RAM_SIMC_TitleScreenAndMenu_Layer2YPosLo
	STA.w !REGISTER_BG2VertScrollOffset
	LDA.b !RAM_SIMC_TitleScreenAndMenu_Layer2YPosHi
	STA.w !REGISTER_BG2VertScrollOffset
	LDA.b !RAM_SIMC_TitleScreenAndMenu_Layer3YPosLo
	STA.w !REGISTER_BG3VertScrollOffset
	LDA.b !RAM_SIMC_TitleScreenAndMenu_Layer3YPosHi
	STA.w !REGISTER_BG3VertScrollOffset
	JSR.w CODE_00833A
	JSR.w CODE_008D65
	JSR.w CODE_00927C
	BRA.b CODE_008193

CODE_008206:
	PHP
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	PLP
	RTL

CODE_008210:
	RTI

CODE_008211:				; Note: This is the routine that COP opcode jumps to.
	CLI
	PHB
	PEA.w ((CODE_008211&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	REP.b #$20
	REP.b #$10
	ASL
	TAX
	JSR.w (DATA_008223,x)
	PLB
	RTI

DATA_008223:
	dw CODE_00930D
	dw CODE_0086A4
	dw CODE_008EA9
	dw CODE_008E43
	dw CODE_008E75
	dw CODE_00930D
	dw CODE_00930D
	dw CODE_009479
	dw CODE_0090DD
	dw CODE_008F82
	dw CODE_0086C8

CODE_008239:
	RTI

CODE_00823A:
	JSR.w CODE_00823E
	RTL

CODE_00823E:
	REP.b #$20
	LDA.b $C7
	STA.b $59
	INC
	STA.b $5B
	INC
	STA.b $5D
	RTS

CODE_00824B:
	JSR.w CODE_00824F
	RTL

CODE_00824F:
	REP.b #$20
	CLC
	LDA.b $59
	STA.b $5D
	ADC.b $5B
	STA.b $59
	ADC.b $5D
	STA.b $5B
	RTS

CODE_00825F:
	SEP.b #$20
	REP.b #$10
	LDA.b #CODE_038000>>16
	STA.w $1F7F
	LDA.b #CODE_038000>>8
	STA.w $1F7E
	LDA.b #CODE_038000
	STA.w $1F7D
	LDA.b #$00
	STA.w $1F7C
	LDX.w #$1EFF
	STX.w $1F7A
	LDX.w #$001F72
	STX.b $AB
	LDX.w #$0000
	STX.b $AD
	RTS

CODE_008288:
	SEP.b #$20
	SEP.b #$10
	LDA.b #$8F
	STA.w !REGISTER_ScreenDisplayRegister
	LDA.b #$03
	STA.b !RAM_SIMC_Global_OAMSizeAndDataAreaDesignation
	LDA.b #$09
	STA.b !RAM_SIMC_Global_BGModeAndTileSizeSetting
	LDA.b #$58
	STA.b !RAM_SIMC_Global_BG1AddressAndSize
	LDA.b #$5C
	STA.b !RAM_SIMC_Global_BG2AddressAndSize
	LDA.b #$54
	STA.b !RAM_SIMC_Global_BG3AddressAndSize
	STZ.b !RAM_SIMC_Global_BG4AddressAndSize
	LDA.b #$00
	STA.b !RAM_SIMC_Global_BG1And2TileDataDesignation
	LDA.b #$04
	STA.b !RAM_SIMC_Global_BG3And4TileDataDesignation
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	LDA.b #$00
	STA.w !REGISTER_Mode7TilemapSettings
	STA.w !REGISTER_Mode7MatrixParameterA
	LDA.b #$01
	STA.w !REGISTER_Mode7MatrixParameterA
	STZ.w !REGISTER_Mode7MatrixParameterB
	STZ.w !REGISTER_Mode7MatrixParameterB
	STZ.w !REGISTER_Mode7MatrixParameterC
	STZ.w !REGISTER_Mode7MatrixParameterC
	STZ.w !REGISTER_Mode7MatrixParameterD
	STA.w !REGISTER_Mode7MatrixParameterD
	LDA.b #$00
	STA.w !REGISTER_Mode7CenterX
	STA.w !REGISTER_Mode7CenterX
	STA.w !REGISTER_Mode7CenterY
	STA.w !REGISTER_Mode7CenterY
	LDA.b #$00
	STA.b !RAM_SIMC_Global_BG1And2WindowMaskSettings
	STA.b !RAM_SIMC_Global_BG3And4WindowMaskSettings
	STA.w !REGISTER_Window1LeftPositionDesignation
	STA.w !REGISTER_Window1RightPositionDesignation
	STA.w !REGISTER_Window2RightPositionDesignation
	LDA.b #$17
	STA.b !RAM_SIMC_Global_MainScreenLayers
	STZ.b !RAM_SIMC_Global_SubScreenLayers
	STZ.b !RAM_SIMC_Global_MainScreenWindowMask
	STZ.b !RAM_SIMC_Global_SubScreenWindowMask
	STZ.w !REGISTER_InitialScreenSettings
	STZ.b !RAM_SIMC_Global_ColorMathInitialSettings
	STZ.b !RAM_SIMC_Global_ColorMathSelectAndEnable
	STZ.b !RAM_SIMC_Global_FixedColorData
	STZ.b !RAM_SIMC_Global_ObjectAndColorWindowSettings
	STZ.b !RAM_SIMC_Global_BGWindowLogicSettings
	STZ.w !REGISTER_ColorAndObjectWindowLogicSettings
	STZ.b $B1
	STZ.b $B3
	LDA.b #$FF
	STA.w !REGISTER_ProgrammableIOPortOutput
	LDA.b #$00
	STA.w !REGISTER_Multiplicand
	STA.w !REGISTER_Multiplier
	STA.w !REGISTER_DividendLo
	STA.w !REGISTER_DividendHi
	STA.w !REGISTER_Divisor
	STA.w !REGISTER_HCountTimerLo
	STA.w !REGISTER_HCountTimerHi
	STA.w !REGISTER_VCountTimerLo
	STA.w !REGISTER_VCountTimerHi
	STA.w !REGISTER_DMAEnable
	STA.w !REGISTER_HDMAEnable
	STZ.w !REGISTER_EnableFastROM
	RTS

CODE_00833A:
	SEP.b #$20
	REP.b #$10
	LDX.b !RAM_SIMC_Global_ScreenDisplayRegister
	STX.w !REGISTER_ScreenDisplayRegister
	LDA.b !RAM_SIMC_Global_BGModeAndTileSizeSetting
	STA.w !REGISTER_BGModeAndTileSizeSetting
	LDX.b !RAM_SIMC_Global_BG1AddressAndSize
	STX.w !REGISTER_BG1AddressAndSize
	LDX.b !RAM_SIMC_Global_BG3AddressAndSize
	STX.w !REGISTER_BG3AddressAndSize
	LDX.b !RAM_SIMC_Global_BG1And2TileDataDesignation
	STX.w !REGISTER_BG1And2TileDataDesignation
	LDX.b !RAM_SIMC_Global_MainScreenLayers
	STX.w !REGISTER_MainScreenLayers
	LDX.b !RAM_SIMC_Global_MainScreenWindowMask
	STX.w !REGISTER_MainScreenWindowMask
	LDX.b !RAM_SIMC_Global_ColorMathInitialSettings
	STX.w !REGISTER_ColorMathInitialSettings
	LDA.b !RAM_SIMC_Global_FixedColorData
	STA.w !REGISTER_FixedColorData
	LDA.b !RAM_SIMC_Global_ObjectAndColorWindowSettings
	STA.w !REGISTER_ObjectAndColorWindowSettings
	LDA.b !RAM_SIMC_Global_BGWindowLogicSettings
	STA.w !REGISTER_BGWindowLogicSettings
	LDX.b !RAM_SIMC_Global_BG1And2WindowMaskSettings
	STX.w !REGISTER_BG1And2WindowMaskSettings
	LDA.w $019B
	BNE.b CODE_00838C
	LDA.b $D7
	BMI.b CODE_008396
	CMP.b #$01
	BEQ.b CODE_008396
	LDA.w $0379
	BNE.b CODE_008396
CODE_00838C:
	LDA.b #$00
	STA.w !REGISTER_Window2LeftPositionDesignation
	LDA.b #$F7
	STA.w !REGISTER_Window2RightPositionDesignation
CODE_008396:
	RTS

CODE_008397:
	REP.b #$20
	LDA.w $019B
	BNE.b CODE_0083B8
	LDA.b $D7
	BMI.b CODE_0083AC
	CMP.w #$0001
	BEQ.b CODE_0083AC
	LDA.w $0379
	BEQ.b CODE_0083AD
CODE_0083AC:
	RTS

CODE_0083AD:
	SEP.b #$20
	LDA.b #$0C
	STA.b !RAM_SIMC_Global_BG1And2WindowMaskSettings
	LDA.b #$01
	STA.b !RAM_SIMC_Global_MainScreenWindowMask
	RTS

CODE_0083B8:
	SEP.b #$20
	LDA.b #$0E
	STA.b !RAM_SIMC_Global_BG1And2WindowMaskSettings
	LDA.b #$07
	STA.b !RAM_SIMC_Global_MainScreenWindowMask
	RTS

CODE_0083C3:
	JSR.w CODE_0083C7
	RTL

CODE_0083C7:
	REP.b #$20
	LDA.w #$0150
	STA.w $0253
	LDA.w #$01BC
	STA.w $0259
	REP.b #$20
	LDA.w #$000A
	COP.b #$00
	JSR.w CODE_008449
	REP.b #$20
	STZ.w $0408
	RTS

CODE_0083E5:
	JSR.w CODE_008449
	REP.b #$20
	LDA.w #$0128
	STA.w $0253
	LDA.w #$01BC
	STA.w $0259
	REP.b #$20
	LDA.w #$000A
	COP.b #$00
	REP.b #$20
	STZ.w $0408
	RTS

CODE_008403:
	JSR.w CODE_008407
	RTL

CODE_008407:
	REP.b #$20
	LDA.w #$0100
	STA.w $0253
	LDA.w #$01BC
	STA.w $0259
	REP.b #$20
	LDA.w #$000A
	COP.b #$00
	JSR.w CODE_008449
	REP.b #$20
	STZ.w $0408
	RTS

CODE_008425:
	JSR.w CODE_008429
	RTL

CODE_008429:
	RTS

CODE_00842A:
	JSR.w CODE_008449
	RTL

CODE_00842E:
	JSR.w CODE_008449
	RTL

CODE_008432:
	JSR.w CODE_008436
	RTL

CODE_008436:
	REP.b #$20
	LDA.w !RAM_SIMC_City_CurrentFundsLo
	CMP.w $0BA1
	BNE.b CODE_008449
	LDA.w !RAM_SIMC_City_CurrentFundsHi
	CMP.w $0BA3
	BNE.b CODE_008449
	RTS

CODE_008449:
	LDA.w $01D7
	BEQ.b CODE_0084A8
	REP.b #$20
	LDA.w !RAM_SIMC_City_CurrentFundsLo
	STA.w $0BA1
	LDA.w !RAM_SIMC_City_CurrentFundsHi
	STA.w $0BA3
	LDA.w #$006C
	STA.w $0253
	STZ.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	STZ.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$0007
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #!RAM_SIMC_City_CurrentFundsLo
	JSR.w CODE_008FEF
	LDX.w #$0000
	TXY
	STZ.b $7F
CODE_008485:
	PHY
	LDA.w $0079,y
	ORA.b $7F
	BEQ.b CODE_00849D
	LDA.b #$00
	XBA
	LDA.w $0079,y
	TAY
	LDA.w DATA_0085E1,y
	STA.l SIMC_Global_OAMBuffer[$1C].Tile,x
	INC.b $7F
CODE_00849D:
	INX
	INX
	INX
	INX
	PLY
	INY
	CPY.w #$0006
	BNE.b CODE_008485
CODE_0084A8:
	RTS

CODE_0084A9:
	JSR.w CODE_0084AD
	RTL

CODE_0084AD:
	REP.b #$20
	STZ.w $0BB9
	LDA.w #$0001
	STA.w $0408
	LDA.w #$0010
	STA.w $0253
	STZ.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	STZ.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$0008
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #!RAM_SIMC_City_CurrentPopulationLo
	JSR.w CODE_008FEF
	LDX.w #$0000
	TXY
	STZ.b $7F
CODE_0084E1:
	PHY
	LDA.w $0079,y
	ORA.b $7F
	BEQ.b CODE_0084F9
	LDA.b #$00
	XBA
	LDA.w $0079,y
	TAY
	LDA.w DATA_0085E1,y
	STA.l SIMC_Global_OAMBuffer[$15].Tile,x
	INC.b $7F
CODE_0084F9:
	INX
	INX
	INX
	INX
	PLY
	INY
	CPY.w #$0006
	BNE.b CODE_0084E1
	SEP.b #$20
	REP.b #$10
	LDX.w !RAM_SIMC_City_CurrentYearLo
	STX.b $7F
	STZ.b $81
	LDX.w #$00007F
	JSR.w CODE_008FEF
	LDY.w #$0000
	TYX
	STZ.b $7F
CODE_00851B:
	PHY
	LDA.w $007B,y
	ORA.b $7F
	BEQ.b CODE_008533
	LDA.b #$00
	XBA
	LDA.w $007B,y
	TAY
	LDA.w DATA_0085E1,y
	STA.l SIMC_Global_OAMBuffer[$0B].Tile,x
	INC.b $7F
CODE_008533:
	PLY
	INX
	INX
	INX
	INX
	INY
	CPY.w #$0004
	BNE.b CODE_00851B
	REP.b #$30
	LDA.w !RAM_SIMC_City_CurrentMonthLo
	ASL
	ADC.w !RAM_SIMC_City_CurrentMonthLo
	ASL
	TAY
	LDX.w #$0000
	LDA.w DATA_008582,y
	STA.l SIMC_Global_OAMBuffer[$10].Tile,x
	LDA.w DATA_008582+$02,y
	STA.l SIMC_Global_OAMBuffer[$11].Tile,x
	LDA.w DATA_008582+$04,y
	STA.l SIMC_Global_OAMBuffer[$12].Tile,x
	SEP.b #$20
	LDX.w $0BBB
	LDA.w DATA_0085D0,x
	STA.l SIMC_Global_OAMBuffer[$08].YDisp
	LDX.w $0BBD
	LDA.w DATA_0085D0,x
	STA.l SIMC_Global_OAMBuffer[$09].YDisp
	LDX.w $0BBF
	LDA.w DATA_0085D0,x
	STA.l SIMC_Global_OAMBuffer[$0A].YDisp
	RTS

DATA_008582:
	dw $0000,$0000,$0000,$31C9,$31C0,$31CD,$31C5,$31C4
	dw $31C1,$31CC,$31C0,$31D1,$31C0,$31CF,$31D1,$31CC
	dw $31C0,$31D8,$31C9,$31D4,$31CD,$31C9,$31D4,$31CB
	dw $31C0,$31D4,$31C6,$31D2,$31C4,$31CF,$31CE,$31C2
	dw $31D3,$31CD,$31CE,$31D5,$31C3,$31C4,$31C2

DATA_0085D0:
	db $1E,$1D,$1C,$1B,$1A,$19,$18,$17,$16,$15,$14,$13,$12,$11,$10,$0F
	db $0E

DATA_0085E1:
	db $60,$61,$62,$63,$64,$70,$71,$72,$73,$74

CODE_0085EB:
	SEP.b #$20
	REP.b #$10
	LDA.b $D7
	CMP.b #$01
	BEQ.b CODE_0085F6
CODE_0085F5:
	RTL

CODE_0085F6:
	LDA.w $0BB9
	BEQ.b CODE_0085F5
	STZ.w $0BB9
CODE_0085FE:
	LDX.w #!RAM_SIMC_City_CurrentPopulationLo
	JSR.w CODE_008FEF
	LDX.w #$0000
	TXY
	STZ.b $7F
CODE_00860A:
	PHY
	CPY.w #$0005
	BEQ.b CODE_00861E
	LDA.w $0079,y
	ORA.b $7F
	BNE.b CODE_00861E
	REP.b #$20
	LDA.w #$24B5
	BRA.b CODE_00862B

CODE_00861E:
	REP.b #$20
	INC.b $7F
	LDA.w $0079,y
	AND.w #$000F
	ORA.w #$28A0
CODE_00862B:
	STA.l !RAM_SIMC_Global_Layer3TilemapBuffer+$00AE,x
	SEP.b #$20
	INX
	INX
	PLY
	INY
	CPY.w #$0006
	BNE.b CODE_00860A
	LDX.w #!RAM_SIMC_City_CurrentFundsLo
	JSR.w CODE_008FEF
	LDX.w #$0000
	TXY
	STZ.b $7F
CODE_008646:
	PHY
	CPY.w #$0005
	BEQ.b CODE_00865A
	LDA.w $0079,y
	ORA.b $7F
	BNE.b CODE_00865A
	REP.b #$20
	LDA.w #$24B5
	BRA.b CODE_008667

CODE_00865A:
	REP.b #$20
	INC.b $7F
	LDA.w $0079,y
	AND.w #$000F
	ORA.w #$28A0
CODE_008667:
	STA.l !RAM_SIMC_Global_Layer3TilemapBuffer+$012E,x
	SEP.b #$20
	INX
	INX
	PLY
	INY
	CPY.w #$0006
	BNE.b CODE_008646
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	LDA.b $BB
	ORA.b #$10
	STA.b $BB
	JSR.w CODE_008E21
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	RTL

CODE_008690:
	REP.b #$10
	SEP.b #$20
	LDX.w #$0000
	LDY.w #$8000
	STX.w !REGISTER_VRAMAddressLo
CODE_00869D:
	STX.w !REGISTER_WriteToVRAMPortLo
	DEY
	BNE.b CODE_00869D
	RTS

CODE_0086A4:
	SEP.b #$20
	REP.b #$10
	LDX.w #$00FC
	LDA.b #$80
CODE_0086AD:
	STA.l SIMC_Global_OAMBuffer[$00].XDisp,x
	STA.l SIMC_Global_OAMBuffer[$40].XDisp,x
	DEX
	DEX
	DEX
	DEX
	BPL.b CODE_0086AD
	LDX.w #$001F
	LDA.b #$55
CODE_0086C0:
	STA.l SIMC_Global_UpperOAMBuffer[$00].Slot,x
	DEX
	BPL.b CODE_0086C0
	RTS

CODE_0086C8:
	REP.b #$30
	LDA.w $0253
	AND.w #$FFFC
	TAX
	SEP.b #$20
	LDA.b #$E0
CODE_0086D5:
	STA.l SIMC_Global_OAMBuffer[$00].YDisp,x
	INX
	INX
	INX
	INX
	CPX.w $0259
	BCC.b CODE_0086D5
	RTS

CODE_0086E3:
	REP.b #$30
	LDX.w #$0020
	LDA.w #$0000
CODE_0086EB:
	DEX
	DEX
	BMI.b CODE_0086F5
	STA.l SIMC_Global_UpperOAMBuffer[$00].Slot,x
	BRA.b CODE_0086EB

CODE_0086F5:
	RTS

CODE_0086F6:
	SEP.b #$20
	LDA.b $D1
	AND.b #$03
	BNE.b CODE_008704
	LDA.b $BB
	ORA.b #$0C
	STA.b $BB
CODE_008704:
	INC.b $D1
	RTS

CODE_008707:
	REP.b #$30
	LDA.b $D7
	CMP.w #$0001
	BNE.b CODE_008718
	LDA.w !REGISTER_Joypad1Lo
	AND.w #$FFF0
	BNE.b CODE_008724
CODE_008718:
	LDA.b $E3
	BNE.b CODE_008724
	LDA.w $0193
	CMP.w #$0003
	BNE.b CODE_008732
CODE_008724:
	LDA.b $E1
	INC
	CMP.w #$0018
	BCC.b CODE_00872F
	LDA.w #$0000
CODE_00872F:
	STA.b $E1
	RTS

CODE_008732:
	LDA.b $E1
	INC
	CMP.w #$0018
	BCC.b CODE_00873D
	LDA.w #$0000
CODE_00873D:
	STA.b $E1
	ASL
	TAX
	JSR.w (DATA_008745,x)
CODE_008744:
	RTS

DATA_008745:
	dw CODE_008775
	dw CODE_0087A8
	dw CODE_008744
	dw CODE_008744
	dw CODE_0087DD
	dw CODE_00881C
	dw CODE_008744
	dw CODE_008744
	dw CODE_008744
	dw CODE_008744
	dw CODE_008744
	dw CODE_008744
	dw CODE_008775
	dw CODE_0087A8
	dw CODE_008744
	dw CODE_008744
	dw CODE_008744
	dw CODE_008744
	dw CODE_008744
	dw CODE_008744
	dw CODE_008744
	dw CODE_008744
	dw CODE_008744
	dw CODE_008744

CODE_008775:
	LDA.b $E5
	AND.w #$0003
	ASL
	TAX
	SEP.b #$20
	LDY.w #$3950
	STY.w !REGISTER_VRAMAddressLo
	LDA.b #$01
	STA.w DMA[$01].Parameters
	LDY.w DATA_0087A0,x
	STY.w DMA[$01].SourceLo
	LDA.b #DATA_05B000>>16
	STA.w DMA[$01].SourceBank
	LDY.w #$0660
	STY.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	RTS

DATA_0087A0:
	dw DATA_05B000+$06A0,DATA_05B000+$1AA0,DATA_05B000+$2EA0,DATA_05B000+$42A0

CODE_0087A8:
	LDA.b $E5
	INC.b $E5
	AND.w #$0003
	ASL
	TAX
	SEP.b #$20
	LDY.w #$3C80
	STY.w !REGISTER_VRAMAddressLo
	LDA.b #$01
	STA.w DMA[$01].Parameters
	LDY.w DATA_0087D5,x
	STY.w DMA[$01].SourceLo
	LDA.b #DATA_05B000>>16
	STA.w DMA[$01].SourceBank
	LDY.w #$0700
	STY.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	RTS

DATA_0087D5:
	dw DATA_05B000+$0D00,DATA_05B000+$2100,DATA_05B000+$3500,DATA_05B000+$4900

CODE_0087DD:
	LDA.b $E9
	ASL
	TAX
	SEP.b #$20
	LDY.w #$3600
	STY.w !REGISTER_VRAMAddressLo
	LDA.b #$01
	STA.w DMA[$01].Parameters
	LDY.w DATA_008810,x
	STY.w DMA[$01].SourceLo
	LDA.b #DATA_05B000>>16
	STA.w DMA[$01].SourceBank
	LDY.w #$02C0
	STY.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	LDA.b $E9
	INC
	CMP.b #$06
	BCC.b CODE_00880D
	LDA.b #$00
CODE_00880D:
	STA.b $E9
	RTS

DATA_008810:
	dw DATA_05B000+$0000,DATA_05B000+$1400,DATA_05B000+$2800,DATA_05B000+$3C00,DATA_05B000+$2800,DATA_05B000+$1400

CODE_00881C:
	LDA.b $E7
	INC.b $E7
	AND.w #$0003
	ASL
	TAX
	SEP.b #$20
	LDY.w #$3760
	STY.w !REGISTER_VRAMAddressLo
	LDA.b #$01
	STA.w DMA[$01].Parameters
	LDY.w DATA_008849,x
	STY.w DMA[$01].SourceLo
	LDA.b #DATA_05B000>>16
	STA.w DMA[$01].SourceBank
	LDY.w #$03E0
	STY.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	RTS

DATA_008849:
	dw DATA_05B000+$02C0,DATA_05B000+$16C0,DATA_05B000+$2AC0,DATA_05B000+$3EC0

CODE_008851:
	REP.b #$30
	LDA.b $E3
	ORA.w $0101
	BNE.b CODE_0088B3
	LDA.w $0193
	CMP.w #$0003
	BEQ.b CODE_0088B3
	LDX.w #$00D0
	LDA.b $FF
	INC
	CMP.w #$000C
	BNE.b CODE_00887D
	LDA.b $FD
	INC
	CMP.w #$0007
	BCC.b CODE_008878
	LDA.w #$0000
CODE_008878:
	STA.b $FD
	LDA.w #$0000
CODE_00887D:
	STA.b $FF
	BNE.b CODE_0088B3
	LDA.b $FD
	ASL
	ASL
	ASL
	ASL
	TAY
CODE_008888:
	LDA.w DATA_0088B4,y
	STA.l SIMC_Global_PaletteMirror[$00].LowByte,x
	INX
	INX
	INY
	INY
	CPX.w #$00D8
	BCC.b CODE_008888
	INX
	INX
	INY
	INY
CODE_00889C:
	LDA.w DATA_0088B4,y
	STA.l SIMC_Global_PaletteMirror[$00].LowByte,x
	INX
	INX
	INY
	INY
	CPX.w #$00E0
	BCC.b CODE_00889C
	LDA.b $BB
	ORA.w #$0002
	STA.b $BB
CODE_0088B3:
	RTS

DATA_0088B4:
	incbin "Palettes/DATA_0088B4.bin"

CODE_008924:
	REP.b #$30
	LDA.w $0105
	BNE.b CODE_008934
	STZ.w $0107
	LDA.w $0109
	BNE.b CODE_008934
	RTS

CODE_008934:
	LDA.w $0107
	AND.w #$0003
	BNE.b CODE_008955
	LDX.w $0107
	LDA.w DATA_00896A,x
	STA.l SIMC_Global_PaletteMirror[$B2].LowByte
	LDA.w DATA_00896A+$02,x
	STA.l SIMC_Global_PaletteMirror[$BE].LowByte
	SEP.b #$20
	LDA.b $BB
	ORA.b #$02
	STA.b $BB
CODE_008955:
	REP.b #$20
	LDA.w $0107
	INC
	CMP.w #$0018
	BCC.b CODE_008963
	LDA.w #$0000
CODE_008963:
	STA.w $0107
	STZ.w $0109
	RTS

DATA_00896A:
	incbin "Palettes/DATA_00896A.bin"

CODE_008982:
	REP.b #$30
	LDA.w $0111
	BNE.b CODE_008992
	STZ.w $0113
	LDA.w $0115
	BNE.b CODE_008992
	RTS

CODE_008992:
	LDA.w $0113
	AND.w #$0003
	BNE.b CODE_0089B3
	LDX.w $0113
	LDA.w DATA_0089C8,x
	STA.l SIMC_Global_PaletteMirror[$BD].LowByte
	LDA.w DATA_0089C8+$02,x
	STA.l SIMC_Global_PaletteMirror[$BF].LowByte
	SEP.b #$20
	LDA.b $BB
	ORA.b #$02
	STA.b $BB
CODE_0089B3:
	REP.b #$20
	LDA.w $0113
	INC
	CMP.w #$0018
	BCC.b CODE_0089C1
	LDA.w #$0000
CODE_0089C1:
	STA.w $0113
	STZ.w $0115
	RTS

DATA_0089C8:
	incbin "Palettes/DATA_0089C8.bin"

DATA_0089E0:
	dw DATA_02E5A3,DATA_02E5BF,DATA_02E5EB,DATA_02E627,DATA_02E673,DATA_02E6CF,DATA_02E73B,DATA_02E7B7
	dw DATA_02E843,DATA_02E8DF,DATA_02E98B,DATA_02EA47,DATA_02EB13,DATA_02EBEF,DATA_02ECDB,DATA_02EDD7
	dw DATA_02EEE6,DATA_02F005,DATA_02F134,DATA_02F273,DATA_02F3C2,DATA_02F521,DATA_02F690,DATA_02F80F
	dw DATA_02F99E,DATA_02FB3D

CODE_008A14:
	REP.b #$30
	LDA.b $D7
	BEQ.b CODE_008A29
	DEC
	BNE.b CODE_008A20
	JMP.w CODE_008A5C

CODE_008A20:
	DEC
	BNE.b CODE_008A26
	JMP.w CODE_008B21

CODE_008A26:
	STZ.b !RAM_SIMC_Global_HDMAEnable
	RTS

CODE_008A29:
	LDA.w $0391
	BEQ.b CODE_008A4A
	LDA.w #DATA_008A4B
	STA.w HDMA[$07].SourceLo
	SEP.b #$20
if !CurrentBank != $00
	LDA.b #DATA_008A4B>>16
	STA.w HDMA[$07].SourceBank
	STA.w HDMA[$07].IndirectSourceBank
else
	STZ.w HDMA[$07].SourceBank
	STZ.w HDMA[$07].IndirectSourceBank
endif
	LDA.b #$41
	STA.w HDMA[$07].Parameters
	LDA.b #!REGISTER_Window2LeftPositionDesignation
	STA.w HDMA[$07].Destination
	LDA.b #$80
	STA.b !RAM_SIMC_Global_HDMAEnable
CODE_008A4A:
	RTS

DATA_008A4B:
	db $18 : dw DATA_008A58
	db $54 : dw DATA_008A5A
	db $54 : dw DATA_008A5A
	db $20 : dw DATA_008A58
	db $00

DATA_008A58:
	db $FF,$00

DATA_008A5A:
	db $18,$E8

CODE_008A5C:
	SEP.b #$20
	LDA.b #$17
	STA.b !RAM_SIMC_Global_MainScreenLayers
	STZ.b !RAM_SIMC_Global_ColorMathSelectAndEnable
	LDA.b #$C3
	STA.b !RAM_SIMC_Global_BG1And2WindowMaskSettings
	LDA.b #$0A
	STA.b !RAM_SIMC_Global_BG3And4WindowMaskSettings
	LDA.b #$17
	STA.b !RAM_SIMC_Global_MainScreenWindowMask
	LDA.b #$10
	STA.b !RAM_SIMC_Global_BGWindowLogicSettings
	REP.b #$30
	STZ.b $91
	LDA.w $0C0F
	BEQ.b CODE_008A90
	LDA.b $D1
	AND.w #$0008
	BEQ.b CODE_008A8B
	LDA.w #$0002
	STA.b $91
	BRA.b CODE_008A90

CODE_008A8B:
	LDA.w #$FFFE
	STA.b $91
CODE_008A90:
	LDA.w $0139
	CLC
	ADC.b $91
	SEC
	SBC.w #$0003
	STA.b $91
	LDX.w #$0000
	LDY.w #$0038
	SEP.b #$20
	LDA.b #$03
	BRA.b CODE_008AAC

CODE_008AA8:
	SEP.b #$20
	LDA.b #$04
CODE_008AAC:
	STA.w $0567,x
	STA.w $06B8,x
	INX
	REP.b #$20
	LDA.b $91
	STA.w $0567,x
	CLC
	ADC.w #$0008
	STA.w $06B8,x
	LDA.b $91
	CLC
	ADC.w #$0001
	STA.b $91
	INX
	INX
	DEY
	BNE.b CODE_008AA8
	SEP.b #$20
	LDA.b #$00
	STA.w $0567,x
	STA.w $06B8,x
	LDX.w #$0006B8
	STX.w HDMA[$06].SourceLo
	LDA.b #$02
	STA.w HDMA[$06].Parameters
	LDA.b #!REGISTER_BG1HorizScrollOffset
	STA.w HDMA[$06].Destination
	STZ.w HDMA[$06].SourceBank
	STZ.w HDMA[$06].IndirectSourceBank
	LDX.w #$000567
	STX.w HDMA[$07].SourceLo
	LDA.b #$02
	STA.w HDMA[$07].Parameters
	LDA.b #!REGISTER_BG2HorizScrollOffset
	STA.w HDMA[$07].Destination
	STZ.w HDMA[$07].SourceBank
	STZ.w HDMA[$07].IndirectSourceBank
	LDX.w #DATA_008B4C
	STX.w HDMA[$05].SourceLo
	LDA.b #$04
	STA.w HDMA[$05].Parameters
	LDA.b #!REGISTER_Window1LeftPositionDesignation
	STA.w HDMA[$05].Destination
if !CurrentBank != $00
	LDA.b #DATA_008B4C>>16
	STA.w HDMA[$05].SourceBank
else
	STZ.w HDMA[$05].SourceBank
endif
	STZ.w HDMA[$07].IndirectSourceBank
	LDA.b !RAM_SIMC_Global_HDMAEnable
	ORA.b #$E0
	STA.b !RAM_SIMC_Global_HDMAEnable
	RTS

CODE_008B21:
	REP.b #$20
	LDA.w $0463
	ASL
	TAX
	LDA.w DATA_0089E0,x
	STA.w HDMA[$07].SourceLo
	SEP.b #$30
	LDA.b #DATA_02E5A3>>16
	STA.w HDMA[$07].SourceBank
	LDX.w $0463
	BNE.b CODE_008B3D
	STA.w HDMA[$07].IndirectSourceBank
CODE_008B3D:
	LDA.b #$41
	STA.w HDMA[$07].Parameters
	LDA.b #!REGISTER_Window1LeftPositionDesignation
	STA.w HDMA[$07].Destination
	LDA.b #$80
	STA.b !RAM_SIMC_Global_HDMAEnable
	RTS

DATA_008B4C:
	db $2B,$01,$00,$01,$00,$04,$36,$E8,$01,$00,$04,$35,$E7,$37,$E7,$04
	db $34,$E6,$36,$E6,$04,$33,$E5,$35,$E5,$04,$32,$E4,$34,$E4,$04,$31
	db $E3,$33,$E3,$04,$30,$E2,$32,$E2,$04,$2F,$E1,$31,$E1,$04,$2E,$E0
	db $30,$E0,$04,$2D,$DF,$2F,$DF,$04,$2C,$DE,$2E,$DE,$04,$2B,$DD,$2D
	db $DD,$04,$2A,$DC,$2C,$DC,$04,$29,$DB,$2B,$DB,$04,$28,$DA,$2A,$DA
	db $04,$27,$D9,$29,$D9,$04,$26,$D8,$28,$D8,$04,$25,$D7,$27,$D7,$04
	db $24,$D6,$26,$D6,$04,$23,$D5,$25,$D5,$04,$22,$D4,$24,$D4,$04,$21
	db $D3,$23,$D3,$04,$20,$D2,$22,$D2,$04,$1F,$D1,$21,$D1,$04,$1E,$D0
	db $20,$D0,$04,$1D,$CF,$1F,$CF,$04,$1C,$CE,$1E,$CE,$04,$1B,$CD,$1D
	db $CD,$04,$1A,$CC,$1C,$CC,$04,$19,$CB,$1B,$CB,$04,$18,$CA,$1A,$CA
	db $04,$17,$C9,$19,$C9,$04,$16,$C8,$18,$C8,$04,$15,$C7,$17,$C7,$04
	db $14,$C6,$16,$C6,$04,$13,$C5,$15,$C5,$04,$12,$C4,$14,$C4,$04,$11
	db $C3,$13,$C3,$04,$10,$C2,$12,$C2,$04,$0F,$C1,$11,$C1,$04,$0E,$C0
	db $10,$C0,$01,$01,$00,$01,$00,$00

ADDR_008C24:
	JSR.w CODE_008C28
	RTL

CODE_008C28:
	SEP.b #$20
	LDA.b !RAM_SIMC_Global_ScreenDisplayRegister
	BPL.b CODE_008C32
	STZ.w !REGISTER_HDMAEnable
	RTS

CODE_008C32:
	LDA.b !RAM_SIMC_Global_HDMAEnable
	BNE.b CODE_008C3A
	CMP.b $77
	BEQ.b CODE_008C41
CODE_008C3A:
	STA.w !REGISTER_HDMAEnable
	STA.b $77
	STZ.b !RAM_SIMC_Global_HDMAEnable
CODE_008C41:
	RTS

CODE_008C42:
	REP.b #$30
	LDA.b $D7
	BPL.b CODE_008C4B
	JMP.w CODE_008CD2

CODE_008C4B:
	BEQ.b CODE_008C5A
	DEC
	BNE.b CODE_008C53
	JMP.w CODE_008C84

CODE_008C53:
	DEC
	BNE.b CODE_008C59
	JMP.w CODE_008CBD

CODE_008C59:
	RTS

CODE_008C5A:
	JSR.w CODE_008D65
	JSR.w CODE_008DA6
	SEP.b #$20
	LDA.b $E3
	BNE.b CODE_008C7D
	LDA.b $E1
	INC
	CMP.b #$18
	BCS.b CODE_008C83
	AND.b #$03
	CMP.b #$02
	BNE.b CODE_008C76
	JMP.w CODE_008DD9

CODE_008C76:
	CMP.b #$03
	BNE.b CODE_008C83
	JMP.w CODE_008DFB

CODE_008C7D:
	JSR.w CODE_008DD9
	JSR.w CODE_008DFB
CODE_008C83:
	RTS

CODE_008C84:
	JSR.w CODE_008D65
	JSR.w CODE_008DA6
	SEP.b #$20
	LDA.b $E3
	BNE.b CODE_008CAB
	LDA.b $E1
	INC
	CMP.b #$18
	BCS.b CODE_008CBC
	AND.b #$03
	CMP.b #$02
	BNE.b CODE_008CA2
	JSR.w CODE_008DD9
	BRA.b CODE_008CB1

CODE_008CA2:
	CMP.b #$03
	BNE.b CODE_008CB1
	JSR.w CODE_008DFB
	BRA.b CODE_008CB1

CODE_008CAB:
	JSR.w CODE_008DD9
	JSR.w CODE_008DFB
CODE_008CB1:
	REP.b #$20
	LDA.b $DF
	BEQ.b CODE_008CBC
	JSR.w CODE_008E21
	STZ.b $DF
CODE_008CBC:
	RTS

CODE_008CBD:
	JSR.w CODE_008DA6
	REP.b #$20
	LDA.b $D1
	LSR
	BCS.b CODE_008CCE
	JSR.w CODE_008DD9
	JSR.w CODE_008DFB
	RTS

CODE_008CCE:
	JSR.w CODE_008E21
	RTS

CODE_008CD2:
	JSR.w CODE_008D65
	JSR.w CODE_008DD9
	RTS

CODE_008CD9:
	JSR.w CODE_008CDD
	RTL

CODE_008CDD:
	SEP.b #$20
	REP.b #$10
	LDA.b $B7
	AND.b #$01
	STA.w !REGISTER_DMAEnable
	LDA.b $B7
	AND.b #$02
	BEQ.b CODE_008D15
	LDA.w $0145
	STA.w !REGISTER_CGRAMAddress
	LDX.w $0165
	STX.w DMA[$01].SourceLo
	LDA.b #!RAM_SIMC_Global_PaletteMirror>>16
	STA.w DMA[$01].SourceBank
	LDX.w $0185
	STX.w DMA[$01].SizeLo
	LDA.w $0175
	STA.w DMA[$01].Destination
	LDA.b #$00
	STA.w DMA[$01].Parameters
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
CODE_008D15:
	LDA.b #$01
	STA.w DMA[$01].Parameters
	LDA.b #!RAM_SIMC_Global_Layer1TilemapBuffer>>16
	STA.w DMA[$01].SourceBank
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$01].Destination
	LDA.b $B7
	LSR
	LSR
	LDX.w #$0004
CODE_008D2B:
	LSR
	BCC.b CODE_008D47
	PHA
	LDY.w $0143,x
	STY.w !REGISTER_VRAMAddressLo
	LDY.w $0163,x
	STY.w DMA[$01].SourceLo
	LDY.w $0183,x
	STY.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	PLA
CODE_008D47:
	INX
	INX
	CPX.w #$0010
	BNE.b CODE_008D2B
	STZ.b $B7
	RTS

DATA_008D51:
	db $01,$02,$04,$08,$10,$20,$40,$80,$00,$10,$20,$30,$40,$50,$60,$70

ADDR_008D61:
	JSR.w CODE_008D65
	RTL

CODE_008D65:
	SEP.b #$20
	LDA.b #$00
	STA.w !REGISTER_OAMAddressLo
	STA.w !REGISTER_OAMAddressHi
	SEP.b #$30
	LDA.b #$00
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$00
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_OAMDataWritePort
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_OAMBuffer
	STA.w DMA[$00].SourceLo,x
	LDA.b #!RAM_SIMC_Global_OAMBuffer>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #!RAM_SIMC_Global_OAMBuffer>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$20
	STA.w DMA[$00].SizeLo,x
	LDA.b #$02
	STA.w DMA[$00].SizeHi,x
	LDA.b $B7
	ORA.b #$01
	STA.b $B7
	RTS

CODE_008DA2:
	JSR.w CODE_008DA6
	RTL

CODE_008DA6:
	SEP.b #$20
	REP.b #$10
	LDA.b $BB
	AND.b #$02
	BEQ.b CODE_008DD8
	REP.b #$20
	LDX.w #SIMC_Global_PaletteMirror[$00].LowByte
	STX.w $0165
	LDX.w #$0000
	STX.w $0145
	LDA.w #!REGISTER_WriteToCGRAMPort&$0000FF
	STA.w $0175
	LDX.w #$0200
	STX.w $0185
	LDA.b $B7
	ORA.w #$0002
	STA.b $B7
	LDA.b $BB
	AND.w #$FFFD
	STA.b $BB
CODE_008DD8:
	RTS

CODE_008DD9:
	SEP.b #$20
	REP.b #$10
	LDX.w #!RAM_SIMC_Global_Layer1TilemapBuffer
	STX.w $0167
	LDA.b #$18
	STA.w $0177
	LDX.w #$0800
	STX.w $0187
	LDX.w #$5800
	STX.w $0147
	LDA.b $B7
	ORA.b #$04
	STA.b $B7
	RTS

CODE_008DFB:
	SEP.b #$20
	REP.b #$10
	LDX.w #!RAM_SIMC_Global_Layer2TilemapBuffer
	STX.w $0169
	LDA.b #$18
	STA.w $0179
	LDX.w #$0800
	STX.w $0189
	LDX.w #$5C00
	STX.w $0149
	LDA.b $B7
	ORA.b #$08
	STA.b $B7
	RTS

CODE_008E1D:
	JSR.w CODE_008E21
	RTL

CODE_008E21:
	SEP.b #$20
	REP.b #$10
	LDX.w #!RAM_SIMC_Global_Layer3TilemapBuffer
	STX.w $0167
	LDA.b #$18
	STA.w $0177
	LDX.w #$0800
	STX.w $0187
	LDX.w #$5400
	STX.w $0147
	LDA.b $B7
	ORA.b #$04
	STA.b $B7
	RTS

CODE_008E43:
	SEP.b #$20
	LDA.b $B3
	PHA
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	SEP.b #$20
	LDA.b #$00
CODE_008E54:
	PHA
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	SEP.b #$20
	PLA
	STA.b !RAM_SIMC_Global_ScreenDisplayRegister
	INC
	CMP.b #$10
	BCC.b CODE_008E54
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	SEP.b #$20
	PLA
	STA.b $B3
	STA.b $B1
	RTS

CODE_008E75:
	SEP.b #$20
	LDA.b $B3
	PHA
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	SEP.b #$20
	LDA.b #$0F
CODE_008E86:
	PHA
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	SEP.b #$20
	PLA
	STA.b !RAM_SIMC_Global_ScreenDisplayRegister
	DEC
	BPL.b CODE_008E86
	LDA.b #$8F
	STA.b !RAM_SIMC_Global_ScreenDisplayRegister
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	SEP.b #$20
	PLA
	STA.b $B3
	STA.b $B1
	RTS

CODE_008EA9:				; Note: Routine that draws the title screen sprites.
	REP.b #$30
	LDA.w $0261
	ASL
	TAY
	LDA.w DATA_00A164,y
	PHA
	LDY.w #$0000
	LDX.w $0253
CODE_008EBA:
	LDA.w #$0008
	STA.w $0251
	LDA.b ($01,S),y
	STA.w $025B
	INY
	INY
CODE_008EC7:
	TXA
	LSR
	LSR
	LSR
	LSR
	AND.w #$FFFE
	STA.w $0255
	TXA
	LSR
	AND.w #$000E
	STA.w $0257
	LDA.b ($01,S),y
	AND.w #$00FF
	LSR.w $025B
	BCC.b CODE_008EE7
	ORA.w #$0100
CODE_008EE7:
	CMP.w #$0100
	BEQ.b CODE_008F4D
	CLC
	ADC.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	SEP.b #$20
	STA.l SIMC_Global_OAMBuffer[$00].XDisp,x
	REP.b #$20
	PHY
	PHX
	LDX.w $0255
	LDY.w $0257
	AND.w #$0100
	PHP
	LDA.l SIMC_Global_UpperOAMBuffer[$00].Slot,x
	AND.w DATA_008F72,y
	PLP
	BEQ.b CODE_008F11
	ORA.w DATA_008F52,y
CODE_008F11:
	LSR.w $025B
	BCC.b CODE_008F19
	ORA.w DATA_008F62,y
CODE_008F19:
	STA.l SIMC_Global_UpperOAMBuffer[$00].Slot,x
	PLX
	PLY
	INY
	SEP.b #$20
	LDA.b #$00
	XBA
	LDA.b ($01,S),y
	REP.b #$20
	CLC
	ADC.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	SEP.b #$20
	STA.l SIMC_Global_OAMBuffer[$00].YDisp,x
	INY
	REP.b #$20
	LDA.b ($01,S),y
	STA.l SIMC_Global_OAMBuffer[$00].Tile,x
	INY
	INY
	INX
	INX
	INX
	INX
	DEC.w $0251
	BEQ.b CODE_008F4A
	JMP.w CODE_008EC7

CODE_008F4A:
	JMP.w CODE_008EBA

CODE_008F4D:
	STX.w $0253
	PLA
	RTS

DATA_008F52:
	db $01,$00,$04,$00,$10,$00,$40,$00,$00,$01,$00,$04,$00,$10,$00,$40

DATA_008F62:
	db $02,$00,$08,$00,$20,$00,$80,$00,$00,$02,$00,$08,$00,$20,$00,$80

DATA_008F72:
	db $FC,$FF,$F3,$FF,$CF,$FF,$3F,$FF,$FF,$FC,$FF,$F3,$FF,$CF,$FF,$3F

CODE_008F82:
	SEP.b #$20
	REP.b #$10
	LDX.b $10
	LDA.w $0267,x
	BNE.b CODE_008FC9
	PHX
	LDA.b #$00
	XBA
	LDA.w $0263,x
	ASL
	TAY
	REP.b #$20
	LDA.w DATA_00A121,y
	PHA
	SEP.b #$20
	LDA.b #$00
	XBA
CODE_008FA1:
	LDA.w $026B,x
	TAY
	LDA.b ($01,S),y
	BNE.b CODE_008FAE
	STZ.w $026B,x
	BRA.b CODE_008FA1

CODE_008FAE:
	STA.w $0267,x
	INY
	REP.b #$20
	TXA
	ASL
	TAX
	LDA.b ($01,S),y
	AND.w #$00FF
	STA.w $026F,x
	INY
	TYA
	SEP.b #$20
	PLX
	PLX
	TYA
	STA.w $026B,x
CODE_008FC9:
	DEC.w $0267,x
	REP.b #$20
	TXA
	ASL
	TAX
	LDA.w $0277,x
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w $027F,x
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w $026F,x
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	RTS

CODE_008FEB:
	JSR.w CODE_008FEF
	RTL

CODE_008FEF:
	SEP.b #$20
	REP.b #$10
	LDY.b $00,x
	STY.b $7F
	LDA.b $02,x
	STA.b $81
	LDY.w #$0000
CODE_008FFE:
	LDX.w #$0000
CODE_009001:
	LDA.b $7F
	CMP.w DATA_009039,y
	LDA.b $80
	SBC.w DATA_00903E,y
	LDA.b $81
	SBC.w DATA_009043,y
	BCC.b CODE_00902A
	LDA.b $7F
	SBC.w DATA_009039,y
	STA.b $7F
	LDA.b $80
	SBC.w DATA_00903E,y
	STA.b $80
	LDA.b $81
	SBC.w DATA_009043,y
	STA.b $81
	INX
	BRA.b CODE_009001

CODE_00902A:
	TXA
	STA.w $0079,y
	INY
	CPY.w #$0005
	BNE.b CODE_008FFE
	LDA.b $7F
	STA.b $7E
	RTS

DATA_009039:
	db $A0,$10,$E8,$64,$0A

DATA_00903E:
	db $86,$27,$03,$00,$00

DATA_009043:
	db $01,$00,$00,$00,$00

DATA_009048:
	dw $5555,$5554,$5550,$5540,$5500,$5400,$5000,$4000

CODE_009058:
	JSR.w CODE_00905C
	RTL

CODE_00905C:
	REP.b #$30
	LDA.w $0253
	LSR
	LSR
	LSR
	LSR
	STA.w $0289
	LDA.w $0261
	ASL
	TAX
	LDA.l DATA_00DAA6,x
	PHA
	LDY.w #$0000
	LDX.w $0253
	LDA.b ($01,S),y
	INY
	INY
	STA.w $0287
	PHA
CODE_009080:
	SEP.b #$20
	LDA.b ($03,S),y
	INY
	CLC
	ADC.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	STA.l SIMC_Global_OAMBuffer[$00].XDisp,x
	INX
	LDA.b ($03,S),y
	INY
	CLC
	ADC.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	STA.l SIMC_Global_OAMBuffer[$00].XDisp,x
	INX
	REP.b #$20
	LDA.b ($03,S),y
	INY
	INY
	STA.l SIMC_Global_OAMBuffer[$00].XDisp,x
	INX
	INX
	DEC.w $0287
	BNE.b CODE_009080
	STX.w $0253
	PLA
	TAX
	LSR
	LSR
	LSR
	TAY
	TXA
	AND.w #$0007
	ASL
	TAX
	LDA.w DATA_009048,x
	LDX.w $0289
	STA.w $0289
	CPY.w #$0000
	BEQ.b CODE_0090D4
	LDA.w #$0000
CODE_0090CB:
	STA.l SIMC_Global_UpperOAMBuffer[$00].Slot,x
	INX
	INX
	DEY
	BNE.b CODE_0090CB
CODE_0090D4:
	LDA.w $0289
	STA.l SIMC_Global_UpperOAMBuffer[$00].Slot,x
	PLA
	RTS

CODE_0090DD:					; Note: Decompression routine.
	PHP
	PHB
	SEP.b #$20
	REP.b #$10
	LDA.w $000B
	PHA
	PLB
	STZ.w $0011
	LDX.w $000E
CODE_0090EE:
	PHY
	LDY.w $0009
	LDA.w $0000,y
	INY
	BNE.b CODE_0090FB
	JSR.w CODE_00926D
CODE_0090FB:
	STY.w $0009
	PLY
	STA.w $000C
	CMP.b #$FF
	BNE.b CODE_009109
	PLB
	PLP
	RTS

CODE_009109:
	AND.b #$E0
	CMP.b #$E0
	BNE.b CODE_009131
	LDA.w $000C
	ASL
	ASL
	ASL
	AND.b #$E0
	PHA
	LDA.w $000C
	AND.b #$03
	XBA
	PHY
	LDY.w $0009
	LDA.w $0000,y
	INY
	BNE.b CODE_00912B
	JSR.w CODE_00926D
CODE_00912B:
	STY.w $0009
	PLY
	BRA.b CODE_00913A

CODE_009131:
	PHA
	LDA.b #$00
	XBA
	LDA.w $000C
	AND.b #$1F
CODE_00913A:
	TAY
	INY
	PLA
	CMP.b #$00
	BPL.b CODE_009144
	JMP.w CODE_0091E5

CODE_009144:
	CMP.b #$20
	BEQ.b CODE_00916B
	CMP.b #$40
	BEQ.b CODE_009187
	CMP.b #$60
	BEQ.b CODE_0091C8
CODE_009150:
	PHY
	LDY.w $0009
	LDA.w $0000,y
	INY
	BNE.b CODE_00915D
	JSR.w CODE_00926D
CODE_00915D:
	STY.w $0009
	PLY
	STA.l !RAM_SIMC_Global_GeneralPurposeBuffer,x
	INX
	DEY
	BNE.b CODE_009150
	BEQ.b CODE_0090EE		; Note: This will always branch.
	
CODE_00916B:
	PHY
	LDY.w $0009
	LDA.w $0000,y
	INY
	BNE.b CODE_009178
	JSR.w CODE_00926D
CODE_009178:
	STY.w $0009
	PLY
CODE_00917C:
	STA.l !RAM_SIMC_Global_GeneralPurposeBuffer,x
	INX
	DEY
	BNE.b CODE_00917C
	JMP.w CODE_0090EE

CODE_009187:
	PHY
	LDY.w $0009
	LDA.w $0000,y
	INY
	BNE.b CODE_009194
	JSR.w CODE_00926D
CODE_009194:
	STY.w $0009
	PLY
	STA.w $000C
	PHY
	LDY.w $0009
	LDA.w $0000,y
	INY
	BNE.b CODE_0091A8
	JSR.w CODE_00926D
CODE_0091A8:
	STY.w $0009
	PLY
	STA.w $000D
CODE_0091AF:
	LDA.w $000C
	STA.l !RAM_SIMC_Global_GeneralPurposeBuffer,x
	INX
	DEY
	BEQ.b CODE_0091C5
	LDA.w $000D
	STA.l !RAM_SIMC_Global_GeneralPurposeBuffer,x
	INX
	DEY
	BNE.b CODE_0091AF
CODE_0091C5:
	JMP.w CODE_0090EE

CODE_0091C8:
	PHY
	LDY.w $0009
	LDA.w $0000,y
	INY
	BNE.b CODE_0091D5
	JSR.w CODE_00926D
CODE_0091D5:
	STY.w $0009
	PLY
CODE_0091D9:
	STA.l !RAM_SIMC_Global_GeneralPurposeBuffer,x
	INC
	INX
	DEY
	BNE.b CODE_0091D9
	JMP.w CODE_0090EE

CODE_0091E5:
	CMP.b #$C0
	BCS.b CODE_009245
	AND.b #$20
	STA.w $0010
	PHY
	LDY.w $0009
	LDA.w $0000,y
	INY
	BNE.b CODE_0091FB
	JSR.w CODE_00926D
CODE_0091FB:
	STY.w $0009
	PLY
	STA.w $000C
	PHY
	LDY.w $0009
	LDA.w $0000,y
	INY
	BNE.b CODE_00920F
	JSR.w CODE_00926D
CODE_00920F:
	STY.w $0009
	PLY
	STA.w $000D
	REP.b #$20
	LDA.w $000C
	CLC
	ADC.w $000E
	STA.w $000C
CODE_009222:
	SEP.b #$20
CODE_009224:
	PHY
	PHX
	LDX.w $000C
	LDA.l !RAM_SIMC_Global_GeneralPurposeBuffer,x
	INX
	STX.w $000C
	PLX
	LDY.w $0010
	BEQ.b CODE_009239
	EOR.b #$FF
CODE_009239:
	STA.l !RAM_SIMC_Global_GeneralPurposeBuffer,x
	INX
	PLY
	DEY
	BNE.b CODE_009224
	JMP.w CODE_0090EE

CODE_009245:
	AND.b #$20
	STA.w $0010
	PHY
	LDY.w $0009
	LDA.w $0000,y
	INY
	BNE.b CODE_009257
	JSR.w CODE_00926D
CODE_009257:
	STY.w $0009
	PLY
	STA.w $000C
	STZ.w $000D
	REP.b #$20
	TXA
	SEC
	SBC.w $000C
	STA.w $000C
	BRA.b CODE_009222

CODE_00926D:
	LDY.w #$8000
	PHA
	PHB
	PLA
	INC
	PHA
	PLB
	PLA
	RTS

ADDR_009278:
	JSR.w CODE_00927C
	RTL

CODE_00927C:
	SEP.b #$20
	REP.b #$10
CODE_009280:
	LDA.w !REGISTER_HVBlankFlagsAndJoypadStatus
	AND.b #$01
	BNE.b CODE_009280
	REP.b #$20
	LDY.w #$0004
	LDX.w #$0000
CODE_00928F:
	LDA.w !REGISTER_Joypad1Lo,x
	JSR.w CODE_00929B
	INX
	INX
	DEY
	BNE.b CODE_00928F
	RTS

CODE_00929B:
	REP.b #$20
	PHY
	STA.b $BF
	EOR.w $011B,x
	AND.b $BF
	STA.b $C9,x
	STA.w $0123,x
	LDA.b $BF
	PHA
	LDY.w $0133
	LDA.w $011B,x
	CMP.b $BF
	BNE.b CODE_0092C2
	DEC.w $012B,x
	BNE.b CODE_0092C6
	STA.w $0123,x
	LDY.w $0135
CODE_0092C2:
	TYA
	STA.w $012B,x
CODE_0092C6:
	PLA
	STA.w $011B,x
	PLY
	RTS

CODE_0092CC:
	REP.b #$20
	LDA.b $D7
	BNE.b CODE_0092F7
	LDA.w $011B
	AND.w #$FFF0
	BNE.b CODE_0092F7
	LDA.w $0406
	CMP.w #$FFFF
	BEQ.b CODE_0092F6
	INC
	STA.w $0406
	CMP.w #$00B4
	BCC.b CODE_0092F6
	LDA.w $0408
	BNE.b CODE_0092F6
	LDA.w #$8080
	STA.w $040A
CODE_0092F6:
	RTS

CODE_0092F7:
	LDA.w #$0000
	STA.w $0406
	LDA.w $0408
	BEQ.b CODE_009309
	LDA.w #$0001
	STA.w $040A
	RTS

CODE_009309:
	STA.w $040A
	RTS

CODE_00930D:
	SEP.b #$20
	STZ.b $B9
CODE_009311:
	INC.b $C7
	LDA.b $B9
	BEQ.b CODE_009311
	RTS

CODE_009318:
	SEP.b #$30
	LDA.b $D7
	BPL.b CODE_009321
	JMP.w CODE_0093DD

CODE_009321:
	CMP.b #$01
	BEQ.b CODE_009374
	CMP.b #$02
	BNE.b CODE_00932C
	JMP.w CODE_0093AA

CODE_00932C:
	REP.b #$20
	LDA.w $0C0F
	BEQ.b CODE_009341
	DEC.w $0C0F
	SEP.b #$20
	BNE.b CODE_00933E
	LDA.b #$80
	STA.b $06
CODE_00933E:
	JMP.w CODE_009416

CODE_009341:
	SEP.b #$20
	LDA.w $0137
	STA.w !REGISTER_BG2VertScrollOffset
	STZ.w !REGISTER_BG2VertScrollOffset
	CLC
	ADC.b #$08
	STA.w !REGISTER_BG1VertScrollOffset
	STZ.w !REGISTER_BG1VertScrollOffset
	LDA.w $0139
	STA.w !REGISTER_BG2HorizScrollOffset
	STZ.w !REGISTER_BG2HorizScrollOffset
	CLC
	ADC.b #$08
	STA.w !REGISTER_BG1HorizScrollOffset
	STZ.w !REGISTER_BG1HorizScrollOffset
	STZ.w !REGISTER_BG3VertScrollOffset
	STZ.w !REGISTER_BG3VertScrollOffset
	STZ.w !REGISTER_BG3HorizScrollOffset
	STZ.w !REGISTER_BG3HorizScrollOffset
	RTS

CODE_009374:
	REP.b #$20
	LDA.w $0C0F
	BEQ.b CODE_009389
	DEC.w $0C0F
	SEP.b #$20
	BNE.b CODE_009386
	LDA.b #$80
	STA.b $06
CODE_009386:
	JMP.w CODE_00945A

CODE_009389:
	SEP.b #$20
	LDA.w $0137
	STA.w !REGISTER_BG2VertScrollOffset
	STZ.w !REGISTER_BG2VertScrollOffset
	STZ.w !REGISTER_BG3VertScrollOffset
	STZ.w !REGISTER_BG3VertScrollOffset
	CLC
	ADC.b #$08
	STA.w !REGISTER_BG1VertScrollOffset
	STZ.w !REGISTER_BG1VertScrollOffset
	STZ.w !REGISTER_BG3HorizScrollOffset
	STZ.w !REGISTER_BG3HorizScrollOffset
	RTS

CODE_0093AA:
	SEP.b #$20
	LDA.w $0137
	STA.w !REGISTER_BG2VertScrollOffset
	STZ.w !REGISTER_BG2VertScrollOffset
	STA.w !REGISTER_BG3VertScrollOffset
	STZ.w !REGISTER_BG3VertScrollOffset
	CLC
	ADC.b #$08
	STA.w !REGISTER_BG1VertScrollOffset
	STZ.w !REGISTER_BG1VertScrollOffset
	LDA.w $0139
	STA.w !REGISTER_BG2HorizScrollOffset
	STZ.w !REGISTER_BG2HorizScrollOffset
	STA.w !REGISTER_BG3HorizScrollOffset
	STZ.w !REGISTER_BG3HorizScrollOffset
	CLC
	ADC.b #$08
	STA.w !REGISTER_BG1HorizScrollOffset
	STZ.w !REGISTER_BG1HorizScrollOffset
	RTS

CODE_0093DD:
	LDA.w $0137
	STA.w !REGISTER_BG1VertScrollOffset
	STZ.w !REGISTER_BG1VertScrollOffset
	STA.w !REGISTER_BG2VertScrollOffset
	STZ.w !REGISTER_BG2VertScrollOffset
	STZ.w !REGISTER_BG3VertScrollOffset
	STZ.w !REGISTER_BG3VertScrollOffset
	LDA.w $0139
	STA.w !REGISTER_BG1HorizScrollOffset
	STZ.w !REGISTER_BG1HorizScrollOffset
	STA.w !REGISTER_BG2HorizScrollOffset
	STZ.w !REGISTER_BG2HorizScrollOffset
	LDA.b $73
	STA.w !REGISTER_BG3HorizScrollOffset
	LDA.b $74
	STA.w !REGISTER_BG3HorizScrollOffset
	LDA.b $75
	STA.w !REGISTER_BG3VertScrollOffset
	LDA.b $76
	STA.w !REGISTER_BG3VertScrollOffset
	RTS

CODE_009416:
	LDA.w $0137
	STA.w !REGISTER_BG2VertScrollOffset
	STZ.w !REGISTER_BG2VertScrollOffset
	STZ.w !REGISTER_BG3VertScrollOffset
	STZ.w !REGISTER_BG3VertScrollOffset
	CLC
	ADC.b #$08
	STA.w !REGISTER_BG1VertScrollOffset
	STZ.w !REGISTER_BG1VertScrollOffset
	LDA.b $D1
	AND.b #$08
	BEQ.b CODE_00943A
	LDA.b #$02
	STA.b $91
	BRA.b CODE_00943E

CODE_00943A:
	LDA.b #$FE
	STA.b $91
CODE_00943E:
	LDA.w $0139
	CLC
	ADC.b $91
	STA.w !REGISTER_BG2HorizScrollOffset
	STZ.w !REGISTER_BG2HorizScrollOffset
	STZ.w !REGISTER_BG3HorizScrollOffset
	STZ.w !REGISTER_BG3HorizScrollOffset
	CLC
	ADC.b #$08
	STA.w !REGISTER_BG1HorizScrollOffset
	STZ.w !REGISTER_BG1HorizScrollOffset
	RTS

CODE_00945A:
	LDA.w $0137
	STA.w !REGISTER_BG2VertScrollOffset
	STZ.w !REGISTER_BG2VertScrollOffset
	STZ.w !REGISTER_BG3VertScrollOffset
	STZ.w !REGISTER_BG3VertScrollOffset
	CLC
	ADC.b #$08
	STA.w !REGISTER_BG1VertScrollOffset
	STZ.w !REGISTER_BG1VertScrollOffset
	STZ.w !REGISTER_BG3HorizScrollOffset
	STZ.w !REGISTER_BG3HorizScrollOffset
	RTS

CODE_009479:
	REP.b #$30
	LDA.w $019D
	STA.w $01C1
	LSR
	BCC.b CODE_00948A
	JSL.l CODE_01B02C
	BRA.b CODE_0094A3

CODE_00948A:
	LSR
	BCC.b CODE_009493
	JSL.l CODE_01B162
	BRA.b CODE_0094A3

CODE_009493:
	LSR
	BCC.b CODE_00949C
	JSL.l CODE_01B1F2
	BRA.b CODE_0094A3

CODE_00949C:
	LSR
	BCC.b CODE_0094BB
	JSL.l CODE_01B2F5
CODE_0094A3:
	JSL.l CODE_01AFBA
	JSL.l CODE_01AFDC
	JSL.l CODE_01AFDC
	REP.b #$20
	STZ.w $01C1
	LDA.b $BB
	ORA.w #$0004
	STA.b $BB
CODE_0094BB:
	RTS

CODE_0094BC:
	JSR.w CODE_0094C0
	RTL

CODE_0094C0:					; Note: Routine that clears the map data
	SEP.b #$20
	REP.b #$10
	LDX.w #$0000
	LDY.w #$5DC0
	LDA.b #$00
CODE_0094CC:
	STA.l !RAM_SIMC_City_MapDataBuffer,x
	INX
	DEY
	BNE.b CODE_0094CC
CODE_0094D4:
	RTS

CODE_0094D5:
	JSR.w CODE_0094D9
	RTL

CODE_0094D9:
	SEP.b #$20
	REP.b #$10
	LDA.w $0B4B
	BEQ.b CODE_0094D4
	LDA.b $3A
	BEQ.b CODE_0094FB
	LDA.w $0B4D
	CMP.b #$02
	BEQ.b CODE_0094F9
	LDA.b #$01
	STA.w $0B4D
	LDA.b #$FF
	STA.w $0B4F
	BRA.b CODE_0094FB

CODE_0094F9:
	STZ.b $3A
CODE_0094FB:
	PHK
	PLB
	LDY.w $0B4D
	LDA.w DATA_00960E,y
	STA.b $79
	LDA.w DATA_00960E+$01,y
	STA.b $7C
	LDA.w DATA_009613,y
	STA.b $7A
	LDA.w DATA_009613+$01,y
	STA.b $7D
	LDA.b #DATA_058000>>16
	STA.b $7B
	STA.b $7E
	REP.b #$20
	LDY.w #$0020
CODE_00951F:
	LDX.w $0B4F
	CPX.w #$00FF
	BNE.b CODE_00952C
	LDA.b [$7C],y
CODE_009529:
	JMP.w CODE_0095C1

CODE_00952C:
	LDA.b [$79],y
	CMP.b [$7C],y
	BEQ.b CODE_009529
	STA.b $7F
	LSR
	LSR
	LSR
	LSR
	LSR
	STA.b $82
	LSR
	LSR
	LSR
	LSR
	LSR
	STA.b $85
	LDA.b [$7C],y
	STA.b $80
	LSR
	LSR
	LSR
	LSR
	LSR
	STA.b $83
	LSR
	LSR
	LSR
	LSR
	LSR
	STA.b $86
	SEP.b #$30
	LDX.b #$00
CODE_009558:
	PHX
	LDA.w $0B4F
	XBA
	LDA.b $7F,x
	AND.b #$1F
	STA.b $7F,x
	LDA.b $80,x
	AND.b #$1F
	STA.b $80,x
	SEC
	SBC.b $7F,x
	BCS.b CODE_009576
	EOR.b #$FF
	INC
	XBA
	EOR.b #$FF
	XBA
	INX
CODE_009576:						; Note: Special building related?
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	XBA
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	XBA
	CLC
	ADC.b $7F,x
	AND.b #$1F
	PLX
	STA.b $7F,x
	INX
	INX
	INX
	CPX.b #$09
	BNE.b CODE_009558
	STZ.b $80
	STZ.b $83
	STZ.b $86
	REP.b #$30
	LDA.b $85
	ASL
	ASL
	ASL
	ASL
	ASL
	ORA.b $82
	ASL
	ASL
	ASL
	ASL
	ASL
	ORA.b $7F
CODE_0095C1:
	TYX
	STA.l SIMC_Global_PaletteMirror[$00].LowByte,x
	INY
	INY
	CPY.w #$00C0
	BNE.b CODE_0095D3
	TYA
	CLC
	ADC.w #$0020
	TAY
CODE_0095D3:
	CPY.w #$0100
	BEQ.b CODE_0095DB
	JMP.w CODE_00951F

CODE_0095DB:
	LDA.w $0B4F
	CLC
	ADC.w #$0005
	CMP.w #$0100
	BCC.b CODE_0095EA
	STZ.w $0B4B
CODE_0095EA:
	STA.w $0B4F
	SEP.b #$20
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	LDA.b $BB
	ORA.b #$02
	STA.b $BB
	JSR.w CODE_008DA6
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	RTS

DATA_00960E:
	db DATA_058000,DATA_058100,DATA_058200,DATA_058300,DATA_058000

DATA_009613:
	db DATA_058000>>8,DATA_058100>>8,DATA_058200>>8,DATA_058300>>8,DATA_058000>>8

CODE_009618:
	JSR.w CODE_00961C
	RTL

CODE_00961C:
	REP.b #$30
	REP.b #$30
	LDX.w #DATA_058000
	LDY.w #!RAM_SIMC_Global_PaletteMirror
	LDA.w #$00FE
	MVN SIMC_Global_PaletteMirror[$00].LowByte>>16,DATA_058000>>16
	LDX.w #$0000
	PHX
	PLB
	PLB
	PEA.w ((DATA_0096AE&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	LDX.w !RAM_SIMC_City_CurrentMonthLo
	DEX
	LDA.l DATA_0096AE,x
	AND.w #$00FF
	STA.w $0B4D
	LDA.w #$0001
	STA.w $0B4B
	LDA.w #$00FF
	STA.w $0B4F
	JSR.w CODE_0094D9
	REP.b #$30
	STZ.w $0B4B
	STZ.b $BB
	REP.b #$30
	LDX.w #DATA_058B00
	LDY.w #SIMC_Global_PaletteMirror[$80].LowByte
	LDA.w #$00FE
	MVN SIMC_Global_PaletteMirror[$80].LowByte>>16,DATA_058B00>>16
	LDX.w #$0000
	PHX
	PLB
	PLB
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	SEP.b #$30
	LDA.b #$01
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$00
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToCGRAMPort
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_PaletteMirror
	STA.w DMA[$00].SourceLo,x
	LDA.b #!RAM_SIMC_Global_PaletteMirror>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #!RAM_SIMC_Global_PaletteMirror>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$02
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$01
	BEQ.b CODE_0096AA
CODE_0096A6:
	ASL
	DEX
	BNE.b CODE_0096A6
CODE_0096AA:
	STA.w !REGISTER_DMAEnable
	RTS

DATA_0096AE:
	db $03,$03,$00,$00,$00,$01,$01,$01,$02,$02,$02,$03

CODE_0096BA:
	JSR.w CODE_0096BE
	RTL

CODE_0096BE:
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_07E584
	STX.b $09
	LDA.b #DATA_07E584>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	JSL.l CODE_008206
	REP.b #$20
	LDA.w #$0000
	STA.w !REGISTER_VRAMAddressLo
	SEP.b #$30
	LDA.b #$01
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer
	STA.w DMA[$00].SourceLo,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$80
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$01
	BEQ.b CODE_009719
CODE_009715:
	ASL
	DEX
	BNE.b CODE_009715
CODE_009719:
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	REP.b #$20
	LDA.w #$6000
	STA.w !REGISTER_VRAMAddressLo
	SEP.b #$30
	LDA.b #$01
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #DATA_06C000
	STA.w DMA[$00].SourceLo,x
	LDA.b #DATA_06C000>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #DATA_06C000>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$40
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$01
	BEQ.b CODE_00975E
CODE_00975A:
	ASL
	DEX
	BNE.b CODE_00975A
CODE_00975E:
	STA.w !REGISTER_DMAEnable
	REP.b #$20
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_09C0FB
	STX.b $09
	LDA.b #DATA_09C0FB>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0BC7BD
	STX.b $09
	LDA.b #DATA_0BC7BD>>16
	STA.b $0B
	LDX.w #$2800
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	JSL.l CODE_008206
	REP.b #$20
	LDA.w #$4000
	STA.w !REGISTER_VRAMAddressLo
	SEP.b #$30
	LDA.b #$01
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer
	STA.w DMA[$00].SourceLo,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$30
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$01
	BEQ.b CODE_0097D7
CODE_0097D3:
	ASL
	DEX
	BNE.b CODE_0097D3
CODE_0097D7:
	STA.w !REGISTER_DMAEnable
	REP.b #$30
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$2800
	LDY.w #!RAM_SIMC_Global_Layer3TilemapBuffer
	LDA.w #$07FF
	MVN !RAM_SIMC_Global_Layer3TilemapBuffer>>16,(!RAM_SIMC_Global_GeneralPurposeBuffer+$2800)>>16
	LDX.w #$0000
	PHX
	PLB
	PLB
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	RTS

CODE_0097F4:
	JSR.w CODE_0097F8
	RTL

CODE_0097F8:
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0BC7BD
	STX.b $09
	LDA.b #DATA_0BC7BD>>16
	STA.b $0B
	LDX.w #$2800
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	REP.b #$30
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$2800
	LDY.w #!RAM_SIMC_Global_Layer3TilemapBuffer
	LDA.w #$07FF
	MVN !RAM_SIMC_Global_Layer3TilemapBuffer>>16,(!RAM_SIMC_Global_GeneralPurposeBuffer+$2800)>>16
	LDX.w #$0000
	PHX
	PLB
	PLB
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	RTS

CODE_00982B:
	JSR.w CODE_00982F
	RTL

CODE_00982F:
	REP.b #$30
	LDY.w $0CA5
	LDA.w $0B59
	BEQ.b CODE_00983F
	STZ.w $0B59
	LDY.w #$0006
CODE_00983F:
	LDA.w DATA_00985B,y
	STA.b $09
	LDA.w DATA_009862,y
	STA.b $0A
	LDA.w DATA_009869,y
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	RTS

DATA_00985B:
	db DATA_0BC91F,DATA_0BCE02,DATA_0BD2F6,DATA_0BD84D,DATA_0BDDD2,DATA_0BE417,DATA_0BEAA8

DATA_009862:
	db DATA_0BC91F>>8,DATA_0BCE02>>8,DATA_0BD2F6>>8,DATA_0BD84D>>8,DATA_0BDDD2>>8,DATA_0BE417>>8,DATA_0BEAA8>>8

DATA_009869:
	db DATA_0BC91F>>16,DATA_0BCE02>>16,DATA_0BD2F6>>16,DATA_0BD84D>>16,DATA_0BDDD2>>16,DATA_0BE417>>16,DATA_0BEAA8>>16

CODE_009870:
	PHP
	SEP.b #$30
	LDA.b $03
	BEQ.b CODE_00987B
	STA.b $08
	BRA.b CODE_009882

CODE_00987B:
	LDY.w !REGISTER_APUPort0
	CPY.b $07
	BNE.b CODE_009889
CODE_009882:
	STA.w !REGISTER_APUPort0
	STA.b $07
	STZ.b $03
CODE_009889:
	LDA.b $04
	STA.w !REGISTER_APUPort1
	STZ.b $04
	LDA.b $05
	STA.w !REGISTER_APUPort2
	STZ.b $05
	LDA.b $06
	STA.w !REGISTER_APUPort3
	STZ.b $06
	PLP
	RTS

CODE_0098A0:
	SEP.b #$20
	REP.b #$10
	PLX
	PLA
	PHA
	PHB
	PHA
	PLB
	INX
	REP.b #$20
	LDA.w $0000,x
	INX
	PLB
	PHX
	SEP.b #$30
	TAX
	XBA
	STA.w $0003,x
	RTL

DATA_0098BB:
	dw DATA_0098F7,DATA_0098F7,DATA_0098FB,DATA_0098F9,DATA_0098FD,DATA_009901,DATA_009913,DATA_009925
	dw DATA_009937,DATA_009949,DATA_00995B,DATA_00999B,DATA_0099BB,DATA_009A03,DATA_009A23,DATA_009A43
	dw DATA_009A55,DATA_009A67,DATA_009A79,DATA_009A8B,DATA_009A9D,DATA_009AAF,DATA_009AC1,DATA_009AD3
	dw DATA_009AE5,DATA_009AF7,DATA_009B09,DATA_009B1B,DATA_009B2D,DATA_009B3F

DATA_0098F7:
	dw $0032

DATA_0098F9:
	dw $0062

DATA_0098FB:
	dw $0072

DATA_0098FD:
	dw $0026,$0027

DATA_009901:
	dw $0080,$0081,$0082,$0083,$0084,$0085,$0086,$0087
	dw $0088

DATA_009913:
	dw $0137,$0138,$0139,$013A,$013B,$013C,$013D,$013E
	dw $013F

DATA_009925:
	dw $01F4,$01F5,$01F6,$01F7,$01F8,$01F9,$01FA,$01FB
	dw $01FC

DATA_009937:
	dw $0245,$0246,$0247,$0248,$0249,$024A,$024B,$024C
	dw $024D

DATA_009949:
	dw $024E,$024F,$0250,$0251,$0252,$0253,$0254,$0255
	dw $0256

DATA_00995B:
	dw $0257,$0258,$0259,$025B,$025C,$025D,$025F,$0260
	dw $0261,$025A,$025E,$0262,$0263,$0264,$0265,$0266
	dw $0366,$0367,$0368,$036A,$036B,$036C,$036E,$036F
	dw $0370,$0369,$036D,$0371,$0372,$0373,$0374,$0375

DATA_00999B:
	dw $0267,$0268,$0269,$026B,$026C,$026D,$026F,$0270
	dw $0271,$026A,$026E,$0272,$0273,$0274,$0275,$0276

DATA_0099BB:
	dw $0297,$0298,$0299,$029D,$029E,$029F,$02A3,$02A4
	dw $02A5,$029A,$02A0,$02A6,$02A9,$02AA,$02AB,$02AC
	dw $029B,$02A1,$02A7,$02AD,$02AF,$02B0,$02B1,$02B2
	dw $02B3,$029C,$02A2,$02A8,$02AE,$02B4,$02B5,$02B6
	dw $02B7,$02B8,$02B9,$02BA

DATA_009A03:
	dw $0277,$0278,$0279,$027B,$027C,$027D,$027F,$0280
	dw $0281,$027A,$027E,$0282,$0283,$0284,$0285,$0286

DATA_009A23:
	dw $0287,$0288,$0289,$028B,$028C,$028D,$028F,$0290
	dw $0291,$028A,$028E,$0292,$0293,$0294,$0295,$0296

DATA_009A43:
	dw $02BB,$02BC,$02BD,$02BE,$02BF,$02C0,$02C1,$02C2
	dw $02C3

DATA_009A55:
	dw $02DF,$02E0,$02E1,$02E2,$02E3,$02E4,$02E5,$02E6
	dw $02E7

DATA_009A67:
	dw $02E8,$02E9,$02EA,$02EB,$02EC,$02ED,$02EE,$02EF
	dw $02F0

DATA_009A79:
	dw $02F1,$02F2,$02F3,$02F4,$02F5,$02F6,$02F7,$02F8
	dw $02F9

DATA_009A8B:
	dw $02FA,$02FB,$02FC,$02FD,$02FE,$02FF,$0300,$0301
	dw $0302

DATA_009A9D:
	dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dw $0000

DATA_009AAF:
	dw $0303,$0304,$0305,$0306,$0307,$0308,$0309,$030A
	dw $030B

DATA_009AC1:
	dw $030C,$030D,$030E,$030F,$0310,$0311,$0312,$0313
	dw $0314

DATA_009AD3:
	dw $0315,$0316,$0317,$0318,$0319,$031A,$031B,$031C
	dw $031D

DATA_009AE5:
	dw $031E,$031F,$0320,$0321,$0322,$0323,$0324,$0325
	dw $0326

DATA_009AF7:
	dw $0327,$0328,$0329,$032A,$032B,$032C,$032D,$032E
	dw $032F

DATA_009B09:
	dw $0330,$0331,$0332,$0333,$0334,$0335,$0336,$0337
	dw $0338

DATA_009B1B:
	dw $0339,$033A,$033B,$033C,$033D,$033E,$033F,$0340
	dw $0341

DATA_009B2D:
	dw $0342,$0343,$0344,$0345,$0346,$0347,$0348,$0349
	dw $034A

DATA_009B3F:
	dw $034B,$034C,$034D,$034E,$034F,$0350,$0351,$0352
	dw $0353

DATA_009B51:
	dw DATA_009B61,DATA_009B69,DATA_009B81,DATA_009BA1

DATA_009B59:
	dw DATA_009B65,DATA_009B75,DATA_009B91,DATA_009BB9

DATA_009B61:
	db $00,$01,$FF,$00

DATA_009B65:
	db $01,$00,$00,$FF

DATA_009B69:
	db $02,$01,$00,$03,$FF,$03,$FF,$03,$FF,$02,$01,$00

DATA_009B75:
	db $03,$03,$03,$02,$02,$01,$01,$00,$00,$FF,$FF,$FF

DATA_009B81:
	db $03,$02,$01,$00,$04,$FF,$04,$FF,$04,$FF,$04,$FF,$03,$02,$01,$00

DATA_009B91:
	db $04,$04,$04,$04,$03,$03,$02,$02,$01,$01,$00,$00,$FF,$FF,$FF,$FF

DATA_009BA1:
	db $05,$04,$03,$02,$01,$00,$06,$FF,$06,$FF,$06,$FF,$06,$FF,$06,$FF
	db $06,$FF,$05,$04,$03,$02,$01,$00

DATA_009BB9:
	db $06,$06,$06,$06,$06,$06,$05,$05,$04,$04,$03,$03,$02,$02,$01,$01
	db $00,$00,$FF,$FF,$FF,$FF,$FF,$FF

DATA_009BD1:
	db $00,$FF,$FF,$00,$01,$00,$00,$01

DATA_009BD9:
	db $FF,$FE,$00,$FE,$01,$FE,$FE,$FF,$02,$FF,$FE,$00,$02,$00,$FE,$01
	db $02,$01,$FF,$02,$00,$02,$01,$02,$FE,$FD,$FF,$FD,$00,$FD,$01,$FD
	db $02,$FD,$FD,$FE,$03,$FE,$FD,$FF,$03,$FF,$FD,$00,$03,$00,$FD,$01
	db $03,$01,$FD,$02,$03,$02,$FE,$03,$FF,$03,$00,$03,$01,$03,$02,$03

DATA_009C19:
	db $FF,$FE,$00,$FE,$01,$FE,$02,$FE,$FE,$FF,$03,$FF,$FE,$00,$03,$00
	db $FE,$01,$03,$01,$FE,$02,$03,$02,$FF,$03,$00,$03,$01,$03,$02,$03

DATA_009C39:
	db $FE,$FE,$FF,$FE,$00,$FE,$01,$FE,$FD,$FF,$02,$FF,$FD,$00,$02,$00
	db $FD,$01,$02,$01,$FD,$02,$02,$02,$FE,$03,$FF,$03,$00,$03,$01,$03

DATA_009C59:
	db $FF,$FD,$00,$FD,$01,$FD,$02,$FD,$FE,$FE,$03,$FE,$FE,$FF,$03,$FF
	db $FE,$00,$03,$00,$FE,$01,$03,$01,$FF,$02,$00,$02,$01,$02,$02,$02

DATA_009C79:
	db $FE,$FD,$FF,$FD,$00,$FD,$01,$FD,$FD,$FE,$02,$FE,$FD,$FF,$02,$FF
	db $FD,$00,$02,$00,$FD,$01,$02,$01,$FE,$02,$FF,$02,$00,$02,$01,$02

DATA_009C99:
	db $FE,$FD,$FF,$FD,$00,$FD,$01,$FD,$02,$FD,$03,$FD,$FD,$FE,$04,$FE
	db $FD,$FF,$04,$FF,$FD,$00,$04,$00,$FD,$01,$04,$01,$FD,$02,$04,$02
	db $FD,$03,$04,$03,$FE,$04,$FF,$04,$00,$04,$01,$04,$02,$04,$03,$04

DATA_009CC9:
	db $FD,$FD,$FE,$FD,$FF,$FD,$00,$FD,$01,$FD,$02,$FD,$FC,$FE,$03,$FE
	db $FC,$FF,$03,$FF,$FC,$00,$03,$00,$FC,$01,$03,$01,$FC,$02,$03,$02
	db $FC,$03,$03,$03,$FD,$04,$FE,$04,$FF,$04,$00,$04,$01,$04,$02,$04

DATA_009CF9:
	db $FE,$FC,$FF,$FC,$00,$FC,$01,$FC,$02,$FC,$03,$FC,$FD,$FD,$04,$FD
	db $FD,$FE,$04,$FE,$FD,$FF,$04,$FF,$FD,$00,$04,$00,$FD,$01,$04,$01
	db $FD,$02,$04,$02,$FE,$03,$FF,$03,$00,$03,$01,$03,$02,$03,$03,$03

DATA_009D29:
	db $FD,$FC,$FE,$FC,$FF,$FC,$00,$FC,$01,$FC,$02,$FC,$FC,$FD,$03,$FD
	db $FC,$FE,$03,$FE,$FC,$FF,$03,$FF,$FC,$00,$03,$00,$FC,$01,$03,$01
	db $FC,$02,$03,$02,$FD,$03,$FE,$03,$FF,$03,$00,$03,$01,$03,$02,$03

DATA_009D59:
	db $00,$00,$FF,$FF,$00,$FF,$01,$FF,$FF,$00,$01,$00,$FF,$01,$00,$01
	db $01,$01,$FE,$FE,$FF,$FE,$00,$FE,$01,$FE,$02,$FE,$FE,$FF,$02,$FF
	db $FE,$00,$02,$00,$FE,$01,$02,$01,$FE,$02,$FF,$02,$00,$02,$01,$02
	db $02,$02

DATA_009D8B:
	db $02,$FF,$02,$00,$02,$01,$02,$02

DATA_009D93:
	db $00,$00,$FF,$FF,$00,$FF,$01,$FF,$FF,$00,$01,$00,$FF,$01,$00,$01
	db $01,$01,$FF,$02,$00,$02,$01,$02,$FE,$02

DATA_009DAD:
	db $FE,$FF,$FE,$00,$FE,$01,$FE,$FE

DATA_009DB5:
	db $00,$00,$FF,$FF,$00,$FF,$01,$FF,$FF,$00,$01,$00,$FF,$01,$00,$01
	db $01,$01,$FF,$FE,$00,$FE,$01,$FE,$02,$FE,$02,$FF,$02,$00,$02,$01

DATA_009DD5:
	db $FD,$FE,$FD,$FF,$FD,$00,$FD,$01,$FD,$02,$FD,$03

DATA_009DE1:
	db $FE,$FE,$FE,$FF,$FE,$00,$FE,$01,$FE,$02,$FE,$03,$FF,$FE,$FF,$FF
	db $FF,$00,$FF,$01,$FF,$02,$FF,$03,$00,$FE,$00,$FF,$00,$00,$00,$01
	db $00,$02,$00,$03,$01,$FE,$01,$FF,$01,$00,$01,$01,$01,$02,$01,$03
	db $02,$FE,$02,$FF,$02,$00,$02,$01,$02,$02,$02,$03,$03,$FE,$03,$FF
	db $03,$00,$03,$01,$03,$02,$03,$03

DATA_009E29:
	db $FD,$FD,$FD,$FE,$FD,$FF,$FD,$00,$FD,$01,$FD,$02

DATA_009E35:
	db $FE,$FD,$FE,$FE,$FE,$FF,$FE,$00,$FE,$01,$FE,$02,$FF,$FD,$FF,$FE
	db $FF,$FF,$FF,$00,$FF,$01,$FF,$02,$00,$FD,$00,$FE,$00,$FF,$00,$00
	db $00,$01,$00,$02,$01,$FD,$01,$FE,$01,$FF,$01,$00,$01,$01,$01,$02
	db $02,$FD,$02,$FE,$02,$FF,$02,$00,$02,$01,$02,$02,$03,$FD,$03,$FE
	db $03,$FF,$03,$00,$03,$01,$03,$02

DATA_009E7D:
	dw DATA_009E83,DATA_009E8D,DATA_009E9F

DATA_009E83:
	dw $0062,$0063,$0072,$0073,$FFFF

DATA_009E8D:
	dw $0032,$0033,$0042,$0043,$0052,$0053,$0062,$0063
	dw $FFFF

DATA_009E9F:
	dw $0032,$0033,$0042,$0043,$0052,$0053,$0072,$0073
	dw $FFFF

DATA_009EB1:
	dw DATA_009EB7,DATA_009EBF,DATA_009ECF

DATA_009EB7:
	dw $003E,$003D,$007D,$007E

DATA_009EBF:
	dw $007E,$007D,$007E,$007D,$007E,$007D,$006E,$006D

DATA_009ECF:
	dw $003D,$003E,$004D,$004E,$005D,$005E,$006D,$006E

UNK_009EDF:
	dw UNK_009EEF,UNK_009EF7,UNK_009EFF,UNK_009EEF,UNK_009F0B,UNK_009F15,UNK_009EEF,UNK_009EEF

UNK_009EEF:							; Note: Bank 04 pointers, but they don't seem to be used.
	dw $048000,$048060,$0480C0,$048120

UNK_009EF7:
	dw $048180,$048600,$048660,$0486C0

UNK_009EFF:
	dw $048720,$048780,$048C00,$048C60,$048CC0,$048D20

UNK_009F0B:
	dw $048D80,$049200,$049260,$0492C0,$04A180

UNK_009F15:
	dw $049320,$049380,$049800,$049860

DATA_009F1D:
	dw DATA_009F3A,DATA_009F3A,DATA_009F9B,DATA_00A01E,DATA_009F3A,DATA_009F2D,DATA_009F2D,DATA_009F2D

DATA_009F2D:
	db $80,$80,$55,$55,$55,$55,$55,$55,$55,$55,$55,$55,$FF

DATA_009F3A:
	db $05,$00,$60,$30,$05,$10,$62,$30,$05,$20,$64,$30,$05,$30,$66,$30
	db $05,$40,$68,$30,$05,$50,$6A,$30,$18,$00,$6C,$32,$18,$10,$6E,$32
	db $28,$00,$8C,$32,$28,$10,$8E,$32,$18,$18,$A0,$32,$18,$28,$A2,$32
	db $28,$18,$C0,$32,$28,$28,$C2,$32,$18,$30,$A4,$32,$18,$40,$A6,$32
	db $28,$30,$C4,$32,$28,$40,$C6,$32,$18,$48,$A8,$32,$18,$58,$AA,$32
	db $28,$48,$C8,$32,$28,$58,$CA,$32,$80,$80,$A5,$AA,$AA,$AA,$AA,$AA
	db $FF

DATA_009F9B:
	db $05,$00,$60,$30,$05,$10,$62,$30,$05,$20,$64,$30,$05,$30,$66,$30
	db $05,$40,$68,$30,$05,$50,$6A,$30,$18,$0C,$6C,$32,$18,$1C,$6E,$32
	db $28,$0C,$8C,$32,$28,$1C,$8E,$32,$18,$24,$A0,$32,$18,$34,$A2,$32
	db $28,$24,$C0,$32,$28,$34,$C2,$32,$18,$3C,$A4,$32,$18,$4C,$A6,$32
	db $28,$3C,$C4,$32,$28,$4C,$C6,$32,$30,$0C,$A8,$32,$30,$1C,$AA,$32
	db $40,$0C,$C8,$32,$40,$1C,$CA,$32,$30,$24,$AC,$32,$30,$34,$AE,$32
	db $40,$24,$CC,$32,$40,$34,$CE,$32,$30,$3C,$E0,$32,$30,$4C,$E2,$32
	db $40,$3C,$E4,$32,$40,$4C,$E6,$32,$80,$80,$A5,$AA,$AA,$AA,$AA,$AA
	db $AA,$AA,$FF

DATA_00A01E:
	db $05,$00,$60,$30,$05,$10,$62,$30,$05,$20,$64,$30,$05,$30,$66,$30
	db $05,$40,$68,$30,$05,$50,$6A,$30,$18,$0C,$6C,$32,$18,$1C,$6E,$32
	db $28,$0C,$8C,$32,$28,$1C,$8E,$32,$18,$24,$A0,$32,$18,$34,$A2,$32
	db $28,$24,$C0,$32,$28,$34,$C2,$32,$18,$3C,$A4,$32,$18,$4C,$A6,$32
	db $28,$3C,$C4,$32,$28,$4C,$C6,$32,$30,$0C,$A8,$32,$30,$1C,$AA,$32
	db $40,$0C,$C8,$32,$40,$1C,$CA,$32,$48,$18,$AC,$32,$48,$28,$AE,$32
	db $58,$18,$CC,$32,$58,$28,$CE,$32,$30,$24,$E0,$32,$30,$34,$E2,$32
	db $40,$24,$E4,$32,$40,$34,$E6,$32,$30,$3C,$E8,$32,$30,$4C,$EA,$32
	db $40,$3C,$EC,$32,$40,$4C,$EE,$32,$48,$30,$00,$33,$48,$40,$02,$33
	db $58,$30,$04,$33,$58,$40,$06,$33,$80,$80,$A5,$AA,$AA,$AA,$AA,$AA
	db $AA,$AA,$AA,$AA,$FF

DATA_00A0C3:
	dw DATA_00A0D3,DATA_00A0D3,DATA_00A0E5,DATA_00A0FF,DATA_00A0D3,DATA_00A0D3,DATA_00A0D3,DATA_00A0D3

DATA_00A0D3:
	dw $3720,$5740,$4F38,$5740,$6750,$5740,$7F68,$5740
	dw $8080

DATA_00A0E5:
	dw $432C,$5740,$5B44,$5740,$735C,$5740,$432C,$6F58
	dw $5B44,$6F58,$735C,$6F58,$8080

DATA_00A0FF:
	dw $432C,$5740,$5B44,$5740,$735C,$5740,$432C,$6F58
	dw $4F38,$8770,$5B44,$6F58,$735C,$6F58,$6750,$8770
	dw $8080

DATA_00A121:
	dw DATA_00A123

DATA_00A123:
	db $20,$32,$10,$33,$10,$34,$20,$35,$08,$2E,$08,$35,$08,$2E,$08,$35
	db $08,$2E,$08,$35,$08,$2E,$20,$35,$02,$2E,$02,$2F,$02,$30,$02,$31
	db $02,$2E,$02,$2F,$02,$30,$02,$31,$02,$2E,$02,$2F,$02,$30,$02,$31
	db $02,$2E,$02,$2F,$02,$30,$02,$31,$02,$2E,$02,$2F,$02,$30,$02,$31
	db $00

DATA_00A164:
	dw DATA_00A1D3,DATA_00A1E6,DATA_00A1F9,DATA_00A20C,DATA_00A1D0,DATA_00A21F,DATA_00A244,DATA_00A928
	dw DATA_00A8C5,DATA_00A2AD,DATA_00A367,DATA_00A2AD,DATA_00A361,DATA_00A368,DATA_00A3A9,DATA_00A3CE
	dw DATA_00A41D,DATA_00A45A,DATA_00A497,DATA_00A4BC,DATA_00A58F,DATA_00A596,DATA_00A704,DATA_00A767
	dw DATA_00A7A8,DATA_00A7BF,DATA_00A7D6,DATA_00A367,DATA_00A98F,DATA_00A9A2,DATA_00A9D7,DATA_00A9E2
	dw DATA_00A9F9,DATA_00AA17,DATA_00AA2E,DATA_00A321,DATA_00A35A,DATA_00A5BF,DATA_00A5DA,DATA_00A5ED
	dw DATA_00A604,DATA_00A66D,DATA_00A680,DATA_00A6E9,DATA_00A2F4,DATA_00AA08,DATA_00A7ED,DATA_00A808
	dw DATA_00A823,DATA_00A83E,DATA_00A859,DATA_00A874,DATA_00A88F,DATA_00A8AA

DATA_00A1D0:
	db $FF,$FF,$00

DATA_00A1D3:
	db $11,$01,$FD,$FB,$EE,$31,$03,$FB,$EF,$31,$FD,$01,$FE,$31,$03,$01
	db $FF,$31,$00

DATA_00A1E6:
	db $11,$01,$FC,$FB,$EE,$31,$13,$FB,$EF,$31,$FC,$12,$FE,$31,$13,$12
	db $FF,$31,$00

DATA_00A1F9:
	db $11,$01,$FD,$FB,$EE,$31,$1B,$FB,$EF,$31,$FD,$19,$FE,$31,$1B,$19
	db $FF,$31,$00

DATA_00A20C:
	db $11,$01,$FD,$FB,$EE,$31,$2B,$FB,$EF,$31,$FD,$29,$FE,$31,$2B,$29
	db $FF,$31,$00

DATA_00A21F:
	db $AA,$AA,$00,$00,$40,$37,$10,$00,$42,$37,$20,$00,$44,$37,$30,$00
	db $46,$37,$40,$00,$48,$37,$50,$00,$4A,$37,$60,$00,$4C,$37,$70,$00
	db $4E,$37,$FF,$FF,$00

DATA_00A244:
	db $AA,$AA,$00,$00,$40,$37,$10,$00,$42,$37,$20,$00,$44,$37,$30,$00
	db $46,$37,$40,$00,$48,$37,$50,$00,$4A,$37,$60,$00,$4C,$37,$70,$00
	db $4E,$37,$AA,$AA,$00,$18,$00,$31,$10,$18,$02,$31,$00,$28,$04,$31
	db $10,$28,$06,$31,$00,$38,$08,$31,$10,$38,$0A,$31,$00,$48,$0C,$31
	db $10,$48,$0E,$31,$AA,$AA,$00,$58,$20,$31,$10,$58,$22,$31,$00,$68
	db $24,$31,$10,$68,$26,$31,$00,$78,$28,$31,$10,$78,$2A,$31,$00,$88
	db $2C,$31,$10,$88,$2E,$37,$FF,$FF,$00

DATA_00A2AD:
	db $AA,$AA,$00,$00,$00,$33,$20,$00,$04,$33,$40,$00,$08,$33,$60,$00
	db $0C,$33,$00,$20,$40,$33,$20,$20,$44,$33,$40,$20,$48,$33,$60,$20
	db $4C,$33,$AA,$AA,$00,$40,$80,$33,$20,$40,$84,$33,$40,$40,$88,$33
	db $60,$40,$8C,$33,$00,$60,$C0,$33,$20,$60,$C4,$33,$40,$60,$C8,$33
	db $60,$60,$CC,$33,$FF,$FF,$00

DATA_00A2F4:
	db $AA,$AA,$18,$00,$7A,$33,$28,$00,$7C,$33,$00,$10,$70,$33,$10,$10
	db $72,$33,$18,$10,$73,$33,$00,$20,$75,$33,$10,$20,$77,$33,$18,$20
	db $78,$33,$50,$55,$08,$08,$7E,$33,$10,$08,$7F,$33,$00

DATA_00A321:
	db $EB,$BA,$F7,$F7,$66,$31,$17,$17,$AA,$31,$07,$17,$A8,$31,$F7,$17
	db $A6,$31,$17,$07,$8A,$31,$07,$07,$88,$31,$F7,$07,$86,$31,$17,$F7
	db $6A,$31,$FA,$57,$07,$F7,$68,$31,$0F,$3F,$8C,$31,$77,$3F,$8E,$31
	db $BF,$07,$6C,$31,$BF,$77,$6E,$31,$00

DATA_00A35A:
	db $54,$55,$00,$00,$94,$33,$00

DATA_00A361:
	db $56,$55,$00,$00,$C2,$30
DATA_00A367:
	db $00

DATA_00A368:
	db $11,$05,$FA,$B7,$B9,$34,$14,$C7,$2F,$33,$E4,$C7,$2E,$33,$04,$C7
	db $3F,$33,$F4,$C7,$3E,$33,$FC,$BF,$0F,$33,$0C,$BF,$2F,$33,$04,$B7
	db $2F,$33,$15,$54,$F4,$B7,$2E,$33,$EC,$BF,$2E,$33,$EC,$C7,$1E,$33
	db $0C,$C7,$1F,$33,$04,$BF,$1F,$33,$F4,$BF,$1E,$33,$FC,$B7,$0E,$33
	db $00

DATA_00A3A9:
	db $AA,$FF,$39,$E4,$64,$30,$29,$E4,$62,$30,$19,$E4,$4A,$30,$09,$E4
	db $48,$30,$F9,$E4,$46,$30,$E1,$E4,$44,$30,$D1,$E4,$42,$30,$C1,$E4
	db $40,$30,$55,$55,$00

DATA_00A3CE:
	db $EA,$FF,$2B,$2C,$E6,$30,$1B,$2C,$E4,$30,$0B,$2C,$E2,$30,$FB,$2C
	db $E0,$30,$F2,$FC,$6C,$30,$E2,$FC,$6A,$30,$D2,$FC,$68,$30,$C2,$FC
	db $66,$30,$EA,$FF,$22,$14,$64,$30,$12,$14,$62,$30,$02,$14,$C8,$30
	db $F2,$14,$C6,$30,$E2,$14,$C4,$30,$D2,$14,$6E,$30,$C2,$14,$22,$30
	db $E2,$2C,$CE,$30,$5F,$55,$D2,$2C,$CC,$30,$C2,$2C,$CA,$30,$00

DATA_00A41D:
	db $EA,$BF,$28,$A7,$2C,$39,$18,$A7,$2A,$39,$08,$A7,$28,$39,$F8,$A7
	db $26,$39,$E8,$A7,$24,$39,$D8,$A7,$22,$39,$C8,$A7,$20,$39,$28,$97
	db $0C,$39,$FA,$5F,$18,$97,$0A,$39,$08,$97,$08,$39,$F8,$97,$06,$39
	db $E8,$97,$04,$39,$D8,$97,$02,$39,$C8,$97,$00,$39,$00

DATA_00A45A:
	db $AA,$A0,$00,$38,$4C,$B4,$10,$38,$4E,$B4,$20,$38,$4E,$B4,$30,$38
	db $4C,$F4,$38,$30,$60,$74,$00,$30,$60,$34,$00,$20,$60,$34,$30,$20
	db $60,$74,$AA,$5A,$30,$00,$4C,$74,$00,$10,$60,$34,$30,$10,$60,$74
	db $20,$00,$4E,$34,$10,$00,$4E,$34,$00,$00,$4C,$34,$00

DATA_00A497:
	db $10,$51,$78,$C4,$AF,$34,$78,$1C,$B9,$34,$88,$1C,$AF,$34,$28,$1C
	db $8F,$34,$D8,$1C,$8E,$34,$28,$C4,$8E,$34,$D8,$C4,$B9,$34,$88,$C4
	db $B9,$34,$55,$55,$00

DATA_00A4BC:
	db $54,$55,$13,$11,$40,$3B,$82,$11,$41,$3B,$92,$11,$42,$3B,$A2,$11
	db $43,$3B,$B2,$11,$44,$3B,$C2,$11,$45,$3B,$D2,$11,$46,$3B,$E2,$11
	db $47,$3B,$51,$55,$F2,$11,$48,$3B,$02,$11,$49,$3B,$92,$31,$50,$3B
	db $DA,$41,$51,$3B,$BA,$41,$52,$3B,$B2,$31,$53,$3B,$AA,$21,$54,$3B
	db $C2,$31,$55,$3B,$55,$50,$D2,$31,$56,$3B,$E2,$31,$57,$3B,$FA,$21
	db $58,$3B,$F2,$31,$59,$3B,$02,$31,$5A,$3B,$12,$31,$5B,$3B,$FA,$41
	db $5C,$3B,$EA,$41,$5D,$3B,$50,$55,$0A,$21,$5E,$3B,$1A,$21,$5F,$3B
	db $8A,$21,$60,$3B,$BA,$21,$61,$3B,$A2,$31,$62,$3B,$CA,$21,$63,$3B
	db $EA,$21,$64,$3B,$CA,$41,$65,$3B,$55,$40,$9A,$21,$66,$3B,$AA,$41
	db $67,$3B,$DA,$21,$68,$3B,$9A,$41,$69,$3B,$0A,$41,$4A,$3B,$1A,$41
	db $4B,$3B,$22,$31,$4C,$3B,$C2,$51,$6A,$3B,$55,$00,$CA,$51,$6B,$3B
	db $D2,$51,$6C,$3B,$DA,$51,$6E,$3B,$E2,$51,$6D,$3B,$28,$11,$6E,$39
	db $30,$11,$6F,$39,$30,$21,$4F,$39,$2A,$41,$4D,$39,$54,$55,$32,$41
	db $4E,$39,$00

DATA_00A58F:
	db $56,$55,$00,$00,$9E,$3F,$00

DATA_00A596:
	db $AA,$FE,$57,$AC,$C0,$30,$47,$AC,$E6,$30,$37,$AC,$E4,$30,$27,$AC
	db $E2,$30,$17,$AC,$E0,$30,$FF,$AC,$CE,$30,$EF,$AC,$CC,$30,$DF,$AC
	db $CA,$30,$57,$55,$CF,$AC,$C0,$30,$00

DATA_00A5BF:
	db $55,$55,$F8,$E0,$01,$30,$F0,$E0,$00,$30,$E0,$F0,$05,$30,$F0,$E8
	db $04,$30,$E8,$E8,$03,$30,$E0,$E8,$02,$30,$00

DATA_00A5DA:
	db $55,$55,$FD,$FC,$07,$32,$F8,$F8,$07,$30,$FB,$03,$06,$32,$F7,$00
	db $06,$30,$00

DATA_00A5ED:
	db $00,$54,$70,$11,$71,$39,$68,$11,$70,$39,$74,$F9,$74,$3B,$6C,$F9
	db $73,$3B,$64,$F9,$72,$3B,$00

DATA_00A604:
	db $00,$00,$00,$00,$8D,$3D,$00,$08,$8D,$3D,$00,$10,$8E,$3D,$08,$00
	db $8D,$3D,$08,$08,$8D,$3D,$08,$10,$8E,$3D,$10,$00,$8D,$3D,$10,$08
	db $8D,$3D,$00,$00,$10,$10,$8E,$3D,$18,$00,$8D,$3D,$18,$08,$8D,$3D
	db $18,$10,$8E,$3D,$20,$00,$8D,$3D,$20,$08,$8D,$3D,$20,$10,$8E,$3D
	db $28,$00,$8D,$3D,$00,$00,$28,$08,$8D,$3D,$28,$10,$8E,$3D,$30,$00
	db $8D,$3D,$30,$08,$8D,$3D,$30,$10,$8E,$3D,$38,$00,$8D,$3D,$38,$08
	db $8D,$3D,$38,$10,$8E,$3D,$55,$55,$00

DATA_00A66D:
	db $AA,$55,$21,$29,$D2,$35,$11,$29,$D0,$35,$21,$19,$B2,$35,$11,$19
	db $B0,$35,$00

DATA_00A680:
	db $55,$05,$EB,$00,$90,$31,$EB,$08,$A0,$31,$F3,$00,$90,$31,$F3,$08
	db $A0,$31,$FB,$00,$90,$31,$FB,$08,$A0,$31,$03,$00,$90,$31,$03,$08
	db $A0,$31,$00,$00,$14,$00,$2F,$30,$14,$08,$3F,$30,$1C,$00,$2F,$30
	db $1C,$08,$3F,$30,$24,$00,$2F,$30,$24,$08,$3F,$30,$2C,$00,$2F,$30
	db $2C,$08,$3F,$30,$00,$00,$34,$00,$2F,$30,$34,$08,$3F,$30,$3C,$00
	db $2F,$30,$3C,$08,$3F,$30,$44,$00,$2F,$30,$44,$08,$3F,$30,$4C,$00
	db $2F,$30,$4C,$08,$3F,$30,$55,$55,$00

DATA_00A6E9:
	db $55,$55,$CE,$2C,$3D,$30,$C6,$2C,$A2,$31,$C6,$24,$92,$31,$CE,$0C
	db $3D,$30,$C6,$0C,$A1,$31,$C6,$04,$91,$31,$00

DATA_00A704:
	db $00,$00,$60,$F0,$00,$30,$50,$30,$0C,$30,$40,$30,$0A,$30,$50,$20
	db $E8,$30,$60,$10,$CA,$30,$50,$10,$C8,$30,$60,$00,$AA,$30,$50,$00
	db $A8,$30,$02,$54,$10,$F0,$80,$30,$00,$20,$6E,$30,$00,$10,$4E,$30
	db $00,$00,$2E,$30,$00,$F0,$0E,$30,$F0,$20,$6C,$30,$E0,$20,$6A,$30
	db $F0,$10,$4C,$30,$D5,$55,$E0,$10,$4A,$30,$F0,$00,$2C,$30,$E0,$00
	db $2A,$30,$A0,$F0,$02,$30,$90,$20,$60,$30,$90,$10,$40,$30,$90,$00
	db $20,$30,$00

DATA_00A767:
	db $00,$55,$30,$00,$06,$31,$20,$00,$04,$31,$10,$00,$02,$31,$00,$00
	db $00,$31,$F0,$00,$EE,$30,$E0,$00,$EC,$30,$D0,$00,$EA,$30,$C0,$00
	db $CE,$30,$40,$55,$20,$F0,$CC,$30,$10,$F0,$AE,$30,$00,$F0,$AC,$30
	db $F0,$F0,$8E,$30,$E0,$F0,$8C,$30,$D0,$F0,$8A,$30,$C0,$F0,$88,$30
	db $00

DATA_00A7A8:
	db $40,$55,$20,$F0,$28,$33,$10,$F0,$0E,$33,$00,$F0,$0C,$33,$F0,$F0
	db $0A,$33,$E0,$F0,$08,$33,$00

DATA_00A7BF:
	db $AB,$56,$02,$80,$20,$35,$42,$80,$20,$35,$82,$80,$20,$35,$C2,$80
	db $20,$35,$02,$80,$20,$35,$00

DATA_00A7D6:
	db $AB,$56,$01,$80,$20,$75,$41,$80,$20,$75,$81,$80,$20,$75,$C1,$80
	db $20,$75,$01,$80,$20,$75,$00

DATA_00A7ED:
	db $55,$55,$E0,$D0,$4E,$37,$D0,$D0,$4C,$37,$C0,$D0,$4A,$37,$E0,$C0
	db $2E,$37,$D0,$C0,$2C,$37,$C0,$C0,$2A,$37,$00

DATA_00A808:
	db $55,$55,$E0,$D0,$8C,$37,$D0,$D0,$8A,$37,$C0,$D0,$88,$37,$E0,$C0
	db $6C,$37,$D0,$C0,$6A,$37,$C0,$C0,$68,$37,$00

DATA_00A823:
	db $55,$55,$E0,$D0,$C4,$37,$D0,$D0,$C2,$37,$C0,$D0,$C0,$37,$E0,$C0
	db $A4,$37,$D0,$C0,$A2,$37,$C0,$C0,$A0,$37,$00

DATA_00A83E:
	db $55,$55,$E0,$D0,$CA,$37,$D0,$D0,$C8,$37,$C0,$D0,$C6,$37,$E0,$C0
	db $AA,$37,$D0,$C0,$A8,$37,$C0,$C0,$A6,$37,$00

DATA_00A859:
	db $55,$55,$E0,$D0,$CE,$37,$D0,$D0,$CC,$37,$E0,$C0,$AE,$37,$D0,$C0
	db $AC,$37,$C0,$D0,$8E,$37,$C0,$C0,$6E,$37,$00

DATA_00A874:
	db $55,$55,$E0,$D0,$CE,$37,$D0,$D0,$CC,$37,$C0,$D0,$8E,$37,$E0,$C0
	db $E4,$37,$D0,$C0,$E2,$37,$C0,$C0,$E0,$37,$00

DATA_00A88F:
	db $55,$55,$E0,$C0,$EA,$37,$D0,$C0,$E8,$37,$C0,$C0,$E6,$37,$E0,$D0
	db $CE,$37,$D0,$D0,$CC,$37,$C0,$D0,$8E,$37,$00

DATA_00A8AA:
	db $55,$55,$E0,$D0,$CE,$37,$D0,$D0,$CC,$37,$C0,$D0,$8E,$37,$E0,$C0
	db $48,$37,$D0,$C0,$EE,$37,$C0,$C0,$EC,$37,$00

DATA_00A8C5:
	db $00,$00,$D1,$16,$90,$33,$D9,$16,$91,$33,$E1,$16,$92,$33,$E9,$16
	db $93,$33,$D5,$16,$65,$33,$DC,$16,$75,$33,$E3,$16,$85,$33,$11,$0C
	db $61,$31,$00,$00,$19,$0C,$71,$31,$21,$0C,$71,$31,$29,$0C,$61,$31
	db $31,$0C,$80,$31,$39,$0C,$A5,$31,$41,$0C,$64,$31,$49,$0C,$81,$31
	db $93,$16,$82,$31,$00,$40,$9B,$16,$83,$31,$A3,$16,$95,$31,$AB,$16
	db $95,$31,$B3,$16,$95,$31,$BB,$16,$95,$31,$C3,$16,$95,$31,$CB,$16
	db $60,$31,$00

DATA_00A928:
	db $00,$00,$97,$1E,$84,$31,$A3,$1E,$95,$31,$AB,$1E,$95,$31,$B3,$1E
	db $95,$31,$BB,$1E,$95,$31,$C3,$1E,$95,$31,$CB,$1E,$60,$31,$97,$1E
	db $81,$31,$01,$00,$00

DATA_00A94D:
	db $3E,$3E,$3E,$3E,$4E,$5E,$6E,$6E,$7E,$8E,$9E,$AE,$BE,$BE

DATA_00A95B:
	db $00,$00,$00,$00,$01,$02,$03,$03,$04,$05,$06,$07,$08,$08,$09,$0A
	db $0B,$0C,$0D,$0E,$11,$12,$0F,$10,$23,$24,$25,$26,$27,$28,$29,$2A

DATA_00A97B:
	db $0A,$0A,$0A,$0A,$08,$08,$06,$06,$06,$06,$06,$06,$06,$06,$0C,$03
	db $01,$02,$00,$11

DATA_00A98F:
	db $00,$01,$FE,$FD,$D4,$30,$16,$FD,$D5,$30,$FE,$15,$D6,$30,$16,$15
	db $D7,$30,$00

DATA_00A9A2:
	db $00,$00,$05,$F0,$EF,$30,$0D,$F0,$C0,$30,$09,$F8,$C1,$30,$23,$05
	db $C6,$30,$23,$0D,$C7,$30,$1B,$09,$C5,$30,$0D,$24,$C3,$30,$05,$24
	db $C2,$30,$00,$01,$09,$1C,$C4,$30,$F1,$0D,$C8,$30,$F1,$05,$C9,$30
	db $F9,$09,$CA,$30,$00

DATA_00A9D7:
	db $1A,$00,$00,$00,$80,$30,$20,$00,$84,$30,$00

DATA_00A9E2:
	db $AA,$06,$00,$00,$00,$30,$20,$00,$04,$30,$40,$00,$08,$30,$60,$00
	db $0C,$30,$80,$00,$88,$30,$00

DATA_00A9F9:
	db $6A,$00,$00,$00,$44,$36,$00,$20,$48,$36,$00,$40,$4C,$36,$00

DATA_00AA08:
	db $6A,$00,$00,$00,$44,$3E,$00,$20,$48,$3E,$00,$40,$4C,$3E,$00

DATA_00AA17:
	db $AA,$06,$00,$00,$00,$30,$20,$00,$04,$30,$40,$00,$08,$30,$70,$00
	db $40,$30,$60,$00,$0C,$30,$00

DATA_00AA2E:
	db $AA,$AA,$00,$00,$F8,$3A,$00,$08,$F9,$3A,$00,$10,$FA,$3A,$00,$18
	db $FB,$3A,$00,$20,$FB,$3A,$00,$28,$FB,$3A,$00,$30,$FB,$3A,$00,$38
	db $FB,$3A,$AA,$AA,$00,$40,$FB,$3A,$00,$48,$FB,$3A,$00,$50,$FB,$3A
	db $00,$58,$FB,$3A,$00,$60,$FB,$3A,$00,$68,$FB,$3A,$00,$76,$FC,$3A
	db $00,$70,$FB,$3A,$FF,$FF,$00

DATA_00AA75:
	db $00,$09,$07,$06,$05,$04,$03,$02,$01

DATA_00AA7E:
	dw !RAM_SIMC_Global_GeneralPurposeBuffer+$4000,!RAM_SIMC_Global_GeneralPurposeBuffer+$4400,!RAM_SIMC_Global_GeneralPurposeBuffer+$4800,!RAM_SIMC_Global_GeneralPurposeBuffer+$4C00
	dw !RAM_SIMC_Global_GeneralPurposeBuffer+$5000,!RAM_SIMC_Global_GeneralPurposeBuffer+$5400,!RAM_SIMC_Global_GeneralPurposeBuffer+$5800,!RAM_SIMC_Global_GeneralPurposeBuffer+$5C00
	dw !RAM_SIMC_Global_GeneralPurposeBuffer+$6000,!RAM_SIMC_Global_GeneralPurposeBuffer+$6400,!RAM_SIMC_Global_GeneralPurposeBuffer+$6800,!RAM_SIMC_Global_GeneralPurposeBuffer+$6C00
	dw !RAM_SIMC_Global_GeneralPurposeBuffer+$7000,!RAM_SIMC_Global_GeneralPurposeBuffer+$7400

DATA_00AA9A:
	dw !RAM_SIMC_Global_GeneralPurposeBuffer+$4800,!RAM_SIMC_Global_GeneralPurposeBuffer+$4800,!RAM_SIMC_Global_GeneralPurposeBuffer+$4800,!RAM_SIMC_Global_GeneralPurposeBuffer+$4800
	dw !RAM_SIMC_Global_GeneralPurposeBuffer+$4800,!RAM_SIMC_Global_GeneralPurposeBuffer+$5000,!RAM_SIMC_Global_GeneralPurposeBuffer+$4000,!RAM_SIMC_Global_GeneralPurposeBuffer+$4800
	dw !RAM_SIMC_Global_GeneralPurposeBuffer+$4000,!RAM_SIMC_Global_GeneralPurposeBuffer+$4000,!RAM_SIMC_Global_GeneralPurposeBuffer+$4000,!RAM_SIMC_Global_GeneralPurposeBuffer+$4000
	dw !RAM_SIMC_Global_GeneralPurposeBuffer+$4000,!RAM_SIMC_Global_GeneralPurposeBuffer+$4000

DATA_00AAB6:
	dw $180E,$180C,$180A,$1808,$1806,$1804,$1802,$1800
	dw $160E,$160C,$160A,$1608,$1606,$1604,$1602,$1600
	dw $140E,$140C,$140A,$1408,$1406,$1404,$1402,$1400
	dw $120E,$120C,$120A,$1208,$1206,$1204,$1202,$1200
	dw $100E,$100C,$100A,$1008,$1006,$1004,$1002,$1000
	dw $0E0E,$0E0C,$0E0A,$0E08,$0E06,$0E04,$0E02,$0E00
	dw $0C0E,$0C0C,$0C0A,$0C08,$0C06,$0C04,$0C02,$0C00
	dw $0A0E,$0A0C,$0A0A,$0A08,$0A06,$0A04,$0A02,$0A00
	dw $080E,$080C,$080A,$0808,$0806,$0804,$0802,$0800
	dw $060E,$060C,$060A,$0608,$0606,$0604,$0602,$0600
	dw $040E,$040C,$040A,$0408,$0406,$0404,$0402,$0400

DATA_00AB66:
	dw $0010,$0000,$1000,$0000,$1010,$0000,$0000,$0010
	dw $0010,$0010,$1000,$0010,$00C3,$0103,$0143,$0183
	dw $01C3,$0203,$0243,$0283,$02C3,$0303

CODE_00AB92:
	SEP.b #$10
	REP.b #$20
	LDA.w $0A91
	BEQ.b CODE_00ABA5
	SEP.b #$20
	LDA.b $E1
	AND.b #$07
	CMP.b #$03
	BEQ.b CODE_00ABA6
CODE_00ABA5:
	RTS

CODE_00ABA6:
	LDA.b #$01
	STA.w $0AB7
	LDA.b $E3
	BNE.b CODE_00ABA5
	LDA.w $0193
	CMP.b #$03
	BNE.b CODE_00ABB9
	JMP.w CODE_00AD24

CODE_00ABB9:
	LDA.w $0ABF
	AND.b #$0F
	BNE.b CODE_00ABD1
	LDA.b $E1
	CMP.b #$03
	BNE.b CODE_00ABE7
	PHP
	JSL.l CODE_0098A0	: dw $0103
	PLP
	JSR.w CODE_00ACE9
CODE_00ABD1:
	SEP.b #$30
	LDA.w $0AC1
	ASL
	ASL
	ASL
	STA.b $91
	LDA.w $0ABF
	AND.b #$03
	ASL
	CLC
	ADC.b $91
	STA.w $0AC3
CODE_00ABE7:
	INC.w $0ABF
	LDA.w $0AC1
	AND.b #$02
	TAY
	LDA.w $0AC1
	AND.b #$01
	BNE.b CODE_00AC16
	LDA.w $0A6B,y
	SEC
	SBC.b #$01
	AND.b #$07
	CMP.w $0A6B,y
	BEQ.b CODE_00AC4E
	STA.w $0A6B,y
	CMP.b #$07
	BNE.b CODE_00AC4E
	LDA.w $0A4F,y
	SEC
	SBC.b #$01
	STA.w $0A4F,y
	BRA.b CODE_00AC34

CODE_00AC16:
	LDA.w $0A6B,y
	CLC
	ADC.b #$01
	AND.b #$07
	CMP.w $0A6B,y
	BEQ.b CODE_00AC4E
	STA.w $0A6B,y
	LDA.w $0A6B,y
	BNE.b CODE_00AC4E
	LDA.w $0A4F,y
	CLC
	ADC.b #$01
	STA.w $0A4F,y
CODE_00AC34:
	LDA.w $0A4F
	XBA
	LDA.w $0A51
	PHY
	REP.b #$10
	LDY.w #$0000
	JSL.l CODE_03A9C2
	STA.w $0AB9
	JSR.w CODE_00ADEE
	SEP.b #$30
	PLY
CODE_00AC4E:
	LDA.w $0A6B,y
	BNE.b CODE_00AC62
	LDA.w $0A4F,y
	BMI.b CODE_00AC66
	CMP.w $0ABB,y
	BEQ.b CODE_00AC66
	CMP.w DATA_00AC79,y
	BEQ.b CODE_00AC66
CODE_00AC62:
	JSR.w CODE_00AD24
	RTS

CODE_00AC66:
	REP.b #$20
	LDA.w $0A91
	BMI.b CODE_00AC70
	JMP.w CODE_00AC7D

CODE_00AC70:
	REP.b #$20
	STZ.w $0A91
	STZ.w $0AB7
	RTS

DATA_00AC79:
	dw $0064,$0078

CODE_00AC7D:
	LDA.w $0AC1
CODE_00AC80:
	JSR.w CODE_00824F
	REP.b #$30
CODE_00AC85:
	CMP.w #$0078
	BCC.b CODE_00AC90
	SEC
	SBC.w #$0078
	BCS.b CODE_00AC85
CODE_00AC90:
	CMP.w $0A51
	BEQ.b CODE_00AC80
	STA.w $0ABD
CODE_00AC98:
	JSR.w CODE_00824F
	REP.b #$30
CODE_00AC9D:
	CMP.w #$0064
	BCC.b CODE_00ACA8
	SEC
	SBC.w #$0064
	BCS.b CODE_00AC9D
CODE_00ACA8:
	CMP.w $0A4F
	BEQ.b CODE_00AC98
	STA.w $0ABB
	LDA.w #$FFFF
	STA.w $0A91
	STZ.w $0ABF
	LDX.w #$0002
	LDA.w $0A51
	SEC
	SBC.w $0ABD
	BCS.b CODE_00ACCA
	INX
	EOR.w #$FFFF
	INC
CODE_00ACCA:
	STA.b $79
	LDY.w #$0000
	LDA.w $0A4F
	SEC
	SBC.w $0ABB
	BCS.b CODE_00ACDD
	INY
	EOR.w #$FFFF
	INC
CODE_00ACDD:
	CMP.b $79
	BCC.b CODE_00ACE5
	STY.w $0AC1
	RTS

CODE_00ACE5:
	STX.w $0AC1
	RTS

CODE_00ACE9:
	SEP.b #$20
	SEP.b #$10
	STZ.w $0ABF
	LDX.b #$03
	LDA.w $0ABD
	SEC
	SBC.w $0A51
	BCS.b CODE_00AD03
	DEX
	LDA.w $0A51
	SEC
	SBC.w $0ABD
CODE_00AD03:
	STA.b $91
	LDY.b #$01
	LDA.w $0ABB
	SEC
	SBC.w $0A4F
	BCS.b CODE_00AD18
	DEY
	LDA.w $0A4F
	SEC
	SBC.w $0ABB
CODE_00AD18:
	CMP.b $91
	BCS.b CODE_00AD20
	STX.w $0AC1
	RTS

CODE_00AD20:
	STY.w $0AC1
	RTS

CODE_00AD24:					; Note: Related to Bowser.
	REP.b #$30
	LDA.w $0AB5
	BNE.b CODE_00AD6D
	LDA.w $0AC3
	LDX.w $0AB9
	BEQ.b CODE_00AD37
	CLC
	ADC.w #$0020
CODE_00AD37:
	LDX.b $D7
	CPX.w #$0001
	BNE.b CODE_00AD42
	CLC
	ADC.w #$0040
CODE_00AD42:
	TAX
	LDA.w DATA_00AD6E,x
	TAX
	PHB
	LDY.w #$7E7400
	LDA.w #$007F
	MVN $7E7400>>16,DATA_048000>>16
	LDY.w #$7E7600
	LDA.w #$007F
	MVN $7E7600>>16,DATA_048000>>16
	LDY.w #$7E7480
	LDA.w #$007F
	MVN $7E7480>>16,DATA_048000>>16
	LDY.w #$7E7680
	LDA.w #$007F
	MVN $7E7680>>16,DATA_048000>>16
	PLB
CODE_00AD6D:
	RTS

DATA_00AD6E:
	dw DATA_048000+$0000,DATA_048000+$0200,DATA_048000+$0400,DATA_048000+$0600,DATA_048000+$0800,DATA_048000+$0A00,DATA_048000+$0C00,DATA_048000+$0E00
	dw DATA_048000+$1000,DATA_048000+$1200,DATA_048000+$1400,DATA_048000+$1600,DATA_048000+$1800,DATA_048000+$1A00,DATA_048000+$1C00,DATA_048000+$1E00
	dw DATA_048000+$2000,DATA_048000+$2200,DATA_048000+$2400,DATA_048000+$2600,DATA_048000+$2800,DATA_048000+$2A00,DATA_048000+$2C00,DATA_048000+$2E00
	dw DATA_048000+$3000,DATA_048000+$3200,DATA_048000+$3400,DATA_048000+$3600,DATA_048000+$3800,DATA_048000+$3A00,DATA_048000+$3C00,DATA_048000+$3E00
	dw DATA_048000+$4000,DATA_048000+$4200,DATA_048000+$4400,DATA_048000+$4600,DATA_048000+$4800,DATA_048000+$4A00,DATA_048000+$4C00,DATA_048000+$4E00
	dw DATA_048000+$5000,DATA_048000+$5200,DATA_048000+$5400,DATA_048000+$5600,DATA_048000+$5800,DATA_048000+$5A00,DATA_048000+$5C00,DATA_048000+$5E00
	dw DATA_048000+$6000,DATA_048000+$6200,DATA_048000+$6400,DATA_048000+$6600,DATA_048000+$6800,DATA_048000+$6A00,DATA_048000+$6C00,DATA_048000+$6E00
	dw DATA_048000+$7000,DATA_048000+$7200,DATA_048000+$7400,DATA_048000+$7600,DATA_048000+$7800,DATA_048000+$7A00,DATA_048000+$7C00,DATA_048000+$7E00

CODE_00ADEE:
	SEP.b #$10
	REP.b #$20
	LDA.w $0A95
	BEQ.b CODE_00AE0A
	LDA.w $0A51
	CMP.w $0A65
	BNE.b CODE_00AE0A
	LDA.w $0A4F
	CMP.w $0A63
	BNE.b CODE_00AE0A
	JMP.w CODE_00BA54

CODE_00AE0A:
	LDA.w $0A93
	BEQ.b CODE_00AE2D
	LDA.w $0A51
	CMP.w $0A55
	BNE.b CODE_00AE2D
	LDA.w $0A4F
	CMP.w $0A53
	BNE.b CODE_00AE2D
	STZ.w $0A93
	REP.b #$10
	LDX.w #$0000
	LDY.w #$0000
	JSR.w CODE_00AE2E
CODE_00AE2D:
	RTS

CODE_00AE2E:
	SEP.b #$20
	REP.b #$10
	TXA
	AND.b #$FF
	TAX
	PHX
	LDA.w $0A4F,x
	DEC
	XBA
	LDA.w $0A51,x
	DEC
	PHY
	JSL.l CODE_03A9C2
	SEP.b #$20
	REP.b #$10
	PLY
	PLX
	PHX
	LDA.w $0A4F,x
	DEC
	XBA
	LDA.w $0A51,x
	INC
	PHY
	JSL.l CODE_03A9C2
	SEP.b #$20
	REP.b #$10
	PLY
	PLX
	PHX
	LDA.w $0A4F,x
	INC
	XBA
	LDA.w $0A51,x
	DEC
	PHY
	JSL.l CODE_03A9C2
	SEP.b #$20
	REP.b #$10
	PLY
	PLX
	LDA.w $0A4F,x
	INC
	XBA
	LDA.w $0A51,x
	INC
	JSL.l CODE_03A9C2
	RTS

CODE_00AE83:
	REP.b #$30
	LDA.w $0A8F
	BNE.b CODE_00AE8B
CODE_00AE8A:
	RTS

CODE_00AE8B:
	LDA.w $0193
	CMP.w #$0003
	BEQ.b CODE_00AED6
	LDA.b $E1
	AND.w #$0003
	BNE.b CODE_00AEA0
	INC.w $0AEB
	INC.w $0AEB
CODE_00AEA0:
	LDA.b $E1
	AND.w #$0007
	CMP.w #$0005
	BNE.b CODE_00AE8A
	SEP.b #$30
	LDA.b #$01
	STA.w $0AB7
	LDA.w $0AAF
	BEQ.b CODE_00AEBA
	JSR.w CODE_00AFB1
	RTS

CODE_00AEBA:
	BIT.w $0A9C
	BPL.b CODE_00AEC4
	LDX.b #$00
	JMP.w CODE_00AFCC

CODE_00AEC4:
	JSR.w CODE_00AED7
	BCC.b CODE_00AECC
	JMP.w CODE_00B040

CODE_00AECC:
	SEP.b #$20
	LDA.w $0A9C
	ORA.b #$80
	STA.w $0A9C
CODE_00AED6:
	RTS

CODE_00AED7:
	SEP.b #$30
	LDX.b #$04
CODE_00AEDB:
	REP.b #$30
	LDA.w $0A97,x
	BEQ.b CODE_00AF48
	CMP.w #$0004
	BEQ.b CODE_00AF48
	BCS.b CODE_00AF08
	LDA.w $0A75,x
	CLC
	ADC.w #$0001
	AND.w #$0007
	STA.w $0A75,x
	BNE.b CODE_00AF48
	LDA.w $0A59,x
	CMP.w #$0077
	BCC.b CODE_00AF03
	JMP.w CODE_00AFAF

CODE_00AF03:
	INC.w $0A59,x
	BRA.b CODE_00AF25

CODE_00AF08:
	LDA.w $0A75,x
	SEC
	SBC.w #$0001
	AND.w #$0007
	STA.w $0A75,x
	CMP.w #$0007
	BNE.b CODE_00AF48
	LDA.w $0A59,x
	BNE.b CODE_00AF22
	JMP.w CODE_00AFAF

CODE_00AF22:
	DEC.w $0A59,x
CODE_00AF25:
	LDA.w $0A59,x
	CMP.w $0AA5,x
	BNE.b CODE_00AF48
	LDY.w #$0000
	LDA.w $0A97,x
	CMP.w #$0002
	BEQ.b CODE_00AFAF
	BCC.b CODE_00AF44
	CMP.w #$0006
	BEQ.b CODE_00AFAF
	BCS.b CODE_00AF44
	LDY.w #$0004
CODE_00AF44:
	TYA
	STA.w $0A97,x
CODE_00AF48:
	LDA.w $0A97,x
	CMP.w #$0002
	BEQ.b CODE_00AFAD
	BCC.b CODE_00AF75
	CMP.w #$0006
	BEQ.b CODE_00AFAD
	BCS.b CODE_00AF75
	LDA.w $0A73,x
	CLC
	ADC.w #$0001
	AND.w #$0007
	STA.w $0A73,x
	BNE.b CODE_00AFAD
	LDA.w $0A57,x
	CMP.w #$0063
	BCS.b CODE_00AFAF
	INC.w $0A57,x
	BRA.b CODE_00AF8F

CODE_00AF75:
	LDA.w $0A73,x
	SEC
	SBC.w #$0001
	AND.w #$0007
	STA.w $0A73,x
	CMP.w #$0007
	BNE.b CODE_00AFAD
	LDA.w $0A57,x
	BEQ.b CODE_00AFAF
	DEC.w $0A57,x
CODE_00AF8F:
	LDA.w $0A57,x
	CMP.w $0AA3,x
	BNE.b CODE_00AFAD
	LDY.w #$0002
	LDA.w $0A97,x
	BEQ.b CODE_00AFAF
	CMP.w #$0004
	BEQ.b CODE_00AFAF
	BCC.b CODE_00AFA9
	LDY.w #$0006
CODE_00AFA9:
	TYA
	STA.w $0A97,x
CODE_00AFAD:
	SEC
	RTS

CODE_00AFAF:
	CLC
	RTS

CODE_00AFB1:
	SEP.b #$30
	LDX.b #$00
CODE_00AFB5:
	SEP.b #$30
	LDA.w $0A9B,x
	CLC
	ADC.w $0AAF,x
	AND.b #$07
	STA.w $0A9B,x
	CMP.w $0A9D,x
	BNE.b CODE_00AFCB
	STZ.w $0AAF,x
CODE_00AFCB:
	RTS

CODE_00AFCC:
	SEP.b #$10
	REP.b #$20
	LDA.w $0A9B,x
	AND.w #$00FF
	STA.w $0A9B,x
	JSR.w CODE_00824F
	SEP.b #$30
CODE_00AFDE:
	CMP.b #$78
	BCC.b CODE_00AFE7
	SEC
	SBC.b #$78
	BCS.b CODE_00AFDE
CODE_00AFE7:
	CMP.w $0A5D,x
	BEQ.b CODE_00AFCC
	STA.w $0AA9,x
	STA.w $0ACD
CODE_00AFF2:
	JSR.w CODE_00824F
	SEP.b #$30
CODE_00AFF7:
	CMP.b #$64
	BCC.b CODE_00B000
	SEC
	SBC.b #$64
	BCS.b CODE_00AFF7
CODE_00B000:
	CMP.w $0A5B,x
	BEQ.b CODE_00AFF2
	STA.w $0AA7,x
	STA.w $0ACF
	LDY.b #$01
	LDA.w $0ACD
	CMP.w $0A5D,x
	BCS.b CODE_00B017
	LDY.b #$07
CODE_00B017:
	LDA.w $0ACF
	CMP.w $0A5B,x
	BCC.b CODE_00B029
	CPY.b #$01
	BEQ.b CODE_00B027
	DEY
	DEY
	BRA.b CODE_00B029

CODE_00B027:
	INY
	INY
CODE_00B029:
	TYA
	CMP.w $0A9B,x
	BEQ.b CODE_00B03F
	STA.w $0A9D,x
	SEC
	SBC.w $0A9B,x
	AND.b #$07
	TAY
	LDA.w DATA_00B0B9,y
	STA.w $0AAF,x
CODE_00B03F:
	RTS

CODE_00B040:
	SEP.b #$20
	REP.b #$10
	LDA.w $0A9B
	AND.b #$07
	CMP.b #$02
	BNE.b CODE_00B054
	LDA.w $0A79
	BEQ.b CODE_00B059
	BNE.b CODE_00B0B8		; Note: This will always branch.

CODE_00B054:
	LDA.w $0A77
	BNE.b CODE_00B0B8
CODE_00B059:
	LDA.w $0A5B
	STA.w !REGISTER_Multiplicand
	LDA.b #$78
	STA.w !REGISTER_Multiplier
	PHA
	PLA
	NOP
	REP.b #$20
	LDA.w !REGISTER_ProductOrRemainderLo
	ASL
	STA.b $91
	LDA.w $0A5D
	ASL
	CLC
	ADC.b $91
	TAX
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	AND.w #$03FF
	CMP.w #$0050
	BCC.b CODE_00B0B8
	CMP.w #$0060
	BCS.b CODE_00B0B8
	LDA.w $0387
	ORA.w $0389
	BNE.b CODE_00B0B8
	JSR.w CODE_00824F
	REP.b #$20
	AND.w #$0007
	BNE.b CODE_00B0B8
	LDA.w $0A5D
	STA.w $0400
	LDA.w $0A5B
	STA.w $0402
	LDA.w #$00C0
	STA.w $03FE
	LDA.w #$012C
	STA.w $038B
	LDA.w #$001C
	STA.w $0389
CODE_00B0B8:
	RTS

DATA_00B0B9:
	db $00,$01,$01,$01,$01,$FF,$FF,$FF

CODE_00B0C1:
	REP.b #$20
	LDA.w $0A8B
	BEQ.b CODE_00B0D2
	LDA.b $E1
	AND.w #$0007
	CMP.w #$0007
	BEQ.b CODE_00B0D3
CODE_00B0D2:
	RTS

CODE_00B0D3:
	LDA.w #$0001
	STA.w $0AB7
	LDA.b $E3
	BNE.b CODE_00B0D2
	LDA.w $0193
	CMP.w #$0003
	BEQ.b CODE_00B11C
	SEP.b #$20
	REP.b #$10
	INC.w $0AC7
	LDA.w $0AC7
	AND.b #$03
	STA.w $0AC7
	REP.b #$20
	LDA.w $0A8B
	BPL.b CODE_00B0FE
	JMP.w CODE_00B178

CODE_00B0FE:
	SEP.b #$30
	LDX.b #$00
	JSR.w CODE_00AEDB
	BCC.b CODE_00B120
	SEP.b #$20
	REP.b #$10
	LDA.w $0A57
	XBA
	LDA.w $0A59
	LDY.w #$0000
	JSL.l CODE_03A9C2
	STA.w $0AC5
CODE_00B11C:
	JSR.w CODE_00B126
	RTS

CODE_00B120:
	SEP.b #$20
	STZ.w $0A8B
	RTS

CODE_00B126:
	REP.b #$30
	LDA.w $0AB5
	BNE.b CODE_00B167
	LDA.w $0AC7
	LDX.b $D7
	CPX.w #$0001
	BNE.b CODE_00B13B
	CLC
	ADC.w #$0004
CODE_00B13B:
	ASL
	TAX
	LDA.w DATA_00B168,x
	TAX
	PHB
	LDY.w #$7E7500
	LDA.w #$007F
	MVN $7E7500>>16,DATA_068000>>16
	LDY.w #$7E7700
	LDA.w #$007F
	MVN $7E7700>>16,DATA_068000>>16
	LDY.w #$7E7580
	LDA.w #$007F
	MVN $7E7580>>16,DATA_068000>>16
	LDY.w #$7E7780
	LDA.w #$007F
	MVN $7E7780>>16,DATA_068000>>16
	PLB
CODE_00B167:
	RTS

DATA_00B168:
	dw DATA_068000+$0000,DATA_068000+$0200,DATA_068000+$0400,DATA_068000+$0600
	dw DATA_06A000+$0000,DATA_06A000+$0200,DATA_06A000+$0400,DATA_06A000+$0600

CODE_00B178:
	SEP.b #$30
	LDY.b #$01
	LDA.w $0AA5
	CMP.w $0A59
	BCS.b CODE_00B186
	LDY.b #$07
CODE_00B186:
	LDA.w $0AA3
	CMP.w $0A57
	BCC.b CODE_00B198
	CPY.b #$01
	BEQ.b CODE_00B196
	DEY
	DEY
	BRA.b CODE_00B198

CODE_00B196:
	INY
	INY
CODE_00B198:
	TYA
	STA.w $0A97
	STZ.w $0A75
	STZ.w $0A73
	LDA.b #$01
	STA.w $0A8B
	STZ.w $0A8C
	RTS

CODE_00B1AB:
	REP.b #$30
	LDA.w $0A93
	BEQ.b CODE_00B1BE
	LDA.b $E1
	AND.w #$0007
	CMP.w #$0006
	BEQ.b CODE_00B1C2
	BNE.b CODE_00B1C1
CODE_00B1BE:
	STZ.w $0AE9
CODE_00B1C1:
	RTS

CODE_00B1C2:
	LDA.w #$0001
	STA.w $0AB7
	LDA.b $E3
	BNE.b CODE_00B1C1
	LDA.w $0193
	CMP.w #$0003
	BEQ.b CODE_00B209
	LDA.w $0ADF
	BEQ.b CODE_00B1ED
	LDA.w $0AE3
	CLC
	ADC.w $0ADF
	STA.w $0AE3
	AND.w #$0007
	CMP.w #$0004
	BEQ.b CODE_00B1FF
	BNE.b CODE_00B209
CODE_00B1ED:
	LDA.w $0AE1
	CLC
	ADC.w $0ADD
	STA.w $0AE1
	AND.w #$0007
	CMP.w #$0004
	BNE.b CODE_00B209
CODE_00B1FF:
	JSR.w CODE_00B260
	REP.b #$20
	LDA.w $0ADB
	BRA.b CODE_00B221

CODE_00B209:
	REP.b #$30
	LDA.w #DATA_069E00+$0000
	LDX.w $0ADD
	BNE.b CODE_00B216
	LDA.w #DATA_069E00+$0080
CODE_00B216:
	LDX.b $D7
	CPX.w #$0001
	BNE.b CODE_00B221
	CLC
	ADC.w #$2000
CODE_00B221:
	STA.w $0ADB
	TAX
	PHB
	LDY.w #$7E79C0
	LDA.w #$003F
	MVN $7E79C0>>16,DATA_069E00>>16
	LDY.w #$7E7BC0
	LDA.w #$003F
	MVN $7E7BC0>>16,DATA_069E00>>16
	PLB
	REP.b #$20
	LDA.w $0AE1
	LSR
	LSR
	LSR
	STA.w $0A55
	LDA.w $0AE1
	AND.w #$0007
	STA.w $0A71
	LDA.w $0AE3
	LSR
	LSR
	LSR
	STA.w $0A53
	LDA.w $0AE3
	AND.w #$0007
	STA.w $0A6F
	RTS

CODE_00B260:
	JSR.w CODE_00B4B5
	REP.b #$30
	STZ.w $0AE7
	AND.w #$03FF
	CMP.w #$0070
	BEQ.b CODE_00B288
	CMP.w #$0071
	BEQ.b CODE_00B288
	CMP.w #$034B
	BCC.b CODE_00B28E
	CMP.w #$0354
	BCS.b CODE_00B28E
	LDX.w #$0080
	STX.w $0AE7
	JMP.w CODE_00B2E6

CODE_00B288:
	LDX.w #$0080
	STX.w $0AE7
CODE_00B28E:
	CMP.w #$006D
	BCC.b CODE_00B2B7
	CMP.w #$006F
	BEQ.b CODE_00B2B7
	CMP.w #$0074
	BCC.b CODE_00B2E6
	CMP.w #$0078
	BCS.b CODE_00B2A5
	JMP.w CODE_00B356

CODE_00B2A5:
	CMP.w #$007C
	BCS.b CODE_00B2AD
	JMP.w CODE_00B3EC

CODE_00B2AD:
	BNE.b CODE_00B2B2
	JMP.w CODE_00B398

CODE_00B2B2:
	CMP.w #$007F
	BCC.b CODE_00B2E6
CODE_00B2B7:
	REP.b #$30
	LDA.w $0AE5
	BNE.b CODE_00B2DF
	LDA.w $0ADF
	EOR.w #$FFFF
	CLC
	ADC.w #$0001
	STA.w $0ADF
	LDA.w $0ADD
	EOR.w #$FFFF
	CLC
	ADC.w #$0001
	STA.w $0ADD
	LDA.w #$0001
	STA.w $0AE5
	RTS

CODE_00B2DF:
	STZ.w $0A93
	STZ.w $0AE5
	RTS

CODE_00B2E6:
	REP.b #$30
	LDA.w $0AE3
	LDX.w $0ADF
	JSR.w CODE_00B346
	SEP.b #$20
	STA.w !REGISTER_Multiplicand
	LDA.b #$78
	STA.w !REGISTER_Multiplier
	PHA
	PLA
	NOP
	REP.b #$20
	LDA.w !REGISTER_ProductOrRemainderLo
	ASL
	STA.b $91
	LDA.w $0AE1
	LDX.w $0ADD
	JSR.w CODE_00B346
	ASL
	CLC
	ADC.b $91
	TAX
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	AND.w #$03FF
	CMP.w #$006D
	BCC.b CODE_00B343
	CMP.w #$006F
	BEQ.b CODE_00B343
	CMP.w #$007F
	BCC.b CODE_00B33A
	CMP.w #$034B
	BCC.b CODE_00B343
	CMP.w #$0354
	BCS.b CODE_00B343
	LDX.w #$0080
	STX.w $0AE7
CODE_00B33A:
	LDX.w $0AE5
	BEQ.b CODE_00B342
	DEC.w $0AE5
CODE_00B342:
	RTS

CODE_00B343:
	JMP.w CODE_00B2B7

CODE_00B346:
	REP.b #$30
	LSR
	LSR
	LSR
	CPX.w #$0001
	BCC.b CODE_00B355
	BNE.b CODE_00B354
	INC
	INC
CODE_00B354:
	DEC
CODE_00B355:
	RTS

CODE_00B356:
	LDX.w $0AE5
	BEQ.b CODE_00B35E
	DEC.w $0AE5
CODE_00B35E:
	LSR
	BCS.b CODE_00B376
	REP.b #$30
	LDA.w $0ADD
	LDX.w $0ADF
	STA.w $0ADF
	STX.w $0ADD
	LDA.w #DATA_069E00+$0100
	STA.w $0ADB
	RTS

CODE_00B376:
	LDA.w $0ADD
	LDX.w $0ADF
	EOR.w #$FFFF
	CLC
	ADC.w #$0001
	STA.w $0ADF
	TXA
	EOR.w #$FFFF
	CLC
	ADC.w #$0001
	STA.w $0ADD
	LDA.w #DATA_069E00+$0180
	STA.w $0ADB
	RTS

CODE_00B398:
	REP.b #$30
	STZ.w $0AE5
	JSL.l CODE_00824B
	AND.w #$0003
	BEQ.b CODE_00B3EB
	CMP.w #$0003
	BEQ.b CODE_00B3EB
	TAX
	LDA.w $0ADF
	BEQ.b CODE_00B3CC
	STA.w $0ADD
	LDY.w #DATA_069E00+$0100
	STZ.w $0ADF
	DEX
	BEQ.b CODE_00B3E8
	EOR.w #$FFFF
	CLC
	ADC.w #$0001
	STA.w $0ADD
	LDY.w #DATA_069E00+$0180
	BRA.b CODE_00B3E8

CODE_00B3CC:
	LDA.w $0ADD
	STA.w $0ADF
	LDY.w #DATA_069E00+$0180
	STZ.w $0ADD
	DEX
	BEQ.b CODE_00B3E8
	EOR.w #$FFFF
	CLC
	ADC.w #$0001
	STA.w $0ADF
	LDY.w #DATA_069E00+$0100
CODE_00B3E8:
	STY.w $0ADB
CODE_00B3EB:
	RTS

CODE_00B3EC:
	REP.b #$30
	STZ.w $0AE5
	SEC
	SBC.w #$0078
	ASL
	ASL
	ASL
	STA.b $91
	LDX.w #$0000
	LDA.w $0ADF
	BMI.b CODE_00B414
	BEQ.b CODE_00B409
	LDX.w #$0002
	BRA.b CODE_00B414

CODE_00B409:
	LDX.w #$0003
	LDA.w $0ADD
	BMI.b CODE_00B414
	LDX.w #$0001
CODE_00B414:
	TXA
	ASL
	CLC
	ADC.b $91
	STA.b $91
	JSL.l CODE_00824B
	AND.w #$0001
	CLC
	ADC.b $91
	TAX
	LDA.w $0ADD
	STA.b $91
	LDA.w $0ADF
	STA.b $94
	STZ.w $0ADD
	STZ.w $0ADF
	SEP.b #$20
	LDA.w DATA_00B4E2,x
	BEQ.b CODE_00B460
	CMP.b #$01
	BEQ.b CODE_00B47B
	CMP.b #$02
	BEQ.b CODE_00B496
	REP.b #$30
	LDA.w #$FFFF
	STA.w $0ADD
	LDX.w #DATA_069E00+$0000
	CMP.b $91
	BEQ.b CODE_00B4B1
	LDX.w #DATA_069E00+$0180
	LDA.b $94
	BPL.b CODE_00B4B1
	LDX.w #DATA_069E00+$0100
	BRA.b CODE_00B4B1

CODE_00B460:
	REP.b #$30
	LDA.w #$FFFF
	STA.w $0ADF
	LDX.w #DATA_069E00+$0080
	CMP.b $94
	BEQ.b CODE_00B4B1
	LDX.w #DATA_069E00+$0180
	LDA.b $91
	BPL.b CODE_00B4B1
	LDX.w #DATA_069E00+$0100
	BRA.b CODE_00B4B1

CODE_00B47B:
	REP.b #$30
	LDA.w #$0001
	STA.w $0ADD
	LDX.w #DATA_069E00+$0000
	CMP.b $91
	BEQ.b CODE_00B4B1
	LDX.w #DATA_069E00+$0100
	LDA.b $94
	BPL.b CODE_00B4B1
	LDX.w #DATA_069E00+$0180
	BRA.b CODE_00B4B1

CODE_00B496:
	REP.b #$30
	LDA.w #$0001
	STA.w $0ADF
	LDX.w #DATA_069E00+$0080
	CMP.b $94
	BEQ.b CODE_00B4B1
	LDX.w #DATA_069E00+$0100
	LDA.b $91
	BPL.b CODE_00B4B1
	LDX.w #DATA_069E00+$0180
	BRA.b CODE_00B4B1

CODE_00B4B1:
	STX.w $0ADB
	RTS

CODE_00B4B5:
	REP.b #$30
	LDA.w $0AE3
	LSR
	LSR
	LSR
	SEP.b #$20
	STA.w !REGISTER_Multiplicand
	LDA.b #$78
	STA.w !REGISTER_Multiplier
	PHA
	PLA
	NOP
	REP.b #$20
	LDA.w !REGISTER_ProductOrRemainderLo
	ASL
	STA.b $91
	LDA.w $0AE1
	LSR
	LSR
	LSR
	ASL
	CLC
	ADC.b $91
	TAX
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	RTS

DATA_00B4E2:
	db $00,$00,$00,$01,$01,$03,$00,$03,$00,$01,$00,$00,$01,$02,$00,$02
	db $01,$03,$01,$02,$00,$00,$02,$03,$00,$03,$00,$02,$02,$03,$00,$00

CODE_00B502:
	REP.b #$30
	LDA.w $0A8D
	BNE.b CODE_00B50A
CODE_00B509:
	RTS

CODE_00B50A:
	LDA.b $E1
	AND.w #$0003
	BNE.b CODE_00B509
	LDA.w $0193
	CMP.w #$0003
	BNE.b CODE_00B51C
	JMP.w CODE_00B602

CODE_00B51C:
	LDA.w $0197
	AND.w #$0004
	BEQ.b CODE_00B53C
	LDA.b $E3
	BNE.b CODE_00B509
	LDA.w $0197
	AND.w #$FFFB
	STA.w $0197
	LDA.w $0425
	AND.w #$0001
	BNE.b CODE_00B53C
	JMP.w CODE_00B5B0

CODE_00B53C:
	LDA.b $E1
	AND.w #$0003
	BNE.b CODE_00B509
	LDA.w #$0001
	STA.w $0AB7
	LDA.w $0ACB
	BEQ.b CODE_00B551
	JMP.w CODE_00B683

CODE_00B551:
	JSR.w CODE_00B584
	BCS.b CODE_00B509
	LDA.w $0AB3
	BEQ.b CODE_00B55E
	JMP.w CODE_00B66B

CODE_00B55E:
	SEP.b #$30
	BIT.w $0AA0
	BPL.b CODE_00B56A
	LDX.b #$04
	JMP.w CODE_00AFCC

CODE_00B56A:
	SEP.b #$30
	LDX.b #$08
	JSR.w CODE_00AEDB
	BCC.b CODE_00B579
	JSR.w CODE_00B602
	JMP.w CODE_00B6FC

CODE_00B579:
	SEP.b #$20
	LDA.w $0AA0
	ORA.b #$80
	STA.w $0AA0
	RTS

CODE_00B584:
	SEP.b #$20
	LDA.w $0A8F
	BEQ.b CODE_00B5A3
	LDA.w $0A5D
	CMP.w $0A61
	BNE.b CODE_00B5A3
	LDA.w $0A5B
	CMP.w $0A5F
	BNE.b CODE_00B5A3
	STZ.w $0A8F
	STZ.w $0A90
	BRA.b CODE_00B5B0

CODE_00B5A3:
	CLC
	RTS

CODE_00B5A5:
	SEP.b #$20
	LDA.w $0B15
	BNE.b CODE_00B5AD
	RTS

CODE_00B5AD:
	STZ.w $0B15
CODE_00B5B0:
	SEP.b #$20
	REP.b #$10
	STZ.w $0A8D
	STZ.w $0A8E
	LDA.w $0A5F
	XBA
	LDA.w $0A61
	LDY.w #$0001
	JSL.l CODE_03A9C2
	REP.b #$10
	LDX.w #$0010
	LDY.w #$0001
	JSR.w CODE_00AE2E
	PHP
	JSL.l CODE_0098A0	: dw $0F03
	PLP
	SEP.b #$20
	LDA.b #$09
	JSL.l CODE_03C426
	SEP.b #$20
	LDA.b #$FF
	STA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	LDA.b #$22
	STA.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.w $0A61
	STA.w $0400
	LDA.w $0A5F
	STA.w $0402
	LDA.b #$FF
	STA.w $03FE
	SEC
	RTS

CODE_00B602:
	REP.b #$30
	LDA.w $0A9F
CODE_00B607:
	LDX.b $D7
	CPX.w #$0001
	BNE.b CODE_00B612
	CLC
	ADC.w #$000B
CODE_00B612:
	ASL
	TAX
	LDA.w DATA_00B63F,x
	TAX
	PHB
	LDY.w #$7E7100
	LDA.w #$007F
	MVN $7E7100>>16,DATA_069200>>16
	LDY.w #$7E7300
	LDA.w #$007F
	MVN $7E7300>>16,DATA_069200>>16
	LDY.w #$7180
	LDA.w #$007F
	MVN $7E7180>>16,DATA_069200>>16
	LDY.w #$7380
	LDA.w #$007F
	MVN $7E7380>>16,DATA_069200>>16
	PLB
	RTS

DATA_00B63F:
	dw DATA_069200+$0200,DATA_069200+$0400,DATA_069200+$0000,DATA_069200+$0400,DATA_069200+$0200,DATA_069200+$0400,DATA_069200+$0000,DATA_069200+$0400
	dw DATA_069200+$0600,DATA_069200+$0800,DATA_069200+$0A00,DATA_06B200+$0200,DATA_06B200+$0400,DATA_06B200+$0000,DATA_06B200+$0400,DATA_06B200+$0200
	dw DATA_06B200+$0400,DATA_06B200+$0000,DATA_06B200+$0400,DATA_06B200+$0600,DATA_06B200+$0800,DATA_06B200+$0A00

CODE_00B66B:
	REP.b #$30
	LDA.w $0AD9
	INC
	AND.w #$0001
	STA.w $0AD9
	BNE.b CODE_00B682
	LDX.w #$0004
	JSR.w CODE_00AFB5
	JSR.w CODE_00B602
CODE_00B682:
	RTS

CODE_00B683:
	REP.b #$30
	LDA.w $0A9F
	CMP.w #$0002
	BNE.b CODE_00B6BB
	LDA.w $0A7D
	CLC
	ADC.w #$0001
	AND.w #$0007
	STA.w $0A7D
	BNE.b CODE_00B6E1
	INC.w $0A61
	LDA.w $0A61
	SEC
	SBC.w $0AAD
	CMP.w #$0004
	BCC.b CODE_00B6E1
	PHP
	JSL.l CODE_0098A0	: dw $0C03
	PLP
	LDA.w #$0006
	STA.w $0A9F
	BRA.b CODE_00B6E1

CODE_00B6BB:
	LDA.w $0A7D
	SEC
	SBC.w #$0001
	AND.w #$0007
	STA.w $0A7D
	CMP.w #$0007
	BNE.b CODE_00B6E1
	DEC.w $0A61
	LDA.w $0A61
	CMP.w $0AAD
	BNE.b CODE_00B6E1
	STZ.w $0ACB
	LDA.w #$8006
	STA.w $0A9F
CODE_00B6E1:
	LDA.w $0A61
	SEC
	SBC.w $0AAD
	TAX
	LDA.w #$0008
	CPX.w #$0001
	BCC.b CODE_00B6F8
	INC
	CPX.w #$0003
	BCC.b CODE_00B6F8
	INC
CODE_00B6F8:
	JSR.w CODE_00B607
	RTS

CODE_00B6FC:
	SEP.b #$20
	REP.b #$10
	LDA.w $0A5F
	STA.w !REGISTER_Multiplicand
	LDA.b #$78
	STA.w !REGISTER_Multiplier
	PHA
	PLA
	NOP
	REP.b #$20
	LDA.w !REGISTER_ProductOrRemainderLo
	CLC
	ADC.w $0A61
	ASL
	TAX
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	CMP.w #$0297
	BNE.b CODE_00B742
	LDA.w $0A9F
	BEQ.b CODE_00B742
	CMP.w #$0004
	BCS.b CODE_00B742
	INC.w $0ACB
	LDA.w #$0002
	STA.w $0A9F
	LDA.w $0A61
	INC
	STA.w $0AAD
	LDA.w $0A5F
	STA.w $0AAB
CODE_00B742:
	RTS

CODE_00B743:
	REP.b #$20
	LDA.b $40
	CMP.w #$0006
	BEQ.b CODE_00B758
	LDA.b $40
	CMP.w #$0007
	BEQ.b CODE_00B758
	LDA.w $0A95
	BNE.b CODE_00B759
CODE_00B758:
	RTS

CODE_00B759:
	REP.b #$20
	LDA.b $E1
	AND.w #$0007
	CMP.w #$0001
	BNE.b CODE_00B758
	LDA.w $0193
	CMP.w #$0003
	BNE.b CODE_00B770
	JMP.w CODE_00BA17

CODE_00B770:
	DEC.w $0B0F
	BNE.b CODE_00B783
	PHP
	JSL.l CODE_0098A0	: dw $0503
	PLP
	LDA.w #$0258
	STA.w $0B0F
CODE_00B783:
	SEP.b #$30
	LDA.b #$01
	STA.w $0AB7
	LDA.b $E3
	BNE.b CODE_00B758
	LDA.w $0A96
	BPL.b CODE_00B796
	JMP.w CODE_00B81D

CODE_00B796:
	LDA.w $0B07
	BEQ.b CODE_00B7A5
	JSR.w CODE_00B84B
	LDA.w $0B07
	BNE.b CODE_00B814
	BEQ.b CODE_00B7BE
CODE_00B7A5:
	LDA.w $0A81
	BNE.b CODE_00B7BE
	LDA.w $0A7F
	BNE.b CODE_00B7BE
	JSR.w CODE_00B86D
	SEP.b #$20
	LDA.b #$08
	STA.w $0B0D
	LDA.w $0B07
	BNE.b CODE_00B814
CODE_00B7BE:
	SEP.b #$10
	REP.b #$20
	LDA.w $0B0B
	ASL
	ASL
	TAX
	LDA.w DATA_00BABA,x
	BEQ.b CODE_00B7D4
	CLC
	ADC.w $0B13
	STA.w $0B13
CODE_00B7D4:
	LDA.w DATA_00BABA+$02,x
	BEQ.b CODE_00B7E0
	CLC
	ADC.w $0B11
	STA.w $0B11
CODE_00B7E0:
	REP.b #$20
	LDA.w $0B11
	BMI.b CODE_00B817
	LSR
	LSR
	LSR
	STA.w $0A63
	CMP.w #$0064
	BCS.b CODE_00B817
	LDA.w $0B11
	AND.w #$0007
	STA.w $0A7F
	LDA.w $0B13
	BMI.b CODE_00B817
	LSR
	LSR
	LSR
	STA.w $0A65
	CMP.w #$0078
	BCS.b CODE_00B817
	LDA.w $0B13
	AND.w #$0007
	STA.w $0A81
CODE_00B814:
	JMP.w CODE_00BA17

CODE_00B817:
	REP.b #$20
	STZ.w $0A95
	RTS

CODE_00B81D:
	REP.b #$30
	LDA.w $0A63
	ASL
	ASL
	ASL
	STA.w $0B11
	LDA.w $0A65
	ASL
	ASL
	ASL
	STA.w $0B13
	STZ.w $0A81
	STZ.w $0A7F
	JSR.w CODE_00B86D
	REP.b #$30
	LDA.w $0A95
	BEQ.b CODE_00B84A
	LDA.w #$0001
	STA.w $0A95
	JMP.w CODE_00BA17

CODE_00B84A:
	RTS

CODE_00B84B:
	SEP.b #$20
	LDA.w $0B05
	INC
	AND.b #$01
	STA.w $0B05
	BNE.b CODE_00B86C
	LDA.w $0B0B
	CLC
	ADC.w $0B07
	AND.b #$07
	STA.w $0B0B
	CMP.w $0B09
	BNE.b CODE_00B86C
	STZ.w $0B07
CODE_00B86C:
	RTS

CODE_00B86D:
	JSR.w CODE_00B9EE
	REP.b #$30
	LDA.w $0B0B
	CLC
	ADC.w #$0004
	AND.w #$0007
	STA.b $94
	STZ.b $9D
	STZ.b $A0
	JSR.w CODE_00824F
	REP.b #$30
	AND.w #$0007
	STA.b $97
CODE_00B88C:
	STA.b $9A
	CMP.b $94
	BEQ.b CODE_00B8A3
	CMP.w $0B0B
	BNE.b CODE_00B89E
	JSR.w CODE_00B9A4
	BCS.b CODE_00B8EB
	BRA.b CODE_00B8A3

CODE_00B89E:
	JSR.w CODE_00B8EC
	BCS.b CODE_00B8EB
CODE_00B8A3:
	REP.b #$30
	LDA.b $9A
	INC
	AND.w #$0007
	CMP.b $97
	BNE.b CODE_00B88C
	LDA.b $A0
	BNE.b CODE_00B8EB
	LDA.b $9D
	BEQ.b CODE_00B8C3
	DEC
	CMP.w $0B0B
	BEQ.b CODE_00B8EB
	STZ.w $0B05
	JMP.w CODE_00B92C

CODE_00B8C3:
	STZ.b $9D
	LDA.b $94
	STA.b $9A
	JSR.w CODE_00B8EC
	BCS.b CODE_00B8D4
	REP.b #$20
	LDA.b $9D
	BEQ.b CODE_00B8DE
CODE_00B8D4:
	REP.b #$20
	LDA.b $94
	STZ.w $0B05
	JMP.w CODE_00B92C

CODE_00B8DE:
	REP.b #$20
	LDA.w $0A95
	STZ.w $0A95
	BMI.b CODE_00B8EB
	JSR.w CODE_00BA54
CODE_00B8EB:
	RTS

CODE_00B8EC:
	REP.b #$30
	ASL
	TAY
	LDA.w DATA_00B943,y
	CLC
	ADC.b $91
	CMP.w #$5DC0
	BCS.b CODE_00B925
	TAX
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	AND.w #$03FF
	CMP.w #$0002
	BEQ.b CODE_00B927
	CMP.w #$0354
	BEQ.b CODE_00B927
	CMP.w #$0355
	BEQ.b CODE_00B927
	CMP.w #$0003
	BNE.b CODE_00B925
	LDA.b $9D
	BNE.b CODE_00B925
	JSR.w CODE_00B963
	BCC.b CODE_00B925
	LDA.b $9A
	INC
	STA.b $9D
CODE_00B925:
	CLC
	RTS

CODE_00B927:
	STZ.w $0B05
	LDA.b $9A
CODE_00B92C:
	AND.w #$0007
	STA.w $0B09
	SEP.b #$20
	SEC
	SBC.w $0B0B
	AND.b #$07
	TAX
	LDA.w DATA_00B0B9,x
	STA.w $0B07
	SEC
	RTS

DATA_00B943:
	dw $FF10,$FF12,$0002,$00F2,$00F0,$00EE,$FFFE,$FF0E

DATA_00B953:
	dw $FE20,$FE24,$0004,$01E4,$01E0,$01DC,$FFFC,$FE1C

CODE_00B963:
	REP.b #$30
	LDA.w DATA_00B953,y
	CLC
	ADC.b $91
	CMP.w #$5DC0
	BCS.b CODE_00B9A0
	TAX
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	AND.w #$03FF
	CMP.w #$0002
	BEQ.b CODE_00B9A2
	CMP.w #$0354
	BEQ.b CODE_00B9A2
	CMP.w #$0355
	BEQ.b CODE_00B9A2
	CMP.w #$0060
	BEQ.b CODE_00B9A2
	CMP.w #$0061
	BEQ.b CODE_00B9A2
	CMP.w #$0070
	BEQ.b CODE_00B9A2
	CMP.w #$0071
	BEQ.b CODE_00B9A2
	CMP.w #$0003
	BEQ.b CODE_00B9A2
CODE_00B9A0:
	CLC
	RTS

CODE_00B9A2:
	SEC
	RTS

CODE_00B9A4:
	REP.b #$30
	ASL
	TAY
	LDA.w DATA_00B943,y
	CLC
	ADC.b $91
	CMP.w #$5DC0
	BCS.b CODE_00B9EA
	TAX
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	AND.w #$03FF
	CMP.w #$0002
	BEQ.b CODE_00B9EC
	CMP.w #$0354
	BEQ.b CODE_00B9EC
	CMP.w #$0355
	BEQ.b CODE_00B9EC
	CMP.w #$0060
	BEQ.b CODE_00B9EC
	CMP.w #$0061
	BEQ.b CODE_00B9EC
	CMP.w #$0070
	BEQ.b CODE_00B9EC
	CMP.w #$0071
	BEQ.b CODE_00B9EC
	CMP.w #$0003
	BNE.b CODE_00B9EA
	JSR.w CODE_00B963
	BCC.b CODE_00B9EA
	INC.b $A0
CODE_00B9EA:
	CLC
	RTS

CODE_00B9EC:
	SEC
	RTS

CODE_00B9EE:
	SEP.b #$20
	REP.b #$10
	LDA.w $0A63
	STA.w !REGISTER_Multiplicand
	LDA.b #$78
	STA.w !REGISTER_Multiplier
	NOP
	PHA
	PLA
	REP.b #$20
	LDA.w #$0088
	STA.b $94
	LDA.w !REGISTER_ProductOrRemainderLo
	ASL
	STA.b $91
	LDA.w $0A65
	ASL
	CLC
	ADC.b $91
	STA.b $91
	RTS

CODE_00BA17:
	REP.b #$30
	LDA.w $0B0B
	LDX.b $D7
	CPX.w #$0001
	BNE.b CODE_00BA27
	CLC
	ADC.w #$0008
CODE_00BA27:
	ASL
	TAX
	LDA.w DATA_00BA9A,x
	TAX
	PHB
	LDY.w #$7E7000
	LDA.w #$007F
	MVN $7E7000>>16,DATA_068800>>16
	LDY.w #$7E7200
	LDA.w #$007F
	MVN $7E7200>>16,DATA_068800>>16
	LDY.w #$7E7080
	LDA.w #$007F
	MVN $7E7080>>16,DATA_068800>>16
	LDY.w #$7E7280
	LDA.w #$007F
	MVN $7E7200>>16,DATA_068800>>16
	PLB
	RTS

CODE_00BA54:
	REP.b #$30
	STZ.w $0A95
	SEP.b #$20
	LDA.w $0A63
	XBA
	LDA.w $0A65
	LDY.w #$0000
	JSL.l CODE_03A9C2
	REP.b #$10
	LDX.w #$0014
	LDY.w #$0000
	JSR.w CODE_00AE2E
	SEP.b #$20
	LDA.b #$10
	JSL.l CODE_03C426
	SEP.b #$20
	LDA.b #$FF
	STA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	LDA.b #$2B
	STA.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.w $0A65
	STA.w $0400
	LDA.w $0A63
	STA.w $0402
	LDA.b #$FF
	STA.w $03FE
	RTS

DATA_00BA9A:
	dw DATA_068800+$0200,DATA_068800+$0600,DATA_068800+$0000,DATA_068800+$0800,DATA_068800+$0200,DATA_068800+$0800,DATA_068800+$0000,DATA_068800+$0400
	dw DATA_06A800+$0200,DATA_06A800+$0600,DATA_06A800+$0000,DATA_06A800+$0800,DATA_06A800+$0200,DATA_06A800+$0800,DATA_06A800+$0000,DATA_06A800+$0400

DATA_00BABA:
	dw $0000,$FFFF,$0001,$FFFF,$0001,$0000,$0001,$0001
	dw $0000,$0001,$FFFF,$0001,$FFFF,$0000,$FFFF,$FFFF

CODE_00BADA:
	REP.b #$30
	LDA.b $D7
	CMP.w #$0003
	BCS.b CODE_00BB20
	LDA.w $0AB7
	BEQ.b CODE_00BB20
	LDA.w $0AB5
	ORA.w $0C0F
	ORA.b $E3
	ORA.w $01F7
	BNE.b CODE_00BB20
	LDA.w $0AF1
	BNE.b CODE_00BB21
	LDA.b $D7
	DEC
	BEQ.b CODE_00BB09
	LDA.w $011B
	AND.w #$4080
	BNE.b CODE_00BB20
	BRA.b CODE_00BB11

CODE_00BB09:
	LDA.w $011B
	AND.w #$0F00
	BNE.b CODE_00BB20
CODE_00BB11:
	LDA.b $E1
	AND.w #$0003
	CMP.w #$0002
	BCC.b CODE_00BB20
	BNE.b CODE_00BB2F
	JMP.w CODE_00BB71

CODE_00BB20:
	RTS

CODE_00BB21:
	LDA.b $E1
	AND.w #$0001
	BNE.b CODE_00BB20
	LDA.w $0B03
	BNE.b CODE_00BB71
	BEQ.b CODE_00BB20
CODE_00BB2F:
	SEP.b #$20
	REP.b #$10
	LDX.w #$6200
	STX.w !REGISTER_VRAMAddressLo
	LDA.b #$01
	STA.w DMA[$04].Parameters
	LDX.w #$7E7400
	STX.w DMA[$04].SourceLo
	LDA.b #$7E7400>>16
	STA.w DMA[$04].SourceBank
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$04].Destination
	LDX.w #$0400
	STX.w DMA[$04].SizeLo
	LDA.b #$10
	STA.w !REGISTER_DMAEnable
	LDX.w #$65E0
	STX.w !REGISTER_VRAMAddressLo
	LDX.w #$7E7BC0
	STX.w DMA[$04].SourceLo
	LDX.w #$0040
	STX.w DMA[$04].SizeLo
	LDA.b #$10
	STA.w !REGISTER_DMAEnable
	RTS

CODE_00BB71:
	SEP.b #$20
	REP.b #$10
	LDX.w #$6000
	STX.w !REGISTER_VRAMAddressLo
	LDA.b #$01
	STA.w DMA[$04].Parameters
	LDX.w #$7E7000
	STX.w DMA[$04].SourceLo
	LDA.b #$7E7000>>16
	STA.w DMA[$04].SourceBank
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$04].Destination
	LDX.w #$0400
	STX.w DMA[$04].SizeLo
	LDA.b #$10
	STA.w !REGISTER_DMAEnable
	LDX.w #$64E0
	STX.w !REGISTER_VRAMAddressLo
	LDX.w #$7E79C0
	STX.w DMA[$04].SourceLo
	LDX.w #$0040
	STX.w DMA[$04].SizeLo
	LDA.b #$10
	STA.w !REGISTER_DMAEnable
	RTS

DATA_00BBB3:
	dw $0000,$0002,$0004,$0006,$0002,$0000,$0006,$0004
	dw $0006,$0004,$0002,$0000,$0004,$0006,$0000,$0002

DATA_00BBD3:
	db $38,$78,$78,$F8,$B8,$B8,$38,$38

DATA_00BBDB:
	db $00,$08,$08,$10,$18,$18,$00,$00

DATA_00BBE3:
	db $FE,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FD,$FF,$FE,$FF,$FF,$FF,$FF,$FF
	db $FE,$FF,$FE,$FF,$FE,$FF,$00,$00,$FE,$FF,$FD,$FF

DATA_00BBFF:
	dw $0001,$FFFF,$0001,$0002

DATA_00BC07:
	dw $0002,$0000,$FFFF,$0000

DATA_00BC0F:
	dw $4840,$4844,$4840,$4844

DATA_00BC17:
	dw $004C,$005C,$004C,$005C

DATA_00BC1F:
	dw $7838,$F878,$B8B8,$3838

DATA_00BC27:
	dw $1808,$0010

DATA_00BC2B:
	dw $B878,$38F8

DATA_00BC2F:
	dw $0303,$0300,$0001,$0303

DATA_00BC37:
	dw $02FC,$08F3,$20CF,$803F

CODE_00BC3F:
	REP.b #$20
	LDA.b $D7
	BMI.b CODE_00BCC3
	LDA.w $0AF1
	BNE.b CODE_00BC99
	LDA.w $0AB5
	BNE.b CODE_00BC99
	LDA.w $01F7
	BNE.b CODE_00BCC3
	LDA.b $D7
	CMP.w #$0001
	BEQ.b CODE_00BC65
	LDA.w $011B
	AND.w #$4080
	BNE.b CODE_00BC9F
	BEQ.b CODE_00BC6D
CODE_00BC65:
	LDA.w $011B
	AND.w #$0F00
	BNE.b CODE_00BCA6
CODE_00BC6D:
	LDA.b $E3
	BNE.b CODE_00BCC3
	LDA.b $E1
	AND.w #$0003
	CMP.w #$0002
	BCC.b CODE_00BCC3
	BNE.b CODE_00BC89
	SEP.b #$20
	JSR.w CODE_00C154
	JSR.w CODE_00BEC9
	JSR.w CODE_00BDC8
	RTS

CODE_00BC89:
	JSR.w CODE_00C0F5
	JSR.w CODE_00BCC4
	JSR.w CODE_00BD9C
	JSR.w CODE_00BE1C
	JSR.w CODE_00BD15
	RTS

CODE_00BC99:
	JSR.w CODE_00C0F5
	JMP.w CODE_00C154

CODE_00BC9F:
	REP.b #$20
	LDA.w $0379
	BNE.b CODE_00BCC3
CODE_00BCA6:
	LDA.w $01C1
	BNE.b CODE_00BCC3
	JSR.w CODE_00C0F5
	JSR.w CODE_00C154
	JSR.w CODE_00BEC9
	JSR.w CODE_00BDC8
	JSR.w CODE_00BCC4
	JSR.w CODE_00BD9C
	JSR.w CODE_00BE1C
	JSR.w CODE_00BD15
CODE_00BCC3:
	RTS

CODE_00BCC4:
	REP.b #$30
	LDA.w $0A8B
	BEQ.b CODE_00BD14
	LDA.w #$0008
	JSR.w CODE_00BF80
	REP.b #$30
	LDA.b $D7
	CMP.w #$0001
	BNE.b CODE_00BCEF
	LDX.w #$000C
CODE_00BCDD:
	LDA.l SIMC_Global_OAMBuffer[$6D].XDisp,x
	SEC
	SBC.w #$0004
	STA.l SIMC_Global_OAMBuffer[$6D].XDisp,x
	DEX
	DEX
	DEX
	DEX
	BPL.b CODE_00BCDD
CODE_00BCEF:
	LDA.w #$3C28
	LDX.w $0AC5
	BEQ.b CODE_00BCFA
	LDA.w #$3A28
CODE_00BCFA:
	STA.l SIMC_Global_OAMBuffer[$6D].Tile
	CLC
	ADC.w #$0002
	STA.l SIMC_Global_OAMBuffer[$6E].Tile
	ADC.w #$0002
	STA.l SIMC_Global_OAMBuffer[$70].Tile
	ADC.w #$0002
	STA.l SIMC_Global_OAMBuffer[$6F].Tile
CODE_00BD14:
	RTS

CODE_00BD15:
	REP.b #$30
	LDA.w $0C0F
	BEQ.b CODE_00BD1F
	STZ.w $0A93
CODE_00BD1F:
	LDA.w $0A93
	BNE.b CODE_00BD25
	RTS

CODE_00BD25:
	LDA.w $0AE7
	BNE.b CODE_00BD9B
	LDA.w #$0004
	JSR.w CODE_00BF80
	REP.b #$20
	LDA.w #$0002
	LDX.b $D7
	CPX.w #$0001
	BNE.b CODE_00BD3F
	LDA.w #$0004
CODE_00BD3F:
	STA.b $91
	SEP.b #$20
	LDA.l SIMC_Global_OAMBuffer[$7B].XDisp
	SEC
	SBC.b $91
	STA.l SIMC_Global_OAMBuffer[$7B].XDisp
	BCS.b CODE_00BD5A
	LDA.l SIMC_Global_UpperOAMBuffer[$1E].Slot
	ORA.b #$40
	STA.l SIMC_Global_UpperOAMBuffer[$1E].Slot
CODE_00BD5A:
	LDA.l SIMC_Global_OAMBuffer[$7B].YDisp
	CLC
	ADC.b #$06
	STA.l SIMC_Global_OAMBuffer[$7B].YDisp
	REP.b #$20
	LDA.w #$284E
	STA.l SIMC_Global_OAMBuffer[$7B].Tile
	SEP.b #$20
	LDA.l SIMC_Global_UpperOAMBuffer[$1E].Slot
	AND.b #$C0
	CMP.b #$40
	BNE.b CODE_00BD7E
	STZ.w $0AEA
	RTS

CODE_00BD7E:
	BIT.w $0AEA
	BNE.b CODE_00BD9B
	LDA.b #$80
	STA.w $0AEA
	LDA.w $0AE9
	INC
	AND.b #$07
	STA.w $0AE9
	BNE.b CODE_00BD9B
	PHP
	JSL.l CODE_0098A0	: dw $1F03
	PLP
CODE_00BD9B:
	RTS

CODE_00BD9C:
	REP.b #$30
	LDA.w $0A91
	BEQ.b CODE_00BDC7
	LDA.w #$0000
	JSR.w CODE_00BF80
	REP.b #$20
	LDA.w #$3E20
	STA.l SIMC_Global_OAMBuffer[$77].Tile
	LDA.w #$3E22
	STA.l SIMC_Global_OAMBuffer[$78].Tile
	LDA.w #$3E24
	STA.l SIMC_Global_OAMBuffer[$7A].Tile
	LDA.w #$3E26
	STA.l SIMC_Global_OAMBuffer[$79].Tile
CODE_00BDC7:
	RTS

CODE_00BDC8:
	REP.b #$30
	LDA.w $0A8D
	BEQ.b CODE_00BE1B
	LDA.w #$0010
	JSR.w CODE_00BF80
	SEP.b #$30
	LDX.w $0A9F
	LDA.b $D7
	CMP.b #$01
	BNE.b CODE_00BDE6
	CPX.b #$04
	BNE.b CODE_00BDE6
	LDX.b #$03
CODE_00BDE6:
	LDA.w DATA_00BBDB,x
	PHA
	LDA.w DATA_00BBD3,x
	PLX
	XBA
	LDA.b #$08
	REP.b #$20
	ORA.w #$3000
	STA.b $91
	CLC
	ADC.w DATA_00BBB3,x
	STA.l SIMC_Global_OAMBuffer[$71].Tile
	LDA.b $91
	ADC.w DATA_00BBB3+$02,x
	STA.l SIMC_Global_OAMBuffer[$72].Tile
	LDA.b $91
	ADC.w DATA_00BBB3+$04,x
	STA.l SIMC_Global_OAMBuffer[$74].Tile
	LDA.b $91
	ADC.w DATA_00BBB3+$06,x
	STA.l SIMC_Global_OAMBuffer[$73].Tile
CODE_00BE1B:
	RTS

CODE_00BE1C:
	REP.b #$30
	LDA.w $0A8F
	BNE.b CODE_00BE24
	RTS

CODE_00BE24:
	LDA.w #$0004
	STA.b $97
	LDA.w #$01D4
	STA.w $0B33
	LDY.w #$000C
	LDA.w $0A5D
	DEC
	STA.b $91
	LDA.w $0A5B
	DEC
	STA.b $94
	JSR.w CODE_00C019
	SEP.b #$20
	LDA.l SIMC_Global_UpperOAMBuffer[$1D].Slot
	AND.b #$CF
	ORA.b #$10
	STA.l SIMC_Global_UpperOAMBuffer[$1D].Slot
	REP.b #$30
	LDA.w $0A9B
	LSR
	BCS.b CODE_00BE94
	AND.w #$000F
	ASL
	TAX
	LDA.w DATA_00BBFF,x
	CLC
	ADC.b $91
	STA.b $91
	LDA.w DATA_00BC07,x
	CLC
	ADC.b $94
	STA.b $94
	LDA.w #$01D8
	STA.w $0B33
	LDA.w #$0003
	STA.b $97
	JSR.w CODE_00C019
	SEP.b #$20
	LDA.b $D7
	CMP.b #$01
	BNE.b CODE_00BE94
	LDA.w $0A9B
	AND.b #$03
	BNE.b CODE_00BE94
	LDA.l SIMC_Global_OAMBuffer[$75].XDisp
	CLC
	ADC.b #$08
	STA.l SIMC_Global_OAMBuffer[$76].XDisp
CODE_00BE94:
	SEP.b #$30
	LDX.w $0A9B
	LDA.w $0AEB
	AND.b #$03
	CLC
	ADC.w DATA_00BC0F,x
	STA.l SIMC_Global_OAMBuffer[$75].Tile
	LDA.w DATA_00BC1F,x
	STA.l SIMC_Global_OAMBuffer[$75].Prop
	LDA.w $0A9B
	LSR
	BCS.b CODE_00BEC8
	LDA.w $0AEB
	AND.b #$03
	LSR
	CLC
	ADC.w DATA_00BC17,x
	STA.l SIMC_Global_OAMBuffer[$76].Tile
	LDA.w DATA_00BC1F,x
	STA.l SIMC_Global_OAMBuffer[$76].Prop
CODE_00BEC8:
	RTS

CODE_00BEC9:
	REP.b #$30
	LDA.b $40
	CMP.w #$0006
	BEQ.b CODE_00BEE1
	LDA.b $40
	CMP.w #$0007
	BEQ.b CODE_00BEE1
	LDA.w $0A95
	CMP.w #$0001
	BEQ.b CODE_00BEE2
CODE_00BEE1:
	RTS

CODE_00BEE2:
	REP.b #$30
	LDA.w #$0004
	STA.b $91
	JSR.w CODE_00BF4D
	LDA.w #$0014
	JSR.w CODE_00BF80
	REP.b #$30
	LDA.w #$0000
	STA.b $91
	JSR.w CODE_00BF4D
	SEP.b #$30
	LDX.w $0B0C
	BMI.b CODE_00BF4C
	LDX.w $0B0B
	CPX.b #$04
	BNE.b CODE_00BF14
	LDA.b $D7
	CMP.b #$01
	BNE.b CODE_00BF14
	LDX.b #$02
	BRA.b CODE_00BF1A

CODE_00BF14:
	SEP.b #$30
	LDA.w DATA_00BC2F,x
	TAX
CODE_00BF1A:
	LDA.w DATA_00BC2B,x
	STA.b $92
	STZ.b $91
	LDA.w DATA_00BC27,x
	TAX
	REP.b #$20
	LDA.b $91
	CLC
	ADC.w DATA_00BBB3,x
	STA.l SIMC_Global_OAMBuffer[$7C].Tile
	LDA.b $91
	ADC.w DATA_00BBB3+$02,x
	STA.l SIMC_Global_OAMBuffer[$7D].Tile
	LDA.b $91
	ADC.w DATA_00BBB3+$04,x
	STA.l SIMC_Global_OAMBuffer[$7F].Tile
	LDA.b $91
	ADC.w DATA_00BBB3+$06,x
	STA.l SIMC_Global_OAMBuffer[$7E].Tile
CODE_00BF4C:
	RTS

CODE_00BF4D:
	REP.b #$20
	LDA.w $0B13
	CLC
	ADC.b $91
	STA.w $0A65
	AND.w #$0007
	STA.w $0A81
	LSR.w $0A65
	LSR.w $0A65
	LSR.w $0A65
	LDA.w $0B11
	SEC
	SBC.b $91
	STA.w $0A63
	AND.w #$0007
	STA.w $0A7F
	LSR.w $0A63
	LSR.w $0A63
	LSR.w $0A63
	RTS

CODE_00BF80:
	REP.b #$30
	TAX
	LSR
	TAY
	LDA.w DATA_00C00B,y
	STA.w $0B33
	LDA.w #$0004
	CPY.w #$0002
	BNE.b CODE_00BF96
	LDA.w #$8000
CODE_00BF96:
	STA.b $97
	TXY
	LDA.w $0A6D,x
	STA.b $A3
	LDA.w $0A51,x
	CLC
	ADC.w DATA_00BBE3,x
	STA.b $91
	LDA.w $0A6B,x
	STA.b $A6
	LDA.w $0A4F,x
	CLC
	ADC.w DATA_00BBE3+$02,x
	STA.b $94
	JSR.w CODE_00C019
	REP.b #$20
	LDA.b $97
	BPL.b CODE_00BFBF
	RTS

CODE_00BFBF:
	REP.b #$20
	DEC.b $97
	LDA.w $0B33
	CLC
	ADC.w #$0004
	STA.w $0B33
	LDA.b $91
	PHA
	CLC
	ADC.w #$0002
	STA.b $91
	JSR.w CODE_00C019
	REP.b #$20
	DEC.b $97
	LDA.w $0B33
	CLC
	ADC.w #$0004
	STA.w $0B33
	LDA.b $94
	CLC
	ADC.w #$0002
	STA.b $94
	PHA
	JSR.w CODE_00C019
	REP.b #$30
	DEC.b $97
	PLA
	STA.b $94
	PLA
	STA.b $91
	LDA.w $0B33
	CLC
	ADC.w #$0004
	STA.w $0B33
	JSR.w CODE_00C019
	RTS

DATA_00C00B:
	dw $01DC,$01EC,$01B4,$01D4,$01C4,$01F0,$01F0

CODE_00C019:
	REP.b #$30
	STZ.b $A0
	LDA.b $D7
	CMP.w #$0001
	BNE.b CODE_00C03B
	LDA.b $91
	SEC
	SBC.w $01BD
	CMP.w #$0005
	BCC.b CODE_00C09C
	BEQ.b CODE_00C09C
	CMP.w #$001E
	BCS.b CODE_00C09C
	JSR.w CODE_00C1B5
	BRA.b CODE_00C059

CODE_00C03B:
	LDA.b $91
	CLC
	ADC.w #$0002
	SEC
	SBC.w $01BD
	BMI.b CODE_00C09C
	SEC
	SBC.w #$0002
	BCS.b CODE_00C051
	INC.b $A0
	BRA.b CODE_00C056

CODE_00C051:
	CMP.w #$0020
	BCS.b CODE_00C09C
CODE_00C056:
	JSR.w CODE_00C1A0
CODE_00C059:
	REP.b #$20
	LDA.b $D7
	CMP.w #$0001
	BNE.b CODE_00C077
	LDA.b $94
	SEC
	SBC.w $01BF
	CMP.w #$0004
	BCC.b CODE_00C09C
	BEQ.b CODE_00C09C
	CMP.w #$001B
	BCS.b CODE_00C09C
	DEC
	BRA.b CODE_00C08C

CODE_00C077:
	LDA.b $94
	SEC
	SBC.w $01BF
	BPL.b CODE_00C086
	CMP.w #$FFFE
	BCC.b CODE_00C09C
	BRA.b CODE_00C08B

CODE_00C086:
	CMP.w #$001D
	BCS.b CODE_00C09C
CODE_00C08B:
	DEC
CODE_00C08C:
	REP.b #$10
	LDX.w $0B33
	INX
	DEY
	DEY
	JSR.w CODE_00C1A5
	INY
	INY
	JMP.w CODE_00C09D

CODE_00C09C:
	RTS

CODE_00C09D:
	REP.b #$30
	LDA.w $0B33
	CMP.w #$01D8
	BNE.b CODE_00C0B3
	SEP.b #$20
	LDA.b #$CF
	STA.b $9A
	LDA.b #$00
	STA.b $9D
	BRA.b CODE_00C0C9

CODE_00C0B3:
	REP.b #$20
	AND.w #$00FF
	LSR
	AND.w #$0007
	TAX
	SEP.b #$20
	LDA.w DATA_00BC37,x
	STA.b $9A
	LDA.w DATA_00BC37+$01,x
	STA.b $9D
CODE_00C0C9:
	REP.b #$20
	LDA.w $0B33
	LSR
	LSR
	LSR
	LSR
	TAX
	SEP.b #$20
	LDA.l SIMC_Global_UpperOAMBuffer[$00].Slot,x
	AND.b $9A
	ORA.b $9D
	STA.l SIMC_Global_UpperOAMBuffer[$00].Slot,x
	LDA.b $A0
	BEQ.b CODE_00C0F4
	LDA.b $9D
	BNE.b CODE_00C0EB
	LDA.b #$20
CODE_00C0EB:
	LSR
	ORA.l SIMC_Global_UpperOAMBuffer[$00].Slot,x
	STA.l SIMC_Global_UpperOAMBuffer[$00].Slot,x
CODE_00C0F4:
	RTS

CODE_00C0F5:
	SEP.b #$20
	REP.b #$10
	LDA.b #$E0
	STA.l SIMC_Global_OAMBuffer[$6D].YDisp
	STA.l SIMC_Global_OAMBuffer[$6E].YDisp
	STA.l SIMC_Global_OAMBuffer[$6F].YDisp
	STA.l SIMC_Global_OAMBuffer[$70].YDisp
	STA.l SIMC_Global_OAMBuffer[$75].YDisp
	STA.l SIMC_Global_OAMBuffer[$76].YDisp
	STA.l SIMC_Global_OAMBuffer[$77].YDisp
	STA.l SIMC_Global_OAMBuffer[$78].YDisp
	STA.l SIMC_Global_OAMBuffer[$79].YDisp
	STA.l SIMC_Global_OAMBuffer[$7A].YDisp
	STA.l SIMC_Global_OAMBuffer[$7B].YDisp
	SEP.b #$20
	LDA.l SIMC_Global_UpperOAMBuffer[$1B].Slot
	AND.b #$03
	ORA.b #$54
	STA.l SIMC_Global_UpperOAMBuffer[$1B].Slot
	LDA.l SIMC_Global_UpperOAMBuffer[$1C].Slot
	AND.b #$FC
	ORA.b #$01
	STA.l SIMC_Global_UpperOAMBuffer[$1C].Slot
	LDA.l SIMC_Global_UpperOAMBuffer[$1D].Slot
	AND.b #$03
	ORA.b #$54
	STA.l SIMC_Global_UpperOAMBuffer[$1D].Slot
	LDA.b #$55
	STA.l SIMC_Global_UpperOAMBuffer[$1E].Slot
	RTS

CODE_00C154:
	SEP.b #$20
	LDA.b #$E0
	STA.l SIMC_Global_OAMBuffer[$71].YDisp
	STA.l SIMC_Global_OAMBuffer[$72].YDisp
	STA.l SIMC_Global_OAMBuffer[$73].YDisp
	STA.l SIMC_Global_OAMBuffer[$74].YDisp
	LDA.l SIMC_Global_UpperOAMBuffer[$1C].Slot
	AND.b #$03
	ORA.b #$54
	STA.l SIMC_Global_UpperOAMBuffer[$1C].Slot
	LDA.l SIMC_Global_UpperOAMBuffer[$1D].Slot
	AND.b #$FC
	ORA.b #$01
	STA.l SIMC_Global_UpperOAMBuffer[$1D].Slot
CODE_00C180:
	SEP.b #$20
	LDA.w $0B03
	BNE.b CODE_00C19F
	LDA.b #$E0
	STA.l SIMC_Global_OAMBuffer[$7C].YDisp
	STA.l SIMC_Global_OAMBuffer[$7D].YDisp
	STA.l SIMC_Global_OAMBuffer[$7E].YDisp
	STA.l SIMC_Global_OAMBuffer[$7F].YDisp
	LDA.b #$55
	STA.l SIMC_Global_UpperOAMBuffer[$1F].Slot
CODE_00C19F:
	RTS

CODE_00C1A0:
	REP.b #$10
	LDX.w $0B33
CODE_00C1A5:
	REP.b #$30
	ASL
	ASL
	ASL
	CLC
	ADC.w $0A6D,y
	SEP.b #$20
	STA.l SIMC_Global_OAMBuffer[$00].XDisp,x
	RTS

CODE_00C1B5:
	REP.b #$30
	LDA.b $94
	SEC
	SBC.w $01BF
	SEC
	SBC.w #$0006
	ASL
	ASL
	ASL
	CLC
	ADC.w $0A6B,y
	LSR
	LSR
	STA.b $9A
	LDX.b $97
	CPX.w #$0003
	BCS.b CODE_00C1D9
	SEC
	SBC.w #$0004
	STA.b $9A
CODE_00C1D9:
	LDA.b $91
	SEC
	SBC.w $01BD
	DEC
	ASL
	ASL
	ASL
	CLC
	ADC.w $0A6D,y
	SEC
	SBC.b $9A
	STA.b $9D
	SEP.b #$20
	REP.b #$10
	LDA.b $9D
	LDX.w $0B33
	STA.l SIMC_Global_OAMBuffer[$00].XDisp,x
	RTS

CODE_00C1FA:
	REP.b #$20
	LDA.w $0C0F
	BNE.b CODE_00C22A
	LDA.b $E3
	BNE.b CODE_00C22A
	LDA.w $01F7
	BNE.b CODE_00C22A
	LDA.w $0AF1
	BNE.b CODE_00C228
	LDA.b $D7
	CMP.w #$0001
	BEQ.b CODE_00C220
	LDA.w $011B
	AND.w #$4080
	BNE.b CODE_00C22A
	BRA.b CODE_00C228

CODE_00C220:
	LDA.w $011B
	AND.w #$0F00
	BNE.b CODE_00C22A
CODE_00C228:
	SEC
	RTS

CODE_00C22A:
	CLC
	RTS

CODE_00C22C:
	JSR.w CODE_00C230
	RTL

CODE_00C230:
	SEP.b #$10
	REP.b #$20
	TXA
	AND.w #$00FF
	STA.b $79
	TXA
	AND.w #$FFFE
	CLC
	ADC.w #$01B4
	AND.w #$00FF
	LSR
	AND.w #$0007
	TAX
	SEP.b #$20
	LDA.w DATA_00BC37,x
	STA.b $82
	LDA.w DATA_00BC37+$01,x
	LSR
	STA.b $85
	REP.b #$20
	LDA.b $79
	CLC
	ADC.w #$01B4
	LSR
	LSR
	LSR
	LSR
	TAX
	SEP.b #$20
	LDA.l SIMC_Global_UpperOAMBuffer[$00].Slot,x
	AND.b $82
	ORA.b $85
	STA.l SIMC_Global_UpperOAMBuffer[$00].Slot,x
	LDX.b $79
	RTS

DATA_00C275:
	dw $0000,$0002,$0003,$0003,$0003,$0003,$0003,$0002
	dw $0000,$FFFE,$FFFD,$FFFD,$FFFD,$FFFD,$FFFD,$FFFE
	dw $FFFD,$FFFD,$FFFD,$FFFE,$0000,$0002,$0003,$0003
	dw $0003,$0003,$0003,$0002,$0000,$FFFE,$FFFD,$FFFD

DATA_00C2B5:
	dw DATA_05A000+$0000,DATA_05A000+$0200,DATA_05A000+$0400,DATA_05A000+$0600,DATA_05A000+$0800,DATA_05A000+$0A00,DATA_05A000+$0C00,DATA_05A000+$0E00

DATA_00C2C5:
	dw $0000,$FFB4,$FF8E,$FF82,$FF82,$FF82,$FF8E,$FFB4
	dw $0000,$004C,$0072,$007E,$007E,$007E,$0072,$004C

DATA_00C2E5:
	dw $0072,$0072,$0072,$0054,$0000,$FFAC,$FF8E,$FF8E
	dw $FF8E,$FF8E,$FF8E,$FFAC,$0000,$0054,$0072,$0072

DATA_00C305:
	incbin "Palettes/DATA_00C305.bin"

DATA_00C385:
	db $FF,$00,$00,$FF,$00,$01,$01,$00,$80

DATA_00C38E:
	db $FE,$00,$00,$FE,$00,$02,$02,$00,$80

DATA_00C397:
	db $FE,$01,$FF,$02,$01,$02,$02,$01,$80

DATA_00C3A0:
	db $FE,$FF,$FF,$FE,$01,$FE,$02,$FF,$80

DATA_00C3A9:
	dw $0100,$0100,$0001,$0100,$0100,$0001,$0100,$0001
	dw $0001,$0100,$0001,$0001,$FF00,$0001,$0001,$FF00
	dw $0001,$FF00,$FF00,$0001,$FF00,$FF00,$00FF,$FF00
	dw $FF00,$00FF,$FF00,$00FF,$00FF,$FF00,$00FF,$00FF
	dw $0100,$00FF,$00FF,$0100,$00FF,$0100,$0100,$00FF

CODE_00C3F9:
	REP.b #$30
	LDA.b $40
	CMP.w #$0006
	BNE.b CODE_00C411
	LDA.w $0AF1
	BEQ.b CODE_00C411
	LDA.w $0AEF
	BEQ.b CODE_00C411
	LDA.w $0AB5
	BEQ.b CODE_00C412
CODE_00C411:
	RTS

CODE_00C412:
	REP.b #$20
	LDA.w $0AF5
	REP.b #$10
	ASL
	TAX
	JSR.w (DATA_00C42E,x)
	REP.b #$20
	LDA.w $0AEF
	BEQ.b CODE_00C42D
	LDA.w $0B03
	BEQ.b CODE_00C42D
	JSR.w CODE_00C713
CODE_00C42D:
	RTS

DATA_00C42E:
	dw CODE_00C440
	dw CODE_00C478
	dw CODE_00C624
	dw CODE_00C4EC
	dw CODE_00C515
	dw CODE_00C550
	dw CODE_00C58B
	dw CODE_00C5C6
	dw CODE_00C66C

CODE_00C440:
	SEP.b #$20
	STZ.w $0B03
	STZ.w $0B04
	LDA.w $0195
	STA.w $0AEF
	AND.b #$FB
	ORA.b #$04
	STA.w $0195
	LDA.w $0AF9
	STA.w $0400
	LDA.w $0AF7
	STA.w $0402
	LDA.b #$FF
	STA.w $03FE
	INC.w $0AF5
	REP.b #$20
	LDA.w #$00E0
	ASL
	ASL
	ASL
	STA.w $0AFB
	JSR.w CODE_00C798
	RTS

CODE_00C478:
	SEP.b #$20
	LDA.w $03FE
	BNE.b CODE_00C4BF
	LDA.w $0AEF
	STA.w $0195
	STZ.w $0AEF
	INC.w $0AF5
	JSR.w CODE_00824F
	SEP.b #$10
	REP.b #$20
	AND.w #$000F
	CMP.w #$0003
	BEQ.b CODE_00C49F
	CMP.w #$0009
	BNE.b CODE_00C4A0
CODE_00C49F:
	INC
CODE_00C4A0:
	STA.w $0AFF
	ASL
	TAX
	LDA.w $0AF9
	ASL
	ASL
	ASL
	CLC
	ADC.w DATA_00C2C5,x
	STA.w $0AFD
	LDA.w $0AF7
	ASL
	ASL
	ASL
	CLC
	ADC.w DATA_00C2E5,x
	STA.w $0AFB
CODE_00C4BF:
	RTS

CODE_00C4C0:
	SEP.b #$30
	LDA.w $0AF3
	ASL
	TAX
	LDA.w DATA_00C3A9,x
	CLC
	ADC.w $0AFB
	STA.w $0AFB
	LDA.w DATA_00C3A9+$01,x
	CLC
	ADC.w $0AFD
	STA.w $0AFD
	JSR.w CODE_00C6E6
	SEP.b #$30
	LDA.w $0AF3
	INC
	CMP.b #$28
	BCS.b CODE_00C4EB
	STA.w $0AF3
CODE_00C4EB:
	RTS

CODE_00C4EC:
	JSR.w CODE_00C4C0
	BCC.b CODE_00C514
	SEP.b #$20
	REP.b #$10
	INC.w $0AF5
	STZ.w $0AF3
	LDA.w $0AF7
	XBA
	LDA.w $0AF9
	LDY.w #$0001
	JSL.l CODE_03A9C2
	REP.b #$10
	LDX.w #$0018
	LDY.w #$0001
	JSR.w CODE_00AE2E
CODE_00C514:
	RTS

CODE_00C515:
	SEP.b #$20
	REP.b #$10
	JSR.w CODE_00C4C0
	BCC.b CODE_00C54F
	SEP.b #$20
	REP.b #$10
	INC.w $0AF5
	STZ.w $0AF3
	LDX.w #$0000
CODE_00C52B:
	LDA.w DATA_00C385,x
	CMP.b #$80
	BEQ.b CODE_00C54F
	CLC
	ADC.w $0AF7
	XBA
	LDA.w $0AF9
	CLC
	ADC.w DATA_00C385+$01,x
	LDY.w #$0001
	PHX
	JSL.l CODE_03A9C2
	SEP.b #$20
	REP.b #$10
	PLX
	INX
	INX
	BRA.b CODE_00C52B

CODE_00C54F:
	RTS

CODE_00C550:
	SEP.b #$20
	REP.b #$10
	JSR.w CODE_00C4C0
	BCC.b CODE_00C58A
	SEP.b #$20
	REP.b #$10
	INC.w $0AF5
	STZ.w $0AF3
	LDX.w #$0000
CODE_00C566:
	LDA.w DATA_00C38E,x
	CMP.b #$80
	BEQ.b CODE_00C58A
	CLC
	ADC.w $0AF7
	XBA
	LDA.w $0AF9
	CLC
	ADC.w DATA_00C38E+$01,x
	LDY.w #$0001
	PHX
	JSL.l CODE_03A9C2
	SEP.b #$20
	REP.b #$10
	PLX
	INX
	INX
	BRA.b CODE_00C566

CODE_00C58A:
	RTS

CODE_00C58B:
	SEP.b #$20
	REP.b #$10
	JSR.w CODE_00C4C0
	BCC.b CODE_00C5C5
	SEP.b #$20
	REP.b #$10
	INC.w $0AF5
	STZ.w $0AF3
	LDX.w #$0000
CODE_00C5A1:
	LDA.w DATA_00C397,x
	CMP.b #$80
	BEQ.b CODE_00C5C5
	CLC
	ADC.w $0AF7
	XBA
	LDA.w $0AF9
	CLC
	ADC.w DATA_00C397+$01,x
	LDY.w #$0001
	PHX
	JSL.l CODE_03A9C2
	SEP.b #$20
	REP.b #$10
	PLX
	INX
	INX
	BRA.b CODE_00C5A1

CODE_00C5C5:
	RTS

CODE_00C5C6:
	SEP.b #$20
	REP.b #$10
	JSR.w CODE_00C4C0
	BCS.b CODE_00C5DA
	SEP.b #$20
	LDA.w $0AF3
	CMP.b #$23
	BNE.b CODE_00C623
	BEQ.b CODE_00C60D
CODE_00C5DA:
	SEP.b #$20
	REP.b #$10
	INC.w $0AF5
	LDA.b #$30
	STA.w $0AF3
	LDX.w #$0000
CODE_00C5E9:
	LDA.w DATA_00C3A0,x
	CMP.b #$80
	BEQ.b CODE_00C623
	CLC
	ADC.w $0AF7
	XBA
	LDA.w $0AF9
	CLC
	ADC.w DATA_00C3A0+$01,x
	LDY.w #$0001
	PHX
	JSL.l CODE_03A9C2
	SEP.b #$20
	REP.b #$10
	PLX
	INX
	INX
	BRA.b CODE_00C5E9

CODE_00C60D:
	JSR.w CODE_00824F
	SEP.b #$30
	AND.b #$0F
	TAX
	CLC
	ADC.b #$08
	AND.b #$0F
	CMP.w $0AFF
	BNE.b CODE_00C620
	TAX
CODE_00C620:
	STX.w $0AFF
CODE_00C623:
	RTS

CODE_00C624:
	REP.b #$30
	LDA.w #$FFFF
	STA.w $0B03
	LDA.w $0AFF
	ASL
	AND.w #$00FF
	TAY
	LDX.w #$0002
	JSR.w CODE_00C6D7
	REP.b #$30
	TYA
	CLC
	ADC.w #$0020
	TAY
	LDX.w #$0000
	JSR.w CODE_00C6D7
	JSR.w CODE_00C6E6
	SEP.b #$20
	LDA.w $0A67
	CMP.w $0AF7
	BNE.b CODE_00C66B
	LDA.w $0A69
	CMP.w $0AF9
	BNE.b CODE_00C66B
	INC.w $0AF5
	STZ.w $0AF3
	PHP
	JSL.l CODE_0098A0	: dw $1C03
	PLP
CODE_00C66B:
	RTS

CODE_00C66C:
	SEP.b #$20
	DEC.w $0AF3
	BNE.b CODE_00C676
	JMP.w CODE_00C6C9

CODE_00C676:
	REP.b #$30
	LDA.w $0AFF
	CLC
	ADC.w #$0008
	AND.w #$000F
	ASL
	TAY
	LDX.w #$0002
	JSR.w CODE_00C6D7
	REP.b #$30
	TYA
	CLC
	ADC.w #$0020
	TAY
	LDX.w #$0000
	JSR.w CODE_00C6D7
	JSR.w CODE_00C6E6
	SEP.b #$20
	LDA.w $0A67
	SEC
	SBC.w $01BF
	BMI.b CODE_00C6AD
	CMP.b #$20
	BCC.b CODE_00C6B4
	JMP.w CODE_00C6C9

CODE_00C6AD:
	CMP.b #$FD
	BCS.b CODE_00C6B4
	JMP.w CODE_00C6C9

CODE_00C6B4:
	LDA.w $0A69
	SEC
	SBC.w $01BD
	BMI.b CODE_00C6C4
	CMP.b #$22
	BCC.b CODE_00C6C8
	JMP.w CODE_00C6C9

CODE_00C6C4:
	CMP.b #$FC
	BCC.b CODE_00C6C9
CODE_00C6C8:
	RTS

CODE_00C6C9:
	REP.b #$20
	LDA.w #$0000
	STA.w $0AEF
	STA.w $0B03
	JMP.w CODE_00C180

CODE_00C6D7:
	SEP.b #$10
	REP.b #$20
	LDA.w $0AFB,x
	CLC
	ADC.w DATA_00C275,y
	STA.w $0AFB,x
	RTS

CODE_00C6E6:
	REP.b #$20
	LDA.w $0AFB
	AND.w #$0007
	STA.w $0A83
	LDA.w $0AFB
	LSR
	LSR
	LSR
	AND.w #$00FF
	STA.w $0A67
	LDA.w $0AFD
	AND.w #$0007
	STA.w $0A85
	LDA.w $0AFD
	LSR
	LSR
	LSR
	AND.w #$00FF
	STA.w $0A69
	RTS

CODE_00C713:
	SEP.b #$20
	LDA.w $0AF5
	CMP.b #$02
	BCC.b CODE_00C71F
	INC.w $0AEF
CODE_00C71F:
	REP.b #$30
	LDA.w #$0018
	JSR.w CODE_00BF80
	REP.b #$30
	LDA.w #$3A00
	STA.l SIMC_Global_OAMBuffer[$7C].Tile
	INC
	INC
	STA.l SIMC_Global_OAMBuffer[$7D].Tile
	INC
	INC
	STA.l SIMC_Global_OAMBuffer[$7F].Tile
	INC
	INC
	STA.l SIMC_Global_OAMBuffer[$7E].Tile
	JSR.w CODE_00C798
	LDA.w $0AF5
	CMP.w #$0003
	BCC.b CODE_00C761
	CMP.w #$0008
	BCS.b CODE_00C761
	LDA.w $0AEF
	AND.w #$000C
	LSR
	LSR
	CLC
	ADC.w #$0004
	JMP.w CODE_00C76B

CODE_00C761:
	REP.b #$30
	LDA.w $0AEF
	AND.w #$000C
	LSR
	LSR
CODE_00C76B:
	ASL
	TAX
	LDA.w DATA_00C2B5,x
	TAX
	PHB
	LDY.w #$7E7000
	LDA.w #$007F
	MVN $7E7000>>16,DATA_05A000>>16
	LDY.w #$7E7200
	LDA.w #$007F
	MVN $7E7200>>16,DATA_05A000>>16
	LDY.w #$7E7080
	LDA.w #$007F
	MVN $7E7080>>16,DATA_05A000>>16
	LDY.w #$7E7280
	LDA.w #$007F
	MVN $7E7280>>16,DATA_05A000>>16
	PLB
	RTS

CODE_00C798:
	REP.b #$30
	LDA.w $0AEF
	AND.w #$000C
	LSR
	LSR
	LDX.w $0AF5
	CPX.w #$0003
	BCC.b CODE_00C7B3
	CPX.w #$0008
	BCS.b CODE_00C7B3
	CLC
	ADC.w #$0004
CODE_00C7B3:
	ASL
	ASL
	ASL
	ASL
	TAY
	LDX.w #$0000
	LDA.w #$0008
	STA.b $91
CODE_00C7C0:
	LDA.w DATA_00C305,y
	STA.l SIMC_Global_PaletteMirror[$D8].LowByte,x
	INX
	INX
	INY
	INY
	DEC.b $91
	BNE.b CODE_00C7C0
	LDA.b $BB
	ORA.w #$0002
	STA.b $BB
	JSR.w CODE_008DA6
	RTS

CODE_00C7DA:
	JSR.w CODE_00CAA1
	JSR.w CODE_00CAE0
	REP.b #$30
	LDA.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$1AA0
	LDX.w #$000B
	JSR.w CODE_00CB12
	JSR.w CODE_00CB44
	JSR.w CODE_00CB6C
	JSR.w CODE_00CDF4
	JSR.w CODE_00CFB8
	JSR.w CODE_00D0F0
CODE_00C7FA:
	JSR.w CODE_00D199
	BEQ.b CODE_00C813
	JSR.w CODE_00D215
	BCC.b CODE_00C82D
	JSR.w CODE_00D276
	REP.b #$30
	PHP
	JSL.l CODE_0098A0	: dw $0202
	PLP
	BRA.b CODE_00C7FA

CODE_00C813:
	LDA.w #$002C
	STA.w $01EB
	LDA.w #$004C
	STA.w $01ED
	LDA.w #$4C2C
	STA.l SIMC_Global_OAMBuffer[$00].XDisp
	JSR.w CODE_00D008
	JSR.w CODE_00D170
	RTL

CODE_00C82D:
	LDA.w $0421
	BEQ.b CODE_00C813
	PHP
	JSL.l CODE_0098A0	: dw $0102
	PLP
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	JSL.l CODE_03C89D
	REP.b #$20
	LDA.w #$0004
	COP.b #$00
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	JSR.w CODE_00825F
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	REP.b #$20
	JSL.l CODE_01A026
	JSL.l CODE_01B13F
	SEP.b #$30
	LDA.b #$FF
	STA.w $0B4B
	STA.w $0B4F
	STZ.w $0B50
	LDX.w !RAM_SIMC_City_CurrentMonthLo
	DEX
	LDA.w DATA_00C8CE,x
	STA.w $0B4D
	JSR.w CODE_0094D9
	REP.b #$20
	LDA.w #$002C
	STA.w $01EB
	LDA.w #$004C
	STA.w $01ED
	LDA.w #$4C2C
	STA.l SIMC_Global_OAMBuffer[$00].XDisp
	JSR.w CODE_00D008
	JSR.w CODE_00D170
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	PHP
	JSL.l CODE_0098A0	: dw $1703
	PLP
	SEP.b #$20
	LDA.w $0195
	AND.b #$08
	BEQ.b CODE_00C8C2
	LDA.b #$02
	STA.b $04
	JSL.l CODE_01B3E3
	BRA.b CODE_00C8C6

CODE_00C8C2:
	LDA.b #$01
	STA.b $04
CODE_00C8C6:
	REP.b #$20
	LDA.w #$0003
	COP.b #$00
	RTL

DATA_00C8CE:
	db $03,$03,$00,$00,$00,$01,$01,$01,$02,$02,$02,$03

CODE_00C8DA:
	JSR.w CODE_00CAA1
	JSR.w CODE_00CAE0
	REP.b #$30
	LDA.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$1900
	LDX.w #$000C
	JSR.w CODE_00CB12
	JSR.w CODE_00CB44
	JSR.w CODE_00CB6C
	JSR.w CODE_00CDF4
	JSR.w CODE_00CFB8
	JSR.w CODE_00D0F0
	JSR.w CODE_00D199
	REP.b #$20
	BEQ.b CODE_00C914
	PHA
	PHP
	JSL.l CODE_0098A0	: dw $0102
	PLP
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	PLA
CODE_00C914:
	REP.b #$20
	STA.w $0423
	BEQ.b CODE_00C927
	JSR.w CODE_00CBEE
	JSR.w CODE_00CDF4
	JSL.l CODE_03CAF9
	REP.b #$20
CODE_00C927:
	LDA.w #$0044
	STA.w $01EB
	LDA.w #$004C
	STA.w $01ED
	LDA.w #$4C44
	STA.l SIMC_Global_OAMBuffer[$00].XDisp
	JSR.w CODE_00D008
	JSR.w CODE_00D170
	RTL

CODE_00C941:
	JSR.w CODE_00CAA1
	JSR.w CODE_00CAE0
	REP.b #$30
	LDA.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$2360
	LDX.w #$0005
	JSR.w CODE_00CB12
	JSR.w CODE_00CB44
	JSR.w CODE_00CBCB
	JSR.w CODE_00CDF4
	JSR.w CODE_00CFB8
	JSR.w CODE_00D0F7
	JSR.w CODE_00D199
	REP.b #$20
	BEQ.b CODE_00C97B
	PHA
	PHP
	JSL.l CODE_0098A0	: dw $0102
	PLP
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	PLA
CODE_00C97B:
	REP.b #$20
	STA.w $0423
	BEQ.b CODE_00C9D4
	CMP.w #$0002
	BEQ.b CODE_00C9CC
	REP.b #$30
	LDA.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$1900
	LDX.w #$000C
	JSR.w CODE_00CB12
	JSR.w CODE_00CB6C
	JSR.w CODE_00CDF4
	JSR.w CODE_00D0F0
	JSR.w CODE_00D199
	REP.b #$20
	BEQ.b CODE_00C9B5
	PHA
	PHP
	JSL.l CODE_0098A0	: dw $0102
	PLP
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	PLA
CODE_00C9B5:
	REP.b #$20
	STA.w $0423
	BEQ.b CODE_00C941
	JSR.w CODE_00CBEE
	JSR.w CODE_00CDF4
	JSL.l CODE_03CAF9
	REP.b #$20
	LDA.b $48
	BNE.b CODE_00C9D4
CODE_00C9CC:
	JSR.w CODE_00D008
	JSR.w CODE_00D170
	CLC
	RTL

CODE_00C9D4:
	LDA.w #$0074
	STA.w $01EB
	LDA.w #$004C
	STA.w $01ED
	LDA.w #$4C74
	STA.l SIMC_Global_OAMBuffer[$00].XDisp
	JSR.w CODE_00D008
	JSR.w CODE_00D170
	SEC
	RTL

CODE_00C9EF:
	JSR.w CODE_00CAA1
	JSR.w CODE_00CAE0
	REP.b #$30
	LDA.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$2360
	LDX.w #$0005
	JSR.w CODE_00CB12
	JSR.w CODE_00CB44
	JSR.w CODE_00CBCB
	JSR.w CODE_00CDF4
	JSR.w CODE_00CFB8
	JSR.w CODE_00D0F7
	JSR.w CODE_00D199
	REP.b #$20
	BEQ.b CODE_00CA29
	PHA
	PHP
	JSL.l CODE_0098A0	: dw $0102
	PLP
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	PLA
CODE_00CA29:
	REP.b #$20
	STA.w $0423
	BEQ.b CODE_00CA82
	CMP.w #$0002
	BEQ.b CODE_00CA7A
	REP.b #$30
	LDA.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$1900
	LDX.w #$000C
	JSR.w CODE_00CB12
	JSR.w CODE_00CB6C
	JSR.w CODE_00CDF4
	JSR.w CODE_00D0F0
	JSR.w CODE_00D199
	REP.b #$20
	BEQ.b CODE_00CA63
	PHA
	PHP
	JSL.l CODE_0098A0	: dw $0102
	PLP
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	PLA
CODE_00CA63:
	REP.b #$20
	STA.w $0423
	BEQ.b CODE_00C9EF
	JSR.w CODE_00CBEE
	JSR.w CODE_00CDF4
	JSL.l CODE_03CAF9
	REP.b #$20
	LDA.b $48
	BNE.b CODE_00CA82
CODE_00CA7A:
	JSR.w CODE_00D008
	JSR.w CODE_00D170
	CLC
	RTL

CODE_00CA82:
	LDA.w #$005C
	STA.w $01EB
	LDA.w #$004C
	STA.w $01ED
	LDA.w #$4C5C
	STA.l SIMC_Global_OAMBuffer[$00].XDisp
	JSR.w CODE_00D008
	JSR.w CODE_00D170
	SEC
	RTL

CODE_00CA9D:
	JSR.w CODE_00CAA1
	RTL

CODE_00CAA1:
	REP.b #$30
	LDX.w #$09FE
	LDA.w #$0000
CODE_00CAA9:
	STA.l !RAM_SIMC_Global_GeneralPurposeBuffer,x
	DEX
	DEX
	BPL.b CODE_00CAA9
	RTS

CODE_00CAB2:
	REP.b #$30
	LDX.w $0417
	LDY.w #$0050
	LDA.w #$0000
CODE_00CABD:
	STA.l !RAM_SIMC_Global_GeneralPurposeBuffer,x
	INX
	INX
	DEY
	BNE.b CODE_00CABD
	RTS

CODE_00CAC7:
	REP.b #$30
	LDX.w $0419
	LDY.w #$0050
	LDA.w #$0000
CODE_00CAD2:
	STA.l !RAM_SIMC_Global_GeneralPurposeBuffer,x
	INX
	INX
	DEY
	BNE.b CODE_00CAD2
	RTS

CODE_00CADC:
	JSR.w CODE_00CAE0
	RTL

CODE_00CAE0:
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0B86F7
	STX.b $09
	LDA.b #DATA_0B86F7>>16
	STA.b $0B
	LDX.w #$1000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	RTS

DATA_00CAFA:
	dw !RAM_SIMC_Global_GeneralPurposeBuffer+$00A0,!RAM_SIMC_Global_GeneralPurposeBuffer+$00C0,!RAM_SIMC_Global_GeneralPurposeBuffer+$00E0,!RAM_SIMC_Global_GeneralPurposeBuffer+$01A0
	dw !RAM_SIMC_Global_GeneralPurposeBuffer+$01C0,!RAM_SIMC_Global_GeneralPurposeBuffer+$01E0,!RAM_SIMC_Global_GeneralPurposeBuffer+$03A0,!RAM_SIMC_Global_GeneralPurposeBuffer+$03C0
	dw !RAM_SIMC_Global_GeneralPurposeBuffer+$03E0,!RAM_SIMC_Global_GeneralPurposeBuffer+$05A0,!RAM_SIMC_Global_GeneralPurposeBuffer+$05C0,!RAM_SIMC_Global_GeneralPurposeBuffer+$05E0

CODE_00CB12:
	REP.b #$30
	STX.b $79
	STZ.b $7C
CODE_00CB18:
	PHA
	LDA.b $7C
	ASL
	TAX
	LDA.w DATA_00CAFA,x
	TAY
	PLX
	LDA.w #$001F
	PHB
	MVN (!RAM_SIMC_Global_GeneralPurposeBuffer+$00A0)>>16,(!RAM_SIMC_Global_GeneralPurposeBuffer+$1900)>>16
	PLB
	TXA
	INC.b $7C
	DEC.b $79
	BNE.b CODE_00CB18
	RTS

DATA_00CB32:
	dw !RAM_SIMC_Global_GeneralPurposeBuffer+$0900,!RAM_SIMC_Global_GeneralPurposeBuffer+$0920,!RAM_SIMC_Global_GeneralPurposeBuffer+$0940,!RAM_SIMC_Global_GeneralPurposeBuffer+$0780
	dw !RAM_SIMC_Global_GeneralPurposeBuffer+$07A0,!RAM_SIMC_Global_GeneralPurposeBuffer+$07C0,!RAM_SIMC_Global_GeneralPurposeBuffer+$0980,!RAM_SIMC_Global_GeneralPurposeBuffer+$09A0
	dw !RAM_SIMC_Global_GeneralPurposeBuffer+$09C0

CODE_00CB44:
	REP.b #$30
	LDA.w #$0009
	STA.b $79
	STZ.b $7C
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$16C0
CODE_00CB50:
	PHX
	LDA.b $7C
	ASL
	TAX
	LDA.w DATA_00CB32,x
	TAY
	PLX
	LDA.w #$001F
	MVN (!RAM_SIMC_Global_GeneralPurposeBuffer+$0900)>>16,(!RAM_SIMC_Global_GeneralPurposeBuffer+$16C0)>>16
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	INC.b $7C
	DEC.b $79
	BNE.b CODE_00CB50
	RTS

CODE_00CB6C:
	REP.b #$30
	LDA.w #$0B6B
	STA.w $040C
	LDA.w $0B65
	STA.w $040E
	LDA.w $0B67
	STA.w $0410
	LDA.w $0B69
	STA.w $0413
	LDA.w #$8200
	STA.w $0415
	LDA.w #$0000
	STA.w $0417
	LDA.w #$0100
	STA.w $0419
	JSR.w CODE_00CC5E
	REP.b #$30
	LDA.w #$0B7B
	STA.w $040C
	LDA.w $0B75
	STA.w $040E
	LDA.w $0B77
	STA.w $0410
	LDA.w $0B79
	STA.w $0413
	LDA.w #$8280
	STA.w $0415
	LDA.w #$0300
	STA.w $0417
	LDA.w #$0500
	STA.w $0419
	JSR.w CODE_00CC5E
	RTS

CODE_00CBCB:
	REP.b #$30
	LDA.w #$0006
	STA.w $040E
	LDA.w #$8200
	STA.w $0415
	JSR.w CODE_00CC8C
	REP.b #$30
	LDA.w #$0007
	STA.w $040E
	LDA.w #$8280
	STA.w $0415
	JSR.w CODE_00CC8C
	RTS

CODE_00CBEE:
	REP.b #$30
	LDA.w $0423
	DEC
	BNE.b CODE_00CC2A
	LDA.w #$0B5B
	STA.w $040C
	LDA.w !RAM_SIMC_City_CityCategory
	STA.w $040E
	LDA.w !RAM_SIMC_City_CurrentYearLo
	STA.w $0410
	LDA.w !RAM_SIMC_City_CurrentMonthLo
	STA.w $0413
	LDA.w #$8200
	STA.w $0415
	LDA.w #$0000
	STA.w $0417
	LDA.w #$0100
	STA.w $0419
	JSR.w CODE_00CAB2
	JSR.w CODE_00CAC7
	JSR.w CODE_00CC5E
	RTS

CODE_00CC2A:
	LDA.w #$0B5B
	STA.w $040C
	LDA.w !RAM_SIMC_City_CityCategory
	STA.w $040E
	LDA.w !RAM_SIMC_City_CurrentYearLo
	STA.w $0410
	LDA.w !RAM_SIMC_City_CurrentMonthLo
	STA.w $0413
	LDA.w #$8280
	STA.w $0415
	LDA.w #$0300
	STA.w $0417
	LDA.w #$0500
	STA.w $0419
	JSR.w CODE_00CAB2
	JSR.w CODE_00CAC7
	JSR.w CODE_00CC5E
	RTS

CODE_00CC5E:
	JSR.w CODE_00CC8C
	JSR.w CODE_00CCC9
	JSR.w CODE_00CD5B
	RTS

DATA_00CC68:
	dw !RAM_SIMC_Global_GeneralPurposeBuffer+$17E0,!RAM_SIMC_Global_GeneralPurposeBuffer+$1000,!RAM_SIMC_Global_GeneralPurposeBuffer+$1120,!RAM_SIMC_Global_GeneralPurposeBuffer+$1240
	dw !RAM_SIMC_Global_GeneralPurposeBuffer+$1360,!RAM_SIMC_Global_GeneralPurposeBuffer+$1480,!RAM_SIMC_Global_GeneralPurposeBuffer+$15A0,!RAM_SIMC_Global_GeneralPurposeBuffer+$2100
	dw !RAM_SIMC_Global_GeneralPurposeBuffer+$2220

DATA_00CC7A:
	dw $7E0200,$7E0220,$7E0240,$7E0400,$7E0420,$7E0440,$7E0600,$7E0620
	dw $7E0640

CODE_00CC8C:
	REP.b #$30
	LDA.w #$0009
	STA.b $79
	STZ.b $7C
	LDA.w $040E
	CMP.w #$00FF
	BNE.b CODE_00CCA2
	LDA.w DATA_00CC68
	BRA.b CODE_00CCA8

CODE_00CCA2:
	INC
	ASL
	TAX
	LDA.w DATA_00CC68,x
CODE_00CCA8:
	TAX
CODE_00CCA9:
	PHX
	LDA.b $7C
	ASL
	TAX
	LDA.w DATA_00CC7A,x
	CLC
	ADC.w $0415
	TAY
	PLX
	LDA.w #$001F
	MVN $7E0200>>16,(!RAM_SIMC_Global_GeneralPurposeBuffer+$1000)>>16
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	INC.b $7C
	DEC.b $79
	BNE.b CODE_00CCA9
	RTS

CODE_00CCC9:
	REP.b #$30
	LDA.w $040E
	CMP.w #$000A
	BCC.b CODE_00CCD6
	JMP.w CODE_00CD36

CODE_00CCD6:
	LDX.w #$0410
	JSL.l CODE_008FEB
	REP.b #$30
	LDA.b $7B
	STA.w $041B
	LDA.b $7D
	STA.w $041D
	SEP.b #$20
	REP.b #$10
	LDX.w #$0000
	LDY.w #$0001
CODE_00CCF3:
	LDA.w $041B,x
	PHX
	LDX.w $0417
	PHY
	JSR.w CODE_00CD9C
	SEP.b #$20
	REP.b #$10
	PLY
	PLX
	INY
	INX
	CPX.w #$0004
	BCC.b CODE_00CCF3
	REP.b #$30
	LDA.w $0413
	ASL
	CLC
	ADC.w $0413
	DEC
	DEC
	DEC
	TAX
	SEP.b #$20
	LDY.w #$0006
CODE_00CD1E:
	LDA.w DATA_00CD37,x
	PHX
	LDX.w $0417
	PHY
	JSR.w CODE_00CD9C
	SEP.b #$20
	REP.b #$10
	PLY
	PLX
	INY
	INX
	CPY.w #$0009
	BCC.b CODE_00CD1E
CODE_00CD36:
	RTS

DATA_00CD37:
	db $13,$0A,$17,$0F,$0E,$0B,$16,$0A,$1B,$0A,$19,$1B,$16,$0A,$22,$13
	db $1E,$17,$13,$1E,$15,$0A,$1E,$10,$1C,$0E,$19,$18,$0C,$1D,$17,$18
	db $1F,$0D,$0E,$0C

CODE_00CD5B:
	SEP.b #$20
	REP.b #$10
	LDA.w $040E
	CMP.b #$FF
	BEQ.b CODE_00CD97
	LDX.w $040C
	LDA.b $00,x
	BEQ.b CODE_00CD97
	INX
	STA.w $041F
	LDA.b #$0A
	SEC
	SBC.w $041F
	LSR
	REP.b #$20
	AND.w #$00FF
	TAY
	SEP.b #$20
CODE_00CD80:
	LDA.b $00,x
	PHX
	LDX.w $0419
	PHY
	JSR.w CODE_00CD9C
	SEP.b #$20
	REP.b #$10
	PLY
	PLX
	INX
	INY
	DEC.w $041F
	BNE.b CODE_00CD80
CODE_00CD97:
	RTS

CODE_00CD98:
	JSR.w CODE_00CD9C
	RTL

CODE_00CD9C:
	REP.b #$20
	AND.w #$00FF
	CLC
	ADC.w #$0060
	ASL
	ASL
	ASL
	ASL
	ASL
	PHA
	TYA
	LSR
	STZ.b $79
	BCC.b CODE_00CDB3
	DEC.b $79
CODE_00CDB3:
	ASL
	ASL
	ASL
	ASL
	ASL
	STA.b $7C
	TXA
	CLC
	ADC.b $7C
	TAX
	PLY
	LDA.w #$0020
	STA.b $7C
	SEP.b #$20
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	PHA
	PLB
	SEP.b #$20
CODE_00CDCD:
	LDA.w !RAM_SIMC_Global_GeneralPurposeBuffer+$1000,y
	AND.b #$F0
	STA.b $7F
	LDA.b $79
	BPL.b CODE_00CDE0
	LDA.b $7F
	LSR
	LSR
	LSR
	LSR
	STA.b $7F
CODE_00CDE0:
	LDA.w !RAM_SIMC_Global_GeneralPurposeBuffer,x
	ORA.b $7F
	STA.w !RAM_SIMC_Global_GeneralPurposeBuffer,x
	INX
	INY
	DEC.b $7C
	BNE.b CODE_00CDCD
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	RTS

CODE_00CDF4:
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	JSL.l CODE_008206
	SEP.b #$20
	REP.b #$10
	LDA.b #$01
	STA.w DMA[$01].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$01].Destination
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$01].SourceBank
	LDX.w #$7680
	STX.w !REGISTER_VRAMAddressLo
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer
	STX.w DMA[$01].SourceLo
	LDX.w #$0100
	STX.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	LDX.w #$7780
	STX.w !REGISTER_VRAMAddressLo
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$0100
	STX.w DMA[$01].SourceLo
	LDX.w #$0100
	STX.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	SEP.b #$20
	REP.b #$10
	LDA.b #$01
	STA.w DMA[$01].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$01].Destination
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$0200)>>16
	STA.w DMA[$01].SourceBank
	LDX.w #$7800
	STX.w !REGISTER_VRAMAddressLo
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$0200
	STX.w DMA[$01].SourceLo
	LDX.w #$0800
	STX.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	RTS

DATA_00CE78:
	incbin "Tilemaps/DATA_00CE78.bin"

CODE_00CFB8:
	REP.b #$30
	LDA.w #$0352
	STA.b $79
	LDA.w #$000A
	STA.b $7C
	PHK
	PLB
	LDY.w #$0000
CODE_00CFC9:
	LDA.w #$0010
	STA.b $7F
	LDX.b $79
CODE_00CFD0:
	LDA.w DATA_00CE78,y
	STA.l !RAM_SIMC_Global_Layer3TilemapBuffer,x
	INX
	INX
	INY
	INY
	DEC.b $7F
	BNE.b CODE_00CFD0
	LDA.b $79
	CLC
	ADC.w #$0040
	STA.b $79
	DEC.b $7C
	BNE.b CODE_00CFC9
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	JSR.w CODE_008E21
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	REP.b #$20
	RTS

CODE_00D008:
	REP.b #$30
	LDA.w #$000A
	STA.b $7C
	LDA.w #$0352
	STA.b $79
CODE_00D014:
	LDA.w #$0010
	STA.b $7F
	LDX.b $79
	LDA.w #$014B
CODE_00D01E:
	STA.l !RAM_SIMC_Global_Layer3TilemapBuffer,x
	INX
	INX
	INY
	INY
	DEC.b $7F
	BNE.b CODE_00D01E
	LDA.b $79
	CLC
	ADC.w #$0040
	STA.b $79
	DEC.b $7C
	BNE.b CODE_00D014
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	JSR.w CODE_008E21
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	REP.b #$20
	RTS

DATA_00D04E:
	dw $7454,$316D,$745C,$316E,$7464,$316F,$746C,$317D
	dw $7474,$317E,$747C,$317F,$7484,$318D,$748C,$318E
	dw $7494,$318F,$749C,$319D,$74A4,$319E,$74AC,$319F

DATA_00D07E:
	dw $8B5C,$31DF,$8B84,$31DE,$935C,$31EB,$9384,$31EB
	dw $7C54,$3380,$7C64,$3382,$8C54,$33A0,$8C64,$33A2
	dw $9C4C,$3168,$9C5C,$316A,$9C6C,$316C,$A46C,$317C
	dw $7C7C,$3384,$7C8C,$3386,$8C7C,$33A4,$8C8C,$33A6
	dw $9C74,$3188,$9C84,$318A,$9C94,$318C,$A494,$319C
	dw $7CA4,$33A8,$7CB4,$33AA,$8CA4,$33AC,$8CB4,$33AE

DATA_00D0DE:
	db $00,$00,$00,$00,$AA,$0A,$AA,$0A,$AA

DATA_00D0E7:
	db $00,$00,$00,$55,$AA,$0A,$AA,$0A,$AA

CODE_00D0F0:
	JSR.w CODE_00D0FE
	JSR.w CODE_00D11E
	RTS

CODE_00D0F7:
	JSR.w CODE_00D0FE
	JSR.w CODE_00D147
	RTS

CODE_00D0FE:
	REP.b #$30
	LDX.w #DATA_00D04E
	LDY.w #SIMC_Global_OAMBuffer[$04].XDisp
	LDA.w #$002F
	MVN SIMC_Global_OAMBuffer[$04].XDisp>>16,DATA_00D04E>>16
	LDX.w #DATA_00D07E
	LDY.w #SIMC_Global_OAMBuffer[$28].XDisp
	LDA.w #$005F
	MVN SIMC_Global_OAMBuffer[$28].XDisp>>16,DATA_00D07E>>16
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	RTS

CODE_00D11E:
	SEP.b #$20
	LDX.w #$0000
	LDY.w #$0003
CODE_00D126:
	LDA.w DATA_00D0DE,x
	STA.l SIMC_Global_UpperOAMBuffer[$01].Slot,x
	INX
	DEY
	BNE.b CODE_00D126
	LDY.w #$0006
CODE_00D134:
	LDA.w DATA_00D0DE,x
	STA.l SIMC_Global_UpperOAMBuffer[$07].Slot,x
	INX
	DEY
	BNE.b CODE_00D134
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	RTS

CODE_00D147:
	SEP.b #$20
	LDX.w #$0000
	LDY.w #$0003
CODE_00D14F:
	LDA.w DATA_00D0E7,x
	STA.l SIMC_Global_UpperOAMBuffer[$01].Slot,x
	INX
	DEY
	BNE.b CODE_00D14F
	LDY.w #$0006
CODE_00D15D:
	LDA.w DATA_00D0E7,x
	STA.l SIMC_Global_UpperOAMBuffer[$07].Slot,x
	INX
	DEY
	BNE.b CODE_00D15D
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	RTS

CODE_00D170:
	REP.b #$20
	LDA.w #$5555
	STA.l SIMC_Global_UpperOAMBuffer[$01].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$0A].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$0C].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$0E].Slot
	SEP.b #$20
	STA.l SIMC_Global_UpperOAMBuffer[$03].Slot
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	RTS

DATA_00D193:
	db $B0,$90,$60,$90,$88,$90

CODE_00D199:
	REP.b #$20
	STZ.w $0421
CODE_00D19E:
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	JSR.w CODE_00D23A
	REP.b #$20
	LDA.b $C9
	AND.w #$8000
	BNE.b CODE_00D1F2
	LDA.b $C9
	AND.w #$0040
	BNE.b CODE_00D1FD
	LDA.b $C9
	AND.w #$0300
	BEQ.b CODE_00D19E
	AND.w #$0200
	BEQ.b CODE_00D1DB
	PHP
	JSL.l CODE_0098A0	: dw $0703
	PLP
	REP.b #$20
	DEC.w $0421
	BPL.b CODE_00D19E
	LDA.w #$0002
	STA.w $0421
	BRA.b CODE_00D19E

CODE_00D1DB:
	PHP
	JSL.l CODE_0098A0	: dw $0703
	PLP
	REP.b #$20
	INC.w $0421
	LDA.w $0421
	CMP.w #$0003
	BCC.b CODE_00D19E
	BRA.b CODE_00D199

CODE_00D1F2:
	JSR.w CODE_00D24F
	REP.b #$20
	LDA.w $0421
	BEQ.b CODE_00D20B
	RTS

CODE_00D1FD:
	PHP
	JSL.l CODE_0098A0	: dw $0603
	PLP
	REP.b #$20
CODE_00D207:
	LDA.w #$0000
	RTS

CODE_00D20B:
	PHP
	JSL.l CODE_0098A0	: dw $0102
	PLP
	BRA.b CODE_00D207

CODE_00D215:
	REP.b #$20
	LDA.w $0421
	BEQ.b CODE_00D22E
	CMP.w #$0002
	BEQ.b CODE_00D226
	LDA.w $0B65
	BRA.b CODE_00D229

CODE_00D226:
	LDA.w $0B75
CODE_00D229:
	CMP.w #$000A
	BCS.b CODE_00D230
CODE_00D22E:
	CLC
	RTS

CODE_00D230:
	PHP
	JSL.l CODE_0098A0	: dw $0202
	PLP
	SEC
	RTS

CODE_00D23A:
	REP.b #$30
	LDA.w $0421
	ASL
	TAX
	LDA.w DATA_00D193,x
	STA.l SIMC_Global_OAMBuffer[$00].XDisp
	RTS

DATA_00D249:
	dw $00F0,$00B0,$00D0

CODE_00D24F:
	REP.b #$30
	LDA.w $0421
	ASL
	TAX
	LDA.w DATA_00D249,x
	TAX
	SEP.b #$20
	LDA.b #$35
	STA.l SIMC_Global_OAMBuffer[$00].Prop,x
	STA.l SIMC_Global_OAMBuffer[$01].Prop,x
	STA.l SIMC_Global_OAMBuffer[$02].Prop,x
	STA.l SIMC_Global_OAMBuffer[$03].Prop,x
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	RTS

CODE_00D276:
	REP.b #$30
	LDA.w $0421
	ASL
	TAX
	LDA.w DATA_00D249,x
	TAX
	SEP.b #$20
	LDA.b #$33
	STA.l SIMC_Global_OAMBuffer[$00].Prop,x
	STA.l SIMC_Global_OAMBuffer[$01].Prop,x
	STA.l SIMC_Global_OAMBuffer[$02].Prop,x
	STA.l SIMC_Global_OAMBuffer[$03].Prop,x
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	RTS

CODE_00D29D:
	PHP
	JSL.l CODE_0098A0	: dw $1300
	PLP
	REP.b #$20
	LDA.w #$0004
	COP.b #$00
	REP.b #$20
	LDA.w #$0001
	COP.b #$00
	JSR.w CODE_00D389
	JSR.w CODE_00D89A
	JSR.w CODE_00D3E6
	JSR.w CODE_00D49E
	JSR.w CODE_00D559
	REP.b #$20
	LDA.w #$0020
	STA.w $0381
	JSL.l CODE_0194E2
	JSR.w CODE_00D5D6
	REP.b #$20
	LDA.w #$0003
	COP.b #$00
	REP.b #$20
	LDA.w #$FFFF
	STA.b $D7
CODE_00D2DF:
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	JSR.w CODE_00DA75
	SEP.b #$20
	LDA.w $0425
	REP.b #$20
	BPL.b CODE_00D2F9
	LDA.w #$005A
	STA.b $75
	BRA.b CODE_00D2FE

CODE_00D2F9:
	LDA.w #$0042
	STA.b $75
CODE_00D2FE:
	JSR.w CODE_00D5D6
	JSR.w CODE_00D8F4
	JSR.w CODE_00D9F2
	BRA.b CODE_00D2DF

table "Tables/Fonts/DebugMenu.txt"

DATA_00D309:
	db "DEBUG MODE  K.IS"
	db "                "
	db " SOUND TEST     "
	db " NO DISASTERS   "
	db " NEEDLESS MONEY "
	db " VALVE MAX      "
	db " WATER RECLAIM  "
	db " MEMORY         "

cleartable

CODE_00D389:
	REP.b #$30
	LDY.w #!RAM_SIMC_Global_GeneralPurposeBuffer
	LDA.w #$0000
	STA.b $79
CODE_00D393:
	LDX.b $79
	LDA.w DATA_00D309,x
	AND.w #$00FF
	ASL
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC.w #DATA_06C000+$3800
	TAX
	LDA.w #$001F
	PHB
	MVN !RAM_SIMC_Global_GeneralPurposeBuffer>>16,(DATA_06C000+$3800)>>16
	PLB
	LDA.b $79
	INC
	STA.b $79
	CMP.w #$0080
	BCC.b CODE_00D393
	JSL.l CODE_008206
	SEP.b #$20
	REP.b #$10
	LDA.b #$01
	STA.w DMA[$01].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$01].Destination
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$01].SourceBank
	LDX.w #$6800
	STX.w !REGISTER_VRAMAddressLo
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer
	STX.w DMA[$01].SourceLo
	LDX.w #$1000
	STX.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	RTS

CODE_00D3E6:
	REP.b #$30
	LDX.w #$07FE
CODE_00D3EB:
	LDA.w #$0000
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer,x
	LDA.w #$014B
	STA.l !RAM_SIMC_Global_Layer3TilemapBuffer,x
	DEX
	DEX
	BPL.b CODE_00D3EB
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	JSL.l CODE_008206
	SEP.b #$20
	REP.b #$10
	LDA.b #$01
	STA.w DMA[$01].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$01].Destination
	LDA.b #!RAM_SIMC_Global_Layer1TilemapBuffer>>16
	STA.w DMA[$01].SourceBank
	LDX.w #$5800
	STX.w !REGISTER_VRAMAddressLo
	LDX.w #!RAM_SIMC_Global_Layer1TilemapBuffer
	STX.w DMA[$01].SourceLo
	LDX.w #$0800
	STX.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	SEP.b #$20
	REP.b #$10
	LDA.b #$01
	STA.w DMA[$01].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$01].Destination
	LDA.b #!RAM_SIMC_Global_Layer2TilemapBuffer>>16
	STA.w DMA[$01].SourceBank
	LDX.w #$5C00
	STX.w !REGISTER_VRAMAddressLo
	LDX.w #!RAM_SIMC_Global_Layer2TilemapBuffer
	STX.w DMA[$01].SourceLo
	LDX.w #$0800
	STX.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	SEP.b #$20
	REP.b #$10
	LDA.b #$01
	STA.w DMA[$01].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$01].Destination
	LDA.b #!RAM_SIMC_Global_Layer3TilemapBuffer>>16
	STA.w DMA[$01].SourceBank
	LDX.w #$5400
	STX.w !REGISTER_VRAMAddressLo
	LDX.w #!RAM_SIMC_Global_Layer3TilemapBuffer
	STX.w DMA[$01].SourceLo
	LDX.w #$0800
	STX.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	RTS

CODE_00D49E:
	REP.b #$30
	STZ.w $0137
	STZ.w $0139
	STZ.w $0431
	STZ.w $0433
	STZ.w $0435
	STZ.w $0437
	STZ.w $0427
	STZ.w $042F
	STZ.w $042B
	LDA.w #$0001
	STA.w $042D
	LDA.w #$FFFF
	STA.b $D7
	LDA.w #$FFF8
	STA.b $73
	LDA.w #$0042
	STA.b $75
	SEP.b #$20
	LDA.b #$43
	STA.b !RAM_SIMC_Global_OAMSizeAndDataAreaDesignation
	LDA.b #$14
	STA.b !RAM_SIMC_Global_MainScreenLayers
	LDA.b #$00
	STA.b !RAM_SIMC_Global_SubScreenLayers
	STA.b !RAM_SIMC_Global_BG1And2WindowMaskSettings
	STA.b !RAM_SIMC_Global_BG3And4WindowMaskSettings
	STA.b !RAM_SIMC_Global_ObjectAndColorWindowSettings
	STA.b !RAM_SIMC_Global_ColorMathSelectAndEnable
	STA.b !RAM_SIMC_Global_FixedColorData
	RTS

DATA_00D4E9:
	incbin "Tilemaps/DATA_00D4E9.bin"

CODE_00D559:
	REP.b #$30
	LDA.w #$03D8
	STA.b $7C
	LDA.w #$0008
	STA.b $79
	LDX.w #DATA_00D4E9
CODE_00D568:
	LDA.b $7C
	CLC
	ADC.w #!RAM_SIMC_Global_Layer3TilemapBuffer
	TAY
	LDA.w #$000D
	PHB
	MVN !RAM_SIMC_Global_Layer3TilemapBuffer>>16,DATA_00D4E9>>16
	PLB
	LDA.b $7C
	CLC
	ADC.w #$0040
	STA.b $7C
	DEC.b $79
	BNE.b CODE_00D568
	RTS

DATA_00D584:
	db $FC,$FA,$05,$FC,$F8,$01,$FC,$F5,$02,$FC,$F3,$01,$FC,$F1,$02,$FC
	db $EF,$01,$FC,$ED,$02,$FC,$EC,$0A,$FC,$ED,$09,$FC,$EC,$02,$FC,$EB
	db $06,$FC,$EA,$0E,$FC,$EB,$07,$FC,$EA,$10,$FC,$EB,$06,$FC,$EC,$02
	db $FC,$EB,$07,$FC,$EA,$13,$FC,$EB,$07,$FC,$EC,$04,$FC,$EB,$0F,$FC
	db $EC,$05,$FB,$F2,$04,$FC,$F6,$03,$80

DATA_00D5CD:
	db $02,$05,$00,$01,$01,$89,$00,$07,$80

CODE_00D5D6:
	JSR.w CODE_00D5E0
	JSR.w CODE_00D63A
	JSR.w CODE_00D692
	RTS

CODE_00D5E0:
	SEP.b #$30
	LDA.w $0433
	BNE.b CODE_00D5FF
	LDX.w $0431
	INX
	INX
	LDA.w DATA_00D5CD,x
	BPL.b CODE_00D5F6
	LDX.b #$00
	LDA.w DATA_00D5CD,x
CODE_00D5F6:
	STX.w $0431
	LDA.w DATA_00D5CD+$01,x
	STA.w $0433
CODE_00D5FF:
	DEC.w $0433
	LDX.w $0431
	LDA.w DATA_00D5CD,x
	CLC
	ADC.b #$4A
	REP.b #$20
	AND.w #$00FF
	STA.w $0261
	LDA.w #$0080
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	SEP.b #$20
	LDA.w $0425
	REP.b #$20
	BPL.b CODE_00D62A
	LDA.w #$0040
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	BRA.b CODE_00D630

CODE_00D62A:
	LDA.w #$0058
CODE_00D62D:
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
CODE_00D630:
	LDA.w #$0020
	STA.w $0253
	JSR.w CODE_00905C
	RTS

CODE_00D63A:
	SEP.b #$30
	LDA.w $0437
	BNE.b CODE_00D65C
	LDX.w $0435
	INX
	INX
	INX
	LDA.w DATA_00D584,x
	CMP.b #$80
	BNE.b CODE_00D653
	LDX.b #$00
	LDA.w DATA_00D584,x
CODE_00D653:
	STX.w $0435
	LDA.w DATA_00D584+$02,x
	STA.w $0437
CODE_00D65C:
	DEC.w $0437
	LDX.w $0435
	LDA.w DATA_00D584,x
	CLC
	ADC.b #$80
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	SEP.b #$20
	LDA.w $0425
	REP.b #$20
	BMI.b CODE_00D679
	LDA.w #$0058
	BRA.b CODE_00D67C

CODE_00D679:
	LDA.w #$0040
CODE_00D67C:
	CLC
	ADC.w DATA_00D584+$01,x
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	REP.b #$20
	LDA.w #$004D
	STA.w $0261
	STZ.w $0253
	JSR.w CODE_00905C
	RTS

CODE_00D692:
	JSR.w CODE_00D69F
	JSR.w CODE_00D6EC
	JSR.w CODE_00D80E
	JSR.w CODE_00D7DE
	RTS

CODE_00D69F:
	SEP.b #$20
	LDA.w $0425
	BMI.b CODE_00D6AD
	LDA.b #$55
	STA.l SIMC_Global_UpperOAMBuffer[$04].Slot
	RTS

CODE_00D6AD:
	REP.b #$20
	LDA.w #$8040
	STA.l SIMC_Global_OAMBuffer[$10].XDisp
	LDA.w #$3080
	STA.l SIMC_Global_OAMBuffer[$10].Tile
	LDA.w #$8080
	STA.l SIMC_Global_OAMBuffer[$11].XDisp
	LDA.w #$3088
	STA.l SIMC_Global_OAMBuffer[$11].Tile
	SEP.b #$20
	LDA.b #$5A
	STA.l SIMC_Global_UpperOAMBuffer[$04].Slot
	RTS

DATA_00D6D4:
	dw $31CE,$31CD,$31DB

DATA_00D6DA:
	dw $31CE,$31C5,$31C5

DATA_00D6E0:
	dw $31D2,$31C4,$31D3

DATA_00D6E6:
	dw $31C2,$31CB,$31D1

CODE_00D6EC:
	SEP.b #$30
	LDA.w $0425
	BMI.b CODE_00D705
	REP.b #$20
	LDA.w #$5555
	STA.l SIMC_Global_UpperOAMBuffer[$06].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$08].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$0A].Slot
	RTS

CODE_00D705:
	STA.b $79
	STZ.b $7C
CODE_00D709:
	LSR.b $79
	BCC.b CODE_00D712
	JSR.w CODE_00D740
	BRA.b CODE_00D715

CODE_00D712:
	JSR.w CODE_00D75E
CODE_00D715:
	SEP.b #$20
	LDA.b $7C
	INC
	STA.b $7C
	CMP.b #$04
	BCC.b CODE_00D709
	LSR.b $79
	BCC.b CODE_00D729
	JSR.w CODE_00D77C
	BRA.b CODE_00D72C

CODE_00D729:
	JSR.w CODE_00D79A
CODE_00D72C:
	REP.b #$20
	LDA.w #$4040
	STA.l SIMC_Global_UpperOAMBuffer[$06].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$08].Slot
	SEP.b #$20
	STA.l SIMC_Global_UpperOAMBuffer[$0A].Slot
	RTS

CODE_00D740:
	LDA.b $7C
	ASL
	ASL
	ASL
	PHA
	ASL
	TAX
	PLA
	CLC
	ADC.b #$98
	STA.b $7F
	LDA.b #$C0
	STA.b $82
	PEA.w DATA_00D6D4
	LDY.b #$00
	JSR.w CODE_00D7B8
	REP.b #$20
	PLA
	RTS

CODE_00D75E:
	LDA.b $7C
	ASL
	ASL
	ASL
	PHA
	ASL
	TAX
	PLA
	CLC
	ADC.b #$98
	STA.b $7F
	LDA.b #$C0
	STA.b $82
	PEA.w DATA_00D6DA
	LDY.b #$00
	JSR.w CODE_00D7B8
	REP.b #$20
	PLA
	RTS

CODE_00D77C:
	LDA.b $7C
	ASL
	ASL
	ASL
	PHA
	ASL
	TAX
	PLA
	CLC
	ADC.b #$98
	STA.b $7F
	LDA.b #$C0
	STA.b $82
	PEA.w DATA_00D6E0
	LDY.b #$00
	JSR.w CODE_00D7B8
	REP.b #$20
	PLA
	RTS

CODE_00D79A:
	LDA.b $7C
	ASL
	ASL
	ASL
	PHA
	ASL
	TAX
	PLA
	CLC
	ADC.b #$98
	STA.b $7F
	LDA.b #$C0
	STA.b $82
	PEA.w DATA_00D6E6
	LDY.b #$00
	JSR.w CODE_00D7B8
	REP.b #$20
	PLA
	RTS

CODE_00D7B8:
	LDA.b $82
	STA.l SIMC_Global_OAMBuffer[$18].XDisp,x
	INX
	CLC
	ADC.b #$08
	STA.b $82
	LDA.b $7F
	STA.l SIMC_Global_OAMBuffer[$18].XDisp,x
	INX
	REP.b #$20
	LDA.b ($03,S),y
	INY
	INY
	STA.l SIMC_Global_OAMBuffer[$18].XDisp,x
	INX
	INX
	SEP.b #$20
	CPY.b #$06
	BCC.b CODE_00D7B8
	RTS

CODE_00D7DE:
	SEP.b #$20
	LDA.w $0425
	BMI.b CODE_00D7EC
	LDA.b #$55
	STA.l SIMC_Global_UpperOAMBuffer[$0C].Slot
	RTS

CODE_00D7EC:
	LDA.w $0429
	ASL
	ASL
	ASL
	CLC
	ADC.b #$90
	XBA
	LDA.b #$32
	REP.b #$20
	STA.l SIMC_Global_OAMBuffer[$30].XDisp
	LDA.w #$39F0
	STA.l SIMC_Global_OAMBuffer[$30].Tile
	SEP.b #$20
	LDA.b #$50
	STA.l SIMC_Global_UpperOAMBuffer[$0C].Slot
	RTS

CODE_00D80E:
	SEP.b #$20
	LDA.w $0425
	BMI.b CODE_00D81C
	LDA.b #$55
	STA.l SIMC_Global_UpperOAMBuffer[$0E].Slot
	RTS

CODE_00D81C:
	REP.b #$30
	LDX.w #DATA_00D86A
	LDY.w #SIMC_Global_OAMBuffer[$38].XDisp
	LDA.w #$000F
	PHB
	MVN SIMC_Global_OAMBuffer[$38].XDisp>>16,DATA_00D86A>>16
	PLB
	SEP.b #$30
	LDX.w $042B
	LDA.w DATA_00D85A,x
	STA.l SIMC_Global_OAMBuffer[$38].Tile
	LDA.w $042D
	PHA
	LSR
	LSR
	LSR
	LSR
	TAX
	LDA.w DATA_00D85A,x
	STA.l SIMC_Global_OAMBuffer[$3A].Tile
	PLA
	AND.b #$0F
	TAX
	LDA.w DATA_00D85A,x
	STA.l SIMC_Global_OAMBuffer[$3B].Tile
	LDA.b #$00
	STA.l SIMC_Global_UpperOAMBuffer[$0E].Slot
	RTS

DATA_00D85A:
	db $E0,$E1,$E2,$E3,$E4,$E5,$E6,$E7,$E8,$E9,$C0,$C1,$C2,$C3,$C4,$C5

DATA_00D86A:
	db $C0,$90,$00,$31,$C8,$90,$EA,$31,$D0,$90,$00,$31,$D8,$90,$00,$31

DATA_00D87A:
	incbin "Palettes/DATA_00D87A.bin"

CODE_00D89A:
	REP.b #$30
	LDX.w #$001E
CODE_00D89F:
	LDA.w DATA_00D87A,x
	STA.l SIMC_Global_PaletteMirror[$C0].LowByte,x
	DEX
	DEX
	BPL.b CODE_00D89F
	LDX.w #$0000
CODE_00D8AD:
	LDA.w #$3C00
	STA.l SIMC_Global_PaletteMirror[$00].LowByte,x
	TXA
	CLC
	ADC.w #$0020
	TAX
	CMP.w #$0100
	BCC.b CODE_00D8AD
	LDA.w #$1929
	STA.l SIMC_Global_PaletteMirror[$05].LowByte
	JSL.l CODE_008206
	SEP.b #$20
	REP.b #$10
	LDA.b #$00
	STA.w DMA[$01].Parameters
	LDA.b #!REGISTER_WriteToCGRAMPort
	STA.w DMA[$01].Destination
	LDA.b #!RAM_SIMC_Global_PaletteMirror>>16
	STA.w DMA[$01].SourceBank
	LDA.b #$00
	STA.w !REGISTER_CGRAMAddress
	LDX.w #!RAM_SIMC_Global_PaletteMirror
	STX.w DMA[$01].SourceLo
	LDX.w #$0200
	STX.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	RTS

CODE_00D8F4:
	SEP.b #$20
	LDA.w $0425
	BMI.b CODE_00D8FC
	RTS

CODE_00D8FC:
	REP.b #$30
	LDA.b $C9
	AND.w #$0C00
	BNE.b CODE_00D908
	JMP.w CODE_00D92A

CODE_00D908:
	AND.w #$0800
	BEQ.b CODE_00D91A
	LDA.w $0429
	DEC
	BPL.b CODE_00D916
	LDA.w #$0005
CODE_00D916:
	STA.w $0429
	RTS

CODE_00D91A:
	LDA.w $0429
	INC
	CMP.w #$0006
	BCC.b CODE_00D926
	LDA.w #$0000
CODE_00D926:
	STA.w $0429
	RTS

CODE_00D92A:
	LDA.w $0429
	BEQ.b CODE_00D935
	CMP.w #$0005
	BEQ.b CODE_00D96E
	RTS

CODE_00D935:
	LDA.b $C9
	AND.w #$0300
	BNE.b CODE_00D93D
	RTS

CODE_00D93D:
	LDX.w $042F
	AND.w #$0200
	BEQ.b CODE_00D94E
	DEX
	DEX
	BPL.b CODE_00D958
	LDX.w #$0070
	BRA.b CODE_00D958

CODE_00D94E:
	INX
	INX
	CPX.w #$0071
	BCC.b CODE_00D958
	LDX.w #$0000
CODE_00D958:
	STX.w $042F
	LDA.w DATA_00D980,x
	AND.w #$00FF
	STA.w $042B
	LDA.w DATA_00D980+$01,x
	AND.w #$00FF
	STA.w $042D
	RTS

CODE_00D96E:
	LDA.b $C9
	AND.w #$0300
	BNE.b CODE_00D976
	RTS

CODE_00D976:
	LDA.w $0425
	EOR.w #$0010
	STA.w $0425
	RTS

DATA_00D980:
	db $00,$01,$00,$02,$00,$03,$00,$04,$00,$05,$00,$06,$00,$07,$00,$08
	db $00,$09,$00,$0A,$00,$0B,$00,$0C,$00,$0D,$00,$0E,$00,$0F,$00,$10
	db $00,$11,$00,$12,$00,$13,$00,$F0,$01,$01,$01,$02,$02,$01,$02,$02
	db $02,$03,$02,$04,$02,$05,$02,$06,$02,$07,$02,$0B,$02,$0C,$02,$0D
	db $02,$0E,$03,$01,$03,$03,$03,$04,$03,$05,$03,$06,$03,$07,$03,$08
	db $03,$09,$03,$0A,$03,$0B,$03,$0C,$03,$0F,$03,$10,$03,$11,$03,$14
	db $03,$17,$03,$1C,$03,$1E,$03,$1F,$03,$21,$03,$22,$03,$24,$03,$26
	db $03,$80

CODE_00D9F2:
	SEP.b #$20
	LDA.w $0425
	BMI.b CODE_00D9FA
	RTS

CODE_00D9FA:
	REP.b #$30
	LDA.b $C9
	AND.w #$8000
	BNE.b CODE_00DA04
	RTS

CODE_00DA04:
	LDA.w $0429
	BEQ.b CODE_00DA1D
	CMP.w #$0005
	BEQ.b CODE_00DA28
	DEC
	TAX
	LDA.w DATA_00DA50,x
	AND.w #$00FF
	EOR.w $0425
	STA.w $0425
	RTS

CODE_00DA1D:
	LDX.w $042B
	LDA.w $042D
	SEP.b #$20
	STA.b $03,x
	RTS

CODE_00DA28:
	DEC
	TAX
	LDA.w DATA_00DA50,x
	AND.w $0425
	BEQ.b CODE_00DA40
	LDA.w $0425
	SEP.b #$20
	STA.l $700009
	JSL.l CODE_03E54F
	RTS

CODE_00DA40:
	STZ.w $0425
	SEP.b #$20
	LDA.b #$00
	STA.l $700009
	JSL.l CODE_03E54F
	RTS

DATA_00DA50:
	db $01,$02,$04,$08,$10

DATA_00DA55:
	dw $0200,$0080,$0100,$4000,$0800,$8000,$0400,$0040
	dw $2000,$1000,$1000,$2000,$0010,$0010,$0020,$0020

CODE_00DA75:
	REP.b #$30
	LDX.w $0427
	LDA.b $CB
	BEQ.b CODE_00DAA5
	CMP.w DATA_00DA55,x
	BNE.b CODE_00DAA2
	INX
	INX
	CPX.w #$0020
	BEQ.b CODE_00DA8E
	STX.w $0427
	RTS

CODE_00DA8E:
	SEP.b #$20
	LDA.w $0425
	EOR.b #$80
	STA.w $0425
	STA.l $700009
	JSL.l CODE_03E54F
	REP.b #$20
CODE_00DAA2:
	STZ.w $0427
CODE_00DAA5:
	RTS

DATA_00DAA6:
	dw DATA_00DB50,DATA_00DBB0,DATA_00DC00,DATA_00DC68,DATA_00DCB8,DATA_00DD20,DATA_00DD92,DATA_00DE0C
	dw DATA_00DE7E,DATA_00DEE6,DATA_00DF60,DATA_00DFDA,DATA_00E042,DATA_00E0C0,DATA_00E13E,DATA_00E196
	dw DATA_00E1E2,DATA_00E228,DATA_00E290,DATA_00E312,DATA_00E372,DATA_00E3C2,DATA_00E42A,DATA_00F0D4
	dw DATA_00F14E,DATA_00F1C8,DATA_00F242,DATA_00F2B4,DATA_00F394,DATA_00F40E,DATA_00F488,DATA_00E47A
	dw DATA_00E4E8,DATA_00E56E,DATA_00E5EC,DATA_00E65E,DATA_00E6D0,DATA_00E738,DATA_00E7A0,DATA_00E816
	dw DATA_00E89C,DATA_00E922,DATA_00E998,DATA_00EA0E,DATA_00EA94,DATA_00EB12,DATA_00EB84,DATA_00DB50
	dw DATA_00EBF6,DATA_00EC5C,DATA_00ECCA,DATA_00ED34,DATA_00EDA2,DATA_00EE06,DATA_00EE78,DATA_00EEDC
	dw DATA_00EF2C,DATA_00EF7C,DATA_00F028,DATA_00FA0C,DATA_00FA20,DATA_00FA34,DATA_00FA48,DATA_00FA5C
	dw DATA_00F4F0,DATA_00F52E,DATA_00F56C,DATA_00F5C4,DATA_00F61C,DATA_00F686,DATA_00F6F4,DATA_00F732
	dw DATA_00F770,DATA_00F7C8,DATA_00FAA2,DATA_00FAC6,DATA_00FAEA,DATA_00FB0E,DATA_00FB16,DATA_00DB50
	dw DATA_00F820,DATA_00F880,DATA_00F8E0,DATA_00F944,DATA_00F9A8

DATA_00DB50:
	dw $0016,$1708,$3053,$1700,$3052,$17F8,$3051,$17F0
	dw $3050,$0F08,$3043,$0F00,$3042,$0FF8,$3041,$0FF0
	dw $3040,$0708,$3033,$0700,$3032,$07F8,$3031,$07F0
	dw $3030,$FF08,$3023,$FF00,$3022,$FFF8,$3021,$FFF0
	dw $3020,$F708,$3013,$F700,$3012,$F7F8,$3011,$EF08
	dw $3003,$EF00,$3002,$EFF8,$3001,$5050,$5050,$5410

DATA_00DBB0:
	dw $0012,$1808,$3057,$1800,$3056,$18F8,$3055,$1008
	dw $3047,$1000,$3046,$10F8,$3045,$0808,$3037,$0800
	dw $3036,$08F8,$3035,$0008,$3027,$0000,$3026,$00F8
	dw $3025,$F808,$3017,$F800,$3016,$F8F8,$3015,$F008
	dw $3007,$F000,$3006,$F0F8,$3005,$0410,$1041,$5554

DATA_00DC00:
	dw $0018,$1808,$305B,$1800,$305A,$18F8,$3059,$18F0
	dw $3058,$1008,$304B,$1000,$304A,$10F8,$3049,$10F0
	dw $3048,$0808,$303B,$0800,$303A,$08F8,$3039,$08F0
	dw $3038,$0008,$302B,$0000,$302A,$00F8,$3029,$00F0
	dw $3028,$F808,$301B,$F800,$301A,$F8F8,$3019,$F8F0
	dw $3018,$F008,$300B,$F000,$300A,$F0F8,$3009,$F0F0
	dw $3008,$5050,$5050,$5050

DATA_00DC68:
	dw $0012,$1800,$305E,$18F8,$305D,$1808,$305F,$1008
	dw $304F,$1000,$304E,$10F8,$3045,$0808,$3037,$0800
	dw $3036,$08F8,$3035,$0008,$3027,$0000,$3026,$00F8
	dw $3025,$F808,$3017,$F800,$3016,$F8F8,$3015,$F008
	dw $3007,$F000,$3006,$F0F8,$3005,$0404,$1041,$5554

DATA_00DCB8:
	dw $0018,$1808,$30B3,$1800,$30B2,$18F8,$30B1,$18F0
	dw $30B0,$1008,$30A3,$1000,$30A2,$10F8,$30A1,$10F0
	dw $30A0,$0808,$3093,$0800,$3092,$08F8,$3091,$08F0
	dw $3090,$0008,$3083,$0000,$3082,$00F8,$3081,$00F0
	dw $3080,$F808,$3073,$F800,$3072,$F8F8,$3071,$F8F0
	dw $3070,$F008,$3063,$F000,$3062,$F0F8,$3061,$F0F0
	dw $3060,$0000,$0000,$0000

DATA_00DD20:
	dw $001A,$08F8,$301C,$0800,$301D,$0800,$3092,$08F8
	dw $3091,$0000,$300D,$00F8,$300C,$1808,$30B3,$1800
	dw $30B2,$18F8,$30B1,$18F0,$30B0,$1008,$30A3,$1000
	dw $30A2,$10F8,$30A1,$10F0,$30A0,$0808,$3093,$08F0
	dw $3090,$0008,$3083,$00F0,$3080,$F808,$3073,$F800
	dw $3072,$F8F8,$3071,$F8F0,$3070,$F008,$3063,$F000
	dw $3062,$F0F8,$3061,$F0F0,$3060,$0000,$0000,$0000
	dw $5550

DATA_00DD92:
	dw $001C,$1000,$30F8,$10F8,$30F7,$F008,$3063,$0800
	dw $303D,$08F8,$303C,$07E8,$3074,$10F0,$3085,$08F0
	dw $3075,$00F0,$3065,$1008,$3086,$0710,$3077,$0808
	dw $3076,$0008,$3066,$0800,$30B7,$08F8,$3067,$0000
	dw $302D,$00F8,$302C,$1808,$30B3,$1800,$30B2,$18F8
	dw $30B1,$18F0,$30B0,$F808,$3073,$F800,$3072,$F8F8
	dw $3071,$F8F0,$3070,$F000,$3062,$F0F8,$3061,$F0F0
	dw $3060,$5504,$1001,$4141,$5551

DATA_00DE0C:
	dw $001A,$1000,$30F8,$10F8,$30F7,$0000,$3082,$00F8
	dw $3081,$0800,$30B7,$08F8,$3067,$07E8,$3074,$10F0
	dw $3085,$08F0,$3075,$00F0,$3065,$1008,$3086,$0710
	dw $3077,$0808,$3076,$0008,$3066,$1808,$30B3,$1800
	dw $30B2,$18F8,$30B1,$18F0,$30B0,$F808,$3073,$F800
	dw $3072,$F8F8,$3071,$F8F0,$3070,$F008,$3063,$F000
	dw $3062,$F0F8,$3061,$F0F0,$3060,$5444,$0005,$0505
	dw $5555

DATA_00DE7E:
	dw $0018,$0000,$302F,$00F8,$302E,$1808,$30B3,$1800
	dw $30B2,$18F8,$30B1,$18F0,$30B0,$1008,$30A3,$1000
	dw $30A2,$10F8,$30A1,$10F0,$30A0,$0808,$3093,$0800
	dw $3092,$08F8,$3091,$08F0,$3090,$0008,$3083,$00F0
	dw $3080,$F808,$3073,$F800,$3072,$F8F8,$3071,$F8F0
	dw $3070,$F008,$3063,$F000,$3062,$F0F8,$3061,$F0F0
	dw $3060,$0000,$0000,$0000

DATA_00DEE6:
	dw $001C,$08F8,$30AD,$0800,$30AE,$0800,$3092,$08F8
	dw $3091,$1000,$30F8,$10F8,$30F7,$0710,$3077,$1008
	dw $3086,$0808,$3076,$0008,$3066,$07E8,$3074,$10F0
	dw $3085,$08F0,$3075,$00F0,$3065,$0000,$303F,$00F8
	dw $303E,$1808,$30B3,$1800,$30B2,$18F8,$30B1,$18F0
	dw $30B0,$F808,$3073,$F800,$3072,$F8F8,$3071,$F8F0
	dw $3070,$F008,$3063,$F000,$3062,$F0F8,$3061,$F0F0
	dw $3060,$0000,$0000,$0000,$5500

DATA_00DF60:
	dw $001C,$0800,$30BE,$08F8,$30BD,$1008,$3086,$10F0
	dw $3085,$FEE8,$30A4,$FE10,$30A7,$0808,$30B6,$0008
	dw $30A6,$F808,$3096,$08F0,$30B5,$00F0,$30A5,$F8F0
	dw $3095,$1000,$30F8,$10F8,$30F7,$0000,$303F,$00F8
	dw $303E,$1808,$30B3,$1800,$30B2,$18F8,$30B1,$18F0
	dw $30B0,$0800,$3092,$08F8,$3091,$F800,$3072,$F8F8
	dw $3071,$F008,$3063,$F000,$3062,$F0F8,$3061,$F0F0
	dw $3060,$0000,$0000,$0000,$5500

DATA_00DFDA:
	dw $0018,$10F8,$31A5,$0808,$31F3,$0800,$31F2,$08F8
	dw $31F1,$08F0,$31F0,$0008,$31E3,$0000,$31E2,$00F8
	dw $31E1,$00F0,$31E0,$F808,$31D3,$F800,$31D2,$F8F8
	dw $31D1,$F8F0,$31D0,$F008,$31C3,$F000,$31C2,$F0F8
	dw $31C1,$F0F0,$31C0,$1808,$30BB,$1800,$30BA,$18F8
	dw $30B9,$18F0,$30B8,$1008,$30AB,$1000,$30AA,$10F0
	dw $30A8,$0000,$0000,$0000

DATA_00E042:
	dw $001D,$0000,$30BE,$00F8,$30BD,$0000,$3092,$00F8
	dw $3091,$1010,$31BE,$1008,$31BD,$0810,$31AE,$0808
	dw $31AD,$0800,$31AC,$08F0,$3085,$F6E8,$30A4,$F610
	dw $30A7,$0008,$30B6,$F808,$30A6,$F008,$3096,$00F0
	dw $30B5,$F8F0,$30A5,$F0F0,$3095,$08F8,$71BF,$F800
	dw $303F,$F8F8,$303E,$10F6,$30B1,$10EE,$30B0,$F000
	dw $3072,$F0F8,$3071,$E808,$3063,$E800,$3062,$E8F8
	dw $3061,$E8F0,$3060,$0000,$0000,$0000,$4000

DATA_00E0C0:
	dw $001D,$0000,$30BE,$00F8,$30BD,$0000,$3092,$00F8
	dw $3091,$0800,$31BF,$08F8,$31AF,$10E8,$71BE,$08E8
	dw $71AE,$10F0,$71BD,$08F0,$71AD,$0808,$3086,$100A
	dw $30B3,$1002,$30B2,$F6E8,$30A4,$F610,$30A7,$0008
	dw $30B6,$F808,$30A6,$F008,$3096,$00F0,$30B5,$F8F0
	dw $30A5,$F0F0,$3095,$F800,$303F,$F8F8,$303E,$F000
	dw $3072,$F0F8,$3071,$E808,$3063,$E800,$3062,$E8F8
	dw $3061,$E8F0,$3060,$0000,$0000,$0000,$4000

DATA_00E13E:
	dw $0014,$00E8,$31FD,$1008,$31FB,$1000,$31FA,$F000
	dw $31BC,$F0F8,$3012,$E800,$3003,$E8F8,$3002,$F8F0
	dw $307C,$F8E8,$3020,$F0F0,$3011,$E8F0,$3001,$0808
	dw $31ED,$0800,$31EC,$08F8,$31EB,$08F0,$31EA,$0000
	dw $31DC,$00F8,$31DB,$00F0,$31DA,$F800,$31CC,$F8F8
	dw $31CB,$0000,$0000,$5500

DATA_00E196:
	dw $0011,$F808,$31B6,$1808,$31F7,$1800,$31F6,$18F8
	dw $31F5,$18F0,$31F4,$1008,$31E7,$1000,$31E6,$10F8
	dw $31E5,$10F0,$31E4,$0808,$31D7,$0800,$31D6,$08F8
	dw $31D5,$08F0,$31D4,$0008,$31C7,$0000,$31C6,$00F8
	dw $31C5,$00F0,$31C4,$0000,$0000,$5554

DATA_00E1E2:
	dw $0010,$0808,$31D8,$0008,$31C8,$0800,$31F9,$08F8
	dw $31F8,$0000,$31E9,$00F8,$31E8,$F800,$31D9,$1808
	dw $31F7,$1800,$31F6,$18F8,$31F5,$18F0,$31F4,$1008
	dw $31E7,$1000,$31E6,$10F8,$31E5,$10F0,$31E4,$08F0
	dw $31D4,$0000,$0000

DATA_00E228:
	dw $0018,$1000,$30F8,$10F8,$30F7,$1008,$3086,$10F0
	dw $3085,$0008,$31FF,$F808,$31EF,$F800,$31EE,$F8F8
	dw $30DA,$F8F0,$30D9,$F008,$30CC,$F000,$30CB,$F0F8
	dw $30CA,$F0F0,$30C9,$0800,$31DF,$08F8,$31DE,$08F0
	dw $31DD,$0000,$31CF,$00F8,$31CE,$00F0,$31CD,$1808
	dw $30B3,$1800,$30B2,$18F8,$30B1,$18F0,$30B0,$0808
	dw $31FE,$0000,$0000,$0000

DATA_00E290:
	dw $001E,$F010,$71FC,$E808,$71CA,$E810,$71C9,$F0E8
	dw $31FC,$E8F0,$31CA,$E8E8,$31C9,$0808,$30DF,$0008
	dw $30CF,$0800,$30FF,$08F8,$30FE,$08F0,$30FD,$0000
	dw $30EF,$00F8,$30EE,$00F0,$30ED,$1000,$30F8,$10F8
	dw $30F7,$1008,$3086,$10F0,$3085,$F908,$31EF,$F900
	dw $31EE,$F9F8,$30DA,$F9F0,$30D9,$F108,$30CC,$F100
	dw $30CB,$F1F8,$30CA,$F1F0,$30C9,$1808,$30B3,$1800
	dw $30B2,$18F8,$30B1,$18F0,$30B0,$0000,$0000,$0000
	dw $5000

DATA_00E312:
	dw $0016,$17F0,$7053,$17F8,$7052,$1700,$7051,$1708
	dw $7050,$0FF0,$7043,$0FF8,$7042,$0F00,$7041,$0F08
	dw $7040,$07F0,$7033,$07F8,$7032,$0700,$7031,$0708
	dw $7030,$FFF0,$7023,$FFF8,$7022,$FF00,$7021,$FF08
	dw $7020,$F7F0,$7013,$F7F8,$7012,$F700,$7011,$EFF0
	dw $7003,$EFF8,$7002,$EF00,$7001,$0505,$0505,$5145

DATA_00E372:
	dw $0012,$18F0,$7057,$18F8,$7056,$1800,$7055,$10F0
	dw $7047,$10F8,$7046,$1000,$7045,$08F0,$7037,$08F8
	dw $7036,$0800,$7035,$00F0,$7027,$00F8,$7026,$0000
	dw $7025,$F8F0,$7017,$F8F8,$7016,$F800,$7015,$F0F0
	dw $7007,$F0F8,$7006,$F000,$7005,$5145,$4514,$5551

DATA_00E3C2:
	dw $0018,$18F0,$705B,$18F8,$705A,$1800,$7059,$1808
	dw $7058,$10F0,$704B,$10F8,$704A,$1000,$7049,$1008
	dw $7048,$08F0,$703B,$08F8,$703A,$0800,$7039,$0808
	dw $7038,$00F0,$702B,$00F8,$702A,$0000,$7029,$0008
	dw $7028,$F8F0,$701B,$F8F8,$701A,$F800,$7019,$F808
	dw $7018,$F0F0,$700B,$F0F8,$700A,$F000,$7009,$F008
	dw $7008,$0505,$0505,$0505

DATA_00E42A:
	dw $0012,$18F8,$705E,$1800,$705D,$18F0,$705F,$10F0
	dw $704F,$10F8,$704E,$1000,$7045,$08F0,$7037,$08F8
	dw $7036,$0800,$7035,$00F0,$7027,$00F8,$7026,$0000
	dw $7025,$F8F0,$7017,$F8F8,$7016,$F800,$7015,$F0F0
	dw $7007,$F0F8,$7006,$F000,$7005,$5151,$4514,$5551

DATA_00E47A:
	dw $0019,$1000,$30F8,$0808,$30B6,$0010,$30DE,$0008
	dw $30DD,$F808,$30CE,$F800,$30CD,$0800,$30FB,$08F8
	dw $30FA,$0000,$30EB,$00F8,$30EA,$00F0,$30E9,$F8F8
	dw $30DA,$F8F0,$30D9,$F008,$30CC,$F000,$30CB,$F0F8
	dw $30CA,$F0F0,$30C9,$10F0,$30A0,$08F0,$3090,$1008
	dw $3086,$1808,$30B3,$1800,$30B2,$18F8,$30B1,$18F0
	dw $30B0,$10F8,$30A1,$0000,$0000,$0000,$5554

DATA_00E4E8:
	dw $001F,$070F,$3705,$F8DF,$3750,$F0DF,$3740,$1807
	dw $3754,$18FF,$3753,$18F7,$3752,$18EF,$3751,$1007
	dw $3744,$10FF,$3743,$10F7,$3742,$10EF,$3741,$0807
	dw $3734,$08FF,$3733,$08F7,$3732,$08EF,$3731,$08E7
	dw $3730,$0007,$3724,$00FF,$3723,$00F7,$3722,$00EF
	dw $3721,$00E7,$3720,$F807,$3714,$F8FF,$3713,$F8F7
	dw $3712,$F8EF,$3711,$F8E7,$3710,$F007,$3704,$F0FF
	dw $3703,$F0F7,$3702,$F0EF,$3701,$F0E7,$3700,$1514
	dw $5515,$5154,$5545

DATA_00E56E:
	dw $001D,$F9E1,$3755,$F1E8,$3746,$F1E0,$3745,$1809
	dw $3759,$1801,$3758,$18F9,$3757,$18F1,$3756,$1009
	dw $3749,$1001,$3748,$10F9,$3747,$0909,$3739,$0901
	dw $3738,$09F9,$3737,$09F1,$3736,$09E9,$3735,$0109
	dw $3729,$0101,$3728,$01F9,$3727,$01F1,$3726,$01E9
	dw $3725,$F909,$3719,$F901,$3718,$F9F9,$3717,$F9F1
	dw $3716,$F9E9,$3715,$F109,$3709,$F101,$3708,$F1F9
	dw $3707,$F1F1,$3706,$1415,$1504,$5054,$5541

DATA_00E5EC:
	dw $001A,$09E7,$371B,$01E7,$370B,$01EF,$372A,$F9EF
	dw $371A,$F907,$3714,$F9FF,$3713,$F9F7,$3712,$F107
	dw $3704,$F1FF,$3703,$F1F7,$3702,$F1EF,$3701,$1807
	dw $375D,$18FF,$375C,$18F7,$375B,$18EF,$375A,$1007
	dw $374D,$10FF,$374C,$10F7,$374B,$10EF,$374A,$0907
	dw $373D,$09FF,$373C,$09F7,$373B,$09EF,$373A,$0107
	dw $372D,$01FF,$372C,$01F7,$372B,$1455,$1515,$1515
	dw $5555

DATA_00E65E:
	dw $001A,$08E7,$371B,$00E7,$370B,$F8EE,$371A,$F806
	dw $3714,$F8FE,$3713,$F8F6,$3712,$F006,$3704,$F0FE
	dw $3703,$F0F6,$3702,$F0EE,$3701,$1806,$371F,$18FE
	dw $371E,$1006,$370F,$10FE,$370E,$0806,$371D,$08FE
	dw $371C,$0006,$370D,$00FE,$370C,$18F6,$375F,$18EE
	dw $375E,$10F6,$374F,$10EE,$374E,$08F6,$373F,$08EE
	dw $373E,$00F6,$372F,$00EE,$372E,$4515,$4445,$5554
	dw $5555

DATA_00E6D0:
	dw $0018,$1808,$31B3,$1800,$31B2,$18F8,$31B1,$18F0
	dw $31B0,$1008,$31A3,$1000,$31A2,$10F8,$31A1,$10F0
	dw $31A0,$0808,$3193,$0800,$3192,$08F8,$3191,$08F0
	dw $3190,$0008,$3183,$0000,$3182,$00F8,$3181,$00F0
	dw $3180,$F808,$3173,$F800,$3172,$F8F8,$3171,$F8F0
	dw $3170,$F008,$3163,$F000,$3162,$F0F8,$3161,$F0F0
	dw $3160,$5050,$5050,$5050

DATA_00E738:
	dw $0018,$1008,$3166,$1808,$3165,$1800,$3164,$18F8
	dw $31B1,$18F0,$31B0,$1000,$31A2,$10F8,$31A1,$10F0
	dw $31A0,$0808,$3193,$0800,$3192,$08F8,$3191,$08F0
	dw $3190,$0008,$3183,$0000,$3182,$00F8,$3181,$00F0
	dw $3180,$F808,$3173,$F800,$3172,$F8F8,$3171,$F8F0
	dw $3170,$F008,$3163,$F000,$3162,$F0F8,$3161,$F0F0
	dw $3160,$5140,$5050,$5050

DATA_00E7A0:
	dw $001B,$0810,$3167,$1808,$31BB,$1800,$31BA,$18F8
	dw $31B9,$18F0,$31B8,$18E8,$31B7,$1008,$31AB,$1000
	dw $31AA,$10F8,$31A9,$10F0,$31A8,$10E8,$31A7,$0808
	dw $319B,$0800,$319A,$08F8,$3199,$08F0,$3198,$0008
	dw $318B,$0000,$318A,$00F8,$3189,$00F0,$3188,$F808
	dw $317B,$F800,$317A,$F8F8,$3179,$F8F0,$3178,$F008
	dw $316B,$F000,$316A,$F0F8,$3169,$F0F0,$3168,$0540
	dw $1415,$1414,$5554

DATA_00E816:
	dw $001F,$0800,$301D,$08F8,$301C,$0000,$300D,$00F8
	dw $300C,$0810,$3167,$1808,$31BB,$1800,$31BA,$18F8
	dw $31B9,$18F0,$31B8,$18E8,$31B7,$1008,$31AB,$1000
	dw $31AA,$10F8,$31A9,$10F0,$31A8,$10E8,$31A7,$0808
	dw $319B,$0800,$319A,$08F8,$3199,$08F0,$3198,$0008
	dw $318B,$0000,$318A,$00F8,$3189,$00F0,$3188,$F808
	dw $317B,$F800,$317A,$F8F8,$3179,$F8F0,$3178,$F008
	dw $316B,$F000,$316A,$F0F8,$3169,$F0F0,$3168,$4044
	dw $1505,$1414,$5414

DATA_00E89C:
	dw $001F,$0800,$301F,$08F8,$301E,$0000,$300F,$00F8	
	dw $300E,$0810,$3167,$1808,$31BB,$1800,$31BA,$18F8
	dw $31B9,$18F0,$31B8,$18E8,$31B7,$1008,$31AB,$1000
	dw $31AA,$10F8,$31A9,$10F0,$31A8,$10E8,$31A7,$0808
	dw $319B,$0800,$319A,$08F8,$3199,$08F0,$3198,$0008
	dw $318B,$0000,$318A,$00F8,$3189,$00F0,$3188,$F808
	dw $317B,$F800,$317A,$F8F8,$3179,$F8F0,$3178,$F008
	dw $316B,$F000,$316A,$F0F8,$3169,$F0F0,$3168,$4044
	dw $1505,$1414,$5414

DATA_00E922:
	dw $001B,$0810,$3167,$0808,$319F,$0800,$319E,$08F8
	dw $319D,$08F0,$319C,$0008,$318F,$0000,$318E,$00F8
	dw $318D,$00F0,$318C,$F808,$317F,$F800,$317E,$F8F8
	dw $317D,$F8F0,$317C,$F008,$316F,$F000,$316E,$F0F8
	dw $316D,$F0F0,$316C,$1808,$31BB,$1800,$31BA,$18F8
	dw $31B9,$18F0,$31B8,$18E8,$31B7,$1008,$31AB,$1000
	dw $31AA,$10F8,$31A9,$10F0,$31A8,$10E8,$31A7,$4140
	dw $4141,$0541,$5555

DATA_00E998:
	dw $001B,$10E8,$31B4,$08E8,$31A4,$1808,$31BB,$1800
	dw $31BA,$18F8,$31B9,$18F0,$31B8,$18E8,$31B7,$1008
	dw $3197,$1000,$3196,$10F8,$3195,$10F0,$3194,$0808
	dw $3187,$0800,$3186,$08F8,$3185,$08F0,$3184,$0008
	dw $3177,$0000,$3176,$00F8,$3175,$00F0,$3174,$F808
	dw $317F,$F800,$317E,$F8F8,$317D,$F8F0,$317C,$F008
	dw $316F,$F000,$316E,$F0F8,$316D,$F0F0,$316C,$1505
	dw $1414,$1414,$5554

DATA_00EA0E:
	dw $001F,$07E8,$7705,$F818,$7750,$F018,$7740,$18F0
	dw $7754,$18F8,$7753,$1800,$7752,$1808,$7751,$10F0
	dw $7744,$10F8,$7743,$1000,$7742,$1008,$7741,$08F0
	dw $7734,$08F8,$7733,$0800,$7732,$0808,$7731,$0810
	dw $7730,$00F0,$7724,$00F8,$7723,$0000,$7722,$0008
	dw $7721,$0010,$7720,$F8F0,$7714,$F8F8,$7713,$F800
	dw $7712,$F808,$7711,$F810,$7710,$F0F0,$7704,$F0F8
	dw $7703,$F000,$7702,$F008,$7701,$F010,$7700,$4141
	dw $0141,$1405,$4050

DATA_00EA94:
	dw $001D,$F818,$7755,$F011,$7746,$F019,$7745,$18F0
	dw $7759,$18F8,$7758,$1800,$7757,$1808,$7756,$10F0
	dw $7749,$10F8,$7748,$1000,$7747,$08F0,$7739,$08F8
	dw $7738,$0800,$7737,$0808,$7736,$0810,$7735,$00F0
	dw $7729,$00F8,$7728,$0000,$7727,$0008,$7726,$0010
	dw $7725,$F8F0,$7719,$F8F8,$7718,$F800,$7717,$F808
	dw $7716,$F810,$7715,$F0F0,$7709,$F0F8,$7708,$F000
	dw $7707,$F008,$7706,$4140,$4051,$0501,$5414

DATA_00EB12:
	dw $001A,$0810,$771B,$0010,$770B,$0008,$772A,$F808
	dw $771A,$F8F0,$7714,$F8F8,$7713,$F800,$7712,$F0F0
	dw $7704,$F0F8,$7703,$F000,$7702,$F008,$7701,$18F0
	dw $775D,$18F8,$775C,$1800,$775B,$1808,$775A,$10F0
	dw $774D,$10F8,$774C,$1000,$774B,$1008,$774A,$08F0
	dw $773D,$08F8,$773C,$0800,$773B,$0808,$773A,$00F0
	dw $772D,$00F8,$772C,$0000,$772B,$4500,$4141,$4141
	dw $5551

DATA_00EB84:
	dw $001A,$080F,$771B,$000F,$770B,$F808,$771A,$F8F0
	dw $7714,$F8F8,$7713,$F800,$7712,$F0F0,$7704,$F0F8
	dw $7703,$F000,$7702,$F008,$7701,$18F0,$771F,$18F8
	dw $771E,$10F0,$770F,$10F8,$770E,$08F0,$771D,$08F8
	dw $771C,$00F0,$770D,$00F8,$770C,$1800,$775F,$1808
	dw $775E,$1000,$774F,$1008,$774E,$0800,$773F,$0808
	dw $773E,$0000,$772F,$0008,$772E,$5140,$5550,$0005
	dw $5550

DATA_00EBF6:
	dw $0017,$10F8,$30F7,$FFE8,$30C0,$F808,$3013,$F800
	dw $3012,$F8F8,$3011,$F008,$3003,$F000,$3002,$F0F8
	dw $3001,$1008,$30A3,$1000,$30A2,$0808,$3093,$0800
	dw $3092,$0008,$30C4,$0000,$30C3,$08F8,$30D2,$08F0
	dw $30D1,$00F8,$30C2,$00F0,$30C1,$10F0,$3085,$1808
	dw $30B3,$1800,$30B2,$18F8,$30B1,$18F0,$30B0,$0505
	dw $0005,$5155,$5555

DATA_00EC5C:
	dw $0019,$10F8,$30F7,$08F8,$3067,$0800,$3092,$00F0
	dw $3084,$0008,$3083,$0000,$3082,$00F8,$3081,$F808
	dw $3073,$F800,$3072,$F8F8,$3071,$F8F0,$3070,$F008
	dw $3063,$F000,$3062,$F0F8,$3061,$F0F0,$3060,$FFE8
	dw $30C0,$1008,$30A3,$1000,$30A2,$0808,$3093,$08F0
	dw $30D1,$10F0,$3085,$1808,$30B3,$1800,$30B2,$18F8
	dw $30B1,$18F0,$30B0,$1045,$5414,$4140,$5555

DATA_00ECCA:
	dw $0018,$10F8,$30F7,$1000,$30F8,$0000,$30D7,$00F8
	dw $30D6,$F800,$30C7,$F8F8,$30C6,$08F8,$30F6,$0008
	dw $30E7,$00F0,$30E6,$F808,$3013,$F008,$3003,$F000
	dw $3002,$F0F8,$3001,$0800,$30B7,$07E8,$3074,$10F0
	dw $3085,$08F0,$3075,$1008,$3086,$0710,$3077,$0808
	dw $3076,$1808,$30B3,$1800,$30B2,$18F8,$30B1,$18F0
	dw $30B0,$1441,$1411,$5015,$5555

DATA_00ED34:
	dw $0019,$1000,$30F8,$10F8,$30F7,$FE10,$30A7,$FEE8
	dw $30A4,$0008,$30D8,$0000,$30D7,$00F8,$30D6,$00F0
	dw $30D5,$F808,$30C8,$F800,$30C7,$F8F8,$30C6,$F8F0
	dw $30C5,$0808,$30B6,$08F0,$30B5,$08F8,$30F6,$F008
	dw $3003,$F000,$3002,$F0F8,$3001,$0800,$30B7,$10F0
	dw $3085,$1008,$3086,$1808,$30B3,$1800,$30B2,$18F8
	dw $30B1,$18F0,$30B0,$5044,$1450,$4044,$5555

DATA_00EDA2:
	dw $0017,$1808,$30BB,$1800,$30BA,$18F8,$30B9,$18F0
	dw $30B8,$1008,$30AB,$1000,$30AA,$10F8,$30A9,$10F0
	dw $30A8,$0808,$309B,$0800,$309A,$08F8,$3099,$08F0
	dw $3098,$0008,$308B,$0000,$308A,$00F8,$3089,$00F0
	dw $3088,$F808,$307B,$F800,$307A,$F8F8,$3079,$F8F0
	dw $3078,$F008,$306B,$F000,$306A,$F0F8,$3069,$5050
	dw $5050,$5050

DATA_00EE06:
	dw $001A,$F000,$30D7,$F0F8,$30D6,$E800,$30C7,$E8F8
	dw $30C6,$0810,$30F5,$0808,$30F4,$08F0,$30F1,$08E8
	dw $30F0,$0010,$30E5,$0008,$30E4,$0000,$30E3,$00F8
	dw $30E2,$00F0,$30E1,$00E8,$30E0,$F8F8,$30F6,$F008
	dw $30E7,$F0F0,$30E6,$E808,$3013,$E008,$3003,$E000
	dw $3002,$E0F8,$3001,$F800,$30B7,$F7E8,$3074,$F8F0
	dw $3075,$F710,$3077,$F808,$3076,$5044,$1540,$5411
	dw $5505

DATA_00EE78:
	dw $0017,$18F0,$70BB,$18F8,$70BA,$1800,$70B9,$1808
	dw $70B8,$10F0,$70AB,$10F8,$70AA,$1000,$70A9,$1008
	dw $70A8,$08F0,$709B,$08F8,$709A,$0800,$7099,$0808
	dw $7098,$00F0,$708B,$00F8,$708A,$0000,$7089,$0008
	dw $7088,$F8F0,$707B,$F8F8,$707A,$F800,$7079,$F808
	dw $7078,$F0F0,$706B,$F0F8,$706A,$F000,$7069,$0505
	dw $0505,$4505

DATA_00EEDC:
	dw $0012,$0000,$3400,$0008,$3444,$0010,$3464,$0800
	dw $3410,$0808,$3454,$0810,$34B4,$0010,$3054,$00F8
	dw $3254,$0008,$3010,$F808,$3000,$00F0,$3210,$F8F0
	dw $3200,$0018,$30B4,$F818,$3064,$F810,$3044,$0000
	dw $32B4,$F800,$3264,$F8F8,$3244,$5414,$0055,$5554

DATA_00EF2C:
	dw $0012,$0000,$34D0,$0008,$34D4,$0010,$3424,$0800
	dw $34F2,$0808,$34F3,$0810,$3434,$0018,$3034,$F818
	dw $3024,$0000,$3234,$F800,$3224,$F808,$30D0,$0010
	dw $30F3,$0008,$30F2,$F810,$30D4,$F8F0,$32D0,$00F8
	dw $32F3,$00F0,$32F2,$F8F8,$32D4,$5500,$5005,$5555

DATA_00EF7C:
	dw $0028,$1808,$3374,$1800,$3373,$18F8,$3372,$18F0
	dw $3371,$18E8,$3370,$1008,$3364,$1000,$3363,$10F8
	dw $3362,$10F0,$3361,$10E8,$3360,$0808,$3354,$0800
	dw $3353,$08F8,$3352,$08F0,$3351,$08E8,$3350,$0008
	dw $3344,$0000,$3343,$00F8,$3342,$00F0,$3341,$00E8
	dw $3340,$F808,$3334,$F800,$3333,$F8F8,$3332,$F8F0
	dw $3331,$F8E8,$3330,$F008,$3324,$F000,$3323,$F0F8
	dw $3322,$F0F0,$3321,$F0E8,$3320,$E808,$3314,$E800
	dw $3313,$E8F8,$3312,$E8F0,$3311,$E8E8,$3310,$E008
	dw $3304,$E000,$3303,$E0F8,$3302,$E0F0,$3301,$E0E8
	dw $3300,$4150,$1505,$5054,$0541,$5415

DATA_00F028:
	dw $0028,$1808,$3379,$1800,$3378,$18F8,$3377,$18F0
	dw $3376,$18E8,$3375,$1008,$3369,$1000,$3368,$10F8
	dw $3367,$10F0,$3366,$10E8,$3365,$0808,$3359,$0800
	dw $3358,$08F8,$3357,$08F0,$3356,$08E8,$3355,$0008
	dw $3349,$0000,$3348,$00F8,$3347,$00F0,$3346,$00E8
	dw $3345,$F808,$3339,$F800,$3338,$F8F8,$3337,$F8F0
	dw $3336,$F8E8,$3335,$F008,$3329,$F000,$3328,$F0F8
	dw $3327,$F0F0,$3326,$F0E8,$3325,$E808,$3319,$E800
	dw $3318,$E8F8,$3317,$E8F0,$3316,$E8E8,$3315,$E008
	dw $3309,$E000,$3308,$E0F8,$3307,$E0F0,$3306,$E0E8
	dw $3305,$4150,$1505,$5054,$0541,$5415

DATA_00F0D4:
	dw $001C,$1008,$3086,$10F0,$3085,$0810,$71B0,$0010
	dw $71A0,$0808,$71B1,$0008,$71A1,$08F0,$31B1,$08E8
	dw $31B0,$00F0,$31A1,$00E8,$31A0,$0000,$3191,$00F8
	dw $3190,$F800,$3181,$F8F8,$3180,$1808,$30B3,$1800
	dw $30B2,$18F8,$30B1,$18F0,$30B0,$1000,$30A2,$10F8
	dw $30A1,$0800,$3092,$08F8,$3091,$F808,$3073,$F8F0
	dw $3070,$F008,$3063,$F000,$3062,$F0F8,$3061,$F0F0
	dw $3060,$5004,$0445,$4445,$5550

DATA_00F14E:
	dw $001C,$1000,$30F8,$10F8,$30F7,$0900,$301D,$09F8
	dw $301C,$0900,$30B7,$09F8,$3067,$0100,$300D,$01F8
	dw $300C,$F900,$304D,$F9F8,$304C,$08E8,$3074,$10F0
	dw $3085,$09F0,$3075,$01F0,$3065,$1008,$3086,$0810
	dw $3077,$0908,$3076,$0108,$3066,$1808,$30B3,$1800
	dw $30B2,$18F8,$30B1,$18F0,$30B0,$F908,$3073,$F9F0
	dw $3070,$F108,$3063,$F100,$3062,$F1F8,$3061,$F1F0
	dw $3060,$4444,$0554,$4500,$5550

DATA_00F1C8:
	dw $001C,$1000,$30F8,$10F8,$30F7,$0800,$303D,$08F8
	dw $303C,$0800,$30B7,$08F8,$3067,$0000,$302D,$00F8
	dw $302C,$F800,$304D,$F8F8,$304C,$07E8,$3074,$10F0
	dw $3085,$08F0,$3075,$00F0,$3065,$1008,$3086,$0710
	dw $3077,$0808,$3076,$0008,$3066,$1808,$30B3,$1800
	dw $30B2,$18F8,$30B1,$18F0,$30B0,$F808,$3073,$F8F0
	dw $3070,$F008,$3063,$F000,$3062,$F0F8,$3061,$F0F0
	dw $3060,$4444,$0554,$4500,$5550

DATA_00F242:
	dw $001A,$1000,$30F8,$10F8,$30F7,$0000,$3082,$00F8
	dw $3081,$0800,$30B7,$08F8,$3067,$F800,$304D,$F8F8
	dw $304C,$07E8,$3074,$10F0,$3085,$08F0,$3075,$00F0
	dw $3065,$1008,$3086,$0710,$3077,$0808,$3076,$0008
	dw $3066,$1808,$30B3,$1800,$30B2,$18F8,$30B1,$18F0
	dw $30B0,$F808,$3073,$F8F0,$3070,$F008,$3063,$F000
	dw $3062,$F0F8,$3061,$F0F0,$3060,$4444,$0055,$0450
	dw $5555

DATA_00F2B4:
	dw $0034,$1010,$32BF,$0810,$32AF,$0010,$329F,$F810
	dw $328F,$F010,$327F,$E810,$326F,$1808,$337F,$1800
	dw $337E,$18F8,$337D,$18F0,$337C,$18E8,$337B,$1008
	dw $336F,$1000,$336E,$10F8,$336D,$10F0,$336C,$10E8
	dw $336B,$10E0,$336A,$0808,$335F,$0800,$335E,$08F8
	dw $335D,$08F0,$335C,$08E8,$335B,$08E0,$335A,$0008
	dw $334F,$0000,$334E,$00F8,$334D,$00F0,$334C,$00E8
	dw $334B,$00E0,$334A,$F808,$333F,$F800,$333E,$F8F8
	dw $333D,$F8F0,$333C,$F8E8,$333B,$F8E0,$333A,$F008
	dw $332F,$F000,$332E,$F0F8,$332D,$F0F0,$332C,$F0E8
	dw $332B,$F0E0,$332A,$E808,$331F,$E800,$331E,$E8F8
	dw $331D,$E8F0,$331C,$E8E8,$331B,$E8E0,$331A,$E008
	dw $330F,$E000,$330E,$E0F8,$330D,$E0F0,$330C,$E0E8
	dw $330B,$0000,$5415,$1541,$4154,$5415,$1541,$5554

DATA_00F394:
	dw $001C,$1100,$30F8,$11F8,$30F7,$0900,$301F,$09F8
	dw $301E,$0900,$30B7,$09F8,$3067,$0100,$300F,$01F8
	dw $300E,$F900,$304D,$F9F8,$304C,$08E8,$3074,$11F0
	dw $3085,$09F0,$3075,$01F0,$3065,$1108,$3086,$0810
	dw $3077,$0908,$3076,$0108,$3066,$1908,$30B3,$1900
	dw $30B2,$19F8,$30B1,$19F0,$30B0,$F908,$3073,$F9F0
	dw $3070,$F108,$3063,$F100,$3062,$F1F8,$3061,$F1F0
	dw $3060,$4444,$0554,$4500,$5550

DATA_00F40E:
	dw $001C,$1000,$30F8,$10F8,$30F7,$0800,$301F,$08F8
	dw $301E,$0800,$30B7,$08F8,$3067,$0000,$300F,$00F8
	dw $300E,$F800,$304D,$F8F8,$304C,$07E8,$3074,$10F0
	dw $3085,$08F0,$3075,$00F0,$3065,$1008,$3086,$0710
	dw $3077,$0808,$3076,$0008,$3066,$1808,$30B3,$1800
	dw $30B2,$18F8,$30B1,$18F0,$30B0,$F808,$3073,$F8F0
	dw $3070,$F008,$3063,$F000,$3062,$F0F8,$3061,$F0F0
	dw $3060,$4444,$0554,$4500,$5550

DATA_00F488:
	dw $0018,$1000,$30F8,$0808,$30FC,$0800,$30FB,$08F8
	dw $30FA,$0008,$30EC,$0000,$30EB,$00F8,$30EA,$00F0
	dw $30E9,$F808,$30DC,$F800,$30DB,$F8F8,$30DA,$F8F0
	dw $30D9,$F008,$30CC,$F000,$30CB,$F0F8,$30CA,$F0F0
	dw $30C9,$10F0,$30A0,$08F0,$3090,$1008,$3086,$1808
	dw $30B3,$1800,$30B2,$18F8,$30B1,$18F0,$30B0,$10F8
	dw $30A1,$5040,$5050,$5405

DATA_00F4F0:
	dw $000E,$1810,$35D6,$1808,$35D5,$1800,$35D4,$18F8
	dw $35D3,$1010,$35F3,$1008,$35F2,$1000,$35F1,$10F8
	dw $35F0,$0808,$35E2,$0800,$35E1,$08F8,$35E0,$0008
	dw $35D2,$0000,$35D1,$00F8,$35D0,$0000,$5000

DATA_00F52E:
	dw $000E,$1810,$35DD,$1808,$35DC,$1800,$35DB,$18F8
	dw $35DA,$1010,$35FA,$1008,$35F9,$1000,$35F8,$10F8
	dw $35F7,$0808,$35F6,$0800,$35F5,$08F8,$35F4,$0008
	dw $35E6,$0000,$35E5,$00F8,$35E4,$0000,$5000

DATA_00F56C:
	dw $0014,$08F0,$35DF,$00F0,$35CF,$08E8,$35BF,$00E8
	dw $35AF,$08E0,$359F,$00E0,$358F,$1810,$35D6,$1808
	dw $35D5,$1800,$35D4,$18F8,$35D3,$1010,$35F3,$1008
	dw $35F2,$1000,$35F1,$10F8,$35F0,$0808,$35E9,$0800
	dw $35E8,$08F8,$35E7,$0008,$35D9,$0000,$35D8,$00F8
	dw $35D7,$0555,$0000,$5500

DATA_00F5C4:
	dw $0014,$07F8,$35FE,$07F0,$35FD,$07E8,$35FC,$07E0
	dw $35FB,$FFF8,$35EE,$FFF0,$35ED,$FFE8,$35EC,$FFE0
	dw $35EB,$1710,$35DD,$1708,$35DC,$1700,$35DB,$17F8
	dw $35DA,$0F10,$35FA,$0F08,$35F9,$0F00,$35F8,$0FF8
	dw $35F7,$0708,$35E9,$0700,$35E8,$FF08,$35D9,$FF00
	dw $35D8,$5454,$0000,$5500

DATA_00F61C:
	dw $0018,$08F8,$3097,$0800,$3087,$1000,$30F8,$10F8
	dw $30F7,$10F0,$3085,$1008,$3086,$00F8,$70D7,$0000
	dw $70D6,$F8F8,$70C7,$F800,$70C6,$00F0,$70E7,$0008
	dw $70E6,$F8F0,$7013,$F0F0,$7003,$F0F8,$7002,$F000
	dw $7001,$0710,$7074,$0808,$7075,$07E8,$7077,$08F0
	dw $7076,$1808,$30B3,$1800,$30B2,$18F8,$30B1,$18F0
	dw $30B0,$5145,$5115,$5501,$5555

DATA_00F686:
	dw $0019,$08F8,$3097,$0800,$3087,$10F0,$3085,$1000
	dw $30F8,$10F8,$30F7,$1008,$3086,$1808,$30B3,$1800
	dw $30B2,$18F8,$30B1,$18F0,$30B0,$FEE8,$70A7,$FE10
	dw $70A4,$00F0,$70D8,$00F8,$70D7,$0000,$70D6,$0008
	dw $70D5,$F8F0,$70C8,$F8F8,$70C7,$F800,$70C6,$F808
	dw $70C5,$08F0,$70B6,$0808,$70B5,$F0F0,$7003,$F0F8
	dw $7002,$F000,$7001,$0115,$1515,$5115,$5555

DATA_00F6F4:
	dw $000E,$18E0,$75D6,$18E8,$75D5,$18F0,$75D4,$18F8
	dw $75D3,$10E0,$75F3,$10E8,$75F2,$10F0,$75F1,$10F8
	dw $75F0,$08E8,$75E2,$08F0,$75E1,$08F8,$75E0,$00E8
	dw $75D2,$00F0,$75D1,$00F8,$75D0,$5555,$5555

DATA_00F732:
	dw $000E,$18E0,$75DD,$18E8,$75DC,$18F0,$75DB,$18F8
	dw $75DA,$10E0,$75FA,$10E8,$75F9,$10F0,$75F8,$10F8
	dw $75F7,$08E8,$75F6,$08F0,$75F5,$08F8,$75F4,$00E8
	dw $75E6,$00F0,$75E5,$00F8,$75E4,$5555,$5555

DATA_00F770:
	dw $0014,$0800,$75DF,$0000,$75CF,$0808,$75BF,$0008
	dw $75AF,$0810,$759F,$0010,$758F,$18E0,$75D6,$18E8
	dw $75D5,$18F0,$75D4,$18F8,$75D3,$10E0,$75F3,$10E8
	dw $75F2,$10F0,$75F1,$10F8,$75F0,$08E8,$75E9,$08F0
	dw $75E8,$08F8,$75E7,$00E8,$75D9,$00F0,$75D8,$00F8
	dw $75D7,$5000,$5555,$5555

DATA_00F7C8:
	dw $0014,$07F8,$75FE,$0700,$75FD,$0708,$75FC,$0710
	dw $75FB,$FFF8,$75EE,$FF00,$75ED,$FF08,$75EC,$FF10
	dw $75EB,$17E0,$75DD,$17E8,$75DC,$17F0,$75DB,$17F8
	dw $75DA,$0FE0,$75FA,$0FE8,$75F9,$0FF0,$75F8,$0FF8
	dw $75F7,$07E8,$75E9,$07F0,$75E8,$FFE8,$75D9,$FFF0
	dw $75D8,$0101,$5555,$5555

DATA_00F820:
	dw $0016,$08F8,$308D,$0800,$309E,$1808,$30B3,$1800
	dw $30B2,$18F8,$30B1,$18F0,$30B0,$1008,$30A3,$1000
	dw $30A2,$10F8,$30A1,$10F0,$30A0,$FF08,$70E8,$0808
	dw $7090,$F8F0,$7013,$F8F8,$7012,$F800,$7011,$F0F0
	dw $7003,$F0F8,$7002,$F000,$7001,$08F0,$7093,$00F0
	dw $70C4,$00F8,$70C3,$0000,$70C2,$0505,$1505,$5555

DATA_00F880:
	dw $0016,$1808,$30B3,$1800,$30B2,$18F8,$30B1,$18F0
	dw $30B0,$1008,$30A3,$1000,$30A2,$10F8,$30A1,$10F0
	dw $30A0,$FFF0,$30E8,$08F8,$30F9,$08F0,$3090,$F808
	dw $3013,$F800,$3012,$F8F8,$3011,$F008,$3003,$F000
	dw $3002,$F0F8,$3001,$0808,$3093,$0800,$3092,$0008
	dw $30C4,$0000,$30C3,$00F8,$30C2,$5050,$1415,$5414

DATA_00F8E0:
	dw $0017,$0808,$3544,$0800,$3543,$08F8,$3542,$08F0
	dw $3541,$0008,$3534,$0000,$3533,$00F8,$3532,$00F0
	dw $3531,$00E8,$3530,$F808,$3524,$F800,$3523,$F8F8
	dw $3522,$F8F0,$3521,$F8E8,$3520,$F008,$3514,$F000
	dw $3513,$F0F8,$3512,$F0F0,$3511,$F0E8,$3510,$E808
	dw $3504,$E800,$3503,$E8F8,$3502,$E8F0,$3501,$5050
	dw $0541,$5415

DATA_00F944:
	dw $0017,$0808,$3549,$0800,$3548,$08F8,$3547,$08F0
	dw $3546,$0008,$3539,$0000,$3538,$00F8,$3537,$00F0
	dw $3536,$00E8,$3535,$F808,$3529,$F800,$3528,$F8F8
	dw $3527,$F8F0,$3526,$F8E8,$3525,$F008,$3519,$F000
	dw $3518,$F0F8,$3517,$F0F0,$3516,$F0E8,$3515,$E808
	dw $3509,$E800,$3508,$E8F8,$3507,$E8F0,$3506,$5050
	dw $0541,$5415

DATA_00F9A8:
	dw $0017,$0800,$354D,$08F8,$354C,$08F0,$354B,$08E8
	dw $354A,$0008,$353E,$0000,$353D,$00F8,$353C,$00F0
	dw $353B,$00E8,$353A,$F808,$352E,$F800,$352D,$F8F8
	dw $352C,$F8F0,$352B,$F8E8,$352A,$F008,$351E,$F000
	dw $351D,$F0F8,$351C,$F0F0,$351B,$F0E8,$351A,$E800
	dw $350D,$E8F8,$350C,$E8F0,$350B,$E8E8,$350A,$5054
	dw $0541,$5515

DATA_00FA0C:
	dw $0004,$0000,$3583,$0800,$3593,$1000,$35A3,$1800
	dw $35B3,$5500

DATA_00FA20:
	dw $0004,$0000,$3582,$0800,$3592,$1000,$35A2,$1800
	dw $35B2,$5500

DATA_00FA34:
	dw $0004,$0000,$3584,$0800,$3594,$1000,$35A4,$1800
	dw $35B4,$5500

DATA_00FA48:
	dw $0004,$0000,$350A,$0800,$35A6,$0008,$750A,$0808
	dw $75A6,$5500

DATA_00FA5C:
	dw $0010,$0000,$3389,$0008,$338A,$0010,$338B,$0018
	dw $338C,$0800,$3399,$0808,$339A,$0810,$339B,$0818
	dw $339C,$1000,$33A9,$1008,$33AA,$1010,$33AB,$1018
	dw $33AC,$1800,$33B9,$1808,$33BA,$1810,$33BB,$1818
	dw $33BC,$0000,$0000

DATA_00FAA2:
	dw $0008,$F800,$39F1,$F808,$39F2,$00F8,$39F3,$0000
	dw $39F4,$0008,$39F5,$08F8,$39F6,$0800,$39F7,$0808
	dw $39F8,$0000

DATA_00FAC6:
	dw $0008,$F800,$39F1,$F808,$39F2,$00F8,$39F3,$0000
	dw $39F4,$0008,$39F5,$08F8,$39F6,$0800,$39FB,$0808
	dw $39F8,$0000

DATA_00FAEA:
	dw $0008,$F800,$39F1,$F808,$39F2,$00F8,$39F3,$0000
	dw $39F4,$0008,$39F5,$08F8,$39F6,$0800,$39FA,$0808
	dw $39F8,$0000

DATA_00FB0E:
	dw $0001,$0000,$39F0,$5554

DATA_00FB16:
	dw $000C,$FE0A,$3BA2,$FE12,$3BA3,$060A,$3BB2,$0612
	dw $3BB3,$1662,$3BA4,$166A,$3BA5,$1E62,$3BB4,$1E6A
	dw $3BB5,$2E92,$3BA6,$2E9A,$3BA7,$3692,$3BB6,$369A
	dw $3BB7,$0000,$5500

	%FREE_BYTES($00FB4C, 1140, $FF)
%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SIMCBank01Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_018000:
	db $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$02,$02,$03,$02,$02,$01

DATA_018010:
	db $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0E,$0D,$0C,$0F

DATA_018020:
	db $02,$03,$02,$05,$02,$06,$02,$0A,$03,$03,$04,$09,$07,$0B,$08,$0C

DATA_018030:
	db $00,$01,$00,$01,$00,$01,$00,$00,$01,$01,$00,$01,$00,$01,$00,$01

DATA_018040:
	db $03,$03,$03,$03,$03,$0B,$0B,$0B,$0B,$0B,$0F,$0F,$17,$0F,$0F,$0B
	db $0B

DATA_018051:
	db $00,$00,$00,$00,$00,$02,$02,$02,$02,$02,$04,$04,$06,$04,$04,$02
	db $02

DATA_018062:
	db $00,$00,$00,$00,$00,$08,$08,$08,$08,$08,$0F,$0F,$23,$0F,$0F,$08

DATA_018072:
	db $00,$01,$02,$00,$01,$02,$00,$01,$02,$03,$03,$03,$00,$01,$02,$03
	db $04,$04,$04,$04,$00,$01,$02,$03,$04,$05,$05,$05,$05,$05,$00,$01
	db $02,$03,$04,$05

DATA_018096:
	db $00,$00,$00,$01,$01,$01,$02,$02,$02,$00,$01,$02,$03,$03,$03,$03
	db $00,$01,$02,$03,$04,$04,$04,$04,$04,$00,$01,$02,$03,$04,$05,$05
	db $05,$05,$05,$05

DATA_0180BA:
	db $04,$2E,$30,$7F,$FF,$FF

DATA_0180C0:
	db $01,$03,$04,$06

DATA_0180C4:
	db $00,$20,$40,$60,$80,$A0,$C0,$E0,$00,$20,$40,$60,$80,$A0,$C0,$E0
	db $00,$20,$40,$60,$80,$A0,$C0,$E0,$00,$20,$40,$60,$80,$A0,$C0,$E0
	db $80,$00,$20,$40,$60,$00,$20,$00,$20,$40,$60,$E0,$E0,$E0,$E0,$E0
	db $E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$E0,$00,$20,$40,$60,$80
	db $A0,$C0,$E0

DATA_018107:
	db $70,$70,$70,$70,$70,$70,$70,$70,$72,$72,$72,$72,$72,$72,$72,$72
	db $74,$74,$74,$74,$74,$74,$74,$74,$60,$60,$60,$60,$60,$60,$60,$60
	db $68,$68,$68,$68,$68,$68,$68,$68,$68,$68,$68,$66,$66,$66,$66,$66
	db $66,$66,$66,$66,$66,$66,$66,$66,$66,$66,$66,$60,$60,$60,$60,$60
	db $60,$60,$60

DATA_01814A:
	db DATA_078000+$0000,DATA_078000+$0100,DATA_078000+$0180,DATA_078000+$0380,DATA_078000+$0080,DATA_078000+$0200,DATA_078000+$0280,DATA_078000+$0300,DATA_078000+$0400,DATA_078000+$0480,DATA_078000+$0600,DATA_078000+$0680,DATA_078000+$0500,DATA_078000+$0580,DATA_078000+$0700,DATA_078000+$0780
	db DATA_078000+$1000,DATA_078000+$1080,DATA_078000+$1100,DATA_078000+$1180,DATA_078000+$1200,DATA_078000+$1280,DATA_078000+$1300,DATA_078000+$1380,DATA_078000+$1800,DATA_078000+$1880,DATA_078000+$1900,DATA_078000+$1980,DATA_078000+$1A00,DATA_078000+$1A80,DATA_078000+$1B00,DATA_078000+$1B80
	db DATA_078000+$1C00,DATA_078000+$1C80,DATA_078000+$0200,DATA_078000+$0280,DATA_078000+$0300,DATA_078000+$1D00,DATA_078000+$1D80,DATA_078000+$0400,DATA_078000+$0480,DATA_078000+$2600,DATA_078000+$2600,DATA_078000+$0000,DATA_078000+$0100,DATA_078000+$0180,DATA_078000+$0380,DATA_078000+$0080
	db DATA_078000+$0200,DATA_078000+$0280,DATA_078000+$0300,DATA_078000+$0400,DATA_078000+$0480,DATA_078000+$0600,DATA_078000+$0680,DATA_078000+$0700,DATA_078000+$0580,DATA_078000+$0500,DATA_078000+$0780,DATA_078000+$0200,DATA_078000+$0280,DATA_078000+$0300,DATA_078000+$1A80,DATA_078000+$1B80
	db DATA_078000+$1B00,DATA_078000+$2400,DATA_078000+$2480

DATA_01818D:
	db (DATA_078000+$0000)>>8,(DATA_078000+$0100)>>8,(DATA_078000+$0180)>>8,(DATA_078000+$0380)>>8,(DATA_078000+$0080)>>8,(DATA_078000+$0200)>>8,(DATA_078000+$0280)>>8,(DATA_078000+$0300)>>8,(DATA_078000+$0400)>>8,(DATA_078000+$0480)>>8,(DATA_078000+$0600)>>8,(DATA_078000+$0680)>>8,(DATA_078000+$0500)>>8,(DATA_078000+$0580)>>8,(DATA_078000+$0700)>>8,(DATA_078000+$0780)>>8
	db (DATA_078000+$1000)>>8,(DATA_078000+$1080)>>8,(DATA_078000+$1100)>>8,(DATA_078000+$1180)>>8,(DATA_078000+$1200)>>8,(DATA_078000+$1280)>>8,(DATA_078000+$1300)>>8,(DATA_078000+$1380)>>8,(DATA_078000+$1800)>>8,(DATA_078000+$1880)>>8,(DATA_078000+$1900)>>8,(DATA_078000+$1980)>>8,(DATA_078000+$1A00)>>8,(DATA_078000+$1A80)>>8,(DATA_078000+$1B00)>>8,(DATA_078000+$1B80)>>8
	db (DATA_078000+$1C00)>>8,(DATA_078000+$1C80)>>8,(DATA_078000+$0200)>>8,(DATA_078000+$0280)>>8,(DATA_078000+$0300)>>8,(DATA_078000+$1D00)>>8,(DATA_078000+$1D80)>>8,(DATA_078000+$0400)>>8,(DATA_078000+$0480)>>8,(DATA_078000+$2600)>>8,(DATA_078000+$2600)>>8,(DATA_078000+$0000)>>8,(DATA_078000+$0100)>>8,(DATA_078000+$0180)>>8,(DATA_078000+$0380)>>8,(DATA_078000+$0080)>>8
	db (DATA_078000+$0200)>>8,(DATA_078000+$0280)>>8,(DATA_078000+$0300)>>8,(DATA_078000+$0400)>>8,(DATA_078000+$0480)>>8,(DATA_078000+$0600)>>8,(DATA_078000+$0680)>>8,(DATA_078000+$0700)>>8,(DATA_078000+$0580)>>8,(DATA_078000+$0500)>>8,(DATA_078000+$0780)>>8,(DATA_078000+$0200)>>8,(DATA_078000+$0280)>>8,(DATA_078000+$0300)>>8,(DATA_078000+$1A80)>>8,(DATA_078000+$1B80)>>8
	db (DATA_078000+$1B00)>>8,(DATA_078000+$2400)>>8,(DATA_078000+$2480)>>8

DATA_0181D0:
	db (DATA_078000+$0000)>>16,(DATA_078000+$0100)>>16,(DATA_078000+$0180)>>16,(DATA_078000+$0380)>>16,(DATA_078000+$0080)>>16,(DATA_078000+$0200)>>16,(DATA_078000+$0280)>>16,(DATA_078000+$0300)>>16,(DATA_078000+$0400)>>16,(DATA_078000+$0480)>>16,(DATA_078000+$0600)>>16,(DATA_078000+$0680)>>16,(DATA_078000+$0500)>>16,(DATA_078000+$0580)>>16,(DATA_078000+$0700)>>16,(DATA_078000+$0780)>>16
	db (DATA_078000+$1000)>>16,(DATA_078000+$1080)>>16,(DATA_078000+$1100)>>16,(DATA_078000+$1180)>>16,(DATA_078000+$1200)>>16,(DATA_078000+$1280)>>16,(DATA_078000+$1300)>>16,(DATA_078000+$1380)>>16,(DATA_078000+$1800)>>16,(DATA_078000+$1880)>>16,(DATA_078000+$1900)>>16,(DATA_078000+$1980)>>16,(DATA_078000+$1A00)>>16,(DATA_078000+$1A80)>>16,(DATA_078000+$1B00)>>16,(DATA_078000+$1B80)>>16
	db (DATA_078000+$1C00)>>16,(DATA_078000+$1C80)>>16,(DATA_078000+$0200)>>16,(DATA_078000+$0280)>>16,(DATA_078000+$0300)>>16,(DATA_078000+$1D00)>>16,(DATA_078000+$1D80)>>16,(DATA_078000+$0400)>>16,(DATA_078000+$0480)>>16,(DATA_078000+$2600)>>16,(DATA_078000+$2600)>>16,(DATA_078000+$0000)>>16,(DATA_078000+$0100)>>16,(DATA_078000+$0180)>>16,(DATA_078000+$0380)>>16,(DATA_078000+$0080)>>16
	db (DATA_078000+$0200)>>16,(DATA_078000+$0280)>>16,(DATA_078000+$0300)>>16,(DATA_078000+$0400)>>16,(DATA_078000+$0480)>>16,(DATA_078000+$0600)>>16,(DATA_078000+$0680)>>16,(DATA_078000+$0700)>>16,(DATA_078000+$0580)>>16,(DATA_078000+$0500)>>16,(DATA_078000+$0780)>>16,(DATA_078000+$0200)>>16,(DATA_078000+$0280)>>16,(DATA_078000+$0300)>>16,(DATA_078000+$1A80)>>16,(DATA_078000+$1B80)>>16
	db (DATA_078000+$1B00)>>16,(DATA_078000+$2400)>>16,(DATA_078000+$2480)>>16

DATA_018213:
	db DATA_078000+$0800,DATA_078000+$0900,DATA_078000+$0980,DATA_078000+$0B80,DATA_078000+$0880,DATA_078000+$0A00,DATA_078000+$0A80,DATA_078000+$0B00,DATA_078000+$0C00,DATA_078000+$0C80,DATA_078000+$0E00,DATA_078000+$0E80,DATA_078000+$0D00,DATA_078000+$0D80,DATA_078000+$0F00,DATA_078000+$0F80
	db DATA_078000+$1400,DATA_078000+$1480,DATA_078000+$1500,DATA_078000+$1580,DATA_078000+$1600,DATA_078000+$1680,DATA_078000+$1700,DATA_078000+$1780,DATA_078000+$1E00,DATA_078000+$1E80,DATA_078000+$1F00,DATA_078000+$1F80,DATA_078000+$2000,DATA_078000+$2080,DATA_078000+$2100,DATA_078000+$2180
	db DATA_078000+$2200,DATA_078000+$2280,DATA_078000+$0A00,DATA_078000+$0A80,DATA_078000+$0B00,DATA_078000+$2300,DATA_078000+$2380,DATA_078000+$0C00,DATA_078000+$0C80,DATA_078000+$2600,DATA_078000+$2600,DATA_078000+$0000,DATA_078000+$0100,DATA_078000+$0180,DATA_078000+$0380,DATA_078000+$0080
	db DATA_078000+$0200,DATA_078000+$0280,DATA_078000+$0300,DATA_078000+$0400,DATA_078000+$0480,DATA_078000+$0600,DATA_078000+$0680,DATA_078000+$0700,DATA_078000+$0580,DATA_078000+$0500,DATA_078000+$0780,DATA_078000+$0A00,DATA_078000+$0A80,DATA_078000+$0B00,DATA_078000+$2080,DATA_078000+$2180
	db DATA_078000+$2100,DATA_078000+$2500,DATA_078000+$2580

DATA_018256:
	db (DATA_078000+$0800)>>8,(DATA_078000+$0900)>>8,(DATA_078000+$0980)>>8,(DATA_078000+$0B80)>>8,(DATA_078000+$0880)>>8,(DATA_078000+$0A00)>>8,(DATA_078000+$0A80)>>8,(DATA_078000+$0B00)>>8,(DATA_078000+$0C00)>>8,(DATA_078000+$0C80)>>8,(DATA_078000+$0E00)>>8,(DATA_078000+$0E80)>>8,(DATA_078000+$0D00)>>8,(DATA_078000+$0D80)>>8,(DATA_078000+$0F00)>>8,(DATA_078000+$0F80)>>8
	db (DATA_078000+$1400)>>8,(DATA_078000+$1480)>>8,(DATA_078000+$1500)>>8,(DATA_078000+$1580)>>8,(DATA_078000+$1600)>>8,(DATA_078000+$1680)>>8,(DATA_078000+$1700)>>8,(DATA_078000+$1780)>>8,(DATA_078000+$1E00)>>8,(DATA_078000+$1E80)>>8,(DATA_078000+$1F00)>>8,(DATA_078000+$1F80)>>8,(DATA_078000+$2000)>>8,(DATA_078000+$2080)>>8,(DATA_078000+$2100)>>8,(DATA_078000+$2180)>>8
	db (DATA_078000+$2200)>>8,(DATA_078000+$2280)>>8,(DATA_078000+$0A00)>>8,(DATA_078000+$0A80)>>8,(DATA_078000+$0B00)>>8,(DATA_078000+$2300)>>8,(DATA_078000+$2380)>>8,(DATA_078000+$0C00)>>8,(DATA_078000+$0C80)>>8,(DATA_078000+$2600)>>8,(DATA_078000+$2600)>>8,(DATA_078000+$0000)>>8,(DATA_078000+$0100)>>8,(DATA_078000+$0180)>>8,(DATA_078000+$0380)>>8,(DATA_078000+$0080)>>8
	db (DATA_078000+$0200)>>8,(DATA_078000+$0280)>>8,(DATA_078000+$0300)>>8,(DATA_078000+$0400)>>8,(DATA_078000+$0480)>>8,(DATA_078000+$0600)>>8,(DATA_078000+$0680)>>8,(DATA_078000+$0700)>>8,(DATA_078000+$0580)>>8,(DATA_078000+$0500)>>8,(DATA_078000+$0780)>>8,(DATA_078000+$0A00)>>8,(DATA_078000+$0A80)>>8,(DATA_078000+$0B00)>>8,(DATA_078000+$2080)>>8,(DATA_078000+$2180)>>8
	db (DATA_078000+$2100)>>8,(DATA_078000+$2500)>>8,(DATA_078000+$2580)>>8

DATA_018299:
	db (DATA_078000+$0800)>>16,(DATA_078000+$0900)>>16,(DATA_078000+$0980)>>16,(DATA_078000+$0B80)>>16,(DATA_078000+$0880)>>16,(DATA_078000+$0A00)>>16,(DATA_078000+$0A80)>>16,(DATA_078000+$0B00)>>16,(DATA_078000+$0C00)>>16,(DATA_078000+$0C80)>>16,(DATA_078000+$0E00)>>16,(DATA_078000+$0E80)>>16,(DATA_078000+$0D00)>>16,(DATA_078000+$0D80)>>16,(DATA_078000+$0F00)>>16,(DATA_078000+$0F80)>>16
	db (DATA_078000+$1400)>>16,(DATA_078000+$1480)>>16,(DATA_078000+$1500)>>16,(DATA_078000+$1580)>>16,(DATA_078000+$1600)>>16,(DATA_078000+$1680)>>16,(DATA_078000+$1700)>>16,(DATA_078000+$1780)>>16,(DATA_078000+$1E00)>>16,(DATA_078000+$1E80)>>16,(DATA_078000+$1F00)>>16,(DATA_078000+$1F80)>>16,(DATA_078000+$2000)>>16,(DATA_078000+$2080)>>16,(DATA_078000+$2100)>>16,(DATA_078000+$2180)>>16
	db (DATA_078000+$2200)>>16,(DATA_078000+$2280)>>16,(DATA_078000+$0A00)>>16,(DATA_078000+$0A80)>>16,(DATA_078000+$0B00)>>16,(DATA_078000+$2300)>>16,(DATA_078000+$2380)>>16,(DATA_078000+$0C00)>>16,(DATA_078000+$0C80)>>16,(DATA_078000+$2600)>>16,(DATA_078000+$2600)>>16,(DATA_078000+$0000)>>16,(DATA_078000+$0100)>>16,(DATA_078000+$0180)>>16,(DATA_078000+$0380)>>16,(DATA_078000+$0080)>>16
	db (DATA_078000+$0200)>>16,(DATA_078000+$0280)>>16,(DATA_078000+$0300)>>16,(DATA_078000+$0400)>>16,(DATA_078000+$0480)>>16,(DATA_078000+$0600)>>16,(DATA_078000+$0680)>>16,(DATA_078000+$0700)>>16,(DATA_078000+$0580)>>16,(DATA_078000+$0500)>>16,(DATA_078000+$0780)>>16,(DATA_078000+$0A00)>>16,(DATA_078000+$0A80)>>16,(DATA_078000+$0B00)>>16,(DATA_078000+$2080)>>16,(DATA_078000+$2180)>>16
	db (DATA_078000+$2100)>>16,(DATA_078000+$2500)>>16,(DATA_078000+$2580)>>16

UNK_0182DC:
	db DATA_078000+$1000,DATA_078000+$1100,DATA_078000+$1180,DATA_078000+$1380,DATA_078000+$1080,DATA_078000+$1200,DATA_078000+$1280,DATA_078000+$1300,DATA_078000+$1400,DATA_078000+$1480,DATA_078000+$1500,DATA_078000+$1580,DATA_078000+$1600,DATA_078000+$1680,DATA_078000+$1700,DATA_078000+$1780

UNK_0182EC:
	db (DATA_078000+$1000)>>8,(DATA_078000+$1100)>>8,(DATA_078000+$1180)>>8,(DATA_078000+$1380)>>8,(DATA_078000+$1080)>>8,(DATA_078000+$1200)>>8,(DATA_078000+$1280)>>8,(DATA_078000+$1300)>>8,(DATA_078000+$1400)>>8,(DATA_078000+$1480)>>8,(DATA_078000+$1500)>>8,(DATA_078000+$1580)>>8,(DATA_078000+$1600)>>8,(DATA_078000+$1680)>>8,(DATA_078000+$1700)>>8,(DATA_078000+$1780)>>8

UNK_0182FC:
	db (DATA_078000+$1000)>>16,(DATA_078000+$1100)>>16,(DATA_078000+$1180)>>16,(DATA_078000+$1380)>>16,(DATA_078000+$1080)>>16,(DATA_078000+$1200)>>16,(DATA_078000+$1280)>>16,(DATA_078000+$1300)>>16,(DATA_078000+$1400)>>16,(DATA_078000+$1480)>>16,(DATA_078000+$1500)>>16,(DATA_078000+$1580)>>16,(DATA_078000+$1600)>>16,(DATA_078000+$1680)>>16,(DATA_078000+$1700)>>16,(DATA_078000+$1780)>>16

DATA_01830C:
	dw CODE_01B62F
	dw CODE_01B645
	dw CODE_01B65B

DATA_018312:
	dw CODE_01B671
	dw CODE_01B689
	dw CODE_01B6A1

DATA_018318:
	dw $0030,$0031,$0032,$0033,$0034,$0035,$0036,$0037
	dw $0038,$0039,$003A,$003B,$003C,$003D,$003E,$0040
	dw $0041,$0042,$0043,$0044,$0045,$0046,$0047,$0048
	dw $0049,$004A,$004B,$004C,$004D,$004E,$0050,$0051
	dw $0052,$0053,$0054,$0055,$0056,$0057,$0058,$0059
	dw $005A,$005B,$005C,$005D,$005E,$007D,$007E,$FFFF

DATA_018378:
	dw $006D,$006E,$0070,$0071,$0072,$0073,$0074,$0075
	dw $0076,$0077,$0078,$0079,$007A,$007B,$007C,$007D
	dw $007E,$034B,$034C,$034D,$034E,$034F,$0350,$0351
	dw $0352,$0353,$FFFF

DATA_0183AE:
	dw $003D,$003E,$004D,$004E,$005D,$005E,$0060,$0061
	dw $0062,$0063,$0064,$0065,$0066,$0067,$0068,$0069
	dw $006A,$006B,$006C,$006D,$006E,$FFFF

DATA_0183DA:
	dw $0084,$0008,$0089,$0000,$008A,$0000,$008B,$0000
	dw $008C,$0000,$008D,$0000,$008E,$0000,$008F,$0000
	dw $0090,$0000,$0091,$0000,$0092,$0000,$0093,$0000
	dw $0094,$0000,$0099,$0008,$00A2,$0008,$00AB,$0008
	dw $00B4,$0008,$00BD,$0008,$00C6,$0008,$00CF,$0008
	dw $00D8,$0008,$00E1,$0008,$00EA,$0008,$00F3,$0008
	dw $00FC,$0008,$0105,$0008,$010E,$0008,$0117,$0008
	dw $0120,$0008,$0129,$0008,$0132,$0008,$013B,$0008
	dw $0144,$0008,$014D,$0008,$0156,$0008,$015F,$0008
	dw $0168,$0008,$0171,$0008,$017A,$0008,$0183,$0008
	dw $018C,$0008,$0195,$0008,$019E,$0008,$01A7,$0008
	dw $01B0,$0008,$01B9,$0008,$01C2,$0008,$01CB,$0008
	dw $01D4,$0008,$01DD,$0008,$01E6,$0008,$01EF,$0008
	dw $01F8,$0008,$0201,$0008,$020A,$0008,$0213,$0008
	dw $021C,$0008,$0225,$0008,$022E,$0008,$0237,$0008
	dw $0240,$0008,$0249,$0008,$0252,$0008,$025C,$000F
	dw $025D,$000F,$0260,$000F,$0261,$000F,$026C,$000F
	dw $026D,$000F,$0270,$000F,$0271,$000F,$027C,$000F
	dw $027D,$000F,$0280,$000F,$0281,$000F,$028C,$000F
	dw $028D,$000F,$0290,$000F,$0291,$000F,$02A5,$0023
	dw $02A6,$0023,$02AB,$0023,$02AC,$0023,$02BF,$0008
	dw $02C8,$0008,$02D1,$0008,$02DA,$0008,$02E3,$0008
	dw $02EC,$0008,$02F5,$0008,$02FE,$0008,$0307,$0008
	dw $0310,$0008,$0319,$0008,$0322,$0008,$032B,$0008
	dw $0334,$0008,$033D,$0008,$0346,$0008,$034F,$0008
	dw $036B,$000F,$036C,$000F,$036F,$000F,$0370,$000F
	dw $037A,$0008,$0383,$0008,$038C,$0008,$0395,$0008
	dw $039E,$0008,$03A7,$0008,$03B0,$0008,$03B9,$0008
	dw $FFFF,$0000

DATA_01859E:
	dw DATA_009C19,DATA_009C39,DATA_009C59,DATA_009C79,DATA_009C99,DATA_009CC9,DATA_009CF9,DATA_009D29

DATA_0185AE:
	dw DATA_009D8B,DATA_009D93,DATA_009DB5,DATA_009DAD

DATA_0185B6:
	dw DATA_009DE1,DATA_009DD5,DATA_009E35,DATA_009E29

UNK_0185BE:
	dw $0303,$0005,$0304,$0000

UNK_0185C6:
	dw $0800,$0880,$0900,$0980,$1000,$1080,$1100,$1180
	dw $D800,$0004,$04D2,$C000,$0004,$04C0,$C600,$0004
	dw $04CC,$C000,$0004,$04C0,$F180,$F180,$F000,$F020
	dw $F180,$F180,$F180,$F180,$F200,$F220,$F180,$F180
	dw $F180,$F180,$F180,$F180,$FE20,$FCA0,$FCC0,$F180
	dw $F180,$F080,$F0A0,$F180,$F180,$F180,$F180,$F280
	dw $F2A0,$F180,$F180,$F180,$F180,$F180,$FE20,$FE00
	dw $FCA0,$FCC0,$F180,$F180,$F0C0,$F0A0,$F180,$F180
	dw $F180,$F180,$F2C0,$F2A0,$F180,$F180,$F180,$F180
	dw $F180,$FE40,$FE00,$FCA0,$FCC0,$F180,$F180,$F500
	dw $F0C0,$F180,$F180,$F180,$F180,$F700,$F2C0,$F180
	dw $F180,$F180,$F180,$F180,$F180,$FEA0,$FCA0,$FCC0
	dw $F180,$F180,$F040,$F060,$F180,$F180,$F180,$F180
	dw $F240,$F260,$F180,$F180,$F180,$F180,$F180,$FE20
	dw $FE00,$FCA0,$FCC0,$F180,$F0E0,$F100,$F020,$F180
	dw $F180,$F180,$F2E0,$F300,$F220,$F180,$F180,$F180
	dw $F180,$FE20,$FE00,$FE00,$FCA0,$FCC0,$F180,$F120
	dw $F140,$F020,$F180,$F180,$F180,$F320,$F340,$F220
	dw $F180,$F180,$F180,$F180,$FE20,$FE00,$FE00,$FCA0
	dw $FCC0,$F180,$F160,$F140,$F020,$F180,$F180,$F180
	dw $F360,$F340,$F220,$F180,$F180,$F180,$F180,$FE20
	dw $FE00,$FE00,$FCA0,$FCC0,$F180,$F400,$F420,$F440
	dw $F180,$F180,$F180,$F600,$F620,$F640,$F180,$F180
	dw $F180,$F180,$FEA0,$FE00,$FE00,$FCA0,$FCC0,$F180
	dw $F460,$F480,$F440,$F180,$F180,$F180,$F660,$F680
	dw $F640,$F180,$F180,$F180,$F180,$FEA0,$FE00,$FE00
	dw $FCA0,$FCC0,$F880,$F8A0,$F8C0,$F180,$F180,$F180
	dw $FA80,$FAA0,$FAC0,$FAE0,$FB00,$F180,$F180,$FE60
	dw $FE00,$FE00,$FE00,$FCA0,$FCC0,$F180,$F180,$F180
	dw $F800,$F180,$F180,$F180,$F180,$F180,$FA00,$F180
	dw $F180,$F180,$FEA0,$FE00,$FE00,$FE00,$FCA0,$FCC0
	dw $F180,$F820,$F840,$F860,$F180,$F180,$F180,$FA20
	dw $FA40,$FA60,$F180,$F180,$FE20,$FE00,$FE00,$FE00
	dw $FE00,$FCA0,$FCC0,$F540,$F560,$F4C0,$F4E0,$F500
	dw $F520,$F740,$F760,$F6C0,$F6E0,$F700,$F720,$F180
	dw $FEA0,$FE00,$FE00,$FE00,$FCA0,$FCC0,$F4A0,$F4C0
	dw $F4E0,$F500,$F520,$F180,$F6A0,$F6C0,$F6E0,$F700
	dw $F720,$F180,$F180,$FE60,$FE00,$FE00,$FE00,$FCA0
	dw $FCC0,$F920,$F180,$F8C0,$F180,$F180,$F180,$FB20
	dw $FB40,$FB60,$FB80,$FBA0,$F180,$F180,$F180,$F180
	dw $F180,$F180,$FCA0,$FCC0

DATA_01884E:
	dw $0001,$000A,$0014,$0005,$000A,$0064,$0064,$0064
	dw $01F4,$01F4,$0BB8,$1388,$0BB8,$1388,$2710,$0064

DATA_01886E:
	dw $0001,$000A,$0014,$0005,$000A,$0064,$0064,$0064
	dw $01F4,$01F4,$0BB8,$1388,$2710,$1388,$0BB8,$0064

CODE_01888E:
	REP.b #$20
	LDA.w #$FFFF
	STA.w $01EF
	STA.w $01D7
	STA.w $01E5
	STA.w $0B4B
	STA.w $0399
	LDA.w #$00FF
	STA.w $0B4F
	LDA.w #$0080
	STA.w $01EB
	STA.w $01ED
	LDA.w #$0000
	STA.w $01D9
	STA.w $01DB
	STA.w $02AB
	STA.w $01F9
	STA.w $01E1
	STA.w $020D
	STA.w $01DD
	STA.b $D7
	STA.w $0389
	STA.w $0385
	STA.w $0383
	STA.w $0379
	SEP.b #$20
	REP.b #$10
	LDX.w #$000F
CODE_0188DE:
	STA.w $029B,x
	DEX
	BPL.b CODE_0188DE
	INC.w $029B
	LDA.l $700009
	STA.w $0425
	RTS

DATA_0188EF:
	dw CODE_018D25
	dw CODE_018D26
	dw CODE_018DCE
	dw CODE_018E28
	dw CODE_018E3D
	dw CODE_019D6B
	dw CODE_019F2D
	dw CODE_01C529
	dw CODE_0193A8
	dw CODE_0193A4
	dw CODE_01940F
	dw CODE_0194E6

CODE_018907:
	REP.b #$10
	TSX
	STX.b $AF
	JSR.w CODE_01B3E7
	REP.b #$20
	LDA.w #$0000
	STA.w $0139
	STA.w $0137
	STA.w $0197
	STA.b $E3
	STA.w $0AB5
	STA.w $0BCB
	JSR.w CODE_01F1DC
	JSR.w CODE_01888E
	JSR.w CODE_01A08C
	JSR.w CODE_01DF7B
	CLI
	JSR.w CODE_01C8B7
	JSR.w CODE_01C817
	REP.b #$10
	JSR.w CODE_018A44
	JSR.w CODE_01C660
	JSR.w CODE_01A064
	REP.b #$20
	LDA.w #$0003
	COP.b #$00
CODE_01894A:
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w #$FFFF
	STA.b $C3
	LDA.w $011B
	AND.w #$F0F0
	BEQ.b CODE_018976
	LDA.w $0105
	BEQ.b CODE_01896B
	INC.w $0109
	STZ.w $0105
CODE_01896B:
	LDA.w $0111
	BEQ.b CODE_018976
	INC.w $0115
	STZ.w $0111
CODE_018976:
	JSR.w CODE_018AF5
	JSR.w CODE_0194A7
	JSR.w CODE_018B1F
	LDA.b $C5
	REP.b #$10
	ASL
	TAX
	JSR.w (DATA_0188EF,x)
	REP.b #$20
	LDA.w $0AF1
	BNE.b CODE_0189E4
	LDA.b $D7
	BEQ.b CODE_01899A
	CMP.w #$0001
	BEQ.b CODE_0189B3
	BNE.b CODE_0189E4			; Note: This will always branch.

CODE_01899A:
	JSR.w CODE_01C01C
	JSR.w CODE_01C3CF
	JSR.w CODE_01C0DD
	JSR.w CODE_01C434
	JSR.w CODE_01C616
	JSR.w CODE_018A92
	JSR.w CODE_01948B
	JSL.l CODE_008432
CODE_0189B3:
	JSL.l CODE_0094D5
	REP.b #$20
	LDA.w $01F7
	BNE.b CODE_0189C5
	JSR.w CODE_01EF9F
	JSL.l CODE_0085EB
CODE_0189C5:
	JSR.w CODE_01EECF
	JSR.w CODE_01F069
	REP.b #$20
	LDA.b $D7
	BNE.b CODE_0189E4
	JSR.w CODE_01C660
	REP.b #$20
	LDA.w $011B
	AND.w #$4080
	ORA.w $01F5
	BNE.b CODE_0189E4
	JSR.w CODE_01C817
CODE_0189E4:
	JSR.w CODE_01C033
	REP.b #$20
	LDA.w $0103
	BNE.b CODE_0189F9
	LDA.w $0105
	BEQ.b CODE_0189F9
	INC.w $0109
	STZ.w $0105
CODE_0189F9:
	LDA.w $010F
	BNE.b CODE_018A09
	LDA.w $0111
	BEQ.b CODE_018A09
	INC.w $0115
	STZ.w $0111
CODE_018A09:
	STZ.b $C3
	LDA.w $0387
	BEQ.b CODE_018A1E
	LDA.w $038B
	BNE.b CODE_018A1E
	LDA.w #$00FF
	STA.w $0385
	STZ.w $0387
CODE_018A1E:
	LDA.w $0D87
	BNE.b CODE_018A26
	JMP.w CODE_01894A

CODE_018A26:
	REP.b #$20
	LDA.w #$0004
	COP.b #$00
	REP.b #$20
	STZ.w $0101
	LDA.w #$0013
	STA.b $14
	STZ.b $12
	STZ.w $01D7
	RTL

CODE_018A3D:
	REP.b #$20
	RTS

CODE_018A40:
	JSR.w CODE_018A44
	RTL

CODE_018A44:
	REP.b #$30
	LDA.w $03FA
	BEQ.b CODE_018A58
	STZ.w $010F
	STZ.w $0111
	LDA.w #$00FF
	STA.w $0115
	RTS

CODE_018A58:
	LDA.w #$0249
	STA.l SIMC_Global_PaletteMirror[$BB].LowByte
	LDA.w #$00E0
	STA.l SIMC_Global_PaletteMirror[$BC].LowByte
	LDA.w #$0180
	STA.l SIMC_Global_PaletteMirror[$BD].LowByte
	LDA.w #$0C63
	STA.l SIMC_Global_PaletteMirror[$BF].LowByte
	LDA.w #$0002
	STA.b $BB
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	JSL.l CODE_008DA2
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	REP.b #$20
	RTS

CODE_018A92:
	REP.b #$20
	LDA.w $040A
	BMI.b CODE_018AA3
	LDA.w $0408
	BEQ.b CODE_018AA7
	LDA.w $0BB9
	BEQ.b CODE_018AA7
CODE_018AA3:
	JSL.l CODE_0084A9
CODE_018AA7:
	RTS

CODE_018AA8:
	REP.b #$20
	LDA.b $D7
	BNE.b CODE_018AF4
	LDA.w #$009C
	STA.w $0253
	REP.b #$20
	LDA.w $01BD
	LSR
	LSR
	CLC
	ADC.w #$00C8
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w $01BF
	LSR
	LSR
	CLC
	ADC.w #$0038
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$0024
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	LDA.w #$00C7
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w #$0037
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$0023
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
CODE_018AF4:
	RTS

CODE_018AF5:
	REP.b #$20
	LDA.b $D7
	BNE.b CODE_018B1E
	LDA.l SIMC_Global_UpperOAMBuffer[$08].Slot
	AND.w #$3FFF
	ORA.w #$4000
	STA.l SIMC_Global_UpperOAMBuffer[$08].Slot
	LDA.w #$5555
	STA.l SIMC_Global_UpperOAMBuffer[$0A].Slot
	LDA.l SIMC_Global_UpperOAMBuffer[$0C].Slot
	AND.w #$FC00
	ORA.w #$0155
	STA.l SIMC_Global_UpperOAMBuffer[$0C].Slot
CODE_018B1E:
	RTS

CODE_018B1F:					; Note: Tile placement cursor related.
	REP.b #$20
	STZ.b $C5
	LDA.w $0C0F
	BNE.b CODE_018B4B
	LDA.w $0AF1
	BEQ.b CODE_018B30
	JMP.w CODE_018C8F

CODE_018B30:
	LDA.w $01C1
	BEQ.b CODE_018B3B
	LDA.w #$0001
	JMP.w CODE_018C52

CODE_018B3B:
	LDA.b $D7
	BEQ.b CODE_018B4E
	DEC
	BNE.b CODE_018B45
	JMP.w CODE_018C55

CODE_018B45:
	DEC
	BNE.b CODE_018B4B
	JMP.w CODE_018CA3

CODE_018B4B:
	STZ.b $C5
	RTS

CODE_018B4E:
	LDA.w $011B
	AND.w #$FFF0
	BNE.b CODE_018B6A
	LDA.w $0DC3
	BEQ.b CODE_018B6A
	LDA.w #$0003
	STA.w $01DF
	LDA.w #$000A
	STA.w $0BCB
	JMP.w CODE_018C52

CODE_018B6A:
	LDA.w $03FE
	BEQ.b CODE_018B9C
	CMP.w #$00C0
	BNE.b CODE_018B7C
	PHP
	JSL.l CODE_0098A0	: dw $0A03
	PLP
CODE_018B7C:
	LDA.w #$00FF
	STA.w $03FA
	LDA.w $0195
	AND.w #$0004
	BEQ.b CODE_018B90
	LDA.w #$0009
	JMP.w CODE_018C52

CODE_018B90:
	LDA.w #$00FF
	STA.w $0111
	LDA.w #$0200
	STA.w $010F
CODE_018B9C:
	STZ.w $03FE
	LDA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	BEQ.b CODE_018BAA
	LDA.w #$0008
	JMP.w CODE_018C52

CODE_018BAA:
	LDA.w $0383
	BEQ.b CODE_018BB5
	LDA.w #$000B
	JMP.w CODE_018C52

CODE_018BB5:
	LDA.w $0387
	BEQ.b CODE_018BD3
	LDA.b $C9
	AND.w #$0040
	BEQ.b CODE_018BD3
	STZ.w $0387
	STZ.w $038B
	LDA.w #$00FF
	STA.w $0385
	LDA.w #$0000
	JMP.w CODE_018C52

CODE_018BD3:
	LDA.w $011B
	AND.w #$4080
	BEQ.b CODE_018BE1
	LDA.w #$0001
	JMP.w CODE_018C52

CODE_018BE1:
	LDA.w $01F5
	BNE.b CODE_018BF2
	LDA.b $C9
	AND.w #$0040
	BEQ.b CODE_018BF2
	LDA.w #$0002
	BRA.b CODE_018C52

CODE_018BF2:
	LDA.b $C9
	AND.w #$3000
	BEQ.b CODE_018BFE
	LDA.w #$0007
	BRA.b CODE_018C52

CODE_018BFE:
	LDA.w $0201
	BEQ.b CODE_018C34
	LDA.b $C9
	BIT.w #$8000
	BNE.b CODE_018C2F
	LDA.w $01F5
	ORA.w $01FF
	BEQ.b CODE_018C22
	LDA.w $011B
	BIT.w #$8000
	BEQ.b CODE_018C34
	LDA.w #$0001
	STA.w $023B
	BRA.b CODE_018C4F

CODE_018C22:
	LDA.w $023B
	BEQ.b CODE_018C4F
	LDA.w $020D
	CMP.w #$0005
	BCS.b CODE_018C4F
CODE_018C2F:
	LDA.w #$0003
	BRA.b CODE_018C52

CODE_018C34:
	LDA.b $C9
	BIT.w #$8000
	BEQ.b CODE_018C4F
	JSR.w CODE_018CA6
	BCC.b CODE_018C45
	LDA.w #$0004
	BRA.b CODE_018C52

CODE_018C45:
	CMP.w #$0000
	BEQ.b CODE_018C4F
	LDA.w #$0005
	BRA.b CODE_018C52

CODE_018C4F:
	LDA.w #$0000
CODE_018C52:
	STA.b $C5
	RTS

CODE_018C55:
	STZ.w $03FE
	STZ.w $01D7
	LDA.w $0DC3
	BEQ.b CODE_018C68
	LDA.w #$000A
	STA.w $0BCB
	BRA.b CODE_018C8C

CODE_018C68:
	LDA.w $011B
	AND.w #$4F80
	BEQ.b CODE_018C75
	LDA.w #$0001
	BRA.b CODE_018C8C

CODE_018C75:
	LDA.b $C9
	AND.w #$0040
	BEQ.b CODE_018C89
	PHP
	JSL.l CODE_0098A0	: dw $0702
	PLP
	LDA.w #$0006
	BRA.b CODE_018C8C

CODE_018C89:
	LDA.w #$0000
CODE_018C8C:
	STA.b $C5
	RTS

CODE_018C8F:
	REP.b #$20
	LDA.w $03FE
	BEQ.b CODE_018CA3
	LDA.w $0195
	AND.w #$0004
	BEQ.b CODE_018CA3
	LDA.w #$0009
	BRA.b CODE_018C52

CODE_018CA3:
	STZ.b $C5
	RTS

CODE_018CA6:
	REP.b #$30
	LDA.w $01ED
	CMP.w #$0016
	BCC.b CODE_018CDB
	CMP.w #$0026
	BCS.b CODE_018CC4
	LDA.w $01EB
	CMP.w #$000F
	BCC.b CODE_018CDB
	CMP.w #$008F
	BCS.b CODE_018CDB
	BCC.b CODE_018CE0
CODE_018CC4:
	CMP.w #$002B
	BCC.b CODE_018CDB
	CMP.w #$00AB
	BCS.b CODE_018CDB
	LDA.w $01EB
	CMP.w #$000F
	BCC.b CODE_018CDB
	CMP.w #$002F
	BCC.b CODE_018D04
CODE_018CDB:
	LDA.w #$0000
	CLC
	RTS

CODE_018CE0:
	SEC
	SBC.w #$000F
	LSR
	LSR
	LSR
	LSR
	STA.w $01DF
	CMP.w #$0007
	BNE.b CODE_018CFF
	LDA.w $03FA
	BNE.b CODE_018CFF
	PHP
	JSL.l CODE_0098A0	: dw $0202
	PLP
	BRA.b CODE_018CDB

CODE_018CFF:
	LDA.w #$0001
	CLC
	RTS

CODE_018D04:
	SEC
	SBC.w #$000F
	LSR
	LSR
	LSR
	LSR
	AND.w #$0001
	STA.b $79
	LDA.w $01ED
	SEC
	SBC.w #$002B
	LSR
	LSR
	LSR
	AND.w #$FFFE
	ORA.b $79
	STA.w $01DD
	SEC
	RTS

CODE_018D25:
	RTS

CODE_018D26:
	REP.b #$20
	LDA.w $01F5
	BEQ.b CODE_018D2E
	RTS

CODE_018D2E:
	JSR.w CODE_018AA8
	LDA.w $01C1
	BNE.b CODE_018D93
	LDA.w $011B
	SEP.b #$20
	XBA
	AND.b #$0F
	BEQ.b CODE_018D90
	STA.w $01C1
	ASL
	ASL
	ASL
	ASL
	ASL
	BCC.b CODE_018D57
	PHA
	JSR.w CODE_01B2F9
	SEP.b #$20
	LDA.b $BB
	ORA.b #$0C
	STA.b $BB
	PLA
CODE_018D57:
	ASL
	BCC.b CODE_018D67
	PHA
	JSR.w CODE_01B1F6
	SEP.b #$20
	LDA.b $BB
	ORA.b #$0C
	STA.b $BB
	PLA
CODE_018D67:
	ASL
	BCC.b CODE_018D77
	PHA
	JSR.w CODE_01B166
	SEP.b #$20
	LDA.b $BB
	ORA.b #$0C
	STA.b $BB
	PLA
CODE_018D77:
	ASL
	BCC.b CODE_018D87
	PHA
	JSR.w CODE_01B030
	SEP.b #$20
	LDA.b $BB
	ORA.b #$0C
	STA.b $BB
	PLA
CODE_018D87:
	JSR.w CODE_01AFE0
	JSR.w CODE_01AFBE
	JSR.w CODE_01B375
CODE_018D90:
	REP.b #$20
	RTS

CODE_018D93:
	LDA.w $01C1
	LSR
	BCC.b CODE_018DA0
	PHA
	JSR.w CODE_01B13E
	REP.b #$20
	PLA
CODE_018DA0:
	LSR
	BCC.b CODE_018DAA
	PHA
	JSR.w CODE_01B1F1
	REP.b #$20
	PLA
CODE_018DAA:
	LSR
	BCC.b CODE_018DB4
	PHA
	JSR.w CODE_01B2F4
	REP.b #$20
	PLA
CODE_018DB4:
	LSR
	BCC.b CODE_018DBC
	JSR.w CODE_01B374
	REP.b #$20
CODE_018DBC:
	JSR.w CODE_01AFE0
	LDA.w #$0000
	STA.w $01C1
	SEP.b #$20
	LDA.b $B7
	AND.b #$EF
	STA.b $B7
	RTS

CODE_018DCE:
	REP.b #$30
	LDA.w $01D7
	BEQ.b CODE_018DDA
	LDA.w #$0000
	BRA.b CODE_018DF2

CODE_018DDA:
	STZ.w $01FF
	LDA.w #$00FF
	STA.w $01D7
	STA.w $01E5
	PHP
	JSL.l CODE_0098A0	: dw $0602
	PLP
	JSR.w CODE_01A064
	RTS

CODE_018DF2:
	STA.w $01D7
	LDA.w #$00FF
	STA.w $01E5
	STZ.w $0408
	STZ.w $023B
	PHP
	JSL.l CODE_0098A0	: dw $0702
	PLP
	JSR.w CODE_01A064
	REP.b #$20
	LDA.w #$0001
	STA.w $0201
	STZ.w $01FF
	LDX.w $020D
	LDA.l DATA_018000,x
	AND.w #$00FF
	STA.w $01F9
	JSR.w CODE_01B375
	RTS

CODE_018E28:				; Note: Related to building stuff.
	REP.b #$30
	STZ.w $0249
	LDA.w $020D
	REP.b #$10
	ASL
	TAX
	JSR.w (DATA_019CFA,x)
	REP.b #$20
	STZ.w $023B
	RTS

CODE_018E3D:
	REP.b #$30
	JSR.w CODE_018E9B
	BCS.b CODE_018E88
	JSR.w CODE_01B42A
	REP.b #$30
	LDA.w $020D
	CMP.w #$000F
	BEQ.b CODE_018E56
	CPX.w $020D
	BEQ.b CODE_018E87
CODE_018E56:
	JSR.w CODE_018ED5
	REP.b #$20
	LDA.w $020D
	STA.w $02AB
	JSR.w CODE_018F25
	JSR.w CODE_018EFA
	JSR.w CODE_018F13
	REP.b #$20
	LDA.w $020D
	STA.w $01E1
	JSR.w CODE_01CAA6
	REP.b #$20
	LDA.w $020D
	CMP.w #$000F
	BEQ.b CODE_018E87
	PHP
	JSL.l CODE_0098A0	: dw $0102
	PLP
CODE_018E87:
	RTS

CODE_018E88:
	LDX.w $020D
	LDA.l DATA_018010,x
	STA.w $01DD
	PHP
	JSL.l CODE_0098A0	: dw $0202
	PLP
	RTS

CODE_018E9B:
	SEP.b #$20
	REP.b #$10
	LDA.w $0425
	AND.b #$02
	BNE.b CODE_018EBD
	LDA.w !RAM_SIMC_City_CurrentFundsHi
	BNE.b CODE_018EBD
	REP.b #$20
	LDA.w $01DD
	ASL
	TAX
	LDA.w !RAM_SIMC_City_CurrentFundsLo
	CMP.l DATA_01884E,x
	BCS.b CODE_018EBD
	SEC
	RTS

CODE_018EBD:
	REP.b #$20
	LDA.w $01DD
	CMP.w #$000F
	BEQ.b CODE_018EC9
	CLC
	RTS

CODE_018EC9:
	LDA.w $03F5
	ORA.w $03F7
	BEQ.b CODE_018ED3
	CLC
	RTS

CODE_018ED3:
	SEC
	RTS

CODE_018ED5:
	SEP.b #$20
	REP.b #$10
	LDX.w #$000F
CODE_018EDC:
	LDA.w $028B,x
	CPX.w $01DD
	BEQ.b CODE_018EF0
	AND.b #$80
	STA.w $029B,x
	DEX
	BPL.b CODE_018EDC
CODE_018EEC:
	JSR.w CODE_01C817
	RTS

CODE_018EF0:
	ORA.b #$01
	STA.w $029B,x
	DEX
	BPL.b CODE_018EDC
	BMI.b CODE_018EEC			; Note: This will always branch.

CODE_018EFA:
	REP.b #$20
	LDA.w $020D
	CMP.w #$000F
	BEQ.b CODE_018F05
	RTS

CODE_018F05:
	PHP
	JSL.l CODE_0098A0	: dw $0102
	PLP
	REP.b #$20
	JSR.w CODE_01CAC3
	RTS

CODE_018F13:
	REP.b #$20
	REP.b #$10
	LDX.w $020D
	LDA.l DATA_018000,x
	AND.w #$00FF
	STA.w $01F9
	RTS

CODE_018F25:
	REP.b #$30
	LDA.w $020D
	ASL
	TAX
	LDA.l DATA_018FC4,x
	PHA
	LDY.w #$0000
	TYX
	PHK
	PLB
CODE_018F37:
	LDA.b ($01,S),y
	INY
	INY
	CLC
	ADC.w #$AF07
	STA.l SIMC_Global_OAMBuffer[$22].XDisp,x
	LDA.b ($01,S),y
	INY
	INY
	STA.l SIMC_Global_OAMBuffer[$22].Tile,x
	INX
	INX
	INX
	INX
	CPY.w #$0014
	BCC.b CODE_018F37
	LDX.w #$0000
CODE_018F57:
	LDA.b ($01,S),y
	INY
	INY
	CLC
	ADC.w #$AF07
	STA.l SIMC_Global_OAMBuffer[$58].XDisp,x
	LDA.b ($01,S),y
	INY
	INY
	STA.l SIMC_Global_OAMBuffer[$58].Tile,x
	INX
	INX
	INX
	INX
	CPY.w #$003C
	BCC.b CODE_018F57
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	SEP.b #$20
	LDA.l SIMC_Global_UpperOAMBuffer[$08].Slot
	AND.b #$0F
	STA.l SIMC_Global_UpperOAMBuffer[$08].Slot
	LDA.b #$40
	STA.l SIMC_Global_UpperOAMBuffer[$09].Slot
	LDA.b #$00
	STA.l SIMC_Global_UpperOAMBuffer[$16].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$17].Slot
	LDA.b #$50
	STA.l SIMC_Global_UpperOAMBuffer[$18].Slot
	REP.b #$20
	PLA
	RTS

CODE_018F9F:
	SEP.b #$20
	LDA.l SIMC_Global_UpperOAMBuffer[$08].Slot
	AND.b #$0F
	ORA.b #$50
	STA.l SIMC_Global_UpperOAMBuffer[$08].Slot
	LDA.b #$55
	STA.l SIMC_Global_UpperOAMBuffer[$09].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$16].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$17].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$18].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$19].Slot
	RTS

DATA_018FC4:
	dw DATA_018FE4,DATA_019020,DATA_01905C,DATA_019098,DATA_0190D4,DATA_019110,DATA_01914C,DATA_019188
	dw DATA_0191C4,DATA_019200,DATA_01923C,DATA_019278,DATA_01932C,DATA_0192F0,DATA_0192B4,DATA_019368

DATA_018FE4:
	dw $1100,$30AF,$1107,$30AF,$110E,$30AF,$1115,$30AF
	dw $111A,$31A1,$1112,$3184,$111C,$30AF,$0005,$3060
	dw $000D,$3061,$0015,$3062,$001D,$3063,$0025,$3064
	dw $080D,$3065,$0815,$3066,$081D,$3067

DATA_019020:
	dw $1100,$30AF,$1107,$30AF,$110E,$30AF,$1114,$31A1
	dw $111C,$31A0,$110C,$3184,$1120,$30AF,$040D,$3068
	dw $0415,$3069,$041D,$306A,$0008,$30BF,$0008,$30BF
	dw $0008,$30BF,$0008,$30BF,$0008,$30BF

DATA_01905C:
	dw $1100,$30AF,$1107,$30AF,$110E,$30AF,$1114,$31A2
	dw $111C,$31A0,$110C,$3184,$1120,$30AF,$000D,$3070
	dw $0015,$3071,$001D,$3072,$0805,$3073,$080D,$3074
	dw $0815,$3075,$081D,$3076,$0825,$3077

DATA_019098:
	dw $1100,$30AF,$1107,$30AF,$110E,$30AF,$1115,$30AF
	dw $111A,$31A4,$1112,$3184,$111C,$30AF,$000D,$306B
	dw $0015,$306C,$001D,$306D,$0811,$306E,$0819,$306F
	dw $0008,$30BF,$0008,$30BF,$0008,$30BF

DATA_0190D4:
	dw $1100,$30AF,$1107,$30AF,$110E,$30AF,$1114,$31A1
	dw $111C,$31A0,$110C,$3184,$1120,$30AF,$040D,$3078
	dw $0415,$3079,$041D,$307A,$0008,$30BF,$0008,$30BF
	dw $0008,$30BF,$0008,$30BF,$0008,$30BF

DATA_019110:
	dw $1100,$30AF,$1107,$30AF,$1110,$31A1,$1117,$31A0
	dw $111E,$31A0,$1109,$3184,$1123,$30AF,$0405,$307B
	dw $040D,$307C,$0415,$307D,$041D,$3080,$0425,$3081
	dw $0008,$30BF,$0008,$30BF,$0008,$30BF

DATA_01914C:
	dw $1100,$30AF,$1107,$30AF,$1110,$31A1,$1117,$31A0
	dw $111E,$31A0,$1109,$3184,$1123,$30AF,$0405,$3082
	dw $040D,$3083,$0415,$3084,$041D,$3085,$0425,$3086
	dw $0008,$30BF,$0008,$30BF,$0008,$30BF

DATA_019188:
	dw $1100,$30AF,$1107,$30AF,$1110,$31A1,$1117,$31A0
	dw $111E,$31A0,$1109,$3184,$1123,$30AF,$0405,$3087
	dw $040D,$3088,$0415,$3089,$041D,$308A,$0425,$308B
	dw $0008,$30BF,$0008,$30BF,$0008,$30BF

DATA_0191C4:
	dw $1100,$30AF,$1107,$30AF,$1110,$31A4,$1117,$31A0
	dw $111E,$31A0,$1109,$3184,$1123,$30AF,$0405,$308C
	dw $040D,$308D,$0415,$308E,$041D,$308F,$0425,$3090
	dw $0008,$30BF,$0008,$30BF,$0008,$30BF

DATA_019200:
	dw $1100,$30AF,$1107,$30AF,$1110,$31A4,$1117,$31A0
	dw $111E,$31A0,$1109,$3184,$1123,$30AF,$0405,$3091
	dw $040D,$3092,$0415,$3093,$041D,$3094,$0425,$3095
	dw $0008,$30BF,$0008,$30BF,$0008,$30BF

DATA_01923C:
	dw $1100,$30AF,$110D,$31A3,$1114,$31A0,$111B,$31A0
	dw $1122,$31A0,$1106,$3184,$1126,$30AF,$0405,$3096
	dw $040D,$3097,$0415,$3098,$041D,$3099,$0425,$309A
	dw $0008,$30BF,$0008,$30BF,$0008,$30BF

DATA_019278:
	dw $1100,$30AF,$110D,$31A4,$1114,$31A0,$111B,$31A0
	dw $1122,$31A0,$1106,$3184,$1126,$30AF,$0405,$30A1
	dw $040D,$30A2,$0415,$30A3,$041D,$30A4,$0425,$30A5
	dw $0008,$30BF,$0008,$30BF,$0008,$30BF

DATA_0192B4:
	dw $1100,$30AF,$110D,$31A3,$1114,$31A0,$111B,$31A0
	dw $1122,$31A0,$1106,$3184,$1126,$30AF,$000D,$309E
	dw $0015,$309F,$001D,$30A0,$080D,$309B,$0815,$309C
	dw $081D,$309D,$0008,$30BF,$0008,$30BF

DATA_0192F0:
	dw $1100,$30AF,$110D,$31A4,$1114,$31A0,$111B,$31A0
	dw $1122,$31A0,$1106,$3184,$1126,$30AF,$0005,$31B0
	dw $000D,$31B1,$0015,$31B2,$001D,$31B3,$0025,$31B4
	dw $080D,$309B,$0815,$309C,$081D,$309D

DATA_01932C:
	dw $1109,$31A1,$110F,$31A0,$1116,$31A0,$111D,$31A0
	dw $1124,$31A0,$1104,$3184,$112B,$30AF,$0405,$30A6
	dw $040D,$30A7,$0415,$30B0,$041D,$30B1,$0425,$30B2
	dw $0008,$30BF,$0008,$30BF,$0008,$30BF

DATA_019368:
	dw $1100,$30AF,$1107,$30AF,$1110,$31A1,$1117,$31A0
	dw $111E,$31A0,$1109,$3184,$1123,$30AF,$0405,$30B3
	dw $040D,$30B4,$0415,$30B5,$041D,$30B6,$0425,$30B7
	dw $0008,$30BF,$0008,$30BF,$0008,$30BF

CODE_0193A4:
	JSR.w CODE_01A640
	RTS

CODE_0193A8:
	REP.b #$20
	LDA.w $0111
	STA.w $0117
	LDA.w $03FA
	STA.w $03FC
	LDA.w $010F
	STA.w $0119
	LDA.w #$FFFF
	STA.w $0379
	STZ.w $0387
	LDA.b $D7
	BNE.b CODE_0193E1
	LDA.w #$00FF
	STA.b $E3
	JSR.w CODE_01DE39
	JSR.w CODE_01A46D
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	JSR.w CODE_01DE2B
	JSR.w CODE_01DF05
CODE_0193E1:
	REP.b #$20
	LDA.w $0117
	BEQ.b CODE_0193FA
	STA.w $0111
	LDA.w $03FC
	STA.w $03FA
	LDA.w $0119
	STA.w $010F
	STZ.w $0115
CODE_0193FA:
	STZ.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	STZ.b $E3
	STZ.w $0379
	STZ.w $038D
	STZ.w $038F
	LDA.w #$00FF
	STA.w $0399
	RTS

CODE_01940F:
	REP.b #$20
	LDA.w #$00FF
	STA.b $E3
	STZ.w $0387
	LDA.w $0DC3
	BPL.b CODE_019467
	LDA.b $D7
	BNE.b CODE_019467
	LDA.w $0195
	AND.w #$0002
	BNE.b CODE_019467
	LDA.w $01D7
	BNE.b CODE_01943A
	JSR.w CODE_01AC0E
	STZ.b $D7
	SEP.b #$20
	STZ.b !RAM_SIMC_Global_SubScreenLayers
	BRA.b CODE_019441

CODE_01943A:
	JSR.w CODE_01AC0E
	REP.b #$20
	STZ.b $D7
CODE_019441:
	JSR.w CODE_01C8B7
	JSR.w CODE_01C817
	REP.b #$20
	LDA.w $020D
	STA.w $02AB
	STA.w $01E1
	JSR.w CODE_01A02A
	REP.b #$20
	LDA.w #$0003
	COP.b #$00
	REP.b #$20
CODE_01945E:
	STZ.w $0DC3
	STZ.w $0BCB
	STZ.b $E3
	RTS

CODE_019467:
	JSL.l CODE_02A3DC
	JSL.l CODE_02A64D
	BRA.b CODE_01945E

CODE_019471:
	REP.b #$30
	STA.w $0381
	LDA.w #$00FF
	STA.w $0383
	LDX.w $0387
	BEQ.b CODE_019484
	STA.w $0385
CODE_019484:
	LDA.w #$0140
	STA.w $038B
	RTS

CODE_01948B:
	REP.b #$20
	LDA.b $D7
	BNE.b CODE_01949F
	LDA.w $0389
	BNE.b CODE_019497
	RTS

CODE_019497:
	STZ.w $0389
	DEC
	JSR.w CODE_019471
	RTS

CODE_01949F:
	STZ.w $0389
	RTS

CODE_0194A3:
	JSR.w CODE_0194A7
	RTL

CODE_0194A7:
	REP.b #$30
	LDA.w $0385
	BNE.b CODE_0194AF
	RTS

CODE_0194AF:
	STZ.w $0385
	LDA.b $D7
	BEQ.b CODE_0194B7
	RTS

CODE_0194B7:
	LDA.w #$05CE
	STA.b $79
	LDA.w #$0004
	STA.b $7C
CODE_0194C1:
	LDY.w #$0019
	LDX.b $79
	LDA.w #$014B
CODE_0194C9:
	STA.l !RAM_SIMC_Global_Layer3TilemapBuffer,x
	INX
	INX
	DEY
	BNE.b CODE_0194C9
	LDA.b $79
	CLC
	ADC.w #$0040
	STA.b $79
	DEC.b $7C
	BNE.b CODE_0194C1
	JSR.w CODE_01A8FF
	RTS

CODE_0194E2:
	JSR.w CODE_0194E6
	RTL

CODE_0194E6:
	JSR.w CODE_019790
	JSR.w CODE_019C9B
	REP.b #$20
	STZ.w $0383
	LDA.w #$00FF
	STA.w $0387
	JSR.w CODE_01A8FF
	RTS

DATA_0194FB:
	db $02,$02,$02,$00,$01,$01,$02,$02,$02,$01,$00,$02,$02,$03,$03,$03
	db $03,$02,$02,$00,$02,$02,$02,$00,$02,$02,$03,$01,$00,$00,$00,$00
	db $01

DATA_01951C:
	dw DATA_019524,DATA_019594,DATA_01961C,DATA_0196C4

DATA_019524:
	incbin "Tilemaps/DATA_019524.bin"

DATA_019594:
	incbin "Tilemaps/DATA_019594.bin"

DATA_01961C:
	incbin "Tilemaps/DATA_01961C.bin"

DATA_0196C4:
	incbin "Tilemaps/DATA_0196C4.bin"

DATA_01978C:
	db $0E,$11,$15,$19

CODE_019790:
	REP.b #$30
	LDA.w $0381
	TAX
	LDA.l DATA_0194FB,x
	AND.w #$00FF
	TAX
	LDA.l DATA_01978C,x
	AND.w #$00FF
	ASL
	STA.b $7F
	TXA
	ASL
	TAX
	LDA.l DATA_01951C,x
	STA.b $79
	LDY.w #$0000
	LDX.w #$05CE
	STX.b $7C
	LDA.w #$0004
	STA.b $82
CODE_0197BE:
	LDX.b $79
	LDA.b $7C
	CLC
	ADC.w #!RAM_SIMC_Global_Layer3TilemapBuffer
	TAY
	LDA.b $7F
	DEC
	PHB
	MVN !RAM_SIMC_Global_Layer3TilemapBuffer>>16,DATA_019524>>16
	PLB
	LDA.b $7C
	CLC
	ADC.w #$0040
	STA.b $7C
	LDA.b $79
	CLC
	ADC.b $7F
	STA.b $79
	DEC.b $82
	BNE.b CODE_0197BE
	RTS

DATA_0197E3:
	dw DATA_019825,DATA_01984B,DATA_019871,DATA_019897,DATA_0198AF,DATA_0198CD,DATA_0198EB,DATA_019911
	dw DATA_019937,DATA_01995D,DATA_01997B,DATA_019993,DATA_0199B9,DATA_0199DF,DATA_019A0D,DATA_019A3B
	dw DATA_019A69,DATA_019A97,DATA_019ABD,DATA_019AE3,DATA_019AFB,DATA_019B21,DATA_019B47,DATA_019B6D
	dw DATA_019B85,DATA_019BAB,DATA_019BD1,DATA_019BFF,DATA_019C1D,DATA_019C35,DATA_019C4D,DATA_019C65
	dw DATA_019C7D

DATA_019825:
	db $80,$AD,$CF,$D2,$C5,$80,$B2,$C5,$D3,$C9,$C4,$C5,$CE,$D4,$C9,$C1
	db $CC,$80,$80,$80,$DA,$CF,$CE,$C5,$D3,$80,$CE,$C5,$C5,$C4,$C5,$C4
	db $8E,$80,$80,$80,$80,$80

DATA_01984B:
	db $80,$AD,$CF,$D2,$C5,$80,$A3,$CF,$CD,$CD,$C5,$D2,$C3,$C9,$C1,$CC
	db $80,$80,$80,$80,$DA,$CF,$CE,$C5,$D3,$80,$CE,$C5,$C5,$C4,$C5,$C4
	db $8E,$80,$80,$80,$80,$80

DATA_019871:
	db $80,$AD,$CF,$D2,$C5,$80,$A9,$CE,$C4,$D5,$D3,$D4,$D2,$C9,$C1,$CC
	db $80,$80,$80,$80,$DA,$CF,$CE,$C5,$D3,$80,$CE,$C5,$C5,$C4,$C5,$C4
	db $8E,$80,$80,$80,$80,$80

DATA_019897:
	db $80,$AD,$CF,$D2,$C5,$80,$D2,$CF,$C1,$C4,$D3,$80,$80,$D2,$C5,$D1
	db $D5,$C9,$D2,$C5,$C4,$8E,$80,$80

DATA_0198AF:
	db $80,$A9,$CE,$C1,$C4,$C5,$D1,$D5,$C1,$D4,$C5,$80,$80,$80,$80,$80
	db $D2,$C1,$C9,$CC,$80,$D3,$D9,$D3,$D4,$C5,$CD,$8E,$80,$80

DATA_0198CD:
	db $80,$A2,$D5,$C9,$CC,$C4,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80
	db $C1,$80,$B0,$CF,$D7,$C5,$D2,$80,$B0,$CC,$C1,$CE,$D4,$8E

DATA_0198EB:
	db $80,$B2,$C5,$D3,$C9,$C4,$C5,$CE,$D4,$D3,$80,$C4,$C5,$CD,$C1,$CE
	db $C4,$80,$80,$80,$C1,$80,$B3,$D4,$C1,$C4,$C9,$D5,$CD,$8E,$80,$80
	db $80,$80,$80,$80,$80,$80

DATA_019911:
	db $80,$A9,$CE,$C4,$D5,$D3,$D4,$D2,$D9,$80,$D2,$C5,$D1,$D5,$C9,$D2
	db $C5,$D3,$80,$80,$C1,$80,$B3,$C5,$C1,$80,$B0,$CF,$D2,$D4,$8E,$80
	db $80,$80,$80,$80,$80,$80

DATA_019937:
	db $80,$A3,$CF,$CD,$CD,$C5,$D2,$C3,$C5,$80,$D2,$C5,$D1,$D5,$C9,$D2
	db $C5,$D3,$80,$80,$C1,$CE,$80,$A1,$C9,$D2,$D0,$CF,$D2,$D4,$8E,$80
	db $80,$80,$80,$80,$80,$80

DATA_01995D:
	db $80,$B0,$CF,$CC,$CC,$D5,$D4,$C9,$CF,$CE,$80,$80,$80,$80,$80,$80
	db $D6,$C5,$D2,$D9,$80,$C8,$C9,$C7,$C8,$8E,$80,$80,$80,$80

DATA_01997B:
	db $80,$A3,$D2,$C9,$CD,$C5,$80,$80,$80,$80,$80,$80,$80,$D6,$C5,$D2
	db $D9,$80,$C8,$C9,$C7,$C8,$8E,$80

DATA_019993:
	db $80,$A6,$D2,$C5,$D1,$D5,$C5,$CE,$D4,$80,$D4,$D2,$C1,$C6,$C6,$C9
	db $C3,$80,$80,$80,$CA,$C1,$CD,$D3,$80,$D2,$C5,$D0,$CF,$D2,$D4,$C5
	db $C4,$8E,$80,$80,$80,$80

DATA_0199B9:
	db $80,$A3,$C9,$D4,$C9,$DA,$C5,$CE,$D3,$80,$C4,$C5,$CD,$C1,$CE,$C4
	db $80,$80,$80,$80,$C1,$80,$A6,$C9,$D2,$C5,$80,$A4,$C5,$D0,$C1,$D2
	db $D4,$CD,$C5,$CE,$D4,$8E

DATA_0199DF:
	db $80,$A3,$C9,$D4,$C9,$DA,$C5,$CE,$D3,$80,$C4,$C5,$CD,$C1,$CE,$C4
	db $80,$80,$80,$80,$80,$80,$80,$80,$C1,$80,$B0,$CF,$CC,$C9,$C3,$C5
	db $80,$A4,$C5,$D0,$C1,$D2,$D4,$CD,$C5,$CE,$D4,$8E,$80,$80

DATA_019A0D:
	db $80,$A2,$CC,$C1,$C3,$CB,$CF,$D5,$D4,$D3,$80,$D2,$C5,$D0,$CF,$D2
	db $D4,$C5,$C4,$8E,$80,$80,$80,$80,$A3,$C8,$C5,$C3,$CB,$80,$D0,$CF
	db $D7,$C5,$D2,$80,$CD,$C1,$D0,$8E,$80,$80,$80,$80,$80,$80

DATA_019A3B:
	db $80,$A3,$C9,$D4,$C9,$DA,$C5,$CE,$D3,$80,$D5,$D0,$D3,$C5,$D4,$8E
	db $80,$B4,$C8,$C5,$80,$80,$80,$80,$D4,$C1,$D8,$80,$D2,$C1,$D4,$C5
	db $80,$C9,$D3,$80,$D4,$CF,$CF,$80,$C8,$C9,$C7,$C8,$8E,$80

DATA_019A69:
	db $80,$B2,$CF,$C1,$C4,$D3,$80,$C4,$C5,$D4,$C5,$D2,$C9,$CF,$D2,$C1
	db $D4,$C9,$CE,$C7,$8C,$80,$80,$80,$C4,$D5,$C5,$80,$D4,$CF,$80,$CC
	db $C1,$C3,$CB,$80,$CF,$C6,$80,$C6,$D5,$CE,$C4,$D3,$8E,$80

DATA_019A97:
	db $80,$A6,$C9,$D2,$C5,$80,$C4,$C5,$D0,$C1,$D2,$D4,$CD,$C5,$CE,$D4
	db $D3,$80,$80,$80,$CE,$C5,$C5,$C4,$80,$C6,$D5,$CE,$C4,$C9,$CE,$C7
	db $8E,$80,$80,$80,$80,$80

DATA_019ABD:
	db $80,$B0,$CF,$CC,$C9,$C3,$C5,$80,$C4,$C5,$D0,$C1,$D2,$D4,$CD,$C5
	db $CE,$D4,$D3,$80,$CE,$C5,$C5,$C4,$80,$C6,$D5,$CE,$C4,$C9,$CE,$C7
	db $8E,$80,$80,$80,$80,$80

DATA_019AE3:
	db $80,$B3,$C8,$C9,$D0,$D7,$D2,$C5,$C3,$CB,$80,$80,$80,$D2,$C5,$D0
	db $CF,$D2,$D4,$C5,$C4,$80,$81,$80

DATA_019AFB:
	db $80,$95,$80,$D9,$C5,$C1,$D2,$D3,$80,$D4,$CF,$80,$80,$80,$80,$80
	db $80,$80,$80,$80,$C3,$CF,$CD,$D0,$CC,$C5,$D4,$C5,$80,$D3,$C3,$C5
	db $CE,$C1,$D2,$C9,$CF,$8E

DATA_019B21:
	db $80,$94,$80,$D9,$C5,$C1,$D2,$D3,$80,$D4,$CF,$80,$80,$80,$80,$80
	db $80,$80,$80,$80,$C3,$CF,$CD,$D0,$CC,$C5,$D4,$C5,$80,$D3,$C3,$C5
	db $CE,$C1,$D2,$C9,$CF,$8E

DATA_019B47:
	db $80,$93,$80,$D9,$C5,$C1,$D2,$D3,$80,$D4,$CF,$80,$80,$80,$80,$80
	db $80,$80,$80,$80,$C3,$CF,$CD,$D0,$CC,$C5,$D4,$C5,$80,$D3,$C3,$C5
	db $CE,$C1,$D2,$C9,$CF,$8E

DATA_019B6D:
	db $80,$A5,$D8,$D0,$CC,$CF,$D3,$C9,$CF,$CE,$80,$80,$80,$C4,$C5,$D4
	db $C5,$C3,$D4,$C5,$C4,$80,$81,$80

DATA_019B85:
	db $80,$92,$80,$D9,$C5,$C1,$D2,$D3,$80,$D4,$CF,$80,$80,$80,$80,$80
	db $80,$80,$80,$80,$C3,$CF,$CD,$D0,$CC,$C5,$D4,$C5,$80,$D3,$C3,$C5
	db $CE,$C1,$D2,$C9,$CF,$8E

DATA_019BAB:
	db $80,$91,$80,$D9,$C5,$C1,$D2,$80,$D4,$CF,$80,$80,$80,$80,$80,$80
	db $80,$80,$80,$80,$C3,$CF,$CD,$D0,$CC,$C5,$D4,$C5,$80,$D3,$C3,$C5
	db $CE,$C1,$D2,$C9,$CF,$8E

DATA_019BD1:
	db $80,$A2,$D2,$CF,$D7,$CE,$CF,$D5,$D4,$D3,$8C,$80,$C2,$D5,$C9,$CC
	db $C4,$80,$80,$80,$80,$80,$80,$80,$C1,$CE,$CF,$D4,$C8,$C5,$D2,$80
	db $B0,$CF,$D7,$C5,$D2,$80,$B0,$CC,$C1,$CE,$D4,$8E,$80,$80

DATA_019BFF:
	db $80,$A8,$C5,$C1,$D6,$D9,$80,$B4,$D2,$C1,$C6,$C6,$C9,$C3,$80,$80
	db $D2,$C5,$D0,$CF,$D2,$D4,$C5,$C4,$8E,$80,$80,$80,$80,$80

DATA_019C1D:
	db $80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80,$80
	db $80,$80,$80,$80,$80,$80,$80,$80

DATA_019C35:
	db $80,$D5,$CE,$C1,$C2,$CC,$C5,$80,$80,$80,$80,$80,$80,$D4,$CF,$80
	db $D3,$C1,$D6,$C5,$8E,$80,$80,$80

DATA_019C4D:
	db $80,$B3,$C1,$D6,$C5,$80,$80,$80,$80,$80,$80,$80,$80,$C3,$CF,$CD
	db $D0,$CC,$C5,$D4,$C5,$C4,$8E,$80

DATA_019C65:
	db $80,$AF,$CE,$C5,$80,$CD,$CF,$CD,$C5,$CE,$D4,$80,$80,$D0,$CC,$C5
	db $C1,$D3,$C5,$8E,$8E,$8E,$80,$80

DATA_019C7D:
	db $80,$B3,$C5,$C5,$80,$D9,$CF,$D5,$80,$D3,$CF,$CF,$CE,$8E,$80,$80
	db $A7,$CF,$CF,$C4,$80,$C2,$D9,$C5,$81,$80,$80,$80,$80,$80

CODE_019C9B:
	REP.b #$30
	LDA.w $0381
	ASL
	TAX
	LDA.l DATA_0197E3,x
	STA.b $79
	LDA.w #$0610
	STA.b $7C
	LDA.w $0381
	TAX
	LDA.l DATA_0194FB,x
	AND.w #$00FF
	TAX
	LDA.l DATA_01978C,x
	AND.w #$00FF
	SEC
	SBC.w #$0002
	STA.b $7F
	LDA.w #$0002
	STA.b $82
	LDX.b $79
CODE_019CCD:
	LDA.b $7F
	PHA
	LDY.b $7C
CODE_019CD2:
	LDA.l DATA_019825&$FF0000,x
	AND.w #$00FF
	ORA.w #$2C00
	PHX
	TYX
	STA.l !RAM_SIMC_Global_Layer3TilemapBuffer,x
	PLX
	INY
	INY
	INX
	DEC.b $7F
	BNE.b CODE_019CD2
	PLA
	STA.b $7F
	LDA.b $7C
	CLC
	ADC.w #$0040
	STA.b $7C
	DEC.b $82
	BNE.b CODE_019CCD
	RTS

DATA_019CFA:
	dw CODE_01B547
	dw CODE_01B43D
	dw CODE_01B43D
	dw CODE_01B43D
	dw CODE_01B483
	dw CODE_01B483
	dw CODE_01B483
	dw CODE_01B483
	dw CODE_01B483
	dw CODE_01B483
	dw CODE_01B483
	dw CODE_01B483
	dw CODE_01B483
	dw CODE_01B483
	dw CODE_01B483
	dw CODE_01B483

DATA_019D1A:
	dw CODE_01D083
	dw CODE_01D083
	dw CODE_01D083
	dw CODE_01D0AA
	dw CODE_01D0AA
	dw CODE_019E16
	dw CODE_01D06A
	dw CODE_019D6A

DATA_019D2A:
	dw CODE_01DEFE
	dw CODE_01DEFE
	dw CODE_01DEFE
	dw CODE_01DEFE
	dw CODE_01DEFE
	dw CODE_01DF05
	dw CODE_01DEFE
	dw CODE_01DEFE

DATA_019D3A:
	dw CODE_01A886
	dw CODE_01A97C
	dw CODE_01AA39
	dw CODE_01AAD5
	dw CODE_01AD54
	dw CODE_01A46D
	dw CODE_01A6EE
	dw CODE_01A660

DATA_019D4A:
	dw CODE_01DE0D
	dw CODE_01DE0D
	dw CODE_01DE0D
	dw CODE_01DE0D
	dw CODE_01DE0D
	dw CODE_01DE0D
	dw CODE_019D6A
	dw CODE_019D6A

DATA_019D5A:
	dw CODE_01DE14
	dw CODE_01DE14
	dw CODE_01DE14
	dw CODE_01DE14
	dw CODE_01DE14
	dw CODE_01DE2B
	dw CODE_01DE14
	dw CODE_019E91

CODE_019D6A:
	RTS

CODE_019D6B:
	JSR.w CODE_01B143
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	STZ.w $01E9
	LDA.w $01DF
	CMP.w #$0007
	BNE.b CODE_019D95
	LDA.w $03FA
	BEQ.b CODE_019E07
CODE_019D95:
	LDA.w #$00FF
	STA.b $E3
	STA.w $0379
	JSR.w CODE_019F18
	PHP
	JSL.l CODE_0098A0	: dw $0102
	PLP
	REP.b #$30
	LDA.w $01DF
	REP.b #$10
	ASL
	TAX
	JSR.w (DATA_019D1A,x)
	REP.b #$30
	LDA.w #$FFFF
	STA.w $0AB5
	STA.w $0101
	STA.w $01E9
	LDA.w $01DF
	REP.b #$10
	ASL
	TAX
	JSR.w (DATA_019D4A,x)
CODE_019DCC:
	REP.b #$30
	LDA.w $01DF
	REP.b #$10
	ASL
	TAX
	JSR.w (DATA_019D3A,x)
	REP.b #$30
	LDA.w $01DF
	REP.b #$10
	ASL
	TAX
	JSR.w (DATA_019D5A,x)
	REP.b #$30
	LDA.w $01DF
	REP.b #$10
	ASL
	TAX
	JSR.w (DATA_019D2A,x)
	JSR.w CODE_01DEEF
	JSR.w CODE_018A44
	SEP.b #$20
	STZ.b $B7
	REP.b #$20
	STZ.w $0AB5
	STZ.w $0101
	STZ.b $E3
	STZ.w $0379
CODE_019E07:
	RTS

DATA_019E08:
	dw $0007,$0015,$000F,$0029,$0028,$002A,$002D

CODE_019E16:
	LDA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	BNE.b CODE_019E7D
	LDY.w #$002D
	LDA.w $0C9F
	ORA.w $0A91
	ORA.w $0A8B
	ORA.w $0C11
	BNE.b CODE_019E5C
	LDY.w #$0000
	TYX
	LDA.w !RAM_SIMC_City_1stWorstProblemPercent
	AND.w #$00FF
	CMP.w #$0014
	BCC.b CODE_019E5C
	LDA.w !RAM_SIMC_City_2ndWorstProblemPercent
	AND.w #$00FF
	CMP.w #$0014
	BCC.b CODE_019E4F
	LDA.b $D1
	AND.w #$0003
	BNE.b CODE_019E4F
	INX
	INX
CODE_019E4F:
	LDA.w !RAM_SIMC_City_1stWorstProblem,x
	AND.w #$00FF
	ASL
	TAX
	LDA.l DATA_019E08,x
	TAY
CODE_019E5C:
	STY.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.w $038D
	LDA.w #$0780
	STA.w $038D
	CPY.w $0399
	BNE.b CODE_019E81
	CMP.w #$0000
	BEQ.b CODE_019E81
	INC.w $038F
	LDA.w $038F
	CMP.w #$0003
	BCS.b CODE_019E86
CODE_019E7D:
	STY.w $0399
	RTS

CODE_019E81:
	STZ.w $038F
	BRA.b CODE_019E7D

CODE_019E86:
	LDY.w #$0025
	STZ.w $038F
	STY.w !RAM_SIMC_City_CurrentWrightMessage
	BRA.b CODE_019E7D

CODE_019E91:
	REP.b #$30
	LDX.w #$0000
CODE_019E96:
	LDA.l DATA_058A00,x
	STA.l SIMC_Global_PaletteMirror[$00].LowByte,x
	INX
	INX
	CPX.w #$0200
	BNE.b CODE_019E96
	LDA.w #$0001
	STA.w $0B4B
	LDA.w #$00FF
	STA.w $0B4F
	JSL.l CODE_0094D5
	JSL.l CODE_008DA2
	RTS

CODE_019EBA:
	REP.b #$30
	LDA.w #$00B0
	STA.w $0253
	LDA.w #$0040
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w #$0020
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$0009
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	RTS

CODE_019EDC:
	SEP.b #$30
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	SEP.b #$20
	LDA.b #$10
	STA.b !RAM_SIMC_Global_ColorMathInitialSettings
	LDA.b #$A3
	STA.b !RAM_SIMC_Global_ColorMathSelectAndEnable
	LDA.b #$E8
	STA.b !RAM_SIMC_Global_FixedColorData
	STZ.b !RAM_SIMC_Global_ColorMathInitialSettings
	STZ.b !RAM_SIMC_Global_MainScreenWindowMask
	STZ.b !RAM_SIMC_Global_SubScreenWindowMask
	LDA.b #$A0
	STA.b !RAM_SIMC_Global_ObjectAndColorWindowSettings
	RTS

CODE_019EFE:
	SEP.b #$30
	LDA.b #$10
	STA.b !RAM_SIMC_Global_ColorMathInitialSettings
	LDA.b #$00
	STA.b !RAM_SIMC_Global_ColorMathSelectAndEnable
	LDA.b #$10
	STA.b !RAM_SIMC_Global_MainScreenWindowMask
	STA.b !RAM_SIMC_Global_SubScreenWindowMask
	LDA.b #$22
	STA.b !RAM_SIMC_Global_BG1And2WindowMaskSettings
	LDA.b #$03
	STA.b !RAM_SIMC_Global_ObjectAndColorWindowSettings
	RTS

CODE_019F17:
	RTS

CODE_019F18:
	REP.b #$30
	STZ.w $01E3
	JSR.w CODE_01CA48
	RTS

CODE_019F21:
	REP.b #$30
	LDA.w #$0001
	STA.w $01E3
	JSR.w CODE_01CA48
	RTS

CODE_019F2D:
	REP.b #$30
	STZ.w $0379
	LDA.b $D7
	CMP.w #$0002
	BNE.b CODE_019F3C
	JMP.w CODE_01A025

CODE_019F3C:
	CMP.w #$0000
	BNE.b CODE_019F44
	JMP.w CODE_019FD1

CODE_019F44:
	REP.b #$20
	LDA.w #$0004
	COP.b #$00
	REP.b #$20
	LDA.w $0404
	STA.w $0195
	STZ.b $D7
	STZ.w $0465
	STZ.w $0101
	JSR.w CODE_01A064
	JSL.l CODE_0097F4
	SEP.b #$20
	LDA.b #$09
	STA.b !RAM_SIMC_Global_BGModeAndTileSizeSetting
	LDA.b #$03
	STA.b !RAM_SIMC_Global_OAMSizeAndDataAreaDesignation
	JSR.w CODE_01DF7B
	REP.b #$20
	LDA.w #$0001
	COP.b #$00
	JSR.w CODE_01A25B
	REP.b #$30
	LDA.w #$00FF
	STA.w $01D7
	STA.w $01E5
	JSR.w CODE_01C8B7
	JSR.w CODE_01C817
	REP.b #$10
	JSR.w CODE_01C660
	JSR.w CODE_01A064
	JSR.w CODE_01A08C
	JSR.w CODE_01A0C2
	STZ.w $01C1
	STZ.w $01F5
	JSR.w CODE_01A02A
	REP.b #$20
	LDA.w #$0003
	STA.w $01DF
	LDA.w #$FFFF
	STA.b $E3
	STA.w $0AB5
	STA.w $0101
	STA.w $01E9
	STA.w $0379
	JSR.w CODE_019F18
	JSR.w CODE_01D0AA
	JSR.w CODE_01DE0D
	REP.b #$20
	LDA.w #$0003
	COP.b #$00
	JSR.w CODE_01C616
	JMP.w CODE_019DCC

CODE_019FD0:
	RTS

CODE_019FD1:
	JSL.l CODE_008403
	REP.b #$20
	INC.b $D7
	INC.w $0465
	LDA.w $0195
	STA.w $0404
	ORA.w #$0002
	STA.w $0195
	STZ.w $0101
	SEP.b #$20
	LDA.b #$01
	STA.b !RAM_SIMC_Global_BGModeAndTileSizeSetting
	LDA.b #$00
	STA.b !RAM_SIMC_Global_ObjectAndColorWindowSettings
	REP.b #$20
	LDA.w #$0001
	COP.b #$00
	JSR.w CODE_01A0FE
	JSR.w CODE_01A0A7
	JSR.w CODE_01A0C2
	STZ.w $01C1
	STZ.w $01F5
	JSR.w CODE_01A02A
	JSR.w CODE_01A312
	SEP.b #$20
	STZ.b $B7
	PHP
	JSL.l CODE_0098A0	: dw $0602
	PLP
	REP.b #$20
	LDA.w #$0003
	COP.b #$00
	RTS

CODE_01A025:
	RTS

CODE_01A026:
	JSR.w CODE_01A02A
	RTL

CODE_01A02A:
	REP.b #$20
	LDA.w #$000E
	STA.w $01B3
CODE_01A032:
	JSR.w CODE_01C033
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	LDA.w $01B3
	CMP.w #$000E
	BCC.b CODE_01A032
	RTS

CODE_01A047:
	REP.b #$20
	LDA.w #$000E
	STA.w $01B3
CODE_01A04F:
	JSR.w CODE_01C033
	JSR.w CODE_01B143
	JSL.l CODE_008206
	REP.b #$20
	LDA.w $01B3
	CMP.w #$000E
	BCC.b CODE_01A04F
	RTS

CODE_01A064:
	SEP.b #$20
	REP.b #$10
	LDA.b #$17
	STA.b !RAM_SIMC_Global_MainScreenLayers
	STZ.b !RAM_SIMC_Global_MainScreenWindowMask
	LDA.b #$B3
	STA.b !RAM_SIMC_Global_ColorMathSelectAndEnable
	LDA.b #$02
	STA.b !RAM_SIMC_Global_ColorMathInitialSettings
	LDA.b #$E0
	STA.b !RAM_SIMC_Global_FixedColorData
	LDA.b #$03
	STA.b !RAM_SIMC_Global_OAMSizeAndDataAreaDesignation
	STZ.b !RAM_SIMC_Global_ObjectAndColorWindowSettings
	LDA.b #$04
	LDX.w $01D7
	BNE.b CODE_01A089
	LDA.b #$00
CODE_01A089:
	STA.b !RAM_SIMC_Global_SubScreenLayers
	RTS

CODE_01A08C:
	REP.b #$20
	LDA.w #$005F
	STA.w $01C5
	LDA.w #$FFF9
	STA.w $01C7
	LDA.w #$004E
	STA.w $01C9
	LDA.w #$FFFA
	STA.w $01CB
	RTS

CODE_01A0A7:
	REP.b #$20
	LDA.w #$005A
	STA.w $01C5
	LDA.w #$FFF8
	STA.w $01C7
	LDA.w #$004A
	STA.w $01C9
	LDA.w #$FFFA
	STA.w $01CB
	RTS

CODE_01A0C2:
	REP.b #$20
	LDA.w $01BD
	BMI.b CODE_01A0D6
	CMP.w $01C5
	BCC.b CODE_01A0E1
	LDA.w $01C5
	STA.w $01BD
	BRA.b CODE_01A0E1

CODE_01A0D6:
	CMP.w $01C7
	BCS.b CODE_01A0E1
	LDA.w $01C7
	STA.w $01BD
CODE_01A0E1:
	LDA.w $01BF
	BMI.b CODE_01A0F2
	CMP.w $01C9
	BCC.b CODE_01A0F1
	LDA.w $01C9
	STA.w $01BF
CODE_01A0F1:
	RTS

CODE_01A0F2:
	CMP.w $01CB
	BCS.b CODE_01A0F1
	LDA.w $01CB
	STA.w $01BF
	RTS

CODE_01A0FE:
	SEP.b #$20
	REP.b #$10
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_09A571
	STX.b $09
	LDA.b #DATA_09A571>>16
	STA.b $0B
	LDX.w #$2000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	JSR.w CODE_01A2E9
	SEP.b #$20
	REP.b #$10
	STZ.b $B7
	JSL.l CODE_008206
	SEP.b #$20
	REP.b #$10
	LDA.b #$01
	STA.w DMA[$01].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$01].Destination
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$01].SourceBank
	LDX.w #$7000
	STX.w !REGISTER_VRAMAddressLo
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer
	STX.w DMA[$01].SourceLo
	LDX.w #$1000
	STX.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	SEP.b #$20
	REP.b #$10
	LDX.w #$7800
	STX.w !REGISTER_VRAMAddressLo
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$1000
	STX.w DMA[$01].SourceLo
	LDX.w #$0400
	STX.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	REP.b #$20
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_08C4DB
	STX.b $09
	LDA.b #DATA_08C4DB>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0BC51C
	STX.b $09
	LDA.b #DATA_0BC51C>>16
	STA.b $0B
	LDX.w #$2800
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	REP.b #$30
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$2800
	LDY.w #!RAM_SIMC_Global_Layer3TilemapBuffer
	LDA.w #$07FF
	PHB
	MVN !RAM_SIMC_Global_Layer3TilemapBuffer>>16,(!RAM_SIMC_Global_GeneralPurposeBuffer+$2800)>>16
	PLB
	JSL.l CODE_0085FE
	SEP.b #$20
	REP.b #$10
	JSL.l CODE_008206
	LDA.b #$01
	STA.w DMA[$01].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$01].Destination
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$01].SourceBank
	LDX.w #$4000
	STX.w !REGISTER_VRAMAddressLo
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer
	STX.w DMA[$01].SourceLo
	LDX.w #$1000
	STX.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	SEP.b #$20
	LDX.w #$4800
	STX.w !REGISTER_VRAMAddressLo
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$1000
	STX.w DMA[$01].SourceLo
	LDX.w #$1000
	STX.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	SEP.b #$20
	LDX.w #$5000
	STX.w !REGISTER_VRAMAddressLo
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$2000
	STX.w DMA[$01].SourceLo
	LDX.w #$1000
	STX.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	SEP.b #$20
	LDX.w #$5400
	STX.w !REGISTER_VRAMAddressLo
	LDX.w #!RAM_SIMC_Global_Layer3TilemapBuffer
	STX.w DMA[$01].SourceLo
	LDX.w #$0800
	STX.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	JSR.w CODE_01DAE5
	SEP.b #$20
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	RTS

CODE_01A25B:
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	REP.b #$20
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_09C0FB
	STX.b $09
	LDA.b #DATA_09C0FB>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0BC7BD
	STX.b $09
	LDA.b #DATA_0BC7BD>>16
	STA.b $0B
	LDX.w #$2800
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	LDA.w #$4000
	STA.w !REGISTER_VRAMAddressLo
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer
	STA.w DMA[$00].SourceLo,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$30
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_01A2D5
CODE_01A2D1:
	ASL
	DEX
	BNE.b CODE_01A2D1
CODE_01A2D5:
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_009618
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	SEP.b #$20
	STZ.b $B7
	RTS

CODE_01A2E9:
	REP.b #$30
	PHB
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$2000
	LDY.w #!RAM_SIMC_Global_GeneralPurposeBuffer
	LDA.w #$07FF
	MVN !RAM_SIMC_Global_GeneralPurposeBuffer>>16,(!RAM_SIMC_Global_GeneralPurposeBuffer+$2000)>>16
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$5200
	LDY.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$0800
	LDA.w #$03FF
	MVN (!RAM_SIMC_Global_GeneralPurposeBuffer+$0800)>>16,(!RAM_SIMC_Global_GeneralPurposeBuffer+$5200)>>16
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$3000
	LDY.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$0C00
	LDA.w #$07FF
	MVN (!RAM_SIMC_Global_GeneralPurposeBuffer+$0C00)>>16,(!RAM_SIMC_Global_GeneralPurposeBuffer+$3000)>>16
	PLB
	RTS

CODE_01A312:
	REP.b #$20
	LDA.w #$002C
	STA.w $0261
	LDA.w #$0040
	STA.w $0253
	LDA.w #$00D0
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w #$0096
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	REP.b #$30
	LDA.w #$0010
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDX.w #$0000
	TXY
	LDA.w $0B5B
	AND.w #$00FF
	STA.b $79
CODE_01A34A:
	SEP.b #$20
	LDA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	XBA
	LDA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	REP.b #$20
	STA.l SIMC_Global_OAMBuffer[$00].XDisp,x
	CLC
	ADC.w #$0800
	STA.l SIMC_Global_OAMBuffer[$01].XDisp,x
	CPY.b $79
	BCS.b CODE_01A36A
	LDA.w $0B5C,y
	BRA.b CODE_01A36D

CODE_01A36A:
	LDA.w #$0027
CODE_01A36D:
	INY
	PHX
	AND.w #$00FF
	TAX
	LDA.l DATA_03E5A7,x
	STA.b $7C
	LDA.l DATA_03E57F,x
	PLX
	AND.w #$00FF
	ORA.w #$3100
	STA.l SIMC_Global_OAMBuffer[$00].Tile,x
	LDA.b $7C
	AND.w #$00FF
	ORA.w #$3100
	STA.l SIMC_Global_OAMBuffer[$01].Tile,x
	TXA
	CLC
	ADC.w #$0008
	TAX
	LDA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	CLC
	ADC.w #$0008
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	CPY.w #$0008
	BCC.b CODE_01A34A
	LDA.w #$0000
	STA.l SIMC_Global_UpperOAMBuffer[$00].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$02].Slot
	RTS

DATA_01A3B5:
	db $01,$01,$01,$01,$02,$01,$02,$01,$02,$02,$02,$01,$02,$02

DATA_01A3C3:
	db $00,$00,$00,$01,$01,$01,$08,$09,$04,$0A,$0B,$0D,$0D,$0D,$06,$06
	db $0D,$0D,$0D,$06,$06,$09,$06,$06,$0D,$06,$0D,$02,$0D,$09,$0C,$06
	db $0B,$0B,$07,$0B,$03,$05,$06,$09,$09,$09,$09,$07,$06,$0B,$0D,$00
	db $03,$01,$06,$06

DATA_01A3F7:
	db $04,$02,$02,$02,$02,$02,$03,$04,$03,$03,$03,$01,$01,$01,$01,$04
	db $01,$01,$01,$01,$01,$04,$01,$01,$01,$01,$01,$04,$04,$01,$03,$04
	db $03,$03,$03,$03,$03,$04,$06,$07,$04,$04,$04,$03,$01,$03,$04,$05
	db $03,$02,$04,$04

DATA_01A42B:
	dw $0A00,$0B00,$0C00,$0F00,$1000,$0D00,$0E00

DATA_01A439:
	dw $0000,$0000,$0000,$0000,$0100,$0001,$0000,$0000
	dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dw $0101,$0101,$0001,$0000,$0000,$0100,$0000,$0000
	dw $0001,$0000

CODE_01A46D:
	JSR.w CODE_01B143
	REP.b #$20
	STZ.w $037F
	STZ.w $0105
	LDA.w #$0048
	STA.w $0253
	LDA.w #$0100
	STA.w $0259
	REP.b #$20
	LDA.w #$000A
	COP.b #$00
	JSR.w CODE_01E1FB
	REP.b #$20
	LDA.w #$0001
	COP.b #$00
	REP.b #$20
	LDA.w #$0001
	COP.b #$00
	REP.b #$20
	LDA.w #$0001
	COP.b #$00
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDX.w !RAM_SIMC_City_CurrentWrightMessage
	STX.w $039B
	LDA.l DATA_01A3C3,x
	AND.w #$00FF
	STA.w $039F
	JSR.w CODE_019EDC
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	JSR.w CODE_01E3F0
	JSR.w CODE_01E7CF
	JSR.w CODE_01DD76
	REP.b #$30
	LDX.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.l DATA_01A3F7,x
	AND.w #$00FF
	BEQ.b CODE_01A503
	CMP.w #$0003
	BNE.b CODE_01A4F6
	PHA
	LDA.l DATA_01A439,x
	LSR
	PLA
	BCC.b CODE_01A4F6
	PHP
	JSL.l CODE_0098A0	: dw $0502
	PLP
	LDA.w #$0003
CODE_01A4F6:
	DEC
	ASL
	TAX
	LDA.l DATA_01A42B,x
	SEP.b #$30
	TAX
	XBA
	STA.b $03,x
CODE_01A503:
	SEP.b #$20
	LDA.b #$FF
	STA.w $0391
	JSR.w CODE_01E72F
	SEP.b #$20
	REP.b #$10
	LDX.w $039F
	LDA.l DATA_01A3B5,x
	DEC
	STA.w $0377
	JSR.w CODE_01EB12
	JSR.w CODE_01E934
	JSR.w CODE_01E95B
	JSR.w CODE_01E89A
	JSR.w CODE_01E982
	SEP.b #$20
	LDA.b #$14
	STA.b !RAM_SIMC_Global_MainScreenLayers
	LDA.b #$03
	STA.b !RAM_SIMC_Global_SubScreenLayers
	LDA.b #$02
	STA.b !RAM_SIMC_Global_ColorMathInitialSettings
	LDA.b #$60
	STA.b !RAM_SIMC_Global_ColorMathSelectAndEnable
	LDA.b #$E0
	STA.b !RAM_SIMC_Global_FixedColorData
	LDA.b #$FF
	STA.w !REGISTER_Window1LeftPositionDesignation
	STA.w !REGISTER_Window2LeftPositionDesignation
	STZ.w !REGISTER_Window1RightPositionDesignation
	STZ.w !REGISTER_Window2RightPositionDesignation
	LDA.b #$14
	STA.b !RAM_SIMC_Global_MainScreenWindowMask
	LDA.b #$03
	STA.b !RAM_SIMC_Global_SubScreenWindowMask
	LDA.b #$AA
	STA.b !RAM_SIMC_Global_BG1And2WindowMaskSettings
	LDA.b #$03
	STA.b !RAM_SIMC_Global_BG3And4WindowMaskSettings
	STA.b !RAM_SIMC_Global_ObjectAndColorWindowSettings
	LDA.b #$05
	STA.b !RAM_SIMC_Global_BGWindowLogicSettings
	JSR.w CODE_01E67D
	SEP.b #$20
	LDA.b #$03
	STA.b !RAM_SIMC_Global_ObjectAndColorWindowSettings
	LDA.b #$18
	STA.w !REGISTER_Window1LeftPositionDesignation
	LDA.b #$E7
	STA.w !REGISTER_Window1RightPositionDesignation
	LDA.b #$10
	STA.b !RAM_SIMC_Global_MainScreenWindowMask
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	LDA.w #$0708
	STA.b $56
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
CODE_01A591:
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.b $C9
	AND.w #$8040
	BNE.b CODE_01A5CA
	LDA.b $56
	BEQ.b CODE_01A5CA
	JSR.w CODE_01EB12
	JSL.l CODE_03F282
	REP.b #$20
	LDA.w !RAM_SIMC_City_CurrentWrightMessage
	CMP.w #$002F
	BEQ.b CODE_01A591
	JSR.w CODE_01EA5F
	JSR.w CODE_01E934
	JSR.w CODE_01E95B
	JSR.w CODE_01E89A
	JSR.w CODE_01E8E9
	JSR.w CODE_01E982
	BRA.b CODE_01A591

CODE_01A5CA:
	SEP.b #$20
	LDA.b #$18
	STA.w !REGISTER_Window1LeftPositionDesignation
	LDA.b #$E8
	STA.w !REGISTER_Window1RightPositionDesignation
	LDA.b #$03
	STA.b !RAM_SIMC_Global_BG3And4WindowMaskSettings
	STA.b !RAM_SIMC_Global_ObjectAndColorWindowSettings
	LDA.b #$14
	STA.b !RAM_SIMC_Global_MainScreenWindowMask
	PHP
	JSL.l CODE_0098A0	: dw $0702
	PLP
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	JSR.w CODE_01E6B5
	SEP.b #$20
	LDA.b #$00
	STA.b !RAM_SIMC_Global_BG1And2WindowMaskSettings
	STZ.w $0391
	REP.b #$20
	LDA.w #$0001
	COP.b #$00
	JSR.w CODE_01E5FE
	SEP.b #$20
	LDA.b #$17
	STA.b !RAM_SIMC_Global_MainScreenLayers
	LDA.b #$04
	STA.b !RAM_SIMC_Global_SubScreenLayers
	STZ.b !RAM_SIMC_Global_MainScreenWindowMask
	STZ.b !RAM_SIMC_Global_ObjectAndColorWindowSettings
	STZ.b !RAM_SIMC_Global_ColorMathSelectAndEnable
	REP.b #$30
	LDA.w #$00FF
	STA.w $01D7
	STA.w $01E5
	JSR.w CODE_01C8B7
	JSR.w CODE_01C817
	REP.b #$10
	JSR.w CODE_01C660
	JSR.w CODE_019EFE
	JSR.w CODE_01DF7B
	JSR.w CODE_01D94F
	JSR.w CODE_01B3E7
	JSR.w CODE_01BFC3
	REP.b #$20
	STZ.w !RAM_SIMC_City_CurrentWrightMessage
	RTS

CODE_01A640:
	REP.b #$20
	LDA.w $0400
	JSR.w CODE_01A688
	STA.w $01BD
	LDA.w $0402
	JSR.w CODE_01A6A1
	STA.w $01BF
	JSR.w CODE_01A02A
	REP.b #$20
	STZ.w $03FA
	STZ.w $03FE
	RTS

CODE_01A660:
	JSR.w CODE_01A640
	REP.b #$20
	LDA.w $03FE
	AND.w #$00FF
	CMP.w #$00C0
	BNE.b CODE_01A678
	PHP
	JSL.l CODE_0098A0	: dw $0A03
	PLP
CODE_01A678:
	STZ.w $03FE
	STZ.w $03FA
	STZ.w $010F
	STZ.w $0111
	STZ.w $0115
	RTS

CODE_01A688:
	SEC
	SBC.w #$000F
	BPL.b CODE_01A698
	CMP.w #$FFFE
	BCS.b CODE_01A6A0
	LDA.w #$FFFE
	BRA.b CODE_01A6A0

CODE_01A698:
	CMP.w #$005A
	BCC.b CODE_01A6A0
	LDA.w #$005A
CODE_01A6A0:
	RTS

CODE_01A6A1:
	SEC
	SBC.w #$000F
	BPL.b CODE_01A6B1
	CMP.w #$FFFE
	BCS.b CODE_01A6B9
	LDA.w #$FFFE
	BRA.b CODE_01A6B9

CODE_01A6B1:
	CMP.w #$0048
	BCC.b CODE_01A6B9
	LDA.w #$0048
CODE_01A6B9:
	RTS

DATA_01A6BA:
	dw $E5A3,$E5BF,$E5EB,$E627,$E673,$E6CF,$E73B,$E7B7
	dw $E843,$E8DF,$E98B,$EA47,$EB13,$EBEF,$ECDB,$EDD7
	dw $EEE6,$F005,$F134,$F273,$F3C2,$F521,$F690,$F80F
	dw $F99E,$FB3D

CODE_01A6EE:
	SEP.b #$20
	LDA.b #$00
	STA.b !RAM_SIMC_Global_SubScreenLayers
	LDA.b #$03
	STA.b !RAM_SIMC_Global_MainScreenLayers
	LDA.b #$02
	STA.b !RAM_SIMC_Global_BGWindowLogicSettings
	STZ.b !RAM_SIMC_Global_MainScreenWindowMask
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	SEP.b #$20
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	LDA.w #$00FF
	STA.b $E3
	LDA.w #$0002
	STA.b $D7
	JSR.w CODE_018F9F
	JSR.w CODE_01A047
	SEP.b #$20
	LDA.b !RAM_SIMC_Global_BGModeAndTileSizeSetting
	ORA.b #$08
	STA.b !RAM_SIMC_Global_BGModeAndTileSizeSetting
	JSR.w CODE_01A86C
	PHP
	JSL.l CODE_0098A0	: dw $0C02
	PLP
	REP.b #$20
	LDA.w #$0000
	STA.w $0463
	JSL.l CODE_008206
	SEP.b #$20
	STZ.w !REGISTER_HDMAEnable
	STZ.b !RAM_SIMC_Global_HDMAEnable
	LDA.b #$07
	STA.b !RAM_SIMC_Global_MainScreenLayers
	LDA.b #$20
	STA.b !RAM_SIMC_Global_ColorMathInitialSettings
	LDA.b #$1F
	STA.b !RAM_SIMC_Global_ColorMathSelectAndEnable
	LDA.b #$0E
	STA.b !RAM_SIMC_Global_BG1And2WindowMaskSettings
	LDA.b #$03
	STA.b !RAM_SIMC_Global_BG3And4WindowMaskSettings
	LDA.b #$30
	STA.b !RAM_SIMC_Global_ObjectAndColorWindowSettings
	LDA.b #$07
	STA.b !RAM_SIMC_Global_MainScreenWindowMask
	LDA.b #$FF
	STA.w $019B
	LDA.b #$01
	STA.w !REGISTER_Window1LeftPositionDesignation
	LDA.b #$00
	STA.w !REGISTER_Window1RightPositionDesignation
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
CODE_01A77A:
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	SEP.b #$20
	LDA.b #$E7
	STA.b !RAM_SIMC_Global_FixedColorData
	REP.b #$30
	LDA.w $0463
	CMP.w #$000F
	BEQ.b CODE_01A79C
	ASL
	TAX
	LDA.l DATA_01A6BA,x
	INC.w $0463
	BRA.b CODE_01A77A

CODE_01A79C:
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	LDA.w $01C1
	BNE.b CODE_01A7C3
	LDA.b $C9
	AND.w #$0040
	BNE.b CODE_01A80D
	LDA.b $C9
	AND.w #$8000
	BNE.b CODE_01A7C8
	LDA.w $011B
	AND.w #$0F00
	BNE.b CODE_01A7C3
	JSR.w CODE_01C033
CODE_01A7C3:
	JSR.w CODE_018D26
	BRA.b CODE_01A79C

CODE_01A7C8:
	PHP
	JSL.l CODE_0098A0	: dw $0D02
	PLP
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0463
	CMP.w #$0019
	BEQ.b CODE_01A7E8
	INC.w $0463
	SEP.b #$20
	BRA.b CODE_01A7C8

CODE_01A7E8:
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	LDA.w $01C1
	BNE.b CODE_01A808
	LDA.b $C9
	AND.w #$8040
	BNE.b CODE_01A80D
	LDA.w $011B
	AND.w #$0F00
	BNE.b CODE_01A808
	JSR.w CODE_01C033
CODE_01A808:
	JSR.w CODE_018D26
	BRA.b CODE_01A7E8

CODE_01A80D:
	PHP
	JSL.l CODE_0098A0	: dw $0E02
	PLP
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0463
	ASL
	TAX
	LDA.l DATA_01A6BA,x
	DEC.w $0463
	BPL.b CODE_01A80D
	JSR.w CODE_01B143
	STZ.w $019B
	STZ.b $D7
	STZ.b $E3
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	RTS

DATA_01A84C:
	incbin "Palettes/DATA_01A84C.bin"

CODE_01A86C:
	REP.b #$30
	LDX.w #$001E
CODE_01A871:
	LDA.l DATA_01A84C,x
	STA.l SIMC_Global_PaletteMirror[$00].LowByte,x
	DEX
	DEX
	BPL.b CODE_01A871
	SEP.b #$20
	LDA.b $BB
	ORA.b #$02
	STA.b $BB
	RTS

CODE_01A886:
	REP.b #$30
	LDA.w $0193
	JSR.w CODE_01A918
CODE_01A88E:
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	JSR.w CODE_01AE26
	JSR.w CODE_01AECC
	BCC.b CODE_01A88E
	REP.b #$20
	CMP.w #$0008
	BCC.b CODE_01A8C5
	SBC.w #$0008
	BMI.b CODE_01A8FB
	CMP.w $0193
	BEQ.b CODE_01A88E
	PHA
	LDA.w $0193
	JSR.w CODE_01A93A
	PHP
	JSL.l CODE_0098A0	: dw $0102
	PLP
	REP.b #$20
	PLA
	STA.w $0193
	BRA.b CODE_01A886

CODE_01A8C5:
	CMP.w $01DF
	BEQ.b CODE_01A88E
	PHA
	JSR.w CODE_019F21
	REP.b #$20
	PLA
	STA.w $01DF
	JSR.w CODE_019F18
	JSR.w CODE_01DEA4
	JSR.w CODE_01E39A
	JSR.w CODE_01A8FF
	REP.b #$30
	LDA.w $01DF
	REP.b #$10
	ASL
	TAX
	JSR.w (DATA_019D1A,x)
	JSR.w CODE_01DE54
	REP.b #$30
	LDA.w $01DF
	REP.b #$10
	ASL
	TAX
	JMP.w (DATA_019D3A,x)

CODE_01A8FB:
	JSR.w CODE_01AF9B
	RTS

CODE_01A8FF:
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	JSL.l CODE_008E1D
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	REP.b #$20
	RTS

CODE_01A918:
	REP.b #$30
	ASL
	ASL
	ASL
	ASL
	TAX
	SEP.b #$20
	LDA.l SIMC_Global_OAMBuffer[$18].Prop,x
	AND.b #$01
	ORA.b #$34
	STA.l SIMC_Global_OAMBuffer[$18].Prop,x
	STA.l SIMC_Global_OAMBuffer[$19].Prop,x
	STA.l SIMC_Global_OAMBuffer[$1A].Prop,x
	STA.l SIMC_Global_OAMBuffer[$1B].Prop,x
	RTS

CODE_01A93A:
	REP.b #$30
	ASL
	ASL
	ASL
	ASL
	TAX
	SEP.b #$20
	LDA.l SIMC_Global_OAMBuffer[$18].Prop,x
	AND.b #$01
	ORA.b #$32
	STA.l SIMC_Global_OAMBuffer[$18].Prop,x
	STA.l SIMC_Global_OAMBuffer[$19].Prop,x
	STA.l SIMC_Global_OAMBuffer[$1A].Prop,x
	STA.l SIMC_Global_OAMBuffer[$1B].Prop,x
	RTS

DATA_01A95C:
	dw $0001,$0002,$0004,$0008,$0010,$0020,$0040,$0080
	dw $0100,$0200,$0400,$0800,$1000,$2000,$4000,$8000

CODE_01A97C:
	SEP.b #$20
	LDA.w $0195
	ASL
	ASL
	ASL
	ASL
	XBA
	REP.b #$30
	STA.b $79
	LDY.w #$0003
CODE_01A98D:
	TYA
	ASL.b $79
	BCC.b CODE_01A997
	JSR.w CODE_01A918
	BRA.b CODE_01A99A

CODE_01A997:
	JSR.w CODE_01A93A
CODE_01A99A:
	REP.b #$20
	DEY
	BPL.b CODE_01A98D
CODE_01A99F:
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	JSR.w CODE_01AE26
	JSR.w CODE_01AECC
	BCC.b CODE_01A99F
	REP.b #$20
	CMP.w #$0008
	BCC.b CODE_01A9FF
	SBC.w #$0008
	BMI.b CODE_01AA35
	ASL
	TAX
	PHX
	LDA.l DATA_01A95C,x
	EOR.w $0195
	STA.w $0195
	AND.l DATA_01A95C,x
	PHA
	BEQ.b CODE_01A9D8
	PHP
	JSL.l CODE_0098A0	: dw $0102
	PLP
	BRA.b CODE_01A9E0

CODE_01A9D8:
	PHP
	JSL.l CODE_0098A0	: dw $0603
	PLP
CODE_01A9E0:
	REP.b #$30
	PLA
	PLX
	CPX.w #$0006
	BNE.b CODE_01A9F6
	SEP.b #$20
	AND.b #$08
	BEQ.b CODE_01A9F8
	LDA.b #$02
	STA.b $04
	JSR.w CODE_01B3E7
CODE_01A9F6:
	BRA.b CODE_01A97C

CODE_01A9F8:
	LDA.b #$01
	STA.b $04
	JMP.w CODE_01A97C

CODE_01A9FF:
	CMP.w $01DF
	BEQ.b CODE_01A99F
	PHA
	JSR.w CODE_019F21
	REP.b #$20
	PLA
	STA.w $01DF
	JSR.w CODE_019F18
	JSR.w CODE_01DEA4
	JSR.w CODE_01E39A
	JSR.w CODE_01A8FF
	REP.b #$30
	LDA.w $01DF
	REP.b #$10
	ASL
	TAX
	JSR.w (DATA_019D1A,x)
	JSR.w CODE_01DE54
	REP.b #$30
	LDA.w $01DF
	REP.b #$10
	ASL
	TAX
	JMP.w (DATA_019D3A,x)

CODE_01AA35:
	JSR.w CODE_01AF9B
	RTS

CODE_01AA39:
	SEP.b #$20
	LDA.w $0197
	ASL
	ASL
	XBA
	REP.b #$30
	STA.b $79
	LDY.w #$0005
CODE_01AA48:
	TYA
	ASL.b $79
	BCC.b CODE_01AA52
	JSR.w CODE_01A918
	BRA.b CODE_01AA55

CODE_01AA52:
	JSR.w CODE_01A93A
CODE_01AA55:
	REP.b #$20
	DEY
	BPL.b CODE_01AA48
CODE_01AA5A:
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	JSR.w CODE_01AE26
	JSR.w CODE_01AECC
	BCC.b CODE_01AA5A
	REP.b #$20
	CMP.w #$0008
	BCC.b CODE_01AA9B
	SBC.w #$0008
	BMI.b CODE_01AAD1
	ASL
	TAX
	LDA.l DATA_01A95C,x
	EOR.w $0197
	STA.w $0197
	AND.l DATA_01A95C,x
	BEQ.b CODE_01AA91
	PHP
	JSL.l CODE_0098A0	: dw $0102
	PLP
	BRA.b CODE_01AA39

CODE_01AA91:
	PHP
	JSL.l CODE_0098A0	: dw $0603
	PLP
	BRA.b CODE_01AA39

CODE_01AA9B:
	CMP.w $01DF
	BEQ.b CODE_01AA5A
	PHA
	JSR.w CODE_019F21
	REP.b #$20
	PLA
	STA.w $01DF
	JSR.w CODE_019F18
	JSR.w CODE_01DEA4
	JSR.w CODE_01E39A
	JSR.w CODE_01A8FF
	REP.b #$30
	LDA.w $01DF
	REP.b #$10
	ASL
	TAX
	JSR.w (DATA_019D1A,x)
	JSR.w CODE_01DE54
	REP.b #$30
	LDA.w $01DF
	REP.b #$10
	ASL
	TAX
	JMP.w (DATA_019D3A,x)

CODE_01AAD1:
	JSR.w CODE_01AF9B
	RTS

CODE_01AAD5:
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	JSR.w CODE_01AE26
	JSR.w CODE_01AECC
	BCC.b CODE_01AAD5
	REP.b #$20
	CMP.w #$0008
	BCS.b CODE_01AAEE
	JMP.w CODE_01ABD1

CODE_01AAEE:
	SBC.w #$0008
	BPL.b CODE_01AAF6
	JMP.w CODE_01AC0A

CODE_01AAF6:
	STA.w $01FB
	CMP.w #$0004
	BNE.b CODE_01AB08
	LDA.w $01E7
	AND.w #$0001
	BEQ.b CODE_01AB2D
	BRA.b CODE_01AB15

CODE_01AB08:
	CMP.w #$0007
	BNE.b CODE_01AB15
	LDA.w $01E7
	AND.w #$0002
	BEQ.b CODE_01AB2D
CODE_01AB15:
	JSR.w CODE_01E1FB
	REP.b #$20
	LDA.w $01FB
	JSR.w CODE_01A918
	REP.b #$20
	LDA.w $01FB
	CMP.w #$0002
	BCC.b CODE_01AB38
	JMP.w CODE_01AC23

CODE_01AB2D:
	PHP
	JSL.l CODE_0098A0	: dw $0202
	PLP
	JMP.w CODE_01AAD5

CODE_01AB38:
	SEP.b #$20
	LDA.b #$03
	STA.b !RAM_SIMC_Global_MainScreenLayers
	JSR.w CODE_01B3FA
	JSL.l CODE_028000
	SEP.b #$20
	LDA.b #$A3
	STA.b !RAM_SIMC_Global_ColorMathSelectAndEnable
	LDA.b #$E7
	STA.b !RAM_SIMC_Global_FixedColorData
	LDA.b #$17
	STA.b !RAM_SIMC_Global_MainScreenLayers
	PHP
	JSL.l CODE_0098A0	: dw $0602
	PLP
	JSR.w CODE_01AD04
	SEP.b #$20
	LDA.b #$B3
	STA.b !RAM_SIMC_Global_ColorMathSelectAndEnable
	LDA.b #$E0
	STA.b !RAM_SIMC_Global_FixedColorData
	JSR.w CODE_01DF7B
	JSR.w CODE_019F18
	JSR.w CODE_01D0D1
	JSR.w CODE_01D6CE
	JSR.w CODE_01D84B
	JSR.w CODE_01D67B
	JSR.w CODE_01D9EA
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	JSR.w CODE_01E211
	REP.b #$30
	LDA.w $0B35
	BEQ.b CODE_01ABC0
	LDA.w $0DC3
	BEQ.b CODE_01ABC0
	LDA.w #$00FF
	STA.w $0BCB
	LDA.w #$0002
	STA.w $01FB
	JSR.w CODE_01AC23
	SEP.b #$20
	STZ.b !RAM_SIMC_Global_SubScreenLayers
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	LDA.w #$0003
	COP.b #$00
	REP.b #$20
	LDA.w $0B35
	DEC
	STA.w $01FB
	JMP.w CODE_01AB38

CODE_01ABC0:
	JSR.w CODE_01D67B
	SEP.b #$20
	LDA.b #$04
	STA.b !RAM_SIMC_Global_SubScreenLayers
	REP.b #$20
	STZ.w $0BCB
	JMP.w CODE_01AAD5

CODE_01ABD1:
	CMP.w $01DF
	BNE.b CODE_01ABD9
	JMP.w CODE_01AAD5

CODE_01ABD9:
	PHA
	JSR.w CODE_019F21
	REP.b #$20
	PLA
	STA.w $01DF
	JSR.w CODE_019F18
	JSR.w CODE_01DEA4
	JSR.w CODE_01E39A
	JSR.w CODE_01A8FF
	REP.b #$30
	LDA.w $01DF
	REP.b #$10
	ASL
	TAX
	JSR.w (DATA_019D1A,x)
	JSR.w CODE_01DE54
	REP.b #$30
	LDA.w $01DF
	REP.b #$10
	ASL
	TAX
	JMP.w (DATA_019D3A,x)

CODE_01AC0A:
	JSR.w CODE_01AF9B
	RTS

CODE_01AC0E:
	REP.b #$20
	LDA.w #$0002
	STA.w $01FB
	JSR.w CODE_01E1FB
	JSR.w CODE_01AC23
	JSR.w CODE_01DF7B
	JSR.w CODE_01E211
	RTS

CODE_01AC23:
	CMP.w #$0007
	BNE.b CODE_01AC2B
	JMP.w CODE_01ACD0

CODE_01AC2B:
	LDA.b $D7
	STA.b $D9
	JSR.w CODE_01D044
	REP.b #$20
	LDA.w #$0004
	COP.b #$00
	LDA.w #$FFFF
	STA.b $D7
	SEP.b #$20
	LDA.b !RAM_SIMC_Global_OAMSizeAndDataAreaDesignation
	PHA
	LDA.b !RAM_SIMC_Global_BGModeAndTileSizeSetting
	PHA
	LDA.b !RAM_SIMC_Global_BG1AddressAndSize
	PHA
	LDA.b !RAM_SIMC_Global_BG2AddressAndSize
	PHA
	LDA.b !RAM_SIMC_Global_BG3AddressAndSize
	PHA
	LDA.b !RAM_SIMC_Global_BG3And4TileDataDesignation
	PHA
	JSL.l CODE_02A0E8
	JSR.w CODE_01B143
	SEP.b #$20
	LDA.b #$17
	STA.b !RAM_SIMC_Global_MainScreenLayers
	PLA
	STA.b !RAM_SIMC_Global_BG3And4TileDataDesignation
	PLA
	STA.b !RAM_SIMC_Global_BG3AddressAndSize
	PLA
	STA.b !RAM_SIMC_Global_BG2AddressAndSize
	PLA
	STA.b !RAM_SIMC_Global_BG1AddressAndSize
	PLA
	STA.b !RAM_SIMC_Global_BGModeAndTileSizeSetting
	PLA
	STA.b !RAM_SIMC_Global_OAMSizeAndDataAreaDesignation
	LDA.b #$04
	STA.b !RAM_SIMC_Global_SubScreenLayers
	LDA.b #$02
	STA.b !RAM_SIMC_Global_ColorMathInitialSettings
	LDA.b #$B3
	STA.b !RAM_SIMC_Global_ColorMathSelectAndEnable
	LDA.b #$03
	STA.b !RAM_SIMC_Global_BG3And4WindowMaskSettings
	LDA.b #$E0
	STA.b !RAM_SIMC_Global_FixedColorData
	LDA.b #$55
	STA.l SIMC_Global_UpperOAMBuffer[$00].Slot
	JSR.w CODE_01D057
	REP.b #$20
	LDA.b $D9
	STA.b $D7
	LDA.w $0BCB
	BNE.b CODE_01ACCF
	JSR.w CODE_019F18
	JSR.w CODE_01D0D1
	JSR.w CODE_01D6CE
	JSR.w CODE_01D67B
	JSR.w CODE_01D84B
	JSR.w CODE_01D9EA
	JSR.w CODE_01E211
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	LDA.w #$0003
	COP.b #$00
	REP.b #$20
	JMP.w CODE_01AAD5

CODE_01ACCF:
	RTS

CODE_01ACD0:
	REP.b #$20
	LDA.w #$0004
	COP.b #$00
	JSR.w CODE_01DEA4
	JSR.w CODE_019E91
	JSR.w CODE_01DF7B
	JSR.w CODE_01C8B7
	JSR.w CODE_01C817
	SEP.b #$20
	STZ.b $B7
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	JSR.w CODE_019F2D
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	STZ.w $0AB5
	STZ.b $E3
	PLA
	RTS

CODE_01AD04:
	SEP.b #$20
	LDA.b #$23
	STA.b !RAM_SIMC_Global_OAMSizeAndDataAreaDesignation
	REP.b #$20
	STZ.b $C3
	JSL.l CODE_028196
	REP.b #$20
	LDA.w #$FFFF
	STA.b $C3
	JSR.w CODE_01AD2E
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	SEP.b #$20
	LDA.b #$03
	STA.b !RAM_SIMC_Global_OAMSizeAndDataAreaDesignation
	LDA.b #$17
	STA.b !RAM_SIMC_Global_MainScreenLayers
	RTS

CODE_01AD2E:
	REP.b #$20
	LDA.w #$5555
	STA.l SIMC_Global_UpperOAMBuffer[$01].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$03].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$05].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$07].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$09].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$0B].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$0D].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$0F].Slot
	RTS

CODE_01AD54:
	REP.b #$30
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	JSR.w CODE_01AE26
	JSR.w CODE_01AECC
	BCC.b CODE_01AD54
	REP.b #$20
	CMP.w #$0008
	BCC.b CODE_01ADE9
	SBC.w #$0008
	BPL.b CODE_01AD74
	JMP.w CODE_01AE22

CODE_01AD74:
	STA.w $01FD
	JSR.w CODE_01A918
	REP.b #$20
	LDA.w $01FD
	BNE.b CODE_01AD8F
	JSL.l CODE_00C7DA
	REP.b #$20
	LDA.w $01FD
	JSR.w CODE_01A93A
	BRA.b CODE_01AD54

CODE_01AD8F:
	CMP.w #$0001
	BNE.b CODE_01ADA2
	JSL.l CODE_00C8DA
	REP.b #$20
	LDA.w $01FD
	JSR.w CODE_01A93A
	BRA.b CODE_01AD54

CODE_01ADA2:
	CMP.w #$0002
	BNE.b CODE_01ADB7
	JSL.l CODE_00C9EF
	BCC.b CODE_01ADD0
	REP.b #$20
	LDA.w $01FD
	JSR.w CODE_01A93A
	BRA.b CODE_01AD54

CODE_01ADB7:
	CMP.w #$0003
	BNE.b CODE_01AD54
	JSL.l CODE_00C941
	BCS.b CODE_01ADC6
	JML.l CODE_00D29D

CODE_01ADC6:
	REP.b #$20
	LDA.w $01FD
	JSR.w CODE_01A93A
	BRA.b CODE_01AD54

CODE_01ADD0:
	REP.b #$20
	LDA.w #$0004
	COP.b #$00
	REP.b #$20
	STZ.w $0101
	LDA.w #$0012
	STA.b $14
	STZ.b $12
	STZ.w $01D7
	PLA
	PLA
	RTL

CODE_01ADE9:
	CMP.w $01DF
	BNE.b CODE_01ADF1
	JMP.w CODE_01AD54

CODE_01ADF1:
	PHA
	JSR.w CODE_019F21
	REP.b #$20
	PLA
	STA.w $01DF
	JSR.w CODE_019F18
	JSR.w CODE_01DEA4
	JSR.w CODE_01E39A
	JSR.w CODE_01A8FF
	REP.b #$30
	LDA.w $01DF
	REP.b #$10
	ASL
	TAX
	JSR.w (DATA_019D1A,x)
	JSR.w CODE_01DE54
	REP.b #$30
	LDA.w $01DF
	REP.b #$10
	ASL
	TAX
	JMP.w (DATA_019D3A,x)

CODE_01AE22:
	JSR.w CODE_01AF9B
	RTS

CODE_01AE26:
	REP.b #$30
	LDA.w $0C0F
	BEQ.b CODE_01AE2E
	RTS

CODE_01AE2E:
	LDA.w $011B
	AND.w #$0F00
	BNE.b CODE_01AE5C
	LDA.b $C9
	AND.w #$3000
	BEQ.b CODE_01AE5B
	LDA.w $01DF
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC.w #$0018
	STA.w $01EB
	LDA.w #$001F
	STA.w $01ED
	PHP
	JSL.l CODE_0098A0	: dw $0803
	PLP
	BRA.b CODE_01AE7F

CODE_01AE5B:
	RTS

CODE_01AE5C:
	SEP.b #$20
	XBA
	REP.b #$20
	LSR
	BCC.b CODE_01AE69
	PHA
	JSR.w CODE_01AE82
	PLA
CODE_01AE69:
	LSR
	BCC.b CODE_01AE71
	PHA
	JSR.w CODE_01AE93
	PLA
CODE_01AE71:
	LSR
	BCC.b CODE_01AE79
	JSR.w CODE_01AEA4
	BRA.b CODE_01AE7F

CODE_01AE79:
	LSR
	BCC.b CODE_01AE7F
	JSR.w CODE_01AEB5
CODE_01AE7F:
	JMP.w CODE_01C616

CODE_01AE82:
	LDA.w $01EB
	CLC
	ADC.w #$0002
	CMP.w #$00F0
	BCC.b CODE_01AEC8
	LDA.w #$00EE
	BRA.b CODE_01AEC8

CODE_01AE93:
	LDA.w $01EB
	SEC
	SBC.w #$0002
	CMP.w #$0010
	BCS.b CODE_01AEC8
	LDA.w #$0010
	BRA.b CODE_01AEC8

CODE_01AEA4:
	LDA.w $01ED
	CLC
	ADC.w #$0002
	CMP.w #$00C8
	BCC.b CODE_01AEC4
	LDA.w #$00C6
	BRA.b CODE_01AEC4

CODE_01AEB5:
	LDA.w $01ED
	SEC
	SBC.w #$0002
	CMP.w #$0018
	BCS.b CODE_01AEC4
	LDA.w #$0018
CODE_01AEC4:
	STA.w $01ED
	RTS

CODE_01AEC8:
	STA.w $01EB
	RTS

CODE_01AECC:
	REP.b #$30
	LDA.w $0C0F
	BNE.b CODE_01AECC
	LDA.b $C9
	BIT.w #$8000
	BNE.b CODE_01AEE6
	BIT.w #$0040
	BNE.b CODE_01AEE1
	CLC
	RTS

CODE_01AEE1:
	LDA.w #$FFFF
	SEC
	RTS

CODE_01AEE6:
	LDA.w $01ED
	CMP.w #$0016
	BCC.b CODE_01AF37
	CMP.w #$0026
	BCS.b CODE_01AF37
	LDA.w $01EB
	CMP.w #$000F
	BCC.b CODE_01AF37
	CMP.w #$008F
	BCS.b CODE_01AF37
	SEC
	SBC.w #$000F
	LSR
	LSR
	LSR
	LSR
	CMP.w $01DF
	BNE.b CODE_01AF17
	PHP
	JSL.l CODE_0098A0	: dw $0603
	PLP
	BRA.b CODE_01AEE1

CODE_01AF17:
	PHA
	PHP
	JSL.l CODE_0098A0	: dw $0102
	PLP
	PLA
	CMP.w #$0007
	BNE.b CODE_01AF35
	LDX.w $03FA
	BNE.b CODE_01AF35
	PHP
	JSL.l CODE_0098A0	: dw $0202
	PLP
	CLC
	RTS

CODE_01AF35:
	SEC
	RTS

CODE_01AF37:
	LDA.w $01DF
	ASL
	TAX
	LDA.w DATA_00A0C3,x
	PHA
	LDY.w #$0000
	STY.b $79
CODE_01AF45:
	LDA.b ($01,S),y
	CMP.w #$8080
	BEQ.b CODE_01AF98
	INY
	AND.w #$00FF
	CMP.w $01EB
	BCS.b CODE_01AF91
	LDA.b ($01,S),y
	INY
	AND.w #$00FF
	CMP.w $01EB
	BCC.b CODE_01AF92
	LDA.b ($01,S),y
	INY
	AND.w #$00FF
	CMP.w $01ED
	BCS.b CODE_01AF93
	LDA.b ($01,S),y
	INY
	AND.w #$00FF
	CMP.w $01ED
	BCC.b CODE_01AF94
	PLX
	LDA.w $01DF
	CMP.w #$0003
	BCC.b CODE_01AF89
	PHP
	JSL.l CODE_0098A0	: dw $0102
	PLP
	REP.b #$20
CODE_01AF89:
	LDA.b $79
	CLC
	ADC.w #$0008
	SEC
	RTS

CODE_01AF91:
	INY
CODE_01AF92:
	INY
CODE_01AF93:
	INY
CODE_01AF94:
	INC.b $79
	BRA.b CODE_01AF45

CODE_01AF98:
	CLC
	PLX
	RTS

CODE_01AF9B:
	SEP.b #$20
	PHP
	JSL.l CODE_0098A0	: dw $0603
	PLP
	REP.b #$20
	LDA.w $01EB
	AND.w #$FFF8
	STA.w $01EB
	LDA.w $01ED
	AND.w #$FFF8
	STA.w $01ED
	RTS

CODE_01AFBA:
	JSR.w CODE_01AFBE
	RTL

CODE_01AFBE:
	REP.b #$30
	LDA.w $01C1
	LSR
	BCC.b CODE_01AFC9
	INC.w $01BD
CODE_01AFC9:
	LSR
	BCC.b CODE_01AFCF
	DEC.w $01BD
CODE_01AFCF:
	LSR
	BCC.b CODE_01AFD5
	INC.w $01BF
CODE_01AFD5:
	LSR
	BCC.b CODE_01AFDB
	DEC.w $01BF
CODE_01AFDB:
	RTS

CODE_01AFDC:
	JSR.w CODE_01AFE0
	RTL

CODE_01AFE0:
	REP.b #$30
	LDA.w $01C1
	LSR
	BCC.b CODE_01AFF7
	PHA
	LDA.w $0139
	CLC
	ADC.w #$0004
	AND.w #$00FF
	STA.w $0139
	PLA
CODE_01AFF7:
	LSR
	BCC.b CODE_01B009
	PHA
	LDA.w $0139
	SEC
	SBC.w #$0004
	AND.w #$00FF
	STA.w $0139
	PLA
CODE_01B009:
	LSR
	BCC.b CODE_01B01B
	PHA
	LDA.w $0137
	CLC
	ADC.w #$0004
	AND.w #$00FF
	STA.w $0137
	PLA
CODE_01B01B:
	LSR
	BCC.b CODE_01B02B
	LDA.w $0137
	SEC
	SBC.w #$0004
	AND.w #$00FF
	STA.w $0137
CODE_01B02B:
	RTS

CODE_01B02C:
	JSR.w CODE_01B030
	RTL

CODE_01B030:
	REP.b #$30
	LDA.w $01BD
	BMI.b CODE_01B046
	CMP.w $01C5
	BCC.b CODE_01B046
	LDA.w $01C1
	AND.w #$FFFE
	STA.w $01C1
	RTS

CODE_01B046:
	LDA.w $0139
	LSR
	LSR
	AND.w #$FFFE
	STA.w $01CD
	LDA.w $0137
	SEC
	SBC.w #$0008
	AND.w #$00FF
	LSR
	LSR
	LSR
	PHA
	SEP.b #$20
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	LDA.b #$40
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	REP.b #$20
	CLC
	ADC.w $01CD
	TAX
	PLA
	EOR.w #$FFFF
	CLC
	ADC.w #$0021
	CMP.w #$001E
	BCC.b CODE_01B09C
	LDA.w #$001E
CODE_01B09C:
	STA.w $01CF
	LDA.w #$001E
	SEC
	SBC.w $01CF
	STA.w $01D1
	LDA.w $01BD
	CLC
	ADC.w #$0020
	STA.w $01D3
	JSR.w CODE_01B0B7
	RTS

CODE_01B0B7:
	REP.b #$30
	LDA.w $01BF
	DEC
	STA.w $01D5
CODE_01B0C0:
	PHX
	JSR.w CODE_01C772
	PLX
	LDA.w $013F
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer,x
	LDA.b $D7
	CMP.w #$0002
	BNE.b CODE_01B0DA
	LDA.w $0141
	STA.l !RAM_SIMC_Global_Layer3TilemapBuffer,x
CODE_01B0DA:
	LDA.w $013B
	ASL
	BPL.b CODE_01B112
	LDA.w $01D3
	PHA
	LDA.w $01D5
	PHA
	DEC.w $01D3
	DEC.w $01D5
	PHX
	JSR.w CODE_01C772
	PLX
	PLA
	STA.w $01D5
	PLA
	STA.w $01D3
	LDA.w $013B
	BMI.b CODE_01B109
	LDA.w #$1376
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	BRA.b CODE_01B119

CODE_01B109:
	LDA.w #$0300
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	BRA.b CODE_01B119

CODE_01B112:
	LDA.w $013D
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
CODE_01B119:
	INC.w $01D5
	TXA
	CLC
	ADC.w #$0040
	TAX
	DEC.w $01CF
	BNE.b CODE_01B0C0
	LDA.w $01D1
	BEQ.b CODE_01B13D
	STA.w $01CF
	STZ.w $01D1
	TXA
	SEC
	SBC.w #$0040
	AND.w #$003E
	TAX
	BRA.b CODE_01B0C0

CODE_01B13D:
	RTS

CODE_01B13E:
	RTS

CODE_01B13F:
	JSR.w CODE_01B143
	RTL

CODE_01B143:
	REP.b #$30
	LDA.w $0139
	LSR
	LSR
	AND.w #$FFFE
	TAX
	LDY.w #$0020
CODE_01B151:
	LDA.w #$2300
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	TXA
	CLC
	ADC.w #$0040
	TAX
	DEY
	BNE.b CODE_01B151
	RTS

CODE_01B162:
	JSR.w CODE_01B166
	RTL

CODE_01B166:
	REP.b #$30
	LDA.w $01BD
	BPL.b CODE_01B17C
	CMP.w $01C7
	BNE.b CODE_01B17C
	LDA.w $01C1
	AND.w #$FFFD
	STA.w $01C1
	RTS

CODE_01B17C:
	LDA.w $0139
	LSR
	LSR
	AND.w #$FFFE
	CLC
	ADC.w #$003E
	AND.w #$003E
	STA.w $01CD
	LDA.w $0137
	SEC
	SBC.w #$0008
	AND.w #$00FF
	LSR
	LSR
	LSR
	PHA
	SEP.b #$20
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	LDA.b #$40
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	REP.b #$20
	CLC
	ADC.w $01CD
	TAX
	PLA
	EOR.w #$FFFF
	CLC
	ADC.w #$0021
	CMP.w #$001E
	BCC.b CODE_01B1D9
	LDA.w #$001E
CODE_01B1D9:
	STA.w $01CF
	LDA.w #$001E
	SEC
	SBC.w $01CF
	STA.w $01D1
	LDA.w $01BD
	DEC
	STA.w $01D3
	JSR.w CODE_01B0B7
	RTS

CODE_01B1F1:
	RTS

CODE_01B1F2:
	JSR.w CODE_01B1F6
	RTL

CODE_01B1F6:
	REP.b #$30
	LDA.w $01BF
	BMI.b CODE_01B20C
	CMP.w $01C9
	BCC.b CODE_01B20C
	LDA.w $01C1
	AND.w #$FFFB
	STA.w $01C1
	RTS

CODE_01B20C:
	LDA.w $0139
	LSR
	LSR
	AND.w #$FFFE
	PHA
	STA.w $01CD
	LDA.w $0137
	LSR
	LSR
	LSR
	CLC
	ADC.w #$001C
	CMP.w #$0020
	BCC.b CODE_01B22A
	SBC.w #$0020
CODE_01B22A:
	SEP.b #$20
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	LDA.b #$40
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	REP.b #$20
	CLC
	ADC.w $01CD
	TAX
	PLA
	LSR
	STA.w $01D1
	LDA.w #$0020
	SEC
	SBC.w $01D1
	STA.w $01CF
	LDA.w $01BF
	CLC
	ADC.w #$001C
	STA.w $01D5
	JSR.w CODE_01B274
	RTS

CODE_01B274:
	REP.b #$30
	LDA.w $01BD
	STA.w $01D3
CODE_01B27C:
	PHX
	JSR.w CODE_01C772
	PLX
	LDA.w $013F
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer,x
	LDA.b $D7
	CMP.w #$0002
	BNE.b CODE_01B296
	LDA.w $0141
	STA.l !RAM_SIMC_Global_Layer3TilemapBuffer,x
CODE_01B296:
	LDA.w $013B
	ASL
	BPL.b CODE_01B2CE
	LDA.w $01D3
	PHA
	LDA.w $01D5
	PHA
	DEC.w $01D3
	DEC.w $01D5
	PHX
	JSR.w CODE_01C772
	PLX
	PLA
	STA.w $01D5
	PLA
	STA.w $01D3
	LDA.w $013B
	BMI.b CODE_01B2C5
	LDA.w #$1376
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	BRA.b CODE_01B2D5

CODE_01B2C5:
	LDA.w #$0300
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	BRA.b CODE_01B2D5

CODE_01B2CE:
	LDA.w $013D
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
CODE_01B2D5:
	INC.w $01D3
	INX
	INX
	DEC.w $01CF
	BNE.b CODE_01B27C
	LDA.w $01D1
	BEQ.b CODE_01B2F3
	STA.w $01CF
	STZ.w $01D1
	TXA
	SEC
	SBC.w #$0040
	TAX
	JMP.w CODE_01B27C

CODE_01B2F3:
	RTS

CODE_01B2F4:
	RTS

CODE_01B2F5:
	JSR.w CODE_01B2F9
	RTL

CODE_01B2F9:
	REP.b #$20
	REP.b #$10
	LDA.w $01BF
	CMP.w $01CB
	BNE.b CODE_01B30F
	LDA.w $01C1
	AND.w #$FFF7
	STA.w $01C1
	RTS

CODE_01B30F:
	LDA.w $0139
	LSR
	LSR
	AND.w #$FFFE
	PHA
	STA.w $01CD
	LDA.w $0137
	LSR
	LSR
	LSR
	CLC
	ADC.w #$001F
	CMP.w #$0020
	BCC.b CODE_01B32D
	SBC.w #$0020
CODE_01B32D:
	SEP.b #$20
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	LDA.b #$40
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	REP.b #$20
	CLC
	ADC.w $01CD
	TAX
	PLA
	LSR
	STA.w $01D1
	LDA.w #$0020
	SEC
	SBC.w $01D1
	STA.w $01CF
	LDA.w $01BF
	DEC
	STA.w $01D5
	JSR.w CODE_01B274
	RTS

CODE_01B374:
	RTS

CODE_01B375:
	REP.b #$30
	LDA.w $0201
	BNE.b CODE_01B37D
	RTS

CODE_01B37D:
	LDX.w $01F9
	LDA.l DATA_0180C0,x
	AND.w #$00FF
	STA.b $79
	LDA.w $01EB
	LSR
	LSR
	LSR
	CLC
	ADC.w $01BD
	BPL.b CODE_01B3A4
	LDA.w #$0000
	SEC
CODE_01B399:
	SBC.w $01BD
	ASL
	ASL
	ASL
	STA.w $01EB
	BRA.b CODE_01B3B6

CODE_01B3A4:
	CLC
	ADC.b $79
	CMP.w #$0078
	BEQ.b CODE_01B3B6
	BCC.b CODE_01B3B6
	LDA.w #$0078
	SEC
	SBC.b $79
	BRA.b CODE_01B399

CODE_01B3B6:
	LDA.w $01ED
	LSR
	LSR
	LSR
	CLC
	ADC.w $01BF
	BPL.b CODE_01B3D0
	LDA.w #$0000
	SEC
CODE_01B3C6:
	SBC.w $01BF
	ASL
	ASL
	ASL
	STA.w $01ED
	RTS

CODE_01B3D0:
	CLC
	ADC.b $79
	CMP.w #$0064
	BEQ.b CODE_01B3E2
	BCC.b CODE_01B3E2
	LDA.w #$0064
	SEC
	SBC.b $79
	BRA.b CODE_01B3C6

CODE_01B3E2:
	RTS

CODE_01B3E3:
	JSR.w CODE_01B3E7
	RTL

CODE_01B3E7:
	SEP.b #$20
	LDA.b $38
	BEQ.b CODE_01B3F3
	STZ.b $38
	LDA.b #$F1
	BRA.b CODE_01B3F7

CODE_01B3F3:
	LDA.w $0CA5
	INC
CODE_01B3F7:
	STA.b $03
	RTS

CODE_01B3FA:
	REP.b #$30
	LDX.w #$0800
	LDA.w #$014B
CODE_01B402:
	DEX
	DEX
	BMI.b CODE_01B40C
	STA.l !RAM_SIMC_Global_Layer3TilemapBuffer,x
	BRA.b CODE_01B402

CODE_01B40C:
	JSR.w CODE_01A8FF
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	RTS

CODE_01B417:
	REP.b #$30
	LDX.w #$0800
	LDA.w #$014B
CODE_01B41F:
	DEX
	DEX
	BMI.b CODE_01B429
	STA.l !RAM_SIMC_Global_Layer3TilemapBuffer,x
	BRA.b CODE_01B41F

CODE_01B429:
	RTS

CODE_01B42A:
	REP.b #$30
	LDX.w $01DD
	LDA.l DATA_018010,x
	AND.w #$00FF
	LDX.w $020D
	STA.w $020D
	RTS

CODE_01B43D:
	REP.b #$30
	JSR.w CODE_01B90A
	BCC.b CODE_01B45E
	LDA.w $0205
	CMP.w #$0078
	BCS.b CODE_01B47A
	LDA.w $0207
	CMP.w #$0064
	BCS.b CODE_01B47A
	JSR.w CODE_01B5B0
	BCC.b CODE_01B45E
	JSR.w CODE_01B5DA
	BCS.b CODE_01B47A
CODE_01B45E:
	JSR.w CODE_01BBF9
	BCS.b CODE_01B47A
	JSR.w CODE_01B5F2
	JSR.w CODE_01BC4A
	JSR.w CODE_01B79A
	JSR.w CODE_01BB78
	REP.b #$20
	PHP
	JSL.l CODE_0098A0	: dw $0302
	PLP
	RTS

CODE_01B47A:
	PHP
	JSL.l CODE_0098A0	: dw $0202
	PLP
	RTS

CODE_01B483:
	REP.b #$30
	JSR.w CODE_01BC35
	BCS.b CODE_01B4E9
	JSR.w CODE_01B90A
	BCS.b CODE_01B4E9
	LDA.w $0205
	CMP.w #$0078
	BCS.b CODE_01B4E9
	LDA.w $0207
	CMP.w #$0064
	BCS.b CODE_01B4E9
	JSR.w CODE_01BBF9
	BCS.b CODE_01B4E9
	REP.b #$20
	LDA.w $020D
	CMP.w #$0004
	BNE.b CODE_01B4B1
	JSR.w CODE_01B6B9
CODE_01B4B1:
	JSR.w CODE_01BC4A
	JSR.w CODE_01B79A
	JSR.w CODE_01BB78
	REP.b #$30
	LDA.w #$FFFF
	STA.w $023F
	LDA.w $020D
	CMP.w #$0005
	BCS.b CODE_01B4D3
	PHP
	JSL.l CODE_0098A0	: dw $0302
	PLP
	RTS

CODE_01B4D3:
	LDA.w $020D
	CMP.w #$000A
	BEQ.b CODE_01B536
	CMP.w #$000F
	BEQ.b CODE_01B4F2
	PHP
	JSL.l CODE_0098A0	: dw $0402
	PLP
	RTS

CODE_01B4E9:
	PHP
	JSL.l CODE_0098A0	: dw $0202
	PLP
	RTS

CODE_01B4F2:
	LDX.w $03F3
	LDA.w $03F5,x
	AND.w #$00FF
	PHA
	JSR.w CODE_01BF55
	REP.b #$20
	PLA
	CMP.w #$0003
	BEQ.b CODE_01B522
	CMP.w #$0001
	BEQ.b CODE_01B533
	CMP.w #$000A
	BNE.b CODE_01B536
	PHP
	JSL.l CODE_0098A0	: dw $0402
	PLP
	PHP
	JSL.l CODE_0098A0	: dw $1103
	PLP
	RTS

CODE_01B522:
	PHP
	JSL.l CODE_0098A0	: dw $0402
	PLP
	PHP
	JSL.l CODE_0098A0	: dw $1403
	PLP
	RTS

CODE_01B533:
	STZ.w $0CC9
CODE_01B536:
	PHP
	JSL.l CODE_0098A0	: dw $0402
	PLP
	PHP
	JSL.l CODE_0098A0	: dw $1003
	PLP
	RTS

CODE_01B547:
	REP.b #$30
	JSR.w CODE_01B989
	BCS.b CODE_01B5A7
	LDA.w $0205
	CMP.w #$0078
	BCS.b CODE_01B5A7
	LDA.w $0207
	CMP.w #$0064
	BCS.b CODE_01B5A7
	JSR.w CODE_01B9A4
	JSR.w CODE_01B9BF
	JSR.w CODE_01B9F5
	JSR.w CODE_01BBF9
	BCS.b CODE_01B5A7
	JSR.w CODE_01BD04
	JSR.w CODE_01B859
	JSR.w CODE_01BB78
	REP.b #$20
	LDA.w #$FFFF
	STA.w $023F
	LDA.w $024D
	CMP.w #$0080
	BCC.b CODE_01B59E
	CMP.w #$0089
	BCC.b CODE_01B58F
	CMP.w #$0095
	BCC.b CODE_01B59E
CODE_01B58F:
	LDA.w #$00FF
	STA.w $023D
	PHP
	JSL.l CODE_0098A0	: dw $0303
	PLP
	RTS

CODE_01B59E:
	PHP
	JSL.l CODE_0098A0	: dw $0403
	PLP
	RTS

CODE_01B5A7:
	PHP
	JSL.l CODE_0098A0	: dw $0202
	PLP
	RTS

CODE_01B5B0:
	REP.b #$30
	LDA.w $020D
	DEC
	ASL
	TAX
	LDA.w DATA_009E7D,x
	PHA
	LDA.w DATA_009EB1,x
	PHA
	LDY.w #$0000
	LDA.w $024D
CODE_01B5C6:
	CMP.b ($03,S),y
	BEQ.b CODE_01B5D1
	INY
	INY
	BCS.b CODE_01B5C6
	SEC
	BRA.b CODE_01B5D7

CODE_01B5D1:
	LDA.b ($01,S),y
	STA.w $0249
	CLC
CODE_01B5D7:
	PLA
	PLA
	RTS

CODE_01B5DA:
	REP.b #$20
	LDA.w $024D
	CMP.w #$0004
	BCS.b CODE_01B5F0
	JSR.w CODE_01B613
	REP.b #$20
	LDA.w $0249
	BEQ.b CODE_01B5F0
	CLC
	RTS

CODE_01B5F0:
	SEC
	RTS

CODE_01B5F2:
	REP.b #$20
	LDA.w $0249
	BNE.b CODE_01B612
	STZ.w $0243
	STZ.w $0245
	STZ.w $0247
	JSR.w CODE_01B6CC
	REP.b #$20
	LDA.w $020D
	DEC
	REP.b #$10
	ASL
	TAX
	JSR.w (DATA_01830C,x)
CODE_01B612:
	RTS

CODE_01B613:
	REP.b #$20
	STZ.w $0243
	STZ.w $0245
	STZ.w $0247
	JSR.w CODE_01B6CC
	REP.b #$20
	LDA.w $020D
	DEC
	REP.b #$10
	ASL
	TAX
	JSR.w (DATA_018312,x)
	RTS

CODE_01B62F:
	REP.b #$20
	REP.b #$10
	LDX.w $0243
	LDA.l DATA_018020,x
	AND.w #$00FF
	CLC
	ADC.w #$0030
	STA.w $0249
	RTS

CODE_01B645:
	REP.b #$20
	REP.b #$10
	LDX.w $0245
	LDA.l DATA_018020,x
	AND.w #$00FF
	CLC
	ADC.w #$0070
	STA.w $0249
	RTS

CODE_01B65B:
	REP.b #$20
	REP.b #$10
	LDX.w $0247
	LDA.l DATA_018020,x
	AND.w #$00FF
	CLC
	ADC.w #$0060
	STA.w $0249
	RTS

CODE_01B671:
	REP.b #$20
	REP.b #$10
	LDX.w $0243
	BEQ.b CODE_01B688
	LDA.l DATA_018030,x
	AND.w #$00FF
	CLC
	ADC.w #$0030
	STA.w $0249
CODE_01B688:
	RTS

CODE_01B689:
	REP.b #$20
	REP.b #$10
	LDX.w $0245
	BEQ.b CODE_01B6A0
	LDA.l DATA_018030,x
	AND.w #$00FF
	CLC
	ADC.w #$0070
	STA.w $0249
CODE_01B6A0:
	RTS

CODE_01B6A1:
	REP.b #$20
	REP.b #$10
	LDX.w $0247
	BEQ.b CODE_01B6B8
	LDA.l DATA_018030,x
	AND.w #$00FF
	CLC
	ADC.w #$0060
	STA.w $0249
CODE_01B6B8:
	RTS

CODE_01B6B9:
	REP.b #$20
	LDA.b $C7
	AND.w #$000F
	CMP.w #$0003
	BCS.b CODE_01B6CB
	LDA.w #$0027
	STA.w $0249
CODE_01B6CB:
	RTS

CODE_01B6CC:
	REP.b #$10
	LDX.w #$0003
CODE_01B6D1:
	PHX
	SEP.b #$20
	LDA.w $0205
	CLC
	ADC.w DATA_009B61,x
	BMI.b CODE_01B6FE
	CMP.b #$78
	BCS.b CODE_01B6FE
	XBA
	LDA.w $0207
	CLC
	ADC.w DATA_009B65,x
	BMI.b CODE_01B6FE
	CMP.b #$64
	BCS.b CODE_01B6FE
	REP.b #$20
	JSR.w CODE_01BA3F
CODE_01B6F4:
	JSR.w CODE_01B73E
	REP.b #$10
	PLX
	DEX
	BPL.b CODE_01B6D1
	RTS

CODE_01B6FE:
	REP.b #$20
	LDA.w #$0000
	BRA.b CODE_01B6F4

CODE_01B705:
	REP.b #$10
	LDX.w #$0003
CODE_01B70A:
	PHX
	SEP.b #$20
	LDA.w $0209
	CLC
	ADC.w DATA_009B61,x
	BMI.b CODE_01B737
	CMP.b #$78
	BCS.b CODE_01B737
	XBA
	LDA.w $020B
	CLC
	ADC.w DATA_009B65,x
	BMI.b CODE_01B737
	CMP.b #$64
	BCS.b CODE_01B737
	REP.b #$20
	JSR.w CODE_01BA3F
CODE_01B72D:
	JSR.w CODE_01B73E
	REP.b #$10
	PLX
	DEX
	BPL.b CODE_01B70A
	RTS

CODE_01B737:
	REP.b #$20
	LDA.w #$0000
	BRA.b CODE_01B72D

CODE_01B73E:
	REP.b #$20
	JSR.w CODE_01B753
	ROL.w $0243
	JSR.w CODE_01B765
	ROL.w $0245
	JSR.w CODE_01B777
	ROL.w $0247
	RTS

CODE_01B753:
	REP.b #$10
	LDX.w #$0000
CODE_01B758:
	CMP.l DATA_018318,x
	BEQ.b CODE_01B763
	INX
	INX
	BCS.b CODE_01B758
	RTS

CODE_01B763:
	SEC
	RTS

CODE_01B765:
	REP.b #$10
	LDX.w #$0000
CODE_01B76A:
	CMP.l DATA_018378,x
	BEQ.b CODE_01B775
	INX
	INX
	BCS.b CODE_01B76A
	RTS

CODE_01B775:
	SEC
	RTS

CODE_01B777:
	REP.b #$10
	LDX.w #$0000
CODE_01B77C:
	CMP.l DATA_0183AE,x
	BEQ.b CODE_01B798
	INX
	INX
	BCS.b CODE_01B77C
	CMP.w #$0080
	BCS.b CODE_01B78C
	RTS

CODE_01B78C:
	CMP.w #$0354
	BCC.b CODE_01B798
	CMP.w #$0366
	BCS.b CODE_01B798
	CLC
	RTS

CODE_01B798:
	SEC
	RTS

CODE_01B79A:
	REP.b #$20
	REP.b #$10
	LDX.w $020D
	LDA.l DATA_018040,x
	AND.w #$00FF
	TAY
	LDA.l DATA_018051,x
	AND.w #$00FF
	TAX
	LDA.w DATA_009B51,x
	PHA
	LDA.w DATA_009B59,x
	PHA
CODE_01B7B9:
	LDA.w #$0000
	SEP.b #$20
	LDA.b ($03,S),y
	REP.b #$20
	BPL.b CODE_01B7C7
	ORA.w #$FF00
CODE_01B7C7:
	CLC
	ADC.w $0205
	BMI.b CODE_01B821
	CMP.w #$0078
	BCS.b CODE_01B821
	STA.w $0209
	LDA.w #$0000
	SEP.b #$20
	LDA.b ($01,S),y
	REP.b #$20
	BPL.b CODE_01B7E3
	ORA.w #$FF00
CODE_01B7E3:
	CLC
	ADC.w $0207
	BMI.b CODE_01B821
	CMP.w #$0064
	BCS.b CODE_01B821
	STA.w $020B
	STZ.w $0243
	STZ.w $0245
	STZ.w $0247
	PHY
	SEP.b #$20
	LDA.w $0209
	XBA
	LDA.w $020B
	REP.b #$20
	JSR.w CODE_01BA3F
	JSR.w CODE_01B829
	BCS.b CODE_01B820
	JSR.w CODE_01B705
	REP.b #$20
	LDA.w $024B
	REP.b #$10
	ASL
	TAX
	JSR.w (DATA_01830C,x)
	JSR.w CODE_01BCC9
CODE_01B820:
	PLY
CODE_01B821:
	DEY
	BPL.b CODE_01B7B9
	REP.b #$20
	PLA
	PLA
	RTS

CODE_01B829:
	CMP.w #$0030
	BCC.b CODE_01B857
	CMP.w #$0080
	BCS.b CODE_01B857
	PHA
	AND.w #$000F
	CMP.w #$0002
	BCC.b CODE_01B856
	CMP.w #$000D
	BCS.b CODE_01B856
	PLA
	LDX.w #$0000
	CMP.w #$0060
	BCC.b CODE_01B851
	INX
	CMP.w #$0070
	BCS.b CODE_01B851
	INX
CODE_01B851:
	STX.w $024B
	CLC
	RTS

CODE_01B856:
	PLA
CODE_01B857:
	SEC
	RTS

CODE_01B859:
	REP.b #$20
	REP.b #$10
	LDA.w $0227
	BEQ.b CODE_01B87F
	CMP.w #$000F
	BEQ.b CODE_01B895
	CMP.w #$0008
	BEQ.b CODE_01B88A
	STA.w $0231
	LDA.w $022B
	CLC
	ADC.w #$0004
	ASL
	TAX
	LDA.l DATA_01859E,x
	PHA
	BRA.b CODE_01B8A2

CODE_01B87F:
	LDA.w #$0003
	STA.w $0231
	PEA.w DATA_009BD1
	BRA.b CODE_01B8A2

CODE_01B88A:
	LDA.w #$000B
	STA.w $0231
	PEA.w DATA_009BD9
	BRA.b CODE_01B8A2

CODE_01B895:
	STA.w $0231
	LDA.w $0229
	ASL
	TAX
	LDA.l DATA_01859E,x
	PHA
CODE_01B8A2:
	LDA.w $0231
	ASL
	TAY
	SEP.b #$20
	LDA.b ($01,S),y
	CLC
	ADC.w $0205
	BMI.b CODE_01B901
	CMP.b #$78
	BCS.b CODE_01B901
	STA.w $0209
	INY
	LDA.b ($01,S),y
	CLC
	ADC.w $0207
	BMI.b CODE_01B901
	CMP.b #$64
	BCS.b CODE_01B901
	STA.w $020B
	REP.b #$20
	STZ.w $0243
	STZ.w $0245
	STZ.w $0247
	SEP.b #$20
	LDA.w $0209
	XBA
	LDA.w $020B
	REP.b #$20
	JSR.w CODE_01BA3F
	JSR.w CODE_01B829
	BCS.b CODE_01B8F8
	JSR.w CODE_01B705
	REP.b #$20
	LDA.w $024B
	REP.b #$10
	ASL
	TAX
	JSR.w (DATA_01830C,x)
	JSR.w CODE_01BCC9
CODE_01B8F8:
	DEC.w $0231
	BPL.b CODE_01B8A2
	REP.b #$20
	PLA
	RTS

CODE_01B901:
	REP.b #$20
	DEC.w $0231
	BPL.b CODE_01B8A2
	PLA
	RTS

CODE_01B90A:
	REP.b #$30
	STZ.w $0221
	STZ.w $0227
	STZ.w $0223
	STZ.w $0225
	LDX.w $020D
	LDA.l DATA_018062,x
	AND.w #$00FF
	STA.w $020F
	JSR.w CODE_01BA24
CODE_01B928:
	LDX.w $020F
	SEP.b #$20
	LDA.l DATA_018072,x
	CLC
	ADC.w $0205
	XBA
	LDA.l DATA_018096,x
	CLC
	ADC.w $0207
	REP.b #$20
	JSR.w CODE_01BA3F
	STA.w $024D
	JSR.w CODE_01BA80
	BCS.b CODE_01B951
	DEC.w $020F
	BPL.b CODE_01B928
	CLC
CODE_01B951:
	PHP
	LDA.w $020D
	CMP.w #$000F
	BEQ.b CODE_01B96A
	LDA.w $020D
	CMP.w #$0004
	BNE.b CODE_01B987
	LDA.w $0225
	BEQ.b CODE_01B987
	PLP
	SEC
	RTS

CODE_01B96A:
	LDX.w $03F3
	LDA.w $03F5,x
	AND.w #$00FF
	CMP.w #$0006
	BNE.b CODE_01B987
	PLP
	LDA.w $0223
	BNE.b CODE_01B983
	LDA.w $0221
	BNE.b CODE_01B985
CODE_01B983:
	SEC
	RTS

CODE_01B985:
	CLC
	RTS

CODE_01B987:
	PLP
	RTS

CODE_01B989:
	STZ.w $0221
	JSR.w CODE_01BA24
	SEP.b #$20
	LDA.w $0205
	XBA
	LDA.w $0207
	REP.b #$20
	JSR.w CODE_01BA3F
	STA.w $024D
	JSR.w CODE_01BB07
	RTS

CODE_01B9A4:
	REP.b #$20
	STZ.w $022F
	LDA.w $024D
	CMP.w #$0030
	BCC.b CODE_01B9BE
	CMP.w #$0072
	BCS.b CODE_01B9BE
	AND.w #$000E
	BNE.b CODE_01B9BE
	INC.w $022F
CODE_01B9BE:
	RTS

CODE_01B9BF:
	REP.b #$30
	LDA.w $0227
	CMP.w #$000F
	BEQ.b CODE_01B9CA
	RTS

CODE_01B9CA:
	LDX.w #$0000
	LDA.w $024D
	CMP.w #$0366
	BCC.b CODE_01B9DB
	SEC
	SBC.w #$036B
	BRA.b CODE_01B9DF

CODE_01B9DB:
	SEC
	SBC.w #$025C
CODE_01B9DF:
	AND.w #$0007
	BEQ.b CODE_01B9F1
	INX
	CMP.w #$0001
	BEQ.b CODE_01B9F1
	INX
	CMP.w #$0004
	BEQ.b CODE_01B9F1
	INX
CODE_01B9F1:
	STX.w $0229
	RTS

CODE_01B9F5:
	REP.b #$20
	REP.b #$10
	LDA.w $0227
	CMP.w #$0023
	BEQ.b CODE_01BA02
	RTS

CODE_01BA02:
	LDX.w #$0000
	LDA.w $024D
	CMP.w #$02A5
	BEQ.b CODE_01BA20
	INX
	CMP.w #$02A6
	BEQ.b CODE_01BA20
	INX
	CMP.w #$02AB
	BEQ.b CODE_01BA20
	INX
	CMP.w #$02AC
	BEQ.b CODE_01BA20
	INX
CODE_01BA20:
	STX.w $022B
	RTS

CODE_01BA24:
	LDA.w $01EB
	LSR
	LSR
	LSR
	CLC
	ADC.w $01BD
	STA.w $0205
	LDA.w $01ED
	LSR
	LSR
	LSR
	CLC
	ADC.w $01BF
	STA.w $0207
	RTS

CODE_01BA3F:					; Note: Related to placing buildings.
	PHA
	SEP.b #$20
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	LDA.b #$78
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	REP.b #$20
	STA.b $79
	PLA
	SEP.b #$20
	XBA
	REP.b #$20
	AND.w #$00FF
	CLC
	ADC.b $79
	ASL
	TAX
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	AND.w #$03FF
	RTS

CODE_01BA80:
	CMP.w #$0080
	BCC.b CODE_01BA88
	INC.w $0223
CODE_01BA88:
	CMP.w #$0001
	BEQ.b CODE_01BAEC
	CMP.w #$0002
	BEQ.b CODE_01BAEC
	CMP.w #$0003
	BEQ.b CODE_01BAEC
	CMP.w #$0000
	BEQ.b CODE_01BAC9
	CMP.w #$0062
	BCC.b CODE_01BAA9
	CMP.w #$006F
	BCS.b CODE_01BAA9
	INC.w $0225
CODE_01BAA9:
	CMP.w #$0030
	BCS.b CODE_01BACB
	CMP.w #$0004
	BCC.b CODE_01BAC7
	TAX
	LDA.w $0195
	AND.w #$0001
	BEQ.b CODE_01BAC7
	TXA
	CMP.w #$002E
	BCS.b CODE_01BAC7
	INC.w $0227
	BRA.b CODE_01BAC9

CODE_01BAC7:
	SEC
	RTS

CODE_01BAC9:
	CLC
	RTS

CODE_01BACB:
	TAX
	LDA.w $020D
	CMP.w #$0004
	BCC.b CODE_01BAC7
	LDA.w $0195
	AND.w #$0001
	BEQ.b CODE_01BAC7
	INC.w $0227
	TXA
	CMP.w #$0062
	BCC.b CODE_01BAC7
	CMP.w #$006D
	BCC.b CODE_01BAC9
	BRA.b CODE_01BAC7

CODE_01BAEC:
	INC.w $0221
	LDA.w $020D
	CMP.w #$000F
	BNE.b CODE_01BAC7
	LDX.w $03F3
	LDA.w $03F5,x
	AND.w #$00FF
	CMP.w #$0006
	BNE.b CODE_01BAC7
	BRA.b CODE_01BAC9

CODE_01BB07:
	CMP.w #$0080
	BCS.b CODE_01BB3C
	SEP.b #$20
	LDX.w #$0000
CODE_01BB11:
	CMP.l DATA_0180BA,x
	BCC.b CODE_01BB26
	INX
	CMP.l DATA_0180BA,x
	INX
	BCS.b CODE_01BB11
CODE_01BB1F:
	REP.b #$20
	STZ.w $0227
	CLC
	RTS

CODE_01BB26:
	REP.b #$20
	LDA.w $0425
	AND.w #$0008
	BEQ.b CODE_01BB3A
	LDA.w $024D
	BEQ.b CODE_01BB3A
	CMP.w #$0004
	BCC.b CODE_01BB1F
CODE_01BB3A:
	SEC
	RTS

CODE_01BB3C:
	LDX.w #$0000
CODE_01BB3F:
	CMP.l DATA_0183DA,x
	BCC.b CODE_01BB26
	BEQ.b CODE_01BB4D
	INX
	INX
	INX
	INX
	BRA.b CODE_01BB3F

CODE_01BB4D:
	INX
	INX
	LDA.l DATA_0183DA,x
	STA.w $0227
	CLC
	RTS

DATA_01BB58:
	dw $0000,$000A,$0014,$0005,$000A,$0064,$0064,$0064
	dw $01F4,$01F4,$0BB8,$1388,$2710,$1388,$0BB8,$0064

CODE_01BB78:
	SEP.b #$20
	LDA.w $0425
	AND.b #$02
	BNE.b CODE_01BBCF
	REP.b #$30
	LDA.w $020D
	BNE.b CODE_01BB8B
	INC.w $0227
CODE_01BB8B:
	CMP.w #$000F
	BNE.b CODE_01BBA5
	LDX.w $03F3
	LDA.w $03F5,x
	AND.w #$00FF
	CMP.w #$0006
	BNE.b CODE_01BBA5
	LDA.w #$0064
	STA.b $79
	BRA.b CODE_01BBBC

CODE_01BBA5:
	LDA.w $020D
	ASL
	TAX
	LDA.l DATA_01BB58,x
	LDX.w $0221
	BMI.b CODE_01BBCF
	BEQ.b CODE_01BBB6
	ASL
CODE_01BBB6:
	CLC
	ADC.w $0227
	STA.b $79
CODE_01BBBC:
	LDA.w !RAM_SIMC_City_CurrentFundsLo
	SEC
	SBC.b $79
	STA.w !RAM_SIMC_City_CurrentFundsLo
	SEP.b #$20
	LDA.w !RAM_SIMC_City_CurrentFundsHi
	SBC.b #$00
	STA.w !RAM_SIMC_City_CurrentFundsHi
CODE_01BBCF:
	JSL.l CODE_00842E
	RTS

CODE_01BBD4:
	REP.b #$20
	LDA.w !RAM_SIMC_City_CurrentFundsLo
	CLC
	SBC.w $0227
	STA.w !RAM_SIMC_City_CurrentFundsLo
	SEP.b #$20
	LDA.w !RAM_SIMC_City_CurrentFundsHi
	SBC.b #$00
	STA.w !RAM_SIMC_City_CurrentFundsHi
	BPL.b CODE_01BBCF
	REP.b #$20
	STZ.w !RAM_SIMC_City_CurrentFundsLo
	STZ.w !RAM_SIMC_City_CurrentFundsHi
	JSL.l CODE_00842E
	RTS

CODE_01BBF9:
	SEP.b #$20
	REP.b #$10
	LDA.w $0425
	AND.b #$02
	BNE.b CODE_01BC33
	LDA.w !RAM_SIMC_City_CurrentFundsHi
	BNE.b CODE_01BC33
	REP.b #$20
	LDA.w $020D
	BNE.b CODE_01BC18
	LDA.w $0227
	INC
	STA.b $79
	BRA.b CODE_01BC2A

CODE_01BC18:
	ASL
	TAX
	LDA.l DATA_01886E,x
	CLC
	ADC.w $0227
	LDX.w $0221
	BEQ.b CODE_01BC28
	ASL
CODE_01BC28:
	STA.b $79
CODE_01BC2A:
	LDA.w !RAM_SIMC_City_CurrentFundsLo
	CMP.b $79
	BCS.b CODE_01BC33
	SEC
	RTS

CODE_01BC33:
	CLC
	RTS

CODE_01BC35:
	SEP.b #$30
	LDA.w $020D
	CMP.b #$0F
	BNE.b CODE_01BC46
	LDX.w $03F3
	LDA.w $03F5,x
	BEQ.b CODE_01BC48
CODE_01BC46:
	CLC
	RTS

CODE_01BC48:
	SEC
	RTS

CODE_01BC4A:
	REP.b #$30
	LDA.w $0249
	BEQ.b CODE_01BC56
	LDA.w #$0249
	BRA.b CODE_01BC8F

CODE_01BC56:
	LDA.w $020D
	CMP.w #$000F
	BNE.b CODE_01BC6B
	LDX.w $03F3
	LDA.w $03F5,x
	AND.w #$00FF
	CLC
	ADC.w #$000E
CODE_01BC6B:
	ASL
	TAX
	LDA.w DATA_0098BB,x
	LDX.w $020D
	CPX.w #$000A
	BNE.b CODE_01BC8F
	LDX.w $0E0B
	BEQ.b CODE_01BC8F
	PHA
	JSL.l CODE_00824B
	AND.w #$00FF
	CMP.w #$00CC
	PLA
	BCS.b CODE_01BC8F
	CLC
	ADC.w #$0020
CODE_01BC8F:
	PHA
	LDA.w $01EB
	LSR
	LSR
	LSR
	STA.w $0211
	LDA.w $01ED
	LSR
	LSR
	LSR
	STA.w $0213
	LDX.w $020D
	LDA.l DATA_018062,x
	AND.w #$00FF
	STA.w $0217
CODE_01BCAF:
	LDA.w $0217
	ASL
	TAY
	LDA.b ($01,S),y
	STA.w $0215
	JSR.w CODE_01BD6F
	JSR.w CODE_01BDCE
	JSR.w CODE_01BE95
	DEC.w $0217
	BPL.b CODE_01BCAF
	PLA
	RTS

CODE_01BCC9:
	LDA.w $0249
	STA.w $0215
	LDA.w $0209
	STA.w $0219
	LDA.w $020B
	STA.w $021B
	JSR.w CODE_01BE07
	LDA.w $0209
	SEC
	SBC.w $01BD
	BMI.b CODE_01BD03
	CMP.w #$0020
	BCS.b CODE_01BD03
	STA.w $021D
	LDA.w $020B
	SEC
	SBC.w $01BF
	BMI.b CODE_01BD03
	CMP.w #$001C
	BCS.b CODE_01BD03
	STA.w $021F
	JSR.w CODE_01BE95
CODE_01BD03:
	RTS

CODE_01BD04:
	REP.b #$30
	LDX.w #$0000
	LDA.w $0227
	BEQ.b CODE_01BD13
	LDX.w #$002A
	BRA.b CODE_01BD1E

CODE_01BD13:
	LDX.w #$0000
	LDA.w $022F
	BEQ.b CODE_01BD1E
	LDX.w #$0003
CODE_01BD1E:
	STX.w $022D
	CMP.w #$000F
	BEQ.b CODE_01BD31
	CMP.w #$0023
	BEQ.b CODE_01BD3D
	LDA.w #DATA_009D59
	PHA
	BRA.b CODE_01BD47

CODE_01BD31:
	LDA.w $0229
	ASL
	TAX
	LDA.l DATA_0185AE,x
	PHA
	BRA.b CODE_01BD47

CODE_01BD3D:
	LDA.w $022B
	ASL
	TAX
	LDA.l DATA_0185B6,x
	PHA
CODE_01BD47:
	LDA.w $01EB
	LSR
	LSR
	LSR
	STA.w $0211
	LDA.w $01ED
	LSR
	LSR
	LSR
	STA.w $0213
	LDA.w $0227
	STA.w $0231
CODE_01BD5F:
	JSR.w CODE_01BDA1
	JSR.w CODE_01BE40
	JSR.w CODE_01BEF5
	DEC.w $0231
	BPL.b CODE_01BD5F
	PLA
	RTS

CODE_01BD6F:
	LDX.w $0217
	LDA.l DATA_018072,x
	AND.w #$00FF
	PHA
	CLC
	ADC.w $0205
	STA.w $0219
	PLA
	CLC
	ADC.w $0211
	STA.w $021D
	LDA.l DATA_018096,x
	AND.w #$00FF
	PHA
	CLC
	ADC.w $0207
	STA.w $021B
	PLA
	CLC
	ADC.w $0213
	STA.w $021F
	RTS

CODE_01BDA1:
	LDA.w $0231
	ASL
	TAY
	LDA.b ($03,S),y
	SEP.b #$20
	PHA
	CLC
	ADC.w $0205
	STA.w $0233
	PLA
	CLC
	ADC.w $0211
	STA.w $0237
	XBA
	PHA
	CLC
	ADC.w $0207
	STA.w $0235
	PLA
	CLC
	ADC.w $0213
	STA.w $0239
	REP.b #$20
	RTS

CODE_01BDCE:
	LDA.w $021B
	SEP.b #$20
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	LDA.b #$78
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	REP.b #$20
	CLC
	ADC.w $0219
	ASL
	TAX
	LDA.w $0215
	STA.l !RAM_SIMC_City_MapDataBuffer,x
	RTS

CODE_01BE07:
	LDA.w $021B
	SEP.b #$20
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	LDA.b #$78
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	REP.b #$20
	CLC
	ADC.w $0219
	ASL
	TAX
	LDA.w $0215
	STA.l !RAM_SIMC_City_MapDataBuffer,x
	RTS

CODE_01BE40:
	LDA.w $0235
	SEP.b #$20
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	LDA.b #$78
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	REP.b #$20
	CLC
	ADC.w $0233
	ASL
	TAX
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	CMP.w #$0080
	BCC.b CODE_01BE8B
	CMP.w #$0364
	BEQ.b CODE_01BE86
	LDA.w $022D
CODE_01BE82:
	STA.l !RAM_SIMC_City_MapDataBuffer,x
CODE_01BE86:
	RTS

CODE_01BE87:
	DEC.w $0227
	RTS

CODE_01BE8B:
	LDA.w $022D
	CMP.w #$0004
	BCC.b CODE_01BE82
	BNE.b CODE_01BE87
CODE_01BE95:
	LDA.w $0139
	LSR
	LSR
	LSR
	CLC
	ADC.w $021D
	CMP.w #$0020
	BCC.b CODE_01BEA7
	SBC.w #$0020
CODE_01BEA7:
	STA.b $79
	LDA.w $0137
	LSR
	LSR
	LSR
	CLC
	ADC.w $021F
	CMP.w #$0020
	BCC.b CODE_01BEBB
	SBC.w #$0020
CODE_01BEBB:
	SEP.b #$20
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	LDA.b #$20
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	REP.b #$20
	CLC
	ADC.b $79
	ASL
	PHA
	TAX
	LDA.w $0215
	JSR.w CODE_01C7ED
	PLX
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	RTS

CODE_01BEF5:
	LDA.w $0139
	LSR
	LSR
	LSR
	CLC
	ADC.w $0237
	CMP.w #$0020
	BCC.b CODE_01BF07
	SBC.w #$0020
CODE_01BF07:
	STA.b $79
	LDA.w $0137
	LSR
	LSR
	LSR
	CLC
	ADC.w $0239
	CMP.w #$0020
	BCC.b CODE_01BF1B
	SBC.w #$0020
CODE_01BF1B:
	SEP.b #$20
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	LDA.b #$20
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	REP.b #$20
	CLC
	ADC.b $79
	ASL
	PHA
	TAX
	LDA.w $022D
	JSR.w CODE_01C7ED
	PLX
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	RTS

CODE_01BF55:
	SEP.b #$20
	REP.b #$10
	LDA.w $020D
	CMP.b #$0F
	BEQ.b CODE_01BF61
	RTS

CODE_01BF61:
	LDX.w $03F3
	STZ.w $03F5,x
	LDX.w #$0000
	TXY
	STX.b $79
	STX.b $7B
CODE_01BF6F:
	LDA.w $03F5,x
	BEQ.b CODE_01BF78
	STA.w $0079,y
	INY
CODE_01BF78:
	INX
	CPX.w #$0004
	BCC.b CODE_01BF6F
	LDX.b $79
	STX.w $03F5
	LDX.b $7B
	STX.w $03F7
	LDX.w #$0004
	STX.w $03F3
	RTS

DATA_01BF8F:
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$02,$00,$03,$04,$00
	db $06,$07,$08,$09,$0A,$00,$0B,$0C,$0D,$0E,$0F,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$00,$00,$00
	db $00,$00,$00,$00

CODE_01BFC3:
	SEP.b #$30
	LDA.w !RAM_SIMC_City_CurrentWrightMessage
	CMP.b #$1F
	BNE.b CODE_01BFD5
	LDA.w $01E7
	ORA.b #$01
	STA.w $01E7
	RTS

CODE_01BFD5:
	LDA.w !RAM_SIMC_City_CurrentWrightMessage
	CMP.b #$0D
	BNE.b CODE_01BFE5
	LDA.w $037F
	ASL
	CLC
	ADC.b #$03
	BRA.b CODE_01BFFB

CODE_01BFE5:
	LDX.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.l DATA_01BF8F,x
	BNE.b CODE_01BFFB
	CPX.b #$0C
	BNE.b CODE_01BFFA
	LDA.w $01E7
	ORA.b #$02
	STA.w $01E7
CODE_01BFFA:
	RTS

CODE_01BFFB:
	STA.b $79
	LDX.b #$00
CODE_01BFFF:
	LDA.w $03F5,x
	BEQ.b CODE_01C00B
	INX
	CPX.b #$04
	BCC.b CODE_01BFFF
	BRA.b CODE_01C010

CODE_01C00B:
	LDA.b $79
	STA.w $03F5,x
CODE_01C010:
	REP.b #$20
	LDA.w #$00FF
	STA.w $0103
	STA.w $0105
	RTS

CODE_01C01C:
	REP.b #$20
	LDA.w $011B
	AND.w #$4080
	BEQ.b CODE_01C02C
	LDA.w #$00FF
	STA.b $E3
	RTS

CODE_01C02C:
	STZ.b $E3
	RTS

CODE_01C02F:
	JSR.w CODE_01C033
	RTL

CODE_01C033:
	REP.b #$30
	LDA.w $01C1
	ORA.w $01F5
	BEQ.b CODE_01C03E
	RTS

CODE_01C03E:
	LDA.w $01B3
	ASL
	CLC
	ADC.w #$0001
	STA.b $7C
	ADC.w $01BF
	STA.w $01D5
	LDA.w $0139
	LSR
	LSR
	AND.w #$FFFE
	PHA
	STA.b $79
	LDA.w $0137
	LSR
	LSR
	LSR
	CLC
	ADC.b $7C
	CMP.w #$0020
	BCC.b CODE_01C06A
	SBC.w #$0020
CODE_01C06A:
	SEP.b #$20
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	LDA.b #$40
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	REP.b #$20
	CLC
	ADC.b $79
	TAX
	PLA
	LSR
	STA.w $01B7
	LDA.w #$0020
	SEC
	SBC.w $01B7
	STA.w $01B5
	LDA.w #$0002
	STA.w $01B9
CODE_01C0AB:
	LDA.w $01B5
	STA.w $01CF
	LDA.w $01B7
	STA.w $01D1
	PHX
	JSR.w CODE_01B274
	REP.b #$30
	PLX
	TXA
	SEC
	SBC.w #$0040
	BCS.b CODE_01C0C8
	ADC.w #$0800
CODE_01C0C8:
	TAX
	DEC.w $01D5
	DEC.w $01B9
	BNE.b CODE_01C0AB
	DEC.w $01B3
	BPL.b CODE_01C0DC
	LDA.w #$000E
	STA.w $01B3
CODE_01C0DC:
	RTS

CODE_01C0DD:
	REP.b #$30
	LDA.b $D7
	BEQ.b CODE_01C0E4
	RTS

CODE_01C0E4:
	LDA.w $01F5
	BEQ.b CODE_01C0EC
	JMP.w CODE_01C38E

CODE_01C0EC:
	LDA.w $01F3
	BEQ.b CODE_01C0F5
	DEC.w $01F3
	RTS

CODE_01C0F5:
	LDA.w $0201
	BNE.b CODE_01C0FD
	JMP.w CODE_01C2E6

CODE_01C0FD:
	LDA.w $01FF
	BEQ.b CODE_01C105
	JMP.w CODE_01C195

CODE_01C105:
	LDA.w $011B
	AND.w #$8000
	STA.w $0203
	LDA.w $01EB
	LSR
	LSR
	LSR
	STA.b $7F
	CLC
	ADC.w $01BD
	STA.b $79
	LDA.w $01ED
	LSR
	LSR
	LSR
	STA.b $82
	CLC
	ADC.w $01BF
	STA.b $7C
	LDA.w $011B
	AND.w #$4080
	BNE.b CODE_01C194
	LDA.w $011B
	AND.w #$0F00
	BEQ.b CODE_01C194
	ASL
	ASL
	ASL
	ASL
	ASL
	BCC.b CODE_01C155
	PHA
	LDA.w #$0800
	STA.w $01FF
	JSR.w CODE_01C1BA
	REP.b #$30
	PLA
	LDX.w $0203
	BEQ.b CODE_01C155
	BRA.b CODE_01C18E

CODE_01C155:
	ASL
	BCC.b CODE_01C16C
	PHA
	LDA.w #$0400
	STA.w $01FF
	JSR.w CODE_01C1F3
	REP.b #$30
	PLA
	LDX.w $0203
	BEQ.b CODE_01C16C
	BRA.b CODE_01C18E

CODE_01C16C:
	ASL
	BCC.b CODE_01C17F
	PHA
	LDA.w $01FF
	ORA.w #$0200
	STA.w $01FF
	JSR.w CODE_01C23F
	REP.b #$30
	PLA
CODE_01C17F:
	ASL
	BCC.b CODE_01C18E
	LDA.w $01FF
	ORA.w #$0100
	STA.w $01FF
	JSR.w CODE_01C280
CODE_01C18E:
	JSR.w CODE_01C4C7
	JSR.w CODE_01C4E5
CODE_01C194:
	RTS

CODE_01C195:
	ASL
	ASL
	ASL
	ASL
	ASL
	BCC.b CODE_01C1A3
	PHA
	JSR.w CODE_01C1CB
	REP.b #$30
	PLA
CODE_01C1A3:
	ASL
	BCC.b CODE_01C1AD
	PHA
	JSR.w CODE_01C214
	REP.b #$30
	PLA
CODE_01C1AD:
	ASL
	BCC.b CODE_01C1B3
	JMP.w CODE_01C250

CODE_01C1B3:
	ASL
	BCC.b CODE_01C1B9
	JMP.w CODE_01C2A1

CODE_01C1B9:
	RTS

CODE_01C1BA:
	LDA.b $7C
	BNE.b CODE_01C1CB
	LDA.w $01D7
	BEQ.b CODE_01C1ED
	LDA.w $01BF
	CMP.w $01CB
	BNE.b CODE_01C1ED
CODE_01C1CB:
	LDA.w $01ED
	DEC
	DEC
	CMP.w #$0018
	BCC.b CODE_01C1DB
	STA.w $01ED
	JMP.w CODE_01C2D4

CODE_01C1DB:
	LDA.w #$0408
	STA.w $01F7
	LDA.w #$0008
	STA.w $01F5
	JSR.w CODE_01B2F9
	JSR.w CODE_01EEEC
CODE_01C1ED:
	REP.b #$20
	STZ.w $01FF
	RTS

CODE_01C1F3:
	LDX.w $01F9
	LDA.l DATA_0180C0,x
	AND.w #$00FF
	CLC
	ADC.b $7C
	CMP.w #$0064
	BCS.b CODE_01C239
	LDA.l DATA_0180C0,x
	AND.w #$00FF
	CLC
	ADC.b $82
	CMP.w #$0019
	BCS.b CODE_01C227
CODE_01C214:
	LDA.w $01ED
	INC
	INC
	CMP.w #$00D1
	BCC.b CODE_01C221
	LDA.w #$00D0
CODE_01C221:
	STA.w $01ED
	JMP.w CODE_01C2D4

CODE_01C227:
	LDA.w #$0404
	STA.w $01F7
	LDA.w #$0004
	STA.w $01F5
	JSR.w CODE_01B1F6
	JSR.w CODE_01EF49
CODE_01C239:
	REP.b #$20
	STZ.w $01FF
	RTS

CODE_01C23F:
	LDA.b $79
	BNE.b CODE_01C250
	LDA.w $01D7
	BEQ.b CODE_01C274
	LDA.w $01BD
	CMP.w $01C7
	BNE.b CODE_01C274
CODE_01C250:
	LDA.w $01EB
	DEC
	DEC
	CMP.w #$0010
	BCC.b CODE_01C25F
	STA.w $01EB
	BRA.b CODE_01C2D4

CODE_01C25F:
	LDA.w #$0402
	STA.w $01F7
	LDA.w #$0002
	ORA.w $01F5
	STA.w $01F5
	JSR.w CODE_01B166
	JSR.w CODE_01EEE5
CODE_01C274:
	REP.b #$20
	LDA.w $01FF
	AND.w #$FCFF
	STA.w $01FF
	RTS

CODE_01C280:
	LDX.w $01F9
	LDA.l DATA_0180C0,x
	AND.w #$00FF
	CLC
	ADC.b $79
	CMP.w #$0078
	BCS.b CODE_01C2C8
	LDA.l DATA_0180C0,x
	AND.w #$00FF
	CLC
	ADC.b $7F
	CMP.w #$001E
	BCS.b CODE_01C2B3
CODE_01C2A1:
	LDA.w $01EB
	INC
	INC
	CMP.w #$00F9
	BCC.b CODE_01C2AE
	LDA.w #$00F8
CODE_01C2AE:
	STA.w $01EB
	BRA.b CODE_01C2D4

CODE_01C2B3:
	LDA.w #$0401
	STA.w $01F7
	LDA.w #$0001
	ORA.w $01F5
	STA.w $01F5
	JSR.w CODE_01B030
	JSR.w CODE_01EF42
CODE_01C2C8:
	REP.b #$20
	LDA.w $01FF
	AND.w #$FCFF
	STA.w $01FF
	RTS

CODE_01C2D4:
	AND.w #$0007
	BEQ.b CODE_01C2DC
	JMP.w CODE_01C194

CODE_01C2DC:
	STA.w $01FF
	LDA.w #$0003
	STA.w $01F3
	RTS

CODE_01C2E6:
	LDA.w $01FF
	BNE.b CODE_01C300
	LDA.w $011B
	AND.w #$4080
	BNE.b CODE_01C322
	LDA.w $011B
	AND.w #$0F00
	BEQ.b CODE_01C322
	STA.w $01FF
	BEQ.b CODE_01C322
CODE_01C300:
	ASL
	ASL
	ASL
	ASL
	ASL
	BCC.b CODE_01C30C
	PHA
	JSR.w CODE_01C323
	PLA
CODE_01C30C:
	ASL
	BCC.b CODE_01C314
	PHA
	JSR.w CODE_01C33C
	PLA
CODE_01C314:
	ASL
	BCC.b CODE_01C31C
	JSR.w CODE_01C355
	BRA.b CODE_01C322

CODE_01C31C:
	ASL
	BCC.b CODE_01C322
	JSR.w CODE_01C36E
CODE_01C322:
	RTS

CODE_01C323:
	LDA.w $01ED
	CMP.w #$0019
	BCS.b CODE_01C335
	LDA.w $01FF
	AND.w #$F7FF
	STA.w $01FF
	RTS

CODE_01C335:
	DEC
	DEC
	STA.w $01ED
	BRA.b CODE_01C385

CODE_01C33C:
	LDA.w $01ED
	CMP.w #$00C0
	BCC.b CODE_01C34E
	LDA.w $01FF
	AND.w #$FBFF
	STA.w $01FF
	RTS

CODE_01C34E:
	INC
	INC
	STA.w $01ED
	BRA.b CODE_01C385

CODE_01C355:
	LDA.w $01EB
	CMP.w #$0011
	BCS.b CODE_01C367
	LDA.w $01FF
	AND.w #$FDFF
	STA.w $01FF
	RTS

CODE_01C367:
	DEC
	DEC
	STA.w $01EB
	BRA.b CODE_01C385

CODE_01C36E:
	LDA.w $01EB
	CMP.w #$00E8
	BCC.b CODE_01C380
	LDA.w $01FF
	AND.w #$FEFF
	STA.w $01FF
	RTS

CODE_01C380:
	INC
	INC
	STA.w $01EB
CODE_01C385:
	AND.w #$0007
	BNE.b CODE_01C322
	STA.w $01FF
	RTS

CODE_01C38E:
	JSR.w CODE_01C4E5
	REP.b #$20
	LDA.w $01F5
	LSR
	BCC.b CODE_01C3A0
	PHA
	JSR.w CODE_01EF42
	REP.b #$20
	PLA
CODE_01C3A0:
	LSR
	BCC.b CODE_01C3AA
	PHA
	JSR.w CODE_01EEE5
	REP.b #$20
	PLA
CODE_01C3AA:
	LSR
	BCC.b CODE_01C3B2
	JSR.w CODE_01EF49
	BRA.b CODE_01C3B8

CODE_01C3B2:
	LSR
	BCC.b CODE_01C3B8
	JSR.w CODE_01EEEC
CODE_01C3B8:
	REP.b #$20
	LDA.w $0139
	ORA.w $0137
	AND.w #$0007
	BNE.b CODE_01C3CE
	STZ.w $01F5
	LDA.w #$0003
	STA.w $01F3
CODE_01C3CE:
	RTS

CODE_01C3CF:
	REP.b #$30
	LDA.w $0201
	STA.b $79
	LDA.w $01D7
	BNE.b CODE_01C3E3
CODE_01C3DB:
	LDA.w #$00FF
	STA.w $0201
	BRA.b CODE_01C3F9

CODE_01C3E3:
	LDA.w $01EB
	CMP.w #$0038
	BCC.b CODE_01C3F3
	LDA.w $01ED
	CMP.w #$0030
	BCS.b CODE_01C3DB
CODE_01C3F3:
	STZ.w $0201
	STZ.w $023B
CODE_01C3F9:
	LDA.w $0201
	CMP.b $79
	BEQ.b CODE_01C433
	LDA.w #$FFFF
	STA.w $01EF
	LDA.w $0201
	BEQ.b CODE_01C433
	LDX.w $020D
	LDA.l DATA_018000,x
	AND.w #$00FF
	STA.w $01F9
	LDA.w $01EB
	AND.w #$FFF8
	STA.w $01EB
	LDA.w $01ED
	AND.w #$FFF8
	STA.w $01ED
	STZ.w $01F5
	STZ.w $01FF
	JSR.w CODE_01B375
CODE_01C433:
	RTS

CODE_01C434:
	SEP.b #$10
	REP.b #$20
	LDA.w $0201
	BEQ.b CODE_01C48F
	LDX.w $01F9
	LDA.l DATA_0180C0,x
	AND.w #$00FF
	ASL
	ASL
	ASL
	STA.b $79
	LDA.w $01EB
	AND.w #$00FF
	CMP.w #$0010
	BCS.b CODE_01C45C
	LDA.w #$0010
	BRA.b CODE_01C46A

CODE_01C45C:
	CLC
	ADC.b $79
	CMP.w #$00F1
	BCC.b CODE_01C46D
	LDA.w #$00F0
	SEC
	SBC.b $79
CODE_01C46A:
	STA.w $01EB
CODE_01C46D:
	LDA.w $01ED
	AND.w #$00FF
	CMP.w #$0018
	BCS.b CODE_01C47D
	LDA.w #$0018
	BRA.b CODE_01C48B

CODE_01C47D:
	CLC
	ADC.b $79
	CMP.w #$00C9
	BCC.b CODE_01C48E
	LDA.w #$00C8
	SEC
	SBC.b $79
CODE_01C48B:
	STA.w $01ED
CODE_01C48E:
	RTS

CODE_01C48F:
	RTS

CODE_01C490:
	LDA.w $01EB
	AND.w #$00FF
	CMP.w #$0010
	BCS.b CODE_01C4A0
	LDA.w #$0010
	BRA.b CODE_01C4A8

CODE_01C4A0:
	CMP.w #$00E1
	BCC.b CODE_01C4AB
	LDA.w #$00E0
CODE_01C4A8:
	STA.w $01EB
CODE_01C4AB:
	LDA.w $01ED
	AND.w #$00FF
	CMP.w #$0018
	BCS.b CODE_01C4BB
	LDA.w #$0018
	BRA.b CODE_01C4C3

CODE_01C4BB:
	CMP.w #$00C1
	BCC.b CODE_01C4C6
	LDA.w #$00C0
CODE_01C4C3:
	STA.w $01ED
CODE_01C4C6:
	RTS

CODE_01C4C7:
	REP.b #$30
	LDA.w $01F5
	LSR
	BCC.b CODE_01C4D2
	INC.w $01BD
CODE_01C4D2:
	LSR
	BCC.b CODE_01C4D8
	DEC.w $01BD
CODE_01C4D8:
	LSR
	BCC.b CODE_01C4DE
	INC.w $01BF
CODE_01C4DE:
	LSR
	BCC.b CODE_01C4E4
	DEC.w $01BF
CODE_01C4E4:
	RTS

CODE_01C4E5:
	REP.b #$30
	LDA.w $01F5
	LSR
	BCC.b CODE_01C4FA
	PHA
	LDA.w $0139
	INC
	INC
	AND.w #$00FF
	STA.w $0139
	PLA
CODE_01C4FA:
	LSR
	BCC.b CODE_01C50A
	PHA
	LDA.w $0139
	DEC
	DEC
	AND.w #$00FF
	STA.w $0139
	PLA
CODE_01C50A:
	LSR
	BCC.b CODE_01C51A
	PHA
	LDA.w $0137
	INC
	INC
	AND.w #$00FF
	STA.w $0137
	PLA
CODE_01C51A:
	LSR
	BCC.b CODE_01C528
	LDA.w $0137
	DEC
	DEC
	AND.w #$00FF
	STA.w $0137
CODE_01C528:
	RTS

CODE_01C529:
	REP.b #$30
	LDA.w $01F5
	BNE.b CODE_01C5AF
	REP.b #$20
	LDA.b $C9
	AND.w #$2000
	BNE.b CODE_01C53C
	JMP.w CODE_01C5B0

CODE_01C53C:
	LDA.w $0201
	BEQ.b CODE_01C581
	LDA.w $01D7
	BNE.b CODE_01C54B
	JSR.w CODE_018DCE
	REP.b #$30
CODE_01C54B:
	LDA.w $01EB
	STA.w $01EF
	LDA.w $01ED
	STA.w $01F1
	LDX.w #$001A
	LDA.w $01DD
	LSR
	BCC.b CODE_01C563
	LDX.w #$002A
CODE_01C563:
	STX.w $01EB
	LDA.w $01DD
	AND.w #$00FE
	ASL
	ASL
	ASL
	ADC.w #$0038
	STA.w $01ED
	STZ.w $0201
	PHP
	JSL.l CODE_0098A0	: dw $0803
	PLP
	RTS

CODE_01C581:
	LDA.w $01EF
	BMI.b CODE_01C5AF
	PHP
	JSL.l CODE_0098A0	: dw $0803
	PLP
	LDA.w $01EF
	AND.w #$00F8
	STA.w $01EB
	LDA.w $01F1
	AND.w #$00F8
	STA.w $01ED
	STZ.w $01FF
	STZ.w $023B
	LDA.w #$00FF
	STA.w $0201
	JSR.w CODE_01B375
CODE_01C5AF:
	RTS

CODE_01C5B0:
	REP.b #$20
	LDA.w $0201
	BEQ.b CODE_01C5E5
	LDA.w $01D7
	BNE.b CODE_01C5C1
	JSR.w CODE_018DCE
	REP.b #$30
CODE_01C5C1:
	LDA.w $01EB
	STA.w $01EF
	LDA.w $01ED
	STA.w $01F1
	LDA.w #$0048
	STA.w $01EB
	LDA.w #$0020
	STA.w $01ED
	STZ.w $0201
	PHP
	JSL.l CODE_0098A0	: dw $0803
	PLP
	RTS

CODE_01C5E5:
	REP.b #$20
	LDA.w $01EF
	BMI.b CODE_01C5AF
	PHP
	JSL.l CODE_0098A0	: dw $0803
	PLP
	LDA.w $01EF
	AND.w #$00F8
	STA.w $01EB
	LDA.w $01F1
	AND.w #$00F8
	STA.w $01ED
	STZ.w $01FF
	STZ.w $023B
	LDA.w #$00FF
	STA.w $0201
	JSR.w CODE_01B375
	RTS

CODE_01C616:
	REP.b #$30
	LDA.w #$0000
	STA.w $0253
	LDA.w $0201
	BEQ.b CODE_01C641
	LDA.b $D7
	BNE.b CODE_01C640
	LDA.w $01EB
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w $01ED
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w $01F9
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
CODE_01C640:
	RTS

CODE_01C641:
	SEP.b #$20
	LDA.w $01ED
	XBA
	LDA.w $01EB
	REP.b #$20
	STA.l SIMC_Global_OAMBuffer[$00].XDisp
	LDA.w #$31EC
	STA.l SIMC_Global_OAMBuffer[$00].Tile
	SEP.b #$20
	LDA.b #$56
	STA.l SIMC_Global_UpperOAMBuffer[$00].Slot
	RTS

CODE_01C660:
	REP.b #$20
	LDA.w $01E5
	BNE.b CODE_01C668
	RTS

CODE_01C668:
	STZ.w $01E5
	LDA.w $01D7
	BEQ.b CODE_01C69E
	LDA.w #$0100
	STA.w $0253
	LDA.w #$000F
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w #$0016
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$0006
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	JSR.w CODE_01C807
	JSL.l CODE_0084A9
	JSL.l CODE_00842A
	JSR.w CODE_018F25
	RTS

CODE_01C69E:
	LDA.w #$5555
	STA.l SIMC_Global_UpperOAMBuffer[$10].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$12].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$14].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$02].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$04].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$06].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$08].Slot
	LDA.w #$5500
	STA.l SIMC_Global_UpperOAMBuffer[$00].Slot
	JSR.w CODE_018F9F
	RTS

CODE_01C6C8:
	JSR.w CODE_01C6CC
	RTL

CODE_01C6CC:
	REP.b #$30
	LDA.w #$001D
	STA.w $01B1
CODE_01C6D4:
	LDA.w #$001F
	STA.w $01AF
CODE_01C6DA:
	LDA.w $01B1
	SEP.b #$20
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	LDA.b #$20
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	REP.b #$20
	CLC
	ADC.w $01AF
	ASL
	STA.w $01BB
	LDA.w $01AF
	CLC
	ADC.w $01BD
	STA.w $01D3
	LDA.w $01B1
	CLC
	ADC.w $01BF
	STA.w $01D5
	JSR.w CODE_01C772
	LDX.w $01BB
	LDA.w $013D
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	LDA.w $013F
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer,x
	LDA.w $013B
	BMI.b CODE_01C759
	AND.w #$03FF
	CMP.w #$0084
	BNE.b CODE_01C759
	PHX
	TXA
	CLC
	ADC.w #$0042
	CMP.w #$0800
	BCC.b CODE_01C750
	SBC.w #$0800
CODE_01C750:
	TAX
	LDA.w #$1376
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	PLX
CODE_01C759:
	DEC.w $01AF
	BMI.b CODE_01C761
	JMP.w CODE_01C6DA

CODE_01C761:
	DEC.w $01B1
	BMI.b CODE_01C769
	JMP.w CODE_01C6D4

CODE_01C769:
	SEP.b #$20
	LDA.b $BB
	ORA.b #$04
	STA.b $BB
	RTS

CODE_01C772:
	REP.b #$10
	SEP.b #$20
	LDA.w $01D3
	BMI.b CODE_01C7D5
	CMP.b #$78
	BCS.b CODE_01C7D5
	LDA.w $01D5
	BMI.b CODE_01C7D5
	CMP.b #$64
	BCS.b CODE_01C7D5
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	LDA.b #$78
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	REP.b #$20
	CLC
	ADC.w $01D3
	ASL
	TAX
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	STA.w $013B
	AND.w #$03FF
	PHA
	JSR.w CODE_01C7F6
	STA.w $013F
	PLA
	PHA
	JSR.w CODE_01C7ED
	STA.w $013D
	PLA
	JSR.w CODE_01C7FD
	STA.w $0141
	RTS

CODE_01C7D5:
	REP.b #$30
	STZ.w $013B
	LDA.w #$0300
	STA.w $013D
	LDA.w #$0301
	STA.w $013F
	LDA.w #$014B
	STA.w $0141
	RTS

CODE_01C7ED:
	PHX
	ASL
	TAX
	LDA.l DATA_02CF2D,x
	PLX
	RTS

CODE_01C7F6:
	ASL
	TAX
	LDA.l DATA_02D6A9,x
	RTS

CODE_01C7FD:
	ASL
	TAX
	LDA.l DATA_02DE25,x
	ORA.w #$2000
	RTS

CODE_01C807:
	JSR.w CODE_01C8A9
	JSR.w CODE_01C8B7
	JSR.w CODE_01C871
	JSR.w CODE_01C89B
	JSR.w CODE_01C8C8
	RTS

CODE_01C817:
	JSR.w CODE_01C824
	JSR.w CODE_01C871
	JSR.w CODE_01C89B
	JSR.w CODE_01C8C8
	RTS

CODE_01C824:
	SEP.b #$30
	LDY.b #$0F
	LDX.b #$1E
CODE_01C82A:
	LDA.w $0425
	AND.b #$02
	BNE.b CODE_01C84D
	LDA.w !RAM_SIMC_City_CurrentFundsHi
	BNE.b CODE_01C84D
	REP.b #$20
	LDA.w !RAM_SIMC_City_CurrentFundsLo
	CMP.l DATA_01884E,x
	SEP.b #$20
	BCS.b CODE_01C84D
	LDA.w $029B,y
	ORA.b #$80
	STA.w $029B,y
	BRA.b CODE_01C855

CODE_01C84D:
	LDA.w $029B,y
	AND.b #$7F
	STA.w $029B,y
CODE_01C855:
	DEX
	DEX
	DEY
	BPL.b CODE_01C82A
	REP.b #$20
	LDY.b #$0F
	LDA.w $03F5
	ORA.w $03F7
	BNE.b CODE_01C870
	SEP.b #$20
	LDA.w $029B,y
	ORA.b #$80
	STA.w $029B,y
CODE_01C870:
	RTS

CODE_01C871:
	SEP.b #$30
	LDX.b #$0F
CODE_01C875:
	LDA.w $029B,x
	CMP.w $028B,x
	BEQ.b CODE_01C884
	PHX
	JSR.w CODE_01C888
	SEP.b #$10
	PLX
CODE_01C884:
	DEX
	BPL.b CODE_01C875
	RTS

CODE_01C888:
	SEP.b #$30
	PHX
	LDX.w $084B
	STA.w $084F,x
	INX
	PLA
	STA.w $084F,x
	INX
	STX.w $084B
	RTS

CODE_01C89B:
	SEP.b #$30
	LDX.b #$0F
CODE_01C89F:
	LDA.w $029B,x
	STA.w $028B,x
	DEX
	BPL.b CODE_01C89F
	RTS

CODE_01C8A9:
	SEP.b #$30
	LDX.b #$0F
CODE_01C8AD:
	LDA.w $028B,x
	STA.w $029B,x
	DEX
	BPL.b CODE_01C8AD
	RTS

CODE_01C8B7:
	SEP.b #$30
	LDX.b #$0F
	LDA.b #$02
CODE_01C8BD:
	STA.w $028B,x
	DEX
	BPL.b CODE_01C8BD
	RTS

CODE_01C8C4:
	JSR.w CODE_01C8C8
	RTL

CODE_01C8C8:
	SEP.b #$30
	LDA.w $084D
	CMP.w $084B
	BNE.b CODE_01C8D3
	RTS

CODE_01C8D3:
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
CODE_01C8DB:
	JSL.l CODE_008206
	SEP.b #$20
	STZ.w $0849
CODE_01C8E4:
	LDX.w $084D
	CPX.w $084B
	BNE.b CODE_01C8EF
	JMP.w CODE_01C9A2

CODE_01C8EF:
	INC.w $0849
	LDA.w $084F,x
	INX
	PHA
	LDA.w $084F,x
	INX
	STX.w $084D
	TAX
	LDA.l DATA_0180C4,x
	STA.b $94
	LDA.l DATA_018107,x
	STA.b $95
	PLA
	BIT.b #$81
	BPL.b CODE_01C934
	LDA.l DATA_01814A,x
	STA.b $91
	LDA.l DATA_01818D,x
	STA.b $92
	LDA.l DATA_0181D0,x
	STA.b $93
	TXA
	ASL
	ASL
	TAX
	LDA.l SIMC_Global_OAMBuffer[$48].Prop,x
	AND.b #$F1
	ORA.b #$04
	STA.l SIMC_Global_OAMBuffer[$48].Prop,x
	BRA.b CODE_01C98E

CODE_01C934:
	BEQ.b CODE_01C95A
	LDA.l DATA_018213,x
	STA.b $91
	LDA.l DATA_018256,x
	STA.b $92
	LDA.l DATA_018299,x
	STA.b $93
	TXA
	ASL
	ASL
	TAX
	LDA.l SIMC_Global_OAMBuffer[$48].Prop,x
	AND.b #$F1
	ORA.b #$00
	STA.l SIMC_Global_OAMBuffer[$48].Prop,x
	BRA.b CODE_01C98E

CODE_01C95A:
	LDA.l DATA_01814A,x
	STA.b $91
	LDA.l DATA_01818D,x
	STA.b $92
	LDA.l DATA_0181D0,x
	STA.b $93
	TXA
	ASL
	ASL
	TAX
	CPX.b #$3C
	BNE.b CODE_01C982
	LDA.l SIMC_Global_OAMBuffer[$48].Prop,x
	AND.b #$F1
	ORA.b #$06
	STA.l SIMC_Global_OAMBuffer[$48].Prop,x
	BRA.b CODE_01C98E

CODE_01C982:
	LDA.l SIMC_Global_OAMBuffer[$48].Prop,x
	AND.b #$F1
	ORA.b #$00
	STA.l SIMC_Global_OAMBuffer[$48].Prop,x
CODE_01C98E:
	JSR.w CODE_01C9AD
	SEP.b #$20
	SEP.b #$10
	LDA.w $0849
	CMP.b #$04
	BCC.b CODE_01C99F
	JMP.w CODE_01C8DB

CODE_01C99F:
	JMP.w CODE_01C8E4

CODE_01C9A2:
	STZ.b $B7
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	RTS

CODE_01C9AD:
	SEP.b #$30
	LDA.b #$01
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b $94
	STA.w !REGISTER_VRAMAddressLo
	LDA.b $95
	STA.w !REGISTER_VRAMAddressHi
	LDA.b $91
	STA.w DMA[$00].SourceLo,x
	LDA.b $92
	STA.w DMA[$00].SourceHi,x
	LDA.b $93
	STA.w DMA[$00].SourceBank,x
	LDA.b #$40
	STA.w DMA[$00].SizeLo,x
	LDA.b #$00
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$01
	BEQ.b CODE_01C9ED
CODE_01C9E9:
	ASL
	DEX
	BNE.b CODE_01C9E9
CODE_01C9ED:
	STA.w !REGISTER_DMAEnable
	REP.b #$20
	LDA.b $91
	CLC
	ADC.w #$0040
	STA.b $91
	LDA.b $94
	CLC
	ADC.w #$0100
	STA.b $94
	SEP.b #$20
	SEP.b #$30
	LDA.b #$01
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b $94
	STA.w !REGISTER_VRAMAddressLo
	LDA.b $95
	STA.w !REGISTER_VRAMAddressHi
	LDA.b $91
	STA.w DMA[$00].SourceLo,x
	LDA.b $92
	STA.w DMA[$00].SourceHi,x
	LDA.b $93
	STA.w DMA[$00].SourceBank,x
	LDA.b #$40
	STA.w DMA[$00].SizeLo,x
	LDA.b #$00
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$01
	BEQ.b CODE_01CA44
CODE_01CA40:
	ASL
	DEX
	BNE.b CODE_01CA40
CODE_01CA44:
	STA.w !REGISTER_DMAEnable
	RTS

CODE_01CA48:
	SEP.b #$30
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	JSL.l CODE_008206
	LDA.w $01DF
	CLC
	ADC.b #$10
	TAX
	LDA.l DATA_0180C4,x
	STA.b $94
	LDA.l DATA_018107,x
	STA.b $95
	LDA.w $01E3
	BNE.b CODE_01CA82
	LDA.l DATA_018213,x
	STA.b $91
	LDA.l DATA_018256,x
	STA.b $92
	LDA.l DATA_018299,x
	STA.b $93
	BRA.b CODE_01CA94

CODE_01CA82:
	LDA.l DATA_01814A,x
	STA.b $91
	LDA.l DATA_01818D,x
	STA.b $92
	LDA.l DATA_0181D0,x
	STA.b $93
CODE_01CA94:
	JSR.w CODE_01C9AD
	SEP.b #$20
	REP.b #$10
	STZ.b $B7
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	RTS

CODE_01CAA6:
	SEP.b #$30
	LDX.w $084B
	LDY.w $01DD
	LDA.w $029B,y
	ORA.b #$01
	STA.w $084F,x
	INX
	TYA
	STA.w $084F,x
	INX
	STX.w $084B
	JSR.w CODE_01C8C8
	RTS

CODE_01CAC3:
	REP.b #$20
	LDA.w $0385
	BEQ.b CODE_01CACD
	JSR.w CODE_0194A7
CODE_01CACD:
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	LDA.w $03F3
	CMP.w #$0004
	BNE.b CODE_01CAE1
	STZ.w $03F3
CODE_01CAE1:
	LDA.w #$00FF
	STA.b $E3
	STA.w $010D
	JSR.w CODE_01CCF2
	JSR.w CODE_01CBC8
	JSR.w CODE_01CF8A
	JSR.w CODE_01CC1A
	JSR.w CODE_01D036
	JSR.w CODE_01CC0B
	REP.b #$20
	STZ.b $E3
	RTS

DATA_01CB00:
	incbin "Tilemaps/DATA_01CB00.bin"

CODE_01CBC8:
	REP.b #$30
	PHK
	PLB
	LDA.w #$040E
	STA.b $79
	LDA.w #$000A
	STA.b $7C
	LDY.w #$0000
CODE_01CBD9:
	LDA.w #$000A
	STA.b $7F
	LDX.b $79
CODE_01CBE0:
	LDA.w DATA_01CB00,y
	STA.l !RAM_SIMC_Global_Layer3TilemapBuffer,x
	INX
	INX
	INY
	INY
	DEC.b $7F
	BNE.b CODE_01CBE0
	LDA.b $79
	CLC
	ADC.w #$0040
	STA.b $79
	DEC.b $7C
	BNE.b CODE_01CBD9
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	JSR.w CODE_01A8FF
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	RTS

CODE_01CC0B:
	JSL.l CODE_0097F4
	JSR.w CODE_01A8FF
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	RTS

CODE_01CC1A:
	JSR.w CODE_01CCA8
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	LDA.b $C9
	AND.w #$0F00
	BNE.b CODE_01CC3B
	LDA.b $C9
	AND.w #$8040
	BEQ.b CODE_01CC1A
	PHP
	JSL.l CODE_0098A0	: dw $0102
	PLP
	RTS

CODE_01CC3B:
	STZ.w $010D
	SEP.b #$20
	XBA
	LSR
	BCS.b CODE_01CC6D
	LSR
	BCS.b CODE_01CC7D
	LSR
	BCS.b CODE_01CC5A
	REP.b #$20
	LDA.w $03F3
	SEC
	SBC.w #$0002
	BCS.b CODE_01CC88
	ADC.w #$0004
	BRA.b CODE_01CC88

CODE_01CC5A:
	REP.b #$20
	LDA.w $03F3
	CLC
	ADC.w #$0002
	CMP.w #$0004
	BCC.b CODE_01CC88
	SBC.w #$0004
	BRA.b CODE_01CC88

CODE_01CC6D:
	REP.b #$20
	LDA.w $03F3
	INC
	CMP.w #$0004
	BCC.b CODE_01CC88
	LDA.w #$0000
	BRA.b CODE_01CC88

CODE_01CC7D:
	REP.b #$20
	LDA.w $03F3
	DEC
	BPL.b CODE_01CC88
	LDA.w #$0003
CODE_01CC88:
	TAX
	TAY
	LDA.w $03F5,x
	AND.w #$00FF
	BEQ.b CODE_01CC1A
	STY.w $03F3
	PHP
	JSL.l CODE_0098A0	: dw $0703
	PLP
	JMP.w CODE_01CC1A

DATA_01CCA0:
	dw $8941,$8969,$B141,$B169

CODE_01CCA8:
	REP.b #$30
	LDA.w $010D
	BEQ.b CODE_01CCB9
	LDA.b $D1
	AND.w #$003F
	CMP.w #$002A
	BCS.b CODE_01CCE9
CODE_01CCB9:
	LDA.w $03F3
	ASL
	TAX
	LDA.l DATA_01CCA0,x
	PHA
	AND.w #$00FF
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	PLA
	SEP.b #$20
	XBA
	REP.b #$20
	AND.w #$00FF
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$0001
	STA.w $0261
	LDA.w #$0000
	STA.w $0253
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	RTS

CODE_01CCE9:
	SEP.b #$20
	LDA.b #$55
	STA.l SIMC_Global_UpperOAMBuffer[$00].Slot
	RTS

CODE_01CCF2:
	JSR.w CODE_01CD68
	REP.b #$30
	LDX.w #$0000
	STX.b $79
CODE_01CCFC:
	LDA.w $03F5,x
	AND.w #$00FF
	JSR.w CODE_01CEBC
	REP.b #$30
	INC.b $79
	LDX.b $79
	CPX.w #$0004
	BCC.b CODE_01CCFC
	SEP.b #$20
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	JSL.l CODE_008206
	REP.b #$20
	LDA.w #$6C00
	STA.w !REGISTER_VRAMAddressLo
	SEP.b #$30
	LDA.b #$01
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer
	STA.w DMA[$00].SourceLo,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$08
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$01
	BEQ.b CODE_01CD5C
CODE_01CD58:
	ASL
	DEX
	BNE.b CODE_01CD58
CODE_01CD5C:
	STA.w !REGISTER_DMAEnable
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	RTS

CODE_01CD68:
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0AC4CF
	STX.b $09
	LDA.b #DATA_0AC4CF>>16
	STA.b $0B
	LDX.w #$1000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	RTS

DATA_01CD82:
	dw $8000,$8080,$8100,$8180

DATA_01CD8A:
	dw DATA_01CDAC,DATA_01CDBC,DATA_01CE8C,DATA_01CDCC,DATA_01CDDC,DATA_01CDEC,DATA_01CDFC,DATA_01CE0C
	dw DATA_01CE1C,DATA_01CE2C,DATA_01CE3C,DATA_01CE4C,DATA_01CE9C,DATA_01CE5C,DATA_01CE6C,DATA_01CE7C
	dw DATA_01CEAC

DATA_01CDAC:
	db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

DATA_01CDBC:
	db $00,$01,$02,$FF,$03,$04,$05,$FF,$06,$07,$08,$FF,$FF,$FF,$FF,$FF

DATA_01CDCC:
	db $09,$0A,$0B,$FF,$0C,$0D,$0E,$FF,$0F,$10,$11,$FF,$FF,$FF,$FF,$FF

DATA_01CDDC:
	db $12,$13,$14,$FF,$15,$16,$17,$FF,$18,$19,$1A,$FF,$FF,$FF,$FF,$FF

DATA_01CDEC:
	db $1B,$1C,$1D,$FF,$1E,$1F,$20,$FF,$21,$22,$23,$FF,$FF,$FF,$FF,$FF

DATA_01CDFC:
	db $24,$25,$26,$FF,$27,$28,$29,$FF,$2A,$2B,$2C,$FF,$FF,$FF,$FF,$FF

DATA_01CE0C:
	db $2D,$2E,$2F,$FF,$30,$31,$32,$FF,$33,$34,$35,$FF,$FF,$FF,$FF,$FF

DATA_01CE1C:
	db $36,$37,$38,$FF,$39,$3A,$3B,$FF,$3C,$3D,$3E,$FF,$FF,$FF,$FF,$FF

DATA_01CE2C:
	db $3F,$40,$41,$FF,$42,$43,$44,$FF,$45,$46,$47,$FF,$FF,$FF,$FF,$FF

DATA_01CE3C:
	db $48,$49,$4A,$FF,$4B,$4C,$4D,$FF,$4E,$4F,$50,$FF,$FF,$FF,$FF,$FF

DATA_01CE4C:
	db $51,$52,$53,$FF,$54,$55,$56,$FF,$57,$58,$59,$FF,$FF,$FF,$FF,$FF

DATA_01CE5C:
	db $5A,$5B,$5C,$FF,$5D,$5E,$5F,$FF,$60,$61,$62,$FF,$FF,$FF,$FF,$FF

DATA_01CE6C:
	db $63,$64,$65,$FF,$66,$67,$68,$FF,$69,$6A,$6B,$FF,$FF,$FF,$FF,$FF

DATA_01CE7C:
	db $6C,$6D,$6E,$FF,$6F,$70,$71,$FF,$72,$73,$74,$FF,$FF,$FF,$FF,$FF

DATA_01CE8C:
	db $75,$76,$77,$FF,$78,$79,$7A,$FF,$7B,$7C,$7D,$FF,$FF,$FF,$FF,$FF

DATA_01CE9C:
	db $7E,$7F,$80,$FF,$81,$82,$83,$FF,$84,$85,$86,$FF,$FF,$FF,$FF,$FF

DATA_01CEAC:
	db $87,$88,$89,$FF,$8A,$8B,$8C,$FF,$8D,$8E,$8F,$FF,$FF,$FF,$FF,$FF

CODE_01CEBC:
	REP.b #$30
	PHA
	TXA
	ASL
	TAX
	LDA.l DATA_01CD82,x
	STA.b $7C
	PLA
	ASL
	TAX
	LDA.l DATA_01CD8A,x
	PHA
	LDY.w #$7E0000
	LDX.b $7C
	LDA.w #$0004
	STA.b $7F
CODE_01CEDA:
	LDA.w #$0004
	STA.b $82
	LDX.b $7C
CODE_01CEE1:
	PHK
	PLB
	LDA.b ($01,S),y
	INY
	AND.w #$00FF
	CMP.w #$00FF
	BEQ.b CODE_01CF3B
	ASL
	ASL
	ASL
	ASL
	ASL
	PHY
	TXY
	CLC
	ADC.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$1000
	TAX
	LDA.w #$001F
	MVN $7E0000>>16,(!RAM_SIMC_Global_GeneralPurposeBuffer+$1000)>>16
	PHK
	PLB
	TYX
	PLY
CODE_01CF04:
	DEC.b $82
	BNE.b CODE_01CEE1
	LDA.b $7C
	CLC
	ADC.w #$0200
	STA.b $7C
	DEC.b $7F
	BNE.b CODE_01CEDA
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	PLA
	RTS

DATA_01CF1B:
	dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000

CODE_01CF3B:
	REP.b #$30
	PHY
	TXY
	LDX.w #DATA_01CF1B
	LDA.w #$001F
	MVN $7E0000>>16,DATA_01CF1B>>16
	PHK
	PLB
	TYX
	PLY
	BRA.b CODE_01CF04

DATA_01CF4E:
	db $30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30
	db $30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30
	db $30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30
	db $30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30,$30

CODE_01CF8A:
	JSR.w CODE_01D019
	REP.b #$30
	PHK
	PLB
	LDA.w #$0000
	STA.b $79
CODE_01CF96:
	LDX.b $79
	LDA.w $03F5,x
	AND.w #$00FF
	BEQ.b CODE_01CFA1
	DEC
CODE_01CFA1:
	ASL
	ASL
	TAY
	LDA.w #$0004
	STA.b $7C
	LDA.b $79
	ASL
	ASL
	ASL
	ASL
	TAX
CODE_01CFB0:
	SEP.b #$20
	LDA.w DATA_01CF4E,y
	INY
	STA.l SIMC_Global_OAMBuffer[$28].Prop,x
	INX
	INX
	INX
	INX
	REP.b #$20
	DEC.b $7C
	BNE.b CODE_01CFB0
	INC.b $79
	LDA.b $79
	CMP.w #$0004
	BCC.b CODE_01CF96
	LDA.w #$AAAA
	STA.l SIMC_Global_UpperOAMBuffer[$0A].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$0C].Slot
	RTS

DATA_01CFD9:
	dw $8840,$00C0,$8850,$00C2,$9840,$00E0,$9850,$00E2
	dw $8868,$00C4,$8878,$00C6,$9868,$00E4,$9878,$00E6
	dw $B040,$00C8,$B050,$00CA,$C040,$00E8,$C050,$00EA
	dw $B068,$00CC,$B078,$00CE,$C068,$00EC,$C078,$00EE

CODE_01D019:
	REP.b #$30
	LDX.w #$0000
	TXY
	LDA.w #$0020
	STA.b $79
	PHK
	PLB
CODE_01D026:
	LDA.w DATA_01CFD9,y
	INY
	INY
	STA.l SIMC_Global_OAMBuffer[$28].XDisp,x
	INX
	INX
	DEC.b $79
	BNE.b CODE_01D026
	RTS

CODE_01D036:
	REP.b #$20
	LDA.w #$FFFF
	STA.l SIMC_Global_UpperOAMBuffer[$0A].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$0C].Slot
	RTS

CODE_01D044:
	SEP.b #$10
	REP.b #$20
	LDX.b #$00
CODE_01D04A:
	LDA.l SIMC_Global_PaletteMirror[$00].LowByte,x
	STA.l !RAM_SIMC_Global_CopyOfPaletteMirror,x
	INX
	INX
	BNE.b CODE_01D04A
	RTS

CODE_01D057:
	SEP.b #$10
	REP.b #$20
	LDX.b #$00
CODE_01D05D:
	LDA.l !RAM_SIMC_Global_CopyOfPaletteMirror,x
	STA.l SIMC_Global_PaletteMirror[$00].LowByte,x
	INX
	INX
	BNE.b CODE_01D05D
	RTS

CODE_01D06A:
	JSR.w CODE_01D0E2
	REP.b #$20
	LDA.w #$5555
	STA.l SIMC_Global_UpperOAMBuffer[$01].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$03].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$05].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$07].Slot
	RTS

CODE_01D083:
	JSR.w CODE_01D0E2
	REP.b #$20
	LDA.w $01E9
	BNE.b CODE_01D09D
	JSR.w CODE_01E347
	JSR.w CODE_018F9F
	JSR.w CODE_01A8FF
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
CODE_01D09D:
	JSR.w CODE_01D6CE
	JSR.w CODE_01D84B
	JSR.w CODE_01D67B
	JSR.w CODE_01D94F
	RTS

CODE_01D0AA:
	JSR.w CODE_01D0E2
	REP.b #$20
	LDA.w $01E9
	BNE.b CODE_01D0C4
	JSR.w CODE_01E347
	JSR.w CODE_018F9F
	JSR.w CODE_01A8FF
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
CODE_01D0C4:
	JSR.w CODE_01D6CE
	JSR.w CODE_01D84B
	JSR.w CODE_01D67B
	JSR.w CODE_01D9EA
	RTS

CODE_01D0D1:
	REP.b #$30
	LDX.w #$1FFE
	LDA.w #$0000
CODE_01D0D9:
	STA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$4000,x
	DEX
	DEX
	BPL.b CODE_01D0D9
	RTS

CODE_01D0E2:
	REP.b #$30
	LDA.w #$5555
	STA.l SIMC_Global_UpperOAMBuffer[$12].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$14].Slot
	RTS

DATA_01D0F0:
	incbin "Tilemaps/DATA_01D0F0.bin"

DATA_01D2C4:
	incbin "Tilemaps/DATA_01D2C4.bin"

DATA_01D42C:
	incbin "Tilemaps/DATA_01D42C.bin"

DATA_01D66C:
	db $0A,$0A,$0D,$10,$0A

DATA_01D671:
	dw DATA_01D2C4,DATA_01D2C4,DATA_01D0F0,DATA_01D42C,DATA_01D2C4

CODE_01D67B:
	JSR.w CODE_01B417
	REP.b #$30
	PHK
	PLB
	LDA.w #$0082
	STA.b $79
	LDX.w $01DF
	LDA.w DATA_01D66C,x
	AND.w #$00FF
	STA.b $7C
	TXA
	ASL
	TAX
	LDA.w DATA_01D671,x
	PHA
	LDY.w #$0000
CODE_01D69C:
	LDA.w #$0012
	STA.b $7F
	LDX.b $79
CODE_01D6A3:
	LDA.b ($01,S),y
	STA.l !RAM_SIMC_Global_Layer3TilemapBuffer,x
	INX
	INX
	INY
	INY
	DEC.b $7F
	BNE.b CODE_01D6A3
	LDA.b $79
	CLC
	ADC.w #$0040
	STA.b $79
	DEC.b $7C
	BNE.b CODE_01D69C
	PLA
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	JSR.w CODE_01A8FF
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	RTS

CODE_01D6CE:
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0AA523
	STX.b $09
	LDA.b #DATA_0AA523>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	JSR.w CODE_01D0D1
	JSR.w CODE_01D729
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	RTS

DATA_01D6F3:
	dw $004C,$004D,$004E,$005C,$005D,$005E,$006C,$006D
	dw $006E,$00A0,$00A1,$00A2,$00B0,$00B1,$00B2,$00A4
	dw $00A5,$00A6

DATA_01D717:
	dw $015A,$015B,$015C,$015D,$015E,$015F,$0160,$0161
	dw $0162

CODE_01D729:
	REP.b #$30
	LDA.w $01DF
	ASL
	TAX
	LDA.l DATA_03E5CF,x
	PHA
	LDY.w #$0000
CODE_01D738:
	SEP.b #$20
	LDA.b #DATA_03E5DF>>16
	PHA
	PLB
	REP.b #$20
	LDA.b ($01,S),y
	CMP.w #$FFFF
	BEQ.b CODE_01D76C
	ASL
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$4000
	TAX
	INY
	INY
	LDA.b ($01,S),y
	ASL
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC.w #!RAM_SIMC_Global_GeneralPurposeBuffer
	INY
	INY
	PHY
	TXY
	TAX
	LDA.w #$001F
	MVN (!RAM_SIMC_Global_GeneralPurposeBuffer+$4000)>>16,!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	PLY
	BRA.b CODE_01D738

CODE_01D76C:
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	REP.b #$20
	PLA
	LDA.w $01DF
	CMP.w #$0003
	BEQ.b CODE_01D77D
	RTS

CODE_01D77D:
	LDX.w #$0000
	LDA.w $01E7
	STA.b $7F
	LDA.w #$0002
	STA.b $79
CODE_01D78A:
	LSR.b $7F
	BCC.b CODE_01D796
	TXA
	CLC
	ADC.w #$0012
	TAX
	BRA.b CODE_01D7CF

CODE_01D796:
	LDA.w #$0009
	STA.b $7C
CODE_01D79B:
	LDA.l DATA_01D6F3,x
	INX
	INX
	PHX
	ASL
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$4000
	TAY
	LDA.w #$0009
	SEC
	SBC.b $7C
	ASL
	TAX
	LDA.l DATA_01D717,x
	ASL
	ASL
	ASL
	ASL
	ASL
	CLC
	ADC.w #!RAM_SIMC_Global_GeneralPurposeBuffer
	TAX
	LDA.w #$001F
	PHB
	MVN (!RAM_SIMC_Global_GeneralPurposeBuffer+$4000)>>16,!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	PLB
	PLX
	DEC.b $7C
	BNE.b CODE_01D79B
CODE_01D7CF:
	DEC.b $79
	BNE.b CODE_01D78A
	RTS

ADDR_01D7D4:
	REP.b #$30
	LDX.w $01DF
	LDA.l UNK_0185BE,x
	AND.w #$00FF
	STA.w $02BB
	LDA.w $01DF
	ASL
	TAX
	LDA.w UNK_009EDF,x
	PHA
ADDR_01D7EC:
	LDA.w $02BB
	ASL
	PHA
	TAX
	LDA.l UNK_0185C6,x
	STA.w $02BD
	PLY
	LDA.b ($01,S),y
	STA.b $79
	JSR.w ADDR_01D80A
	REP.b #$30
	DEC.w $02BB
	BPL.b ADDR_01D7EC
	PLA
	RTS

ADDR_01D80A:
	SEP.b #$20
	REP.b #$10
	LDA.b #DATA_048000>>16
	PHA
	PLB
	LDX.w $02BD
	LDY.w #$0000
	REP.b #$20
	LDA.w #$0003
	STA.b $7F
ADDR_01D81F:
	LDA.w #$0030
	STA.b $7C
ADDR_01D824:
	LDA.b ($79),y
	STA.l !RAM_SIMC_Global_GeneralPurposeBuffer,x
	INX
	INX
	INY
	INY
	DEC.b $7C
	BNE.b ADDR_01D824
	DEC.b $7F
	BEQ.b ADDR_01D844
	TXA
	CLC
	ADC.w #$01A0
	TAX
	TYA
	CLC
	ADC.w #$01A0
	TAY
	BRA.b ADDR_01D81F

ADDR_01D844:
	SEP.b #$20
	LDA.b #CODE_008000>>16
	PHA
	PLB
	RTS

CODE_01D84B:
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	SEP.b #$30
	JSL.l CODE_008206
	SEP.b #$20
	REP.b #$10
	LDA.b #$01
	STA.w DMA[$01].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$01].Destination
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$4000)>>16
	STA.w DMA[$01].SourceBank
	LDX.w #$6600
	STX.w !REGISTER_VRAMAddressLo
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$4000
	STX.w DMA[$01].SourceLo
	LDX.w #$1000
	STX.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	SEP.b #$20
	REP.b #$10
	LDX.w #$6E00
	STX.w !REGISTER_VRAMAddressLo
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$5000
	STX.w DMA[$01].SourceLo
	LDX.w #$0800
	STX.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	SEP.b #$20
	STZ.b $B7
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	RTS

DATA_01D8AF:
	incbin "Palettes/DATA_01D8AF.bin"

CODE_01D94F:
	REP.b #$30
	PHK
	PLB
	LDX.w #$0100
	LDY.w #$0000
	LDA.w #$0010
	STA.b $79
CODE_01D95E:
	LDA.w DATA_01D8AF,y
	STA.l SIMC_Global_PaletteMirror[$00].LowByte,x
	INX
	INX
	INY
	INY
	DEC.b $79
	BNE.b CODE_01D95E
	LDX.w #$0120
	LDY.w #$0000
	LDA.w #$0010
	STA.b $79
CODE_01D978:
	LDA.w DATA_01D8AF+$20,y
	STA.l SIMC_Global_PaletteMirror[$00].LowByte,x
	INX
	INX
	INY
	INY
	DEC.b $79
	BNE.b CODE_01D978
	LDX.w #$0140
	LDY.w #$0000
	LDA.w #$0010
	STA.b $79
CODE_01D992:
	LDA.w DATA_01D8AF+$40,y
	STA.l SIMC_Global_PaletteMirror[$00].LowByte,x
	INX
	INX
	INY
	INY
	DEC.b $79
	BNE.b CODE_01D992
	LDX.w #$0160
	LDY.w #$0000
	LDA.w #$0010
	STA.b $79
CODE_01D9AC:
	LDA.w DATA_01D8AF+$80,y
	STA.l SIMC_Global_PaletteMirror[$00].LowByte,x
	INX
	INX
	INY
	INY
	DEC.b $79
	BNE.b CODE_01D9AC
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	JSR.w CODE_018A44
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	LDA.b $BB
	ORA.w #$0002
	STA.b $BB
	JSL.l CODE_008DA2
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	REP.b #$20
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	RTS

CODE_01D9EA:
	REP.b #$30
	PHK
	PLB
	LDX.w #$0100
	LDY.w #$0000
	LDA.w #$0010
	STA.b $79
CODE_01D9F9:
	LDA.w DATA_01D8AF,y
	STA.l SIMC_Global_PaletteMirror[$00].LowByte,x
	INX
	INX
	INY
	INY
	DEC.b $79
	BNE.b CODE_01D9F9
	LDX.w #$0120
	LDY.w #$0000
	LDA.w #$0010
	STA.b $79
CODE_01DA13:
	LDA.w DATA_01D8AF+$60,y
	STA.l SIMC_Global_PaletteMirror[$00].LowByte,x
	INX
	INX
	INY
	INY
	DEC.b $79
	BNE.b CODE_01DA13
	LDX.w #$0140
	LDY.w #$0000
	LDA.w #$0010
	STA.b $79
CODE_01DA2D:
	LDA.w DATA_01D8AF+$40,y
	STA.l SIMC_Global_PaletteMirror[$00].LowByte,x
	INX
	INX
	INY
	INY
	DEC.b $79
	BNE.b CODE_01DA2D
	LDX.w #$0160
	LDY.w #$0000
	LDA.w #$0010
	STA.b $79
CODE_01DA47:
	LDA.w DATA_01D8AF+$80,y
	STA.l SIMC_Global_PaletteMirror[$00].LowByte,x
	INX
	INX
	INY
	INY
	DEC.b $79
	BNE.b CODE_01DA47
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	JSR.w CODE_018A44
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	LDA.b $BB
	ORA.w #$0002
	STA.b $BB
	JSL.l CODE_008DA2
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	REP.b #$20
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	RTS

DATA_01DA85:
	incbin "Palettes/DATA_01DA85.bin"

CODE_01DAE5:
	REP.b #$30
	PHK
	PLB
	LDX.w #$0000
	LDY.w #$0000
	LDA.w #$0010
	STA.b $79
CODE_01DAF4:
	LDA.w DATA_01DA85,y
	STA.l SIMC_Global_PaletteMirror[$00].LowByte,x
	INX
	INX
	INY
	INY
	DEC.b $79
	BNE.b CODE_01DAF4
	LDX.w #$0100
	LDY.w #$0000
	LDA.w #$0020
	STA.b $79
CODE_01DB0E:
	LDA.w DATA_01DA85+$20,y
	STA.l SIMC_Global_PaletteMirror[$00].LowByte,x
	INX
	INX
	INY
	INY
	DEC.b $79
	BNE.b CODE_01DB0E
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	LDA.b $BB
	ORA.w #$0002
	STA.b $BB
	JSL.l CODE_008DA2
	RTS

DATA_01DB2E:
	db $00,$00,$00,$00,$00,$00,$00,$02,$00,$01,$01,$02,$02,$02,$02,$02
	db $02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$02,$00,$02,$02,$00,$02
	db $01,$01,$01,$01,$01,$00,$02,$02,$02,$02,$02,$01,$02,$01,$02,$00
	db $01,$00,$02,$02

DATA_01DB62:
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$00
	db $01,$01,$01,$01,$01,$00,$01,$01,$01,$01,$01,$00,$01,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$00,$00,$00
	db $00,$00,$01,$01

DATA_01DB96:
	incbin "Palettes/DATA_01DB96.bin"

DATA_01DBF6:
	incbin "Palettes/DATA_01DBF6.bin"

DATA_01DC76:
	incbin "Palettes/DATA_01DC76.bin"

DATA_01DCB6:
	incbin "Palettes/DATA_01DCB6.bin"

CODE_01DD76:
	REP.b #$30
	LDX.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.l DATA_01DB2E,x
	LDX.w #$0000
	AND.w #$00FF
	ASL
	ASL
	ASL
	ASL
	ASL
	TAY
	LDA.w #$0010
	STA.b $79
	LDX.w #$0000
	PHK
	PLB
CODE_01DD95:
	LDA.w DATA_01DB96,y
	INY
	INY
	STA.l SIMC_Global_PaletteMirror[$00].LowByte,x
	INX
	INX
	DEC.b $79
	BNE.b CODE_01DD95
	LDA.w !RAM_SIMC_City_CurrentWrightMessage
	CMP.w #$002F
	BNE.b CODE_01DDC1
	LDX.w #$0000
	LDY.w #$0060
CODE_01DDB2:
	LDA.w DATA_01DCB6,x
	STA.l SIMC_Global_PaletteMirror[$80].LowByte,x
	INX
	INX
	DEY
	BNE.b CODE_01DDB2
	JMP.w CODE_01DE00

CODE_01DDC1:
	LDX.w #$0100
	LDY.w #$0000
	LDA.w #$0040
	STA.b $79
CODE_01DDCC:
	LDA.w DATA_01DBF6,y
	INY
	INY
	STA.l SIMC_Global_PaletteMirror[$00].LowByte,x
	INX
	INX
	DEC.b $79
	BNE.b CODE_01DDCC
	LDX.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.w DATA_01DB62,x
	AND.w #$00FF
	BEQ.b CODE_01DE00
	LDX.w #$0180
	LDY.w #$0000
	LDA.w #$0020
	STA.b $79
CODE_01DDF1:
	LDA.w DATA_01DC76,y
	INY
	INY
	STA.l SIMC_Global_PaletteMirror[$00].LowByte,x
	INX
	INX
	DEC.b $79
	BNE.b CODE_01DDF1
CODE_01DE00:
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	LDA.b $BB
	ORA.w #$0002
	STA.b $BB
	RTS

CODE_01DE0D:
	JSR.w CODE_01DEC2
	JSR.w CODE_01DE54
	RTS

CODE_01DE14:
	JSR.w CODE_01DE4A
	JSR.w CODE_01DEA4
	JSR.w CODE_019E91
	JSR.w CODE_01E39A
	JSR.w CODE_01A8FF
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	RTS

CODE_01DE2B:
	JSR.w CODE_01DE4A
	JSR.w CODE_019E91
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	RTS

CODE_01DE39:
	SEP.b #$20
	LDA.b #$E8
	STA.b !RAM_SIMC_Global_FixedColorData
	LDA.b #$A3
	STA.b !RAM_SIMC_Global_ColorMathSelectAndEnable
	LDA.b #$00
	STA.b !RAM_SIMC_Global_ColorMathInitialSettings
	STA.b !RAM_SIMC_Global_SubScreenLayers
	RTS

CODE_01DE4A:
	SEP.b #$20
	LDA.b #$00
	STA.b !RAM_SIMC_Global_ColorMathSelectAndEnable
	JSR.w CODE_01A064
	RTS

CODE_01DE54:
	REP.b #$30
	LDA.w $01DF
	ASL
	TAX
	LDA.w DATA_009F1D,x
	PHA
	LDX.w #$0048
	LDY.w #$0000
CODE_01DE65:
	LDA.b ($01,S),y
	CMP.w #$8080
	BEQ.b CODE_01DE8B
	SEP.b #$20
	CLC
	ADC.b #$28
	XBA
	CLC
	ADC.b #$20
	REP.b #$20
	STA.l SIMC_Global_OAMBuffer[$00].XDisp,x
	INX
	INX
	INY
	INY
	LDA.b ($01,S),y
	STA.l SIMC_Global_OAMBuffer[$00].XDisp,x
	INX
	INX
	INY
	INY
	BRA.b CODE_01DE65

CODE_01DE8B:
	INY
	INY
	SEP.b #$20
	LDX.w #$0000
CODE_01DE92:
	LDA.b ($01,S),y
	CMP.b #$FF
	BEQ.b CODE_01DEA0
	STA.l SIMC_Global_UpperOAMBuffer[$04].Slot,x
	INY
	INX
	BRA.b CODE_01DE92

CODE_01DEA0:
	REP.b #$20
	PLA
	RTS

CODE_01DEA4:
	REP.b #$20
	LDA.w #$5555
	STA.l SIMC_Global_UpperOAMBuffer[$04].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$06].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$08].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$0A].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$0C].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$0E].Slot
	RTS

CODE_01DEC2:
	SEP.b #$20
	LDA.b #$55
	STA.l SIMC_Global_UpperOAMBuffer[$01].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$02].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$03].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$04].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$16].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$17].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$18].Slot
	LDA.l SIMC_Global_UpperOAMBuffer[$19].Slot
	AND.b #$F0
	ORA.b #$05
	STA.l SIMC_Global_UpperOAMBuffer[$19].Slot
	RTS

CODE_01DEEF:
	REP.b #$30
	LDA.w #$AAAA
	STA.l SIMC_Global_UpperOAMBuffer[$12].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$14].Slot
	RTS

CODE_01DEFD:
	RTS

CODE_01DEFE:
	JSR.w CODE_01DF7B
	JSL.l CODE_0097F4
CODE_01DF05:
	JSR.w CODE_01C8B7
	JSR.w CODE_01C817
	REP.b #$20
	LDA.w $020D
	STA.w $02AB
	STA.w $01E1
	JSL.l CODE_0084A9
	JSL.l CODE_00842A
	JSR.w CODE_018F25
	JSR.w CODE_01CAA6
	JSR.w CODE_01A8FF
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	RTS

CODE_01DF2F:
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	JSL.l CODE_008206
	SEP.b #$20
	REP.b #$10
	LDA.b #$01
	STA.w DMA[$01].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$01].Destination
	LDA.b #(DATA_06C000+$2800)>>16
	STA.w DMA[$01].SourceBank
	LDX.w #$7400
	STX.w !REGISTER_VRAMAddressLo
	LDX.w #DATA_06C000+$2800
	STX.w DMA[$01].SourceLo
	LDX.w #$0400
	STX.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	JSL.l CODE_0084A9
	JSL.l CODE_00842A
	JSR.w CODE_018F25
	RTS

CODE_01DF7B:
	SEP.b #$30
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	JSL.l CODE_008206
	STZ.w !REGISTER_VRAMAddressLo
	LDA.b #$60
	STA.w !REGISTER_VRAMAddressHi
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #DATA_06C000
	STA.w DMA[$00].SourceLo,x
	LDA.b #DATA_06C000>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #DATA_06C000>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$10
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_01DFC7
CODE_01DFC3:
	ASL
	DEX
	BNE.b CODE_01DFC3
CODE_01DFC7:
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	STZ.w !REGISTER_VRAMAddressLo
	LDA.b #$68
	STA.w !REGISTER_VRAMAddressHi
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #DATA_06C000+$1000
	STA.w DMA[$00].SourceLo,x
	LDA.b #(DATA_06C000+$1000)>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #(DATA_06C000+$1000)>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$10
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_01E00C
CODE_01E008:
	ASL
	DEX
	BNE.b CODE_01E008
CODE_01E00C:
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	STZ.w !REGISTER_VRAMAddressLo
	LDA.b #$70
	STA.w !REGISTER_VRAMAddressHi
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #DATA_06C000+$2000
	STA.w DMA[$00].SourceLo,x
	LDA.b #(DATA_06C000+$2000)>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #(DATA_06C000+$2000)>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$10
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_01E051
CODE_01E04D:
	ASL
	DEX
	BNE.b CODE_01E04D
CODE_01E051:
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	STZ.w !REGISTER_VRAMAddressLo
	LDA.b #$78
	STA.w !REGISTER_VRAMAddressHi
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #DATA_06C000+$3000
	STA.w DMA[$00].SourceLo,x
	LDA.b #(DATA_06C000+$3000)>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #(DATA_06C000+$3000)>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$10
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_01E096
CODE_01E092:
	ASL
	DEX
	BNE.b CODE_01E092
CODE_01E096:
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_00CADC
	JSL.l CODE_00CA9D
	REP.b #$30
	LDA.w $0B5B
	AND.w #$00FF
	BEQ.b CODE_01E0D5
	STA.w $041F
	LDA.w #$0008
	SEC
	SBC.w $041F
	LSR
	TAY
	LDX.w #$0001
	SEP.b #$20
CODE_01E0BC:
	LDA.w $0B5B,x
	PHX
	LDX.w #$0000
	PHY
	JSL.l CODE_00CD98
	SEP.b #$20
	REP.b #$10
	PLY
	PLX
	INX
	INY
	DEC.w $041F
	BNE.b CODE_01E0BC
CODE_01E0D5:
	JSR.w CODE_01E16C
	JSL.l CODE_008206
	SEP.b #$20
	REP.b #$10
	LDA.b #$01
	STA.w DMA[$01].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$01].Destination
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$01].SourceBank
	LDX.w #$7670
	STX.w !REGISTER_VRAMAddressLo
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer
	STX.w DMA[$01].SourceLo
	LDX.w #$0080
	STX.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	REP.b #$30
	LDA.b $3E
	LSR
	BCS.b CODE_01E163
	JSL.l CODE_00CA9D
	LDX.w #$0002
	LDY.w #$0001
	SEP.b #$20
CODE_01E119:
	LDA.w !RAM_SIMC_Global_MapNumOnesDigit,x
	PHX
	LDX.w #$0000
	PHY
	JSL.l CODE_00CD98
	SEP.b #$20
	REP.b #$10
	PLY
	PLX
	INY
	DEX
	BPL.b CODE_01E119
	JSR.w CODE_01E1A1
	JSR.w CODE_01E1D8
	JSL.l CODE_008206
	SEP.b #$20
	REP.b #$10
	LDA.b #$01
	STA.w DMA[$01].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$01].Destination
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$01].SourceBank
	LDX.w #$7990
	STX.w !REGISTER_VRAMAddressLo
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer
	STX.w DMA[$01].SourceLo
	LDX.w #$0040
	STX.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
CODE_01E163:
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	RTS

CODE_01E16C:
	SEP.b #$30
	LDA.b #$00
	STA.b $79
CODE_01E172:
	LDA.b $79
	ASL
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$08
	STA.b $7C
CODE_01E17E:
	LDA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$0001,x
	STA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$0010,x
	EOR.b #$FF
	STA.l !RAM_SIMC_Global_GeneralPurposeBuffer,x
	LDA.b #$00
	STA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$0001,x
	INX
	INX
	DEC.b $7C
	BNE.b CODE_01E17E
	INC.b $79
	LDA.b $79
	CMP.b #$04
	BCC.b CODE_01E172
	RTS

CODE_01E1A1:
	SEP.b #$30
	LDA.b #$00
	STA.b $79
CODE_01E1A7:
	LDA.b $79
	ASL
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$08
	STA.b $7C
CODE_01E1B3:
	LDA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$0001,x
	ORA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$0010,x
	PHA
	LDA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$0010,x
	STA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$0001,x
	PLA
	STA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$0010,x
	INX
	INX
	DEC.b $7C
	BNE.b CODE_01E1B3
	INC.b $79
	LDA.b $79
	CMP.b #$02
	BCC.b CODE_01E1A7
	RTS

CODE_01E1D8:
	SEP.b #$20
	REP.b #$10
	LDY.w #$0020
	LDX.w #$0000
CODE_01E1E2:
	LDA.l $06F320,x
	AND.b #$F0
	STA.b $79
	LDA.l !RAM_SIMC_Global_GeneralPurposeBuffer,x
	AND.b #$0F
	ORA.b $79
	STA.l !RAM_SIMC_Global_GeneralPurposeBuffer,x
	INX
	DEY
	BNE.b CODE_01E1E2
	RTS

CODE_01E1FB:
	REP.b #$30
	LDX.w #$0000
	LDY.w #$0110
CODE_01E203:
	LDA.l SIMC_Global_OAMBuffer[$00].XDisp,x
	STA.l !RAM_SIMC_Global_CopyOfOAMBuffer,x
	INX
	INX
	DEY
	BNE.b CODE_01E203
	RTS

CODE_01E211:
	REP.b #$30
	LDX.w #$0000
	LDY.w #$0110
CODE_01E219:
	LDA.l !RAM_SIMC_Global_CopyOfOAMBuffer,x
	STA.l SIMC_Global_OAMBuffer[$00].XDisp,x
	INX
	INX
	DEY
	BNE.b CODE_01E219
	RTS

DATA_01E227:
	dw $0920,$0921,$0921,$0921,$0921,$0921,$0921,$0921
	dw $0921,$0921,$0921,$0921,$0921,$0921,$0921,$0921
	dw $0921,$0921,$0921,$0921,$0921,$0921,$0921,$0921
	dw $0921,$0921,$0921,$0921,$0921,$0123

DATA_01E263:
	dw $0930,$0131,$0131,$0131,$0131,$0131,$0131,$0131
	dw $0131,$0131,$0131,$0131,$0131,$0131,$0131,$0131
	dw $0131,$0131,$0131,$0131,$0131,$0131,$0131,$0131
	dw $0131,$0131,$0131,$0131,$0131,$0133

DATA_01E29F:
	dw $0940,$0141,$0141,$0141,$0141,$0141,$0141,$0141
	dw $0141,$0141,$0141,$0141,$0141,$0141,$0141,$0141
	dw $0141,$0141,$0141,$0141,$0141,$0141,$0141,$0141
	dw $0141,$0141,$0141,$0141,$0141,$0143

DATA_01E2DB:
	dw $0920,$0921,$0921,$0921,$0921,$0921,$0921,$0921
	dw $0921,$0921,$0921,$0921,$0921,$0921,$0921,$0921
	dw $0921,$0123

DATA_01E2FF:
	dw $0930,$0131,$0131,$0131,$0131,$0131,$0131,$0131
	dw $0131,$0131,$0131,$0131,$0131,$0131,$0131,$0131
	dw $0131,$0133

DATA_01E323:
	dw $0940,$0141,$0141,$0141,$0141,$0141,$0141,$0141
	dw $0141,$0141,$0141,$0141,$0141,$0141,$0141,$0141
	dw $0141,$0143

CODE_01E347:
	JSR.w CODE_01B417
	REP.b #$30
	LDA.w #$003C
	STA.b $79
	LDA.w #DATA_01E227
	STA.b $7C
	LDA.w #DATA_01E263
	STA.b $7F
	LDA.w #DATA_01E29F
	STA.b $82
	PHB
	LDX.b $7C
	LDY.w #!RAM_SIMC_Global_Layer3TilemapBuffer+$0042
	LDA.b $79
	DEC
	MVN (!RAM_SIMC_Global_Layer3TilemapBuffer+$0042)>>16,DATA_01E227>>16
	LDX.b $7F
	LDY.w #!RAM_SIMC_Global_Layer3TilemapBuffer+$0082
	LDA.b $79
	DEC
	MVN (!RAM_SIMC_Global_Layer3TilemapBuffer+$0082)>>16,DATA_01E263>>16
	LDX.b $7F
	LDY.w #!RAM_SIMC_Global_Layer3TilemapBuffer+$00C2
	LDA.b $79
	DEC
	MVN (!RAM_SIMC_Global_Layer3TilemapBuffer+$00C2)>>16,DATA_01E263>>16
	LDX.b $7F
	LDY.w #!RAM_SIMC_Global_Layer3TilemapBuffer+$0102
	LDA.b $79
	DEC
	MVN (!RAM_SIMC_Global_Layer3TilemapBuffer+$0102)>>16,DATA_01E263>>16
	LDX.b $82
	LDY.w #!RAM_SIMC_Global_Layer3TilemapBuffer+$0142
	LDA.b $79
	DEC
	MVN (!RAM_SIMC_Global_Layer3TilemapBuffer+$0142)>>16,DATA_01E29F>>16
	PLB
	RTS

CODE_01E39A:
	JSR.w CODE_01B417
	REP.b #$30
	LDA.w #$0024
	STA.b $79
	LDA.w #DATA_01E2DB
	STA.b $7C
	LDA.w #DATA_01E2FF
	STA.b $7F
	LDA.w #DATA_01E323
	STA.b $82
	PHB
	LDX.b $7C
	LDY.w #!RAM_SIMC_Global_Layer3TilemapBuffer+$0082
	LDA.b $79
	DEC
	MVN (!RAM_SIMC_Global_Layer3TilemapBuffer+$0082)>>16,DATA_01E2DB>>16
	LDX.b $7F
	LDY.w #!RAM_SIMC_Global_Layer3TilemapBuffer+$00C2
	LDA.b $79
	DEC
	MVN (!RAM_SIMC_Global_Layer3TilemapBuffer+$00C2)>>16,DATA_01E2FF>>16
	LDX.b $7F
	LDY.w #!RAM_SIMC_Global_Layer3TilemapBuffer+$0102
	LDA.b $79
	DEC
	MVN (!RAM_SIMC_Global_Layer3TilemapBuffer+$0102)>>16,DATA_01E2FF>>16
	LDX.b $82
	LDY.w #!RAM_SIMC_Global_Layer3TilemapBuffer+$0142
	LDA.b $79
	DEC
	MVN (!RAM_SIMC_Global_Layer3TilemapBuffer+$0142)>>16,DATA_01E323>>16
	PLB
	RTS

DATA_01E3E2:
	db $00,$00,$00,$00,$00,$00,$02,$01,$00,$02,$01,$01,$01,$02

CODE_01E3F0:
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_09D650
	STX.b $09
	LDA.b #DATA_09D650>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	REP.b #$30
	LDA.w !RAM_SIMC_City_CurrentWrightMessage
	CMP.w #$002F
	BNE.b CODE_01E42E
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0A9C34
	STX.b $09
	LDA.b #DATA_0A9C34>>16
	STA.b $0B
	LDX.w #$2000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	BRA.b CODE_01E48C

CODE_01E42E:
	LDX.w $039F
	LDA.l DATA_01E3E2,x
	AND.w #$00FF
	BNE.b CODE_01E455
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_09EBC1
	STX.b $09
	LDA.b #DATA_09EBC1>>16
	STA.b $0B
	LDX.w #$2000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	BRA.b CODE_01E48C

CODE_01E455:
	DEC
	BNE.b CODE_01E473
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0A81E9
	STX.b $09
	LDA.b #DATA_0A81E9>>16
	STA.b $0B
	LDX.w #$2000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	BRA.b CODE_01E48C

CODE_01E473:
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0A8F68
	STX.b $09
	LDA.b #DATA_0A8F68>>16
	STA.b $0B
	LDX.w #$2000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
CODE_01E48C:
	SEP.b #$20
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$30
	LDA.w #$6000
	STA.b $79
	LDA.w #!RAM_SIMC_Global_GeneralPurposeBuffer
	STA.b $7C
	LDX.w #$0000
CODE_01E4A5:
	PHX
	JSL.l CODE_008206
	SEP.b #$20
	LDA.b #$01
	STA.w DMA[$01].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$01].Destination
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$01].SourceBank
	LDX.b $79
	STX.w !REGISTER_VRAMAddressLo
	LDX.b $7C
	STX.w DMA[$01].SourceLo
	LDX.w #$1000
	STX.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	REP.b #$20
	LDA.b $79
	CLC
	ADC.w #$0800
	STA.b $79
	LDA.b $7C
	CLC
	ADC.w #$1000
	STA.b $7C
	PLX
	INX
	CPX.w #$0004
	BNE.b CODE_01E4A5
	STZ.w $039D
	JSR.w CODE_01E544
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	REP.b #$20
	RTS

DATA_01E4FA:
	dw !RAM_SIMC_Global_GeneralPurposeBuffer,!RAM_SIMC_Global_GeneralPurposeBuffer+$0800,!RAM_SIMC_Global_GeneralPurposeBuffer+$1000,!RAM_SIMC_Global_GeneralPurposeBuffer+$1800

DATA_01E502:
	db $00,$00,$00,$00,$00,$00,$02,$00,$00,$02,$00,$00,$00,$02

DATA_01E510:
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$02,$02,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $01,$02,$01,$02,$03,$00,$00,$00,$00,$00,$00,$00,$00,$02,$00,$00
	db $03,$00,$00,$00

CODE_01E544:
	REP.b #$30
	LDX.w $039F
	LDA.l DATA_01E502,x
	AND.w #$00FF
	BEQ.b CODE_01E55B
	INC.w $0B59
	DEC
	STA.w $03F1
	BRA.b CODE_01E568

CODE_01E55B:
	LDX.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.l DATA_01E510,x
	AND.w #$00FF
	STA.w $03F1
CODE_01E568:
	JSL.l CODE_00982B
	PHK
	PLB
	REP.b #$30
	LDA.w $03F1
	ASL
	TAY
	LDX.w DATA_01E4FA,y
	LDY.w #!RAM_SIMC_Global_Layer3TilemapBuffer
	LDA.w #$0800
	MVN !RAM_SIMC_Global_Layer3TilemapBuffer>>16,!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	SEP.b #$20
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$30
	LDA.w !RAM_SIMC_City_CurrentWrightMessage
	ASL
	TAX
	LDA.l DATA_0FA800,x
	TAX
	LDY.w #$0000
CODE_01E59F:
	LDA.w #$0018
	STA.b $79
CODE_01E5A4:
	LDA.l DATA_0FA868&$FF0000,x
	AND.w #$00FF
	CMP.w #$00FF
	BEQ.b CODE_01E5C9
	ORA.w #$0800
	PHX
	TYX
	STA.l !RAM_SIMC_Global_Layer3TilemapBuffer+$0108,x
	PLX
	INX
	INY
	INY
	DEC.b $79
	BNE.b CODE_01E5A4
	TYA
	CLC
	ADC.w #$0010
	TAY
	BRA.b CODE_01E59F

CODE_01E5C9:
	SEP.b #$20
	JSL.l CODE_008206
	LDA.b #$01
	STA.w DMA[$01].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$01].Destination
	LDA.b #!RAM_SIMC_Global_Layer3TilemapBuffer>>16
	STA.w DMA[$01].SourceBank
	LDX.w #$5400
	STX.w !REGISTER_VRAMAddressLo
	LDX.w #!RAM_SIMC_Global_Layer3TilemapBuffer
	STX.w DMA[$01].SourceLo
	LDX.w #$0800
	STX.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	RTS

CODE_01E5FE:
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_09C0FB
	STX.b $09
	LDA.b #DATA_09C0FB>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	JSL.l CODE_008206
	SEP.b #$20
	REP.b #$10
	LDA.b #$01
	STA.w DMA[$01].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$01].Destination
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$01].SourceBank
	LDX.w #$4000
	STX.w !REGISTER_VRAMAddressLo
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer
	STX.w DMA[$01].SourceLo
	LDX.w #$1000
	STX.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	SEP.b #$20
	REP.b #$10
	LDX.w #$4800
	STX.w !REGISTER_VRAMAddressLo
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$1000
	STX.w DMA[$01].SourceLo
	LDX.w #$1000
	STX.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_0097F4
	JSR.w CODE_01A8FF
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	RTS

CODE_01E67D:
	SEP.b #$20
	LDA.b #$00
	STA.b $79
CODE_01E683:
	LDA.b #$80
	SEC
	SBC.b $79
	STA.w !REGISTER_Window1LeftPositionDesignation
	LDA.b #$80
	CLC
	ADC.b $79
	STA.w !REGISTER_Window1RightPositionDesignation
	LDA.b $79
	CLC
	ADC.b #$04
	STA.b $79
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	SEP.b #$20
	LDA.b $79
	CMP.b #$69
	BCC.b CODE_01E683
	LDA.b #$00
	STA.b !RAM_SIMC_Global_BG3And4WindowMaskSettings
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	RTS

CODE_01E6B5:
	SEP.b #$20
	LDA.b #$68
	STA.b $79
CODE_01E6BB:
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	SEP.b #$20
	LDA.b #$80
	SEC
	SBC.b $79
	STA.w !REGISTER_Window1LeftPositionDesignation
	LDA.b #$80
	CLC
	ADC.b $79
	STA.w !REGISTER_Window1RightPositionDesignation
	LDA.b $79
	SEC
	SBC.b #$04
	STA.b $79
	BPL.b CODE_01E6BB
	LDA.b #$FF
	STA.w !REGISTER_Window1LeftPositionDesignation
	RTS

DATA_01E6E3:
	dw DATA_01E6FF,DATA_01E6FF,DATA_01E6FF,DATA_01E707,DATA_01E70F,DATA_01E707,DATA_01E71F,DATA_01E6FF
	dw DATA_01E717,DATA_01E71F,DATA_01E6FF,DATA_01E6FF,DATA_01E727,DATA_01E71F

DATA_01E6FF:
	dw $0106,$0097,$0104,$0097

DATA_01E707:
	dw $0092,$0097,$0000,$0000

DATA_01E70F:
	dw $0108,$0097,$0108,$0097

DATA_01E717:
	dw $010A,$0097,$00F8,$00AD

DATA_01E71F:
	dw $0088,$0094,$0088,$0090

DATA_01E727:
	dw $0104,$0099,$0102,$0097

CODE_01E72F:
	REP.b #$30
	LDA.w !RAM_SIMC_City_CurrentWrightMessage
	CMP.w #$002F
	BNE.b CODE_01E73E
	JSL.l CODE_03F245
	RTS

CODE_01E73E:
	LDA.w $039F
	ASL
	TAX
	LDA.l DATA_01E6E3,x
	PHA
	PHK
	PLB
	LDX.w #$0002
CODE_01E74D:
	CPX.w #$0002
	BNE.b CODE_01E757
	LDA.w #$00FF
	BRA.b CODE_01E75A

CODE_01E757:
	LDA.w #$FFFF
CODE_01E75A:
	STA.w $02D7,x
	STA.w $02E7,x
	STZ.w $02F7,x
	STZ.w $0307,x
	STZ.w $0317,x
	STZ.w $0327,x
	STZ.w $0357,x
	STZ.w $0367,x
	STZ.w $02C7,x
	TXA
	ASL
	TAY
	LDA.b ($01,S),y
	INY
	INY
	STA.w $0337,x
	LDA.b ($01,S),y
	STA.w $0347,x
	DEX
	DEX
	BPL.b CODE_01E74D
	PLA
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	LDA.w #$000B
	STA.w $037B
	STZ.w $037D
	JSR.w CODE_01ECA3
	RTS

DATA_01E79B:
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$02,$10,$03,$04,$00
	db $06,$07,$08,$09,$0A,$00,$0B,$0C,$0D,$0E,$0F,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$00,$00,$00
	db $00,$00,$00,$00

CODE_01E7CF:
	REP.b #$30
	LDX.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.l DATA_01E79B,x
	AND.w #$00FF
	BNE.b CODE_01E7DE
	RTS

CODE_01E7DE:
	PHA
	JSR.w CODE_01CD68
	REP.b #$30
	PLA
	LDX.w !RAM_SIMC_City_CurrentWrightMessage
	CPX.w #$000D
	BEQ.b CODE_01E7F5
	LDX.w #$0000
	JSR.w CODE_01CEBC
	BRA.b CODE_01E807

CODE_01E7F5:
	LDA.w #$0003
	LDX.w #$0000
	JSR.w CODE_01CEBC
	LDA.w #$0005
	LDX.w #$0001
	JSR.w CODE_01CEBC
CODE_01E807:
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	JSL.l CODE_008206
	SEP.b #$20
	REP.b #$10
	LDA.b #$01
	STA.w DMA[$01].Parameters
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$01].Destination
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$01].SourceBank
	LDX.w #$7C00
	STX.w !REGISTER_VRAMAddressLo
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer
	STX.w DMA[$01].SourceLo
	LDX.w #$0800
	STX.w DMA[$01].SizeLo
	LDA.b #$02
	STA.w !REGISTER_DMAEnable
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	RTS

DATA_01E848:
	dw DATA_01E868,DATA_01E868,DATA_01E879,DATA_01E868,DATA_01E879,DATA_01E868,DATA_01E868,DATA_01E868
	dw DATA_01E868,DATA_01E868,DATA_01E868,DATA_01E868,DATA_01E868,DATA_01E868,DATA_01E868,DATA_01E868

DATA_01E868:
	db $48,$87,$C0,$39,$58,$87,$C2,$39,$48,$97,$E0,$39,$58,$97,$E2,$39
	db $FF

DATA_01E879:
	db $20,$87,$C0,$39,$30,$87,$C2,$39,$20,$97,$E0,$39,$30,$97,$E2,$39
	db $48,$87,$C4,$39,$58,$87,$C6,$39,$48,$97,$E4,$39,$58,$97,$E6,$39
	db $FF

CODE_01E89A:
	REP.b #$30
	LDX.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.l DATA_01E79B,x
	AND.w #$00FF
	BNE.b CODE_01E8A9
	RTS

CODE_01E8A9:
	DEC
	ASL
	TAX
	LDA.l DATA_01E848,x
	PHA
	PHK
	PLB
	SEP.b #$20
	LDX.w #$0000
	TXY
CODE_01E8B9:
	LDA.b ($01,S),y
	CMP.b #$FF
	BEQ.b CODE_01E8C7
	STA.l SIMC_Global_OAMBuffer[$78].XDisp,x
	INX
	INY
	BRA.b CODE_01E8B9

CODE_01E8C7:
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	REP.b #$20
	PLA
	LDA.w !RAM_SIMC_City_CurrentWrightMessage
	CMP.w #$000D
	BEQ.b CODE_01E8DF
	LDA.w #$55AA
	STA.l SIMC_Global_UpperOAMBuffer[$1E].Slot
	RTS

CODE_01E8DF:
	LDA.w #$AAAA
	STA.l SIMC_Global_UpperOAMBuffer[$1E].Slot
	RTS

DATA_01E8E7:
	db $2C,$54

CODE_01E8E9:
	REP.b #$30
	LDA.w !RAM_SIMC_City_CurrentWrightMessage
	CMP.w #$000D
	BEQ.b CODE_01E8F4
	RTS

CODE_01E8F4:
	LDA.b $C9
	AND.w #$0F00
	BEQ.b CODE_01E913
	PHP
	JSL.l CODE_0098A0	: dw $0703
	PLP
	REP.b #$30
	LDA.w $037F
	BNE.b CODE_01E910
	INC
	STA.w $037F
	BRA.b CODE_01E913

CODE_01E910:
	STZ.w $037F
CODE_01E913:
	LDX.w $037F
	LDA.l DATA_01E8E7,x
	AND.w #$00FF
	ORA.w #$9400
	STA.l SIMC_Global_OAMBuffer[$38].XDisp
	LDA.w #$3982
	STA.l SIMC_Global_OAMBuffer[$38].Tile
	SEP.b #$20
	LDA.b #$56
	STA.l SIMC_Global_UpperOAMBuffer[$0E].Slot
	RTS

CODE_01E934:
	REP.b #$20
	LDA.w !RAM_SIMC_City_CurrentWrightMessage
	CMP.w #$0024
	BNE.b CODE_01E95A
	LDA.w #$00C8
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w #$00A8
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$01C0
	STA.w $0253
	LDA.w #$003E
	STA.w $0261
	JSL.l CODE_009058
CODE_01E95A:
	RTS

CODE_01E95B:
	REP.b #$20
	LDA.w !RAM_SIMC_City_CurrentWrightMessage
	CMP.w #$002E
	BNE.b CODE_01E981
	LDA.w #$0044
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w #$0083
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$01C0
	STA.w $0253
	LDA.w #$003F
	STA.w $0261
	JSL.l CODE_009058
CODE_01E981:
	RTS

CODE_01E982:
	REP.b #$20
	LDA.w !RAM_SIMC_City_CurrentWrightMessage
	CMP.w #$001C
	BNE.b CODE_01E9A8
	LDA.w #$001E
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w #$0031
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$01C0
	STA.w $0253
	LDA.w #$004E
	STA.w $0261
	JSL.l CODE_009058
CODE_01E9A8:
	RTS

DATA_01E9A9:
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$02,$02,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $01,$00,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00

DATA_01E9DD:
	dw DATA_01E9E9,DATA_01E9EF,DATA_01E9F5,DATA_01E9FB,DATA_01EA01,DATA_01EA01

DATA_01E9E9:
	dw $0058,$0088,$FFFF

DATA_01E9EF:
	dw $0050,$0080,$FFFF

DATA_01E9F5:
	dw $0060,$0080,$FFFF

DATA_01E9FB:
	dw $0048,$0080,$FFFF

DATA_01EA01:
	dw $0058,$0080,$FFFF

DATA_01EA07:
	dw DATA_01EA13,DATA_01EA1D,DATA_01EA27,DATA_01EA35,DATA_01EA43,DATA_01EA51

DATA_01EA13:
	dw $0054,$0088,$00B0,$0090,$FFFF

DATA_01EA1D:
	dw $0050,$0080,$00D0,$0080,$FFFF

DATA_01EA27:
	dw $0060,$0080,$00A8,$0080,$00C8,$0088,$FFFF

DATA_01EA35:
	dw $0048,$0080,$0060,$0090,$00B8,$0080,$FFFF

DATA_01EA43:
	dw $0058,$0080,$00A0,$0088,$00B8,$0080,$FFFF

DATA_01EA51:
	dw $0058,$0080,$0088,$0080,$00C8,$0080,$FFFF

CODE_01EA5F:
	REP.b #$30
	LDX.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.l DATA_01E9A9,x
	AND.w #$00FF
	BNE.b CODE_01EA6E
	RTS

CODE_01EA6E:
	DEC
	BEQ.b CODE_01EA74
	JMP.w CODE_01EAD4

CODE_01EA74:
	LDA.w $0CA5
	ASL
	TAX
	LDA.l DATA_01E9DD,x
	PHA
	LDY.w #$0000
	LDA.w #$01C0
	STA.w $0253
CODE_01EA87:
	PHK
	PLB
	LDA.b ($01,S),y
	BMI.b CODE_01EAB2
	INY
	INY
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.b ($01,S),y
	INY
	INY
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w $037D
	CLC
	ADC.w #$003B
	STA.w $0261
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	PHX
	PHY
	JSL.l CODE_009058
	PLY
	PLX
	BRA.b CODE_01EA87

CODE_01EAB2:
	PLA
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	DEC.w $037B
	BEQ.b CODE_01EABE
	RTS

CODE_01EABE:
	LDA.w #$000B
	STA.w $037B
	LDA.w $037D
	INC
	CMP.w #$0003
	BCC.b CODE_01EAD0
	LDA.w #$0000
CODE_01EAD0:
	STA.w $037D
	RTS

CODE_01EAD4:
	LDA.w $0CA5
	ASL
	TAX
	LDA.l DATA_01EA07,x
	PHA
	LDY.w #$0000
	LDA.w #$01C0
	STA.w $0253
CODE_01EAE7:
	PHK
	PLB
	LDA.b ($01,S),y
	BMI.b CODE_01EAB2
	INY
	INY
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.b ($01,S),y
	INY
	INY
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w $037D
	CLC
	ADC.w #$003B
	STA.w $0261
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	PHX
	PHY
	JSL.l CODE_009058
	PLY
	PLX
	BRA.b CODE_01EAE7

CODE_01EB12:
	REP.b #$30
	LDX.w #$001E
	LDA.w #$5555
CODE_01EB1A:
	STA.l SIMC_Global_UpperOAMBuffer[$00].Slot,x
	DEX
	DEX
	BPL.b CODE_01EB1A
	LDA.w !RAM_SIMC_City_CurrentWrightMessage
	CMP.w #$002F
	BNE.b CODE_01EB2F
	JSL.l CODE_03F2AB
	RTS

CODE_01EB2F:
	LDA.w $0377
	AND.w #$00FF
	ASL
	TAY
CODE_01EB37:
	REP.b #$20
	LDA.w $02C7,y
	BEQ.b CODE_01EB41
	JMP.w CODE_01EC8D

CODE_01EB41:
	LDA.w $0317,y
	BEQ.b CODE_01EB49
	JMP.w CODE_01EBB3

CODE_01EB49:
	LDA.w $02E7,y
	INC
CODE_01EB4D:
	STA.w $02E7,y
	ASL
	TAX
	LDA.l !RAM_SIMC_Global_GeneralPurposeBuffer,x
	CMP.w #$FFFF
	BNE.b CODE_01EB61
	STA.w $02C7,y
	JMP.w CODE_01EBEE

CODE_01EB61:
	CMP.w #$FFFE
	BNE.b CODE_01EB78
	INX
	INX
	LDA.l !RAM_SIMC_Global_GeneralPurposeBuffer,x
	ASL
	STA.b $79
	INX
	INX
	TXA
	SEC
	SBC.b $79
	LSR
	BRA.b CODE_01EB4D

CODE_01EB78:
	CMP.w #$FFFD
	BNE.b CODE_01EBA9
	INX
	INX
	LDA.l !RAM_SIMC_Global_GeneralPurposeBuffer,x
	ASL
	STA.b $79
	INX
	INX
	LDA.w $0357,y
	BNE.b CODE_01EB94
	LDA.l !RAM_SIMC_Global_GeneralPurposeBuffer,x
	STA.w $0357,y
CODE_01EB94:
	LDA.w $0357,y
	DEC
	STA.w $0357,y
	BEQ.b CODE_01EBA4
	TXA
	SEC
	SBC.b $79
	LSR
	BRA.b CODE_01EB4D

CODE_01EBA4:
	INX
	INX
	TXA
	BRA.b CODE_01EB4D

CODE_01EBA9:
	STA.w $0317,y
	LDA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$0400,x
	STA.w $0327,y
CODE_01EBB3:
	LDA.w $0317,y
	DEC
	STA.w $0317,y
	LDA.w $0327,y
	PHA
	PHP
	SEP.b #$20
	XBA
	REP.b #$20
	PLP
	BMI.b CODE_01EBCC
	AND.w #$00FF
	BRA.b CODE_01EBCF

CODE_01EBCC:
	ORA.w #$FF00
CODE_01EBCF:
	CLC
	ADC.w $0337,y
	STA.w $0337,y
	PLA
	SEP.b #$20
	AND.b #$FF
	REP.b #$20
	BMI.b CODE_01EBE4
	AND.w #$00FF
	BRA.b CODE_01EBE7

CODE_01EBE4:
	ORA.w #$FF00
CODE_01EBE7:
	CLC
	ADC.w $0347,y
	STA.w $0347,y
CODE_01EBEE:
	LDA.w $0307,y
	BNE.b CODE_01EC5E
	LDA.w $02D7,y
	INC
CODE_01EBF7:
	STA.w $02D7,y
	ASL
	TAX
	LDA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$0C00,x
	CMP.w #$FFFF
	BNE.b CODE_01EC0B
	STA.w $02C7,y
	JMP.w CODE_01EC8D

CODE_01EC0B:
	CMP.w #$FFFE
	BNE.b CODE_01EC22
	INX
	INX
	LDA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$0C00,x
	INX
	INX
	ASL
	STA.b $79
	TXA
	SEC
	SBC.b $79
	LSR
	BRA.b CODE_01EBF7

CODE_01EC22:
	CMP.w #$FFFD
	BNE.b CODE_01EC54
	INX
	INX
	LDA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$0C00,x
	INX
	INX
	ASL
	STA.b $79
	LDA.w $0367,y
	BNE.b CODE_01EC3E
	LDA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$0C00,x
	STA.w $0367,y
CODE_01EC3E:
	LDA.w $0367,y
	DEC
	STA.w $0367,y
	BEQ.b CODE_01EC4E
	TXA
	SEC
	SBC.b $79
	LSR
	BRA.b CODE_01EBF7

CODE_01EC4E:
	INX
	INX
	TXA
	LSR
	BRA.b CODE_01EBF7

CODE_01EC54:
	STA.w $0307,y
	LDA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$0800,x
	STA.w $02F7,y
CODE_01EC5E:
	LDA.w $0307,y
	DEC
	STA.w $0307,y
	LDA.w $02F7,y
	STA.w $0261
	TYA
	BNE.b CODE_01EC73
	LDA.w #$0000
	BRA.b CODE_01EC76

CODE_01EC73:
	LDA.w #$00F0
CODE_01EC76:
	STA.w $0253
	LDA.w $0337,y
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w $0347,y
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	PHY
	JSL.l CODE_009058
	REP.b #$30
	PLY
CODE_01EC8D:
	DEY
	DEY
	BMI.b CODE_01EC94
	JMP.w CODE_01EB37

CODE_01EC94:
	RTS

DATA_01EC95:
	db $00,$00,$00,$00,$01,$00,$06,$00,$02,$03,$04,$00,$05,$07

CODE_01ECA3:
	REP.b #$30
	LDA.w $039F
	ASL
	TAX
	PHA
	LDA.l DATA_02BF3B,x
	PHA
	LDY.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$0400
	LDA.l DATA_02BFAB,x
	DEC
	PLX
	MVN (!RAM_SIMC_Global_GeneralPurposeBuffer+$0400)>>16,DATA_02C07B>>16
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	PLX
	PHX
	LDA.l DATA_02BF57,x
	PHA
	LDY.w #!RAM_SIMC_Global_GeneralPurposeBuffer
	LDA.l DATA_02BFC7,x
	DEC
	PLX
	MVN !RAM_SIMC_Global_GeneralPurposeBuffer>>16,DATA_02C07F>>16
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	PLX
	PHX
	LDA.l DATA_02BF03,x
	PHA
	LDY.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$0800
	LDA.l DATA_02BF73,x
	DEC
	PLX
	MVN (!RAM_SIMC_Global_GeneralPurposeBuffer+$0800)>>16,DATA_02BFE3>>16
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	PLX
	LDA.l DATA_02BF1F,x
	PHA
	LDY.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$0C00
	LDA.l DATA_02BF8F,x
	DEC
	PLX
	MVN (!RAM_SIMC_Global_GeneralPurposeBuffer+$0C00)>>16,DATA_02C02D>>16
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	LDX.w $039F
	LDA.l DATA_01EC95,x
	AND.w #$00FF
	BEQ.b CODE_01ED75
	DEC
	ASL
	TAX
	PHA
	LDA.l DATA_02CACD,x
	PHA
	LDY.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$0600
	LDA.l DATA_02CB05,x
	DEC
	PLX
	MVN (!RAM_SIMC_Global_GeneralPurposeBuffer+$0600)>>16,DATA_02CB05>>16
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	PLX
	PHX
	LDA.l DATA_02CADB,x
	PHA
	LDY.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$0200
	LDA.l DATA_02CB13,x
	DEC
	PLX
	MVN (!RAM_SIMC_Global_GeneralPurposeBuffer+$0200)>>16,DATA_02CB13>>16
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	PLX
	PHX
	LDA.l DATA_02CAB1,x
	PHA
	LDY.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$0A00
	LDA.l DATA_02CAE9,x
	DEC
	PLX
	MVN (!RAM_SIMC_Global_GeneralPurposeBuffer+$0A00)>>16,DATA_02CAE9>>16
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	PLX
	LDA.l DATA_02CABF,x
	PHA
	LDY.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$0E00
	LDA.l DATA_02CAF7,x
	DEC
	PLX
	MVN (!RAM_SIMC_Global_GeneralPurposeBuffer+$0E00)>>16,DATA_02CAF7>>16
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
CODE_01ED75:
	RTS

CODE_01ED76:
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	SEP.b #$30
	JSL.l CODE_008206
	REP.b #$20
	LDA.w #$6000
	STA.w !REGISTER_VRAMAddressLo
	SEP.b #$20
	SEP.b #$30
	LDA.b #$01
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #DATA_06C000
	STA.w DMA[$00].SourceLo,x
	LDA.b #DATA_06C000>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #DATA_06C000>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$10
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$01
	BEQ.b CODE_01EDC6
CODE_01EDC2:
	ASL
	DEX
	BNE.b CODE_01EDC2
CODE_01EDC6:
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	REP.b #$20
	LDA.w #$6800
	STA.w !REGISTER_VRAMAddressLo
	SEP.b #$20
	SEP.b #$30
	LDA.b #$01
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #DATA_06C000+$1000
	STA.w DMA[$00].SourceLo,x
	LDA.b #(DATA_06C000+$1000)>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #(DATA_06C000+$1000)>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$10
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$01
	BEQ.b CODE_01EE0D
CODE_01EE09:
	ASL
	DEX
	BNE.b CODE_01EE09
CODE_01EE0D:
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	REP.b #$20
	LDA.w #$7000
	STA.w !REGISTER_VRAMAddressLo
	SEP.b #$20
	SEP.b #$30
	LDA.b #$01
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #DATA_06C000+$2000
	STA.w DMA[$00].SourceLo,x
	LDA.b #(DATA_06C000+$2000)>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #(DATA_06C000+$2000)>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$10
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$01
	BEQ.b CODE_01EE54
CODE_01EE50:
	ASL
	DEX
	BNE.b CODE_01EE50
CODE_01EE54:
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	REP.b #$20
	LDA.w #$7800
	STA.w !REGISTER_VRAMAddressLo
	SEP.b #$20
	SEP.b #$30
	LDA.b #$01
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #DATA_06C000+$3000
	STA.w DMA[$00].SourceLo,x
	LDA.b #(DATA_06C000+$3000)>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #(DATA_06C000+$3000)>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$10
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$01
	BEQ.b CODE_01EE9B
CODE_01EE97:
	ASL
	DEX
	BNE.b CODE_01EE97
CODE_01EE9B:
	STA.w !REGISTER_DMAEnable
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	RTS

CODE_01EEA7:
	SEP.b #$20
	LDA.b #$03
	STA.b !RAM_SIMC_Global_SubScreenWindowMask
	LDA.b #$88
	STA.b !RAM_SIMC_Global_BG1And2WindowMaskSettings
	RTS

DATA_01EEB2:
	dw $01B4,$01C4,$01D4,$01DC,$01EC,$01F0

DATA_01EEBE:
	db $AA,$FE,$AB,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$BA,$AA,$AA
	db $AA

CODE_01EECF:
	SEP.b #$20
	REP.b #$10
	LDY.w #$0000
	LDA.w $01F8
	BEQ.b CODE_01EEE4
	DEC
	STA.w $01F8
	BNE.b CODE_01EEE4
	STZ.w $01F7
CODE_01EEE4:
	RTS

CODE_01EEE5:
	REP.b #$10
	LDY.w #$0000
	BRA.b CODE_01EEF1

CODE_01EEEC:
	REP.b #$10
	LDY.w #$0001
CODE_01EEF1:
	REP.b #$20
	LDX.w #$000A
CODE_01EEF6:
	LDA.w $0A8B,x
	BEQ.b CODE_01EF3D
	PHX
	PHY
	LDA.l DATA_01EEB2,x
	TAX
	CPY.w #$0001
	BNE.b CODE_01EF08
	INX
CODE_01EF08:
	LDY.w #$0004
	CPX.w #$01D4
	BEQ.b CODE_01EF24
	CPX.w #$01D5
	BEQ.b CODE_01EF24
	CPX.w #$01EC
	BEQ.b CODE_01EF1F
	CPX.w #$01ED
	BNE.b CODE_01EF27
CODE_01EF1F:
	LDY.w #$0001
	BRA.b CODE_01EF27

CODE_01EF24:
	LDY.w #$0002
CODE_01EF27:
	SEP.b #$20
	LDA.l SIMC_Global_OAMBuffer[$00].XDisp,x
	CLC
	ADC.b #$02
	STA.l SIMC_Global_OAMBuffer[$00].XDisp,x
	INX
	INX
	INX
	INX
	DEY
	BNE.b CODE_01EF27
	PLY
	PLX
CODE_01EF3D:
	DEX
	DEX
	BPL.b CODE_01EEF6
	RTS

CODE_01EF42:
	REP.b #$10
	LDY.w #$0000
	BRA.b CODE_01EF4E

CODE_01EF49:
	REP.b #$10
	LDY.w #$0001
CODE_01EF4E:
	REP.b #$30
	LDX.w #$000A
CODE_01EF53:
	LDA.w $0A8B,x
	BEQ.b CODE_01EF9A
	PHX
	PHY
	LDA.l DATA_01EEB2,x
	TAX
	CPY.w #$0001
	BNE.b CODE_01EF65
	INX
CODE_01EF65:
	LDY.w #$0004
	CPX.w #$01D4
	BEQ.b CODE_01EF81
	CPX.w #$01D5
	BEQ.b CODE_01EF81
	CPX.w #$01EC
	BEQ.b CODE_01EF7C
	CPX.w #$01ED
	BNE.b CODE_01EF84
CODE_01EF7C:
	LDY.w #$0001
	BRA.b CODE_01EF84

CODE_01EF81:
	LDY.w #$0002
CODE_01EF84:
	SEP.b #$20
	LDA.l SIMC_Global_OAMBuffer[$00].XDisp,x
	SEC
	SBC.b #$02
	STA.l SIMC_Global_OAMBuffer[$00].XDisp,x
	INX
	INX
	INX
	INX
	DEY
	BNE.b CODE_01EF84
	PLY
	PLX
CODE_01EF9A:
	DEX
	DEX
	BPL.b CODE_01EF53
	RTS

CODE_01EF9F:
	REP.b #$30
	LDA.b $D7
	CMP.w #$0001
	BEQ.b CODE_01EFA9
	RTS

CODE_01EFA9:
	LDX.w #$0000
	LDA.w #$0010
	STA.b $79
	LDA.w #$2F17
	JSR.w CODE_01F04D
	LDA.w #$2F27
	JSR.w CODE_01F04D
	LDA.w #$2FE5
	JSR.w CODE_01F04D
	LDA.w #$2FF5
	JSR.w CODE_01F04D
	LDY.w #$000F
	LDA.w #$1F18
	JSR.w CODE_01F038
	LDY.w #$000F
	LDA.w #$CFF8
	JSR.w CODE_01F038
	LDX.w #$0002
	STZ.b $79
	LDY.w #$000A
	LDA.w #$00A8
	JSR.w CODE_01F038
	LDY.w #$000A
	LDA.w #$00AA
	JSR.w CODE_01F038
	LDY.w #$000A
	LDA.w #$00AC
	JSR.w CODE_01F038
	LDY.w #$000A
	LDA.w #$00A8
	JSR.w CODE_01F038
	LDY.w #$001E
	LDA.w #$00A8
	JSR.w CODE_01F038
	SEP.b #$30
	LDY.b #$11
	LDX.b #$00
CODE_01F013:
	LDA.l DATA_01EEBE,x
	STA.l SIMC_Global_UpperOAMBuffer[$0A].Slot,x
	INX
	DEY
	BNE.b CODE_01F013
	LDA.l SIMC_Global_UpperOAMBuffer[$09].Slot
	AND.b #$3F
	ORA.b #$80
	STA.l SIMC_Global_UpperOAMBuffer[$09].Slot
	LDA.l SIMC_Global_UpperOAMBuffer[$1B].Slot
	AND.b #$FC
	ORA.b #$02
	STA.l SIMC_Global_UpperOAMBuffer[$1B].Slot
	RTS

CODE_01F038:
	REP.b #$20
	STA.l SIMC_Global_OAMBuffer[$27].XDisp,x
	SEP.b #$20
	CLC
	ADC.b $79
	INX
	INX
	INX
	INX
	DEY
	BNE.b CODE_01F038
	REP.b #$20
	RTS

CODE_01F04D:
	REP.b #$30
	LDY.w #$000A
CODE_01F052:
	STA.l SIMC_Global_OAMBuffer[$27].XDisp,x
	CLC
	ADC.w #$1000
	SEP.b #$20
	SEC
	SBC.b #$04
	REP.b #$20
	INX
	INX
	INX
	INX
	DEY
	BNE.b CODE_01F052
	RTS

CODE_01F069:
	SEP.b #$10
	REP.b #$20
	LDA.b $D7
	BMI.b CODE_01F076
	LDA.w $0AF1
	BEQ.b CODE_01F077
CODE_01F076:
	RTS

CODE_01F077:
	LDA.b $D7
	BEQ.b CODE_01F07E
	JMP.w CODE_01F0D1

CODE_01F07E:
	SEP.b #$10
	REP.b #$20
	LDA.w $011B
	AND.w #$4080
	BEQ.b CODE_01F0CD
	SEP.b #$20
	LDA.w $011C
	AND.b #$0F
	BEQ.b CODE_01F0CD
	LDY.b #$01
	STY.w $01C3
	LDY.b #$00
CODE_01F09A:
	LSR
	BCC.b CODE_01F0C5
	PHA
	TYA
	AND.b #$02
	TAX
	LDA.w $01BD,x
	TYX
	CMP.l DATA_01F1D0,x
	BNE.b CODE_01F0B6
	LDA.w $01C1
	BEQ.b CODE_01F0C4
	AND.w $01C3
	BEQ.b CODE_01F0C4
CODE_01F0B6:
	LDA.l DATA_01F1D4,x
	STA.b $7C
	TYA
	LSR
	TAX
	PHY
	JSR.w CODE_01F11A
	PLY
CODE_01F0C4:
	PLA
CODE_01F0C5:
	ASL.w $01C3
	INY
	CPY.b #$04
	BCC.b CODE_01F09A
CODE_01F0CD:
	STZ.w $01C3
	RTS

CODE_01F0D1:
	SEP.b #$30
	LDA.w $011C
	AND.b #$0F
	BEQ.b CODE_01F116
	LDY.b #$01
	STY.w $01C3
	LDY.b #$00
CODE_01F0E1:
	LSR
	BCC.b CODE_01F10E
	PHA
	TYA
	AND.b #$02
	TAX
	LDA.w $01BD,x
	TYX
	CMP.l DATA_01F1C8,x
	BNE.b CODE_01F0FD
	LDA.w $01C1
	BEQ.b CODE_01F10B
	AND.w $01C3
	BEQ.b CODE_01F10B
CODE_01F0FD:
	LDA.l DATA_01F1CC,x
	STA.b $7C
	TYA
	LSR
	TAX
	PHY
	JSR.w CODE_01F17D
	PLY
CODE_01F10B:
	SEP.b #$20
	PLA
CODE_01F10E:
	ASL.w $01C3
	INY
	CPY.b #$04
	BCC.b CODE_01F0E1
CODE_01F116:
	STZ.w $01C3
	RTS

CODE_01F11A:
	SEP.b #$30
	LDY.b #$13
CODE_01F11E:
	SEP.b #$30
	TXA
	LSR
	BCS.b CODE_01F166
	LDA.l SIMC_Global_OAMBuffer[$6D].YDisp,x
	CMP.b #$E0
	BEQ.b CODE_01F175
	LDA.b $7C
	BMI.b CODE_01F149
	LDA.l SIMC_Global_OAMBuffer[$6D].XDisp,x
	CLC
	ADC.b $7C
	STA.l SIMC_Global_OAMBuffer[$6D].XDisp,x
	BCC.b CODE_01F175
	STY.b $7F
	JSL.l CODE_00C22C
	SEP.b #$30
	LDY.b $7F
	BRA.b CODE_01F175

CODE_01F149:
	LDA.l SIMC_Global_OAMBuffer[$6D].XDisp,x
	CLC
	ADC.b $7C
	STA.l SIMC_Global_OAMBuffer[$6D].XDisp,x
	BEQ.b CODE_01F175
	CMP.b #$FD
	BCC.b CODE_01F175
	STY.b $7F
	JSL.l CODE_00C22C
	SEP.b #$30
	LDY.b $7F
	BRA.b CODE_01F175

CODE_01F166:
	LDA.l SIMC_Global_OAMBuffer[$6D].XDisp,x
	CMP.b #$E0
	BEQ.b CODE_01F171
	CLC
	ADC.b $7C
CODE_01F171:
	STA.l SIMC_Global_OAMBuffer[$6D].XDisp,x
CODE_01F175:
	INX
	INX
	INX
	INX
	DEY
	BNE.b CODE_01F11E
	RTS

CODE_01F17D:
	SEP.b #$30
	LDY.b #$13
CODE_01F181:
	CPX.b #$00
	BNE.b CODE_01F192
	LDA.l SIMC_Global_OAMBuffer[$6D].XDisp,x
	CLC
	ADC.b $7C
	STA.l SIMC_Global_OAMBuffer[$6D].XDisp,x
	BRA.b CODE_01F1C0

CODE_01F192:
	LDA.b $7C
	BMI.b CODE_01F1A3
	LDA.l SIMC_Global_OAMBuffer[$6D].XDisp,x
	CLC
	ADC.b $7C
	CMP.b #$CF
	BCC.b CODE_01F1AE
	BCS.b CODE_01F1B4
CODE_01F1A3:
	LDA.l SIMC_Global_OAMBuffer[$6D].XDisp,x
	CLC
	ADC.b $7C
	CMP.b #$20
	BCC.b CODE_01F1B4
CODE_01F1AE:
	STA.l SIMC_Global_OAMBuffer[$6D].XDisp,x
	BRA.b CODE_01F1C0

CODE_01F1B4:
	PHX
	TXA
	AND.b #$FE
	TAX
	LDA.b #$E0
	STA.l SIMC_Global_OAMBuffer[$6D].YDisp,x
	PLX
CODE_01F1C0:
	INX
	INX
	INX
	INX
	DEY
	BNE.b CODE_01F181
	RTS

DATA_01F1C8:
	db $5A,$F8,$4A,$FA

DATA_01F1CC:
	db $FD,$03,$FC,$04

DATA_01F1D0:
	db $5F,$F9,$4E,$FA

DATA_01F1D4:
	db $FC,$04,$FC,$04,$F0,$E0,$FC,$E0

CODE_01F1DC:
	REP.b #$30
	LDX.w #$07FE
	LDA.w #$2300
CODE_01F1E4:
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	DEX
	DEX
	BPL.b CODE_01F1E4
	RTS

CODE_01F1ED:					; Note: Map generation related
	JSR.w CODE_01F1F1
	RTL

CODE_01F1F1:
	SEP.b #$20
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	JSL.l CODE_00824B
	AND.w #$00FF
	CMP.w #$0056
	BCS.b CODE_01F20E
	JSR.w CODE_01F22C
	BRA.b CODE_01F221

CODE_01F20E:
	JSL.l CODE_0094BC
	JSR.w CODE_01F380
	JSR.w CODE_01F5B9
	JSR.w CODE_01F311
	JSR.w CODE_01F444
	JSR.w CODE_01F3A3
CODE_01F221:
	SEP.b #$20
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	RTS

CODE_01F22C:					; Note: Map generation related. This is what causes most of the load times.
	REP.b #$20
	LDA.w #$0077
	STA.w $044F
CODE_01F234:
	LDA.w #$0063
	STA.w $0451
CODE_01F23A:
	LDA.w #$0001
	JSR.w CODE_01F8AF
	DEC.w $0451
	BPL.b CODE_01F23A
	DEC.w $044F
	BPL.b CODE_01F234
	LDA.w #$0005
	STA.w $044F
CODE_01F250:
	LDA.w #$0005
	STA.w $0451
CODE_01F256:
	LDA.w #$0000
	JSR.w CODE_01F8AF
	INC.w $0451
	LDA.w $0451
	CMP.w #$005F
	BCC.b CODE_01F256
	INC.w $044F
	LDA.w $044F
	CMP.w #$0073
	BCC.b CODE_01F250
	LDA.w #$0000
	STA.w $043F
	BRA.b CODE_01F287

CODE_01F27A:
	LDA.w $043F
	INC
	INC
	CMP.w #$0073
	BCS.b CODE_01F2BE
	STA.w $043F
CODE_01F287:
	STA.w $043B
	LDA.w #$0012
	JSR.w CODE_01F85D
	STA.w $043D
	JSR.w CODE_01F71D
	LDA.w #$0012
	JSR.w CODE_01F85D
	STA.b $79
	LDA.w #$005A
	SEC
	SBC.b $79
	STA.w $043D
	JSR.w CODE_01F71D
	LDA.w #$0000
	STA.w $043D
	JSR.w CODE_01F794
	LDA.w #$005E
	STA.w $043D
	JSR.w CODE_01F794
	BRA.b CODE_01F27A

CODE_01F2BE:
	LDA.w #$0000
	STA.w $0441
	BRA.b CODE_01F2D3

CODE_01F2C6:
	LDA.w $0441
	INC
	INC
	CMP.w #$005F
	BCS.b CODE_01F30A
	STA.w $0441
CODE_01F2D3:
	STA.w $043D
	LDA.w #$0012
	JSR.w CODE_01F85D
	STA.w $043B
	JSR.w CODE_01F71D
	LDA.w #$0012
	JSR.w CODE_01F85D
	STA.b $79
	LDA.w #$006E
	SEC
	SBC.b $79
	STA.w $043B
	JSR.w CODE_01F71D
	LDA.w #$0000
	STA.w $043B
	JSR.w CODE_01F794
	LDA.w #$0072
	STA.w $043B
	JSR.w CODE_01F794
	BRA.b CODE_01F2C6

CODE_01F30A:
	JSR.w CODE_01F444
	JSR.w CODE_01F3A3
	RTS

CODE_01F311:
	REP.b #$30
	LDA.w #$000A
	JSR.w CODE_01F877
	INC
	STA.w $0445
CODE_01F31D:
	LDA.w #$0063
	JSR.w CODE_01F877
	CLC
	ADC.w #$000A
	STA.w $043F
	LDA.w #$0050
	JSR.w CODE_01F877
	CLC
	ADC.w #$000A
	STA.w $0441
	LDA.w #$000C
	JSR.w CODE_01F877
	INC
	INC
	STA.w $0443
CODE_01F342:
	LDA.w #$000C
	JSR.w CODE_01F877
	CLC
	ADC.w $043F
	SEC
	SBC.w #$0006
	STA.w $043B
	LDA.w #$000C
	JSR.w CODE_01F877
	CLC
	ADC.w $0441
	SEC
	SBC.w #$0006
	STA.w $043D
	JSL.l CODE_00824B
	AND.w #$0003
	BEQ.b CODE_01F372
	JSR.w CODE_01F71D
	BRA.b CODE_01F375

CODE_01F372:
	JSR.w CODE_01F794
CODE_01F375:
	DEC.w $0443
	BNE.b CODE_01F342
	DEC.w $0445
	BNE.b CODE_01F31D
	RTS

CODE_01F380:
	REP.b #$20
	LDA.w #$0028
	JSR.w CODE_01F877
	CLC
	ADC.w #$0028
	STA.w $0457
	STA.w $043B
	LDA.w #$0021
	JSR.w CODE_01F877
	CLC
	ADC.w #$0021
	STA.w $0459
	STA.w $043D
	RTS

CODE_01F3A3:
	REP.b #$30
	LDA.w #$0064
	JSR.w CODE_01F877
	CLC
	ADC.w #$0032
	STA.w $043F
CODE_01F3B2:
	LDA.w #$0077
	JSR.w CODE_01F877
	STA.w $044B
	LDA.w #$0063
	JSR.w CODE_01F877
	STA.w $044D
	JSR.w CODE_01F3D3
	DEC.w $043F
	BNE.b CODE_01F3B2
	JSR.w CODE_01F502
	JSR.w CODE_01F502
	RTS

CODE_01F3D3:
	REP.b #$30
	LDY.w #$0000
	LDA.w #$0096
	JSR.w CODE_01F877
	CLC
	ADC.w #$0032
	STA.w $0443
	LDA.w $044B
	STA.w $043B
	LDA.w $044D
	STA.w $043D
CODE_01F3F1:
	JSL.l CODE_00824B
	AND.w #$0007
	JSR.w CODE_01F6AE
	LDA.w $043B
	STA.w $0453
	LDA.w $043D
	STA.w $0455
	JSR.w CODE_01F843
	BCS.b CODE_01F42B
	LDA.w $043B
	STA.w $044F
	LDA.w $043D
	STA.w $0451
	JSR.w CODE_01F8E9
	CMP.w #$0000
	BNE.b CODE_01F426
	LDA.w #$0018
	JSR.w CODE_01F8AF
CODE_01F426:
	DEC.w $0443
	BNE.b CODE_01F3F1
CODE_01F42B:
	RTS

DATA_01F42C:
	db $FF,$00,$01,$00

DATA_01F430:
	db $00,$01,$00,$FF

DATA_01F434:
	db $01,$07,$0A,$09,$08,$01,$0B,$01,$05,$04,$01,$01,$06,$01,$01,$01

CODE_01F444:
	REP.b #$30
	LDA.w #$0077
	STA.w $043F
CODE_01F44C:
	LDA.w #$0063
	STA.w $0441
CODE_01F452:
	LDA.w $043F
	STA.w $044F
	LDA.w $0441
	STA.w $0451
	JSR.w CODE_01F8E9
	CMP.w #$0003
	BNE.b CODE_01F4E1
	LDA.w #$0000
	STA.w $045B
	LDA.w #$0003
	STA.w $0443
CODE_01F472:
	ASL.w $045B
	LDX.w $0443
	LDA.w #$0000
	SEP.b #$20
	LDA.l DATA_01F42C,x
	CLC
	ADC.w $043F
	REP.b #$20
	STA.w $0453
	STA.w $044F
	SEP.b #$20
	LDA.l DATA_01F430,x
	CLC
	ADC.w $0441
	REP.b #$20
	STA.w $0455
	STA.w $0451
	JSR.w CODE_01F843
	BCS.b CODE_01F4AC
	JSR.w CODE_01F8E9
	CMP.w #$0000
	BNE.b CODE_01F4AF
CODE_01F4AC:
	INC.w $045B
CODE_01F4AF:
	DEC.w $0443
	BPL.b CODE_01F472
	LDX.w $045B
	LDA.l DATA_01F434,x
	AND.w #$00FF
	CMP.w #$0001
	BEQ.b CODE_01F4D2
	STA.b $79
	JSL.l CODE_00824B
	LSR
	LDA.b $79
	BCC.b CODE_01F4D2
	CLC
	ADC.w #$0008
CODE_01F4D2:
	LDX.w $043F
	STX.w $044F
	LDX.w $0441
	STX.w $0451
	JSR.w CODE_01F8AF
CODE_01F4E1:
	DEC.w $0441
	BMI.b CODE_01F4E9
	JMP.w CODE_01F452

CODE_01F4E9:
	DEC.w $043F
	BMI.b CODE_01F4F1
	JMP.w CODE_01F44C

CODE_01F4F1:
	RTS

DATA_01F4F2:
	db $00,$00,$00,$16,$00,$00,$14,$15,$00,$1C,$00,$19,$1A,$1B,$17,$18

CODE_01F502:
	REP.b #$30
	LDA.w #$0077
	STA.w $043F
CODE_01F50A:
	LDA.w #$0063
	STA.w $0441
CODE_01F510:
	LDA.w $043F
	STA.w $044F
	LDA.w $0441
	STA.w $0451
	JSR.w CODE_01F8E9
	CMP.w #$0014
	BCS.b CODE_01F527
	JMP.w CODE_01F5A8

CODE_01F527:
	CMP.w #$0026
	BCS.b CODE_01F5A8
	LDA.w #$0000
	STA.w $045D
	LDA.w #$0003
	STA.w $0443
CODE_01F538:
	ASL.w $045D
	LDX.w $0443
	LDA.w #$0000
	SEP.b #$20
	LDA.l DATA_01F42C,x
	CLC
	ADC.w $043F
	REP.b #$20
	STA.w $0453
	STA.w $044F
	SEP.b #$20
	LDA.l DATA_01F430,x
	CLC
	ADC.w $0441
	REP.b #$20
	STA.w $0455
	STA.w $0451
	JSR.w CODE_01F843
	BCS.b CODE_01F57A
	JSR.w CODE_01F8E9
	CMP.w #$0014
	BCC.b CODE_01F57A
	CMP.w #$0026
	BCS.b CODE_01F57A
	INC.w $045D
CODE_01F57A:
	DEC.w $0443
	BPL.b CODE_01F538
	LDX.w $045D
	LDA.l DATA_01F4F2,x
	AND.w #$00FF
	BEQ.b CODE_01F599
	STA.b $79
	JSL.l CODE_00824B
	LSR
	LDA.b $79
	BCS.b CODE_01F599
	ADC.w #$0009
CODE_01F599:
	LDX.w $043F
	STX.w $044F
	LDX.w $0441
	STX.w $0451
	JSR.w CODE_01F8AF
CODE_01F5A8:
	DEC.w $0441
	BMI.b CODE_01F5B0
	JMP.w CODE_01F510

CODE_01F5B0:
	DEC.w $043F
	BMI.b CODE_01F5B8
	JMP.w CODE_01F50A

CODE_01F5B8:
	RTS

CODE_01F5B9:
	REP.b #$20
	JSL.l CODE_00824B
	AND.w #$0003
	STA.w $045F
	STA.w $0461
	JSR.w CODE_01F600
	LDA.w $0457
	STA.w $043B
	LDA.w $0459
	STA.w $043D
	LDA.w $045F
	EOR.w #$0004
	STA.w $045F
	STA.w $0461
	JSR.w CODE_01F600
	LDA.w $0457
	STA.w $043B
	LDA.w $0459
	STA.w $043D
	JSL.l CODE_00824B
	AND.w #$0003
	STA.w $045F
	JSR.w CODE_01F647
	RTS

CODE_01F600:
	REP.b #$20
CODE_01F602:
	LDA.w $043B
	CLC
	ADC.w #$0004
	STA.w $0453
	LDA.w $043D
	CLC
	ADC.w #$0004
	STA.w $0455
	JSR.w CODE_01F843
	BCS.b CODE_01F646
	JSR.w CODE_01F71D
	JSL.l CODE_00824B
	LSR
	BCC.b CODE_01F630
	LSR
	BCS.b CODE_01F62D
	INC.w $0461
	BRA.b CODE_01F630

CODE_01F62D:
	DEC.w $0461
CODE_01F630:
	LDA.w #$000A
	JSR.w CODE_01F877
	BNE.b CODE_01F63E
	LDA.w $045F
	STA.w $0461
CODE_01F63E:
	LDA.w $0461
	JSR.w CODE_01F6AE
	BRA.b CODE_01F602

CODE_01F646:
	RTS

CODE_01F647:
	REP.b #$20
CODE_01F649:
	LDA.w $043B
	CLC
	ADC.w #$0003
	STA.w $0453
	LDA.w $043D
	CLC
	ADC.w #$0003
	STA.w $0455
	JSR.w CODE_01F843
	BCS.b CODE_01F68D
	JSR.w CODE_01F794
	JSL.l CODE_00824B
	LSR
	BCC.b CODE_01F677
	LSR
	BCS.b CODE_01F674
	INC.w $0461
	BRA.b CODE_01F677

CODE_01F674:
	DEC.w $0461
CODE_01F677:
	LDA.w #$000C
	JSR.w CODE_01F877
	BNE.b CODE_01F685
	LDA.w $045F
	STA.w $0461
CODE_01F685:
	LDA.w $0461
	JSR.w CODE_01F6AE
	BRA.b CODE_01F649

CODE_01F68D:
	RTS

DATA_01F68E:
	dw $0000,$0001,$0001,$0001,$0000,$FFFF,$FFFF,$FFFF

DATA_01F69E:
	dw $FFFF,$FFFF,$0000,$0001,$0001,$0001,$0000,$FFFF

CODE_01F6AE:
	REP.b #$30
	AND.w #$0007
	ASL
	TAX
	LDA.l DATA_01F68E,x
	CLC
	ADC.w $043B
	STA.w $043B
	LDA.l DATA_01F69E,x
	CLC
	ADC.w $043D
	STA.w $043D
	RTS

DATA_01F6CC:
	db $00,$00,$00,$03,$03,$03,$00,$00,$00,$00,$00,$03,$01,$01,$01,$03
	db $00,$00,$00,$03,$01,$01,$01,$01,$01,$03,$00,$03,$01,$01,$01,$01
	db $01,$01,$01,$03,$03,$01,$01,$01,$02,$01,$01,$01,$03,$03,$01,$01
	db $01,$01,$01,$01,$01,$03,$00,$03,$01,$01,$01,$01,$01,$03,$00,$00
	db $00,$03,$01,$01,$01,$03,$00,$00,$00,$00,$00,$03,$03,$03,$00,$00
	db $00

CODE_01F71D:
	REP.b #$20
	LDA.w #$0008
	STA.w $0447
CODE_01F725:
	LDA.w #$0008
	STA.w $0449
CODE_01F72B:
	SEP.b #$20
	LDA.w $0449
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	LDA.b #$09
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	REP.b #$20
	CLC
	ADC.w $0447
	TAX
	LDA.l DATA_01F6CC,x
	AND.w #$00FF
	JSR.w CODE_01F7E7
	DEC.w $0449
	BPL.b CODE_01F72B
	DEC.w $0447
	BPL.b CODE_01F725
	RTS

DATA_01F770:
	db $00,$00,$03,$03,$00,$00,$00,$03,$01,$01,$03,$00,$03,$01,$01,$01
	db $01,$03,$03,$01,$01,$01,$01,$03,$00,$03,$01,$01,$03,$00,$00,$00
	db $03,$03,$00,$00

CODE_01F794:
	REP.b #$20
	LDA.w #$0005
	STA.w $0447
CODE_01F79C:
	LDA.w #$0005
	STA.w $0449
CODE_01F7A2:
	SEP.b #$20
	LDA.w $0449
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	LDA.b #$06
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	REP.b #$20
	CLC
	ADC.w $0447
	TAX
	LDA.l DATA_01F770,x
	AND.w #$00FF
	JSR.w CODE_01F7E7
	DEC.w $0449
	BPL.b CODE_01F7A2
	DEC.w $0447
	BPL.b CODE_01F79C
	RTS

CODE_01F7E7:
	REP.b #$20
	PHA
	CMP.w #$0000
	BEQ.b CODE_01F841
	LDA.w $0447
	CLC
	ADC.w $043B
	STA.w $0453
	STA.w $044F
	LDA.w $0449
	CLC
	ADC.w $043D
	STA.w $0455
	STA.w $0451
	JSR.w CODE_01F843
	BCS.b CODE_01F841
	JSR.w CODE_01F8E9
	REP.b #$10
	PLX
	CPX.w #$0002
	BEQ.b CODE_01F825
	CMP.w #$0001
	BEQ.b CODE_01F840
	CMP.w #$0002
	BEQ.b CODE_01F840
	BNE.b CODE_01F83C
CODE_01F825:
	LDA.w $044F
	BEQ.b CODE_01F839
	CMP.w #$0078
	BEQ.b CODE_01F839
	LDA.w $0451
	BEQ.b CODE_01F839
	CMP.w #$0064
	BNE.b CODE_01F83C
CODE_01F839:
	LDX.w #$0001
CODE_01F83C:
	TXA
	JSR.w CODE_01F8AF
CODE_01F840:
	RTS

CODE_01F841:
	PLA
	RTS

CODE_01F843:
	REP.b #$20
	LDA.w $0453
	BMI.b CODE_01F85B
	CMP.w #$0078
	BCS.b CODE_01F85B
	LDA.w $0455
	BMI.b CODE_01F85B
	CMP.w #$0064
	BCS.b CODE_01F85B
	CLC
	RTS

CODE_01F85B:
	SEC
	RTS

CODE_01F85D:
	REP.b #$20
	PHA
	JSR.w CODE_01F877
	REP.b #$10
	TAX
	PLA
	PHX
	JSR.w CODE_01F877
	REP.b #$10
	PLX
	STX.b $79
	CMP.b $79
	BCS.b CODE_01F875
	RTS

CODE_01F875:
	TXA
	RTS

CODE_01F877:
	REP.b #$20
	INC
	STA.b $79
	JSL.l CODE_00824B
	SEP.b #$20
	XBA
	LDA.b $79
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	XBA
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	XBA
	REP.b #$20
	AND.w #$00FF
	RTS

CODE_01F8AF:
	REP.b #$30
	PHA
	SEP.b #$20
	LDA.w $0451
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	LDA.b #$78
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	REP.b #$20
	CLC
	ADC.w $044F
	ASL
	TAX
	PLA
	STA.l !RAM_SIMC_City_MapDataBuffer,x
	RTS

CODE_01F8E9:
	SEP.b #$20
	REP.b #$10
	LDA.w $0451
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	LDA.b #$78
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	REP.b #$20
	CLC
	ADC.w $044F
	ASL
	TAX
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	AND.w #$03FF
	RTS

	%FREE_BYTES($01F924, 1756, $FF)
%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SIMCBank02Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

CODE_028000:
	REP.b #$30
	LDA.w $0D87
	BEQ.b CODE_02800A
	JMP.w CODE_028462

CODE_02800A:
	REP.b #$30
	PHB
	LDY.w #SIMC_Global_PaletteMirror[$80].LowByte
	LDX.w #DATA_058900
	LDA.w #$00FF
	MVN SIMC_Global_PaletteMirror[$80].LowByte>>16,DATA_058900>>16
	PLB
	INC.b $C3
	LDA.b $BB
	ORA.w #$0002
	STA.b $BB
	JSL.l CODE_008DA2
	STZ.w $0D29
	STZ.w $0B35
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	JSR.w CODE_02A01D
	LDA.w $01FB
	BEQ.b CODE_02803F
	JMP.w CODE_02824B

CODE_02803F:
	JSR.w CODE_029892
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	SEP.b #$30
	LDA.w $0D51
	BEQ.b CODE_028071
	INC.b $C3
	LDA.w $0D49
	LDX.w $0D4D
	STX.w $0D49
	STA.w $0D4D
	JSR.w CODE_0287F8
	SEP.b #$20
	LDA.w $0D49
	LDX.w $0D4D
	STX.w $0D49
	STA.w $0D4D
	BRA.b CODE_028074

CODE_028071:
	JSR.w CODE_0287F1
CODE_028074:
	SEP.b #$20
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	JSL.l CODE_008206
	STZ.w !REGISTER_VRAMAddressLo
	LDA.b #$60
	STA.w !REGISTER_VRAMAddressHi
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer
	STA.w DMA[$00].SourceLo,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$08
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_0280C0
CODE_0280BC:
	ASL
	DEX
	BNE.b CODE_0280BC
CODE_0280C0:
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	STZ.w !REGISTER_VRAMAddressLo
	LDA.b #$64
	STA.w !REGISTER_VRAMAddressHi
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer+$0800
	STA.w DMA[$00].SourceLo,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$0800)>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$0800)>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$08
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_028105
CODE_028101:
	ASL
	DEX
	BNE.b CODE_028101
CODE_028105:
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	STZ.w !REGISTER_VRAMAddressLo
	LDA.b #$68
	STA.w !REGISTER_VRAMAddressHi
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer+$1000
	STA.w DMA[$00].SourceLo,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$1000)>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$1000)>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$08
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_02814A
CODE_028146:
	ASL
	DEX
	BNE.b CODE_028146
CODE_02814A:
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	STZ.w !REGISTER_VRAMAddressLo
	LDA.b #$6C
	STA.w !REGISTER_VRAMAddressHi
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer+$1800
	STA.w DMA[$00].SourceLo,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$1800)>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$1800)>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$08
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_02818F
CODE_02818B:
	ASL
	DEX
	BNE.b CODE_02818B
CODE_02818F:
	STA.w !REGISTER_DMAEnable
	JSR.w CODE_028839
	RTL

CODE_028196:
	REP.b #$20
	LDA.w $01EB
	PHA
	LDA.w $01ED
	PHA
	LDA.w $01FF
	PHA
	LDA.w #$00AC
	STA.w $01ED
	LDA.w #$003E
	STA.w $01EB
	SEP.b #$20
	LDA.w $046B
	PHA
	STZ.w $046B
	STZ.b !RAM_SIMC_Global_ObjectAndColorWindowSettings
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	LDA.w $01FB
	BEQ.b CODE_0281CA
	JMP.w CODE_028375

CODE_0281CA:
	SEP.b #$10
	REP.b #$20
	LDX.w $0D49
	LDA.l DATA_00A94D,x
	AND.w #$00FF
	STA.w $01EB
	JSR.w CODE_029589
	JSR.w CODE_0295A0
	JSR.w CODE_0287C3
	SEP.b #$20
	REP.b #$10
	LDX.w $0D49
	LDA.b #$01
	JSR.w CODE_02A0CB
	JSL.l CODE_01C8C4
	SEP.b #$30
	JSR.w CODE_0285EA
CODE_0281F9:
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDA.w $0D87
	BEQ.b CODE_02820C
	JMP.w CODE_028462

CODE_02820C:
	LDA.w $0DC3
	BMI.b CODE_02821C
	BEQ.b CODE_028224
	JSR.w CODE_02A3E0
	JSR.w CODE_02A651
	JMP.w CODE_0281F9

CODE_02821C:
	LDA.b #$01
	STA.w $0B35
	JMP.w CODE_028423

CODE_028224:
	JSR.w CODE_02985A
	JSR.w CODE_0284EB
	REP.b #$20
	LDA.w $0C0F
	BNE.b CODE_028234
	JSR.w CODE_028476
CODE_028234:
	SEP.b #$20
	LDA.w $0D29
	BEQ.b CODE_02823E
	JMP.w CODE_028423

CODE_02823E:
	JSR.w CODE_0287C3
	JSR.w CODE_0295EC
	JSL.l CODE_0094D5
	JMP.w CODE_0281F9

CODE_02824B:
	JSR.w CODE_0298F3
	JSR.w CODE_02990F
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	JSL.l CODE_008206
	STZ.w !REGISTER_VRAMAddressLo
	LDA.b #$60
	STA.w !REGISTER_VRAMAddressHi
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer
	STA.w DMA[$00].SourceLo,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$08
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_02829B
CODE_028297:
	ASL
	DEX
	BNE.b CODE_028297
CODE_02829B:
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	STZ.w !REGISTER_VRAMAddressLo
	LDA.b #$64
	STA.w !REGISTER_VRAMAddressHi
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer+$0800
	STA.w DMA[$00].SourceLo,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$0800)>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$0800)>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$08
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_0282E0
CODE_0282DC:
	ASL
	DEX
	BNE.b CODE_0282DC
CODE_0282E0:
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	STZ.w !REGISTER_VRAMAddressLo
	LDA.b #$68
	STA.w !REGISTER_VRAMAddressHi
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer+$1000
	STA.w DMA[$00].SourceLo,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$1000)>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$1000)>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$08
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_028325
CODE_028321:
	ASL
	DEX
	BNE.b CODE_028321
CODE_028325:
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	STZ.w !REGISTER_VRAMAddressLo
	LDA.b #$6C
	STA.w !REGISTER_VRAMAddressHi
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer+$1800
	STA.w DMA[$00].SourceLo,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$1800)>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$1800)>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$08
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_02836A
CODE_028366:
	ASL
	DEX
	BNE.b CODE_028366
CODE_02836A:
	STA.w !REGISTER_DMAEnable
	JSR.w CODE_02887E
	REP.b #$20
	STZ.b $C3
	RTL

CODE_028375:
	REP.b #$20
	STZ.b $E3
	LDA.w #$0046
	STA.w $01EB
	LDA.w #$00AC
	STA.w $01ED
	JSR.w CODE_02A068
	JSR.w CODE_029910
	SEP.b #$30
	LDX.b #$06
	LDA.w $0B25
	BNE.b CODE_028395
	INX
CODE_028395:
	STX.w $0DAF
	JSR.w CODE_029BB8
CODE_02839B:
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDA.w $0D87
	BEQ.b CODE_0283AE
	JMP.w CODE_028462

CODE_0283AE:
	LDA.w $0DC3
	BMI.b CODE_0283BE
	BEQ.b CODE_0283C6
	JSR.w CODE_02A3E0
	JSR.w CODE_02A651
	JMP.w CODE_02839B

CODE_0283BE:
	LDA.b #$02
	STA.w $0B35
	JMP.w CODE_028423

CODE_0283C6:
	LDA.w $0C0F
	BEQ.b CODE_0283CE
	JMP.w CODE_028416

CODE_0283CE:
	LDA.b $C9
	AND.b #$40
	BEQ.b CODE_0283DF
	PHP
	JSL.l CODE_0098A0	: dw $0603
	PLP
	JMP.w CODE_028423

CODE_0283DF:
	SEP.b #$20
	BIT.b $CA
	BPL.b CODE_028413
	JSR.w CODE_029958
	BCS.b CODE_028416
	JSR.w CODE_029978
	BCS.b CODE_0283F7
	JSR.w CODE_0299D5
	JSR.w CODE_029BB8
	BRA.b CODE_028416

CODE_0283F7:
	LDA.w $0DAF
	CMP.b #$06
	BCS.b CODE_028416
	JSR.w CODE_0299D5
	SEP.b #$10
	LDX.b #$06
	LDA.w $0B25
	BNE.b CODE_02840B
	INX
CODE_02840B:
	STX.w $0DAF
	JSR.w CODE_029BB8
	BRA.b CODE_028416

CODE_028413:
	JSR.w CODE_029F2A
CODE_028416:
	JSR.w CODE_029EFC
	JSR.w CODE_029F7C
	JSL.l CODE_0094D5
	JMP.w CODE_02839B

CODE_028423:
	PHP
	JSL.l CODE_0098A0	: dw $0603
	PLP
	SEP.b #$20
	STZ.w $0D29
	JSR.w CODE_029876
	PLA
	STA.w $046B
	LDA.b #$03
	STA.b !RAM_SIMC_Global_ObjectAndColorWindowSettings
	REP.b #$20
	PLA
	LDA.w $01FF
	PLA
	STA.w $01ED
	PLA
	STA.w $01EB
	SEP.b #$20
	LDA.w $0195
	AND.b #$08
	BNE.b CODE_028456
	LDA.b #$F0
	STA.b $03
CODE_028456:
	SEP.b #$20
	LDA.b #$FF
	STA.b $E3
	STA.b $C3
	STZ.w $0D29
	RTL

CODE_028462:
	REP.b #$20
	LDA.w #$0004
	COP.b #$00
CODE_028469:
	REP.b #$30
	LDA.w #$0013
	STA.b $14
	STZ.b $12
	LDX.b $AF
	TXS
	RTL

CODE_028476:
	REP.b #$20
	STZ.b $E3
	BIT.b $C9
	BMI.b CODE_028499
	LDA.w $011B
	AND.w #$4080
	BEQ.b CODE_02848B
	INC.b $E3
	JMP.w CODE_028523

CODE_02848B:
	SEP.b #$20
	LDA.b $C9
	AND.b #$40
	BNE.b CODE_0284B8
	JMP.w CODE_029F2A

CODE_028496:
	JMP.w CODE_0287BB

CODE_028499:
	SEP.b #$20
	JSR.w CODE_02858A
	BNE.b CODE_0284EA
	JSL.l CODE_01C8C4
	JSR.w CODE_02A047
	JSR.w CODE_029767
	JSR.w CODE_0287E4
	JSR.w CODE_02A01D
	JSR.w CODE_0295A0
	STZ.w $0D51
	BRA.b CODE_0284EA

CODE_0284B8:
	LDA.w $0D51
	BEQ.b CODE_028496
	SEP.b #$20
	LDX.w $0D49
	LDA.b #$00
	JSR.w CODE_02A0CB
	LDX.w $0D4D
	LDA.b #$01
	JSR.w CODE_02A0CB
	JSL.l CODE_01C8C4
	LDA.w $0D4D
	STA.w $0D49
	CLC
	ADC.b #$04
	STA.w $0D4B
	STZ.w $0D51
	PHP
	JSL.l CODE_0098A0	: dw $0603
	PLP
CODE_0284EA:
	RTS

CODE_0284EB:
	SEP.b #$10
	REP.b #$20
	LDA.w $011B
	BNE.b CODE_028514
	LDA.w $0D51
	BNE.b CODE_028514
	SEP.b #$20
	PHB
	LDA.b #DATA_028515>>16
	PHA
	PLB
	LDX.w $0D49
	LDA.w DATA_028515,x
	TAX
	PLB
	LDA.w $0CDD,x
	BEQ.b CODE_028510
	JMP.w CODE_0287E4

CODE_028510:
	JSL.l CODE_01C02F
CODE_028514:
	RTS

DATA_028515:
	db $00,$00,$00,$00,$04,$00,$00,$00,$00,$03,$02,$03,$01,$00

CODE_028523:
	SEP.b #$20
	LDA.w $011C
	AND.b #$0F
	BEQ.b CODE_028589
	LSR
	BCS.b CODE_028548
	LSR
	BCS.b CODE_02855B
	LSR
	BCS.b CODE_02856E
	REP.b #$20
	LDA.w $0D35
	CMP.w #$002C
	BEQ.b CODE_028589
	DEC
	STA.w $0D35
	LDA.w #$0008
	BRA.b CODE_02857F

CODE_028548:
	REP.b #$20
	LDA.w $0D33
	CMP.w #$00A5
	BEQ.b CODE_028589
	INC
	STA.w $0D33
	LDA.w #$0001
	BRA.b CODE_02857F

CODE_02855B:
	REP.b #$20
	LDA.w $0D33
	CMP.w #$003F
	BEQ.b CODE_028589
	DEC
	STA.w $0D33
	LDA.w #$0002
	BRA.b CODE_02857F

CODE_02856E:
	REP.b #$20
	LDA.w $0D35
	CMP.w #$0080
	BEQ.b CODE_028589
	INC
	STA.w $0D35
	LDA.w #$0004
CODE_02857F:
	STA.w $019D
	REP.b #$20
	LDA.w #$0007
	COP.b #$00
CODE_028589:
	RTS

CODE_02858A:
	SEP.b #$30
	LDA.w $0D51
	BEQ.b CODE_028594
	JMP.w CODE_028603

CODE_028594:
	LDX.b #$00
	JSR.w CODE_028769
	BCC.b CODE_028600
	SEP.b #$20
	PHA
	PHP
	JSL.l CODE_0098A0	: dw $0102
	PLP
	LDX.w $0D49
	LDA.b #$00
	JSR.w CODE_02A0CB
	PLA
	PHA
	TAX
	LDA.b #$01
	JSR.w CODE_02A0CB
	SEP.b #$20
	PLA
	CMP.w $0D49
	BNE.b CODE_0285CA
	CMP.b #$00
	BEQ.b CODE_0285CA
	CMP.b #$06
	BEQ.b CODE_0285CA
	CMP.b #$0C
	BNE.b CODE_0285DC
CODE_0285CA:
	LDX.w $0D49
	STX.w $0D4D
	STA.w $0D49
	CLC
	ADC.b #$04
	STA.w $0D4B
	LDA.w $0D49
CODE_0285DC:
	ASL
	TAX
	PHB
	LDA.b #DATA_0286A4>>16
	PHA
	PLB
	LDA.w DATA_0286A4,x
	PLB
	STA.w $0D51
CODE_0285EA:
	LDA.w $0D51
	BEQ.b CODE_028602
	CMP.b #$01
	BNE.b CODE_0285F6
	JMP.w CODE_0286C0

CODE_0285F6:
	CMP.b #$02
	BNE.b CODE_0285FD
	JMP.w CODE_028703

CODE_0285FD:
	JMP.w CODE_028736

CODE_028600:
	LDA.b #$80
CODE_028602:
	RTS

CODE_028603:
	SEP.b #$30
	PHB
	LDA.b #DATA_0286A4>>16
	PHA
	PLB
	LDA.w $0D49
	ASL
	TAX
	LDA.w DATA_0286A4,x
	TAX
	PLB
	JSR.w CODE_028769
	BCS.b CODE_02861C
	LDA.b #$80
	RTS

CODE_02861C:
	SEP.b #$30
	PHX
	PHP
	JSL.l CODE_0098A0	: dw $0102
	PLP
	PLA
	CLC
	ADC.w $0D49
	STA.w $0D49
	CLC
	ADC.b #$04
	STA.w $0D4B
	SEP.b #$30
	LDA.w $0D49
	CMP.w $0D4D
	BEQ.b CODE_028693
	PHB
	LDA.b #DATA_028696>>16
	PHA
	PLB
	LDX.w $0D49
	LDA.w DATA_028696,x
	TAX
	LDA.b #$01
	PLB
	JSR.w CODE_02A0CB
	LDA.b #$03
	CMP.w $0D4D
	BCC.b CODE_02865F
	CMP.w $0D49
	BCS.b CODE_028681
	BCC.b CODE_028693
CODE_02865F:
	LDA.w $0D4D
	AND.b #$06
	CMP.b #$06
	BNE.b CODE_028673
	LDA.w $0D49
	AND.b #$06
	CMP.b #$06
	BEQ.b CODE_028681
	BNE.b CODE_028693
CODE_028673:
	LDA.w $0D4D
	CMP.b #$0C
	BCC.b CODE_028693
	LDA.w $0D49
	CMP.b #$0C
	BCC.b CODE_028693
CODE_028681:
	PHB
	LDA.b #DATA_028696>>16
	PHA
	PLB
	LDX.w $0D4D
	LDA.w DATA_028696,x
	TAX
	LDA.b #$00
	PLB
	JSR.w CODE_02A0CB
CODE_028693:
	LDA.b #$00
	RTS

DATA_028696:
	db $0E,$0F,$10,$11,$00,$00,$12,$13,$00,$00,$00,$00,$16,$17

DATA_0286A4:
	dw $0001,$0001,$0001,$0001,$0000,$0000,$0002,$0002
	dw $0000,$0000,$0000,$0000,$0003,$0003

CODE_0286C0:
	SEP.b #$30
	LDA.b #$00
	LDY.w $0D4D
	BNE.b CODE_0286CA
	INC
CODE_0286CA:
	LDX.b #$0E
	JSR.w CODE_02A0CB
	LDA.b #$00
	LDY.w $0D4D
	CPY.b #$01
	BNE.b CODE_0286D9
	INC
CODE_0286D9:
	LDX.b #$0F
	JSR.w CODE_02A0CB
	LDA.b #$00
	LDY.w $0D4D
	CPY.b #$02
	BNE.b CODE_0286E8
	INC
CODE_0286E8:
	LDX.b #$10
	JSR.w CODE_02A0CB
	LDA.b #$00
	LDY.w $0D4D
	CPY.b #$03
	BNE.b CODE_0286F7
	INC
CODE_0286F7:
	LDX.b #$11
	JSR.w CODE_02A0CB
	JSL.l CODE_01C8C4
	LDA.b #$80
	RTS

CODE_028703:
	LDA.b #$00
	LDY.w $0D4D
	CPY.b #$06
	BNE.b CODE_02870D
	INC
CODE_02870D:
	LDX.b #$12
	JSR.w CODE_02A0CB
	LDA.b #$00
	LDY.w $0D4D
	CPY.b #$07
	BNE.b CODE_02871C
	INC
CODE_02871C:
	LDX.b #$13
	JSR.w CODE_02A0CB
	LDX.b #$14
	LDA.b #$00
	JSR.w CODE_02A0CB
	LDX.b #$15
	LDA.b #$00
	JSR.w CODE_02A0CB
	JSL.l CODE_01C8C4
	LDA.b #$80
	RTS

CODE_028736:
	LDA.b #$00
	LDY.w $0D4D
	CPY.b #$0C
	BNE.b CODE_028740
	INC
CODE_028740:
	LDX.b #$16
	JSR.w CODE_02A0CB
	LDA.b #$00
	LDY.w $0D4D
	CPY.b #$0D
	BNE.b CODE_02874F
	INC
CODE_02874F:
	LDX.b #$17
	JSR.w CODE_02A0CB
	LDX.b #$14
	LDA.b #$00
	JSR.w CODE_02A0CB
	LDX.b #$15
	LDA.b #$00
	JSR.w CODE_02A0CB
	JSL.l CODE_01C8C4
	LDA.b #$80
	RTS

CODE_028769:
	SEP.b #$30
	PHB
	LDA.b #DATA_0287A2>>16
	PHA
	PLB
	LDA.w $01ED
	CMP.w DATA_0287AB,x
	BCC.b CODE_02879F
	CMP.w DATA_0287AF,x
	BCS.b CODE_02879F
	LDY.b #$00
	LDA.w $01EB
	CMP.w DATA_0287B3,x
	BCS.b CODE_02879F
	SEC
	SBC.w DATA_0287B7,x
	BCC.b CODE_02879F
CODE_02878D:
	SEC
	SBC.b #$10
	BCC.b CODE_028797
	INY
	CPY.b #$08
	BCC.b CODE_02878D
CODE_028797:
	TYA
	TAX
	LDA.w DATA_0287A2,x
	SEC
	BRA.b CODE_0287A0

CODE_02879F:
	CLC
CODE_0287A0:
	PLB
	RTS

DATA_0287A2:
	db $00,$04,$05,$06,$08,$09,$0A,$0B,$0C

DATA_0287AB:
	db $A5,$AC,$AC,$AC

DATA_0287AF:
	db $B5,$BC,$BC,$BC

DATA_0287B3:
	db $C8,$60,$80,$D0

DATA_0287B7:
	db $38,$20,$60,$B0

CODE_0287BB:
	SEP.b #$20
	LDA.b #$08
	STA.w $0D29
	RTS

CODE_0287C3:
	REP.b #$20
	LDA.w $0C0F
	BNE.b CODE_0287D7
	LDA.w $011B
	AND.w #$4080
	BEQ.b CODE_0287D7
	JSR.w CODE_0297B6
	BRA.b CODE_0287DA

CODE_0287D7:
	JSR.w CODE_029F7C
CODE_0287DA:
	JSR.w CODE_02980C
	JSR.w CODE_029767
	JSR.w CODE_0295EC
	RTS

CODE_0287E4:
	JSR.w CODE_0287C3
	JSR.w CODE_0295EC
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
CODE_0287F1:
	REP.b #$20
	INC.b $C3
	LDA.w $0D49
CODE_0287F8:
	REP.b #$10
	ASL
	TAX
	JSR.w (DATA_02880D,x)
	REP.b #$20
	STZ.b $C3
	STZ.w $0CDD
	STZ.w $0CDF
	STZ.w $0CE0
	RTS

DATA_02880D:
	dw CODE_028829
	dw CODE_028829
	dw CODE_028829
	dw CODE_028829
	dw CODE_028829
	dw CODE_028AD9
	dw CODE_028A62
	dw CODE_0289ED
	dw CODE_028A62
	dw CODE_028A62
	dw CODE_028A62
	dw CODE_028A62
	dw CODE_0289ED
	dw CODE_0289ED

CODE_028829:
	JSR.w CODE_029892
	JSR.w CODE_02899B
CODE_02882F:
	SEP.b #$20
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
CODE_028839:
	JSL.l CODE_008206
	STZ.w !REGISTER_VRAMAddressLo
	LDA.b #$64
	STA.w !REGISTER_VRAMAddressHi
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer+$0800
	STA.w DMA[$00].SourceLo,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$0800)>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$0800)>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$08
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_02887B
CODE_028877:
	ASL
	DEX
	BNE.b CODE_028877
CODE_02887B:
	STA.w !REGISTER_DMAEnable
CODE_02887E:
	JSL.l CODE_008206
	STZ.w !REGISTER_VRAMAddressLo
	LDA.b #$70
	STA.w !REGISTER_VRAMAddressHi
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer+$2000
	STA.w DMA[$00].SourceLo,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$2000)>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$2000)>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$08
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_0288C0
CODE_0288BC:
	ASL
	DEX
	BNE.b CODE_0288BC
CODE_0288C0:
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	STZ.w !REGISTER_VRAMAddressLo
	LDA.b #$74
	STA.w !REGISTER_VRAMAddressHi
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer+$2800
	STA.w DMA[$00].SourceLo,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$2800)>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$2800)>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$08
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_028905
CODE_028901:
	ASL
	DEX
	BNE.b CODE_028901
CODE_028905:
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	STZ.w !REGISTER_VRAMAddressLo
	LDA.b #$78
	STA.w !REGISTER_VRAMAddressHi
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer+$3000
	STA.w DMA[$00].SourceLo,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$3000)>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$3000)>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$08
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_02894A
CODE_028946:
	ASL
	DEX
	BNE.b CODE_028946
CODE_02894A:
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	STZ.w !REGISTER_VRAMAddressLo
	LDA.b #$7C
	STA.w !REGISTER_VRAMAddressHi
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer+$3800
	STA.w DMA[$00].SourceLo,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$3800)>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$3800)>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$08
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_02898F
CODE_02898B:
	ASL
	DEX
	BNE.b CODE_02898B
CODE_02898F:
	STA.w !REGISTER_DMAEnable
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	RTS

CODE_02899B:
	REP.b #$30
	STZ.w $0D63
	STZ.w $0D61
CODE_0289A3:
	STZ.w $0D5F
CODE_0289A6:
	LDY.w #$0000
CODE_0289A9:					; Note: Seems to be used for creating map graphics
	PHY
	SEP.b #$20
	PHB
	LDA.b #DATA_02948E>>16
	PHA
	PLB
	JSR.w CODE_028B34
	SEP.b #$20
	PLB
	PLY
	STA.w $0D57,y
	REP.b #$20
	LDA.w $0D63
	CLC
	ADC.w #$0002
	STA.w $0D63
	INY
	CPY.w #$0008
	BNE.b CODE_0289A9
	JSR.w CODE_02909D
	REP.b #$20
	LDA.w $0D5F
	CLC
	ADC.w #$0008
	STA.w $0D5F
	CMP.w #$0078
	BCC.b CODE_0289A6
	INC.w $0D61
	LDA.w $0D61
	CMP.w #$0064
	BCC.b CODE_0289A3
	RTS

CODE_0289ED:
	JSR.w CODE_029892
	REP.b #$30
	STZ.w $0D63
	STZ.w $0D65
	STZ.w $0D61
CODE_0289FB:
	STZ.w $0D5F
CODE_0289FE:
	LDY.w #$0000
CODE_028A01:
	PHY
	JSR.w CODE_0291EF
	BNE.b CODE_028A14
	SEP.b #$20
	PHB
	LDA.b #DATA_02948E>>16
	PHA
	PLB
	JSR.w CODE_028F11
	SEP.b #$20
	PLB
CODE_028A14:
	SEP.b #$20
	REP.b #$10
	PLY
	STA.w $0D57,y
	REP.b #$20
	LDA.w $0D63
	CLC
	ADC.w #$0002
	STA.w $0D63
	INY
	CPY.w #$0008
	BNE.b CODE_028A01
	JSR.w CODE_02909D
	REP.b #$20
	LDA.w $0D5F
	CLC
	ADC.w #$0008
	STA.w $0D5F
	CMP.w #$0078
	BCC.b CODE_0289FE
	INC.w $0D61
	LDA.w $0D61
	AND.w #$0007
	BNE.b CODE_028A57
	LDA.w $0D65
	CLC
	ADC.w #$000F
	STA.w $0D65
CODE_028A57:
	LDA.w $0D61
	CMP.w #$0064
	BCC.b CODE_0289FB
	JMP.w CODE_02882F

CODE_028A62:
	JSR.w CODE_029892
	REP.b #$30
	STZ.w $0D63
	STZ.w $0D65
	STZ.w $0D61
CODE_028A70:
	STZ.w $0D5F
CODE_028A73:
	STZ.b $79
	LDY.w #$0000
CODE_028A78:
	PHY
	JSR.w CODE_02918F
	BNE.b CODE_028A8B
	SEP.b #$20
	PHB
	LDA.b #DATA_02948E>>16
	PHA
	PLB
	JSR.w CODE_028F11
	SEP.b #$20
	PLB
CODE_028A8B:
	SEP.b #$20
	REP.b #$10
	PLY
	STA.w $0D57,y
	REP.b #$20
	LDA.w $0D63
	CLC
	ADC.w #$0002
	STA.w $0D63
	INC.b $79
	INY
	CPY.w #$0008
	BNE.b CODE_028A78
	JSR.w CODE_02909D
	REP.b #$20
	LDA.w $0D5F
	CLC
	ADC.w #$0008
	STA.w $0D5F
	CMP.w #$0078
	BCC.b CODE_028A73
	INC.w $0D61
	LDA.w $0D61
	LSR
	BCS.b CODE_028ACE
	LDA.w $0D65
	CLC
	ADC.w #$003C
	STA.w $0D65
CODE_028ACE:
	LDA.w $0D61
	CMP.w #$0064
	BCC.b CODE_028A70
	JMP.w CODE_02882F

CODE_028AD9:
	JSR.w CODE_029892
	REP.b #$30
	STZ.w $0D63
	STZ.w $0D61
CODE_028AE4:
	STZ.w $0D5F
CODE_028AE7:
	LDY.w #$0000
CODE_028AEA:
	SEP.b #$20
	REP.b #$10
	PHY
	PHB
	LDA.b #DATA_02948E>>16
	PHA
	PLB
	JSR.w CODE_028F11
	SEP.b #$20
	REP.b #$10
	PLB
	PLY
	STA.w $0D57,y
	REP.b #$20
	LDA.w $0D63
	CLC
	ADC.w #$0002
	STA.w $0D63
	INY
	CPY.w #$0008
	BNE.b CODE_028AEA
	JSR.w CODE_02909D
	REP.b #$20
	LDA.w $0D5F
	CLC
	ADC.w #$0008
	STA.w $0D5F
	CMP.w #$0078
	BCC.b CODE_028AE7
	INC.w $0D61
	LDA.w $0D61
	CMP.w #$0064
	BCC.b CODE_028AE4
	JMP.w CODE_02882F

CODE_028B34:
	REP.b #$30
	LDX.w $0D63
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	AND.w #$03FF
	TAX
	CPX.w #$0030
	BCC.b CODE_028B65
	LDA.w #$0028
	CPX.w #$007F
	BEQ.b CODE_028B65
	CPX.w #$0364
	BEQ.b CODE_028B65
	CPX.w #$0365
	BEQ.b CODE_028B65
	LDA.w #$0001
	CPX.w #$0354
	BEQ.b CODE_028B65
	CPX.w #$0355
	BNE.b CODE_028B97
CODE_028B65:
	TAX
	CPX.w #$0014
	BCC.b CODE_028B93
	CPX.w #$0026
	BCS.b CODE_028B93
	LDA.b $3E
	CMP.w #$0003
	BNE.b CODE_028B93
	LDA.b $40
	CMP.w #$0007
	BNE.b CODE_028B83
	LDX.w #$0014
	BRA.b CODE_028B93

CODE_028B83:
	LDA.w $0B3B
	INC
	AND.w #$000F
	STA.w $0B3B
	TXA
	CLC
	ADC.w $0B3B
	TAX
CODE_028B93:
	LDA.w DATA_02948E,x
	RTS

CODE_028B97:
	CPX.w #$0080
	BCC.b CODE_028BAD
	CPX.w #$0356
	BCC.b CODE_028BD6
	CPX.w #$0364
	BCS.b CODE_028BD6
	TXA
	SEC
	SBC.w #$0326
	BRA.b CODE_028BCD

CODE_028BAD:
	LDA.w $0D49
	CMP.w #$0004
	BNE.b CODE_028BCC
	CPX.w #$003D
	BEQ.b CODE_028BC9
	CPX.w #$003E
	BEQ.b CODE_028BC9
	CPX.w #$0060
	BCC.b CODE_028BCC
	CPX.w #$0070
	BCS.b CODE_028BCC
CODE_028BC9:
	JMP.w CODE_028C93

CODE_028BCC:
	TXA
CODE_028BCD:
	LSR
	LSR
	LSR
	LSR
	TAX
	LDA.w DATA_02937D,x
	RTS

CODE_028BD6:
	CPX.w #$0137
	BCS.b CODE_028BDE
	JMP.w CODE_028CFC

CODE_028BDE:
	CPX.w #$0376
	BCC.b CODE_028BEB
	CPX.w #$039A
	BCS.b CODE_028BEB
	JMP.w CODE_028D5A

CODE_028BEB:
	CPX.w #$01F4
	BCS.b CODE_028BF3
	JMP.w CODE_028D9D

CODE_028BF3:
	CPX.w #$039A
	BCC.b CODE_028C00
	CPX.w #$03BE
	BCS.b CODE_028C00
	JMP.w CODE_028DEC

CODE_028C00:
	CPX.w #$0245
	BCS.b CODE_028C08
	JMP.w CODE_028E2B

CODE_028C08:
	CPX.w #$0257
	BCC.b CODE_028C2A
	CPX.w #$02BB
	BCC.b CODE_028C2D
	CPX.w #$0354
	BCC.b CODE_028C20
	CPX.w #$0376
	BCC.b CODE_028C2D
	LDA.w #$000B
	RTS

CODE_028C20:
	REP.b #$20
	TXA
	SEC
	SBC.w #$02BB
	JMP.w CODE_028E85

CODE_028C2A:
	JMP.w CODE_028E7E

CODE_028C2D:
	CPX.w #$0297
	BCC.b CODE_028C44
	CPX.w #$0366
	BCC.b CODE_028C47
	CPX.w #$0376
	BCS.b CODE_028C47
	TXA
	SEC
	SBC.w #$0366
	JMP.w CODE_028ECD

CODE_028C44:
	JMP.w CODE_028EC6

CODE_028C47:
	CPX.w #$02BB
	BCS.b CODE_028C92
	TAX
	SEC
	SBC.w #$0297
	LDX.w #$0024
	SEP.b #$10
	REP.b #$20
	PHA
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	PLA
	STA.w !REGISTER_DividendLo
	STX.w !REGISTER_Divisor
	PHA
	PLA
	PHA
	PLA
	NOP #2
	LDA.w !REGISTER_ProductOrRemainderLo
	LDY.w !REGISTER_QuotientLo
	PHA
	SEP.b #$20
	LDA.b $B3
	STA.b $B1
	REP.b #$20
	PLA
	REP.b #$30
	TAX
	LDA.w $0D49
	CMP.w #$0004
	BNE.b CODE_028C8E
	JMP.w CODE_028CC0

CODE_028C8E:
	LDA.w DATA_029401,x
	RTS

CODE_028C92:
	RTS

CODE_028C93:
	REP.b #$30
	JSR.w CODE_028CED
	BNE.b CODE_028C9E
	LDA.w #$0005
	RTS

CODE_028C9E:
	LDA.w #$0001
	RTS

CODE_028CA2:
	REP.b #$30
	JSR.w CODE_028CED
	BNE.b CODE_028CAD
	LDA.w DATA_0294BE,x
	RTS

CODE_028CAD:
	LDA.w DATA_0294C7,x
	RTS

CODE_028CB1:
	REP.b #$30
	JSR.w CODE_028CED
	BNE.b CODE_028CBC
	LDA.w DATA_0294D0,x
	RTS

CODE_028CBC:
	LDA.w DATA_0294E0,x
	RTS

CODE_028CC0:
	REP.b #$30
	JSR.w CODE_028CED
	BNE.b CODE_028CCB
	LDA.w DATA_0294F0,x
	RTS

CODE_028CCB:
	LDA.w DATA_029514,x
	RTS

CODE_028CCF:
	REP.b #$30
	JSR.w CODE_028CED
	BNE.b CODE_028CDA
	LDA.w DATA_02955C,x
	RTS

CODE_028CDA:
	LDA.w DATA_02956E,x
	RTS

CODE_028CDE:
	REP.b #$30
	JSR.w CODE_028CED
	BNE.b CODE_028CE9
	LDA.w DATA_029538,x
	RTS

CODE_028CE9:
	LDA.w DATA_02954A,x
	RTS

CODE_028CED:
	REP.b #$30
	PHX
	LDX.w $0D63
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	PLX
	AND.w #$8000
	RTS

CODE_028CFC:
	REP.b #$20
	TXA
	LDX.w #$0001
	SEC
	SBC.w #$0080
	CMP.w #$0009
	BCC.b CODE_028D10
	SBC.w #$0015
	BCC.b CODE_028D42
CODE_028D10:
	LDX.w #$0009
	SEP.b #$10
	REP.b #$20
	PHA
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	PLA
	STA.w !REGISTER_DividendLo
	STX.w !REGISTER_Divisor
	PHA
	PLA
	PHA
	PLA
	NOP #2
	LDA.w !REGISTER_ProductOrRemainderLo
	LDY.w !REGISTER_QuotientLo
	PHA
	SEP.b #$20
	LDA.b $B3
	STA.b $B1
	REP.b #$20
	PLA
	REP.b #$30
	TAX
CODE_028D42:
	LDA.w $0D49
	CMP.w #$0004
	BNE.b CODE_028D4D
	JMP.w CODE_028CA2

CODE_028D4D:
	CMP.w #$0002
	BCS.b CODE_028D56
	LDA.w DATA_029385,x
	RTS

CODE_028D56:
	LDA.w DATA_029425,x
	RTS

CODE_028D5A:
	REP.b #$30
	CPX.w #$0388
	BCS.b CODE_028D7F
	TXA
	SEC
	SBC.w #$0376
	TAX
	LDA.w $0D49
	CMP.w #$0004
	BNE.b CODE_028D72
	JMP.w CODE_028CCF

CODE_028D72:
	CMP.w #$0002
	BCS.b CODE_028D7B
	LDA.w DATA_02938E,x
	RTS

CODE_028D7B:
	LDA.w DATA_029474,x
	RTS

CODE_028D7F:
	TXA
	SEC
	SBC.w #$0388
	TAX
	LDA.w $0D49
	CMP.w #$0004
	BNE.b CODE_028D90
	JMP.w CODE_028CDE

CODE_028D90:
	CMP.w #$0002
	BCS.b CODE_028D99
	LDA.w DATA_02938E,x
	RTS

CODE_028D99:
	LDA.w DATA_029462,x
	RTS

CODE_028D9D:
	REP.b #$30
	TXA
	SEC
	SBC.w #$0137
	LDX.w #$0009
	SEP.b #$10
	REP.b #$20
	PHA
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	PLA
	STA.w !REGISTER_DividendLo
	STX.w !REGISTER_Divisor
	PHA
	PLA
	PHA
	PLA
	NOP #2
	LDA.w !REGISTER_ProductOrRemainderLo
	LDY.w !REGISTER_QuotientLo
	PHA
	SEP.b #$20
	LDA.b $B3
	STA.b $B1
	REP.b #$20
	PLA
	REP.b #$30
	TAX
	LDA.w $0D49
	CMP.w #$0004
	BNE.b CODE_028DE1
	JMP.w CODE_028CA2

CODE_028DE1:
	LSR
	BCS.b CODE_028DE8
	LDA.w DATA_0293B2,x
	RTS

CODE_028DE8:
	LDA.w DATA_029425,x
	RTS

CODE_028DEC:
	CPX.w #$03AC
	BCS.b CODE_028E0D
	TXA
	SEC
	SBC.w #$039A
	TAX
	LDA.w $0D49
	CMP.w #$0004
	BNE.b CODE_028E02
	JMP.w CODE_028CCF

CODE_028E02:
	LSR
	BCS.b CODE_028E09
	LDA.w DATA_0293BB,x
	RTS

CODE_028E09:
	LDA.w DATA_029474,x
	RTS

CODE_028E0D:
	TXA
	SEC
	SBC.w #$03AC
	TAX
	LDA.w $0D49
	CMP.w #$0004
	BNE.b CODE_028E1E
	JMP.w CODE_028CDE

CODE_028E1E:
	AND.w #$0001
	BNE.b CODE_028E27
	LDA.w DATA_0293BB,x
	RTS

CODE_028E27:
	LDA.w DATA_029462,x
	RTS

CODE_028E2B:
	REP.b #$30
	TXA
	SEC
	SBC.w #$01F4
	LDX.w #$0009
	SEP.b #$10
	REP.b #$20
	PHA
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	PLA
	STA.w !REGISTER_DividendLo
	STX.w !REGISTER_Divisor
	PHA
	PLA
	PHA
	PLA
	NOP #2
	LDA.w !REGISTER_ProductOrRemainderLo
	LDY.w !REGISTER_QuotientLo
	PHA
	SEP.b #$20
	LDA.b $B3
	STA.b $B1
	REP.b #$20
	PLA
	REP.b #$30
	TAX
	LDA.w $0D49
	BEQ.b CODE_028E7A
	CMP.w #$0004
	BNE.b CODE_028E71
	JMP.w CODE_028CA2

CODE_028E71:
	CMP.w #$0003
	BEQ.b CODE_028E7A
	LDA.w DATA_029425,x
	RTS

CODE_028E7A:
	LDA.w DATA_0293DF,x
	RTS

CODE_028E7E:
	REP.b #$30
	TXA
	SEC
	SBC.w #$0245
CODE_028E85:
	LDX.w #$0009
	SEP.b #$10
	REP.b #$20
	PHA
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	PLA
	STA.w !REGISTER_DividendLo
	STX.w !REGISTER_Divisor
	PHA
	PLA
	PHA
	PLA
	NOP #2
	LDA.w !REGISTER_ProductOrRemainderLo
	LDY.w !REGISTER_QuotientLo
	PHA
	SEP.b #$20
	LDA.b $B3
	STA.b $B1
	REP.b #$20
	PLA
	REP.b #$30
	TAX
	LDA.w $0D49
	CMP.w #$0004
	BNE.b CODE_028EC2
	JMP.w CODE_028CA2

CODE_028EC2:
	LDA.w DATA_0293E8,x
	RTS

CODE_028EC6:
	REP.b #$30
	TXA
	SEC
	SBC.w #$0257
CODE_028ECD:
	LDY.w #$0006
	LDX.w #$0010
	SEP.b #$10
	REP.b #$20
	PHA
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	PLA
	STA.w !REGISTER_DividendLo
	STX.w !REGISTER_Divisor
	PHA
	PLA
	PHA
	PLA
	NOP #2
	LDA.w !REGISTER_ProductOrRemainderLo
	LDY.w !REGISTER_QuotientLo
	PHA
	SEP.b #$20
	LDA.b $B3
	STA.b $B1
	REP.b #$20
	PLA
	REP.b #$30
	TAX
	LDA.w $0D49
	CMP.w #$0004
	BNE.b CODE_028F0D
	JMP.w CODE_028CB1

CODE_028F0D:
	LDA.w DATA_0293F1,x
	RTS

CODE_028F11:
	REP.b #$30
	LDX.w $0D63
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	AND.w #$03FF
	TAX
	CPX.w #$0030
	BCC.b CODE_028F3A
	CPX.w #$007F
	BNE.b CODE_028F2D
	LDX.w #$0028
	BRA.b CODE_028F3A

CODE_028F2D:
	CPX.w #$0364
	BCC.b CODE_028F3E
	CPX.w #$0366
	BCS.b CODE_028F3E
	LDX.w #$0028
CODE_028F3A:
	LDA.w DATA_02948E,x
	RTS

CODE_028F3E:
	CPX.w #$0080
	BCC.b CODE_028F54
	CPX.w #$0356
	BCC.b CODE_028F6A
	CPX.w #$0364
	BCS.b CODE_028F6A
	TXA
	SEC
	SBC.w #$0326
	BRA.b CODE_028F55

CODE_028F54:
	TXA
CODE_028F55:
	LSR
	LSR
	LSR
	LSR
	TAX
	LDA.w $0D49
	CMP.w #$0005
	BEQ.b CODE_028F66
	LDA.w DATA_02937D,x
	RTS

CODE_028F66:
	LDA.w DATA_029486,x
	RTS

CODE_028F6A:
	CPX.w #$0257
	BCC.b CODE_028F82
	CPX.w #$02BB
	BCC.b CODE_028FCC
	CPX.w #$0354
	BCS.b CODE_028FCC
	REP.b #$20
	TXA
	SEC
	SBC.w #$02BB
	BRA.b CODE_028F96

CODE_028F82:
	REP.b #$20
	TXA
	SEC
	SBC.w #$0080
	LDX.w #$0000
	CMP.w #$0009
	BCC.b CODE_028F96
	SBC.w #$0015
	BCC.b CODE_028FC8
CODE_028F96:
	LDX.w #$0009
	SEP.b #$10
	REP.b #$20
	PHA
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	PLA
	STA.w !REGISTER_DividendLo
	STX.w !REGISTER_Divisor
	PHA
	PLA
	PHA
	PLA
	NOP #2
	LDA.w !REGISTER_ProductOrRemainderLo
	LDY.w !REGISTER_QuotientLo
	PHA
	SEP.b #$20
	LDA.b $B3
	STA.b $B1
	REP.b #$20
	PLA
	REP.b #$30
	TAX
CODE_028FC8:
	LDA.w DATA_029425,x
	RTS

CODE_028FCC:
	CPX.w #$0297
	BCC.b CODE_028FE2
	CPX.w #$0366
	BCC.b CODE_029020
	CPX.w #$0376
	BCS.b CODE_029020
	TXA
	SEC
	SBC.w #$0366
	BRA.b CODE_028FE7

CODE_028FE2:
	TXA
	SEC
	SBC.w #$0257
CODE_028FE7:
	LDY.w #$0006
	LDX.w #$0010
	SEP.b #$10
	REP.b #$20
	PHA
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	PLA
	STA.w !REGISTER_DividendLo
	STX.w !REGISTER_Divisor
	PHA
	PLA
	PHA
	PLA
	NOP #2
	LDA.w !REGISTER_ProductOrRemainderLo
	LDY.w !REGISTER_QuotientLo
	PHA
	SEP.b #$20
	LDA.b $B3
	STA.b $B1
	REP.b #$20
	PLA
	REP.b #$30
	TAX
	LDA.w DATA_02942E,x
	RTS

CODE_029020:
	CPX.w #$02BB
	BCS.b CODE_029060
	TAX
	SEC
	SBC.w #$0297
	LDX.w #$0024
	SEP.b #$10
	REP.b #$20
	PHA
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	PLA
	STA.w !REGISTER_DividendLo
	STX.w !REGISTER_Divisor
	PHA
	PLA
	PHA
	PLA
	NOP #2
	LDA.w !REGISTER_ProductOrRemainderLo
	LDY.w !REGISTER_QuotientLo
	PHA
	SEP.b #$20
	LDA.b $B3
	STA.b $B1
	REP.b #$20
	PLA
	REP.b #$30
	TAX
	LDA.w DATA_02943E,x
	RTS

CODE_029060:
	CPX.w #$0376
	BCC.b CODE_02909C
	CPX.w #$0388
	BCC.b CODE_02908B
	CPX.w #$039A
	BCC.b CODE_029079
	CPX.w #$03AC
	BCC.b CODE_02908B
	CPX.w #$03BE
	BCS.b CODE_02909C
CODE_029079:
	TXA
	SBC.w #$0388
	CMP.w #$0012
	BCC.b CODE_029086
	TXA
	SBC.w #$03AC
CODE_029086:
	TAX
	LDA.w DATA_029462,x
	RTS

CODE_02908B:
	TXA
	SBC.w #$0376
	CMP.w #$0012
	BCC.b CODE_029098
	TXA
	SBC.w #$039A
CODE_029098:
	TAX
	LDA.w DATA_029474,x
CODE_02909C:
	RTS

CODE_02909D:
	JSR.w CODE_029136
	REP.b #$30
	TAX
	SEP.b #$20
	LSR.w $0D57
	ROL
	LSR.w $0D58
	ROL
	LSR.w $0D59
	ROL
	LSR.w $0D5A
	ROL
	LSR.w $0D5B
	ROL
	LSR.w $0D5C
	ROL
	LSR.w $0D5D
	ROL
	LSR.w $0D5E
	ROL
	STA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$2000,x
	LSR.w $0D57
	ROL
	LSR.w $0D58
	ROL
	LSR.w $0D59
	ROL
	LSR.w $0D5A
	ROL
	LSR.w $0D5B
	ROL
	LSR.w $0D5C
	ROL
	LSR.w $0D5D
	ROL
	LSR.w $0D5E
	ROL
	STA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$2001,x
	LSR.w $0D57
	ROL
	LSR.w $0D58
	ROL
	LSR.w $0D59
	ROL
	LSR.w $0D5A
	ROL
	LSR.w $0D5B
	ROL
	LSR.w $0D5C
	ROL
	LSR.w $0D5D
	ROL
	LSR.w $0D5E
	ROL
	STA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$2010,x
	LSR.w $0D57
	ROL
	LSR.w $0D58
	ROL
	LSR.w $0D59
	ROL
	LSR.w $0D5A
	ROL
	LSR.w $0D5B
	ROL
	LSR.w $0D5C
	ROL
	LSR.w $0D5D
	ROL
	LSR.w $0D5E
	ROL
	STA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$2011,x
	RTS

CODE_029136:
	SEP.b #$10
	REP.b #$20
	LDA.w $0D5F
	AND.w #$00F8
	ASL
	ASL
	STA.b $79
	LDA.w $0D61
	CLC
	ADC.w #$0012
	LSR
	LSR
	LSR
	SEP.b #$20
	XBA
	LDA.b #$02
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	XBA
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	SEP.b #$30
	XBA
	REP.b #$20
	CLC
	ADC.b $79
	STA.b $79
	LDA.w $0D61
	CLC
	ADC.w #$0012
	AND.w #$0007
	ASL
	CLC
	ADC.b $79
	RTS

CODE_02918F:
	LDA.b $79
	CLC
	ADC.w $0D5F
	LSR
	CLC
	ADC.w $0D65
	TAX
	SEP.b #$20
	LDA.w $0D49
	CMP.b #$0B
	BEQ.b CODE_0291CC
	CMP.b #$0A
	BEQ.b CODE_0291C5
	CMP.b #$09
	BEQ.b CODE_0291BE
	CMP.b #$08
	BEQ.b CODE_0291B7
	LDA.l $7F8E28,x
	BNE.b CODE_0291D2
	RTS

CODE_0291B7:
	LDA.l $7F99E0,x
	BNE.b CODE_0291D2
	RTS

CODE_0291BE:
	LDA.l $7F8270,x
	BNE.b CODE_0291D2
	RTS

CODE_0291C5:
	LDA.l $7F76B8,x
	BNE.b CODE_0291D2
	RTS

CODE_0291CC:
	LDA.l $7F6B00,x
	BEQ.b CODE_0291EE
CODE_0291D2:
	SEP.b #$10
	LSR
	ADC.b #$00
	LSR
	ADC.b #$00
	LSR
	ADC.b #$00
	LSR
	ADC.b #$00
	LSR
	ADC.b #$00
	CMP.b #$08
	BCC.b CODE_0291E9
	LDA.b #$08
CODE_0291E9:
	TAX
	LDA.l DATA_00AA75,x
CODE_0291EE:
	RTS

CODE_0291EF:
	LDA.w $0D5F
	LSR
	LSR
	LSR
	CLC
	ADC.w $0D65
	TAX
	SEP.b #$20
	LDA.w $0D49
	CMP.b #$0D
	BEQ.b CODE_029215
	CMP.b #$0C
	BEQ.b CODE_02921C
	REP.b #$20
	TXA
	ASL
	TAX
	SEP.b #$20
	LDA.l $7FAE62,x
	BNE.b CODE_029222
	RTS

CODE_029215:
	LDA.l $7FB0AB,x
	BNE.b CODE_029222
	RTS

CODE_02921C:
	LDA.l $7FAFE8,x
	BEQ.b CODE_02923E
CODE_029222:
	SEP.b #$10
	LSR
	ADC.b #$00
	LSR
	ADC.b #$00
	LSR
	ADC.b #$00
	LSR
	ADC.b #$00
	LSR
	ADC.b #$00
	CMP.b #$08
	BCC.b CODE_029239
	LDA.b #$08
CODE_029239:
	TAX
	LDA.l DATA_00AA75,x
CODE_02923E:
	RTS

CODE_02923F:
	JSR.w CODE_029243
	RTL

CODE_029243:					; Note: Map generation related.
	REP.b #$30
	LDX.w #$1BFE
	LDA.w #$0000
CODE_02924B:
	STA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$2400,x
	DEX
	DEX
	BPL.b CODE_02924B
	JSR.w CODE_02899B
	SEP.b #$20
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	JSL.l CODE_008206
	STZ.w !REGISTER_VRAMAddressLo
	LDA.b #$20
	STA.w !REGISTER_VRAMAddressHi
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer+$2000
	STA.w DMA[$00].SourceLo,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$2000)>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$2000)>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$08
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_0292A2
CODE_02929E:
	ASL
	DEX
	BNE.b CODE_02929E
CODE_0292A2:
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	STZ.w !REGISTER_VRAMAddressLo
	LDA.b #$24
	STA.w !REGISTER_VRAMAddressHi
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer+$2800
	STA.w DMA[$00].SourceLo,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$2800)>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$2800)>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$08
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_0292E7
CODE_0292E3:
	ASL
	DEX
	BNE.b CODE_0292E3
CODE_0292E7:
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	STZ.w !REGISTER_VRAMAddressLo
	LDA.b #$28
	STA.w !REGISTER_VRAMAddressHi
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer+$3000
	STA.w DMA[$00].SourceLo,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$3000)>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$3000)>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$08
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_02932C
CODE_029328:
	ASL
	DEX
	BNE.b CODE_029328
CODE_02932C:
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	STZ.w !REGISTER_VRAMAddressLo
	LDA.b #$2C
	STA.w !REGISTER_VRAMAddressHi
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer+$3800
	STA.w DMA[$00].SourceLo,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$3800)>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$3800)>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$08
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_029371
CODE_02936D:
	ASL
	DEX
	BNE.b CODE_02936D
CODE_029371:
	STA.w !REGISTER_DMAEnable
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	RTS

DATA_02937D:
	db $08,$08,$08,$08,$08,$08,$0B,$08

DATA_029385:
	db $0C,$03,$03,$0C,$03,$03,$0C,$0C,$0C

DATA_02938E:
	db $0C,$03,$03,$03,$03,$03,$0C,$03,$03,$03,$03,$03,$0C,$0C,$0C,$0C
	db $0C,$0C,$0C,$03,$03,$0C,$03,$03,$0C,$03,$03,$0C,$03,$03,$0C,$03
	db $03,$0C,$0C,$0C

DATA_0293B2:
	db $0C,$04,$04,$0C,$04,$04,$0C,$0C,$0C

DATA_0293BB:
	db $0C,$04,$04,$04,$04,$04,$0C,$04,$04,$04,$04,$04,$0C,$0C,$0C,$0C
	db $0C,$0C,$0C,$04,$04,$0C,$04,$04,$0C,$04,$04,$0C,$04,$04,$0C,$04
	db $04,$0C,$0C,$0C

DATA_0293DF:
	db $0C,$05,$05,$0C,$05,$05,$0C,$0C,$0C

DATA_0293E8:
	db $0C,$06,$06,$0C,$06,$06,$0C,$0C,$0C

DATA_0293F1:
	db $0C,$06,$06,$06,$0C,$06,$06,$06,$0C,$06,$06,$06,$0C,$0C,$0C,$0C

DATA_029401:
	db $0C,$06,$06,$06,$06,$06,$0C,$06,$06,$06,$06,$06,$0C,$06,$06,$06
	db $06,$06,$0C,$06,$06,$06,$06,$06,$0C,$06,$06,$06,$06,$06,$0C,$0C
	db $0C,$0C,$0C,$06

DATA_029425:
	db $0C,$0A,$0A,$0C,$0A,$0A,$0C,$0C,$0C

DATA_02942E:
	db $0C,$0A,$0A,$0A,$0C,$0A,$0A,$0A,$0C,$0A,$0A,$0A,$0C,$0C,$0C,$0C

DATA_02943E:
	db $0C,$0A,$0A,$0A,$0A,$0A,$0C,$0A,$0A,$0A,$0A,$0A,$0C,$0A,$0A,$0A
	db $0A,$0A,$0C,$0A,$0A,$0A,$0A,$0A,$0C,$0A,$0A,$0A,$0A,$0A,$0C,$0C
	db $0C,$0C,$0C,$0C

DATA_029462:
	db $0C,$0A,$0A,$0C,$0A,$0A,$0C,$0A,$0A,$0C,$0A,$0A,$0C,$0A,$0A,$0C
	db $0C,$0C

DATA_029474:
	db $0C,$0A,$0A,$0C,$0A,$0A,$0C,$0C,$0C,$0A,$0A,$0A,$0A,$0A,$0A,$0C
	db $0C,$0C

DATA_029486:
	db $00,$00,$00,$07,$07,$07,$0B,$09

DATA_02948E:
	db $0B,$0D,$0D,$0D,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
	db $0B,$0B,$0B,$0B,$08,$0B,$0A,$0B,$0D,$0B,$08,$0B,$0A,$0B,$0A,$0D
	db $08,$0A,$0A,$0B,$0A,$0D,$0E,$0E,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B

DATA_0294BE:
	db $06,$05,$05,$06,$05,$05,$06,$06,$06

DATA_0294C7:
	db $02,$01,$01,$02,$01,$01,$02,$02,$02

DATA_0294D0:
	db $06,$05,$05,$05,$06,$05,$05,$05,$06,$05,$05,$05,$06,$06,$06,$06

DATA_0294E0:
	db $02,$01,$01,$01,$02,$01,$01,$01,$02,$01,$01,$01,$02,$02,$02,$02

DATA_0294F0:
	db $06,$05,$05,$05,$05,$05,$06,$05,$05,$05,$05,$05,$06,$05,$05,$05
	db $05,$05,$06,$05,$05,$05,$05,$05,$06,$05,$05,$05,$05,$05,$06,$06
	db $06,$06,$06,$06

DATA_029514:
	db $02,$01,$01,$01,$01,$01,$02,$01,$01,$01,$01,$01,$02,$01,$01,$01
	db $01,$01,$02,$01,$01,$01,$01,$01,$02,$01,$01,$01,$01,$01,$02,$02
	db $02,$02,$02,$02

DATA_029538:
	db $06,$05,$05,$06,$05,$05,$06,$05,$05,$06,$05,$05,$06,$05,$05,$06
	db $06,$06

DATA_02954A:
	db $02,$01,$01,$02,$01,$01,$02,$01,$01,$02,$01,$01,$02,$01,$01,$02
	db $02,$02

DATA_02955C:
	db $06,$05,$05,$06,$05,$05,$06,$06,$06,$05,$05,$05,$05,$05,$05,$06
	db $06,$06

DATA_02956E:
	db $02,$01,$01,$02,$01,$01,$02,$02,$02,$01,$01,$01,$01,$01,$01,$02
	db $02,$02,$02,$01,$01,$02,$01,$01,$02,$02,$02

CODE_029589:
	REP.b #$20
	LDA.w $01BD
	CLC
	ADC.w #$0046
	STA.w $0D33
	LDA.w $01BF
	CLC
	ADC.w #$0032
	STA.w $0D35
	RTS

CODE_0295A0:
	JSR.w CODE_029F7C
	JSR.w CODE_02980C
	JSR.w CODE_029731
	JSR.w CODE_0296F4
	JSR.w CODE_02A068
	JSR.w CODE_0295B6
	JSR.w CODE_0295EC
	RTS

CODE_0295B6:
	REP.b #$20
	LDA.w #$00D0
	STA.w $0253
	LDA.w #$003C
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w #$0020
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$0022
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	SEP.b #$20
	LDA.b #$00
	STA.l SIMC_Global_UpperOAMBuffer[$0D].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$0E].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$0F].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$10].Slot
	RTS

CODE_0295EC:
	SEP.b #$20
	REP.b #$10
	LDA.w $0D49
	LDX.w $0D51
	BEQ.b CODE_0295FB
	LDA.w $0D4D
CODE_0295FB:
	CMP.b #$04
	BCC.b CODE_029600
	RTS

CODE_029600:
	LDA.w $0A8D
	BEQ.b CODE_029619
	LDY.w #$0050
	LDX.w #$0010
	LDA.b #$FC
	JSR.w CODE_0296AB
	REP.b #$20
	LDA.w #$32ED
	STA.l SIMC_Global_OAMBuffer[$14].Tile
CODE_029619:
	SEP.b #$20
	REP.b #$10
	LDA.w $0A93
	BEQ.b CODE_029636
	LDY.w #$0060
	LDX.w #$0004
	LDA.b #$FC
	JSR.w CODE_0296AB
	REP.b #$20
	LDA.w #$32EA
	STA.l SIMC_Global_OAMBuffer[$18].Tile
CODE_029636:
	SEP.b #$20
	REP.b #$10
	LDA.w $0A95
	BEQ.b CODE_029653
	LDY.w #$0064
	LDX.w #$0014
	LDA.b #$F3
	JSR.w CODE_0296AB
	REP.b #$20
	LDA.w #$32EC
	STA.l SIMC_Global_OAMBuffer[$19].Tile
CODE_029653:
	SEP.b #$20
	REP.b #$10
	LDA.w $0A8F
	BEQ.b CODE_029670
	LDX.w #$000C
	LDY.w #$0054
	LDA.b #$F3
	JSR.w CODE_0296AB
	REP.b #$20
	LDA.w #$32E9
	STA.l SIMC_Global_OAMBuffer[$15].Tile
CODE_029670:
	SEP.b #$20
	REP.b #$10
	LDA.w $0A8B
	BEQ.b CODE_02968D
	LDX.w #$0008
	LDY.w #$0058
	LDA.b #$CF
	JSR.w CODE_0296AB
	REP.b #$20
	LDA.w #$32EB
	STA.l SIMC_Global_OAMBuffer[$16].Tile
CODE_02968D:
	SEP.b #$20
	REP.b #$10
	LDA.w $0A91
	BEQ.b CODE_0296AA
	LDX.w #$0000
	LDY.w #$005C
	LDA.b #$3F
	JSR.w CODE_0296AB
	REP.b #$20
	LDA.w #$32EE
	STA.l SIMC_Global_OAMBuffer[$17].Tile
CODE_0296AA:
	RTS

CODE_0296AB:
	SEP.b #$20
	REP.b #$10
	STA.b $79
	LDA.w $0A4F,x
	CLC
	ADC.b #$30
	CMP.b #$2F
	BCS.b CODE_0296BF
	LDA.b #$2F
	BRA.b CODE_0296C5

CODE_0296BF:
	CMP.b #$8F
	BCC.b CODE_0296C5
	LDA.b #$8F
CODE_0296C5:
	XBA
	LDA.w $0A51,x
	CLC
	ADC.b #$42
	CMP.b #$43
	BCS.b CODE_0296D4
	LDA.b #$43
	BRA.b CODE_0296DA

CODE_0296D4:
	CMP.b #$B5
	BCC.b CODE_0296DA
	LDA.b #$B5
CODE_0296DA:
	TYX
	REP.b #$20
	STA.l SIMC_Global_OAMBuffer[$00].XDisp,x
	SEP.b #$30
	TYA
	LSR
	LSR
	LSR
	LSR
	TAX
	LDA.l SIMC_Global_UpperOAMBuffer[$00].Slot,x
	AND.b $79
	STA.l SIMC_Global_UpperOAMBuffer[$00].Slot,x
	RTS

CODE_0296F4:
	SEP.b #$10
	REP.b #$20
	LDX.b #$20
	LDA.w $0D49
	CMP.w #$0005
	BCC.b CODE_029730
	BNE.b CODE_029706
	LDX.b #$2D
CODE_029706:
	STX.w $0261
	LDA.w #$0084
	STA.w $0253
	LDA.w #$00C0
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w #$0030
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	SEP.b #$20
	LDA.l SIMC_Global_UpperOAMBuffer[$08].Slot
	AND.b #$03
	ORA.b #$A8
	STA.l SIMC_Global_UpperOAMBuffer[$08].Slot
CODE_029730:
	RTS

CODE_029731:
	REP.b #$20
	LDA.w #$0070
	STA.w $0253
	LDA.w #$0038
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w #$00A5
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$001F
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	SEP.b #$20
	LDA.b #$AA
	STA.l SIMC_Global_UpperOAMBuffer[$07].Slot
	LDA.l SIMC_Global_UpperOAMBuffer[$08].Slot
	AND.b #$FC
	ORA.b #$02
	STA.l SIMC_Global_UpperOAMBuffer[$08].Slot
	RTS

CODE_029767:
	SEP.b #$30
	LDA.w $0D51
	BEQ.b CODE_0297AD
	PHB
	LDA.b #DATA_0297AE>>16
	PHA
	PLB
	LDA.w $0D49
	ASL
	TAX
	REP.b #$20
	LDA.w DATA_0286A4,x
	ASL
	TAX
	LDA.w #$0068
	STA.w $0253
	LDA.w DATA_0297AE,x
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w #$00AC
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$001E
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	SEP.b #$20
	LDA.l SIMC_Global_UpperOAMBuffer[$06].Slot
	AND.b #$0F
	ORA.b #$A0
	STA.l SIMC_Global_UpperOAMBuffer[$06].Slot
	PLB
CODE_0297AD:
	RTS

DATA_0297AE:
	dw $0038,$0020,$0060,$00B0

CODE_0297B6:
	REP.b #$20
	LDA.w #$0020
	STA.w $0253
	LDA.w $0D33
	CMP.w #$0043
	BCC.b CODE_0297D0
	CMP.w #$00A1
	BCC.b CODE_0297D3
	LDA.w #$00A1
	BRA.b CODE_0297D3

CODE_0297D0:
	LDA.w #$0043
CODE_0297D3:
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w $0D35
	CMP.w #$0031
	BCC.b CODE_0297E8
	CMP.w #$007C
	BCC.b CODE_0297EB
	LDA.w #$007C
	BRA.b CODE_0297EB

CODE_0297E8:
	LDA.w #$0031
CODE_0297EB:
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$001D
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	SEP.b #$20
	LDA.b #$00
	STA.l SIMC_Global_UpperOAMBuffer[$02].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$03].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$04].Slot
	RTS

CODE_02980C:
	REP.b #$20
	LDA.w #$0010
	STA.w $0253
	LDA.w $0D33
	CMP.w #$0043
	BCC.b CODE_029826
	CMP.w #$00A1
	BCC.b CODE_029829
	LDA.w #$00A1
	BRA.b CODE_029829

CODE_029826:
	LDA.w #$0043
CODE_029829:
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w $0D35
	CMP.w #$0031
	BCC.b CODE_02983E
	CMP.w #$007C
	BCC.b CODE_029841
	LDA.w #$007C
	BRA.b CODE_029841

CODE_02983E:
	LDA.w #$0031
CODE_029841:
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$001C
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	SEP.b #$20
	LDA.b #$00
	STA.l SIMC_Global_UpperOAMBuffer[$01].Slot
	RTS

CODE_02985A:
	SEP.b #$30
	LDX.b #$6C
	LDA.b #$E0
CODE_029860:
	STA.l SIMC_Global_OAMBuffer[$00].YDisp,x
	DEX
	DEX
	DEX
	DEX
	BPL.b CODE_029860
	LDX.b #$06
	LDA.b #$55
CODE_02986E:
	STA.l SIMC_Global_UpperOAMBuffer[$00].Slot,x
	DEX
	BPL.b CODE_02986E
	RTS

CODE_029876:
	SEP.b #$30
	LDX.b #$8C
	LDA.b #$E0
CODE_02987C:
	STA.l SIMC_Global_OAMBuffer[$00].YDisp,x
	DEX
	DEX
	DEX
	DEX
	BPL.b CODE_02987C
	LDX.b #$08
	LDA.b #$55
CODE_02988A:
	STA.l SIMC_Global_UpperOAMBuffer[$00].Slot,x
	DEX
	BPL.b CODE_02988A
	RTS

CODE_029892:
	REP.b #$30
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0AD381
	STX.b $09
	LDA.b #DATA_0AD381>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	LDA.w $0D49
	ASL
	TAX
	LDA.l DATA_00AA7E,x
	TAX
	PHB
	LDY.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$2000
	LDA.w #$03FF
	MVN (!RAM_SIMC_Global_GeneralPurposeBuffer+$2000)>>16,(!RAM_SIMC_Global_GeneralPurposeBuffer+$4000)>>16
	PLB
	REP.b #$30
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0AF80B
	STX.b $09
	LDA.b #DATA_0AF80B>>16
	STA.b $0B
	LDX.w #$4000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	LDA.w $0D49
	ASL
	TAX
	LDA.l DATA_00AA9A,x
	TAX
	PHB
	LDY.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$0800
	LDA.w #$07FF
	MVN (!RAM_SIMC_Global_GeneralPurposeBuffer+$0800)>>16,(!RAM_SIMC_Global_GeneralPurposeBuffer+$4000)>>16
	PLB
	RTS

CODE_0298F3:
	REP.b #$30
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0AFCE1
	STX.b $09
	LDA.b #DATA_0AFCE1>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	RTS

CODE_02990F:
	RTS

CODE_029910:
	REP.b #$20
	LDA.w #$0010
	STA.w $0253
	LDA.w #$0040
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w #$00A9
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$0021
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	SEP.b #$20
	LDA.b #$AA
	STA.l SIMC_Global_UpperOAMBuffer[$01].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$02].Slot
	SEP.b #$30
	LDY.b #$00
	LDX.b #$18
CODE_029943:
	PHX
	PHY
	LDA.w $0B1F,y
	JSR.w CODE_02A0CB
	PLY
	PLX
	INX
	INY
	CPY.b #$08
	BCC.b CODE_029943
	JSL.l CODE_01C8C4
	RTS

CODE_029958:
	REP.b #$30
	LDA.w $01ED
	CMP.w #$00A8
	BCC.b CODE_029976
	CMP.w #$00B8
	BCS.b CODE_029976
	LDA.w $01EB
	SEC
	SBC.w #$0040
	BCC.b CODE_029976
	CMP.w #$0080
	BCS.b CODE_029976
	RTS

CODE_029976:
	SEC
	RTS

CODE_029978:
	REP.b #$30
	LDX.w #$FFFF
	LDA.w $01EB
	SEC
	SBC.w #$0040
CODE_029984:
	INX
	SBC.w #$0010
	BCS.b CODE_029984
	STX.w $0DAF
	SEP.b #$30
	CPX.b #$06
	BCC.b CODE_0299B0
	LDA.w $0B1F,x
	BNE.b CODE_0299D3
	PHP
	JSL.l CODE_0098A0	: dw $0102
	PLP
	SEP.b #$30
	LDA.w $0B25
	LDY.w $0B26
	STY.w $0B25
	STA.w $0B26
	CLC
	RTS

CODE_0299B0:
	LDA.w $0B1F,x
	BEQ.b CODE_0299C4
	EOR.b #$01
	STA.w $0B1F,x
	PHP
	JSL.l CODE_0098A0	: dw $0603
	PLP
	SEC
	RTS

CODE_0299C4:
	EOR.b #$01
	STA.w $0B1F,x
	PHP
	JSL.l CODE_0098A0	: dw $0102
	PLP
	CLC
	RTS

CODE_0299D3:
	SEC
	RTS

CODE_0299D5:
	SEP.b #$30
	LDY.w $0DAF
	TYA
	CLC
	ADC.b #$18
	TAX
	LDA.w $0B1F,y
	JSR.w CODE_02A0CB
	SEP.b #$30
	LDA.w $0DAF
	CMP.b #$06
	BCC.b CODE_0299F9
	EOR.b #$01
	CLC
	ADC.b #$18
	TAX
	LDA.b #$00
	JSR.w CODE_02A0CB
CODE_0299F9:
	JSL.l CODE_01C8C4
	RTS

CODE_0299FE:
	SEP.b #$20
	LDA.l SIMC_Global_UpperOAMBuffer[$02].Slot
	AND.b #$03
	STA.l SIMC_Global_UpperOAMBuffer[$02].Slot
	LDA.b #$00
	STA.l SIMC_Global_UpperOAMBuffer[$03].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$04].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$05].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$06].Slot
	LDA.l SIMC_Global_UpperOAMBuffer[$07].Slot
	AND.b #$FC
	STA.l SIMC_Global_UpperOAMBuffer[$07].Slot
	LDA.w $0B25
	BEQ.b CODE_029A98
	REP.b #$20
	LDA.w $0DA9
	STA.b $79
	LSR
	LDA.w #$0018
	BCC.b CODE_029A3D
	DEC.b $79
	LDA.w #$000C
CODE_029A3D:
	SEC
	SBC.w $0DAD
	CMP.w #$000A
	BCS.b CODE_029A4D
	ADC.w #$0018
	INC.b $79
	INC.b $79
CODE_029A4D:
	PHA
	INC.b $79
	INC.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	PLA
	STA.b $79
	SEP.b #$30
	LDX.b #$24
CODE_029A60:
	JSR.w CODE_029B95
	JSR.w CODE_029B33
	SEP.b #$30
	PHX
	PHB
	LDA.b #DATA_029B30>>16
	PHA
	PLB
	LDX.b #$00
CODE_029A70:
	LDA.w $0D95,x
	CLC
	ADC.w DATA_029B30,x
	STA.w $0D95,x
	SEC
	SBC.b #$0A
	BCC.b CODE_029A85
	STA.w $0D95,x
	INC.w $0D96,x
CODE_029A85:
	INX
	CPX.b #$03
	BCC.b CODE_029A70
	PLB
	PLX
	LDA.b $79
	CLC
	ADC.b #$18
	STA.b $79
	CPX.b #$74
	BCC.b CODE_029A60
	RTS

CODE_029A98:
	SEP.b #$10
	REP.b #$20
	LDA.w $0DAB
	LDX.b #$0A
	SEP.b #$10
	REP.b #$20
	PHA
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	PLA
	STA.w !REGISTER_DividendLo
	STX.w !REGISTER_Divisor
	PHA
	PLA
	PHA
	PLA
	NOP #2
	LDA.w !REGISTER_ProductOrRemainderLo
	LDY.w !REGISTER_QuotientLo
	PHA
	SEP.b #$20
	LDA.b $B3
	STA.b $B1
	REP.b #$20
	PLA
	REP.b #$20
	AND.w #$00FF
	STA.b $7C
	LDA.w $0DAB
	CLC
	ADC.w #$0014
	SEC
	SBC.b $7C
	STA.b $79
	LDA.w #$0014
	SEC
	SBC.b $7C
	PHA
	STZ.b $7C
	JSR.w CODE_02B351
	SEP.b #$10
	REP.b #$20
	PLA
	STA.b $79
	LDX.b #$24
CODE_029AF5:
	JSR.w CODE_029B95
	JSR.w CODE_029B33
	SEP.b #$30
	PHX
	PHB
	LDA.b #DATA_029B2D>>16
	PHA
	PLB
	LDX.b #$00
CODE_029B05:
	LDA.w $0D95,x
	CLC
	ADC.w DATA_029B2D,x
	STA.w $0D95,x
	SEC
	SBC.b #$0A
	BCC.b CODE_029B1A
	STA.w $0D95,x
	INC.w $0D96,x
CODE_029B1A:
	INX
	CPX.b #$03
	BCC.b CODE_029B05
	PLB
	PLX
	LDA.b $79
	CLC
	ADC.b #$19
	STA.b $79
	CPX.b #$74
	BCC.b CODE_029AF5
	RTS

DATA_029B2D:
	db $05,$02,$00

DATA_029B30:
	db $02,$00,$00

CODE_029B33:
	SEP.b #$30
	LDA.b #$38
	CLC
	ADC.b $79
	STA.l SIMC_Global_OAMBuffer[$00].XDisp,x
	LDA.b #$8B
	STA.l SIMC_Global_OAMBuffer[$00].YDisp,x
	LDA.w $0D98
	CLC
	ADC.b #$90
	JSR.w CODE_029BA8
	LDA.b #$3C
	CLC
	ADC.b $79
	STA.l SIMC_Global_OAMBuffer[$00].XDisp,x
	LDA.b #$8B
	STA.l SIMC_Global_OAMBuffer[$00].YDisp,x
	LDA.w $0D97
	CLC
	ADC.b #$90
	JSR.w CODE_029BA8
	LDA.b #$40
	CLC
	ADC.b $79
	STA.l SIMC_Global_OAMBuffer[$00].XDisp,x
	LDA.b #$8B
	STA.l SIMC_Global_OAMBuffer[$00].YDisp,x
	LDA.w $0D96
	CLC
	ADC.b #$90
	JSR.w CODE_029BA8
	LDA.b #$44
	CLC
	ADC.b $79
	STA.l SIMC_Global_OAMBuffer[$00].XDisp,x
	LDA.b #$8B
	STA.l SIMC_Global_OAMBuffer[$00].YDisp,x
	LDA.w $0D95
	CLC
	ADC.b #$90
	JMP.w CODE_029BA8

CODE_029B95:
	SEP.b #$30
	LDA.b #$44
	CLC
	ADC.b $79
	STA.l SIMC_Global_OAMBuffer[$00].XDisp,x
	LDA.b #$82
	STA.l SIMC_Global_OAMBuffer[$00].YDisp,x
	LDA.b #$9A
CODE_029BA8:
	STA.l SIMC_Global_OAMBuffer[$00].Tile,x
	LDA.b #$3C
	STA.l SIMC_Global_OAMBuffer[$00].Prop,x
	TXA
	CLC
	ADC.b #$04
	TAX
	RTS

CODE_029BB8:
	SEP.b #$20
	LDA.w $0DAF
	CMP.b #$06
	BCS.b CODE_029BC7
	JSR.w CODE_029BF1
	JMP.w CODE_029DD5

CODE_029BC7:
	JSR.w CODE_0299FE
	JSR.w CODE_0298F3
	SEP.b #$10
	LDX.b #$00
CODE_029BD1:
	SEP.b #$30
	LDA.w $0B1F,x
	BEQ.b CODE_029BE9
	PHX
	STX.w $0DAF
	JSR.w CODE_029BF1
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	SEP.b #$10
	PLX
CODE_029BE9:
	INX
	CPX.b #$06
	BCC.b CODE_029BD1
	JMP.w CODE_029DD5

CODE_029BF1:
	REP.b #$20
	LDA.w #$00FA
	STA.b $82
	LDA.w $0DAF
	CMP.w #$0003
	BCS.b CODE_029C12
	LDA.w $0C63
	STA.b $82
	LDA.w $0B25
	AND.w #$00FF
	BNE.b CODE_029C12
	LDA.w $0C6B
	STA.b $82
CODE_029C12:
	SEP.b #$20
	LDA.w $0DAF
	CLC
	ADC.b #$01
	XBA
	LDA.b #$F0
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	XBA
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	REP.b #$30
	TAX
	LDA.w #$0004
	STA.b $85
	STZ.b $88
	DEX
	DEX
	PHX
	SEP.b #$20
	LDA.w $0DAF
	ASL
	ASL
	TAX
	REP.b #$20
	LDA.l DATA_00AB66,x
	STA.w $0DB3
	LDA.l DATA_00AB66+$02,x
	STA.w $0DB5
	LDA.w #$EFEF
	STA.w $0DB7
	STA.w $0DB9
	PLX
CODE_029C6F:
	REP.b #$30
	PHX
	LDA.w $0B25
	AND.w #$00FF
	BNE.b CODE_029C80
	LDA.l $7F6560,x
	BRA.b CODE_029C84

CODE_029C80:
	LDA.l $7F5FC0,x
CODE_029C84:
	JSR.w CODE_029D2B
	AND.w #$00FF
	ASL
	TAX
	LDA.b $88
	CLC
	ADC.l DATA_00AAB6,x
	PHA
	SEP.b #$20
	REP.b #$10
	LDA.w $0DB3
	LSR
	ROR.w $0DB3
	LDA.w $0DB4
	LSR
	ROR.w $0DB4
	LDA.w $0DB5
	LSR
	ROR.w $0DB5
	LDA.w $0DB6
	LSR
	ROR.w $0DB6
	LDA.w $0DB7
	LSR
	ROR.w $0DB7
	LDA.w $0DB8
	LSR
	ROR.w $0DB8
	LDA.w $0DB9
	LSR
	ROR.w $0DB9
	LDA.w $0DBA
	LSR
	ROR.w $0DBA
	REP.b #$20
	PLX
	LDA.w $0DB7
	AND.l !RAM_SIMC_Global_GeneralPurposeBuffer+$2000,x
	STA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$2000,x
	LDA.w $0DB9
	AND.l !RAM_SIMC_Global_GeneralPurposeBuffer+$2010,x
	STA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$2010,x
	LDA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$2000,x
	ORA.w $0DB3
	STA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$2000,x
	LDA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$2010,x
	ORA.w $0DB5
	STA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$2010,x
	PLX
	DEX
	DEX
	INC.b $85
	LDA.b $85
	AND.w #$0007
	STA.b $85
	BEQ.b CODE_029D1F
	CMP.w #$0004
	BEQ.b CODE_029D15
	JMP.w CODE_029C6F

CODE_029D15:
	LDA.b $88
	CMP.w #$01E0
	BEQ.b CODE_029D2A
	JMP.w CODE_029C6F

CODE_029D1F:
	LDA.b $88
	CLC
	ADC.w #$0020
	STA.b $88
	JMP.w CODE_029C6F

CODE_029D2A:
	RTS

CODE_029D2B:
	REP.b #$20
	STA.b $7F
	LDA.w $0DAF
	CMP.w #$0003
	BCC.b CODE_029D55
	SEP.b #$20
	LDA.b $80
	BEQ.b CODE_029D43
	STZ.b $80
	LDA.b #$FF
	STA.b $7F
CODE_029D43:
	REP.b #$20
	LDA.b $82
	PHA
	JSR.w CODE_029D6C
	REP.b #$20
	PLA
	STA.b $82
	REP.b #$30
	LDA.b $7A
	RTS

CODE_029D55:
	LDA.b $82
	PHA
	JSR.w CODE_029D6C
	REP.b #$20
	PLA
	STA.b $82
	PHA
	JSR.w CODE_02B47F
	REP.b #$30
	TAX
	PLA
	STA.b $82
	TXA
	RTS

CODE_029D6C:
	SEP.b #$20
	STZ.b $7B
	LDA.b $7F
	XBA
	LDA.b #$55
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	XBA
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	REP.b #$20
	STA.b $79
	SEP.b #$20
	LDA.b $80
	BEQ.b CODE_029DD4
	XBA
	LDA.b #$55
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	XBA
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	SEP.b #$20
	CLC
	ADC.b $7A
	STA.b $7A
	XBA
	ADC.b #$00
	STA.b $7B
CODE_029DD4:
	RTS

CODE_029DD5:
	SEP.b #$20
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	JSL.l CODE_008206
	STZ.w !REGISTER_VRAMAddressLo
	LDA.b #$70
	STA.w !REGISTER_VRAMAddressHi
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer+$2000
	STA.w DMA[$00].SourceLo,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$2000)>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$2000)>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$08
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_029E21
CODE_029E1D:
	ASL
	DEX
	BNE.b CODE_029E1D
CODE_029E21:
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	STZ.w !REGISTER_VRAMAddressLo
	LDA.b #$74
	STA.w !REGISTER_VRAMAddressHi
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer+$2800
	STA.w DMA[$00].SourceLo,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$2800)>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$2800)>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$08
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_029E66
CODE_029E62:
	ASL
	DEX
	BNE.b CODE_029E62
CODE_029E66:
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	STZ.w !REGISTER_VRAMAddressLo
	LDA.b #$78
	STA.w !REGISTER_VRAMAddressHi
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer+$3000
	STA.w DMA[$00].SourceLo,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$3000)>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$3000)>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$08
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_029EAB
CODE_029EA7:
	ASL
	DEX
	BNE.b CODE_029EA7
CODE_029EAB:
	STA.w !REGISTER_DMAEnable
	JSL.l CODE_008206
	STZ.w !REGISTER_VRAMAddressLo
	LDA.b #$7C
	STA.w !REGISTER_VRAMAddressHi
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer+$3800
	STA.w DMA[$00].SourceLo,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$3800)>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #(!RAM_SIMC_Global_GeneralPurposeBuffer+$3800)>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$08
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_029EF0
CODE_029EEC:
	ASL
	DEX
	BNE.b CODE_029EEC
CODE_029EF0:
	STA.w !REGISTER_DMAEnable
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	RTS

CODE_029EFC:
	SEP.b #$10
	REP.b #$20
	LDA.w $011B
	BNE.b CODE_029F25
	LDA.w $0B25
	BEQ.b CODE_029F18
	LDA.w $0CE7
	BEQ.b CODE_029F25
	JSR.w CODE_029BC7
	REP.b #$30
	STZ.w $0CE7
	RTS

CODE_029F18:
	LDA.w $0CE9
	BEQ.b CODE_029F25
	JSR.w CODE_029BC7
	REP.b #$30
	STZ.w $0CE9
CODE_029F25:
	JSL.l CODE_01C02F
	RTS

CODE_029F2A:
	SEP.b #$30
	LDA.w $01FB
	CMP.b #$02
	BEQ.b CODE_029F75
	CMP.b #$04
	BEQ.b CODE_029F75
	LDA.w $011C
	AND.b #$0F
	BEQ.b CODE_029F75
	PHB
	LDA.b #DATA_029F76>>16
	PHA
	PLB
	LDA.w $011C
	LDX.b #$00
CODE_029F48:
	LSR
	PHA
	BCC.b CODE_029F5A
	LDA.w $01EB,x
	CLC
	ADC.b #$02
	CMP.w DATA_029F76,x
	BCS.b CODE_029F5A
	STA.w $01EB,x
CODE_029F5A:
	PLA
	LSR
	PHA
	BCC.b CODE_029F6D
	LDA.w $01EB,x
	SEC
	SBC.b #$02
	CMP.w DATA_029F79,x
	BCC.b CODE_029F6D
	STA.w $01EB,x
CODE_029F6D:
	PLA
	INX
	INX
	CPX.b #$04
	BCC.b CODE_029F48
	PLB
CODE_029F75:
	RTS

DATA_029F76:
	db $E9,$00,$C1

DATA_029F79:
	db $10,$00,$18

CODE_029F7C:
	SEP.b #$20
	LDA.w $01FB
	CMP.b #$02
	BCC.b CODE_029FB0
	CMP.b #$03
	BEQ.b CODE_029FAF
	CMP.b #$04
	BCS.b CODE_029FAF
	LDA.w $01ED
	XBA
	LDA.w $01EB
	REP.b #$20
	STA.l SIMC_Global_OAMBuffer[$00].XDisp
	LDA.w #$31EC
	STA.l SIMC_Global_OAMBuffer[$00].Tile
	SEP.b #$20
	LDA.l SIMC_Global_UpperOAMBuffer[$00].Slot
	AND.b #$FC
	ORA.b #$02
	STA.l SIMC_Global_UpperOAMBuffer[$00].Slot
CODE_029FAF:
	RTS

CODE_029FB0:
	SEP.b #$20
	LDA.w $01ED
	XBA
	LDA.w $01EB
	REP.b #$20
	STA.l SIMC_Global_OAMBuffer[$00].XDisp
	LDA.w #$30D0
	STA.l SIMC_Global_OAMBuffer[$00].Tile
	SEP.b #$20
	LDA.w $01ED
	XBA
	LDA.w $01EB
	CLC
	ADC.b #$08
	REP.b #$20
	STA.l SIMC_Global_OAMBuffer[$01].XDisp
	LDA.w #$30D1
	STA.l SIMC_Global_OAMBuffer[$01].Tile
	SEP.b #$20
	LDA.w $01ED
	CLC
	ADC.b #$08
	XBA
	LDA.w $01EB
	REP.b #$20
	STA.l SIMC_Global_OAMBuffer[$02].XDisp
	LDA.w #$30D2
	STA.l SIMC_Global_OAMBuffer[$02].Tile
	SEP.b #$20
	LDA.w $01ED
	CLC
	ADC.b #$08
	XBA
	LDA.w $01EB
	CLC
	ADC.b #$08
	REP.b #$20
	STA.l SIMC_Global_OAMBuffer[$03].XDisp
	LDA.w #$30D3
	STA.l SIMC_Global_OAMBuffer[$03].Tile
	SEP.b #$20
	LDA.b #$00
	STA.l SIMC_Global_UpperOAMBuffer[$00].Slot
	RTS

CODE_02A01D:
	SEP.b #$20
	REP.b #$10
	LDX.w #$00FC
	LDA.b #$E0
CODE_02A026:
	STA.l SIMC_Global_OAMBuffer[$00].YDisp,x
	STA.l SIMC_Global_OAMBuffer[$40].YDisp,x
	DEX
	DEX
	DEX
	DEX
	BPL.b CODE_02A026
	LDX.w #$001F
	LDA.b #$55
CODE_02A039:
	STA.l SIMC_Global_UpperOAMBuffer[$00].Slot,x
	DEX
	BPL.b CODE_02A039
	LDA.b #$A5
	STA.l SIMC_Global_UpperOAMBuffer[$07].Slot
	RTS

CODE_02A047:
	SEP.b #$20
	LDA.b #$E0
	STA.l SIMC_Global_OAMBuffer[$21].YDisp
	STA.l SIMC_Global_OAMBuffer[$22].YDisp
	STA.l SIMC_Global_OAMBuffer[$23].YDisp
	LDA.l SIMC_Global_UpperOAMBuffer[$08].Slot
	AND.b #$03
	ORA.b #$54
	STA.l SIMC_Global_UpperOAMBuffer[$08].Slot
	RTS

CODE_02A064:
	JSR.w CODE_02A068
	RTL

CODE_02A068:
	REP.b #$20
	REP.b #$10
	LDA.w $01FB
	BNE.b CODE_02A07F
	LDA.w #$0090
	STA.w $0253
	LDA.w #$0044
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	BRA.b CODE_02A08B

CODE_02A07F:
	LDA.w #$0090
	STA.w $0253
	LDA.w #$0040
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
CODE_02A08B:
	LDA.w #$0020
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$0009
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	SEP.b #$20
	SEP.b #$10
	LDX.b #$0E
	LDA.w $01FB
	BNE.b CODE_02A0AC
	LDX.w $0D49
CODE_02A0AC:
	LDA.l DATA_00A97B,x
	STA.b $79
	LDY.b #$10
	LDX.b #$00
CODE_02A0B6:
	LDA.l SIMC_Global_OAMBuffer[$24].Prop,x
	AND.b #$F1
	ORA.b $79
	STA.l SIMC_Global_OAMBuffer[$24].Prop,x
	TXA
	CLC
	ADC.b #$04
	TAX
	DEY
	BNE.b CODE_02A0B6
	RTS

CODE_02A0CB:
	SEP.b #$30
	PHA
	LDA.l DATA_00A95B,x
	CLC
	ADC.b #$18
	TAX
	PLA
	PHX
	LDX.w $084B
	STA.w $084F,x
	INX
	PLA
	STA.w $084F,x
	INX
	STX.w $084B
	RTS

CODE_02A0E8:
	REP.b #$30
	LDA.w #$FFFF
	STA.b $D7
	LDA.w $01EB
	PHA
	LDA.w $01ED
	PHA
	JSR.w CODE_02A01D
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	SEP.b #$20
	STA.b $E3
	STA.b $C3
	STZ.b $B7
	REP.b #$20
	LDA.w #$0001
	COP.b #$00
	REP.b #$10
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_08E422
	STX.b $09
	LDA.b #DATA_08E422>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_09875C
	STX.b $09
	LDA.b #DATA_09875C>>16
	STA.b $0B
	LDX.w #$4000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	REP.b #$20
	STZ.w !REGISTER_VRAMAddressLo
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer
	STA.w DMA[$00].SourceLo,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$80
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_02A182
CODE_02A17E:
	ASL
	DEX
	BNE.b CODE_02A17E
CODE_02A182:
	STA.w !REGISTER_DMAEnable
	SEP.b #$10
	REP.b #$20
	LDA.w $01FB
	SEC
	SBC.w #$0002
	REP.b #$10
	ASL
	TAX
	JSR.w (DATA_02A32E,x)
	REP.b #$20
	LDA.w #$4000
	STA.w !REGISTER_VRAMAddressLo
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer
	STA.w DMA[$00].SourceLo,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$40
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_02A1D5
CODE_02A1D1:
	ASL
	DEX
	BNE.b CODE_02A1D1
CODE_02A1D5:
	STA.w !REGISTER_DMAEnable
	REP.b #$20
	STZ.w $0137
	STZ.w $0139
	LDA.w $01FB
	CMP.w #$0004
	BEQ.b CODE_02A206
	SEP.b #$20
	LDA.b #$40
	STA.b !RAM_SIMC_Global_BG1AddressAndSize
	LDA.b #$58
	STA.b !RAM_SIMC_Global_BG3AddressAndSize
	LDA.b #$02
	STA.b !RAM_SIMC_Global_BG3And4TileDataDesignation
	LDA.b #$14
	STA.b !RAM_SIMC_Global_MainScreenLayers
	LDA.b #$01
	STA.b !RAM_SIMC_Global_SubScreenLayers
	LDA.b #$02
	STA.b !RAM_SIMC_Global_ColorMathInitialSettings
	LDA.b #$20
	STA.b !RAM_SIMC_Global_ColorMathSelectAndEnable
CODE_02A206:
	STZ.b !RAM_SIMC_Global_MainScreenWindowMask
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	REP.b #$30
	PHB
	LDY.w #!RAM_SIMC_Global_Layer1TilemapBuffer
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$3000
	LDA.w #$07FF
	MVN !RAM_SIMC_Global_Layer1TilemapBuffer>>16,(!RAM_SIMC_Global_GeneralPurposeBuffer+$3000)>>16
	PLB
	JSR.w CODE_02A01D
	SEP.b #$10
	REP.b #$20
	LDA.w $01FB
	SEC
	SBC.w #$0002
	REP.b #$10
	ASL
	TAX
	JSR.w (DATA_02A338,x)
	LDA.w $0D87
	BEQ.b CODE_02A23D
	JMP.w CODE_028469

CODE_02A23D:
	REP.b #$20
	LDA.w #$0003
	COP.b #$00
CODE_02A244:
	REP.b #$20
	REP.b #$10
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	SEP.b #$20
	LDA.w $01FB
	CMP.b #$02
	BEQ.b CODE_02A26D
	CMP.b #$04
	BEQ.b CODE_02A26D
	LDA.b $C9
	AND.b #$40
	BEQ.b CODE_02A26D
	PHP
	JSL.l CODE_0098A0	: dw $0603
	PLP
	JMP.w CODE_02A28A

CODE_02A26D:
	LDA.w $01FB
	SEC
	SBC.b #$02
	REP.b #$10
	ASL
	TAX
	JSR.w (DATA_02A324,x)
	SEP.b #$20
	LDA.w $0D29
	BNE.b CODE_02A28A
	JSR.w CODE_029F2A
	JSR.w CODE_029F7C
	JMP.w CODE_02A244

CODE_02A28A:
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	LDA.w #$0004
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	INC.w $0D29
	LDA.w $01FB
	SEC
	SBC.w #$0002
	REP.b #$10
	ASL
	TAX
	JSR.w (DATA_02A342,x)
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	SEP.b #$20
	STZ.b $E3
	STZ.b $C3
	STZ.w $0D29
	REP.b #$20
	STZ.w $0137
	STZ.w $0139
	JSL.l CODE_01C6C8
	JSL.l CODE_0096BA
	JSL.l CODE_009618
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	REP.b #$20
	REP.b #$20
	PLA
	STA.w $01ED
	PLA
	STA.w $01EB
	STZ.b $D7
	LDA.w #$0001
	STA.b !RAM_SIMC_Global_MainScreenWindowMask
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	SEP.b #$20
	LDA.w $01FB
	CMP.b #$03
	BEQ.b CODE_02A30F
	CMP.b #$02
	BNE.b CODE_02A318
	LDA.w $0DC3
	BEQ.b CODE_02A318
CODE_02A30F:
	REP.b #$20
	STZ.w $0DC3
	JSL.l CODE_01B3E3
CODE_02A318:
	SEP.b #$20
	LDA.b #$FF
	STA.b $E3
	STA.b $C3
	STZ.w $0D29
	RTL

DATA_02A324:
	dw CODE_02A4E7
	dw CODE_02A4E6
	dw CODE_02A6D4
	dw CODE_02A4E6
	dw CODE_02A4E6

DATA_02A32E:
	dw CODE_02A34D
	dw CODE_02A424
	dw CODE_02B56F
	dw CODE_02A485
	dw CODE_02B609

DATA_02A338:
	dw CODE_02AB7E
	dw CODE_02AC72
	dw CODE_02A66E
	dw CODE_02AE5D
	dw CODE_02B66A

DATA_02A342:
	dw CODE_02A63C
	dw CODE_02A34C
	dw CODE_02A34C
	dw CODE_02A34C
	dw CODE_02A34C

CODE_02A34C:
	RTS

CODE_02A34D:
	SEP.b #$20
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0BADAE
	STX.b $09
	LDA.b #DATA_0BADAE>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0BBF0E
	STX.b $09
	LDA.b #DATA_0BBF0E>>16
	STA.b $0B
	LDX.w #$3000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0C8C44
	STX.b $09
	LDA.b #DATA_0C8C44>>16
	STA.b $0B
	LDX.w #$7000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	LDX.w #$0000
	STZ.w !REGISTER_CGRAMAddress
CODE_02A3A2:
	LDA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$7000,x
	STA.w !REGISTER_WriteToCGRAMPort
	INX
	CPX.w #$0200
	BCC.b CODE_02A3A2
	STZ.b !RAM_SIMC_Global_OAMSizeAndDataAreaDesignation
	REP.b #$20
	LDA.w #$00D0
	STA.w $01EB
	LDA.w #$0034
	STA.w $01ED
	STZ.w $0D67
	LDA.w $0DC3
	BEQ.b CODE_02A3CA
	JMP.w CODE_02A3F1

CODE_02A3CA:
	REP.b #$20
	LDA.w !RAM_SIMC_City_TaxRateLo
	STA.w !RAM_SIMC_City_DisplayedTaxRateLo
	JSR.w CODE_02A8DC
	JSR.w CODE_02A905
	JSR.w CODE_02A8A1
	RTS

CODE_02A3DC:
	JSR.w CODE_02A3E0
	RTL

CODE_02A3E0:
	JSR.w CODE_02A3F1
	REP.b #$30
	STZ.w $0DC3
	LDA.w $0D87
	BEQ.b CODE_02A3F0
	JMP.w CODE_028462

CODE_02A3F0:
	RTS

CODE_02A3F1:
	REP.b #$20
	LDA.w !RAM_SIMC_City_TaxRateLo
	STA.w !RAM_SIMC_City_DisplayedTaxRateLo
	JSR.w CODE_02A8DC
	JSR.w CODE_02A905
	JSR.w CODE_02A8A1
	JSR.w CODE_02A9AD
	BCS.b CODE_02A423
	JSR.w CODE_02A9C1
	LDA.w $0D87
	BNE.b CODE_02A423
	LDA.w #$0006
	STA.w $0D67
CODE_02A415:
	JSR.w CODE_02AA20
	DEC.w $0D67
	DEC.w $0D67
	BNE.b CODE_02A415
	JSR.w CODE_02A8A1
CODE_02A423:
	RTS

CODE_02A424:
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0BAFCE
	STX.b $09
	LDA.b #DATA_0BAFCE>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0BC0C9
	STX.b $09
	LDA.b #DATA_0BC0C9>>16
	STA.b $0B
	LDX.w #$3000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0C8CEE
	STX.b $09
	LDA.b #DATA_0C8CEE>>16
	STA.b $0B
	LDX.w #$7000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	LDX.w #$0000
	STZ.w !REGISTER_CGRAMAddress
CODE_02A477:
	LDA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$7000,x
	STA.w !REGISTER_WriteToCGRAMPort
	INX
	CPX.w #$00A0
	BCC.b CODE_02A477
	RTS

CODE_02A485:
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0BB1EB
	STX.b $09
	LDA.b #DATA_0BB1EB>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0BC29F
	STX.b $09
	LDA.b #DATA_0BC29F>>16
	STA.b $0B
	LDX.w #$3000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0C8D50
	STX.b $09
	LDA.b #DATA_0C8D50>>16
	STA.b $0B
	LDX.w #$7000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	LDX.w #$0000
	STZ.w !REGISTER_CGRAMAddress
CODE_02A4D8:
	LDA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$7000,x
	STA.w !REGISTER_WriteToCGRAMPort
	INX
	CPX.w #$00A0
	BCC.b CODE_02A4D8
	RTS

CODE_02A4E6:
	RTS

CODE_02A4E7:
	JSR.w CODE_02A5A9
	REP.b #$20
	LDA.w $011B
	AND.w #$FFF0
	BNE.b CODE_02A4F7
	JMP.w CODE_02A594

CODE_02A4F7:
	STZ.b $56
	SEP.b #$20
	BIT.w $011C
	BPL.b CODE_02A50A
	LDA.w $0D67
	CMP.b #$08
	BCS.b CODE_02A516
	JMP.w CODE_02A522

CODE_02A50A:
	SEP.b #$20
	LDA.b $CA
	AND.b #$0F
	BEQ.b CODE_02A515
	JMP.w CODE_02AB18

CODE_02A515:
	RTS

CODE_02A516:
	PHP
	JSL.l CODE_0098A0	: dw $0102
	PLP
	INC.w $0D29
	RTS

CODE_02A522:
	SEP.b #$20
	JSR.w CODE_02A582
	JSR.w CODE_02A7A2
	SEP.b #$20
	LDA.w $0D67
	CMP.b #$02
	BCC.b CODE_02A55A
	LDA.w $0DC3
	BNE.b CODE_02A547
	JSR.w CODE_02A91A
	JSR.w CODE_02A561
	JSR.w CODE_02A8A1
	JSR.w CODE_02AA50
	JMP.w CODE_02AA92

CODE_02A547:
	LDA.w $0D83
	BNE.b CODE_02A560
	JSR.w CODE_02A91A
	JSR.w CODE_02A865
	BCC.b CODE_02A557
	JSR.w CODE_02AA20
CODE_02A557:
	JSR.w CODE_02A561
CODE_02A55A:
	JSR.w CODE_02AA50
	JMP.w CODE_02AA92

CODE_02A560:
	RTS

CODE_02A561:
	SEP.b #$10
	REP.b #$20
	LDA.w $0D67
	CMP.w #$0002
	BCC.b CODE_02A581
	AND.w #$00FE
	TAY
	LDA.w $0D77,y
	CMP.w $0D81
	BEQ.b CODE_02A581
	PHP
	JSL.l CODE_0098A0	: dw $0803
	PLP
CODE_02A581:
	RTS

CODE_02A582:
	SEP.b #$10
	REP.b #$20
	LDA.w $0D67
	AND.w #$00FE
	TAY
	LDA.w $0D77,y
	STA.w $0D81
	RTS

CODE_02A594:
	REP.b #$20
	LDA.b $56
	BEQ.b CODE_02A5A3
	CMP.w #$0001
	BNE.b CODE_02A5A8
	STA.w $0D29
	RTS

CODE_02A5A3:
	LDA.w #$0708
	STA.b $56
CODE_02A5A8:
	RTS

CODE_02A5A9:
	SEP.b #$20
	LDA.w $0D85
	INC
	CMP.b #$31
	BCC.b CODE_02A5B5
	LDA.b #$00
CODE_02A5B5:
	STA.w $0D85
	PHB
	LDA.b #DATA_02A628>>16
	PHA
	PLB
	REP.b #$30
	LDX.w #$0012
	LDA.b $56
	BEQ.b CODE_02A5D6
	LDX.w #$0000
CODE_02A5C9:
	SEC
	SBC.w #$00B4
	BCC.b CODE_02A5D6
	INX
	INX
	CPX.w #$0012
	BCC.b CODE_02A5C9
CODE_02A5D6:
	LDA.w #$221C
	STA.l SIMC_Global_OAMBuffer[$05].XDisp
	LDA.w #$321C
	STA.l SIMC_Global_OAMBuffer[$06].XDisp
	LDA.w #$2F20
	STA.l SIMC_Global_OAMBuffer[$04].XDisp
	SEP.b #$20
	LDA.b #$37
	STA.l SIMC_Global_OAMBuffer[$05].Prop
	STA.l SIMC_Global_OAMBuffer[$06].Prop
	STA.l SIMC_Global_OAMBuffer[$04].Prop
	LDA.w DATA_02A628,x
	STA.l SIMC_Global_OAMBuffer[$05].Tile
	LDA.w DATA_02A628+$01,x
	STA.l SIMC_Global_OAMBuffer[$06].Tile
	LDA.b #$CB
	LDX.w $0D85
	CPX.w #$0010
	BCC.b CODE_02A61A
	INC
	CPX.w #$0020
	BCC.b CODE_02A61A
	INC
CODE_02A61A:
	STA.l SIMC_Global_OAMBuffer[$04].Tile
	SEP.b #$20
	LDA.b #$28
	STA.l SIMC_Global_UpperOAMBuffer[$01].Slot
	PLB
	RTS

DATA_02A628:
	db $C9,$E9,$C7,$E7,$C5,$E5,$C3,$E3,$8D,$AD,$8B,$AB,$89,$A9,$87,$A7
	db $85,$A5,$83,$A3

CODE_02A63C:
	REP.b #$20
	LDA.w #$0001
	COP.b #$00
	JSR.w CODE_02A651
	SEP.b #$20
	LDA.b #$03
	STA.b !RAM_SIMC_Global_OAMSizeAndDataAreaDesignation
	RTS

CODE_02A64D:
	JSR.w CODE_02A651
	RTL

CODE_02A651:
	REP.b #$20
	LDA.w !RAM_SIMC_City_DisplayedTaxRateLo
	STA.w !RAM_SIMC_City_TaxRateLo
	LDA.w !RAM_SIMC_City_DisplayedFireFundingLo
	STA.w !RAM_SIMC_City_AllocatedFireFundsLo
	LDA.w !RAM_SIMC_City_DisplayedPoliceFundingLo
	STA.w !RAM_SIMC_City_AllocatedPoliceFundsLo
	LDA.w !RAM_SIMC_City_DisplayedTransportFundingLo
	STA.w !RAM_SIMC_City_AllocatedTransportFundsLo
	SEP.b #$20
	RTS

CODE_02A66E:
	REP.b #$20
	LDA.w #$0070
	STA.w $01ED
	LDA.w #$0088
	STA.w $01EB
	STZ.w $0B17
	STZ.w $0B19
	SEP.b #$30
	LDA.w $0B1D
	BEQ.b CODE_02A6CB
	LDA.b #$02
	STA.w $0B19
	REP.b #$30
	LDA.w #$02D0
	STA.w $0B1B
	LDX.w #$0000
	LDA.w $0B1D
CODE_02A69C:
	SEC
	CMP.w #$000A
	BCC.b CODE_02A6A8
	INX
	SBC.w #$000A
	BCS.b CODE_02A69C
CODE_02A6A8:
	ADC.w #$3C50
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$02EA
	ADC.w #$0010
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$032A
	CPX.w #$0000
	BEQ.b CODE_02A6CB
	TXA
	CLC
	ADC.w #$3C50
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$02E8
	ADC.w #$0010
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0328
CODE_02A6CB:
	PHP
	JSL.l CODE_0098A0	: dw $0602
	PLP
	RTS

CODE_02A6D4:
	SEP.b #$20
	LDA.w $0B19
	REP.b #$10
	ASL
	TAX
	JSR.w (DATA_02A6E1,x)
	RTS

DATA_02A6E1:
	dw CODE_02A6E7
	dw CODE_02A785
	dw CODE_02A785

CODE_02A6E7:
	SEP.b #$20
	LDA.b $CA
	BMI.b CODE_02A713
	AND.b #$03
	BEQ.b CODE_02A750
	LDA.w $0B17
	PHA
	STZ.w $0B17
	LDA.b $CA
	AND.b #$03
	CMP.b #$02
	BEQ.b CODE_02A703
	INC.w $0B17
CODE_02A703:
	PLA
	CMP.w $0B17
	BEQ.b CODE_02A750
	PHP
	JSL.l CODE_0098A0	: dw $0703
	PLP
	BRA.b CODE_02A750

CODE_02A713:
	LDA.w $0B17
	BNE.b CODE_02A745
	PHP
	JSL.l CODE_0098A0	: dw $1703
	PLP
	LDA.b #$15
	STA.w $0B1D
	REP.b #$20
	LDA.w #$2710
	CLC
	ADC.w !RAM_SIMC_City_CurrentFundsLo
	STA.w !RAM_SIMC_City_CurrentFundsLo
	LDA.w !RAM_SIMC_City_CurrentFundsHi
	ADC.w #$0000
	STA.w !RAM_SIMC_City_CurrentFundsHi
	LDA.w #$00E0
	STA.w $01ED
	INC.w $0D29
	BRA.b CODE_02A750

CODE_02A745:
	INC.w $0D29
	PHP
	JSL.l CODE_0098A0	: dw $0603
	PLP
CODE_02A750:
	SEP.b #$20
	REP.b #$10
	LDX.w #$0088
	LDA.w $0B17
	BEQ.b CODE_02A75F
	LDX.w #$00B0
CODE_02A75F:
	STX.w $01EB
	LDA.w $01ED
	XBA
	LDA.w $01EB
	REP.b #$20
	STA.l SIMC_Global_OAMBuffer[$00].XDisp
	LDA.w #$31EC
	STA.l SIMC_Global_OAMBuffer[$00].Tile
	SEP.b #$20
	LDA.l SIMC_Global_UpperOAMBuffer[$00].Slot
	AND.b #$FC
	ORA.b #$02
	STA.l SIMC_Global_UpperOAMBuffer[$00].Slot
	RTS

CODE_02A785:
	SEP.b #$20
	LDA.b $C9
	AND.b #$40
	BNE.b CODE_02A796
	REP.b #$20
	DEC.w $0B1B
	SEP.b #$20
	BNE.b CODE_02A7A1
CODE_02A796:
	INC.w $0D29
	PHP
	JSL.l CODE_0098A0	: dw $0603
	PLP
CODE_02A7A1:
	RTS

CODE_02A7A2:
	REP.b #$30
	LDA.b $C9
	AND.w #$8000
	BEQ.b CODE_02A7B4
	LDA.w #$0001
	STA.w $0D69
	STZ.w $0D6B
CODE_02A7B4:
	DEC.w $0D69
	BNE.b CODE_02A830
	LDA.w $0D6B
	CLC
	ADC.w #$0001
	AND.w #$7FFF
	STA.w $0D6B
	LDY.w #$0006
	CMP.w #$0004
	BCS.b CODE_02A7D1
	LDY.w #$000C
CODE_02A7D1:
	STY.w $0D69
	LDX.w #$0001
	LDA.w $0D6B
	CMP.w #$0020
	BCC.b CODE_02A7EA
	LDX.w #$000A
	CMP.w #$0030
	BCC.b CODE_02A7EA
	LDX.w #$0064
CODE_02A7EA:
	LDA.w $0D67
	CMP.w #$0002
	BCS.b CODE_02A7F5
	JMP.w CODE_02A831

CODE_02A7F5:
	LDY.w $0DC3
	BEQ.b CODE_02A800
	LDY.w $0D83
	BEQ.b CODE_02A800
	RTS

CODE_02A800:
	LSR
	BCC.b CODE_02A81C
	ASL
	TAY
	STX.b $79
	LDA.w $0D77,y
	CMP.w #$0064
	BEQ.b CODE_02A830
	CLC
	ADC.b $79
	CMP.w #$0064
	BCC.b CODE_02A82D
	LDA.w #$0064
	BRA.b CODE_02A82D

CODE_02A81C:
	ASL
	TAY
	STX.b $79
	LDA.w $0D77,y
	BEQ.b CODE_02A830
	SEC
	SBC.b $79
	BPL.b CODE_02A82D
	LDA.w #$0000
CODE_02A82D:
	STA.w $0D77,y
CODE_02A830:
	RTS

CODE_02A831:
	LSR
	BCS.b CODE_02A845
	STX.b $79
	LDA.w !RAM_SIMC_City_DisplayedTaxRateLo
	BEQ.b CODE_02A864
	SEC
	SBC.b $79
	BPL.b CODE_02A859
	LDA.w #$0000
	BRA.b CODE_02A859

CODE_02A845:
	STX.b $79
	LDA.w !RAM_SIMC_City_DisplayedTaxRateLo
	CLC
	ADC.b $79
	CMP.w #!Define_SIMC_City_MaxTaxPercent+$01
	BCC.b CODE_02A859
	LDA.w #!Define_SIMC_City_MaxTaxPercent
	STA.w !RAM_SIMC_City_DisplayedTaxRateLo
	RTS

CODE_02A859:
	STA.w !RAM_SIMC_City_DisplayedTaxRateLo
	PHP
	JSL.l CODE_0098A0	: dw $0803
	PLP
CODE_02A864:
	RTS

CODE_02A865:
	REP.b #$30
	LDA.w $0D67
	CMP.w #$0002
	BCC.b CODE_02A89F
	JSR.w CODE_02A8A1
	LDA.w $0D89
	SEC
	SBC.w $0D8D
	LDA.w $0D8B
	SBC.w $0D8F
	BCS.b CODE_02A89F
	LDA.w $0D8D
	SEC
	SBC.w $0D89
	STA.b $79
	LDA.w $0D67
	AND.w #$FFFE
	TAY
	LDA.w !RAM_SIMC_City_DisplayedTaxRateLo,y
	SEC
	SBC.b $79
	STA.w !RAM_SIMC_City_DisplayedTaxRateLo,y
	JSR.w CODE_02A8A1
	SEC
	RTS

CODE_02A89F:
	CLC
	RTS

CODE_02A8A1:
	REP.b #$30
	STZ.w $0D8D
	STZ.w $0D8F
	LDX.w #$0006
CODE_02A8AC:
	LDA.w !RAM_SIMC_City_DisplayedTaxRateLo,x
	CLC
	ADC.w $0D8D
	STA.w $0D8D
	LDA.w $0D8F
	ADC.w #$0000
	STA.w $0D8F
	DEX
	DEX
	BNE.b CODE_02A8AC
	LDA.w $0B1D
	BEQ.b CODE_02A8DB
	LDA.w #$01F4
	CLC
	ADC.w $0D8D
	STA.w $0D8D
	LDA.w $0D8F
	ADC.w #$0000
	STA.w $0D8F
CODE_02A8DB:
	RTS

CODE_02A8DC:
	REP.b #$20
	LDA.w $0DC9
	CLC
	ADC.w !RAM_SIMC_City_CurrentFundsLo
	STA.w $0D89
	LDA.w $0DCB
	ADC.w !RAM_SIMC_City_CurrentFundsHi
	STA.w $0D8B
	LDA.w $0D89
	CLC
	ADC.w $0DD9
	STA.w $0D89
	LDA.w $0D8B
	ADC.w #$0000
	STA.w $0D8B
	RTS

CODE_02A905:
	SEP.b #$30
	STZ.b $7B
	LDA.b #$06
	STA.w $0D67
CODE_02A90E:
	JSR.w CODE_02A91A
	DEC.w $0D67
	DEC.w $0D67
	BNE.b CODE_02A90E
	RTS

CODE_02A91A:
	SEP.b #$30
	LDA.w $0D67
	AND.b #$FE
	TAY
	LDA.w $0D77,y
	CMP.b #$65
	BCC.b CODE_02A92E
	LDA.b #$64
	STA.w $0D77,y
CODE_02A92E:
	XBA
	LDA.w !RAM_SIMC_City_AllocatedFireFundsLo,y
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	XBA
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	SEP.b #$10
	REP.b #$20
	STA.b $79
	SEP.b #$20
	LDA.w $0D77,y
	XBA
	LDA.w $0DD2,y
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	XBA
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	SEP.b #$20
	CLC
	ADC.b $7A
	STA.b $7A
	XBA
	ADC.b #$00
	STA.b $7B
	REP.b #$30
	LDA.w #$0064
	STA.b $82
	JSR.w CODE_02B47F
	SEP.b #$30
	LDA.w $0D67
	AND.b #$FE
	TAY
	REP.b #$20
	LDA.b $79
	STA.w !RAM_SIMC_City_DisplayedTaxRateLo,y
	RTS

CODE_02A9AD:
	REP.b #$30
	LDA.w $0D89
	SEC
	SBC.w $0D8D
	STA.b $79
	LDA.w $0D8B
	SBC.w $0D8F
	STA.b $7C
	RTS

CODE_02A9C1:
	REP.b #$30
	LDA.b $7C
	EOR.w #$FFFF
	STA.b $7C
	LDA.b $79
	EOR.w #$FFFF
	CLC
	ADC.w #$0001
	STA.b $79
	LDA.b $7C
	ADC.w #$0000
	STA.b $7C
	LDX.w #$0006
CODE_02A9DF:
	LDA.b $7C
	BNE.b CODE_02A9F1
	LDA.b $79
	CMP.w !RAM_SIMC_City_DisplayedTaxRateLo,x
	BEQ.b CODE_02AA16
	LDA.b $7C
	SBC.w #$0000
	BCC.b CODE_02AA16
CODE_02A9F1:
	LDA.b $79
	SEC
	SBC.w !RAM_SIMC_City_DisplayedTaxRateLo,x
	STA.b $79
	LDA.b $7C
	SBC.w #$0000
	STA.b $7C
	LDA.w #$0000
	STA.w !RAM_SIMC_City_DisplayedTaxRateLo,x
	DEX
	DEX
	BNE.b CODE_02A9DF
	LDA.w $0DC3
	BEQ.b CODE_02AA15
	LDA.w #$0001
	STA.w $0D87
CODE_02AA15:
	RTS

CODE_02AA16:
	LDA.w !RAM_SIMC_City_DisplayedTaxRateLo,x
	SEC
	SBC.b $79
	STA.w !RAM_SIMC_City_DisplayedTaxRateLo,x
	RTS

CODE_02AA20:
	REP.b #$30
	LDA.w $0D67
	CMP.w #$0002
	BCC.b CODE_02AA4F
	AND.w #$FFFE
	TAY
	LDA.w !RAM_SIMC_City_DisplayedTaxRateLo,y
	STA.b $7F
	JSR.w CODE_02B4B4
	REP.b #$30
	LDA.w $0D67
	AND.w #$FFFE
	TAY
	JSR.w CODE_02B46D
	SEP.b #$30
	TAY
	LDA.w $0D67
	AND.b #$FE
	TAX
	TYA
	STA.w $0D77,x
CODE_02AA4F:
	RTS

CODE_02AA50:
	REP.b #$30
	LDA.w $0D67
	AND.w #$FFFE
	TAX
	LDA.w !RAM_SIMC_City_DisplayedTaxRateLo,x
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w $0D67
	AND.w #$FFFE
	JSR.w CODE_02B266
	REP.b #$30
	LDA.w $0D67
	CMP.w #$0002
	BCC.b CODE_02AA91
	AND.w #$FFFE
	TAX
	LDA.w $0D77,x
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w $0D67
	ORA.w #$0001
	JSR.w CODE_02B266
CODE_02AA91:
	RTS

CODE_02AA92:
	REP.b #$30
	LDA.w $0D67
	CMP.w #$0002
	BCS.b CODE_02AA9D
	RTS

CODE_02AA9D:
	REP.b #$30
	LDA.w $0D8D
	STA.b $79
	LDA.w $0D8F
	STA.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$0010
	JSR.w CODE_02B266
	REP.b #$30
	LDA.w $0D89
	SEC
	SBC.w $0D8D
	STA.b $79
	LDA.w $0D8B
	SBC.w $0D8F
	STA.b $7C
	BCC.b CODE_02AAD5
	LDX.w #$05E2
	LDA.w #$03FF
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	BRA.b CODE_02AAF6

CODE_02AAD5:
	LDX.w #$05E2
	LDA.w #$082F
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	LDA.w #$FFFF
	STA.w $0D83
	LDA.w $0D8D
	SEC
	SBC.w $0D89
	STA.b $79
	LDA.w $0D8B
	SBC.w $0D8F
	STA.b $7C
CODE_02AAF6:
	LDA.b $79
	CMP.w #$423F
	LDA.b $7C
	SBC.w #$000F
	BCC.b CODE_02AB0C
	LDA.w #$423F
	STA.b $79
	LDA.w #$000F
	STA.b $7C
CODE_02AB0C:
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$000B
	JSR.w CODE_02B266
	RTS

CODE_02AB18:
	SEP.b #$30
	PHB
	LDA.b #DATA_02AB6A>>16
	PHA
	PLB
	LDA.b $CA
	AND.b #$0C
	BNE.b CODE_02AB30
	LDA.w $0D67
	CMP.b #$08
	BCS.b CODE_02AB68
	EOR.b #$01
	BRA.b CODE_02AB4E

CODE_02AB30:
	AND.b #$08
	BNE.b CODE_02AB42
	LDA.w $0D67
	CLC
	ADC.b #$02
	CMP.b #$0A
	BCC.b CODE_02AB4E
	AND.b #$01
	BRA.b CODE_02AB4E

CODE_02AB42:
	LDA.w $0D67
	SEC
	SBC.b #$02
	BPL.b CODE_02AB4E
	AND.b #$01
	ORA.b #$08
CODE_02AB4E:
	STA.w $0D67
	ASL
	TAX
	LDA.w DATA_02AB6A,x
	STA.w $01EB
	INX
	LDA.w DATA_02AB6A,x
	STA.w $01ED
	PHP
	JSL.l CODE_0098A0	: dw $0703
	PLP
CODE_02AB68:
	PLB
	RTS

DATA_02AB6A:
	db $D0,$34,$DC,$34,$D0,$60,$DC,$60,$D0,$70,$DC,$70,$D0,$80,$DC,$80
	db $80,$D0,$80,$D0

CODE_02AB7E:
	REP.b #$20
	STZ.w $0D83
	REP.b #$20
	LDA.w #$0006
	STA.w $0D67
CODE_02AB8B:
	JSR.w CODE_02AA50
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	DEC.w $0D67
	DEC.w $0D67
	BPL.b CODE_02AB8B
	REP.b #$30
	LDA.w !RAM_SIMC_City_TaxRateLo
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$0000
	JSR.w CODE_02B266
	REP.b #$30
	LDA.w $0DC9
	STA.b $79
	LDA.w $0DCB
	STA.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$000C
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0DD3
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$000D
	JSR.w CODE_02B266
	REP.b #$30
	LDA.w $0DD5
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$000E
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0DD7
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$000F
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w !RAM_SIMC_City_CurrentFundsLo
	STA.b $79
	LDA.w !RAM_SIMC_City_CurrentFundsHi
	STA.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$0011
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0DD9
	STA.b $79
	LDA.w $0DDB
	STA.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$000A
	JSR.w CODE_02B266
	SEP.b #$20
	PHP
	JSL.l CODE_0098A0	: dw $0602
	PLP
	REP.b #$20
	STZ.w $0D67
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	JSR.w CODE_02B51F
	JSR.w CODE_02AA9D
	REP.b #$20
	STZ.b $56
	JSR.w CODE_02A5A9
	RTS

CODE_02AC72:
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w !RAM_SIMC_City_PercentOfPeopleThatApproveOfMayorLo
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$0012
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w !RAM_SIMC_City_PercentOfPeopleThatDisapproveOfMayorLo
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$0013
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	LDA.w !RAM_SIMC_City_1stWorstProblemPercent
	AND.w #$00FF
	BNE.b CODE_02ACBC
	JMP.w CODE_02AD4F

CODE_02ACBC:
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	SEP.b #$20
	LDA.b #$14
	JSR.w CODE_02B266
	SEP.b #$30
	LDY.w !RAM_SIMC_City_1stWorstProblem
	LDA.b #$00
	JSR.w CODE_02B2EC
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	LDA.w !RAM_SIMC_City_2ndWorstProblemPercent
	AND.w #$00FF
	BEQ.b CODE_02AD4F
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	SEP.b #$20
	LDA.b #$15
	JSR.w CODE_02B266
	SEP.b #$30
	LDY.w !RAM_SIMC_City_2ndWorstProblem
	LDA.b #$01
	JSR.w CODE_02B2EC
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	LDA.w !RAM_SIMC_City_3rdWorstProblemPercent
	AND.w #$00FF
	BEQ.b CODE_02AD4F
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	SEP.b #$20
	LDA.b #$16
	JSR.w CODE_02B266
	SEP.b #$30
	LDY.w !RAM_SIMC_City_3rdWorstProblem
	LDA.b #$02
	JSR.w CODE_02B2EC
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	LDA.w !RAM_SIMC_City_4thWorstProblemPercent
	AND.w #$00FF
	BEQ.b CODE_02AD4F
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	SEP.b #$20
	LDA.b #$17
	JSR.w CODE_02B266
	SEP.b #$30
	LDY.w !RAM_SIMC_City_4thWorstProblem
	LDA.b #$03
	JSR.w CODE_02B2EC
CODE_02AD4F:
	REP.b #$30
	LDA.w !RAM_SIMC_City_CurrentPopulationLo
	STA.b $79
	LDA.w !RAM_SIMC_City_CurrentPopulationHi
	AND.w #$00FF
	STA.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$0018
	JSR.w CODE_02B266
	REP.b #$30
	LDA.w !RAM_SIMC_City_LastYearsNetMigrationHi
	BPL.b CODE_02AD8A
	EOR.w #$FFFF
	STA.b $7C
	LDA.w !RAM_SIMC_City_LastYearsNetMigrationLo
	EOR.w #$FFFF
	CLC
	ADC.w #$0001
	STA.b $79
	LDA.b $7C
	ADC.w #$0000
	STA.b $7C
	BRA.b CODE_02AD91

CODE_02AD8A:
	STA.b $7C
	LDA.w !RAM_SIMC_City_LastYearsNetMigrationLo
	STA.b $79
CODE_02AD91:
	JSR.w CODE_02B351
	REP.b #$30
	LDA.w !RAM_SIMC_City_LastYearsNetMigrationHi
	BPL.b CODE_02ADA1
	LDX.w #$0005
	JSR.w CODE_02AE4A
CODE_02ADA1:
	REP.b #$20
	LDA.w #$0019
	JSR.w CODE_02B266
	REP.b #$30
	LDA.w !RAM_SIMC_City_AssessedValueLo
	STA.b $79
	LDA.w !RAM_SIMC_City_AssessedValueMidHi
	STA.b $7C
	ORA.b $79
	AND.w #$0FFF
	BEQ.b CODE_02ADDA
	JSR.w CODE_02B351
	SEP.b #$10
	REP.b #$20
	LDX.b #$06
CODE_02ADC5:
	LDA.w $0D95,x
	STA.w $0D97,x
	DEX
	BPL.b CODE_02ADC5
	STZ.w $0D96
	STZ.w $0D95
	LDA.w #$001A
	JSR.w CODE_02B266
CODE_02ADDA:
	SEP.b #$30
	LDA.w !RAM_SIMC_City_CityCategory
	CLC
	ADC.b #$07
	TAY
	LDA.b #$04
	JSR.w CODE_02B2EC
	SEP.b #$30
	LDA.w !RAM_SIMC_City_DifficultyLevel
	CLC
	ADC.b #$0D
	TAY
	LDA.b #$05
	JSR.w CODE_02B2EC
	REP.b #$30
	LDA.w !RAM_SIMC_City_CurrentCityScoreLo
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$001B
	JSR.w CODE_02B266
	REP.b #$30
	LDA.w !RAM_SIMC_City_AnnualCityScoreChangeLo
	BPL.b CODE_02AE18
	EOR.w #$FFFF
	CLC
	ADC.w #$0001
CODE_02AE18:
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w !RAM_SIMC_City_AnnualCityScoreChangeLo
	BPL.b CODE_02AE2C
	LDX.w #$0003
	JSR.w CODE_02AE4A
CODE_02AE2C:
	REP.b #$20
	LDA.w #$001C
	JSR.w CODE_02B266
	JSR.w CODE_02B51F
	SEP.b #$20
	LDA.w !RAM_SIMC_City_PercentOfPeopleThatApproveOfMayorLo
	CMP.b #$32
	BCS.b CODE_02AE45
	LDA.b #$0E
	STA.b $03
	RTS

CODE_02AE45:
	LDA.b #$0D
	STA.b $03
	RTS

CODE_02AE4A:
	SEP.b #$20
	REP.b #$10
CODE_02AE4E:
	LDA.w $0D95,x
	BNE.b CODE_02AE57
	DEX
	BPL.b CODE_02AE4E
	RTS

CODE_02AE57:
	LDA.b #$0F
	STA.w $0D96,x
	RTS

CODE_02AE5D:
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0C73
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$001D
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w $0C73
	BEQ.b CODE_02AE90
	STA.b $7F
	JSR.w CODE_02B4B4
	REP.b #$20
	LDA.w $0E21
	STA.b $82
	JSR.w CODE_02B47F
	REP.b #$30
CODE_02AE90:
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$001E
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0C75
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$001F
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w $0C75
	BEQ.b CODE_02AED2
	STA.b $7F
	JSR.w CODE_02B4B4
	REP.b #$20
	LDA.w $0E21
	STA.b $82
	JSR.w CODE_02B47F
	REP.b #$30
CODE_02AED2:
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$0020
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0C77
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$0021
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w $0C77
	BEQ.b CODE_02AF14
	STA.b $7F
	JSR.w CODE_02B4B4
	REP.b #$20
	LDA.w $0E21
	STA.b $82
	JSR.w CODE_02B47F
	REP.b #$30
CODE_02AF14:
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$0022
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0C7D
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$0025
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w $0C7D
	BEQ.b CODE_02AF56
	STA.b $7F
	JSR.w CODE_02B4B4
	REP.b #$20
	LDA.w $0E21
	STA.b $82
	JSR.w CODE_02B47F
	REP.b #$30
CODE_02AF56:
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$0026
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0C79
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$0023
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0C7B
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$0024
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0C7F
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w $0D95
	AND.w #$00FF
	ORA.w #$0420
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0558
	SEP.b #$30
	LDX.b #$00
CODE_02AFC1:
	LDA.w $0D96,x
	STA.w $0D95,x
	INX
	CPX.b #$04
	BCC.b CODE_02AFC1
	REP.b #$20
	LDA.w #$0027
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0C81
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w $0D95
	AND.w #$00FF
	ORA.w #$0420
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$05D8
	SEP.b #$30
	LDX.b #$00
CODE_02AFFA:
	LDA.w $0D96,x
	STA.w $0D95,x
	INX
	CPX.b #$04
	BCC.b CODE_02AFFA
	REP.b #$20
	LDA.w #$0028
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0C83
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w $0D95
	AND.w #$00FF
	ORA.w #$0420
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0658
	SEP.b #$30
	LDX.b #$00
CODE_02B033:
	LDA.w $0D96,x
	STA.w $0D95,x
	INX
	CPX.b #$04
	BCC.b CODE_02B033
	REP.b #$20
	LDA.w #$0029
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0C85
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$0031
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0C87
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$002C
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0C89
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$002D
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0C8B
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$002E
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0C8D
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$0032
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0C8F
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$002F
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0C91
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$0030
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0C93
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$002B
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0C95
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$002A
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0C97
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$0033
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0C99
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$0034
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0C9B
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$0035
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0C9D
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$0036
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0C97
	BEQ.b CODE_02B1C4
	STA.b $7F
	JSR.w CODE_02B4B4
	REP.b #$20
	LDA.w #$2EE0
	STA.b $82
	JSR.w CODE_02B47F
	REP.b #$30
CODE_02B1C4:
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$0037
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0C99
	BEQ.b CODE_02B1F2
	STA.b $7F
	JSR.w CODE_02B4B4
	REP.b #$20
	LDA.w #$2EE0
	STA.b $82
	JSR.w CODE_02B47F
	REP.b #$30
CODE_02B1F2:
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$0038
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0C9B
	BEQ.b CODE_02B220
	STA.b $7F
	JSR.w CODE_02B4B4
	REP.b #$20
	LDA.w #$2EE0
	STA.b $82
	JSR.w CODE_02B47F
	REP.b #$30
CODE_02B220:
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$0039
	JSR.w CODE_02B266
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$30
	LDA.w $0C9D
	BEQ.b CODE_02B24E
	STA.b $7F
	JSR.w CODE_02B4B4
	REP.b #$20
	LDA.w #$2EE0
	STA.b $82
	JSR.w CODE_02B47F
	REP.b #$30
CODE_02B24E:
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w #$003A
	JSR.w CODE_02B266
	PHP
	JSL.l CODE_0098A0	: dw $0602
	PLP
	RTS

CODE_02B266:
	REP.b #$30
	STA.b $79
	SEP.b #$20
	PHB
	LDA.b #DATA_02B77C>>16
	PHA
	PLB
	REP.b #$20
	LDA.b $79
	ASL
	TAX
	LDA.w DATA_02B77C,x
	TAY
	LDA.w #$03FF
	STA.w $0D9D
	CPX.w #$0024
	BCS.b CODE_02B28B
	LDA.w DATA_02B806,x
	BRA.b CODE_02B2A2

CODE_02B28B:
	CPX.w #$003A
	BCS.b CODE_02B295
	LDA.w #$1420
	BRA.b CODE_02B2A2

CODE_02B295:
	CPX.w #$0076
	BCC.b CODE_02B29F
	LDA.w #$0020
	BNE.b CODE_02B2A2
CODE_02B29F:
	LDA.w #$0420
CODE_02B2A2:
	STA.w $0D9F
	LDA.w DATA_02B82A,x
	ASL
	TAX
CODE_02B2AA:
	SEP.b #$20
	LDA.w $0D94,y
	BNE.b CODE_02B2CD
	REP.b #$20
	LDA.w $0D9D
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	INX
	INX
	DEY
	BNE.b CODE_02B2AA
	LDA.w $0D9F
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer-$02,x
	BRA.b CODE_02B2E8

CODE_02B2C8:
	SEP.b #$20
	LDA.w $0D94,y
CODE_02B2CD:
	REP.b #$20
	AND.w #$00FF
	CMP.w #$000E
	BCC.b CODE_02B2DC
	LDA.w #$042F
	BRA.b CODE_02B2DF

CODE_02B2DC:
	ORA.w $0D9F
CODE_02B2DF:
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	INX
	INX
	DEY
	BNE.b CODE_02B2C8
CODE_02B2E8:
	SEP.b #$20
	PLB
	RTS

CODE_02B2EC:
	REP.b #$20
	STA.b $79
	SEP.b #$20
	PHB
	LDA.b #DATA_02BAB9>>16
	PHA
	PLB
	REP.b #$30
	LDA.b $79
	AND.w #$00FF
	ASL
	TAX
	LDA.w DATA_02BAB9,x
	ASL
	TAX
	TYA
	AND.w #$00FF
	ASL
	TAY
	LDA.w DATA_02BAD9,y
	AND.w #$0FFF
	TAY
	PHX
	JSR.w CODE_02B328
	PLX
	CMP.w #$00FF
	BEQ.b CODE_02B326
	INY
	TXA
	CLC
	ADC.w #$0040
	TAX
	JSR.w CODE_02B328
CODE_02B326:
	PLB
	RTS

CODE_02B328:
	LDA.w #$0000
	CPY.w #$005E
	BCS.b CODE_02B333
	LDA.w #$0100
CODE_02B333:
	STA.b $79
CODE_02B335:
	LDA.w DATA_02B8B4,y
	AND.w #$00FF
	CMP.w #$00FF
	BEQ.b CODE_02B350
	CMP.w #$00FE
	BEQ.b CODE_02B350
	ORA.b $79
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	INY
	INX
	INX
	BNE.b CODE_02B335
CODE_02B350:
	RTS

CODE_02B351:
	REP.b #$30
	LDX.w #$0006
CODE_02B356:
	STZ.w $0D95,x
	DEX
	DEX
	BPL.b CODE_02B356
	LDY.w #$0000
	LDX.w #$0004
	LDA.b $7C
	BEQ.b CODE_02B3D9
	LDY.w #$0000
	LDX.w #$0007
CODE_02B36D:
	LDA.b $79
	SEC
	SBC.w #$9680
	STA.b $7F
	LDA.b $7C
	SBC.w #$0098
	BCC.b CODE_02B385
	STA.b $7C
	LDA.b $7F
	STA.b $79
	INY
	BRA.b CODE_02B36D

CODE_02B385:
	TYA
	SEP.b #$20
	STA.w $0D95,x
	DEX
	LDY.w #$0000
	REP.b #$20
CODE_02B391:
	LDA.b $79
	SEC
	SBC.w #$4240
	STA.b $7F
	LDA.b $7C
	SBC.w #$000F
	BCC.b CODE_02B3A9
	STA.b $7C
	LDA.b $7F
	STA.b $79
	INY
	BRA.b CODE_02B391

CODE_02B3A9:
	TYA
	SEP.b #$20
	STA.w $0D95,x
	DEX
	LDY.w #$0000
	REP.b #$20
CODE_02B3B5:
	LDA.b $79
	SEC
	SBC.w #$86A0
	STA.b $7F
	LDA.b $7C
	SBC.w #$0001
	BCC.b CODE_02B3CD
	STA.b $7C
	LDA.b $7F
	STA.b $79
	INY
	BRA.b CODE_02B3B5

CODE_02B3CD:
	TYA
	SEP.b #$20
	STA.w $0D95,x
	DEX
	LDY.w #$0000
	REP.b #$20
CODE_02B3D9:
	LDA.b $79
	SEC
	SBC.w #$2710
	STA.b $7F
	LDA.b $7C
	SBC.w #$0000
	BCC.b CODE_02B3F1
	STA.b $7C
	LDA.b $7F
	STA.b $79
	INY
	BRA.b CODE_02B3D9

CODE_02B3F1:
	TYA
	SEP.b #$20
	STA.w $0D95,x
	DEX
	LDY.w #$0000
	REP.b #$20
CODE_02B3FD:
	LDA.b $79
	SEC
	SBC.w #$03E8
	STA.b $7F
	LDA.b $7C
	SBC.w #$0000
	BCC.b CODE_02B415
	STA.b $7C
	LDA.b $7F
	STA.b $79
	INY
	BRA.b CODE_02B3FD

CODE_02B415:
	TYA
	SEP.b #$20
	STA.w $0D95,x
	DEX
	LDY.w #$0000
	REP.b #$20
CODE_02B421:
	LDA.b $79
	SEC
	SBC.w #$0064
	STA.b $7F
	LDA.b $7C
	SBC.w #$0000
	BCC.b CODE_02B439
	STA.b $7C
	LDA.b $7F
	STA.b $79
	INY
	BRA.b CODE_02B421

CODE_02B439:
	TYA
	SEP.b #$20
	STA.w $0D95,x
	DEX
	LDY.w #$0000
	REP.b #$20
CODE_02B445:
	LDA.b $79
	SEC
	SBC.w #$000A
	STA.b $7F
	LDA.b $7C
	SBC.w #$0000
	BCC.b CODE_02B45D
	STA.b $7C
	LDA.b $7F
	STA.b $79
	INY
	BRA.b CODE_02B445

CODE_02B45D:
	TYA
	SEP.b #$20
	STA.w $0D95,x
	DEX
	LDA.b $79
	STA.w $0D95,x
	RTS

CODE_02B46A:
	JMP.w CODE_02A905

CODE_02B46D:
	REP.b #$30
	LDX.w #$0000
	LDA.w !RAM_SIMC_City_AllocatedFireFundsLo,y
	BEQ.b CODE_02B4B3
	STA.b $82
	LDY.w #$0018
	JMP.w CODE_02B488

CODE_02B47F:
	REP.b #$30
	LDY.w #$0018
	LDA.b $82
	BEQ.b CODE_02B4B3
CODE_02B488:
	STZ.b $7F
CODE_02B48A:
	SEP.b #$20
	ROL.b $79
	ROL.b $7A
	ROL.b $7B
	REP.b #$20
	ROL.b $7F
	LDA.b $7F
	CMP.b $82
	BCC.b CODE_02B4A0
	SBC.b $82
	STA.b $7F
CODE_02B4A0:
	DEY
	BNE.b CODE_02B48A
	ROL.b $79
	ASL.b $7F
	LDA.b $7F
	BEQ.b CODE_02B4B1
	CMP.b $82
	BCC.b CODE_02B4B1
	INC.b $79
CODE_02B4B1:
	LDA.b $79
CODE_02B4B3:
	RTS

CODE_02B4B4:				; Note: City Overview related
	SEP.b #$30
	STZ.b $7B
	LDA.b $7F
	XBA
	LDA.b #$64
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	XBA
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	SEP.b #$10
	REP.b #$20
	STA.b $79
	SEP.b #$20
	LDA.b $80
	BEQ.b CODE_02B51E
	XBA
	LDA.b #$64
	PHA
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	PLA
	STA.l !REGISTER_Multiplicand
	XBA
	STA.l !REGISTER_Multiplier
	PHA
	PLA
	NOP
	LDA.l !REGISTER_ProductOrRemainderHi
	XBA
	LDA.l !REGISTER_ProductOrRemainderLo
	PHA
	LDA.b $B3
	STA.b $B1
	PLA
	SEP.b #$30
	CLC
	ADC.b $7A
	STA.b $7A
	XBA
	ADC.b #$00
	STA.b $7B
CODE_02B51E:
	RTS

CODE_02B51F:
	REP.b #$30
	LDA.w !RAM_SIMC_City_CurrentYearLo
	STA.b $79
	STZ.b $7C
	LDA.w $01FB
	CMP.w #$0003
	BEQ.b CODE_02B537
	LDA.w $0DC3
	BNE.b CODE_02B537
	INC.b $79
CODE_02B537:
	JSR.w CODE_02B351
	REP.b #$30
	LDY.w #$0C50
	LDX.w #$004C
	LDA.w $01FB
	CMP.w #$0002
	BNE.b CODE_02B550
	LDY.w #$0050
	LDX.w #$004E
CODE_02B550:
	STY.b $79
	LDY.w #$0003
CODE_02B555:
	LDA.w $0D95,y
	AND.w #$00FF
	ORA.b $79
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	CLC
	ADC.w #$0010
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0040,x
	INX
	INX
	DEY
	BPL.b CODE_02B555
	RTS

CODE_02B56F:
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0BB5F3
	STX.b $09
	LDA.b #DATA_0BB5F3>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0BBCAD
	STX.b $09
	LDA.b #DATA_0BBCAD>>16
	STA.b $0B
	LDX.w #$2000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0C8E00
	STX.b $09
	LDA.b #DATA_0C8E00>>16
	STA.b $0B
	LDX.w #$7000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	LDX.w #$0000
	STZ.w !REGISTER_CGRAMAddress
CODE_02B5C2:
	LDA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$7000,x
	STA.w !REGISTER_WriteToCGRAMPort
	INX
	CPX.w #$0200
	BCC.b CODE_02B5C2
	SEP.b #$20
	STZ.b !RAM_SIMC_Global_OAMSizeAndDataAreaDesignation
	LDA.b #$09
	STA.b !RAM_SIMC_Global_BGModeAndTileSizeSetting
	LDA.b #$40
	STA.b !RAM_SIMC_Global_BG1AddressAndSize
	LDA.b #$4C
	STA.b !RAM_SIMC_Global_BG2AddressAndSize
	LDA.b #$02
	STA.b !RAM_SIMC_Global_BG3And4TileDataDesignation
	LDA.b #$15
	STA.b !RAM_SIMC_Global_MainScreenLayers
	LDA.b #$02
	STA.b !RAM_SIMC_Global_SubScreenLayers
	LDA.b #$02
	STA.b !RAM_SIMC_Global_ColorMathInitialSettings
	LDA.b #$41
	STA.b !RAM_SIMC_Global_ColorMathSelectAndEnable
	LDA.b #$E0
	STA.b !RAM_SIMC_Global_FixedColorData
	LDA.b #$50
	STA.b !RAM_SIMC_Global_BG3AddressAndSize
	LDA.w $0B1D
	BEQ.b CODE_02B608
	LDA.b #$48
	STA.b !RAM_SIMC_Global_BG1AddressAndSize
	LDA.b #$58
	STA.b !RAM_SIMC_Global_BG3AddressAndSize
CODE_02B608:
	RTS

CODE_02B609:
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0BB408
	STX.b $09
	LDA.b #DATA_0BB408>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0BC488
	STX.b $09
	LDA.b #DATA_0BC488>>16
	STA.b $0B
	LDX.w #$3000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0C8DAB
	STX.b $09
	LDA.b #DATA_0C8DAB>>16
	STA.b $0B
	LDX.w #$7000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	LDX.w #$0000
	STZ.w !REGISTER_CGRAMAddress
CODE_02B65C:
	LDA.l !RAM_SIMC_Global_GeneralPurposeBuffer+$7000,x
	STA.w !REGISTER_WriteToCGRAMPort
	INX
	CPX.w #$00A0
	BCC.b CODE_02B65C
	RTS

CODE_02B66A:
	REP.b #$30
	LDX.w #$0000
	STX.w $0B37
	LDA.w #$0006
	STA.b $79
CODE_02B677:
	LDA.w $0CED,x
	BMI.b CODE_02B6C7
	CLC
	ADC.w #$0010
	TAY
	LDA.b $79
	PHA
	JSR.w CODE_02B2EC
	REP.b #$30
	LDX.w $0B38
	LDA.w $0CEF,x
	STA.b $79
	STZ.b $7C
	JSR.w CODE_02B351
	REP.b #$20
	LDA.w $0B37
	AND.w #$00FF
	CLC
	ADC.w #$003B
	JSR.w CODE_02B266
	REP.b #$10
	JSR.w CODE_02B6D0
	SEP.b #$20
	INC.w $0B37
	LDA.w $0B38
	CLC
	ADC.b #$06
	STA.w $0B38
	REP.b #$30
	AND.w #$00FF
	TAX
	PLA
	INC
	STA.b $79
	CPX.w #$003C
	BCC.b CODE_02B677
CODE_02B6C7:
	PHP
	JSL.l CODE_0098A0	: dw $0602
	PLP
	RTS

CODE_02B6D0:
	SEP.b #$30
	PHB
	LDA.b #DATA_02B708>>16
	PHA
	PLB
	LDX.w $0B38
	LDA.w $0CF1,x
	DEC
	ASL
	ASL
	ASL
	REP.b #$30
	AND.w #$00FF
	TAY
	LDA.w $0B37
	AND.w #$00FF
	ASL
	TAX
	LDA.w DATA_02B768,x
	ASL
	TAX
CODE_02B6F4:
	LDA.w DATA_02B708,y
	CMP.w #$0FFF
	BEQ.b CODE_02B706
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	INX
	INX
	INY
	INY
	BNE.b CODE_02B6F4
CODE_02B706:
	PLB
	RTS

DATA_02B708:
	dw $0409,$0400,$040D,$0FFF,$0405,$0404,$0401,$0FFF
	dw $040C,$0400,$0411,$0FFF,$0400,$040F,$0411,$0FFF
	dw $040C,$0400,$0418,$0FFF,$0409,$0414,$040D,$0FFF
	dw $0409,$0414,$040B,$0FFF,$0400,$0414,$0406,$0FFF
	dw $0412,$0404,$040F,$0FFF,$040E,$0402,$0413,$0FFF
	dw $040D,$040E,$0415,$0FFF,$0403,$0404,$0402,$0FFF

DATA_02B768:
	dw $00C8,$0108,$0148,$0188,$01C8,$0208,$0248,$0288
	dw $02C8,$0308

DATA_02B77C:
	dw $0002,$0000,$0004,$0003,$0004,$0003,$0004,$0003
	dw $0000,$0000,$0006,$0006,$0006,$0004,$0004,$0004
	dw $0005,$0006,$0003,$0003,$0002,$0002,$0002,$0002
	dw $0006,$0007,$0008,$0004,$0004,$0004,$0003,$0004
	dw $0003,$0004,$0003,$0004,$0004,$0004,$0003,$0003
	dw $0003,$0003,$0002,$0002,$0002,$0002,$0002,$0002
	dw $0002,$0002,$0002,$0005,$0005,$0005,$0005,$0003
	dw $0003,$0003,$0003,$0004,$0004,$0004,$0004,$0004
	dw $0004,$0004,$0004,$0004,$0004

DATA_02B806:
	dw $0C20,$0020,$0020,$0C20,$0020,$0C20,$0020,$0C20
	dw $0020,$0020,$0820,$0820,$0820,$0020,$0020,$0020
	dw $0820,$0820

DATA_02B82A:
	dw $00D4,$0000,$0190,$0195,$01D0,$01D5,$0210,$0215
	dw $0000,$0000,$0294,$02F4,$0274,$018A,$01CA,$020A
	dw $02B5,$0254,$0163,$01A3,$0264,$02A4,$02E4,$0324
	dw $0117,$0196,$01D4,$02F8,$0338,$00E7,$00EB,$0127
	dw $012B,$0167,$016B,$01C7,$0207,$0267,$026B,$02A8
	dw $02E8,$0328,$00D9,$00F9,$0119,$0139,$0159,$0179
	dw $0199,$01B9,$01D9,$0218,$0258,$0298,$02D8,$0239
	dw $0279,$02B9,$02F9,$00C3,$0103,$0143,$0183,$01C3
	dw $0203,$0243,$0283,$02C3,$0303

DATA_02B8B4:
	db $A6,$A7,$A8,$A9,$AA,$FF,$C3,$C4,$C5,$C6,$C7,$C8,$C9,$CA,$FF,$D4
	db $D5,$D6,$D7,$D8,$D9,$DA,$DB,$DC,$FF,$AB,$AC,$AD,$AE,$AF,$FF,$B6
	db $B7,$B8,$B9,$BA,$BB,$FF,$CB,$CC,$CD,$CE,$CF,$D0,$D1,$D2,$D3,$FF
	db $B1,$B2,$B3,$B4,$FF,$81,$82,$83,$84,$85,$86,$87,$FF,$88,$89,$8A
	db $8B,$FF,$8C,$8D,$8E,$8F,$FF,$90,$91,$92,$93,$94,$95,$96,$FF,$97
	db $98,$99,$9A,$9B,$9C,$9D,$FF,$9E,$9F,$A0,$A1,$A2,$A3,$A4,$A5,$FF
	db $04,$30,$42,$48,$FF,$0C,$34,$33,$38,$44,$3C,$FF,$07,$30,$41,$33
	db $FF,$0D,$34,$46,$1F,$3C,$30,$48,$3E,$41,$1F,$34,$3B,$34,$32,$43
	db $34,$33,$FF,$0F,$3E,$3F,$44,$3B,$30,$43,$38,$3E,$3D,$1F,$32,$30
	db $3C,$34,$FE,$43,$3E,$1F,$23,$20,$1C,$20,$20,$20,$FF,$01,$34,$32
	db $30,$3C,$34,$1F,$43,$3E,$46,$3D,$FF,$01,$34,$32,$30,$3C,$34,$1F
	db $32,$38,$43,$48,$FF,$01,$34,$32,$30,$3C,$34,$1F,$32,$30,$3F,$38
	db $43,$30,$3B,$FF,$01,$34,$32,$30,$3C,$34,$1F,$3C,$34,$43,$41,$3E
	db $3F,$3E,$3B,$38,$42,$FF,$01,$34,$32,$30,$3C,$34,$FE,$3C,$34,$36
	db $30,$3B,$3E,$3F,$3E,$3B,$38,$42,$FF,$00,$1F,$3C,$3E,$3D,$42,$43
	db $34,$41,$1F,$FE,$30,$3F,$3F,$34,$30,$41,$34,$33,$FF,$0D,$44,$32
	db $3B,$34,$30,$41,$FE,$3C,$34,$3B,$43,$1F,$33,$3E,$46,$3D,$2C,$FF
	db $00,$1F,$3F,$3B,$30,$3D,$34,$1F,$32,$41,$30,$42,$37,$34,$33,$2C
	db $FF,$00,$1F,$43,$3E,$41,$3D,$30,$33,$3E,$FE,$3E,$32,$32,$44,$41
	db $41,$34,$33,$2C,$FF,$00,$1F,$35,$38,$41,$34,$1F,$3E,$32,$32,$44
	db $41,$41,$34,$33,$2C,$FF,$00,$1F,$33,$34,$3B,$44,$36,$34,$1F,$3E
	db $32,$32,$44,$41,$41,$34,$33,$2C,$FF,$0F,$3E,$3B,$3B,$44,$43,$38
	db $3E,$3D,$FE,$46,$30,$41,$3D,$38,$3D,$36,$2C,$FF,$00,$1F,$31,$38
	db $36,$1F,$34,$30,$41,$43,$37,$40,$44,$30,$3A,$34,$FE,$3E,$32,$32
	db $44,$41,$41,$34,$33,$2C,$FF,$02,$41,$38,$3C,$3D,$30,$3B,$1F,$46
	db $30,$41,$3D,$38,$3D,$36,$2C,$FF,$00,$1F,$42,$37,$38,$3F,$46,$41
	db $34,$32,$3A,$FE,$3E,$32,$32,$44,$41,$41,$34,$33,$2C,$FF,$25,$20
	db $43,$37,$1F,$30,$3D,$3D,$38,$45,$34,$41,$42,$30,$41,$48,$FF,$05
	db $3E,$41,$3C,$30,$43,$38,$3E,$3D,$1F,$3E,$35,$1F,$30,$1F,$FE,$42
	db $38,$42,$43,$34,$41,$1F,$32,$38,$43,$48,$FF,$0F,$3E,$3F,$44,$3B
	db $30,$43,$38,$3E,$3D,$FE,$1F,$32,$30,$3C,$34,$1F,$43,$3E,$1F,$26
	db $20,$20,$1C,$20,$20,$20,$FF,$14,$05,$0E,$1E,$42,$1F,$30,$43,$43
	db $30,$32,$3A,$2C,$FF

DATA_02BAB9:
	dw $0267,$02A7,$02E7,$0327,$0216,$0257,$00CC,$010C
	dw $014C,$018C,$01CC,$020C,$024C,$028C,$02CC,$030C

DATA_02BAD9:
	dw $0000,$0006,$000F,$0019,$001F,$0026,$0030,$0035
	dw $003D,$0042,$0047,$004F,$0057,$0060,$0065,$006C
	dw $0071,$0083,$009D,$00A9,$00B5,$00C4,$00D6,$00E9
	dw $00FD,$0110,$0121,$0135,$0146,$0159,$016C,$0187
	dw $0198,$01AE,$01BF,$01DB,$01F7

CODE_02BB23:
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_09A571
	STX.b $09
	LDA.b #DATA_09A571>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0BABF1
	STX.b $09
	LDA.b #DATA_0BABF1>>16
	STA.b $0B
	LDX.w #$6000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	REP.b #$10
	LDX.w #$0000
	STX.w !REGISTER_VRAMAddressLo
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer
	STA.w DMA[$00].SourceLo,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$80
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_02BB93
CODE_02BB8F:
	ASL
	DEX
	BNE.b CODE_02BB8F
CODE_02BB93:
	STA.w !REGISTER_DMAEnable
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_08C4DB
	STX.b $09
	LDA.b #DATA_08C4DB>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	REP.b #$10
	LDX.w #$4000
	STX.w !REGISTER_VRAMAddressLo
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer
	STA.w DMA[$00].SourceLo,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$20
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_02BBED
CODE_02BBE9:
	ASL
	DEX
	BNE.b CODE_02BBE9
CODE_02BBED:
	STA.w !REGISTER_DMAEnable
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0C8AD8
	STX.b $09
	LDA.b #DATA_0C8AD8>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	STZ.w !REGISTER_CGRAMAddress
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$00
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToCGRAMPort
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer
	STA.w DMA[$00].SourceLo,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$02
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_02BC44
CODE_02BC40:
	ASL
	DEX
	BNE.b CODE_02BC40
CODE_02BC44:
	STA.w !REGISTER_DMAEnable
	RTL

CODE_02BC48:
	REP.b #$20
	STZ.b !RAM_SIMC_TitleScreenAndMenu_Layer1XPosLo
	STZ.b !RAM_SIMC_TitleScreenAndMenu_Layer2XPosLo
	STZ.b !RAM_SIMC_TitleScreenAndMenu_Layer3XPosLo
	STZ.b !RAM_SIMC_TitleScreenAndMenu_Layer1YPosLo
	STZ.b !RAM_SIMC_TitleScreenAndMenu_Layer2YPosLo
	STZ.b !RAM_SIMC_TitleScreenAndMenu_Layer3YPosLo
	SEP.b #$20
	LDA.b #$01
	STA.b !RAM_SIMC_Global_BGModeAndTileSizeSetting
	LDA.b #$30
	STA.b !RAM_SIMC_Global_BG3AddressAndSize
	LDA.b #$04
	STA.b !RAM_SIMC_Global_BG3And4TileDataDesignation
	STZ.b !RAM_SIMC_Global_OAMSizeAndDataAreaDesignation
	LDA.b #$14
	STA.b !RAM_SIMC_Global_MainScreenLayers
	STZ.b !RAM_SIMC_Global_SubScreenLayers
	LDA.b #$E0
	STA.b !RAM_SIMC_Global_FixedColorData
	STZ.b !RAM_SIMC_Global_ColorMathSelectAndEnable
	LDA.b #$08
	CMP.b $08
	BEQ.b CODE_02BC7A
	STA.b $03
CODE_02BC7A:
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	REP.b #$20
	LDA.w #$0003
	COP.b #$00
	LDA.w #$0003
	STA.b $14
	RTL

CODE_02BC8F:
	REP.b #$30
	STZ.w $0253
	LDA.w #$0080
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$000D
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	LDA.w #$0010
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	LDA.w #$0088
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.b $44
	BEQ.b CODE_02BCD0
	LDA.w #$000E
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	BRA.b CODE_02BCD6

CODE_02BCD0:
	LDA.w #$0074
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
CODE_02BCD6:
	LDA.w #$000F
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDA.b #$32
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.b #$00
	XBA
	LDA.b #$00
	LDY.b $44
	BEQ.b CODE_02BCF6
	INC
CODE_02BCF6:
	ASL
	ASL
	ADC.b $3E
	TAX
	LDA.w DATA_03D37C,x
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.b #$0C
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	RTL

CODE_02BD0E:
	REP.b #$30
	REP.b #$20
	LDA.w #$0001
	COP.b #$00
	STZ.w $0421
	LDA.w #$0008
	STA.w $0253
	LDA.w #$0080
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$000D
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	LDA.w #$0010
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	LDA.w #$000E
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	LDA.w #$002B
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	LDA.w #$0120
	STA.w $0253
	LDA.w #$0070
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w #$0084
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$002A
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	LDA.w #$00A4
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$002A
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	LDA.b $44
	AND.w #$0001
	BEQ.b CODE_02BE09
	SEP.b #$20
	REP.b #$10
	PHB
	LDA.b #CODE_008000>>16
	PHA
	PLB
	LDX.w $0B67
	STX.b $7F
	STZ.b $81
	LDX.w #$00007F
	JSL.l CODE_008FEB
	PLB
	SEP.b #$30
	LDY.b #$00
	TYX
	CLC
CODE_02BDB4:
	LDA.l SIMC_Global_OAMBuffer[$48].Tile,x
	ADC.w $007B,y
	STA.l SIMC_Global_OAMBuffer[$48].Tile,x
	LDA.l SIMC_Global_OAMBuffer[$49].Tile,x
	ADC.w $007B,y
	STA.l SIMC_Global_OAMBuffer[$49].Tile,x
	TXA
	CLC
	ADC.b #$08
	TAX
	INY
	CPY.b #$04
	BNE.b CODE_02BDB4
	LDY.b #$00
	TYX
	LDA.w $0B6B
	BEQ.b CODE_02BE27
CODE_02BDDC:
	PHY
	LDA.w $0B6C,y
	ASL
	TAY
	REP.b #$20
	LDA.w DATA_03DD00,y
	AND.w #$31FF
	STA.l SIMC_Global_OAMBuffer[$50].Tile,x
	CLC
	ADC.w #$0010
	AND.w #$31FF
	STA.l SIMC_Global_OAMBuffer[$51].Tile,x
	SEP.b #$20
	TXA
	CLC
	ADC.b #$08
	TAX
	PLY
	INY
	CPY.w $0B6B
	BNE.b CODE_02BDDC
	BRA.b CODE_02BE27

CODE_02BE09:
	LDY.w #$0000
	TYX
CODE_02BE0D:
	LDA.w #$302C
	STA.l SIMC_Global_OAMBuffer[$48].Tile,x
	LDA.w #$303C
	STA.l SIMC_Global_OAMBuffer[$49].Tile,x
	TXA
	CLC
	ADC.w #$0008
	TAX
	INY
	CPY.w #$000C
	BNE.b CODE_02BE0D
CODE_02BE27:
	REP.b #$30
	LDA.b $44
	AND.w #$0002
	BEQ.b CODE_02BEA3
	SEP.b #$20
	REP.b #$10
	PHB
	LDA.b #CODE_008000>>16
	PHA
	PLB
	LDX.w $0B77
	STX.b $7F
	STZ.b $81
	LDX.w #$00007F
	JSL.l CODE_008FEB
	PLB
	SEP.b #$30
CODE_02BE4A:
	LDY.b #$00
	TYX
	CLC
CODE_02BE4E:
	LDA.l SIMC_Global_OAMBuffer[$60].Tile,x
	ADC.w $007B,y
	STA.l SIMC_Global_OAMBuffer[$60].Tile,x
	LDA.l SIMC_Global_OAMBuffer[$61].Tile,x
	ADC.w $007B,y
	STA.l SIMC_Global_OAMBuffer[$61].Tile,x
	TXA
	ADC.b #$08
	TAX
	INY
	CPY.b #$04
	BNE.b CODE_02BE4E
	LDY.b #$00
	LDX.b #$00
	LDA.w $0B7B
	BEQ.b CODE_02BEC1
CODE_02BE76:
	PHY
	LDA.w $0B7C,y
	ASL
	TAY
	REP.b #$20
	LDA.w DATA_03DD00,y
	AND.w #$31FF
	STA.l SIMC_Global_OAMBuffer[$68].Tile,x
	CLC
	ADC.w #$0010
	AND.w #$31FF
	STA.l SIMC_Global_OAMBuffer[$69].Tile,x
	SEP.b #$20
	TXA
	CLC
	ADC.b #$08
	TAX
	PLY
	INY
	CPY.w $0B7B
	BNE.b CODE_02BE76
	BRA.b CODE_02BEC1

CODE_02BEA3:
	LDY.w #$0000
	TYX
CODE_02BEA7:
	LDA.w #$302C
	STA.l SIMC_Global_OAMBuffer[$60].Tile,x
	LDA.w #$303C
	STA.l SIMC_Global_OAMBuffer[$61].Tile,x
	TXA
	CLC
	ADC.w #$0008
	TAX
	INY
	CPY.w #$000C
	BNE.b CODE_02BEA7
CODE_02BEC1:
	REP.b #$30
	INC.b $14
	RTL

CODE_02BEC6:
	LDA.b $CA
	AND.w #$000C
	BEQ.b CODE_02BEDE
	SEP.b #$20
	LDA.b #$07
	STA.b $06
	REP.b #$20
	LDA.w $0421
	EOR.w #$0001
	STA.w $0421
CODE_02BEDE:
	REP.b #$30
	STZ.w $0253
	LDA.w #$0032
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDX.w $0421
	LDA.w DATA_03E2DD,x
	AND.w #$00FF
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$000C
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	RTL

DATA_02BF03:
	dw DATA_02BFE3,DATA_02C087,DATA_02C123,DATA_02C217,DATA_02C27D,DATA_02C2D5,DATA_02C2E9,DATA_02C46D
	dw DATA_02C57F,DATA_02C623,DATA_02C6C7,DATA_02C83F,DATA_02C921,DATA_02C94D

DATA_02BF1F:
	dw DATA_02C02D,DATA_02C0D3,DATA_02C193,DATA_02C243,DATA_02C29D,DATA_02C2D9,DATA_02C371,DATA_02C4E9
	dw DATA_02C5C9,DATA_02C655,DATA_02C76F,DATA_02C8A5,DATA_02C927,DATA_02C9C5

DATA_02BF3B:
	dw DATA_02C07B,DATA_02C07B,DATA_02C205,DATA_02C273,DATA_02C2C1,DATA_02C2E1,DATA_02C3FD,DATA_02C56D
	dw DATA_02C617,DATA_02C68B,DATA_02C81B,DATA_02C913,DATA_02C931,DATA_02CA41

DATA_02BF57:
	dw DATA_02C07F,DATA_02C07F,DATA_02C20D,DATA_02C275,DATA_02C2C9,DATA_02C2E3,DATA_02C433,DATA_02C575
	dw DATA_02C61B,DATA_02C6A7,DATA_02C82B,DATA_02C919,DATA_02C93D,DATA_02CA77

DATA_02BF73:
	dw $004A,$004C,$0070,$002C,$0020,$0004,$0088,$007C
	dw $004A,$0032,$00A8,$0066,$0006,$0078

DATA_02BF8F:
	dw $004E,$0050,$0072,$0030,$0024,$0008,$008C,$0084
	dw $004E,$0036,$00AC,$006E,$000A,$007C

DATA_02BFAB:
	dw $0004,$0004,$0008,$0002,$0008,$0002,$0036,$0008
	dw $0004,$001C,$0010,$0006,$000C,$0036

DATA_02BFC7:
	dw $0008,$0008,$000A,$0008,$000C,$0006,$003A,$000A
	dw $0008,$0020,$0014,$0008,$0010,$003A

DATA_02BFE3:
	dw $0000,$0001,$0002,$0003,$0000,$0000,$0000,$0008
	dw $000A,$0009,$0008,$000A,$0009,$0008,$000A,$0009
	dw $0008,$0004,$0005,$0004,$0005,$0004,$0005,$0004
	dw $0005,$0004,$0005,$0008,$0004,$0005,$0004,$0005
	dw $0004,$0005,$0004,$0005,$0008

DATA_02C02D:
	dw $0004,$0004,$0004,$0004,$FFFD,$0006,$0004,$0008
	dw $0008,$0008,$0008,$0008,$0008,$0008,$0008,$0008
	dw $0010,$0008,$0008,$0008,$0008,$0008,$0008,$0008
	dw $0008,$0008,$0008,$0010,$0008,$0008,$0008,$0008
	dw $0008,$0008,$0008,$0008,$0020,$FFFE,$0020

DATA_02C07B:
	dw $FE00,$0000

DATA_02C07F:
	dw $0040,$0050,$FFFE,$0003

DATA_02C087:
	dw $0000,$0001,$0002,$0003,$0000,$0000,$0000,$000B
	dw $000D,$0009,$0008,$000B,$000C,$0009,$0008,$000B
	dw $000D,$0009,$0008,$000B,$000C,$0009,$0008,$0004
	dw $0005,$0004,$0005,$0004,$0005,$0008,$000B,$000D
	dw $0009,$0008,$000B,$000C,$0009,$0008

DATA_02C0D3:
	dw $0004,$0004,$0004,$0004,$FFFD,$0006,$0004,$0018
	dw $0008,$0008,$0008,$0008,$0010,$0008,$0008,$0008
	dw $0010,$0008,$0008,$0008,$0010,$0008,$0008,$0008
	dw $0008,$0008,$0008,$0008,$0008,$0020,$0018,$0008
	dw $0008,$0008,$0018,$0008,$0008,$0008,$FFFE,$0021

DATA_02C123:
	dw $0000,$0001,$0002,$0003,$0000,$0000,$0000,$000E
	dw $000F,$0010,$0011,$0012,$0011,$0012,$0011,$0012
	dw $0011,$0012,$001F,$0004,$0005,$0006,$0007,$0006
	dw $0007,$0006,$0007,$0004,$0005,$0004,$0005,$0004
	dw $0005,$0004,$0005,$0004,$0005,$0004,$0004,$0005
	dw $0004,$0005,$0004,$0005,$0004,$0005,$0013,$0014
	dw $0015,$0016,$0000,$0000,$0000,$0013,$0014,$0015

DATA_02C193:
	dw $0004,$0004,$0004,$0004,$FFFD,$0006,$0004,$0020
	dw $0030,$0030,$0008,$0008,$0008,$0008,$0008,$0008
	dw $0008,$0008,$0030,$0010,$0040,$0008,$0008,$0008
	dw $0008,$0008,$0008,$0008,$0008,$0008,$0008,$0020
	dw $0008,$0008,$0008,$0008,$0008,$0020,$0008,$0008
	dw $0008,$0008,$0008,$0008,$0040,$0040,$0004,$0004
	dw $0004,$0004,$FFFD,$0006,$0004,$0004,$0004,$0004
	dw $FFFF

DATA_02C205:
	dw $FE00,$FF00,$0000,$0200

DATA_02C20D:
	dw $0040,$0020,$0288,$004C,$FFFF

DATA_02C217:
	dw $0026,$0027,$0028,$0026,$0027,$0028,$0026,$0027
	dw $0028,$0026,$0027,$0028,$0026,$0027,$0028,$0026
	dw $0027,$0028,$0026,$0029,$002A,$0029

DATA_02C243:
	dw $000A,$000A,$000A,$0006,$0006,$0006,$000A,$000A
	dw $000A,$000A,$000A,$000A,$000A,$000A,$000A,$0006
	dw $0006,$0006,$0020,$0060,$0060,$0060,$FFFE,$0018

DATA_02C273:
	dw $0000

DATA_02C275:
	dw $0050,$FFFE,$0003,$FFFF

DATA_02C27D:
	dw $0000,$0001,$0002,$0003,$0000,$0000,$0000,$0000
	dw $0013,$0014,$0015,$0016,$0000,$0000,$0000,$0000

DATA_02C29D:
	dw $0004,$0004,$0004,$0004,$FFFD,$0006,$0008,$0050
	dw $0004,$0004,$0004,$0004,$FFFD,$0006,$0008,$0050
	dw $FFFE,$0012

DATA_02C2C1:
	dw $FE00,$0000,$0200,$0000

DATA_02C2C9:
	dw $0080,$0050,$0080,$0050,$FFFE,$0006

DATA_02C2D5:
	dw $0024,$0025

DATA_02C2D9:
	dw $0010,$0010,$FFFE,$0004

DATA_02C2E1:
	dw $0000

DATA_02C2E3:
	dw $0050,$FFFE,$0003

DATA_02C2E9:
	dw $0039,$003A,$0000,$0001,$0002,$0003,$0000,$0001
	dw $0008,$000A,$0009,$0008,$0000,$0000,$0000,$0008
	dw $0004,$0005,$0000,$0000,$0000,$0008,$0004,$0005
	dw $0000,$0000,$0000,$000A,$0008,$000A,$0008,$0019
	dw $001A,$0000,$0000,$0000,$0008,$0004,$0005,$0006
	dw $0007,$0000,$0000,$0000,$0004,$0005,$0004,$0005
	dw $0006,$0007,$0006,$0007,$0019,$001A,$0004,$0005
	dw $0000,$0000,$0000,$0008,$0013,$0014,$0015,$0016
	dw $0013,$0014,$003A,$0039

DATA_02C371:
	dw $0020,$0030,$0004,$0004,$0004,$0004,$0004,$0002
	dw $0008,$0008,$0008,$0008,$FFFD,$0005,$0003,$0008
	dw $0008,$0008,$FFFD,$0004,$0005,$0010,$0008,$0008
	dw $FFFD,$0004,$0004,$0020,$0010,$0020,$0010,$0020
	dw $0010,$FFFD,$0004,$0003,$0010,$0008,$0008,$0008
	dw $0008,$FFFD,$0006,$0002,$0008,$0008,$0008,$0008
	dw $0008,$0008,$0008,$0008,$0020,$0010,$0008,$0008
	dw $FFFD,$0004,$0003,$0040,$0004,$0004,$0004,$0004
	dw $0004,$0002,$0030,$0020,$FFFE,$0003

DATA_02C3FD:
	dw $0000,$2601,$FE00,$FE01,$FE00,$FE01,$FE00,$FE01
	dw $FE00,$FE01,$FE00,$FE01,$FE00,$0000,$0200,$02FF
	dw $0200,$02FF,$0200,$02FF,$0200,$02FF,$0200,$02FF
	dw $0200,$D8FF,$0000

DATA_02C433:
	dw $0050,$0001,$0003,$0001,$0003,$0001,$0003,$0001
	dw $0003,$0001,$0003,$0001,$0001,$0318,$0003,$0001
	dw $0003,$0001,$0003,$0001,$0003,$0001,$0003,$0001
	dw $0002,$0001,$004F,$FFFE,$0003

DATA_02C46D:
	dw $0013,$0014,$0015,$0016,$0000,$0000,$0000,$0000
	dw $0001,$0002,$0003,$0000,$0000,$0000,$0004,$0005
	dw $0000,$0000,$0000,$0006,$0004,$001F,$001E,$0000
	dw $0000,$0000,$001F,$0017,$0004,$0005,$0007,$0005
	dw $001D,$0005,$001D,$0004,$0005,$0004,$0005,$0000
	dw $0000,$0000,$001E,$001F,$001E,$001F,$001E,$001F
	dw $0004,$0005,$0004,$0005,$0017,$0005,$0017,$0005
	dw $0004,$0005,$0013,$0014,$0015,$0016

DATA_02C4E9:
	dw $0004,$0004,$0004,$0004,$FFFD,$0006,$0006,$0004
	dw $0004,$0004,$0004,$FFFD,$0006,$0002,$0008,$0008
	dw $FFFD,$0004,$0003,$0010,$0010,$0010,$0010,$FFFD
	dw $0004,$0003,$0030,$0040,$0030,$000C,$000C,$000C
	dw $000C,$000C,$000C,$0008,$0008,$000C,$000C,$FFFD
	dw $0006,$0003,$0010,$0010,$0010,$0010,$0010,$0050
	dw $0008,$0008,$000C,$000C,$0030,$0010,$0030,$0010
	dw $0008,$0008,$0004,$0004,$0004,$0004,$FFFD,$0006
	dw $0004,$FFFF

DATA_02C56D:
	dw $0200,$FE00,$0000,$0200

DATA_02C575:
	dw $0060,$0020,$0368,$0040,$FFFF

DATA_02C57F:
	dw $0000,$0001,$0002,$0003,$0000,$0000,$0000,$0004
	dw $0004,$0005,$0000,$0000,$0000,$0006,$0007,$0006
	dw $0007,$0004,$0005,$0030,$0031,$0030,$0031,$0030
	dw $0031,$0030,$0031,$0032,$0032,$0033,$0000,$0000
	dw $0000,$0034,$0035,$0034,$0036

DATA_02C5C9:
	dw $0004,$0004,$0004,$0004,$FFFD,$0006,$0004,$0010
	dw $0008,$0008,$FFFD,$0004,$0004,$0008,$0008,$0008
	dw $0008,$0008,$0008,$0010,$0010,$0010,$0010,$0008
	dw $0008,$0006,$0006,$0020,$0002,$0002,$FFFD,$0004
	dw $0006,$0010,$0020,$0004,$0020,$FFFE,$0020

DATA_02C617:
	dw $FE00,$0000

DATA_02C61B:
	dw $0040,$0050,$FFFE,$0003

DATA_02C623:
	dw $0039,$003A,$0000,$0001,$0002,$0003,$0000,$0001
	dw $0017,$0018,$0000,$0000,$0000,$0017,$0019,$001A
	dw $0000,$0000,$0000,$001D,$001C,$0000,$0000,$0000
	dw $0032

DATA_02C655:
	dw $0020,$0030,$0004,$0004,$0004,$0004,$0004,$0002
	dw $0010,$0010,$FFFD,$0004,$0004,$0006,$0006,$0006
	dw $FFFD,$0005,$0005,$0010,$0010,$FFFD,$0004,$0004
	dw $0010,$FFFE,$0013

DATA_02C68B:
	dw $0000,$26FE,$FE00,$FE00,$FE00,$FE01,$FE00,$FE00
	dw $FE00,$FE00,$FE00,$FE01,$FE00,$0000

DATA_02C6A7:
	dw $0050,$0001,$0003,$0001,$0003,$0001,$0003,$0001
	dw $0003,$0001,$0003,$0001,$0001,$0050,$FFFE,$0003

DATA_02C6C7:
	dw $0013,$0014,$0015,$0016,$0000,$0000,$0000,$001D
	dw $0033,$0032,$0000,$0000,$0000,$0017,$0019,$001A
	dw $001D,$0017,$0019,$001A,$0004,$0017,$001A,$0034
	dw $0033,$0032,$0000,$0000,$0000,$0033,$001D,$0033
	dw $001D,$0036,$0013,$0014,$0015,$0016,$0000,$0000
	dw $0000,$0013,$0000,$0001,$0002,$0003,$0000,$0000
	dw $0000,$001D,$0045,$0044,$0000,$0000,$0000,$0017
	dw $0019,$001A,$001D,$0017,$0019,$001A,$0004,$0017
	dw $001A,$0036,$0045,$0044,$0000,$0000,$0000,$0045
	dw $001D,$0045,$001D,$0034,$0000,$0001,$0002,$0003
	dw $0000,$0000,$0000,$0013

DATA_02C76F:
	dw $0004,$0004,$0004,$0004,$FFFD,$0006,$0004,$0008
	dw $0004,$0004,$FFFD,$0004,$0004,$0004,$0004,$0004
	dw $0006,$0004,$0004,$0004,$0006,$0006,$0006,$0010
	dw $0006,$0004,$FFFD,$0005,$0003,$000C,$000C,$000C
	dw $000C,$0010,$0004,$0004,$0004,$0004,$FFFD,$0006
	dw $0004,$0070,$0004,$0004,$0004,$0004,$FFFD,$0006
	dw $0004,$0008,$0004,$0004,$FFFD,$0004,$0004,$0004
	dw $0004,$0004,$0006,$0004,$0004,$0004,$0006,$0006
	dw $0006,$0010,$0006,$0004,$FFFD,$0005,$0003,$000C
	dw $000C,$000C,$000C,$0010,$0004,$0004,$0004,$0004
	dw $FFFD,$0006,$0004,$0070,$FFFE,$0056

DATA_02C81B:
	dw $0200,$0000,$0200,$0000,$FE00,$0000,$FE00,$0000

DATA_02C82B:
	dw $0040,$00E6,$0040,$0070,$0040,$00E6,$0040,$0070
	dw $FFFE,$000A

DATA_02C83F:
	dw $0013,$0014,$0015,$0016,$0000,$0000,$0000,$001D
	dw $0033,$0032,$0000,$0000,$0000,$0017,$0019,$001A
	dw $001D,$0017,$0019,$001A,$0004,$0017,$001A,$001D
	dw $0019,$001A,$0000,$0000,$0000,$0044,$0032,$0000
	dw $0000,$0000,$001D,$0019,$001A,$001D,$0019,$001A
	dw $0036,$001D,$0019,$001A,$001D,$0019,$001A,$0013
	dw $0014,$0015,$0016

DATA_02C8A5:
	dw $0004,$0004,$0004,$0004,$FFFD,$0006,$0004,$0008
	dw $0004,$0004,$FFFD,$0004,$0004,$0004,$0004,$0004
	dw $0006,$0004,$0004,$0004,$0006,$0006,$0006,$0004
	dw $0004,$0004,$FFFD,$0005,$0004,$0020,$0020,$FFFD
	dw $0004,$0003,$0004,$0004,$0004,$0004,$0004,$0004
	dw $0040,$0004,$0004,$0004,$0004,$0004,$0004,$0004
	dw $0004,$0004,$0004,$FFFD,$0006,$0004,$FFFF

DATA_02C913:
	dw $0200,$0000,$0200

DATA_02C919:
	dw $0040,$01B8,$0040,$FFFF

DATA_02C921:
	dw $0052,$0053,$0054

DATA_02C927:
	dw $0008,$0008,$0008,$FFFE,$0005

DATA_02C931:
	dw $FF00,$0000,$0100,$0000,$FF00,$0000

DATA_02C93D:
	dw $00C0,$0150,$0080,$0170,$0080,$0170,$FFFE,$0006

DATA_02C94D:
	dw $0039,$003A,$0000,$0001,$0002,$0003,$0000,$0001
	dw $0004,$0004,$0005,$0000,$0000,$0000,$0006,$0007
	dw $0006,$0007,$0004,$0005,$0000,$0000,$0000,$0004
	dw $0030,$0031,$0030,$0031,$0030,$0031,$0019,$001D
	dw $0019,$001D,$0004,$0005,$0004,$0005,$0000,$0000
	dw $0000,$0006,$0007,$0006,$0007,$0004,$0005,$0004
	dw $0005,$0000,$0000,$0000,$0013,$0014,$0015,$0016
	dw $0013,$0014,$003A,$0039

DATA_02C9C5:
	dw $0020,$0030,$0004,$0004,$0004,$0004,$0004,$0002
	dw $0010,$0008,$0008,$FFFD,$0004,$0004,$0008,$0008
	dw $0008,$0008,$0008,$0008,$FFFD,$0004,$0005,$0008
	dw $0020,$0020,$0020,$0020,$0010,$0010,$0008,$0008
	dw $0008,$0008,$0008,$0008,$000C,$000C,$FFFD,$0006
	dw $0002,$0008,$0008,$0008,$0008,$0008,$0008,$000C
	dw $000C,$FFFD,$0006,$0002,$0004,$0004,$0004,$0004
	dw $0004,$0002,$0030,$0020,$FFFE,$0003

DATA_02CA41:
	dw $0000,$2601,$FE00,$FE01,$FE00,$FE01,$FE00,$FE01
	dw $FE00,$FE01,$FE00,$FE01,$FE00,$0000,$0200,$02FF
	dw $0200,$02FF,$0200,$02FF,$0200,$02FF,$0200,$02FF
	dw $0200,$D8FF,$0000

DATA_02CA77:
	dw $0050,$0001,$0003,$0001,$0003,$0001,$0003,$0001
	dw $0003,$0001,$0003,$0001,$0001,$0248,$0003,$0001
	dw $0003,$0001,$0003,$0001,$0003,$0001,$0003,$0001
	dw $0002,$0001,$004F,$FFFE,$0003

DATA_02CAB1:
	dw DATA_02CB21,DATA_02CBD1,DATA_02CBF1,DATA_02CC65,DATA_02CCD5,DATA_02CDCD,DATA_02CE7D

DATA_02CABF:
	dw DATA_02CB6B,DATA_02CBD5,DATA_02CC0D,DATA_02CC8F,DATA_02CD43,DATA_02CDED,DATA_02CE9D

DATA_02CACD:
	dw DATA_02CBB9,DATA_02CBDD,DATA_02CC2D,DATA_02CCBD,DATA_02CDB5,DATA_02CE11,DATA_02CEC1

DATA_02CADB:
	dw DATA_02CBC3,DATA_02CBE5,DATA_02CC47,DATA_02CCC7,DATA_02CDBF,DATA_02CE45,DATA_02CEF5

DATA_02CAE9:
	dw $0052,$0004,$001C,$002A,$006E,$0020,$0020

DATA_02CAF7:
	dw $0056,$0008,$0020,$002E,$0072,$0024,$0024

DATA_02CB05:
	dw $000A,$0008,$001A,$000A,$000A,$0034,$0034

DATA_02CB13:
	dw $000E,$000C,$001E,$000E,$000E,$0038,$0038

DATA_02CB21:
	dw $0003,$0003,$0003,$0022,$0023,$0022,$0021,$0020
	dw $0021,$0022,$0023,$0022,$0021,$0000,$0000,$0000
	dw $0020,$0003,$0016,$0016,$002C,$002D,$002E,$002D
	dw $002C,$002B,$002C,$002D,$002E,$002D,$002C,$0000
	dw $0000,$0000,$0016,$0016,$0003

DATA_02CB6B:
	dw $0018,$0004,$0004,$0004,$0004,$0004,$0004,$0004
	dw $0004,$0004,$0004,$0004,$0004,$FFFD,$0008,$0004
	dw $0004,$0004,$0050,$0004,$0004,$0004,$0004,$0004
	dw $0004,$0004,$0004,$0004,$0004,$0004,$0004,$FFFD
	dw $0008,$0004,$0004,$0004,$0050,$FFFE,$0026

DATA_02CBB9:
	dw $0000,$FE00,$0000,$0200,$0000

DATA_02CBC3:
	dw $0018,$0080,$0050,$0080,$0050,$FFFE,$0006

DATA_02CBD1:
	dw $0037,$0038

DATA_02CBD5:
	dw $0004,$0004,$FFFE,$0004

DATA_02CBDD:
	dw $0000,$0000,$0400,$0000

DATA_02CBE5:
	dw $0040,$0114,$0040,$0014,$FFFE,$0005

DATA_02CBF1:
	dw $0014,$0013,$0014,$0015,$0016,$0013,$0039,$0039
	dw $0039,$001B,$0000,$0000,$0000,$0039

DATA_02CC0D:
	dw $003C,$0004,$0004,$0004,$0004,$0004,$0016,$00DA
	dw $0010,$0010,$FFFD,$0004,$0004,$0010,$FFFE,$0009

DATA_02CC2D:
	dw $0000,$0200,$0201,$0200,$0200,$0200,$0200,$0200
	dw $0201,$0200,$0200,$D802,$0000

DATA_02CC47:
	dw $003C,$0003,$0001,$0003,$0001,$0003,$0001,$0003
	dw $0001,$0003,$0001,$0001,$0050,$FFFE,$0003

DATA_02CC65:
	dw $0046,$0046,$0047,$0048,$0049,$0000,$0000,$0000
	dw $0046,$0047,$0046,$0040,$0041,$0042,$0043,$0000
	dw $0000,$0000,$0040,$0041,$0046

DATA_02CC8F:
	dw $0106,$0018,$0010,$0004,$0004,$FFFD,$0004,$000A
	dw $0004,$0004,$0156,$0018,$0010,$0004,$0004,$FFFD
	dw $0004,$000A,$0004,$0004,$0156,$FFFE,$0016

DATA_02CCBD:
	dw $0000,$0200,$0000,$FE00,$0000

DATA_02CCC7:
	dw $0106,$0080,$0156,$0080,$0156,$FFFE,$0006

DATA_02CCD5:
	dw $0000,$0001,$0002,$0003,$0000,$0000,$0000,$0000
	dw $0001,$0002,$0003,$0000,$0000,$0000,$0004,$0050
	dw $0004,$0050,$0004,$0005,$0006,$0007,$0005,$0006
	dw $0007,$0005,$0006,$0007,$0005,$0006,$0007,$0013
	dw $0014,$0015,$0016,$0000,$0000,$0000,$0004,$0051
	dw $0004,$0051,$0004,$0005,$0006,$0007,$0005,$0006
	dw $0007,$0005,$0006,$0007,$0005,$0006,$0007

DATA_02CD43:
	dw $0004,$0004,$0004,$0004,$FFFD,$0006,$0002,$0004
	dw $0004,$0004,$0004,$FFFD,$0006,$0004,$0010,$0050
	dw $0010,$0010,$0030,$0008,$0010,$0010,$0008,$0008
	dw $0008,$0008,$0010,$0010,$0008,$0008,$0088,$0004
	dw $0004,$0004,$0004,$FFFD,$0006,$0004,$0010,$0050
	dw $0010,$0010,$0030,$0008,$0010,$0010,$0008,$0008
	dw $0008,$0008,$0010,$0010,$0008,$0008,$0088,$FFFE
	dw $0032

DATA_02CDB5:
	dw $FE00,$FE00,$0000,$0200,$0000

DATA_02CDBF:
	dw $0020,$0040,$01B0,$0040,$01B0,$FFFE,$0006

DATA_02CDCD:
	dw $0014,$0013,$0014,$0015,$0016,$0013,$0039,$0039
	dw $0039,$0000,$0001,$0002,$0003,$0000,$0001,$0001

DATA_02CDED:
	dw $003C,$0004,$0004,$0004,$0004,$0004,$0016,$0318
	dw $0016,$0004,$0004,$0004,$0004,$0004,$0004,$0020
	dw $FFFE,$0003

DATA_02CE11:
	dw $0000,$0200,$0201,$0200,$0201,$0200,$0201,$0200
	dw $0201,$0200,$0201,$D8FF,$0000,$2801,$FE00,$FEFF
	dw $FE00,$FEFF,$FE00,$FEFF,$FE00,$FEFF,$FE00,$FEFF
	dw $FE00,$0000

DATA_02CE45:
	dw $003C,$0003,$0001,$0003,$0001,$0003,$0001,$0003
	dw $0001,$0003,$0001,$0001,$0343,$0001,$0003,$0001
	dw $0003,$0001,$0003,$0001,$0003,$0001,$0003,$0001
	dw $0003,$003C,$FFFE,$0003

DATA_02CE7D:
	dw $0014,$0013,$0014,$0015,$0016,$0013,$0039,$0039
	dw $0039,$0000,$0001,$0002,$0003,$0000,$0001,$0001

DATA_02CE9D:
	dw $003C,$0004,$0004,$0004,$0004,$0004,$0016,$0248
	dw $0016,$0004,$0004,$0004,$0004,$0004,$0004,$0020
	dw $FFFE,$0003

DATA_02CEC1:
	dw $0000,$0200,$0201,$0200,$0201,$0200,$0201,$0200
	dw $0201,$0200,$0201,$D8FF,$0000,$2801,$FE00,$FEFF
	dw $FE00,$FEFF,$FE00,$FEFF,$FE00,$FEFF,$FE00,$FEFF
	dw $FE00,$0000

DATA_02CEF5:
	dw $003C,$0003,$0001,$0003,$0001,$0003,$0001,$0003
	dw $0001,$0003,$0001,$0001,$0273,$0001,$0003,$0001
	dw $0003,$0001,$0003,$0001,$0003,$0001,$0003,$0001
	dw $0003,$003C,$FFFE,$0003

DATA_02CF2D:
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$3078,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$3094,$3095,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$309F,$30A0,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$28FC,$28FD,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2907,$2908,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$292D,$292E
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2938
	dw $2939,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2955,$2956,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2960,$2961,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$296B,$296C,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2F9F,$2FA0,$2FA1,$2D90,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2FA7,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2DAA,$2FAE,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$25B0
	dw $25B1,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$29E4,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $39C4,$39C5,$39C6,$39C7,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $39D8,$39D9,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$3FCA,$3FCB,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$3FDB,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$264F,$2650,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$3E5A,$3E5B
	dw $3E5C,$3E5D,$2300,$2300,$2300,$2300,$2300,$2300
	dw $3F5B,$3F5C,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $3307,$2300,$2300,$2300,$2300,$2300,$2300,$3308
	dw $3309,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$331C,$331D,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2B30,$2B31,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2B32,$2B33,$2B34,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2B47,$2B48,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300,$2300,$2300
	dw $2300,$2300,$2300,$2300,$2300,$2300

DATA_02D6A9:
	dw $06A5,$0770,$0770,$0770,$0760,$0761,$0762,$0763
	dw $0764,$0765,$0766,$0767,$0768,$0769,$076A,$076B
	dw $076C,$076D,$076E,$076F,$1E8E,$1E8F,$1E90,$1E91
	dw $1E92,$1E93,$1E94,$1E95,$1E96,$1E97,$1E98,$1E99
	dw $1E9A,$1E9B,$1E9C,$1E9D,$1E9E,$1E9F,$1EA0,$06A1
	dw $06A2,$06A3,$06A6,$06A7,$06A8,$06A9,$000F,$000F
	dw $06BA,$06BB,$06BC,$06BD,$06BE,$06BF,$06C0,$06C1
	dw $06C2,$06C3,$06C4,$06C5,$06C6,$06C7,$06C8,$000F
	dw $0777,$0778,$0779,$077A,$077B,$077C,$077D,$077E
	dw $077F,$0780,$0781,$0782,$0783,$0784,$0785,$000F
	dw $0786,$0787,$0788,$0789,$078A,$078B,$078C,$078D
	dw $078E,$078F,$0790,$0791,$0792,$0793,$0794,$000F
	dw $0773,$0774,$06C9,$06CA,$06CB,$06CC,$06CD,$06CE
	dw $06CF,$06D0,$06D1,$06D2,$06D3,$06D4,$06D5,$000F
	dw $0771,$0772,$06D6,$06D7,$06D8,$06D9,$06DA,$06DB
	dw $06DC,$06DD,$06DE,$06DF,$06E0,$06E1,$06E2,$0775
	dw $0400,$0401,$0402,$0403,$0404,$0405,$0406,$0407
	dw $0408,$1009,$100A,$100B,$100C,$100D,$100E,$100F
	dw $1010,$1011,$1012,$1013,$1014,$1015,$1016,$1017
	dw $1019,$101A,$101B,$101B,$101C,$101D,$101E,$101F
	dw $1020,$1021,$1022,$1023,$1024,$1025,$1026,$1027
	dw $1028,$1029,$102A,$102B,$102C,$102D,$102E,$102F
	dw $1030,$1031,$1032,$1033,$1034,$1035,$1036,$1037
	dw $1038,$1039,$103A,$103B,$103C,$103D,$103E,$103F
	dw $1040,$1041,$1042,$1043,$1044,$1045,$1046,$1047
	dw $1048,$1049,$104A,$104B,$104C,$104D,$104E,$104F
	dw $1050,$1051,$1052,$1053,$1054,$1055,$1056,$1057
	dw $1058,$1059,$105A,$105B,$105C,$105D,$105E,$105F
	dw $1060,$1061,$1062,$1063,$1064,$1065,$1066,$1067
	dw $1068,$1069,$106A,$106B,$106C,$106D,$106E,$106F
	dw $1070,$1071,$1072,$1073,$1074,$1075,$1076,$1077
	dw $1079,$107A,$107B,$107C,$107D,$107E,$107F,$1080
	dw $1081,$1082,$1083,$1084,$1085,$1086,$1087,$1088
	dw $1089,$108A,$108B,$108C,$108D,$108E,$108F,$1090
	dw $1091,$1092,$1093,$1096,$1097,$1098,$1099,$109A
	dw $109B,$109C,$109D,$109E,$10A1,$10A2,$10A3,$10A4
	dw $10A5,$10A6,$10A7,$10A8,$10A9,$12E3,$12E4,$12E5
	dw $12E6,$12E7,$12E8,$12E9,$12EA,$12EB,$12EC,$12ED
	dw $12EE,$12EF,$12F0,$12F1,$12F2,$12F3,$12F4,$08AA
	dw $08AB,$08AC,$08AD,$08AE,$08AF,$08B0,$08B1,$08B2
	dw $08B3,$08B4,$08B5,$08B6,$08B7,$08B8,$08B9,$08BA
	dw $08BB,$08BC,$08BD,$08BE,$08BF,$08C0,$08C1,$08C2
	dw $08C3,$08C4,$08C5,$08C6,$08C7,$08C8,$08C9,$08CA
	dw $08CB,$08CC,$08CD,$08CE,$08CF,$08D0,$08D1,$08D2
	dw $08D3,$08D4,$08D5,$08D6,$08D8,$08D9,$08DA,$08DB
	dw $08DC,$08DD,$08DE,$08DF,$08E0,$08E1,$08E2,$08E3
	dw $08E4,$08E5,$08E6,$08E7,$08E8,$08E9,$08EA,$08EB
	dw $08EC,$08ED,$08EE,$08EF,$08F0,$08F1,$08F2,$08F3
	dw $08F4,$08F5,$08F6,$08F7,$08F8,$08F9,$08FA,$08FB
	dw $08FE,$08FF,$0900,$0901,$0902,$0903,$0904,$0905
	dw $0906,$0909,$090A,$090B,$090C,$090D,$090E,$090F
	dw $0910,$0911,$0912,$0913,$0914,$0915,$0916,$0917
	dw $0918,$0919,$091A,$091B,$091C,$091D,$091E,$091F
	dw $0920,$0921,$0922,$0923,$0924,$0925,$0926,$0927
	dw $0928,$0929,$092A,$092B,$092C,$092F,$0930,$0931
	dw $0932,$0933,$0934,$0935,$0936,$0937,$093A,$093B
	dw $093C,$093D,$093E,$093F,$0940,$0941,$0942,$0943
	dw $0944,$0945,$0946,$0947,$0948,$0949,$094A,$094B
	dw $094C,$094D,$094E,$094F,$0950,$0951,$0952,$0953
	dw $0954,$0957,$0958,$0959,$095A,$095B,$095C,$095D
	dw $095E,$095F,$0962,$0963,$0964,$0965,$0966,$0967
	dw $0968,$0969,$096A,$096D,$096E,$096F,$0970,$0971
	dw $0972,$0973,$0974,$0975,$0576,$0577,$0578,$0579
	dw $057A,$057B,$057C,$057D,$057E,$0D7F,$0D80,$0D81
	dw $0D82,$0F95,$0F96,$0D83,$0F97,$0D84,$0D85,$0D86
	dw $0D87,$0D88,$0F98,$0D89,$0D8A,$0F99,$0D8B,$0F9A
	dw $0F9B,$0F9C,$0F9D,$0F9E,$0D8C,$0D8D,$0D8E,$0D8F
	dw $0D91,$0D92,$0D93,$0D94,$0D95,$0D96,$0D97,$0D98
	dw $0D99,$0D9A,$0D9B,$0D9C,$0D9D,$0FA2,$0D9E,$0FA3
	dw $0D9F,$0DA0,$0DA1,$0DA2,$0DA3,$0DA4,$0FA4,$0DA5
	dw $0FA5,$0FA6,$0DA6,$0FA8,$0FA9,$0DA7,$0FAA,$0FAB
	dw $0DA8,$0FAC,$0FAD,$0DA9,$0DAB,$0FAF,$0DAC,$0FB0
	dw $0FB1,$0DAD,$0FB2,$0DAE,$0DAF,$09BB,$09BC,$09BD
	dw $09BE,$09BF,$09C0,$09C1,$09C2,$09C3,$05B2,$05B3
	dw $05B4,$05B5,$05B6,$05B7,$05B8,$05B9,$05BA,$0BB9
	dw $0BBA,$0BBB,$09E5,$0BBC,$0BBD,$0BBE,$09E6,$0BBF
	dw $0BC0,$0BC1,$09E7,$0BC2,$0BC3,$0BC4,$09E8,$0BC5
	dw $09E9,$09EA,$09EB,$09EC,$09ED,$09EE,$09EF,$09F0
	dw $09F1,$09F2,$09F3,$09F4,$0BC6,$0BC7,$0BC8,$19C8
	dw $19C9,$19CA,$19CB,$19CC,$19CD,$19CE,$19CF,$19D0
	dw $19D1,$19D2,$19D3,$19D4,$19D5,$19D6,$19D7,$1BB3
	dw $1BB4,$1BB5,$19DA,$1BB6,$1BB7,$1BB8,$19DB,$19DC
	dw $19DD,$19DE,$19DF,$19E0,$19E1,$19E2,$19E3,$19F5
	dw $19F6,$19F7,$19F8,$19F9,$19FA,$19FB,$19FC,$19FD
	dw $19FE,$19FF,$1A00,$1A01,$1A02,$1A03,$1A04,$1A05
	dw $1A06,$1A07,$1A08,$1A09,$1A0A,$1A0B,$1A0C,$1A0D
	dw $1A0E,$1A0F,$1A10,$1BC9,$1A11,$1A12,$1A13,$1A14
	dw $1A15,$1A16,$1A17,$1E18,$1E19,$1E1A,$1E1B,$1E1C
	dw $1E1D,$1E1E,$1E1F,$1E20,$1E21,$1E22,$1E23,$1E24
	dw $1E25,$1E26,$1E27,$1E28,$1E29,$1E2A,$1E2B,$1E2C
	dw $1E2D,$1E2E,$1E2F,$1E30,$1E31,$1E32,$1E33,$1E34
	dw $1E35,$1E36,$1E37,$1E38,$1E39,$1E3A,$1E3B,$063C
	dw $063D,$063E,$063F,$0640,$0641,$0642,$0643,$0644
	dw $1FCC,$1FCD,$1E45,$1FCE,$1FCF,$1FD0,$1FD1,$1FD2
	dw $1FD3,$1E46,$1E47,$1FD4,$1FD5,$1FD6,$1FD7,$1FD8
	dw $1FD9,$1FDA,$1FDC,$1FDD,$1FDE,$1E48,$1FDF,$1FE0
	dw $1FE1,$1E49,$1FE2,$0BE3,$0BE4,$0A4A,$0BE5,$0BE6
	dw $0A4B,$0A4C,$0A4D,$0A4E,$07E7,$07E8,$0651,$07E9
	dw $07EA,$0652,$0653,$0654,$0655,$0A56,$0BEB,$0A57
	dw $0BEC,$0BED,$0BEE,$0A58,$0BEF,$0A59,$1E5E,$1E5F
	dw $1E60,$1E61,$1E62,$1E63,$1E64,$1E65,$1E66,$1FF9
	dw $1F5D,$1FFC,$1FFA,$1F5E,$1FFD,$1FFB,$1F5F,$1FFE
	dw $0BF0,$0BF1,$0BF2,$0BF3,$0BF4,$0BF5,$0A72,$0BF6
	dw $0BF7,$0A73,$0A74,$0A75,$0A76,$0A77,$0A78,$0A79
	dw $0A7A,$0A7B,$1E7C,$1E7D,$1E7E,$1E7F,$1E80,$1E81
	dw $1E82,$1E83,$1E84,$0A85,$0A86,$0A87,$0A88,$0A89
	dw $0A8A,$0A8B,$0A8C,$0A8D,$0770,$0770,$06AA,$06AB
	dw $06AC,$06AD,$06AE,$06AF,$06B0,$06B1,$0000,$0000
	dw $06B6,$06B7,$06B8,$06B9,$1AA4,$07F8,$0AF5,$0AF6
	dw $0AF7,$0AF8,$0AF9,$0AFA,$0AFB,$0AFC,$0AFD,$0AFE
	dw $0AFF,$0B02,$0B03,$0B04,$0B05,$0B06,$130A,$130B
	dw $130C,$1310,$1311,$1312,$1316,$1317,$1318,$130D
	dw $130E,$130F,$1313,$1314,$1315,$1319,$131A,$131B
	dw $131E,$131F,$1320,$1321,$1322,$1323,$1324,$1325
	dw $1326,$1327,$1328,$1329,$132A,$132B,$132C,$132D
	dw $132E,$132F,$0B35,$0B36,$0B37,$0B3B,$0B3C,$0B3D
	dw $0B41,$0B42,$0B43,$0B38,$0B39,$0B3A,$0B3E,$0B3F
	dw $0B40,$0B44,$0B45,$0B46,$0B49,$0B4A,$0B4B,$0B4C
	dw $0B4D,$0B4E,$0B4F,$0B50,$0B51,$0B52,$0B53,$0B54
	dw $0B55,$0B56,$0B57,$0B58,$0B59,$0B5A

DATA_02DE25:
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$017D,$017D,$017D,$017D,$017D,$017D,$017D
	dw $017D,$017D,$017D,$017D,$017D,$0150,$0151,$0152
	dw $0160,$0161,$0162,$0170,$0171,$0172,$0150,$0154
	dw $0155,$0160,$0164,$0165,$0170,$0171,$0172,$0150
	dw $0157,$0158,$0160,$0167,$0168,$0170,$0171,$0172
	dw $0150,$015A,$015B,$0160,$0161,$016B,$0170,$0171
	dw $0172,$0150,$0151,$0152,$0160,$0161,$0162,$0173
	dw $0174,$0175,$0150,$0154,$0155,$0160,$0164,$0165
	dw $0173,$0174,$0175,$0150,$0157,$0158,$0160,$0167
	dw $0168,$0173,$0174,$0175,$0150,$015A,$015B,$0160
	dw $0161,$016B,$0173,$0174,$0175,$0150,$0151,$0152
	dw $0160,$0161,$0162,$0176,$0177,$0178,$0150,$0154
	dw $0155,$0160,$0164,$0165,$0176,$0177,$0178,$0150
	dw $0157,$0158,$0160,$0167,$0168,$0176,$0177,$0178
	dw $0150,$015A,$015B,$0160,$0161,$016B,$0176,$0177
	dw $0178,$0150,$0151,$0152,$0160,$0161,$0162,$0179
	dw $017A,$017B,$0150,$0154,$0155,$0160,$0164,$0165
	dw $0179,$017A,$017B,$0150,$0157,$0158,$0160,$0167
	dw $0168,$0179,$017A,$017B,$0150,$015A,$015B,$0160
	dw $0161,$016B,$0179,$017A,$017B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $054D,$054E,$0552,$055D,$055E,$0562,$0570,$0571
	dw $0572,$054D,$054F,$0555,$055D,$055F,$0565,$0570
	dw $0571,$0572,$054D,$056C,$0558,$055D,$057C,$0568
	dw $0570,$0571,$0572,$054D,$056D,$055B,$055D,$055E
	dw $056B,$0570,$0571,$0572,$054D,$056E,$056F,$055D
	dw $057E,$057F,$0570,$0571,$0572,$054D,$054E,$0552
	dw $055D,$055E,$0562,$0573,$0574,$0575,$054D,$054F
	dw $0555,$055D,$055F,$0565,$0573,$0574,$0575,$054D
	dw $056C,$0558,$055D,$057C,$0568,$0573,$0574,$0575
	dw $054D,$056D,$055B,$055D,$055E,$056B,$0573,$0574
	dw $0575,$054D,$056E,$056F,$055D,$057E,$057F,$0573
	dw $0574,$0575,$054D,$054E,$0552,$055D,$055E,$0562
	dw $0576,$0577,$0578,$054D,$054F,$0555,$055D,$055F
	dw $0565,$0576,$0577,$0578,$054D,$056C,$0558,$055D
	dw $057C,$0568,$0576,$0577,$0578,$054D,$056D,$055B
	dw $055D,$055E,$056B,$0576,$0577,$0578,$054D,$056E
	dw $056F,$055D,$057E,$057F,$0576,$0577,$0578,$054D
	dw $054E,$0552,$055D,$055E,$0562,$0579,$057A,$057B
	dw $054D,$054F,$0555,$055D,$055F,$0565,$0579,$057A
	dw $057B,$054D,$056C,$0558,$055D,$057C,$0568,$0579
	dw $057A,$057B,$054D,$056D,$055B,$055D,$055E,$056B
	dw $0579,$057A,$057B,$054D,$056E,$056F,$055D,$057E
	dw $057F,$0579,$057A,$057B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$092C,$092D,$0952
	dw $093C,$095C,$0962,$0970,$0971,$0972,$092C,$092E
	dw $0955,$093C,$093E,$0965,$0970,$0971,$0972,$092C
	dw $092F,$0958,$093C,$093F,$0968,$0970,$0971,$0972
	dw $092C,$094C,$095B,$093C,$095C,$096B,$0970,$0971
	dw $0972,$092C,$092D,$0952,$093C,$095C,$0962,$0979
	dw $097A,$097B,$092C,$092E,$0955,$093C,$093E,$0965
	dw $0979,$097A,$097B,$092C,$092F,$0958,$093C,$093F
	dw $0968,$0979,$097A,$097B,$092C,$094C,$095B,$093C
	dw $095C,$096B,$0979,$097A,$097B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$014B,$014B
	dw $014B,$014B,$014B,$014B,$014B,$014B,$010C,$010D
	dw $010D,$011F,$0122,$0113,$011C,$011D,$011D,$010D
	dw $010D,$010E,$0114,$0115,$010F,$011D,$011D,$011E
	dw $010C,$010D,$010E,$011F,$0122,$010F,$011F,$0113
	dw $010F,$011F,$0114,$010F,$011F,$0115,$010F,$011C
	dw $011D,$011E,$050C,$050D,$050D,$051F,$0544,$0513
	dw $051C,$051D,$051D,$050D,$050D,$050E,$0514,$0515
	dw $050F,$051D,$051D,$051E,$050C,$050D,$050E,$051F
	dw $0544,$050F,$051F,$0513,$050F,$051F,$0514,$050F
	dw $051F,$0515,$050F,$051C,$051D,$051E

DATA_02E5A1:
	db $FF,$00

DATA_02E5A3:
	db $6B : dw DATA_02E5A1
	db $89 : dw DATA_02E5AD
	db $6C : dw DATA_02E5A1
	db $00

DATA_02E5AD:
	db $80,$80,$7D,$82,$7D,$82,$7C,$83,$7C,$83,$7C,$83,$7D,$82,$7D,$82
	db $80,$80

DATA_02E5BF:
	db $67 : dw DATA_02E5A1
	db $91 : dw DATA_02E5C9
	db $68 : dw DATA_02E5A1
	db $00

DATA_02E5C9:
	db $80,$80,$7C,$83,$7B,$84,$7A,$85,$7A,$85,$79,$86,$79,$86,$79,$86
	db $79,$86,$79,$86,$79,$86,$79,$86,$7A,$85,$7A,$85,$7B,$84,$7C,$83
	db $80,$80

DATA_02E5EB:
	db $63 : dw DATA_02E5A1
	db $99 : dw DATA_02E5F5
	db $64 : dw DATA_02E5A1
	db $00

DATA_02E5F5:
	db $80,$80,$7B,$84,$7A,$85,$79,$86,$78,$87,$77,$88,$77,$88,$76,$89
	db $76,$89,$76,$89,$75,$8A,$75,$8A,$75,$8A,$75,$8A,$75,$8A,$76,$89
	db $76,$89,$76,$89,$77,$88,$77,$88,$78,$87,$79,$86,$7A,$85,$7B,$84
	db $80,$80

DATA_02E627:
	db $5F : dw DATA_02E5A1
	db $A1 : dw DATA_02E631
	db $60 : dw DATA_02E5A1
	db $00

DATA_02E631:
	db $80,$80,$7B,$84,$79,$86,$78,$87,$77,$88,$76,$89,$75,$8A,$74,$8B
	db $74,$8B,$73,$8C,$73,$8C,$73,$8C,$72,$8D,$72,$8D,$72,$8D,$72,$8D
	db $72,$8D,$72,$8D,$72,$8D,$72,$8D,$72,$8D,$73,$8C,$73,$8C,$73,$8C
	db $74,$8B,$74,$8B,$75,$8A,$76,$89,$77,$88,$78,$87,$79,$86,$7B,$84
	db $80,$80

DATA_02E673:
	db $5B : dw DATA_02E5A1
	db $A9 : dw DATA_02E67D
	db $5C : dw DATA_02E5A1
	db $00

DATA_02E67D:
	db $80,$80,$7A,$85,$78,$87,$77,$88,$75,$8A,$74,$8B,$73,$8C,$73,$8C
	db $72,$8D,$71,$8E,$71,$8E,$70,$8F,$70,$8F,$70,$8F,$6F,$90,$6F,$90
	db $6F,$90,$6F,$90,$6F,$90,$6F,$90,$6F,$91,$6F,$90,$6F,$90,$6F,$90
	db $6F,$90,$6F,$90,$6F,$90,$70,$8F,$70,$8F,$70,$8F,$71,$8E,$71,$8E
	db $72,$8D,$73,$8C,$73,$8C,$74,$8B,$75,$8A,$77,$88,$78,$87,$7A,$85
	db $80,$80

DATA_02E6CF:
	db $57 : dw DATA_02E5A1
	db $B1 : dw DATA_02E6D9
	db $58 : dw DATA_02E5A1
	db $00

DATA_02E6D9:
	db $80,$80,$7A,$85,$77,$88,$76,$89,$74,$8B,$73,$8C,$72,$8D,$71,$8E
	db $70,$8F,$70,$8F,$6F,$90,$6E,$91,$6E,$91,$6D,$92,$6D,$92,$6D,$92
	db $6C,$93,$6C,$93,$6C,$93,$6C,$93,$6B,$94,$6B,$94,$6B,$94,$6B,$94
	db $6B,$94,$6B,$94,$6B,$94,$6B,$94,$6B,$94,$6C,$93,$6C,$93,$6C,$93
	db $6C,$93,$6D,$92,$6D,$92,$6D,$92,$6E,$91,$6E,$91,$6F,$90,$70,$8F
	db $70,$8F,$71,$8E,$72,$8D,$73,$8C,$74,$8B,$76,$89,$77,$88,$7A,$85
	db $80,$80

DATA_02E73B:
	db $53 : dw DATA_02E5A1
	db $B9 : dw DATA_02E745
	db $54 : dw DATA_02E5A1
	db $00

DATA_02E745:
	db $80,$80,$79,$86,$77,$88,$75,$8A,$73,$8C,$72,$8D,$71,$8E,$70,$8F
	db $6F,$90,$6E,$91,$6D,$92,$6D,$92,$6C,$93,$6B,$94,$6B,$94,$6A,$95
	db $6A,$95,$6A,$95,$69,$96,$69,$96,$69,$96,$68,$97,$68,$97,$68,$97
	db $68,$97,$68,$97,$68,$97,$68,$97,$68,$97,$68,$97,$68,$97,$68,$97
	db $68,$97,$68,$97,$68,$97,$68,$97,$69,$96,$69,$96,$69,$96,$6A,$95
	db $6A,$95,$6A,$95,$6B,$94,$6B,$94,$6C,$93,$6D,$92,$6D,$92,$6E,$91
	db $6F,$90,$70,$8F,$71,$8E,$72,$8D,$73,$8C,$75,$8A,$77,$88,$79,$86
	db $80,$80

DATA_02E7B7:
	db $4F : dw DATA_02E5A1
	db $C1 : dw DATA_02E7C1
	db $50 : dw DATA_02E5A1
	db $00

DATA_02E7C1:
	db $80,$80,$79,$86,$76,$89,$74,$8B,$72,$8D,$71,$8E,$70,$8F,$6F,$90
	db $6E,$91,$6D,$92,$6C,$93,$6B,$94,$6A,$95,$6A,$95,$69,$96,$68,$97
	db $68,$97,$67,$98,$67,$98,$67,$98,$66,$99,$66,$99,$66,$99,$65,$9A
	db $65,$9A,$65,$9A,$65,$9A,$65,$9A,$65,$9A,$64,$9B,$64,$9B,$64,$9B
	db $64,$9B,$64,$9B,$64,$9B,$64,$9B,$65,$9A,$65,$9A,$65,$9A,$65,$9A
	db $65,$9A,$65,$9A,$66,$99,$66,$99,$66,$99,$67,$98,$67,$98,$67,$98
	db $68,$97,$68,$97,$69,$96,$6A,$95,$6A,$95,$6B,$94,$6C,$93,$6D,$92
	db $6E,$91,$6F,$90,$70,$8F,$71,$8E,$72,$8D,$74,$8B,$76,$89,$79,$86
	db $80,$80

DATA_02E843:
	db $4B : dw DATA_02E5A1
	db $C9 : dw DATA_02E84D
	db $4C : dw DATA_02E5A1
	db $00

DATA_02E84D:
	db $80,$80,$78,$87,$75,$8A,$73,$8C,$71,$8E,$70,$8F,$6F,$90,$6D,$92
	db $6C,$93,$6B,$94,$6A,$95,$69,$96,$69,$96,$68,$97,$67,$98,$67,$98
	db $66,$99,$66,$99,$65,$9A,$65,$9A,$64,$9B,$64,$9B,$63,$9C,$63,$9C
	db $63,$9C,$62,$9D,$62,$9D,$62,$9D,$62,$9D,$61,$9E,$61,$9E,$61,$9E
	db $61,$9E,$61,$9E,$61,$9E,$61,$9E,$61,$9E,$61,$9E,$61,$9E,$61,$9E
	db $61,$9E,$61,$9E,$61,$9E,$61,$9E,$62,$9D,$62,$9D,$62,$9D,$62,$9D
	db $63,$9C,$63,$9C,$63,$9C,$64,$9B,$64,$9B,$65,$9A,$65,$9A,$66,$99
	db $66,$99,$67,$98,$67,$98,$68,$97,$69,$96,$69,$96,$6A,$95,$6B,$94
	db $6C,$93,$6D,$92,$6F,$90,$70,$8F,$71,$8E,$73,$8C,$75,$8A,$78,$87
	db $80,$80

DATA_02E8DF:
	db $47 : dw DATA_02E5A1
	db $D1 : dw DATA_02E8E9
	db $48 : dw DATA_02E5A1
	db $00

DATA_02E8E9:
	db $80,$80,$78,$87,$75,$8A,$73,$8C,$71,$8E,$6F,$90,$6E,$91,$6C,$93
	db $6B,$94,$6A,$95,$69,$96,$68,$97,$67,$98,$66,$99,$66,$99,$65,$9A
	db $64,$9B,$64,$9B,$63,$9C,$63,$9C,$62,$9D,$62,$9D,$61,$9E,$61,$9E
	db $60,$9F,$60,$9F,$60,$9F,$5F,$A0,$5F,$A0,$5F,$A0,$5F,$A0,$5E,$A1
	db $5E,$A1,$5E,$A1,$5E,$A1,$5E,$A1,$5E,$A1,$5E,$A1,$5E,$A1,$5E,$A1
	db $5E,$A2,$5E,$A1,$5E,$A1,$5E,$A1,$5E,$A1,$5E,$A1,$5E,$A1,$5E,$A1
	db $5E,$A1,$5E,$A1,$5F,$A0,$5F,$A0,$5F,$A0,$5F,$A0,$60,$9F,$60,$9F
	db $60,$9F,$61,$9E,$61,$9E,$62,$9D,$62,$9D,$63,$9C,$63,$9C,$64,$9B
	db $64,$9B,$65,$9A,$66,$99,$66,$99,$67,$98,$68,$97,$69,$96,$6A,$95
	db $6B,$94,$6C,$93,$6E,$91,$6F,$90,$71,$8E,$73,$8C,$75,$8A,$78,$87
	db $80,$80

DATA_02E98B:
	db $43 : dw DATA_02E5A1
	db $D9 : dw DATA_02E995
	db $44 : dw DATA_02E5A1
	db $00

DATA_02E995:
	db $80,$80,$78,$87,$74,$8B,$72,$8D,$70,$8F,$6E,$91,$6D,$92,$6B,$94
	db $6A,$95,$69,$96,$68,$97,$67,$98,$66,$99,$65,$9A,$64,$9B,$63,$9C
	db $63,$9C,$62,$9D,$61,$9E,$61,$9E,$60,$9F,$60,$9F,$5F,$A0,$5F,$A0
	db $5E,$A1,$5E,$A1,$5D,$A2,$5D,$A2,$5D,$A2,$5C,$A3,$5C,$A3,$5C,$A3
	db $5C,$A3,$5B,$A4,$5B,$A4,$5B,$A4,$5B,$A4,$5B,$A4,$5A,$A5,$5A,$A5
	db $5A,$A5,$5A,$A5,$5A,$A5,$5A,$A5,$5A,$A5,$5A,$A5,$5A,$A5,$5A,$A5
	db $5A,$A5,$5A,$A5,$5A,$A5,$5B,$A4,$5B,$A4,$5B,$A4,$5B,$A4,$5B,$A4
	db $5C,$A3,$5C,$A3,$5C,$A3,$5C,$A3,$5D,$A2,$5D,$A2,$5D,$A2,$5E,$A1
	db $5E,$A1,$5F,$A0,$5F,$A0,$60,$9F,$60,$9F,$61,$9E,$61,$9E,$62,$9D
	db $63,$9C,$63,$9C,$64,$9B,$65,$9A,$66,$99,$67,$98,$68,$97,$69,$96
	db $6A,$95,$6B,$94,$6D,$92,$6E,$91,$70,$8F,$72,$8D,$74,$8B,$78,$87
	db $80,$80

DATA_02EA47:
	db $3F : dw DATA_02E5A1
	db $E1 : dw DATA_02EA51
	db $40 : dw DATA_02E5A1
	db $00

DATA_02EA51:
	db $80,$80,$77,$88,$74,$8B,$71,$8E,$6F,$90,$6D,$92,$6C,$93,$6A,$95
	db $69,$96,$68,$97,$67,$98,$66,$99,$65,$9A,$64,$9B,$63,$9C,$62,$9D
	db $61,$9E,$60,$9F,$60,$9F,$5F,$A0,$5E,$A1,$5E,$A1,$5D,$A2,$5D,$A2
	db $5C,$A3,$5C,$A3,$5B,$A4,$5B,$A4,$5A,$A5,$5A,$A5,$5A,$A5,$59,$A6
	db $59,$A6,$59,$A6,$58,$A7,$58,$A7,$58,$A7,$58,$A7,$58,$A7,$57,$A8
	db $57,$A8,$57,$A8,$57,$A8,$57,$A8,$57,$A8,$57,$A8,$57,$A8,$57,$A8
	db $57,$A8,$57,$A8,$57,$A8,$57,$A8,$57,$A8,$57,$A8,$57,$A8,$57,$A8
	db $57,$A8,$57,$A8,$58,$A7,$58,$A7,$58,$A7,$58,$A7,$58,$A7,$59,$A6
	db $59,$A6,$59,$A6,$5A,$A5,$5A,$A5,$5A,$A5,$5B,$A4,$5B,$A4,$5C,$A3
	db $5C,$A3,$5D,$A2,$5D,$A2,$5E,$A1,$5E,$A1,$5F,$A0,$60,$9F,$60,$9F
	db $61,$9E,$62,$9D,$63,$9C,$64,$9B,$65,$9A,$66,$99,$67,$98,$68,$97
	db $69,$96,$6A,$95,$6C,$93,$6D,$92,$6F,$90,$71,$8E,$74,$8B,$77,$88
	db $80,$80

DATA_02EB13:
	db $3B : dw DATA_02E5A1
	db $E9 : dw DATA_02EB1D
	db $3C : dw DATA_02E5A1
	db $00

DATA_02EB1D:
	db $80,$80,$77,$88,$73,$8C,$71,$8E,$6F,$91,$6D,$92,$6B,$94,$69,$96
	db $68,$97,$67,$98,$65,$9A,$64,$9B,$63,$9C,$62,$9D,$61,$9E,$60,$9F
	db $60,$9F,$5F,$A0,$5E,$A1,$5D,$A2,$5D,$A2,$5C,$A3,$5B,$A4,$5B,$A4
	db $5A,$A5,$5A,$A5,$59,$A6,$59,$A6,$58,$A7,$58,$A7,$57,$A8,$57,$A8
	db $57,$A8,$56,$A9,$56,$A9,$56,$A9,$55,$AA,$55,$AA,$55,$AA,$55,$AA
	db $54,$AB,$54,$AB,$54,$AB,$54,$AB,$54,$AB,$54,$AB,$54,$AB,$54,$AB
	db $53,$AC,$53,$AC,$53,$AC,$53,$AC,$53,$AC,$53,$AC,$53,$AC,$53,$AC
	db $53,$AC,$54,$AB,$54,$AB,$54,$AB,$54,$AB,$54,$AB,$54,$AB,$54,$AB
	db $54,$AB,$55,$AA,$55,$AA,$55,$AA,$55,$AA,$56,$A9,$56,$A9,$56,$A9
	db $57,$A8,$57,$A8,$57,$A8,$58,$A7,$58,$A7,$59,$A6,$59,$A6,$5A,$A5
	db $5A,$A5,$5B,$A4,$5B,$A4,$5C,$A3,$5D,$A2,$5D,$A2,$5E,$A1,$5F,$A0
	db $60,$9F,$60,$9F,$61,$9E,$62,$9D,$63,$9C,$64,$9B,$65,$9A,$67,$98
	db $68,$97,$69,$96,$6B,$94,$6D,$92,$6F,$91,$71,$8E,$73,$8C,$77,$88
	db $80,$80

DATA_02EBEF:
	db $37 : dw DATA_02E5A1
	db $F1 : dw DATA_02EBF9
	db $38 : dw DATA_02E5A1
	db $00

DATA_02EBF9:
	db $80,$80,$77,$88,$73,$8C,$70,$8F,$6E,$91,$6C,$93,$6A,$95,$68,$97
	db $67,$98,$66,$99,$64,$9B,$63,$9C,$62,$9D,$61,$9E,$60,$9F,$5F,$A0
	db $5E,$A1,$5D,$A2,$5D,$A2,$5C,$A3,$5B,$A4,$5A,$A5,$5A,$A5,$59,$A6
	db $58,$A7,$58,$A7,$57,$A8,$57,$A8,$56,$A9,$56,$A9,$55,$AA,$55,$AA
	db $54,$AB,$54,$AB,$54,$AB,$53,$AC,$53,$AC,$53,$AC,$52,$AD,$52,$AD
	db $52,$AD,$52,$AD,$51,$AE,$51,$AE,$51,$AE,$51,$AE,$51,$AE,$51,$AE
	db $50,$AF,$50,$AF,$50,$AF,$50,$AF,$50,$AF,$50,$AF,$50,$AF,$50,$AF
	db $50,$AF,$50,$AF,$50,$AF,$50,$AF,$50,$AF,$50,$AF,$50,$AF,$50,$AF
	db $50,$AF,$51,$AE,$51,$AE,$51,$AE,$51,$AE,$51,$AE,$51,$AE,$52,$AD
	db $52,$AD,$52,$AD,$52,$AD,$53,$AC,$53,$AC,$53,$AC,$54,$AB,$54,$AB
	db $54,$AB,$55,$AA,$55,$AA,$56,$A9,$56,$A9,$57,$A8,$57,$A8,$58,$A7
	db $58,$A7,$59,$A6,$5A,$A5,$5A,$A5,$5B,$A4,$5C,$A3,$5D,$A2,$5D,$A2
	db $5E,$A1,$5F,$A0,$60,$9F,$61,$9E,$62,$9D,$63,$9C,$64,$9B,$66,$99
	db $67,$98,$68,$97,$6A,$95,$6C,$93,$6E,$91,$70,$8F,$73,$8C,$77,$88
	db $80,$80

DATA_02ECDB:
	db $33 : dw DATA_02E5A1
	db $F9 : dw DATA_02ECE5
	db $34 : dw DATA_02E5A1
	db $00

DATA_02ECE5:
	db $80,$80,$76,$89,$72,$8D,$70,$8F,$6D,$92,$6B,$94,$69,$96,$68,$97
	db $66,$99,$65,$9A,$63,$9C,$62,$9D,$61,$9E,$60,$9F,$5F,$A0,$5E,$A1
	db $5D,$A2,$5C,$A3,$5B,$A4,$5A,$A5,$59,$A6,$59,$A6,$58,$A7,$57,$A8
	db $57,$A8,$56,$A9,$55,$AA,$55,$AA,$54,$AB,$54,$AB,$53,$AC,$53,$AC
	db $52,$AD,$52,$AD,$52,$AD,$51,$AE,$51,$AE,$50,$AF,$50,$AF,$50,$AF
	db $4F,$B0,$4F,$B0,$4F,$B0,$4F,$B0,$4E,$B1,$4E,$B1,$4E,$B1,$4E,$B1
	db $4E,$B1,$4D,$B2,$4D,$B2,$4D,$B2,$4D,$B2,$4D,$B2,$4D,$B2,$4D,$B2
	db $4D,$B2,$4D,$B2,$4D,$B2,$4D,$B2,$4D,$B3,$4D,$B2,$4D,$B2,$4D,$B2
	db $4D,$B2,$4D,$B2,$4D,$B2,$4D,$B2,$4D,$B2,$4D,$B2,$4D,$B2,$4D,$B2
	db $4E,$B1,$4E,$B1,$4E,$B1,$4E,$B1,$4E,$B1,$4F,$B0,$4F,$B0,$4F,$B0
	db $4F,$B0,$50,$AF,$50,$AF,$50,$AF,$51,$AE,$51,$AE,$52,$AD,$52,$AD
	db $52,$AD,$53,$AC,$53,$AC,$54,$AB,$54,$AB,$55,$AA,$55,$AA,$56,$A9
	db $57,$A8,$57,$A8,$58,$A7,$59,$A6,$59,$A6,$5A,$A5,$5B,$A4,$5C,$A3
	db $5D,$A2,$5E,$A1,$5F,$A0,$60,$9F,$61,$9E,$62,$9D,$63,$9C,$65,$9A
	db $66,$99,$68,$97,$69,$96,$6B,$94,$6D,$92,$70,$8F,$72,$8D,$76,$89
	db $80,$80

DATA_02EDD7:
	db $2F : dw DATA_02E5A1
	db $8A : dw DATA_02EDE4
	db $F7 : dw DATA_02EDF8
	db $30 : dw DATA_02E5A1
	db $00

DATA_02EDE4:
	db $80,$80,$76,$89,$72,$8D,$6F,$90,$6D,$92,$6A,$95,$69,$96,$67,$98
	db $65,$9A,$64,$9B

DATA_02EDF8:
	db $62,$9D,$61,$9E,$60,$9F,$5F,$A0,$5E,$A1,$5D,$A2,$5C,$A3,$5B,$A4
	db $5A,$A5,$59,$A6,$58,$A7,$57,$A8,$56,$A9,$56,$A9,$55,$AA,$54,$AB
	db $54,$AB,$53,$AC,$53,$AC,$52,$AD,$51,$AE,$51,$AE,$50,$AF,$50,$AF
	db $4F,$B0,$4F,$B0,$4F,$B0,$4E,$B1,$4E,$B1,$4D,$B2,$4D,$B2,$4D,$B2
	db $4C,$B3,$4C,$B3,$4C,$B3,$4C,$B3,$4B,$B4,$4B,$B4,$4B,$B4,$4B,$B4
	db $4A,$B5,$4A,$B5,$4A,$B5,$4A,$B5,$4A,$B5,$4A,$B5,$4A,$B5,$49,$B6
	db $49,$B6,$49,$B6,$49,$B6,$49,$B6,$49,$B6,$49,$B6,$49,$B6,$49,$B6
	db $49,$B6,$49,$B6,$49,$B6,$49,$B6,$49,$B6,$49,$B6,$4A,$B5,$4A,$B5
	db $4A,$B5,$4A,$B5,$4A,$B5,$4A,$B5,$4A,$B5,$4B,$B4,$4B,$B4,$4B,$B4
	db $4B,$B4,$4C,$B3,$4C,$B3,$4C,$B3,$4C,$B3,$4D,$B2,$4D,$B2,$4D,$B2
	db $4E,$B1,$4E,$B1,$4F,$B0,$4F,$B0,$4F,$B0,$50,$AF,$50,$AF,$51,$AE
	db $51,$AE,$52,$AD,$53,$AC,$53,$AC,$54,$AB,$54,$AB,$55,$AA,$56,$A9
	db $56,$A9,$57,$A8,$58,$A7,$59,$A6,$5A,$A5,$5B,$A4,$5C,$A3,$5D,$A2
	db $5E,$A1,$5F,$A0,$60,$9F,$61,$9E,$62,$9D,$64,$9B,$65,$9A,$67,$98
	db $69,$96,$6A,$95,$6D,$92,$6F,$90,$72,$8D,$76,$89,$80,$80

DATA_02EEE6:
	db $2B : dw DATA_02E5A1
	db $8A : dw DATA_02EEF3
	db $FF : dw DATA_02EF07
	db $2C : dw DATA_02E5A1
	db $00

DATA_02EEF3:
	db $80,$80,$76,$89,$72,$8D,$6F,$90,$6C,$93,$6A,$95,$68,$97,$66,$99
	db $64,$9B,$63,$9C

DATA_02EF07:
	db $61,$9E,$60,$9F,$5F,$A0,$5E,$A1,$5C,$A3,$5B,$A4,$5A,$A5,$59,$A6
	db $58,$A7,$57,$A8,$57,$A8,$56,$A9,$55,$AA,$54,$AB,$53,$AC,$53,$AC
	db $52,$AD,$51,$AE,$51,$AE,$50,$AF,$50,$AF,$4F,$B0,$4E,$B1,$4E,$B1
	db $4D,$B2,$4D,$B2,$4D,$B3,$4C,$B3,$4C,$B3,$4B,$B4,$4B,$B4,$4A,$B5
	db $4A,$B5,$4A,$B5,$49,$B6,$49,$B6,$49,$B6,$49,$B6,$48,$B7,$48,$B7
	db $48,$B7,$48,$B7,$47,$B8,$47,$B8,$47,$B8,$47,$B8,$47,$B8,$46,$B9
	db $46,$B9,$46,$B9,$46,$B9,$46,$B9,$46,$B9,$46,$B9,$46,$B9,$46,$B9
	db $46,$B9,$46,$B9,$46,$B9,$46,$B9,$46,$B9,$46,$B9,$46,$B9,$46,$B9
	db $46,$B9,$46,$B9,$46,$B9,$46,$B9,$46,$B9,$46,$B9,$47,$B8,$47,$B8
	db $47,$B8,$47,$B8,$47,$B8,$48,$B7,$48,$B7,$48,$B7,$48,$B7,$49,$B6
	db $49,$B6,$49,$B6,$49,$B6,$4A,$B5,$4A,$B5,$4A,$B5,$4B,$B4,$4B,$B4
	db $4C,$B3,$4C,$B3,$4D,$B3,$4D,$B2,$4D,$B2,$4E,$B1,$4E,$B1,$4F,$B0
	db $50,$AF,$50,$AF,$51,$AE,$51,$AE,$52,$AD,$53,$AC,$53,$AC,$54,$AB
	db $55,$AA,$56,$A9,$57,$A8,$57,$A8,$58,$A7,$59,$A6,$5A,$A5,$5B,$A4
	db $5C,$A3,$5E,$A1,$5F,$A0,$60,$9F,$61,$9E,$63,$9C,$64,$9B,$66,$99
	db $68,$97,$6A,$95,$6C,$93,$6F,$90,$72,$8D,$76,$89,$80,$80

DATA_02F005:
	db $27 : dw DATA_02E5A1
	db $94 : dw DATA_02F012
	db $FD : dw DATA_02F03A
	db $28 : dw DATA_02E5A1
	db $00

DATA_02F012:
	db $80,$80,$75,$8A,$71,$8E,$6E,$91,$6B,$94,$69,$96,$67,$98,$65,$9A
	db $63,$9C,$62,$9D,$60,$9F,$5F,$A0,$5E,$A1,$5C,$A3,$5B,$A4,$5A,$A5
	db $59,$A6,$58,$A7,$57,$A8,$56,$A9

DATA_02F03A:
	db $55,$AA,$54,$AB,$53,$AC,$53,$AC,$52,$AD,$51,$AE,$50,$AF,$50,$AF
	db $4F,$B0,$4E,$B1,$4E,$B1,$4D,$B2,$4D,$B2,$4C,$B3,$4C,$B3,$4B,$B4
	db $4A,$B5,$4A,$B5,$4A,$B5,$49,$B6,$49,$B6,$48,$B7,$48,$B7,$47,$B8
	db $47,$B8,$47,$B8,$46,$B9,$46,$B9,$46,$B9,$46,$B9,$45,$BA,$45,$BA
	db $45,$BA,$44,$BB,$44,$BB,$44,$BB,$44,$BB,$44,$BB,$43,$BC,$43,$BC
	db $43,$BC,$43,$BC,$43,$BC,$43,$BC,$43,$BC,$43,$BC,$43,$BC,$42,$BD
	db $42,$BD,$42,$BD,$42,$BD,$42,$BD,$42,$BD,$42,$BD,$42,$BD,$42,$BD
	db $42,$BD,$42,$BD,$43,$BC,$43,$BC,$43,$BC,$43,$BC,$43,$BC,$43,$BC
	db $43,$BC,$43,$BC,$43,$BC,$44,$BB,$44,$BB,$44,$BB,$44,$BB,$44,$BB
	db $45,$BA,$45,$BA,$45,$BA,$46,$B9,$46,$B9,$46,$B9,$46,$B9,$47,$B8
	db $47,$B8,$47,$B8,$48,$B7,$48,$B7,$49,$B6,$49,$B6,$4A,$B5,$4A,$B5
	db $4A,$B5,$4B,$B4,$4C,$B3,$4C,$B3,$4D,$B2,$4D,$B2,$4E,$B1,$4E,$B1
	db $4F,$B0,$50,$AF,$50,$AF,$51,$AE,$52,$AD,$53,$AC,$53,$AC,$54,$AB
	db $55,$AA,$56,$A9,$57,$A8,$58,$A7,$59,$A6,$5A,$A5,$5B,$A4,$5C,$A3
	db $5E,$A1,$5F,$A0,$60,$9F,$62,$9D,$63,$9C,$65,$9A,$67,$98,$69,$96
	db $6B,$94,$6E,$91,$71,$8E,$75,$8A,$80,$80

DATA_02F134:
	db $23 : dw DATA_02E5A1
	db $9E : dw DATA_02F141
	db $FB : dw DATA_02F17D
	db $24 : dw DATA_02E5A1
	db $00

DATA_02F141:
	db $80,$80,$75,$8A,$71,$8E,$6E,$91,$6B,$94,$68,$97,$66,$99,$64,$9B
	db $63,$9C,$61,$9E,$5F,$A0,$5E,$A1,$5D,$A2,$5B,$A4,$5A,$A5,$59,$A6
	db $58,$A7,$57,$A8,$56,$A9,$55,$AA,$54,$AB,$53,$AC,$52,$AD,$51,$AE
	db $50,$AF,$50,$AF,$4F,$B0,$4E,$B1,$4D,$B2,$4D,$B2

DATA_02F17D:
	db $4C,$B3,$4B,$B4,$4B,$B4,$4A,$B5,$4A,$B5,$49,$B6,$49,$B6,$48,$B7
	db $48,$B7,$47,$B8,$47,$B8,$46,$B9,$46,$B9,$45,$BA,$45,$BA,$45,$BA
	db $44,$BB,$44,$BB,$43,$BC,$43,$BC,$43,$BC,$42,$BD,$42,$BD,$42,$BD
	db $42,$BD,$41,$BE,$41,$BE,$41,$BE,$41,$BE,$41,$BE,$40,$BF,$40,$BF
	db $40,$BF,$40,$BF,$40,$BF,$40,$BF,$3F,$C0,$3F,$C0,$3F,$C0,$3F,$C0
	db $3F,$C0,$3F,$C0,$3F,$C0,$3F,$C0,$3F,$C0,$3F,$C0,$3F,$C0,$3F,$C0
	db $3F,$C0,$3F,$C0,$3F,$C0,$3F,$C0,$3F,$C0,$3F,$C0,$3F,$C0,$3F,$C0
	db $3F,$C0,$40,$BF,$40,$BF,$40,$BF,$40,$BF,$40,$BF,$40,$BF,$41,$BE
	db $41,$BE,$41,$BE,$41,$BE,$41,$BE,$42,$BD,$42,$BD,$42,$BD,$42,$BD
	db $43,$BC,$43,$BC,$43,$BC,$44,$BB,$44,$BB,$45,$BA,$45,$BA,$45,$BA
	db $46,$B9,$46,$B9,$47,$B8,$47,$B8,$48,$B7,$48,$B7,$49,$B6,$49,$B6
	db $4A,$B5,$4A,$B5,$4B,$B4,$4B,$B4,$4C,$B3,$4D,$B2,$4D,$B2,$4E,$B1
	db $4F,$B0,$50,$AF,$50,$AF,$51,$AE,$52,$AD,$53,$AC,$54,$AB,$55,$AA
	db $56,$A9,$57,$A8,$58,$A7,$59,$A6,$5A,$A5,$5B,$A4,$5D,$A2,$5E,$A1
	db $5F,$A0,$61,$9E,$63,$9C,$64,$9B,$66,$99,$68,$97,$6B,$94,$6E,$91
	db $71,$8E,$75,$8A,$80,$80

DATA_02F273:
	db $1F : dw DATA_02E5A1
	db $A8 : dw DATA_02F280
	db $F9 : dw DATA_02F2D0
	db $20 : dw DATA_02E5A1
	db $00

DATA_02F280:
	db $80,$80,$75,$8A,$70,$8F,$6D,$92,$6A,$95,$68,$97,$66,$99,$64,$9B
	db $62,$9D,$60,$9F,$5F,$A0,$5D,$A2,$5C,$A3,$5A,$A5,$59,$A6,$58,$A7
	db $57,$A8,$56,$A9,$55,$AA,$54,$AB,$53,$AC,$52,$AD,$51,$AE,$50,$AF
	db $4F,$B0,$4E,$B1,$4D,$B2,$4D,$B2,$4C,$B3,$4B,$B4,$4A,$B5,$4A,$B5
	db $49,$B6,$48,$B7,$48,$B7,$47,$B8,$47,$B8,$46,$B9,$46,$B9,$45,$BA

DATA_02F2D0:
	db $45,$BA,$44,$BB,$44,$BB,$43,$BC,$43,$BC,$42,$BD,$42,$BD,$42,$BD
	db $41,$BE,$41,$BE,$40,$BF,$40,$BF,$40,$BF,$3F,$C0,$3F,$C0,$3F,$C0
	db $3F,$C0,$3E,$C1,$3E,$C1,$3E,$C1,$3E,$C1,$3D,$C2,$3D,$C2,$3D,$C2
	db $3D,$C2,$3D,$C2,$3D,$C2,$3C,$C3,$3C,$C3,$3C,$C3,$3C,$C3,$3C,$C3
	db $3C,$C3,$3C,$C3,$3C,$C3,$3C,$C3,$3C,$C3,$3C,$C3,$3C,$C3,$3C,$C3
	db $3C,$C4,$3C,$C3,$3C,$C3,$3C,$C3,$3C,$C3,$3C,$C3,$3C,$C3,$3C,$C3
	db $3C,$C3,$3C,$C3,$3C,$C3,$3C,$C3,$3C,$C3,$3C,$C3,$3D,$C2,$3D,$C2
	db $3D,$C2,$3D,$C2,$3D,$C2,$3D,$C2,$3E,$C1,$3E,$C1,$3E,$C1,$3E,$C1
	db $3F,$C0,$3F,$C0,$3F,$C0,$3F,$C0,$40,$BF,$40,$BF,$40,$BF,$41,$BE
	db $41,$BE,$42,$BD,$42,$BD,$42,$BD,$43,$BC,$43,$BC,$44,$BB,$44,$BB
	db $45,$BA,$45,$BA,$46,$B9,$46,$B9,$47,$B8,$47,$B8,$48,$B7,$48,$B7
	db $49,$B6,$4A,$B5,$4A,$B5,$4B,$B4,$4C,$B3,$4D,$B2,$4D,$B2,$4E,$B1
	db $4F,$B0,$50,$AF,$51,$AE,$52,$AD,$53,$AC,$54,$AB,$55,$AA,$56,$A9
	db $57,$A8,$58,$A7,$59,$A6,$5A,$A5,$5C,$A3,$5D,$A2,$5F,$A0,$60,$9F
	db $62,$9D,$64,$9B,$66,$99,$68,$97,$6A,$95,$6D,$92,$70,$8F,$75,$8A
	db $80,$80

DATA_02F3C2:
	db $1B : dw DATA_02E5A1
	db $B2 : dw DATA_02F3CF
	db $F7 : dw DATA_02F433
	db $1C : dw DATA_02E5A1
	db $00

DATA_02F3CF:
	db $80,$80,$75,$8A,$70,$8F,$6D,$92,$6A,$95,$67,$98,$65,$9A,$63,$9C
	db $61,$9E,$5F,$A0,$5E,$A1,$5C,$A3,$5B,$A4,$59,$A6,$58,$A7,$57,$A8
	db $56,$A9,$54,$AB,$53,$AC,$52,$AD,$51,$AE,$50,$AF,$4F,$B0,$4E,$B1
	db $4E,$B1,$4D,$B2,$4C,$B3,$4B,$B4,$4A,$B5,$4A,$B5,$49,$B6,$48,$B7
	db $47,$B8,$47,$B8,$46,$B9,$46,$B9,$45,$BA,$44,$BB,$44,$BB,$43,$BC
	db $43,$BC,$42,$BD,$42,$BD,$41,$BE,$41,$BE,$40,$BF,$40,$BF,$3F,$C0
	db $3F,$C0,$3F,$C0

DATA_02F433:
	db $3E,$C1,$3E,$C1,$3D,$C2,$3D,$C2,$3D,$C2,$3C,$C3,$3C,$C3,$3C,$C3
	db $3C,$C3,$3B,$C4,$3B,$C4,$3B,$C4,$3B,$C4,$3A,$C5,$3A,$C5,$3A,$C5
	db $3A,$C5,$3A,$C5,$39,$C6,$39,$C6,$39,$C6,$39,$C6,$39,$C6,$39,$C6
	db $39,$C6,$39,$C6,$38,$C7,$38,$C7,$38,$C7,$38,$C7,$38,$C7,$38,$C7
	db $38,$C7,$38,$C7,$38,$C7,$38,$C7,$38,$C7,$38,$C7,$38,$C7,$38,$C7
	db $38,$C7,$38,$C7,$38,$C7,$39,$C6,$39,$C6,$39,$C6,$39,$C6,$39,$C6
	db $39,$C6,$39,$C6,$39,$C6,$3A,$C5,$3A,$C5,$3A,$C5,$3A,$C5,$3A,$C5
	db $3B,$C4,$3B,$C4,$3B,$C4,$3B,$C4,$3C,$C3,$3C,$C3,$3C,$C3,$3C,$C3
	db $3D,$C2,$3D,$C2,$3D,$C2,$3E,$C1,$3E,$C1,$3F,$C0,$3F,$C0,$3F,$C0
	db $40,$BF,$40,$BF,$41,$BE,$41,$BE,$42,$BD,$42,$BD,$43,$BC,$43,$BC
	db $44,$BB,$44,$BB,$45,$BA,$46,$B9,$46,$B9,$47,$B8,$47,$B8,$48,$B7
	db $49,$B6,$4A,$B5,$4A,$B5,$4B,$B4,$4C,$B3,$4D,$B2,$4E,$B1,$4E,$B1
	db $4F,$B0,$50,$AF,$51,$AE,$52,$AD,$53,$AC,$54,$AB,$56,$A9,$57,$A8
	db $58,$A7,$59,$A6,$5B,$A4,$5C,$A3,$5E,$A1,$5F,$A0,$61,$9E,$63,$9C
	db $65,$9A,$67,$98,$6A,$95,$6D,$92,$70,$8F,$75,$8A,$80,$80

DATA_02F521:
	db $17 : dw DATA_02E5A1
	db $B2 : dw DATA_02F52E
	db $FF : dw DATA_02F592
	db $18 : dw DATA_02E5A1
	db $00

DATA_02F52E:
	db $80,$80,$74,$8B,$70,$8F,$6C,$93,$69,$96,$67,$98,$64,$9B,$62,$9D
	db $60,$9F,$5F,$A0,$5D,$A2,$5B,$A4,$5A,$A5,$58,$A7,$57,$A8,$56,$A9
	db $54,$AB,$53,$AC,$52,$AD,$51,$AE,$50,$AF,$4F,$B0,$4E,$B1,$4D,$B2
	db $4C,$B3,$4B,$B4,$4A,$B5,$4A,$B5,$49,$B6,$48,$B7,$47,$B8,$47,$B8
	db $46,$B9,$45,$BA,$44,$BB,$44,$BB,$43,$BC,$43,$BC,$42,$BD,$41,$BE
	db $41,$BE,$40,$BF,$40,$BF,$3F,$C0,$3F,$C0,$3E,$C1,$3E,$C1,$3D,$C2
	db $3D,$C2,$3C,$C3

DATA_02F592:
	db $3C,$C3,$3C,$C3,$3B,$C4,$3B,$C4,$3B,$C4,$3A,$C5,$3A,$C5,$39,$C6
	db $39,$C6,$39,$C6,$39,$C6,$38,$C7,$38,$C7,$38,$C7,$38,$C7,$37,$C8
	db $37,$C8,$37,$C8,$37,$C8,$36,$C9,$36,$C9,$36,$C9,$36,$C9,$36,$C9
	db $36,$C9,$36,$C9,$35,$CA,$35,$CA,$35,$CA,$35,$CA,$35,$CA,$35,$CA
	db $35,$CA,$35,$CA,$35,$CA,$35,$CA,$35,$CA,$35,$CA,$35,$CA,$35,$CA
	db $35,$CA,$35,$CA,$35,$CA,$35,$CA,$35,$CA,$35,$CA,$35,$CA,$35,$CA
	db $35,$CA,$35,$CA,$35,$CA,$36,$C9,$36,$C9,$36,$C9,$36,$C9,$36,$C9
	db $36,$C9,$36,$C9,$37,$C8,$37,$C8,$37,$C8,$37,$C8,$38,$C7,$38,$C7
	db $38,$C7,$38,$C7,$39,$C6,$39,$C6,$39,$C6,$39,$C6,$3A,$C5,$3A,$C5
	db $3B,$C4,$3B,$C4,$3B,$C4,$3C,$C3,$3C,$C3,$3C,$C3,$3D,$C2,$3D,$C2
	db $3E,$C1,$3E,$C1,$3F,$C0,$3F,$C0,$40,$BF,$40,$BF,$41,$BE,$41,$BE
	db $42,$BD,$43,$BC,$43,$BC,$44,$BB,$44,$BB,$45,$BA,$46,$B9,$47,$B8
	db $47,$B8,$48,$B7,$49,$B6,$4A,$B5,$4A,$B5,$4B,$B4,$4C,$B3,$4D,$B2
	db $4E,$B1,$4F,$B0,$50,$AF,$51,$AE,$52,$AD,$53,$AC,$54,$AB,$56,$A9
	db $57,$A8,$58,$A7,$5A,$A5,$5B,$A4,$5D,$A2,$5F,$A0,$60,$9F,$62,$9D
	db $64,$9B,$67,$98,$69,$96,$6C,$93,$70,$8F,$74,$8B,$80,$80

DATA_02F690:
	db $13 : dw DATA_02E5A1
	db $BC : dw DATA_02F69D
	db $FD : dw DATA_02F715
	db $14 : dw DATA_02E5A1
	db $00

DATA_02F69D:
	db $80,$80,$74,$8B,$6F,$90,$6C,$93,$69,$96,$66,$99,$64,$9B,$62,$9D
	db $60,$9F,$5E,$A1,$5C,$A3,$5A,$A5,$59,$A6,$57,$A8,$56,$A9,$55,$AA
	db $53,$AC,$52,$AD,$51,$AE,$50,$AF,$4F,$B0,$4E,$B1,$4D,$B2,$4C,$B3
	db $4B,$B4,$4A,$B5,$49,$B6,$48,$B7,$47,$B8,$47,$B8,$46,$B9,$45,$BA
	db $44,$BB,$43,$BC,$43,$BC,$42,$BD,$41,$BE,$41,$BE,$40,$BF,$40,$BF
	db $3F,$C0,$3E,$C1,$3E,$C1,$3D,$C2,$3D,$C2,$3C,$C3,$3C,$C3,$3B,$C4
	db $3B,$C4,$3A,$C5,$3A,$C5,$39,$C6,$39,$C6,$39,$C6,$38,$C7,$38,$C7
	db $38,$C7,$37,$C8,$37,$C8,$37,$C8

DATA_02F715:
	db $36,$C9,$36,$C9,$36,$C9,$35,$CA,$35,$CA,$35,$CA,$34,$CB,$34,$CB
	db $34,$CB,$34,$CB,$34,$CB,$33,$CC,$33,$CC,$33,$CC,$33,$CC,$33,$CC
	db $32,$CD,$32,$CD,$32,$CD,$32,$CD,$32,$CD,$32,$CD,$32,$CD,$32,$CD
	db $32,$CD,$32,$CD,$31,$CE,$31,$CE,$31,$CE,$31,$CE,$31,$CE,$31,$CE
	db $31,$CE,$31,$CE,$31,$CE,$31,$CE,$31,$CE,$31,$CE,$31,$CE,$32,$CD
	db $32,$CD,$32,$CD,$32,$CD,$32,$CD,$32,$CD,$32,$CD,$32,$CD,$32,$CD
	db $32,$CD,$33,$CC,$33,$CC,$33,$CC,$33,$CC,$33,$CC,$34,$CB,$34,$CB
	db $34,$CB,$34,$CB,$34,$CB,$35,$CA,$35,$CA,$35,$CA,$36,$C9,$36,$C9
	db $36,$C9,$37,$C8,$37,$C8,$37,$C8,$38,$C7,$38,$C7,$38,$C7,$39,$C6
	db $39,$C6,$39,$C6,$3A,$C5,$3A,$C5,$3B,$C4,$3B,$C4,$3C,$C3,$3C,$C3
	db $3D,$C2,$3D,$C2,$3E,$C1,$3E,$C1,$3F,$C0,$40,$BF,$40,$BF,$41,$BE
	db $41,$BE,$42,$BD,$43,$BC,$43,$BC,$44,$BB,$45,$BA,$46,$B9,$47,$B8
	db $47,$B8,$48,$B7,$49,$B6,$4A,$B5,$4B,$B4,$4C,$B3,$4D,$B2,$4E,$B1
	db $4F,$B0,$50,$AF,$51,$AE,$52,$AD,$53,$AC,$55,$AA,$56,$A9,$57,$A8
	db $59,$A6,$5A,$A5,$5C,$A3,$5E,$A1,$60,$9F,$62,$9D,$64,$9B,$66,$99
	db $69,$96,$6C,$93,$6F,$90,$74,$8B,$80,$80

DATA_02F80F:
	db $0F : dw DATA_02E5A1
	db $C6 : dw DATA_02F81C
	db $FB : dw DATA_02F8A8
	db $10 : dw DATA_02E5A1
	db $00

DATA_02F81C:
	db $80,$80,$74,$8B,$6F,$90,$6B,$94,$68,$97,$66,$99,$63,$9C,$61,$9E
	db $5F,$A0,$5D,$A2,$5B,$A4,$5A,$A5,$58,$A7,$56,$A9,$55,$AA,$54,$AB
	db $52,$AD,$51,$AE,$50,$AF,$4F,$B0,$4E,$B1,$4D,$B2,$4C,$B3,$4B,$B4
	db $4A,$B5,$49,$B6,$48,$B7,$47,$B8,$46,$B9,$45,$BA,$44,$BB,$43,$BC
	db $43,$BC,$42,$BD,$41,$BE,$40,$BF,$40,$BF,$3F,$C0,$3E,$C1,$3E,$C1
	db $3D,$C2,$3D,$C2,$3C,$C3,$3B,$C4,$3B,$C4,$3A,$C5,$3A,$C5,$39,$C6
	db $39,$C6,$38,$C7,$38,$C7,$37,$C8,$37,$C8,$37,$C8,$36,$C9,$36,$C9
	db $35,$CA,$35,$CA,$35,$CA,$34,$CB,$34,$CB,$34,$CB,$33,$CC,$33,$CC
	db $33,$CC,$32,$CD,$32,$CD,$32,$CD,$31,$CE,$31,$CE

DATA_02F8A8:
	db $31,$CE,$31,$CE,$30,$CF,$30,$CF,$30,$CF,$30,$CF,$30,$CF,$30,$CF
	db $2F,$D0,$2F,$D0,$2F,$D0,$2F,$D0,$2F,$D0,$2F,$D0,$2F,$D0,$2E,$D1
	db $2E,$D1,$2E,$D1,$2E,$D1,$2E,$D1,$2E,$D1,$2E,$D1,$2E,$D1,$2E,$D1
	db $2E,$D1,$2E,$D1,$2E,$D1,$2E,$D1,$2E,$D1,$2E,$D1,$2E,$D1,$2E,$D1
	db $2E,$D1,$2E,$D1,$2E,$D1,$2E,$D1,$2E,$D1,$2E,$D1,$2F,$D0,$2F,$D0
	db $2F,$D0,$2F,$D0,$2F,$D0,$2F,$D0,$2F,$D0,$30,$CF,$30,$CF,$30,$CF
	db $30,$CF,$30,$CF,$30,$CF,$31,$CE,$31,$CE,$31,$CE,$31,$CE,$32,$CD
	db $32,$CD,$32,$CD,$33,$CC,$33,$CC,$33,$CC,$34,$CB,$34,$CB,$34,$CB
	db $35,$CA,$35,$CA,$35,$CA,$36,$C9,$36,$C9,$37,$C8,$37,$C8,$37,$C8
	db $38,$C7,$38,$C7,$39,$C6,$39,$C6,$3A,$C5,$3A,$C5,$3B,$C4,$3B,$C4
	db $3C,$C3,$3D,$C2,$3D,$C2,$3E,$C1,$3E,$C1,$3F,$C0,$40,$BF,$40,$BF
	db $41,$BE,$42,$BD,$43,$BC,$43,$BC,$44,$BB,$45,$BA,$46,$B9,$47,$B8
	db $48,$B7,$49,$B6,$4A,$B5,$4B,$B4,$4C,$B3,$4D,$B2,$4E,$B1,$4F,$B0
	db $50,$AF,$51,$AE,$52,$AD,$54,$AB,$55,$AA,$56,$A9,$58,$A7,$5A,$A5
	db $5B,$A4,$5D,$A2,$5F,$A0,$61,$9E,$63,$9C,$66,$99,$68,$97,$6B,$94
	db $6F,$90,$74,$8B,$80,$80

DATA_02F99E:
	db $0B : dw DATA_02E5A1
	db $D0 : dw DATA_02F9AB
	db $F9 : dw DATA_02FA4B
	db $0C : dw DATA_02E5A1
	db $00

DATA_02F9AB:
	db $80,$80,$74,$8B,$6F,$90,$6B,$94,$68,$97,$65,$9A,$63,$9C,$60,$9F
	db $5E,$A1,$5C,$A3,$5A,$A5,$59,$A6,$57,$A8,$56,$A9,$54,$AB,$53,$AC
	db $51,$AE,$50,$AF,$4F,$B0,$4E,$B1,$4D,$B3,$4B,$B4,$4A,$B5,$49,$B6
	db $48,$B7,$47,$B8,$46,$B9,$45,$BA,$45,$BA,$44,$BB,$43,$BC,$42,$BD
	db $41,$BE,$40,$BF,$40,$BF,$3F,$C0,$3E,$C1,$3D,$C2,$3D,$C2,$3C,$C3
	db $3C,$C4,$3B,$C4,$3A,$C5,$3A,$C5,$39,$C6,$39,$C6,$38,$C7,$37,$C8
	db $37,$C8,$36,$C9,$36,$C9,$35,$CA,$35,$CA,$34,$CB,$34,$CB,$34,$CB
	db $33,$CC,$33,$CC,$32,$CD,$32,$CD,$32,$CD,$31,$CE,$31,$CE,$31,$CE
	db $30,$CF,$30,$CF,$30,$CF,$2F,$D0,$2F,$D0,$2F,$D0,$2E,$D1,$2E,$D1
	db $2E,$D1,$2E,$D1,$2D,$D2,$2D,$D2,$2D,$D2,$2D,$D2,$2D,$D2,$2C,$D3

DATA_02FA4B:
	db $2C,$D3,$2C,$D3,$2C,$D3,$2C,$D3,$2C,$D3,$2B,$D4,$2B,$D4,$2B,$D4
	db $2B,$D4,$2B,$D4,$2B,$D4,$2B,$D4,$2B,$D4,$2B,$D4,$2B,$D4,$2B,$D4
	db $2B,$D4,$2B,$D4,$2B,$D4,$2B,$D4,$2B,$D5,$2B,$D4,$2B,$D4,$2B,$D4
	db $2B,$D4,$2B,$D4,$2B,$D4,$2B,$D4,$2B,$D4,$2B,$D4,$2B,$D4,$2B,$D4
	db $2B,$D4,$2B,$D4,$2B,$D4,$2B,$D4,$2C,$D3,$2C,$D3,$2C,$D3,$2C,$D3
	db $2C,$D3,$2C,$D3,$2D,$D2,$2D,$D2,$2D,$D2,$2D,$D2,$2D,$D2,$2E,$D1
	db $2E,$D1,$2E,$D1,$2E,$D1,$2F,$D0,$2F,$D0,$2F,$D0,$30,$CF,$30,$CF
	db $30,$CF,$31,$CE,$31,$CE,$31,$CE,$32,$CD,$32,$CD,$32,$CD,$33,$CC
	db $33,$CC,$34,$CB,$34,$CB,$34,$CB,$35,$CA,$35,$CA,$36,$C9,$36,$C9
	db $37,$C8,$37,$C8,$38,$C7,$39,$C6,$39,$C6,$3A,$C5,$3A,$C5,$3B,$C4
	db $3C,$C4,$3C,$C3,$3D,$C2,$3D,$C2,$3E,$C1,$3F,$C0,$40,$BF,$40,$BF
	db $41,$BE,$42,$BD,$43,$BC,$44,$BB,$45,$BA,$45,$BA,$46,$B9,$47,$B8
	db $48,$B7,$49,$B6,$4A,$B5,$4B,$B4,$4D,$B3,$4E,$B1,$4F,$B0,$50,$AF
	db $51,$AE,$53,$AC,$54,$AB,$56,$A9,$57,$A8,$59,$A6,$5A,$A5,$5C,$A3
	db $5E,$A1,$60,$9F,$63,$9C,$65,$9A,$68,$97,$6B,$94,$6F,$90,$74,$8B
	db $80,$80

DATA_02FB3D:
	db $07 : dw DATA_02E5A1
	db $DA : dw DATA_02FB4A
	db $F7 : dw DATA_02FBFE
	db $08 : dw DATA_02E5A1
	db $00

DATA_02FB4A:
	db $80,$80,$73,$8C,$6E,$91,$6A,$95,$67,$98,$64,$9B,$62,$9D,$60,$9F
	db $5E,$A2,$5C,$A3,$5A,$A5,$58,$A7,$56,$A9,$55,$AA,$53,$AC,$52,$AD
	db $50,$AF,$4F,$B0,$4E,$B1,$4D,$B2,$4B,$B4,$4A,$B5,$49,$B6,$48,$B7
	db $47,$B8,$46,$B9,$45,$BA,$44,$BB,$43,$BC,$42,$BD,$41,$BE,$41,$BE
	db $40,$BF,$3F,$C0,$3E,$C1,$3D,$C2,$3D,$C2,$3C,$C3,$3B,$C4,$3A,$C5
	db $3A,$C5,$39,$C6,$39,$C6,$38,$C7,$37,$C8,$37,$C8,$36,$C9,$36,$C9
	db $35,$CA,$34,$CB,$34,$CB,$33,$CC,$33,$CC,$32,$CD,$32,$CD,$32,$CD
	db $31,$CE,$31,$CE,$30,$CF,$30,$CF,$2F,$D0,$2F,$D0,$2F,$D0,$2E,$D1
	db $2E,$D1,$2E,$D1,$2D,$D2,$2D,$D2,$2D,$D2,$2C,$D3,$2C,$D3,$2C,$D3
	db $2B,$D4,$2B,$D4,$2B,$D4,$2B,$D4,$2A,$D5,$2A,$D5,$2A,$D5,$2A,$D5
	db $29,$D6,$29,$D6,$29,$D6,$29,$D6,$29,$D6,$29,$D6,$28,$D7,$28,$D7
	db $28,$D7,$28,$D7

DATA_02FBFE:
	db $28,$D7,$28,$D7,$28,$D7,$28,$D7,$28,$D7,$27,$D8,$27,$D8,$27,$D8
	db $27,$D8,$27,$D8,$27,$D8,$27,$D8,$27,$D8,$27,$D8,$27,$D8,$27,$D8
	db $27,$D8,$27,$D8,$27,$D8,$27,$D8,$27,$D8,$27,$D8,$27,$D8,$27,$D8
	db $28,$D7,$28,$D7,$28,$D7,$28,$D7,$28,$D7,$28,$D7,$28,$D7,$28,$D7
	db $28,$D7,$29,$D6,$29,$D6,$29,$D6,$29,$D6,$29,$D6,$29,$D6,$2A,$D5
	db $2A,$D5,$2A,$D5,$2A,$D5,$2B,$D4,$2B,$D4,$2B,$D4,$2B,$D4,$2C,$D3
	db $2C,$D3,$2C,$D3,$2D,$D2,$2D,$D2,$2D,$D2,$2E,$D1,$2E,$D1,$2E,$D1
	db $2F,$D0,$2F,$D0,$2F,$D0,$30,$CF,$30,$CF,$31,$CE,$31,$CE,$32,$CD
	db $32,$CD,$32,$CD,$33,$CC,$33,$CC,$34,$CB,$34,$CB,$35,$CA,$36,$C9
	db $36,$C9,$37,$C8,$37,$C8,$38,$C7,$39,$C6,$39,$C6,$3A,$C5,$3A,$C5
	db $3B,$C4,$3C,$C3,$3D,$C2,$3D,$C2,$3E,$C1,$3F,$C0,$40,$BF,$41,$BE
	db $41,$BE,$42,$BD,$43,$BC,$44,$BB,$45,$BA,$46,$B9,$47,$B8,$48,$B7
	db $49,$B6,$4A,$B5,$4B,$B4,$4D,$B2,$4E,$B1,$4F,$B0,$50,$AF,$52,$AD
	db $53,$AC,$55,$AA,$56,$A9,$58,$A7,$5A,$A5,$5C,$A3,$5E,$A2,$60,$9F
	db $62,$9D,$64,$9B,$67,$98,$6A,$95,$6E,$91,$73,$8C,$80,$80

	%FREE_BYTES($02FCEC, 788, $FF)
%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SIMCBank03Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

CODE_038000:
	SEP.b #$20
	REP.b #$10
	LDA.b #DATA_038160>>16
	PHA
	PLB
	REP.b #$20
	JSR.w CODE_0390A7
	JSR.w CODE_03C474
	JSR.w CODE_03B84B
	JSR.w CODE_0388B4
CODE_038016:
	REP.b #$30
	JSR.w CODE_03894C
	JSR.w CODE_03821D
	JSR.w CODE_038297
	JSR.w CODE_03ADDF
	REP.b #$20
	INC.w $0B51
	LDA.w $0DC7
	CLC
	ADC.w !RAM_SIMC_City_TaxRateLo
	STA.w $0DC7
	LDA.w $0B51
	AND.w #$0003
	BNE.b CODE_0380B0
	INC.w !RAM_SIMC_City_CurrentMonthLo
	LDA.w !RAM_SIMC_City_CurrentMonthLo
	CMP.w #!Define_SIMC_City_Month_December+$01
	BNE.b CODE_03804F
	LDA.w #!Define_SIMC_City_Month_January
	STA.w !RAM_SIMC_City_CurrentMonthLo
	INC.w !RAM_SIMC_City_CurrentYearLo
CODE_03804F:
	JSR.w CODE_038BD1
	LDA.w !RAM_SIMC_City_CurrentYearLo
	SEC
	SBC.w #$000A
	STA.w $0DA9
	LDA.w !RAM_SIMC_City_CurrentMonthLo
	DEC
	STA.w $0DAD
	LDA.w #$0001
	STA.w $0CE7
	JSR.w CODE_03ADDF
	LDA.w !RAM_SIMC_City_CurrentMonthLo
	CMP.w #!Define_SIMC_City_Month_January
	BNE.b CODE_038090
	JSR.w CODE_038D29
	LDA.w !RAM_SIMC_City_CurrentYearLo
	SEC
	SBC.w #$0078
	STA.w $0DAB
	LDA.w #$0001
	STA.w $0CE9
	JSR.w CODE_038DF1
	JSR.w CODE_03B42F
	JSR.w CODE_03ADDF
CODE_038090:
	LDY.w !RAM_SIMC_City_CurrentMonthLo
	SEP.b #$20
	LDA.w DATA_038160,y
	BEQ.b CODE_0380B0
	LDA.w DATA_03816D,y
	CMP.w $0B4D
	BEQ.b CODE_0380B0
	STA.w $0B4D
	REP.b #$20
	LDA.w #$0001
	STA.w $0B4B
	STZ.w $0B4F
CODE_0380B0:
	REP.b #$20
	LDA.w $0B51
	AND.w #$0003
	CMP.w #$0001
	BNE.b CODE_0380C3
	JSR.w CODE_03891F
	JSR.w CODE_03ADDF
CODE_0380C3:
	JSR.w CODE_0388F3
	JSR.w CODE_03ADDF
	JSR.w CODE_03BE12
	JSR.w CODE_03C0AD
	JSR.w CODE_03C474
	JSR.w CODE_03C500
	SEP.b #$20
	REP.b #$10
CODE_0380D9:
	LDA.w $0193
	CMP.b #$03
	BEQ.b CODE_0380D9
	LDY.w $0193
	LDA.w DATA_03817A,y
	AND.w $0B51
	BNE.b CODE_0380F4
	JSR.w CODE_03AFB0
	JSR.w CODE_03B152
	JSR.w CODE_03ADDF
CODE_0380F4:
	SEP.b #$20
	REP.b #$10
	LDY.w $0193
	LDA.w DATA_03817E,y
	AND.w $0B51
	CMP.w DATA_038182,y
	BNE.b CODE_03810C
	JSR.w CODE_039C11
	JSR.w CODE_03ADDF
CODE_03810C:
	SEP.b #$20
	REP.b #$10
	LDY.w $0193
	LDA.w DATA_03817E,y
	AND.w $0B51
	CMP.w DATA_038186,y
	BNE.b CODE_038124
	JSR.w CODE_039E8E
	JSR.w CODE_03ADDF
CODE_038124:
	SEP.b #$20
	REP.b #$10
	LDY.w $0193
	LDA.w DATA_03817E,y
	AND.w $0B51
	CMP.w DATA_03818A,y
	BNE.b CODE_03813C
	JSR.w CODE_039AD7
	JSR.w CODE_03ADDF
CODE_03813C:
	SEP.b #$20
	REP.b #$10
	LDY.w $0193
	LDA.w DATA_03817E,y
	AND.w $0B51
	CMP.w DATA_03818E,y
	BNE.b CODE_038154
	JSR.w CODE_039AA3
	JSR.w CODE_03ADDF
CODE_038154:
	JSR.w CODE_03B84B
	JSR.w CODE_038196
	JSR.w CODE_03ADDF
	JMP.w CODE_038016

DATA_038160:
	db $00,$00,$00,$01,$00,$00,$01,$00,$00,$01,$00,$00,$01

DATA_03816D:
	db $03,$03,$03,$00,$00,$00,$01,$01,$01,$02,$02,$02,$03

DATA_03817A:
	db $03,$00,$00,$00

DATA_03817E:
	db $0F,$07,$03,$00

DATA_038182:
	db $02,$01,$00,$00

DATA_038186:
	db $06,$03,$01,$00

DATA_03818A:
	db $0A,$05,$02,$00

DATA_03818E:
	db $0E,$07,$03,$00

CODE_038192:
	JSR.w CODE_038196
	RTL

CODE_038196:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0004
	TCD
	PLA
	REP.b #$30
	LDA.w $0B8F
	CLC
	ADC.w $0B93
	ASL
	ASL
	ASL
	ADC.w $0B8B
	STA.b $00
	LDA.w #$0014
	STA.b $02
	JSR.w CODE_03A2F5	: db $00,$02,$00
	LDA.b $00
	STA.w !RAM_SIMC_City_CurrentPopulationLo
	LDA.b $02
	STA.w !RAM_SIMC_City_CurrentPopulationHi
	LDA.b $00
	SEC
	SBC.w $0BCD
	STA.w !RAM_SIMC_City_LastYearsNetMigrationLo
	LDA.b $02
	SBC.w $0BCF
	STA.w !RAM_SIMC_City_LastYearsNetMigrationHi
	LDY.w #$0003
	LDA.w !RAM_SIMC_City_CurrentPopulationHi
	BNE.b CODE_0381FA
	LDY.w #$0000
	LDA.w !RAM_SIMC_City_CurrentPopulationLo
	CMP.w #!Define_SIMC_City_TownPopulationThreshold
	BCC.b CODE_038218
	INY
	CMP.w #!Define_SIMC_City_CityPopulationThreshold
	BCC.b CODE_038218
	INY
	CMP.w #!Define_SIMC_City_CapitalPopulationThreshold
	BCC.b CODE_038218
	INY
	BRA.b CODE_038218

CODE_0381FA:
	LDA.w !RAM_SIMC_City_CurrentPopulationLo
	CMP.w #!Define_SIMC_City_MetropolisPopulationThreshold
	LDA.w !RAM_SIMC_City_CurrentPopulationHi
	SBC.w #!Define_SIMC_City_MetropolisPopulationThreshold>>16
	BCC.b CODE_038218
	INY
	LDA.w !RAM_SIMC_City_CurrentPopulationLo
	CMP.w #!Define_SIMC_City_MegalopolisPopulationThreshold
	LDA.w !RAM_SIMC_City_CurrentPopulationHi
	SBC.w #!Define_SIMC_City_MegalopolisPopulationThreshold>>16
	BCC.b CODE_038218
	INY
CODE_038218:
	STY.w !RAM_SIMC_City_CityCategory
	PLD
	RTS

CODE_03821D:
	REP.b #$30
	STZ.w $0E01
	STZ.w $0E15
	STZ.w $0E17
	STZ.w $0B8B
	STZ.w $0B93
	STZ.w $0B8F
	STZ.w $0B8D
	STZ.w $0B95
	STZ.w $0B91
	STZ.w $0E03
	STZ.w $0E05
	STZ.w !RAM_SIMC_City_PoliceStationCountLo
	STZ.w !RAM_SIMC_City_FireStationCountLo
	STZ.w $0E0B
	STZ.w $0E0D
	STZ.w $0E0F
	STZ.w $0E11
	STZ.w $0E13
	STZ.w $0E1B
	STZ.w $0E1D
	STZ.w $0E1F
	STZ.w $0E23
	STZ.w $0E25
	STZ.w $0E27
	STZ.w $0E29
	STZ.w $0E19
	STZ.w $0CA1
	STZ.w $0CA3
	STZ.w $0C57
	STZ.w $0C59
	STZ.w $0DDD
	STZ.w $0C71
	REP.b #$20
	LDX.w #$0000
	LDA.w #$0000
CODE_038287:
	STA.l $7FB16E,x
	STA.l $7FB2F4,x
	INX
	INX
	CPX.w #$0186
	BNE.b CODE_038287
	RTS

CODE_038297:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0002
	TCD
	PLA
	STZ.b $00
	SEP.b #$20
	STZ.w $0B86
CODE_0382A9:
	STZ.w $0B85
CODE_0382AC:
	REP.b #$20
	LDA.w $0B85
	JSR.w CODE_03849E
	CPX.b $00
	BEQ.b CODE_0382B9
	NOP
CODE_0382B9:
	LDX.b $00
	STX.w $0B49
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	INX
	INX
	STX.b $00
	STA.w $0B87
	AND.w #$03FF
	STA.w $0B89
	CMP.w #$007F
	BNE.b CODE_0382D9
	JSR.w CODE_03A7E0
	BRA.b CODE_038341

CODE_0382D9:
	TAY
	SEP.b #$20
	LDA.w DATA_0384EB,y
	AND.b #$01
	BEQ.b CODE_0382FF
	REP.b #$20
CODE_0382E5:
	STZ.w $023F
	LDA.l $7F02F0,x
	ORA.w #$4000
	STA.l $7F02F0,x
	LDA.w $023F
	BNE.b CODE_0382E5
	SEP.b #$20
	JSR.w CODE_0390C5
	BRA.b CODE_038341

CODE_0382FF:
	LDA.w DATA_0384EB,y
	AND.b #$20
	BEQ.b CODE_03830B
	JSR.w CODE_03A73D
	BRA.b CODE_03831A

CODE_03830B:
	SEP.b #$20
	LDY.w $0B89
	LDA.w DATA_0384EB,y
	AND.b #$40
	BEQ.b CODE_03831A
	JSR.w CODE_03A493
CODE_03831A:
	SEP.b #$20
	LDY.w $0B89
	LDA.w DATA_0384EB,y
	AND.b #$10
	BEQ.b CODE_03832B
	JSR.w CODE_03A7DA
	BRA.b CODE_03833E

CODE_03832B:
	LDY.w $0B89
	CPY.w #$0365
	BNE.b CODE_038336
	JSR.w CODE_03AD3F
CODE_038336:
	CPY.w #$0364
	BNE.b CODE_03833E
	JSR.w CODE_03AA8B
CODE_03833E:
	JSR.w CODE_0383F9
CODE_038341:
	SEP.b #$20
	INC.w $0B85
	LDA.w $0B85
	CMP.b #$78
	BEQ.b CODE_038350
	JMP.w CODE_0382AC

CODE_038350:
	INC.w $0B86
	LDA.w $0B86
	CMP.b #$64
	BEQ.b CODE_03835D
	JMP.w CODE_0382A9

CODE_03835D:
	REP.b #$20
	LDA.w $0B8D
	STA.w $0C73
	LDA.w $0B91
	STA.w $0C75
	LDA.w $0B95
	STA.w $0C77
	LDA.w $0E15
	STA.w $0C7F
	LDA.w $0E17
	STA.w $0C81
	LDA.w $0E19
	STA.w $0C83
	LDA.w $0E1B
	STA.w $0C79
	LDA.w $0E1D
	STA.w $0C7B
	LDA.w $0E1F
	STA.w $0C7D
	CLC
	ADC.w $0E1B
	ADC.w $0E1D
	STA.w $0E21
	LDA.w $0E0D
	CLC
	ADC.w $0E0F
	STA.w $0C85
	LDA.w $0E0B
	STA.w $0C87
	LDA.w !RAM_SIMC_City_FireStationCountLo
	STA.w $0C89
	LDA.w !RAM_SIMC_City_PoliceStationCountLo
	STA.w $0C8B
	LDA.w $0CA1
	STA.w $0C8D
	LDA.w $0E13
	STA.w $0C8F
	LDA.w $0E11
	STA.w $0C91
	LDA.w $0E03
	STA.w $0C93
	LDA.w $0E05
	STA.w $0C95
	LDA.w $0E23
	STA.w $0C97
	LDA.w $0E25
	STA.w $0C99
	LDA.w $0E27
	STA.w $0C9B
	LDA.w $0E29
	STA.w $0C9D
	LDA.w $0E01
	STA.w $0C9F
	PLD
	RTS

CODE_0383F9:
	REP.b #$20
	LDY.w $0B89
	BNE.b CODE_038405
	INC.w $0E27
	BRA.b CODE_03842E

CODE_038405:
	CPY.w #$0026
	BCC.b CODE_038414
	CPY.w #$0028
	BCS.b CODE_038414
	INC.w $0E23
	BRA.b CODE_03842E

CODE_038414:
	CPY.w #$0014
	BCC.b CODE_038423
	CPY.w #$0026
	BCS.b CODE_038423
	INC.w $0E25
	BRA.b CODE_03842E

CODE_038423:
	LDA.w DATA_0384EB,y
	AND.w #$0008
	BEQ.b CODE_03842E
	INC.w $0E29
CODE_03842E:
	RTS

CODE_03842F:
	LDA.w $0B89
	SEC
	SBC.w #$0099
	BCS.b CODE_03843C
	LDA.w #$0000
	RTS

CODE_03843C:
	SEP.b #$20
CODE_03843E:
	CMP.b #$24
	BCC.b CODE_038446
	SBC.b #$24
	BRA.b CODE_03843E

CODE_038446:
	LDY.w #$0001
	SEC
CODE_03844A:
	INY
	SBC.b #$09
	BCS.b CODE_03844A
	REP.b #$20
	TYA
	ASL
	ASL
	ASL
	RTS

CODE_038456:
	LDA.w $0B89
	SEC
	SBC.w #$0144
	BCS.b CODE_038463
	LDA.w #$0000
	RTS

CODE_038463:
	SEP.b #$20
CODE_038465:
	CMP.b #$2D
	BCC.b CODE_03846D
	SBC.b #$2D
	BRA.b CODE_038465

CODE_03846D:
	LDY.w #$0000
	SEC
CODE_038471:
	INY
	SBC.b #$09
	BCS.b CODE_038471
	REP.b #$20
	TYA
	RTS

CODE_03847A:
	LDA.w $0B89
	SEC
	SBC.w #$0201
	BCS.b CODE_038487
	LDA.w #$0000
	RTS

CODE_038487:
	SEP.b #$20
CODE_038489:
	CMP.b #$24
	BCC.b CODE_038491
	SBC.b #$24
	BRA.b CODE_038489

CODE_038491:
	LDY.w #$0000
	SEC
CODE_038495:
	INY
	SBC.b #$09
	BCS.b CODE_038495
	REP.b #$20
	TYA
	RTS

CODE_03849E:
	SEP.b #$20
	ASL
	STA.w $0B3F
	STZ.w $0B40
	LDA.b #$00
	XBA
	REP.b #$20
	PHA
	ASL
	ASL
	ASL
	ASL
	STA.w $0B3D
	PLA
	XBA
	SEC
	SBC.w $0B3D
	CLC
	ADC.w $0B3F
	TAX
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	RTS

CODE_0384C4:
	SEP.b #$20
	ASL
	STA.w $0B3F
	STZ.w $0B40
	LDA.b #$00
	XBA
	REP.b #$20
	PHA
	ASL
	ASL
	ASL
	ASL
	STA.w $0B3D
	PLA
	XBA
	SEC
	SBC.w $0B3D
	CLC
	ADC.w $0B3F
	TAX
	TYA
	STA.l !RAM_SIMC_City_MapDataBuffer,x
	RTS

DATA_0384EB:
	db $00,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08,$08
	db $08,$08,$08,$08,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04,$04
	db $04,$04,$04,$04,$04,$04,$04,$04,$00,$00,$00,$00,$00,$00,$00,$00
	db $48,$48,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$D4,$D4,$00
	db $48,$48,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$D4,$D4,$00
	db $48,$48,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$44,$D4,$D4,$00
	db $98,$98,$94,$94,$94,$94,$94,$94,$94,$94,$94,$94,$94,$B4,$B4,$00
	db $28,$28,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$00
	db $84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84
	db $84,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84
	db $84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84
	db $84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84
	db $84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$85
	db $84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84
	db $84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84
	db $84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84
	db $84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84
	db $84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84
	db $85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84
	db $84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84
	db $84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84
	db $84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$85
	db $84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84
	db $84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84
	db $84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84
	db $84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84
	db $84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84
	db $85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84
	db $84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84
	db $84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84
	db $84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$85
	db $84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84
	db $84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84
	db $84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84
	db $84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84
	db $84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84
	db $85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84
	db $84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84
	db $84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84
	db $84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84
	db $84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84
	db $84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84
	db $84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84
	db $84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$85
	db $84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84
	db $84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84
	db $84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84
	db $84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84
	db $84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84
	db $85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84
	db $84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84
	db $84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84
	db $84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$85
	db $84,$84,$84,$84,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40,$40
	db $40,$40,$40,$40,$00,$00,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84
	db $84,$84,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84
	db $84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84
	db $84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84
	db $84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$84,$84,$84,$84
	db $85,$84,$84,$84,$84,$84,$84,$84,$84,$85,$84,$84,$84,$84,$08

CODE_0388AA:
	SEP.b #$20
	INC.w $0058
	LDA.w $0058
	PLP
	RTS

CODE_0388B4:
	JSR.w CODE_03894C
	JSR.w CODE_03821D
	JSR.w CODE_038297
	JSR.w CODE_03ADDF
	JSR.w CODE_03AFB0
	JSR.w CODE_03B152
	JSR.w CODE_03ADDF
	JSR.w CODE_039C11
	JSR.w CODE_039E8E
	JSR.w CODE_039AD7
	JSR.w CODE_039C11
	JSR.w CODE_039E8E
	JSR.w CODE_039AD7
	JSR.w CODE_039AA3
	LDX.w #$0009
CODE_0388E1:
	STZ.w $0CDD,x
	DEX
	BPL.b CODE_0388E1
	LDA.b #$01
	STA.w $0DFB
	JSR.w CODE_03B42F
	JSR.w CODE_03ADDF
	RTS

CODE_0388F3:
	SEP.b #$20
	REP.b #$10
	LDX.w #$0000
CODE_0388FA:
	LDA.l $7F99E0,x
	BEQ.b CODE_038918
	CMP.b #$18
	BCC.b CODE_038912
	CMP.b #$C8
	BCC.b CODE_03890D
	SEC
	SBC.b #$22
	BRA.b CODE_038914

CODE_03890D:
	SEC
	SBC.b #$18
	BRA.b CODE_038914

CODE_038912:
	LDA.b #$00
CODE_038914:
	STA.l $7F99E0,x
CODE_038918:
	INX
	CPX.w #$0BB8
	BNE.b CODE_0388FA
	RTS

CODE_03891F:
	REP.b #$30
	LDX.w #$0000
CODE_038924:
	LDA.l $7FAE62,x
	BEQ.b CODE_038944
	BMI.b CODE_038937
	DEC
	CMP.w #$00C8
	BCC.b CODE_038940
	LDA.w #$00C8
	BRA.b CODE_038940

CODE_038937:
	INC
	CMP.w #$FF38
	BCS.b CODE_038940
	LDA.w #$FF38
CODE_038940:
	STA.l $7FAE62,x
CODE_038944:
	INX
	INX
	CPX.w #$0186
	BNE.b CODE_038924
	RTS

CODE_03894C:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0016
	TCD
	PLA
	REP.b #$20
	LDA.w $0DFB
	STA.w $0DFD
	LDA.w $0B8B
	LSR
	LSR
	LSR
	STA.b $14
	CLC
	ADC.w $0B93
	ADC.w $0B8F
	STA.w $0DFB
	LDA.b $14
	BEQ.b CODE_038994
	STA.b $04
	STZ.b $06
	LDA.l $7F60B0
	CLC
	ADC.l $7F61A0
	STA.b $02
	STZ.b $00
	JSR.w CODE_03A421	: db $00,$04,$00
	LDA.b $01
	CLC
	ADC.w #$0005
	BRA.b CODE_038997

CODE_038994:
	LDA.w #$014C
CODE_038997:
	CMP.w #$0200
	BCC.b CODE_03899F
	LDA.w #$0200
CODE_03899F:
	STA.b $08
	LDA.b $14
	CLC
	ADC.w $0B93
	ADC.w $0B8F
	STA.b $02
	STZ.b $00
	LDA.w #$03B3
	STA.b $04
	STZ.b $06
	JSR.w CODE_03A421	: db $00,$04,$00
	LDA.b $00
	STA.b $10
	LDA.b $02
	STA.b $12
	LDA.l $7F60B0
	CLC
	ADC.l $7F61A0
	BNE.b CODE_0389D3
	LDA.w #$0100
	BRA.b CODE_0389EF

CODE_0389D3:
	STA.b $04
	STZ.b $06
	LDA.l $7F5FC0
	STA.b $02
	STZ.b $00
	JSR.w CODE_03A421	: db $00,$04,$00
	LDA.b $01
	CMP.w #$014C
	BCC.b CODE_0389EF
	LDA.w #$014C
CODE_0389EF:
	STA.b $0E
	LDA.w $0B93
	BNE.b CODE_0389FD
	LDA.b $10
	CLC
	ADC.b $0E
	BRA.b CODE_038A17

CODE_0389FD:
	STA.b $04
	LDA.b $10
	CLC
	ADC.b $0E
	STA.b $00
	LDA.b $12
	ADC.w #$0000
	STA.b $02
	STZ.b $06
	JSR.w CODE_03A421	: db $00,$04,$00
	LDA.b $00
CODE_038A17:
	CMP.w #$0200
	BCC.b CODE_038A1F
	LDA.w #$0200
CODE_038A1F:
	STA.b $0A
	LDA.w $0B8F
	BNE.b CODE_038A2B
	LDA.w #$0200
	BRA.b CODE_038A72

CODE_038A2B:
	STA.b $00
	LDA.b $0E
	STA.b $04
	JSR.w CODE_03A2F5	: db $00,$04,$00
	LDA.b $01
	STA.b $00
	LDA.w !RAM_SIMC_City_DifficultyLevel
	ASL
	TAY
	LDA.w DATA_038BCB,y
	STA.b $04
	JSR.w CODE_03A2F5	: db $00,$04,$00
	LDA.b $01
	CMP.w #$0005
	BCS.b CODE_038A55
	LDA.w #$0005
CODE_038A55:
	STZ.b $00
	STZ.b $02
	STA.b $01
	LDA.w $0B8F
	STA.b $04
	STZ.b $06
	JSR.w CODE_03A421	: db $00,$04,$00
	LDA.b $00
	CMP.w #$0200
	BCC.b CODE_038A72
	LDA.w #$0200
CODE_038A72:
	STA.b $0C
	LDA.w !RAM_SIMC_City_TaxRateLo
	CLC
	ADC.w !RAM_SIMC_City_DifficultyLevel
	CMP.w #!Define_SIMC_City_MaxTaxPercent
	BCC.b CODE_038A83
	LDA.w #!Define_SIMC_City_MaxTaxPercent
CODE_038A83:
	ASL
	PHA
	LDA.w #$0258
	STA.b $04
	JSR.w CODE_03A2F5	: db $08,$04,$00
	PLY
	LDA.b $01
	SEC
	SBC.w #$0258
	CLC
	ADC.w DATA_038BA1,y
	CLC
	ADC.w $0BAD
	BMI.b CODE_038AAB
	CMP.w #$07D0
	BCC.b CODE_038AB3
	LDA.w #$07D0
	BRA.b CODE_038AB3

CODE_038AAB:
	CMP.w #$F830
	BCS.b CODE_038AB3
	LDA.w #$F830
CODE_038AB3:
	STA.w $0BAD
	PHY
	JSR.w CODE_03A2F5	: db $0A,$04,$00
	PLY
	LDA.b $01
	SEC
	SBC.w #$0258
	CLC
	ADC.w DATA_038BA1,y
	CLC
	ADC.w $0BAF
	BMI.b CODE_038AD8
	CMP.w #$05DC
	BCC.b CODE_038AE0
	LDA.w #$05DC
	BRA.b CODE_038AE0

CODE_038AD8:
	CMP.w #$FA24
	BCS.b CODE_038AE0
	LDA.w #$FA24
CODE_038AE0:
	STA.w $0BAF
	PHY
	JSR.w CODE_03A2F5	: db $0C,$04,$00
	PLY
	LDA.b $01
	SEC
	SBC.w #$0258
	CLC
	ADC.w DATA_038BA1,y
	CLC
	ADC.w $0BB1
	BMI.b CODE_038B05
	CMP.w #$05DC
	BCC.b CODE_038B0D
	LDA.w #$05DC
	BRA.b CODE_038B0D

CODE_038B05:
	CMP.w #$FA24
	BCS.b CODE_038B0D
	LDA.w #$FA24
CODE_038B0D:
	STA.w $0BB1
	LDA.w $0BB3
	BEQ.b CODE_038B1D
	LDA.w $0BAD
	BMI.b CODE_038B1D
	STZ.w $0BAD
CODE_038B1D:
	LDA.w $0BB5
	BEQ.b CODE_038B2A
	LDA.w $0BAF
	BMI.b CODE_038B2A
	STZ.w $0BAF
CODE_038B2A:
	LDA.w $0BB7
	BEQ.b CODE_038B37
	LDA.w $0BB1
	BMI.b CODE_038B37
	STZ.w $0BB1
CODE_038B37:
	LDA.w $0425
	AND.w #$0004
	BEQ.b CODE_038B4E
	LDA.w #$07D0
	STA.w $0BAD
	LDA.w #$05DC
	STA.w $0BAF
	STA.w $0BB1
CODE_038B4E:
	LDA.w $0BAD
	CLC
	ADC.w #$07D0
	STA.b $00
	LDA.w #$00F4
	STA.b $04
	JSR.w CODE_03A3CF	: db $00,$04,$00
	LDA.b $00
	STA.w $0BBB
	LDA.w $0BAF
	CLC
	ADC.w #$05DC
	STA.b $00
	LDA.w #$00B6
	STA.b $04
	JSR.w CODE_03A3CF	: db $00,$04,$00
	LDA.b $00
	STA.w $0BBD
	LDA.w $0BB1
	CLC
	ADC.w #$05DC
	STA.b $00
	LDA.w #$00B6
	STA.b $04
	JSR.w CODE_03A3CF	: db $00,$04,$00
	LDA.b $00
	STA.w $0BBF
	LDA.w #$0001
	STA.w $0BB9
	PLD
	RTS

DATA_038BA1:
	dw $00C8,$0096,$0078,$0064,$0050,$0032,$001E,$0000
	dw $FFF6,$FFD8,$FF9C,$FF6A,$FF38,$FF06,$FED4,$FEA2
	dw $FE70,$FE3E,$FE0C,$FDDA,$FDA8

DATA_038BCB:
	dw $0133,$011A,$00FB

CODE_038BD1:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$000C
	TCD
	PLA
	REP.b #$30
	STZ.b $00
	STZ.b $04
	STZ.b $08
	LDX.w #$00EC
CODE_038BE7:
	LDA.l $7F5FC0,x
	CMP.b $00
	BCC.b CODE_038BF1
	STA.b $00
CODE_038BF1:
	STA.l $7F5FC2,x
	LDA.l $7F60B0,x
	CMP.b $04
	BCC.b CODE_038BFF
	STA.b $04
CODE_038BFF:
	STA.l $7F60B2,x
	LDA.l $7F61A0,x
	CMP.b $08
	BCC.b CODE_038C0D
	STA.b $08
CODE_038C0D:
	STA.l $7F61A2,x
	LDA.l $7F6470,x
	STA.l $7F6472,x
	LDA.l $7F6380,x
	STA.l $7F6382,x
	LDA.l $7F6290,x
	STA.l $7F6292,x
	DEX
	DEX
	BPL.b CODE_038BE7
	LDA.b $00
	STA.w $0C5D
	STA.w $0C63
	LDA.b $04
	CMP.w $0C63
	BCC.b CODE_038C3F
	STA.w $0C63
CODE_038C3F:
	STA.w $0C5F
	LDA.b $08
	CMP.w $0C63
	BCC.b CODE_038C4C
	STA.w $0C63
CODE_038C4C:
	STA.w $0C61
	LDA.w $0B8B
	LSR
	LSR
	LSR
	CMP.w $0C6B
	BCC.b CODE_038C5D
	STA.w $0C6B
CODE_038C5D:
	STA.l $7F5FC0
	LDA.w $0B93
	CMP.w $0C6B
	BCC.b CODE_038C6C
	STA.w $0C6B
CODE_038C6C:
	STA.l $7F60B0
	LDA.w $0B8F
	CMP.w $0C6B
	BCC.b CODE_038C7B
	STA.w $0C6B
CODE_038C7B:
	STA.l $7F61A0
	LDA.w $0C01
	SEC
	SBC.w $0C6D
	CMP.w #$8000
	ROR
	CMP.w #$8000
	ROR
	CLC
	ADC.w $0C6D
	STA.w $0C6D
	CMP.w #$00FF
	BCC.b CODE_038C9D
	LDA.w #$00FF
CODE_038C9D:
	STA.l $7F6470
	LDA.w $0C07
	SEC
	SBC.w $0C6F
	CMP.w #$8000
	ROR
	CMP.w #$8000
	ROR
	CLC
	ADC.w $0C6F
	STA.w $0C6F
	CMP.w #$00FF
	BCC.b CODE_038CBF
	LDA.w #$00FF
CODE_038CBF:
	STA.l $7F6290
	LDA.w $0BC1
	CLC
	ADC.w #$0A00
	BMI.b CODE_038CE5
	STA.b $00
	LDA.w #$0014
	STA.b $04
	JSR.w CODE_03A3CF	: db $00,$04,$00
	LDA.b $00
	CMP.w #$00FF
	BCC.b CODE_038CE8
	LDA.w #$00FF
	BRA.b CODE_038CE8

CODE_038CE5:
	LDA.w #$0000
CODE_038CE8:
	STA.l $7F6380
	REP.b #$10
	LDY.w #$0001
	LDA.w $0B8B
	LSR
	LSR
	LSR
	LSR
	LSR
	LSR
	LSR
	LSR
	CMP.w $0E03
	BEQ.b CODE_038D08
	BCS.b CODE_038D0D
	LDY.w #$FFFF
	BRA.b CODE_038D0D

CODE_038D08:
	LDY.w #$0000
	BRA.b CODE_038D0D

CODE_038D0D:
	STY.w $0B97
	LDY.w #$0001
	CMP.w $0E05
	BEQ.b CODE_038D1F
	BCS.b CODE_038D24
	LDY.w #$FFFF
	BRA.b CODE_038D24

CODE_038D1F:
	LDY.w #$0000
	BRA.b CODE_038D24

CODE_038D24:
	STY.w $0B99
	PLD
	RTS

CODE_038D29:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$000C
	TCD
	PLA
	REP.b #$30
	STZ.b $00
	STZ.b $04
	STZ.b $08
	LDX.w #$00EC
CODE_038D3F:
	LDA.l $7F6560,x
	CMP.b $00
	BCC.b CODE_038D49
	STA.b $00
CODE_038D49:
	STA.l $7F6562,x
	LDA.l $7F6650,x
	CMP.b $04
	BCC.b CODE_038D57
	STA.b $04
CODE_038D57:
	STA.l $7F6652,x
	LDA.l $7F6740,x
	CMP.b $08
	BCC.b CODE_038D65
	STA.b $08
CODE_038D65:
	STA.l $7F6742,x
	LDA.l $7F6A10,x
	STA.l $7F6A12,x
	LDA.l $7F6920,x
	STA.l $7F6922,x
	LDA.l $7F6830,x
	STA.l $7F6832,x
	DEX
	DEX
	BPL.b CODE_038D3F
	LDA.b $00
	STA.w $0C65
	STA.w $0C6B
	LDA.b $04
	CMP.w $0C6B
	BCC.b CODE_038D97
	STA.w $0C6B
CODE_038D97:
	STA.w $0C67
	LDA.b $08
	CMP.w $0C6B
	BCC.b CODE_038DA4
	STA.w $0C6B
CODE_038DA4:
	STA.w $0C69
	LDA.w $0B8B
	LSR
	LSR
	LSR
	CMP.w $0C6B
	BCC.b CODE_038DB5
	STA.w $0C6B
CODE_038DB5:
	STA.l $7F6560
	LDA.w $0B93
	CMP.w $0C6B
	BCC.b CODE_038DC4
	STA.w $0C6B
CODE_038DC4:
	STA.l $7F6650
	LDA.w $0B8F
	CMP.w $0C6B
	BCC.b CODE_038DD3
	STA.w $0C6B
CODE_038DD3:
	STA.l $7F6740
	LDA.l $7F6470
	STA.l $7F6A10
	LDA.l $7F6290
	STA.l $7F6830
	LDA.l $7F6380
	STA.l $7F6920
	PLD
	RTS

CODE_038DF1:				; Note: Routine that adds money to your funds?
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$000C
	TCD
	PLA
	REP.b #$30
	STZ.w $0BC1
	LDA.w $0DC3
	BEQ.b CODE_038E07
	RTS

CODE_038E07:
	LDA.w !RAM_SIMC_City_PoliceStationCountLo
	STA.b $00
	LDA.w #!Define_SIMC_City_YearlyPoliceAndFireStationCost
	STA.b $04
	JSR.w CODE_03A2F5	: db $00,$04,$00
	LDA.b $00
	CMP.w #!Define_SIMC_City_MaxRequestedPoliceFund
	BCC.b CODE_038E21
	LDA.w #!Define_SIMC_City_MaxRequestedPoliceFund
CODE_038E21:
	STA.w $0DD5
	LDA.w !RAM_SIMC_City_FireStationCountLo
	STA.b $00
	JSR.w CODE_03A2F5	: db $00,$04,$00
	LDA.b $00
	CMP.w #!Define_SIMC_City_MaxRequestedFireFund
	BCC.b CODE_038E39
	LDA.w #!Define_SIMC_City_MaxRequestedFireFund
CODE_038E39:
	STA.w $0DD7
	LDA.w $0E17
	ASL
	ADC.w $0E15
	STA.b $00
	LDA.w !RAM_SIMC_City_DifficultyLevel
	ASL
	TAX
	LDA.w DATA_038FE8,x
	STA.b $04
	JSR.w CODE_03A2F5	: db $00,$04,$00
	LDA.b $01
	CMP.w #!Define_SIMC_City_MaxRequestedTransportFund
	BCC.b CODE_038E5F
	LDA.w #!Define_SIMC_City_MaxRequestedTransportFund
CODE_038E5F:
	STA.w $0DD3
	LDA.w $0DC7
	STA.b $00
	LDA.w #$0030
	STA.b $04
	JSR.w CODE_03A3CF	: db $00,$04,$08
	LDA.w $0DFB
	STA.b $00
	LDA.w $0C03
	STA.b $04
	JSR.w CODE_03A2F5	: db $00,$04,$00
	LDA.w #$0078
	STA.b $04
	STZ.b $06
	JSR.w CODE_03A421	: db $00,$04,$00
	JSR.w CODE_03A2F5	: db $00,$08,$00
	LDA.w $0DDD
	STA.w $0DD9
	LDA.w !RAM_SIMC_City_DifficultyLevel
	ASL
	TAX
	LDA.w DATA_038FEE,x
	STA.b $04
	STZ.b $06
	JSR.w CODE_03A350	: db $00,$04,$00
	LDA.b $01
	STA.w $0DC9
	LDA.b $03
	STA.w $0DCB
	STZ.w $0DC7
	LDA.w #$FFFF
	STA.w $0DC3
	LDA.w $0195
	AND.w #$0002
	BEQ.b CODE_038ECE
	LDA.w #$0001
	STA.w $0DC3
CODE_038ECE:
	LDA.w $0DC3
	BNE.b CODE_038ECE
	LDA.w #$0000
	LDY.w $0B1D
	BEQ.b CODE_038EE1
	DEC.w $0B1D
	LDA.w #$01F4
CODE_038EE1:
	CLC
	ADC.w !RAM_SIMC_City_AllocatedPoliceFundsLo
	ADC.w !RAM_SIMC_City_AllocatedFireFundsLo
	ADC.w !RAM_SIMC_City_AllocatedTransportFundsLo
	STA.b $00
	LDA.w $0DC9
	CLC
	ADC.w $0DD9
	SEC
	SBC.b $00
	STA.w $0BC1
	LDA.w !RAM_SIMC_City_CurrentFundsLo
	CLC
	ADC.w $0DC9
	STA.b $04
	LDA.w !RAM_SIMC_City_CurrentFundsHi
	ADC.w $0DCB
	STA.b $06
	LDA.b $04
	CLC
	ADC.w $0DD9
	STA.b $04
	BCC.b CODE_038F17
	INC.b $06
CODE_038F17:
	LDA.b $04
	SEC
	SBC.b $00
	STA.w !RAM_SIMC_City_CurrentFundsLo
	LDA.b $06
	SBC.w #$0000
	STA.w !RAM_SIMC_City_CurrentFundsHi
	LDA.w !RAM_SIMC_City_CurrentFundsLo
	CMP.w #!Define_SIMC_City_MaxMoney
	LDA.w !RAM_SIMC_City_CurrentFundsHi
	SBC.w #!Define_SIMC_City_MaxMoney>>16
	BCC.b CODE_038F41
	LDA.w #!Define_SIMC_City_MaxMoney
	STA.w !RAM_SIMC_City_CurrentFundsLo
	LDA.w #!Define_SIMC_City_MaxMoney>>16
	STA.w !RAM_SIMC_City_CurrentFundsHi
CODE_038F41:
	LDA.w $0DD3
	BEQ.b CODE_038F72
	SEP.b #$20
	STZ.b $00
	STZ.b $03
	REP.b #$20
	LDA.w !RAM_SIMC_City_AllocatedTransportFundsLo
	STA.b $01
	LDA.w $0DD3
	STA.b $04
	STZ.b $06
	JSR.w CODE_03A421	: db $00,$04,$00
	LDA.w #$0021
	STA.b $04
	JSR.w CODE_03A2F5	: db $00,$04,$00
	LDA.b $01
	STA.w $0BC5
	BRA.b CODE_038F78

CODE_038F72:
	LDA.w #$0020
	STA.w $0BC5
CODE_038F78:
	LDA.w $0DD5
	BEQ.b CODE_038FA9
	SEP.b #$20
	STZ.b $00
	STZ.b $03
	REP.b #$20
	LDA.w !RAM_SIMC_City_AllocatedPoliceFundsLo
	STA.b $01
	LDA.w $0DD5
	STA.b $04
	STZ.b $06
	JSR.w CODE_03A421	: db $00,$04,$00
	LDA.w #$03E8
	STA.b $04
	JSR.w CODE_03A2F5	: db $00,$04,$00
	LDA.b $01
	STA.w $0BC7
	BRA.b CODE_038FAF

CODE_038FA9:
	LDA.w #$03E8
	STA.w $0BC7
CODE_038FAF:
	LDA.w $0DD7
	BEQ.b CODE_038FE0
	SEP.b #$20
	STZ.b $00
	STZ.b $03
	REP.b #$20
	LDA.w !RAM_SIMC_City_AllocatedFireFundsLo
	STA.b $01
	LDA.w $0DD7
	STA.b $04
	STZ.b $06
	JSR.w CODE_03A421	: db $00,$04,$00
	LDA.w #$03E8
	STA.b $04
	JSR.w CODE_03A2F5	: db $00,$04,$00
	LDA.b $01
	STA.w $0BC9
	BRA.b CODE_038FE6

CODE_038FE0:
	LDA.w #$03E8
	STA.w $0BC9
CODE_038FE6:
	PLD
	RTS

DATA_038FE8:
	dw $00B3,$00E6,$0133

DATA_038FEE:
	dw $0166,$0133,$00CD

CODE_038FF4:
	SEP.b #$30
	LDX.w $0B85
	LDY.w $0B86
	CMP.b #$00
	BNE.b CODE_039007
	CPY.b #$00
	BEQ.b CODE_03902F
	DEY
	BRA.b CODE_039023

CODE_039007:
	DEC
	BNE.b CODE_039011
	CPX.b #$77
	BEQ.b CODE_03902F
	INX
	BRA.b CODE_039023

CODE_039011:
	DEC
	BNE.b CODE_03901B
	CPY.b #$63
	BEQ.b CODE_03902F
	INY
	BRA.b CODE_039023

CODE_03901B:
	DEC
	BNE.b CODE_039023
	CPX.b #$00
	BEQ.b CODE_03902F
	DEX
CODE_039023:
	STX.w $0B85
	STY.w $0B86
	REP.b #$30
	LDA.w #$0001
	RTS

CODE_03902F:
	REP.b #$30
	LDA.w #$0000
	RTS

CODE_039035:
	PHP
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0006
	TCD
	PLA
	REP.b #$30
	PHX
	PHY
	INC
	STA.b $02
	STZ.b $00
	LDX.w #$000C
CODE_03904D:
	LDA.w $0CCD,x
	STA.w $0CCF,x
	ADC.b $00
	STA.b $00
	DEX
	DEX
	BNE.b CODE_03904D
	STA.w $0CCF
	LDA.w #$7FFF
	STA.b $00
	JSR.w CODE_03A3CF	: db $00,$02,$04
	LDA.w $0CCF
	AND.w #$7FFF
	STA.b $00
	JSR.w CODE_03A3CF	: db $00,$04,$00
	LDA.b $00
	PLY
	PLX
	PLD
	PLP
	RTS

CODE_03907E:
	PHP
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0002
	TCD
	PLA
	REP.b #$30
	PHX
	STZ.b $00
	LDX.w #$000C
CODE_039092:
	LDA.w $0CCD,x
	STA.w $0CCF,x
	ADC.b $00
	STA.b $00
	DEX
	DEX
	BNE.b CODE_039092
	STA.w $0CCF
	PLX
	PLD
	PLP
	RTS

CODE_0390A7:
	REP.b #$20
	LDX.w #$000C
CODE_0390AC:
	LDA.w DATA_0390B7,x
	STA.w $0CCF,x
	DEX
	DEX
	BPL.b CODE_0390AC
	RTS

DATA_0390B7:
	dw $03FA,$11A9,$00CA,$FE5D,$0003,$9BA8,$01D4

CODE_0390C5:
	REP.b #$30
	JSR.w CODE_039137
	LDA.w $0B89
	CMP.w #$0129
	BNE.b CODE_0390D8
	INC.w $0E1F
	JMP.w CODE_0391DF

CODE_0390D8:
	CMP.w #$0132
	BNE.b CODE_0390E3
	INC.w $0E1F
	JMP.w CODE_039207

CODE_0390E3:
	CMP.w #$036B
	BEQ.b CODE_03910E
	CMP.w #$0310
	BEQ.b CODE_03910E
	CMP.w #$0307
	BEQ.b CODE_03910E
	CMP.w #$02BB
	BCC.b CODE_039109
	CMP.w #$0376
	BCC.b CODE_039103
	CMP.w #$039A
	BCC.b CODE_03911E
	BRA.b CODE_03912B

CODE_039103:
	INC.w $0E1F
	JMP.w CODE_03AE25

CODE_039109:
	CMP.w #$0249
	BCC.b CODE_039111
CODE_03910E:
	JMP.w CODE_03AA9F

CODE_039111:
	LDA.w $0B89
	CMP.w #$0080
	BCC.b CODE_039136
	CMP.w #$0129
	BCS.b CODE_039121
CODE_03911E:
	JMP.w CODE_03937A

CODE_039121:
	CMP.w #$0137
	BCC.b CODE_03912E
	CMP.w #$01F4
	BCS.b CODE_03912E
CODE_03912B:
	JMP.w CODE_0392CE

CODE_03912E:
	CMP.w #$0249
	BCS.b CODE_039136
	JMP.w CODE_03922F

CODE_039136:
	RTS

CODE_039137:
	LDA.w $0B49
	SEC
	SBC.w #$02D0
	TAX
	LDA.w $0B89
	CMP.w #$037A
	BCC.b CODE_039136
	BNE.b CODE_039157
	LDA.l $7F04D6,x
	AND.w #$03FF
	CMP.w #$0383
	BEQ.b CODE_039136
	BRA.b CODE_03918E

CODE_039157:
	CMP.w #$0383
	BNE.b CODE_03916A
	LDA.l $7F04CA,x
	AND.w #$03FF
	CMP.w #$037A
	BEQ.b CODE_039136
	BRA.b CODE_03918E

CODE_03916A:
	CMP.w #$038C
	BNE.b CODE_03917D
	LDA.l $7F07A0,x
	AND.w #$03FF
	CMP.w #$0395
	BEQ.b CODE_039136
	BRA.b CODE_03918E

CODE_03917D:
	CMP.w #$0395
	BNE.b CODE_039193
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	AND.w #$03FF
	CMP.w #$038C
	BEQ.b CODE_0391DE
CODE_03918E:
	LDA.w #$011C
	BRA.b CODE_0391DB

CODE_039193:
	CMP.w #$039E
	BNE.b CODE_0391A6
	LDA.l $7F04D6,x
	AND.w #$03FF
	CMP.w #$03A7
	BEQ.b CODE_0391DE
	BRA.b CODE_0391D8

CODE_0391A6:
	CMP.w #$03A7
	BNE.b CODE_0391B9
	LDA.l $7F04CA,x
	AND.w #$03FF
	CMP.w #$039E
	BEQ.b CODE_0391DE
	BRA.b CODE_0391D8

CODE_0391B9:
	CMP.w #$03B0
	BNE.b CODE_0391CC
	LDA.l $7F07A0,x
	AND.w #$03FF
	CMP.w #$03B9
	BEQ.b CODE_0391DE
	BRA.b CODE_0391D8

CODE_0391CC:
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	AND.w #$03FF
	CMP.w #$03B0
	BEQ.b CODE_0391DE
CODE_0391D8:
	LDA.w #$01EB
CODE_0391DB:
	JSR.w CODE_039940
CODE_0391DE:
	RTS

CODE_0391DF:
	INC.w $0E03
	LDA.w $0B9B
	AND.w #$000F
	BNE.b CODE_0391F0
	LDY.w #$0003
	JSR.w CODE_03AEA1
CODE_0391F0:
	LDA.w $0B97
	BPL.b CODE_039206
	LDA.w #$0014
	JSR.w CODE_039035
	CMP.w #$0000
	BNE.b CODE_039206
	LDA.w #$0080
	JSR.w CODE_039940
CODE_039206:
	RTS

CODE_039207:
	INC.w $0E05
	LDA.w $0B9B
	AND.w #$000F
	BNE.b CODE_039218
	LDY.w #$0003
	JSR.w CODE_03AEA1
CODE_039218:
	LDA.w $0B99
	BPL.b CODE_03922E
	LDA.w #$0014
	JSR.w CODE_039035
	CMP.w #$0000
	BNE.b CODE_03922E
	LDA.w #$0080
	JSR.w CODE_039940
CODE_03922E:
	RTS

CODE_03922F:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0008
	TCD
	PLA
	INC.w $0B91
	JSR.w CODE_03847A
	STA.b $00
	CMP.w #$0000
	BNE.b CODE_03924C
	INC.w $0E1D
	BRA.b CODE_039258

CODE_03924C:
	INC.w $0E1B
	LDA.w $0B8F
	CLC
	ADC.b $00
	STA.w $0B8F
CODE_039258:
	LDA.w #$0005
	JSR.w CODE_039035
	CMP.b $00
	BCS.b CODE_03926A
	LDA.w #$0002
	JSR.w CODE_03B1A5
	BRA.b CODE_03926D

CODE_03926A:
	LDA.w #$0001
CODE_03926D:
	STA.b $04
	LDA.b $04
	CMP.w #$FFFF
	BNE.b CODE_03927B
	JSR.w CODE_039794
	BRA.b CODE_0392CC

CODE_03927B:
	JSR.w CODE_03907E
	AND.w #$0007
	BNE.b CODE_0392CC
	LDA.b $04
	JSR.w CODE_039A31
	CLC
	ADC.w $0BB1
	LDY.w $0B87
	BMI.b CODE_039294
	LDA.w #$FE0C
CODE_039294:
	STA.b $02
	CMP.w #$FEA2
	BMI.b CODE_0392B1
	JSR.w CODE_03907E
	STA.b $06
	LDA.b $02
	SEC
	SBC.w #$670C
	CMP.b $06
	BVS.b CODE_0392B1
	BMI.b CODE_0392B1
	JSR.w CODE_0395FC
	BRA.b CODE_0392CC

CODE_0392B1:
	LDA.b $02
	CMP.w #$015E
	BPL.b CODE_0392CC
	JSR.w CODE_03907E
	STA.b $06
	LDA.b $02
	CLC
	ADC.w #$670C
	CMP.b $06
	BVS.b CODE_0392CC
	BPL.b CODE_0392CC
	JSR.w CODE_039794
CODE_0392CC:
	PLD
	RTS

CODE_0392CE:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0008
	TCD
	PLA
	INC.w $0B95
	LDA.w $0B89
	CMP.w #$039A
	BCC.b CODE_0392E9
	LDA.w #$0006
	BRA.b CODE_0392EC

CODE_0392E9:
	JSR.w CODE_038456
CODE_0392EC:
	STA.b $00
	CMP.w #$0000
	BNE.b CODE_0392F8
	INC.w $0E1D
	BRA.b CODE_039304

CODE_0392F8:
	INC.w $0E1B
	LDA.w $0B93
	CLC
	ADC.b $00
	STA.w $0B93
CODE_039304:
	LDA.w #$0005
	JSR.w CODE_039035
	CMP.b $00
	BCS.b CODE_039316
	LDA.w #$0001
	JSR.w CODE_03B1A5
	BRA.b CODE_039319

CODE_039316:
	LDA.w #$0001
CODE_039319:
	STA.b $04
	LDA.b $04
	CMP.w #$FFFF
	BNE.b CODE_039327
	JSR.w CODE_03974B
	BRA.b CODE_039378

CODE_039327:
	JSR.w CODE_03907E
	AND.w #$0007
	BNE.b CODE_039378
	LDA.b $04
	JSR.w CODE_039A0E
	CLC
	ADC.w $0BAF
	LDY.w $0B87
	BMI.b CODE_039340
	LDA.w #$FE0C
CODE_039340:
	STA.b $02
	CMP.w #$FEA2
	BMI.b CODE_03935D
	JSR.w CODE_03907E
	STA.b $06
	LDA.b $02
	SEC
	SBC.w #$670C
	CMP.b $06
	BVS.b CODE_03935D
	BMI.b CODE_03935D
	JSR.w CODE_039567
	BRA.b CODE_039378

CODE_03935D:
	LDA.b $02
	CMP.w #$015E
	BPL.b CODE_039378
	JSR.w CODE_03907E
	STA.b $06
	LDA.b $02
	CLC
	ADC.w #$670C
	CMP.b $06
	BVS.b CODE_039378
	BPL.b CODE_039378
	JSR.w CODE_03974B
CODE_039378:
	PLD
	RTS

CODE_03937A:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$000A
	TCD
	PLA
	INC.w $0B8D
	LDA.w $0B89
	CMP.w #$0376
	BCC.b CODE_039395
	LDA.w #$0030
	BRA.b CODE_0393A2

CODE_039395:
	CMP.w #$0084
	BNE.b CODE_03939F
	JSR.w CODE_039A3E
	BRA.b CODE_0393A2

CODE_03939F:
	JSR.w CODE_03842F
CODE_0393A2:
	STA.b $00
	CMP.w #$0000
	BNE.b CODE_0393AE
	INC.w $0E1D
	BRA.b CODE_0393BA

CODE_0393AE:
	INC.w $0E1B
	LDA.w $0B8B
	CLC
	ADC.b $00
	STA.w $0B8B
CODE_0393BA:
	LDA.w #$0023
	JSR.w CODE_039035
	CMP.b $00
	BCS.b CODE_0393CC
	LDA.w #$0000
	JSR.w CODE_03B1A5
	BRA.b CODE_0393CF

CODE_0393CC:
	LDA.w #$0001
CODE_0393CF:
	STA.b $04
	LDA.b $04
	CMP.w #$FFFF
	BNE.b CODE_0393DD
	JSR.w CODE_039659
	BRA.b CODE_039447

CODE_0393DD:
	LDA.w $0B89
	CMP.w #$0084
	BEQ.b CODE_0393ED
	JSR.w CODE_03907E
	AND.w #$0007
	BNE.b CODE_039447
CODE_0393ED:
	LDA.b $04
	JSR.w CODE_0399D2
	CLC
	ADC.w $0BAD
	LDY.w $0B87
	BMI.b CODE_0393FE
	LDA.w #$FE0C
CODE_0393FE:
	STA.b $02
	CMP.w #$FEA2
	BMI.b CODE_03942C
	JSR.w CODE_03907E
	STA.b $06
	LDA.b $02
	SEC
	SBC.w #$670C
	CMP.b $06
	BVS.b CODE_03942C
	BMI.b CODE_03942C
	LDA.b $00
	BNE.b CODE_039427
	JSR.w CODE_03907E
	AND.w #$0003
	BNE.b CODE_039427
	JSR.w CODE_039449
	BRA.b CODE_039447

CODE_039427:
	JSR.w CODE_039495
	BRA.b CODE_039447

CODE_03942C:
	LDA.b $02
	CMP.w #$015E
	BPL.b CODE_039447
	JSR.w CODE_03907E
	STA.b $06
	LDA.b $02
	CLC
	ADC.w #$670C
	CMP.b $06
	BVS.b CODE_039447
	BPL.b CODE_039447
	JSR.w CODE_039659
CODE_039447:
	PLD
	RTS

CODE_039449:
	LDA.w $0B97
	BEQ.b CODE_039459
	LDA.w #$0125
	JSR.w CODE_039940
	STZ.w $0B97
	BRA.b CODE_039467

CODE_039459:
	LDA.w $0B99
	BEQ.b CODE_039467
	LDA.w #$012E
	JSR.w CODE_039940
	STZ.w $0B99
CODE_039467:
	RTS

CODE_039468:
	SEP.b #$20
	LDA.w $0B86
	LSR
	XBA
	LDA.w $0B85
	LSR
	JSR.w CODE_03A29A
	LDY.w #$0000
	LDA.l $7F6B00,x
	SEC
	SBC.l $7F8270,x
	BCC.b CODE_039493
	CMP.b #$1E
	BCC.b CODE_039493
	INY
	CMP.b #$50
	BCC.b CODE_039493
	INY
	CMP.b #$96
	BCC.b CODE_039493
	INY
CODE_039493:
	TYA
	RTS

CODE_039495:
	SEP.b #$20
	LDA.w $0B86
	LSR
	XBA
	LDA.w $0B85
	LSR
	JSR.w CODE_03A29A
	LDA.l $7F8270,x
	CMP.b #$81
	BCS.b CODE_039503
	REP.b #$20
	LDA.w $0B89
	CMP.w #$0084
	BNE.b CODE_0394E6
	LDA.b $00
	CMP.w #$0008
	BCS.b CODE_0394CA
	PHX
	JSR.w CODE_0397C9
	PLX
	SEP.b #$20
	LDA.b #$01
	JSR.w CODE_03961D
	BRA.b CODE_039503

CODE_0394CA:
	SEP.b #$20
	LDA.l $7F8E28,x
	CMP.b #$41
	BCC.b CODE_039503
	JSR.w CODE_039468
	XBA
	LDA.b #$00
	JSR.w CODE_0398B8
	SEP.b #$20
	LDA.b #$08
	JSR.w CODE_03961D
	BRA.b CODE_039503

CODE_0394E6:
	REP.b #$20
	LDA.b $00
	CMP.w #$0028
	BCS.b CODE_039504
	JSR.w CODE_039468
	XBA
	LDA.b $00
	LSR
	LSR
	LSR
	DEC
	JSR.w CODE_0398B8
	SEP.b #$20
	LDA.b #$08
	JSR.w CODE_03961D
CODE_039503:
	RTS

CODE_039504:
	REP.b #$30
	LDA.w $0B89
	CMP.w #$0120
	BNE.b CODE_039566
	LDX.w $0B49
	LDA.l $7F0206,x
	AND.w #$03FF
	CMP.w #$0120
	BNE.b CODE_03953C
	LDA.w #$0376
	JSR.w CODE_039940
	LDA.w $0B85
	PHA
	LDA.w $0B85
	CLC
	ADC.w #$0003
	STA.w $0B85
	LDA.w #$037F
	JSR.w CODE_039940
	PLA
	STA.w $0B85
	RTS

CODE_03953C:
	LDA.l $7F04D0,x
	AND.w #$03FF
	CMP.w #$0120
	BNE.b CODE_039566
	LDA.w #$0388
	JSR.w CODE_039940
	LDA.w $0B85
	PHA
	LDA.w $0B85
	CLC
	ADC.w #$0300
	STA.w $0B85
	LDA.w #$0391
	JSR.w CODE_039940
	PLA
	STA.w $0B85
CODE_039566:
	RTS

CODE_039567:
	SEP.b #$20
	LDA.w $0B86
	LSR
	XBA
	LDA.w $0B85
	LSR
	JSR.w CODE_03A29A
	LDA.l $7F6B00,x
	LSR
	LSR
	LSR
	LSR
	LSR
	CMP.b $00
	BCC.b CODE_039598
	LDA.b $00
	CMP.b #$05
	BCS.b CODE_039599
	JSR.w CODE_039468
	XBA
	LDA.b $00
	JSR.w CODE_0398DD
	SEP.b #$20
	LDA.b #$08
	JSR.w CODE_03961D
CODE_039598:
	RTS

CODE_039599:
	REP.b #$30
	LDA.w $0B89
	CMP.w #$01EF
	BNE.b CODE_0395FB
	LDX.w $0B49
	LDA.l $7F0206,x
	AND.w #$03FF
	CMP.w #$01EF
	BNE.b CODE_0395D1
	LDA.w #$039A
	JSR.w CODE_039940
	LDA.w $0B85
	PHA
	LDA.w $0B85
	CLC
	ADC.w #$0003
	STA.w $0B85
	LDA.w #$03A3
	JSR.w CODE_039940
	PLA
	STA.w $0B85
	RTS

CODE_0395D1:
	LDA.l $7F04D0,x
	AND.w #$03FF
	CMP.w #$01EF
	BNE.b CODE_0395FB
	LDA.w #$03AC
	JSR.w CODE_039940
	LDA.w $0B85
	PHA
	LDA.w $0B85
	CLC
	ADC.w #$0300
	STA.w $0B85
	LDA.w #$03B5
	JSR.w CODE_039940
	PLA
	STA.w $0B85
CODE_0395FB:
	RTS

CODE_0395FC:
	REP.b #$20
	LDA.b $00
	CMP.w #$0004
	BCS.b CODE_03961C
	REP.b #$20
	JSR.w CODE_03907E
	AND.w #$0001
	SEP.b #$20
	XBA
	LDA.b $00
	JSR.w CODE_039906
	SEP.b #$20
	LDA.b #$08
	JSR.w CODE_03961D
CODE_03961C:
	RTS

CODE_03961D:
	SEP.b #$20
	PHA
	LDA.w $0B86
	LSR
	LSR
	LSR
	XBA
	LDA.w $0B85
	LSR
	LSR
	LSR
	JSR.w CODE_03A2D7
	REP.b #$20
	ASL
	TAX
	SEP.b #$20
	PLA
	BPL.b CODE_039640
	REP.b #$20
	ORA.w #$FF00
	BRA.b CODE_039645

CODE_039640:
	REP.b #$20
	AND.w #$00FF
CODE_039645:
	ASL
	ASL
	CLC
	ADC.l $7FAE62,x
	STA.l $7FAE62,x
	SEP.b #$20
	RTS

CODE_039653:
	LDA.w #$011C
	JMP.w CODE_039940

CODE_039659:
	REP.b #$20
	LDA.w $0B89
	CMP.w #$037A
	BEQ.b CODE_039653
	CMP.w #$038C
	BEQ.b CODE_039653
	CMP.w #$0383
	BEQ.b CODE_0396D5
	CMP.w #$0395
	BEQ.b CODE_0396D5
	SEP.b #$20
	LDA.b $00
	BEQ.b CODE_0396D5
	CMP.b #$10
	BNE.b CODE_0396D7
	LDA.b #$F8
	JSR.w CODE_03961D
	REP.b #$20
	LDA.w $0B85
	LDY.w #$0084
	JSR.w CODE_0384C4
	JSR.w CODE_039468
	REP.b #$20
	AND.w #$00FF
	STA.b $06
	ASL
	ADC.b $06
	ADC.w #$0089
	STA.b $06
	SEP.b #$20
	LDA.w $0B86
	DEC
	XBA
	LDA.w $0B85
	DEC
	JSR.w CODE_03849E
	STX.b $08
	LDY.w #$0000
CODE_0396B1:
	LDA.b $08
	CLC
	ADC.w DATA_039733,y
	TAX
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	CMP.w #$0084
	BEQ.b CODE_0396CE
	LDA.w #$0002
	JSR.w CODE_039035
	CLC
	ADC.b $06
	STA.l !RAM_SIMC_City_MapDataBuffer,x
CODE_0396CE:
	INY
	INY
	CPY.w #$0012
	BNE.b CODE_0396B1
CODE_0396D5:
	BRA.b CODE_039732

CODE_0396D7:
	BCC.b CODE_0396F3
	SEP.b #$20
	JSR.w CODE_039468
	XBA
	LDA.b $00
	SEC
	SBC.b #$18
	LSR
	LSR
	LSR
	JSR.w CODE_0398B8
	SEP.b #$20
	LDA.b #$F8
	JSR.w CODE_03961D
	BRA.b CODE_039732

CODE_0396F3:
	LDA.b #$FF
	JSR.w CODE_03961D
	SEP.b #$20
	LDA.w $0B86
	DEC
	XBA
	LDA.w $0B85
	DEC
	JSR.w CODE_03849E
	STX.b $08
	LDY.w #$0000
CODE_03970B:
	LDA.b $08
	CLC
	ADC.w DATA_039733,y
	TAX
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	CMP.w #$0089
	BCC.b CODE_03972B
	CMP.w #$0095
	BCS.b CODE_03972B
	TYA
	LSR
	ADC.w #$0080
	STA.l !RAM_SIMC_City_MapDataBuffer,x
	BRA.b CODE_039732

CODE_03972B:
	INY
	INY
	CPY.w #$0012
	BNE.b CODE_03970B
CODE_039732:
	RTS

DATA_039733:
	dw $0000,$0002,$0004,$00F0,$00F2,$00F4,$01E0,$01E2
	dw $01E4

CODE_039745:
	LDA.w #$01EB
	JMP.w CODE_039940

CODE_03974B:
	REP.b #$20
	LDA.w $0B89
	CMP.w #$039E
	BEQ.b CODE_039745
	CMP.w #$03B0
	BEQ.b CODE_039745
	CMP.w #$03A7
	BEQ.b CODE_039793
	CMP.w #$03B9
	BEQ.b CODE_039793
	REP.b #$20
	LDA.b $00
	CMP.w #$0002
	BCC.b CODE_039781
	JSR.w CODE_039468
	XBA
	LDA.b $00
	DEC
	DEC
	JSR.w CODE_0398DD
	SEP.b #$20
	LDA.b #$F8
	JSR.w CODE_03961D
	BRA.b CODE_039793

CODE_039781:
	CMP.w #$0001
	BNE.b CODE_039793
	LDA.w #$0137
	JSR.w CODE_039940
	SEP.b #$20
	LDA.b #$F8
	JSR.w CODE_03961D
CODE_039793:
	RTS

CODE_039794:
	REP.b #$20
	LDA.b $00
	CMP.w #$0002
	BCC.b CODE_0397B6
	JSR.w CODE_03907E
	AND.w #$0001
	SEP.b #$20
	XBA
	LDA.b $00
	DEC
	DEC
	JSR.w CODE_039906
	SEP.b #$20
	LDA.b #$F8
	JSR.w CODE_03961D
	BRA.b CODE_0397C8

CODE_0397B6:
	CMP.w #$0001
	BNE.b CODE_0397C8
	LDA.w #$01F4
	JSR.w CODE_039940
	SEP.b #$20
	LDA.b #$F8
	JSR.w CODE_03961D
CODE_0397C8:
	RTS

CODE_0397C9:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$000C
	TCD
	PLA
	STZ.b $02
	STZ.b $00
	LDY.w #$0001
CODE_0397DB:
	SEP.b #$20
	LDA.w $0B86
	CLC
	ADC.w DATA_039851,y
	XBA
	LDA.w $0B85
	CLC
	ADC.w DATA_039848,y
	PHY
	JSR.w CODE_03985A
	PLY
	CMP.b #$00
	BMI.b CODE_039808
	CMP.b $00
	BNE.b CODE_039802
	JSR.w CODE_03907E
	AND.b #$07
	BNE.b CODE_039808
	BEQ.b CODE_039806				; Note: This will always branch.

CODE_039802:
	BCC.b CODE_039808
	STA.b $00
CODE_039806:
	STY.b $02
CODE_039808:
	INY
	CPY.w #$0009
	BNE.b CODE_0397DB
	REP.b #$20
	LDX.b $02
	BEQ.b CODE_039846
	JSR.w CODE_039468
	REP.b #$20
	AND.w #$00FF
	STA.b $04
	ASL
	ADC.b $04
	STA.b $04
	LDA.w #$0002
	JSR.w CODE_039035
	CLC
	ADC.w #$0089
	ADC.b $04
	TAY
	LDX.b $02
	SEP.b #$20
	LDA.w $0B86
	CLC
	ADC.w DATA_039851,x
	XBA
	LDA.w $0B85
	CLC
	ADC.w DATA_039848,x
	JSR.w CODE_0384C4
CODE_039846:
	PLD
	RTS

DATA_039848:
	db $00,$FF,$00,$01,$FF,$01,$FF,$00,$01

DATA_039851:
	db $00,$FF,$FF,$FF,$00,$00,$01,$01,$01

CODE_03985A:
	REP.b #$20
	STA.b $06
	JSR.w CODE_03849E
	AND.w #$03FF
	BEQ.b CODE_039876
	CMP.w #$0080
	BCC.b CODE_039870
	CMP.w #$0089
	BCC.b CODE_039876
CODE_039870:
	SEP.b #$20
	LDA.b #$FF
	BRA.b CODE_0398AF

CODE_039876:
	SEP.b #$20
	LDA.b #$01
	STA.b $0A
	LDX.w #$0000
CODE_03987F:
	PHX
	LDA.b $06
	CLC
	ADC.w DATA_0398B4
	CMP.b #$64
	XBA
	LDA.b $06
	CLC
	ADC.w DATA_0398B0
	CMP.b #$78
	BCS.b CODE_0398A4
	JSR.w CODE_03849E
	REP.b #$20
	AND.w #$03FF
	CMP.w #$0060
	BCS.b CODE_0398A4
	SEP.b #$20
	INC.b $0A
CODE_0398A4:
	SEP.b #$20
	PLX
	INX
	CPX.w #$0004
	BNE.b CODE_03987F
	LDA.b $0A
CODE_0398AF:
	RTS

DATA_0398B0:
	db $00,$01,$00,$FF

DATA_0398B4:
	db $FF,$00,$01,$00

CODE_0398B8:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0002
	TCD
	PLA
	SEP.b #$30
	STA.b $00
	LDA.b #$00
	XBA
	ASL
	ASL
	ADC.b $00
	TAY
	LDA.w DATA_03992B,y
	REP.b #$30
	CLC
	ADC.w #$0095
	JSR.w CODE_039940
	PLD
	RTS

CODE_0398DD:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0004
	TCD
	PLA
	SEP.b #$30
	STA.b $00
	LDA.b #$00
	XBA
	STA.b $02
	ASL
	ASL
	ADC.b $02
	ADC.b $00
	TAY
	LDA.w DATA_03992B,y
	REP.b #$30
	CLC
	ADC.w #$0140
	JSR.w CODE_039940
	PLD
	RTS

CODE_039906:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0002
	TCD
	PLA
	SEP.b #$30
	STA.b $00
	LDA.b #$00
	XBA
	ASL
	ASL
	ADC.b $00
	TAY
	LDA.w DATA_03992B,y
	REP.b #$30
	CLC
	ADC.w #$01FD
	JSR.w CODE_039940
	PLD
	RTS

DATA_03992B:
	db $00,$09,$12,$1B,$24,$2D,$36,$3F,$48,$51,$5A,$63,$6C,$75,$7E,$87
	db $90,$99,$A2,$AB,$B4

CODE_039940:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0004
	TCD
	PLA
	REP.b #$30
	STA.b $02
	LDY.w #$0000
CODE_039952:
	SEP.b #$20
	LDA.w $0B86
	CLC
	ADC.w DATA_0399C9,y
	XBA
	LDA.w $0B85
	CLC
	ADC.w DATA_0399C0,y
	JSR.w CODE_03849E
	AND.w #$03FF
	CMP.w #$007F
	BEQ.b CODE_0399BE
	CMP.w #$0364
	BEQ.b CODE_0399BE
	CMP.w #$0365
	BEQ.b CODE_0399BE
	CMP.w #$0028
	BCC.b CODE_039982
	CMP.w #$0080
	BCC.b CODE_0399BE
CODE_039982:
	INY
	CPY.w #$0009
	BNE.b CODE_039952
	LDY.w #$0000
CODE_03998B:
	PHY
	SEP.b #$20
	LDA.w $0B86
	CLC
	ADC.w DATA_0399C9,y
	XBA
	LDA.w $0B85
	CLC
	ADC.w DATA_0399C0,y
	JSR.w CODE_03849E
	AND.w #$8000
	STA.b $00
	LDA.b $02
	CPY.w #$0008
	BNE.b CODE_0399AF
	ORA.w #$4000
CODE_0399AF:
	ORA.b $00
	STA.l !RAM_SIMC_City_MapDataBuffer,x
	INC.b $02
	PLY
	INY
	CPY.w #$0009
	BNE.b CODE_03998B
CODE_0399BE:
	PLD
	RTS

DATA_0399C0:
	db $FF,$00,$01,$FF,$00,$01,$FF,$00,$01

DATA_0399C9:
	db $FF,$FF,$FF,$00,$00,$00,$01,$01,$01

CODE_0399D2:
	LDY.w #$F448
	CMP.w #$0000
	BEQ.b CODE_039A0C
	SEP.b #$20
	LDA.w $0B86
	LSR
	XBA
	LDA.w $0B85
	LSR
	JSR.w CODE_03A29A
	LDA.l $7F6B00,x
	SEC
	SBC.l $7F8270,x
	BCS.b CODE_0399F5
	LDA.b #$00
CODE_0399F5:
	REP.b #$20
	AND.w #$00FF
	ASL
	ASL
	ASL
	ASL
	ASL
	CMP.w #$1770
	BCC.b CODE_039A07
	LDA.w #$1770
CODE_039A07:
	SEC
	SBC.w #$0BB8
	TAY
CODE_039A0C:
	TYA
	RTS

CODE_039A0E:
	LDY.w #$F448
	CMP.w #$0000
	BEQ.b CODE_039A30
	SEP.b #$20
	LDA.w $0B86
	LSR
	LSR
	LSR
	XBA
	LDA.w $0B85
	LSR
	LSR
	LSR
	JSR.w CODE_03A2D7
	REP.b #$20
	ASL
	TAX
	LDA.l $7FB47A,x
CODE_039A30:
	RTS

CODE_039A31:
	LDY.w #$FC18
	CMP.w #$0000
	BEQ.b CODE_039A3C
	LDY.w #$0000
CODE_039A3C:
	TYA
	RTS

CODE_039A3E:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0006
	TCD
	PLA
	STZ.b $00
	SEP.b #$20
	LDA.w $0B86
	DEC
	XBA
	LDA.w $0B85
	DEC
	JSR.w CODE_03849E
	REP.b #$20
	JSR.w CODE_039A93
	LDA.l $7F0202,x
	JSR.w CODE_039A93
	LDA.l $7F0204,x
	JSR.w CODE_039A93
	LDA.l $7F02F0,x
	JSR.w CODE_039A93
	LDA.l $7F02F4,x
	JSR.w CODE_039A93
	LDA.l $7F03E0,x
	JSR.w CODE_039A93
	LDA.l $7F03E2,x
	JSR.w CODE_039A93
	LDA.l $7F03E4,x
	JSR.w CODE_039A93
	LDA.b $00
	PLD
	RTS

CODE_039A93:
	AND.w #$03FF
	CMP.w #$0089
	BCC.b CODE_039AA2
	CMP.w #$0095
	BCS.b CODE_039AA2
	INC.b $00
CODE_039AA2:
	RTS

CODE_039AA3:
	JSR.w CODE_03A14D
	JSR.w CODE_03A14D
	JSR.w CODE_03A14D
	LDX.w #$0000
	LDY.w #$0000
CODE_039AB2:
	REP.b #$20
	LDA.l $7FB16E,x
	CMP.w #$0100
	BCC.b CODE_039AC0
	LDA.w #$00FF
CODE_039AC0:
	PHX
	TYX
	SEP.b #$20
	STA.l $7FB0AB,x
	PLX
	INX
	INX
	INY
	CPY.w #$00C3
	BNE.b CODE_039AB2
	LDA.b #$01
	STA.w $0CDD
	RTS

CODE_039AD7:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0014
	TCD
	PLA
	REP.b #$30
	JSR.w CODE_03A13B
	STZ.b $00
	STZ.b $02
	STZ.b $04
	STZ.b $06
	STZ.b $08
	STZ.b $0A
	STZ.b $12
CODE_039AF5:
	STZ.b $10
CODE_039AF7:
	SEP.b #$20
	LDA.b $12
	XBA
	LDA.b $10
	JSR.w CODE_03849E
	REP.b #$20
	AND.w #$03FF
	STA.w $0B89
	TAY
	LDA.w DATA_0384EB,y
	AND.w #$0001
	BEQ.b CODE_039B5A
	SEP.b #$20
	LDA.b $10
	STA.w $0B85
	LDA.b $12
	STA.w $0B86
	REP.b #$20
	JSR.w CODE_039BD5
	ASL
	ASL
	ASL
	CMP.w #$00FE
	BCC.b CODE_039B2E
	LDA.w #$00FE
CODE_039B2E:
	SEP.b #$20
	PHA
	LDA.b $12
	LSR
	XBA
	LDA.b $10
	LSR
	JSR.w CODE_03A29A
	PLA
	STA.l $7FB600,x
	REP.b #$20
	LDA.b $00
	CLC
	ADC.b $10
	STA.b $00
	BCC.b CODE_039B4D
	INC.b $02
CODE_039B4D:
	LDA.b $04
	CLC
	ADC.b $12
	STA.b $04
	BCC.b CODE_039B58
	INC.b $06
CODE_039B58:
	INC.b $08
CODE_039B5A:
	SEP.b #$20
	INC.b $10
	LDA.b $10
	CMP.b #$78
	BNE.b CODE_039AF7
	INC.b $12
	LDA.b $12
	CMP.b #$64
	BNE.b CODE_039AF5
	JSR.w CODE_03A02F
	JSR.w CODE_03A0B5
	JSR.w CODE_03A02F
	SEP.b #$20
	LDX.w #$0000
CODE_039B7A:
	LDA.l $7FC1B8,x
	ASL
	BCC.b CODE_039B83
	LDA.b #$FF
CODE_039B83:
	STA.l $7F8E28,x
	INX
	CPX.w #$0BB8
	BNE.b CODE_039B7A
	JSR.w CODE_03A24B
	LDA.b $08
	ORA.b $0A
	BEQ.b CODE_039BB4
	JSR.w CODE_03A421	: db $00,$08,$0C
	SEP.b #$20
	LDA.b $0C
	STA.w $0BA9
	REP.b #$20
	JSR.w CODE_03A421	: db $04,$08,$0C
	SEP.b #$20
	LDA.b $0C
	STA.w $0BAA
	BRA.b CODE_039BC0

CODE_039BB4:
	SEP.b #$20
	LDA.b #$3C
	STA.w $0BA9
	LDA.b #$32
	STA.w $0BAA
CODE_039BC0:
	LDA.w $0BA9
	LSR
	STA.w $0BAB
	LDA.w $0BAA
	LSR
	STA.w $0BAC
	LDA.b #$01
	STA.w $0CDE
	PLD
	RTS

CODE_039BD5:
	REP.b #$30
	LDA.w $0B89
	CMP.w #$0376
	BCC.b CODE_039BE3
	LDA.w #$0030
	RTS

CODE_039BE3:
	CMP.w #$0084
	BNE.b CODE_039BEB
	JMP.w CODE_039A3E

CODE_039BEB:
	CMP.w #$0137
	BCS.b CODE_039BF3
	JMP.w CODE_03842F

CODE_039BF3:
	CMP.w #$01F4
	BCS.b CODE_039C00
	JSR.w CODE_038456
	ASL
	ASL
	ASL
	BRA.b CODE_039C10

CODE_039C00:
	CMP.w #$0249
	BCS.b CODE_039C0D
	JSR.w CODE_03847A
	ASL
	ASL
	ASL
	BRA.b CODE_039C10

CODE_039C0D:
	LDA.w #$0000
CODE_039C10:
	RTS

CODE_039C11:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0024
	TCD
	PLA
	REP.b #$30
	LDX.w #$0000
	TXA
CODE_039C22:
	STA.l $7FCD70,x
	INX
	INX
	CPX.w #$02EE
	BNE.b CODE_039C22
	STZ.b $04
	STZ.b $06
	STZ.b $18
	STZ.b $1A
	SEP.b #$20
	STZ.b $0A
CODE_039C39:
	STZ.b $08
CODE_039C3B:
	JSR.w CODE_039CDF
	SEP.b #$20
	INC.b $08
	LDA.b $08
	CMP.b #$3C
	BNE.b CODE_039C3B
	INC.b $0A
	LDA.b $0A
	CMP.b #$32
	BNE.b CODE_039C39
	REP.b #$20
	LDA.b $18
	BEQ.b CODE_039C5E
	JSR.w CODE_03A421	: db $04,$18,$20
	LDA.b $20
CODE_039C5E:
	STA.w $0C03
	JSR.w CODE_03A02F
	JSR.w CODE_03A0B5
	STZ.b $1C
	STZ.b $14
	STZ.b $16
	STZ.b $00
	STZ.b $02
	REP.b #$20
	STZ.b $0A
CODE_039C75:
	STZ.b $08
CODE_039C77:
	SEP.b #$20
	LDA.b $0A
	XBA
	LDA.b $08
	JSR.w CODE_03A29A
	LDA.l $7FB600,x
	STA.l $7F8270,x
	STA.b $0C
	BEQ.b CODE_039CB0
	REP.b #$20
	INC.b $14
	LDA.b $00
	CLC
	ADC.b $0C
	STA.b $00
	BCC.b CODE_039C9C
	INC.b $02
CODE_039C9C:
	LDA.b $0C
	CMP.b $1C
	BCC.b CODE_039CB0
	STA.b $1C
	LDA.b $08
	LSR
	STA.w $0C09
	LDA.b $0A
	LSR
	STA.w $0C0B
CODE_039CB0:
	REP.b #$30
	INC.b $08
	LDA.b $08
	CMP.w #$003C
	BNE.b CODE_039C77
	INC.b $0A
	LDA.b $0A
	CMP.w #$0032
	BNE.b CODE_039C75
	LDA.b $14
	BEQ.b CODE_039CD0
	JSR.w CODE_03A421	: db $00,$14,$20
	LDA.b $20
CODE_039CD0:
	STA.w $0C07
	JSR.w CODE_039FA6
	SEP.b #$20
	LDA.b #$01
	STA.w $0CE0
	PLD
	RTS

CODE_039CDF:
	REP.b #$20
	STZ.b $22
	STZ.b $0E
	STZ.b $10
	SEP.b #$20
	LDA.b $0A
	ASL
	XBA
	LDA.b $08
	ASL
	JSR.w CODE_03849E
	JSR.w CODE_039DCA
	LDA.l $7F0202,x
	JSR.w CODE_039DCA
	LDA.l $7F02F0,x
	JSR.w CODE_039DCA
	LDA.l $7F02F2,x
	JSR.w CODE_039DCA
	LDA.b $22
	CMP.w #$00FF
	BCC.b CODE_039D15
	LDA.w #$00FF
CODE_039D15:
	STA.b $22
	SEP.b #$20
	LDA.b $0A
	LSR
	XBA
	LDA.b $08
	LSR
	JSR.w CODE_03A2B9
	LDA.l $7FCD70,x
	CLC
	ADC.b $22
	STA.l $7FCD70,x
	REP.b #$20
	LDA.b $0E
	CMP.w #$00FA
	BCC.b CODE_039D3A
	LDA.w #$00FA
CODE_039D3A:
	STA.b $0E
	SEP.b #$20
	LDA.b $0A
	XBA
	LDA.b $08
	JSR.w CODE_03A29A
	LDA.b $0E
	STA.l $7FB600,x
	PHX
	LDA.b $10
	BEQ.b CODE_039DC2
	LDA.b $0A
	XBA
	LDA.b $08
	JSR.w CODE_039E61
	STA.b $1E
	LDA.b #$22
	SEC
	SBC.b $1E
	ASL
	ASL
	STA.b $1E
	STZ.b $1F
	LDA.b $0A
	LSR
	XBA
	LDA.b $08
	LSR
	JSR.w CODE_03A2B9
	LDA.b $1E
	CLC
	ADC.l $7FAB74,x
	BCC.b CODE_039D7B
	INC.b $1F
CODE_039D7B:
	PLX
	SEC
	SBC.l $7F8270,x
	STA.b $1E
	BCS.b CODE_039D87
	DEC.b $1F
CODE_039D87:
	LDA.l $7F76B8,x
	CMP.b #$BE
	BCC.b CODE_039D9A
	LDA.b $1E
	SEC
	SBC.b #$14
	STA.b $1E
	BCS.b CODE_039D9A
	DEC.b $1F
CODE_039D9A:
	REP.b #$20
	LDA.b $1E
	BPL.b CODE_039DA5
	LDA.w #$0001
	BRA.b CODE_039DAD

CODE_039DA5:
	CMP.w #$00FA
	BCC.b CODE_039DAD
	LDA.w #$00FA
CODE_039DAD:
	SEP.b #$20
	STA.l $7F6B00,x
	REP.b #$20
	CLC
	ADC.b $04
	STA.b $04
	BCC.b CODE_039DBE
	INC.b $06
CODE_039DBE:
	INC.b $18
	BRA.b CODE_039DC9

CODE_039DC2:
	PLX
	LDA.b #$00
	STA.l $7F6B00,x
CODE_039DC9:
	RTS

CODE_039DCA:
	REP.b #$30
	AND.w #$03FF
	BEQ.b CODE_039E0B
	CMP.w #$0028
	BCS.b CODE_039DDF
	LDA.b $22
	ADC.w #$000F
	STA.b $22
	BRA.b CODE_039E0B

CODE_039DDF:
	CMP.w #$02BF
	BCC.b CODE_039DFA
	CMP.w #$0354
	BCS.b CODE_039DFA
	CMP.w #$0307
	BEQ.b CODE_039DFA
	CMP.w #$0310
	BEQ.b CODE_039DFA
	PHA
	LDA.w #$00FF
	STA.b $22
	PLA
CODE_039DFA:
	PHA
	JSR.w CODE_039E0C
	CLC
	ADC.b $0E
	STA.b $0E
	PLA
	CMP.w #$0030
	BCC.b CODE_039E0B
	INC.b $10
CODE_039E0B:
	RTS

CODE_039E0C:
	REP.b #$30
	LDY.w #$003C
	CMP.w #$007F
	BEQ.b CODE_039E5F
	LDY.w #$FFD8
	CMP.w #$0364
	BEQ.b CODE_039E5F
	CMP.w #$0060
	BCS.b CODE_039E35
	LDY.w #$0019
	CMP.w #$0050
	BCS.b CODE_039E5F
	LDY.w #$000A
	CMP.w #$0040
	BCS.b CODE_039E5F
	BRA.b CODE_039E5C

CODE_039E35:
	LDY.w #$0000
	CMP.w #$01FD
	BCC.b CODE_039E5F
	LDY.w #$0032
	CMP.w #$0245
	BCC.b CODE_039E5F
	LDY.w #$003C
	CMP.w #$0267
	BCC.b CODE_039E5C
	CMP.w #$0277
	BCC.b CODE_039E5F
	CMP.w #$0287
	BCC.b CODE_039E5C
	CMP.w #$02BA
	BCC.b CODE_039E5F
CODE_039E5C:
	LDY.w #$0000
CODE_039E5F:
	TYA
	RTS

CODE_039E61:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0001
	TCD
	PLA
	SEP.b #$20
	SEC
	SBC.w $0BAB
	BCS.b CODE_039E77
	EOR.b #$FF
	INC
CODE_039E77:
	STA.b $00
	XBA
	SEC
	SBC.w $0BAC
	BCS.b CODE_039E83
	EOR.b #$FF
	INC
CODE_039E83:
	CLC
	ADC.b $00
	CMP.b #$20
	BCC.b CODE_039E8C
	LDA.b #$20
CODE_039E8C:
	PLD
	RTS

CODE_039E8E:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0014
	TCD
	PLA
	JSR.w CODE_03A1CC
	JSR.w CODE_03A1CC
	JSR.w CODE_03A1CC
	REP.b #$20
	STZ.b $04
	STZ.b $06
	STZ.b $00
	STZ.b $02
	STZ.b $0A
CODE_039EAE:
	STZ.b $08
CODE_039EB0:
	SEP.b #$20
	LDA.b $0A
	XBA
	LDA.b $08
	JSR.w CODE_03A29A
	LDA.l $7F6B00,x
	BEQ.b CODE_039F3F
	REP.b #$20
	AND.w #$00FF
	STA.b $0C
	INC.b $00
	LDA.w #$0080
	SEC
	SBC.b $0C
	BCS.b CODE_039ED4
	LDA.w #$0000
CODE_039ED4:
	SEP.b #$20
	CLC
	ADC.l $7F8E28,x
	STA.b $0C
	BCC.b CODE_039EE1
	INC.b $0D
CODE_039EE1:
	REP.b #$20
	LDA.b $0C
	CLC
	ADC.w $0C71
	STA.b $0C
	LDA.b $0C
	BMI.b CODE_039EF9
	CMP.w #$012C
	BCC.b CODE_039EFE
	LDA.w #$012C
	BRA.b CODE_039EFC

CODE_039EF9:
	LDA.w #$0000
CODE_039EFC:
	STA.b $0C
CODE_039EFE:
	SEP.b #$20
	PHX
	LDA.b $0A
	LSR
	LSR
	XBA
	LDA.b $08
	LSR
	LSR
	JSR.w CODE_03A2D7
	REP.b #$20
	ASL
	TAX
	LDA.b $0C
	SEC
	SBC.l $7FB2F4,x
	STA.b $0C
	BCS.b CODE_039F21
	LDA.w #$0000
	BRA.b CODE_039F2B

CODE_039F21:
	LDA.b $0C
	CMP.w #$00FA
	BCC.b CODE_039F2B
	LDA.w #$00FA
CODE_039F2B:
	SEP.b #$20
	PLX
	STA.l $7F76B8,x
	REP.b #$20
	CLC
	ADC.b $04
	STA.b $04
	BCC.b CODE_039F47
	INC.b $06
	BRA.b CODE_039F47

CODE_039F3F:
	SEP.b #$20
	LDA.b #$00
	STA.l $7F76B8,x
CODE_039F47:
	REP.b #$20
	INC.b $08
	LDA.b $08
	CMP.w #$003C
	BEQ.b CODE_039F55
	JMP.w CODE_039EB0

CODE_039F55:
	INC.b $0A
	LDA.b $0A
	CMP.w #$0032
	BEQ.b CODE_039F61
	JMP.w CODE_039EAE

CODE_039F61:
	SEP.b #$20
	LDY.b $00
	BEQ.b CODE_039F74
	JSR.w CODE_03A421	: db $04,$00,$0E
	LDA.b $0E
	STA.w $0C01
	BRA.b CODE_039F77

CODE_039F74:
	STZ.w $0C01
CODE_039F77:
	LDX.w #$0000
	LDY.w #$0000
CODE_039F7D:
	REP.b #$20
	LDA.l $7FB2F4,x
	CMP.w #$0100
	BCC.b CODE_039F8B
	LDA.w #$00FF
CODE_039F8B:
	PHX
	TYX
	SEP.b #$20
	STA.l $7FAFE8,x
	PLX
	INX
	INX
	INY
	CPY.w #$00C3
	BNE.b CODE_039F7D
	LDA.b #$01
	STA.w $0CDF
	STA.w $0CDD
	PLD
	RTS

CODE_039FA6:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0006
	TCD
	PLA
	REP.b #$30
	STZ.b $02
CODE_039FB5:
	STZ.b $00
CODE_039FB7:
	SEP.b #$20
	LDA.b $02
	XBA
	LDA.b $00
	JSR.w CODE_03A2B9
	STZ.b $05
	LDA.b #$00
	LDY.b $00
	BEQ.b CODE_039FD2
	CLC
	ADC.l $7FCD6F,x
	BCC.b CODE_039FD2
	INC.b $05
CODE_039FD2:
	CPY.w #$001D
	BEQ.b CODE_039FE0
	CLC
	ADC.l $7FCD71,x
	BCC.b CODE_039FE0
	INC.b $05
CODE_039FE0:
	LDY.b $02
	BEQ.b CODE_039FED
	CLC
	ADC.l $7FCD52,x
	BCC.b CODE_039FED
	INC.b $05
CODE_039FED:
	CPY.w #$0018
	BEQ.b CODE_039FFB
	CLC
	ADC.l $7FCD8E,x
	BCC.b CODE_039FFB
	INC.b $05
CODE_039FFB:
	STA.b $04
	REP.b #$20
	LSR.b $04
	LSR.b $04
	SEP.b #$20
	LDA.b $04
	CLC
	ADC.l $7FCD70,x
	BCC.b CODE_03A010
	INC.b $05
CODE_03A010:
	STA.b $04
	REP.b #$20
	LDA.b $04
	LSR
	SEP.b #$20
	STA.l $7FAB74,x
	INC.b $00
	LDA.b $00
	CMP.b #$1E
	BNE.b CODE_039FB7
	INC.b $02
	LDA.b $02
	CMP.b #$19
	BNE.b CODE_039FB5
	PLD
	RTS

CODE_03A02F:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0006
	TCD
	PLA
	REP.b #$30
	STZ.b $02
CODE_03A03E:
	STZ.b $00
CODE_03A040:
	SEP.b #$20
	LDA.b $02
	XBA
	LDA.b $00
	JSR.w CODE_03A29A
	STZ.b $05
	LDA.b #$00
	LDY.b $00
	BEQ.b CODE_03A057
	CLC
	ADC.l $7FB5FF,x
CODE_03A057:
	CPY.w #$003B
	BEQ.b CODE_03A065
	CLC
	ADC.l $7FB601,x
	BCC.b CODE_03A065
	INC.b $05
CODE_03A065:
	LDY.b $02
	BEQ.b CODE_03A072
	CLC
	ADC.l $7FB5C4,x
	BCC.b CODE_03A072
	INC.b $05
CODE_03A072:
	CPY.w #$0031
	BEQ.b CODE_03A080
	CLC
	ADC.l $7FB63C,x
	BCC.b CODE_03A080
	INC.b $05
CODE_03A080:
	CLC
	ADC.l $7FB600,x
	BCC.b CODE_03A089
	INC.b $05
CODE_03A089:
	STA.b $04
	REP.b #$20
	LDA.b $04
	LSR
	LSR
	CMP.w #$00FA
	BCC.b CODE_03A099
	LDA.w #$00FA
CODE_03A099:
	SEP.b #$20
	STA.l $7FC1B8,x
	REP.b #$20
	INC.b $00
	LDA.b $00
	CMP.w #$003C
	BNE.b CODE_03A040
	INC.b $02
	LDA.b $02
	CMP.w #$0032
	BNE.b CODE_03A03E
	PLD
	RTS

CODE_03A0B5:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0006
	TCD
	PLA
	REP.b #$30
	STZ.b $02
CODE_03A0C4:
	STZ.b $00
CODE_03A0C6:
	SEP.b #$20
	LDA.b $02
	XBA
	LDA.b $00
	JSR.w CODE_03A29A
	STZ.b $05
	LDA.b #$00
	LDY.b $00
	BEQ.b CODE_03A0DD
	CLC
	ADC.l $7FC1B7,x
CODE_03A0DD:
	CPY.w #$003B
	BEQ.b CODE_03A0EB
	CLC
	ADC.l $7FC1B9,x
	BCC.b CODE_03A0EB
	INC.b $05
CODE_03A0EB:
	LDY.b $02
	BEQ.b CODE_03A0F8
	CLC
	ADC.l $7FC17C,x
	BCC.b CODE_03A0F8
	INC.b $05
CODE_03A0F8:
	CPY.w #$0031
	BEQ.b CODE_03A106
	CLC
	ADC.l $7FC1F4,x
	BCC.b CODE_03A106
	INC.b $05
CODE_03A106:
	CLC
	ADC.l $7FC1B8,x
	BCC.b CODE_03A10F
	INC.b $05
CODE_03A10F:
	STA.b $04
	REP.b #$20
	LDA.b $04
	LSR
	LSR
	CMP.w #$00FA
	BCC.b CODE_03A11F
	LDA.w #$00FA
CODE_03A11F:
	SEP.b #$20
	STA.l $7FB600,x
	REP.b #$20
	INC.b $00
	LDA.b $00
	CMP.w #$003C
	BNE.b CODE_03A0C6
	INC.b $02
	LDA.b $02
	CMP.w #$0032
	BNE.b CODE_03A0C4
	PLD
	RTS

CODE_03A13B:
	REP.b #$20
	LDX.w #$0000
	TXA
CODE_03A141:
	STA.l $7FB600,x
	INX
	INX
	CPX.w #$0BB8
	BNE.b CODE_03A141
	RTS

CODE_03A14D:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0004
	TCD
	PLA
	SEP.b #$20
	REP.b #$10
	STZ.b $01
	STZ.b $03
	STZ.b $02
CODE_03A162:
	STZ.b $00
CODE_03A164:
	LDA.b $02
	XBA
	LDA.b $00
	JSR.w CODE_03A2D7
	REP.b #$20
	ASL
	TAX
	LDA.w #$0000
	LDY.b $00
	BEQ.b CODE_03A17C
	CLC
	ADC.l $7FB16C,x
CODE_03A17C:
	CPY.w #$000E
	BEQ.b CODE_03A186
	CLC
	ADC.l $7FB170,x
CODE_03A186:
	LDY.b $02
	BEQ.b CODE_03A18F
	CLC
	ADC.l $7FB150,x
CODE_03A18F:
	CPY.w #$000C
	BEQ.b CODE_03A199
	CLC
	ADC.l $7FB18C,x
CODE_03A199:
	LSR
	LSR
	ADC.l $7FB16E,x
	LSR
	STA.l $7FD05E,x
	SEP.b #$20
	INC.b $00
	LDA.b $00
	CMP.b #$0F
	BNE.b CODE_03A164
	INC.b $02
	LDA.b $02
	CMP.b #$0D
	BNE.b CODE_03A162
	REP.b #$20
	LDX.w #$0000
CODE_03A1BB:
	LDA.l $7FD05E,x
	STA.l $7FB16E,x
	INX
	INX
	CPX.w #$0186
	BNE.b CODE_03A1BB
	PLD
	RTS

CODE_03A1CC:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0004
	TCD
	PLA
	SEP.b #$20
	REP.b #$10
	STZ.b $01
	STZ.b $03
	STZ.b $02
CODE_03A1E1:
	STZ.b $00
CODE_03A1E3:
	LDA.b $02
	XBA
	LDA.b $00
	JSR.w CODE_03A2D7
	REP.b #$20
	ASL
	TAX
	LDA.w #$0000
	LDY.b $00
	BEQ.b CODE_03A1FB
	CLC
	ADC.l $7FB2F2,x
CODE_03A1FB:
	CPY.w #$000E
	BEQ.b CODE_03A205
	CLC
	ADC.l $7FB2F6,x
CODE_03A205:
	LDY.b $02
	BEQ.b CODE_03A20E
	CLC
	ADC.l $7FB2D6,x
CODE_03A20E:
	CPY.w #$000C
	BEQ.b CODE_03A218
	CLC
	ADC.l $7FB312,x
CODE_03A218:
	LSR
	LSR
	ADC.l $7FB2F4,x
	LSR
	STA.l $7FD05E,x
	SEP.b #$20
	INC.b $00
	LDA.b $00
	CMP.b #$0F
	BNE.b CODE_03A1E3
	INC.b $02
	LDA.b $02
	CMP.b #$0D
	BNE.b CODE_03A1E1
	REP.b #$20
	LDX.w #$0000
CODE_03A23A:
	LDA.l $7FD05E,x
	STA.l $7FB2F4,x
	INX
	INX
	CPX.w #$0186
	BNE.b CODE_03A23A
	PLD
	RTS

CODE_03A24B:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$000E
	TCD
	PLA
	SEP.b #$20
	STZ.b $02
CODE_03A25A:
	STZ.b $00
CODE_03A25C:
	LDA.b $02
	ASL
	ASL
	XBA
	LDA.b $00
	ASL
	ASL
	JSR.w CODE_039E61
	STA.b $06
	STZ.b $07
	LDA.b $02
	XBA
	LDA.b $00
	JSR.w CODE_03A2D7
	REP.b #$20
	ASL
	TAX
	ASL.b $06
	ASL.b $06
	LDA.w #$0040
	SEC
	SBC.b $06
	STA.l $7FB47A,x
	SEP.b #$20
	INC.b $00
	LDA.b $00
	CMP.b #$0F
	BNE.b CODE_03A25C
	INC.b $02
	LDA.b $02
	CMP.b #$0D
	BNE.b CODE_03A25A
	PLD
	RTS

CODE_03A29A:
	STA.w $0B3F
	STZ.w $0B40
	LDA.b #$00
	XBA
	REP.b #$20
	STA.w $0B3D
	ASL
	ASL
	ASL
	ASL
	SEC
	SBC.w $0B3D
	ASL
	ASL
	ADC.w $0B3F
	TAX
	SEP.b #$20
	RTS

CODE_03A2B9:
	STA.w $0B3F
	STZ.w $0B40
	LDA.b #$00
	XBA
	REP.b #$20
	STA.w $0B3D
	ASL
	ASL
	ASL
	ASL
	SEC
	SBC.w $0B3D
	ASL
	ADC.w $0B3F
	TAX
	SEP.b #$20
	RTS

CODE_03A2D7:
	STA.w $0B3F
	STZ.w $0B40
	LDA.b #$00
	XBA
	REP.b #$20
	STA.w $0B3D
	ASL
	ASL
	ASL
	ASL
	SEC
	SBC.w $0B3D
	CLC
	ADC.w $0B3F
	TAX
	SEP.b #$20
	RTS

CODE_03A2F5:
	REP.b #$30
	PLA
	TAY
	CLC
	ADC.w #$0003
	PHA
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$000A
	TCD
	PLA
	LDA.w $0001,y
	AND.w #$00FF
	TAX
	LDA.b $0A,x
	STA.b $02
	LDA.w $0002,y
	AND.w #$00FF
	TAX
	LDA.b $0A,x
	STA.b $04
	LDA.w $0003,y
	AND.w #$00FF
	STA.b $00
	STZ.b $06
	STZ.b $08
	LDX.w #$0010
CODE_03A32E:
	ASL.b $06
	ROL.b $08
	ASL.b $04
	BCC.b CODE_03A341
	LDA.b $06
	CLC
	ADC.b $02
	STA.b $06
	BCC.b CODE_03A341
	INC.b $08
CODE_03A341:
	DEX
	BNE.b CODE_03A32E
	LDX.b $00
	LDA.b $06
	STA.b $0A,x
	LDA.b $08
	STA.b $0C,x
	PLD
	RTS

CODE_03A350:
	REP.b #$30
	PLA
	TAY
	CLC
	ADC.w #$0003
	PHA
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0014
	TCD
	PLA
	LDA.w $0001,y
	AND.w #$00FF
	TAX
	LDA.b $14,x
	STA.b $04
	LDA.b $16,x
	STA.b $06
	LDA.w $0002,y
	AND.w #$00FF
	TAX
	LDA.b $14,x
	STA.b $08
	LDA.b $16,x
	STA.b $0A
	LDA.w $0003,y
	AND.w #$00FF
	STA.b $00
	STZ.b $0C
	STZ.b $0E
	STZ.b $10
	STZ.b $12
	LDX.w #$0020
CODE_03A395:
	ASL.b $0C
	ROL.b $0E
	ROL.b $10
	ROL.b $12
	ASL.b $08
	ROL.b $0A
	BCC.b CODE_03A3B8
	LDA.b $0C
	CLC
	ADC.b $04
	STA.b $0C
	LDA.b $0E
	ADC.b $06
	STA.b $0E
	BCC.b CODE_03A3B8
	INC.b $10
	BNE.b CODE_03A3B8
	INC.b $12
CODE_03A3B8:
	DEX
	BNE.b CODE_03A395
	LDX.b $00
	LDA.b $0C
	STA.b $14,x
	LDA.b $0E
	STA.b $16,x
	LDA.b $10
	STA.b $18,x
	LDA.b $12
	STA.b $1A,x
	PLD
	RTS

CODE_03A3CF:
	REP.b #$30
	PLA
	TAY
	CLC
	ADC.w #$0003
	PHA
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0008
	TCD
	PLA
	LDA.w $0001,y
	AND.w #$00FF
	TAX
	LDA.b $08,x
	STA.b $02
	LDA.w $0002,y
	AND.w #$00FF
	TAX
	LDA.b $08,x
	STA.b $04
	LDA.w $0003,y
	AND.w #$00FF
	STA.b $00
	STZ.b $06
	LDY.w #$0010
CODE_03A406:
	ROL.b $02
	ROL.b $06
	LDA.b $06
	CMP.b $04
	BCC.b CODE_03A414
	SBC.b $04
	STA.b $06
CODE_03A414:
	DEY
	BNE.b CODE_03A406
	ROL.b $02
	LDX.b $00
	LDA.b $02
	STA.b $08,x
	PLD
	RTS

CODE_03A421:
	REP.b #$30
	PLA
	TAY
	CLC
	ADC.w #$0003
	PHA
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$000E
	TCD
	PLA
	LDA.w $0001,y
	AND.w #$00FF
	TAX
	LDA.b $0E,x
	STA.b $02
	LDA.b $10,x
	STA.b $04
	LDA.w $0002,y
	AND.w #$00FF
	TAX
	LDA.b $0E,x
	STA.b $06
	LDA.b $10,x
	STA.b $08
	LDA.w $0003,y
	AND.w #$00FF
	STA.b $00
	STZ.b $0A
	STZ.b $0C
	LDY.w #$0020
CODE_03A462:
	ROL.b $02
	ROL.b $04
	ROL.b $0A
	ROL.b $0C
	LDA.b $0A
	CMP.b $06
	LDA.b $0C
	SBC.b $08
	BCC.b CODE_03A480
	LDA.b $0A
	SBC.b $06
	STA.b $0A
	LDA.b $0C
	SBC.b $08
	STA.b $0C
CODE_03A480:
	DEY
	BNE.b CODE_03A462
	ROL.b $02
	ROL.b $04
	LDX.b $00
	LDA.b $02
	STA.b $0E,x
	LDA.b $04
	STA.b $10,x
	PLD
	RTS

CODE_03A493:
	REP.b #$30
	INC.w $0E15
	LDA.w $0B89
	CMP.w #$0080
	BCS.b CODE_03A4EC
	LDA.w $0BC5
	CMP.w #$001E
	BCS.b CODE_03A4E1
	JSR.w CODE_03907E
	AND.w #$01FF
	BNE.b CODE_03A4E1
	LDY.w $0B89
	LDA.w DATA_0384EB,y
	AND.w #$0010
	BNE.b CODE_03A4E1
	JSR.w CODE_03907E
	AND.w #$001F
	CMP.w $0BC5
	BCC.b CODE_03A4E1
	LDA.w $0B89
	AND.w #$000F
	CMP.w #$0002
	BCS.b CODE_03A4D6
	LDA.w #$0003
	BRA.b CODE_03A4D9

CODE_03A4D6:
	LDA.w #$0028
CODE_03A4D9:
	LDX.w $0B49
	STA.l !RAM_SIMC_City_MapDataBuffer,x
	RTS

CODE_03A4E1:
	LDA.w $0B89
	AND.w #$000F
	CMP.w #$0002
	BCS.b CODE_03A4FB
CODE_03A4EC:
	LDA.w $0E15
	CLC
	ADC.w #$0004
	STA.w $0E15
	JSR.w CODE_03A53B
	BNE.b CODE_03A53A
CODE_03A4FB:
	LDA.w $0B89
	CMP.w #$0080
	BCS.b CODE_03A53A
	SEP.b #$20
	LDA.w $0B86
	LSR
	XBA
	LDA.w $0B85
	LSR
	JSR.w CODE_03A29A
	LDY.w #$0030
	LDA.l $7F99E0,x
	CMP.b #$64
	BCC.b CODE_03A526
	LDY.w #$0040
	CMP.b #$C8
	BCC.b CODE_03A526
	LDY.w #$0050
CODE_03A526:
	STY.w $0B41
	REP.b #$20
	LDX.b $00
	LDA.w $0B87
	AND.w #$FF0F
	ORA.w $0B41
	STA.l $7F01FE,x
CODE_03A53A:
	RTS

CODE_03A53B:
	LDA.w $0B89
	CMP.w #$0355
	BNE.b CODE_03A589
	JSR.w CODE_03907E
	AND.w #$0003
	BNE.b CODE_03A585
	JSR.w CODE_03A70C
	CMP.w #$0015
	BCC.b CODE_03A585
	LDY.w #$0000
CODE_03A556:
	LDA.b $00
	CLC
	ADC.w DATA_03A6E2,y
	TAX
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	CMP.w DATA_03A6F0,y
	BNE.b CODE_03A585
	INY
	INY
	CPY.w #$000E
	BNE.b CODE_03A556
	LDY.w #$0000
CODE_03A570:
	LDA.b $00
	CLC
	ADC.w DATA_03A6E2,y
	TAX
	LDA.w DATA_03A6FE,y
	STA.l !RAM_SIMC_City_MapDataBuffer,x
	INY
	INY
	CPY.w #$000E
	BNE.b CODE_03A570
CODE_03A585:
	LDA.w #$0001
	RTS

CODE_03A589:
	CMP.w #$0354
	BNE.b CODE_03A5D6
	JSR.w CODE_03907E
	AND.w #$0003
	BNE.b CODE_03A585
	JSR.w CODE_03A70C
	CMP.w #$0015
	BCC.b CODE_03A585
	LDY.w #$0000
CODE_03A5A1:
	LDA.b $00
	CLC
	ADC.w DATA_03A6B8,y
	TAX
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	CMP.w DATA_03A6C6,y
	BNE.b CODE_03A585
	INY
	INY
	CPY.w #$000E
	BNE.b CODE_03A5A1
	LDY.w #$0000
CODE_03A5BB:
	LDA.b $00
	CLC
	ADC.w DATA_03A6B8,y
	TAX
	LDA.w DATA_03A6D4,y
	STA.l !RAM_SIMC_City_MapDataBuffer,x
	INY
	INY
	CPY.w #$000E
	BNE.b CODE_03A5BB
	BRA.b CODE_03A585

CODE_03A5D2:
	LDA.w #$0000
	RTS

CODE_03A5D6:
	REP.b #$30
	LDA.w $0B89
	CMP.w #$0080
	BCS.b CODE_03A5D2
	JSR.w CODE_03A70C
	CMP.w #$0012
	BCC.b CODE_03A5F0
	JSR.w CODE_03907E
	AND.w #$0007
	BNE.b CODE_03A5D2
CODE_03A5F0:
	LDA.w $0B85
	AND.w #$00FF
	CMP.w #$0002
	BCC.b CODE_03A5D2
	CMP.w #$0076
	BCS.b CODE_03A5D2
	LDA.w $0B86
	AND.w #$00FF
	CMP.w #$0002
	BCC.b CODE_03A5D2
	CMP.w #$0062
	BCS.b CODE_03A5D2
	LDA.w $0B89
	LSR
	BCC.b CODE_03A664
	LDX.b $00
	LDA.l $7F01FC,x
	AND.w #$03FF
	CMP.w #$0002
	BNE.b CODE_03A5D2
	LDY.w #$0000
CODE_03A627:
	LDA.b $00
	CLC
	ADC.w DATA_03A6E2,y
	TAX
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	AND.w #$000F
	STA.w $0B41
	LDA.w DATA_03A6FE,y
	AND.w #$000F
	CMP.w $0B41
	BNE.b CODE_03A5D2
	INY
	INY
	CPY.w #$000E
	BNE.b CODE_03A627
	LDY.w #$0000
CODE_03A64D:
	LDA.b $00
	CLC
	ADC.w DATA_03A6E2,y
	TAX
	LDA.w DATA_03A6F0,y
	STA.l !RAM_SIMC_City_MapDataBuffer,x
	INY
	INY
	CPY.w #$000E
	BNE.b CODE_03A64D
	BRA.b CODE_03A6B0

CODE_03A664:
	LDX.b $00
	LDA.l $7F010E,x
	AND.w #$03FF
	CMP.w #$0002
	BNE.b CODE_03A6B4
	LDY.w #$0000
CODE_03A675:
	LDA.b $00
	CLC
	ADC.w DATA_03A6B8,y
	TAX
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	AND.w #$000F
	STA.w $0B41
	LDA.w DATA_03A6D4,y
	AND.w #$000F
	CMP.w $0B41
	BNE.b CODE_03A6B4
	INY
	INY
	CPY.w #$000E
	BNE.b CODE_03A675
	LDY.w #$0000
CODE_03A69B:
	LDA.b $00
	CLC
	ADC.w DATA_03A6B8,y
	TAX
	LDA.w DATA_03A6C6,y
	STA.l !RAM_SIMC_City_MapDataBuffer,x
	INY
	INY
	CPY.w #$000E
	BNE.b CODE_03A69B
CODE_03A6B0:
	LDA.w #$0001
	RTS

CODE_03A6B4:
	LDA.w #$0000
	RTS

DATA_03A6B8:
	dw $FF0A,$FFFA,$FFFC,$FFFE,$0000,$0002,$FF12

DATA_03A6C6:
	dw $0356,$0357,$0001,$0354,$0001,$0359,$0358

DATA_03A6D4:
	dw $0001,$0030,$0030,$0030,$0030,$0030,$0001

DATA_03A6E2:
	dw $FE1C,$FE1E,$FF0E,$FFFE,$00EE,$01DE,$01DC

DATA_03A6F0:
	dw $035C,$035D,$0001,$0355,$0001,$035B,$035A

DATA_03A6FE:
	dw $0001,$0031,$0031,$0031,$0031,$0031,$0001

CODE_03A70C:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0002
	TCD
	PLA
	SEP.b #$20
	LDA.w $0A65
	SEC
	SBC.w $0B85
	BCS.b CODE_03A725
	EOR.b #$FF
	INC
CODE_03A725:
	STA.b $00
	LDA.w $0A63
	SEC
	SBC.w $0B86
	BCS.b CODE_03A733
	EOR.b #$FF
	INC
CODE_03A733:
	CLC
	ADC.b $00
	REP.b #$20
	AND.w #$00FF
	PLD
	RTS

CODE_03A73D:
	REP.b #$30
	INC.w $0E17
	LDA.w $0A93
	ORA.w $0C0F
	BNE.b CODE_03A74D
	JSR.w CODE_03A78B
CODE_03A74D:
	LDA.w $0BC5
	CMP.w #$001E
	BCS.b CODE_03A78A
	JSR.w CODE_03907E
	AND.w #$01FF
	BNE.b CODE_03A78A
	LDY.w $0B89
	LDA.w DATA_0384EB,y
	AND.w #$0010
	BNE.b CODE_03A78A
	JSR.w CODE_03907E
	AND.w #$001F
	CMP.w $0BC5
	BCC.b CODE_03A78A
	LDA.w $0B89
	CMP.w #$0072
	BCS.b CODE_03A780
	LDA.w #$0003
	BRA.b CODE_03A783

CODE_03A780:
	LDA.w #$0028
CODE_03A783:
	LDX.w $0B49
	STA.l !RAM_SIMC_City_MapDataBuffer,x
CODE_03A78A:
	RTS

CODE_03A78B:
	STZ.w $0ADD
	STZ.w $0ADF
	LDA.w $0B89
	CMP.w #$0072
	BNE.b CODE_03A7A1
	LDA.w #$0001
	STA.w $0ADD
	BRA.b CODE_03A7AC

CODE_03A7A1:
	CMP.w #$0073
	BNE.b CODE_03A7D9
	LDA.w #$0001
	STA.w $0ADF
CODE_03A7AC:
	LDA.w $0B85
	AND.w #$00FF
	ASL
	ASL
	ASL
	ADC.w #$0004
	STA.w $0AE1
	LDA.w $0B86
	AND.w #$00FF
	ASL
	ASL
	ASL
	ADC.w #$0004
	STA.w $0AE3
	LDA.w #$0001
	STA.w $0A93
	SEP.b #$20
	LDA.b #$0B
	STA.w $0006
	REP.b #$20
CODE_03A7D9:
	RTS

CODE_03A7DA:
	REP.b #$30
	INC.w $0E19
	RTS

CODE_03A7E0:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0008
	TCD
	PLA
	INC.w $0E01
	STZ.b $00
CODE_03A7F0:
	REP.b #$20
	JSR.w CODE_03907E
	AND.w #$0007
	BNE.b CODE_03A84C
	SEP.b #$20
	LDY.b $00
	LDA.w $0B86
	CLC
	ADC.w DATA_03A89B,y
	XBA
	LDA.w $0B85
	CLC
	ADC.w DATA_03A897,y
	REP.b #$20
	STA.b $04
	SEP.b #$20
	JSR.w CODE_03B420
	BEQ.b CODE_03A84C
	REP.b #$20
	LDA.b $04
	JSR.w CODE_03849E
	AND.w #$03FF
	TAY
	LDA.w DATA_0384EB,y
	AND.w #$0004
	BEQ.b CODE_03A84C
	LDA.w DATA_0384EB,y
	AND.w #$0001
	BEQ.b CODE_03A845
	LDX.w $0B85
	PHX
	LDX.b $04
	STX.w $0B85
	JSR.w CODE_03A89F
	PLX
	STX.w $0B85
	BRA.b CODE_03A84C

CODE_03A845:
	LDA.w #$007F
	STA.l !RAM_SIMC_City_MapDataBuffer,x
CODE_03A84C:
	REP.b #$20
	INC.b $00
	LDA.b $00
	CMP.w #$0004
	BNE.b CODE_03A7F0
	SEP.b #$20
	LDA.w $0B86
	LSR
	LSR
	LSR
	XBA
	LDA.w $0B85
	LSR
	LSR
	LSR
	JSR.w CODE_03A2D7
	SEP.b #$20
	LDY.w #$000A
	LDA.l $7FB0AB,x
	BEQ.b CODE_03A881
	LDY.w #$0003
	CMP.b #$14
	BCC.b CODE_03A881
	DEY
	CMP.b #$64
	BCC.b CODE_03A881
	DEY
CODE_03A881:
	REP.b #$20
	TYA
	JSR.w CODE_039035
	CMP.w #$0000
	BNE.b CODE_03A895
	LDY.w #$0028
	LDA.w $0B85
	JSR.w CODE_0384C4
CODE_03A895:
	PLD
	RTS

DATA_03A897:
	db $FF,$00,$01,$00

DATA_03A89B:
	db $00,$FF,$00,$01

CODE_03A89F:
	PHP
	SEP.b #$20
	LDA.b #$EC
	JSR.w CODE_03961D
	REP.b #$30
	LDA.w $0B85
	JSR.w CODE_03849E
	PHA
	LDA.l $7F02F2,x
	AND.w #$03FF
	STA.l $7F02F2,x
	PLA
	AND.w #$03FF
	CMP.w #$02A5
	BNE.b CODE_03A8DF
	TXA
	SEC
	SBC.w #$01E4
	STA.w $0B41
	LDY.w #$0046
CODE_03A8CF:
	LDA.w $0B41
	CLC
	ADC.w DATA_03A92D,y
	JSR.w CODE_03A9A7
	DEY
	DEY
	BPL.b CODE_03A8CF
	BRA.b CODE_03A922

CODE_03A8DF:
	CMP.w #$036B
	BEQ.b CODE_03A8EE
	CMP.w #$0257
	BCC.b CODE_03A909
	CMP.w #$0297
	BCS.b CODE_03A909
CODE_03A8EE:
	TXA
	SEC
	SBC.w #$00F2
	STA.w $0B41
	LDY.w #$001E
CODE_03A8F9:
	LDA.w $0B41
	CLC
	ADC.w DATA_03A975,y
	JSR.w CODE_03A9A7
	DEY
	DEY
	BPL.b CODE_03A8F9
	BRA.b CODE_03A922

CODE_03A909:
	TXA
	SEC
	SBC.w #$00F2
	STA.w $0B41
	LDY.w #$0010
CODE_03A914:
	LDA.w $0B41
	CLC
	ADC.w DATA_03A995,y
	JSR.w CODE_03A9A7
	DEY
	DEY
	BPL.b CODE_03A914
CODE_03A922:
	SEP.b #$20
	LDA.b #$03
	STA.w $0006
	REP.b #$20
	PLP
	RTS

DATA_03A92D:
	dw $0000,$0002,$0004,$0006,$0008,$000A,$00F0,$00F2
	dw $00F4,$00F6,$00F8,$00FA,$01B8,$01BA,$01BC,$01BE
	dw $01C0,$01C2,$02D0,$02D2,$02D4,$02D6,$02D8,$02DA
	dw $03C0,$03C2,$03C4,$03C6,$03C8,$03CA,$04B0,$04B2
	dw $04B4,$04B6,$04B8,$04BA

DATA_03A975:
	dw $0000,$0002,$0004,$0006,$00F0,$00F2,$00F4,$00F6
	dw $01E0,$01E2,$01E4,$01E6,$02D0,$02D2,$02D4,$02D6

DATA_03A995:
	dw $0000,$0002,$0004,$00F0,$00F2,$00F4,$01E0,$01E2
	dw $01E4

CODE_03A9A7:
	TAX
	PHY
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	AND.w #$03FF
	TAY
	LDA.w DATA_0384EB,y
	AND.w #$0004
	BEQ.b CODE_03A9C0
	LDA.w #$007F
	STA.l !RAM_SIMC_City_MapDataBuffer,x
CODE_03A9C0:
	PLY
CODE_03A9C1:
	RTS

CODE_03A9C2:
	JSR.w CODE_03A9C6
	RTL

CODE_03A9C6:
	SEP.b #$20
	CMP.b #$78
	BCS.b CODE_03A9C1
	XBA
	CMP.b #$64
	BCS.b CODE_03A9C1
	XBA
	PHB
	REP.b #$30
	PHA
	SEP.b #$20
	LDA.b #DATA_039733>>16
	PHA
	PLB
	REP.b #$30
	PLA
	LDX.w $0B41
	PHX
	LDX.w $0B3D
	PHX
	LDX.w $0B3F
	PHX
	LDX.w $0B85
	PHX
	PHA
	STA.w $0B85
	JSR.w CODE_03849E
	AND.w #$03FF
	TXY
	TAX
	PLA
	STA.w $0B3D
	CPX.w #$0000
	BEQ.b CODE_03AA6E
	CPX.w #$0014
	BCC.b CODE_03AA73
	LDA.w DATA_0384EB,x
	AND.w #$0008
	LSR
	LSR
	LSR
	PHA
	BEQ.b CODE_03AA1A
	LDA.w #$0003
	BRA.b CODE_03AA55

CODE_03AA1A:
	LDA.w DATA_0384EB,x
	AND.w #$0004
	BEQ.b CODE_03AA78
	LDA.w DATA_0384EB,x
	AND.w #$0001
	BEQ.b CODE_03AA42
	LDA.w $0B3D
	PHA
	JSR.w CODE_03A89F
	PLA
	STA.w $0B3D
	LDA.w $0AEF
	BNE.b CODE_03AA78
	LDA.w #$0001
	STA.w $03FE
	BRA.b CODE_03AA5A

CODE_03AA42:
	REP.b #$20
	JSL.l CODE_00824B
	AND.w #$0003
	BNE.b CODE_03AA52
	LDA.w #$007F
	BRA.b CODE_03AA55

CODE_03AA52:
	LDA.w #$0028
CODE_03AA55:
	TYX
	STA.l !RAM_SIMC_City_MapDataBuffer,x
CODE_03AA5A:
	LDA.w $0B3D
	AND.w #$00FF
	STA.w $0400
	LDA.w $0B3E
	AND.w #$00FF
	STA.w $0402
	BRA.b CODE_03AA78

CODE_03AA6E:
	LDA.w #$0000
	BRA.b CODE_03AA79

CODE_03AA73:
	LDA.w #$0001
	BRA.b CODE_03AA79

CODE_03AA78:
	PLA
CODE_03AA79:
	PLX
	STX.w $0B85
	PLX
	STX.w $0B3F
	PLX
	STX.w $0B3D
	PLX
	STX.w $0B41
	PLB
	RTS

CODE_03AA8B:
	REP.b #$30
	LDA.w #$0FA0
	JSR.w CODE_039035
	BNE.b CODE_03AA9E
	LDX.b $00
	LDA.w #$0000
	STA.l !RAM_SIMC_City_MapDataBuffer,x
CODE_03AA9E:
	RTS

CODE_03AA9F:
	REP.b #$30
	INC.w $0E1F
	LDA.w $0B89
	CMP.w #$028C
	BNE.b CODE_03AAB9
	INC.w $0E0D
	LDY.w #$0004
	JSR.w CODE_03AEA1
	JSR.w CODE_03B0BE
	RTS

CODE_03AAB9:
	CMP.w #$027C
	BNE.b CODE_03AAE1
	LDA.w !RAM_SIMC_City_DifficultyLevel
	ASL
	TAY
	LDA.w DATA_03ABF6,y
	JSR.w CODE_039035
	CMP.w #$0000
	BNE.b CODE_03AAD4				; Note: NOP this out and nuclear power plants will meltdown shortly after being placed.
	LDA.w $0B85
	JMP.w CODE_03BD61

CODE_03AAD4:
	INC.w $0E0F
	LDY.w #$0004
	JSR.w CODE_03AEA1
	JSR.w CODE_03B0BE
	RTS

CODE_03AAE1:
	CMP.w #$0310
	BEQ.b CODE_03AAEB
	CMP.w #$0252
	BNE.b CODE_03AB3A
CODE_03AAEB:
	INC.w !RAM_SIMC_City_FireStationCountLo
	LDY.w #$0003
	JSR.w CODE_03AEA1
	LDA.w $0B85
	PHA
	SEP.b #$20
	LDA.w $0B86
	LSR
	LSR
	LSR
	XBA
	LDA.w $0B85
	LSR
	LSR
	LSR
	JSR.w CODE_03A2D7
	REP.b #$20
	ASL
	PHA
	LDA.w $0BC9
	LDY.w $0B89
	CPY.w #$0310
	BNE.b CODE_03AB1A
	ASL
CODE_03AB1A:
	LDY.w $0B87
	BMI.b CODE_03AB20
	LSR
CODE_03AB20:
	PHA
	JSR.w CODE_03B26B
	BNE.b CODE_03AB2A
	PLA
	LSR
	BRA.b CODE_03AB2B

CODE_03AB2A:
	PLA
CODE_03AB2B:
	CLC
	PLX
	ADC.l $7FB16E,x
	STA.l $7FB16E,x
	PLA
	STA.w $0B85
	RTS

CODE_03AB3A:
	CMP.w #$0307
	BEQ.b CODE_03AB44
	CMP.w #$0249
	BNE.b CODE_03AB93
CODE_03AB44:
	INC.w !RAM_SIMC_City_PoliceStationCountLo
	LDY.w #$0003
	JSR.w CODE_03AEA1
	LDA.w $0B85
	PHA
	SEP.b #$20
	LDA.w $0B86
	LSR
	LSR
	LSR
	XBA
	LDA.w $0B85
	LSR
	LSR
	LSR
	JSR.w CODE_03A2D7
	REP.b #$20
	ASL
	PHA
	LDA.w $0BC7
	LDY.w $0B89
	CPY.w #$0307
	BNE.b CODE_03AB73
	ASL
CODE_03AB73:
	LDY.w $0B87
	BMI.b CODE_03AB79
	LSR
CODE_03AB79:
	PHA
	JSR.w CODE_03B26B
	BNE.b CODE_03AB83
	PLA
	LSR
	BRA.b CODE_03AB84

CODE_03AB83:
	PLA
CODE_03AB84:
	CLC
	PLX
	ADC.l $7FB2F4,x
	STA.l $7FB2F4,x
	PLA
	STA.w $0B85
	RTS

CODE_03AB93:
	CMP.w #$025C
	BEQ.b CODE_03AB9D
	CMP.w #$036B
	BNE.b CODE_03ABA7
CODE_03AB9D:
	INC.w $0E0B
	LDY.w #$0004
	JSR.w CODE_03AEA1
	RTS

CODE_03ABA7:
	CMP.w #$02A5
	BNE.b CODE_03ABDA
	INC.w $0E13
	LDY.w #$0006
	JSR.w CODE_03AEA1
	LDA.w $0B87
	BPL.b CODE_03ABF5
	LDA.w $0A8D
	BNE.b CODE_03ABCA
	JSR.w CODE_03907E
	AND.w #$0003
	BNE.b CODE_03ABF5
	JMP.w CODE_03ABFC

CODE_03ABCA:
	LDA.w $0A8F
	BNE.b CODE_03ABF5
	JSR.w CODE_03907E
	AND.w #$0007
	BNE.b CODE_03ABF5
	JMP.w CODE_03AC32

CODE_03ABDA:
	CMP.w #$026C
	BNE.b CODE_03ABF5
	INC.w $0E11
	LDY.w #$0004
	JSR.w CODE_03AEA1
	LDA.w $0B87
	BPL.b CODE_03ABF5
	LDA.w $0A95
	BNE.b CODE_03ABF5
	JSR.w CODE_03AC5B
CODE_03ABF5:
	RTS

DATA_03ABF6:
	dw $AFC8,$7530,$3A98

CODE_03ABFC:
	SEP.b #$20
	LDA.b #$0C
	STA.w $0006
	REP.b #$20
	INC.w $0ACB
	INC.w $0A8D
	LDA.w #$0006
	STA.w $0A9F
	LDA.w $0B85
	AND.w #$00FF
	DEC
	STA.w $0AAD
	CLC
	ADC.w #$0003
	STA.w $0A61
	STZ.w $0A7D
	LDA.w $0B86
	AND.w #$00FF
	STA.w $0A5F
	STA.w $0AAB
	RTS

CODE_03AC32:
	REP.b #$20
	LDA.w #$0001
	STA.w $0A8F
	LDA.w #$8000
	STA.w $0A9B
	LDA.w $0B85
	AND.w #$00FF
	INC
	STA.w $0A5D
	STA.w $0AA9
	LDA.w $0B86
	AND.w #$00FF
	INC
	STA.w $0A5B
	STA.w $0AA7
	RTS

CODE_03AC5B:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0008
	TCD
	PLA
	JSR.w CODE_039035
	AND.w #$0003
	BNE.b CODE_03AC92
	LDA.w #$0004
	STA.b $00
	STZ.b $04
	LDY.w #$0004
	LDX.w #$0008
CODE_03AC7B:
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	AND.w #$03FF
	CMP.w #$0002
	BEQ.b CODE_03ACB1
	INX
	INX
	INC.b $00
	LDA.b $00
	CMP.w #$0076
	BNE.b CODE_03AC7B
CODE_03AC92:
	JSR.w CODE_039035
	AND.w #$0003
	BNE.b CODE_03ACC2
	LDA.w #$0004
	STA.b $04
	STZ.b $00
	LDY.w #$0002
	LDX.w #$0008
CODE_03ACA7:
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	AND.w #$03FF
	CMP.w #$0002
CODE_03ACB1:
	BEQ.b CODE_03AD24
	TXA
	CLC
	ADC.w #$00F0
	TAX
	INC.b $04
	LDA.b $04
	CMP.w #$0062
	BNE.b CODE_03ACA7
CODE_03ACC2:
	JSR.w CODE_039035
	AND.w #$0003
	BNE.b CODE_03ACF1
	LDA.w #$0004
	STA.b $00
	LDA.w #$0063
	STA.b $04
	LDY.w #$0000
	LDX.w #$5CD8
CODE_03ACDA:
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	AND.w #$03FF
	CMP.w #$0002
	BEQ.b CODE_03AD24
	INX
	INX
	INC.b $00
	LDA.b $00
	CMP.w #$0076
	BNE.b CODE_03ACDA
CODE_03ACF1:
	JSR.w CODE_039035
	AND.w #$0003
	BNE.b CODE_03AD3D
	LDA.w #$0004
	STA.b $04
	LDA.w #$0077
	STA.b $00
	LDY.w #$0006
	LDX.w #$04AE
CODE_03AD09:
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	AND.w #$03FF
	CMP.w #$0002
	BEQ.b CODE_03AD24
	TXA
	CLC
	ADC.w #$00F0
	TAX
	INC.b $04
	LDA.b $04
	CMP.w #$0062
	BNE.b CODE_03AD09
CODE_03AD24:
	STY.w $0B0B
	LDA.b $00
	STA.w $0A65
	LDA.b $04
	STA.w $0A63
	LDA.w #$8000
	STA.w $0A95
	LDA.w #$0064
	STA.w $0B0F
CODE_03AD3D:
	PLD
	RTS

CODE_03AD3F:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0008
	TCD
	PLA
	LDA.w $0C11
	BEQ.b CODE_03ADC4
	DEC.w $0C11
	STZ.b $00
CODE_03AD54:
	REP.b #$20
	JSR.w CODE_03907E
	AND.w #$0003
	BNE.b CODE_03ADB7
	SEP.b #$20
	LDY.b $00
	LDA.w $0B86
	CLC
	ADC.w DATA_03ADDB,y
	XBA
	LDA.w $0B85
	CLC
	ADC.w DATA_03ADD7,y
	REP.b #$20
	STA.b $04
	SEP.b #$20
	JSR.w CODE_03B420
	BEQ.b CODE_03ADB7
	REP.b #$20
	LDA.b $04
	JSR.w CODE_03849E
	AND.w #$03FF
	BEQ.b CODE_03ADB0
	CMP.w #$0365
	BEQ.b CODE_03ADB7
	TAY
	LDA.w DATA_0384EB,y
	AND.w #$0004
	BEQ.b CODE_03ADB7
	LDA.w DATA_0384EB,y
	AND.w #$0001
	BEQ.b CODE_03ADB0
	LDX.w $0B85
	PHX
	LDX.b $04
	STX.w $0B85
	JSR.w CODE_03A89F
	PLX
	STX.w $0B85
	BRA.b CODE_03ADB7

CODE_03ADB0:
	LDA.w #$0365
	STA.l !RAM_SIMC_City_MapDataBuffer,x
CODE_03ADB7:
	REP.b #$20
	INC.b $00
	LDA.b $00
	CMP.w #$0004
	BNE.b CODE_03AD54
	BRA.b CODE_03ADD5

CODE_03ADC4:
	JSR.w CODE_03907E
	AND.w #$0007
	BNE.b CODE_03ADD5
	LDY.w #$0000
	LDA.w $0B85
	JSR.w CODE_0384C4
CODE_03ADD5:
	PLD
	RTS

DATA_03ADD7:
	db $00,$01,$00,$FF

DATA_03ADDB:
	db $FF,$00,$01,$00

CODE_03ADDF:
	PHP
	REP.b #$30
CODE_03ADE2:
	LDA.w $023D
	BEQ.b CODE_03AE23
	LDX.w #$0000
	STZ.w $023D
	TXY
CODE_03ADEE:
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	AND.w #$03FF
	CMP.w #$002A
	BCC.b CODE_03AE15
	CMP.w #$002D
	BEQ.b CODE_03AE04
	BCS.b CODE_03AE15
	INC
	BRA.b CODE_03AE0E

CODE_03AE04:
	JSR.w CODE_03907E
	AND.w #$0001
	CLC
	ADC.w #$0028
CODE_03AE0E:
	STA.l !RAM_SIMC_City_MapDataBuffer,x
	INC.w $023D
CODE_03AE15:
	INX
	INX
	CPX.w #$5DC0
	BNE.b CODE_03ADEE
CODE_03AE1C:
	LDA.w $01B3
	BNE.b CODE_03AE1C
	BRA.b CODE_03ADE2

CODE_03AE23:
	PLP
	RTS

CODE_03AE25:
	REP.b #$30
	INC.w $0CA1
	LDY.w #$0003
	JSR.w CODE_03AEA1
	LDA.w $0CC9
	BEQ.b CODE_03AE51
	LDA.w $0B89
	CMP.w #$02BF
	BEQ.b CODE_03AE47
	CMP.w #$02C8
	BEQ.b CODE_03AE47
	CMP.w #$02D1
	BNE.b CODE_03AE51
CODE_03AE47:
	CLC
	ADC.w #$0005
	JSR.w CODE_039940
	STZ.w $0CC9
CODE_03AE51:
	LDA.w $0B89
	CMP.w #$02E3
	BNE.b CODE_03AE5C
	INC.w $0CA3
CODE_03AE5C:
	CMP.w #$02FE
	BNE.b CODE_03AE64
	INC.w $0C71
CODE_03AE64:
	LDY.w #$012C
	CMP.w #$02FE
	BEQ.b CODE_03AE98
	LDY.w #$00C8
	CMP.w #$02EC
	BEQ.b CODE_03AE98
	LDY.w #$0064
	CMP.w #$02F5
	BEQ.b CODE_03AE98
	CMP.w #$034F
	BEQ.b CODE_03AE98
	CMP.w #$033D
	BEQ.b CODE_03AE98
	CMP.w #$0334
	BEQ.b CODE_03AE98
	CMP.w #$032B
	BEQ.b CODE_03AE98
	CMP.w #$0319
	BEQ.b CODE_03AE98
	LDY.w #$0000
CODE_03AE98:
	TYA
	CLC
	ADC.w $0DDD
	STA.w $0DDD
	RTS

CODE_03AEA1:
	REP.b #$30
	LDA.w $0B51
	AND.w #$0007
	BEQ.b CODE_03AEAC
	RTS

CODE_03AEAC:
	LDX.b $00
	CPY.w #$0003
	BEQ.b CODE_03AF08
	CPY.w #$0004
	BEQ.b CODE_03AEE0
	LDY.w #$0000
CODE_03AEBB:
	LDA.w DATA_03AF30,y
	BMI.b CODE_03AF2F
	CLC
	ADC.b $00
	TAX
	LDA.l $7F001A,x
	AND.w #$03FF
	BNE.b CODE_03AEDB
	TYA
	LSR
	CLC
	ADC.w $0B87
	SEC
	SBC.w #$000E
	STA.l $7F001A,x
CODE_03AEDB:
	INY
	INY
	BRA.b CODE_03AEBB

CODE_03AEDF:
	RTS

CODE_03AEE0:
	LDY.w #$0000
CODE_03AEE3:
	LDA.w DATA_03AF7A,y
	BMI.b CODE_03AF2F
	CLC
	ADC.b $00
	TAX
	LDA.l $7F010C,x
	AND.w #$03FF
	BNE.b CODE_03AF03
	TYA
	LSR
	CLC
	ADC.w $0B87
	SEC
	SBC.w #$0005
	STA.l $7F010C,x
CODE_03AF03:
	INY
	INY
	BRA.b CODE_03AEE3

CODE_03AF07:
	RTS

CODE_03AF08:
	LDY.w #$0000
CODE_03AF0B:
	LDA.w DATA_03AF9C,y
	BMI.b CODE_03AF2F
	CLC
	ADC.b $00
	TAX
	LDA.l $7F010C,x
	AND.w #$03FF
	BNE.b CODE_03AF2B
	TYA
	LSR
	CLC
	ADC.w $0B87
	SEC
	SBC.w #$0004
	STA.l $7F010C,x
CODE_03AF2B:
	INY
	INY
	BRA.b CODE_03AF0B

CODE_03AF2F:
	RTS

DATA_03AF30:
	dw $0000,$0002,$0004,$0006,$0008,$000A,$00F0,$00F2
	dw $00F4,$00F6,$00F8,$00FA,$01E0,$01E2,$01E4,$01E6
	dw $01E8,$01EA,$02D0,$02D2,$02D4,$02D6,$02D8,$02DA
	dw $03C0,$03C2,$03C4,$03C6,$03C8,$03CA,$04B0,$04B2
	dw $04B4,$04B6,$04B8,$04BA,$FFFF

DATA_03AF7A:
	dw $0000,$0002,$0004,$0006,$00F0,$00F2,$00F4,$00F6
	dw $01E0,$01E2,$01E4,$01E6,$02D0,$02D2,$02D4,$02D6
	dw $FFFF

DATA_03AF9C:
	dw $0000,$0002,$0004,$00F0,$00F2,$00F4,$01E0,$01E2
	dw $01E4,$FFFF

CODE_03AFB0:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0018
	TCD
	PLA
	REP.b #$30
	LDX.w #$0000
	TXA
CODE_03AFC1:
	STA.l $7FA598,x
	INX
	INX
	CPX.w #$05DC
	BNE.b CODE_03AFC1
	LDA.w $0E0D
	STA.b $06
	LDA.w #$02BC
	STA.b $0A
	JSR.w CODE_03A2F5	: db $06,$0A,$0E
	LDA.w $0E0F
	STA.b $06
	LDA.w #$07D0
	STA.b $0A
	JSR.w CODE_03A2F5	: db $06,$0A,$06
	LDA.b $0E
	CLC
	ADC.b $06
	STA.b $0E
	LDA.b $10
	ADC.b $08
	STA.b $10
	STZ.b $12
	STZ.b $14
CODE_03AFFD:
	LDA.w $0C57
	CMP.w $0C59
	BEQ.b CODE_03B06A
	JSR.w CODE_03B0A3
	LDA.w #$0004
	STA.b $00
CODE_03B00D:
	INC.b $12
	BNE.b CODE_03B013
	INC.b $14
CODE_03B013:
	LDA.b $0E
	CMP.b $12
	LDA.b $10
	SBC.b $14
	BCS.b CODE_03B031
	LDA.w #$001A
	STA.w $0381
	LDA.w #$0001
	STA.w $0383
	LDA.w #$012C
	STA.w $038B
	BRA.b CODE_03B06A

CODE_03B031:
	LDA.b $00
	JSR.w CODE_038FF4
	JSR.w CODE_03B0E5
	STZ.b $02
	STZ.b $04
CODE_03B03D:
	LDA.b $02
	CMP.w #$0002
	BCS.b CODE_03B05A
	LDA.b $04
	CMP.w #$0004
	BCS.b CODE_03B05A
	JSR.w CODE_03B06C
	BEQ.b CODE_03B056
	INC.b $02
	LDA.b $04
	STA.b $00
CODE_03B056:
	INC.b $04
	BRA.b CODE_03B03D

CODE_03B05A:
	LDA.b $02
	CMP.w #$0002
	BCC.b CODE_03B064
	JSR.w CODE_03B0BE
CODE_03B064:
	LDA.b $02
	BNE.b CODE_03B00D
	BRA.b CODE_03AFFD

CODE_03B06A:
	PLD
	RTS

CODE_03B06C:
	LDX.w $0B85
	STX.b $16
	JSR.w CODE_038FF4
	BEQ.b CODE_03B09A
	JSR.w CODE_03B0F8
	CPY.w #$0000
	BNE.b CODE_03B09A
	LDA.w $0B85
	JSR.w CODE_03849E
	AND.w #$03FF
	TAX
	SEP.b #$20
	LDA.w DATA_0384EB,x
	REP.b #$20
	BPL.b CODE_03B09A
	LDA.b $16
	STA.w $0B85
	LDA.w #$0001
	RTS

CODE_03B09A:
	LDA.b $16
	STA.w $0B85
	LDA.w #$0000
	RTS

CODE_03B0A3:
	LDX.w $0C57
	BEQ.b CODE_03B0BD
	SEP.b #$20
	LDA.l $7FD1E4,x
	STA.w $0B85
	LDA.l $7FE56C,x
	STA.w $0B86
	REP.b #$20
	DEC.w $0C57
CODE_03B0BD:
	RTS

CODE_03B0BE:
	LDX.w $0C57
	CPX.w #$1388
	BCS.b CODE_03B0DC
	INX
	SEP.b #$20
	LDA.w $0B85
	STA.l $7FD1E4,x
	LDA.w $0B86
	STA.l $7FE56C,x
	REP.b #$20
	STX.w $0C57
CODE_03B0DC:
	RTS

DATA_03B0DD:
	db $80,$40,$20,$10,$08,$04,$02,$01

CODE_03B0E5:
	JSR.w CODE_03B120
	SEP.b #$20
	LDA.l $7FA598,x
	ORA.w DATA_03B0DD,y
	STA.l $7FA598,x
	REP.b #$20
	RTS

CODE_03B0F8:
	LDY.w #$0001
	LDA.w $0B89
	CMP.w #$027C
	BEQ.b CODE_03B11F
	CMP.w #$028C
	BEQ.b CODE_03B11F
	JSR.w CODE_03B120
	CPX.w #$05DC
	BCS.b CODE_03B11F
	SEP.b #$20
	LDA.l $7FA598,x
	AND.w DATA_03B0DD,y
	REP.b #$20
	AND.w #$00FF
	TAY
CODE_03B11F:
	RTS

CODE_03B120:
	SEP.b #$20
	LDA.b #$00
	XBA
	LDA.w $0B86
	REP.b #$20
	STA.w $0C5B
	ASL
	ASL
	ASL
	ASL
	SEC
	SBC.w $0C5B
	STA.w $0C5B
	SEP.b #$20
	LDA.b #$00
	XBA
	LDA.w $0B85
	REP.b #$20
	LSR
	LSR
	LSR
	CLC
	ADC.w $0C5B
	TAX
	LDA.w $0B85
	AND.w #$0007
	TAY
	RTS

CODE_03B152:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0002
	TCD
	PLA
	SEP.b #$20
	PHB
	LDA.b #$7FA598>>16
	PHA
	PLB
	REP.b #$20
	LDX.w #$0000
	LDY.w #$0000
CODE_03B16C:
	TXA
	AND.w #$001E
	BNE.b CODE_03B17A
	LDA.w $7FA598,y
	XBA
	STA.b $00
	INY
	INY
CODE_03B17A:
	LDA.w #$0000
	STA.l $00023F
	LDA.w !RAM_SIMC_City_MapDataBuffer,x
	AND.w #$7FFF
	ASL.b $00
	BCC.b CODE_03B18E
	ORA.w #$8000
CODE_03B18E:
	STA.w !RAM_SIMC_City_MapDataBuffer,x
	LDA.l $00023F
	BEQ.b CODE_03B19B
	ROR.b $00
	BRA.b CODE_03B17A

CODE_03B19B:
	INX
	INX
	CPX.w #$5DC0
	BNE.b CODE_03B16C
	PLB
	PLD
	RTS

CODE_03B1A5:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0004
	TCD
	PLA
	REP.b #$30
	ASL
	STA.w $0C55
	LDA.w $0B85
	STA.b $00
	LDA.w $0B86
	STA.b $02
	STZ.w $0C13
	JSR.w CODE_03B26B
	BEQ.b CODE_03B1F0
	JSR.w CODE_03B2D6
	BEQ.b CODE_03B1E1
	JSR.w CODE_03B1F5
	LDA.b $00
	STA.w $0B85
	LDA.b $02
	STA.w $0B86
	REP.b #$20
	PLD
	LDA.w #$0001
	RTS

CODE_03B1E1:
	LDA.b $00
	STA.w $0B85
	LDA.b $02
	STA.w $0B86
	PLD
	LDA.w #$0000
	RTS

CODE_03B1F0:
	PLD
	LDA.w #$FFFF
	RTS

CODE_03B1F5:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0004
	TCD
	PLA
	LDX.w $0C13
CODE_03B203:
	PHX
	SEP.b #$20
	JSR.w CODE_03B258
	REP.b #$20
	LDA.w $0B85
	JSR.w CODE_03849E
	AND.w #$03FF
	CMP.w #$0030
	BCC.b CODE_03B23F
	CMP.w #$0060
	BCS.b CODE_03B23F
	SEP.b #$20
	LDA.w $0B86
	LSR
	XBA
	LDA.w $0B85
	LSR
	JSR.w CODE_03A29A
	LDA.l $7F99E0,x
	CLC
	ADC.b #$32
	BCS.b CODE_03B239
	CMP.b #$F0
	BCC.b CODE_03B23B
CODE_03B239:
	LDA.b #$F0
CODE_03B23B:
	STA.l $7F99E0,x
CODE_03B23F:
	PLX
	DEX
	BPL.b CODE_03B203
	PLD
	RTS

CODE_03B245:
	INC.w $0C13
	LDX.w $0C13
	LDA.w $0B85
	STA.w $0C15,x
	LDA.w $0B86
	STA.w $0C34,x
	RTS

CODE_03B258:
	LDX.w $0C13
	LDA.w $0C15,x
	STA.w $0B85
	LDA.w $0C34,x
	STA.w $0B86
	DEC.w $0C13
	RTS

CODE_03B26B:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0002
	TCD
	PLA
	LDX.w #$0000
CODE_03B279:
	PHX
	SEP.b #$20
	LDA.w $0B86
	CLC
	ADC.w DATA_03B2CA,x
	STA.b $01
	XBA
	LDA.w $0B85
	CLC
	ADC.w DATA_03B2BE,x
	STA.b $00
	JSR.w CODE_03B420
	BEQ.b CODE_03B2B0
	REP.b #$20
	LDA.b $00
	JSR.w CODE_03849E
	JSR.w CODE_03B401
	BEQ.b CODE_03B2B0
	LDA.b $00
	STA.w $0B85
	LDA.b $01
	STA.w $0B86
	PLX
	PLD
	LDA.w #$0001
	RTS

CODE_03B2B0:
	PLX
	INX
	CPX.w #$000C
	BNE.b CODE_03B279
	PLD
	REP.b #$20
	LDA.w #$0000
	RTS

DATA_03B2BE:
	db $FF,$00,$01,$02,$02,$02,$01,$00,$FF,$FE,$FE,$FE

DATA_03B2CA:
	db $FE,$FE,$FE,$FF,$00,$01,$02,$02,$02,$01,$00,$FF

CODE_03B2D6:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0002
	TCD
	PLA
	LDA.w #$0005
	STA.w $0C53
	LDX.w #$0000
CODE_03B2EA:
	STX.b $00
	JSR.w CODE_03B318
	BEQ.b CODE_03B2FB
	JSR.w CODE_03B3B0
	BEQ.b CODE_03B30B
	PLD
	LDA.w #$0001
	RTS

CODE_03B2FB:
	LDA.w $0C13
	BEQ.b CODE_03B313
	DEC.w $0C13
	LDA.b $00
	CLC
	ADC.w #$0003
	STA.b $00
CODE_03B30B:
	LDX.b $00
	INX
	CPX.w #$001E
	BNE.b CODE_03B2EA
CODE_03B313:
	PLD
	LDA.w #$0000
	RTS

CODE_03B318:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0008
	TCD
	PLA
	STX.b $00
	JSR.w CODE_03907E
	AND.w #$0003
	STA.b $04
	STA.b $02
CODE_03B32F:
	LDA.b $02
	AND.w #$0003
	STA.b $06
	CMP.w $0C53
	BEQ.b CODE_03B360
	JSR.w CODE_03B370
	JSR.w CODE_03B401
	BEQ.b CODE_03B360
	LDA.b $06
	JSR.w CODE_038FF4
	LDA.b $06
	CLC
	ADC.w #$0002
	AND.w #$0003
	STA.w $0C53
	LSR.b $00
	BCS.b CODE_03B35B
	JSR.w CODE_03B245
CODE_03B35B:
	PLD
	LDA.w #$0001
	RTS

CODE_03B360:
	INC.b $02
	LDA.b $02
	AND.w #$0003
	CMP.b $04
	BNE.b CODE_03B32F
	PLD
	LDA.w #$0000
	RTS

CODE_03B370:
	PHP
	SEP.b #$30
	LDX.w $0B85
	LDY.w $0B86
	CMP.b #$00
	BNE.b CODE_03B382
	DEY
	BMI.b CODE_03B3A9
	BRA.b CODE_03B39C

CODE_03B382:
	DEC
	BNE.b CODE_03B38C
	CPX.b #$77
	BCS.b CODE_03B3A9
	INX
	BRA.b CODE_03B39C

CODE_03B38C:
	DEC
	BNE.b CODE_03B396
	CPY.b #$63
	BCS.b CODE_03B3A9
	INY
	BRA.b CODE_03B39C

CODE_03B396:
	DEC
	BNE.b CODE_03B3A9
	DEX
	BMI.b CODE_03B3A9
CODE_03B39C:
	TYA
	XBA
	TXA
	REP.b #$10
	JSR.w CODE_03849E
	AND.w #$03FF
	PLP
	RTS

CODE_03B3A9:
	REP.b #$30
	LDA.w #$0000
	PLP
	RTS

CODE_03B3B0:
	LDX.w #$0000
CODE_03B3B3:
	PHX
	TXA
	JSR.w CODE_03B370
	LDX.w $0C55
	CMP.w DATA_03B3E9,x
	BCC.b CODE_03B3DE
	CMP.w DATA_03B3EF,x
	BCC.b CODE_03B3CF
	CMP.w DATA_03B3F5,x
	BCC.b CODE_03B3DE
	CMP.w DATA_03B3FB,x
	BCS.b CODE_03B3DE
CODE_03B3CF:
	CMP.w #$0277
	BCC.b CODE_03B3D9
	CMP.w #$0287
	BCC.b CODE_03B3DE
CODE_03B3D9:
	PLX
	LDA.w #$0001
	RTS

CODE_03B3DE:
	PLX
	INX
	CPX.w #$0004
	BNE.b CODE_03B3B3
	LDA.w #$0000
	RTS

DATA_03B3E9:
	dw $0137,$0089,$0089

DATA_03B3EF:
	dw $0354,$0245,$0137

DATA_03B3F5:
	dw $039A,$0376,$0376

DATA_03B3FB:
	dw $03BE,$03BE,$039A

CODE_03B401:
	LDY.w #$0000
	AND.w #$03FF
	CMP.w #$0030
	BCC.b CODE_03B41E
	CMP.w #$0080
	BCS.b CODE_03B41E
	CMP.w #$0060
	BCC.b CODE_03B41B
	CMP.w #$006D
	BCC.b CODE_03B41E
CODE_03B41B:
	LDY.w #$0001
CODE_03B41E:
	TYA
	RTS

CODE_03B420:
	CMP.b #$78
	BCS.b CODE_03B42C
	XBA
	CMP.b #$64
	BCS.b CODE_03B42C
	LDA.b #$01
	RTS

CODE_03B42C:
	LDA.b #$00
	RTS

CODE_03B42F:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0010
	TCD
	PLA
	LDA.w $0DFB
	BEQ.b CODE_03B450
	JSR.w CODE_03B4AA
	JSR.w CODE_03B562
	JSR.w CODE_03B573
	JSR.w CODE_03B708
	JSR.w CODE_03B824
	BRA.b CODE_03B456

CODE_03B450:
	JSR.w CODE_03B477
	STZ.w $0DF7
CODE_03B456:
	SEP.b #$20
	LDY.w #$0000
	TYX
CODE_03B45C:
	LDA.w $0DF7,x
	STA.w !RAM_SIMC_City_1stWorstProblemPercent,y
	INY
	LDA.w $0DF3,x
	STA.w !RAM_SIMC_City_1stWorstProblemPercent,y
	INY
	INX
	CPX.w #$0004
	BNE.b CODE_03B45C
	LDA.b #$01
	STA.w $0CEB
	PLD
	RTS

CODE_03B477:
	REP.b #$30
	STZ.w !RAM_SIMC_City_PercentOfPeopleThatApproveOfMayorLo
	STZ.w !RAM_SIMC_City_PercentOfPeopleThatDisapproveOfMayorLo
	STZ.w !RAM_SIMC_City_LastYearsNetMigrationLo
	STZ.w !RAM_SIMC_City_AssessedValueLo
	LDA.w #$01F4
	STA.w !RAM_SIMC_City_CurrentCityScoreLo
	STZ.w !RAM_SIMC_City_AnnualCityScoreChangeLo
	LDX.w #$0000
CODE_03B491:
	STZ.w $0BF1,x
	INX
	INX
	CPX.w #$0010
	BNE.b CODE_03B491
	SEP.b #$20
	LDX.w #$0000
CODE_03B4A0:
	STZ.w $0DF3,x
	INX
	CPX.w #$0004
	BNE.b CODE_03B4A0
	RTS

CODE_03B4AA:
	REP.b #$30
	LDA.w $0E15
	STA.b $00
	LDA.w #$0005
	STA.b $04
	JSR.w CODE_03A2F5	: db $00,$04,$0C
	LDA.w $0E17
	STA.b $00
	LDA.w #$000A
	STA.b $04
	JSR.w CODE_03A2F5	: db $00,$04,$08
	JSR.w CODE_03B554
	LDA.w $0E03
	STA.b $00
	LDA.w #$0190
	STA.b $04
	JSR.w CODE_03A2F5	: db $00,$04,$08
	JSR.w CODE_03B554
	LDA.w !RAM_SIMC_City_PoliceStationCountLo
	CLC
	ADC.w !RAM_SIMC_City_FireStationCountLo
	STA.b $00
	LDA.w #$03E8
	STA.b $04
	JSR.w CODE_03A2F5	: db $00,$04,$08
	JSR.w CODE_03B554
	LDA.w $0E0B
	CLC
	ADC.w $0E0D
	STA.b $00
	LDA.w #$0BB8
	STA.b $04
	JSR.w CODE_03A2F5	: db $00,$04,$08
	JSR.w CODE_03B554
	LDA.w $0E11
	STA.b $00
	LDA.w #$1388
	STA.b $04
	JSR.w CODE_03A2F5	: db $00,$04,$08
	JSR.w CODE_03B554
	LDA.w $0E0F
	STA.b $00
	LDA.w #$1770
	STA.b $04
	JSR.w CODE_03A2F5	: db $00,$04,$08
	JSR.w CODE_03B554
	LDA.w $0E13
	STA.b $00
	LDA.w #$2710
	STA.b $04
	JSR.w CODE_03A2F5	: db $00,$04,$08
	JSR.w CODE_03B554
	LDA.b $0C
	STA.w !RAM_SIMC_City_AssessedValueLo
	LDA.b $0E
	STA.w !RAM_SIMC_City_AssessedValueMidHi
	RTS

CODE_03B554:
	LDA.b $0C
	CLC
	ADC.b $08
	STA.b $0C
	LDA.b $0E
	ADC.b $0A
	STA.b $0E
	RTS

CODE_03B562:
	REP.b #$30
CODE_03B564:
	LDA.w !RAM_SIMC_City_CurrentPopulationLo
	STA.w $0BCD
	LDA.w !RAM_SIMC_City_CurrentPopulationHi
	STA.w $0BCF
	JMP.w CODE_038196

CODE_03B573:
	REP.b #$30
	LDX.w #$0000
CODE_03B578:
	STZ.w $0BD1,x
	INX
	INX
	CPX.w #$0010
	BNE.b CODE_03B578
	LDA.w $0C01
	STA.w $0BD1
	LDA.w $0C07
	STA.w $0BD3
	LDA.w $0C03
	STA.b $00
	LDA.w #$00B3
	STA.b $04
	JSR.w CODE_03A2F5	: db $00,$04,$00
	LDA.b $01
	STA.w $0BD5
	LDA.w !RAM_SIMC_City_TaxRateLo
	ASL
	STA.b $00
	ASL
	ASL
	ADC.b $00
	STA.w $0BD7
	JSR.w CODE_03B66A
	STA.w $0BD9
	JSR.w CODE_03B6BD
	STA.w $0BDB
	JSR.w CODE_03B6F7
	STA.w $0BDD
	JSR.w CODE_03B627
	LDX.w #$0000
CODE_03B5C8:
	STZ.w $0BE1,x
	INX
	INX
	CPX.w #$0010
	BNE.b CODE_03B5C8
	LDY.w #$0000
CODE_03B5D5:
	STZ.b $0C
	LDX.w #$0000
CODE_03B5DA:
	LDA.w $0BF1,x
	CMP.b $0C
	BCC.b CODE_03B5ED
	LDA.w $0BE1,x
	BNE.b CODE_03B5ED
	STX.b $08
	LDA.w $0BF1,x
	STA.b $0C
CODE_03B5ED:
	INX
	INX
	CPX.w #$000E
	BNE.b CODE_03B5DA
	LDA.b $0C
	BEQ.b CODE_03B60F
	LDX.b $08
	LDA.w #$0001
	STA.w $0BE1,x
	SEP.b #$20
	LDA.b $0C
	STA.w $0DF7,y
	LDA.b $08
	LSR
	STA.w $0DF3,y
	BRA.b CODE_03B61E

CODE_03B60F:
	STZ.w $0BDF
	SEP.b #$20
	LDA.b #$00
	STA.w $0DF7,y
	LDA.b #$07
	STA.w $0DF3,y
CODE_03B61E:
	REP.b #$20
	INY
	CPY.w #$0004
	BNE.b CODE_03B5D5
	RTS

CODE_03B627:
	REP.b #$30
	LDX.w #$0000
CODE_03B62C:
	STZ.w $0BF1,x
	INX
	INX
	CPX.w #$0010
	BNE.b CODE_03B62C
	LDX.w #$0000
	STZ.b $04
	STZ.b $08
CODE_03B63D:
	LDA.b $04
	CMP.w #$0064
	BCS.b CODE_03B669
	LDA.b $08
	CMP.w #$0258
	BCS.b CODE_03B669
	LDA.w #$012C
	JSR.w CODE_039035
	CMP.w $0BD1,x
	BCS.b CODE_03B65B
	INC.w $0BF1,x
	INC.b $04
CODE_03B65B:
	INX
	INX
	CPX.w #$0010
	BNE.b CODE_03B665
	LDX.w #$0000
CODE_03B665:
	INC.b $08
	BRA.b CODE_03B63D

CODE_03B669:
	RTS

CODE_03B66A:
	REP.b #$30
	STZ.b $00
	STZ.b $02
	LDY.w #$0000
	TYX
	SEP.b #$20
CODE_03B676:
	LDA.l $7F6B00,x
	BEQ.b CODE_03B691
	LDA.l $7F99E0,x
	REP.b #$20
	AND.w #$00FF
	CLC
	ADC.b $00
	STA.b $00
	BCC.b CODE_03B68E
	INC.b $02
CODE_03B68E:
	SEP.b #$20
	INY
CODE_03B691:
	INX
	CPX.w #$0BB8
	BNE.b CODE_03B676
	REP.b #$20
	CPY.w #$0000
	BNE.b CODE_03B6A2
	STY.w $0C05
	RTS

CODE_03B6A2:
	STY.b $04
	STZ.b $06
	JSR.w CODE_03A421	: db $00,$04,$00
	LDA.w #$0266
	STA.b $04
	JSR.w CODE_03A2F5	: db $00,$04,$00
	LDA.b $01
	STA.w $0C05
	RTS

CODE_03B6BD:
	REP.b #$30
	STZ.b $06
	STZ.b $00
	STZ.b $02
	LDA.w $0B93
	CLC
	ADC.w $0B8F
	BEQ.b CODE_03B6F3
	ASL
	ASL
	ASL
	CMP.w $0B8B
	BCS.b CODE_03B6F3
	STA.b $04
	LDA.w $0B8B
	STA.b $01
	JSR.w CODE_03A421	: db $00,$04,$00
	LDA.b $00
	SEC
	SBC.w #$0100
	CMP.w #$00FF
	BCC.b CODE_03B6F6
	LDA.w #$00FF
	BRA.b CODE_03B6F6

CODE_03B6F3:
	LDA.w #$0000
CODE_03B6F6:
	RTS

CODE_03B6F7:
	LDA.w $0E01
	ASL
	ASL
	ADC.w $0E01
	CMP.w #$00FF
	BCC.b CODE_03B707
	LDA.w #$00FF
CODE_03B707:
	RTS

CODE_03B708:
	REP.b #$30
	LDA.w !RAM_SIMC_City_CurrentCityScoreLo
	STA.w $0DF1
	LDX.w #$0000
	TXA
CODE_03B714:
	CLC
	ADC.w $0BD1,x
	INX
	INX
	CPX.w #$000E
	BNE.b CODE_03B714
	STA.b $04
	LDA.w #$0003
	STA.b $00
	JSR.w CODE_03A3CF	: db $04,$00,$04
	LDA.b $04
	CMP.w #$0100
	BCC.b CODE_03B736
	LDA.w #$0100
CODE_03B736:
	STA.b $04
	LDA.w #$0100
	SEC
	SBC.b $04
	ASL
	ASL
	CMP.w #$03E8
	BCC.b CODE_03B748
	LDA.w #$03E8
CODE_03B748:
	STA.b $04
	LDA.w #$00DA
	STA.b $00
	LDA.w $0BB3
	BEQ.b CODE_03B75A
	JSR.w CODE_03A2F5	: db $04,$00,$03
CODE_03B75A:
	LDA.w $0BB5
	BEQ.b CODE_03B765
	JSR.w CODE_03A2F5	: db $04,$00,$03
CODE_03B765:
	LDA.w $0BB7
	BEQ.b CODE_03B770
	JSR.w CODE_03A2F5	: db $04,$00,$03
CODE_03B770:
	LDA.w $0BC5
	CMP.w #$0020
	BCS.b CODE_03B783
	LDA.b $04
	ADC.w $0BC5
	SEC
	SBC.w #$0020
	STA.b $04
CODE_03B783:
	LDA.w $0BC7
	CMP.w #$03E8
	BCS.b CODE_03B7AC
	STZ.b $00
	STZ.b $02
	STA.b $01
	LDA.w #$2710
	STA.b $08
	STZ.b $0A
	JSR.w CODE_03A421	: db $00,$08,$00
	LDA.b $00
	CLC
	ADC.w #$00E6
	STA.b $00
	JSR.w CODE_03A2F5	: db $04,$00,$03
CODE_03B7AC:
	LDA.w $0BC9
	CMP.w #$1000
	BCS.b CODE_03B7D5
	STZ.b $00
	STZ.b $02
	STA.b $01
	LDA.w #$2710
	STA.b $08
	STZ.b $0A
	JSR.w CODE_03A421	: db $00,$08,$00
	LDA.b $00
	CLC
	ADC.w #$00E6
	STA.b $00
	JSR.w CODE_03A2F5	: db $04,$00,$03
CODE_03B7D5:
	LDA.w #$00DA
	STA.b $00
	LDA.w $0BAD
	CLC
	ADC.w #$03E8
	BPL.b CODE_03B7E9
	JSR.w CODE_03A2F5	: db $04,$00,$03
CODE_03B7E9:
	LDA.w $0BAF
	CLC
	ADC.w #$03E8
	BPL.b CODE_03B7F8
	JSR.w CODE_03A2F5	: db $04,$00,$03
CODE_03B7F8:
	LDA.w $0BB1
	CLC
	ADC.w #$03E8
	BPL.b CODE_03B807
	JSR.w CODE_03A2F5	: db $04,$00,$03
CODE_03B807:
	LDA.b $04
	CMP.w #$03E8
	BCC.b CODE_03B811
	LDA.w #$03E8
CODE_03B811:
	CLC
	ADC.w !RAM_SIMC_City_CurrentCityScoreLo
	LSR
	STA.w !RAM_SIMC_City_CurrentCityScoreLo
	LDA.w !RAM_SIMC_City_CurrentCityScoreLo
	SEC
	SBC.w $0DF1
	STA.w !RAM_SIMC_City_AnnualCityScoreChangeLo
	RTS

CODE_03B824:
	REP.b #$30
	STZ.b $00
	LDY.w #$0000
	TYX
CODE_03B82C:
	LDA.w #$03E8
	JSR.w CODE_039035
	CMP.w !RAM_SIMC_City_CurrentCityScoreLo
	BCS.b CODE_03B83A
	INY
	BRA.b CODE_03B83C

CODE_03B83A:
	INC.b $00
CODE_03B83C:
	INX
	CPX.w #$0064
	BNE.b CODE_03B82C
	STY.w !RAM_SIMC_City_PercentOfPeopleThatApproveOfMayorLo
	LDA.b $00
	STA.w !RAM_SIMC_City_PercentOfPeopleThatDisapproveOfMayorLo
	RTS

CODE_03B84B:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$0010
	TCD
	PLA
	REP.b #$30
	LDA.w $0425
	AND.w #$0001
	BEQ.b CODE_03B863
	JMP.w CODE_03B914

CODE_03B863:
	LDA.w $003E
	CMP.w #$0003
	BNE.b CODE_03B86E
	JSR.w CODE_03B96F
CODE_03B86E:
	LDA.w $0199
	BEQ.b CODE_03B8A1
	AND.w #$0001
	BEQ.b CODE_03B87D
	LDA.w #$00FE
	BRA.b CODE_03B89B

CODE_03B87D:
	LDA.w $0199
	AND.w #$0002
	BEQ.b CODE_03B88D
	JSR.w CODE_03B9DB
	LDA.w #$00FD
	BRA.b CODE_03B89B

CODE_03B88D:
	LDA.w $0199
	AND.w #$0004
	BEQ.b CODE_03B8A1
	JSR.w CODE_03BA47
	LDA.w #$00FB
CODE_03B89B:
	AND.w $0199
	STA.w $0199
CODE_03B8A1:
	LDA.w $00D7
	ORA.w $0AB5
	BNE.b CODE_03B8AE
	LDA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	BNE.b CODE_03B914
CODE_03B8AE:
	LDA.w $0197
	BEQ.b CODE_03B916
	AND.w #$0001
	BEQ.b CODE_03B8C0
	JSR.w CODE_03BBB9
	LDA.w #$00FE
	BRA.b CODE_03B90E

CODE_03B8C0:
	LDA.w $0197
	AND.w #$0002
	BEQ.b CODE_03B8D0
	JSR.w CODE_03BC0B
	LDA.w #$00FD
	BRA.b CODE_03B90E

CODE_03B8D0:
	LDA.w $0197
	AND.w #$0004
	BEQ.b CODE_03B8E0
	JSR.w CODE_03B9CD
	LDA.w #$00FB
	BRA.b CODE_03B90E

CODE_03B8E0:
	LDA.w $0197
	AND.w #$0008
	BEQ.b CODE_03B8F0
	JSR.w CODE_03B9DB
	LDA.w #$00F7
	BRA.b CODE_03B90E

CODE_03B8F0:
	LDA.w $0197
	AND.w #$0010
	BEQ.b CODE_03B900
	JSR.w CODE_03BAF5
	LDA.w #$00EF
	BRA.b CODE_03B90E

CODE_03B900:
	LDA.w $0197
	AND.w #$0020
	BEQ.b CODE_03B914
	JSR.w CODE_03BA47
	LDA.w #$00DF
CODE_03B90E:
	AND.w $0197
	STA.w $0197
CODE_03B914:
	PLD
	RTS

CODE_03B916:
	LDA.w $003E
	CMP.w #$0001
	BEQ.b CODE_03B967
	LDA.w !RAM_SIMC_City_DifficultyLevel
	ASL
	TAY
	LDA.w DATA_03B969,y
	JSR.w CODE_039035
	CMP.w #$0000
	BNE.b CODE_03B967
	JSR.w CODE_03907E
	AND.w #$0007
	CMP.w #$0002
	BCS.b CODE_03B93E
	JSR.w CODE_03BB6A
	BRA.b CODE_03B967

CODE_03B93E:
	CMP.w #$0004
	BCS.b CODE_03B948
	JSR.w CODE_03BC0B
	BRA.b CODE_03B967

CODE_03B948:
	CMP.w #$0005
	BNE.b CODE_03B952
	JSR.w CODE_03B9DB
	BRA.b CODE_03B967

CODE_03B952:
	CMP.w #$0006
	BNE.b CODE_03B95C
	JSR.w CODE_03BAF5
	BRA.b CODE_03B967

CODE_03B95C:
	LDA.w $0C07
	CMP.w #$0050
	BCC.b CODE_03B967
	JSR.w CODE_03BA47
CODE_03B967:
	PLD
	RTS

DATA_03B969:
	dw $12C0,$0960,$04B0

CODE_03B96F:
	LDA.w $0C0D
	CMP.w #$0001
	BNE.b CODE_03B997
	LDY.w !RAM_SIMC_Global_CurrentScenario
	BNE.b CODE_03B981
	JSR.w CODE_03BAF5
	BRA.b CODE_03B9C4

CODE_03B981:
	CPY.w #!Define_SIMC_Global_Scenario_Tokyo
	BNE.b CODE_03B98B
	JSR.w CODE_03BA47
	BRA.b CODE_03B9C4

CODE_03B98B:
	CPY.w #!Define_SIMC_Global_Scenario_Boston
	BNE.b CODE_03B995
	JSR.w CODE_03BAC1
	BRA.b CODE_03B9C4

CODE_03B995:
	BRA.b CODE_03B9C4

CODE_03B997:
	LDA.w $0C0D
	BEQ.b CODE_03B9CC
	AND.w #$000F
	BNE.b CODE_03B9C4
	LDY.w !RAM_SIMC_Global_CurrentScenario
	CPY.w #!Define_SIMC_Global_Scenario_RioDeJaneiro
	BNE.b CODE_03B9AE
	JSR.w CODE_03BC0B
	BRA.b CODE_03B9C4

CODE_03B9AE:
	CPY.w #!Define_SIMC_Global_Scenario_LasVegas
	BNE.b CODE_03B9C4
	LDA.w !RAM_SIMC_City_CurrentPopulationLo
	CMP.w #$4C08
	LDA.w !RAM_SIMC_City_CurrentPopulationHi
	SBC.w #$0001
	BCC.b CODE_03B9C4
	JSR.w CODE_03BCB8
CODE_03B9C4:
	LDY.w $0C0D
	BEQ.b CODE_03B9CC
	DEC.w $0C0D
CODE_03B9CC:
	RTS

CODE_03B9CD:
	REP.b #$30
	LDA.w $0A8D
	BEQ.b CODE_03B9DA
	LDA.w #$0001
	STA.w $0B15
CODE_03B9DA:
	RTS

CODE_03B9DB:
	REP.b #$30
	LDA.w $0A8B
	BNE.b CODE_03BA46
	LDA.w #$0064
	JSR.w CODE_039035
	CLC
	ADC.w #$000A
	STA.w $0A59
	LDA.w #$005A
	JSR.w CODE_039035
	CLC
	ADC.w #$0005
	STA.w $0AA5
	LDA.w #$0064
	JSR.w CODE_039035
	CLC
	ADC.w #$000A
	STA.w $0AA3
	LDA.w #$005A
	JSR.w CODE_039035
	CLC
	ADC.w #$0005
	STA.w $0A57
	LDA.w #$8000
	STA.w $0A8B
	STZ.w $0A75
	STZ.w $0A73
	LDA.w $0A59
	STA.w $0400
	LDA.w $0A57
	STA.w $0402
	INC.w $03FE
	LDA.w #$0023
	JSR.w CODE_03BE04
	LDA.w #$000A
	JSR.w CODE_03C42A
	SEP.b #$20
	LDA.b #$22
	STA.w $0006
	REP.b #$20
CODE_03BA46:
	RTS

CODE_03BA47:
	REP.b #$30
	LDA.w $0A91
	BNE.b CODE_03BAC0
	LDA.w #$0064
	JSR.w CODE_039035
	CLC
	ADC.w #$000A
	STA.w $0A51
	STA.w $0400
	LDA.w #$005A
	JSR.w CODE_039035
	CLC
	ADC.w #$0005
	STA.w $0A4F
	STA.w $0402
	INC.w $03FE
	LDA.w #$0009
	JSR.w CODE_03BE04
	LDA.w #$0007
	JSR.w CODE_03C42A
	LDA.w $0C09
	STA.w $0ABD
	LDA.w $0C0B
	STA.w $0ABB
	LDA.w #$0001
	STA.w $0A91
	STZ.w $0ABF
	STZ.w $0A6D
	STZ.w $0A6B
	LDY.w #$0001
	LDA.w $0ABB
	SEC
	SBC.w $0A4F
	STA.b $00
	BCS.b CODE_03BAA9
	LDY.w #$0000
CODE_03BAA9:
	LDX.w #$0002
	LDA.w $0ABD
	SEC
	SBC.w $0A51
	BCS.b CODE_03BAB8
	LDX.w #$0003
CODE_03BAB8:
	CMP.b $00
	BCC.b CODE_03BABD
	TXY
CODE_03BABD:
	STY.w $0AC1
CODE_03BAC0:
	RTS

CODE_03BAC1:
	REP.b #$30
	LDX.w #$0000
	STZ.b $04
CODE_03BAC8:
	STZ.b $00
CODE_03BACA:
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	AND.w #$03FF
	CMP.w #$027C
	BNE.b CODE_03BAE0
	SEP.b #$20
	LDA.b $04
	XBA
	LDA.b $00
	JMP.w CODE_03BD61

CODE_03BAE0:
	INX
	INX
	INC.b $00
	LDA.b $00
	CMP.w #$0078
	BNE.b CODE_03BACA
	INC.b $04
	LDA.b $04
	CMP.w #$0064
	BNE.b CODE_03BAC8
	RTS

CODE_03BAF5:
	REP.b #$30
	LDA.w $0BA9
	AND.w #$00FF
	STA.w $0400
	LDA.w $0BAA
	AND.w #$00FF
	STA.w $0402
	INC.w $03FE
	LDA.w #$000A
	JSR.w CODE_03BE04
	LDA.w #$000E
	JSR.w CODE_03C42A
	LDA.w #$015E
	JSR.w CODE_039035
	CLC
	ADC.w #$00C8
	STA.b $00
	STA.w $0C0F
	SEP.b #$20
	LDA.b #$09
	STA.w $0006
	REP.b #$20
CODE_03BB30:
	JSR.w CODE_03BC9F
	JSR.w CODE_03BB4F
	BEQ.b CODE_03BB4A
	LDY.w #$0028
	LDA.b $04
	AND.w #$0003
	BNE.b CODE_03BB45
	LDY.w #$007F
CODE_03BB45:
	LDA.b $04
	JSR.w CODE_0384C4
CODE_03BB4A:
	DEC.b $00
	BNE.b CODE_03BB30
	RTS

CODE_03BB4F:
	CMP.w #$0080
	BCC.b CODE_03BB66
	CMP.w #$02BC
	BCS.b CODE_03BB66
	TAY
	LDA.w DATA_0384EB,y
	AND.w #$0001
	BNE.b CODE_03BB66
	LDA.w #$0001
	RTS

CODE_03BB66:
	LDA.w #$0000
	RTS

CODE_03BB6A:
	REP.b #$30
	LDA.w #$0014
	STA.b $00
CODE_03BB71:
	JSR.w CODE_03BC9F
	TAY
	LDA.w DATA_0384EB,y
	AND.w #$0001
	BNE.b CODE_03BBB4
	CPY.w #$0088
	BCC.b CODE_03BBB4
	LDA.w #$007F
	STA.l !RAM_SIMC_City_MapDataBuffer,x
	SEP.b #$20
	LDA.b $04
	STA.w $0400
	LDA.b $05
	STA.w $0402
	REP.b #$20
	INC.w $03FE
	LDA.w #$0020
	JSR.w CODE_03BE04
	LDA.w #$000B
	JSR.w CODE_03C42A
	INC.w $0C9F
	SEP.b #$20
	LDA.b #$21
	STA.w $0006
	REP.b #$20
	BRA.b CODE_03BBB8

CODE_03BBB4:
	DEC.b $00
	BNE.b CODE_03BB71
CODE_03BBB8:
	RTS

CODE_03BBB9:
	REP.b #$30
	LDA.w #$0028
	STA.b $00
CODE_03BBC0:
	JSR.w CODE_03BC9F
	TAY
	LDA.w DATA_0384EB,y
	AND.w #$0001
	BNE.b CODE_03BC06
	LDA.w DATA_0384EB,y
	AND.w #$0004
	BEQ.b CODE_03BC06
	LDA.w #$007F
	STA.l !RAM_SIMC_City_MapDataBuffer,x
	SEP.b #$20
	LDA.b $04
	STA.w $0400
	LDA.b $05
	STA.w $0402
	REP.b #$20
	INC.w $03FE
	LDA.w #$0020
	JSR.w CODE_03BE04
	LDA.w #$000B
	JSR.w CODE_03C42A
	INC.w $0C9F
	SEP.b #$20
	LDA.b #$21
	STA.w $0006
	REP.b #$20
	BRA.b CODE_03BC0A

CODE_03BC06:
	DEC.b $00
	BNE.b CODE_03BBC0
CODE_03BC0A:
	RTS

CODE_03BC0B:
	LDA.w #$012C
	STA.b $00
CODE_03BC10:
	REP.b #$30
	JSR.w CODE_03BC9F
	CMP.w #$0004
	BCC.b CODE_03BC8E
	CMP.w #$0014
	BCS.b CODE_03BC8E
	STZ.b $08
CODE_03BC21:
	SEP.b #$20
	LDY.b $08
	LDA.b $05
	CLC
	ADC.w DATA_03BC9B,y
	STA.b $0D
	XBA
	LDA.b $04
	CLC
	ADC.w DATA_03BC97,y
	STA.b $0C
	JSR.w CODE_03B420
	BEQ.b CODE_03BC84
	REP.b #$20
	LDA.b $0C
	JSR.w CODE_03849E
	AND.w #$03FF
	BEQ.b CODE_03BC84
	TAY
	LDA.w DATA_0384EB,y
	AND.w #$0004
	BEQ.b CODE_03BC84
	LDA.w #$0365
	STA.l !RAM_SIMC_City_MapDataBuffer,x
	LDA.w #$003C
	STA.w $0C11
	SEP.b #$20
	LDA.b $0C
	STA.w $0400
	LDA.b $0D
	STA.w $0402
	REP.b #$20
	INC.w $03FE
	LDA.w #$0021
	JSR.w CODE_03BE04
	LDA.w #$000C
	JSR.w CODE_03C42A
	SEP.b #$20
	LDA.b #$24
	STA.w $0006
CODE_03BC81:
	REP.b #$20
	RTS

CODE_03BC84:
	SEP.b #$20
	INC.b $08
	LDA.b $08
	CMP.b #$04
	BNE.b CODE_03BC21
CODE_03BC8E:
	REP.b #$20
	DEC.b $00
	BEQ.b CODE_03BC81
	JMP.w CODE_03BC10

DATA_03BC97:
	db $00,$01,$00,$FF

DATA_03BC9B:
	db $FF,$00,$01,$00

CODE_03BC9F:
	LDA.w #$0077
	JSR.w CODE_039035
	STA.b $04
	LDA.w #$0063
	JSR.w CODE_039035
	STA.b $05
	LDA.b $04
	JSR.w CODE_03849E
	AND.w #$03FF
	RTS

CODE_03BCB8:
	REP.b #$30
	LDY.w #$0000
	LDA.w $0B01
	BNE.b CODE_03BCF0
	INC.w $0B01
CODE_03BCC5:
	LDA.w $0AEF
	BNE.b CODE_03BCC5
	LDA.w $011B
	BNE.b CODE_03BCC5
	LDA.w DATA_03BD3B,y
	CMP.w #$00FF
	BEQ.b CODE_03BD2B
	STA.w $0AF9
	LDA.w DATA_03BD4F,y
	STA.w $0AF7
	STZ.w $0AF5
	LDA.w #$8000
	STA.w $0AEF
	STA.w $0AF1
	INY
	INY
	BRA.b CODE_03BCC5

CODE_03BCF0:
	PHY
CODE_03BCF1:
	LDA.w $0AEF
	BNE.b CODE_03BCF1
	LDA.w $011B
	BNE.b CODE_03BCF1
	CPY.w #$0003
	BEQ.b CODE_03BD2A
	LDA.w #$0050
	JSR.w CODE_039035
	CLC
	ADC.w #$0014
	STA.w $0AF9
	LDA.w #$003C
	JSR.w CODE_039035
	CLC
	ADC.w #$0014
	STA.w $0AF7
	STZ.w $0AF5
	LDA.w #$8000
	STA.w $0AEF
	STA.w $0AF1
	PLY
	INY
	BRA.b CODE_03BCF0

CODE_03BD2A:
	PLY
CODE_03BD2B:
	STZ.w $0AF1
	LDA.w #$0030
	JSR.w CODE_03BE04
	LDA.w #$0014
	JSR.w CODE_03C42A
	RTS

DATA_03BD3B:
	dw $0022,$0032,$001E,$0024,$002D,$0044,$001E,$001E
	dw $001E,$00FF

DATA_03BD4F:
	dw $001E,$0022,$0028,$002E,$0032,$001E,$0032,$003E
	dw $0046

CODE_03BD61:
	REP.b #$20
	PHD
	PHA
	TDC
	SEC
	SBC.w #$000C
	TCD
	PLA
	LDX.w $0B85
	PHX
	STA.b $00
	STA.w $0B85
	JSR.w CODE_03A89F
	PLX
	STX.w $0B85
	LDA.w #$00C8
	STA.b $08
CODE_03BD81:
	LDA.w #$0028
	JSR.w CODE_039035
	SEP.b #$20
	CLC
	ADC.b $00
	SEC
	SBC.b #$14
	STA.b $02
	REP.b #$20
	LDA.w #$001E
	JSR.w CODE_039035
	SEP.b #$20
	CLC
	ADC.b $01
	SEC
	SBC.b #$0F
	XBA
	LDA.b $02
	REP.b #$20
	STA.b $02
	SEP.b #$20
	JSR.w CODE_03B420
	BEQ.b CODE_03BDD6
	REP.b #$20
	LDA.b $02
	JSR.w CODE_03849E
	AND.w #$03FF
	TAY
	LDA.w DATA_0384EB,y
	AND.w #$0001
	BNE.b CODE_03BDD6
	LDA.w DATA_0384EB,y
	AND.w #$0004
	BEQ.b CODE_03BDD6
	CPY.w #$0000
	BEQ.b CODE_03BDD6
	LDA.w #$0364
	STA.l !RAM_SIMC_City_MapDataBuffer,x
CODE_03BDD6:
	REP.b #$20
	DEC.b $08
	BNE.b CODE_03BD81
	SEP.b #$20
	LDA.b $00
	STA.w $0400
	LDA.b $01
	STA.w $0402
	REP.b #$20
	INC.w $03FE
	LDA.w #$0024
	JSR.w CODE_03BE04
	LDA.w #$0008
	JSR.w CODE_03C42A
	SEP.b #$20
	LDA.b #$1E
	STA.w $0006
	REP.b #$20
	PLD
	RTS

CODE_03BE04:
	REP.b #$30
	LDY.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	BNE.b CODE_03BE11
	STA.w !RAM_SIMC_City_CurrentWrightMessage
	INC.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
CODE_03BE11:
	RTS

CODE_03BE12:
	REP.b #$30
	LDX.w #$0000
	LDA.w $0B51
	AND.w #$003F
	CMP.w #$003F
	BCC.b CODE_03BE25
	JMP.w CODE_03C00E

CODE_03BE25:
	CMP.w #$003C
	BCC.b CODE_03BE2D
	JMP.w CODE_03BFF9

CODE_03BE2D:
	CMP.w #$0039
	BCC.b CODE_03BE35
	JMP.w CODE_03BFE4

CODE_03BE35:
	CMP.w #$0036
	BCC.b CODE_03BE3D
	JMP.w CODE_03BFCF

CODE_03BE3D:
	CMP.w #$0033
	BCC.b CODE_03BE45
	JMP.w CODE_03BFC2

CODE_03BE45:
	CMP.w #$0030
	BCC.b CODE_03BE4D
	JMP.w CODE_03BFB0

CODE_03BE4D:
	CMP.w #$002D
	BCC.b CODE_03BE55
	JMP.w CODE_03BF9D

CODE_03BE55:
	CMP.w #$002A
	BCC.b CODE_03BE5D
	JMP.w CODE_03BF7C

CODE_03BE5D:
	CMP.w #$0023
	BCC.b CODE_03BE65
	JMP.w CODE_03BF63

CODE_03BE65:
	CMP.w #$001E
	BCC.b CODE_03BE6D
	JMP.w CODE_03BF47

CODE_03BE6D:
	CMP.w #$001C
	BCC.b CODE_03BE75
	JMP.w CODE_03BF2B

CODE_03BE75:
	CMP.w #$001A
	BCC.b CODE_03BE7D
	JMP.w CODE_03BF0F

CODE_03BE7D:
	CMP.w #$0016
	BCS.b CODE_03BEFC
	CMP.w #$0012
	BCS.b CODE_03BEE9
	CMP.w #$000E
	BCS.b CODE_03BED5
	CMP.w #$000A
	BCS.b CODE_03BEC4
	CMP.w #$0005
	BCS.b CODE_03BEB3
CODE_03BE96:
	LDA.w $0B8D
	CLC
	ADC.w $0B95
	ADC.w $0B91
	STA.w $0DFF
	LDA.w $0DFF
	LSR
	LSR
	CMP.w $0B8D
	BCC.b CODE_03BEB3
	LDA.w #$0000
	JMP.w CODE_03C030

CODE_03BEB3:
	LDA.w $0DFF
	LSR
	LSR
	LSR
	CMP.w $0B95
	BCC.b CODE_03BEC4
	LDA.w #$0001
	JMP.w CODE_03C030

CODE_03BEC4:
	LDA.w $0DFF
	LSR
	LSR
	LSR
	CMP.w $0B91
	BCC.b CODE_03BED5
	LDA.w #$0002
	JMP.w CODE_03C030

CODE_03BED5:
	LDA.w $0DFF
	CMP.w #$000A
	BCC.b CODE_03BEE9
	ASL
	CMP.w $0E15
	BCC.b CODE_03BEE9
	LDA.w #$0003
	JMP.w CODE_03C030

CODE_03BEE9:
	LDA.w $0DFF
	CMP.w #$0032
	BCC.b CODE_03BEFC
	CMP.w $0E17
	BCC.b CODE_03BEFC
	LDA.w #$0004
	JMP.w CODE_03C030

CODE_03BEFC:
	LDA.w $0DFF
	CMP.w #$000A
	BCC.b CODE_03BF0F
	LDA.w $0C85
	BNE.b CODE_03BF0F
	LDA.w #$0005
	JMP.w CODE_03C030

CODE_03BF0F:
	STZ.w $0BB3
	LDA.w $0B8B
	CMP.w #$01F4
	BCC.b CODE_03BF2B
	LDA.w $0E0B
	BNE.b CODE_03BF2B
	LDA.w #$0001
	STA.w $0BB3
	LDA.w #$0006
	JMP.w CODE_03C030

CODE_03BF2B:
	STZ.w $0BB7
	LDA.w $0B8F
	CMP.w #$0046
	BCC.b CODE_03BF47
	LDA.w $0E11
	BNE.b CODE_03BF47
	LDA.w #$0001
	STA.w $0BB7
	LDA.w #$0007
	JMP.w CODE_03C030

CODE_03BF47:
	STZ.w $0BB5
	LDA.w $0B93
	CMP.w #$0064
	BCC.b CODE_03BF63
	LDA.w $0E13
	BNE.b CODE_03BF63
	LDA.w #$0001
	STA.w $0BB5
	LDA.w #$0008
	JMP.w CODE_03C030

CODE_03BF63:
	LDA.w $0C07
	CMP.w #$0050
	BCC.b CODE_03BF71
	LDA.w #$001E
	JMP.w CODE_03C086

CODE_03BF71:
	CMP.w #$0041
	BCC.b CODE_03BF7C
	LDA.w #$0009
	JMP.w CODE_03C030

CODE_03BF7C:
	LDA.w $0DFB
	CMP.w #$0014
	BCC.b CODE_03BF9D
	LDA.w $0C01
	CMP.w #$0078
	BCC.b CODE_03BF92
	LDA.w #$0008
	JMP.w CODE_03C086

CODE_03BF92:
	CMP.w #$0064
	BCC.b CODE_03BF9D
	LDA.w #$000A
	JMP.w CODE_03C030

CODE_03BF9D:
	LDA.w $0DFB
	CMP.w #$003C
	BCC.b CODE_03BFB0
	LDA.w !RAM_SIMC_City_FireStationCountLo
	BNE.b CODE_03BFB0
	LDA.w #$000C
	JMP.w CODE_03C030

CODE_03BFB0:
	LDA.w $0DFB
	CMP.w #$003C
	BCC.b CODE_03BFC2
	LDA.w !RAM_SIMC_City_PoliceStationCountLo
	BNE.b CODE_03BFC2
	LDA.w #$000D
	BRA.b CODE_03C030

CODE_03BFC2:
	LDA.w !RAM_SIMC_City_TaxRateLo
	CMP.w #$000D
	BCC.b CODE_03BFCF
	LDA.w #$000F
	BRA.b CODE_03C030

CODE_03BFCF:
	LDA.w $0BC5
	CMP.w #$0014
	BCS.b CODE_03BFE4
	LDA.w $0E15
	CMP.w #$001E
	BCC.b CODE_03BFE4
	LDA.w #$0010
	BRA.b CODE_03C030

CODE_03BFE4:
	LDA.w $0BC9
	CMP.w #$02BC
	BCS.b CODE_03BFF9
	LDA.w $0DFB
	CMP.w #$0014
	BCC.b CODE_03BFF9
	LDA.w #$0011
	BRA.b CODE_03C030

CODE_03BFF9:
	LDA.w $0BC7
	CMP.w #$02BC
	BCS.b CODE_03C00E
	LDA.w $0DFB
	CMP.w #$0014
	BCC.b CODE_03C00E
	LDA.w #$0012
	BRA.b CODE_03C030

CODE_03C00E:
	LDA.w $0C05
	CMP.w #$003C
	BCC.b CODE_03C01B
	LDA.w #$0006
	BRA.b CODE_03C086

CODE_03C01B:
	CMP.w #$0032
	BCC.b CODE_03C026
	LDA.w #$000B
	JMP.w CODE_03C030

CODE_03C026:
	CPX.w #$0000
	BNE.b CODE_03C02F
	INX
	JMP.w CODE_03BE96

CODE_03C02F:
	RTS

CODE_03C030:
	LDY.w $0387
	BNE.b CODE_03C085
	CMP.w #$0006
	BCC.b CODE_03C03F
	CMP.w #$0009
	BCC.b CODE_03C044
CODE_03C03F:
	CMP.w $0381
	BEQ.b CODE_03C085
CODE_03C044:
	INC
	STA.w $0389
	LDA.w #$05CE
	STA.w $0B41
	LDA.w #$0004
	STA.w $0B43
CODE_03C054:
	LDY.w #$0019
	STY.w $0B45
	LDX.w $0B41
	LDA.w #$014B
CODE_03C060:
	LDY.w $00D7
	BNE.b CODE_03C085
	STA.l !RAM_SIMC_Global_Layer3TilemapBuffer,x
	INX
	INX
	DEC.w $0B45
	BNE.b CODE_03C060
	LDA.w $0B41
	CLC
	ADC.w #$0040
	STA.w $0B41
	DEC.w $0B43
	BNE.b CODE_03C054
	LDA.w #$012C
	STA.w $038B
CODE_03C085:
	RTS

CODE_03C086:
	CMP.w $039B
	BEQ.b CODE_03C094
	STA.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.w #$0001
	STA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
CODE_03C094:
	RTS

DATA_03C095:
	db $D0,$10,$50,$A0,$20,$FF,$A0,$C0

DATA_03C09D:
	db $07,$27,$C3,$86,$A1,$FF,$86,$27

DATA_03C0A5:
	db $00,$00,$00,$01,$07,$FF,$01,$09

CODE_03C0AD:
	REP.b #$30
	LDA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	ORA.w $00D7
	BNE.b CODE_03C0F9
	JSR.w CODE_03C0FA
	JSR.w CODE_03C3CD
	LDA.w $003E
	CMP.w #$0003
	BEQ.b CODE_03C0F9
	JSR.w CODE_03C391
	JSR.w CODE_03C405
	BCS.b CODE_03C0F9
	REP.b #$30
	JSR.w CODE_03C131
	JSR.w CODE_03C14C
	JSR.w CODE_03C186
	JSR.w CODE_03C1CE
	JSR.w CODE_03C20F
	JSR.w CODE_03C26B
	JSR.w CODE_03C291
	JSR.w CODE_03C2B7
	JSR.w CODE_03C2DD
	JSR.w CODE_03C303
	JSR.w CODE_03C327
	JSR.w CODE_03C34B
	JSR.w CODE_03C369
	JSR.w CODE_03C3AF
CODE_03C0F9:
	RTS

CODE_03C0FA:
	LDY.w $0CA5
	JSR.w CODE_03C11A
	BCC.b CODE_03C119
	INC.w $0CC9
	INC.w $0CA5
	LDA.w $0CA5
	STA.w !RAM_SIMC_City_CurrentWrightMessage
	INC
	JSR.w CODE_03C42A
	LDA.w #$0001
	STA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	PLA
CODE_03C119:
	RTS

CODE_03C11A:
	SEP.b #$20
	LDA.w !RAM_SIMC_City_CurrentPopulationLo
	CMP.w DATA_03C095,y
	LDA.w !RAM_SIMC_City_CurrentPopulationMid
	SBC.w DATA_03C09D,y
	LDA.w !RAM_SIMC_City_CurrentPopulationHi
	SBC.w DATA_03C0A5,y
	REP.b #$20
	RTS

CODE_03C131:
	LDA.w $0CA7
	BNE.b CODE_03C14B
	LDA.w $0CA5
	BEQ.b CODE_03C14B
	INC.w $0CA7
	LDA.w #$002C
	STA.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.w #$0001
	STA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	PLA
CODE_03C14B:
	RTS

CODE_03C14C:
	LDY.w $0CA9
	BNE.b CODE_03C16B
	LDA.w !RAM_SIMC_City_CityCategory
	CMP.w #!Define_SIMC_City_CityCategory_City
	BCC.b CODE_03C185
	LDA.w !RAM_SIMC_City_CurrentFundsHi
	BNE.b CODE_03C185
	LDA.w !RAM_SIMC_City_CurrentFundsLo
	CMP.w #$07D0
	BCS.b CODE_03C185
	LDA.w #$000B
	BRA.b CODE_03C178

CODE_03C16B:
	CPY.w #$0001
	BNE.b CODE_03C185
	LDA.w $0CA3
	BEQ.b CODE_03C185
	LDA.w #$001F
CODE_03C178:
	STA.w !RAM_SIMC_City_CurrentWrightMessage
	INC.w $0CA9
	LDA.w #$0001
	STA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	PLA
CODE_03C185:
	RTS

CODE_03C186:
	LDA.w $0CAB
	AND.w #$00FF
	ASL
	TAY
	LDA.w $0E15
	CMP.w DATA_03C1C0,y
	BCC.b CODE_03C19B
	INC.w $0CAB
	BRA.b CODE_03C1B2

CODE_03C19B:
	LDA.w $0CAC
	AND.w #$00FF
	ASL
	TAY
	LDA.w $0E05
	CLC
	ADC.w $0E03
	CMP.w DATA_03C1C8,y
	BCC.b CODE_03C1BF
	INC.w $0CAC
CODE_03C1B2:
	LDA.w #$000D
	STA.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.w #$0001
	STA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	PLA
CODE_03C1BF:
	RTS

DATA_03C1C0:
	dw $012C,$0190,$01F4,$FFFF

DATA_03C1C8:
	dw $0006,$000A,$FFFF

CODE_03C1CE:
	SEP.b #$20
	LDA.w $0CAE
	BEQ.b CODE_03C1EA
	DEC.w $0CAE
	REP.b #$20
	BNE.b CODE_03C208
	LDA.w #$000E
	STA.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.w #$0001
	STA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	PLA
	RTS

CODE_03C1EA:
	REP.b #$20
	LDA.w !RAM_SIMC_City_CityCategory
	BEQ.b CODE_03C208				; Note: !Define_SIMC_City_CityCategory_Village
	LDA.w $0CAD
	ASL
	TAY
	LDA.w $0E0B
	CMP.w DATA_03C209,y
	BCC.b CODE_03C208
	LDA.w $0CAD
	INC
	ORA.w #$1800
	STA.w $0CAD
CODE_03C208:
	RTS

DATA_03C209:
	dw $0001,$0003,$FFFF

CODE_03C20F:
	LDA.w $0CAF
	AND.w #$00FF
	ASL
	TAY
	LDA.w $0E27
	BEQ.b CODE_03C226
	CMP.w DATA_03C24D,y
	BCS.b CODE_03C226
	INC.w $0CAF
	BRA.b CODE_03C23F

CODE_03C226:
	LDA.w $0CB0
	AND.w #$00FF
	ASL
	TAY
	LDA.w !RAM_SIMC_City_CurrentPopulationLo
	CMP.w DATA_03C257,y
	LDA.w !RAM_SIMC_City_CurrentPopulationHi
	SBC.w DATA_03C261,y
	BCC.b CODE_03C24C
	INC.w $0CB0
CODE_03C23F:
	LDA.w #$0010
	STA.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.w #$0001
	STA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	PLA
CODE_03C24C:
	RTS

DATA_03C24D:
	dw $0096,$0064,$0032,$001E,$0000

DATA_03C257:
	dw $0D40,$D090,$93E0,$1A80,$DDD0

DATA_03C261:
	dw $0003,$0003,$0004,$0006,$0006

CODE_03C26B:
	LDA.w $0CB1
	ASL
	TAY
	LDA.w !RAM_SIMC_City_PoliceStationCountLo
	CMP.w DATA_03C289,y
	BCC.b CODE_03C288
	INC.w $0CB1
	LDA.w #$0011
	STA.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.w #$0001
	STA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	PLA
CODE_03C288:
	RTS

DATA_03C289:
	dw $0006,$000C,$0012,$FFFF

CODE_03C291:
	LDA.w $0CB3
	ASL
	TAY
	LDA.w !RAM_SIMC_City_FireStationCountLo
	CMP.w DATA_03C2AF,y
	BCC.b CODE_03C2AE
	INC.w $0CB3
	LDA.w #$0012
	STA.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.w #$0001
	STA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	PLA
CODE_03C2AE:
	RTS

DATA_03C2AF:
	dw $0006,$000C,$0012,$FFFF

CODE_03C2B7:
	LDA.w $0CB5
	ASL
	TAY
	LDA.w $0E05
	CMP.w DATA_03C2D5,y
	BCC.b CODE_03C2D4
	INC.w $0CB5
	LDA.w #$0018
	STA.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.w #$0001
	STA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	PLA
CODE_03C2D4:
	RTS

DATA_03C2D5:
	dw $0003,$0006,$0009,$FFFF

CODE_03C2DD:
	LDA.w $0CB7
	ASL
	TAY
	LDA.w $0E23
	CMP.w DATA_03C2FB,y
	BCC.b CODE_03C2FA
	INC.w $0CB7
	LDA.w #$0019
	STA.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.w #$0001
	STA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	PLA
CODE_03C2FA:
	RTS

DATA_03C2FB:
	dw $012C,$0258,$0384,$FFFF

CODE_03C303:
	LDA.w $0CB9
	ASL
	TAY
	LDA.w $0E17
	CMP.w DATA_03C321,y
	BCC.b CODE_03C320
	INC.w $0CB9
	LDA.w #$001A
	STA.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.w #$0001
	STA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	PLA
CODE_03C320:
	RTS

DATA_03C321:
	dw $01F4,$07D0,$FFFF

CODE_03C327:
	LDA.w $0CBB
	ASL
	TAY
	LDA.w $0E1B
	CMP.w DATA_03C345,y
	BCC.b CODE_03C344
	INC.w $0CBB
	LDA.w #$0017
	STA.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.w #$0001
	STA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	PLA
CODE_03C344:
	RTS

DATA_03C345:
	dw $0096,$01F4,$FFFF

CODE_03C34B:
	LDA.w $0CBD
	BNE.b CODE_03C368
	LDA.w !RAM_SIMC_City_CityCategory
	CMP.w #!Define_SIMC_City_CityCategory_Megalopolis
	BCC.b CODE_03C368
	INC.w $0CBD
	LDA.w #$0014
	STA.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.w #$0001
	STA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	PLA
CODE_03C368:
	RTS

CODE_03C369:
	LDA.w !RAM_SIMC_City_CityCategory
	CMP.w #!Define_SIMC_City_CityCategory_City
	BCC.b CODE_03C390
	LDA.w $0CBF
	BNE.b CODE_03C390
	LDA.w $0E13
	BEQ.b CODE_03C390
	LDA.w $0E11
	BEQ.b CODE_03C390
	INC.w $0CBF
	LDA.w #$0016
	STA.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.w #$0001
	STA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	PLA
CODE_03C390:
	RTS

CODE_03C391:
	LDA.w $0CC3
	BNE.b CODE_03C3AE
	LDA.w !RAM_SIMC_City_CityCategory
	CMP.w #!Define_SIMC_City_CityCategory_Capital
	BCC.b CODE_03C3AE
	INC.w $0CC3
	LDA.w #$000C
	STA.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.w #$0001
	STA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	PLA
CODE_03C3AE:
	RTS

CODE_03C3AF:
	LDA.w $0CC1
	BNE.b CODE_03C3CC
	LDA.w !RAM_SIMC_City_CurrentYearLo
	CMP.w #!Define_SIMC_City_50YearAnniversaryDate
	BCC.b CODE_03C3CC
	INC.w $0CC1
	LDA.w #$0013
	STA.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.w #$0001
	STA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	PLA
CODE_03C3CC:
	RTS

CODE_03C3CD:
	LDA.w $0CC5
	BNE.b CODE_03C404
	LDY.w #$0006
	LDA.w $003E
	CMP.w #$0001
	BEQ.b CODE_03C3DE
	INY
CODE_03C3DE:
	JSR.w CODE_03C11A
	BCC.b CODE_03C404
	INC.w $0CC5
	LDA.w #$0031
	LDY.w $003E
	CPY.w #$0001
	BEQ.b CODE_03C3FA
	LDA.w #$0013
	JSR.w CODE_03C42A
	LDA.w #$002F
CODE_03C3FA:
	STA.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.w #$0001
	STA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	PLA
CODE_03C404:
	RTS

CODE_03C405:
	SEP.b #$30
	LDY.b #$00
CODE_03C409:
	LDA.w $03F5,y
	BEQ.b CODE_03C413
	INY
	CPY.b #$04
	BNE.b CODE_03C409
CODE_03C413:
	LDA.w !RAM_SIMC_City_CityCategory
	BEQ.b CODE_03C41E			; Note: !Define_SIMC_City_CityCategory_Village
	CPY.b #$04
	BCS.b CODE_03C424
	BCC.b CODE_03C422			; Note: This will always branch.

CODE_03C41E:
	CPY.b #$03
	BCS.b CODE_03C424
CODE_03C422:
	CLC
	RTS

CODE_03C424:
	SEC
	RTS

CODE_03C426:
	JSR.w CODE_03C42A
	RTL

CODE_03C42A:
	REP.b #$30
	PHA
	LDX.w #$0000
CODE_03C430:
	LDA.w $0CED,x
	CMP.w #$FFFF
	BEQ.b CODE_03C463
	TXA
	CLC
	ADC.w #$0006
	TAX
	CPX.w #$003C
	BNE.b CODE_03C430
	LDX.w #$0000
CODE_03C446:
	LDA.w $0CF3,x
	STA.w $0CED,x
	LDA.w $0CF5,x
	STA.w $0CEF,x
	LDA.w $0CF7,x
	STA.w $0CF1,x
	TXA
	CLC
	ADC.w #$0006
	TAX
	CPX.w #$0036
	BNE.b CODE_03C446
CODE_03C463:
	PLA
	STA.w $0CED,x
	LDA.w !RAM_SIMC_City_CurrentYearLo
	STA.w $0CEF,x
	LDA.w !RAM_SIMC_City_CurrentMonthLo
	STA.w $0CF1,x
	RTS

CODE_03C474:
	REP.b #$30
	LDA.w $003E
	CMP.w #$0001
	BNE.b CODE_03C4DB
	LDA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	ORA.w $00D7
	BNE.b CODE_03C4DB
	LDA.w $0CC7
	CMP.w #$0006
	BEQ.b CODE_03C4DB
	ASL
	TAY
	LDA.w !RAM_SIMC_City_CurrentYearLo
	CMP.w DATA_03C4DC,y
	BEQ.b CODE_03C49C
	BCS.b CODE_03C4A4
	BCC.b CODE_03C4DB			; Note: This will always branch.

CODE_03C49C:
	LDA.w !RAM_SIMC_City_CurrentMonthLo
	CMP.w DATA_03C4E8,y
	BCC.b CODE_03C4DB
CODE_03C4A4:
	INC.w $0CC7
	CPY.w #$000A
	BEQ.b CODE_03C4B9
	LDA.w DATA_03C4F4,y
	STA.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.w #$0001
	STA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	RTS

CODE_03C4B9:
	LDA.w #$0027
	LDX.w !RAM_SIMC_City_CurrentPopulationHi
	BNE.b CODE_03C4C9
	LDX.w !RAM_SIMC_City_CurrentPopulationLo
	CPX.w #$7530
	BCC.b CODE_03C4D2
CODE_03C4C9:
	LDA.w #$0001
	JSR.w CODE_03C42A
	LDA.w #$0026
CODE_03C4D2:
	STA.w !RAM_SIMC_City_CurrentWrightMessage
	LDA.w #$0001
	STA.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
CODE_03C4DB:
	RTS

DATA_03C4DC:
	dw $076C,$076C,$076C,$076D,$076D,$0771

DATA_03C4E8:
	dw !Define_SIMC_City_Month_January,!Define_SIMC_City_Month_June,!Define_SIMC_City_Month_November,!Define_SIMC_City_Month_January,!Define_SIMC_City_Month_June,!Define_SIMC_City_Month_January

DATA_03C4F4:
	dw $001B,$002E,$0032,$001C,$0033,$0026

CODE_03C500:
	REP.b #$30
	LDA.w $003E
	CMP.w #$0003
	BEQ.b CODE_03C50B
CODE_03C50A:
	RTS

CODE_03C50B:
	LDA.w $0CCB
	ASL
	TAX
	LDA.w !RAM_SIMC_Global_CurrentScenario
	ASL
	TAY
	LDA.w DATA_03C5B3,y
	SEC
	SBC.w !RAM_SIMC_City_CurrentYearLo
	BCS.b CODE_03C521
	LDA.w #$0000
CODE_03C521:
	CMP.w DATA_03C5C3,x
	BEQ.b CODE_03C528
	BCS.b CODE_03C50A
CODE_03C528:
	INC.w $0CCB
	CPX.w #$000A
	BEQ.b CODE_03C548
	LDA.w $00D7
	ORA.w $0AB5
	BNE.b CODE_03C547
	LDA.w DATA_03C5DB,x
	JSR.w CODE_03C030
	SEP.b #$20
	LDA.b #$26
	STA.w $0006
	REP.b #$20
CODE_03C547:
	RTS

CODE_03C548:
	LDA.w !RAM_SIMC_City_CityCategory
	CMP.w #!Define_SIMC_City_CityCategory_Metropolis
	BCC.b CODE_03C5AC
	LDY.w !RAM_SIMC_Global_CurrentScenario
	BNE.b CODE_03C557
	BRA.b CODE_03C5A7

CODE_03C557:
	CPY.w #!Define_SIMC_Global_Scenario_Bern
	BNE.b CODE_03C566
	LDA.w $0C05
	CMP.w #$0050
	BCC.b CODE_03C5A7
	BRA.b CODE_03C5AC

CODE_03C566:
	CPY.w #!Define_SIMC_Global_Scenario_Tokyo
	BNE.b CODE_03C575
	LDA.w !RAM_SIMC_City_CurrentCityScoreLo
	CMP.w #$01F4
	BCS.b CODE_03C5A7
	BRA.b CODE_03C5AC

CODE_03C575:
	CPY.w #!Define_SIMC_Global_Scenario_Detroit
	BNE.b CODE_03C584
	LDA.w $0C01
	CMP.w #$003C
	BCC.b CODE_03C5A7
	BRA.b CODE_03C5AC

CODE_03C584:
	CPY.w #!Define_SIMC_Global_Scenario_Boston
	BNE.b CODE_03C593
	LDA.w !RAM_SIMC_City_CurrentCityScoreLo
	CMP.w #$01F4
	BCS.b CODE_03C5A7
	BRA.b CODE_03C5AC

CODE_03C593:
	CPY.w #!Define_SIMC_Global_Scenario_RioDeJaneiro
	BNE.b CODE_03C5A2
	LDA.w !RAM_SIMC_City_CurrentCityScoreLo
	CMP.w #$01F4
	BCS.b CODE_03C5A7
	BRA.b CODE_03C5AC

CODE_03C5A2:
	CPY.w #!Define_SIMC_Global_Scenario_LasVegas
	BNE.b CODE_03C5B2
CODE_03C5A7:
	LDA.w #$0002
	BRA.b CODE_03C5AF

CODE_03C5AC:
	LDA.w #$0001
CODE_03C5AF:
	STA.w $0D87
CODE_03C5B2:
	RTS

DATA_03C5B3:
	dw $0777,$07B7,$07AE,$07BE,$07DF,$0809,$083A,$FFFF

DATA_03C5C3:
	dw $0005,$0004,$0003,$0002,$0001,$0000,$00F0,$00C0
	dw $0090,$0060,$0030,$0000

DATA_03C5DB:
	dw $0014,$0015,$0016,$0018,$0019

CODE_03C5E5:
	REP.b #$30
	JSR.w CODE_03C8A1
	RTS

CODE_03C5EB:
	REP.b #$30
	LDA.w !RAM_SIMC_Global_CurrentScenario
	PHA
	LDA.w #!Define_SIMC_Global_Scenario_PracticeCity
	STA.w !RAM_SIMC_Global_CurrentScenario
	JSR.w CODE_03CE2E
	REP.b #$30
	PLA
	STA.w !RAM_SIMC_Global_CurrentScenario
	LDY.w #$0010
	JSR.w CODE_03CF19
	LDA.w #!Define_SIMC_City_PracticeCityStartingYear
	STA.w !RAM_SIMC_City_CurrentYearLo
	LDA.w #!Define_SIMC_City_Month_January
	STA.w !RAM_SIMC_City_CurrentMonthLo
	STZ.w !RAM_SIMC_City_DifficultyLevel
	LDA.w #!Define_SIMC_City_PracticeCityStartingMoney
	STA.w !RAM_SIMC_City_CurrentFundsLo
	STZ.w !RAM_SIMC_City_CurrentFundsHi
	JSR.w CODE_03C6A1
	LDA.w #$0000
	JSR.w CODE_03C42A
	LDA.w #$002F
	STA.w $01BD
	LDA.w #$0022
	STA.w $01BF
	JSR.w CODE_03C79D
	LDA.w #$0001
	STA.w $0038
	RTS

CODE_03C63D:
	REP.b #$30
	LDA.w #!Define_SIMC_City_BaseStartingYear
	STA.w !RAM_SIMC_City_CurrentYearLo
	LDA.w #!Define_SIMC_City_Month_January
	STA.w !RAM_SIMC_City_CurrentMonthLo
	LDA.w !RAM_SIMC_City_DifficultyLevel
	ASL
	TAY
	LDA.w DATA_03C691,y
	STA.w !RAM_SIMC_City_CurrentFundsLo
	LDA.w DATA_03C699,y
	STA.w !RAM_SIMC_City_CurrentFundsHi
	LDA.w !RAM_SIMC_City_DifficultyLevel
	CMP.w #$0003
	BNE.b CODE_03C667
	STZ.w !RAM_SIMC_City_DifficultyLevel
CODE_03C667:
	JSR.w CODE_03C6A1
	LDA.w #$0000
	JSR.w CODE_03C42A
	JSR.w CODE_03C79D
	RTS

CODE_03C674:
	REP.b #$30
	JSR.w CODE_03CE2E
	JSR.w CODE_03C6A1
	JSR.w CODE_03CE8B
	LDA.w #$0000
	JSR.w CODE_03C42A
	REP.b #$30
	LDA.w #$0002
	STA.w $01E7
	JSR.w CODE_03C79D
	RTS

DATA_03C691:
	dw $4E20,$2710,$1388,$423F

DATA_03C699:
	dw $0000,$0000,$0000,$000F

CODE_03C6A1:
	REP.b #$30
	LDX.w #$0000
CODE_03C6A6:
	LDA.w #$0000
	STA.l $7F5FC0,x
	STA.l $7F6560,x
	STA.l $7F60B0,x
	STA.l $7F6650,x
	STA.l $7F61A0,x
	STA.l $7F6740,x
	STA.l $7F6470,x
	STA.l $7F6A10,x
	STA.l $7F6290,x
	STA.l $7F6830,x
	LDA.w #$0080
	STA.l $7F6380,x
	STA.l $7F6920,x
	INX
	INX
	CPX.w #$00F0
	BNE.b CODE_03C6A6
	LDX.w #$0000
CODE_03C6E6:
	LDA.w #$FFFF
	STA.w $0CED,x
	TXA
	CLC
	ADC.w #$0006
	TAX
	CPX.w #$003C
	BNE.b CODE_03C6E6
	LDA.w #$01F4
	STA.w !RAM_SIMC_City_CurrentCityScoreLo
	LDA.w #$000D
	STA.w $0195
	LDA.w #$0002
	STA.w $0193
	LDA.w #!Define_SIMC_City_InitialTaxPercent
	STA.w !RAM_SIMC_City_TaxRateLo
	STZ.w $0B8B
	STZ.w $0B93
	STZ.w $0B8F
	STZ.w $0BAD
	STZ.w $0BAF
	STZ.w $0BB1
	STZ.w $0C6D
	STZ.w $0C6F
	STZ.w $0C03
	STZ.w $0C01
	STZ.w $0C07
	STZ.w !RAM_SIMC_City_CityCategory
	STZ.w $0DC7
	STZ.w !RAM_SIMC_City_CurrentPopulationLo
	STZ.w !RAM_SIMC_City_CurrentPopulationHi
	STZ.w $0CA5
	STZ.w $0CC9
	STZ.w $0CA7
	STZ.w $0CA9
	STZ.w $0CAB
	STZ.w $0CAD
	STZ.w $0CAF
	STZ.w $0CB1
	STZ.w $0CB3
	STZ.w $0CB5
	STZ.w $0CB7
	STZ.w $0CB9
	STZ.w $0CBB
	STZ.w $0CBD
	STZ.w $0CBF
	STZ.w $0CC3
	STZ.w $0CC1
	STZ.w $0CC5
	STZ.w $0CCB
	STZ.w $0199
	STZ.w $0197
	STZ.w $0B01
	STZ.w $0B51
	STZ.w $0B1D
	STZ.w $03F5
	STZ.w $03F7
	STZ.w $01E7
	LDA.w #$FFFF
	STA.w $01BD
	STA.w $01BF
	STZ.w $0CC7
	STZ.w !RAM_SIMC_City_TriggerWrightMessageFlagLo
	RTS

CODE_03C79D:
	REP.b #$30
	JSR.w CODE_03C89C
	LDA.w #$0020
	STA.w $0BC5
	LDA.w #$03E8
	STA.w $0BC7
	STA.w $0BC9
	STZ.w $0DD3
	STZ.w $0DD5
	STZ.w $0DD7
	STZ.w $0DC3
	STZ.w $0BB3
	STZ.w $0BB5
	STZ.w $0BB7
	STZ.w $0A91
	STZ.w $0A8B
	STZ.w $0A8F
	STZ.w $0A8D
	STZ.w $0A93
	STZ.w $0A95
	STZ.w $0AEF
	STZ.w $0AF1
	STZ.w $0D87
	STZ.w $0DC9
	STZ.w $0DCB
	LDA.w #!Define_SIMC_City_InitialDeptFundingPercent
	STA.w !RAM_SIMC_City_TransportFundingLevelLo
	STA.w !RAM_SIMC_City_PoliceFundingLevelLo
	STA.w !RAM_SIMC_City_FireFundingLevelLo
	STZ.w $0C73
	STZ.w $0C75
	STZ.w $0C77
	STZ.w $0C7F
	STZ.w $0C81
	STZ.w $0C83
	STZ.w $0C79
	STZ.w $0C7B
	STZ.w $0C7D
	STZ.w $0C85
	STZ.w $0C87
	STZ.w $0C89
	STZ.w $0C8B
	STZ.w $0C8D
	STZ.w $0C8F
	STZ.w $0C91
	STZ.w $0C93
	STZ.w $0C95
	STZ.w $0C97
	STZ.w $0C99
	STZ.w $0C9B
	STZ.w $0C9D
	STZ.w $0C9F
	STZ.w $0038
	STZ.w $0E21
	STZ.w $0BCD
	STZ.w $0BCF
	STZ.w !RAM_SIMC_City_LastYearsNetMigrationLo
	STZ.w !RAM_SIMC_City_LastYearsNetMigrationHi
	STZ.w !RAM_SIMC_City_1stWorstProblemPercent
	STZ.w !RAM_SIMC_City_2ndWorstProblemPercent
	SEP.b #$20
	LDA.b #$01
	STA.w $003A
	LDA.b #$3C
	STA.w $0BA9
	LSR
	STA.w $0BAB
	LDA.b #$32
	STA.w $0BAA
	LSR
	STA.w $0BAC
	REP.b #$20
	LDA.w #$0000
	STA.w $0B4D
	LDA.w #$0000
	LDX.w #$0000
CODE_03C877:
	STA.l $7F6B00,x
	INX
	CPX.w #$8DF4
	BNE.b CODE_03C877
	JSR.w CODE_03B477
	JSL.l CODE_00823A
	REP.b #$30
	LDA.w !RAM_SIMC_City_CurrentYearLo
	SEC
	SBC.w #$000A
	STA.w $0DA9
	SEC
	SBC.w #$006E
	STA.w $0DAB
	RTS

CODE_03C89C:
	RTS

CODE_03C89D:
	JSR.w CODE_03C8A1
	RTL

CODE_03C8A1:
	SEP.b #$20
	SEP.b #$20
	LDA.w $00B3
	AND.b #$7F
	STA.w $00B1
	REP.b #$30
	PHB
	LDX.w #$700C00
	LDA.w $0421
	CMP.w #$0001
	BEQ.b CODE_03C8BE
	LDX.w #$704BF0
CODE_03C8BE:
	LDY.w #!RAM_SIMC_Global_GeneralPurposeBuffer
	LDA.w #$33FF
	MVN !RAM_SIMC_Global_GeneralPurposeBuffer>>16,$700C00>>16
	PLB
	JSR.w CODE_03D15F
	JSR.w CODE_03C8E1
	SEP.b #$20
	SEP.b #$20
	LDA.w $00B3
	ORA.b #$80
	STA.w $00B1
	JSR.w CODE_03C79D
	STZ.w $003A
	RTS

CODE_03C8E1:						; Note: Load save file routine.
	REP.b #$30
	LDX.w #$0000
	LDA.w $0421
	CMP.w #$0001
	BEQ.b CODE_03C8F1
	LDX.w #$3FF0
CODE_03C8F1:
	LDA.l $700010,x
	STA.w $0B8B
	LDA.l $700012,x
	STA.w $0B93
	LDA.l $700014,x
	STA.w $0B8F
	LDA.l $700016,x
	STA.w $0BAD
	LDA.l $700018,x
	STA.w $0BAF
	LDA.l $70001A,x
	STA.w $0BB1
	LDA.l $70001C,x
	STA.w $0C6D
	LDA.l $70001E,x
	STA.w $0C6F
	LDA.l $700020,x
	STA.w $0C03
	LDA.l $700022,x
	STA.w $0C01
	LDA.l $700024,x
	STA.w $0C07
	LDA.l $700026,x
	STA.w !RAM_SIMC_City_DifficultyLevel
	LDA.l $700028,x
	STA.w !RAM_SIMC_City_CurrentFundsLo
	LDA.l $70002A,x
	STA.w !RAM_SIMC_City_CurrentFundsHi
	LDA.l $70002C,x
	STA.w $0193
	LDA.l $70002E,x
	STA.w $0195
	LDA.l $700030,x
	STA.w !RAM_SIMC_City_CurrentYearLo
	LDA.l $700032,x
	STA.w !RAM_SIMC_City_CurrentMonthLo
	LDA.l $700034,x
	STA.w !RAM_SIMC_City_TaxRateLo
	LDA.l $700036,x
	STA.w !RAM_SIMC_City_CityCategory
	LDA.l $700038,x
	STA.w !RAM_SIMC_City_CurrentCityScoreLo
	LDA.l $70003A,x
	STA.w $0DC7
	LDA.l $70003C,x
	STA.w !RAM_SIMC_City_CurrentPopulationLo
	LDA.l $70003E,x
	STA.w !RAM_SIMC_City_CurrentPopulationHi
	LDA.l $700040,x
	STA.w $0CA7
	LDA.l $700042,x
	STA.w $0CA9
	LDA.l $700044,x
	STA.w $0CAB
	LDA.l $700046,x
	STA.w $0CAD
	LDA.l $700048,x
	STA.w $0CAF
	LDA.l $70004A,x
	STA.w $0CB1
	LDA.l $70004C,x
	STA.w $0CB3
	LDA.l $70004E,x
	STA.w $0CB5
	LDA.l $700050,x
	STA.w $0CB7
	LDA.l $700052,x
	STA.w $0CB9
	LDA.l $700054,x
	STA.w $0B51
	SEP.b #$20
	LDA.l $700056,x
	STA.w $0CBB
	LDA.l $700057,x
	STA.w $0CBD
	LDA.l $700058,x
	STA.w $0CBF
	LDA.l $700059,x
	STA.w $0CCB
	LDA.l $70005A,x
	STA.w $0CC3
	LDA.l $70005B,x
	STA.w $0CC7
	LDA.l $70005C,x
	STA.w $0CC1
	LDA.l $70005D,x
	STA.w $0CC5
	REP.b #$20
	LDA.l $70005E,x
	STA.w $0B1D
	LDA.l $700060,x
	STA.w $03F5
	LDA.l $700062,x
	STA.w $03F7
	LDA.l $700064,x
	STA.w $01E7
	LDA.l $700066,x
	STA.w $01BD
	LDA.l $700068,x
	STA.w $01BF
	LDA.l $70006A,x
	STA.w $0CA5
	LDA.l $70006C,x
	STA.w $003E
	LDA.l $70006E,x
	STA.w $0199
	LDA.l $700070,x
	STA.w !RAM_SIMC_Global_CurrentScenario
	LDA.l $700072,x
	STA.w $0C0D
	LDA.l $700074,x
	STA.w $0B01
	LDA.l $700076,x
	STA.w $0B5B
	LDA.l $700078,x
	STA.w $0B5D
	LDA.l $70007A,x
	STA.w $0B5F
	LDA.l $70007C,x
	STA.w $0B61
	LDA.l $70007E,x
	STA.w $0B63
	LDA.l $700080,x
	STA.w !RAM_SIMC_Global_MapNumOnesDigit
	SEP.b #$20
	LDA.l $700082,x
	STA.w !RAM_SIMC_Global_MapNumHundredsDigit
	REP.b #$20
	PHX
	LDY.w #$0000
CODE_03CAAF:
	LDA.l $700084,x
	STA.w $0CED,y
	INX
	INX
	INY
	INY
	CPY.w #$003C
	BNE.b CODE_03CAAF
	PLX
	STZ.w $0C63
	STZ.w $0C6B
	LDY.w #$0000
CODE_03CAC9:
	LDA.l $7000C0,x
	PHX
	TYX
	STA.l $7F5FC0,x
	CMP.w $0C63
	BCC.b CODE_03CADB
	STA.w $0C63
CODE_03CADB:
	PLX
	LDA.l $700660,x
	PHX
	TYX
	STA.l $7F6560,x
	CMP.w $0C6B
	BCC.b CODE_03CAEE
	STA.w $0C6B
CODE_03CAEE:
	PLX
	INX
	INX
	INY
	INY
	CPY.w #$05A0
	BNE.b CODE_03CAC9
	RTS

CODE_03CAF9:
	JSR.w CODE_03CAFD
	RTL

CODE_03CAFD:
	SEP.b #$20
	SEP.b #$20
	LDA.w $00B3
	AND.b #$7F
	STA.w $00B1
	REP.b #$30
	STZ.w $0048
	JSR.w CODE_03CF82
	LDA.w $0B47
	CMP.w #$3400
	BCS.b CODE_03CB34
	PHB
	LDY.w #$700C00
	LDA.w $0423
	CMP.w #$0001
	BEQ.b CODE_03CB28
	LDY.w #$704BF0
CODE_03CB28:
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer
	LDA.w #$33FF
	MVN $700C00>>16,!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	PLB
	BRA.b CODE_03CBAA

CODE_03CB34:
	LDA.w #$001F
	STA.w $0381
	PHD
	LDA.w #$0000
	TCD
	JSL.l CODE_0194E2
	PLD
	SEP.b #$20
	SEP.b #$20
	LDA.w $00B3
	ORA.b #$80
	STA.w $00B1
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	SEP.b #$20
	SEP.b #$20
	LDA.w $00B3
	AND.b #$7F
	STA.w $00B1
	REP.b #$20
	JSR.w CODE_03D056
	LDA.w $0B47
	CMP.w #$3400
	BCC.b CODE_03CBAA
	LDX.w $0423
	SEP.b #$20
	LDA.b #$00
	STA.l $700004,x
	REP.b #$20
	LDA.w $0423
	EOR.w #$FFFF
	AND.w $0044
	STA.w $0044
	JSR.w CODE_03E553
	LDY.w #$FFFF
	LDA.w $0423
	CMP.w #$0002
	BEQ.b CODE_03CB9C
	STY.w $0B65
	BRA.b CODE_03CB9F

CODE_03CB9C:
	STY.w $0B75
CODE_03CB9F:
	LDA.w #$0001
	STA.w $0048
	LDA.w #$001D
	BRA.b CODE_03CBD5

CODE_03CBAA:
	JSR.w CODE_03CC17
	LDX.w $0423
	SEP.b #$20
	LDA.b #$01
	STA.l $700004,x
	REP.b #$20
	LDA.w $0423
	ORA.w $0044
	STA.w $0044
	JSR.w CODE_03E50C
	JSR.w CODE_03E553
	SEP.b #$20
	LDA.b #$17
	STA.w $0006
	REP.b #$20
	LDA.w #$001E
CODE_03CBD5:
	STA.w $0381
	PHD
	LDA.w #$0000
	TCD
	JSL.l CODE_0194E2
	PLD
	SEP.b #$20
	SEP.b #$20
	LDA.w $00B3
	ORA.b #$80
	STA.w $00B1
	REP.b #$20
	LDY.w #$0078
CODE_03CBF3:
	PHY
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	PLY
	DEY
	BNE.b CODE_03CBF3
	LDA.w #$0001
	STA.w $0385
	PHD
	LDA.w #$0000
	TCD
	JSL.l CODE_0194A3
	PLD
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	RTS

CODE_03CC17:
	REP.b #$30
	LDX.w #$0000
	TXY
	LDA.w $0423
	CMP.w #$0001
	BEQ.b CODE_03CC2B
	LDX.w #$3FF0
	LDY.w #$0010
CODE_03CC2B:
	LDA.w $0B8B
	STA.l $700010,x
	LDA.w $0B93
	STA.l $700012,x
	LDA.w $0B8F
	STA.l $700014,x
	LDA.w $0BAD
	STA.l $700016,x
	LDA.w $0BAF
	STA.l $700018,x
	LDA.w $0BB1
	STA.l $70001A,x
	LDA.w $0C6D
	STA.l $70001C,x
	LDA.w $0C6F
	STA.l $70001E,x
	LDA.w $0C03
	STA.l $700020,x
	LDA.w $0C01
	STA.l $700022,x
	LDA.w $0C07
	STA.l $700024,x
	LDA.w !RAM_SIMC_City_DifficultyLevel
	STA.l $700026,x
	LDA.w !RAM_SIMC_City_CurrentFundsLo
	STA.l $700028,x
	LDA.w !RAM_SIMC_City_CurrentFundsHi
	STA.l $70002A,x
	LDA.w $0193
	STA.l $70002C,x
	LDA.w $0195
	STA.l $70002E,x
	LDA.w !RAM_SIMC_City_CurrentYearLo
	STA.l $700030,x
	STA.w $0B67,y
	LDA.w !RAM_SIMC_City_CurrentMonthLo
	STA.l $700032,x
	STA.w $0B69,y
	LDA.w !RAM_SIMC_City_TaxRateLo
	STA.l $700034,x
	LDA.w !RAM_SIMC_City_CityCategory
	STA.l $700036,x
	STA.w $0B65,y
	LDA.w !RAM_SIMC_City_CurrentCityScoreLo
	STA.l $700038,x
	LDA.w $0DC7
	STA.l $70003A,x
	LDA.w !RAM_SIMC_City_CurrentPopulationLo
	STA.l $70003C,x
	LDA.w !RAM_SIMC_City_CurrentPopulationHi
	STA.l $70003E,x
	LDA.w $0CA7
	STA.l $700040,x
	LDA.w $0CA9
	STA.l $700042,x
	LDA.w $0CAB
	STA.l $700044,x
	LDA.w $0CAD
	STA.l $700046,x
	LDA.w $0CAF
	STA.l $700048,x
	LDA.w $0CB1
	STA.l $70004A,x
	LDA.w $0CB3
	STA.l $70004C,x
	LDA.w $0CB5
	STA.l $70004E,x
	LDA.w $0CB7
	STA.l $700050,x
	LDA.w $0CB9
	STA.l $700052,x
	LDA.w $0B51
	STA.l $700054,x
	SEP.b #$20
	LDA.w $0CBB
	STA.l $700056,x
	LDA.w $0CBD
	STA.l $700057,x
	LDA.w $0CBF
	STA.l $700058,x
	LDA.w $0CCB
	STA.l $700059,x
	LDA.w $0CC3
	STA.l $70005A,x
	LDA.w $0CC7
	STA.l $70005B,x
	LDA.w $0CC1
	STA.l $70005C,x
	LDA.w $0CC5
	STA.l $70005D,x
	REP.b #$20
	LDA.w $0B1D
	STA.l $70005E,x
	LDA.w $03F5
	STA.l $700060,x
	LDA.w $03F7
	STA.l $700062,x
	LDA.w $01E7
	STA.l $700064,x
	LDA.w $01BD
	STA.l $700066,x
	LDA.w $01BF
	STA.l $700068,x
	LDA.w $0CA5
	STA.l $70006A,x
	LDA.w $003E
	STA.l $70006C,x
	LDA.w $0A91
	ASL
	ORA.w $0A8B
	ASL
	STA.l $70006E,x
	LDA.w !RAM_SIMC_Global_CurrentScenario
	STA.l $700070,x
	LDA.w $0C0D
	STA.l $700072,x
	LDA.w $0B01
	STA.l $700074,x
	LDA.w $0B5B
	STA.l $700076,x
	STA.w $0B6B,y
	LDA.w $0B5D
	STA.l $700078,x
	STA.w $0B6D,y
	LDA.w $0B5F
	STA.l $70007A,x
	STA.w $0B6F,y
	LDA.w $0B61
	STA.l $70007C,x
	STA.w $0B71,y
	LDA.w $0B63
	STA.l $70007E,x
	STA.w $0B73,y
	LDA.w !RAM_SIMC_Global_MapNumOnesDigit
	STA.l $700080,x
	LDA.w !RAM_SIMC_Global_MapNumHundredsDigit
	AND.w #$00FF
	STA.l $700082,x
	PHX
	LDY.w #$0000
CODE_03CE05:
	LDA.w $0CED,y
	STA.l $700084,x
	INX
	INX
	INY
	INY
	CPY.w #$003C
	BNE.b CODE_03CE05
	PLX
	LDY.w #$0000
CODE_03CE19:
	PHX
	TYX
	LDA.l $7F5FC0,x
	PLX
	STA.l $7000C0,x
	INX
	INX
	INY
	INY
	CPY.w #$0B40
	BNE.b CODE_03CE19
	RTS

CODE_03CE2E:
	SEP.b #$20
	REP.b #$10
	SEP.b #$20
	LDA.w $00B3
	AND.b #$7F
	STA.w $00B1
	LDY.w !RAM_SIMC_Global_CurrentScenario
	LDA.w DATA_03CE70,y
	STA.w $0009
	LDA.w DATA_03CE79,y
	STA.w $000A
	LDA.w DATA_03CE82,y
	STA.w $000B
	LDX.w #$0000
	STX.w $000E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	JSR.w CODE_03D15F
	SEP.b #$20
	REP.b #$10
	SEP.b #$20
	LDA.w $00B3
	ORA.b #$80
	STA.w $00B1
	RTS

DATA_03CE70:
	db DATA_0D9F23,DATA_0CE30B,DATA_0C8F27,DATA_0CC5A2,DATA_0CA8E8,DATA_0D816E,DATA_0DB987,DATA_0DCB15,DATA_0DD131

DATA_03CE79:
	db DATA_0D9F23>>8,DATA_0CE30B>>8,DATA_0C8F27>>8,DATA_0CC5A2>>8,DATA_0CA8E8>>8,DATA_0D816E>>8,DATA_0DB987>>8,DATA_0DCB15>>8,DATA_0DD131>>8

DATA_03CE82:
	db DATA_0D9F23>>16,DATA_0CE30B>>16,DATA_0C8F27>>16,DATA_0CC5A2>>16,DATA_0CA8E8>>16,DATA_0D816E>>16,DATA_0DB987>>16,DATA_0DCB15>>16,DATA_0DD131>>16

CODE_03CE8B:
	REP.b #$30
	LDA.w !RAM_SIMC_Global_CurrentScenario
	ASL
	TAY
	LDA.w DATA_03CEC9,y
	STA.w $0C0D
	LDA.w DATA_03CED9,y
	STA.w !RAM_SIMC_City_CurrentYearLo
	LDA.w DATA_03CEE9,y
	STA.w !RAM_SIMC_City_CityCategory
	STA.w $0CA5
	LDA.w DATA_03CEF9,y
	STA.w !RAM_SIMC_City_CurrentPopulationLo
	LDA.w DATA_03CF09,y
	STA.w !RAM_SIMC_City_CurrentPopulationHi
	JSR.w CODE_03CF19
	LDA.w #!Define_SIMC_City_Month_January
	STA.w !RAM_SIMC_City_CurrentMonthLo
	LDA.w #!Define_SIMC_City_ScenarioStartingMoney
	STA.w !RAM_SIMC_City_CurrentFundsLo
	STZ.w !RAM_SIMC_City_CurrentFundsHi
	STZ.w !RAM_SIMC_City_DifficultyLevel
	RTS

DATA_03CEC9:
	dw $000A,$0014,$0005,$0003,$0001,$0102,$0180,$000A

DATA_03CED9:
	dw !Define_SIMC_City_SanFranciscoScenarioStartingYear
	dw !Define_SIMC_City_BernScenarioStartingYear
	dw !Define_SIMC_City_TokyoScenarioStartingYear
	dw !Define_SIMC_City_DetroitScenarioStartingYear
	dw !Define_SIMC_City_BostonScenarioStartingYear
	dw !Define_SIMC_City_RioDeJaneriroScenarioStartingYear
	dw !Define_SIMC_City_LasVegasScenarioStartingYear
	dw !Define_SIMC_City_FreeCityScenarioStartingYear

DATA_03CEE9:
	dw !Define_SIMC_City_CityCategory_Metropolis
	dw !Define_SIMC_City_CityCategory_Capital
	dw !Define_SIMC_City_CityCategory_Metropolis
	dw !Define_SIMC_City_CityCategory_Capital
	dw !Define_SIMC_City_CityCategory_Capital
	dw !Define_SIMC_City_CityCategory_Metropolis
	dw !Define_SIMC_City_CityCategory_Capital
	dw !Define_SIMC_City_CityCategory_Village

DATA_03CEF9:
	dw $A0B8,$73E0,$B4E0,$2908,$2ED0,$53A0,$3FB0,$0000

DATA_03CF09:
	dw $0001,$0001,$0001,$0001,$0001,$0002,$0001,$0000

CODE_03CF19:
	LDA.w DATA_03CF32,y
	STA.w $0079
	SEP.b #$30
	LDY.b #$00
	LDA.b ($79),y
	TAX
CODE_03CF26:
	LDA.b ($79),y
	STA.w $0B5B,y
	INY
	DEX
	BPL.b CODE_03CF26
	REP.b #$30
	RTS

DATA_03CF32:
	dw DATA_03CF44,DATA_03CF4A,DATA_03CF4F,DATA_03CF55,DATA_03CF5D,DATA_03CF64,DATA_03CF68,DATA_03CF71
	dw DATA_03CF79

DATA_03CF44:
	db $05,$0C,$12,$1C,$0C,$18

DATA_03CF4A:
	db $04,$0B,$0E,$1B,$17

DATA_03CF4F:
	db $05,$1D,$18,$14,$22,$18

DATA_03CF55:
	db $07,$0D,$0E,$1D,$1B,$18,$12,$1D

DATA_03CF5D:
	db $06,$0B,$18,$1C,$1D,$18,$17

DATA_03CF64:
	db $03,$1B,$12,$18

DATA_03CF68:
	db $08,$15,$0A,$1C,$1F,$0E,$10,$0A,$1C

DATA_03CF71:
	db $07,$0F,$1B,$0E,$0E,$0D,$18,$16

DATA_03CF79:
	db $08,$19,$1B,$0A,$0C,$1D,$12,$0C,$0E

CODE_03CF82:
	SEP.b #$20
	PHB
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	PHA
	PLB
	REP.b #$30
	LDX.w #$0000
CODE_03CF8E:
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	AND.w #$03FF
	STA.w !RAM_SIMC_Global_GeneralPurposeBuffer,x
	INX
	INX
	CPX.w #$5DC0
	BNE.b CODE_03CF8E
	LDY.w #$0000
	TYX
CODE_03CFA3:
	LDA.w !RAM_SIMC_Global_GeneralPurposeBuffer,y
	BMI.b CODE_03D003
	INC
	CMP.w !RAM_SIMC_Global_GeneralPurposeBuffer+$0002,y
	BNE.b CODE_03CFFB
	INC
	CMP.w !RAM_SIMC_Global_GeneralPurposeBuffer+$0004,y
	BNE.b CODE_03CFFB
	INC
	CMP.w !RAM_SIMC_Global_GeneralPurposeBuffer+$00F0,y
	BNE.b CODE_03CFFB
	INC
	CMP.w !RAM_SIMC_Global_GeneralPurposeBuffer+$00F2,y
	BNE.b CODE_03CFFB
	INC
	CMP.w !RAM_SIMC_Global_GeneralPurposeBuffer+$00F4,y
	BNE.b CODE_03CFFB
	INC
	CMP.w !RAM_SIMC_Global_GeneralPurposeBuffer+$01E0,y
	BNE.b CODE_03CFFB
	INC
	CMP.w !RAM_SIMC_Global_GeneralPurposeBuffer+$01E2,y
	BNE.b CODE_03CFFB
	INC
	CMP.w !RAM_SIMC_Global_GeneralPurposeBuffer+$01E4,y
	BNE.b CODE_03CFFB
	LDA.w #$8000
	STA.w !RAM_SIMC_Global_GeneralPurposeBuffer+$0002,y
	STA.w !RAM_SIMC_Global_GeneralPurposeBuffer+$0004,y
	STA.w !RAM_SIMC_Global_GeneralPurposeBuffer+$00F0,y
	STA.w !RAM_SIMC_Global_GeneralPurposeBuffer+$00F2,y
	STA.w !RAM_SIMC_Global_GeneralPurposeBuffer+$00F4,y
	STA.w !RAM_SIMC_Global_GeneralPurposeBuffer+$01E0,y
	STA.w !RAM_SIMC_Global_GeneralPurposeBuffer+$01E2,y
	STA.w !RAM_SIMC_Global_GeneralPurposeBuffer+$01E4,y
	LDA.w !RAM_SIMC_Global_GeneralPurposeBuffer,y
	ORA.w #$8000
	BRA.b CODE_03CFFE

CODE_03CFFB:
	LDA.w !RAM_SIMC_Global_GeneralPurposeBuffer,y
CODE_03CFFE:
	STA.w !RAM_SIMC_Global_GeneralPurposeBuffer,x
	INX
	INX
CODE_03D003:
	INY
	INY
	CPY.w #$5DC0
	BNE.b CODE_03CFA3
	STX.w $0B47
	LDY.w #$0002
	LDX.w #$0000
CODE_03D013:
	LDA.w !RAM_SIMC_Global_GeneralPurposeBuffer,x
	AND.w #$3C00
	CMP.w #$3C00
	BEQ.b CODE_03D035
	LDA.w !RAM_SIMC_Global_GeneralPurposeBuffer,x
	AND.w #$83FF
	CMP.w !RAM_SIMC_Global_GeneralPurposeBuffer,y
	BNE.b CODE_03D035
	LDA.w !RAM_SIMC_Global_GeneralPurposeBuffer,x
	CLC
	ADC.w #$0400
	STA.w !RAM_SIMC_Global_GeneralPurposeBuffer,x
	BRA.b CODE_03D040

CODE_03D035:
	INX
	INX
	LDA.w !RAM_SIMC_Global_GeneralPurposeBuffer,y
	AND.w #$83FF
	STA.w !RAM_SIMC_Global_GeneralPurposeBuffer,x
CODE_03D040:
	INY
	INY
	CPY.w $0B47
	BNE.b CODE_03D013
	LDA.w #$FFFF
	INX
	INX
	STA.w !RAM_SIMC_Global_GeneralPurposeBuffer,x
	INX
	INX
	STX.w $0B47
	PLB
	RTS

CODE_03D056:
	SEP.b #$20
	PHB
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	PHA
	PLB
	REP.b #$20
	LDX.w #$3FFC
	STX.w $008B
	LDX.w #$0C00
	LDA.w $0423
	CMP.w #$0001
	BEQ.b CODE_03D079
	LDX.w #$7FEC
	STX.w $008B
	LDX.w #$4BF0
CODE_03D079:
	STX.w $0079
	STX.w $008E
	LDY.w #$0002
	STY.w $007C
	LDA.w !RAM_SIMC_Global_GeneralPurposeBuffer
	STA.l $700000,x
CODE_03D08C:
	LDA.w $007C
	SEC
	SBC.w #$0100
	BCS.b CODE_03D098
	LDA.w #$0000
CODE_03D098:
	STA.w $007F
	STZ.w $0085
CODE_03D09E:
	STZ.w $0082
	LDY.w $007C
	LDX.w $007F
CODE_03D0A7:
	LDA.w !RAM_SIMC_Global_GeneralPurposeBuffer,y
	AND.w #$3C00
	BNE.b CODE_03D0C6
	LDA.w !RAM_SIMC_Global_GeneralPurposeBuffer,y
	CMP.w !RAM_SIMC_Global_GeneralPurposeBuffer,x
	BNE.b CODE_03D0C6
	INY
	INY
	INX
	INX
	INC.w $0082
	LDA.w $0082
	CMP.w #$000F
	BNE.b CODE_03D0A7
CODE_03D0C6:
	LDA.w $0082
	CMP.w $0085
	BCC.b CODE_03D0D7
	STA.w $0085
	LDA.w $007F
	STA.w $0088
CODE_03D0D7:
	INC.w $007F
	INC.w $007F
	LDA.w $007F
	CMP.w $007C
	BCC.b CODE_03D09E
	LDA.w $0085
	CMP.w #$0002
	BCC.b CODE_03D11E
	LDA.w $007C
	SEC
	SBC.w $0088
	STA.w $0088
	LDA.w $0085
	XBA
	ASL
	ASL
	ORA.w $0088
	LDX.w $0079
	INX
	INX
	CPX.w $008B
	BCS.b CODE_03D157
	STX.w $0079
	ORA.w #$4000
	STA.l $700000,x
	LDA.w $0085
	ASL
	ADC.w $007C
	TAY
	BRA.b CODE_03D137

CODE_03D11E:
	LDX.w $0079
	LDY.w $007C
	INX
	INX
	STX.w $0079
	CPX.w $008B
	BCS.b CODE_03D157
	LDA.w !RAM_SIMC_Global_GeneralPurposeBuffer,y
	STA.l $700000,x
	INY
	INY
CODE_03D137:
	STY.w $007C
	CPY.w $0B47
	BCS.b CODE_03D142
	JMP.w CODE_03D08C

CODE_03D142:
	LDA.w #$FFFF
	LDX.w $0079
	INX
	INX
	STA.l $700000,x
	INX
	INX
	TXA
	SEC
	SBC.w $008E
	BRA.b CODE_03D15A

CODE_03D157:
	LDA.w #$FFFF
CODE_03D15A:
	STA.w $0B47
	PLB
	RTS

CODE_03D15F:
	PHB
	SEP.b #$20
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	PHA
	PLB
	REP.b #$20
	LDY.w #$0000
	TYX
CODE_03D16C:
	LDA.w !RAM_SIMC_Global_GeneralPurposeBuffer,y
	CMP.w #$FFFF
	BEQ.b CODE_03D1B9
	AND.w #$4000
	BEQ.b CODE_03D1AC
	LDA.w !RAM_SIMC_Global_GeneralPurposeBuffer,y
	AND.w #$03FF
	STA.w $0079
	LDA.w !RAM_SIMC_Global_GeneralPurposeBuffer,y
	AND.w #$3C00
	XBA
	LSR
	LSR
	STA.w $007C
	TXA
	SEC
	SBC.w $0079
	PHY
	TAY
CODE_03D195:
	PHX
	TYX
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	PLX
	STA.l !RAM_SIMC_City_MapDataBuffer,x
	INY
	INY
	INX
	INX
	DEC.w $007C
	BNE.b CODE_03D195
	PLY
	BRA.b CODE_03D1B5

CODE_03D1AC:
	LDA.w !RAM_SIMC_Global_GeneralPurposeBuffer,y
	STA.l !RAM_SIMC_City_MapDataBuffer,x
	INX
	INX
CODE_03D1B5:
	INY
	INY
	BRA.b CODE_03D16C

CODE_03D1B9:
	LDA.w #$FFFF
	STA.l !RAM_SIMC_City_MapDataBuffer,x
	LDY.w #$0000
	TYX
CODE_03D1C4:
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	CMP.w #$FFFF
	BEQ.b CODE_03D1FB
	AND.w #$3C00
	BEQ.b CODE_03D1EB
	LSR
	LSR
	XBA
	STA.w $0079
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	AND.w #$83FF
CODE_03D1DF:
	STA.w !RAM_SIMC_Global_GeneralPurposeBuffer,y
	INY
	INY
	DEC.w $0079
	BPL.b CODE_03D1DF
	BRA.b CODE_03D1F7

CODE_03D1EB:
	LDA.l !RAM_SIMC_City_MapDataBuffer,x
	AND.w #$83FF
	STA.w !RAM_SIMC_Global_GeneralPurposeBuffer,y
	INY
	INY
CODE_03D1F7:
	INX
	INX
	BRA.b CODE_03D1C4

CODE_03D1FB:
	REP.b #$30
	LDA.w #$0000
	STA.l !RAM_SIMC_City_MapDataBuffer
	LDX.w #!RAM_SIMC_City_MapDataBuffer
	LDY.w #!RAM_SIMC_City_MapDataBuffer+$01
	LDA.w #$5DBF
	MVN !RAM_SIMC_City_MapDataBuffer>>16,!RAM_SIMC_City_MapDataBuffer>>16
	LDX.w #$0000
	TXY
CODE_03D214:
	LDA.w $0200,y
	BNE.b CODE_03D24C
	LDA.l !RAM_SIMC_Global_GeneralPurposeBuffer,x
	BPL.b CODE_03D247
	AND.w #$7FFF
	STA.w $0200,y
	INC
	STA.w $0202,y
	INC
	STA.w $0204,y
	INC
	STA.w $02F0,y
	INC
	STA.w $02F2,y
	INC
	STA.w $02F4,y
	INC
	STA.w $03E0,y
	INC
	STA.w $03E2,y
	INC
	STA.w $03E4,y
	BRA.b CODE_03D24A

CODE_03D247:
	STA.w $0200,y
CODE_03D24A:
	INX
	INX
CODE_03D24C:
	INY
	INY
	CPY.w #$5DC0
	BNE.b CODE_03D214
	PLB
	RTS

DATA_03D255:
	dw CODE_03D2B8
	dw CODE_03D2C6
	dw CODE_03D304
	dw CODE_03D333
	dw CODE_03D388
	dw CODE_03D3CA
	dw CODE_03D88A
	dw CODE_03D8BB
	dw CODE_03D951
	dw CODE_03D964
	dw CODE_03DD52
	dw CODE_03DDB6
	dw CODE_03DF40
	dw CODE_03E1EC
	dw CODE_03E246
	dw CODE_03E257
	dw CODE_03E292
	dw CODE_03E296
	dw CODE_03D30F
	dw CODE_03E2DF
	dw CODE_03E344
	dw CODE_03D9EB
	dw CODE_03DA26

CODE_03D283:
	PHK
	PLB
	REP.b #$20
CODE_03D287:
	REP.b #$30
	LDA.b $14
	REP.b #$10
	ASL
	TAX
	JSR.w (DATA_03D255,x)
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	LDA.b $14
	BPL.b CODE_03D287
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	LDA.w #$0001
	STA.b $12
	SEP.b #$20
	LDA.b #$FF
	STA.w $0B2A
	LDA.b #CODE_008000>>16
	PHA
	PLB
	RTL

CODE_03D2B8:
	JSL.l CODE_059080
	LDA.b #$A0
	STA.b $3C
	LDA.b #$FF
	STA.w $0B2A
	RTS

CODE_03D2C6:
	SEP.b #$20
	LDA.b !RAM_SIMC_Global_FixedColorData
	CMP.b #$E0
	BEQ.b CODE_03D2D8
	DEC.b $3C
	BNE.b CODE_03D2D8
	LDA.b #$0E
	STA.b $3C
	DEC.b !RAM_SIMC_Global_FixedColorData
CODE_03D2D8:
	JSL.l CODE_0593AE
	REP.b #$30
	LDA.w $011B
	AND.w #$3030
	CMP.w #$3030
	BNE.b CODE_03D2F4
	LDA.w #$0000
	STA.l $700000
	STA.l $707FF0
CODE_03D2F4:
	LDA.b $C9
	AND.w #$9000
	BEQ.b CODE_03D303
	JSR.w CODE_03E574
	JSR.w CODE_03E349
	INC.b $14
CODE_03D303:
	RTS

CODE_03D304:
	SEP.b #$20
	REP.b #$20
	LDA.w #$0004
	COP.b #$00
	STZ.b !RAM_SIMC_Global_HDMAEnable
CODE_03D30F:
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	REP.b #$20
	LDA.w #$0001
	COP.b #$00
	JSL.l CODE_02BB23
	JSL.l CODE_02BC8F
	JSL.l CODE_02BC48
	SEP.b #$20
	STZ.b !RAM_SIMC_Global_MainScreenWindowMask
	STZ.b !RAM_SIMC_Global_SubScreenWindowMask
	RTS

CODE_03D333:
	SEP.b #$30
	LDY.b #$00
	LDA.b $44
	BNE.b CODE_03D33C
	INY
CODE_03D33C:
	STY.b $79
	LDA.b $CA
	AND.b #$0C
	BEQ.b CODE_03D360
	LDX.b $3E
	CMP.b #$04
	BNE.b CODE_03D353
	INX
	CPX.b #$04
	BNE.b CODE_03D35A
	LDX.b $79
	BRA.b CODE_03D35A

CODE_03D353:
	DEX
	CPX.b $79
	BPL.b CODE_03D35A
	LDX.b #$03
CODE_03D35A:
	STX.b $3E
	LDA.b #$07
	STA.b $06
CODE_03D360:
	LDA.b $CA
	AND.b #$90
	BEQ.b CODE_03D370
	JSR.w CODE_03E574
	LDX.b $3E
	LDA.w DATA_03D384,x
	STA.b $14
CODE_03D370:
	REP.b #$20
	LDA.w #$0001
	COP.b #$00
	JSL.l CODE_02BC8F
	RTS

DATA_03D37C:
	db $00,$70,$88,$A0,$64,$7C,$94,$AC

DATA_03D384:
	db $10,$0E,$04,$0A

CODE_03D388:
	REP.b #$20
	LDA.w #$0004
	COP.b #$00
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	REP.b #$20
	LDA.w #$0001
	COP.b #$00
	JSL.l CODE_0598EE
	JSR.w CODE_03D3B7
	JSL.l CODE_0599FE
	JSR.w CODE_03D80D
	SEP.b #$20
	LDA.b #$16
	STA.b !RAM_SIMC_Global_MainScreenLayers
	INC.b $14
	RTS

CODE_03D3B7:
	REP.b #$30
	LDA.w #$0001
	STA.w $0B2D
	JSR.w CODE_03D773
	JSR.w CODE_03D7DD
	JSL.l CODE_059A51
	RTS

CODE_03D3CA:
	LDA.b $C9
	AND.w #$0040
	BNE.b CODE_03D3D7
	JSR.w CODE_03D3E0
	JMP.w CODE_03D7DD

CODE_03D3D7:
	JSR.w CODE_03E574
	LDA.w #$0002
	STA.b $14
	RTS

CODE_03D3E0:
	SEP.b #$30
	LDA.b $CA
	BMI.b CODE_03D3ED
	AND.b #$0F
	BEQ.b CODE_03D459
	JMP.w CODE_03D625

CODE_03D3ED:
	STZ.w $0B31
	LDA.w $0B2D
	BNE.b CODE_03D3FC
	LDA.b #$01
	STA.b $05
	JMP.w CODE_03D4D6

CODE_03D3FC:
	CMP.b #$01
	BEQ.b CODE_03D417
	STA.w $0B2F
	PHA
	LDA.b #$08
	STA.b $06
	PLA
	LDX.b #$80
	STX.w $0B31
	LSR
	BCC.b CODE_03D414
	JMP.w CODE_03D494

CODE_03D414:
	JMP.w CODE_03D45A

CODE_03D417:
	JSR.w CODE_03D5ED
	LDA.l SIMC_Global_OAMBuffer[$40].YDisp
	INC
	INC
	STA.l SIMC_Global_OAMBuffer[$40].YDisp
	LDA.l SIMC_Global_OAMBuffer[$41].YDisp
	INC
	INC
	STA.l SIMC_Global_OAMBuffer[$41].YDisp
	JSR.w CODE_03E574
	INC.b $14
	REP.b #$10
	LDY.w #$0014
CODE_03D438:
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	DEY
	BNE.b CODE_03D438
	JSR.w CODE_03D5B5
	LDA.l SIMC_Global_OAMBuffer[$40].YDisp
	DEC
	DEC
	STA.l SIMC_Global_OAMBuffer[$40].YDisp
	LDA.l SIMC_Global_OAMBuffer[$41].YDisp
	DEC
	DEC
	STA.l SIMC_Global_OAMBuffer[$41].YDisp
CODE_03D459:
	RTS

CODE_03D45A:
	SEP.b #$30
	LDA.w $0B2D
	LSR
	TAX
	LDA.w $0B26,x
	CMP.b #$09
	BCC.b CODE_03D46C
	LDA.b #$00
	BEQ.b CODE_03D46E
CODE_03D46C:
	ADC.b #$01
CODE_03D46E:
	STA.w $0B26,x
	REP.b #$30
	LDA.w #$082C
	JSR.w CODE_03D4C2
	JSR.w CODE_03D6B8
	REP.b #$30
	LDA.w #$082B
	JMP.w CODE_03D4C2

DATA_03D484:
	dw $0000,$0000,$05B6,$05F6,$05B4,$05F4,$05B2,$05F2

CODE_03D494:
	SEP.b #$30
	LDA.w $0B2F
	ORA.b #$80
	STA.w $0B2F
	LDA.w $0B2D
	LSR
	TAX
	LDA.w $0B26,x
	BNE.b CODE_03D4AC
	LDA.b #$09
	BRA.b CODE_03D4AF

CODE_03D4AC:
	SEC
	SBC.b #$01
CODE_03D4AF:
	STA.w $0B26,x
	REP.b #$30
	LDA.w #$082E
	JSR.w CODE_03D4C2
	JSR.w CODE_03D6B8
	REP.b #$30
	LDA.w #$082D
CODE_03D4C2:
	REP.b #$30
	PHA
	LDA.w $0B2D
	ASL
	TAX
	LDA.w DATA_03D484,x
	TAX
	PLA
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer,x
	JMP.w CODE_03DBD6

CODE_03D4D6:
	LDA.l SIMC_Global_OAMBuffer[$42].YDisp
	INC
	INC
	STA.l SIMC_Global_OAMBuffer[$42].YDisp
	LDA.l SIMC_Global_OAMBuffer[$43].YDisp
	INC
	INC
	STA.l SIMC_Global_OAMBuffer[$43].YDisp
	LDA.l SIMC_Global_OAMBuffer[$44].YDisp
	INC
	INC
	STA.l SIMC_Global_OAMBuffer[$44].YDisp
	JSR.w CODE_03D545
	SEP.b #$30
	LDX.b #$00
CODE_03D4FB:
	LDA.w !RAM_SIMC_Global_MapNumOnesDigit,x
	CLC
	ADC.b #$01
	CMP.b #$0A
	BCC.b CODE_03D510
	STZ.w !RAM_SIMC_Global_MapNumOnesDigit,x
	INX
	CPX.b #$03
	BCC.b CODE_03D4FB
	DEX
	BCS.b CODE_03D513
CODE_03D510:
	STA.w !RAM_SIMC_Global_MapNumOnesDigit,x
CODE_03D513:
	LDA.w DATA_03D542,x
	STA.w $0B2F
	JSR.w CODE_03D6B8
	LDA.b #$80
	STA.w $0B31
	LDA.l SIMC_Global_OAMBuffer[$42].YDisp
	DEC
	DEC
	STA.l SIMC_Global_OAMBuffer[$42].YDisp
	LDA.l SIMC_Global_OAMBuffer[$43].YDisp
	DEC
	DEC
	STA.l SIMC_Global_OAMBuffer[$43].YDisp
	LDA.l SIMC_Global_OAMBuffer[$44].YDisp
	DEC
	DEC
	STA.l SIMC_Global_OAMBuffer[$44].YDisp
	JMP.w CODE_03D57D

DATA_03D542:
	db $02,$08,$0A

CODE_03D545:
	REP.b #$20
	LDA.w #$0834
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$02F0
	LDA.w #$0842
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$02F2
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$02F4
	LDA.w #$0835
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$02F6
	LDA.w #$0836
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$0330
	LDA.w #$0843
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$0332
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$0334
	LDA.w #$0837
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$0336
	JSR.w CODE_03DBD6
	RTS

CODE_03D57D:
	REP.b #$20
	LDA.w #$0830
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$02F0
	LDA.w #$0840
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$02F2
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$02F4
	LDA.w #$0831
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$02F6
	LDA.w #$0832
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$0330
	LDA.w #$0841
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$0332
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$0334
	LDA.w #$0833
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$0336
	JSR.w CODE_03DBD6
	RTS

CODE_03D5B5:
	REP.b #$20
	LDA.w #$0838
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$03B0
	LDA.w #$0844
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$03B2
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$03B4
	LDA.w #$0839
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$03B6
	LDA.w #$083A
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$03F0
	LDA.w #$0845
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$03F2
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$03F4
	LDA.w #$083B
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$03F6
	JSR.w CODE_03DBD6
	RTS

CODE_03D5ED:
	REP.b #$20
	LDA.w #$083C
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$03B0
	LDA.w #$0846
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$03B2
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$03B4
	LDA.w #$083D
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$03B6
	LDA.w #$083E
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$03F0
	LDA.w #$0847
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$03F2
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$03F4
	LDA.w #$083F
	STA.l !RAM_SIMC_Global_Layer2TilemapBuffer+$03F6
	JSR.w CODE_03DBD6
	RTS

CODE_03D625:
	SEP.b #$30
	LDX.w $0B2D
	LDA.b $CA
	LSR
	BCC.b CODE_03D63D
	CPX.b #$04
	BCC.b CODE_03D65D
	LDA.b #$07
	STA.b $06
	TXA
	SEC
	SBC.b #$02
	BRA.b CODE_03D650

CODE_03D63D:
	LSR
	BCC.b CODE_03D65E
	CPX.b #$02
	BCC.b CODE_03D65D
	CPX.b #$06
	BCS.b CODE_03D65D
	LDA.b #$07
	STA.b $06
	TXA
	CLC
	ADC.b #$02
CODE_03D650:
	STA.w $0B2D
	LDA.w $0B31
	BEQ.b CODE_03D65D
	LDA.b #$80
	STA.w $0B31
CODE_03D65D:
	RTS

CODE_03D65E:
	LSR
	BCC.b CODE_03D676
	TXA
	CPX.b #$03
	BEQ.b CODE_03D68E
	CPX.b #$05
	BEQ.b CODE_03D68E
	CPX.b #$07
	BEQ.b CODE_03D68E
	LDA.b #$07
	STA.b $06
	INX
	TXA
	BRA.b CODE_03D68E

CODE_03D676:
	LDA.b #$00
	CPX.b #$00
	BEQ.b CODE_03D68E
	LDA.b #$01
	CPX.b #$04
	BEQ.b CODE_03D68E
	CPX.b #$06
	BEQ.b CODE_03D68E
	LDA.b #$07
	STA.b $06
	DEX
	TXA
	AND.b #$07
CODE_03D68E:
	STA.w $0B2D
	CMP.b #$01
	BNE.b CODE_03D6AB
	LDA.w $0B31
	BEQ.b CODE_03D6AB
	JSR.w CODE_03D7DD
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	JSR.w CODE_03D80D
	STZ.w $0B31
	RTS

CODE_03D6AB:
	SEP.b #$20
	LDA.w $0B31
	BEQ.b CODE_03D6B7
	LDA.b #$80
	STA.w $0B31
CODE_03D6B7:
	RTS

CODE_03D6B8:
	SEP.b #$30
	LDY.b #$FF
	LDX.b #$08
	LDA.w $0B2F
	BPL.b CODE_03D6C5
	LDY.b #$01
CODE_03D6C5:
	STY.b $79
	AND.b #$7F
	LSR
	TAY
CODE_03D6CB:
	SEP.b #$20
	LDA.b $79
	PHA
	PHX
	PHY
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	SEP.b #$20
	PLY
	PLX
	PLA
	STA.b $79
	JSR.w CODE_03D6EF
	JSR.w CODE_03D71B
	JSR.w CODE_03D747
	DEX
	BNE.b CODE_03D6CB
	JMP.w CODE_03D773

CODE_03D6EF:
	SEP.b #$30
	CPY.b #$01
	BEQ.b CODE_03D6F9
	CPY.b #$04
	BCC.b CODE_03D71A
CODE_03D6F9:
	LDA.l SIMC_Global_OAMBuffer[$01].YDisp
	CLC
	ADC.b $79
	STA.l SIMC_Global_OAMBuffer[$01].YDisp
	LDA.l SIMC_Global_OAMBuffer[$02].YDisp
	CLC
	ADC.b $79
	STA.l SIMC_Global_OAMBuffer[$02].YDisp
	LDA.l SIMC_Global_OAMBuffer[$03].YDisp
	CLC
	ADC.b $79
	STA.l SIMC_Global_OAMBuffer[$03].YDisp
CODE_03D71A:
	RTS

CODE_03D71B:
	SEP.b #$30
	CPY.b #$02
	BEQ.b CODE_03D725
	CPY.b #$04
	BCC.b CODE_03D746
CODE_03D725:
	LDA.l SIMC_Global_OAMBuffer[$04].YDisp
	CLC
	ADC.b $79
	STA.l SIMC_Global_OAMBuffer[$04].YDisp
	LDA.l SIMC_Global_OAMBuffer[$05].YDisp
	CLC
	ADC.b $79
	STA.l SIMC_Global_OAMBuffer[$05].YDisp
	LDA.l SIMC_Global_OAMBuffer[$06].YDisp
	CLC
	ADC.b $79
	STA.l SIMC_Global_OAMBuffer[$06].YDisp
CODE_03D746:
	RTS

CODE_03D747:
	SEP.b #$30
	CPY.b #$03
	BEQ.b CODE_03D751
	CPY.b #$05
	BNE.b CODE_03D772
CODE_03D751:
	LDA.l SIMC_Global_OAMBuffer[$07].YDisp
	CLC
	ADC.b $79
	STA.l SIMC_Global_OAMBuffer[$07].YDisp
	LDA.l SIMC_Global_OAMBuffer[$08].YDisp
	CLC
	ADC.b $79
	STA.l SIMC_Global_OAMBuffer[$08].YDisp
	LDA.l SIMC_Global_OAMBuffer[$09].YDisp
	CLC
	ADC.b $79
	STA.l SIMC_Global_OAMBuffer[$09].YDisp
CODE_03D772:
	RTS

CODE_03D773:
	SEP.b #$30
	LDA.b #$93
	STA.l SIMC_Global_OAMBuffer[$01].YDisp
	STA.l SIMC_Global_OAMBuffer[$04].YDisp
	STA.l SIMC_Global_OAMBuffer[$07].YDisp
	LDA.b #$9C
	STA.l SIMC_Global_OAMBuffer[$02].YDisp
	STA.l SIMC_Global_OAMBuffer[$05].YDisp
	STA.l SIMC_Global_OAMBuffer[$08].YDisp
	LDA.b #$A5
	STA.l SIMC_Global_OAMBuffer[$03].YDisp
	STA.l SIMC_Global_OAMBuffer[$06].YDisp
	STA.l SIMC_Global_OAMBuffer[$09].YDisp
	LDY.b #$00
	LDX.b #$00
	JSR.w CODE_03D7B8
	LDY.b #$01
	LDX.b #$0C
	JSR.w CODE_03D7B8
	LDY.b #$02
	LDX.b #$18
	JSR.w CODE_03D7B8
	STZ.w $0B2F
	RTS

CODE_03D7B8:
	SEP.b #$30
	LDA.w !RAM_SIMC_Global_MapNumOnesDigit,y
	CLC
	ADC.b #$40
	STA.l SIMC_Global_OAMBuffer[$02].Tile,x
	PHA
	INC
	CMP.b #$4A
	BNE.b CODE_03D7CC
	LDA.b #$40
CODE_03D7CC:
	STA.l SIMC_Global_OAMBuffer[$03].Tile,x
	PLA
	DEC
	CMP.b #$3F
	BNE.b CODE_03D7D8
	LDA.b #$49
CODE_03D7D8:
	STA.l SIMC_Global_OAMBuffer[$01].Tile,x
	RTS

CODE_03D7DD:
	SEP.b #$10
	REP.b #$20
	LDA.w $0B2D
	ASL
	TAX
	LDA.w DATA_03D7FD,x
	STA.l SIMC_Global_OAMBuffer[$00].XDisp
	LDA.w #$3F9E
	STA.l SIMC_Global_OAMBuffer[$00].Tile
	SEP.b #$20
	LDA.b #$02
	STA.l SIMC_Global_UpperOAMBuffer[$00].Slot
	RTS

DATA_03D7FD:
	dw $60D0,$78D0,$B2DC,$BADC,$B2D4,$BAD4,$B2CC,$BACC

CODE_03D80D:
	SEP.b #$20
	LDA.b #$17
	STA.b !RAM_SIMC_Global_MainScreenLayers
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	SEP.b #$20
	LDA.w !RAM_SIMC_Global_MapNumOnesDigit
	CMP.w $0B2A
	BNE.b CODE_03D834
	LDA.w !RAM_SIMC_Global_MapNumTensDigit
	CMP.w $0B2B
	BNE.b CODE_03D834
	LDA.w !RAM_SIMC_Global_MapNumHundredsDigit
	CMP.w $0B2C
	BEQ.b CODE_03D86D
CODE_03D834:
	REP.b #$20
	LDA.w !RAM_SIMC_Global_MapNumOnesDigit
	CLC
	ROL
	ROL
	ROL
	ADC.w #!Define_SIMC_MapGen_MapGenSeed1
	STA.b $59
	LDA.w !RAM_SIMC_Global_MapNumTensDigit
	EOR.w #$FFFF
	ROL
	ROL
	ROL
	ROL
	ROL
	ADC.w #!Define_SIMC_MapGen_MapGenSeed2
	STA.b $5B
	STZ.b $5D
	LDA.w !RAM_SIMC_Global_MapNumHundredsDigit
	ASL
	ADC.w !RAM_SIMC_Global_MapNumTensDigit
	ADC.w !RAM_SIMC_Global_MapNumOnesDigit
	AND.w #$001F
	TAX
CODE_03D862:
	JSL.l CODE_00824B
	DEX
	BPL.b CODE_03D862
	JSL.l CODE_01F1ED
CODE_03D86D:
	JSL.l CODE_02923F
	SEP.b #$20
	LDA.w !RAM_SIMC_Global_MapNumOnesDigit
	STA.w $0B2A
	LDA.w !RAM_SIMC_Global_MapNumTensDigit
	STA.w $0B2B
	LDA.w !RAM_SIMC_Global_MapNumHundredsDigit
	STA.w $0B2C
	LDA.b #$16
	STA.b !RAM_SIMC_Global_MainScreenLayers
	RTS

CODE_03D88A:
	REP.b #$20
	LDA.w #$0004
	COP.b #$00
	REP.b #$20
	LDA.w #$0001
	COP.b #$00
	JSR.w CODE_03DC83
	JSR.w CODE_03DCA5
	LDA.w #$00FF
	STA.b $4E
	SEP.b #$20
	LDA.b #$48
	STA.b !RAM_SIMC_Global_BG1AddressAndSize
	LDA.b #$54
	STA.b !RAM_SIMC_Global_BG3AddressAndSize
	LDA.b #$15
	STA.b !RAM_SIMC_Global_MainScreenLayers
	REP.b #$20
	LDA.w #$0003
	COP.b #$00
	INC.b $14
	RTS

CODE_03D8BB:
	REP.b #$30
	STZ.w $0253
	JSR.w CODE_03DAD3
	JSR.w CODE_03DB5D
	JSR.w CODE_03DBB6
	JSR.w CODE_03DC83
	JSL.l CODE_059B94
	JSR.w CODE_03D91D
	JSR.w CODE_03DCA5
	REP.b #$30
	LDA.b $4E
	CMP.w #$0082
	BNE.b CODE_03D8E3
	INC.b $14
	BRA.b CODE_03D91C

CODE_03D8E3:
	LDA.b $C9
	AND.w #$0040
	BEQ.b CODE_03D91C
	JSR.w CODE_03E574
	REP.b #$20
	LDA.w #$0004
	COP.b #$00
	REP.b #$20
	LDA.w #$0001
	COP.b #$00
	JSR.w CODE_03D3B7
	SEP.b #$20
	LDA.b #$16
	STA.b !RAM_SIMC_Global_MainScreenLayers
	LDA.b #$40
	STA.b !RAM_SIMC_Global_BG1AddressAndSize
	LDA.b #$44
	STA.b !RAM_SIMC_Global_BG2AddressAndSize
	LDA.b #$50
	STA.b !RAM_SIMC_Global_BG3AddressAndSize
	REP.b #$20
	LDA.w #$0003
	COP.b #$00
	LDA.w #$0005
	STA.b $14
CODE_03D91C:
	RTS

CODE_03D91D:
	SEP.b #$30
	LDA.b $50
	BEQ.b CODE_03D94E
	LDY.w $0B5B
	LDA.b $4E
	CMP.b #$FF
	BEQ.b CODE_03D94E
	CMP.b #$82
	BEQ.b CODE_03D94E
	CMP.b #$80
	BNE.b CODE_03D938
	LDY.b #$00
	BRA.b CODE_03D94B

CODE_03D938:
	CMP.b #$81
	BNE.b CODE_03D943
	CPY.b #$00
	BEQ.b CODE_03D94E
	DEY
	BRA.b CODE_03D94B

CODE_03D943:
	CPY.b #$08
	BCS.b CODE_03D94E
	STA.w $0B5C,y
	INY
CODE_03D94B:
	STY.w $0B5B
CODE_03D94E:
	STZ.b $50
	RTS

CODE_03D951:
	REP.b #$20
	LDA.w #$0001
	COP.b #$00
	SEP.b #$20
	LDA.b #$48
	STA.b !RAM_SIMC_Global_BG1AddressAndSize
	LDA.b #$58
	STA.b !RAM_SIMC_Global_BG3AddressAndSize
	INC.b $14
CODE_03D964:
	REP.b #$30
	STZ.w $0253
	JSR.w CODE_03DB5D
	JSR.w CODE_03DBB6
	JSR.w CODE_03DC83
	JSL.l CODE_059B94
	REP.b #$30
	LDY.w !RAM_SIMC_City_DifficultyLevel
	LDA.b $C9
	AND.w #$0300
	BEQ.b CODE_03D9A0
	CMP.w #$0200
	BEQ.b CODE_03D98F
	CPY.w #$0002
	BEQ.b CODE_03D9A0
	INY
	BRA.b CODE_03D995

CODE_03D98F:
	CPY.w #$0000
	BEQ.b CODE_03D9A0
	DEY
CODE_03D995:
	STY.w !RAM_SIMC_City_DifficultyLevel
	SEP.b #$20
	LDA.b #$07
	STA.b $06
	REP.b #$20
CODE_03D9A0:
	LDY.w #$0000
CODE_03D9A3:
	PHY
	LDA.w #$0000
	CPY.w !RAM_SIMC_City_DifficultyLevel
	BNE.b CODE_03D9B1
	LDA.b $2C
	AND.w #$0010
CODE_03D9B1:
	JSL.l CODE_059AD7
	PLY
	INY
	CPY.w #$0003
	BNE.b CODE_03D9A3
	INC.b $2C
	LDA.b $C9
	BPL.b CODE_03D9C9
	LDA.w #$0015
	STA.b $14
	BRA.b CODE_03D9EA

CODE_03D9C9:
	LDA.b $C9
	AND.w #$0040
	BEQ.b CODE_03D9EA
	JSR.w CODE_03DCA5
	LDA.w #$00FF
	STA.b $4E
	SEP.b #$20
	LDA.b #$48
	STA.b !RAM_SIMC_Global_BG1AddressAndSize
	LDA.b #$54
	STA.b !RAM_SIMC_Global_BG3AddressAndSize
	LDA.b #$15
	STA.b !RAM_SIMC_Global_MainScreenLayers
	LDA.b #$07
	STA.b $14
CODE_03D9EA:
	RTS

CODE_03D9EB:
	SEP.b #$20
	LDA.b #$5C
	STA.b !RAM_SIMC_Global_BG3AddressAndSize
	REP.b #$30
	STZ.b $36
	LDA.w !RAM_SIMC_City_DifficultyLevel
	ASL
	TAY
	LDA.w DATA_03DAAF,y
	STA.l !RAM_SIMC_Global_Layer4TilemapBuffer+$0194
	LDA.w DATA_03DAB5,y
	STA.l !RAM_SIMC_Global_Layer4TilemapBuffer+$0196
	LDA.w DATA_03DABB,y
	STA.l !RAM_SIMC_Global_Layer4TilemapBuffer+$0198
	LDA.w DATA_03DAC1,y
	STA.l !RAM_SIMC_Global_Layer4TilemapBuffer+$019A
	LDA.w DATA_03DAC7,y
	STA.l !RAM_SIMC_Global_Layer4TilemapBuffer+$019E
	LDA.w DATA_03DACD,y
	STA.l !RAM_SIMC_Global_Layer4TilemapBuffer+$01A0
	INC.b $14
CODE_03DA26:
	REP.b #$30
	STZ.w $0253
	JSR.w CODE_03DB5D
	JSR.w CODE_03DBB6
	JSR.w CODE_03DC83
	JSL.l CODE_059B94
	REP.b #$30
	LDY.b $36
	LDA.b $C9
	AND.w #$0300
	BEQ.b CODE_03DA60
	CMP.w #$0200
	BEQ.b CODE_03DA50
	CPY.w #$0000
	BNE.b CODE_03DA60
	INY
	BRA.b CODE_03DA56

CODE_03DA50:
	CPY.w #$0000
	BEQ.b CODE_03DA60
	DEY
CODE_03DA56:
	STY.b $36
	SEP.b #$20
	LDA.b #$07
	STA.b $06
	REP.b #$20
CODE_03DA60:
	LDA.b $36
	CLC
	ADC.w #$0003
	TAY
	LDA.b $2C
	AND.w #$0010
	JSL.l CODE_059AD7
	LDA.b $36
	EOR.w #$0001
	CLC
	ADC.w #$0003
	TAY
	LDA.w #$0000
	JSL.l CODE_059AD7
	INC.b $2C
	LDA.b $C9
	AND.w #$8000
	BEQ.b CODE_03DAA2
	LDA.b $36
	BNE.b CODE_03DAA9
	JSR.w CODE_03E574
	REP.b #$20
	LDA.w #$0004
	COP.b #$00
	JSR.w CODE_03C63D
	LDA.w #$8000
	STA.b $14
	BRA.b CODE_03DAAE

CODE_03DAA2:
	LDA.b $C9
	AND.w #$0040
	BEQ.b CODE_03DAAE
CODE_03DAA9:
	LDA.w #$0008
	STA.b $14
CODE_03DAAE:
	RTS

DATA_03DAAF:
	dw $15D3,$15D6,$15DA

DATA_03DAB5:
	dw $15D4,$15D7,$15DB

DATA_03DABB:
	dw $15D5,$15D8,$15DC

DATA_03DAC1:
	dw $15EF,$15D9,$15EF

DATA_03DAC7:
	dw $15C8,$15C7,$14F6

DATA_03DACD:
	dw $15CA,$15CA,$15C9

CODE_03DAD3:
	SEP.b #$30
	LDX.b $4A
	LDY.b $4C
	LDA.w $0124
	AND.b #$0F
	BEQ.b CODE_03DB5C
	LSR
	BCC.b CODE_03DB0F
	CPY.b #$02
	BCS.b CODE_03DAEF
	CPX.b #$0A
	BNE.b CODE_03DB08
	LDX.b #$00
	BRA.b CODE_03DB09

CODE_03DAEF:
	CPY.b #$02
	BNE.b CODE_03DAFA
	CPX.b #$09
	BNE.b CODE_03DB08
	INY
	BRA.b CODE_03DB09

CODE_03DAFA:
	CPY.b #$03
	BNE.b CODE_03DB0F
	CPX.b #$09
	BNE.b CODE_03DB08
	LDX.b #$00
	LDY.b #$02
	BRA.b CODE_03DB09

CODE_03DB08:
	INX
CODE_03DB09:
	PHA
	LDA.b #$07
	STA.b $06
	PLA
CODE_03DB0F:
	LSR
	BCC.b CODE_03DB2F
	CPY.b #$04
	BEQ.b CODE_03DB2F
	CPX.b #$00
	BNE.b CODE_03DB28
	CPY.b #$02
	BCC.b CODE_03DB24
	LDX.b #$09
	LDY.b #$03
	BRA.b CODE_03DB29

CODE_03DB24:
	LDX.b #$0A
	BRA.b CODE_03DB29

CODE_03DB28:
	DEX
CODE_03DB29:
	PHA
	LDA.b #$07
	STA.b $06
	PLA
CODE_03DB2F:
	LSR
	BCC.b CODE_03DB4A
	CPY.b #$01
	BNE.b CODE_03DB3F
	CPX.b #$0A
	BNE.b CODE_03DB3F
	DEX
	INY
	INY
	BRA.b CODE_03DB44

CODE_03DB3F:
	CPY.b #$04
	BEQ.b CODE_03DB4A
	INY
CODE_03DB44:
	PHA
	LDA.b #$07
	STA.b $06
	PLA
CODE_03DB4A:
	LSR
	BCC.b CODE_03DB58
	CPY.b #$00
	BEQ.b CODE_03DB58
	DEY
	PHA
	LDA.b #$07
	STA.b $06
	PLA
CODE_03DB58:
	STX.b $4A
	STY.b $4C
CODE_03DB5C:
	RTS

CODE_03DB5D:
	SEP.b #$30
	LDA.b $4C
	CMP.b #$04
	BNE.b CODE_03DB71
	LDA.b #$B8
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.b #$98
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	BRA.b CODE_03DBA0

CODE_03DB71:
	ASL
	ASL
	ASL
	STA.b $10
	ASL
	ADC.b #$78
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.b $4A
	CMP.b #$09
	BNE.b CODE_03DB8A
	LDX.b $4C
	CPX.b #$03
	BEQ.b CODE_03DB8E
	BRA.b CODE_03DB95

CODE_03DB8A:
	CMP.b #$0A
	BNE.b CODE_03DB95
CODE_03DB8E:
	LDA.b #$E0
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	BRA.b CODE_03DBA0

CODE_03DB95:
	ASL
	ASL
	ASL
	ASL
	ADC.b $10
	ADC.b #$30
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
CODE_03DBA0:
	STZ.w $0260
	STZ.w $025E
	REP.b #$20
	LDA.w #$0014
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	RTS

CODE_03DBB6:
	SEP.b #$30
	LDA.b $CA
	BPL.b CODE_03DBD5
	LDA.b #$01
	STA.b $50
	LDA.b $4C
	ASL
	ASL
	STA.b $10
	ASL
	ADC.b $10
	ADC.b $4A
	TAY
	LDA.w DATA_03DC47,y
	STA.b $4E
	LDA.b #$06
	STA.b $06
CODE_03DBD5:
	RTS

CODE_03DBD6:
	SEP.b #$20
	REP.b #$10
	LDX.w #$4400
	STX.w $0147
	LDX.w #$0018
	STX.w $0177
	LDX.w #!RAM_SIMC_Global_Layer2TilemapBuffer
	STX.w $0167
	LDX.w #$0800
	STX.w $0187
	LDA.b $B7
	ORA.b #$04
	STA.b $B7
	RTS

DATA_03DBF9:
	dw $03AE,$038A,$038E,$0392,$0396,$039A,$039E,$03A2
	dw $03A6,$03AA,$048E,$0520,$0518,$0496,$0414,$049A
	dw $049E,$04A2,$0428,$04A6,$04AA,$04AE,$0528,$0524
	dw $042C,$0430,$040C,$0418,$0492,$041C,$0424,$051C
	dw $0410,$0514,$0420,$0510,$052C,$0530,$04B2

DATA_03DC47:
	dw $0201,$0403,$0605,$0807,$0009,$FF80,$201A,$1B0E
	dw $221D,$121E,$1918,$FF81,$1C0A,$0F0D,$1110,$1413
	dw $2615,$FF82,$2123,$1F0C,$170B,$2416,$8225,$FF82
	dw $2727,$2727,$2727,$2727,$2727,$FF27

CODE_03DC83:
	REP.b #$30
	LDA.w #$0100
	STA.w $0253
	LDA.w #$00A9
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w #$0061
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$0013
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	RTS

CODE_03DCA5:
	REP.b #$30
	LDA.w #$0080
	STA.w $0253
	LDA.w #$0060
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w #$003D
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$0028
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	SEP.b #$30
	LDA.w $0B5B
	BEQ.b CODE_03DCFD
	LDY.b #$00
	LDX.b #$00
CODE_03DCD1:
	PHY
	LDA.w $0B5C,y
	ASL
	TAY
	REP.b #$20
	LDA.w DATA_03DD00,y
	STA.l SIMC_Global_OAMBuffer[$20].Tile,x
	CLC
	ADC.w #$0010
	STA.l SIMC_Global_OAMBuffer[$21].Tile,x
	LDA.w #$3C2D
	STA.l SIMC_Global_OAMBuffer[$22].Tile,x
	SEP.b #$20
	TXA
	CLC
	ADC.b #$0C
	TAX
	PLY
	INY
	CPY.w $0B5B
	BNE.b CODE_03DCD1
CODE_03DCFD:
	REP.b #$30
	RTS

DATA_03DD00:
	dw $3D90,$3D91,$3D92,$3D93,$3D94,$3D95,$3D96,$3D97
	dw $3D98,$3D99,$3C00,$3C01,$3C02,$3C03,$3C04,$3C05
	dw $3C06,$3C07,$3C08,$3C09,$3C0A,$3C0B,$3C0C,$3C0D
	dw $3C0E,$3C0F,$3C20,$3C21,$3C22,$3C23,$3C24,$3C25
	dw $3C26,$3C27,$3C28,$3C29,$3C2E,$3C2D,$3C2C,$3C2F

CODE_03DD50:
	REP.b #$10
CODE_03DD52:
	JSL.l CODE_059E50
	JSR.w CODE_03DE64
	REP.b #$30
	LDA.w #$0060
	STA.w $0253
	LDA.w #$0060
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w #$0060
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$0015
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	SEP.b #$20
	LDA.b #$03
	STA.b !RAM_SIMC_Global_OAMSizeAndDataAreaDesignation
	LDA.b #$11
	STA.b !RAM_SIMC_Global_MainScreenLayers
	LDA.b #$31
	STA.b !RAM_SIMC_Global_BG1AddressAndSize
	STZ.b !RAM_SIMC_Global_BG1And2TileDataDesignation
	STZ.b !RAM_SIMC_Global_BGModeAndTileSizeSetting
	LDA.b #$08
	CMP.b $08
	BEQ.b CODE_03DD94
	STA.b $03
CODE_03DD94:
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	REP.b #$20
	LDA.w #$0003
	COP.b #$00
	INC.b $14
	RTS

DATA_03DDA6:
	db $00,$01,$02,$00,$01,$02,$03,$03

DATA_03DDAE:
	db $00,$00,$00,$01,$01,$01,$00,$01

CODE_03DDB6:
	SEP.b #$20
	REP.b #$10
	LDA.b #$02
	LDX.b $42
	BPL.b CODE_03DDC1
	INC
CODE_03DDC1:
	STA.b $79
	LDA.b $CA
	AND.b #$0F
	BEQ.b CODE_03DE1C
	AND.b #$0C
	BEQ.b CODE_03DDD9
	LDA.b $54
	EOR.b #$01
	STA.b $54
	PHA
	LDA.b #$07
	STA.b $06
	PLA
CODE_03DDD9:
	LDA.b $CA
	AND.b #$03
	BEQ.b CODE_03DDFE
	LSR
	BCC.b CODE_03DDF1
	LDA.b $52
	CMP.b $79
	BEQ.b CODE_03DDFC
	INC
	PHA
	LDA.b #$07
	STA.b $06
	PLA
	BRA.b CODE_03DDFC

CODE_03DDF1:
	LDA.b $52
	BEQ.b CODE_03DDFC
	DEC
	PHA
	LDA.b #$07
	STA.b $06
	PLA
CODE_03DDFC:
	STA.b $52
CODE_03DDFE:
	LDA.b $52
	CMP.b #$03
	BNE.b CODE_03DE0E
	LDA.b #$06
	LDX.b $54
	BEQ.b CODE_03DE1A
	LDA.b #$07
	BRA.b CODE_03DE1A

CODE_03DE0E:
	LDA.b $54
	ASL
	ADC.b $54
	ADC.b $52
	REP.b #$20
	AND.w #$00FF
CODE_03DE1A:
	STA.b $40
CODE_03DE1C:
	REP.b #$30
	LDX.b $52
	BNE.b CODE_03DE27
	LDA.w #$0000
	BRA.b CODE_03DE2F

CODE_03DE27:
	CPX.w #$0003
	BNE.b CODE_03DE31
	LDA.w #$0050
CODE_03DE2F:
	STA.b $22
CODE_03DE31:
	LDA.b !RAM_SIMC_TitleScreenAndMenu_Layer1XPosLo
	CMP.b $22
	BEQ.b CODE_03DE43
	BCC.b CODE_03DE3F
	DEC.b !RAM_SIMC_TitleScreenAndMenu_Layer1XPosLo
	DEC.b !RAM_SIMC_TitleScreenAndMenu_Layer1XPosLo
	BRA.b CODE_03DE43

CODE_03DE3F:
	INC.b !RAM_SIMC_TitleScreenAndMenu_Layer1XPosLo
	INC.b !RAM_SIMC_TitleScreenAndMenu_Layer1XPosLo
CODE_03DE43:
	JSR.w CODE_03DE64
	LDA.b $C9
	AND.w #$8000
	BEQ.b CODE_03DE54
	JSR.w CODE_03E574
	INC.b $14
	BRA.b CODE_03DE63

CODE_03DE54:
	LDA.b $C9
	AND.w #$0040
	BEQ.b CODE_03DE63
	JSR.w CODE_03E574
	LDA.w #$0002
	STA.b $14
CODE_03DE63:
	RTS

CODE_03DE64:
	REP.b #$20
	LDA.w #$5555
	STA.l SIMC_Global_UpperOAMBuffer[$00].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$02].Slot
	STA.l SIMC_Global_UpperOAMBuffer[$04].Slot
	STZ.w $0253
	LDA.w #$00A0
	SEC
	SBC.b !RAM_SIMC_TitleScreenAndMenu_Layer1XPosLo
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w #$0060
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$0012
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	DEC.b $2C
	BNE.b CODE_03DEA4
	LDA.w #$0008
	STA.b $2C
	LDA.b $30
	EOR.w #$0001
	STA.b $30
CODE_03DEA4:
	LDA.b $30
	BEQ.b CODE_03DEC8
	LDA.b $40
	ASL
	TAX
	LDA.w DATA_03DF10,x
	SEC
	SBC.b $16
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w DATA_03DF00,x
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$0011
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
CODE_03DEC8:
	REP.b #$30
	LDA.w #$0084
	STA.w $0253
	LDA.b $42
	LDY.w #$0000
CODE_03DED5:
	PHY
	LSR
	BCC.b CODE_03DEF7
	PHA
	LDA.w DATA_03DF30,y
	SEC
	SBC.b $16
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w DATA_03DF20,y
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$0029
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	PLA
CODE_03DEF7:
	PLY
	INY
	INY
	CPY.w #$0010
	BNE.b CODE_03DED5
	RTS

DATA_03DF00:
	dw $0027,$0027,$0027,$007F,$007F,$007F,$0027,$007F

DATA_03DF10:
	dw $0010,$0060,$00B0,$0010,$0060,$00B0,$0100,$0100

DATA_03DF20:
	dw $0014,$0014,$0014,$006C,$006C,$006C,$0014,$006C

DATA_03DF30:
	dw $000E,$005E,$00AE,$000E,$005E,$00AE,$00FE,$00FE

CODE_03DF40:
	SEP.b #$20
	REP.b #$20
	LDA.w #$0004
	COP.b #$00
CODE_03DF49:
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	REP.b #$20
	LDA.w #$0001
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_08C4DB
	STX.b $09
	LDA.b #DATA_08C4DB>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_09875C
	STX.b $09
	LDA.b #DATA_09875C>>16
	STA.b $0B
	LDX.w #$4000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #$0000
	STX.w !REGISTER_VRAMAddressLo
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer
	STA.w DMA[$00].SourceLo,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$80
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_03DFCC
CODE_03DFC8:
	ASL
	DEX
	BNE.b CODE_03DFC8
CODE_03DFCC:
	STA.w !REGISTER_DMAEnable
	SEP.b #$20
	REP.b #$10
	LDY.b !RAM_SIMC_Global_CurrentScenario
	LDA.w DATA_03E1C8,y
	STA.b $09
	LDA.w DATA_03E1D4,y
	STA.b $0A
	LDA.w DATA_03E1E0,y
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0C869D
	STX.b $09
	LDA.b #DATA_0C869D>>16
	STA.b $0B
	LDX.w #$1000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0C87CB
	STX.b $09
	LDA.b #DATA_0C87CB>>16
	STA.b $0B
	LDX.w #$2000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0C89B9
	STX.b $09
	LDA.b #DATA_0C89B9>>16
	STA.b $0B
	LDX.w #$2800
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #$4000
	STX.w !REGISTER_VRAMAddressLo
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer
	STA.w DMA[$00].SourceLo,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$30
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_03E07B
CODE_03E077:
	ASL
	DEX
	BNE.b CODE_03E077
CODE_03E07B:
	STA.w !REGISTER_DMAEnable
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0AC460
	STX.b $09
	LDA.b #DATA_0AC460>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	REP.b #$20
	LDA.w #$6000
	STA.w !REGISTER_VRAMAddressLo
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer
	STA.w DMA[$00].SourceLo,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$10
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_03E0D5
CODE_03E0D1:
	ASL
	DEX
	BNE.b CODE_03E0D1
CODE_03E0D5:
	STA.w !REGISTER_DMAEnable
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0C8ED8
	STX.b $09
	LDA.b #DATA_0C8ED8>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	STZ.w !REGISTER_CGRAMAddress
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$00
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToCGRAMPort
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer
	STA.w DMA[$00].SourceLo,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$02
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_03E12E
CODE_03E12A:
	ASL
	DEX
	BNE.b CODE_03E12A
CODE_03E12E:
	STA.w !REGISTER_DMAEnable
	REP.b #$30
	STZ.w $0253
	LDA.w #$0108
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w #$009F
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$0025
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	LDA.w #$0032
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w #$00CF
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$0026
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	JSR.w CODE_03E227
	LDX.w #$FF88
	STX.b !RAM_SIMC_TitleScreenAndMenu_Layer1YPosLo
	STX.b !RAM_SIMC_TitleScreenAndMenu_Layer2YPosLo
	STZ.b !RAM_SIMC_TitleScreenAndMenu_Layer1XPosLo
	LDA.b #$02
	STA.b !RAM_SIMC_Global_BG1And2TileDataDesignation
	LDA.b #$00
	STA.b !RAM_SIMC_Global_BG3And4TileDataDesignation
	LDA.b #$42
	STA.b !RAM_SIMC_Global_BG1AddressAndSize
	LDA.b #$4A
	STA.b !RAM_SIMC_Global_BG2AddressAndSize
	LDA.b #$50
	STA.b !RAM_SIMC_Global_BG3AddressAndSize
	LDA.b #$54
	STA.b !RAM_SIMC_Global_BG4AddressAndSize
	LDA.b #$17
	STA.b !RAM_SIMC_Global_MainScreenLayers
	LDA.b #$08
	STA.b !RAM_SIMC_Global_SubScreenLayers
	LDA.b #$02
	STA.b !RAM_SIMC_Global_ColorMathInitialSettings
	LDA.b #$A7
	STA.b !RAM_SIMC_Global_ColorMathSelectAndEnable
	LDA.b #$E0
	STA.b !RAM_SIMC_Global_FixedColorData
	LDA.b #$03
	STA.b !RAM_SIMC_Global_OAMSizeAndDataAreaDesignation
	STZ.b !RAM_SIMC_Global_BGModeAndTileSizeSetting
	STZ.b !RAM_SIMC_Global_MainScreenWindowMask
	STZ.b !RAM_SIMC_Global_SubScreenWindowMask
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	REP.b #$20
	LDA.w #$0003
	COP.b #$00
	INC.b $14
	SEP.b #$20
	LDA.b #$0B
	STA.b $05
	REP.b #$20
	RTS

DATA_03E1C8:
	db DATA_0BF764,DATA_0BF2EA,DATA_0BF972,DATA_0BF543,DATA_0BF06A,DATA_0BEE30,DATA_0BFE00,DATA_0C8066,DATA_0BFBE7,DATA_0C8539,DATA_0C82AD,DATA_0C83CE

DATA_03E1D4:
	db DATA_0BF764>>8,DATA_0BF2EA>>8,DATA_0BF972>>8,DATA_0BF543>>8,DATA_0BF06A>>8,DATA_0BEE30>>8,DATA_0BFE00>>8,DATA_0C8066>>8,DATA_0BFBE7>>8,DATA_0C8539>>8,DATA_0C82AD>>8,DATA_0C83CE>>8

DATA_03E1E0:
	db DATA_0BF764>>16,DATA_0BF2EA>>16,DATA_0BF972>>16,DATA_0BF543>>16,DATA_0BF06A>>16,DATA_0BEE30>>16,DATA_0BFE00>>16,DATA_0C8066>>16,DATA_0BFBE7>>16,DATA_0C8539>>16,DATA_0C82AD>>16,DATA_0C83CE>>16

CODE_03E1EC:
	REP.b #$30
	LDX.b $18
	BEQ.b CODE_03E1F8
	INX
	STX.b $18
	STX.b $1C
	RTS

CODE_03E1F8:
	LDA.b $C9
	AND.w #$8000
	BEQ.b CODE_03E217
	JSR.w CODE_03E574
	REP.b #$20
	LDA.w #$0004
	COP.b #$00
	JSR.w CODE_03C674
	LDA.w #$8000
	STA.b $14
	SEP.b #$20
	STZ.b !RAM_SIMC_Global_HDMAEnable
	BRA.b CODE_03E226

CODE_03E217:
	LDA.b $C9
	AND.w #$0040
	BEQ.b CODE_03E226
	JSR.w CODE_03E574
	LDA.w #$000A
	STA.b $14
CODE_03E226:
	RTS

CODE_03E227:
	LDX.w #DATA_03E23F
	STX.w HDMA[$07].SourceLo
	LDA.b #DATA_03E23F>>16
	STA.w HDMA[$07].SourceBank
	LDA.b #!REGISTER_MainScreenLayers
	STA.w HDMA[$07].Destination
	STZ.w HDMA[$07].Parameters
	LDA.b #$80
	STA.b !RAM_SIMC_Global_HDMAEnable
	RTS

DATA_03E23F:
	db $7F,$17,$47,$17,$01,$14,$00

CODE_03E246:
	REP.b #$30
	LDA.b $40
	PHA
	LDA.w #$0008
	STA.b $40
	JSR.w CODE_03DF40
	PLA
	STA.b $40
	RTS

CODE_03E257:
	REP.b #$30
	LDX.b $18
	BEQ.b CODE_03E263
	INX
	STX.b $18
	STX.b $1C
	RTS

CODE_03E263:
	LDA.b $C9
	AND.w #$8000
	BEQ.b CODE_03E282
	JSR.w CODE_03E574
	REP.b #$20
	LDA.w #$0004
	COP.b #$00
	JSR.w CODE_03C5EB
	LDA.w #$8000
	STA.b $14
	SEP.b #$20
	STZ.b !RAM_SIMC_Global_HDMAEnable
	BRA.b CODE_03E291

CODE_03E282:
	LDA.b $C9
	AND.w #$0040
	BEQ.b CODE_03E291
	JSR.w CODE_03E574
	LDA.w #$0002
	STA.b $14
CODE_03E291:
	RTS

CODE_03E292:
	JSL.l CODE_02BD0E
CODE_03E296:
	JSL.l CODE_02BEC6
	LDA.b $C9
	AND.w #$9000
	BEQ.b CODE_03E2CD
	LDA.w $0421
	INC
	AND.b $44
	BEQ.b CODE_03E2C4
	SEP.b #$20
	LDA.b #$06
	STA.b $05
	REP.b #$20
CODE_03E2B1:
	REP.b #$20
	LDA.w #$0004
	COP.b #$00
	INC.w $0421
	JSR.w CODE_03C5E5
	LDA.w #$8000
	STA.b $14
	RTS

CODE_03E2C4:
	SEP.b #$20
	LDA.b #$02
	STA.b $05
	REP.b #$20
	RTS

CODE_03E2CD:
	LDA.b $C9
	AND.w #$0040
	BEQ.b CODE_03E2DC
	JSR.w CODE_03E574
	LDA.w #$0003
	STA.b $14
CODE_03E2DC:
	RTS

DATA_03E2DD:
	db $84,$A4

CODE_03E2DF:
	SEP.b #$20
	LDA.b #$11
	LDY.w $0D87
	DEY
	BNE.b CODE_03E2EB
	LDA.b #$12
CODE_03E2EB:
	STA.b $03
	REP.b #$30
	LDA.b $40
	PHA
	LDX.w #$0009
	LDA.b $3E
	CMP.w #$0003
	BNE.b CODE_03E322
	LDA.w $0D87
	CMP.w #$0002
	BNE.b CODE_03E322
	LDA.b $40
	ASL
	TAY
	LDA.b $42
	ORA.w DATA_03E334,y
	STA.b $42
	BMI.b CODE_03E321
	AND.w #$003F
	CMP.w #$003F
	BNE.b CODE_03E321
	LDA.b $42
	ORA.w #$8000
	STA.b $42
	INX
CODE_03E321:
	INX
CODE_03E322:
	STX.b $40
	LDA.b $42
	STA.l $700007
	JSR.w CODE_03E553
	JSR.w CODE_03DF49
	PLA
	STA.b $40
	RTS

DATA_03E334:
	dw $0001,$0002,$0004,$0008,$0010,$0020,$0040,$0080

CODE_03E344:
	JSL.l CODE_059FBB
	RTS

CODE_03E349:
	REP.b #$30
	JSR.w CODE_03E40A
	BEQ.b CODE_03E35D
	JSR.w CODE_03E446
	JSR.w CODE_03E40A
	BEQ.b CODE_03E360
	JSR.w CODE_03E45B
	BRA.b CODE_03E368

CODE_03E35D:
	JSR.w CODE_03E484
CODE_03E360:
	JSR.w CODE_03E499
	BEQ.b CODE_03E368
	JSR.w CODE_03E553
CODE_03E368:
	LDA.l $700007
	STA.b $42
	LDA.l $700009
	AND.w #$00FF
	STA.w $0425
	LDY.w #$0000
	LDA.b $44
	BNE.b CODE_03E380
	INY
CODE_03E380:
	STY.b $3E
	LDA.w #$FFFF
	STA.w $0B65
	STA.w $0B75
	LDA.b $44
	AND.w #$0001
	BEQ.b CODE_03E3CA
	LDA.l $700036
	STA.w $0B65
	LDA.l $700030
	STA.w $0B67
	LDA.l $700032
	STA.w $0B69
	LDA.l $700076
	STA.w $0B6B
	LDA.l $700078
	STA.w $0B6D
	LDA.l $70007A
	STA.w $0B6F
	LDA.l $70007C
	STA.w $0B71
	LDA.l $70007E
	STA.w $0B73
CODE_03E3CA:
	LDA.b $44
	AND.w #$0002
	BEQ.b CODE_03E409
	LDA.l $704026
	STA.w $0B75
	LDA.l $704020
	STA.w $0B77
	LDA.l $704022
	STA.w $0B79
	LDA.l $704066
	STA.w $0B7B
	LDA.l $704068
	STA.w $0B7D
	LDA.l $70406A
	STA.w $0B7F
	LDA.l $70406C
	STA.w $0B81
	LDA.l $70406E
	STA.w $0B83
CODE_03E409:
	RTS

CODE_03E40A:
	REP.b #$30
	STZ.b $46
	LDX.w #$0000
CODE_03E411:
	LDA.l $700000,x
	AND.w #$00FF
	CLC
	ADC.b $46
	STA.b $46
	INX
	CPX.w #$000E
	BNE.b CODE_03E411
	CMP.l $70000E
	BNE.b CODE_03E443
	SEP.b #$20
	LDA.l $700000
	CMP.b #$53
	BNE.b CODE_03E443
	LDA.l $700001
	CMP.b #$49
	BNE.b CODE_03E443
	LDA.l $700002
	CMP.b #$4D
	BNE.b CODE_03E443
CODE_03E443:
	REP.b #$20
	RTS

CODE_03E446:
	REP.b #$20
	LDX.w #$0000
CODE_03E44B:
	LDA.l $707FF0,x
	STA.l $700000,x
	INX
	INX
	CPX.w #$0010
	BNE.b CODE_03E44B
	RTS

CODE_03E45B:
	SEP.b #$20
	LDA.b #$53
	STA.l $700000
	LDA.b #$49
	STA.l $700001
	LDA.b #$4D
	STA.l $700002
	REP.b #$20
	LDA.w #$0000
	STA.l $700005
	STA.l $700007
	STA.l $700009
	JSR.w CODE_03E553
	RTS

CODE_03E484:
	REP.b #$20
	LDX.w #$0000
CODE_03E489:
	LDA.l $700000,x
	STA.l $707FF0,x
	INX
	INX
	CPX.w #$0010
	BNE.b CODE_03E489
	RTS

CODE_03E499:
	REP.b #$30
	LDA.l $700005
	AND.w #$00FF
	BEQ.b CODE_03E4D2
	STZ.b $46
	LDX.w #$0000
CODE_03E4A9:
	LDA.l $700010,x
	AND.w #$00FF
	CLC
	ADC.b $46
	STA.b $46
	INX
	CPX.w #$3FF0
	BNE.b CODE_03E4A9
	CMP.l $70000A
	BNE.b CODE_03E4C8
	LDA.w #$0001
	STA.b $44
	BRA.b CODE_03E4D2

CODE_03E4C8:
	SEP.b #$20
	LDA.b #$00
	STA.l $700005
	REP.b #$20
CODE_03E4D2:
	LDA.l $700006
	AND.w #$00FF
	BEQ.b CODE_03E50B
	STZ.b $46
	LDX.w #$0000
CODE_03E4E0:
	LDA.l $704000,x
	AND.w #$00FF
	CLC
	ADC.b $46
	STA.b $46
	INX
	CPX.w #$3FF0
	BNE.b CODE_03E4E0
	CMP.l $70000C
	BNE.b CODE_03E501
	LDA.b $44
	ORA.w #$0002
	STA.b $44
	BRA.b CODE_03E50B

CODE_03E501:
	SEP.b #$20
	LDA.b #$00
	STA.l $700006
	REP.b #$20
CODE_03E50B:
	RTS

CODE_03E50C:
	REP.b #$30
	LDA.w $0423
	CMP.w #$0001
	BNE.b CODE_03E533
	STZ.b $46
	LDX.w #$0000
CODE_03E51B:
	LDA.l $700010,x
	AND.w #$00FF
	CLC
	ADC.b $46
	STA.b $46
	INX
	CPX.w #$3FF0
	BNE.b CODE_03E51B
	STA.l $70000A
	BRA.b CODE_03E54E

CODE_03E533:
	STZ.b $46
	LDX.w #$0000
CODE_03E538:
	LDA.l $704000,x
	AND.w #$00FF
	CLC
	ADC.b $46
	STA.b $46
	INX
	CPX.w #$3FF0
	BNE.b CODE_03E538
	STA.l $70000C
CODE_03E54E:
	RTS

CODE_03E54F:
	JSR.w CODE_03E553
	RTL

CODE_03E553:
	REP.b #$20
	STZ.b $46
	LDX.w #$0000
CODE_03E55A:
	LDA.l $700000,x
	AND.w #$00FF
	CLC
	ADC.b $46
	STA.b $46
	INX
	CPX.w #$000E
	BNE.b CODE_03E55A
	STA.l $70000E
	JSR.w CODE_03E484
	RTS

CODE_03E574:
	PHP
	SEP.b #$20
	PHA
	LDA.b #$06
	STA.b $05
	PLA
	PLP
	RTS

DATA_03E57F:
	db $40,$41,$42,$43,$44,$45,$46,$47,$48,$49,$00,$01,$02,$03,$04,$05
	db $06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F,$20,$21,$22,$23,$24,$25
	db $26,$27,$28,$29,$2D,$2D,$2C,$2D

DATA_03E5A7:
	db $50,$51,$52,$53,$54,$55,$56,$57,$58,$59,$10,$11,$12,$13,$14,$15
	db $16,$17,$18,$19,$1A,$1B,$1C,$1D,$1E,$1F,$30,$31,$32,$33,$34,$35
	db $36,$37,$38,$39,$3E,$3D,$3C,$2D

DATA_03E5CF:
	dw DATA_03E5DF,DATA_03E6D1,DATA_03E7A3,DATA_03E8CD,DATA_03EA4F,DATA_03E5DF,DATA_03E5DF,DATA_03E5DF

DATA_03E5DF:
	dw $0000,$0002,$0001,$0053,$0002,$0054,$0003,$0055
	dw $0004,$0056,$0005,$0000,$0006,$0057,$0007,$0058
	dw $0008,$0059,$0009,$005A,$000A,$005B,$000B,$0004
	dw $0010,$0003,$0011,$0063,$0012,$0064,$0013,$0065
	dw $0014,$0066,$0015,$0001,$0016,$0067,$0017,$0068
	dw $0018,$0069,$0019,$006A,$001A,$006B,$001B,$0005
	dw $000C,$0070,$000D,$0071,$000E,$0072,$001C,$0073
	dw $001D,$0074,$001E,$0075,$002C,$0076,$002D,$0077
	dw $002E,$0078,$0040,$0079,$0041,$007A,$0042,$007B
	dw $0050,$007C,$0051,$007D,$0052,$007E,$0060,$007F
	dw $0061,$0080,$0062,$0081,$0044,$0082,$0045,$0083
	dw $0046,$0084,$0054,$0085,$0055,$0086,$0056,$0087
	dw $0064,$0088,$0065,$0089,$0066,$008A,$0048,$008B
	dw $0049,$008C,$004A,$008D,$0058,$008E,$0059,$008F
	dw $005A,$0090,$0068,$0091,$0069,$0092,$006A,$0093
	dw $FFFF

DATA_03E6D1:
	dw $0002,$0002,$0003,$003D,$0004,$003E,$0005,$003F
	dw $0006,$0050,$0007,$0051,$0008,$0052,$0009,$0004
	dw $0012,$0003,$0013,$004D,$0014,$004E,$0015,$004F
	dw $0016,$0060,$0017,$0061,$0018,$0062,$0019,$0005
	dw $000C,$0094,$000D,$0095,$000E,$0096,$001C,$0097
	dw $001D,$0098,$001E,$0099,$002C,$009A,$002D,$009B
	dw $002E,$009C,$0040,$009D,$0041,$009E,$0042,$009F
	dw $0050,$00A0,$0051,$00A1,$0052,$00A2,$0060,$00A3
	dw $0061,$00A4,$0062,$00A5,$0044,$00A6,$0045,$00A7
	dw $0046,$00A8,$0054,$00A9,$0055,$00AA,$0056,$00AB
	dw $0064,$00AC,$0065,$00AD,$0066,$00AE,$0048,$00AF
	dw $0049,$00B0,$004A,$00B1,$0058,$00B2,$0059,$00B3
	dw $005A,$00B4,$0068,$00B5,$0069,$00B6,$006A,$00B7
	dw $FFFF

DATA_03E7A3:
	dw $0001,$0010,$0002,$0011,$0003,$0012,$0004,$0013
	dw $0005,$0014,$0006,$0015,$0007,$0016,$0008,$0017
	dw $0009,$0018,$000A,$005E,$0011,$0020,$0012,$0021
	dw $0013,$0022,$0014,$0023,$0015,$0024,$0016,$0025
	dw $0017,$0026,$0018,$0027,$0019,$0028,$001A,$006E
	dw $000C,$00B8,$000D,$00B9,$000E,$00BA,$001C,$00BB
	dw $001D,$00BC,$001E,$00BD,$002C,$00BE,$002D,$00BF
	dw $002E,$00C0,$0040,$00C1,$0041,$00C2,$0042,$00C3
	dw $0050,$00C4,$0051,$00C5,$0052,$00C6,$0060,$00C7
	dw $0061,$00C8,$0062,$00C9,$0044,$00CA,$0045,$00CB
	dw $0046,$00CC,$0054,$00CD,$0055,$00CE,$0056,$00CF
	dw $0064,$00D0,$0065,$00D1,$0066,$00D2,$0048,$00D3
	dw $0049,$00D4,$004A,$00D5,$0058,$00D6,$0059,$00D7
	dw $005A,$00D8,$0068,$00D9,$0069,$00DA,$006A,$00DB
	dw $004C,$00DC,$004D,$00DD,$004E,$00DE,$005C,$00DF
	dw $005D,$00E0,$005E,$00E1,$006C,$00E2,$006D,$00E3
	dw $006E,$00E4,$0080,$00E5,$0081,$00E6,$0082,$00E7
	dw $0090,$00E8,$0091,$00E9,$0092,$00EA,$0084,$00EB
	dw $0085,$00EC,$0086,$00ED,$FFFF

DATA_03E8CD:
	dw $0000,$0019,$0001,$001A,$0002,$001B,$0003,$001C
	dw $0004,$001D,$0005,$001E,$0006,$001F,$0007,$0030
	dw $0008,$0031,$0009,$0032,$000A,$0033,$000B,$005C
	dw $0010,$0029,$0011,$002A,$0012,$002B,$0013,$002C
	dw $0014,$002D,$0015,$002E,$0016,$002F,$0017,$0040
	dw $0018,$0041,$0019,$0042,$001A,$0043,$001B,$006C
	dw $000C,$00EE,$000D,$00EF,$000E,$00F0,$001C,$00F1
	dw $001D,$00F2,$001E,$00F3,$002C,$00F4,$002D,$00F5
	dw $002E,$00F6,$0040,$00F7,$0041,$00F8,$0042,$00F9
	dw $0050,$00FA,$0051,$00FB,$0052,$00FC,$0060,$00FD
	dw $0061,$00FE,$0062,$00FF,$0044,$0100,$0045,$0101
	dw $0046,$0102,$0054,$0103,$0055,$0104,$0056,$0105
	dw $0064,$0106,$0065,$0107,$0066,$0108,$0048,$0109
	dw $0049,$010A,$004A,$010B,$0058,$010C,$0059,$010D
	dw $005A,$010E,$0068,$010F,$0069,$0110,$006A,$0111
	dw $004C,$0136,$004D,$0137,$004E,$0138,$005C,$0139
	dw $005D,$013A,$005E,$013B,$006C,$013C,$006D,$013D
	dw $006E,$013E,$0080,$013F,$0081,$0140,$0082,$0141
	dw $0090,$0142,$0091,$0143,$0092,$0144,$0084,$0145
	dw $0085,$0146,$0086,$0147,$0088,$0148,$0089,$0149
	dw $008A,$014A,$0098,$014B,$0099,$014C,$009A,$014D
	dw $008C,$014E,$008D,$014F,$008E,$0150,$00A0,$0151
	dw $00A1,$0152,$00A2,$0153,$00B0,$0154,$00B1,$0155
	dw $00B2,$0156,$00A4,$0157,$00A5,$0158,$00A6,$0159
	dw $FFFF

DATA_03EA4F:
	dw $0001,$0034,$0002,$0035,$0003,$0036,$0004,$0037
	dw $0005,$0038,$0006,$0039,$0007,$003A,$0008,$003B
	dw $0009,$003C,$000A,$005D,$0011,$0044,$0012,$0045
	dw $0013,$0046,$0014,$0047,$0015,$0048,$0016,$0049
	dw $0017,$004A,$0018,$004B,$0019,$004C,$001A,$006D
	dw $000C,$0112,$000D,$0113,$000E,$0114,$001C,$0115
	dw $001D,$0116,$001E,$0117,$002C,$0118,$002D,$0119
	dw $002E,$011A,$0040,$011B,$0041,$011C,$0042,$011D
	dw $0050,$011E,$0051,$011F,$0052,$0120,$0060,$0121
	dw $0061,$0122,$0062,$0123,$0044,$0124,$0045,$0125
	dw $0046,$0126,$0054,$0127,$0055,$0128,$0056,$0129
	dw $0064,$012A,$0065,$012B,$0066,$012C,$0048,$012D
	dw $0049,$012E,$004A,$012F,$0058,$0130,$0059,$0131
	dw $005A,$0132,$0068,$0133,$0069,$0134,$006A,$0135
	dw $FFFF

DATA_03EB31:
	dw $0080,$00E0,$0140,$01A0,$0000,$0020,$0040,$0060

DATA_03EB41:
	dw $0000,$0080,$0100,$0180,$0000,$0020,$0040,$0060

DATA_03EB51:
	dw $FFFF,$0033,$0067,$009D,$00D5,$00E5,$00F5,$0105

DATA_03EB61:
	dw $FFFF,$0026,$0046,$0067,$008E,$0091,$0094,$0097

DATA_03EB71:
	dw $0017,$0017,$0018,$0019,$001A,$0000,$0000,$0000
	dw $0017,$001D,$000D,$000E,$0006,$0005,$0004,$0005
	dw $0006,$000E,$0006,$0005,$0004,$0005,$0006,$0007
	dw $0008,$0009,$000A,$000B,$000A,$0009,$0008,$0007
	dw $0000,$0000,$0000,$000D,$000E,$0006,$0005,$0004
	dw $0005,$0006,$000E,$001C,$001F,$001B,$0000,$0000
	dw $0000,$0017,$0000,$0000,$0017,$0018,$0019,$001A
	dw $0000,$0000,$0000,$0017,$0018,$001C,$000D,$000E
	dw $0006,$0005,$0004,$0005,$0006,$000E,$0006,$0005
	dw $0004,$0005,$0006,$0007,$0008,$0009,$000A,$000B
	dw $000A,$0009,$0008,$0007,$0000,$0000,$0000,$000D
	dw $000E,$0006,$0005,$0004,$0005,$0006,$000E,$001C
	dw $001F,$001B,$0000,$0000,$0000,$0017,$0000,$0000
	dw $0000,$0000,$0001,$0002,$0003,$0000,$0000,$0000
	dw $0000,$0001,$0002,$000A,$000D,$000E,$0006,$0005
	dw $0004,$0005,$0006,$000E,$0006,$0005,$0004,$0005
	dw $0006,$0007,$0008,$0009,$000A,$000B,$000A,$0009
	dw $0008,$0007,$0000,$0000,$0000,$000D,$000E,$0006
	dw $0005,$0004,$0005,$0006,$000E,$001B,$001F,$001C
	dw $0000,$0000,$0000,$0017,$0000,$0000,$0000,$0000
	dw $0001,$0002,$0003,$0000,$0000,$0000,$0000,$0001
	dw $0002,$001F,$001E,$001F,$001E,$001F,$0006,$0005
	dw $0004,$0005,$0006,$000E,$0006,$0005,$0004,$0005
	dw $0006,$0007,$0008,$0009,$000A,$000B,$000A,$0009
	dw $0008,$0007,$0000,$0000,$0000,$000D,$000E,$0006
	dw $0005,$0004,$0005,$0006,$000E,$001B,$001F,$001C
	dw $0000,$0000,$0000,$0017,$0000,$0000,$0020,$000F
	dw $0010,$0011,$0012,$0013,$0014,$0015,$0016,$0020
	dw $0000,$0000,$0000,$0020,$0000,$0000,$0020,$000F
	dw $0010,$0011,$0012,$0013,$0014,$0015,$0016,$0020
	dw $0000,$0000,$0000,$0020,$0000,$0000,$0020,$000F
	dw $0010,$0011,$0012,$0013,$0014,$0015,$0016,$0020
	dw $0000,$0000,$0000,$0020,$0000,$0000,$0020,$000F
	dw $0010,$0011,$0012,$0013,$0014,$0015,$0016,$0020
	dw $0000,$0000,$0000,$0020,$0000,$0000

DATA_03ED9D:
	dw $006F,$0004,$0004,$0004,$0004,$FFFD,$0006,$0002
	dw $0004,$0030,$0039,$0004,$0004,$0004,$0030,$0004
	dw $0004,$0030,$0004,$0005,$000E,$0005,$0004,$0004
	dw $0004,$0004,$0005,$000E,$0005,$0004,$0004,$0004
	dw $FFFD,$0010,$0006,$004B,$0004,$0004,$0004,$0030
	dw $0004,$0004,$0040,$0008,$0028,$0008,$FFFD,$0005
	dw $000B,$0010,$FFFE,$0003,$0004,$0004,$0004,$0004
	dw $FFFD,$0006,$0003,$0004,$0001,$0030,$0097,$0004
	dw $0004,$0004,$0030,$0004,$0004,$0039,$0004,$0005
	dw $000E,$0005,$0004,$0004,$0004,$0004,$0005,$000E
	dw $0005,$0004,$0004,$0004,$FFFD,$0010,$0006,$0042
	dw $0004,$0004,$0004,$0030,$0004,$0004,$0030,$0008
	dw $0028,$0008,$FFFD,$0005,$0009,$0010,$FFFE,$0003
	dw $0035,$0004,$0004,$0004,$0004,$FFFD,$0006,$0003
	dw $0004,$0004,$0002,$0030,$005D,$0004,$0004,$0004
	dw $0030,$0004,$0004,$0042,$0004,$0005,$000E,$0005
	dw $0004,$0004,$0004,$0004,$0005,$000E,$0005,$0004
	dw $0004,$0004,$FFFD,$0010,$0006,$0039,$0004,$0004
	dw $0004,$0030,$0004,$0004,$0030,$0008,$0028,$0008
	dw $FFFD,$0005,$0009,$0010,$FFFE,$0003,$0093,$0004
	dw $0004,$0004,$0004,$FFFD,$0006,$0002,$0004,$0004
	dw $0001,$0020,$0012,$0012,$0008,$0008,$0004,$0004
	dw $0020,$0004,$0004,$004B,$0004,$0005,$000E,$0005
	dw $0004,$0004,$0004,$0004,$0005,$000E,$0005,$0004
	dw $0004,$0004,$FFFD,$0010,$0006,$0030,$0004,$0004
	dw $0004,$0030,$0004,$0004,$0040,$0008,$0028,$0008
	dw $FFFD,$0005,$000B,$0010,$FFFE,$0003,$019C,$0007
	dw $0007,$0007,$0007,$0009,$0009,$0009,$0009,$0010
	dw $FFFD,$000B,$0006,$0600,$FFFE,$0003,$01A5,$0007
	dw $0007,$0007,$0007,$0009,$0009,$0009,$0009,$0010
	dw $FFFD,$000B,$0006,$0600,$FFFE,$0003,$01AE,$0007
	dw $0007,$0007,$0007,$0009,$0009,$0009,$0009,$0010
	dw $FFFD,$000B,$0006,$0600,$FFFE,$0003,$01B7,$0007
	dw $0007,$0007,$0007,$0009,$0009,$0009,$0009,$0010
	dw $FFFD,$000B,$0006,$0600,$FFFE,$0003

DATA_03EFC9:
	dw $0000,$0200,$0000,$0100,$0000,$0100,$0100,$0000
	dw $0100,$0100,$0000,$0100,$0100,$0000,$0100,$0100
	dw $0000,$0100,$0100,$0000,$0100,$0100,$0000,$0100
	dw $0100,$0000,$0100,$0100,$0000,$0100,$0100,$0000
	dw $0100,$0100,$0000,$0100,$0000,$0000,$0000,$0200
	dw $0000,$0100,$0000,$0100,$0100,$0000,$0100,$0100
	dw $0000,$0100,$0100,$0000,$0100,$0100,$0000,$0100
	dw $0100,$0000,$0100,$0100,$0000,$0100,$0100,$0000
	dw $0100,$0100,$0000,$0100,$0000,$0000,$0000,$0000
	dw $FE00,$0000,$FF00,$0000,$FF00,$FF00,$0000,$FF00
	dw $FF00,$0000,$FF00,$FF00,$0000,$FF00,$FF00,$0000
	dw $FF00,$FF00,$0000,$FF00,$FF00,$0000,$FF00,$FF00
	dw $0000,$FF00,$FF00,$0000,$FF00,$0000,$0000,$0000
	dw $0000,$FE00,$0000,$FF00,$0000,$FF00,$FF00,$0000
	dw $FF00,$FF00,$0000,$FF00,$FF00,$0000,$FF00,$FF00
	dw $0000,$FF00,$FF00,$0000,$FF00,$FF00,$0000,$FF00
	dw $FF00,$0000,$FF00,$FF00,$0000,$FF00,$FF00,$0000
	dw $FF00,$FF00,$0000,$FF00,$0000,$0000,$0000,$0000
	dw $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	dw $0000,$0000,$0000

DATA_03F0FF:
	dw $006F,$0024,$038C,$0008,$0028,$0008,$0008,$0028
	dw $0008,$0008,$0028,$0008,$0008,$0028,$0008,$0008
	dw $0028,$0008,$0008,$0028,$0008,$0008,$0028,$0008
	dw $0008,$0028,$0008,$0008,$0028,$0008,$0008,$0028
	dw $0008,$0008,$0028,$0008,$0010,$FFFE,$0003,$0035
	dw $03DA,$0008,$0028,$0008,$0008,$0028,$0008,$0008
	dw $0028,$0008,$0008,$0028,$0008,$0008,$0028,$0008
	dw $0008,$0028,$0008,$0008,$0028,$0008,$0008,$0028
	dw $0008,$0008,$0028,$0008,$0010,$FFFE,$0003,$0035
	dw $003A,$03A0,$0008,$0028,$0008,$0008,$0028,$0008
	dw $0008,$0028,$0008,$0008,$0028,$0008,$0008,$0028
	dw $0008,$0008,$0028,$0008,$0008,$0028,$0008,$0008
	dw $0028,$0008,$0008,$0028,$0008,$0010,$FFFE,$0003
	dw $0093,$0029,$0363,$0008,$0028,$0008,$0008,$0028
	dw $0008,$0008,$0028,$0008,$0008,$0028,$0008,$0008
	dw $0028,$0008,$0008,$0028,$0008,$0008,$0028,$0008
	dw $0008,$0028,$0008,$0008,$0028,$0008,$0008,$0028
	dw $0008,$0008,$0028,$0008,$0010,$FFFE,$0003,$0600
	dw $FFFE,$0003,$0600,$FFFE,$0003,$0600,$FFFE,$0003
	dw $0600,$FFFE,$0003

DATA_03F235:
	dw $0106,$0106,$0106,$0106,$004E,$0070,$0092,$00B4

CODE_03F245:
	REP.b #$30
	LDA.w #$FFFF
	LDX.w #$000E
CODE_03F24D:
	LDA.l DATA_03EB51,x
	STA.w $02D7,X
	LDA.l DATA_03EB61,x
	STA.w $02E7,x
	STZ.w $02F7,x
	STZ.w $0307,x
	STZ.w $0317,x
	STZ.w $0327,x
	STZ.w $0357,x
	STZ.w $0367,x
	STZ.w $02C7,x
	LDA.l DATA_03F235,x
	STA.w $0337,x
	LDA.w #$0097
	STA.w $0347,x
	DEX
	DEX
	BPL.b CODE_03F24D
	RTL

CODE_03F282:
	REP.b #$30
	LDA.w !RAM_SIMC_City_CurrentWrightMessage
	CMP.w #$002F
	BNE.b CODE_03F2AA
	LDX.w #$0010
CODE_03F28F:
	LDA.l SIMC_Global_PaletteMirror[$D0].LowByte,x
	STA.l SIMC_Global_PaletteMirror[$D1].LowByte,x
	DEX
	DEX
	BPL.b CODE_03F28F
	LDA.l SIMC_Global_PaletteMirror[$D9].LowByte
	STA.l SIMC_Global_PaletteMirror[$D0].LowByte
	LDA.b $BB
	ORA.w #$0002
	STA.b $BB
CODE_03F2AA:
	RTL

CODE_03F2AB:
	REP.b #$30
	STZ.w $02C3
	LDY.w #$000E
CODE_03F2B3:
	REP.b #$20
	LDA.w $02C7,y
	BEQ.b CODE_03F2BD
	JMP.w CODE_03F428

CODE_03F2BD:
	LDA.w $0317,y
	BEQ.b CODE_03F2C5
	JMP.w CODE_03F32F

CODE_03F2C5:
	LDA.w $02E7,y
	INC
CODE_03F2C9:
	STA.w $02E7,y
	ASL
	TAX
	LDA.l DATA_03F0FF,x
	CMP.w #$FFFF
	BNE.b CODE_03F2DD
	STA.w $02C7,y
	JMP.w CODE_03F36A

CODE_03F2DD:
	CMP.w #$FFFE
	BNE.b CODE_03F2F4
	INX
	INX
	LDA.l DATA_03F0FF,x
	ASL
	STA.b $79
	INX
	INX
	TXA
	SEC
	SBC.b $79
	LSR
	BRA.b CODE_03F2C9

CODE_03F2F4:
	CMP.w #$FFFD
	BNE.b CODE_03F325
	INX
	INX
	LDA.l DATA_03F0FF,x
	ASL
	STA.b $79
	INX
	INX
	LDA.w $0357,y
	BNE.b CODE_03F310
	LDA.l DATA_03F0FF,x
	STA.w $0357,y
CODE_03F310:
	LDA.w $0357,y
	DEC
	STA.w $0357,y
	BEQ.b CODE_03F320
	TXA
	SEC
	SBC.b $79
	LSR
	BRA.b CODE_03F2C9

CODE_03F320:
	INX
	INX
	TXA
	BRA.b CODE_03F2C9

CODE_03F325:
	STA.w $0317,y
	LDA.l DATA_03EFC9,x
	STA.w $0327,y
CODE_03F32F:
	LDA.w $0317,y
	DEC
	STA.w $0317,y
	LDA.w $0327,y
	PHA
	PHP
	SEP.b #$20
	XBA
	REP.b #$20
	PLP
	BMI.b CODE_03F348
	AND.w #$00FF
	BRA.b CODE_03F34B

CODE_03F348:
	ORA.w #$FF00
CODE_03F34B:
	CLC
	ADC.w $0337,y
	STA.w $0337,y
	PLA
	SEP.b #$20
	AND.b #$FF
	REP.b #$20
	BMI.b CODE_03F360
	AND.w #$00FF
	BRA.b CODE_03F363

CODE_03F360:
	ORA.w #$FF00
CODE_03F363:
	CLC
	ADC.w $0347,y
	STA.w $0347,y
CODE_03F36A:
	LDA.w $0307,y
	BNE.b CODE_03F3DA
	LDA.w $02D7,y
	INC
CODE_03F373:
	STA.w $02D7,y
	ASL
	TAX
	LDA.l DATA_03ED9D,x
	CMP.w #$FFFF
	BNE.b CODE_03F387
	STA.w $02C7,y
	JMP.w CODE_03F428

CODE_03F387:
	CMP.w #$FFFE
	BNE.b CODE_03F39E
	INX
	INX
	LDA.l DATA_03ED9D,x
	INX
	INX
	ASL
	STA.b $79
	TXA
	SEC
	SBC.b $79
	LSR
	BRA.b CODE_03F373

CODE_03F39E:
	CMP.w #$FFFD
	BNE.b CODE_03F3D0
	INX
	INX
	LDA.l DATA_03ED9D,x
	INX
	INX
	ASL
	STA.b $79
	LDA.w $0367,y
	BNE.b CODE_03F3BA
	LDA.l DATA_03ED9D,x
	STA.w $0367,y
CODE_03F3BA:
	LDA.w $0367,y
	DEC
	STA.w $0367,y
	BEQ.b CODE_03F3CA
	TXA
	SEC
	SBC.b $79
	LSR
	BRA.b CODE_03F373

CODE_03F3CA:
	INX
	INX
	TXA
	LSR
	BRA.b CODE_03F373

CODE_03F3D0:
	STA.w $0307,y
	LDA.l DATA_03EB71,x
	STA.w $02F7,y
CODE_03F3DA:
	LDA.w $0307,y
	DEC
	STA.w $0307,y
	LDA.w $02F7,y
	STA.w $0261
	CMP.w #$000F
	BCC.b CODE_03F3F7
	CMP.w #$0017
	BCS.b CODE_03F3F7
	LDA.w #$FFFF
	STA.w $02C3
CODE_03F3F7:
	LDA.w $0261
	CMP.w #$0020
	BEQ.b CODE_03F428
	TYX
	LDA.w $02C3
	BNE.b CODE_03F40B
	LDA.l DATA_03EB41,x
	BRA.b CODE_03F40F

CODE_03F40B:
	LDA.l DATA_03EB31,x
CODE_03F40F:
	STA.w $0253
	LDA.w $0337,y
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w $0347,y
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	STY.w $02C5
	PHY
	JSR.w CODE_03F430
	REP.b #$30
	PLY
CODE_03F428:
	DEY
	DEY
	BMI.b CODE_03F42F
	JMP.w CODE_03F2B3

CODE_03F42F:
	RTL

CODE_03F430:
	PHK
	PLB
	REP.b #$30
	LDA.w $0253
	LSR
	LSR
	LSR
	LSR
	STA.w $0289
	LDA.w $0261
	ASL
	TAX
	LDA.w DATA_03F4CC,x
	PHA
	LDY.w #$0000
	LDX.w $0253
	LDA.b ($01,S),y
	INY
	INY
	STA.w $0287
	PHA
CODE_03F455:
	SEP.b #$20
	LDA.b ($03,S),y
	INY
	CLC
	ADC.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	STA.l SIMC_Global_OAMBuffer[$00].XDisp,x
	INX
	LDA.b ($03,S),y
	INY
	CLC
	ADC.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	STA.l SIMC_Global_OAMBuffer[$00].XDisp,x
	INX
	REP.b #$20
	LDA.b ($03,S),y
	AND.w #$0E00
	BNE.b CODE_03F484
	LDA.w $02C5
	SEP.b #$20
	XBA
	REP.b #$20
	ORA.b ($03,S),y
	BRA.b CODE_03F486

CODE_03F484:
	LDA.b ($03,S),y
CODE_03F486:
	INY
	INY
	STA.l SIMC_Global_OAMBuffer[$00].XDisp,x
	INX
	INX
	DEC.w $0287
	BNE.b CODE_03F455
	STX.w $0253
	PLA
	TAX
	LSR
	LSR
	LSR
	TAY
	TXA
	AND.w #$0007
	ASL
	STA.b $79
	TAX
	LDA.l DATA_009048,x
	LDX.w $0289
	STA.w $0289
	LDA.w #$0000
CODE_03F4B1:
	STA.l SIMC_Global_UpperOAMBuffer[$00].Slot,x
	INX
	INX
	DEY
	BNE.b CODE_03F4B1
	LDA.b $79
	BEQ.b CODE_03F4C5
	LDA.w $0289
	STA.l SIMC_Global_UpperOAMBuffer[$00].Slot,x
CODE_03F4C5:
	PLA
	PEA.w ((CODE_008000&$FF0000)>>16)|((CODE_008000&$FF0000)>>8)
	PLB
	PLB
	RTS

DATA_03F4CC:
	dw DATA_03F50C,DATA_03F56C,DATA_03F5BC,DATA_03F624,DATA_03F674,DATA_03F6D4,DATA_03F734,DATA_03F79C
	dw DATA_03F804,DATA_03F86C,DATA_03F8D4,DATA_03F93C,DATA_03F93C,DATA_03F9A4,DATA_03FA0C,DATA_03FA74
	dw DATA_03FA98,DATA_03FABC,DATA_03FAE0,DATA_03FB04,DATA_03FB28,DATA_03FB4C,DATA_03FB70,DATA_03FB94
	dw DATA_03FBF4,DATA_03FC44,DATA_03FCAC,DATA_03FCFC,DATA_03FD7E,DATA_03FE00,DATA_03FE68,DATA_03FED0

DATA_03F50C:
	dw $0016,$1708,$3053,$1700,$3052,$17F8,$3051,$17F0
	dw $3050,$0F08,$3043,$0F00,$3042,$0FF8,$3041,$0FF0
	dw $3040,$0708,$3033,$0700,$3032,$07F8,$3031,$07F0
	dw $3030,$FF08,$3023,$FF00,$3022,$FFF8,$3021,$FFF0
	dw $3020,$F708,$3013,$F700,$3012,$F7F8,$3011,$EF08
	dw $3003,$EF00,$3002,$EFF8,$3001,$5050,$5050,$5410

DATA_03F56C:
	dw $0012,$1808,$3057,$1800,$3056,$18F8,$3055,$1008
	dw $3047,$1000,$3046,$10F8,$3045,$0808,$3037,$0800
	dw $3036,$08F8,$3035,$0008,$3027,$0000,$3026,$00F8
	dw $3025,$F808,$3017,$F800,$3016,$F8F8,$3015,$F008
	dw $3007,$F000,$3006,$F0F8,$3005,$0410,$1041,$5554

DATA_03F5BC:
	dw $0018,$1808,$305B,$1800,$305A,$18F8,$3059,$18F0
	dw $3058,$1008,$304B,$1000,$304A,$10F8,$3049,$10F0
	dw $3048,$0808,$303B,$0800,$303A,$08F8,$3039,$08F0
	dw $3038,$0008,$302B,$0000,$302A,$00F8,$3029,$00F0
	dw $3028,$F808,$301B,$F800,$301A,$F8F8,$3019,$F8F0
	dw $3018,$F008,$300B,$F000,$300A,$F0F8,$3009,$F0F0
	dw $3008,$5050,$5050,$5050

DATA_03F624:
	dw $0012,$1008,$304F,$1000,$304E,$1808,$305F,$1800
	dw $305E,$18F8,$305D,$10F8,$3045,$0808,$3037,$0800
	dw $3036,$08F8,$3035,$0008,$3027,$0000,$3026,$00F8
	dw $3025,$F808,$3017,$F800,$3016,$F8F8,$3015,$F008
	dw $3007,$F000,$3006,$F0F8,$3005,$0500,$1041,$5554

DATA_03F674:
	dw $0016,$F000,$7102,$F0F8,$3102,$1808,$7140,$1008
	dw $7130,$0808,$7120,$0008,$7110,$0000,$7111,$F808
	dw $7100,$F800,$7101,$1800,$3142,$18F8,$3141,$18F0
	dw $3140,$1000,$3132,$10F8,$3131,$10F0,$3130,$0800
	dw $3122,$08F8,$3121,$08F0,$3120,$00F8,$3111,$00F0
	dw $3110,$F8F8,$3101,$F8F0,$3100,$0004,$1450,$5555

DATA_03F6D4:
	dw $0016,$F000,$7105,$F0F8,$3105,$1808,$7143,$0008
	dw $7113,$1008,$7133,$0808,$7123,$F808,$7103,$F800
	dw $7104,$1800,$3145,$18F8,$3144,$18F0,$3143,$1000
	dw $3135,$10F8,$3134,$10F0,$3133,$0800,$3125,$08F8
	dw $3124,$08F0,$3123,$0000,$3115,$00F8,$3114,$00F0
	dw $3113,$F8F8,$3104,$F8F0,$3103,$0004,$4514,$5551

DATA_03F734:
	dw $0018,$1008,$7146,$0808,$7136,$0008,$7126,$F808
	dw $7116,$F008,$7106,$F800,$7117,$F000,$7107,$1808
	dw $30B3,$1800,$30B2,$18F8,$30B1,$18F0,$30B0,$1000
	dw $3148,$10F8,$3147,$10F0,$3146,$0800,$3138,$08F8
	dw $3137,$08F0,$3136,$0000,$3128,$00F8,$3127,$00F0
	dw $3126,$F8F8,$3117,$F8F0,$3116,$F0F8,$3107,$F0F0
	dw $3106,$0000,$4514,$5551

DATA_03F79C:
	dw $0018,$1008,$7129,$0808,$7119,$1808,$30B3,$1800
	dw $30B2,$18F8,$30B1,$18F0,$30B0,$1000,$312B,$10F8
	dw $312A,$10F0,$3129,$0800,$311B,$08F8,$311A,$08F0
	dw $3119,$0000,$310B,$00F8,$310A,$00F0,$3109,$0008
	dw $3083,$F808,$3073,$F800,$3072,$F8F8,$3071,$F8F0
	dw $3070,$F008,$3063,$F000,$3062,$F0F8,$3061,$F0F0
	dw $3060,$4500,$1451,$5050

DATA_03F804:
	dw $0018,$0800,$311E,$08F8,$311D,$0000,$310E,$00F8
	dw $310D,$1008,$712C,$0808,$711C,$0008,$710C,$1000
	dw $312E,$10F8,$312D,$10F0,$312C,$08F0,$311C,$00F0
	dw $310C,$1808,$30B3,$1800,$30B2,$18F8,$30B1,$18F0
	dw $30B0,$F808,$3073,$F800,$3072,$F8F8,$3071,$F8F0
	dw $3070,$F008,$3063,$F000,$3062,$F0F8,$3061,$F0F0
	dw $3060,$0044,$5055,$5050

DATA_03F86C:
	dw $0018,$0800,$314B,$08F8,$314A,$0000,$313B,$00F8
	dw $313A,$0808,$7149,$0008,$7139,$08F0,$3149,$00F0
	dw $3139,$1008,$712C,$1000,$312E,$10F8,$312D,$10F0
	dw $312C,$1808,$30B3,$1800,$30B2,$18F8,$30B1,$18F0
	dw $30B0,$F808,$3073,$F800,$3072,$F8F8,$3071,$F8F0
	dw $3070,$F008,$3063,$F000,$3062,$F0F8,$3061,$F0F0
	dw $3060,$5044,$5050,$5050

DATA_03F8D4:
	dw $0018,$F000,$7151,$F800,$7161,$1008,$7190,$0808
	dw $7180,$0008,$7170,$F808,$7160,$F008,$7150,$1000
	dw $3192,$0800,$3182,$0000,$3172,$10F8,$3191,$10F0
	dw $3190,$08F8,$3181,$08F0,$3180,$00F8,$3171,$00F0
	dw $3170,$F8F8,$3161,$F8F0,$3160,$F0F8,$3151,$F0F0
	dw $3150,$1808,$30B3,$1800,$30B2,$18F8,$30B1,$18F0
	dw $30B0,$0000,$5550,$5055

DATA_03F93C:
	dw $0018,$0000,$7174,$0808,$7183,$0008,$7173,$F808
	dw $7163,$F000,$7154,$F008,$7153,$1000,$3195,$0800
	dw $3185,$F800,$3165,$10F8,$3194,$10F0,$3193,$08F8
	dw $3184,$08F0,$3183,$00F8,$3174,$00F0,$3173,$F8F8
	dw $3164,$F8F0,$3163,$F0F8,$3154,$F0F0,$3153,$1008
	dw $7190,$1808,$30B3,$1800,$30B2,$18F8,$30B1,$18F0
	dw $30B0,$0000,$5554,$5015

DATA_03F9A4:
	dw $0018,$1808,$30B3,$1800,$30B2,$18F8,$30B1,$18F0
	dw $30B0,$1008,$30A3,$1000,$30A2,$10F8,$30A1,$10F0
	dw $30A0,$0808,$3093,$0800,$3092,$08F8,$3091,$08F0
	dw $3090,$0008,$3083,$0000,$3082,$00F8,$3081,$00F0
	dw $3080,$F808,$3073,$F800,$3072,$F8F8,$3071,$F8F0
	dw $3070,$F008,$3063,$F000,$3062,$F0F8,$3061,$F0F0
	dw $3060,$5050,$5050,$5050

DATA_03FA0C:
	dw $0018,$1008,$7146,$0808,$7136,$1808,$30B3,$1800
	dw $30B2,$18F8,$30B1,$18F0,$30B0,$1000,$3148,$10F8
	dw $3147,$10F0,$3146,$0800,$3138,$08F8,$3137,$08F0
	dw $3136,$0008,$3083,$0000,$3082,$00F8,$3081,$00F0
	dw $3080,$F808,$3073,$F800,$3072,$F8F8,$3071,$F8F0
	dw $3070,$F008,$3063,$F000,$3062,$F0F8,$3061,$F0F0
	dw $3060,$4500,$5051,$5050

DATA_03FA74:
	dw $0008,$E8F8,$3B2F,$FCF1,$3B3F,$F8F8,$3B0F,$ECF2
	dw $3B1F,$FE06,$3B3F,$F60B,$3B2F,$ED07,$3B1F,$ED01
	dw $3B0F,$0055

DATA_03FA98:
	dw $0008,$ED02,$3B3F,$00F7,$3B0F,$F800,$3B1F,$EEF6
	dw $3B2F,$FF05,$3B3F,$F30B,$3B2F,$FAF1,$3B1F,$F5ED
	dw $3B0F,$5044

DATA_03FABC:
	dw $0008,$01F8,$3B3F,$F4EB,$3B1F,$EFF6,$3B2F,$FEED
	dw $3B0F,$FF02,$3B3F,$FF0C,$3B2F,$F409,$3B1F,$F301
	dw $3B0F,$0055

DATA_03FAE0:
	dw $0008,$F601,$3B3F,$F50A,$3B1F,$0306,$3B2F,$0013
	dw $3B0F,$03F5,$3B3F,$00E8,$3B2F,$F8EC,$3B1F,$F5F6
	dw $3B0F,$5500

DATA_03FB04:
	dw $0008,$FAF3,$3B3F,$FEEB,$3B2F,$06F3,$3B1F,$08E8
	dw $3B0F,$0501,$3B3F,$080C,$3B2F,$FE0B,$3B1F,$FB05
	dw $3B0F,$0055

DATA_03FB28:
	dw $0008,$100D,$3B2F,$0B03,$3B2F,$FE06,$3B1F,$050F
	dw $3B0F,$0FF9,$3B2F,$0DE9,$3B2F,$06F3,$3B1F,$00EC
	dw $3B0F,$5500

DATA_03FB4C:
	dw $0008,$1407,$3B2F,$1712,$3B0F,$0A0F,$3B3F,$0E03
	dw $3B1F,$16F7,$3B3F,$16E9,$3B2F,$0AEF,$3B1F,$0EF7
	dw $3B0F,$5500

DATA_03FB70:
	dw $0008,$16F6,$3B0F,$0FF5,$3B3F,$0DEE,$3B2F,$15E6
	dw $3B1F,$1703,$3B3F,$1810,$3B2F,$1312,$3B1F,$120A
	dw $3B0F,$0055

DATA_03FB94:
	dw $0016,$17F0,$7053,$17F8,$7052,$1700,$7051,$1708
	dw $7050,$0FF0,$7043,$0FF8,$7042,$0F00,$7041,$0F08
	dw $7040,$07F0,$7033,$07F8,$7032,$0700,$7031,$0708
	dw $7030,$FFF0,$7023,$FFF8,$7022,$FF00,$7021,$FF08
	dw $7020,$F7F0,$7013,$F7F8,$7012,$F700,$7011,$EFF0
	dw $7003,$EFF8,$7002,$EF00,$7001,$0505,$0505,$5145

DATA_03FBF4:
	dw $0012,$18F0,$7057,$18F8,$7056,$1800,$7055,$10F0
	dw $7047,$10F8,$7046,$1000,$7045,$08F0,$7037,$08F8
	dw $7036,$0800,$7035,$00F0,$7027,$00F8,$7026,$0000
	dw $7025,$F8F0,$7017,$F8F8,$7016,$F800,$7015,$F0F0
	dw $7007,$F0F8,$7006,$F000,$7005,$5145,$4514,$5551

DATA_03FC44:
	dw $0018,$18F0,$705B,$18F8,$705A,$1800,$7059,$1808
	dw $7058,$10F0,$704B,$10F8,$704A,$1000,$7049,$1008
	dw $7048,$08F0,$703B,$08F8,$703A,$0800,$7039,$0808
	dw $7038,$00F0,$702B,$00F8,$702A,$0000,$7029,$0008
	dw $7028,$F8F0,$701B,$F8F8,$701A,$F800,$7019,$F808
	dw $7018,$F0F0,$700B,$F0F8,$700A,$F000,$7009,$F008
	dw $7008,$0505,$0505,$0505

DATA_03FCAC:
	dw $0012,$10F0,$704F,$10F8,$704E,$18F0,$705F,$18F8
	dw $705E,$1800,$705D,$1000,$7045,$08F0,$7037,$08F8
	dw $7036,$0800,$7035,$00F0,$7027,$00F8,$7026,$0000
	dw $7025,$F8F0,$7017,$F8F8,$7016,$F800,$7015,$F0F0
	dw $7007,$F0F8,$7006,$F000,$7005,$5055,$4514,$5551

DATA_03FCFC:
	dw $001E,$1010,$314E,$1008,$314D,$1000,$314C,$0810
	dw $313E,$0808,$313D,$0800,$313C,$F610,$30A7,$08F8
	dw $30F7,$0000,$30BE,$00F8,$30BD,$0000,$3092,$00F8
	dw $3091,$08F0,$3085,$F6E8,$30A4,$0008,$30B6,$F808
	dw $30A6,$F008,$3096,$00F0,$30B5,$F8F0,$30A5,$F0F0
	dw $3095,$F800,$303F,$F8F8,$303E,$10F6,$30B1,$10EE
	dw $30B0,$F000,$3072,$F0F8,$3071,$E808,$3063,$E800
	dw $3062,$E8F8,$3061,$E8F0,$3060,$4000,$0544,$5454
	dw $5504

DATA_03FD7E:
	dw $001E,$18E8,$714E,$10E8,$713E,$18F0,$714D,$10F0
	dw $713D,$10F8,$713C,$08F8,$30AD,$0800,$30AE,$0800
	dw $3092,$08F8,$3091,$00F0,$30A5,$0008,$30A6,$F808
	dw $3096,$F8F0,$3095,$0000,$303F,$00F8,$303E,$F800
	dw $3072,$F8F8,$3071,$F008,$3063,$F000,$3062,$F0F8
	dw $3061,$F0F0,$3060,$FE10,$70A4,$0808,$70B5,$18F8
	dw $31BC,$FEE8,$70A7,$1008,$7085,$08F0,$70B6,$1000
	dw $70F7,$1800,$70B1,$1808,$70B0,$0555,$1105,$4141
	dw $5011

DATA_03FE00:
	dw $0018,$18F0,$70BB,$18F8,$70BA,$1800,$70B9,$1808
	dw $70B8,$10F0,$70AB,$10F8,$70AA,$1000,$70A9,$1008
	dw $70A8,$08F0,$709B,$08F8,$709A,$0800,$7099,$0808
	dw $7098,$00F0,$708B,$00F8,$708A,$0000,$7089,$0008
	dw $7088,$F8F0,$707B,$F8F8,$707A,$F800,$7079,$F808
	dw $7078,$F0F0,$706B,$F0F8,$706A,$F000,$7069,$F008
	dw $7068,$0505,$0505,$0505

DATA_03FE68:
	dw $0018,$1000,$30F8,$10F8,$30F7,$0000,$30D7,$00F8
	dw $30D6,$F800,$30C7,$F8F8,$30C6,$08F8,$30F6,$0008
	dw $30E7,$00F0,$30E6,$F808,$3013,$F008,$3003,$F000
	dw $3002,$F0F8,$3001,$0800,$30B7,$0710,$3077,$07E8
	dw $3074,$10F0,$3085,$08F0,$3075,$1008,$3086,$0808
	dw $3076,$1808,$30B3,$1800,$30B2,$18F8,$30B1,$18F0
	dw $30B0,$1444,$4101,$5005

DATA_03FED0:
	dw $001A,$0000,$3082,$00F8,$3081,$0800,$30B7,$08F8
	dw $3067,$07E8,$3074,$10F0,$3085,$08F0,$3075,$00F0
	dw $3065,$1008,$3086,$0710,$3077,$0808,$3076,$0008
	dw $3066,$1808,$30B3,$1800,$30B2,$18F8,$30B1,$18F0
	dw $30B0,$1000,$30A2,$10F8,$30A1,$F808,$3073,$F800
	dw $3072,$F8F8,$3071,$F8F0,$3070,$F008,$3063,$F000
	dw $3062,$F0F8,$3061,$F0F0,$3060,$5544,$5000,$0504
	dw $5555

	%FREE_BYTES($03FF42, 190, $FF)
%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SIMCBank04Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_048000:
	incbin "Graphics/GFX_Sprite_Bowser.bin"

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SIMCBank05Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_058000:
	incbin "Palettes/DATA_058000.bin"

DATA_058100:
	incbin "Palettes/DATA_058100.bin"

DATA_058200:
	incbin "Palettes/DATA_058200.bin"

DATA_058300:
	incbin "Palettes/DATA_058300.bin"

UNK_058400:
	incbin "Palettes/DATA_058400.bin"

UNK_058500:
	incbin "Palettes/DATA_058500.bin"

UNK_058600:
	incbin "Palettes/DATA_058600.bin"

UNK_058700:
	incbin "Palettes/DATA_058700.bin"

UNK_058800:
	incbin "Palettes/DATA_058800.bin"

DATA_058900:
	incbin "Palettes/DATA_058900.bin"

DATA_058A00:
	incbin "Palettes/DATA_058A00.bin"

DATA_058B00:
	incbin "Palettes/DATA_058B00.bin"

UNK_058C00:
	incbin "Palettes/DATA_058C00.bin"

UNK_058D00:
	incbin "Palettes/DATA_058D00.bin"

UNK_058E00:
	db "NAK1989 S-CG-CAD"
	db "Ver1.02 910227 F"

UNK_058E20:
	db $02,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $02,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$01,$00,$00,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $3E,$31,$32,$33,$18,$19,$1A,$1B,$40,$41,$42,$43,$77,$75,$76,$77
	db $34,$35,$36,$37,$4B,$45,$46,$49,$20,$29,$2A,$2B,$46,$4D,$4E,$4F
	db $48,$49,$4A,$4B,$2C,$2D,$2E,$2F,$3C,$3D,$3E,$3F,$4C,$4D,$4E,$4F
	db $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F
	db $40,$41,$42,$43,$44,$45,$46,$47,$48,$49,$4A,$4B,$4C,$4D,$4E,$4F
	db $50,$51,$52,$53,$54,$55,$56,$57,$58,$59,$5A,$5B,$5C,$5D,$5E,$5F
	db $60,$61,$62,$63,$64,$65,$66,$67,$68,$69,$6A,$6B,$6C,$6D,$6E,$6F
	db $70,$71,$72,$73,$74,$75,$76,$77,$78,$79,$7A,$7B,$7C,$7D,$7E,$7F
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

	%FREE_BYTES($059000, 128, $FF)

CODE_059080:
	JSR.w CODE_05956F
	SEP.b #$20
	LDA.b #$81
	STA.b $B3
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	LDA.w #$0001
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_07C9E0
	STX.b $09
	LDA.b #DATA_07C9E0>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_07A680
	STX.b $09
	LDA.b #DATA_07A680>>16
	STA.b $0B
	LDX.w #$4000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	REP.b #$20
	STZ.w !REGISTER_VRAMAddressLo
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer
	STA.w DMA[$00].SourceLo,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$80
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_059105
CODE_059101:
	ASL
	DEX
	BNE.b CODE_059101
CODE_059105:
	STA.w !REGISTER_DMAEnable
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_07C930
	STX.b $09
	LDA.b #DATA_07C930>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0B9224
	STX.b $09
	LDA.b #DATA_0B9224>>16
	STA.b $0B
	LDX.w #$2000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0B942B
	STX.b $09
	LDA.b #DATA_0B942B>>16
	STA.b $0B
	LDX.w #$3000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0B966B
	STX.b $09
	LDA.b #DATA_0B966B>>16
	STA.b $0B
	LDX.w #$4000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	REP.b #$20
	LDA.w #$4000
	STA.w !REGISTER_VRAMAddressLo
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer
	STA.w DMA[$00].SourceLo,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$60
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_0591AA
CODE_0591A6:
	ASL
	DEX
	BNE.b CODE_0591A6
CODE_0591AA:
	STA.w !REGISTER_DMAEnable
	REP.b #$30
	PHB
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$3000
	LDY.w #!RAM_SIMC_Global_Layer1TilemapBuffer
	LDA.w #$07FF
	MVN !RAM_SIMC_Global_Layer1TilemapBuffer>>16,(!RAM_SIMC_Global_GeneralPurposeBuffer+$3000)>>16
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$4000
	LDY.w #!RAM_SIMC_Global_Layer2TilemapBuffer
	LDA.w #$0FFF
	MVN !RAM_SIMC_Global_Layer2TilemapBuffer>>16,(!RAM_SIMC_Global_GeneralPurposeBuffer+$4000)>>16
	PLB
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0C89D8
	STX.b $09
	LDA.b #DATA_0C89D8>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	STZ.w !REGISTER_CGRAMAddress
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$00
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToCGRAMPort
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer
	STA.w DMA[$00].SourceLo,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$02
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_05921F
CODE_05921B:
	ASL
	DEX
	BNE.b CODE_05921B
CODE_05921F:
	STA.w !REGISTER_DMAEnable
	REP.b #$30
	PHB
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer
	LDY.w #SIMC_Global_PaletteMirror[$00].LowByte
	LDA.w #$01FF
	MVN SIMC_Global_PaletteMirror[$00].LowByte>>16,!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	PLB
	SEP.b #$20
	STZ.b $28
	LDA.b #$5F
	STA.b $2A
	LDA.b #$80
	STA.b $26
	LDA.b #$5C
	STA.b $24
	JSR.w CODE_0594BE
	REP.b #$20
	LDA.w #$0190
	STA.w $0277
	LDA.w #$00B7
	STA.w $027F
	STZ.b $40
	SEP.b #$20
	STZ.b $52
	STZ.b $54
	LDA.b #$01
	STA.b !RAM_SIMC_Global_BGModeAndTileSizeSetting
	STZ.b !RAM_SIMC_Global_BG1And2TileDataDesignation
	LDA.b #$04
	STA.b !RAM_SIMC_Global_BG3And4TileDataDesignation
	LDA.b #$63
	STA.b !RAM_SIMC_Global_BG1AddressAndSize
	LDA.b #$5A
	STA.b !RAM_SIMC_Global_BG2AddressAndSize
	LDA.b #$52
	STA.b !RAM_SIMC_Global_BG3AddressAndSize
	LDA.b #$81
	STA.b !RAM_SIMC_Global_OAMSizeAndDataAreaDesignation
	LDA.b #$8F
	STA.b !RAM_SIMC_Global_ColorMathSelectAndEnable
	LDA.b #$FF
	STA.b !RAM_SIMC_Global_FixedColorData
	LDA.b #$17
	STA.b !RAM_SIMC_Global_MainScreenLayers
	STZ.b !RAM_SIMC_Global_ColorMathInitialSettings
	REP.b #$20
	LDA.w #$01D0
	STA.b !RAM_SIMC_TitleScreenAndMenu_Layer3YPosLo
	LDA.w #$01A1
	STA.b !RAM_SIMC_TitleScreenAndMenu_Layer2YPosLo
	LDA.w #$0143
	STA.b !RAM_SIMC_TitleScreenAndMenu_Layer1YPosLo
	LDA.w #$0001
	STA.b $2C
	STZ.b !RAM_SIMC_TitleScreenAndMenu_Layer1XPosLo
	STZ.b !RAM_SIMC_TitleScreenAndMenu_Layer2XPosLo
	STZ.b !RAM_SIMC_TitleScreenAndMenu_Layer3XPosLo
	STZ.b $30
	LDA.w #$000A
	STA.w $0133
	LDA.w #$0004
	STA.w $0135
	REP.b #$20
	LDA.w #$00FC
	STA.w $0253
	LDA.w #$00B0
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w #$00B7
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$0017
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	REP.b #$20
	REP.b #$20
	LDA.w #$0003
	COP.b #$00
	REP.b #$30
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0DD77C
	STX.b $09
	LDA.b #DATA_0DD77C>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	PHB
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer
	LDY.w #$7F0000
	LDA.w #$7FFF
	MVN $7F0000>>16,!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0EC242
	STX.b $09
	LDA.b #DATA_0EC242>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer
	LDY.w #$7F8000
	LDA.w #$7FFF
	MVN $7F8000>>16,!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	PLB
	JSR.w CODE_059347
	INC.b $14
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	REP.b #$20
	LDA.w #$0000
	COP.b #$00
	SEP.b #$20
	LDA.b #$07
	STA.b $03
	RTL

CODE_059347:
	SEP.b #$20
	REP.b #$10
	LDY.w #$7F0000
	STY.b $00
	LDA.b #$7F0000>>16
	STA.b $02
	LDX.w #$BBAA
CODE_059357:
	CPX.w !REGISTER_APUPort0
	BNE.b CODE_059357
	LDA.b #$CC
	BRA.b CODE_059386

CODE_059360:
	LDA.b [$00],y
	INY
	XBA
	LDA.b #$00
	BRA.b CODE_059373

CODE_059368:
	XBA
	LDA.b [$00],y
	INY
	XBA
CODE_05936D:
	CMP.w !REGISTER_APUPort0
	BNE.b CODE_05936D
	INC
CODE_059373:
	REP.b #$20
	STA.w !REGISTER_APUPort0
	SEP.b #$20
	DEX
	BNE.b CODE_059368
CODE_05937D:
	CMP.w !REGISTER_APUPort0
	BNE.b CODE_05937D
CODE_059382:
	ADC.b #$03
	BEQ.b CODE_059382
CODE_059386:
	PHA
	REP.b #$20
	LDA.b [$00],y
	INY
	INY
	TAX
	LDA.b [$00],y
	INY
	INY
	STA.w !REGISTER_APUPort2
	SEP.b #$20
	CPX.w #$0001
	LDA.b #$00
	ROL
	STA.w !REGISTER_APUPort1
	ADC.b #$7F
	PLA
	STA.w !REGISTER_APUPort0
CODE_0593A6:
	CMP.w !REGISTER_APUPort0
	BNE.b CODE_0593A6
	BVS.b CODE_059360
	RTS

CODE_0593AE:
	REP.b #$30
	JSL.l CODE_059603
	STZ.w $0253
	LDA.b $30
	REP.b #$10
	ASL
	TAX
	JSR.w (DATA_0593C1,x)
	RTL

DATA_0593C1:
	dw CODE_0593CB
	dw CODE_0593D4
	dw CODE_05941A
	dw CODE_0593CB
	dw CODE_05942E

CODE_0593CB:
	REP.b #$20
	DEC.b $2C
	BNE.b CODE_0593D3
	INC.b $30
CODE_0593D3:
	RTS

CODE_0593D4:
	REP.b #$30
	LDA.b $2C
	AND.w #$0007
	BNE.b CODE_0593E1
	DEC.b $24
	INC.b $20
CODE_0593E1:
	AND.w #$0003
	BNE.b CODE_0593E8
	INC.b $1C
CODE_0593E8:
	AND.w #$0001
	BNE.b CODE_0593F8
	INC.b $18
	LDA.b $18
	CMP.w #$01E6
	BCC.b CODE_0593F8
	DEC.b $2A
CODE_0593F8:
	INC.b $2C
	JSR.w CODE_0594BE
	JSR.w CODE_05952E
	LDA.b $18
	AND.w #$01FF
	STA.b $18
	LDA.b $1C
	AND.w #$01FF
	STA.b $1C
	LDA.b $20
	AND.w #$01FF
	STA.b $20
	BNE.b CODE_059419
	INC.b $30
CODE_059419:
	RTS

CODE_05941A:
	REP.b #$20
	LDA.w #$0040
	STA.b $2E
	INC.b $30
	JSR.w CODE_0594DB
	REP.b #$20
	LDA.w #$014A
	STA.b $2C
	RTS

CODE_05942E:
	REP.b #$20
	LDA.w #$0180
	STA.w $0253
	LDA.w $0277
	AND.w #$03FF
	STA.w $0277
	AND.w #$0200
	BNE.b CODE_05944D
	STZ.b $10
	REP.b #$20
	LDA.w #$0009
	COP.b #$00
CODE_05944D:
	LDA.b $2C
	AND.w #$0007
	BNE.b CODE_059454
CODE_059454:
	AND.w #$0003
	BNE.b CODE_05945B
	INC.b !RAM_SIMC_TitleScreenAndMenu_Layer2XPosLo
CODE_05945B:
	AND.w #$0001
	BNE.b CODE_059465
	INC.b !RAM_SIMC_TitleScreenAndMenu_Layer1XPosLo
	DEC.w $0277
CODE_059465:
	LDA.b !RAM_SIMC_TitleScreenAndMenu_Layer1XPosLo
	AND.w #$01FF
	STA.b !RAM_SIMC_TitleScreenAndMenu_Layer1XPosLo
	LDA.b !RAM_SIMC_TitleScreenAndMenu_Layer2XPosLo
	AND.w #$01FF
	STA.b !RAM_SIMC_TitleScreenAndMenu_Layer2XPosLo
	LDA.b !RAM_SIMC_TitleScreenAndMenu_Layer3XPosLo
	AND.w #$01FF
	STA.b !RAM_SIMC_TitleScreenAndMenu_Layer3XPosLo
	INC.b $2C
	REP.b #$20
	LDA.b $2C
	AND.w #$0003
	BEQ.b CODE_059496
	DEC.b $28
	LDA.b $28
	AND.w #$01FF
	CMP.w #$01C1
	BCS.b CODE_059494
	LDA.w #$0000
CODE_059494:
	STA.b $28
CODE_059496:
	REP.b #$20
	DEC.b $2E
	BEQ.b CODE_0594A6
	LDA.b $2E
	CMP.w #$0020
	BNE.b CODE_0594AF
	JMP.w CODE_0594FD

CODE_0594A6:
	JSR.w CODE_0594DB
	SEP.b #$20
	LDA.b #$40
	STA.b $2E
CODE_0594AF:
	REP.b #$20
	LDA.b $2E
	CMP.w #$0020
	BCS.b CODE_0594BB
	JMP.w CODE_05952E

CODE_0594BB:
	JMP.w CODE_05954F

CODE_0594BE:
	REP.b #$20
	STZ.w $0253
	LDA.b $26
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.b $24
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$0016
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	RTS

CODE_0594DB:
	REP.b #$20
	LDA.w #$00E8
	STA.w $0253
	LDA.w #$0078
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w #$0087
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$0018
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	RTS

CODE_0594FD:
	SEP.b #$20
	LDA.b #$E0
	STA.l SIMC_Global_OAMBuffer[$3A].YDisp
	STA.l SIMC_Global_OAMBuffer[$3B].YDisp
	STA.l SIMC_Global_OAMBuffer[$3C].YDisp
	STA.l SIMC_Global_OAMBuffer[$3D].YDisp
	STA.l SIMC_Global_OAMBuffer[$3E].YDisp
	LDA.l SIMC_Global_UpperOAMBuffer[$1E].Slot
	AND.b #$0F
	ORA.b #$50
	STA.l SIMC_Global_UpperOAMBuffer[$1E].Slot
	LDA.l SIMC_Global_UpperOAMBuffer[$1F].Slot
	AND.b #$C0
	ORA.b #$15
	STA.l SIMC_Global_UpperOAMBuffer[$1F].Slot
	RTS

CODE_05952E:
	REP.b #$20
	LDA.w #$00D4
	STA.w $0253
	LDA.b $28
	DEC
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.b $2A
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$0019
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	RTS

CODE_05954F:
	REP.b #$20
	LDA.w #$00D4
	STA.w $0253
	LDA.b $28
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.b $2A
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$001A
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	RTS

CODE_05956F:
	SEP.b #$30
	LDA.b #$8F
	STA.b !RAM_SIMC_Global_ScreenDisplayRegister
	STZ.b !RAM_SIMC_Global_OAMSizeAndDataAreaDesignation
	STZ.w !REGISTER_OAMAddressLo
	STZ.w !REGISTER_OAMAddressHi
	STZ.w !REGISTER_MosaicSizeAndBGEnable
	LDA.b #$01
	STZ.b !RAM_SIMC_Global_BGModeAndTileSizeSetting
	LDA.b #$35
	STA.b !RAM_SIMC_Global_BG1AddressAndSize
	STA.w !REGISTER_BG1AddressAndSize
	LDA.b #$20
	STA.w !REGISTER_BG1And2TileDataDesignation
	STZ.w !REGISTER_BG4HorizScrollOffset
	STZ.w !REGISTER_BG4HorizScrollOffset
	STZ.w !REGISTER_BG4VertScrollOffset
	STZ.w !REGISTER_BG4VertScrollOffset
	LDA.b #$80
	STA.w !REGISTER_VRAMAddressIncrementValue
	STZ.w !REGISTER_BG1And2WindowMaskSettings
	STZ.w !REGISTER_BG3And4WindowMaskSettings
	STZ.w !REGISTER_ObjectAndColorWindowSettings
	STZ.w !REGISTER_BGWindowLogicSettings
	STZ.w !REGISTER_ColorAndObjectWindowLogicSettings
	LDA.b #$01
	STA.w !REGISTER_MainScreenLayers
	STA.b !RAM_SIMC_Global_MainScreenLayers
	STZ.w !REGISTER_SubScreenLayers
	LDA.b #$01
	STA.w !REGISTER_Window1LeftPositionDesignation
	STZ.w !REGISTER_Window1RightPositionDesignation
	STA.w !REGISTER_Window2LeftPositionDesignation
	STZ.w !REGISTER_Window2RightPositionDesignation
	STZ.w !REGISTER_ColorMathInitialSettings
	STZ.w !REGISTER_ColorMathSelectAndEnable
	STZ.w !REGISTER_InitialScreenSettings
	STZ.b $B1
	STZ.b $B3
	LDA.b #$FF
	STA.w !REGISTER_ProgrammableIOPortOutput
	LDA.b #$00
	STA.w !REGISTER_Multiplicand
	STA.w !REGISTER_Multiplier
	STA.w !REGISTER_DividendLo
	STA.w !REGISTER_DividendHi
	STA.w !REGISTER_Divisor
	STA.w !REGISTER_HCountTimerLo
	STA.w !REGISTER_HCountTimerHi
	STA.w !REGISTER_VCountTimerLo
	STA.w !REGISTER_VCountTimerHi
	STA.w !REGISTER_DMAEnable
	STA.w !REGISTER_HDMAEnable
	LDA.b #$00
	STA.w !REGISTER_EnableFastROM
	RTS

CODE_059603:
	SEP.b #$20
	PHB
	LDA.b #DATA_0596AE>>16
	PHA
	PLB
	REP.b #$30
	LDX.b $32
	LDA.w DATA_059696,x
	STA.b $79
	INX
	INX
	CPX.w #$0018
	BNE.b CODE_05962A
	LDA.b $34
	INC
	CMP.w #$0003
	BNE.b CODE_059625
	LDA.w #$0000
CODE_059625:
	STA.b $34
	LDX.w #$0000
CODE_05962A:
	STX.b $32
	LDY.w #$0000
	LDA.b ($79),y
	ASL
	STA.b $7F
	INC.b $79
	INC.b $79
	LDA.b $79
	LDX.b $34
CODE_05963C:
	CLC
	ADC.b $7F
	DEX
	BPL.b CODE_05963C
	STA.b $7C
	LDY.w #$0000
CODE_059647:
	LDA.b ($79),y
	TAX
	LDA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	AND.w #$FC00
	ORA.b ($7C),y
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	INY
	INY
	CPY.b $7F
	BNE.b CODE_059647
	LDA.b $2C
	AND.w #$0003
	CMP.w #$0003
	BEQ.b CODE_059688
	ASL
	TAY
	LDX.w DATA_05968A,y
	STX.w $0147
	LDX.w #$0018
	STX.w $0177
	LDX.w DATA_059690,y
	STX.w $0167
	LDX.w #$0800
	STX.w $0187
	LDA.b $B7
	ORA.w #$0004
	STA.b $B7
CODE_059688:
	PLB
	RTL

DATA_05968A:
	dw $5800,$6000,$6400

DATA_059690:
	dw !RAM_SIMC_Global_Layer1TilemapBuffer,!RAM_SIMC_Global_Layer2TilemapBuffer,!RAM_SIMC_Global_Layer3TilemapBuffer

DATA_059696:
	dw DATA_0596AE,DATA_0597B0,DATA_05970A,DATA_05980C,DATA_059786,DATA_0597DA,DATA_0596E0,DATA_059858
	dw DATA_059836,DATA_059892,DATA_0598B4,DATA_059754

DATA_0596AE:
	dw $0006,$0BC2,$0BC4,$0BC6,$0BC8,$0BCA,$0C0C,$0024
	dw $0025,$0026,$0027,$0028,$002E,$0056,$0057,$0026
	dw $0058,$0059,$005A,$005B,$005C,$0026,$005D,$005E
	dw $005F

DATA_0596E0:
	dw $0005,$0D0E,$0D10,$0D16,$0D18,$0D58,$001B,$001C
	dw $001D,$001E,$001F,$0020,$0021,$0022,$001E,$0023
	dw $0001,$0002,$0004,$0005,$0009

DATA_05970A:
	dw $0009,$0B5E,$0B66,$0B68,$0B6A,$0BDE,$0BE6,$0BE8
	dw $0C28,$0C2A,$0060,$0062,$0063,$0064,$006C,$0070
	dw $0071,$0076,$0077,$0086,$0087,$0088,$0089,$008A
	dw $008B,$008C,$008D,$008E,$008F,$0090,$0088,$0091
	dw $0092,$0093,$008C,$008D,$0094

DATA_059754:
	dw $0006,$0C2C,$0C2E,$0C30,$0C32,$0C34,$0C74,$00DB
	dw $00D6,$00DC,$00DD,$00D9,$00DE,$00AB,$00AC,$00AD
	dw $00AE,$00AF,$00B4,$00D5,$00D6,$00D7,$00D8,$00D9
	dw $00DA

DATA_059786:
	dw $0005,$0B36,$0B38,$0B3A,$0B3C,$0B3E,$00FD,$00E0
	dw $00E0,$00FE,$00FF,$0100,$00E0,$00E0,$00FE,$0101
	dw $00DF,$00E0,$00E0,$00E1,$00E2

DATA_0597B0:
	dw $0005,$1504,$1506,$1510,$1512,$1552,$0001,$0002
	dw $0004,$0005,$0009,$001B,$001C,$001D,$001E,$001F
	dw $0020,$0021,$0022,$001E,$0023

DATA_0597DA:
	dw $0006,$1324,$1326,$1328,$132A,$132C,$136E,$005B
	dw $005C,$0026,$005D,$005E,$005F,$0024,$0025,$0026
	dw $0027,$0028,$002E,$0056,$0057,$0026,$0058,$0059
	dw $005A

DATA_05980C:
	dw $0005,$1470,$1472,$1474,$1476,$1478,$0100,$00E0
	dw $00E0,$00FE,$0101,$00DF,$00E0,$00E0,$00E1,$00E2
	dw $00FD,$00E0,$00E0,$00FE,$00FF

DATA_059836:
	dw $0004,$0380,$0382,$0384,$0386,$0102,$0103,$0104
	dw $0105,$011B,$011C,$011D,$011E,$011B,$011F,$0120
	dw $011E

DATA_059858:
	dw $0007,$03C8,$03CA,$03CC,$03CE,$03D0,$03D2,$03D4
	dw $0121,$0122,$0123,$0124,$0125,$0126,$0127,$0121
	dw $0122,$0152,$0124,$0153,$0126,$0154,$0121,$0122
	dw $0155,$0124,$0156,$0126,$0157

DATA_059892:
	dw $0004,$03E2,$03E4,$03E6,$03E8,$011B,$011F,$0120
	dw $011E,$0102,$0103,$0104,$0105,$011B,$011C,$011D
	dw $011E

DATA_0598B4:
	dw $0007,$03EA,$03EC,$03EE,$03F0,$03F2,$03F4,$03F6
	dw $0121,$0122,$0152,$0124,$0153,$0126,$0154,$0121
	dw $0122,$0155,$0124,$0156,$0126,$0157,$0121,$0122
	dw $0123,$0124,$0125,$0126,$0127

CODE_0598EE:
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_08C4DB
	STX.b $09
	LDA.b #DATA_08C4DB>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_08DEA2
	STX.b $09
	LDA.b #DATA_08DEA2>>16
	STA.b $0B
	LDX.w #$2000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	REP.b #$20
	STZ.w !REGISTER_VRAMAddressLo
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer
	STA.w DMA[$00].SourceLo,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$60
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_05995B
CODE_059957:
	ASL
	DEX
	BNE.b CODE_059957
CODE_05995B:
	STA.w !REGISTER_DMAEnable
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0B9BA4
	STX.b $09
	LDA.b #DATA_0B9BA4>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0BA10B
	STX.b $09
	LDA.b #DATA_0BA10B>>16
	STA.b $0B
	LDX.w #$2000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_09A571
	STX.b $09
	LDA.b #DATA_09A571>>16
	STA.b $0B
	LDX.w #$4000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	REP.b #$20
	LDA.w #$4000
	STA.w !REGISTER_VRAMAddressLo
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer
	STA.w DMA[$00].SourceLo,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$80
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_0599E7
CODE_0599E3:
	ASL
	DEX
	BNE.b CODE_0599E3
CODE_0599E7:
	STA.w !REGISTER_DMAEnable
	REP.b #$30
	PHB
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$3000
	LDY.w #!RAM_SIMC_Global_Layer3TilemapBuffer
	LDA.w #$0FFF
	MVN !RAM_SIMC_Global_Layer3TilemapBuffer>>16,(!RAM_SIMC_Global_GeneralPurposeBuffer+$3000)>>16
	PLB
	STZ.w $0B5B
	RTL

CODE_0599FE:
	REP.b #$30
	PHB
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$0800
	LDY.w #!RAM_SIMC_Global_Layer2TilemapBuffer
	LDA.w #$07FF
	MVN !RAM_SIMC_Global_Layer2TilemapBuffer>>16,(!RAM_SIMC_Global_GeneralPurposeBuffer+$0800)>>16
	LDX.w #!RAM_SIMC_Global_GeneralPurposeBuffer+$1000
	LDY.w #!RAM_SIMC_Global_Layer1TilemapBuffer
	LDA.w #$07FF
	MVN !RAM_SIMC_Global_Layer1TilemapBuffer>>16,(!RAM_SIMC_Global_GeneralPurposeBuffer+$1000)>>16
	PLB
	SEP.b #$20
	LDA.b #$01
	STA.b !RAM_SIMC_Global_BGModeAndTileSizeSetting
	LDA.b #$17
	STA.b !RAM_SIMC_Global_MainScreenLayers
	STZ.b !RAM_SIMC_Global_ColorMathSelectAndEnable
	LDA.b #$11
	STA.b !RAM_SIMC_Global_BG1And2TileDataDesignation
	STZ.b !RAM_SIMC_Global_BG3And4TileDataDesignation
	LDA.b #$40
	STA.b !RAM_SIMC_Global_BG1AddressAndSize
	LDA.b #$44
	STA.b !RAM_SIMC_Global_BG2AddressAndSize
	LDA.b #$50
	STA.b !RAM_SIMC_Global_BG3AddressAndSize
	LDA.b #$03
	STA.b !RAM_SIMC_Global_OAMSizeAndDataAreaDesignation
	SEP.b #$20
	LDA.b $B3
	ORA.b #$80
	STA.b $B1
	REP.b #$20
	LDA.w #$0003
	COP.b #$00
	REP.b #$30
	STZ.w !RAM_SIMC_City_DifficultyLevel
	RTL

CODE_059A51:
	SEP.b #$30
	LDA.b #$D8
	STA.l SIMC_Global_OAMBuffer[$01].XDisp
	STA.l SIMC_Global_OAMBuffer[$02].XDisp
	STA.l SIMC_Global_OAMBuffer[$03].XDisp
	LDA.b #$D0
	STA.l SIMC_Global_OAMBuffer[$04].XDisp
	STA.l SIMC_Global_OAMBuffer[$05].XDisp
	STA.l SIMC_Global_OAMBuffer[$06].XDisp
	LDA.b #$C8
	STA.l SIMC_Global_OAMBuffer[$07].XDisp
	STA.l SIMC_Global_OAMBuffer[$08].XDisp
	STA.l SIMC_Global_OAMBuffer[$09].XDisp
	LDA.b #$09
	STA.l SIMC_Global_OAMBuffer[$01].Prop
	STA.l SIMC_Global_OAMBuffer[$02].Prop
	STA.l SIMC_Global_OAMBuffer[$03].Prop
	STA.l SIMC_Global_OAMBuffer[$04].Prop
	STA.l SIMC_Global_OAMBuffer[$05].Prop
	STA.l SIMC_Global_OAMBuffer[$06].Prop
	STA.l SIMC_Global_OAMBuffer[$07].Prop
	STA.l SIMC_Global_OAMBuffer[$08].Prop
	STA.l SIMC_Global_OAMBuffer[$09].Prop
	LDA.b #$02
	STA.l SIMC_Global_UpperOAMBuffer[$00].Slot
	LDA.b #$00
	STA.l SIMC_Global_UpperOAMBuffer[$01].Slot
	LDA.b #$50
	STA.l SIMC_Global_UpperOAMBuffer[$02].Slot
	REP.b #$30
	LDA.w #$0100
	STA.w $0253
	LDA.w #$0060
	STA.w !RAM_SIMC_Global_OnScreenCursorXPosLo
	LDA.w #$0060
	STA.w !RAM_SIMC_Global_OnScreenCursorYPosLo
	LDA.w #$0027
	STA.w $0261
	REP.b #$20
	LDA.w #$0002
	COP.b #$00
	RTL

CODE_059AD7:
	PHB
	SEP.b #$20
	PHA
	LDA.b #DATA_059B4A>>16
	PHA
	PLB
	PLA
	REP.b #$30
	LDX.w #$1000
	CMP.w #$0000
	BNE.b CODE_059AED
	LDX.w #$1400
CODE_059AED:
	STX.b $7C
	STY.b $7F
	TYA
	ASL
	TAY
	LDA.w DATA_059B40,y
	STA.b $79
	LDY.w #$0000
CODE_059AFC:
	LDA.b ($79),y
	BMI.b CODE_059B12
	TAX
	LDA.l !RAM_SIMC_Global_Layer3TilemapBuffer,x
	AND.w #$03FF
	ORA.b $7C
	STA.l !RAM_SIMC_Global_Layer3TilemapBuffer,x
	INY
	INY
	BRA.b CODE_059AFC

CODE_059B12:
	LDX.w #$5800
	LDY.w #!RAM_SIMC_Global_Layer3TilemapBuffer
	LDA.b $7F
	CMP.w #$0003
	BCC.b CODE_059B25
	LDX.w #$5C00
	LDY.w #!RAM_SIMC_Global_Layer4TilemapBuffer
CODE_059B25:
	STX.w $0149
	STY.w $0169
	LDX.w #$0018
	STX.w $0179
	LDX.w #$0800
	STX.w $0189
	LDA.b $B7
	ORA.w #$0008
	STA.b $B7
	PLB
	RTL

DATA_059B40:
	dw DATA_059B4A,DATA_059B5C,DATA_059B6E,DATA_059B80,DATA_059B8A

DATA_059B4A:
	dw $0212,$0214,$0216,$0218,$0252,$0254,$0256,$0258
	dw $FFFF

DATA_059B5C:
	dw $021C,$021E,$0220,$0222,$025C,$025E,$0260,$0262
	dw $FFFF

DATA_059B6E:
	dw $0226,$0228,$022A,$022C,$0266,$0268,$026A,$026C
	dw $FFFF

DATA_059B80:
	dw $0A58,$0A5A,$0A5C,$0A5E,$FFFF

DATA_059B8A:
	dw $0A62,$0A64,$0A66,$0A68,$FFFF

CODE_059B94:
	REP.b #$30
	LDA.b $4E
	AND.w #$00FF
	CMP.w #$00FF
	BNE.b CODE_059BA1
	RTL

CODE_059BA1:
	CMP.w #$0027
	BEQ.b CODE_059BA9
	JMP.w CODE_059C31

CODE_059BA9:
	LDX.w #$0590
	LDA.w $011B
	BPL.b CODE_059BFD
	LDA.w #$0834
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	LDA.w #$0836
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0040,x
CODE_059BBF:
	INX
	INX
	LDA.w #$0842
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	LDA.w #$0843
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0040,x
	CPX.w #$05AE
	BNE.b CODE_059BBF
	LDA.w #$0835
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	LDA.w #$0837
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0040,x
	LDX.w #$0000
CODE_059BE5:
	LDA.l SIMC_Global_OAMBuffer[$67].YDisp,x
	CLC
	ADC.w #$0002
	STA.l SIMC_Global_OAMBuffer[$67].YDisp,x
	INX
	INX
	INX
	INX
	CPX.w #$0014
	BNE.b CODE_059BE5
	JMP.w CODE_059E2B

CODE_059BFD:
	LDA.w #$0830
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	LDA.w #$0832
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0040,x
CODE_059C0B:
	INX
	INX
	LDA.w #$0840
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	LDA.w #$0841
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0040,x
	CPX.w #$05AE
	BNE.b CODE_059C0B
	LDA.w #$0831
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	LDA.w #$0833
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0040,x
	JMP.w CODE_059E2B

CODE_059C31:
	CMP.w #$0080
	BEQ.b CODE_059C39
	JMP.w CODE_059CC3

CODE_059C39:
	LDX.w #$03B2
	LDA.w $011B
	BPL.b CODE_059C8E
	LDA.w #$083C
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	LDA.w #$083E
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0040,x
	LDA.w #$0846
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0002,x
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0004,x
	LDA.w #$0847
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0042,x
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0044,x
	LDA.w #$083D
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0006,x
	LDA.w #$083F
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0046,x
	LDA.l SIMC_Global_OAMBuffer[$6C].YDisp
	CLC
	ADC.w #$0002
	STA.l SIMC_Global_OAMBuffer[$6C].YDisp
	LDA.l SIMC_Global_OAMBuffer[$6D].YDisp
	CLC
	ADC.w #$0002
	STA.l SIMC_Global_OAMBuffer[$6D].YDisp
	JMP.w CODE_059E2B

CODE_059C8E:
	LDA.w #$0838
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	LDA.w #$083A
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0040,x
	LDA.w #$0844
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0002,x
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0004,x
	LDA.w #$0845
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0042,x
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0044,x
	LDA.w #$0839
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0006,x
	LDA.w #$083B
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0046,x
	JMP.w CODE_059E2B

CODE_059CC3:
	CMP.w #$0081
	BNE.b CODE_059D36
	LDX.w #$0434
	LDA.w $011B
	BPL.b CODE_059D09
	LDA.w #$083C
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	LDA.w #$083E
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0040,x
	LDA.w #$0846
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0002,x
	LDA.w #$0847
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0042,x
	LDA.w #$083D
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0004,x
	LDA.w #$083F
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0044,x
	LDA.l SIMC_Global_OAMBuffer[$6E].YDisp
	CLC
	ADC.w #$0002
	STA.l SIMC_Global_OAMBuffer[$6E].YDisp
	JMP.w CODE_059E2B

CODE_059D09:
	LDA.w #$0838
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	LDA.w #$083A
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0040,x
	LDA.w #$0844
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0002,x
	LDA.w #$0845
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0042,x
	LDA.w #$0839
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0004,x
	LDA.w #$083B
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0044,x
	JMP.w CODE_059E2B

CODE_059D36:
	CMP.w #$0082
	BEQ.b CODE_059D3E
	JMP.w CODE_059DD8

CODE_059D3E:
	LDX.w #$04B6
	LDA.w $011B
	BPL.b CODE_059D9B
	LDA.w #$083C
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$007E,x
	INC
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0002,x
	LDA.w #$084A
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0040,x
	INC
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0082,x
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0042,x
	LDA.w #$084D
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0080,x
	LDA.w #$0847
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$00C0,x
	LDA.w #$083E
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$00BE,x
	INC
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$00C2,x
	LDA.l SIMC_Global_OAMBuffer[$6F].YDisp
	CLC
	ADC.w #$0002
	STA.l SIMC_Global_OAMBuffer[$6F].YDisp
	LDA.l SIMC_Global_OAMBuffer[$70].YDisp
	CLC
	ADC.w #$0002
	STA.l SIMC_Global_OAMBuffer[$70].YDisp
	JMP.w CODE_059E2B

CODE_059D9B:
	LDA.w #$0838
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$007E,x
	INC
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0002,x
	LDA.w #$0848
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0040,x
	INC
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0042,x
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0082,x
	LDA.w #$084C
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0080,x
	LDA.w #$0845
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$00C0,x
	LDA.w #$083A
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$00BE,x
	INC
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$00C2,x
	JMP.w CODE_059E2B

CODE_059DD8:
	ASL
	TAY
	LDX.w DATA_03DBF9,y
	LDA.w $011B
	BPL.b CODE_059E0F
	LDA.w #$0834
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	LDA.w #$0835
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0002,x
	LDA.w #$0836
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0040,x
	LDA.w #$0837
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0042,x
	TYA
	ASL
	TAX
	LDA.l SIMC_Global_OAMBuffer[$40].YDisp,x
	CLC
	ADC.w #$0002
	STA.l SIMC_Global_OAMBuffer[$40].YDisp,x
	BRA.b CODE_059E2B

CODE_059E0F:
	LDA.w #$0830
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer,x
	LDA.w #$0831
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0002,x
	LDA.w #$0832
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0040,x
	LDA.w #$0833
	STA.l !RAM_SIMC_Global_Layer1TilemapBuffer+$0042,x
CODE_059E2B:
	JSR.w CODE_059E2F
	RTL

CODE_059E2F:
	SEP.b #$20
	LDX.w #$4800
	STX.w $0147
	LDX.w #$0018
	STX.w $0177
	LDX.w #!RAM_SIMC_Global_Layer1TilemapBuffer
	STX.w $0167
	LDX.w #$0800
	STX.w $0187
	LDA.b $B7
	ORA.b #$04
	STA.b $B7
	RTS

CODE_059E50:
	REP.b #$20
	LDA.w #$0004
	COP.b #$00
	SEP.b #$20
	STZ.b !RAM_SIMC_Global_HDMAEnable
	SEP.b #$20
	LDA.b $B3
	AND.b #$7F
	STA.b $B1
	REP.b #$20
	LDA.w #$0001
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_08C4DB
	STX.b $09
	LDA.b #DATA_08C4DB>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0BA5A1
	STX.b $09
	LDA.b #DATA_0BA5A1>>16
	STA.b $0B
	LDX.w #$6000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	REP.b #$20
	STZ.w !REGISTER_VRAMAddressLo
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer
	STA.w DMA[$00].SourceLo,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$70
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_059ED7
CODE_059ED3:
	ASL
	DEX
	BNE.b CODE_059ED3
CODE_059ED7:
	STA.w !REGISTER_DMAEnable
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_09A571
	STX.b $09
	LDA.b #DATA_09A571>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	REP.b #$20
	LDA.w #$6000
	STA.w !REGISTER_VRAMAddressLo
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$01
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToVRAMPortLo
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer
	STA.w DMA[$00].SourceLo,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$40
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_059F31
CODE_059F2D:
	ASL
	DEX
	BNE.b CODE_059F2D
CODE_059F31:
	STA.w !REGISTER_DMAEnable
	SEP.b #$20
	REP.b #$10
	LDX.w #DATA_0C8AD8
	STX.b $09
	LDA.b #DATA_0C8AD8>>16
	STA.b $0B
	LDX.w #$0000
	STX.b $0E
	REP.b #$20
	LDA.w #!Define_SIMC_Global_COPRt_DecompressFile
	COP.b #$00
	SEP.b #$20
	STZ.w !REGISTER_CGRAMAddress
	SEP.b #$30
	LDA.b #$02
	ASL
	ASL
	ASL
	ASL
	TAX
	LDA.b #$00
	STA.w DMA[$00].Parameters,x
	LDA.b #!REGISTER_WriteToCGRAMPort
	STA.w DMA[$00].Destination,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer
	STA.w DMA[$00].SourceLo,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>8
	STA.w DMA[$00].SourceHi,x
	LDA.b #!RAM_SIMC_Global_GeneralPurposeBuffer>>16
	STA.w DMA[$00].SourceBank,x
	LDA.b #$00
	STA.w DMA[$00].SizeLo,x
	LDA.b #$02
	STA.w DMA[$00].SizeHi,x
	LDA.b #$01
	LDX.b #$02
	BEQ.b CODE_059F88
CODE_059F84:
	ASL
	DEX
	BNE.b CODE_059F84
CODE_059F88:
	STA.w !REGISTER_DMAEnable
	SEP.b #$30
	LDY.b $40
	LDA.w DATA_03DDA6,y
	STA.b $52
	LDA.w DATA_03DDAE,y
	STA.b $54
	REP.b #$30
	LDA.w #$0000
	LDX.b $52
	CPX.w #$0003
	BNE.b CODE_059FA8
	LDA.w #$0050
CODE_059FA8:
	STA.b $22
	STA.b !RAM_SIMC_TitleScreenAndMenu_Layer1XPosLo
	LDA.w #$0008
	STA.b $2C
	LDA.w #$0001
	STA.b $30
	STZ.b !RAM_SIMC_TitleScreenAndMenu_Layer1YPosLo
	STZ.b !RAM_SIMC_TitleScreenAndMenu_Layer2YPosLo
	RTL

CODE_059FBB:
	REP.b #$30
	LDX.b $18
	BEQ.b CODE_059FC7
	INX
	STX.b $18
	STX.b $1C
	RTL

CODE_059FC7:
	LDA.b $C9
	AND.w #$8040
	BEQ.b CODE_059FE5
	SEP.b #$20
	LDA.b #$01
	STA.b $05
	REP.b #$20
	LDA.w #$0002
	LDY.b $3E
	CPY.w #$0003
	BNE.b CODE_059FE3
	LDA.w #$000A
CODE_059FE3:
	STA.b $14
CODE_059FE5:
	RTL

	%FREE_BYTES($059FE6, 26, $FF)

DATA_05A000:
	incbin "Graphics/GFX_Sprite_UFO.bin"

DATA_05B000:
	incbin "Graphics/GFX_Layer2_AnimatedCitySimulationTiles.bin"

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SIMCBank06Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_068000:
	incbin "Graphics/GFX_Sprite_Tornado.bin":0-800

DATA_068800:
	incbin "Graphics/GFX_Sprite_Boat.bin":0-A00

DATA_069200:
	incbin "Graphics/GFX_Sprite_Airplane.bin":0-C00

DATA_069E00:
	incbin "Graphics/GFX_Sprite_Train.bin":0-200

DATA_06A000:
	incbin "Graphics/GFX_Sprite_Tornado.bin":800-1000

DATA_06A800:
	incbin "Graphics/GFX_Sprite_Boat.bin":A00-1400

DATA_06B200:
	incbin "Graphics/GFX_Sprite_Airplane.bin":C00-1800

UNK_06BE00:
	incbin "Graphics/GFX_Sprite_Train.bin":200-400

DATA_06C000:
	incbin "Graphics/GFX_Sprite_StatusBarUI.bin"

%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################

macro SIMCBank07Macros(StartBank, EndBank)
%BANK_START(<StartBank>)

DATA_078000:
	incbin "Graphics/GFX_Sprite_StatusBarUIButtons.bin"

check bankcross off

DATA_07A680:
	incbin "Graphics/GFX_Sprite_TitleScreen.lz5"

DATA_07C930:
	incbin "Graphics/GFX_Layer3_TitleScreen.lz5"

DATA_07C9E0:						; Note: Also the layer 2 graphics.
	incbin "Graphics/GFX_Layer1_TitleScreen.lz5"

DATA_07E584:
	incbin "Graphics/GFX_Layer1_CitySimulationTiles.lz5"

DATA_08C4DB:
	incbin "Graphics/GFX_LayerX_MainMenu.lz5"

DATA_08DEA2:						; Note: Also is the layer 2 graphics
	incbin "Graphics/GFX_Layer1_MapSelectScreen.lz5"

DATA_08E422:
	incbin "Graphics/GFX_Layer1_InformationAndBankLoanSubScreens.lz5"

DATA_09875C:
	incbin "Graphics/GFX_Layer3_InformationAndBankLoanSubScreens.lz5"

DATA_09A571:
	incbin "Graphics/GFX_Sprite_ScenarioSelectScreen.lz5"

DATA_09C0FB:
	incbin "Graphics/GFX_Layer3_CitySimulationTiles.lz5"

DATA_09D650:
	incbin "Graphics/GFX_Sprite_WillWrightMessageScreen1.lz5"

DATA_09EBC1:
	incbin "Graphics/GFX_Sprite_WillWrightMessageScreen2.lz5"

DATA_0A81E9:
	incbin "Graphics/GFX_Sprite_WillWrightMessageScreen3.lz5"

DATA_0A8F68:
	incbin "Graphics/GFX_Sprite_WillWrightMessageScreen4.lz5"

DATA_0A9C34:
	incbin "Graphics/GFX_Sprite_WillWrightMessageScreen5.lz5"

DATA_0AA523:
	incbin "Graphics/GFX_Sprite_StatusBarSubMenuButtons.lz5"

DATA_0AC460:
	incbin "Graphics/GFX_Sprite_FamicomLogoAndFaxMachineCord.lz5"

DATA_0AC4CF:
	incbin "Graphics/GFX_Sprite_SpecialBuildingButtons.lz5"

DATA_0AD381:
	incbin "Graphics/GFX_Sprite_MapScreenButtons.lz5"

DATA_0AF80B:
	incbin "Graphics/GFX_Sprite_MapScreenHeaders.lz5"

DATA_0AFCE1:
	incbin "Graphics/GFX_Sprite_GraphScreenButtons.lz5"

DATA_0B86F7:
	incbin "Graphics/GFX_Sprite_StatusBarSaveMenuButtons.lz5"

DATA_0B9224:
	incbin "Tilemaps/Layer3_TitleScreen.lz5"

DATA_0B942B:
	incbin "Tilemaps/Layer2_TitleScreen.lz5"

DATA_0B966B:
	incbin "Tilemaps/Layer1_TitleScreen.lz5"

DATA_0B9BA4:						; Note: Also is the layer 2 tilemap
	incbin "Tilemaps/Layer1_MapSelectScreen.lz5"

DATA_0BA10B:
	incbin "Tilemaps/Layer3_MapSelectScreen.lz5"

DATA_0BA5A1:
	incbin "Tilemaps/ScenarioSelectScreen.lz5"

DATA_0BABF1:
	incbin "Tilemaps/GameModeSelectScreen.lz5"

DATA_0BADAE:
	incbin "Tilemaps/Layer1_FiscalBudgetSubScreen.lz5"

DATA_0BAFCE:
	incbin "Tilemaps/Layer1_CityEvaluationSubScreen.lz5"

DATA_0BB1EB:
	incbin "Tilemaps/Layer1_CityOverviewSubScreen.lz5"

DATA_0BB408:
	incbin "Tilemaps/Layer1_HistorySubScreen.lz5"

DATA_0BB5F3:
	incbin "Tilemaps/Layer1_BankLoanSubScreen.lz5"

DATA_0BBCAD:
	incbin "Tilemaps/Layer3_BankLoanText.lz5"

DATA_0BBF0E:
	incbin "Tilemaps/Layer3_FiscalBudgetSubScreen.lz5"

DATA_0BC0C9:
	incbin "Tilemaps/Layer3_CityEvaluationSubScreen.lz5"

DATA_0BC29F:
	incbin "Tilemaps/Layer3_CityOverviewSubScreen.lz5"

DATA_0BC488:
	incbin "Tilemaps/Layer3_HistorySubScreen.lz5"

DATA_0BC51C:
	incbin "Tilemaps/Layer3_ScaleModelSubScreen.lz5"

DATA_0BC7BD:
	incbin "Tilemaps/Layer3_LShapedStatusBar.lz5"

DATA_0BC91F:
	incbin "Tilemaps/Layer3_WillWriteMessageBoxVillageBG.lz5"

DATA_0BCE02:
	incbin "Tilemaps/Layer3_WillWriteMessageBoxTownBG.lz5"

DATA_0BD2F6:
	incbin "Tilemaps/Layer3_WillWriteMessageBoxCityBG.lz5"

DATA_0BD84D:
	incbin "Tilemaps/Layer3_WillWriteMessageBoxCapitalBG.lz5"

DATA_0BDDD2:
	incbin "Tilemaps/Layer3_WillWriteMessageBoxMetropolisBG.lz5"

DATA_0BE417:
	incbin "Tilemaps/Layer3_WillWriteMessageBoxMegalopolisBG.lz5"

DATA_0BEAA8:
	incbin "Tilemaps/Layer3_WillWriteMessageBoxOfficeBG.lz5"

DATA_0BEE30:
	incbin "Tilemaps/RioDeJaneiroScenarioIntroText.lz5"

DATA_0BF06A:
	incbin "Tilemaps/BostonScenarioIntroText.lz5"

DATA_0BF2EA:
	incbin "Tilemaps/BernScenarioIntroText.lz5"

DATA_0BF543:
	incbin "Tilemaps/DetroitScenarioIntroText.lz5"

DATA_0BF764:
	incbin "Tilemaps/SanFrancicsoScenarioIntroText.lz5"

DATA_0BF972:
	incbin "Tilemaps/TokyoScenarioIntroText.lz5"

DATA_0BFBE7:
	incbin "Tilemaps/PracticeCityIntroText.lz5"

DATA_0BFE00:
	incbin "Tilemaps/LasVegasScenarioIntroText.lz5"

DATA_0C8066:
	incbin "Tilemaps/FreeCityScenarioIntroText.lz5"

DATA_0C82AD:
	incbin "Tilemaps/CompleteScenarioText.lz5"

DATA_0C83CE:
	incbin "Tilemaps/UnlockBonusScenariosText.lz5"

DATA_0C8539:
	incbin "Tilemaps/FailedScenarioText.lz5"

DATA_0C869D:
	incbin "Tilemaps/FaxPaper.lz5"

DATA_0C87CB:
	incbin "Tilemaps/FaxMachineAndWoodTable.lz5"

DATA_0C89B9:
	incbin "Tilemaps/FaxMachineGlass.lz5"

DATA_0C89D8:
	incbin "Palettes/TitleScreen.lz5"

DATA_0C8AD8:
	incbin "Palettes/MainMenu.lz5"

DATA_0C8C44:
	incbin "Palettes/FiscalBudgetSubScreen.lz5"

DATA_0C8CEE:
	incbin "Palettes/CityEvaluationSubScreen.lz5"

DATA_0C8D50:
	incbin "Palettes/CityOverviewSubScreen.lz5"

DATA_0C8DAB:
	incbin "Palettes/HistorySubScreen.lz5"

DATA_0C8E00:
	incbin "Palettes/BankLoanScreen.lz5"

DATA_0C8ED8:
	incbin "Palettes/FaxMachineScreen.lz5"

DATA_0C8F27:
	incbin "PremadeMaps/Tokyo.lz5"

DATA_0CA8E8:
	incbin "PremadeMaps/Boston.lz5"

DATA_0CC5A2:
	incbin "PremadeMaps/Detroit.lz5"

DATA_0CE30B:
	incbin "PremadeMaps/Bern.lz5"

DATA_0D816E:
	incbin "PremadeMaps/RioDeJaneiro.lz5"

DATA_0D9F23:
	incbin "PremadeMaps/SanFrancicso.lz5"

DATA_0DB987:
	incbin "PremadeMaps/LasVegas.lz5"

DATA_0DCB15:
	incbin "PremadeMaps/FreeCity.lz5"

DATA_0DD131:
	incbin "PremadeMaps/PracticeCity.lz5"

DATA_0DD77C:
	incbin "SPC700/CompressedSPCBlock1.lz5"

DATA_0EC242:
	incbin "SPC700/CompressedSPCBlock2.lz5"

	%FREE_BYTES($0F9B98, 3176, $FF)

DATA_0FA800:
	dw DATA_0FA868,DATA_0FA8DF,DATA_0FA9E7,DATA_0FAACD,DATA_0FABE7,DATA_0FACD1,DATA_0FAE21,DATA_0FAF1A
	dw DATA_0FB034,DATA_0FB152,DATA_0FB28B,DATA_0FB3A3,DATA_0FB494,DATA_0FB53A,DATA_0FB63F,DATA_0FB727
	dw DATA_0FB829,DATA_0FB8D1,DATA_0FB9B5,DATA_0FBACF,DATA_0FBBCF,DATA_0FBCD6,DATA_0FBDD3,DATA_0FBED2
	dw DATA_0FBFAA,DATA_0FC060,DATA_0FC138,DATA_0FC251,DATA_0FC37F,DATA_0FC499,DATA_0FC598,DATA_0FC6B0
	dw DATA_0FC7CC,DATA_0FC8F8,DATA_0FC9F7,DATA_0FCAE7,DATA_0FCBC7,DATA_0FCCCC,DATA_0FCD87,DATA_0FCE65
	dw DATA_0FCF69,DATA_0FD055,DATA_0FD106,DATA_0FD208,DATA_0FD2A9,DATA_0FD3A5,DATA_0FD45A,DATA_0FD554
	dw DATA_0FD674,DATA_0FD726,DATA_0FD85F,DATA_0FD965

DATA_0FA868:
	db "Good Job! Your fine city"
	db "is growing nicely.  I   "
	db "don*t see any problems  "
	db "at the moment, so let*s "
	db "keep up the good work!",$FF

DATA_0FA8DF:
	db "TOWN (population of more"
	db "than 2,000 people)      "
	db "                        "
	db "Congratulations! Your   "
	db "village has become a    "
	db "TOWN.  Placing          "
	db "Residential zones,      "
	db "Industrial zones and    "
	db "Commercial zones in     "
	db "balanced numbers will   "
	db "help your city to grow.",$FF

DATA_0FA9E7:
	db "CITY (population of more"
	db "than 10,000 people)     "
	db "                        "
	db "Congratulations! Your   "
	db "TOWN has become a CITY. "
	db "Solve any transportation"
	db "dilemmas and reduce the "
	db "crime rate to keep your "
	db "citizens happy and the  "
	db "city growing.",$FF

DATA_0FAACD:
	db "CAPITAL (population of  "
	db "more than 50,000 people)"
	db "                        "
	db "Congratulations! Your   "
	db "CITY has become a       "
	db "CAPITAL.  All eyes are  "
	db "on you now so it*s time "
	db "to show your stuff!     "
	db "Build Airports and      "
	db "Seaports to improve     "
	db "your Commercial and     "
	db "Industrial zones.",$FF

DATA_0FABE7:
	db "METROPOLIS (population  "
	db "of more than 100,000    "
	db "people)                 "
	db "                        "
	db "Congratulations! Your   "
	db "CAPITAL has become a    "
	db "METROPOLIS. You have a  "
	db "bright future ahead of  "
	db "you as a politician.    "
	db "Let*s keep going!",$FF

DATA_0FACD1:
	db "MEGALOPOLIS (population "
	db "of more than 500,000    "
	db "people)                 "
	db "                        "
	db "Congratulations! Your   "
	db "METROPOLIS has become a "
	db "MEGALOPOLIS.  Very few  "
	db "people can reach and    "
	db "maintain a city of this "
	db "size! Is there still    "
	db "room for growth?  Can   "
	db "you re-zone areas to    "
	db "increase your           "
	db "population?  Good Luck!",$FF

DATA_0FAE21:
	db "TRAFFIC JAM WARNING     "
	db "                        "
	db "Stay off the streets!   "
	db "Heavy traffic is        "
	db "clogging our roads,     "
	db "residents are upset, and"
	db "the pollution levels are"
	db "rising. Now might be a  "
	db "good time to introduce  "
	db "your mass transit       "
	db "program.",$FF

DATA_0FAF1A:
	db "ADVICE / CRIME          "
	db "                        "
	db "The crime rate will be  "
	db "higher in areas where   "
	db "the land value is low or"
	db "the population density  "
	db "is high. Check the map  "
	db "and make sure police    "
	db "stations are distributed"
	db "so that they provide    "
	db "overlapping coverage in "
	db "high crime areas.",$FF

DATA_0FB034:
	db "CRIME WARNING           "
	db "                        "
	db "Crime Alert! The crime  "
	db "rate in the city is     "
	db "beyond acceptable       "
	db "levels.  The residents  "
	db "want to reclaim their   "
	db "neighborhoods and are   "
	db "willing to take matters "
	db "into their own hands.   "
	db "You better build some   "
	db "police stations fast!",$FF

DATA_0FB152:
	db "BOWSER ATTACK!          "
	db "                        "
	db "The King of the Koopas  "
	db "has invaded our city!   "
	db "While looking for Mario "
	db "and Luigi, Bowser is    "
	db "destroying everything in"
	db "sight!  Contain the     "
	db "fires he has set and    "
	db "repair the damage       "
	db "before he decides to    "
	db "return for a second     "
	db "stroll through downtown.",$FF

DATA_0FB28B:
	db "EARTHQUAKE!             "
	db "                        "
	db "Crash! Boom! Bam!  A    "
	db "major earthquake has    "
	db "shaken your fine city to"
	db "ruins!  Major fires are "
	db "burning out of control. "
	db "Put out the fires and   "
	db "restore power to all    "
	db "zones before you begin  "
	db "to rebuild your city to "
	db "its past glory.",$FF

DATA_0FB3A3:
	db "SIMCITY SAVINGS & LOAN  "
	db "                        "
	db "SimCity Savings & Loan  "
	db "would like to build a   "
	db "branch office in this   "
	db "city.  I hear they offer"
	db "low interest loans for  "
	db "city improvements.      "
	db "Sounds like a steal     "
	db ". . . I mean a deal!    ",$FF

DATA_0FB494:
	db "SCALE MODEL OF THE CITY "
	db "                        "
	db "You have been given a   "
	db "scale model of your     "
	db "city.  You can see it   "
	db "using \VIEW] in the     "
	db "\INFORMATION] window.",$FF

DATA_0FB53A:
	db "AMUSEMENT PARK OR CASINO"
	db "                        "
	db "Why don*t you build an  "
	db "amusement park or a     "
	db "casino for your city?   "
	db "The amusement park will "
	db "attract people to the   "
	db "nearby zones while the  "
	db "casino will bring more  "
	db "money to the city.      "
	db "Which do you prefer?",$FF

DATA_0FB63F:
	db "ZOO                     "
	db "                        "
	db "The children of the city"
	db "need some form of       "
	db "entertainment. How about"
	db "building a zoo so they  "
	db "can learn all about     "
	db "animals? The income from"
	db "the zoo will be added as"
	db "Special Income.",$FF

DATA_0FB727:
	db "ADVICE / HOUSING COSTS  "
	db "                        "
	db "If the residents of the "
	db "city are complaining    "
	db "about housing costs, it "
	db "probably means that the "
	db "land values of available"
	db "Residential zones are   "
	db "too high or that they   "
	db "are too far from        "
	db "Commercial zones.",$FF

DATA_0FB829:
	db "LAND FILL               "
	db "                        "
	db "Are you running out of  "
	db "land to develop?  With  "
	db "the land fill, you can  "
	db "reclaim land that was   "
	db "previously under water.",$FF

DATA_0FB8D1:
	db "POLICE HEADQUARTERS     "
	db "                        "
	db "Why don*t you build a   "
	db "Police Department       "
	db "Headquarters?  A state  "
	db "of the art facility     "
	db "will give the citizens  "
	db "of your city a wider    "
	db "area of police          "
	db "protection.",$FF

DATA_0FB9B5:
	db "FIRE DEPARTMENT         "
	db "HEADQUARTERS            "
	db "                        "
	db "Why don*t you build a   "
	db "Fire Department         "
	db "Headquarters? A disaster"
	db "could happen at any time"
	db "and the citizens will   "
	db "need the greater area of"
	db "fire protection that the"
	db "new headquarters will   "
	db "be able to offer.",$FF

DATA_0FBACF:
	db "WATER FOUNTAIN          "
	db "                        "
	db "Congratulations on your "
	db "city*s 50th year        "
	db "anniversary!  This water"
	db "fountain commemorates   "
	db "your city*s 50th        "
	db "birthday.       Oh, how "
	db "wonderful! (I always get"
	db "teary-eyed at           "
	db "anniversaries.)",$FF

DATA_0FBBCF:
	db "MARIO STATUE            "
	db "                        "
	db "Congratulations!  Your  "
	db "city now has over       "
	db "500,000 people! This    "
	db "Mario statue has been   "
	db "given to your city to   "
	db "celebrate your excellent"
	db "work as Mayor. (I bet   "
	db "you thought the statue  "
	db "should look like you!)",$FF

DATA_0FBCD6:
	db "ADVICE / POLLUTION      "
	db "                        "
	db "The pollution has gotten"
	db "out of hand.  Eventually"
	db "the land value will drop"
	db "and the crime rate will "
	db "rise.  To prevent this, "
	db "why don*t you spread out"
	db "your Industrial zones   "
	db "and keep them away from "
	db "the Airport.",$FF

DATA_0FBDD3:
	db "EXPO                    "
	db "                        "
	db "Why don*t you build an  "
	db "EXPO so that the        "
	db "citizens can see all the"
	db "technical advances we*ve"
	db "made. I*m sure that some"
	db "of this new technology  "
	db "will help to develop the"
	db "surrounding Industrial  "
	db "zones as well.",$FF

DATA_0FBED2:
	db "SISTER-CITY AFFILIATION "
	db "                        "
	db "A windmill has been sent"
	db "from Amsterdam in       "
	db "remembrance of our      "
	db "sister-city affiliation."
	db "Let*s set it up so that "
	db "everyone in the city can"
	db "enjoy their generosity.",$FF

DATA_0FBFAA:
	db "LIBRARY                 "
	db "                        "
	db "Why don*t you build a   "
	db "library for the         "
	db "increasing number of    "
	db "school kids?  I*m sure  "
	db "it will help to improve "
	db "their grades.",$FF

DATA_0FC060:
	db "LARGE PARK              "
	db "                        "
	db "Why don*t you build a   "
	db "big park so that the    "
	db "kids have a place to    "
	db "play?  It will also     "
	db "make your city a more   "
	db "comfortable place to    "
	db "live for the residents.",$FF

DATA_0FC138:
	db "TRAIN STATION           "
	db "                        "
	db "Why don*t you consider  "
	db "building a train        "
	db "station?  With a train  "
	db "station, more trains can"
	db "run on time and that    "
	db "will help to develop the"
	db "surrounding areas. This "
	db "will surely make the    "
	db "Monday morning          "
	db "commuters happy!",$FF

DATA_0FC251:
	db "Hello! I*m Dr. Wright.  "
	db "You must be the new     "
	db "Mayor! Let*s practice   "
	db "our city building       "
	db "techniques by building a"
	db "Power Plant and then    "
	db "adding Residential,     "
	db "Commercial, and         "
	db "Industrial zones. Next, "
	db "connect all zones with  "
	db "power and then add      "
	db "roads for the residents "
	db "to travel on.",$FF

DATA_0FC37F:
	db "Has your city been      "
	db "developing ok?  Press   "
	db "    to gain useful      "
	db "                        "
	db "information about your  "
	db "city. Press    to save  "
	db "                        "
	db "your city. I*ll come and"
	db "help if you press    .  "
	db "                        "
	db "Start and Select moves  "
	db "to the icon bars.",$FF

DATA_0FC499:
	db "I*m sorry, but it seems "
	db "like something wasn*t   "
	db "quite right in your city"
	db "planning.  Was your     "
	db "budget balanced         "
	db "properly?  Did you solve"
	db "your traffic and crime  "
	db "problems?  Did you build"
	db "a stadium?  Let*s think "
	db "about this some more,   "
	db "and try again!",$FF

DATA_0FC598:
	db "POLLUTION WARNING       "
	db "                        "
	db "Smog warning! High      "
	db "levels of pollution are "
	db "causing your city*s air "
	db "quality to deteriorate. "
	db "The citizens are leaving"
	db "town. Spread out your   "
	db "Industrial zones and    "
	db "avoid traffic           "
	db "congestion to improve   "
	db "this situation.",$FF

DATA_0FC6B0:
	db "SIMCITY SAVINGS & LOAN  "
	db "                        "
	db "Welcome to SimCity      "
	db "Savings & Loan!  We are "
	db "happy to offer $10,000  "
	db "low interest loans to   "
	db "those who wish to       "
	db "improve our community.  "
	db "Your payments will be   "
	db "$500 a year for the next"
	db "21 years. Would you like"
	db "to take out a loan?",$FF

DATA_0FC7CC:
	db "FIRE!                   "
	db "                        "
	db "Yowwza!  A fire has     "
	db "broken out! If it       "
	db "continues to burn, it   "
	db "will spread through the "
	db "city.  Bulldoze the area"
	db "around the fire to stop "
	db "it from spreading. Have "
	db "you built a Fire        "
	db "Department yet or do you"
	db "have sufficient fire    "
	db "protection?",$FF

DATA_0FC8F8:
	db "FLOOD WARNING!          "
	db "                        "
	db "Break out the life      "
	db "rafts!  The waters have "
	db "risen to flood levels!  "
	db "Unless you develop the  "
	db "shore lines to prevent  "
	db "erosion and future      "
	db "flooding, the flood     "
	db "waters will continue to "
	db "spread inland.",$FF

DATA_0FC9F7:
	db "PLANE CRASH!            "
	db "                        "
	db "A plane has crashed and "
	db "emergency crews are     "
	db "needed to check for     "
	db "survivors and any damage"
	db "caused by the explosion."
	db "Locate the disaster and "
	db "put out the fires so we "
	db "can look for survivors.",$FF

DATA_0FCAE7:
	db "TORNADO!                "
	db "                        "
	db "Run for cover! A tornado"
	db "has been spotted in the "
	db "city!  You*ll have to   "
	db "wait until it passes    "
	db "before you can rebuild  "
	db "the city because nobody "
	db "fools with Mother       "
	db "Nature.",$FF

DATA_0FCBC7:
	db "A NUCLEAR DISASTER!     "
	db "                        "
	db "The nuclear power plant "
	db "has had a core melt     "
	db "down!  Radioactive      "
	db "particles have made     "
	db "parts of your city      "
	db "uninhabitable. Bulldoze "
	db "the affected area and   "
	db "rebuild your city using "
	db "uncontaminated land.",$FF

DATA_0FCCCC:
	db "Enough is enough! You*re"
	db "the one getting all the "
	db "fame and glory around   "
	db "here.  You should be the"
	db "one who makes the       "
	db "decisions.  Remember,   "
	db "elections are just      "
	db "around the corner!",$FF

DATA_0FCD87:
	db "Congratulations on      "
	db "achieving a city with a "
	db "population of 30,000    "
	db "people!  It seems like  "
	db "your city planning has  "
	db "been pretty successful. "
	db "You are a great Mayor   "
	db "now!  Why don*t you plan"
	db "to build an even bigger "
	db "city?",$FF

DATA_0FCE65:
	db "I*m sorry, but it seems "
	db "like something wasn*t   "
	db "quite right in your     "
	db "city planning. Was your "
	db "budget balanced         "
	db "properly? Did you solve "
	db "your traffic and crime  "
	db "problems?  Did you      "
	db "build a stadium?  Let*s "
	db "think about this some   "
	db "more and try again.",$FF

DATA_0FCF69:
	db "ADVICE / TRAFFIC JAM    "
	db "                        "
	db "A traffic problem is    "
	db "inevitable when your    "
	db "city grows. Traffic jams"
	db "cause environmental     "
	db "pollution.  One way to  "
	db "solve this problem is to"
	db "replace the roads with  "
	db "mass transit lines.",$FF

DATA_0FD055:
	db "ADVICE / TAX            "
	db "                        "
	db "If the tax rate is too  "
	db "high, the residents will"
	db "move to other cities.   "
	db "Most of the residents   "
	db "feel that a 7% tax rate "
	db "is fair.",$FF

DATA_0FD106:
	db "ADVICE / UNEMPLOYMENT   "
	db "                        "
	db "The citizens of your    "
	db "city need jobs! Build   "
	db "Commercial or Industrial"
	db "zones closer to         "
	db "Residential zones and   "
	db "check the transportation"
	db "grid to make sure your  "
	db "mass transit lines are  "
	db "used efficiently.",$FF

DATA_0FD208:
	db "SHIPWRECK!              "
	db "                        "
	db "Abandon ship! A ship has"
	db "crashed somewhere! Let*s"
	db "find out what happened  "
	db "and repair any damage it"
	db "may have caused.",$FF

DATA_0FD2A9:
	db "Where would you like to "
	db "build your own house? Do"
	db "you want to live near   "
	db "the residents of your   "
	db "city or do you want to  "
	db "build your house in a   "
	db "secluded area away from "
	db "the congestion?         "
	db "Remember, another       "
	db "election is just around "
	db "the corner!",$FF

DATA_0FD3A5:
	db "DISASTER!               "
	db "                        "
	db "A disaster is happening "
	db "somewhere in the city!  "
	db "You*ll need to find out "
	db "what has happened and   "
	db "take care of it as soon "
	db "as possible.",$FF

DATA_0FD45A:
	db "Do you know how to read "
	db "this graph?  If the bar "
	db "is positive, there is a "
	db "demand for that type of "
	db "zone.The longer the bar,"
	db "the greater the demand. "
	db "Once you know how to use"
	db "this graph, the feedback"
	db "will help you to prevent"
	db "unnecessary construction"
	db "of zones.",$FF

DATA_0FD554:
	db "CONGRATULATIONS! YOU*VE "
	db "BECOME A GREAT MAYOR!   "
	db "                        "
	db "The residents of SimCity"
	db "have decided to honor   "
	db "you as their most       "
	db "successful Mayor. You*ve"
	db "helped this city grow   "
	db "into a thriving         "
	db "Megalopolis and you     "
	db "should have a long      "
	db "career as a politician.",$FF

DATA_0FD674:
	db "Run!  Hide! Aaaahhh. . ."
	db "Aliens are attacking Las"
	db "Vegas!  Parts of the    "
	db "city have been damaged  "
	db "by the attack.  Check   "
	db "the city for damage and "
	db "rebuild as soon as      "
	db "possible.",$FF

DATA_0FD726:
	db "YOUR CITY NOW HAS       "
	db "100,000 PEOPLE!         "
	db "                        "
	db "Congratulations!  Your  "
	db "city has reached a      "
	db "population of 100,000   "
	db "people!  You*ve done an "
	db "excellent job in        "
	db "developing your city    "
	db "given the limited amount"
	db "of land available.  Your"
	db "planning has been very  "
	db "successful.  Keep it up!",$FF

DATA_0FD85F:
	db "LET*S PLAN A BUDGET!    "
	db "                        "
	db "It is important to form "
	db "a budget every December."
	db "Careful planning is     "
	db "required to increase    "
	db "your revenue without    "
	db "upsetting the citizens. "
	db "If they think the tax   "
	db "rate is high, they*ll   "
	db "move to another city.",$FF

DATA_0FD965:
	db "Is everything going ok? "
	db "To develop your city    "
	db "further, I think you    "
	db "should study your       "
	db "transportation network. "
	db "Citizens don*t like to  "
	db "live or work in an area "
	db "that is difficult to get"
	db "to.  Connect each zone  "
	db "with roads or rail, but "
	db "remember every kilometer"
	db "requires maintenance.",$FF

check bankcross on
	%FREE_BYTES($0FDA83, 9597, $FF)
%BANK_END(<EndBank>)
endmacro

;#############################################################################################################
;#############################################################################################################
