@echo off

set PATH="../../Global"
set Input1=
set ROMName=SIMC.sfc
set MemMap=lorom

setlocal EnableDelayedExpansion

echo To fully extract all files for supported ROMs, you'll need one of the following ROMs in each group:
echo - Graphics: (USA)
echo - Tilemaps: (USA)
echo - Palettes (USA)
echo - Samples: (USA)
echo - Music: (USA)
echo.

:Start
echo Place a headerless SIMC ROM named %ROMName% in this folder, then type the number representing what version %ROMName% is.
echo 0 = SIMC USA
echo 1 = SIMC PAL
echo 2 = SIMC Japan
echo 3 = SIMC French
echo 4 = SIMC German

:Mode
set /p Input1=""
if exist %ROMName% goto :ROMExists

echo You need to place a SIMC ROM named %ROMName% in this folder before you can extract any assets^^!
goto :Mode

:ROMExists
if "%Input1%" equ "0" goto :USA
if "%Input1%" equ "1" goto :PAL
if "%Input1%" equ "2" goto :Japan
if "%Input1%" equ "3" goto :French
if "%Input1%" equ "4" goto :German

echo %Input1% is not a valid mode.
goto :Mode

:USA
set GFXLoc="../Graphics"
set TilemapLoc="../Tilemaps"
set PaletteLoc="../Palettes"
set MapLoc="../PremadeMaps"
set CompressedSPCDatLoc="../SPC700"
set MusicLoc="../SPC700"
set UnknownSPCDataLoc="../SPC700"
set BrrLoc="../SPC700/Samples"
set ROMBit=$0001
goto :BeginExtract

:PAL
echo The PAL ROM is not supported by the disassembly
goto :BeginExtract

set GFXLoc="../Graphics"
set TilemapLoc="../Tilemaps"
set PaletteLoc="../Palettes"
set MapLoc="../PremadeMaps"
set CompressedSPCDatLoc="../SPC700"
set MusicLoc="../SPC700"
set UnknownSPCDataLoc="../SPC700"
set BrrLoc="../SPC700/Samples"
set ROMBit=$0002
goto :BeginExtract

:Japan
echo The Japanese ROM is not supported by the disassembly
goto :BeginExtract

set GFXLoc="../Graphics"
set TilemapLoc="../Tilemaps"
set PaletteLoc="../Palettes"
set MapLoc="../PremadeMaps"
set CompressedSPCDatLoc="../SPC700"
set MusicLoc="../SPC700"
set UnknownSPCDataLoc="../SPC700"
set BrrLoc="../SPC700/Samples"
set ROMBit=$0004
goto :BeginExtract

:French
echo The French ROM is not supported by the disassembly
goto :BeginExtract

set GFXLoc="../Graphics"
set TilemapLoc="../Tilemaps"
set PaletteLoc="../Palettes"
set MapLoc="../PremadeMaps"
set CompressedSPCDatLoc="../SPC700"
set MusicLoc="../SPC700"
set UnknownSPCDataLoc="../SPC700"
set BrrLoc="../SPC700/Samples"
set ROMBit=$0008
goto :BeginExtract

:German
echo The German ROM is not supported by the disassembly
goto :BeginExtract

set GFXLoc="../Graphics"
set TilemapLoc="../Tilemaps"
set PaletteLoc="../Palettes"
set MapLoc="../PremadeMaps"
set CompressedSPCDatLoc="../SPC700"
set MusicLoc="../SPC700"
set UnknownSPCDataLoc="../SPC700"
set BrrLoc="../SPC700/Samples"
set ROMBit=$0010
goto :BeginExtract

:BeginExtract
set i=0
set PointerSet=0

echo Generating temporary ROM
asar --fix-checksum=off --no-title-check --define ROMVer="%ROMBit%" "AssetPointersAndFiles.asm" TEMP.sfc

CALL :GetLoopIndex
set MaxFileTypes=%Length%
set PointerSet=6

:GetNewLoopIndex
CALL :GetLoopIndex

:ExtractLoop
if %i% equ %Length% goto :NewFileType

CALL :GetGFXFileName
CALL :ExtractFile
set /a i = %i%+1
if exist TEMP1.asm del TEMP1.asm
if exist TEMP2.asm del TEMP2.asm
if exist TEMP3.txt del TEMP3.txt
goto :ExtractLoop

:NewFileType
echo Moving extracted files to appropriate locations
if %PointerSet% equ 6 goto :MoveGFX
if %PointerSet% equ 12 goto :MoveTilemaps
if %PointerSet% equ 18 goto :MovePalettes
if %PointerSet% equ 24 goto :MoveMaps
if %PointerSet% equ 30 goto :DecompressSPCData
if %PointerSet% equ 36 goto :MoveMusic
if %PointerSet% equ 42 goto :MoveUnknownSPCData
if %PointerSet% equ 48 goto :MoveBRR
goto :MoveNothing

:MoveGFX
CALL :MergeSplitGFX
move "*.bin" %GFXLoc%
move "*.lz5" %GFXLoc%
goto :MoveNothing

:MoveTilemaps
move "*.bin" %TilemapLoc%
move "*.lz5" %TilemapLoc%
goto :MoveNothing

:MovePalettes
move "*.bin" %PaletteLoc%
move "*.lz5" %PaletteLoc%
goto :MoveNothing

:MoveMaps
move "*.lz5" %MapLoc%
goto :MoveNothing

:DecompressSPCData
CALL :RunLC
move "*.lz5" %CompressedSPCDatLoc%
goto :MoveNothing

:MoveMusic
move "*.bin" %MusicLoc%
goto :MoveNothing

:MoveUnknownSPCData
move "*.bin" %UnknownSPCDataLoc%
goto :MoveNothing

:MoveBRR
move "*.brr" %BrrLoc%
goto :MoveNothing

:MoveNothing
set i=0
set /a PointerSet = %PointerSet%+6
if %PointerSet% neq %MaxFileTypes% goto :GetNewLoopIndex
if exist TEMP.sfc del TEMP.sfc
if exist DecompressedSPCBlock1.cbin del DecompressedSPCBlock1.cbin
if exist DecompressedSPCBlock2.cbin del DecompressedSPCBlock2.cbin
set ROMName=%OldROMName%

echo Done^^!
goto :Start

EXIT /B %ERRORLEVEL% 

:ExtractFile
echo:%MemMap% >> TEMP1.asm
echo:org $008000 >> TEMP1.asm
echo:check bankcross off >> TEMP1.asm
echo:^^!OffsetStart #= snestopc(readfile3("TEMP.sfc", snestopc(readfile3("TEMP.sfc", snestopc($008000+%PointerSet%))+$00+(%i%*$0C)))) >> TEMP1.asm
echo:^^!OffsetEnd #= snestopc(readfile3("TEMP.sfc", snestopc(readfile3("TEMP.sfc", snestopc($008000+%PointerSet%))+$03+(%i%*$0C)))) >> TEMP1.asm
echo:incbin %ROMName%:(^^!OffsetStart)-(^^!OffsetEnd) >> TEMP1.asm

echo Extracting %FileName%
asar --fix-checksum=off --no-title-check "TEMP1.asm" %FileName%
EXIT /B 0

:GetGFXFileName
echo:%MemMap% >> TEMP2.asm
echo:org $008000 >> TEMP2.asm
echo:^^!FileNameStart #= snestopc(readfile3("TEMP.sfc", snestopc(readfile3("TEMP.sfc", snestopc($008000+%PointerSet%))+$06+(%i%*$0C)))) >> TEMP2.asm
echo:^^!FileNameEnd #= snestopc(readfile3("TEMP.sfc", snestopc(readfile3("TEMP.sfc", snestopc($008000+%PointerSet%))+$09+(%i%*$0C)))) >> TEMP2.asm
echo:incbin TEMP.sfc:(^^!FileNameStart)-(^^!FileNameEnd) >> TEMP2.asm
asar --fix-checksum=off --no-title-check "TEMP2.asm" TEMP3.txt

for /f "delims=" %%x in (TEMP3.txt) do set FileName=%%x

EXIT /B 0

:GetLoopIndex
echo:%MemMap% >> TEMP4.asm
echo:org $008000 >> TEMP4.asm
echo:^^!OnesDigit = 0 >> TEMP4.asm
echo:^^!TensDigit = 0 >> TEMP4.asm
echo:^^!HundredsDigit = 0 >> TEMP4.asm
echo:^^!ThousandsDigit = 0 >> TEMP4.asm
echo:^^!TensDigitSet = 0 >> TEMP4.asm
echo:^^!HundredsDigitSet = 0 >> TEMP4.asm
echo:^^!ThousandsDigitSet = 0 >> TEMP4.asm
echo:^^!Offset #= readfile3("TEMP.sfc", snestopc($008000+%PointerSet%+$03)) >> TEMP4.asm
echo:while ^^!Offset ^> 0 >> TEMP4.asm
::echo:print hex(^^!Offset) >> TEMP4.asm
echo:^^!OnesDigit #= ^^!OnesDigit+1 >> TEMP4.asm
echo:if ^^!OnesDigit == 10 >> TEMP4.asm
echo:^^!OnesDigit #= 0 >> TEMP4.asm
echo:^^!TensDigit #= ^^!TensDigit+1 >> TEMP4.asm
echo:^^!TensDigitSet #= 1 >> TEMP4.asm
echo:endif >> TEMP4.asm
echo:if ^^!TensDigit == 10 >> TEMP4.asm
echo:^^!TensDigit #= 0 >> TEMP4.asm
echo:^^!HundredsDigit #= ^^!HundredsDigit+1 >> TEMP4.asm
echo:^^!HundredsDigitSet #= 1 >> TEMP4.asm
echo:endif >> TEMP4.asm
echo:if ^^!HundredsDigit == 10 >> TEMP4.asm
echo:^^!HundredsDigit #= 0 >> TEMP4.asm
echo:^^!ThousandsDigit #= ^^!ThousandsDigit+1 >> TEMP4.asm
echo:^^!ThousandsDigitSet #= 1 >> TEMP4.asm
echo:endif >> TEMP4.asm
echo:^^!Offset #= ^^!Offset-1 >> TEMP4.asm
echo:endif >> TEMP4.asm
echo:if ^^!ThousandsDigitSet == 1 >> TEMP4.asm
echo:db ^^!ThousandsDigit+$30 >> TEMP4.asm
echo:endif >> TEMP4.asm
echo:if ^^!HundredsDigitSet == 1 >> TEMP4.asm
echo:db ^^!HundredsDigit+$30 >> TEMP4.asm
echo:endif >> TEMP4.asm
echo:if ^^!TensDigitSet == 1 >> TEMP4.asm
echo:db ^^!TensDigit+$30 >> TEMP4.asm
echo:endif >> TEMP4.asm
echo:db ^^!OnesDigit+$30 >> TEMP4.asm
asar --fix-checksum=off --no-title-check "TEMP4.asm" TEMP5.txt

for /f "delims=" %%x in (TEMP5.txt) do set Length=%%x

if exist TEMP4.asm del TEMP4.asm
if exist TEMP5.txt del TEMP5.txt

EXIT /B 0

:MergeSplitGFX
if not exist "GFX_Sprite_Tornado.bin" goto :NoSplitGFX1
if not exist "GFX_Sprite_Tornado_01.bin" goto :NoSplitGFX1
echo:Merging GFX_Sprite_Tornado files

echo:%MemMap% >> TEMP1.asm
echo:^^!Offset #= filesize("GFX_Sprite_Tornado.bin") >> TEMP1.asm
echo:org $008000+^^!Offset >> TEMP1.asm
echo:incbin GFX_Sprite_Tornado_01.bin >> TEMP1.asm
asar --fix-checksum=off --no-title-check "TEMP1.asm" "GFX_Sprite_Tornado.bin"

if exist TEMP1.asm del TEMP1.asm
if exist GFX_Sprite_Tornado_01.bin del GFX_Sprite_Tornado_01.bin
:NoSplitGFX1

if not exist "GFX_Sprite_Boat.bin" goto :NoSplitGFX2
if not exist "GFX_Sprite_Boat_01.bin" goto :NoSplitGFX2
echo:Merging GFX_Sprite_Boat files

echo:%MemMap% >> TEMP1.asm
echo:^^!Offset #= filesize("GFX_Sprite_Boat.bin") >> TEMP1.asm
echo:org $008000+^^!Offset >> TEMP1.asm
echo:incbin GFX_Sprite_Boat_01.bin >> TEMP1.asm
asar --fix-checksum=off --no-title-check "TEMP1.asm" "GFX_Sprite_Boat.bin"

if exist TEMP1.asm del TEMP1.asm
if exist GFX_Sprite_Boat_01.bin del GFX_Sprite_Boat_01.bin
:NoSplitGFX2

if not exist "GFX_Sprite_Airplane.bin" goto :NoSplitGFX3
if not exist "GFX_Sprite_Airplane_01.bin" goto :NoSplitGFX3
echo:Merging GFX_Sprite_Airplane files

echo:%MemMap% >> TEMP1.asm
echo:^^!Offset #= filesize("GFX_Sprite_Airplane.bin") >> TEMP1.asm
echo:org $008000+^^!Offset >> TEMP1.asm
echo:incbin GFX_Sprite_Airplane_01.bin >> TEMP1.asm
asar --fix-checksum=off --no-title-check "TEMP1.asm" "GFX_Sprite_Airplane.bin"

if exist TEMP1.asm del TEMP1.asm
if exist GFX_Sprite_Airplane_01.bin del GFX_Sprite_Airplane_01.bin
:NoSplitGFX3

if not exist "GFX_Sprite_Train.bin" goto :NoSplitGFX4
if not exist "GFX_Sprite_Train_01.bin" goto :NoSplitGFX4
echo:Merging GFX_Sprite_Train files

echo:%MemMap% >> TEMP1.asm
echo:^^!Offset #= filesize("GFX_Sprite_Train.bin") >> TEMP1.asm
echo:org $008000+^^!Offset >> TEMP1.asm
echo:incbin GFX_Sprite_Train_01.bin >> TEMP1.asm
asar --fix-checksum=off --no-title-check "TEMP1.asm" "GFX_Sprite_Train.bin"

if exist TEMP1.asm del TEMP1.asm
if exist GFX_Sprite_Train_01.bin del GFX_Sprite_Train_01.bin
:NoSplitGFX4

EXIT /B 0

:RunLC
decomp "CompressedSPCBlock1.lz5" "DecompressedSPCBlock1.cbin" 0 4 0
decomp "CompressedSPCBlock2.lz5" "DecompressedSPCBlock2.cbin" 0 4 0

echo:norom >> TEMP1.asm
echo:^^!Offset #= filesize("DecompressedSPCBlock1.cbin") >> TEMP1.asm
echo:check bankcross off >> TEMP1.asm
echo:org $000000+^^!Offset >> TEMP1.asm
echo:incbin DecompressedSPCBlock2.cbin >> TEMP1.asm
asar --fix-checksum=off --no-title-check "TEMP1.asm" "DecompressedSPCBlock1.cbin"

if exist TEMP1.asm del TEMP1.asm

set OldROMName=%ROMName%
set ROMName=DecompressedSPCBlock1.cbin

EXIT /B 0
