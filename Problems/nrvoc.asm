bits 32


segment data use32 public data
    vocale db "aeiouAEIOU", 0

segment code use32 public code
    global nrvoc
    nrvoc:
        
        mov edi, [esp + 4]
        mov ecx, 100
        mov edx, 0
        
        ripit:
            
            cmp byte [edi], 0
            je final_nrvoc
            
            mov esi, vocale
            
            rep_voc:
                
                cmp byte [esi], 0
                je end_rep_voc
                
                lodsb ;al avem litera
                
                cmp al, byte [edi]
                jne rep_voc
                
                inc edx
       
        end_rep_voc:
            
            inc edi
            loop ripit
            
        final_nrvoc:
        mov eax, edx
        ret