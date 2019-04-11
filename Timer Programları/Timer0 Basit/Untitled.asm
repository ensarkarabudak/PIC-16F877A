
include "p16f877.inc"

Sayac equ h'20'
Led equ h'21'

org 0x00 
goto Basla
org 0x04
goto kesme
	
Basla:
	banksel TRISC
	movlw 0x02
	movwf OPTION_REG				

	clrf TRISC						
	banksel PORTC

	clrf Sayac

	clrf PORTC
	clrf TMR0						
	movlw 0xE0
	movwf INTCON					

don
	goto don	


kesme:
	bcf INTCON,2				
	incf Sayac,f					
	btfss STATUS,Z
	retfie
	incf PORTC
	retfie
end