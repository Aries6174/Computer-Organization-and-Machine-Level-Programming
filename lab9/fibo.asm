; Author: Adrian Joel Jaspa
; Subject: CMSC 131
;
; file: lab8asm
; Creating Fibonacci sequence of numbers using Recursion
;
; Using Linux and gcc:
; nasm -f elf fibo.asm
; gcc -m32 -o fibo Main.c fibo.o asm_io.o -no-pie
; ./fibo

%include "asm_io.inc"

section .data
    prompt1 db "The number you inputted is less than or equal to 0. ", 0

section .bss

section .text
    global fibo

fibo:
        enter   0, 0           
        pusha

        mov     eax, 0                  ;store 0 for comparing
        cmp     [ebp + 8], eax          ;comparing the parameter and 0
        jle     Zero                    ;For Zero and negative input

;starting
        mov     ecx, [ebp + 8]          ;storing the parameter as the counter
        mov     ebx, 0                  ;storing 0 in ebx
        mov     eax, 1                  ;storing 1 in eax
        call    RecursiveSolution       ;call the Recursion

        jmp     Finale                  ;jump to the End

Zero:                                   ;if input is less than or equal to Zero
        mov     eax, prompt1            ;storing prompt1 in eax
        call    print_string            ;prints the prompt if Zero
        jmp     Finale                  ;jump to end

RecursiveSolution:
        cmp     ecx, 0                  ;comparing the counter and 0
        jle     EndRecursion            ;if less jump to End recursion

;Recursion function
        xadd    ebx, eax                ;Automatically add then exchange,
                                        ;This also accumulates the values and continues everytime
                                        ;the function is called.

        call    print_int               ;prints every number
        call    print_nl                ;prints the next_line
        dec     ecx                     ;decrement, prevents the infinite loop
        call    RecursiveSolution       ;Calls recursion again

EndRecursion:
        ret

Finale: 
        call    print_nl                

        popa
        leave
        ret
