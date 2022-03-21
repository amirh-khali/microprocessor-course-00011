dtseg   segment    

vector db 17, 13, 30, 18, 15, 13, 24, 10, 25, 5 
sum db 0
average db 0    
maximum db 0   
minimum db 100

dtseg   ends 

cdseg   segment
start:
        mov ax, dtseg
        mov ds, ax

        mov si, 0
    mov al, 0 
    
    mov cx, 10
    L1:
        add al, [si]
        inc si
    loop L1
    
    mov sum, al

    mov al, sum
    mov ah, 0
    mov bl, 10
    div bl

    mov average, al

    mov si, 0
    mov cx, 10
    L2:
        mov al, [si]
        
        cmp al, maximum
        jg update_max
        jmp next_max
        update_max:
            mov maximum, al
        next_max:
            inc si
    loop L2

    mov si, 0
    mov cx, 10
    L3:
        mov al, [si]

        cmp al, minimum
        jl update_min
        jmp next_min
        update_min:
            mov minimum, al
        next_min:  
            inc si
    loop L3
    
end start
cdseg   ends