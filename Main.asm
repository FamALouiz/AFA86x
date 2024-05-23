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

    SBox DB 63h, 7Ch, 77h, 7Bh, F2h, 6Bh, 6Fh, C5h, 30h, 01h, 67h, 2Bh, FEh, D7h, ABh, 76h
          DB CAh, 82h, C9h, 7Dh, FAh, 59h, 47h, F0h, ADh, D4h, A2h, AFh, 9Ch, A4h, 72h, C0h
          DB B7h, FDh, 93h, 26h, 36h, 3Fh, F7h, CCh, 34h, A5h, E5h, F1h, 71h, D8h, 31h, 15h
          DB 04h, C7h, 23h, C3h, 18h, 96h, 05h, 9Ah, 07h, 12h, 80h, E2h, EBh, 27h, B2h, 75h
          DB 09h, 83h, 2Ch, 1Ah, 1Bh, 6Eh, 5Ah, A0h, 52h, 3Bh, D6h, B3h, 29h, E3h, 2Fh, 84h
          DB 53h, D1h, 00h, EDh, 20h, FCh, B1h, 5Bh, 6Ah, CBh, BEh, 39h, 4Ah, 4Ch, 58h, CFh
          DB D0h, EFh, AAh, FBh, 43h, 4Dh, 33h, 85h, 45h, F9h, 02h, 7Fh, 50h, 3Ch, 9Fh, A8h
          DB 51h, A3h, 40h, 8Fh, 92h, 9Dh, 38h, F5h, BCh, B6h, DAh, 21h, 10h, F3h, D2h, CDh
          DB 0Ch, 13h, ECh, 5Fh, 97h, 44h, 17h, C4h, A7h, 7Eh, 3Dh, 64h, 5Dh, 19h, 73h, 60h
          DB 81h, 4Fh, DCh, 22h, 2Ah, 90h, 88h, 46h, EEh, Bh, 14h, DEh, 5Eh, 0Bh, DBh, E0h
          DB 32h, 3Ah, 0Ah, 49h, 06h, 24h, 5Ch, C2h, D3h, ACh, 62h, 91h, 95h, E4h, 79h, E7h
          DB C8h, 37h, 6Dh, 8Dh, D5h, 4Eh, A9h, 6Ch, 56h, F4h, EAh, 65h, 7Ah, AEh, 08h, BAh
          DB 78h, 25h, 2Eh, 1Ch, A6h, B4h, C6h, E8h, DDh, 74h, 1Fh, 4Bh, BDh, 8Bh, 8Ah, 70h
          DB 3Eh, B5h, 66h, 48h, 03h, F6h, 0Eh, 61h, 35h, 57h, B9h, 86h, C1h, 1Dh, 9Eh, E1h
          DB F8h, 98h, 11h, 69h, D9h, 8Eh, 94h, 9Bh, 1Eh, 87h, E9h, CEh, 55h, 28h, DFr, 8Ch
          DB A1h, 89h, 0Dh, BFh, E6h, 42h, 68h, 41h, 99h, 2Dh, 0Fh, B0h, 54h, BBh, 16h
    ResultMatrix DB 16 DUP (?)
    include SubBytesMacros.inc

; Define code section
.code segment
    subByte
    shiftRows
    addRoundKey