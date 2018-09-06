bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    sir DD 12AB5678h, 1256ABCDh, 12344344h 
    ls equ $ - sir
    
segment code use32 class=code
    start:
        mov esi, sir
        mov ecx, ls
        
        loop1:
            mov eax, sir
            add eax, ls
            cmp esi, eax
            jae final_loop1
            
            mov edi, esi
            add edi, 4
            loop2:
                
                mov eax, sir
                add eax, ls
                cmp edi, eax
                jae final_loop2
                
                cmpsw
                cmpsw ;esi comparat cu edi
                
                jae swap
                sub esi, 2
                sub edi, 2
                jmp next
                
                swap:
                
                    sub edi, 2
                    sub esi, 2
                
                    lodsw;ax = cuvantul 
                    mov dx, ax ;bx primul cuvant
                    sub esi, 2
                
                    mov ebx, esi
                    mov esi, edi
                    lodsw       ;ax al doilea cuvant
                    mov esi, ebx
                
                    xchg esi, edi
                    stosw
                    sub edi, 2
                    xchg esi, edi
                
                    xchg ax, dx
                    stosw
                    sub edi, 2
                
                jmp next
                
            next:
                sub edi, 2
                sub esi, 2
                
                add edi, 4
                
            jmp loop2
            final_loop2:
            
            add esi, 4
            
        loop loop1
        final_loop1:
        
        push dword 0
        call [exit]
    