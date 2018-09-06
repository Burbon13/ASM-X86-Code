;palindrom_verif(sir,st,dr)
bits 32


segment code use32 public code
    global palindrom_verif
    palindrom_verif:
        
        mov esi, [esp + 4]
        mov eax, [esp + 8]
        add esi, eax ;el din stanga
        
        mov edi, [esp + 4]
        mov eax, [esp + 12]
        add edi, eax ;el din dreapta
        
        mov eax, 1
        
        ripit:
            cmp esi, edi
            jae final
            
            mov bl, [esi]
            mov cl, [edi]
            cmp ebx, ecx
            jne negativ
            
            dec edi
            inc esi
            
            jmp ripit
    
    negativ:
        mov eax, 0
          
    final:    
        ret