;*****************TMR1 �LE �LK D�RT LED VE SON D�RT LED�N D�N���ML� ;YANMASI*******************LIST P=16F877INCLUDE <P16F877.INC>SAYAC EQU 0X21ORG 0GOTO MAINORG 4KESMEINCF SAYAC,FBANKSEL PIR1BCF PIR1,0RETFIEMAINBANKSEL TRISB CLRF TRISBMOVLW 0X01BANKSEL T1CONMOVWF T1CONBCF PIR1,0BANKSEL PIE1BSF PIE1,0MOVLW 0XF0BANKSEL PORTBMOVWF PORTBCLRF SAYACMOVLW 0XC0MOVWF INTCONMAIN1MOVLW D'12'SUBWF SAYAC,WBTFSS STATUS,ZGOTO MAIN1COMF PORTB,WMOVWF PORTBCLRF SAYACGOTO MAIN1END