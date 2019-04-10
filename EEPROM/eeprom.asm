#INCLUDE<P16F877.INC>
DEGER	EQU		0X21	
ORG		0X00

ANA_PROGRAM
	BANKSEL	TRISB
	BSF		TRISB,0
	BSF		TRISB,1
	CLRF	TRISD
	BANKSEL	PORTD
	CLRF	DEGER
	MOVLW	0X00
	CALL	EEPROM_ADRES
	CALL	EEPROM_OKU
	MOVWF	PORTD
MAIN
	BTFSC	PORTB,0
	GOTO	ARTIR	
	BTFSC	PORTB,1
	GOTO	AZALT
	GOTO	MAIN	
ARTIR
	MOVLW	0X00
	CALL	EEPROM_ADRES
	INCF	DEGER,1
	MOVF	DEGER,W
	CALL	EEPROM_YAZ
	CALL	EEPROM_OKU
	MOVWF	PORTD
	GOTO	MAIN
AZALT
	MOVLW	0X00
	CALL	EEPROM_ADRES
	DECF	DEGER,1
	MOVF	DEGER,W
	CALL	EEPROM_YAZ
	CALL	EEPROM_OKU
	MOVWF	PORTD
	GOTO	MAIN

EEPROM_ADRES
	BANKSEL 	EEADR
	MOVWF		EEADR		
	BANKSEL 	0x00
	RETURN

EEPROM_OKU
	BANKSEL		EECON1			
	BSF			EECON1,RD
	BANKSEL		EEDATA		
	MOVF		EEDATA,W		
	BANKSEL		0X00
	RETURN

EEPROM_YAZ
	BANKSEL		EEADR
	MOVWF		EEDATA

	BANKSEL		EECON1
	BSF			EECON1,WREN	

	BCF			INTCON,GIE
	MOVLW		0X55	
	MOVWF		EECON2	
	MOVLW		0XAA	
	MOVWF		EECON2	

	BSF			EECON1,WR
	BSF			INTCON,GIE

	BTFSC		EECON1,WR	
	GOTO		$-1	
		
	BCF			EECON1,WREN		
	BANKSEL		0X00			
	RETURN
END