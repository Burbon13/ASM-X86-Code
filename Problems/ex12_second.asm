bits 32


segment data use32 public data
    sa resb 100


segment code use32 public code
    global conc
    conc:
        
        mov eax, [esp+4]
        mov ebx, [esp+8]
        mov ecx, [esp+12]
        mov edi, sa
        
        repeta:
            
            mov esi, eax
            movsb
            mov esi, ebx
            movsb
            inc eax
            inc ebx
        
        loop repeta
        
        mov eax, sa
        
        ret