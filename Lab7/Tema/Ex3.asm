bits 32

global start

extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    S db 1, 2, 3, 4, 5, 6, 7, 8
    lenS equ $ - S
    D resb lenS
    format db "%d ", 0
    
segment code use32 class=code
    start:
        mov esi, 0
        mov edi, 0
        
    loop1:
        cmp esi, lenS
        jae continue1
        
        mov al, [S + esi]
        mov [D + edi], al
        
        inc edi
        add esi, 2
        
        loop loop1
        
    continue1:
        mov esi, 1
        
    loop2:
        cmp esi, lenS
        jae dada
        
        mov al, [S + esi]
        mov [D + edi], al
        
        inc edi
        add esi, 2
        
        loop loop2
    
    dada:
        mov esi, 0
        
    afish:
        cmp esi, lenS
        je final
        
        pushad
        
        mov al, [D + esi]
        cbw
        cwde
        push eax
        push dword format
        call [printf]
        add esp, 4 * 2
        
        popad
        inc esi
        loop afish
        
    final:
        push dword 0
        call [exit]