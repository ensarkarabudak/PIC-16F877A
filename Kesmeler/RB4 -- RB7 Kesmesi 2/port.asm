list				p=16f877
include			"p16f877.inc"

DON 	equ		0x20

ORG 	0
goto	 	anaprogram
ORG 	4
goto 		kesme

anaprogram
			bsf				STATUS,5
			movlw 			0xF0
			movwf 			TRISB
			clrf 				TRISC
			bcf 				STATUS,5
			bsf				INTCON,3
			bsf 				INTCON,6
			bsf 				INTCON,7
			clrf 				PORTB
			clrf				PORTC
			goto				$

kesme
			btfss 		INTCON,0
			retfie
			bcf 			INTCON,7
			bcf 			INTCON,0
			movf 		PORTB,W
			movwf		PORTC
			call			GECIKME
			bsf 			INTCON,7
			retfie

GECIKME
			NOP
			NOP
			NOP
			NOP	
RETURN
END 