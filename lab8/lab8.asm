; Author: Adrian Joel Jaspa
; Subject: CMSC 131
;
; file: lab8.asm
; Eight Assembly lab that requires us to create a multiplication table
;
; Using Linux and gcc:
; nasm -f elf lab8.asm
; gcc -m32 -o lab8 driver.c lab8.o asm_io.o -no-pie
; ./lab8

%include "asm_io.inc"

section .data

prompt1 db 9,0

section .bss

section .text
    global mult

mult:
        enter   0, 0           ; Allocate room for the stack
        push    ebx

        mov     eax, [ebp+8]

;set Counters        
        mov     ecx, 1          ;counter for i
        mov     edx, 1          ;counter for j

Loop1: ;This correct
        cmp     ecx, [ebp+8]    ;compare ecx to input
        jle     Loop2          ;if Ecx is greater than input, END, if not jump Loop2
        jmp     Finale

Loop2:  ;This correct
        cmp     edx, [ebp+8]    ;if j is less than or equal to input
        jle     Printer         ;jump to Print
        jmp     End1            

Printer:
        mov     eax, prompt1    ;print of tab
        call    print_string
        mov     eax, edx        ; Ari lang gli ang may sala, naglibog pa ulo ko

        imul    eax, ecx        ;multiplying the values of edx and ecx
        call    print_int       ;print

End2:
        inc     edx             ;Increment edx
        jmp     Loop2           

End1:
        inc     ecx
        mov     edx, 1
        call    print_nl
        jmp     Loop1

Finale:
        call    print_nl

        pop     ebx
        leave
        ret

