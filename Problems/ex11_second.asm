bits 32

segment code use32 public code
    global convert
    convert:
        
        mov eax, 0
        mov esi, [esp + 4]
        
        repeta:
            
            cmp byte [esi], 0
            je ies_convert
            
            shl eax, 1
            
            cmp byte [esi], '1'
            jne chestie
            
            inc eax
            
        chestie:
            inc esi
             
        jmp repeta
        
    ies_convert:
        ret
    
    