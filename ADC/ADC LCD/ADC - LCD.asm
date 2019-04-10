	LIST P = 16F877
	INCLUDE p16f877.inc

SAYAC0 EQU 0x20
SAYAC1 EQU 0x21
	ORG 0x00
	GOTO ANA_PROGRAM
	ORG 0x04
	GOTO KESME

ANA_PROGRAM
	BANKSEL PORTB
	CLRF PORTB
	BANKSEL TRISB		
	CLRF TRISB
	CLRF TRISC
	CLRF TRISD
	CLRF TRISE
	BSF PIE1,6 			;(ADIE)  A/D dönüþtürme KESMElerine izin verdik
	MOVLW 0x80			;ADFM=1 ADRESH ýn msb kýsmýndaki 6 bit 0 kabul edilir.
	MOVWF ADCON1		;Veri ADRESH ýn 2 bitlik lsb kýsmýna ve ADRESL ye yazýlýr.
	BANKSEL PIR1		;bank 0
	BCF PIR1,6 		    ;(ADIF) ADC interrupt bayraðýný indir
	MOVLW h'C0'	        ;Aktif yapýlmýþ tüm çevresel KESMElere izin verildi.	
	MOVWF INTCON	    ;Aktif yapýlmýþ tüm KESMElere izin verildi.
	MOVLW 0xD1			;Kanal 2 seçtik.ADC çeviriciyi açýktýk.
    MOVWF ADCON0	
	CALL GECÝK		    
	BSF ADCON0,2		;çeviriyi baþlat
	
SONSUZ:GOTO SONSUZ			;sonsuz döngü...
	
KESME
	BTFSS PIR1,6		;(ADIF)Gelen interrupt ADC'den mi gelmiþ
	RETFIE				
	BCF PIR1,6		    ;(ADIF)Flagý sýfýrla
	BTFSC ADCON0,3		;Kanal 3'ý çevirdiysek 1, 2'yi çevirdiysek 0 olur
	GOTO YÜKLE_3	    ;deðeri port d ve port e ye yükle
	GOTO YÜKLE_2	    ;deðeri port b ve port c ye yükle
	
YÜKLE_2
	BANKSEL ADRESL
	MOVF ADRESL,w
	BANKSEL PORTB		;bank0
	MOVWF PORTB
	MOVF ADRESH,w
	MOVWF PORTC			;deðeri portB ve C'ye yükle
	MOVLW 0xD9			;Kanal 3 seç.
   	MOVWF ADCON0
	CALL GECÝK		    ;1ms adc'yi bekle
	BSF ADCON0,2		;çeviriyi baþlat		
   	RETFIE

YÜKLE_3
	BSF STATUS,RP0		;bank1
	MOVF ADRESL,w
	BCF STATUS,RP0		;bank0
	MOVWF PORTD
	MOVF ADRESH,w
	MOVWF PORTE			;deðeri portD ve E'ye yükle
	MOVLW 0xD1			;Kanal 2 seç.
    MOVWF ADCON0
	CALL GECÝK		    ;1ms adc'yi bekle		
	BSF ADCON0,2		;çeviriyi baþlat
    RETFIE

GECÝK	
	MOVLW d'8'			;working register'a atýlan deger kadar ms gecik
	MOVWF SAYAC1
DÖNGÜ
	MOVLW d'255'
	MOVWF SAYAC0
DÖNGÜ1
	DECFSZ SAYAC0,1
	GOTO DÖNGÜ1
	DECFSZ SAYAC1,1
	GOTO DÖNGÜ
	RETURN
END