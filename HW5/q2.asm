
print   macro   s, d
        
        mov     from, '0'
        add     from, s
        mov     to, '0'
        add     to, d
        
        lea     dx, from
        mov     ah, 09
        int     21h
        
        endm
        
        .model  small
        .stack  64
        .data
                 
src     db  1
des     db  3
mid     db  2
size    db  10

from    db      ?
arrow   db      " -> "
to      db      ?
endl    db      0ah, 0dh, '$'
        
        .code   
main    proc    far
        mov     ax,@data
        mov     ds,ax        
        
        ; state
        mov     bl, size
        mov     bh, src
        mov     cl, des
        mov     ch, mid
        
        call    hanoi
        
        mov     ah,4ch
        INT     21h        
main    endp


hanoi   proc
        
        cmp     bl, 1
        jne     recursive
        
        print   bh, cl
        
        ret

recursive:
        push    bx
        push    cx
        
        dec     bl
        mov     al, cl
        mov     cl, ch
        mov     ch, al
        call    hanoi
        
        pop     cx
        pop     bx
        
        print   bh, cl
        
        push    bx
        push    cx
        
        dec     bl
        mov     al, bh
        mov     bh, ch
        mov     ch, al
        call    hanoi
        
        pop     cx
        pop     bx
        
        ret
hanoi   endp
        end     main
