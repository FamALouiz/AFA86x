keySchedule MACRO 
    RotWord
    SubMiniBytes
    RconXOR
    ContinueXOR 1
    ContinueXOR 2 
    ContinueXOR 3
    MoveKeySchedule
ENDM

RotWord Macro
    PUSHA
    PUSHF

    MOV DI, 3
    MOV SI, 12
    MOV AL, roundKey[DI]
    MOV tempRoundKey[SI], AL

    MOV DI, 7
    MOV SI, 0
    MOV AL, roundKey[DI]
    MOV tempRoundKey[SI], AL

    MOV DI, 11
    MOV SI, 4
    MOV AL, roundKey[DI]
    MOV tempRoundKey[SI], AL

    MOV DI, 15
    MOV SI, 8
    MOV AL, roundKey[DI]
    MOV tempRoundKey[SI], AL

    POPF
    POPA
ENDM

SubMiniBytes MACRO 

    PUSHA
    PUSHF

    MOV DI, 0
    MOV BL, tempRoundKey[DI]
    MOV BH, 0
    MOV AL, SBOX[BX]
    MOV tempRoundKey[DI], AL

    MOV DI, 4
    MOV BL, tempRoundKey[DI]
    MOV BH, 0
    MOV AL, SBOX[BX]
    MOV tempRoundKey[DI], AL
    
    MOV DI, 8
    MOV BL, tempRoundKey[DI]
    MOV BH, 0
    MOV AL, SBOX[BX]
    MOV tempRoundKey[DI], AL

    MOV DI, 12
    MOV BL, tempRoundKey[DI]
    MOV BH, 0
    MOV AL, SBOX[BX]
    MOV tempRoundKey[DI], AL

    POPF
    POPA

ENDM

RconXOR MACRO 

    PUSHA 
    PUSHF

    MOV DI, 0
    MOV AL, roundKey[DI]
    XOR tempRoundKey[DI], AL
    MOV SI, 0 + RconCounter
    INC RconCounter
    MOV AL, Rcon[SI]
    XOR tempRoundKey[DI], AL

    MOV DI, 4
    MOV AL, roundKey[DI]
    XOR tempRoundKey[DI], AL

    MOV DI, 8
    MOV AL, roundKey[DI]
    XOR tempRoundKey[DI], AL

    MOV DI, 12
    MOV AL, roundKey[DI]
    XOR tempRoundKey[DI], Al

    POPF
    POPA

ENDM

ContinueXOR MACRO column

    PUSHA 
    PUSHF
    
    MOV DI, column
    MOV SI, column - 1
    MOV AL, tempRoundKey[SI]
    XOR AL, roundKey[DI]     
    MOV tempRoundKey[DI], AL

    MOV DI, column + 4
    MOV SI, 3 + column
    MOV AL, tempRoundKey[SI]
    XOR AL, roundKey[DI]
    MOV tempRoundKey[DI], AL

    MOV DI, column + 8
    MOV SI, 7 + column
    MOV AL, tempRoundKey[SI]
    XOR AL, roundKey[DI]
    MOV tempRoundKey[DI], AL

    MOV DI, column + 12
    MOV SI, 11 + column
    MOV AL, tempRoundKey[SI]
    XOR AL, roundKey[DI]
    MOV tempRoundKey[DI], AL

    POPF
    POPA

ENDM

MoveKeySchedule MACRO 

    PUSHA 
    PUSHF

    MOV CX, 15
    MOVE_KEY_SCHEDULE_LOOP:
    
        MOV DI, CX

        MOV AL, tempRoundKey[DI]
        MOV roundKey[DI], AL

        LOOP MOVE_KEY_SCHEDULE_LOOP

    MOV DI, 0
    MOV AL, tempRoundKey[DI]
    MOV roundKey[DI], AL

    POPF
    POPA

ENDM 