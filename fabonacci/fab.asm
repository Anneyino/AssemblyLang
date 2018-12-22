DATA SEGMENT            ; The program for outputing the beginning 30 numbers of faibonacci 
FibonacciL DW 30 DUP(0) ; For 30 fibonacci numbers
FibonacciH DW 30 DUP(0) ; For 30 fibonacci numbers  
TEMVALUE DW ?
DATA ENDS

CODE SEGMENT
     ASSUME CS:CODE,ES:DATA,DS:DATA
MAIN PROC FAR
START: PUSH DS
       SUB AX,AX
       PUSH AX

       MOV AX,DATA
       MOV DS,AX
       MOV SI, OFFSET FibonacciL
       MOV DI, OFFSET FibonacciH

       MOV WORD PTR [SI],1
       MOV WORD PTR [SI+2],1    ; set the beginning numbers 1, 1
       ADD SI,4
       ADD DI,4

       MOV CX, 1
COMPUTE:
       CMP CX, 28
       JA RESETCL
       MOV AX, [SI-2]
       MOV BX, [SI-4]
       ADD AX,BX
       MOV [SI],AX

       MOV AX, [DI-2]
       MOV BX, [DI-4]
       ADC AX,BX
       MOV [DI],AX
       INC CX
       ADD SI,2
       ADD DI,2
       JMP COMPUTE

RESETCL:
      MOV CX, 1
      MOV SI, OFFSET FibonacciL ;  Reset the counter to loop
      MOV DI, OFFSET FibonacciH
OUTPUT:
      CMP CX, 30
      JA ENDOUTPUT
      MOV AX, [SI]
      MOV DX, [DI]
      PUSH CX
      MOV CX, 10000
      DIV CX
      MOV TEMVALUE,AX
      MOV AX,DX
      MOV CX, 1
LOOP1:     
      CMP CX, 4
      JA DATARESET1
      MOV DX, 0
      MOV BX, 10
      DIV BX
      PUSH DX
      INC CX
      JMP LOOP1
DATARESET1:
      MOV AX,TEMVALUE  ;  Reset the counter to loop
      MOV CX, 1
      JMP LOOP2
LOOP2:
     CMP CX, 2
     JA DATARESET2
     MOV DX, 0
     MOV BX, 10
     DIV BX
     PUSH DX
     INC CX
     JMP LOOP2
DATARESET2:
     MOV CX, 1     ;  Reset the counter to loop
     JMP PRINTNUMBER
PRINTNUMBER:
     CMP CX, 6
     JA PRINTNEWLINE     
     POP DX
     OR DL,30H
     MOV AH,2
     INT 21H
     INC CX
     JMP PRINTNUMBER
PRINTNEWLINE:
     MOV DL, 0DH
     MOV AH, 2
     INT 21H

     MOV DL, 0AH
     MOV AH, 2
     INT 21H
 
     POP CX
     ADD SI,2
     ADD DI,2
     INC CX
     JMP OUTPUT

          
ENDOUTPUT:  RET

MAIN ENDP
CODE ENDS
     END MAIN
             