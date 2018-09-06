;Sa se copieze octetii inferiori wordurilor care sunt divizibili cu 3 intr-un sir destinatie
; esi-si : indexi ptr siruri sursa, edi-di : indexi ptr siruri destinatie
bits 32

global start

extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    s dw 13h,34h,1234h,0ch
    ls equ $ - s 
    d times ls db 0 
    ld dd 0
    mesaj db "%x"

segment code use32 class=code
    start:
        mov esi, 0
        mov edi, 0
        
    for.sir:
        cmp esi, ls
        je end.for
        
        mov al, [s+esi]
        cbw
        mov bl, 3
        div bl
        
        cmp ah, 0
        jnz next
        ;am gasit multiplu de 3
        mov al, [s+esi]
        mov [d+edi], al
        add edi, 1
        
    next:
        add esi, 2
        jmp for.sir
        
    end.for:
        mov [ld], edi
    
        mov esi, 0
        
    for.afis:
        cmp esi, [ld]
        je end.afis
        
        pushad
        mov al, [d+esi]
        cbw
        cwde
        push eax
        push dword mesaj
        call [printf]
        add esp, 4 * 2
        popad
        add esi,1
        jmp for.afis
        
    end.afis:
        push dword 0
        call [exit]