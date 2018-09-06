bits 32

segment data use32 public data
    gst dd 0

segment code use32 public code
    global kmp_joke
    kmp_joke:
        
        mov eax, [esp+4] ;sirul de cautat
        mov ebx, [esp+8] ;sirul in care se cauta
        
        big_loop:
            
            cmp byte [ebx], 0
            je end_fnc
            
            mov esi, eax
            mov edi, ebx
            
            small_loop:
                
                cmp byte [esi], 0
                jne negasit
                
                inc dword [gst]
                jmp end_fnc
                
                negasit:
            
                    cmp byte [edi], 0
                    je end_fnc
                    
                    mov dl, byte [edi]
                    mov dh, byte [esi]
                    cmp dl, dh
                    jne end_sml
                    
                    inc edi
                    inc esi
                
            jmp small_loop
            end_sml:
            
            inc ebx
            
        jmp big_loop
        
    end_fnc:
        
        mov eax, [gst]
        ret