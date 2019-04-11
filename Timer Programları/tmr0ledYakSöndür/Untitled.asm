	list p=16F877
	include"p16F877.inc"

	SAYAC0 EQU 0X20
	SAYAC1 EQU 0X21

	ORG 0X00
	GOTO ANA_PROGRAM
	ORG 0X04
	GOTO KESME
	

ANA_PROGRAM
	BANKSEL TRISD
	CLRF TRISD
	BANKSEL PORTD
	CLRF PORTD
	BANKSEL OPTION_REG
	MOVLW h'07'
	MOVWF OPTION_REG
	BANKSEL INTCON
	MOVLW h'E0'
	MOVWF INTCON
	MOVLW h'FF'
	MOVWF SAYAC0

SONSUZ
	GOTO SONSUZ

KESME
	BTFSS INTCON,2
	RETFIE
	BCF INTCON,2
	CALL GEC�K
	BTFSS PORTD,0
	GOTO LED_YAK
	GOTO LED_S�NDUR
DEVAM	
	RETFIE

GEC�K
	MOVLW h'FF'
	MOVWF SAYAC1
	DECFSZ	SAYAC0,1
	RETURN
D�N
	DECFSZ SAYAC1,1
	GOTO D�N
	GOTO GEC�K

LED_YAK
	BSF PORTD,0
	GOTO DEVAM

LED_S�NDUR
	BCF PORTD,0
	GOTO DEVAM


END
