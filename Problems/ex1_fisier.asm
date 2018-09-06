;Se da un fisier text. Sa se citeasca continutul fisierului, sa se contorizeze numarul de vocale si sa se afiseze aceasta valoare. 
;Numele fisierului text este definit in segmentul de date.
bits 32

global start

extern exit, fread, printf, fopen, fclose, nrvoc
import exit msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll


segment data use32 public code
    fisier db "text.txt", 0
    acces db "r", 0
    hndl dd -1
    format_out db "%d", 0
    sir resb 105
    vocale dd 0
    
    
segment code use32 public code
    start:
        ;deschidere fisier
        push dword acces
        push dword fisier
        call [fopen]
        add esp, 4 * 2
        
        cmp eax, 0
        je final
        
        mov [hndl], eax
        
        ;citim bucatele acum
        bucla:
            ;citim 100 caractere
            push dword [hndl]
            push dword 100
            push dword 1
            push dword sir
            call [fread]
            add esp, 4 * 4
            
            cmp eax, 0
            je curat
            
            push dword sir
            call nrvoc ;nrvoc(sir) = nr de vocale din primele 100 de caractere de pe poz sir[0]
            add esp, 4
            
            add dword [vocale], eax
            
    curat:
        push dword [hndl]
        call [fclose]
        add esp, 4
        
    final:
        
        push dword [vocale]
        push dword format_out
        call [printf]
        add esp, 4 * 2
    
        push dword 0
        call [exit]