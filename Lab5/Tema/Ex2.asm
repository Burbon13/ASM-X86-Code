bits 32

global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 1000111010111101b
    b dw 1101010110101010b
    c dd 0
    
segment code use32 class=code
start:
    mov ax, [b] ;ax = b15 b14 b13 b12 ... b0
    shl eax, 16 ;eax = b15 b14 ... b1 b0 0 0 ... 0
    
    mov ax, [a] ;ax = a15 a14 a13 ... a1 a0
    shl ax, 3   ;ah = a12 a11 a10 a9 a8 a7 a6 a5    al = a4 a3 a2 a1 a0 0 0 0
    shr ah, 1  ;ah = 0 a12 a11 a10 a9 a8 a7 a6    al = a4 a3 a2 a1 a0 0 0 0
    shl ax, 1  ;ah = a12 a11 a10 a9 a8 a7 a6 a5   al = a3 a2 a1 a0 0 0 0 0
    
    mov bx, [b] ;bx = b15 b14 ... b1 b0  bl = b7 b6 b5 b4 b3 b2 b1 b0
    shr bx, 5   ;bx = 0 0 0 0 0 b15 b14 b13   bl = b12 b11 b10 b9 b8 b7 b6 b5
    and bl, 00001111b ;bl = 0 0 0 0 b8 b7 b6 b5
    
    or al, bl ;bl = a3 a2 a1 a0 b8 b7 b6 b5
    
    mov [c], eax ;rezultatul
    
    push dword 0
    call [exit]