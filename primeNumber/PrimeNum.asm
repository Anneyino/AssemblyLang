DATA SEGMENT             ; The program of outputing 100 prime numbers less than 100
PRIMENUMBER DB 25 DUP(?) ; SINCE WE ALL KNOW THERE ARE 25 PRIME NUMBER UNDER 100
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,ES:DATA,DS:DATA
MAIN PROC FAR
START: PUSH DS
       SUB AX,AX
       PUSH AX

       MOV AX, DATA
       MOV DS, AX
       MOV SI, OFFSET PRIMENUMBER
       MOV DI, OFFSET PRIMENUMBER
       MOV CH, 1
LOOP1: INC CH
       CMP CH, 100       
       JA PRINTNUM
       MOV CL, 1

LOOP2: INC CL
       MOV BL, CH
       SHR BL, 1
       CMP CL, BL
       JA ADDPRIME
       XOR AX,AX
       MOV AL, CH
       DIV CL
       CMP AH, 0
       JE LOOP1
       JMP LOOP2

ADDPRIME: MOV [SI],CH
          INC SI
          JMP LOOP1

PRINTNUM: CMP DI, SI      ; DI is unchanged and begin with the offset, but SI is changed, so we use DI here
          JE COMPLETE

          SUB AX, AX
          MOV AL, [DI]
          
          MOV BL, 10
          DIV BL
          XCHG AH,AL
          OR AX, 3030H
          MOV CX, AX
          
          MOV DL, CH
          MOV AH, 2
          INT 21H

          MOV DL, CL
          MOV AH, 2
          INT 21H

          MOV DL, 0DH
          MOV AH, 2
          INT 21H
          MOV DL, 0AH
          MOV AH, 2
          INT 21H

          INC DI
          JMP PRINTNUM 

COMPLETE: RET
MAIN ENDP
CODE ENDS
     END MAIN