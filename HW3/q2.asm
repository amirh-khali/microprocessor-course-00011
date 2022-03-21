.data 

    arr db "amirh$", "amirh$", "mmd$", "dani$", "arman$", "dani$", "dani$", "alis$", "alif$", "arman$", "arman$", "arman$", "arman$", "alif$", "alif$", "alif$", "alif$", "alif$", "payam$", "payam$"
    size equ $-arr
    ans db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
;

main:
    mov ax, @data
    mov ds, ax 
    
    mov bx, 0
    mov bp, 0
    
    for: 
        
        cmp bx, size
        jge the_end
        
        mov di, 0
        mov si, bx
        
        compare:
        
            cmp di, size
            jge next_word
            
            mov al, arr[si] 
            cmp al, arr[di]
            jne dissimilar
        
            cmp al, '$'
            je similar
            
            inc si
            inc di
            jmp compare
        
            similar:
        
                inc ans[bp]
                inc di
                
                mov si, bx
                jmp compare
            
            dissimilar:
            
                inc di
                cmp arr[di-1], '$'
                jne dissimilar
                
                mov si, bx
                jmp compare
            
        next_word:
        
            inc bx
            cmp arr[bx-1], '$'
            jne next_word
            inc bp
            jmp for
            
    the_end: 
                          
end main 