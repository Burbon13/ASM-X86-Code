bits 32


extern fopen, fscanf, fclose
import fopen msvcrt.dll
import fscanf msvcrt.dll
import fclose msvcrt.dll


segment data use32 public data
    fisier db "palindrom.txt", 0
    format db "%d", 0
    mod_acces db "r", 0
    handle dd -1
    adresa_sir dd 0
    len dd 0
    nr dd 0
    
    
segment code use32 public code
    global palindrom_citire
    palindrom_citire:
        mov eax, dword [esp + 4] ;sirul unde salvam
        mov [adresa_sir], eax
        
        ;fopen(fisier,mod)
        push dword mod_acces
        push dword fisier
        call [fopen]
        add esp, 4 * 2
        
        cmp eax, 0
        je final
        mov dword [handle], eax
        ;deschis fisierul
        
        repeta:
            ;fscanf(handler,format,pointer);
            mov eax, [adresa_sir]
            add eax, dword [len] ;eax = sir[len]
            push eax
            push dword format
            push dword [handle]
            call [fscanf]
            add esp, 4 * 3
            
            cmp eax, -1
            je final
            
            inc dword [len]
            jmp repeta
        
    final:
        push dword [handle]
        call [fclose]
        add esp, 4
    
        mov eax, dword [esp + 8]
        mov ebx, dword [len]
        mov [eax], ebx
        
        ret