;====================================================================
; Main.asm file generated by New Project wizard
;
; Created:   Thu Nov 19 2020
; Processor: 8086
; Compiler:  MASM32
;
; Before starting simulation set Internal Memory Size 
; in the 8086 model properties to 0x10000
;====================================================================

DATA	SEGMENT PARA 'DATA'
	       DIGITS	DB 10H,00H,00H,00H,20H,03H,02H,01H,30H,06H,05H,04H,40H,09H,08H,07H	;USED FOR MAPPING
DATA	ENDS

STAK	SEGMENT STACK 'STACK'
	 DW 20 DUP(?)
STAK	ENDS

CODE    SEGMENT PUBLIC 'CODE'
        ASSUME CS:CODE,  DS:DATA,  SS:STAK

START:
        ; Write your code here
	   ; Write your code here
	MOV AX,0H
	MOV AL, 80H			;MAKING SECOND 8255 MOD 0, OUTPUT ALL PORTS
	OUT 66H, AL

	MOV DX, 206H

	MOV AL, 09H
	OUT DX, AL			; MAKING INTE A, B AS ACTIVE IN BIT SET RESET MODE
	MOV AL, 05H
	OUT DX, AL
	MOV AL, 0BCH			; 8255 MODE 1
	OUT DX, AL
	MOV DX, 202H

ENDLESS:

	MOV CX, 3H			; GETTING 3 VALUES
DONGU:
TEKRAR:
	MOV DX, 204H
        IN AL, DX				; CHECK INPUT
	AND AL, 08H			; MASKING THE VALUE 
	CMP AL,00H
	JE TEKRAR

	MOV DX, 200H
	IN AL, DX
	
	AND AL, 0FH
	MOV BL, AL				; GET MAPPED VALUE
	MOV AL, DIGITS[BX]
	MOV BL, AL
TEKRAR1:	
	MOV DX, 204H
	IN AL, DX
	AND AL, 01H			; CHECK IF PORT B IS READY
	CMP AL,00H
	JE TEKRAR1
	
	MOV DX, 202H
	MOV AL,BL			; OUTPUT THE VALUE TO PORT B
	OUT DX, AL
	PUSH  AX				; SAVE THE VALUE IN STACK

	LOOP DONGU
	
	POP AX;
	POP BX				; GET BACK ALL VALUES FROM STACK
	POP CX;
	
	CMP BX , 10H
	JE TOPLAMA			; CHECK THE OPERATION REQUIRED
	CMP BX, 20H
	JE CIKARMA
	CMP BX ,30H
	JE CARPMA
	CMP BX , 40H
	JE BOLME
	JMP NOTHING
	
TOPLAMA:
	 ADD CL, AL;
	 CMP CL, 1010B		; CHECK IF THE VALUE IS GREATER THAN 9
	 JAE ERROR
	 JMP NOTHING
	 
CIKARMA:
	 ;XCHG AL, CL
	 SUB CL,AL
	 CMP CL, 0H			; CHECK IF THE VALUE IS LESS THAN 0
	 JL ERROR
	 JMP NOTHING

CARPMA:
	 MUL CL;
	 MOV CL, AL
	 CMP CL, 1010B		; CHECK IF THE VALUE IS GREATER THAN 9
	 JAE ERROR
	 JMP NOTHING

BOLME:
	 MOV AH, 0H
	 XCHG AL, CL
	 DIV CL
	 CMP AH,0H			; CHECK IF THERE IS ANY REMAINDER
	 JNE ERROR	
	 MOV CL, AL
	 JMP NOTHING

ERROR:	
	MOV DX, 204H
	IN AL, DX
	AND AL, 01H			; CHECK IF PORT B IS READY
	CMP AL,00H
	JE ERROR
	
	MOV DX, 202H
	MOV AL,0FH			; CLOSE THE 7 SEGMENT
	OUT DX, AL
	JMP MESAJ
	
	;JMP ENDLESS
	
NOTHING:
        MOV DX, 204H
	IN AL, DX
	AND AL, 01H			;CHECK IF PORT B IS READY
	CMP AL,00H
	JE NOTHING
	
	MOV DX, 202H
	MOV AL, CL			; OUTPUT THE RIGHT VALUE
	OUT DX, AL
	JMP MESAJ2
	
	;JMP ENDLESS
	 
MESAJ:
	 MOV AL, 11001100B
	 OUT 60H, AL
	 MOV AL, 11101110B
	 OUT 62H, AL
	 CALL DELAY
	 
	 MOV AL, 00001100B		;PRINTING HATA
	 OUT 60H, AL
	 MOV AL, 11101110B
	 OUT 62H, AL
	 CALL DELAY
	 
	  MOV AL, 00111111B
	 OUT 60H, AL
	 MOV AL, 10111011B
	 OUT 62H, AL
	 CALL DELAY
	 
	  MOV AL, 00001100B
	 OUT 60H, AL
	 MOV AL, 11101110B
	 OUT 62H, AL
	 CALL DELAY
	 
        JMP ENDLESS
	
MESAJ2:
	 MOV AL, 00000000B
	 OUT 60H, AL
	 MOV AL, 11111111B
	 OUT 62H, AL
	 CALL DELAY
	 
	 MOV AL, 11001100B
	 OUT 60H, AL				; PRINTING ONAY
	 MOV AL, 01110111B
	 OUT 62H, AL
	 CALL DELAY
	 
	  MOV AL, 00001100B
	 OUT 60H, AL
	 MOV AL, 11101110B
	 OUT 62H, AL
	 CALL DELAY
	 
	  MOV AL, 11111111B
	 OUT 60H, AL
	 MOV AL, 01011011B
	 OUT 62H, AL
	 CALL DELAY
	 
        JMP ENDLESS
	
	
DELAY PROC NEAR
      PUSH CX
      MOV CX, 05FFFh
      COUNT:
      LOOP COUNT
      POP CX
      RET
DELAY ENDP

CODE    ENDS
        END START