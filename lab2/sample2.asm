
%include "asm_io.inc"

segment .data
shift_prompt_left   db  "Shifting Arithmetic Left",0
shift_prompt_right  db  "Shifting Arithmetic Right",0
num_pompt           db  "The number in EBX is: ",0
reset_prompt        db  "Resetting EBX",0


segment .bss

 
segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        mov     ebx,0x8FFFFFFF

        dump_regs 1               ; dump out register values
        call    print_nl
        
        mov     eax, num_pompt
        call    print_string
        mov     eax, ebx
        call    print_int
        call    print_nl

;========= shifting arithmetic left
        call    print_nl
        mov     eax, shift_prompt_left
        call    print_string
        call    print_nl
        call    print_nl

        sal     ebx, 1
        dump_regs 1               ; dump out register values
        call    print_nl
        
        mov     eax, num_pompt
        call    print_string
        mov     eax, ebx
        call    print_int
        call    print_nl

;========= Resetting ebx
        call    print_nl
        mov     eax, reset_prompt
        call    print_string
        call    print_nl
        
        mov     ebx,0x8FFFFFFF

;========= shifting arithmetic right
        call    print_nl
        mov     eax, shift_prompt_right
        call    print_string
        call    print_nl
        call    print_nl

        sar     ebx, 1
        dump_regs 1               ; dump out register values
        call    print_nl
        
        mov     eax, num_pompt
        call    print_string
        mov     eax, ebx
        call    print_int
        call    print_nl

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


