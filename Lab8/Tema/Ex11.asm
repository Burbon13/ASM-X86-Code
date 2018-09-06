bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    s DD 12345678h, 1A2B3C4Dh, 0FE98DC76h
    ls equ ($ - s)/4
    rez resb ls
    
segment code use32 class=code
    start:
        mov esi, s
        mov edi, rez
        mov ecx, ls
        
        repeta:
            lodsd ;eax = ce vrem ; in al e ce vrem sa verificam
            mov al, ah
            mov ah, 0
            mov bl, 10
            div bl 
            cmp ah, 0
            je adauga
            jmp next
            
            adauga:
                sub esi, 4
                lodsd
                mov al, ah
                stosb
                jmp next
            
            next:
        loop repeta
        
        push dword 0
        call [exit]