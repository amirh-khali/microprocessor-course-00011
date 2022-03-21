
; INCLUDE \masm32\irvine\Irvine32.inc
include \masm32\include\masm32rt.inc

.data
    vector word 17, 13, 30, 18, 15, 13, 24, 10, 25, 5 
    sum db 110
    average db 0    
    maximum db 0   
    minimum db 100

.code
start:    
    mov edi, offset vector
    mov ecx, lengthof vector - 1
    mov al, 0
    
    L1:
        add al, [edi + ecx * 2]
    loop L1
    add al, [edi + 0]
    mov sum, al

    movzx eax, al
    printf ("sum: %u\n", eax)
 
    mov al, sum
    mov cx, lengthof vector
    div cx
    
    movzx eax, al
    printf ("av: %u\n", eax)

    mov edi, offset vector
    mov ecx, lengthof vector - 1

    L2:
        mov al, [edi + ecx * 2]

        cmp al, maximum
        jg update_max
        jmp next_max
        update_max:
            mov maximum, al
        next_max:
    loop L2

    mov edi, offset vector
    mov ecx, lengthof vector - 1

    L3:
        mov al, [edi + ecx * 2]

        cmp al, minimum
        jl update_min
        jmp next_min
        update_min:
            mov minimum, al
        next_min:
    loop L3

    movzx eax, maximum
    movzx ebx, minimum
    printf ("max: %u, min: %u\n", eax, ebx)

    exit
end start