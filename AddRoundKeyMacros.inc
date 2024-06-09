; -------------------- MACROS --------------------

addRoundKey MACRO

    PUSHA ; Save all registers
    PUSHF ; Save flags
    MOV DX, 0

    ADD_ROUND_KEY_LOOP_ROWS:
        MOV BL, DL  ; Gets the row slot
        MOV AX, 4
        MUL BL
        MOV BX, AX

        addRoundKeyInnerLoop BX
        INC DX
        CMP DX, 4
        JNE ADD_ROUND_KEY_LOOP_ROWS

    POPF ; Restore flags
    POPA ; Restore all registers

ENDM

addRoundKeyInnerLoop MACRO row

    PUSHA ; Save all registers
    PUSHF ; Save flags

    MOV DI, 0
    INNER_XOR_LOOP:  
        MOV AL, keyMatrix[row][DI]
        XOR AL, roundKey[row][DI]
        MOV keyMatrix[row][DI], AL  
        INC DI
        CMP DI, 4
        JNE INNER_XOR_LOOP

    POPF ; Restore flags
    POPA ; Restore all registers

ENDM