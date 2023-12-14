; Author: Adrian Joel Jaspa
; Subject: CMSC 131
;
; file: searchArray.asm
; Tenth Assembly Lab. Enter a size of an array as well as the values of of each array. After inputting all values,
; print the line of array first then ask the user which array do they want to search.
;
; Using Linux and gcc:
; nasm -f elf stack.asm
; gcc -m32 -o stack stack1.c stack.o asm_io.o -no-pie
; ./stack

;Assembly code

segment .text
    global  pells

pells:
    enter   4,0
    push    ebx

    mov     edx, [ebp + 8]
    mov     dword [ebp - 4], 0

    ;SD

    cmp     edx, 1
    jle     base_condition

    dec     edx
    push    edx
    call    pells
    pop     edx

    sal     eax, 1
    add     [ebp + 4], eax

    dec     edx
    push    edx

    call    pells
    pop     edx

    add     [ebp - 4], eax
    jmp     return_pell

base_condition:
    mov     [ebp-4], edx

return_pell:
    mov     eax, [ebp - 4]
    pop     ebx
    leave
    ret
