; Title: AES 8086
; Author: AFA86x
; Date: 18/5/2024

org 100h

; Define constants, variables, and data sections
.data segment
    ; Define your data variables here
    ROWS EQU 4
    COLS EQU 4  ;0  1  2  3  4  5  6  7  8  9   10  11  12  13  14  15
    MDS DB 2,3,1,1,1,2,3,1,1,1,2,3,3,1,1,2
    unchangedMatrix DB 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0
    i db 00
    j db 00
    x db 00
    an db 00
    tmp dw 00 
    ans DB 00
    at db 00                   
    totalNumberOfLoops DW 11          ; 1 + 9 + 1 (if the number of loops needs to be changed please change here)                                           
    tempRoundKey DB 16 DUP(?)
    Rcon DB 01h, 02h, 04h, 08h, 10h, 20h, 40h, 80h, 1bh, 36h
    include ShiftRowsMacros.inc
    include MixColoums.inc
    include AddRoundKeyMacros.inc
    include KeyScheduleMacros.inc

    SBOX DB 63H,7CH,77H,7BH,0F2H,6BH,6FH,0C5H,30H,01H,67H,2BH,0FEH,0D7H,0ABH,76H
         DB 0CAH,82H,0C9H,7DH,0FAH,59H,47H,0F0H,0ADH,0D4H,0A2H,0AFH,9CH,0A4H,72H,0C0H
         DB 0B7H,0FDH,93H,26H,36H,3FH,0F7H,0CCH,34H,0A5H,0E5H,0F1H,71H,0D8H,31H,15H
         DB 04H,0C7H,23H,0C3H,18H,96H,05H,9AH,07H,12H,80H,0E2H,0EBH,27H,0B2H,75H
         DB 09H,83H,2CH,1AH,1BH,6EH,5AH,0A0H,52H,3BH,0D6H,0B3H,29H,0E3H,2FH,84H
         DB 53H,0D1H,00H,0EDH,20H,0FCH,0B1H,5BH,6AH,0CBH,0BEH,39H,4AH,4CH,58H,0CFH
         DB 0D0H,0EFH,0AAH,0FBH,43H,4DH,33H,85H,45H,0F9H,02H,7FH,50H,3CH,9FH,0A8H
         DB 51H,0A3H,40H,8FH,92H,9DH,38H,0F5H,0BCH,0B6H,0DAH,21H,10H,0FFH,0F3H,0D2H
         DB 0CDH,0CH,13H,0ECH,5FH,97H,44H,17H,0C4H,0A7H,7EH,3DH,64H,5DH,19H,73H
         DB 60H,81H,4FH,0DCH,22H,2AH,90H,88H,46H,0EEH,0B8H,14H,0DEH,5EH,0BH,0DBH
         DB 0E0H,32H,3AH,0AH,49H,06H,24H,5CH,0C2H,0D3H,0ACH,62H,91H,95H,0E4H,79H
         DB 0E7H,0C8H,37H,6DH,8DH,0D5H,4EH,0A9H,6CH,56H,0F4H,0EAH,65H,7AH,0AEH,08H
         DB 0BAH,78H,25H,2EH,1CH,0A6H,0B4H,0C6H,0E8H,0DDH,74H,1FH,4BH,0BBH,8BH,8AH
         DB 70H,3EH,0B5H,66H,84H,03H,0F6H,0EH,61H,35H,57H,0B9H,86H,0C1H,1BH,9EH
         DB 0E1H,0F8H,98H,11H,69H,0D9H,8EH,94H,9BH,1EH,87H,0E9H,0CEH,55H,28H,0DFH
         DB 8CH,0A1H,89H,0DH,0BFH,0E6H,42H,68H,41H,99H,2DH,0FH,0B0H,54H,0BBH,16H
    RconCounter DW 0
    defaultValue DB 0      ; This value should match the one in the keyMatrix
    keyMatrix DB 16 DUP(0)                                   ; assumption that the rest of the inputs are nulls or 00h (some websites assume they are                                    
    roundKey DB 16 DUP(0)                                    ; white spaces or 020h) depending on the assumption change the default value for the keyMatrix
    msg db 'Enter the input text: $'
    msg2 db 'Enter the key: $'
    newLine db 0Dh, 0Ah, '$' ;
    include SubBytesMacros.inc


; Define code section
.code segment
    ; Print message
    LEA DX, msg
    MOV AH, 9
    INT 21h

    ; Read 16 characters from the user for the matrix
    LEA DI, keyMatrix
    MOV CX, 16

    read_loopInputMatrix:
        MOV AH, 1
        INT 21h
        STOSB
        CMP AL, 0Dh
        JZ correct_last_digit
        LOOP read_loopInputMatrix

    print_new_line:
        STOSB
        LEA DX, newLine
        MOV AH, 9
        INT 21h

    Print_message:
        LEA DX, msg2
        MOV AH, 9
        INT 21h

    ; Read 16 characters from the user for the key
        LEA DI, roundKey
        MOV CX, 16

    read_loopInputKey:
        MOV AH, 1
        INT 21h
        STOSB
        CMP AL, 0Dh
        JZ print_new_line2
        LOOP read_loopInputKey

     print_new_line2:
        LEA DX, newLine
        MOV AH, 9
        INT 21h

    MOV CX, totalNumberOfLoops
    loop9: 

        CMP CX, totalNumberOfLoops
        JE FIRST_ROUND

        subByte
        shiftRows

        CMP CX, 1
        JE FIRST_ROUND
        mixColoums

        FIRST_ROUND:
            addRoundKey
            keySchedule

        loop loop9  
    
    SUB CX, 1

    END:
    ; Output the entered characters
    LEA SI, keyMatrix
    MOV CX, 16

    write_loop:
            LODSB
            MOV DL, AL
            MOV AH, 2
            INT 21h
            LOOP write_loop
    RET

    correct_last_digit:
        SUB DI, 1                   ; Correcting last digit
        MOV AL, defaultValue
        JMP print_new_line