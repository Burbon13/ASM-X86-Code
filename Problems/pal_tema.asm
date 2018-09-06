bits 32

global start

extern fopen, fscanf, fclose, printf, nr_pal, exit
import exit msvcrt.dll
import fopen msvcrt.dll
import fscanf msvcrt.dll
import printf msvcrt.dll
import fclose msvcrt.dll


segment data use32 public data
    fisier db "pal_tema.txt", 0
    format db "%d ", 0
    mod_acces db "r", 0
    handle dd -1
    nr dd 0
    
    
segment code use32 public code
    start:
        ;fopen(fisier,mod)
        push dword mod_acces
        push dword fisier
        call [fopen]
        add esp, 4 * 2
        
        cmp eax, 0
        je final
        mov [handle], eax
        ;deschis fisierul
        
        repeta:
            ;fscanf(handler,format,pointer);
            push dword nr
            push dword format
            push dword [handle]
            call [fscanf]
            add esp, 4 * 3
            
            cmp eax, -1
            je final
            
            push dword [nr]
            call nr_pal
            add esp, 4
            
            cmp eax, 1
            jne repeta
            
            push dword [nr]
            push dword format
            call [printf]
            add esp, 4 * 2
            
            jmp repeta
        
    final:
        push dword [handle]
        call [fclose]
        add esp, 4
    
        
        push dword 0
        call [exit]