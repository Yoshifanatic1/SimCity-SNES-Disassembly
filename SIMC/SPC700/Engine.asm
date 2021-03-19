
; Note: If you plan on editing this, you probably should modify the SNES code to load Engine.bin rather than decompress CompressedSPCBlock1.lz5 and CompressedSPCBlock2.lz5.

%SPCDataBlockStart(3400)
DATA_3400:
	db $00,$8F,$E0,$B8,$03,$00,$01,$8F,$ED,$B8,$07,$A0,$02,$8F,$E0,$B8
	db $03,$00,$03,$8F,$E0,$B8,$03,$00,$04,$8F,$E0,$B8,$03,$00,$05,$8F
	db $E7,$B8,$0B,$00,$06,$8F,$E0,$B8,$46,$00,$07,$8F,$E0,$B8,$00,$00
	db $08,$8F,$E0,$B8,$0C,$00,$09,$8F,$E0,$B8,$04,$00,$0A,$8F,$E0,$B8
	db $64,$00,$0B,$FF,$E0,$B8,$07,$A0,$0C,$8F,$EB,$B8,$03,$00,$0D,$8F
	db $E0,$B8,$07,$00,$0E,$8F,$E0,$B8,$03,$00,$0F,$8F,$EE,$B8,$07,$00
	db $10,$8F,$E0,$B8,$07,$00,$11,$8F,$E0,$B8,$07,$A0,$12,$8F,$ED,$B8
	db $09,$00,$13,$8F,$F3,$B8,$03,$00,$14,$8F,$EB,$B8,$03,$00,$15,$8F
	db $E6,$B8,$10,$00,$16,$8F,$E0,$B8,$07,$A0,$17,$8F,$E0,$B8,$80,$00
	db $18,$8F,$E0,$B8,$06,$A0,$32,$65,$7F,$98,$B2,$CB,$E5,$FC,$19,$32
	db $4C,$65,$72,$7F,$8C,$98,$A5,$B2,$BF,$CB,$D8,$E5,$F2,$FC
%SPCDataBlockEnd(3400)

%SPCDataBlockStart(0800)
DATA_0800:
	CLRP
	MOV X, #$CF
	MOV SP, X
	MOV A, #$00
	MOV X, A
CODE_0807:
	MOV (X+), A
	CMP X, #$E0
	BNE CODE_0807
	MOV X, #$00
CODE_080E:
	MOV $0200+x, A
	INC X
	BNE CODE_080E
CODE_0814:
	MOV $0300+x, A
	INC X
	BNE CODE_0814
	INC A
	CALL CODE_175D
	SET5 $48
	MOV A, #$60
	MOV Y, #$0C
	CALL CODE_09FB
	MOV Y, #$1C
	CALL CODE_09FB
	MOV A, #$35
	MOV Y, #$5D
	CALL CODE_09FB
	MOV A, #$F0
	MOV $00F1, A
	MOV A, #$10
	MOV $00FA, A
	MOV $53, A
	MOV A, #$01
	MOV $00F1, A
CODE_0844:
	MOV Y, #$0A
CODE_0846:
	CMP Y, #$05
	BEQ CODE_0851
	BCS CODE_0854
	CMP $4C, $4D
	BNE CODE_0862
CODE_0851:
	BBS7 $4C, CODE_0862
CODE_0854:
	MOV A, DATA_1AD4+y
	MOV $00F2, A
	MOV A, DATA_1ADE+y
	MOV X, A
	MOV A, (X)
	MOV $00F3, A
CODE_0862:
	DBNZ Y, CODE_0846
	MOV $45, Y
	MOV $46, Y
	MOV A, $18
	EOR A, $19
	LSR A
	LSR A
	NOTC
	ROR $18
	ROR $19
CODE_0873:
	MOV Y, $00FD
	BEQ CODE_0873
	PUSH Y
	MOV A, #$38
	MUL YA
	CLRC
	ADC A, $43
	MOV $43, A
	BCC CODE_08AE
	CALL CODE_1378
	MOV X, #$01
	CALL CODE_08E5
	CALL CODE_0AB2
	CALL CODE_0AA6
	MOV X, #$02
	CALL CODE_08E5
	CALL CODE_0AAB
	MOV X, #$03
	CALL CODE_08E5
	CMP $4C, $4D
	BEQ CODE_08AE
	INC $03C7
	MOV A, $03C7
	LSR A
	BCS CODE_08AE
	INC $4C
CODE_08AE:
	MOV A, $53
	POP Y
	MUL YA
	CLRC
	ADC A, $51
	MOV $51, A
	BCC CODE_08CC
	CALL CODE_1378
	CALL CODE_1422
	MOV X, #$00
	CALL CODE_08E5
	MOV X, #$01
	CALL CODE_08E5
	JMP CODE_0844

CODE_08CC:
	MOV A, $0D
	BEQ CODE_08E2
	MOV X, #$00
	MOV $47, #$01
CODE_08D5:
	MOV A, $31+x
	BEQ CODE_08DC
	CALL CODE_19FD
CODE_08DC:
	INC X
	INC X
	ASL $47
	BNE CODE_08D5
CODE_08E2:
	JMP CODE_0844

CODE_08E5:
	MOV A, $04+x
	MOV $00F4+x, A
CODE_08EA:
	MOV A, $00F4+x
	CMP A, $00F4+x
	BNE CODE_08EA
	MOV Y, A
	BNE CODE_08F7
	MOV $04+x, Y
CODE_08F7:
	MOV A, $08+x
	MOV $08+x, Y
	CBNE $08+x, CODE_0903
	MOV Y, #$00
	MOV $00+x, Y
	RET

CODE_0903:
	MOV $00+x, Y
CODE_0905:
	RET

CODE_0906:
	CMP Y, #$CA
	BCC CODE_090F
	CALL CODE_15A6
	MOV Y, #$A4
CODE_090F:
	CMP Y, #$C8
	BCS CODE_0905
	MOV A, $1A
	AND A, $47
	BNE CODE_0905
	MOV A, Y
	AND A, #$7F
	CLRC
	ADC A, $50
	CLRC
	ADC A, $02F0+x
	MOV $0361+x, A
	MOV A, $0381+x
	MOV $0360+x, A
	MOV A, $02B1+x
	LSR A
	MOV A, #$00
	ROR A
	MOV $02A0+x, A
	MOV A, #$00
	MOV $B0+x, A
	MOV $0100+x, A
	MOV $02D0+x, A
	MOV $C0+x, A
	OR $5E, $47
	OR $45, $47
	MOV A, $0280+x
	MOV $A0+x, A
	BEQ CODE_096D
	MOV A, $0281+x
	MOV $A1+x, A
	MOV A, $0290+x
	BNE CODE_0963
	MOV A, $0361+x
	SETC
	SBC A, $0291+x
	MOV $0361+x, A
CODE_0963:
	MOV A, $0291+x
	CLRC
	ADC A, $0361+x
	CALL CODE_17D5
CODE_096D:
	CALL CODE_17ED
CODE_0970:
	MOV Y, #$00
	MOV A, $11
	SETC
	SBC A, #$34
	BCS CODE_0982
	MOV A, $11
	SETC
	SBC A, #$13
	BCS CODE_0986
	DEC Y
	ASL A
CODE_0982:
	ADDW YA, $10
	MOVW $10, YA
CODE_0986:
	PUSH X
	MOV A, $11
	ASL A
	MOV Y, #$00
	MOV X, #$18
	DIV YA, X
	MOV X, A
	MOV A, DATA_1AE9+$01+y
	MOV $15, A
	MOV A, DATA_1AE9+y
	MOV $14, A
	MOV A, DATA_1AE9+$03+y
	PUSH A
	MOV A, DATA_1AE9+$02+y
	POP Y
	SUBW YA, $14
	MOV Y, $10
	MUL YA
	MOV A, Y
	MOV Y, #$00
	ADDW YA, $14
	MOV $15, Y
	ASL A
	ROL $15
	MOV $14, A
	BRA CODE_09B9

CODE_09B5:
	LSR $15
	ROR A
	INC X
CODE_09B9:
	CMP X, #$06
	BNE CODE_09B5
	MOV $14, A
	POP X
	MOV A, $0220+x
	MOV Y, $15
	MUL YA
	MOVW $16, YA
	MOV A, $0220+x
	MOV Y, $14
	MUL YA
	PUSH Y
	MOV A, $0221+x
	MOV Y, $14
	MUL YA
	ADDW YA, $16
	MOVW $16, YA
	MOV A, $0221+x
	MOV Y, $15
	MUL YA
	MOV Y, A
	POP A
	ADDW YA, $16
	MOVW $16, YA
	MOV A, X
	XCN A
	LSR A
	OR A, #$02
	MOV Y, A
	MOV A, $16
	CALL CODE_09F3
	INC Y
	MOV A, $17
CODE_09F3:
	PUSH A
	MOV A, $47
	AND A, $1A
	POP A
	BNE CODE_0A01
CODE_09FB:
	MOV $00F2, Y
	MOV $00F3, A
CODE_0A01:
	RET

CODE_0A02:
	MOV Y, #$0E
	MOV X, #$80
	MOV $03C1, X
CODE_0A09:
	MOV A, $03A0+y
	SETC
	SBC A, #$10
	CMP A, $03
	BEQ CODE_0A1C
	DEC Y
	DEC Y
	LSR $03C1
	BNE CODE_0A09
	BRA CODE_0A4D

CODE_0A1C:
	MOV $03C0, Y
	BRA CODE_0A69

CODE_0A21:
	SETC
	MOV A, $03C8
	SBC A, #$02
	AND A, #$0F
	MOV $03C0, A
	CLRC
	MOV A, $03C9
	LSR A
	MOV $03C1, A
	BNE CODE_0A3B
	MOV A, #$80
	MOV $03C1, A
CODE_0A3B:
	MOV A, $03C0
	MOV $03C8, A
	MOV A, $03C1
	MOV $03C9, A
	OR A, $1A
	MOV $1A, A
	BRA CODE_0A79

CODE_0A4D:
	MOV A, #$FF
	CBNE $1A, CODE_0A54
	BRA CODE_0A21

CODE_0A54:
	CLRC
	MOV X, #$1A
	MOV A, #$80
	MOV $03C1, A
	MOV Y, #$0E
CODE_0A5E:
	AND A, (X)
	BEQ CODE_0A69
	DEC Y
	DEC Y
	LSR $03C1
	LSR A
	BCC CODE_0A5E
CODE_0A69:
	MOV $03C0, Y
	MOV $03C8, Y
	MOV A, $03C1
	MOV $03C9, A
	OR A, $1A
	MOV $1A, A
CODE_0A79:
	MOV A, $03C1
	AND A, $4A
	BEQ CODE_0A8D
	MOV A, $4A
	SETC
	SBC A, $03C1
	MOV $4A, A
	MOV Y, #$4D
	CALL CODE_09FB
CODE_0A8D:
	RET

CODE_0A8E:
	MOV X, $03C4
	MOV $03C0, X
	MOV Y, $03C5
	MOV $03C1, Y
	MOV A, $03C1
	MOV Y, #$5C
	CALL CODE_09FB
	CALL CODE_0B5E
	RET

CODE_0AA6:
	MOV A, $02
	BNE CODE_0B0E
	RET

CODE_0AAB:
	MOV A, $03
	BMI CODE_0A8E
	BNE CODE_0AD7
	RET

CODE_0AB2:
	MOV X, #$0E
	MOV A, #$80
	MOV $03C1, A
CODE_0AB9:
	MOV $03C0, X
	MOV A, X
	XCN A
	LSR A
	MOV $03C2, A
	MOV A, $03A1+x
	BNE CODE_0B35
	MOV A, $03A0+x
	BEQ CODE_0ACF
	JMP CODE_0B8F

CODE_0ACF:
	LSR $03C1
	DEC X
	DEC X
	BPL CODE_0AB9
	RET

CODE_0AD7:
	CALL CODE_0A02
	MOV X, $03C0
	MOV A, $03
	CMP A, #$09
	BNE CODE_0AEC
	MOV $03C4, X
	MOV Y, $03C1
	MOV $03C5, Y
CODE_0AEC:
	CLRC
	ADC A, #$10
	MOV $03A0+x, A
	MOV A, #$03
	MOV $03A1+x, A
	MOV A, #$00
	MOV $0280+x, A
	MOV A, $03C1
	MOV Y, #$5C
	CALL CODE_09FB
	MOV X, $03
	MOV A, DATA_0E12+x
	MOV $03, A
	BNE CODE_0AD7
	RET

CODE_0B0E:
	CALL CODE_0A4D
	MOV X, $03C0
	MOV A, $02
	MOV $03A0+x, A
	MOV A, #$03
	MOV $03A1+x, A
	MOV A, #$00
	MOV $0280+x, A
	MOV A, $03C1
	MOV Y, #$5C
	CALL CODE_09FB
	MOV X, $02
	MOV A, DATA_0D95+x
	MOV $02, A
	BNE CODE_0B0E
	RET

CODE_0B35:
	MOV $03C0, X
	MOV A, $03A1+x
	DEC A
	MOV $03A1+x, A
	BNE CODE_0ACF
CODE_0B41:
	MOV A, $03A0+x
	ASL A
	MOV Y, A
	MOV A, DATA_0DA4+$01+y
	MOV $0391+x, A
	MOV $2D, A
	MOV A, DATA_0DA4+y
	MOV $0390+x, A
	MOV $2C, A
	BRA CODE_0BA9

CODE_0B58:
	CALL CODE_0B5E
	JMP CODE_0ACF

CODE_0B5E:
	MOV A, #$00
	MOV X, $03C0
	MOV $03A0+x, A
	MOV A, $1A
	SETC
	SBC A, $03C1
	MOV $1A, A
	MOV $44, X
	MOV A, $0211+x
	CALL CODE_15A6
	MOV A, $03C1
	AND A, $03C3
	BEQ CODE_0B8B
	MOV A, $4A
	CLRC
	ADC A, $03C1
	MOV $4A, A
	MOV Y, #$4D
	CALL CODE_09FB
CODE_0B8B:
	MOV X, $03C0
	RET

CODE_0B8F:
	CALL CODE_0A79
	MOV $03C0, X
	MOV A, $0391+x
	MOV Y, A
	MOV A, $0390+x
	MOVW $2C, YA
	MOV A, $03B0+x
	DEC A
	MOV $03B0+x, A
	BNE CODE_0C1A
CODE_0BA7:
	INCW $2C
CODE_0BA9:
	MOV A, $03C0
	XCN A
	LSR A
	MOV $03C2, A
	MOV X, #$00
	MOV A, ($2C+x)
	BEQ CODE_0B58
	BMI CODE_0BEB
	MOV Y, $03C0
	MOV $03B1+y, A
	INCW $2C
	MOV A, ($2C+x)
	MOV $10, A
	BMI CODE_0BEB
	MOV Y, $03C2
	CALL CODE_09FB
	INCW $2C
	MOV A, ($2C+x)
	BPL CODE_0BE0
	MOV X, A
	MOV A, $10
	MOV Y, $03C2
	INC Y
	CALL CODE_09FB
	MOV A, X
	BRA CODE_0BEB

CODE_0BE0:
	MOV Y, $03C2
	INC Y
	CALL CODE_09FB
	INCW $2C
	MOV A, ($2C+x)
CODE_0BEB:
	CMP A, #$E0
	BNE CODE_0BF2
	JMP CODE_0C84

CODE_0BF2:
	CMP A, #$F9
	BEQ CODE_0C47
	CMP A, #$F1
	BEQ CODE_0C5C
	CMP A, #$FF
	BNE CODE_0C04
	MOV X, $03C0
	JMP CODE_0B41

CODE_0C04:
	MOV X, $03C0
	MOV Y, A
	CALL CODE_0906
	MOV A, $03C1
	CALL CODE_0CCA
CODE_0C11:
	MOV X, $03C0
	MOV A, $03B1+x
	MOV $03B0+x, A
CODE_0C1A:
	CLR7 $13
	MOV X, $03C0
	MOV A, $A0+x
	BEQ CODE_0C28
	CALL CODE_0CB0
	BRA CODE_0C37

CODE_0C28:
	MOV A, #$02
	CMP A, $03B0+x
	BNE CODE_0C37
	MOV A, $03C1
	MOV Y, #$5C
	CALL CODE_09FB
CODE_0C37:
	MOV X, $03C0
	MOV A, $2D
	MOV $0391+x, A
	MOV A, $2C
	MOV $0390+x, A
	JMP CODE_0ACF

CODE_0C47:
	MOV X, #$00
	INCW $2C
	MOV A, ($2C+x)
	MOV X, $03C0
	MOV $44, X
	MOV Y, A
	CALL CODE_0906
	MOV A, $03C1
	CALL CODE_0CCA
CODE_0C5C:
	MOV X, #$00
	INCW $2C
	MOV A, ($2C+x)
	MOV X, $03C0
	MOV $A1+x, A
	MOV X, #$00
	INCW $2C
	MOV A, ($2C+x)
	MOV X, $03C0
	MOV $A0+x, A
	PUSH A
	MOV X, #$00
	INCW $2C
	MOV A, ($2C+x)
	POP Y
	MOV X, $03C0
	MOV $44, X
	CALL CODE_17D5
	BRA CODE_0C11

CODE_0C84:
	MOV X, #$00
	INCW $2C
	MOV A, ($2C+x)
	MOV Y, #$09
	MUL YA
	MOV X, A
	MOV Y, $03C2
	MOV $12, #$08
CODE_0C94:
	MOV A, DATA_0CD8+x
	CALL CODE_09FB
	INC X
	INC Y
	DBNZ $12, CODE_0C94
	MOV A, DATA_0CD8+x
	MOV Y, $03C0
	MOV $0221+y, A
	MOV A, #$00
	MOV $0220+y, A
	JMP CODE_0BA7

CODE_0CB0:
	SET7 $13
	MOV A, #$60
	MOV Y, #$03
	DEC $A0+x
	CALL CODE_18FF
	MOV A, $0361+x
	MOV Y, A
	MOV A, $0360+x
	MOVW $10, YA
	MOV $47, #$00
	JMP CODE_0970

CODE_0CCA:
	PUSH A
	MOV Y, #$5C
	MOV A, #$00
	CALL CODE_09FB
	POP A
	MOV Y, #$4C
	JMP CODE_09FB

DATA_0CD8:
	db $70,$70,$00,$10,$00,$FE,$0A,$B8,$03,$70,$70,$00,$10,$02,$FE,$6A
	db $B8,$03,$70,$70,$00,$10,$01,$FE,$6A,$B8,$05,$70,$70,$00,$10,$04
	db $FE,$6A,$B8,$02,$70,$70,$00,$10,$04,$FE,$00,$7F,$06,$70,$70,$00
	db $10,$05,$86,$EB,$7F,$0B,$70,$70,$00,$10,$06,$0E,$F1,$70,$04,$70
	db $70,$00,$10,$07,$0E,$F1,$70,$03,$70,$70,$00,$10,$12,$96,$CD,$70
	db $03,$70,$70,$00,$10,$03,$FE,$F5,$70,$03,$70,$70,$00,$10,$08,$8E
	db $E0,$70,$02,$70,$70,$00,$10,$01,$FE,$F4,$B8,$04,$70,$70,$00,$10
	db $03,$8E,$E0,$B8,$03,$70,$70,$00,$10,$09,$8E,$E0,$B8,$06,$70,$70
	db $00,$10,$0A,$84,$F0,$B8,$02,$70,$70,$00,$10,$0B,$8E,$E0,$B8,$04
	db $70,$70,$00,$10,$11,$8E,$E0,$B8,$02,$70,$70,$00,$10,$00,$FE,$6A
	db $B8,$03,$70,$70,$00,$10,$0C,$FD,$0F,$B8,$03,$70,$70,$00,$10,$02
	db $F8,$6A,$B8,$03,$70,$70,$00,$10,$0A,$88,$E0,$B8,$02

DATA_0D95:
	db $00,$00,$00,$00,$00,$0A,$08,$09,$00,$00,$00,$00,$00,$00,$00

DATA_0DA4:
	dw $0000,DATA_1342,DATA_1368,DATA_136E,DATA_12CD,DATA_11F2,DATA_12A5,DATA_12B9
	dw DATA_12AE,DATA_12C2,DATA_1211,DATA_1057,DATA_1272,DATA_1283,DATA_1294,DATA_136D
	dw DATA_136D,DATA_123D,DATA_1256,DATA_1300,DATA_1306,DATA_1329,DATA_1355,DATA_11DA
	dw DATA_11E0,DATA_11A7,DATA_1198,DATA_10CD,DATA_109F,DATA_1131,DATA_130C,DATA_12D7
	dw DATA_108D,DATA_101E,DATA_1031,DATA_1044,DATA_0FA4,DATA_0FD4,DATA_0FEF,DATA_0F75
	dw DATA_0F7C,DATA_0F86,DATA_0F90,DATA_0F9A,DATA_0F17,DATA_0F14,DATA_0EF4,DATA_10F9
	dw DATA_1160,DATA_0EAB,DATA_0ECC,DATA_0E7E,DATA_0E57,DATA_0E54,DATA_0E39

DATA_0E12:
	db $00,$02,$00,$00,$00,$0E,$00,$00,$00,$00,$00,$0D,$00,$00,$00,$00
	db $00,$12,$13,$10,$15,$16,$10,$18,$19,$1A,$1B,$00,$1D,$00,$00,$20
	db $00,$23,$00,$00,$25,$00,$00

DATA_0E39:
	db $E0,$12,$08,$50,$C3,$08,$46,$C3,$08,$3C,$C3,$18,$32,$C3,$08,$50
	db $C3,$08,$46,$C3,$08,$3C,$C3,$18,$32,$C3,$00

DATA_0E54:
	db $04,$00,$92

DATA_0E57:
	db $E0,$14,$0C,$7F,$85,$04,$00,$85,$30,$7F,$F9,$85,$00,$30,$85,$33
	db $F1,$00,$30,$82,$0C,$7F,$85,$04,$00,$85,$30,$7F,$F9,$85,$00,$30
	db $85,$33,$F1,$00,$30,$82,$00

DATA_0E7E:
	db $E0,$07,$0C,$00,$91,$0C,$7F,$95,$18,$00,$8E,$0C,$7F,$93,$0C,$7F
	db $90,$30,$00,$90,$0C,$7F,$8E,$24,$00,$93,$0C,$7F,$91,$E0,$14,$60
	db $7F,$F9,$85,$00,$60,$87,$33,$6B,$F1,$00,$30,$89,$00

DATA_0EAB:
	db $E0,$07,$0C,$7F,$91,$E0,$14,$60,$7F,$F9,$85,$00,$60,$87,$30,$6B
	db $F1,$00,$30,$8C,$30,$7F,$F1,$00,$30,$87,$33,$6B,$F1,$00,$30,$89
	db $00

DATA_0ECC:
	db $E0,$14,$18,$7F,$F9,$98,$00,$18,$91,$18,$F1,$00,$18,$97,$18,$F1
	db $00,$18,$90,$18,$F1,$00,$18,$95,$18,$F1,$00,$18,$8E,$60,$F1,$00
	db $60,$89,$63,$F1,$00,$60,$80,$00

DATA_0EF4:
	db $E0,$07,$06,$64,$9D,$A1,$A3,$0C,$28,$5A,$A1,$0C,$46,$46,$9A,$12
	db $78,$9D,$06,$64,$9D,$A1,$A3,$A1,$9D,$9C,$9A,$18,$28,$5A,$98,$00

DATA_0F14:
	db $18,$00,$BC

DATA_0F17:
	db $E0,$13,$0C,$14,$00,$F9,$C0,$00,$0C,$C1,$18,$F1,$00,$18,$C2,$0C
	db $1E,$0A,$F9,$C0,$00,$0C,$C1,$18,$F1,$00,$18,$C2,$0C,$28,$1E,$F9
	db $C0,$00,$0C,$C1,$18,$F1,$00,$18,$C2,$0C,$1E,$28,$F9,$C0,$00,$0C
	db $C1,$18,$F1,$00,$18,$C2,$0C,$14,$1E,$F9,$C0,$00,$0C,$C1,$18,$F1
	db $00,$18,$C2,$0C,$0A,$14,$F9,$C0,$00,$0C,$C1,$18,$F1,$00,$18,$C2
	db $0C,$00,$0A,$F9,$C0,$00,$0C,$C1,$1B,$F1,$00,$18,$C2,$00

DATA_0F75:
	db $E0,$12,$60,$78,$00,$B0,$00

DATA_0F7C:
	db $E0,$12,$08,$00,$B0,$60,$1E,$5A,$B7,$00

DATA_0F86:
	db $E0,$12,$10,$00,$B0,$60,$3C,$3C,$BC,$00

DATA_0F90:
	db $E0,$12,$18,$00,$B0,$60,$5A,$1E,$C0,$00

DATA_0F9A:
	db $E0,$12,$20,$00,$B0,$60,$00,$78,$C3,$00

DATA_0FA4:
	db $E0,$11,$24,$00,$8C,$0C,$3C,$B0,$0C,$00,$BC,$0C,$3C,$BC,$0C,$00
	db $BC,$0C,$3C,$BB,$B9,$B7,$B5,$0C,$3C,$B7,$0C,$00,$BC,$0C,$3C,$B4
	db $0C,$00,$BC,$0C,$3C,$B2,$B4,$B2,$B0,$AF,$AB,$AD,$AF,$48,$B0,$00

DATA_0FD4:
	db $E0,$11,$24,$00,$8C,$18,$32,$9D,$A4,$9E,$A4,$9F,$A4,$9A,$A1,$9F
	db $A3,$98,$12,$9F,$06,$00,$9F,$30,$32,$98,$00

DATA_0FEF:
	db $E0,$11,$24,$00,$8C,$18,$00,$9D,$18,$32,$A1,$18,$00,$9D,$18,$32
	db $A1,$18,$00,$9D,$18,$32,$A8,$18,$00,$9D,$18,$32,$A9,$18,$00,$9D
	db $18,$32,$A6,$18,$00,$9D,$12,$32,$9C,$06,$00,$9C,$30,$9C,$00

DATA_101E:
	db $E0,$10,$24,$00,$8C,$0C,$28,$B4,$18,$B4,$B4,$0C,$B0,$18,$B4,$30
	db $B7,$AB,$00

DATA_1031:
	db $E0,$10,$24,$00,$8C,$0C,$0A,$AA,$18,$AA,$AA,$0C,$AA,$18,$AA,$30
	db $AF,$A3,$00

DATA_1044:
	db $E0,$10,$24,$00,$8C,$0C,$0A,$9A,$18,$9A,$9A,$0C,$9A,$18,$9A,$30
	db $9F,$93,$00

DATA_1057:
	db $E0,$0C,$18,$32,$BC,$E0,$0B,$04,$32,$A4,$9F,$A4,$9F,$A4,$9F,$A4
	db $9F,$A4,$9F,$A4,$9F,$A4,$9F,$A4,$9F,$A4,$9F,$A4,$9F,$A4,$9F,$A4
	db $9F,$A4,$9F,$A4,$9F,$A4,$9F,$A4,$9F,$A4,$9F,$A4,$9F,$A4,$9F,$A4
	db $9F,$A4,$9F,$A4,$9F,$00

DATA_108D:
	db $E0,$0F,$30,$00,$98,$60,$78,$F9,$98,$00,$60,$98,$4B,$F1,$00,$48
	db $98,$00

DATA_109F:
	db $E0,$0E,$18,$00,$7F,$F9,$98,$00,$18,$9A,$18,$14,$6B,$F1,$00,$18
	db $9C,$18,$2F,$50,$F1,$00,$18,$9E,$18,$43,$3C,$F1,$00,$18,$A0,$18
	db $50,$28,$F1,$00,$18,$A2,$33,$64,$00,$F1,$00,$30,$A4,$00

DATA_10CD:
	db $E0,$0C,$03,$50,$B9,$B5,$B9,$B5,$03,$50,$B9,$B5,$B9,$B5,$03,$50
	db $B9,$B5,$B9,$B5,$03,$46,$B9,$B5,$B9,$B5,$03,$3C,$B9,$B5,$B9,$B5
	db $03,$28,$B9,$B5,$B9,$B5,$03,$14,$B9,$B5,$B9,$B5

DATA_10F9:
	db $18,$00,$C0,$E0,$0B,$0A,$3C,$8C,$3E,$8C,$0A,$1E,$85,$37,$85,$09
	db $46,$8C,$32,$8C,$08,$28,$85,$2E,$85,$08,$3C,$8C,$28,$8C,$08,$1E
	db $85,$26,$85,$08,$32,$8C,$24,$8C,$08,$14,$85,$48,$85,$08,$28,$8C
	db $24,$8C,$08,$0A,$85,$48,$85,$00

DATA_1131:
	db $E0,$0C,$02,$00,$B9,$03,$3C,$B9,$B5,$B9,$B5,$03,$3C,$B9,$B5,$B9
	db $B5,$03,$3C,$B9,$B5,$B9,$B5,$03,$32,$B9,$B5,$B9,$B5,$03,$14,$B9
	db $B5,$B9,$B5,$03,$0A,$B9,$B5,$B9,$B5,$03,$05,$B9,$B5,$B9,$B5

DATA_1160:
	db $36,$00,$C0,$E0,$0B,$0A,$3C,$8C,$3E,$8C,$0A,$1E,$85,$37,$85,$09
	db $46,$8C,$32,$8C,$08,$28,$85,$2E,$85,$08,$3C,$8C,$28,$8C,$08,$1E
	db $85,$26,$85,$08,$14,$8C,$24,$8C,$08,$0A,$85,$48,$85,$08,$0F,$8C
	db $24,$8C,$08,$05,$85,$48,$85,$00

DATA_1198:
	db $E0,$0A,$7F,$3C,$F9,$AC,$00,$7F,$AC,$7B,$F1,$00,$78,$AC,$00

DATA_11A7:
	db $E0,$07,$08,$00,$7C,$8E,$08,$4E,$22,$8D,$0C,$64,$56,$8C,$12,$56
	db $7C,$8D,$0C,$2C,$58,$8B,$12,$5C,$3A,$89,$0C,$62,$4A,$8B,$08,$2C
	db $44,$8C,$0C,$44,$2C,$89,$18,$60,$51,$8B,$08,$36,$44,$8C,$30,$4E
	db $4E,$8B,$FF

DATA_11DA:
	db $E0,$09,$06,$3C,$BB,$00

DATA_11E0:
	db $E0,$0C,$04,$50,$B9,$04,$3C,$B9,$04,$28,$B9,$04,$14,$B9,$04,$0A
	db $B9,$00

DATA_11F2:
	db $E0,$0D,$18,$14,$F9,$B4,$00,$18,$B5,$60,$F1,$00,$60,$B5,$60,$1E
	db $F1,$00,$60,$B5,$60,$F1,$00,$60,$AD,$63,$F1,$00,$60,$A6,$00

DATA_1211:
	db $E0,$0D,$30,$00,$B4,$18,$0A,$F9,$B3,$00,$18,$B6,$60,$F1,$00,$60
	db $B3,$18,$0F,$F1,$00,$18,$B6,$60,$F1,$00,$60,$B3,$18,$F1,$00,$18
	db $B4,$60,$F1,$00,$60,$B1,$63,$F1,$00,$60,$AB,$00

DATA_123D:
	db $E0,$08,$12,$78,$F9,$89,$00,$12,$8D,$0C,$F1,$00,$0C,$99,$24,$F1
	db $00,$24,$97,$7F,$F1,$00,$48,$82,$00

DATA_1256:
	db $E0,$08,$0C,$00,$A5,$12,$5A,$F9,$89,$00,$12,$8D,$0C,$F1,$00,$0C
	db $99,$24,$F1,$00,$24,$97,$7F,$F1,$00,$48,$82,$00

DATA_1272:
	db $E0,$00,$12,$64,$F9,$AB,$00,$0C,$B7,$12,$64,$F9,$B2,$00,$0C,$BE
	db $00

DATA_1283:
	db $E0,$00,$12,$64,$F9,$B2,$00,$0C,$BE,$12,$64,$F9,$B7,$00,$0C,$C3
	db $00

DATA_1294:
	db $E0,$00,$12,$64,$F9,$BA,$00,$0C,$AD,$12,$64,$F9,$AB,$00,$0C,$A6
	db $00

DATA_12A5:
	db $E0,$09,$08,$00,$B7,$2C,$1E,$BE,$00

DATA_12AE:
	db $E0,$09,$10,$3C,$00,$B7,$24,$00,$3C,$C3,$00

DATA_12B9:
	db $E0,$09,$08,$00,$B7,$2C,$1E,$BE,$00

DATA_12C2:
	db $E0,$09,$10,$00,$3C,$C3,$24,$3C,$00,$B7,$00

DATA_12CD:
	db $E0,$03,$06,$64,$98,$98,$30,$64,$98,$00

DATA_12D7:
	db $E0,$0E,$18,$7F,$F9,$B0,$00,$18,$AE,$18,$6B,$F1,$00,$18,$AC,$18
	db $6B,$F1,$00,$18,$AA,$1B,$6B,$F1,$00,$18,$A8,$E0,$07,$12,$28,$5A
	db $95,$12,$46,$46,$95,$60,$78,$95,$00

DATA_1300:
	db $E0,$07,$60,$78,$98,$00

DATA_1306:
	db $E0,$06,$18,$46,$9C,$00

DATA_130C:
	db $E0,$05,$12,$00,$9C,$60,$00,$0A,$F9,$9C,$00,$60,$9C,$60,$F1,$00
	db $60,$9C,$60,$F1,$00,$60,$9C,$63,$F1,$00,$60,$9C,$00

DATA_1329:
	db $E0,$05,$60,$23,$F9,$9C,$00,$60,$9C,$60,$F1,$00,$60,$9C,$60,$F1
	db $00,$60,$9C,$63,$F1,$00,$60,$9C,$00

DATA_1342:
	db $E0,$04,$06,$78,$F9,$B0,$00,$06,$A4,$E0,$02,$09,$46,$F9,$B0,$00
	db $06,$B7,$00

DATA_1355:
	db $E0,$00,$06,$78,$F9,$98,$00,$06,$A4,$E0,$02,$0F,$46,$F9,$A3,$00
	db $0C,$9F,$00

DATA_1368:
	db $E0,$0D,$18,$32,$8D
DATA_136D:
	db $00

DATA_136E:
	db $E0,$03,$07,$32,$F9,$B7,$00,$04,$93,$00

CODE_1378:
	BBS0 $01, CODE_1386
	BBS1 $01, CODE_137F
	RET

CODE_137F:
	MOV A, #$00
	MOV $03CA, A
	BEQ CODE_138B
CODE_1386:
	CALL CODE_13AD
	MOV A, #$01
CODE_138B:
	MOV $03C6, A
	RET

CODE_138F:
	MOV X, #$A0
	MOV $5A, X
	MOV $03CA, X
	MOV A, #$00
	MOV $5B, A
	SETC
	SBC A, $59
	CALL CODE_17F8
	MOVW $5C, YA
	JMP CODE_1440

CODE_13A5:
	DEC $03CA
	BEQ CODE_13AD
	JMP CODE_144C

CODE_13AD:
	MOV A, $1A
	EOR A, #$FF
	TSET $0046, A
	MOV $0D, #$00
	MOV $47, #$00
	RET

CODE_13BB:
	MOV Y, #$00
	MOV A, ($40)+y
	INCW $40
	PUSH A
	MOV A, ($40)+y
	INCW $40
	MOV Y, A
	POP A
	RET

CODE_13C9:
	CLRC
	MOV X, #$00
	MOV $03CA, X
	MOV $0D, A
	ASL A
	MOV X, A
	MOV A, DATA_1B10-$01+x
	MOV Y, A
	MOV A, DATA_1B10-$02+x
	MOVW $40, YA
	MOV $0C, #$02
CODE_13DF:
	MOV A, $1A
	EOR A, #$FF
	TSET $0046, A
	RET

CODE_13E7:
	MOV X, #$0E
	MOV $47, #$80
CODE_13EC:
	MOV A, #$FF
	MOV $0301+x, A
	MOV A, #$0A
	CALL CODE_15FF
	MOV $0211+x, A
	MOV $0381+x, A
	MOV $02F0+x, A
	MOV $0280+x, A
	MOV $03FF+x, A
	MOV $B1+x, A
	MOV $C1+x, A
	DEC X
	DEC X
	LSR $47
	BNE CODE_13EC
	MOV $5A, A
	MOV $68, A
	MOV $54, A
	MOV $50, A
	MOV $42, A
	MOV $5F, A
	MOV $59, #$C0
	MOV $53, #$20
CODE_1421:
	RET

CODE_1422:
	MOV A, $00
	BEQ CODE_1440
	MOV $04, A
	CMP A, #$F0
	BEQ CODE_13AD
	CMP A, #$F1
	BNE CODE_1433
	JMP CODE_138F

CODE_1433:
	SETC
	CMP A, #$07
	BCS CODE_13C9
	MOV Y, $03C6
	BEQ CODE_13C9
	JMP CODE_138F

CODE_1440:
	MOV A, $0D
	BEQ CODE_1421
	MOV A, $03CA
	BEQ CODE_144C
	JMP CODE_13A5

CODE_144C:
	MOV A, $0C
	BEQ CODE_14AD
	DBNZ $0C, CODE_13E7
CODE_1453:
	CALL CODE_13BB
	BNE CODE_147D
	MOV Y, A
	BNE CODE_145E
	JMP CODE_13AD

CODE_145E:
	CMP A, #$80
	BEQ CODE_1468
	CMP A, #$81
	BNE CODE_146C
	MOV A, #$00
CODE_1468:
	MOV $1B, A
	BRA CODE_1453

CODE_146C:
	DEC $42
	BPL CODE_1472
	MOV $42, A
CODE_1472:
	CALL CODE_13BB
	MOV X, $42
	BEQ CODE_1453
	MOVW $40, YA
	BRA CODE_1453

CODE_147D:
	MOVW $16, YA
	MOV Y, #$0F
CODE_1481:
	MOV A, ($16)+y
	MOV $0030+y, A
	DEC Y
	BPL CODE_1481
	MOV X, #$00
	MOV $47, #$01
CODE_148E:
	MOV A, $31+x
	BEQ CODE_149C
	MOV A, $0211+x
	BNE CODE_149C
	MOV A, #$00
	CALL CODE_15A6
CODE_149C:
	MOV A, #$00
	MOV $80+x, A
	MOV $90+x, A
	MOV $91+x, A
	INC A
	MOV $70+x, A
	INC X
	INC X
	ASL $47
	BNE CODE_148E
CODE_14AD:
	MOV X, #$00
	MOV $5E, X
	MOV $47, #$01
CODE_14B4:
	MOV $44, X
	MOV A, $31+x
	BEQ CODE_1534
	DEC $70+x
	BNE CODE_152A
CODE_14BE:
	CALL CODE_159C
	BNE CODE_14DA
	MOV A, $80+x
	BEQ CODE_1453
	CALL CODE_16F2
	DEC $80+x
	BNE CODE_14BE
	MOV A, $0230+x
	MOV $30+x, A
	MOV A, $0231+x
	MOV $31+x, A
	BRA CODE_14BE

CODE_14DA:
	BMI CODE_14FC
	MOV $0200+x, A
	CALL CODE_159C
	BMI CODE_14FC
	PUSH A
	XCN A
	AND A, #$07
	MOV Y, A
	MOV A, $3496+y
	MOV $0201+x, A
	POP A
	AND A, #$0F
	MOV Y, A
	MOV A, $349E+y
	MOV $0210+x, A
	CALL CODE_159C
CODE_14FC:
	CMP A, #$E0
	BCC CODE_1505
	CALL CODE_158A
	BRA CODE_14BE

CODE_1505:
	MOV A, $03FF+x
	OR A, $1B
	BNE CODE_1518
	MOV A, Y
	PUSH A
	MOV A, $47
	AND A, $1A
	POP A
	BNE CODE_1518
	CALL CODE_0906
CODE_1518:
	MOV A, $0200+x
	MOV $70+x, A
	MOV Y, A
	MOV A, $0201+x
	MUL YA
	MOV A, Y
	BNE CODE_1526
	INC A
CODE_1526:
	MOV $71+x, A
	BRA CODE_1531

CODE_152A:
	MOV A, $1B
	BNE CODE_1534
	CALL CODE_1920
CODE_1531:
	CALL CODE_17B5
CODE_1534:
	INC X
	INC X
	ASL $47
	BEQ CODE_153D
	JMP CODE_14B4

CODE_153D:
	MOV A, $54
	BEQ CODE_154C
	MOVW YA, $56
	ADDW YA, $52
	DBNZ $54, CODE_154A
	MOVW YA, $54
CODE_154A:
	MOVW $52, YA
CODE_154C:
	MOV A, $68
	BEQ CODE_1565
	MOVW YA, $64
	ADDW YA, $60
	MOVW $60, YA
	MOVW YA, $66
	ADDW YA, $62
	DBNZ $68, CODE_1563
	MOVW YA, $68
	MOVW $60, YA
	MOV Y, $6A
CODE_1563:
	MOVW $62, YA
CODE_1565:
	MOV A, $5A
	BEQ CODE_1577
	MOVW YA, $5C
	ADDW YA, $58
	DBNZ $5A, CODE_1572
	MOVW YA, $5A
CODE_1572:
	MOVW $58, YA
	MOV $5E, #$FF
CODE_1577:
	MOV X, #$00
	MOV $47, #$01
CODE_157C:
	MOV A, $31+x
	BEQ CODE_1583
	CALL CODE_1869
CODE_1583:
	INC X
	INC X
	ASL $47
	BNE CODE_157C
	RET

CODE_158A:
	ASL A
	MOV Y, A
	MOV A, DATA_1814-$BF+y
	PUSH A
	MOV A, DATA_1814-$C0+y
	PUSH A
	MOV A, Y
	LSR A
	MOV Y, A
	MOV A, DATA_184A-$60+y
	BEQ CODE_15A4
CODE_159C:
	MOV A, ($30+x)
CODE_159E:
	INC $30+x
	BNE CODE_15A4
	INC $31+x
CODE_15A4:
	MOV Y, A
	RET

CODE_15A6:
	MOV $0211+x, A
	MOV Y, A
	BPL CODE_15B2
	SETC
	SBC A, #$CA
	CLRC
	ADC A, $5F
CODE_15B2:
	MOV Y, #$06
	MUL YA
	MOVW $14, YA
	CLRC
	ADC $14, #$00
	ADC $15, #$34
	MOV A, $1A
	AND A, $47
	BNE CODE_15FE
	PUSH X
	MOV A, X
	XCN A
	LSR A
	OR A, #$04
	MOV X, A
	MOV Y, #$00
	MOV A, ($14)+y
	BPL CODE_15DF
	AND A, #$1F
	AND $48, #$20
	TSET $0048, A
	OR $49, $47
	MOV A, Y
	BRA CODE_15E6

CODE_15DF:
	MOV A, $47
	TCLR $0049, A
CODE_15E4:
	MOV A, ($14)+y
CODE_15E6:
	MOV $00F2, X
	MOV $00F3, A
	INC X
	INC Y
	CMP Y, #$04
	BNE CODE_15E4
	POP X
	MOV A, ($14)+y
	MOV $0221+x, A
	INC Y
	MOV A, ($14)+y
	MOV $0220+x, A
CODE_15FE:
	RET

CODE_15FF:
	MOV $0351+x, A
	AND A, #$1F
	MOV $0331+x, A
	MOV A, #$00
	MOV $0330+x, A
	RET

CODE_160D:
	MOV $91+x, A
	PUSH A
	CALL CODE_159C
	MOV $0350+x, A
	SETC
	SBC A, $0331+x
	POP X
	CALL CODE_17F8
	MOV $0340+x, A
	MOV A, Y
	MOV $0341+x, A
	RET

CODE_1626:
	MOV $02B0+x, A
	CALL CODE_159C
	MOV $02A1+x, A
	CALL CODE_159C
CODE_1632:
	MOV $B1+x, A
	MOV $02C1+x, A
	MOV A, #$00
	MOV $02B1+x, A
	RET

CODE_163D:
	MOV $02B1+x, A
	PUSH A
	MOV Y, #$00
	MOV A, $B1+x
	POP X
	DIV YA, X
	MOV X, $44
	MOV $02C0+x, A
	RET

CODE_164D:
	MOV A, $03CA
	BNE CODE_1656
	MOV A, #$00
	MOVW $58, YA
CODE_1656:
	RET

CODE_1657:
	MOV $5A, A
	CALL CODE_159C
	MOV $5B, A
	SETC
	SBC A, $59
	MOV X, $5A
	CALL CODE_17F8
	MOVW $5C, YA
	RET

CODE_1669:
	MOV A, #$00
	MOVW $52, YA
	RET

CODE_166E:
	MOV $54, A
	CALL CODE_159C
	MOV $55, A
	SETC
	SBC A, $53
	MOV X, $54
	CALL CODE_17F8
	MOVW $56, YA
	RET

CODE_1680:
	MOV $50, A
	RET

CODE_1683:
	MOV $02F0+x, A
	RET

CODE_1687:
	MOV $02E0+x, A
	CALL CODE_159C
	MOV $02D1+x, A
	CALL CODE_159C
CODE_1693:
	MOV $C1+x, A
	RET

CODE_1696:
	MOV A, #$01
	BRA CODE_169C

CODE_169A:
	MOV A, #$00
CODE_169C:
	MOV $0290+x, A
	MOV A, Y
	MOV $0281+x, A
	CALL CODE_159C
	MOV $0280+x, A
	CALL CODE_159C
	MOV $0291+x, A
	RET

CODE_16B0:
	MOV $0280+x, A
	RET

CODE_16B4:
	MOV $0301+x, A
	MOV A, #$00
	MOV $0300+x, A
	RET

CODE_16BD:
	MOV $90+x, A
	PUSH A
	CALL CODE_159C
	MOV $0320+x, A
	SETC
	SBC A, $0301+x
	POP X
	CALL CODE_17F8
	MOV $0310+x, A
	MOV A, Y
	MOV $0311+x, A
	RET

CODE_16D6:
	MOV $0381+x, A
	RET

CODE_16DA:
	MOV $0240+x, A
	CALL CODE_159C
	MOV $0241+x, A
	CALL CODE_159C
	MOV $80+x, A
	MOV A, $30+x
	MOV $0230+x, A
	MOV A, $31+x
	MOV $0231+x, A
CODE_16F2:
	MOV A, $0240+x
	MOV $30+x, A
	MOV A, $0241+x
	MOV $31+x, A
	RET

CODE_16FD:
	MOV $03C3, A
	MOV $4A, A
	CALL CODE_159C
	MOV A, #$00
	MOVW $60, YA
	CALL CODE_159C
	MOV A, #$00
	MOVW $62, YA
	CLR5 $48
	RET

CODE_1713:
	MOV $68, A
	CALL CODE_159C
	MOV $69, A
	SETC
	SBC A, $61
	MOV X, $68
	CALL CODE_17F8
	MOVW $64, YA
	CALL CODE_159C
	MOV $6A, A
	SETC
	SBC A, $63
	MOV X, $68
	CALL CODE_17F8
	MOVW $66, YA
	RET

CODE_1734:
	MOVW $60, YA
	MOVW $62, YA
	SET5 $48
	RET

CODE_173B:
	CALL CODE_175D
	CALL CODE_159C
	MOV $4E, A
	CALL CODE_159C
	MOV Y, #$08
	MUL YA
	MOV X, A
	MOV Y, #$0F
CODE_174C:
	MOV A, DATA_1AB5+x
	CALL CODE_09FB
	INC X
	MOV A, Y
	CLRC
	ADC A, #$10
	MOV Y, A
	BPL CODE_174C
	MOV X, $44
	RET

CODE_175D:
	MOV $4D, A
	MOV Y, #$7D
	MOV $00F2, Y
	MOV A, $00F3
	CMP A, $4D
	BEQ CODE_1796
	AND A, #$0F
	EOR A, #$FF
	BBC7 $4C, CODE_1775
	CLRC
	ADC A, $4C
CODE_1775:
	MOV $4C, A
	MOV Y, #$04
CODE_1779:
	MOV A, DATA_1AD4+y
	MOV $00F2, A
	MOV A, #$00
	MOV $00F3, A
	DBNZ Y, CODE_1779
	MOV A, $48
	OR A, #$20
	MOV Y, #$6C
	CALL CODE_09FB
	MOV A, $4D
	MOV Y, #$7D
	CALL CODE_09FB
CODE_1796:
	ASL A
	ASL A
	ASL A
	EOR A, #$FF
	SETC
	ADC A, #$D0
	MOV Y, #$6D
	JMP CODE_09FB

CODE_17A3:
	MOV $5F, A
	RET

CODE_17A6:
	CALL CODE_159E
	RET

CODE_17AA:
	INC A
	MOV $03FF+x, A
	RET

CODE_17AF:
	INC A
	MOV $1B, A
	JMP CODE_13DF

CODE_17B5:
	MOV A, $A0+x
	BNE CODE_17EC
	MOV A, ($30+x)
	CMP A, #$F9
	BNE CODE_17EC
	CALL CODE_159E
	CALL CODE_159C
CODE_17C5:
	MOV $A1+x, A
	CALL CODE_159C
	MOV $A0+x, A
	CALL CODE_159C
	CLRC
	ADC A, $50
	ADC A, $02F0+x
CODE_17D5:
	AND A, #$7F
	MOV $0380+x, A
	SETC
	SBC A, $0361+x
	MOV Y, $A0+x
	PUSH Y
	POP X
	CALL CODE_17F8
	MOV $0370+x, A
	MOV A, Y
	MOV $0371+x, A
CODE_17EC:
	RET

CODE_17ED:
	MOV A, $0361+x
	MOV $11, A
	MOV A, $0360+x
	MOV $10, A
	RET

CODE_17F8:
	NOTC
	ROR $12
	BPL CODE_1800
	EOR A, #$FF
	INC A
CODE_1800:
	MOV Y, #$00
	DIV YA, X
	PUSH A
	MOV A, #$00
	DIV YA, X
	POP Y
	MOV X, $44
CODE_180A:
	BBC7 $12, CODE_1813
	MOVW $14, YA
	MOVW YA, $0E
	SUBW YA, $14
CODE_1813:
	RET

DATA_1814:
	dw CODE_15A6
	dw CODE_15FF
	dw CODE_160D
	dw CODE_1626
	dw CODE_1632
	dw CODE_164D
	dw CODE_1657
	dw CODE_1669
	dw CODE_166E
	dw CODE_1680
	dw CODE_1683
	dw CODE_1687
	dw CODE_1693
	dw CODE_16B4
	dw CODE_16BD
	dw CODE_16DA
	dw CODE_163D
	dw CODE_1696
	dw CODE_169A
	dw CODE_16B0
	dw CODE_16D6
	dw CODE_16FD
	dw CODE_1734
	dw CODE_173B
	dw CODE_1713
	dw CODE_17C5
	dw CODE_17A3

DATA_184A:
	db $01,$01,$02,$03,$00,$01,$02,$01,$02,$01,$01,$03,$00,$01,$02,$03
	db $01,$03,$03,$00,$01,$03,$00,$03,$03,$03,$01,$02,$00,$00,$00

CODE_1869:
	MOV A, $90+x
	BEQ CODE_1876
	MOV A, #$00
	MOV Y, #$03
	DEC $90+x
	CALL CODE_18FC
CODE_1876:
	MOV Y, $C1+x
	BEQ CODE_189D
	MOV A, $02E0+x
	CBNE $C0+x, CODE_189B
	OR $5E, $47
	MOV A, $02D0+x
	BPL CODE_188F
	INC Y
	BNE CODE_188F
	MOV A, #$80
	BRA CODE_1893

CODE_188F:
	CLRC
	ADC A, $02D1+x
CODE_1893:
	MOV $02D0+x, A
	CALL CODE_1A83
	BRA CODE_18A2

CODE_189B:
	INC $C0+x
CODE_189D:
	MOV A, #$FF
	CALL CODE_1A8E
CODE_18A2:
	MOV A, $91+x
	BEQ CODE_18AF
	MOV A, #$30
	MOV Y, #$03
	DEC $91+x
	CALL CODE_18FC
CODE_18AF:
	MOV A, $47
	AND A, $5E
	BEQ CODE_18FB
	MOV A, $0331+x
	MOV Y, A
	MOV A, $0330+x
	MOVW $10, YA
CODE_18BE:
	MOV A, X
	XCN A
	LSR A
	MOV $12, A
CODE_18C3:
	MOV Y, $11
	MOV A, DATA_1AA0+$01+y
	SETC
	SBC A, DATA_1AA0+y
	MOV Y, $10
	MUL YA
	MOV A, Y
	MOV Y, $11
	CLRC
	ADC A, DATA_1AA0+y
	MOV Y, A
	MOV A, $0321+x
	MUL YA
	MOV A, $0351+x
	ASL A
	BBC0 $12, CODE_18E3
	ASL A
CODE_18E3:
	MOV A, Y
	BCC CODE_18E9
	EOR A, #$FF
	INC A
CODE_18E9:
	MOV Y, $12
	CALL CODE_09F3
	MOV Y, #$14
	MOV A, #$00
	SUBW YA, $10
	MOVW $10, YA
	INC $12
	BBC1 $12, CODE_18C3
CODE_18FB:
	RET

CODE_18FC:
	OR $5E, $47
CODE_18FF:
	MOVW $14, YA
	MOVW $16, YA
	PUSH X
	POP Y
	CLRC
	BNE CODE_1912
	ADC $16, #$1F
	MOV A, #$00
	MOV ($14)+y, A
	INC Y
	BRA CODE_191B

CODE_1912:
	ADC $16, #$10
	CALL CODE_1919
	INC Y
CODE_1919:
	MOV A, ($14)+y
CODE_191B:
	ADC A, ($16)+y
	MOV ($14)+y, A
	RET

CODE_1920:
	MOV A, $71+x
	BEQ CODE_1987
	DEC $71+x
	BEQ CODE_192D
	MOV A, #$02
	CBNE $70+x, CODE_1987
CODE_192D:
	MOV A, $80+x
	MOV $17, A
	MOV A, $30+x
	MOV Y, $31+x
CODE_1935:
	MOVW $14, YA
	MOV Y, #$00
CODE_1939:
	MOV A, ($14)+y
	BEQ CODE_1959
	BMI CODE_1944
CODE_193F:
	INC Y
	MOV A, ($14)+y
	BPL CODE_193F
CODE_1944:
	CMP A, #$C8
	BEQ CODE_1987
	CMP A, #$EF
	BEQ CODE_1975
	CMP A, #$E0
	BCC CODE_1980
	PUSH Y
	MOV Y, A
	POP A
	ADC A, DATA_184A-$E0+y
	MOV Y, A
	BRA CODE_1939

CODE_1959:
	MOV A, $17
	BEQ CODE_1980
	DEC $17
	BNE CODE_196B
	MOV A, $0231+x
	PUSH A
	MOV A, $0230+x
	POP Y
	BRA CODE_1935

CODE_196B:
	MOV A, $0241+x
	PUSH A
	MOV A, $0240+x
	POP Y
	BRA CODE_1935

CODE_1975:
	INC Y
	MOV A, ($14)+y
	PUSH A
	INC Y
	MOV A, ($14)+y
	MOV Y, A
	POP A
	BRA CODE_1935

CODE_1980:
	MOV A, $47
	MOV Y, #$5C
	CALL CODE_09F3
CODE_1987:
	CLR7 $13
	MOV A, $A0+x
	BEQ CODE_19A6
	MOV A, $A1+x
	BEQ CODE_1995
	DEC $A1+x
	BRA CODE_19A6

CODE_1995:
	MOV A, $1A
	AND A, $47
	BNE CODE_19A6
	SET7 $13
	MOV A, #$60
	MOV Y, #$03
	DEC $A0+x
	CALL CODE_18FF
CODE_19A6:
	CALL CODE_17ED
	MOV A, $B1+x
	BEQ CODE_19F9
	MOV A, $02B0+x
	CBNE $B0+x, CODE_19F7
	MOV A, $0100+x
	CMP A, $02B1+x
	BNE CODE_19C0
	MOV A, $02C1+x
	BRA CODE_19CD

CODE_19C0:
	SETP
	INC $00+x
	CLRP
	MOV Y, A
	BEQ CODE_19C9
	MOV A, $B1+x
CODE_19C9:
	CLRC
	ADC A, $02C0+x
CODE_19CD:
	MOV $B1+x, A
	MOV A, $02A0+x
	CLRC
	ADC A, $02A1+x
	MOV $02A0+x, A
CODE_19D9:
	MOV $12, A
	ASL A
	ASL A
	BCC CODE_19E1
	EOR A, #$FF
CODE_19E1:
	MOV Y, A
	MOV A, $B1+x
	CMP A, #$F1
	BCC CODE_19ED
	AND A, #$0F
	MUL YA
	BRA CODE_19F1

CODE_19ED:
	MUL YA
	MOV A, Y
	MOV Y, #$00
CODE_19F1:
	CALL CODE_1A6E
CODE_19F4:
	JMP CODE_0970

CODE_19F7:
	INC $B0+x
CODE_19F9:
	BBS7 $13, CODE_19F4
	RET

CODE_19FD:
	CLR7 $13
	MOV A, $C1+x
	BEQ CODE_1A0C
	MOV A, $02E0+x
	CBNE $C0+x, CODE_1A0C
	CALL CODE_1A76
CODE_1A0C:
	MOV A, $0331+x
	MOV Y, A
	MOV A, $0330+x
	MOVW $10, YA
	MOV A, $91+x
	BEQ CODE_1A23
	MOV A, $0341+x
	MOV Y, A
	MOV A, $0340+x
	CALL CODE_1A58
CODE_1A23:
	BBC7 $13, CODE_1A29
	CALL CODE_18BE
CODE_1A29:
	CLR7 $13
	CALL CODE_17ED
	MOV A, $A0+x
	BEQ CODE_1A40
	MOV A, $A1+x
	BNE CODE_1A40
	MOV A, $0371+x
	MOV Y, A
	MOV A, $0370+x
	CALL CODE_1A58
CODE_1A40:
	MOV A, $B1+x
	BEQ CODE_19F9
	MOV A, $02B0+x
	CBNE $B0+x, CODE_19F9
	MOV Y, $51
	MOV A, $02A1+x
	MUL YA
	MOV A, Y
	CLRC
	ADC A, $02A0+x
	JMP CODE_19D9

CODE_1A58:
	SET7 $13
	MOV $12, Y
	CALL CODE_180A
	PUSH Y
	MOV Y, $51
	MUL YA
	MOV $14, Y
	MOV $15, #$00
	MOV Y, $51
	POP A
	MUL YA
	ADDW YA, $14
CODE_1A6E:
	CALL CODE_180A
	ADDW YA, $10
	MOVW $10, YA
	RET

CODE_1A76:
	SET7 $13
	MOV Y, $51
	MOV A, $02D1+x
	MUL YA
	MOV A, Y
	CLRC
	ADC A, $02D0+x
CODE_1A83:
	ASL A
	BCC CODE_1A88
	EOR A, #$FF
CODE_1A88:
	MOV Y, $C1+x
	MUL YA
	MOV A, Y
	EOR A, #$FF
CODE_1A8E:
	MOV Y, $59
	MUL YA
	MOV A, $0210+x
	MUL YA
	MOV A, $0301+x
	MUL YA
	MOV A, Y
	MUL YA
	MOV A, Y
	MOV $0321+x, A
	RET

DATA_1AA0:
	db $00,$01,$03,$07,$0D,$15,$1E,$29,$34,$42,$51,$5E,$67,$6E,$73,$77
	db $7A,$7C,$7D,$7E,$7F

DATA_1AB5:
	db $7F,$00,$00,$00,$00,$00,$00,$00,$58,$BF,$DB,$F0,$FE,$07,$0C,$0C
	db $0C,$21,$2B,$2B,$13,$FE,$F3,$F9,$34,$33,$00,$D9,$E5,$01,$FC

DATA_1AD4:
	db $EB,$2C,$3C,$0D,$4D,$6C,$4C,$5C,$3D,$2D

DATA_1ADE:
	db $5C,$61,$63,$4E,$4A,$48,$45,$0E,$49,$4B,$46

DATA_1AE9:
	dw $085F,$08DE,$0965,$09F4,$0A8C,$0B2C,$0BD6,$0C8B
	dw $0D4A,$0E14,$0EEA,$0FCD,$10BE
%SPCDataBlockEnd(0800)

%SPCDataBlockStart(1B10)
DATA_1B10:
	incbin "SPC700/MusicData.bin"
%SPCDataBlockEnd(1B10)

%SPCDataBlockStart(D000)
DATA_D000:
	incbin "SPC700/UnknownSPCData.bin"
%SPCDataBlockEnd(D000)

%SPCDataBlockStart(3500)
DATA_3500:
	dw DATA_3600	:	dw DATA_3600+$001B
	dw DATA_3636	:	dw DATA_3636+$0465
	dw DATA_3A9B	:	dw DATA_3A9B+$001B
	dw DATA_3AD1	:	dw DATA_3AD1+$001B
	dw DATA_3B07	:	dw DATA_3B07+$0A68
	dw DATA_458A	:	dw DATA_458A+$0201
	dw DATA_47EE	:	dw DATA_47EE+$0291
	dw DATA_4CF5	:	dw DATA_4CF5+$0D2F
	dw DATA_5A24	:	dw DATA_5A24+$022E
	dw DATA_5E6E	:	dw DATA_5E6E+$003F
	dw DATA_5ED1	:	dw DATA_5ED1+$0384
	dw DATA_65D9	:	dw DATA_65D9+$21D2
	dw DATA_87AB	:	dw DATA_87AB+$01C2
	dw DATA_8988	:	dw DATA_8988+$003F
	dw DATA_8A06	:	dw DATA_8A06+$001B
	dw DATA_8A3C	:	dw DATA_8A3C+$0735
	dw DATA_91B0	:	dw DATA_91B0+$07F2
	dw DATA_99E1	:	dw DATA_99E1+$057C
	dw DATA_9F5D	:	dw DATA_9F5D+$02B5
	dw DATA_A263	:	dw DATA_A263+$0036
	dw DATA_A2B4	:	dw DATA_A2B4+$0522
	dw DATA_A7F1	:	dw DATA_A7F1+$0099
	dw DATA_A91A	:	dw DATA_A91A+$08CA
	dw DATA_B1E4	:	dw DATA_B1E4+$0426
	dw DATA_B60A	:	dw DATA_B60A+$09A2
	dw $FFFF	:	dw $FFFF
	dw $FFFF	:	dw $FFFF
	dw $FFFF	:	dw $FFFF
%SPCDataBlockEnd(3500)

%SPCDataBlockStart(3600)
DATA_3600:
	incbin "Samples/00.brr"

DATA_3636:
	incbin "Samples/01.brr"

DATA_3A9B:
	incbin "Samples/02.brr"

DATA_3AD1:
	incbin "Samples/03.brr"

DATA_3B07:
	incbin "Samples/04.brr"

DATA_458A:
	incbin "Samples/05.brr"

DATA_47EE:
	incbin "Samples/06.brr"

DATA_4CF5:
	incbin "Samples/07.brr"

DATA_5A24:
	incbin "Samples/08.brr"

DATA_5E6E:
	incbin "Samples/09.brr"

DATA_5ED1:
	incbin "Samples/0A.brr"

DATA_65D9:
	incbin "Samples/0B.brr"

DATA_87AB:
	incbin "Samples/0C.brr"

DATA_8988:
	incbin "Samples/0D.brr"

DATA_8A06:
	incbin "Samples/0E.brr"

DATA_8A3C:
	incbin "Samples/0F.brr"

DATA_91B0:
	incbin "Samples/10.brr"

DATA_99E1:
	incbin "Samples/11.brr"

DATA_9F5D:
	incbin "Samples/12.brr"

DATA_A263:
	incbin "Samples/13.brr"

DATA_A2B4:
	incbin "Samples/14.brr"

DATA_A7F1:
	incbin "Samples/15.brr"

DATA_A91A:
	incbin "Samples/16.brr"

DATA_B1E4:
	incbin "Samples/17.brr"

DATA_B60A:
	incbin "Samples/18.brr"
%SPCDataBlockEnd(3600)

%EndSPCUploadAndJumpToEngine($0800)
