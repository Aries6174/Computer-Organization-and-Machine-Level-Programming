; Author: Adrian Joel Jaspa
; Subject: CMSC 131
;
; file: lab2.asm
; Second assenbly program. Asks for 2 inputs foo and bar,
; prints them, and switches them after.
;
; To assemble for Linux
; nasm -f elf -d ELF_TYPE lab2.asm
;
; Using Linux and gcc:
; nasm -f elf lab2.asm
; gcc -m32 -o lab2 driver.c lab2.o asm_io.o -no-pie
; ./lab2

%include "asm_io.inc"

section .data

prompt1 db    "Enter a year: ", 0       
prompt2 db    " is a leap year.", 0
prompt3 db    " is not a leap year.", 0

section .bss

input1    resd 1

section .text
        global  asm_main

asm_main:
        enter 0, 0
        pusha

;creating the request of the year

        call    print_nl                ;Calls in a space for visibility
        mov     eax, prompt1            ;moves the string in prompt1 inside eax
        call    print_string            ;prints the string

        call    read_int                ;Input for the year
        mov     [input1], eax           ;inserting what the input is inside input1

;if statements and others

        mov     eax, [input1]           ;storing input1 in eax
        mov     edx, 0                  ;this is where the remainder will be stored
        mov     ecx, 4                  ;the divisor
        div     ecx                     ;dividing ecx
        cmp     edx, 0                  ;comparing if statement of the remainder and the other value is 0
        jne     not_leap                ;if it is not equal to 0 then it is only divisible by 4 therefore the given year is a leap year

        mov     eax, [input1]           ;storing input1 in eax
        mov     edx, 0                  ;this is where the remainder will be stored
        mov     ecx, 100                ;the divisor
        div     ecx                     ;dividing ecx
        cmp     edx, 0                  ;if statement of the remainder and the other value is 0
        jne     is_leap                 ;if it is not equal to 0 then it is only divisible by 4 therefore the given year is a leap year


        mov     eax, [input1]           ;storing input1 in eax
        mov     edx, 0                  ;this is where the remainder will be stored
        mov     ecx, 400                ;the divisor (for century year)
        div     ecx                     ;dividing
        cmp     edx, 0                  ;Another comparing if statement
        jne     not_leap                ;if it is not divisible by 400 then it is not a century year but only divisible by 100

;If the year is divisible by 4 or divisible by 400
is_leap:
        mov     eax, [input1]           ;calls the inputted integer
        call    print_int               ;prints the integer
        mov     eax, prompt2            ;calls the necessary prompt
        call    print_string            ;prints the required string in determining whether or not it is leap
        jmp     end                     ;jumps to end or it will trigger not leap

;
not_leap:
        mov     eax, [input1]           ;calls the inputted integer
        call    print_int               ;prints that integer
        mov     eax, prompt3            ;calls the necassary prompt
        call    print_string            ;prints that prompt


; finale
end:                                    ;is_leap is used, skips not_leap and jumps here
        call    print_nl                ;calls next line for visbility
        call    print_nl 
        popa
        mov eax, 0
        leave                     
        ret


