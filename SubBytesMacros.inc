                                             ; -------------------- MACROS --------------------

; MACRO: subByte()
; DESCRIPTION: replaces each byte in the input block with a corresponding byte from the S-box.
              ;The S-box is a predefined 16x16 matrix that provides a non-linear substitution.
subByte MACRO
    PUSHA
    PUSHF

              MOV DX, 4 ; Columns

              MOV SI, 0                  ; Initialize SI to point to keyMatrix
              MOV DI, 0                  ; Initialize DI to point to ResultMatrix

              outer_loop:
              MOV CX, 4 ; Rows

              inner_loop:
              MOV BX, 0                  ; clear BX
              MOV BL, buffer[SI]      ; Load element from Matrix

             ; Perform SubBytes operation
              MOV AX,0                  ; clear AX
              MOV AL, SBox[BX]          ; Substitute byte using SBox

              ; Store result in ResultMatrix
              MOV ResultMatrix[DI], AL
              INC SI                     ; Move to the next element in Matrix
              INC DI                     ; Move to the next element in ResultMatrix
              DEC CX
              CMP CX, 0
              JNZ inner_loop

              DEC DX
              CMP DX,0
              JNZ outer_loop
    POPF
    POPA
ENDM



    ; offset=row_number×number_of_columns+column_number
    ; number_of_columns= 16 fixed
    ; using the same byte from the keyMatrix directly will be the same as calculating it from the offset equation

