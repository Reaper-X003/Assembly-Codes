
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

DATA_SEGMENT:
  ARRAY DB 'Time Devine'
  
CODE_SEGMENT:
  MOV CX,11
  MOV SI,0
  PRINT:
      MOV AH,2
      MOV DL,[ARRAY+SI]
      INT 21H
      
      INC SI
      LOOP PRINT 

ret




