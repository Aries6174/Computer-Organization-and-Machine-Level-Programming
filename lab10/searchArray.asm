; Author: Adrian Joel Jaspa
; Subject: CMSC 131
;
; file: searchArray.asm
; Tenth Assembly Lab. Enter a size of an array as well as the values of of each array. After inputting all values,
; print the line of array first then ask the user which array do they want to search.
;
; Using Linux and gcc:
; nasm -f elf searchArray.asm
; gcc -m32 -o searchArray array1c.c searchArray.o asm_io.o -no-pie
; ./searchArray

%include "asm_io.inc"           
%define max 100            ;I just want to use define lmao

section .data  

arrayRequest db "Enter array size: ", 0
askAtIndex db "Enter value @ array[" , 0
colon db "]: ", 0
arraycontains db "Array contains: ", 0
outsideprintstart db "The number you inputted cannot be created into an array", 0
blankspace db " ", 0
searchArray db "Enter number to be searched: ", 0
outsideInput db "The number you inputted is outside the array. ", 0
elementAtArray db " is @ array[", 0
closebrack db "]", 0

section .bss

arraysize       resd 1          ;for the size of the array
searchInput     resd 1          ;inputting the specific number being searched
array1          resd max        ;The array with size 100

section .text 
    global asm_main
    extern dump_line

asm_main:
        enter   0, 0                    ;set up
        pusha

ask_size:
        mov     eax, arrayRequest       ;printing the request
        call    print_string
        call    read_int
        cmp     eax, 0                  ;comparing the input with 0
        jle     outside_printstart                  ;if less than or equal to, jump to end

        mov     [arraysize], eax        ;storing the result inside arraysize

        ;clearing ECX register just to make sure
        xor     ecx, ecx

;asking specific elements
ask_elements:
        ;comparing everytime the loop starts
        cmp     [arraysize], ecx
        je      printing_part1           ;jumps to printing if its equals          

        ;printing the request
        mov     eax, askAtIndex
        call    print_string
        mov     eax, ecx
        call    print_int               
        mov     eax, colon
        call    print_string
        call    read_int                ;input the value of a specific element in the array

        ;storing that value in the array
        mov     [array1 + 4 * ecx], eax 
        inc     ecx                     ;Increment ecx
        jmp     ask_elements            ;goes back to the start again

;printing all the values in each elements
printing_part1:
        ;Printing the sentence
        mov     eax, arraycontains
        call    print_string
        call    print_nl

        ;clearing ecx, the terminal wont print the numbers
        xor     ecx, ecx

printing_part2:
        ;comparing the counter
        cmp     [arraysize], ecx        
        je      search_print            ;jump to search print after the printing              

        mov     eax, [array1 + 4 * ecx] ;storing the value inside eax
        call    print_int               ;print
        mov     eax, blankspace
        call    print_string
        inc     ecx                     ;increment ecx

        jmp     printing_part2          ;do it again

search_print:
        xor     ecx, ecx                ;clear ecx

        call    print_nl
        mov     eax, searchArray
        call    print_string
        call    read_int                ;asks for the value
        mov     [searchInput], eax
        mov     edx, [searchInput]      ;store searchvalue in edx for comparing in search_find

search_find:
        ;comparing ecx with arraysize if it reaches the size
        cmp     ecx, [arraysize]
        jg      outside_print           ;if it doesnt, goes to outside_print

        mov     eax, [array1 + 4 * ecx] ;gets each value in the array and stores it inside eax
        cmp     eax, edx                ;compare the values in the array and the value being asked by the user
        je      elementfound            ;if the element is found, jump to element_found

        inc     ecx                     ;increments ecx
        jmp     search_find             ;back at it again

outside_print:
        mov     eax, outsideInput       ;prints message
        call    print_string
        jmp     search_print            ;runs search_find again for another trial

elementfound:
        ;prints everything and ends the prohgrahm.
        mov     eax, [searchInput]
        call    print_int
        mov     eax, elementAtArray
        call    print_string
        mov     eax, ecx
        call    print_int
        mov     eax, closebrack
        call    print_string

        jmp     finale

outside_printstart:
        mov     eax, outsideprintstart
        call    print_string
        call    print_nl

        jmp     ask_size

finale:
        ;ends prohgrahm
        call    print_nl

        popa
        leave
        ret

