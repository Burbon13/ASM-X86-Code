bits 32

global start

extern exit, palindrom_citire, palindrom_verif, palindrom_afis
import exit msvcrt.dll


segment data use32 public data
    sirNr resd 100
    lenSir dd 0
    sta dd 0
    dr dd 0


segment code use32 public code
    start:
        ;palindrom_citire(sirNr,lenSir)
        push dword lenSir
        push dword sirNr
        call palindrom_citire
        add esp, 4 * 2
        
        ;for ebx = [0:lenSir-1]
        ;   for ecx = [0, ebx - 1]
        ;       eax = palindrom_verif(sirNr, ecx, ebx)
        mov ebx, 0
        bucla1:
            cmp ebx, dword [lenSir]
            je end_bucla1
            
            mov ecx, 0
            
            bucla2:
                cmp ecx, ebx
                je end_bucla2
                
                mov dword [sta], ecx
                mov dword [dr], ebx
                
                ;palindrom_verif
                push dword [dr]
                push dword [sta]
                push dword sirNr
                call palindrom_verif
                add esp, 4 * 3
                
                cmp eax, 1
                jne next_bucla2
                
                ;palindrom_afis(sirNr, ecx, ebx)
                push dword [dr]
                push dword [sta]
                push dword sirNr
                call palindrom_afis
                add esp, 4 * 3
                
                next_bucla2:
                
                mov ecx, dword [sta]
                mov ebx, dword [dr]
                
                inc ecx
                
                jmp bucla2
                
            end_bucla2:
            
            inc ebx 
            jmp bucla1
            
        end_bucla1:
        
        push dword 0
        call [exit]