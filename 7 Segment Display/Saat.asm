LSB	EQU	H'0021'
MSB	EQU	H'0022'
SAYI1	EQU	H'0023'
SAYI2	EQU	H'0024'
SAYI3	EQU	H'0025'
SAYI4	EQU	H'0026'
SAYI5	EQU	H'0027'
DEGER	EQU	H'0028'
BIR	EQU	H'0029'
ON	EQU	H'002A'
YUZ	EQU	H'002B'
BIN	EQU	H'002C'
RAKAM	EQU	H'002D'
RAKAM1	EQU	H'002E'
TEMP	EQU	H'002F'
;-------------
BASLA
	CLRF	 MSB
	CLRF	 LSB
	BSF	 STATUS,5
	MOVLW 	 B'11110000'
	MOVWF    TRISA
	MOVLW 	 B'10000000'
	MOVWF	 TRISB
	BCF	 STATUS,5
	CLRF	PORTB
	CLRF	PORTA
	CLRF	BIR
	CLRF	ON
	CLRF	YUZ
	CLRF	BIN
	CLRF	SAYI1
	CLRF	SAYI2
	CLRF	SAYI3
	CLRF	SAYI4
	GOTO	ANA
;-----------
ART
	INCF	BIR,F
	MOVLW	.10
	SUBWF	BIR,W
	BTFSS	STATUS,Z
	GOTO	ASON
	CLRF	BIR
	INCF	ON,F
	MOVLW	.10
	SUBWF	ON,W
	BTFSS	STATUS,Z
	GOTO	ASON
	CLRF	ON
	INCF	YUZ,F
	MOVLW	.10
	SUBWF	YUZ,W
	BTFSS	STATUS,Z
	GOTO	ASON
	CLRF	YUZ
	INCF	BIN,F
	MOVLW	.10
	SUBWF	BIN,W
	BTFSS	STATUS,Z
	GOTO	ASON
	CLRF	BIN
ASON
	CALL	EKRAN
	BTFSS	PORTB,7
	GOTO	ASON
	GOTO	ANA
;-----------
AZAL
	MOVLW	.1
	SUBWF	BIR,F
	BTFSC	STATUS,C
	GOTO	ESON
	CLRF	BIR
	MOVLW	.1
	SUBWF	ON,F
	BTFSC	STATUS,C
	GOTO	BIR9
	CLRF	ON
	MOVLW	.1
	SUBWF	YUZ,F
	BTFSC	STATUS,C
	GOTO	ON9
	CLRF	YUZ
	MOVLW	.1
	SUBWF	BIN,F
	BTFSC	STATUS,C
	GOTO	YUZ9
	CLRF	BIN
	GOTO	ESON
;----------
YUZ9
	MOVLW	.9
	MOVWF	YUZ
ON9
	MOVLW	.9
	MOVWF	ON
BIR9
	MOVLW	.9
	MOVWF	BIR
ESON
	CALL	EKRAN
	BTFSS	PORTA,4
	GOTO	ESON
	GOTO	ANA
;-----------
ANA
	CALL	EKRAN
	BTFSS	PORTA,4
	GOTO	AZAL
	BTFSS	PORTB,7
	GOTO	ART
	GOTO	ANA
;----------
EKRAN
	MOVLW	.5
	MOVWF	RAKAM
	CLRF	PORTB
	MOVLW	.255
	MOVWF	PORTA
GOSTER
	BCF	PORTA,0
	BSF	PORTA,1
	BSF	PORTA,2
	BSF	PORTA,3
	MOVF    BIR,W
        CALL	TABLO
	MOVWF   PORTB
	CALL	GECIKME
	CALL	GECIKME
	CLRF	PORTB
	BSF	PORTA,0
	BCF	PORTA,1
	BSF	PORTA,2
	BSF	PORTA,3
	MOVF    ON,W
        CALL	TABLO
	MOVWF   PORTB
	CALL	GECIKME
	CLRF	PORTB
	BSF	PORTA,0
	BSF	PORTA,1
	BCF	PORTA,2
	BSF	PORTA,3
	MOVF    YUZ,W
        CALL	TABLO
	MOVWF   PORTB
	CALL	GECIKME
	CLRF	PORTB
	BSF	PORTA,0
	BSF	PORTA,1
	BSF	PORTA,2
	BCF	PORTA,3
	MOVF    BIN,W
        CALL	TABLO
	MOVWF   PORTB
	CALL	GECIKME
	DECFSZ	RAKAM,F
	GOTO	GOSTER
	RETURN
GECIKME
	MOVLW	.5
	MOVWF	MSB
D11
	MOVLW	.55
	MOVWF	LSB
D22
	DECFSZ	LSB,F
	GOTO	D22
	DECFSZ	MSB,F
	GOTO	D11
	RETURN
TABLO
	ADDWF	PCL,F
	RETLW	h'3F'
	RETLW	h'06'
	RETLW	h'5B'
	RETLW	h'4F'
	RETLW	h'66'
	RETLW	h'6D'
	RETLW	h'7D'
	RETLW	h'07'
	RETLW	h'7F'
	RETLW	h'6F'
	RETLW	h'77'
	RETLW	h'7C'
	RETLW	h'39'
	RETLW	h'5E'
	RETLW	h'79'
	RETLW	h'71'
	RETLW	h'80'



	END