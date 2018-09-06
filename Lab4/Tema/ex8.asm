bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw -1 ;word
    b dw 4 ;word
    c db 20 ;byte
    d db 3 ;byte
    e dd 5 ;double word
    x dq 3 ;quad word
    
segment code use32 class=code
start:
    ;1/a+200*b-c/(d+1)+x/a-e
    ;cu semn
    
    mov ax, 1
    cwd
        
    idiv word [a] ;ax = 1/a
    
    mov bx, ax ;bx=1/a
    
    mov ax, 200
    imul word [b] ;dx:ax = 200*b
    
    push bx
    
    mov bx,ax
    mov cx,dx
    
    pop ax
    
    cwd ;dx:ax = 1/a
    
    add ax, bx
    adc dx, cx       ;dx:ax = 1/a+b*200
    
    push dx
    push ax
    pop ebx        ;ebx=1/a+b*200
    
    mov al, [c]
    cbw         ;ax = c
    
    mov dl, [d]
    add dl, 1   ;dl = d + 1
    
    idiv dl   ;al = c/(d+1)
    
    cbw
    cwde    ;eax = c/(d+1)
    
    sub ebx, eax ;ebx = 1/a+b*200 - c/(d+1)
    
    sub ebx, dword [e]  ;ebx = 1/a+b*200 - c/(d+1) - e
    
    mov al, [a] 
    cbw
    cwde  ;eax = a
    mov ecx, eax
    
    mov eax, dword [x]
    mov edx, dword [x+4] ;edx:eax = x
    
    idiv ecx ;eax = x/a
    
    add ebx, eax ;ebx = 1/a+b*200 - c/(d+1) + x/a - e
    
    push dword 0
    call [exit]