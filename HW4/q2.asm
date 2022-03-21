            .model small

            .stack 64

            .data

buff        db  26
            db ?
            db 26 dup(0)

menu_str    db "0: Addition, 1: Subtraction, 2: Multiplication, 3: Division, 4: Exit$"
            
first       dw  ?       
second      dw  ? 

            .code
main        proc far
            mov ax, @data
            mov ds, ax              
            
            ; Get first number
            call get_int
            mov first, ax
            
            ; Get second number
            call get_int
            mov second, ax
            
            ; While True
L2:         call menu
            call get_int
            cmp ax, 0
            je  Addition
            cmp ax, 1
            je  Subtraction
            cmp ax, 2
            je  Multiplication
            cmp ax, 3
            je  Division
            cmp ax, 4
            je  Exit
            jmp L2
            
            
Addition:   mov ax, first
            mov bx, second
            add ax, bx
            call print_int
            jmp L2
            
Subtraction:
            mov ax, first
            mov bx, second
            cmp ax, bx
            jge  ax_bx
            
            ; Swap
            mov cx, bx
            mov bx, ax
            mov ax, cx
 
ax_bx:      sub ax, bx
            call print_int
            jmp L2
           
            
Multiplication:
            mov ax, first
            mov bx, second
            mul bx
            call print_int
            jmp L2

Division:   mov ax, first
            mov bx, second
            mov dx, 0
            div bx
            mov cx, dx
            call print_int
            mov ax, cx
            call print_int
            jmp L2               
            
            

Exit:       mov ah, 4ch
            int 21h
main        endp

menu        proc
            
            mov si, offset menu_str
            mov ah, 9
            mov dx, si
            int 21h
            
            call endl
            
            ret
menu        endp

print_int   proc
            
            ; Convert to string
            mov si, offset buff + 25
            mov [si], '$'
            
L3:         dec si
            mov bx, 10
            mov dx, 0
            div bx
            add dx, 30h
            mov [si], dl
            cmp ax, 0
            jne L3               
            
            ; Print string
            mov ah, 9
            mov dx, si
            int 21h
            
            ; New line
            call endl
            
            ret
print_int   endp
            


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
        
    
    