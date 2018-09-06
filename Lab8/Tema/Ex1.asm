;Se dau doua siruri de caractere ordonate alfabetic s1 si s2. Sa se construiasca prin interclasare sirul ordonat s3 care sa contina toate elementele din s1 si s2.
bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    s1 db 1,3,5,7,13,15
    ls1 equ $ - s1
    s2 db 2,4,6,8,10,12
    ls2 equ $ - s2
    s3 resb ls1 + ls2
    
segment code use32 class=code
    start:
        mov esi, s1
        mov edi, s2
        mov ebx, s3
        
        repeta:
            mov eax, s1
            add eax, ls1
            cmp esi, eax
            jae cmpl_s2
            
            mov eax, s2
            add eax, ls2
            cmp edi, eax
            jae cmpl_s1
            
            cmpsb
            jae incarca_s2
            jmp incarca_s1
            
            incarca_s1:
                dec esi
                mov edx, edi
                mov edi, ebx
                movsb
                mov ebx, edi
                mov edi, edx
                dec edi
                jmp repeta
            
            incarca_s2:
                mov eax, esi
                mov esi, edi
                dec esi
                mov edx, edi
                mov edi, ebx
                movsb
                mov ebx, edi
                mov edi, edx
                mov esi, eax
                dec esi
                jmp repeta
        
        
        cmpl_s1:
            mov edi, ebx
            
            salt:
                mov eax, s1
                add eax, ls1
                cmp esi, eax
                jae final
                movsb
                jmp salt
           
            jmp final
        
        cmpl_s2:
            mov esi, edi
            mov edi, ebx
            
            salt2:
                mov eax, s2
                add eax, ls2
                cmp esi, eax
                jae final
                movsb
                jmp salt2
                       
            jmp final
        
        final:
            push dword 0
            call [exit]