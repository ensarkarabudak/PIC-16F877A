list			p=16f877
include		"p16f877.inc"

cblock		0x20
sayac0
sayac1
sayac2
endc

ORG			0
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
yak0
			movlw			b'00111111'
			movwf			PORTD
			movlw			d'10'
			call				gecikme
yak1
			movlw			b'00000110'
			movwf			PORTD
			movlw			d'10'
			call				gecikme
yak2
			movlw			b'01011011'
			movwf			PORTD
			movlw			d'10'
			call				gecikme
yak3
			movlw			b'01001111'
			movwf			PORTD
			movlw			d'10'
			call				gecikme
yak4
			movlw			b'01100110'
			movwf			PORTD
			movlw			d'10'
			call				gecikme
yak5
			movlw			b'01101101'
			movwf			PORTD
			movlw			d'10'
			call				gecikme
yak6
			movlw			b'01111101'
			movwf			PORTD
			movlw			d'10'
			call				gecikme
yak7
			movlw			b'00000111'
			movwf			PORTD
			movlw			d'10'
			call				gecikme
yak8
			movlw			b'01111111'
			movwf			PORTD
			movlw			d'10'
			call				gecikme
yak9
			movlw			b'01101111'
			movwf			PORTD
			movlw			d'10'
			call				gecikme
			goto				yak0
			
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