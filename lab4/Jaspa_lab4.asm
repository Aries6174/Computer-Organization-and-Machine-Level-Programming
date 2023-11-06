; Author: Adrian Joel Jaspa
; Subject: CMSC 131
;
; file: lab4.asm
; Fourth Assembly prgram that shifts the number of bits to the left and to the right of the inputted number of the user
; also using bitwise operations and shifts in the process
;
; Using Linux and gcc:
; nasm -f elf lab4.asm
; gcc -m32 -o lab4 driver.c lab4.o asm_io.o -no-pie
; ./lab4

%include "asm_io.inc"

segment .data

prompt1 db     "Enter a number: ", 0    
prompt2 db     "Enter the number of places to shift: ",0
prompt3 db     " << ", 0                                                ;prompt for left shift
prompt4 db     " >> ", 0                                                ;prompt for right shift
prompt5 db     " is ", 0

segment .bss

input1  resd 1                                                          ;for the inputted number
shift   resd 1                                                          ;for the shift
answerL resw 1                                                          ;answer for the left shift
answerR resw 1                                                          ;answer for the right shift

segment .text
        global  asm_main

asm_main:
        enter 0, 0
        pusha

;printing of prompts and requesting of inputs

        mov     eax, prompt1
        call    print_string
        call    read_int
        mov     [input1], eax
        mov     eax, prompt2
        call    print_string
        call    read_int
        mov     [shift], eax

;shifting the bits

        mov     eax, [input1]                                            ;storing the iputted number inside ax
        mov     cl, [shift]                                             ;storing the input inside cl
        shl     ax, cl                                                  ;shift the inputted number to the left based on the amount of shifts inputted
        mov     [answerL], ax                                           ;storing ax inside answerL

        mov     eax, [input1]
        mov     cl, [shift]
        shr     ax, cl                                                  ;shift the inputted number to the right based on the amount of shifts inputted
        mov     [answerR], ax                                           ;storing ax inside answer

;printing of prompts
        mov     eax, [input1]
        call    print_int
        mov     eax, prompt3
        call    print_string
        mov     eax, [shift]
        call    print_int
        mov     eax, prompt5
        call    print_string
        mov     eax, [answerL]
        call    print_int
        call    print_nl

        mov     eax, [input1]
        call    print_int
        mov     eax, prompt4
        call    print_string
        mov     eax, [shift]
        call    print_int
        mov     eax, prompt5
        call    print_string
        mov     eax, [answerR]
        call    print_int
        call    print_nl

finale:
        call    print_nl

        popa 
        mov     eax, 0
        leave              
        ret


