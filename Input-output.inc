.data
buffer DB 16 DUP(?)
msg DB 'Enter the matrix (16 characters): $'  ; Dollar sign ($) marks the end of the string

.code
main:

    MOV AX, @DATA    ; Initialize Data Segment
    MOV DS, AX

    ; Print message
    LEA DX, msg      ; Load the address of the message into DX
    MOV AH, 9        ; Function 9 - Display string
    INT 21h          ; Call DOS interrupt

    ; Read 16 characters from the user
    LEA DI, buffer   ; Load the address of buffer into DI
    MOV CX, 16

read_loop:
    MOV AH, 1        ; Function 1 - Read character from standard input, with echo
    INT 21h
    STOSB            ; Store AL into buffer[DI] and increment DI
    LOOP read_loop

    ; Output the entered characters
    LEA SI, buffer   ; Load the address of buffer into SI
    MOV CX, 16

write_loop:
    LODSB            ; Load byte at DS:SI into AL and increment SI
    MOV DL, AL       ; Move the character to DL for output
    MOV AH, 2        ; Function 2 - Write character to standard output
    INT 21h
    LOOP write_loop

RET
