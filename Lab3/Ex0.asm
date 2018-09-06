bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 3
    b db 2
    c dw 4
    d db 5
    e dq 7
    f dw 2
    aux dd 0
    ; ...

; our code starts here
segment code use32 class=code
    start:
        ; (a+b/c-2*d-e)/(-f)
        
        mov al, [b]
        cbw ;ax = b
        cwd ;dx:ax = b
        idiv word [c] ;ax = b / c
        
        mov bx, ax
        mov al, 2
        imul byte [d]
        sub bx,ax ;bx = b / c - 2 * d
        
        mov ax,bx
        cwde ;eax = b/c-2*d
        add eax, dword [a] ;eax = a + b/c - 2 * d
        
        cdq ;edx:eax = eax
        sub eax, dword [e]
        sub edx, dword [e+4]
        
        mov ecx, edx
        mov ebx, eax ;ecx:ebx = edx:eax
        mov ax, [f]
        neg ax
        cwde ;eax = -f
        
        mov [aux], eax
        mov eax, ebx
        mov edx, ecx
        
        idiv dword [aux]
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
