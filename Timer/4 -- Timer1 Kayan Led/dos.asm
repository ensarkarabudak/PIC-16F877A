list				p=16f877
include			"p16f877.inc"

cblock		0x20
sayac
endc

ORG			0
goto			anaprogram
ORG			4
goto			kesme

anaprogram
			movlw			d'4'
			movwf			sayac
			banksel			TRISC
			clrf				TRISC
			banksel			PORTC
			movlw			b'10000000'
			movwf			PORTC
			banksel			T1CON
			movlw			b'00110001'
			movwf			T1CON
			bcf 				PIR1,TMR1IF
			banksel 		PIE1
			bsf 				PIE1,TMR1IE
			banksel			INTCON
			bsf				INTCON,6
			bsf				INTCON,7
			goto				$
			
kesme
			banksel			PIE1
			btfss				PIE1,0
			retfie
			banksel			PIR1
			btfss				PIR1,0
			retfie
			bcf				PIR1,0
			decfsz			sayac,F
			retfie
			rrf					PORTC
			movlw			d'4'
			movwf			sayac
			retfie
END 