timercounter EQU 0X21
SAYAC		 EQU 0X22
org 0X00
goto Start
org 0X04
CALL	KESME_KONTROL
 
KESME_KONTROL
		
		BCF		INTCON,GIE
		
		BTFSC	INTCON,T0IF
		CALL	KESME1
		
		BTFSC	PIR1,TMR1IF
		CALL	KESME
		
		BSF		INTCON,GIE
;return

KESME1
 BCF INTCON,T0IF  ;timer0 kesmesinin tasma oldugunu gösteren bitini sifirla
 MOVLW D'6'    ;timer0'a (256-250)=6 degerini ver.250 saysin
 MOVWF TMR0
 
 DECF timercounter,F   ;(SAYACI 1 AZALTIP TMR0SAYACI NA YAZAR)
 
 BTFSS STATUS,Z  ;timer0 sayaci 0'lanmis mi?
 RETFIE
 
 MOVLW D'19'   ;timer0 sayaci 0'lanmissa 50 degerini yeniden yükle
 MOVWF timercounter 


 GOTO LED           ;led yaniyor mu?sönük mü? kontrol etmek için alt programa git
 BSF	INTCON,T0IF 
RETFIE 
LED 
INCF PORTC,F;PortD icerigini 1 ile XOR la
 RETFIE

KESME
bcf PIR1,TMR1IF    
movlw H'3C'
movwf TMR1H
movwf H'B0'
movwf TMR1L
DECF SAYAC,1
BTFSS STATUS,Z
retfie
movlw D'7'
movwf SAYAC

goto LED2
BSF	PIR1,TMR1IF
RETFIE
LED2

INCF	PORTD,F
RETFIE

 Start
        CLRF		PORTC
		CLRF		PORTD
		BANKSEL		TRISC
		CLRF		TRISC
		CLRF		TRISD


bsf STATUS,RP0
movlw b'10100000';tüm kesmeleri ve timer0 kesmesini aktif et
movwf INTCON
movlw b'01010110'
movwf OPTION_REG;yukselen kenar kesmesi,1:64 prescaler timerodahili komutcevrimi
bcf STATUS,RP0
movlw d'6'
movwf TMR0;TMRO baslangic degeri
movlw d'19'
movwf timercounter ;tmrocounter baslangic degeri
clrf PORTC


MOVLW B'11000000'  ;GIE AKTIF -Cevresel Kesme Aktif
MOVWF INTCON
bsf STATUS,RP0
movlw b'00000001'
movwf PIE1                     ;timer1 tasma kesmesine izin ver
bcf STATUS,RP0
movlw b'00010001'                       ;Timer kesmesini aktif et ve prescaler degeri 4
movwf T1CON
movlw D'7'
movwf SAYAC
movlw H'3C'
movwf TMR1H
movlw H'B0'
movwf TMR1L
clrf PORTD


 DON
 goto DON




end