;----------------------------------------------------------
; Code Produced by the PROTON+ Compiler. Version 3.2.5.5
; Copyright Rosetta Technologies/Crownhill Associates
; Written by Les Johnson. February 2007
;----------------------------------------------------------
 NOLIST
 #include "C:\USERS\IMAGE\DESKTOP\PIC_LCD\LCD_DENEME.PBP"
 LIST

	#Define __LCD_DTPORT PORTB
	#Define __LCD_RSPORT PORTB
	#Define __LCD_ENPORT PORTB
F2_SOF equ $ ; LCD_DENEME.PRP
F2_EOF equ $ ; LCD_DENEME.PRP
F1_SOF equ $ ; LCD_DENEME.BAS
F1_000009 equ $ ; in [LCD_DENEME.BAS] ALL_DIGITAL = True
	Movlw 7
	Bsf STATUS,5
ram_bank = 1
	Movwf CMCON
	Movlw 7
	Movwf ADCON1
F1_000010 equ $ ; in [LCD_DENEME.BAS] TRISA = 0
	Clrf TRISA
F1_000011 equ $ ; in [LCD_DENEME.BAS] DelayMS 150
	Movlw 150
	Bcf STATUS,5
ram_bank = 0
	F@Call dl@ms
F1_000012 equ $ ; in [LCD_DENEME.BAS] Cls
	F@Call Lcd@Cls
F1_000015 equ $ ; in [LCD_DENEME.BAS] DelayMS 100
	Movlw 100
	F@Call dl@ms
MAIN
F1_000019 equ $ ; in [LCD_DENEME.BAS] Print At 1,1, "Hello World"
	Movlw 128
	Movwf BPFH
	Movlw 128
	F@Call LCD@crs
	Movlw ((str@lb1 >> 8) & 255)
	Movwf GEN4H
	Movlw (str@lb1 & 255)
	F@Call c@strout
F1_000022 equ $ ; in [LCD_DENEME.BAS] PORTA.0 = 1
	Bsf PORTA,0
F1_000023 equ $ ; in [LCD_DENEME.BAS] DelayMS 60
	Movlw 60
	F@Call dl@ms
F1_000024 equ $ ; in [LCD_DENEME.BAS] PORTA.0 = 0
	Bcf PORTA,0
F1_000025 equ $ ; in [LCD_DENEME.BAS] DelayMS 60
	Movlw 60
	F@Call dl@ms
F1_000027 equ $ ; in [LCD_DENEME.BAS] GoTo Main
	F@Jump MAIN
F1_EOF equ $ ; LCD_DENEME.BAS
 LIST
;---------------------------------------------
; Null Terminated Strings

; String Hello World
str@lb1
	DE 72,101,108,108,111,32,87,111,114,108,100,0
;---------------------------------------------
	END

