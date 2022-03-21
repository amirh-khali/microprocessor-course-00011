        .MODEL SMALL
        .STACK 100H


        .DATA

COLOR   DB      0
TEMP_Y  DW      ?
TEMP_X  DW      ?     
STRINGVIR DW    ", $"

X       DW ?
Y       DW ?


        .CODE
MAIN    PROC    FAR

        MOV     AX, @DATA
        MOV     DS, AX

        ; Video Mode
        MOV     AH, 00H
        MOV     AL, 13H
        INT     10H
  
        MOV     AX, 0       ; Star Mouse
        INT     33H

 

WHILE:  ; Repeat Until A Key Is Pressed

      
        MOV     AX, 1H      ; Display Mouse Cursor
        INT     33H  
      
                     
        ; Get Mouse State
        MOV     AX, 3
        INT     33H         ; State Return In BX
      

      
        ; Check Left Button State
        MOV     AX, BX  
        AND     AX, 0000000000000001B 
        CMP     AX, 1B      ; If Bit 0 == 0 : No Left Button
      
      
        JNE     CHECK_KEY
      
        ; CX Is Doubled So We / 2
        MOV     TEMP_Y, DX
        MOV     TEMP_X, CX
      
        MOV     AX, CX
        MOV     BL, 2
        DIV     BL
       
        MOV     CX, AX
        MOV     DX, TEMP_Y
        MOV     AH, 02h     ; Set Cursor Position
        INT     10h         ; Actually Does It  
        
      
        ; Change Color
        MOV     AH, 0CH
        MOV     AL, COLOR
        
        CMP     AL, 0CH
        JE      RED
    
        CMP     AL, 0BH
        JE      BLUE
      
        CMP     AL, 0AH
        JE      GREEN
  

RED:
        MOV     COLOR, 0BH
        INT     10H
        JMP     WHILE

BLUE:
        MOV     COLOR, 0AH
        INT     10H
        JMP     WHILE

GREEN:
        MOV     COLOR, 0CH
        INT     10H
        JMP     WHILE
  

CHECK_KEY:
    ;Check If Reset Key Was Pressed : Works With Any Key   
      
        MOV     X, CX
        MOV     Y, DX
        MOV     AX, CX
        CALL    PRINT 
      
        MOV     AH, 09H
        MOV     DX, OFFSET STRINGVIR
        INT     21H
      
        MOV     AX, Y
        CALL    PRINT
        CALL    NEWLINEPOINTER
   
      
        MOV     AH, 0BH
        INT     21H                                     
        CMP     AL, 0       ; AL==0 : No Key.
        JZ      WHILE
          
        MOV     AX, 0600H   ; Reset Screen.   
        MOV     BH, 07
        MOV     CX, 0
        MOV     DX, 184FH
        INT     10H  
  
MAIN    ENDP


PRINT   PROC     
        CMP     AX, 0
        JE      ENDPRT
        MOV     CX, 10 
        MOV     DX, 0
        DIV     CX
        PUSH    DX
        CALL    PRINT 
        POP     DX
        PUSH    AX
        MOV     AL, DL
        ADD     AL, 30H
       
        MOV     AH, 0EH
        INT     10H  
        POP     AX
ENDPRT: RET
PRINT   ENDP     

       
       
NEWLINEPOINTER  PROC
            
        MOV     DL, 10
        MOV     AH, 02H
        INT     21H
        MOV     DL, 13
        MOV     AH, 02H
        INT     21H
            
        RET
NEWLINEPOINTER  ENDP


            
        END     MAIN