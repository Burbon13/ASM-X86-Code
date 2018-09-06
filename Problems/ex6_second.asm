bits 32


segment code use32 public code
    global conc
    conc:
        
        mov esi, [esp + 4]
        mov edi, [esp + 8]
        
        muta_it:
        
            cmp byte [edi], 0
            je muta
            
            inc edi
            
            jmp muta_it
            
        muta:
        
            cmp byte [esi], 0
            je final_conc
            
            movsb
            
            jmp muta
            
        
        final_conc:
            ret