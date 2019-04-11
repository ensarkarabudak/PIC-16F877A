list			p=16f877
include		"p16f877.inc"

sayac		equ		0x20

ORG			0
goto			anaprogram
ORG			4
goto			kesme

anaprogram
			movlw			d'30'
			movwf			sayac
			banksel			OPTION_REG
			movlw			b'11010111'
			movwf			OPTION_REG
			banksel			TRISC
			clrf				TRISC
			banksel			PORTC
			clrf				PORTC
			banksel			INTCON
			bsf				INTCON,5
			bsf				INTCON,7
			goto				$

kesme
			btfss				INTCON,5
			retfie
			btfss				INTCON,2
			retfie
			bcf				INTCON,2
			decfsz			sayac,F
			retfie
			incf				PORTC
			movlw			d'30'
			movwf			sayac
			retfie
END 