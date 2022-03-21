            .model small

            .stack 64

            .data

buff        db  26
            db ?
            db 26 dup(0)
                  
star        db "* $"
space       db "  $"
            
x           dw  ?       
y           dw  ?
l           dw  ? 

            .code
main        proc far
            mov ax, @data
            mov ds, ax                           
            
            call get_int
            mov x, ax
            
            call get_int
            mov y, ax
            
            call get_int
            mov l, ax
            
            mov cx, y
            
            cmp cx, 0
            je continue
L4:         call endl
            loop L4
            
continue:   mov cx, l
            
L5:         mov ax, x
            call print_spaces
            
            mov ax, cx
            call print_stars
            
            call endl
            
            loop L5
            

Exit:       mov ah, 4ch
            int 21h
main        endp

print_spaces proc
            
            cmp ax, 0
            je ps_continue
            
            mov bx, cx
            
            mov cx, ax
L3:         mov ah, 9
            mov dx, offset space
            int 21h
            loop L3
            
            mov cx, bx
            
ps_continue:ret

print_spaces endp

print_stars proc
            
            mov bx, cx
            
            mov cx, ax
L2:         mov ah, 9
            mov dx, offset star
            int 21h
            loop L2
            
            mov cx, bx
            
            ret
print_stars endp


get_int     proc
            
            ; Capture string
            mov ah, 0Ah
            mov dx, offset buff
            int 21h
            
            ; Convert to int
            mov si, offset buff + 1
            mov cl, [si]
            mov ch, 0
            mov ax, 0
            
L1:         inc si
            mov bx, 10
            mul bx
            mov bl, [si]
            mov bh, 0
            add ax, bx
            sub ax, 30h
            loop L1
            
            ; New line
            mov bx, ax
            call endl
            mov ax, bx
            
            ret 
get_int     endp

endl        proc
            
            mov dl, 10
            mov ah, 02h
            int 21h
            mov dl, 13
            mov ah, 02h
            int 21h
            
            ret
endl        endp
            
            end main
        
    
    