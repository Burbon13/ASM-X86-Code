bits 32

global start

extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    s1 db 1, 3, 6, 2, 3, 7
    s2 db 6, 3, 8, 1, 2, 5
    len equ $ - s2
    s3 times len db 0
    format db "%d ", 0
    
segment code use32 class=code
    start:
        mov esi, 0
        
    repeta:
        cmp esi, len
        je final.repeta
        
        mov al, [s1 + esi]
        mov ah, [s2 + esi]
        
        cmp al, ah
        jge caz2
        
    caz1:
        mov [s3 + esi], ah
        jmp cont
        
    caz2:
        mov [s3 + esi], al
        
    cont:
        add esi, 1
        jmp repeta
        
    final.repeta:
    
        ;push dword s3
        ;push dword format
        ;call [printf]
        ;add esp, 4 * 2
        
        mov esi, 0
    afisare:
        cmp esi, len
        je final.afisare
        
        pushad
        mov al, [s3+esi]
        cbw
        cwde
        push eax
        push dword format
        call [printf]
        add esp, 4 * 2
        
        popad
        add esi,1
        jmp afisare
    
    final.afisare:
        push dword 0
        call [exit]