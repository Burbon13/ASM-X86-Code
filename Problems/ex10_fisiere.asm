;Sa se citeasca de la tastatura un nume de fisier si un text. Sa se creeze un fisier cu numele dat in directorul curent si sa se scrie textul in acel fisier. 
;Observatii: Numele de fisier este de maxim 30 de caractere. Textul este de maxim 120 de caractere.
bits 32

global start

extern exit, scanf, fopen, fprintf, fclose, gets
import exit msvcrt.dll
import scanf msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
import gets msvcrt.dll


segment data use32 class=data
    handle dd -1
    fisier resb 32
    text resb 122
    format_in db "%s", 0
    mod_acces db "w+", 0
    format_out db "%s --- %s", 0
    
    
segment code use32 class=code
    start:
        
        push dword fisier
        push dword format_in
        call [scanf]
        add esp, 4 * 2
        
        ;read(buffer,1,120)
        push dword text
        call [gets]
        call [gets]
        add esp, 4
            
        push dword mod_acces
        push dword fisier
        call [fopen]
        add esp, 4 * 2
        
        cmp eax, 0
        je final
        mov [handle], eax
        
        ;fprintf(handle, format, variables)
        push dword text
        push dword fisier
        push dword format_out
        push dword [handle]
        call [fprintf]
        add esp, 4 * 4
        
    final:
        push dword 0
        call [exit]