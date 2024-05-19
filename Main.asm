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

    ; Row 0 is not shifted
    shiftRowsHelper 1, 1 ; Shift row 1 by 1 position
    shiftRowsHelper 2, 2 ; Shift row 2 by 2 positions
    shiftRowsHelper 3, 3 ; Shift row 3 by 3 positions
ENDM

shiftRowsHelper MACRO row, shiftAmount
    

    MOV CX, shiftAmount - 1
    PUSH_LOOP_START:     ; Push the elements of the row to the stack
        PUSH key[row][CX]
        LOOP PUSH_LOOP_START
    
    MOV DX, shiftAmount ; Use DX since CX will be used in the next loop
    SHIFT_LOOP_START: 
        shiftElementsToTheRight row
        SUB DX, 1
        JNE SHIFT_LOOP_START

    MOV CX, shiftAmount
    POP_LOOP_START: ; Pop the elements from the stack to the row
        POP key[row][4 - CX]
        LOOP POP_LOOP_START
ENDM


shiftElementsToTheRight MACRO row
    MOV CX, 0
    SWAP_ITEMS_LOOP: ; Shifts elements to the right
        XCHG key[row][CX], key[row][CX + 1]
        ADD CX, 1
        CMP CX, 4
        JNE SWAP_ITEMS_LOOP
ENDM