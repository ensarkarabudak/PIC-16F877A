sayac EQU 0X21
org 0X00
goto Start
org 0X04

interrupt
bcf PIR1,TMR1IF    ;
movlw H'3C'
movwf TMR1H
movwf H'B0'
movwf TMR1L
DECF sayac,1
BTFSS STATUS,Z
retfie
movlw D'5'
movwf sayac
goto LED

LED
INCF PORTD,F   
retfie

Start
MOVLW B'11000000'  ;GIE AKTIF -Cevresel Kesme Aktif
MOVWF INTCON
bsf STATUS,RP0
movlw b'00000001'
movwf PIE1                     ;timer1 tasma kesmesine izin ver
movlw b'00000000'
movwf TRISD
bcf STATUS,RP0
movlw b'00100001'                       ;Timer kesmesini aktif et ve prescaler degeri 4
movwf T1CON
movlw D'5'
movwf sayac
movlw H'3C'
movwf TMR1H
movlw H'B0'
movwf TMR1L
clrf PORTD
DON
goto DON
end