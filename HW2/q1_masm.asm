
; INCLUDE \masm32\irvine\Irvine32.inc
include \masm32\include\masm32rt.inc

.data
    res db 0
    first db 4
    second db 6

.code
start:    
    mov cl, first  
    mov al, 0

    next: 
        add al, second
    loop next

    movzx eax, al
    printf ("result: %u\n", eax)
    
    exit
end start
