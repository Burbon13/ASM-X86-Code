;Se da un fisier text. Sa se citeasca continutul fisierului, sa se determine cifra cu cea mai mare frecventa si sa se afiseze acea cifra impreuna cu frecventa acesteia. 
;Numele fisierului text este definit in segmentul de date.
bits 32

global start

extern exit, fopen, fread, scanf, fclose, contorizare,getmax, printf
import fopen msvcrt.dll
import fread msvcrt.dll
import scanf msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll
import exit msvcrt.dll


segment data use32 public data
    fisier db "text6.txt", 0
    mod_acces db "r", 0
    handle dd -1
    buffer resb 105
    contor times 10 db 0
    format db "Cifra %d apare de %d ori!", 0
    
    
segment code use32 public code
    start:
        
        ;deschiderea fisierului
        push dword mod_acces
        push dword fisier
        call [fopen]
        add esp, 4 * 2
        
        cmp eax, 0
        je final
        
        mov dword [handle], eax
        ;am deschis cu succes fisierul
        
        bucla_citire:
            ;citire pe bucati fread(buffer,1,100,handle)
            push dword [handle]
            push dword 100
            push dword 1
            push dword buffer
            call [fread]
            add esp, 4 * 4
                
            cmp eax, 0
            je cleanup ;am terminat de citit fisierul
            
            push dword contor
            push dword buffer
            call contorizare ;contorizare(sir, contor)
            add esp, 4 * 2
            
            jmp bucla_citire
            
    cleanup:
        ;inchidem fisierul
        push dword [handle]
        call [fopen]
        add esp, 4
        
        ;apelam calculul 
        push dword contor
        call getmax ;getmax(contor) -> eax = cifra, ebx = nr de aparitii
        add esp, 4
        
        ;afisam
        push ebx
        push eax
        push dword format
        call [printf]
        add esp, 4 * 3
        
    final:
        push dword 0
        call [exit]