bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 3 ;al
    b dd 10 ;eax
    c dq 4 ;edx:eax
    aux dw 0
    ; ...

; our code starts here
segment code use32 class=code
    start:
        ; Lab3 Pb1
        ; c+(a*a-b+7)/(2+a) 
        ; a-byte; b-doubleword; c-qword
        
        mov al, [a]
        imul byte [a] ;ax = a * a
        add ax, 7 ;ax = a*a + 7
        
        cwd ;dx:ax = a * a + 7
        sub ax, word [b] 
        sbb dx, word [b+2] ;dx:ax = a * a - b + 7
        
        mov bx,ax
        mov cx,dx
        
        mov al, [a]
        cbw ;ax = a
        add ax, 2 ;ax = a + 2
        
        mov [aux], ax
        
        mov ax, bx
        mov dx, cx 
        
        idiv word [aux] ;ax = (a*a-b+7)/(2+a) 
        cwde
        cdq ;edx:eax = ...
        
        add eax, dword [c]
        adc edx, dword [c+4]
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
