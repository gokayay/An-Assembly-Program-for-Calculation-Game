;***********************************************
;A CALCULATION GAME WITH FOUR(+-*/) OPERATIONS FOR KIDS

;GOKAY AY

;***********************************************
LED	EQU	P1.7
BUZZER EQU	P1.5


	LJMP	START
	ORG	100H
START:
	MOV	R0,#LCDWC	;address of "write command" mode
	MOV	R1,#LCDRC	

	MOV	A,#1		;clear display
	ACALL	WRITE

	MOV	A,#0FH		;display on, cursor and blinking on	
	ACALL	WRITE

	MOV	A,#06H		;chars from left to right
	ACALL	WRITE		;shift a cursor

	INC	R0		;address of "write data" mode
	MOV	DPTR,#TEXT	;address of string
WRITE_TXT:
	CLR	A		
	MOVC	A,@A+DPTR	;read from table
	JZ	TEXT_END	;finish if byte is 0
	ACALL	WRITE		;send ASCII code to LCD
	INC	DPTR		;shift pointer
	SJMP	WRITE_TXT	;stay in loop
TEXT_END:
	DEC	R0		;address of "write command" mode
	MOV	DPTR,#KEY_CODE 	;address of instructions
LOOP:			
	LCALL	WAIT_KEY	
	CJNE	A,#0DH,NO_DOWN	;if key pressed not equals to 'v'
				;goto address "NO_DOWN"
DOWN:				;for key 'v' (down)
	MOVX	A,@R1
	JB	ACC.7,DOWN	
	MOVX	A,@R1		;read a cursor position
	CPL	ACC.6		;toggle display line
	SETB	ACC.7		;it must be 1
	ACALL	WRITE		;send new cursor position
	SJMP	LOOP
NO_DOWN:
	MOV	R2,A		;store key number
	MOVC	A,@A+DPTR	;read from table "TEXT"
	JZ	SEND_CHAR	;for "0" send ASCII code
	ACALL	WRITE		;send instruction to LCD
	SJMP	LOOP
SEND_CHAR:			
	MOV	A,R2		;load a key number

	ACALL	CONTROL		;CONTROL*******************

	ADD	A,#30H		;ASCII conversion
	INC	R0		
	ACALL	WRITE		
	DEC	R0		
	SJMP	LOOP

;**************************************


CONTROL:
	CJNE	A,#05,LEDBUZZ
	CLR	BUZZER
	CLR	LED
	LCALL	DELAY_100MS
	SETB	LED
	SETB	BUZZER
	ACALL	CONTROL2
LEDBUZZ:	
	RET

;**************************************

CONTROL2:

	MOV	A,#1		;clear display
	ACALL	WRITE

	MOV	A,#0FH		;display on, cursor and blinking on	
	ACALL	WRITE

	MOV	A,#06H		;chars from left to right
	ACALL	WRITE		;shift a cursor

	INC	R0		;address of "write data" mode
	MOV	DPTR,#TEXT2	;address of string
WRITE_TXT2:
	CLR	A		
	MOVC	A,@A+DPTR	;read from table
	JZ	TEXT_END2	;finish if byte is 0
	ACALL	WRITE		;send ASCII code to LCD
	INC	DPTR		;shift pointer
	SJMP	WRITE_TXT2	;stay in loop
TEXT_END2:
	DEC	R0		;address of "write command" mode
	MOV	DPTR,#KEY_CODE 	;address of instructions
LOOP2:			
	LCALL	WAIT_KEY	
	CJNE	A,#0DH,NO_DOWN2	;if key pressed not equals to 'v'
				;goto address "NO_DOWN"
DOWN2:				;for key 'v' (down)
	MOVX	A,@R1
	JB	ACC.7,DOWN2	
	MOVX	A,@R1		;read a cursor position
	CPL	ACC.6		;toggle display line
	SETB	ACC.7		;it must be 1
	ACALL	WRITE		;send new cursor position
	SJMP	LOOP2
NO_DOWN2:
	MOV	R2,A		;store key number
	MOVC	A,@A+DPTR	;read from table "TEXT"
	JZ	SEND_CHAR2	;for "0" send ASCII code
	ACALL	WRITE		;send instruction to LCD
	SJMP	LOOP2

SEND_CHAR2:			
	MOV	A,R2		;load a key number

	ACALL	CONTROL21	;CONTROL*******************

	ADD	A,#30H		;ASCII conversion
	INC	R0		
	ACALL	WRITE		
	DEC	R0		
	SJMP	LOOP2

;**************************************

CONTROL21:	
	CJNE	A,#03,LEDBUZZ2
	CLR	BUZZER
	CLR	LED
	LCALL	DELAY_100MS
	SETB	LED
	SETB	BUZZER
	ACALL	CONTROL3
LEDBUZZ2:	
	RET

;**************************************

CONTROL3:

	MOV	A,#1		;clear display
	ACALL	WRITE

	MOV	A,#0FH		;display on, cursor and blinking on	
	ACALL	WRITE

	MOV	A,#06H		;chars from left to right
	ACALL	WRITE		;shift a cursor

	INC	R0		;address of "write data" mode
	MOV	DPTR,#TEXT3	;address of string
WRITE_TXT3:
	CLR	A		
	MOVC	A,@A+DPTR	;read from table
	JZ	TEXT_END3	;finish if byte is 0
	ACALL	WRITE		;send ASCII code to LCD
	INC	DPTR		;shift pointer
	SJMP	WRITE_TXT3	;stay in loop
TEXT_END3:
	DEC	R0		;address of "write command" mode
	MOV	DPTR,#KEY_CODE 	;address of instructions
LOOP3:			
	LCALL	WAIT_KEY	
	CJNE	A,#0DH,NO_DOWN3	;if key pressed not equals to 'v'
				;goto address "NO_DOWN"
DOWN3:				;for key 'v' (down)
	MOVX	A,@R1
	JB	ACC.7,DOWN3	
	MOVX	A,@R1		;read a cursor position
	CPL	ACC.6		;toggle display line
	SETB	ACC.7		;it must be 1
	ACALL	WRITE		;send new cursor position
	SJMP	LOOP3
NO_DOWN3:
	MOV	R2,A		;store key number
	MOVC	A,@A+DPTR	;read from table "TEXT"
	JZ	SEND_CHAR3	;for "0" send ASCII code
	ACALL	WRITE		;send instruction to LCD
	SJMP	LOOP3

SEND_CHAR3:			
	MOV	A,R2		;load a key number

	ACALL	CONTROL31	;CONTROL*******************

	ADD	A,#30H		;ASCII conversion
	INC	R0		
	ACALL	WRITE		
	DEC	R0		
	SJMP	LOOP3

;**************************************

CONTROL31:	
	CJNE	A,#09,LEDBUZZ3
	CLR	BUZZER
	CLR	LED
	LCALL	DELAY_100MS
	SETB	LED
	SETB	BUZZER
	ACALL	CONTROL4
LEDBUZZ3:	
	RET

;**************************************

CONTROL4:

	MOV	A,#1		;clear display
	ACALL	WRITE

	MOV	A,#0FH		;display on, cursor and blinking on	
	ACALL	WRITE

	MOV	A,#06H		;chars from left to right
	ACALL	WRITE		;shift a cursor

	INC	R0		;address of "write data" mode
	MOV	DPTR,#TEXT4	;address of string
WRITE_TXT4:
	CLR	A		
	MOVC	A,@A+DPTR	;read from table
	JZ	TEXT_END4	;finish if byte is 0
	ACALL	WRITE		;send ASCII code to LCD
	INC	DPTR		;shift pointer
	SJMP	WRITE_TXT4	;stay in loop
TEXT_END4:
	DEC	R0		;address of "write command" mode
	MOV	DPTR,#KEY_CODE 	;address of instructions
LOOP4:			
	LCALL	WAIT_KEY	
	CJNE	A,#0DH,NO_DOWN4	;if key pressed not equals to 'v'
				;goto address "NO_DOWN"
DOWN4:				;for key 'v' (down)
	MOVX	A,@R1
	JB	ACC.7,DOWN4	
	MOVX	A,@R1		;read a cursor position
	CPL	ACC.6		;toggle display line
	SETB	ACC.7		;it must be 1
	ACALL	WRITE		;send new cursor position
	SJMP	LOOP4
NO_DOWN4:
	MOV	R2,A		;store key number
	MOVC	A,@A+DPTR	;read from table "TEXT"
	JZ	SEND_CHAR4	;for "0" send ASCII code
	ACALL	WRITE		;send instruction to LCD
	SJMP	LOOP4

SEND_CHAR4:			
	MOV	A,R2		;load a key number

	ACALL	CONTROL41	;CONTROL*******************

	ADD	A,#30H		;ASCII conversion
	INC	R0		
	ACALL	WRITE		
	DEC	R0		
	SJMP	LOOP4

;**************************************

CONTROL41:	
	CJNE	A,#04,LEDBUZZ4
	CLR	BUZZER
	CLR	LED
	LCALL	DELAY_100MS
	SETB	LED
	SETB	BUZZER
	ACALL	CONTROL5
LEDBUZZ4:	
	RET

;**************************************

;**************************************

CONTROL5:

	MOV	A,#1		;clear display
	ACALL	WRITE

	MOV	A,#0FH		;display on, cursor and blinking on	
	ACALL	WRITE

	MOV	A,#06H		;chars from left to right
	ACALL	WRITE		;shift a cursor

	INC	R0		;address of "write data" mode
	MOV	DPTR,#TEXT5	;address of string
WRITE_TXT5:
	CLR	A		
	MOVC	A,@A+DPTR	;read from table
	JZ	TEXT_END5	;finish if byte is 0
	ACALL	WRITE		;send ASCII code to LCD
	INC	DPTR		;shift pointer
	SJMP	WRITE_TXT5	;stay in loop
TEXT_END5:
	DEC	R0		;address of "write command" mode
	MOV	DPTR,#KEY_CODE 	;address of instructions
LOOP5:			
	LCALL	WAIT_KEY	
	CJNE	A,#0DH,NO_DOWN5	;if key pressed not equals to 'v'
				;goto address "NO_DOWN"
DOWN5:				;for key 'v' (down)
	MOVX	A,@R1
	JB	ACC.7,DOWN5	
	MOVX	A,@R1		;read a cursor position
	CPL	ACC.6		;toggle display line
	SETB	ACC.7		;it must be 1
	ACALL	WRITE		;send new cursor position
	SJMP	LOOP5
NO_DOWN5:
	MOV	R2,A		;store key number
	MOVC	A,@A+DPTR	;read from table "TEXT"
	JZ	SEND_CHAR5	;for "0" send ASCII code
	ACALL	WRITE		;send instruction to LCD
	SJMP	LOOP5

SEND_CHAR5:			
	MOV	A,R2		;load a key number

	ACALL	CONTROL51	;CONTROL*******************

	ADD	A,#30H		;ASCII conversion
	INC	R0		
	ACALL	WRITE		
	DEC	R0		
	SJMP	LOOP5

;**************************************

CONTROL51:	
	CJNE	A,#02,LEDBUZZ5
	CLR	BUZZER
	CLR	LED
	LCALL	DELAY_100MS
	SETB	LED
	SETB	BUZZER
	ACALL	CONTROL6
LEDBUZZ5:	
	RET

;**************************************


CONTROL6:

	MOV	A,#1		;clear display
	ACALL	WRITE

	MOV	A,#0FH		;display on, cursor and blinking on	
	ACALL	WRITE

	MOV	A,#06H		;chars from left to right
	ACALL	WRITE		;shift a cursor

	INC	R0		;address of "write data" mode
	MOV	DPTR,#TEXT6	;address of string
WRITE_TXT6:
	CLR	A		
	MOVC	A,@A+DPTR	;read from table
	JZ	TEXT_END6	;finish if byte is 0
	ACALL	WRITE		;send ASCII code to LCD
	INC	DPTR		;shift pointer
	SJMP	WRITE_TXT6	;stay in loop
TEXT_END6:
	DEC	R0		;address of "write command" mode
	MOV	DPTR,#KEY_CODE 	;address of instructions
LOOP6:			
	LCALL	WAIT_KEY	
	CJNE	A,#0DH,NO_DOWN6	;if key pressed not equals to 'v'
				;goto address "NO_DOWN"
DOWN6:				;for key 'v' (down)
	MOVX	A,@R1
	JB	ACC.7,DOWN6	
	MOVX	A,@R1		;read a cursor position
	CPL	ACC.6		;toggle display line
	SETB	ACC.7		;it must be 1
	ACALL	WRITE		;send new cursor position
	SJMP	LOOP6
NO_DOWN6:
	MOV	R2,A		;store key number
	MOVC	A,@A+DPTR	;read from table "TEXT"
	JZ	SEND_CHAR6	;for "0" send ASCII code
	ACALL	WRITE		;send instruction to LCD
	SJMP	LOOP6

SEND_CHAR6:			
	MOV	A,R2		;load a key number

	ACALL	CONTROL61	;CONTROL*******************

	ADD	A,#30H		;ASCII conversion
	INC	R0		
	ACALL	WRITE		
	DEC	R0		
	SJMP	LOOP6

;**************************************

CONTROL61:	
	CJNE	A,#07,LEDBUZZ6
	CLR	BUZZER
	CLR	LED
	LCALL	DELAY_100MS
	SETB	LED
	SETB	BUZZER
	ACALL	FINISH
LEDBUZZ6:	
	RET

;**************************************


;subroutine of sending data to LCD
;valid addresses are assummed

WRITE:
	MOV	R2,A			
BUSY:
	MOVX	A,@R1		
	JB	ACC.7,BUSY
	MOV	A,R2	
	MOVX	@R0,A			
	RET

;**************************************

FINISH:

	MOV	A,#1		;clear display
	ACALL	WRITE

	MOV	A,#0FH		;display on, cursor and blinking on	
	ACALL	WRITE

	MOV	A,#06H		;chars from left to right
	ACALL	WRITE		;shift a cursor

	INC	R0		;address of "write data" mode
	MOV	DPTR,#TEXTFINISH	;address of string
WRITE_TXTF:
	CLR	A		
	MOVC	A,@A+DPTR	;read from table
	JZ	TEXT_ENDF	;finish if byte is 0
	ACALL	WRITE		;send ASCII code to LCD
	INC	DPTR		;shift pointer
	SJMP	WRITE_TXTF	;stay in loop
TEXT_ENDF:
	RET			;address of "write command" mode


;**************************************
;table with association of keys and LCD instructions
KEY_CODE:
	DB	0,0,0			;0,1,2
	DB	0,0,0			;3,4,5
	DB	0,0,0			;6,7,8
	DB	0,10H,14H		;9,<,>
	DB	02H,0,06H		;^,v,Esc
	DB	0000 0111B		;Enter
;**************************************
TEXT:
	DB	'2+3=?>>',0

TEXT2:
	DB	'7-4=?>>',0

TEXT3:
	DB	'3*3=?>>',0

TEXT4:
	DB	'8/2=?>>',0

TEXT5:
	DB	'10/5=?>>',0

TEXT6:
	DB	'7*1=?>>',0

TEXTFINISH:
	DB	'WELL DONE!',0