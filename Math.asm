global _start

_start:
    mov eax, 4
    mov ecx, 5
    add eax, ecx    ; Add 4 and 5. Result should be 9 
    int 0x80    ; end system call 