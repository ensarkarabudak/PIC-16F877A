;*******************************************************************************;*************** 2SN ARALIKLARLA YANIP S�NEN LED TMRO************list p=16F877Ainclude "p16F877A.inc"SAYICI EQU 0X25ORG 0X00GOTO ANAORG 0X04BTFSS INTCON,2GOTO KESMESON;MOVLW D'6';MOVWF TMROBCF INTCON,2INCF SAYICI,FMOVLW D'250'SUBWF SAYICI,WBTFSS STATUS,CGOTO KESMESONCLRF SAYICIBTFSS PORTB,0GOTO YAKBCF PORTB,0GOTO KESMESONYAKBSF PORTB,0KESMESON RETFIEANAMOVLW 0XD4BANKSEL TRISBMOVWF OPTION_REGBCF TRISB,0BCF STATUS,RP0BCF PORTB,0MOVLW D'6'MOVWF TMR0BSF INTCON,5BSF INTCON,7DON GOTO DONEND