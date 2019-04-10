list 			p=16F877
include 		"p16F877.inc"

Counter		equ 	0x20

	ORG 	0
	goto 		anaprogram
	ORG 	4
	goto		kesme


anaprogram
			movlw 			b'11101000'
			banksel 		OPTION_REG
			movwf 			OPTION_REG
			movlw 			b'11111111'
			movwf 			TRISA
			clrf 				PORTB
			bcf 				STATUS, RP0
			clrf 				PORTB
			movlw 			b'11111111'
			movwf 			TMR0
			clrf 				Counter
			bsf 				INTCON, 5
			bsf 				INTCON, 6
			bsf 				INTCON, 7
			goto				$
kesme
			btfss				INTCON, 5
			retfie
			btfss 			INTCON, 2
			retfie
			movlw			b'11111111'
			movwf			TMR0
			bcf				INTCON, 2
			incf 				Counter, F
			movf 			Counter, W
			sublw 			D'15'
			btfss 			STATUS, C
			clrf 				Counter
			movf 			Counter, W
			movwf 			PORTB
			retfie
END 