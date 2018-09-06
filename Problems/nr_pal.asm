bits 32


segment data use32 public data
    invers dd 0


segment code use32 public code
    global nr_pal
    nr_pal:
        mov dword [invers], 0
        mov ecx, 10
        mov edx, 0
        mov eax, dword [esp + 4]
        
        imparte:    
            
            cmp eax, 0
            je fin_imparte
            
            div ecx ;edx avem restul
            
            push eax
            mov ebx, edx
            mov eax, dword [invers]
            mul ecx
            add eax, ebx
            mov [invers], eax
            
            pop eax
            
            jmp imparte
            
        fin_imparte:
        
        mov eax, 0
        
        mov ebx, dword [esp + 4]
        cmp ebx, dword [invers]
        jne afara
        
        mov eax, 1
        
    afara:
        ret