.model small
.stack 100h
.data
buffer db 0
msg db 'Enter a character: $'  ; Dollar sign ($) marks the end of the string

.code
main:
    ; Initialize Data Segment
    mov ax, @data
    mov ds, ax

    ; Print message
    lea dx, msg      ; Load the address of the message into DX
    mov ah, 9        ; Function 9 - Display string
    int 21h          ; Call DOS interrupt

    ; Read a character from the user
    mov ah, 1        ; Function 1 - Read character from standard input, with echo
    int 21h          ; Call DOS interrupt
    mov buffer, al   ; Store the character in the buffer

    ; Output the character
    mov dl, buffer   ; Move the character to DL for output
    mov ah, 2        ; Function 2 - Write character to standard output
    int 21h          ; Call DOS interrupt

    ; Exit program
    mov ah, 4Ch      ; Function 4Ch - Terminate program
    int 21h          ; Call DOS interrupt

end main
