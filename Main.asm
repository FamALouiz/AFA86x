; Title: AES 8086
; Author: AFA86x
; Date: 18/5/2024

org 100h

; Define constants, variables, and data sections
segment .data
    ; Define your data variables here
    ROWS EQU 4
    COLS EQU 4
    key DB ROWS * COLS DUP(?)

; Define code section
segment .code

; -------------------- MACROS --------------------

; MACRO: shiftRows
; DESCRIPTION: Shifts the rows of the key matrix to the left by the specified number of positions
shiftRows MACRO

ENDM

shiftRowsHelper MACRO row, shiftAmount
    MOV CX, shiftAmount - 1
    PUSH_LOOP_START: 
        PUSH key[row][CX]
        LOOP PUSH_LOOP_START

    MOV CX, shiftAmount
    POP_LOOP_START: 
        POP key[row][4 - CX]
        LOOP POP_LOOP_START
ENDM