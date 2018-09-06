bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 5 ;word
    b db -2 ;byte
    c dd 3 ;double word
    x dq 4 ;quad word
    
segment code use32 class=code
start:
    ;(a*a+b+x)/(b+b)+c*c
    ;cu semn
    
    mov ax, [a]
    mul word [a] ;dx:ax = a*a
    
    mov bx,ax
    mov cx,dx ;cx:bx = a*a
    
    mov al, [b]
    cbw    
    cwd ;dx:ax = b
    
    add ax, bx
    adc dx, cx ;dx:ax = a*a+b
    
    push dx
    push ax
    pop eax
    cdq ;edx:eax = a*a+b
    
    add eax, dword [x]
    adc edx, dword [x+4] ;edx:eax = a*a+b+x
    
    mov ebx, eax
    
    mov al, [b]
    cbw
    cwde ;eax = b
    
    mov ecx, eax
    mov eax,ebx
    div ecx ;eax = (a*a+b+x) / (b+b)
    cdq ;edx:eax = -||-
    
    mov ebx, eax
    mov ecx, edx
    
    mov eax, [c]
    mul eax ;edx:eax = c*c
    
    add eax, ebx
    adc edx, ecx ;edx:eax = (a*a+b+x) / (b+b) + c*c
    
    
    push dword 0
    call [exit]