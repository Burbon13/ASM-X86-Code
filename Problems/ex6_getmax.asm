bits 32


segment code use32 public code
    global getmax
    getmax:
        
        mov esi, [esp + 4]
        mov ebx, 0 ;nr_ap
        mov ecx, 0
        
        bucla_gas:  
        
            cmp ecx, 10
            je fin_getmax
            
            cmp bl, byte [esi + ecx]
            jae negasit
            
            mov bl, byte [esi + ecx]
            mov eax, ecx
            
            negasit:
            
            inc ecx
            
            jmp bucla_gas
        
        fin_getmax:
            ret