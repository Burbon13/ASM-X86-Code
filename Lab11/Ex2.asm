bits 32

global start

extern exit, fopen, fclose, fread, printf
import exit msvcrt.dll 
import fopen msvcrt.dll 
import fread msvcrt.dll 
import fclose msvcrt.dll 
import printf msvcrt.dll

segment data use32 class=data
    difM db 0
    desc2 dd -1
    sc db "w", 0
    nume_fisscriere db "transformat.txt", 0
    nume_fisier db "input.txt", 0
    mod_acces db "r", 0
    descriptor dd -1
    sir times 91 db 0
    lsir equ $ - sir
    c db 'a'
    numar_aparitii db 0
    n db 3
    este_egal db "Este egal", 0
    nu_egal db "Nu este egal", 0
    
segment code use32 class=code
    start:
        push dword sc
        push dword nume_fisscriere
        call [fopen]
        add esp, 4 * 2
        
        cmp eax, 0
        je, final
        
        final:
            push dword 0
            call [exit]