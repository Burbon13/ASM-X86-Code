bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fread, printf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll 
import fopen msvcrt.dll 
import fread msvcrt.dll 
import fclose msvcrt.dll 
import printf msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
nume_fisier db "palindrom2.txt", 0   ; numele fisierului care va fi deschis
mod_acces db "r", 0             ; modul de deschidere a fisierului; r - pentru scriere. fisierul trebuie sa existe 
descriptor_fis dd -1            ; variabila in care vom salva descriptorul fisierului - necesar pentru a putea face referire la fisier
nr_cifre dd 0              ; variabila in care vom salva numarul de caractere citit din fisier in etapa curenta
len equ 50   
format db '%c' ,0 
aux dd 0
buffer resb len
new resb len
   ; ...

; our code starts here
segment code use32 class=code
    start:
    ; apelam fopen pentru a deschide fisierul
        ; functia va returna in EAX descriptorul fisierului sau 0 in caz de eroare
        ; eax = fopen(nume_fisier, mod_acces)
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        ; verificam daca functia fopen a creat cu succes fisierul (daca EAX != 0)
        cmp eax, 0                  
        je final
        
        mov [descriptor_fis], eax   ; salvam valoarea returnata de fopen in variabila descriptor_fis
        
        ; echivalentul in pseudocod al urmatoarei secvente de cod este:
        ;repeta
        ;   nr_car_citite = fread(buffer, 1, len, descriptor_fis)
        ;   daca nr_car_citite > 0
        ;       ; instructiuni pentru procesarea caracterelor citite in aceasta etapa
        ;pana cand nr_car_citite == 0
       
            ; citim o parte (100 caractere) din textul in fisierul deschis folosind functia fread
            ; eax = fread(buffer, 1, len, descriptor_fis)
            push dword [descriptor_fis]
            push dword len
            push dword 1
            push dword buffer
            call [fread]
            add esp, 4*4
            
        ;am inchiat citirea, avem tot sirul in buffer
        cleanup:
        mov esi,0
        mov edi,0
        for_sir:;parcurgem caracter cu caracter pana dam de virgula
            cmp esi, len
            je final
            mov al, byte [buffer+esi]
            cmp al, ','
            je verificare;daca am dat, verificam daca sirul new in care avem numarul este simetric
            mov byte [new+edi],al
            inc esi
            inc edi
            jmp for_sir
            verificare:
            mov ecx,0
            mov eax,edi
            mov bx,2
            div bx;ax=edi//2
            cwde
            mov dword [aux],eax
            repeta:
            cmp ecx, [aux]
            ja afisare_palindrom
            mov al, [new+ecx]
            mov ebx,edi
            sub ebx,ecx
            dec ebx
            cmp al, byte [new+ebx]
            jne fals;daca nu este
            inc ecx
            jmp repeta
            fals:;setam din nou new a.i. sa fie gol si edi =0
            mov ecx,0
            for_stergere:
            cmp ecx,edi
            ja fin
            mov byte [new+ecx],0
            inc ecx
            jmp for_stergere
            fin:
            mov edi,0
            inc esi
            jmp for_sir
            afisare_palindrom:;daca am gasit,il afisam
            mov ebx,0
            inc edi
            repeta_af:
            cmp ebx,edi
            je ffinal
            mov al,[new+ebx]
            cbw
            cwde
            push eax
            push dword format
            call [printf]
            add esp, 4*2
            add ebx,1
            jmp repeta_af
            ffinal:;si revenim pana terminam
            jmp fals
            
        
        
      final:  
        ; exit(0)
        push    dword 0      
        call    [exit] 
