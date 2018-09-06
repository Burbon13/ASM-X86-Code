bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 5 ;word
    c dw 1 ;word
    d db 2 ;byte
    b db 3 ;byte
    e dd 10;double word
    x dq 4 ;quad word
    
segment code use32 class=code
start:
    ;x/2+100*(a+b)-3/(c+d)+e*e
    ;interpretare cu semn
    
    mov eax, dword [x]
    mov edx, dword [x+4]
    mov ecx, 2
    div ecx 
    mov ebx, eax ;ebx = x/2
    
    mov al, [b]
    cbw ;ax = b
    add ax, [a] ;ax = b + a
    mov dx, 100
    mul dx ;dx:ax = 100*(a+b)
    push dx
    push ax
    pop eax
    add ebx, eax ;ebx = x/2 + 100*(a+b)
    
    mov al, [d]
    cbw ;ax = d
    add ax, [c] ;ax = c + d
    mov cx,ax ;cx = c+d
    mov ax, 3
    mov dx, 0
    div cx ;ax = 3/(c-d)
    cwde ;eax = 3/(c-d)
    sub ebx,eax ;ebx = x/2 + 100*(a+b) - 3(c-d)
    
    mov eax, [e]
    mul eax ;edx:eax = e * e
    
    add eax,ebx
    adc edx, 0 ;edx:eax = x/2 + 100*(a+b) - 3(c-d) + e * e
    
    
    push dword 0
    call [exit]