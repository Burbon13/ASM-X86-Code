bits 32

global start

extern suma
extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll


segment data use32 public data
    nr1 dd 2345
    nr2 dd 123
    format db "%d",0
    

segment code use32 public code
start:
    push dword [nr1]
    push dword [nr2]
    call suma
    add esp, 4 * 2
    
    push eax
    push dword format
    call [printf]
    add esp, 4 * 2
    
    push dword 0
    call [exit]