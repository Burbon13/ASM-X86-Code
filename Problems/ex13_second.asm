bits 32

segment data use32 public data
    s1 dd 0
    ls1 dd 0 
    s2 dd 0
    ls2 dd 0
    sa resb 100

segment code use32 public code
    global sufix
    sufix:
        
        mov eax, [esp+4]
        mov [s1], eax
        mov eax, [esp+8]
        mov [ls1], eax
        mov eax, [esp+12]
        mov [s2], eax
        mov eax, [esp+16]
        mov [ls2], eax
        
        mov ecx, [ls1]
        cmp ecx, [ls2]
        jbe next_modifica
        
        mov ecx, [ls2]
        
    next_modifica:
            
        mov esi, [s1]
        add esi, [ls1]
        sub esi, 1
        
        mov edi, [s2]
        add edi, [ls2]
        sub edi, 1
        
        repeta:
            
            cmp esi, [s1]
            jb creare
            cmp edi, [s2]
            jb creare
            
            mov al, [esi]
            mov ah, [edi]
            cmp al, ah
            jne creare
            
            dec esi
            dec edi
        
        jmp repeta
            
    creare:
    
        
        mov edi, sa
        inc esi
        
        repetaaaaa:
            
            mov eax, [s1]
            add eax, [ls1]
            cmp esi, eax
            je final
            
            movsb
            
        jmp repetaaaaa
        
        
    final:
        mov ecx, sa
        ret