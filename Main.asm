; Title: AES 8086
; Author: AFA86x
; Date: 18/5/2024

org 100h

; Define constants, variables, and data sections
section .data
    ; Define your data variables here
    ROWS EQU 4
    COLS EQU 4
    key DB ROWS * COLS DUP(?)
section .bss
    ; Define uninitialized data variables here

; Define code section
section .text
    ; Declare global entry point
    global _start

; Entry point
_start:
    ; Your code starts here

    ; Example: Exit program
    mov eax, 1       ; System call number for exit
    xor ebx, ebx     ; Exit code 0
    int 0x80         ; Invoke system call

; Define additional functions or code sections below if needed


; -------------------- MACROS --------------------

; MACRO: shiftRows
; DESCRIPTION: Shifts the rows of the key matrix to the left by the specified number of positions
shiftRows MACRO

ENDM

shiftRowsHelper MACRO row, shiftAmount
    MOV CX, shiftAmount - 1
    PUSH_LOOP_START: 
        PUSH key[row][CX]
        LOOP PUSH_LOOP_START

    MOV CX, shiftAmount
    POP_LOOP_START: 
        POP key[row][4 - CX]
        LOOP POP_LOOP_START
ENDM