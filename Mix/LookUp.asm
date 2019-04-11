 	list p=16F877
	include"p16F877.inc"
	
	DEG�SKEN EQU 0X23

	SAYAC1 EQU 0X21
	SAYAC2 EQU 0X22

	ORG 0X00 

	BANKSEL TRISB	
	CLRF TRISB
	BANKSEL PORTB
	CLRF PORTB
	CLRF DEG�SKEN

D�N
	MOVF DEG�SKEN,W
	CALL LOOK_UP
	MOVWF PORTB
	MOVLW h'01'
	CALL GEC�K
	INCF DEG�SKEN,F
	GOTO D�N

LOOK_UP
	addwf	PCL,F
	RETLW h'00'
	RETLW h'03'
	RETLW h'0C'
	RETLW h'F0'
	RETLW h'0C'
	RETLW h'03'
	RETLW h'00'
	RETLW h'F0'
	RETLW h'1E'
	RETLW h'11'
	RETLW h'11'
	RETLW h'1E'
	RETLW h'F0'
	RETLW h'00'
	RETLW h'FF'
	RETLW h'01'
	RETLW h'06'
	RETLW h'08'
	RETLW h'06'
	RETLW h'01'
	RETLW h'FF'
	RETLW h'00'
	RETLW h'F0'
	RETLW h'1E'
	RETLW h'11'
	RETLW h'11'
	RETLW h'1E'
	RETLW h'F0'
	RETLW h'00'
	RETLW h'FF'
	RETLW h'01'
	RETLW h'0E'
	RETLW h'70'
	RETLW h'80'
	RETLW h'FF'
	RETLW h'00'
	CLRF DEG�SKEN
	MOVLW h'00'
	CALL GEC�K1

	




GEC�K

	MOVWF SAYAC1	
D�N1
	MOVLW h'FF'
	MOVWF SAYAC2
D�N2
	DECFSZ SAYAC2,1
	GOTO D�N2
	DECFSZ SAYAC1,1
	GOTO D�N1
	RETURN	

GEC�K1

	MOVWF SAYAC1	
D�N11
	MOVLW h'FF'
	MOVWF SAYAC2
D�N12
	DECFSZ SAYAC2,1
	GOTO D�N12
	DECFSZ SAYAC1,1
	GOTO D�N11
	RETURN	

END
	