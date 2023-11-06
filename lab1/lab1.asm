; Author: Adrian Joel Jaspa
; Subject: CMSC 131
;
; file: math.asm
; Second assenbly program. Asks for 2 inputs foo and bar,
; prints them, and switches them after.
;
; To assemble for Linux
; nasm -f elf -d ELF_TYPE lab1.asm
;
; Using Linux and gcc:
; nasm -f elf lab1.asm
; gcc -m32 -o lab1 driver.c lab1.o asm_io.o
; ./lab1

%include "asm_io.inc"

segment .data

prompt1 db    "Problem: When the smallest of three consecutive odd integers is added to four times the largest, it produces a result 729 more than four times the middle integer. Find the numbers and check your answer.", 0
prompt2 db    "The first odd number is ", 0       
prompt3 db    "The second odd number is ", 0
prompt4 db    "The third odd number is ", 0


segment .bss

a       resd 1
b       resd 1
c       resd 1
d       resd 1
e       resd 1
f       resd 1
first   resd 1
second  resd 1
third   resd 1

segment .text
        global  asm_main
asm_main:

;printing of problem

        enter   0,0               ; setup routine

        call    print_nl
        mov     eax, prompt1      ; prints string request of foo
        call    print_string
        call    print_nl
        call    print_nl

;math
;left hand side pt.1
; 1 + 4(1 +4)

        mov     eax, 1
        mov     [c], eax

        mov     eax, 1
        mov     ebx, 4
        imul    eax, ebx
        mov     [a], eax

        mov     eax, 4
        mov     ebx, 4
        imul    eax, ebx
        mov     [b], eax


;right hand side pt.1
        mov     eax, 729
        mov     [f], eax

        mov     eax, 1
        mov     ebx, 4
        imul    eax, ebx
        mov     [d], eax

        mov     eax, 4
        mov     ebx, 2
        imul    eax, ebx
        mov     [e], eax


;switching of values

        mov     eax, [b]
        mov     ebx, [d]
        mov     [b], ebx
        mov     [d], eax

;left hand side pt.2

        mov     eax, [a]
        mov     ebx, [b]
        sub     eax, ebx
        mov     [a], eax

        mov     eax, [a]
        mov     ebx, [c]
        add     eax, ebx
        mov     [a], eax

;right hand side pt.2

        mov     eax, [e]
        mov     ebx, [d]
        sub     eax, ebx
        mov     [d], eax

        mov     eax, [d]
        mov     ebx, [f]
        add     eax, ebx
        mov     [d], eax

        mov     eax, [d]
        mov     [first], eax


; getting the second and third odd integers

        mov     eax, [first]
        mov     ebx, 2
        add     eax, ebx
        mov     [second], eax

        mov     eax, [first]
        mov     ebx, 4
        add     eax, ebx
        mov     [third], eax

;printing of the answers

        call    print_nl
        mov     eax, prompt2
        call    print_string
        mov     eax, [first]     ; store into input
        call    print_int

        call    print_nl
        mov     eax, prompt3
        call    print_string
        mov     eax, [second]     ; store into input
        call    print_int
        
        call    print_nl
        mov     eax, prompt4
        call    print_string
        mov     eax, [third]    ; store into input
        call    print_int
        call    print_nl


        leave                     
        ret


