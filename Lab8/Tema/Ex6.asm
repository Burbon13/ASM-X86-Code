;Dandu-se un sir de cuvinte sa se obtina sirul (de octeti) cifrelor in baza zece ale fiecarui cuvant din acest sir.
bits 32

global start

extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    sir DW 12345, 2078, 45961 
    lsir equ ($ - sir) / 2
    mesaj db "%d ", 0
    sirfinal resb lsir * 6
    len_f db 0
    
segment code use32 class=code
    start:
        
        mov esi, sir
        mov ecx, lsir
        mov edi, sirfinal
        
    lup:
        ;verificam daca am ajuns la sfarsit
        mov eax, sir
        add eax, lsir * 2
        cmp esi, eax
        jae exit_lup
        
        lodsw ;ax
        
        mov bx, 10
        mov ecx, 0
        uail_not_zero:
            
            cmp ax, 0
            je exit_uail_not_zero
            
            inc ecx
            
            mov edx, 0
            div bx ;ax = nr / 10, dx = nr % 10
            push edx
            
        jmp uail_not_zero    
        exit_uail_not_zero:
        
        fa_sir:
            pop eax ;al val
            stosb
            
            mov al, [len_f]
            inc al
            mov [len_f], al
            
            loop fa_sir        
        
    jmp lup
    exit_lup:
    
        mov ecx, [len_f]
        mov esi, sirfinal
        mov eax, 0
        
    afis:
        
        lodsb ;al valoarea
        
        pushad
        
        push eax
        push dword mesaj
        call [printf]
        add esp, 4  * 2
        
        popad
        
    loop afis
        
        push dword 0
        call [exit]