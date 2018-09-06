;Sa se determine suma elementelor unui sir de word-uri
;d dw 12h,34h,1234h,0ah
bits 32

global start

extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    d dw 1,2,3,4
    ld equ ($ - d) 
    rez dw 0
    af db "%d"
    
segment code use32 class=code
    start:
        mov esi, 0
        mov ebx, 0
        
    s_for:
        cmp esi,ld
        je f_for
        mov ax, [d+esi]
        cwde
        add ebx, eax
        add esi, 2
        jmp s_for
        
        
    f_for:
    
        push ebx
        push dword af
        call [printf]
        add esp, 4 * 2
        
        push dword 0
        call [exit]