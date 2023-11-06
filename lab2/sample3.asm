
%include "asm_io.inc"

segment .data
rotate_prompt_left  db  "Rotating Left",0
rotate_prompt_right db  "Rotating Right",0
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

;========= Rotating left
        call    print_nl
        mov     eax, rotate_prompt_left
        call    print_string
        call    print_nl
        call    print_nl

        rol     ebx, 1
        dump_regs 1               ; dump out register values
        call    print_nl
        
;========= Rotating left
        call    print_nl
        mov     eax, rotate_prompt_left
        call    print_string
        call    print_nl
        call    print_nl

        rol     ebx, 1
        dump_regs 1               ; dump out register values
        call    print_nl


        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


