
#INCLUDE "P16F877.INC"

SAY1	EQU	021H
SAY2	EQU	022H
RS	EQU	.0
EN	EQU	.1
COUNT_L EQU	023H
COUNT_H EQU	024H
CURSOR	EQU	025H
CTRL	EQU	026H
TEMP	EQU	027H

	__CONFIG(_WRT_ENABLE_OFF & _DEBUG_OFF& _BODEN_OFF& _LVP_OFF& _WDT_OFF& _CP_OFF& _XT_OSC& _PWRTE_OFF)

	ORG 		0000H
	GOTO 	BASLA
	ORG 		0004H
	GOTO 	KESME

;********************************************************************
;	PIC IN BASLATILMASI						                 *
;********************************************************************

BASLA
	BSF	STATUS,RP0
	CLRF	TRISB
	MOVLW	0F0H
	MOVWF	TRISC
	CLRF	TRISD
	BCF	STATUS,RP0
	MOVLW h'0F'
	CALL	LCD_SETUP
	MOVLW h'38'
	CALL	LCD_SETUP

	MOVLW H'C0'
	CALL LCD_SETUP
	MOVLW A'E'
	CALL LCD_WRITE_DIGIT
	MOVLW A'N'
	CALL LCD_WRITE_DIGIT
	MOVLW A'S'
	CALL LCD_WRITE_DIGIT
	MOVLW A'A'
	CALL LCD_WRITE_DIGIT
	MOVLW A'R'

	MOVLW A' '
	CALL LCD_WRITE_DIGIT

	MOVLW A'K'
	CALL LCD_WRITE_DIGIT
	MOVLW A'A'
	CALL LCD_WRITE_DIGIT
	MOVLW A'R'
	CALL LCD_WRITE_DIGIT
	MOVLW A'A'
	CALL LCD_WRITE_DIGIT
	MOVLW A'B'
	CALL LCD_WRITE_DIGIT
	MOVLW A'U'
	CALL LCD_WRITE_DIGIT
	MOVLW A'D'
	CALL LCD_WRITE_DIGIT
	MOVLW A'A'
	CALL LCD_WRITE_DIGIT
	MOVLW A'K'
	CALL LCD_WRITE_DIGIT

	MOVLW H'80'
	CALL LCD_SETUP



	;CALL	LCD_SET2
	;CALL 	LCD_NEW_LINE
	CLRF	CURSOR

;*******************************************************************
;	ANA PROGRAM DONGUSU						   *
;*******************************************************************

ENBAS
	CALL	SAT1
	ADDLW	d'47'
	CALL	LCD_WRITE_DIGIT
	CALL	GECIK
    CALL	GECIK

	GOTO	ENBAS
;********************************************************************
;	KEYPAD'I KONTROL EDEN FONKSIYON				     *
;********************************************************************

SAT1
	MOVLW	01H
	MOVWF	PORTC
	BTFSC	PORTC,4
	RETLW	d'1'			;0 yazar
	BTFSC	PORTC,5
	RETLW	d'2'			;1 yazar
	BTFSC	PORTC,6
	RETLW	d'3'			;2 yazar
	BTFSC	PORTC,7
	RETLW	d'4'			;3 yazar
SAT2
	MOVLW	02H
	MOVWF	PORTC
	BTFSC	PORTC,4
	RETLW	d'5'			;4 yazar
	BTFSC	PORTC,5
	RETLW	d'6'			;5 yazar
	BTFSC	PORTC,6
	RETLW	d'7'			;6 yazar
	BTFSC	PORTC,7
	RETLW	d'8'			;7 yazar
SAT3
	MOVLW	04H
	MOVWF	PORTC
	BTFSC	PORTC,4
	RETLW	d'9'			;8 yazar
	BTFSC	PORTC,5
	RETLW	d'10'			;9 yazar
	BTFSC	PORTC,6
	RETLW	d'18'			;A yazar
	BTFSC	PORTC,7
	RETLW	d'19'			;B yazar
SAT4
	MOVLW	08H
	MOVWF	PORTC
	BTFSC	PORTC,4
	RETLW	d'20'			;C yazar
	BTFSC	PORTC,5
	RETLW	d'21'			;D yazar
	BTFSC	PORTC,6
	RETLW	d'22'			;E yazar
	BTFSC	PORTC,7
	RETLW	d'23'			;F yazar
	GOTO	SAT1

;**************************************************************
;	LCD NIN BASLATILMASI						     *
;**************************************************************

LCD_SETUP
	BCF	PORTD,RS
	;KURSOR YANIP SONECEK
	MOVWF	PORTB
	CALL	LCD_ENABLE
	CALL	GECIK
	RETURN

;**************************************************************
;	CURSOR U EN BASA ALAN FONKSIYON			     *
;**************************************************************

LCD_SET2
	BCF	PORTD,RS
	MOVLW	B'10000000'
	MOVWF	PORTB
	CALL	LCD_ENABLE
	CALL	LCD_DELAY
	BSF	PORTD,RS
	RETURN

;****************************************************************
;	LCD EKRANINI TEMIZLEYEN FONKSIYON			         *
;****************************************************************

LCD_TEMIZLE
	CLRF	CURSOR
	CALL	LCD_SET2
	BSF	PORTD,RS
	MOVLW	.32
	MOVWF	PORTB
	MOVLW	.17
	MOVWF	TEMP
CLEAR
	CALL	LCD_ENABLE
	CALL 	GECIK
	DECFSZ	TEMP,F
	GOTO	CLEAR
	CALL	LCD_SET2
	RETURN






;************************************************************
;	ALT SATIRA GECME FONKSIYONU				 *
;************************************************************

LCD_NEW_LINE
	INCF	CTRL
	BCF	PORTD,RS
	MOVLW	B'10010000'
	MOVWF	PORTB
	CALL	LCD_ENABLE
	BSF	PORTD,RS
	MOVLW	.2
	SUBWF	CTRL,W
	BTFSC	STATUS,Z
	CALL	LCD_SET2
	RETURN

;*****************************************************************
;      LCD NIN DATA VEYA KOMUTU ISLEMESINI SAGLAYAN FONK     *
;*****************************************************************

LCD_ENABLE
	BCF	PORTD,EN
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	BSF	PORTD,EN
	CALL	LCD_DELAY
	RETURN

LCD_DELAY
	MOVLW	7FH
	MOVWF	COUNT_H

LCD_DELAY2
	MOVLW	0FFH
	MOVWF	COUNT_L

LCD_LOOP
	DECFSZ	COUNT_L,F
	GOTO	LCD_LOOP
	DECFSZ	COUNT_H,F
	GOTO	LCD_DELAY2
	RETURN

;**************************************************************
;	OKUNAN KAREKTERI LCD YE YAZAN FONKSIYON	     *
;**************************************************************

LCD_WRITE_DIGIT
	MOVWF	PORTB
	INCF	CURSOR
	BSF	PORTD,RS
	CALL	LCD_ENABLE
	MOVLW	.16
	SUBWF	CURSOR,W
	BTFSC	STATUS,Z
	CALL	LCD_TEMIZLE
	RETURN

;**************************************************************
;GECIKME FONKSIYONU							     *
;**************************************************************

GECIK			;193 MS BEKLEME
	MOVLW	.255
	MOVWF   SAY2
BAS1
	MOVWF	SAY1
DON2
	DECFSZ	SAY1,F
	GOTO 	DON2
	DECFSZ  SAY2,F
	GOTO	BAS1
	RETURN

;*************************************************************
;KESME	ALT PROGRAMI						   *
;*************************************************************

KESME
	RETFIE
	END

