
%include "asm_io.inc"

segment .data
shift_prompt_left db    "Shifting Left",0
shift_prompt_right db   "Shifting Right",0


segment .bss

 
segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        mov     ebx, 0
        mov     bl,0x7F

        dump_regs 1               ; dump out register values

;========= shifting left
        call    print_nl
        mov     eax, shift_prompt_left
        call    print_string
        call    print_nl
        call    print_nl

        shl     ebx, 1
        dump_regs 1               ; dump out register values

;========= shifting left 
        call    print_nl
        mov     eax, shift_prompt_left
        call    print_string
        call    print_nl
        call    print_nl

        shl     ebx, 1
        dump_regs 1               ; dump out register values

;========= shifting left bl only 
        call    print_nl
        mov     eax, shift_prompt_left
        call    print_string
        call    print_nl
        call    print_nl

        shl     bl, 1
        dump_regs 1               ; dump out register values

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


