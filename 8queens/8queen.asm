DATA SEGMENT   ; the program of 8 queens algrithm
POINT DB 9 DUP(?)
SOLUTIONS DB 0
CURQUEEN DW 0 ;CURRENT POSITION
ISTRUE DB 0
QUEEN DW 8
TEMP DB 0
DATA ENDS

CODE SEGMENT
     ASSUME CS:CODE,ES:DATA,DS:DATA

MAIN PROC FAR
START: 
      PUSH DS
      SUB AX,AX
      PUSH AX

      MOV AX,DATA
      MOV DS,AX

      CALL CALCULATEFUNC
      
      MOV AX,0
      MOV AL,SOLUTIONS
      MOV BL, 10
      DIV BL
      OR AL,30H
      OR AH,30H
      MOV CL, AL
      MOV CH, AH
      
      MOV DL,CL
      MOV AH,2
      INT 21H

      MOV DL,CH
      MOV AH,2
      INT 21H
      
      RET
MAIN ENDP


VERIFY  PROC  NEAR
        MOV  CX, CURQUEEN
        DEC  CX
        CMP  CX,0                    
        JE   CORRECT
LOOP1:  MOV  SI,CX
        MOV  AL,POINT[SI]
        MOV  SI,CURQUEEN
        MOV  BL,POINT[SI]
        SUB  AL,BL                   
        JE   FALSE
        JNC  XLINECHECK                   
        NOT  AL                      
        INC  AL                      
XLINECHECK:
        MOV  BX,CURQUEEN
        SUB  BX,CX                   
        CMP  AL,BL
        JE   FALSE
        DEC CX
        CMP CX, 0
        JA LOOP1
CORRECT:  
        MOV     ISTRUE,1
        RET
FALSE:
        MOV     ISTRUE,0
        RET

VERIFY   ENDP

PRINTER PROC NEAR
        MOV CX, 1
LOOP2:  
        MOV SI, CX
        MOV DL, POINT[SI]    ;ERROR PROBABLY pay attention to the size
        OR DL, 30H
        MOV AH, 2
        INT 21H
        INC CX
        CMP CX, QUEEN
        JBE LOOP2

        MOV DL,0DH
        MOV AH,2
        INT 21H

        MOV DL,0AH
        MOV AH,2
        INT 21H

        RET
PRINTER ENDP        

CALCULATEFUNC PROC NEAR   
    INC CURQUEEN
    MOV CX, QUEEN
    CMP CURQUEEN, CX
    JA PRINT
    JMP DATARESET1
DATARESET1:
    MOV CX, 1                ; reset the counter to loop
    JMP SECONDJUDGE
SECONDJUDGE:
    CMP CX, QUEEN
    JA OUTSECONDJUDGE
    MOV SI, CURQUEEN
    MOV POINT[SI], CL
    PUSH CX
    CALL VERIFY
    POP CX
    CMP ISTRUE,1
    JE RECALLSELF
    JMP DATARESET2
RECALLSELF:
    PUSH CX
    CALL CALCULATEFUNC        ; recursion of itself
    POP CX
DATARESET2:
    INC CX
    JMP SECONDJUDGE     
PRINT:
    INC SOLUTIONS
    CALL PRINTER
OUTSECONDJUDGE:
    DEC CURQUEEN   
    RET
CALCULATEFUNC ENDP

CODE ENDS
     END MAIN

      
                
              



