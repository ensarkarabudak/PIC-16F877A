list			p=16f877
include		"p16f877.inc"

cblock		0x20
sayac0
sayac1
sayac2
degis
endc

ORG			0
goto			anaprogram

lookup
			addwf		PCL,F
			retlw			b'00111111'
			retlw			b'00000110'
			retlw			b'01011011'
			retlw			b'01001111'
			retlw			b'01100110'
			retlw			b'01101101'
			retlw			b'01111101'
			retlw			b'00000111'
			retlw			b'01111111'
			retlw			b'01101111'
			
anaprogram
			banksel			TRISD
			clrf				TRISD
			banksel			PORTD
			clrf				PORTD
			banksel			TRISA
			movlw			b'11110000'
			movwf			TRISA
			banksel			PORTA
			movlw			b'00001110'
			movwf			PORTA
			clrf				degis
don
			movf				degis,W
			call				lookup
			movwf			PORTD
			movlw			d'10'
			call				gecikme
			incf				degis,F
			goto				don

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
			decfsz			sayac1,F
			goto				dongu1
			decfsz			sayac0,F
			goto				dongu0
			return
END 