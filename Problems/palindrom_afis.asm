;palindrom_afis(sir,st,dr)
bits 32


extern printf
import printf msvcrt.dll


segment data use32 public data
    format_d db "%d ", 0
    format_c db "%c", 0
    NL equ 10
    
    
segment code use32 public code
    global palindrom_afis
    palindrom_afis:
        
        mov esi, [esp + 4]
        mov eax, [esp + 8]
        add esi, eax ;el din stanga
        
        mov edi, [esp + 4]
        mov eax, [esp + 12]
        add edi, eax ;el din dreapta
        
        afis_r:
            
            cmp esi, edi
            ja final
            
            mov eax, 0
            mov al, byte [esi]
            push eax
            push dword format_d
            call [printf]
            add esp, 4 * 2
            
            inc esi
            
            jmp afis_r
        
    final:
        push dword NL
        push dword format_c
        call [printf]
        add esp, 4 * 2
        
        ret