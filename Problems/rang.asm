bits 32

global rangT

segment data use32 public data
    haha dd 0ff000000h, 0ff0000h, 0ff00h, 0ffh
    poz dd 24,16,8, 0
    val_min dd 0ffh
    rang dd -1
    
    
segment code use32 public code
    rangT:
        mov dword [val_min], 0ffh
        mov dword [rang], -1
        
        mov eax, [esp + 4]
        mov ecx, 1
        mov esi, haha
        
        bucla_scap:
            test eax, dword [esi]
            jnz exit_0 ;daca e zero mai tre sa mergen
            
            inc ecx
            add esi, 4
            
            jmp bucla_scap
            
        exit_0:
        
        cauta_min:
            mov eax, [esp + 4]
            cmp ecx, 5
            jae final
                        
            push ecx
            mov ecx, dword [esi]
            and eax, ecx
            mov ecx, dword [esi+16]
            shr eax, cl
            pop ecx
            
            cmp eax, dword [val_min]
            jae negasit_min
            
            mov dword [val_min], eax
            mov dword [rang], ecx
            
            negasit_min:
                inc ecx
                add esi, 4
                jmp cauta_min
            
            
    final:
        mov ebx, dword [rang]
        mov eax, dword [val_min]
            
        ret