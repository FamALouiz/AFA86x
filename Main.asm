; Title: AES 8086
; Author: AFA86x
; Date: 18/5/2024

org 100h

; Define constants, variables, and data sections
.data segment
    ; Define your data variables here
    ROWS EQU 4
    COLS EQU 4  ;0  1  2  3  4  5  6  7  8  9   10  11  12  13  14  15
    keyMatrix DB 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16
    roundKey DB 0a3h, 012h, 0bdh, 0c2h, 045h, 06fh, 08ah, 07fh, 037h, 076h, 03bh, 09fh, 01fh, 01bh, 06bh, 014h ; Random round key
    include ShiftRowsMacros.inc
    include MixColoums.inc
    include AddRoundKeyMacros.inc

    SBox  DB 063h, 07Ch, 077h, 07Bh, 0F2h, 06Bh, 06Fh, 0C5h, 030h, 001h, 067h, 02Bh, 0FEh, 0D7h, 0ABh, 076h
          DB 0CAh, 082h, 0C9h, 07Dh, 0FAh, 059h, 047h, 0F0h, 0ADh, 0D4h, 0A2h, 0AFh, 09Ch, 0A4h, 072h, 0C0h
          DB 0B7h, 0FDh, 093h, 026h, 036h, 03Fh, 0F7h, 0CCh, 034h, 0A5h, 0E5h, 0F1h, 071h, 0D8h, 031h, 015h
          DB 004h, 0C7h, 023h, 0C3h, 018h, 096h, 005h, 09Ah, 007h, 012h, 080h, 0E2h, 0EBh, 027h, 0B2h, 075h
          DB 009h, 083h, 02Ch, 01Ah, 01Bh, 06Eh, 05Ah, 0A0h, 052h, 03Bh, 0D6h, 0B3h, 029h, 0E3h, 02Fh, 084h
          DB 053h, 0D1h, 000h, 0EDh, 020h, 0FCh, 0B1h, 05Bh, 06Ah, 0CBh, 0BEh, 039h, 04Ah, 04Ch, 058h, 0CFh
          DB 0D0h, 0EFh, 0AAh, 0FBh, 043h, 04Dh, 033h, 085h, 045h, 0F9h, 002h, 07Fh, 050h, 03Ch, 09Fh, 0A8h
          DB 051h, 0A3h, 040h, 08Fh, 092h, 09Dh, 038h, 0F5h, 0BCh, 0B6h, 0DAh, 021h, 010h, 0F3h, 0D2h, 0CDh
          DB 00Ch, 013h, 0ECh, 05Fh, 097h, 044h, 017h, 0C4h, 0A7h, 07Eh, 03Dh, 064h, 05Dh, 019h, 073h, 060h
          DB 081h, 04Fh, 0DCh, 022h, 02Ah, 090h, 088h, 046h, 0EEh, 0B8h, 014h, 0DEh, 05Eh, 00Bh, 0DBh, 0E0h
          DB 032h, 03Ah, 00Ah, 049h, 006h, 024h, 05Ch, 0C2h, 0D3h, 0ACh, 062h, 091h, 095h, 0E4h, 079h, 0E7h
          DB 0C8h, 037h, 06Dh, 08Dh, 0D5h, 04Eh, 0A9h, 06Ch, 056h, 0F4h, 0EAh, 065h, 07Ah, 0AEh, 008h, 0BAh
          DB 078h, 025h, 02Eh, 01Ch, 0A6h, 0B4h, 0C6h, 0E8h, 0DDh, 074h, 01Fh, 04Bh, 0BDh, 08Bh, 08Ah, 070h
          DB 03Eh, 0B5h, 066h, 048h, 003h, 0F6h, 00Eh, 061h, 035h, 057h, 0B9h, 086h, 0C1h, 01Dh, 09Eh, 0E1h
          DB 0F8h, 098h, 011h, 069h, 0D9h, 08Eh, 094h, 09Bh, 01Eh, 087h, 0E9h, 0CEh, 055h, 028h, 0DFh, 08Ch
          DB 0A1h, 089h, 00Dh, 0BFh, 0E6h, 042h, 068h, 041h, 099h, 02Dh, 00Fh, 0B0h, 054h, 0BBh, 016h
    ResultMatrix DB 16 DUP(?)
    include SubBytesMacros.inc

; Define code sectionx
.code segment
    subByte
    ;shiftRows
    ;addRoundKey