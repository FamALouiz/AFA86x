
org 100h

.data SEGMENT 
    ROWS EQU 4
    COLS EQU 4
    key DB ROWS * COLS DUP(?)

.code SEGMENT 

; -------------------- MACROS --------------------

; MACRO: shiftRows
; DESCRIPTION: Shifts the rows of the key matrix to the left by the specified number of positions
shiftRows MACRO

ENDM

shiftRowsHelper MACRO row, shiftAmount
    MOV CX, shiftAmount
    Loop: 
        PUSH key[row][CX]
        LOOP Loop

ENDM
    
