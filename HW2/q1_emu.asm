
.data
    res db 0
    first db 4
    second db 6
;

start:
        mov ax, @data
        mov ds, ax
        
        mov cl, first  
        mov al, 0
        
        next: 
            add al, second
        loop next  
        
        mov res, al
end start