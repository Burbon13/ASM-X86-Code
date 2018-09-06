bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 10 ;byte
    b dd 5  ;double word
    c dq 8  ;quad word
    
segment code use32 class=code
start:
    ;c+(a*a-b+7)/(2+a) reprezentare fara semn
    ;8 + (100 - 5 + 7) / (12)
    ;8 + 102/12
    ;16
    
    mov al, [a]
    mul byte [a] ;ax = a * a
    mov dx, 0    ;dx:ax = a * a
    
    sub ax, word [b]
    sbb dx, word [b+2] ;dx:ax = a * a - b
    
    add ax, 7
    adc dx, 0  ;dx:ax = a * a - b + 7
    
    mov bh, 0
    mov bl, [a] ;bx = a
    add bx, 2 ;bx = a + 2
    
    div bx ;ax = (a*a-b+7)/(a+2)
    
    mov ebx, 0
    mov bx, ax ;ebx = (a*a-b+7)/(a+2)
    
    mov eax, dword [c]
    mov edx, dword [c+4]
    
    add eax, ebx
    adc edx, 0 ;edx:eax = c + (a*a-b+7)/(a+2)
    
    push dword 0
    call [exit]