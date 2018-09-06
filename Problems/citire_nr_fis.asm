bits 32

global start

extern exit, fopen, fscanf, printf
import exit msvcrt.dll
import fopen msvcrt.dll
import fscanf msvcrt.dll
import printf msvcrt.dll


segment data use32 class=data
    fisier db "palindrom.txt", 0
    mod_acces db "r", 0
    handler dd -1
    format db "%d ", 0
    nr dd 0
    
    
segment code use32 class=code  
    start:
        
        push dword mod_acces
        push dword fisier
        call [fopen]
        add esp, 4 * 2
        
        cmp eax, 0
        je final
        mov [handler], eax
        
        bucla:
            ;Module: main, citire, verificare palindrom, afisare secventa!
            ;
            ;
            
            
            ;fscanf(handler,format,varia...)
            push dword nr
            push dword format
            push dword [handler]
            call [fscanf]
            add esp, 4 * 3
            
            cmp eax, -1
            je final
            
            push dword [nr]
            push dword format
            call [printf]
            add esp, 4 * 2
            
            jmp bucla
        
    final:
        push dword 0
        call [exit]