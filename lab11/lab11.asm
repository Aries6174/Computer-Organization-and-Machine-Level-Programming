; Author: Adrian Joel Jaspa
; Subject: CMSC 131
;
; file: lab11.asm
; Tenth Assembly Lab. Enter a size of an array as well as the values of of each array. After inputting all values,
; print the line of array first then ask the user which array do they want to search.
;
; Using Linux and gcc:
; nasm -f elf lab11.asm
; gcc -m32 -o lab11 driver.c lab11.o asm_io.o -no-pie
; ./lab11

%include "asm_io.inc"
%define MAX 100
%define SYS_READ 3
%define STDIN 0
section .data  

border1 db          "--------------------------------------------------", 0
msgBorder db        "Find the maximum occurring character in a string", 0
stringReq db        "Enter a string : ", 0
stringOut1 db       "The Highest frequency of character '", 0
stringOut2 db       "' appears number of times is ", 0

section .bss

string1 resb    MAX			; string array
string2 resb    MAX			; counter of appearances in string1 (array counter)
length  resd    1

section .text 
    global asm_main

asm_main:
    ; set-up routine
    enter   0, 0                    ; set up
    pusha

Title_Print:

    call    print_nl


Request:
    ; includes spaces, and enter keys
    ; mov     eax, SYS_READ
    ; mov     ebx, STDIN
    ; mov     ecx, string1
    ; mov     edx, MAX
    ; int     0x80

    mov     [string1], eax
    mov     edx, MAX

    ; Find the position of the newline character and replace it with null terminator
    mov     edi, [string1]
    xor     eax, eax

; Convert the string to lowercase
    mov     esi, [string1]       ; esi points to the input string
    
to_lowercase_loop:
    mov     al, [esi]            ; load the current character
    cmp     al, 0                ; check if it's the null terminator
    je      find_newline         ; if it is, exit the loop
    cmp     al, 'A'              ; compare with A
    jl      not_uppercase        ; if less than 'A', not an uppercase letter
    cmp     al, 'Z'              ; compare with Z
    jg      not_uppercase        ; if greater than 'Z', not an uppercase letter
    
    add     al, 32               ; convert to lowercase by adding 32
    mov     [esi], al            ; store the converted character back

not_uppercase:

    inc     esi                  ; move to the next character
    jmp     to_lowercase_loop   ; repeat the loop

find_newline:
    cmp     byte [edi], 0
    je      newline_found
    inc     edi
    inc     eax
    jmp     find_newline
newline_found:
    mov     byte [ecx + eax - 1], 0

    dec     eax               ; decrement because Enter key counts as a character
    mov     [length], eax

clears:
    ; clearing all registers used just to make sure.
    xor     eax, eax
    xor     edi, edi
    xor     ecx, ecx
    xor     ebx, ebx
    xor     edx, edx

    ; Finding the most frequent character in a string
    mov     esi, [string1]     ; gets the address of the string
    xor     edi, edi         ; edi will store the most famous(greatest frequency) character in the string


;	Finding the most frequent character in a string
;	1. Ask for the string
;	2. Initialize the array counter that is a copy the array string. 
;	3. For each character in array string we:
;		a. Let i be the index of the character currently being used.
;		b. Perform a similar feature in Data structures called getNext() to look ahead up to the end of the string.
;		c. If its similar, increment i in the array counter, then take mark it with a blank. This blank will represent that
;			the character in that string is already been counted.
;		d. If the loop encounters a blank(including spaces), then it will automatically go to the next char.
;	4. For the character that is famous, create looping if-statement that if the current character is lesser than the next character.
;		If less than then update that output to be that character.

loop1:
    cmp     ecx, [length] ; compares the length of the string with the counter
    je      print_start     ; jumps to printing of finale

    push    ecx             ; ecx will serve as the first counter

    mov     dl, byte [esi]  ; move current character being compared
    push    esi             ; save index of that character
    inc     esi             ; increment to compare it to the next one. Since we don't have to compare the character with itself.

    mov     bx, 0           ; counter for the element that is currently used
    cmp     dl, ' '         ; if blank is encountered
    je      move_to_next

    ; since it starts at 0 we
    inc     bx
    inc     ecx

pass:
    ; Checks if the end of the string is reached
    cmp     ecx, [length]
    je      next_char

    xor     eax, eax

    mov     al, byte[esi]

    cmp     al, ' '
    je      Incrementing

    cmp     dl, al
    je      its_a_match
    
Incrementing:
    inc     esi             ;moves to the next character
    inc     ecx             ;increment the counter
    jmp     pass        

its_a_match:
    mov     byte [esi], ' ' ;duplicated character
    inc     bx              ;increment count of the current character

    jmp     Incrementing

next_char:
    cmp     di, bx
    jg      move_to_next     ; if di > bx
    mov     di, bx           ; else: replace di with bx

move_to_next:
    pop     esi              ; restoring the pointer
    inc     esi              ; we get the new character
    pop     ecx              ; restoring counter
    mov     [string2 + 4 * ecx], bx ; Storing that frequency in the array counter
    inc     ecx              ; move to the next character

    jmp     loop1            ; do it all again

print_start:
    ; remember di is the most famous character in the string
    xor     ecx, ecx
    mov     eax, stringOut1
    call    print_string
    mov     esi, [string1]

printing_char1:
    cmp     ecx, [length]
    je      printing_finale

    mov     eax, [string2 + 4 * ecx]
    cmp     eax, edi
    jne     printing_char2

    mov     al, byte [esi]
    cmp     al, ' '
    je      printing_char2

    call    print_char
    mov     eax, ' '
    call    print_char

printing_char2:
    inc     ecx
    inc     esi
    jmp     printing_char1

printing_finale:
    mov     eax, stringOut2
    call    print_string
    mov     eax, edi
    call    print_int

    jmp     finale

finale:
    ; ends program
    call    print_nl

    popa
    leave
    ret
