
; INCLUDE \masm32\irvine\Irvine32.inc
include \masm32\include\masm32rt.inc

dtseg   segment
    res db 0
    first db 4
    second db 6
dtseg   ends

cdseg   segment
.code
start:
    Mov cl, first  
    mov al, 0
    
    next: 
        add al, second
    loop next

    movzx eax, al
    printf ("result: %u\n", eax)
    
    exit
end   start
cdseg   ends