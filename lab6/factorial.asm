; Author: Adrian Joel Jaspa
; Subject: CMSC 131
;
; file: factorial.asm
; The Sixth File is a file that asks the user a number and factorials it
;
; Using Linux and gcc:
; nasm -f elf factorial.asm
; gcc -m32 -o factorial driver.c factorial.o asm_io.o -no-pie
; ./factorial

%include "asm_io.inc"

segment .data
prompt1     db "Enter a number to calculate its factorial: ", 0
prompt2     db "! = ", 0

segment .bss
n           resd 1
stored_value resd 1

segment .text
        global asm_main, Factorial

asm_main:
        enter 0, 0
        pusha


        mov     eax, prompt1   
        call    print_string
        call    read_int                        ;Reads the input of the user
        mov     [n], eax

        cmp     eax, 0                          ;if the user input is 0
        je      Zero                            ;jumps to Zero

        call    Factorial                       ;calls factorial
        jmp     print_result                    ;jumps to to skip Zero

Zero:
        mov     eax, 1
        mov     [stored_value], eax             ;If the number is 0, store 1 inside dword

print_result:
        mov     eax, [n]
        call    print_int                       ;prints the user input
        mov     eax, prompt2
        call    print_string                    ;prints the 2nd prompt
        mov     eax, [stored_value]
        call    print_int                       ;prints the answer

; Finale
        call    print_nl
        popa
        mov     eax, 0
        leave
        ret

Factorial:
        mov     ecx, [n]
        mov     eax, 1

iteration:
        imul    eax, ecx                        ;Multiply eax by ecx
        loop    iteration                       ;Decrement ecx (Counter) and loop if not zero
                                                ;using loop it automatically decrements everytime its used and stop if ecx is equal to 0
                                                ;eax also changes.
        mov     [stored_value], eax             ;storing the value inside stored_value
        ret
