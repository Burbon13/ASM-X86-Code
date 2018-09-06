bits 32


segment data use32 public data
    cifre db "0123456789", 0


segment code use32 public code
    global contorizare
    contorizare:
        
        mov esi, [esp + 4] ;sirul in care cautam
        mov edi, [esp + 8] ;sirul contor pe care il actualizam
        mov ecx, 100
        mov eax, 0
        
        bucla_contor:
            
            lodsb ;al - caracterul actual
            
            cmp al, '0'
            jb continue
            
            cmp al, '9'
            ja continue
            
            ;am gasit cifraaa
            sub al, '0'
            inc byte [edi + eax]
            
            continue:
                loop bucla_contor
        
        ret