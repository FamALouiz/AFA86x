                                             ; -------------------- MACROS --------------------

; MACRO: subByte()
; DESCRIPTION: replaces each byte in the input block with a corresponding byte from the S-box.
              ;The S-box is a predefined 16x16 matrix that provides a non-linear substitution.
subByte MACRO

             MOV AX, DATA
             MOV DS, AX

             MOV CX, 4 ; Rows
             MOV DX, 4 ; Columns

             MOV SI, 0 ; Initialize SI to point to keyMatrix
             MOV DI, 0 ; Initialize DI to point to ResultMatrix

             outer_loop:
             MOV BX, DX ; Copy number of columns into BX for inner loop

             inner_loop:
             ; Load element from Matrix
             MOV AL, keyMatrix[SI]

             ; Perform SubBytes operation

             ; Calculate offset in SBox;
             ; offset=row_number×number_of_columns+column_number
             ; number_of_columns= 16 fixed

             MOV AH, AL         ; Copy element value to AH
             AND AH, 0F0h       ; Clear low part
             AND AL, 0FH        ; Mask high part
             MOV BL, AL         ; Copy high part to BL
             MOV AL, AH         ; Copy low part to AL
             MOV AH, 0          ; Clear AH for zero extension
             MUL BYTE PTR [16]  ; Multiply row by number of columns
             ADD AX, BX         ; Add column
             MOV SI, AX         ; SI = offset

             ; Substitute byte using SBox
              MOV AL, SBox[SI]

              ; Store result in ResultMatrix
              MOV keyMatrix[DI], AL

             INC SI ; Move to the next element in Matrix
             INC DI ; Move to the next element in ResultMatrix
             LOOP inner_loop

             ADD SI, BX ; Move to the next row in Matrix
             ADD DI, BX ; Move to the next row in ResultMatrix

             LOOP outer_loop

ENDM
