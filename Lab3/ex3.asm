bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 2
    b db 75
    c dw 17
    d db 4
    aux dw 0
    
segment code use32 class=code
start:
    ;a*b/(c+b) + b/(c+a*d)
    ;            d  w w b
    mov ax, 0
    mov al, [b]
    mul word [a] ;dx:ax = a * b
    
    mov bx, [c]
    add bl, byte [b] 
    adc bh, 0 ;bx = c - b
    
    div bx   ;ax = a * b / (c - b)
    mov [aux], ax
    
    mov al, [a]
    mov ah, 0  ;ax = a
    
    mov bl, [d]
    mov bh, 0
    mul bx ;dx:ax = a * d
    
    add ax, word[c]
    adc dx, 0   ;dx:ax = c + a * d
    
    push dx
    push ax
    pop ebx ;ebx = c + a * d
    
    mov eax, 0
    mov al, [b]
    mov edx, 0  ;edx:eax = b
    
    div ebx ;eax = b / (c+a*d)
    
    mov ebx, 0
    mov bx, [aux]
    
    add eax, ebx

    
    push dword 0
    call [exit]