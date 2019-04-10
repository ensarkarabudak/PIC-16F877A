list p=16F877
include p16F877.inc
SAY1 EQU 0X20
SAY2 EQU 0X21
VERI EQU 0X22
ORG 0X00

GOTO LCD_AYAR
ORG 0X04

LCD_AYAR

BANKSEL TRISB
CLRF TRISB
BANKSEL PORTB


MOVLW h'02'
CALL KOMUT_YAZ


MOVLW h'02'
CALL KOMUT_YAZ

MOVLW h'00'
CALL KOMUT_YAZ

MOVLW h'00'
CALL KOMUT_YAZ


MOVLW h'0E'
CALL KOMUT_YAZ


MOVLW h'00'
CALL KOMUT_YAZ


MOVLW h'06'
CALL KOMUT_YAZ







DONGU 
GOTO DONGU

KOMUT_YAZ
	MOVWF VERI
	BSF VERI,5
	BCF VERI,4
	MOVF VERI,W
	MOVWF PORTB
	CALL BEKLE
	CALL DISABLE
	CALL BEKLE
RETURN


HARF_YAZ
	MOVWF VERI
	BSF VERI,5
	BSF VERI,4
	MOVF VERI,W
	MOVWF PORTB
	CALL BEKLE
	CALL DISABLE
	CALL BEKLE
RETURN

BEKLE

MOVLW 0XFF
MOVWF SAY1
D1
MOVLW 0XFF
MOVWF SAY2
D2
DECFSZ SAY2,F
GOTO D2
DECFSZ SAY1,F
GOTO D1
RETURN

DISABLE
BANKSEL PORTB
BCF PORTB,5
BCF PORTB,4
RETURN

END