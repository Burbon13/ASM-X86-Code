bits 32

extern printf
import printf msvcrt.dll

segment data use32 public data
    frmt db "%c", 0

segment code use32 public code
    global prefix
    prefix:
        
        mov esi, [esp + 4]
        mov edi, [esp + 8]
        mov ecx, 0
        
        repat:
            
            mov al, byte [esi]
            mov ah, byte [edi]
            
            cmp al, 0
            je end_repat
            
            cmp al, ah
            jne end_repat
            
            inc ecx
            inc esi
            inc edi
            
        jmp repat
    end_repat:
        
        mov esi, [esp + 4]
        mov eax, 0
        alt_repat:
            
            pushad
            mov al, [esi]
            push eax
            push dword frmt
            call [printf]
            add esp, 4 * 2
            popad
            inc esi
            
        loop alt_repat
        
        ret