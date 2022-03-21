dtseg   segment    

res db 0
first db 4
second db 6

dtseg   ends 

cdseg   segment
start:
        mov ax, dtseg
        mov ds, ax

        mov cl, first  
        mov al, 0
    
        next: 
            add al, second
        loop next  
        
        mov res, al
end start
cdseg   ends