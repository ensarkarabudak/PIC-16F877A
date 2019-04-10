	LIST P=16F877
	#INCLUDE "P16F877.INC"

templcd	EQU	H'33'
count1	EQU	H'34'
counta	EQU H'35'
countb	EQU H'36'
count	EQU	H'37'

LCD_PORT	Equ	PORTB
LCD_TRIS	Equ	TRISB

LCD_RS		Equ	4			
LCD_E		Equ	5


		ORG 0x0000

		
		BCF STATUS,6
     	BSF STATUS,5
       	CLRF LCD_TRIS
	
     	BCF STATUS,5

		call	Delay100

		CALL	LCD_Init

		call	LCD_Clr		
		;call	LCD_CurOn		

		movlw	0x05
		call	LCD_Line1W		


	 

		clrf	count			
Message		
		movf	count, w		
		call	Satir1			
		xorlw	0x00			
		btfsc	STATUS, Z
		goto	NextMessage
		call	LCD_Char
		incf	count, f
		goto	Message
		

NextMessage	
		call	LCD_Line2		
		movlw	0x05
		call	LCD_Line2W		


		clrf	count			
Message2	
		movf	count, w		
		call	Satir2			
		xorlw	0x00		
		btfsc	STATUS, Z
		goto	EndMessage
		call	LCD_Char
		incf	count, f
		goto	Message2

EndMessage	
		
Stop		
		goto	Stop			




LCD_Init	

		call	Delay100
		call	Delay100

		movlw	0x03
		movwf	LCD_PORT
		bsf	LCD_PORT,LCD_E
		bcf	LCD_PORT,LCD_E
		call	Delay50

		bsf	LCD_PORT,LCD_E
		bcf	LCD_PORT,LCD_E
		call	d1
		call	d1


		bsf	LCD_PORT,LCD_E
		bcf	LCD_PORT,LCD_E
		call	d1
		call	d1

		movlw	0x02
		movwf	LCD_PORT
		bsf	LCD_PORT,LCD_E
		bcf	LCD_PORT,LCD_E
		call	d1
		call	d1

	
		
		movlw	0x28			;Set display shift
		call	LCD_Cmd
		movlw	0x08			;Set display shift
		call	LCD_Cmd
		movlw	0x01			;Set display shift
		call	LCD_Cmd

		movlw	0x06			;Set display shift
		call	LCD_Cmd
		movlw	0x0C			;Set display shift
		call	LCD_Cmd
		

		return


		
LCD_Cmd		
		movwf	templcd
		swapf	templcd,	w	
		andlw	0x0f			;clear upper 4 bits of W
		movwf	LCD_PORT
		bcf	LCD_PORT, LCD_RS	;RS line to 0
		
		call	Pulse_e			;Pulse the E line high

		movf	templcd,	w	;send lower nibble
		andlw	0x0f			;clear upper 4 bits of W
		movwf	LCD_PORT
		bcf	LCD_PORT, LCD_RS	;RS line to 0
	
		call	Pulse_e			;Pulse the E line high
		call 	Delay5
		return

LCD_CharD	addlw	0x30
LCD_Char	
		
		movwf	templcd
		swapf	templcd,	w	
		andlw	0x0f			;clear upper 4 bits of W
		movwf	LCD_PORT
		bsf	LCD_PORT, LCD_RS	;RS line to 1
		
		call	Pulse_e			;Pulse the E line high

		movf	templcd,	w	;send lower nibble
		
		andlw	0x0f			;clear upper 4 bits of W
		movwf	LCD_PORT
		bsf	LCD_PORT, LCD_RS	;RS line to 1
		
		call	Pulse_e			;Pulse the E line high
		call 	Delay5
		return


LCD_Line1	movlw	0x80			;move to 1st row, first column
		call	LCD_Cmd
		return

LCD_Line2	movlw	0xc0			;move to 2nd row, first column
		call	LCD_Cmd
		return

LCD_Line1W	addlw	0x80			;move to 1st row, column W
		call	LCD_Cmd
		return

LCD_Line2W	addlw	0xc0			;move to 2nd row, column W
		call	LCD_Cmd
		return

LCD_CurOn	movlw	0x0d			;Set display on/off and cursor command
		call	LCD_Cmd
		return

LCD_CurOff	movlw	0x0c			;Set display on/off and cursor command
		call	LCD_Cmd
		return

LCD_Clr		movlw	0x01			;Clear display
		call	LCD_Cmd
		return



Delay255	movlw	0xff		;delay 255 mS
		goto	d0
Delay100	movlw	d'100'		;delay 100mS
		goto	d0
Delay50		movlw	d'50'		;delay 50mS
		goto	d0
Delay20		movlw	d'20'		;delay 20mS
		goto	d0
Delay5		movlw	0x05		;delay 5.000 ms (4 MHz clock)
d0		movwf	count1
d1		movlw	0xC7			;delay 1mS
		movwf	counta
		movlw	0x01
		movwf	countb
Delay_0
		decfsz	counta, f
		goto	$+2
		decfsz	countb, f
		goto	Delay_0

		decfsz	count1	,f
		goto	d1
		return


Pulse_e		
		bsf	LCD_PORT, LCD_E
		bcf	LCD_PORT, LCD_E
		return



Satir1		
		addwf	PCL, f
		retlw	'E'
		retlw	'N'
		retlw	'S'
		retlw	'A'
		retlw	'R'
		retlw	0x00

Satir2		
		ADDWF   PCL, f
        RETLW   'K'
        RETLW   'A'
        RETLW   'R'
        RETLW   'A'
        RETLW   'B'
        RETLW   'U'
        RETLW   'D'
        RETLW   'A'
        RETLW   'K'
        RETLW   0x00



       END
       
