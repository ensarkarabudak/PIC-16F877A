;----------------------------------------------------------
; Code Produced by the PROTON+ Compiler. Version 3.2.5.5
; Copyright Rosetta Technologies/Crownhill Associates
; Written by Les Johnson. February 2007
;----------------------------------------------------------
 NOLIST
 #include "C:\USERS\IMAGE\DESKTOP\PIC_LCD\LCD_DENEME2.PBP"
 LIST

	#Define __LCD_DTPORT PORTB
	#Define __LCD_RSPORT PORTB
	#Define __LCD_ENPORT PORTB
F2_SOF equ $ ; LCD_DENEME2.PRP
F2_EOF equ $ ; LCD_DENEME2.PRP
F1_SOF equ $ ; LCD_DENEME2.BAS
F1_000009 equ $ ; in [LCD_DENEME2.BAS] ALL_DIGITAL = True
	Movlw 7
	Bsf STATUS,5
ram_bank = 1
	Movwf CMCON
	Movlw 7
	Movwf ADCON1
F1_000010 equ $ ; in [LCD_DENEME2.BAS] TRISA.0 = 0
	Bcf TRISA,0
F1_000011 equ $ ; in [LCD_DENEME2.BAS] TRISA.1 = 1
	Bsf TRISA,1
F1_000013 equ $ ; in [LCD_DENEME2.BAS] DelayMS 150
	Movlw 150
	Bcf STATUS,5
ram_bank = 0
	F@Call dl@ms
F1_000014 equ $ ; in [LCD_DENEME2.BAS] Cls
	F@Call Lcd@Cls
F1_000015 equ $ ; in [LCD_DENEME2.BAS] DelayMS 100
	Movlw 100
	F@Call dl@ms
MAIN
F1_000019 equ $ ; in [LCD_DENEME2.BAS] If PORTA.1 = 1 Then
	set@page bc@LL2
	Btfss PORTA,1
	Goto bc@LL2
F1_000020 equ $ ; in [LCD_DENEME2.BAS] Print At 1,1, "23 Nisan 1920   "
	Movlw 128
	Movwf BPFH
	Movlw 128
	F@Call LCD@crs
	Movlw ((str@lb1 >> 8) & 255)
	Movwf GEN4H
	Movlw (str@lb1 & 255)
	F@Call c@strout
F1_000021 equ $ ; in [LCD_DENEME2.BAS] Print At 2,1, "TBMM nin acilisi"
	Movlw 128
	Movwf BPFH
	Movlw 192
	F@Call LCD@crs
	Movlw ((str@lb2 >> 8) & 255)
	Movwf GEN4H
	Movlw (str@lb2 & 255)
	F@Call c@strout
F1_000022 equ $ ; in [LCD_DENEME2.BAS] PORTA.0 = 1
	Bsf PORTA,0
	F@Jump bc@LL3
bc@LL2
F1_000023 equ $ ; in [LCD_DENEME2.BAS] Else
F1_000024 equ $ ; in [LCD_DENEME2.BAS] Print At 1,1, "29 Ekim 1923    "
	Movlw 128
	Movwf BPFH
	Movlw 128
	F@Call LCD@crs
	Movlw ((str@lb3 >> 8) & 255)
	Movwf GEN4H
	Movlw (str@lb3 & 255)
	F@Call c@strout
F1_000025 equ $ ; in [LCD_DENEME2.BAS] Print At 2,1, "CUMHURIYET ILANI"
	Movlw 128
	Movwf BPFH
	Movlw 192
	F@Call LCD@crs
	Movlw ((str@lb4 >> 8) & 255)
	Movwf GEN4H
	Movlw (str@lb4 & 255)
	F@Call c@strout
F1_000026 equ $ ; in [LCD_DENEME2.BAS] PORTA.0 = 0
	Bcf PORTA,0
F1_000027 equ $ ; in [LCD_DENEME2.BAS] EndIf
bc@LL3
F1_000032 equ $ ; in [LCD_DENEME2.BAS] GoTo Main
	F@Jump MAIN
F1_EOF equ $ ; LCD_DENEME2.BAS
 LIST
;---------------------------------------------
; Null Terminated Strings

; String 23 Nisan 1920   
str@lb1
	DE 50,51,32,78,105,115,97,110,32,49,57,50,48,32,32,32,0
;---------------------------------------------
; String TBMM nin acilisi
str@lb2
	DE 84,66,77,77,32,110,105,110,32,97,99,105,108,105,115,105,0
;---------------------------------------------
; String 29 Ekim 1923    
str@lb3
	DE 50,57,32,69,107,105,109,32,49,57,50,51,32,32,32,32,0
;---------------------------------------------
; String CUMHURIYET ILANI
str@lb4
	DE 67,85,77,72,85,82,73,89,69,84,32,73,76,65,78,73,0
;---------------------------------------------
	END

