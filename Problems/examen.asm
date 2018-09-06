;se da un sir de dworzi definit in data segment
;sa se determine rangurile octetilor de valoare minima din fiecare double word si sa se determine suma acesot octeti
;sirul rangurilor si suma se vor afisa in fisierul 'iesire.txt' pe linii separate
;ex: 1234a678h
bits 32

global start

extern exit, fopen, fprintf, fclose, rangT
import exit msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll


segment data use32 public data
    sir dd 1234a678h, 13240678h, 1ac3b47dh, 0fedc9876h, 98h, 7898h, 780098h
    lensir equ $ - sir
    fisier db "iesire.txt", 0
    mod_acces db "w", 0
    handle dd -1
    it dd 0
    suma dd 0
    format db "%d ", 0
    nl db "%c", 0
    aux dd 0
    

segment code use32 public code
    start:
        ;deschidere fisier
        push dword mod_acces
        push dword fisier
        call [fopen]
        add esp, 4 * 2
        
        cmp eax, 0
        je final
        mov dword [handle], eax
        ;deschis cu succes fisierul
        
        mov ecx, 0
        mov esi, sir
        
        bucla:
            lodsd 
            mov dword [aux], esi
            mov dword [it], ecx
            
            ;reg free
            ;rang(numar) -> eax - octetul cautat; ebx - rangul
            push eax
            call rangT
            add esp, 4
            
            ;adaugam suma
            add dword [suma], eax
            
            push ebx
            push dword format
            push dword [handle]
            call [fprintf]
            add esp, 4 * 3
            
            mov esi, dword [aux]
            mov ecx, dword [it]
            add ecx, 4
            cmp ecx, lensir
            je sumaT
            jmp bucla
    
    sumaT:
        
        push dword 10
        push dword nl
        push dword [handle]
        call [fprintf]
        add esp, 4 * 3
        
        push dword [suma]
        push dword format
        push dword [handle]
        call [fprintf]

        push dword [handle]
        call [fclose]
        add esp, 4
        
    final:
        push dword 0
        call [exit]
    
