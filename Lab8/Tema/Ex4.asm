;Dandu-se doua siruri de octeti sa se calculeze toate pozitiile unde al doilea sir apare ca subsir in primul sir.
bits 32

global start

extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    s1 db 1,3,5,3,5,3,2,3,5,3,2,3,5,3,5,3,3,5,3
    ls1 equ $ - s1
    s2 db 3,5,3
    ls2 equ $ - s2
    mesaj db "%d ", 0
    
segment code use32 class=code
    start:
        mov esi, s1
        mov edi, s2
        mov ecx, ls1
        sub ecx, ls2
        inc ecx
        
        ripit:
            mov edx, esi
        
            comper:
                ;veririf daca am terminat tot sirul s2
                mov eax, s2
                add eax, ls2
                cmp edi, eax
                jae gasit
                jmp next
            
                gasit:
                    mov ebx, esi
                    sub ebx, s1 ;in ebx avem pozitia
                    sub ebx, 2
                
                    pushad
                
                    push ebx
                    push dword mesaj
                    call [printf]
                    add esp, 4 * 2
                
                    popad
                
                    jmp exit_comper
                
                next:
                    cmpsb
                    jne exit_comper
            
            jmp comper
            exit_comper:
        
        
            mov esi, edx
            mov edi, s2
            inc esi
        
        loop ripit
        
        push dword 0
        call [exit]