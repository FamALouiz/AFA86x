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
    include ShiftRowsMacros.inc

; Define code section
.code segment 
    shiftRows