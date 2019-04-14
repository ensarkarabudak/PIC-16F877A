	list p=16f877
	include "p16f877.inc"
	Sayac equ 0x25
	
	ORG 0
	goto Ana_program
	
	
	ORG 4
	
Kesme
	Banksel PIR1
	bcf PIR1,TMR2IF

	incfsz Sayac
	retfie

	Banksel PORTD
	incf PORTD
	retfie
	
	
Ana_program

	clrf Sayac

	Banksel TRISD
	clrf TRISD

	Banksel PORTD
	clrf PORTD

	Banksel T2CON
	movlw 0xFC
	movwf T2CON

	Banksel PIR1
	bcf PIR1,TMR2IF

	Banksel PIE1
	bsf PIR1,TMR2IE

	bsf INTCON,PEIE
	bsf INTCON,GIE

Dongu
	goto Dongu

END