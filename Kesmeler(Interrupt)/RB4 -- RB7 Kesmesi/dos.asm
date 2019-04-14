list 			p=16F877
include 		"p16F877.inc" 

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
			movlw			b'11110000'
			movwf			TRISB
			banksel			PORTB
			clrf				PORTB
			banksel			TRISA
			movlw			b'11111111'
			movwf			TRISA
			movlw			0x06
			movwf			ADCON1
			bsf				INTCON, RBIE
			bsf				INTCON, GIE
			banksel   		PORTA

dongu
			btfss				PORTA, 1
			call				uyu
			incf				PORTB
			movlw			d'5'
			call				gecikme
			goto				dongu

uyu
			movf				PORTB, W
			clrf				PORTB
			sleep
			movwf			PORTB
			return

kesme
			bcf				INTCON, GIE
			bsf				PORTB,3
			bsf				PORTB,2
			bsf				PORTB,1
			bsf				PORTB,0
			movlw			d'20'
			call				gecikme
			bcf				INTCON, 0
			bsf				INTCON, GIE
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