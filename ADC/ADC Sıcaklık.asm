	list p=16F877A
	INCLUDE <P16F877A.INC>
	
	SAYAC1  EQU 0X22 
	SAYAC2  EQU 0X23 
	LCDDATA EQU 0X24
	ONB	    EQU 0X25 
	BIRB    EQU 0X26 
	ARADEG  EQU 0X27 

	ORG 0X00
	GOTO ANA	
ANA
	BSF STATUS,RP0
	CLRF  TRISB
	MOVLW 0XFF
	MOVWF TRISA
	MOVLW 0X80
	MOVWF ADCON1
	BCF   STATUS,RP0
	MOVLW 0XC9
	MOVWF ADCON0	
	MOVLW 0X02
	CALL KOMUTYAZ
	MOVLW 0X06
	CALL KOMUTYAZ
	MOVLW 0X0C
	CALL KOMUTYAZ
	MOVLW 0X2C
	CALL KOMUTYAZ
	CLRF ONB
	CLRF BIRB
YAZDIRMA_ISLEMI
	CLRF ONB
	CLRF BIRB
	CALL ADC_BASLA
	MOVWF ARADEG
	CALL ONLAR
	CALL LCD_ADC_YAZ
RETURN
ADC_BASLA
	BSF ADCON0,2
	CALL GECIKME
ADC_KONTROL
	BTFSC ADCON0,2
	GOTO  ADC_KONTROL
	BSF   STATUS,RP0
	RRF   ADRESL,0
	BCF   STATUS,RP0
	MOVWF ARADEG
	GOTO ONLAR
ONLAR
	MOVLW D'10'
	SUBWF ARADEG,0
	BTFSS STATUS,C
	GOTO  BIRLER
	INCF  ONB,1
	MOVLW  D'10'
	SUBWF ARADEG,1
	GOTO ONLAR
BIRLER
	MOVF ARADEG,0
	MOVWF BIRB
LCD_ADC_YAZ
	MOVLW  0X80
	CALL KOMUTYAZ
	MOVLW 'S'    
	CALL VERIYAZ
	MOVLW 'I' 		
	CALL VERIYAZ
	MOVLW 'C' 		
	CALL VERIYAZ
	MOVLW 'A' 		
	CALL VERIYAZ
	MOVLW 'K' 		
	CALL VERIYAZ
	MOVLW 'L' 	
	CALL VERIYAZ
	MOVLW 'I' 	
	CALL VERIYAZ
	MOVLW 'K' 		
	CALL VERIYAZ
	MOVLW A':' 		;
	CALL VERIYAZ	
	MOVLW A' ' 		;
	CALL VERIYAZ
	BSF ONB,4
	BSF ONB,5
	MOVF ONB,0
	CALL VERIYAZ
	MOVLW b'00110000'
	IORWF BIRB,0
	CALL VERIYAZ	
	MOVLW A' ' 		;bosluk
	CALL VERIYAZ	
	MOVLW b'11011111'		;derece simgesi
	CALL VERIYAZ	
	MOVLW A'C' 		;C harfi
	CALL VERIYAZ
	CALL YAZDIRMA_ISLEMI
KOMUTYAZ
	MOVWF LCDDATA
	SWAPF LCDDATA,W
	ANDLW 0X0F
	MOVWF PORTB
	BCF PORTB,4
	BSF  PORTB,5
	CALL GECIKME
	BCF PORTB,5
	MOVF LCDDATA,W
	ANDLW 0X0F
	MOVWF PORTB
	BCF PORTB,4
	BSF  PORTB,5
	CALL GECIKME
	BCF PORTB,5
RETURN
VERIYAZ
	MOVWF LCDDATA
	SWAPF LCDDATA,W
	ANDLW 0X0F
	MOVWF PORTB
	BSF PORTB,4
	BSF  PORTB,5
	CALL GECIKME
	BCF PORTB,5
	MOVF LCDDATA,W
	ANDLW 0X0F
	MOVWF PORTB
	BSF PORTB,4
	BSF  PORTB,5
	CALL GECIKME
	BCF PORTB,5
RETURN
GECIKME
	MOVLW 0X20
	MOVWF SAYAC1
D1
	MOVLW 0X30
	MOVWF SAYAC2
D2 
	DECFSZ SAYAC2,1
	GOTO   D2
	DECFSZ SAYAC1,1
	GOTO   D1
RETURN
    END
