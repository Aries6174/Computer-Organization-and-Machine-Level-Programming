; Author: Adrian Joel Jaspa
; Subject: CMSC 131
;
; file: lab3.asm
; Third assembly program that finds the GCD or GCF.
;
; To assemble for Linux
; nasm -f elf -d ELF_TYPE lab3.asm
;
; Using Linux and gcc:
; nasm -f elf lab3.asm
; gcc -m32 -o lab3 driver.c lab3.o asm_io.o -no-pie
; ./lab3

%include "asm_io.inc"

segment .data

prompt1 db    "Enter two integers: ", 0       
prompt2 db    "The greatest common divisor of ", 0
prompt3 db    " and ", 0
prompt4 db    " is ", 0

segment .bss

input1 resd 1
input2 resd 1
input3 resd 1

segment .text
        global  asm_main

asm_main:
        enter 0, 0
        pusha

;creating the requests of two integers

        mov     eax, prompt1                    ;Printing of prompt1 (request of inputs)
        call    print_string
        call    read_int                       
        mov     [input1], eax                   ;storing the first input inside input1
        call    read_int
        mov     [input2], eax                   ;storing the second input inside input2
        mov     ecx, [input2]                   ;Input2 is move inside ecx        
        cmp     eax, ecx                        ;comparing the values of input1 and input 2
        jg      GCD                             ;if input1 is greater than input 2, jump to GCD
        mov     ecx, [input1]                   ;otherwise, switch the values
        mov     eax, [input2]                   ;jump to GCD since the order of values are now correct
        jmp    GCD

print:
        mov     eax, prompt2                    ;printing the necessary prompts
        call    print_string
        mov     eax, [input1]
        call    print_int
        mov     eax, prompt3
        call    print_string
        mov     eax, [input2]
        call    print_int
        mov     eax, prompt4
        call    print_string
        mov     [input3], ecx                   ;storing the quotient inside input 3 since the quotient is stored inside ecx
        mov     eax, [input3]                   ;moving input3 inside eax
        call    print_int                       ;printing the answer
        call    print_nl
        jmp     finale                          ;jump to the end

GCD:
        xor     edx, edx                        ;clearing the register of edx because this will loop
        div     ecx                             ;dividing the two values and storing it in ecx
        cmp     edx, 0                          ;if the remainder is equal to 0
        je      print                           ;jump to the print
        mov     eax, ecx                        ;if the condtion is not met, store ecx inside eax
        mov     ecx, edx                        ;store the remainder inside ecx, this becomes the new dividend
        jmp     GCD                             ;do the loop again

finale:
        popa 
        mov     eax, 0
        leave              
        ret


