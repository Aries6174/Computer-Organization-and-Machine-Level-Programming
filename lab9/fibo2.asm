; Author: Adrian Joel Jaspa
; Subject: CMSC 131
;
; file: lab9.asm
; Ninth Assembly Lab. Requires us to create a Fibonacci sequence with the use of recursion.
;
; Using Linux and gcc:
; nasm -f elf fibo.asm
; gcc -m32 -o fibo Main.c fibo.o asm_io.o -no-pie
; ./fibo

%define n [ebp+8]                       ;n = ebp+8 or parameter
%define i [ebp-4]                       ;i = ebp-4 or the previous number

%include "asm_io.inc"

section .data  

section .bss

section .text 
    global fibo

fibo:
        enter   0, 0                    ;set up
        push    ebx                     ;pushing ebx

        mov     ecx, n                  ;store 0 for comparing
        cmp     ecx, 0                  ;comparing the counter
        jle     finale                  ;if equal or less than 0

fib_rec:
        mov     eax, n                  ;eax = ebp+8
        sub     eax, ecx                ;eax - ecx      
        push    eax                     ;pushes eax
        call    recursion               ;calls recursion
        call    print_int               ;print the number
        call    print_nl                ;print the new line
        loop    fib_rec                 ;loop fib rec again

finale:
        pop     ebx
        leave
        ret

recursion:
        enter   4,0                     ;allocating 4 stacks

        mov     dword i, 0              ;setting the value of i to be 0
        cmp     dword n, 1              ;comparing is ebp+8 and 1
        mov     eax, n                  ;setting eax to be n(to start or Zero)
        jle     rec_end                 ;if less than or equal to, jump to the end

        cmp     dword n, 1              ;comparing n, with 1
        mov     eax, n                  ;sets eax to be n
        je      rec_end                 ;if 1 jump to end

        dec     dword n                 ;decrement n
        push    dword n                 ;push n inside the stack
        call    recursion               ;call the recursion again
        add     i, eax                  ;add i and eax which is n

        dec     dword n                 ;decrement n
        push    dword n                 ;push n
        call    recursion               ;call recursion

rec_end:
        add     eax, dword i            ;add eax to i

        leave
        ret                             ;return

