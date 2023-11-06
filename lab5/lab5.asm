; Author: Adrian Joel Jaspa
; Subject: CMSC 131
;
; file: lab4.asm
; Fourth Assembly prgram that shifts the number of bits to the left and to the right of the inputted number of the user
; also using bitwise operations and shifts in the process
;
; Using Linux and gcc:
; nasm -f elf lab5.asm
; gcc -m32 -o lab5 driver.c lab5.o asm_io.o -no-pie
; ./lab5

%include "asm_io.inc"

segment .data

prompt1 db     "Enter a number: ", 0    
prompt2 db     "Enter another number: ",0
prompt3 db     " & ", 0                                                ;prompt for and
prompt4 db     " | ", 0                                                ;prompt for or
prompt5 db     " ^ ", 0                                                ;prompt for xor
prompt6 db     " is ", 0

segment .bss

input1  resd 1                                                          ;for the inputted number
input2  resd 1                                                          ;for the shift
answerA resd 1                                                          ;answer for the and
answerO resd 1                                                          ;answer for the or
answerX resw 1                                                          ;answer for the xor

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
        mov     [input2], eax

;and, or, and xor the bits

        mov     eax, [input1]                                            ;storing the first iputted number inside eax
        mov     ebx, [input2]                                            ;storing the second inputted number inside ebx
        and     eax, ebx                                                 ;And the inputted number with the right
        mov     [answerA], ax                                            ;storing eax inside answerA

        mov     eax, [input1]                                            ;storing the inputted number in eax
        or      eax, ebx                                                 ;Or both numbers
        mov     [answerO], eax                                           ;storing eax inside answerO

        mov     eax, [input1]                                            ;storing the inputted number in eax
        xor     eax, ebx                                                 ;Xor both numbers
        mov     [answerX], eax                                           ;storing eax inside answerX

;printing of prompts
        mov     eax, [input1]
        call    print_int
        mov     eax, prompt3
        call    print_string
        mov     eax, [input2]
        call    print_int
        mov     eax, prompt6
        call    print_string
        mov     eax, [answerA]
        call    print_int
        call    print_nl

        mov     eax, [input1]
        call    print_int
        mov     eax, prompt4
        call    print_string
        mov     eax, [input2]
        call    print_int
        mov     eax, prompt6
        call    print_string
        mov     eax, [answerO]
        call    print_int
        call    print_nl

        mov     eax, [input1]
        call    print_int
        mov     eax, prompt5
        call    print_string
        mov     eax, [input2]
        call    print_int
        mov     eax, prompt6
        call    print_string
        mov     eax, [answerX]
        call    print_int
        call    print_nl

finale:
        call    print_nl

        popa 
        mov     eax, 0
        leave              
        ret


