bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 2147400000
    b dd 2147400000

; our code starts here
segment code use32 class=code
    start:
        
        mov eax, [a]
        cdq ;edx:eax = a
        
        mov ecx,edx
        mov ebx,eax ;ecx:edx = a
        
        mov eax, [b]
        cdq ;edx:eax = b
        
        add eax,ebx
        adc edx,ecx
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
