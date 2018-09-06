;Se dau trei siruri de caractere. Sa se afiseze cel mai lung prefix comun pentru fiecare din cele trei perechi de cate doua siruri ce se pot forma.
bits 32

global start

extern exit, prefix
import exit msvcrt.dll


segment data use32 public data
    s1 db 'abc1', 0
    s2 db 'abc1', 0
    s3 db 'adbg4f', 0
    format db '%s', 0
    
    
segment code use32 public code
    start:
        
        push dword s1
        push dword s2
        call prefix
        add esp, 4 * 2
        
        push dword 0
        call [exit]