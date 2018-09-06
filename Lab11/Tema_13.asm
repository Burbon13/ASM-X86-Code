;Se da un fisier text. Sa se citeasca continutul fisierului, sa se determine litera mare (uppercase) cu cea mai mare frecventa si sa se afiseze acea litera, impreuna cu frecventa acesteia. 
;Numele fisierului text este definit in segmentul de date.
bits 32

global start

extern exit, fopen, fclose, fread, printf
import exit msvcrt.dll 
import fopen msvcrt.dll 
import fread msvcrt.dll 
import fclose msvcrt.dll 
import printf msvcrt.dll

segment data use32 class=data
    nume_fisier db "input.txt", 0   ; numele fisierului care va fi deschis
    mod_acces db "r", 0             ; modul de deschidere a fisierului; r - pentru scriere. fisierul trebuie sa existe 
    descriptor_fis dd -1            ; variabila in care vom salva descriptorul fisierului - necesar pentru a putea face referire la fisier
    nr_car_citite dd 0              ; variabila in care vom salva numarul de caractere citit din fisier in etapa curenta
    len equ 100                     ; numarul maxim de elemente citite din fisier intr-o etapa
    buffer resb len                 ; sirul in care se va citi textul din fisier
    vec_ap times 27 db 0
    nr_ap dd 0
    litera dd 0
    format db "%c de atatea ori: %d", 0

segment code use32 class=code
    start:
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        cmp eax, 0                  
        je final
        
        mov [descriptor_fis], eax
        
        parsare:
            push dword [descriptor_fis]
            push dword len
            push dword 1
            push dword buffer
            call [fread]
            add esp, 4*4
            
            cmp eax, 0
            je cleanup
            
            mov ecx, eax
            mov eax, 0
            mov esi, buffer
            
            parcurgere:
                lodsb 
                
                cmp al, 'A' 
                jb next_parc
                cmp al, 'Z'
                ja next_parc
                
                sub al, 'A'
                mov bl, [vec_ap + eax]
                add bl, 1
                mov [vec_ap + eax], bl
                
                next_parc:
                    loop parcurgere
            
            jmp parsare
            
        cleanup:
            push dword [descriptor_fis]
            call [fclose]
            add esp, 4
            
            mov ecx, 0
            mov eax, 0
            
            cautare_max:
                
                mov al, [vec_ap + ecx]
                cmp eax, [nr_ap]
                
                jna nu_gasit
                
                mov [litera], ecx
                mov [nr_ap], eax
                
                nu_gasit:
                    inc ecx
                    cmp ecx, 26
                    je final
                    jmp cautare_max
        
        final:
            push dword [nr_ap]
            mov ecx, [litera]
            add ecx, 65
            push ecx
            push dword format
            call [printf]
            add esp, 4 * 3
            
            push dword 0
            call [exit]