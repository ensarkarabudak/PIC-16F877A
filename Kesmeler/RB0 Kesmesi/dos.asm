list			p=16f877
include		"p16f877.inc"

cblock		0x20
sayac0
sayac1
sayac2
endc

	ORG		0
	goto		anaprogram
	ORG		4
	goto		kesme

anaprogram
			banksel			TRISB
			movlw			b'00000001'
			movwf			TRISB
			banksel			PORTB
			clrf				PORTB
			banksel			INTCON
			movlw			b'10010000'
			movwf			INTCON
			banksel			OPTION_REG
			clrf				OPTION_REG
			goto				$
kesme
			banksel			INTCON
			bcf				INTCON,INTF
			movlw			h'80'
			xorwf			PORTB
			retfie

gecikme
			movwf			sayac0
dongu0
			movlw			d'255'
			movwf			sayac1
dongu1
			movlw			d'255'
			movwf			sayac2
dongu2
			decfsz			sayac2,F
			goto				dongu2
			decfsz			sayac1
			goto				dongu1
			decfsz			sayac0
			goto				dongu0
			return
END 