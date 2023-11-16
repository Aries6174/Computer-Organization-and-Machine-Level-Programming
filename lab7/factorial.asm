; Author: Adrian Joel Jaspa
; Subject: CMSC 131
;
; file: factorial.asm
; Copied and altered from the Sixth Lab, this is a sub program of the actual main lab7 program. This contains get_int which asks the user its input number, and its factorial which contains the codes
; where it gives the factorial of the input.
;
; Using Linux and gcc:
; nasm -f elf factorial.asm -o factorial.o
; gcc -m32 -o factorial driver.c lab7.o factorial.o asm_io.o -no-pie

%include "asm_io.inc"

section .data

section .bss

section .text
        global get_int, factorial

get_int:
        enter 0,0

        mov     eax, [ebp+12]                   ;take the address of prompt
        call    print_string                    ;prints the prompt
        call    read_int                        ;read input
        mov     ebx, [ebp+8]                    ;moving the address of ebp+8 (which is n), and pointing it to ebx
        mov     [ebx], eax                      ;store inputted int inside ebx

        leave
        ret                                     ;return back to lab7

factorial:
        enter   0, 0

        mov     eax, [ebp+8]                    ;taking out the paramater
        mov     ecx, eax                        ;Initialize eax to 1 (identity element for multiplication)
        mov     eax, 1                          ;Eax = 1
        cmp     ecx, 1                          ;If(ecx <= 1)
        jle     end                             ;skips looping

iteration:
        imul    eax, ecx                        ;Multiply eax by ecx
        loop    iteration                       ;Use loop to automatically decrement ecx and repeat if not zero

end:
        leave
        ret
