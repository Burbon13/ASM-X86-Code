bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a db 1 ;byte
    b db 2 ;byte
    c db 3 ;byte
    e dw 6  ;double word
    x dq 4  ;quad word
    
segment code use32 class=code
start:
    ;(a+a+b*c*100+x)/(a+10)+e*a
    ;interpretare fara semn
    
    mov al, [b]
    mul byte [c] ;ax = b*c
    mov dx, 100
    mul dx       ;dx:ax = b*c*100
    
    mov bx, 0
    mov bl, [a] ;bx = a
    
    add bx, bx  ;bx = a + a
    add ax, bx
    adc dx, 0   ;dx:ax = a + a + b*c*100
    
    push dx
    push ax
    pop eax ;eax = a+a+b*c*100
    mov edx, 0
    
    mov ebx, dword [x]
    mov ecx, dword [x+4] ;ecx:ebx = x
    
    add eax, ebx
    adc edx, ecx   ;edx:eax = a+a+b*c*100+x
    
    mov ebx, 0
    mov bl, [a]
    add ebx, 10 ;ebx=a+10
    
    div ebx ;eax = (a+a+b*c*100+x)/(a+10)
    
    mov ebx, eax
    
    mov eax, 0
    mov al, [a] ;eax = a
    mul dword [e] ;edx:eax = e*a
    
    add eax, ebx
    adc edx, 0 ;edx:eax = (a+a+b*c*100+x)/(a+10) + e*a
    
    push dword 0
    call [exit]