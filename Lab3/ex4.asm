bits 32

global start

extern exit 
import exit msvcrt.dll

segment data use32 class=data
    a dw 3 ;2 word
    b db 55 ;1 byte
    c dw 5 ;2 word
    d dd 2 ;4 double word
    ;3 + 55 / 3 + 6 / 3
    ;3 + 18 + 2 = 23
    
segment code use32 class=code
start:
    ;a + b / (c - 2) + d * 3 / a
    
    mov al, [b]
    mov ah, 0
    mov dx, 0  ;dx:ax = b
    
    mov bx, [c]
    sub bx, 2  ;bx = c - 2
    
    div bx ;ax = b / (c - 2)
    
    add ax, [a] ;ax = a + b / (c - 2)
    
    mov bx, ax ;bx = a + b / (c - 2)
    
    mov eax, 3
    mul dword [d] ;edx:eax = d * 3
    
    mov ecx, 0
    mov cx, [a]
    div ecx  ;eax = d * 3 / a
    
    mov ecx, 0
    mov cx, bx ;exc = a + b / (c - 2)
    
    add eax, ecx ; a + b / (c - 2) + d * 3 / a
    
    push dword 0
    call [exit]