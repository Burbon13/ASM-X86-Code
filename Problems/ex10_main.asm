;Se citesc mai multe siruri de caractere. Sa se determine daca primul apare ca subsecventa in fiecare din celelalte si sa se dea un mesaj corespunzator.
bits 32

global start

extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
extern kmp_joke


segment data use32 public data
    format_in db "%s",0
    format_poz db "APARE IN TOARE", 0
    format_neg db "NU APARE IN TOATE", 0
    caut resb 100
    sir resb 100
    total dd 0
    gasite dd 0
    
    
segment code use32 public code
    start:
        
        push dword caut
        push dword format_in
        call [scanf]
        add esp, 4*2
        
        repeta:
            
            push dword sir
            push dword format_in
            call [scanf]
            add esp, 4*2
            
            cmp byte [sir], '!'
            je final_repeta
            
            push dword sir
            push dword caut
            call kmp_joke ;returneaza in eax 1 daca a gasit 0 daca nu a gasit
            
            cmp eax, 0
            je negasit
            inc dword [gasite]
            
        negasit:
            ;incrementare nr total de siruri citite
            inc dword [total]
        
        jmp repeta
        final_repeta:
        
        mov al, byte [gasite]
        mov ah, byte [total]
        cmp al, ah
        jne nu
        
    da:
        
        push dword format_poz
        call [printf]
        add esp, 4
        jmp finalisimo
    
    nu:
        
        push dword format_neg
        call [printf]
        add esp, 4
        
    finalisimo:
    
        push dword 0
        call [exit]