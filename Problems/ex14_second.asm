bits 32

segment data use32 public data
    nrs dd 0
    
segment code use32 public code
    global conv
    conv:
        
        mov ecx, 0
        
        mov esi, [esp + 4]
        
        repet:
            
            lodsb ;pune in ah valoarea
            
            cmp al, 0
            je out_conv
            
            shl ecx, 1
            
            cmp al, '1'
            jne repet
            
            add ecx, 1
            
        jmp repet
        
        
    out_conv:
        ret