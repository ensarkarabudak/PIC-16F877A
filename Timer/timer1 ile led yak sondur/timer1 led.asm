list p =16F877A
#include <p16F877A.inc>

ORG 0X00
GOTO ANA_PROG
ORG 0X04
GOTO KESME

ANA_PROG
	BANKSEL TRISB
	MOVLW h'00'
	MOVWF TRISB
	BANKSEL PORTB
	CLRF PORTB
	BANKSEL INTCON
	BSF INTCON,7
	BSF INTCON,6
	BANKSEL T1CON
	MOVLW h'01'
	MOVWF T1CON
	BANKSEL PIE1
	MOVLW h'1'
	MOVWF PIE1
	BANKSEL PIR1
	MOVLW h'00'
	MOVWF PIR1

GOTO $

KESME
	BTFSS PIR1,0
	RETFIE
	BCF PIR1,0
	BANKSEL PORTB
	BTFSS PORTB,0
	GOTO LED_YAK
	GOTO LED_SONDUR
CIK
	RETFIE

LED_YAK
	BANKSEL PORTB
	BSF PORTB,0
	GOTO CIK


LED_SONDUR
	BANKSEL PORTB
	BCF PORTB,0
	GOTO CIK
END