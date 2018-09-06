;Sa se afiseze, pentru fiecare numar de la 32 la 126, valoarea numarului (in baza 8) si caracterul cu acel cod ASCII.
bits 32

global start

extern afish
extern exit
import exit msvcrt.dll

segment data use32 public data
    nr dd 32
    
    
segment code use32 public code
    start:
        mov eax, 32
        
        salt:
            push dword [nr]
            call afish
            add esp, 4
            mov eax, [nr]
            inc eax
            mov [nr], eax
            cmp eax, 126
            jne salt
            
            
        push dword 0
        call [exit]