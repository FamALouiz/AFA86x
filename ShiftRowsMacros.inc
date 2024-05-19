; -------------------- MACROS --------------------

; MACRO: shiftRows
; DESCRIPTION: Shifts the rows of the keyMatrix matrix to the left by the specified number of positions
shiftRows MACRO

    MOV BX, 1
    ; Row 0 is not shifted
    LOOP_ROWS:
        shiftRowsHelper BX, BX
        ADD BX, 1
        CMP BX, 4
        JNE LOOP_ROWS

ENDM

shiftRowsHelper MACRO row, shiftAmount
    
    PUSHA ; Save all registers
    MOV CX, shiftAmount
    MOV AX, 4 ; Number of elements in a 4x4 matrix row
    MUL row 
    MOV row, AX
    SHIFT_LOOP:
        SUB CX, 1 
        shiftElementsToTheRight row
        CMP CX, 0
        JNE SHIFT_LOOP

    POPA ; Restore all registers
ENDM


shiftElementsToTheRight MACRO row

    PUSHA ; Save all registers

    MOV DI, 0
    SWAP_ITEMS_LOOP: ; Shifts elements to the right
    
        ; Swaps the consecutive numbers
        MOV AL, keyMatrix[row][DI]
        MOV DL, keyMatrix[row][DI + 1]
        MOV keyMatrix[row][DI], DL
        MOV keyMatrix[row][DI + 1], AL
        ADD DI, 1
        CMP DI, 3
        JNE SWAP_ITEMS_LOOP

    POPA ; Restore all registers
ENDM
