; Author: Adrian Joel Jaspa
; Subject: CMSC 131
;
; file: lab7.asm
; Fourth Assembly prgram that shifts the number of bits to the left and to the right of the inputted number of the user
; also using bitwise operations and shifts in the process
;
; Using Linux and gcc:
; nasm -f elf lab7.asm -o lab7.o
; gcc -m32 -o lab7 driver.c lab7.o factorial.o asm_io.o -no-pie
; ./lab7

%include "asm_io.inc"

section .data
prompt1 db     "Enter a number to calculate its factorial: ", 0    
prompt2 db      "! = ", 0
prompt3 db      " is a number out of range."
prompt4 db      "Want to input another number? [Y = 1/ N = 0]: "

section .bss
n       resd 1

section .text
        global asm_main
        extern get_int, factorial

asm_main:
        enter 0, 0
        pusha

        mov     eax, prompt1                    ;Prints the request
        call    print_string
        push    prompt1                         ;pushing the prompt at ebp+12
        push    dword n                         ;pushing the address at ebp+8
        call    get_int                         ;Calls get_int inside factorial.asm
        add     esp, 8                          ;taking the paramaters and prompts out of the stack

;calling subprogram factorial
        mov     eax, [n]                        ;store the value of n inside eax
        call    print_int                       ;print n
        mov     eax, prompt2                    ;Stores the prompt inside eax
        call    print_string                    ;Prints the prompt
        push    dword [n]                         ;push dword n to used inside factorial
        call    factorial                       ;calling factorial
        add     esp, 4                          ;taking the parameters out of the stac
        call    print_int                       ;Print n (answer).


Finale:
        call    print_nl
        popa
        mov     eax, 0
        leave
        ret
