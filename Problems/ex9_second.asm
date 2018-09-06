bits 32

segment code use32 public code
    global conv16
    conv16:
        
        mov esi, [esp + 4]
        mov ebx, 0
        mov eax, 0
        
        reptilian:
            
            lodsb ;salveaza in al caracterul
            
            cmp al, 0
            je fin_reptilian
            
            shl ebx, 4
            
            cmp al, '9'
            ja c_lit
            
            sub al, '0'
            add ebx, eax
            
        jmp reptilian
            
        c_lit:
            
            sub al, 'A'
            add al, 10
            add ebx, eax
            
        jmp reptilian
    fin_reptilian:
        
        ret