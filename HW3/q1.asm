.data
    grades  db 09H, 03H, 10H, 14H, 18H, 12H, 16H, 08H, 09H, 13H, 15H, 10H, 04H, 18H, 17H, 11H, 06H, 16H, 08H, 03H
    size    dw 20
    
    sum     dw 0
    avg     dw 0
    new_sum dw 0
    new_avg dw 0
    
    median  db 0
    max     db 0
    diff    db 0
;

main:
    mov ax, @data
    mov ds, ax
    
    ;sum
    mov si, 0
    mov ah, 0
    sum_loop:
        mov al, grades[si]
        and al, 0F0h
        ror al, 4
        mov dl, 10
        mul dl
        
        mov bl, grades[si]
        and bl, 0Fh
        
        add al, bl
        add sum, ax
        
        inc si
        cmp si, size
        jl sum_loop
    
    ;avg
    mov ax, sum
    div size
    
    mov ah, 0
    mov cl, 10
    div cl
    ror al, 4
    add al, ah
    mov ah, 0
    mov avg, ax
    
    ;sort
    mov si, 0
    sort_loop_i:
        mov di, si
        inc di
        
        sort_loop_j:
            inc di
            cmp di, size
            jge break
            
            mov al, grades[si]
            mov bl, grades[di]
            cmp al, bl
            jg swap
            jmp sort_loop_j
            
            swap:
                mov grades[si], bl
                mov grades[di], al
                jmp sort_loop_j
        break:
            inc si
            cmp si, size
            jl sort_loop_i
     
    ;meadian
    mov ax, 0 
    mov al, grades[9]
    add al, grades[10]
    daa
    mov ah, 0
    mov bl, 2
    div bl
    mov median, al
    
    ;max
    mov al, grades[19]
    mov max, al
    
    ;diff
    mov al, 20h
    sbb al, max
    das
    mov diff, al
    
    ;increment
    mov si, 0
    increment_loop:
    
        mov al, grades[si]
        cmp al, median
        jg increase
        jmp end_loop
        
        increase:
            add al, diff
            daa
            mov grades[si], al
        
        end_loop:
            inc si
            cmp si, size
            jl increment_loop      
    
    ;new_sum
    mov si, 0
    mov ah, 0
    new_sum_loop:
        mov al, grades[si]
        and al, 0F0h
        ror al, 4
        mov dl, 10
        mul dl
        
        mov bl, grades[si]
        and bl, 0Fh
        
        add al, bl
        add new_sum, ax
        
        inc si
        cmp si, size
        jl new_sum_loop
    
    ;new_avg
    mov ax, new_sum
    div size
    
    mov ah, 0
    mov cl, 10
    div cl
    ror al, 4
    add al, ah
    mov ah, 0
    mov new_avg, ax      
            

end main
        
    
    