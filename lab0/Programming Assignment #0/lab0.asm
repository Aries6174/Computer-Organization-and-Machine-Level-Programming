; Author: Adrian Joel Jaspa
; Subject: CMSC 131
;
; file: lab0.asm
; Second assenbly program. Asks for 2 inputs foo and bar,
; prints them, and switches them after.
;
; To assemble for Linux
; nasm -f elf -d ELF_TYPE lab0.asm
;
; Using Linux and gcc:
; nasm -f elf lab0.asm
; gcc -m32 -o lab0 driver.c lab0.o asm_io.o
; ./lab0

%include "asm_io.inc"

segment .data

;prints prompts db

prompt1 db    "Enter value of foo: ", 0                                 
prompt2 db    "Enter value of bar: ", 0                                 
outmsg1 db    "The value of foo is ", 0                                 
outmsg2 db    "The value of bar is ", 0                                 
outmsg3 db    "==============After Swapping=============", 0           

;prints inputs

segment .bss

foo  resd 1
bar  resd 1

segment .text
        global  asm_main
asm_main:

;printing of inputs

        enter   0,0               ; setup routine

        call    print_nl
        mov     eax, prompt1      ; prints string request of foo
        call    print_string

        call    read_int          ; read integer
        mov     [foo], eax        ; store into foo

        mov     eax, prompt2      ; prints string request of foo
        call    print_string

        call    read_int          ; read integer
        mov     [bar], eax        ; store into bar

;printing of prompts and inputs

        mov     eax, outmsg1
        call    print_string      ; print out first message
        mov     eax, [foo]     
        call    print_int         ; print out input
        call    print_nl

        mov     eax, outmsg2
        call    print_string      ; print out second message
        mov     eax, [bar]
        call    print_int         ; print out input2
        call    print_nl

        mov     eax, outmsg3
        call    print_string      ; print out third message
        call    print_nl

;switching foo and bar

        mov     eax, [foo]
        mov     ebx, [bar]
        mov     [foo],ebx
        mov     [bar],eax

;printing the switched version 

        mov     eax, outmsg1
        call    print_string      ; print out first message
        mov     eax, [foo]     
        call    print_int         ; print out input
        call    print_nl

        mov     eax, outmsg2
        call    print_string      ; print out second message
        mov     eax, [bar]
        call    print_int         ; print out input2
        call    print_nl
        call    print_nl



        leave                     
        ret


