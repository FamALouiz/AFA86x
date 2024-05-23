                                             ; -------------------- MACROS --------------------

; MACRO: subByte()
; DESCRIPTION: replaces each byte in the input block with a corresponding byte from the S-box.
              ;The S-box is a predefined 16x16 matrix that provides a non-linear substitution.
subByte MACRO


             MOV CX, 4 ; Rows
             MOV DX, 4 ; Columns

             MOV SI, 0 ; Initialize SI to point to keyMatrix
             MOV DI, 0 ; Initialize DI to point to ResultMatrix
             MOV 
             outer_loop:
             MOV AX, DX ; Copy number of columns into BX for inner loop
             MOV CX,4


             inner_loop:
             ; Load element from Matrix
             MOV BL, keyMatrix[SI]

             ; Perform SubBytes operation

             ; Calculate offset in SBox;
             ; offset=row_number×number_of_columns+column_number
             ; number_of_columns= 16 fixed


              MOV BH, 0
             ; Substitute byte using SBox
              MOV AL, SBox[BX]

              ; Store result in ResultMatrix
              MOV ResultMatrix[DI], AL

             INC SI ; Move to the next element in Matrix
             INC DI ; Move to the next element in ResultMatrix
             DEC CX
             CMP CX, 0
             JNZ inner_loop

             ADD SI, 1 ; Move to the next row in Matrix
             ADD DI, 1 ; Move to the next row in ResultMatrix
             DEC DX
             CMP DX,0
             JNZ outer_loop

ENDM
