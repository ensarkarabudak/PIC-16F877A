#include <P16F877A.INC>
__config H'3F31'


org 0x00

AYARLAR
	bsf STATUS,5
	clrf TRISA
	clrf TRISC
	movlw B'00000110'
	movwf ADCON1
	movlw B'11111111'
	movwf PR2
	bcf STATUS,5

	clrf TMR2
	movlw B'10000000' ; DUTY TIME
	movwf CCPR1L
	movlw B'00000100' ; TMR2 Enabled Yepýldý prescaler ve postscaler 1/1 yapýldý.
	movwf T2CON
	movlw B'00001100'
	movwf CCP1CON	; Pwm modu

DONGU
	btfsc PORTA, 0
	goto ARTTIR
	btfsc PORTA, 1
	goto AZALT
	goto DONGU

ARTTIR       
	movlw B'00010000' ;DUTY TIME
	addwf CCPR1L, F
	goto BEKLETICI
AZALT
	movlw B'00010000' ;DUTY TIME
	subwf CCPR1L, F
	goto BEKLETICI

BEKLETICI
	btfsc PORTA, 1
	goto BEKLETICI
	btfsc PORTA, 0
	goto BEKLETICI
	goto DONGU

END
