            .model small

            .stack 64

            .data

first       db      12h, 34h ; 3412h 
                                                       
second      db      34h, 56h ; 5634h


res         db      0h, 0h, 0h, 0h

 

            .code
main        proc far
            mov ax, @data
            mov ds, ax                           
            
            mov si, 0
for1:       cmp si, 2
            jg exit  
            
            mov cx, si
for2:       mov bp, si
            sub bp, cx
            
            cmp bp, 1
            jg break
            
            cmp cx, 1
            jg continue
            
            mov ah, 0
            mov al, ds:first[bp]
            mov di, cx
            mov bl, second[di]
            mul bl
            
            add res[si], al
            adc ah, 0
            add res[si + 1], ah
            
            cmp cx, 0
            je break
            
continue:   dec cx
            jmp for2

break:      inc si
            jmp for1            



exit:       mov ah, 4ch
            int 21h
main        endp
            end main
        
    
    