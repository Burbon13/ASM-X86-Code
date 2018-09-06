;Se da un sir de octeti 'input' si inca doua siruri de dimensiune N fiecare, 'src' si 'dst'. Sa se obtina un nou sir 'output' din sirul 'input' in care se vor inlocui toti octetii cu valoarea src[i] cu dst[i], unde i=1..N.
bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    sir db 1,3,4,7,3,6,3,8,42,6,2,4,2,3,41
    lsir equ $ - sir
    src db 3,7,8
    dst db 69,0,1
    ln equ $ - src
    output resb lsir
    
segment code use32 class=code
    start:
        
        mov ecx, lsir
        mov esi, sir
        mov edi, output
        
        ripit:  
        
            lodsb ;al = nr
            
            ;verificam daca gasim inlocuitor
            
            mov ebx, edi
            mov edi, src
                        
            compar:
                
                cmp edi, dst
                jae same ;am iterat prin toate elementele
                
                scasb ;comparam al cu src[i]
                
                je change
            
            jmp compar
            
            same:
                mov edi, ebx
                stosb
                
                jmp nextr
                
            change: ;ebx = output      edi = src
                ;push ebx ;locatia unde pun
                
                push esi
                
                dec edi
                mov esi, edi
                sub esi, src
                add esi, dst
          
                lodsb
                
                pop esi
                mov edi, ebx
                stosb
                
                jmp nextr
        
        nextr:
        loop ripit
        
        push dword 0
        call [exit]