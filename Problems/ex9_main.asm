;Se cere sa se citeasca de la tastatura un sir de numere, date in baza 16 (se citeste de la tastatura un sir de caractere si in memorie trebuie stocat un sir de numere).
bits 32

global start

extern exit, scanf, conv16
import exit msvcrt.dll
import scanf msvcrt.dll


segment data use32 public data
    format db "%s", 0
    sir resb 100
    

segment code use32 public code
    start:
        
        repeta:
            
           push dword sir
           push dword format
           call [scanf]
           add esp, 4 * 2
           
           cmp byte [sir], '!'
           je final_repeta
           
           push dword sir
           call conv16 ;returneaza in ebx numarul
           add esp, 4
           
           
            
        jmp repeta
        final_repeta:
        
        push dword 0
        call [exit]
        