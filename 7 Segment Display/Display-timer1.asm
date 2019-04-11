    	LIST    p=16F877
		#include "P16F877.INC"
	

		SAYAC EQU 20H 		; Kesmeleri sayacak sayaç
		SAYAC_SAYI EQU 21H  ;Sayýnýn deðerini belirleyecek sayaç

;------------------------------------------------------------		
;		PROGRAMA BAÞLAYALIM									;										
;------------------------------------------------------------
	ORG 0
 		GOTO ANA_PROGRAM
		ORG 4
		GOTO KESME

;------------------------------------------------------------
;		ÝLKÝÞLEM ALTPROGRAMINI BAÞLANGICI					;
;------------------------------------------------------------
	ILKISLEM:
		MOVLW H'04' 	  ;Kesmeleri sayacak olan sayac
		MOVWF SAYAC
		MOVLW B'00110001' ; Timer1 için prescale, osilatör seçimi ve
		MOVWF T1CON		  ; Timer1'in çalýþma durumunun belirtilmesi
		BCF PIR1,0		  ; Timer1 flaðýný indiriyoruz 
		BSF STATUS,RP0 
 		BSF PIE1,0		  ; Timer1'in çalýþmasýna izin verilmesi
		MOVLW h'00'
		MOVWF TRISA 	  ; PORTA'yý çýkýþ yaptýk
		MOVWF TRISD 	  ; PORTD'yi çýkýþ yaptýk
		BCF STATUS,5 	
		MOVLW H'01'		  ; Deney setimizde sadece sondaki displayýn
		MOVWF PORTA 	  ; için vermemmiz gereken sayý
		BSF INTCON,7	  ; Genel kesmelere izin verdik
		BSF INTCON,6	  ;	Çevresel kesmelere izin verdik
		MOVLW H'00'		   
		MOVWF TMR1L		  ;Timer1'in nerden baþlayacaðýný seçtik
		MOVWF TMR1H			
		CALL ORTAK_KATOT
		INCF SAYAC_SAYI,1
		MOVWF PORTD
		RETURN 

;------------------------------------------------------------
;		KESME ALT PROGRAMIMIZIN BAÞLANGICI					;
;------------------------------------------------------------
	KESME:
		BCF PIR1,0
		DECFSZ SAYAC,1
		RETFIE
		MOVFW SAYAC_SAYI	;Tablodan hangi sayýyý alacaðýmýzý seçiyoruz
		CALL ORTAK_KATOT
		INCF SAYAC_SAYI,1	;Bi dahaki sefer için gerekli sayýyýnýn adresi
		MOVWF PORTD
		MOVLW H'04'
		MOVWF SAYAC
		RETFIE

	
;------------------------------------------------------------
;		ORTAK KATOT PROGRAMIMIZIN BAÞLANGICI				;
;------------------------------------------------------------
	ORTAK_KATOT:
		addwf	PCL, F
		retlw	0x3F		; 0 rakamý için segment deðeri.
		retlw	0x06		; 1 rakamý için segment deðeri.
		retlw	0x5B		; 2 rakamý için segment deðeri.
		retlw	0x4F		; 3 rakamý için segment deðeri.
		retlw	0x66		; 4 rakamý için segment deðeri.
		retlw	0x6D		; 5 rakamý için segment deðeri.
		retlw	0x7D		; 6 rakamý için segment deðeri.
		retlw	0x07		; 7 rakamý için segment deðeri.
		retlw	0x7F		; 8 rakamý için segment deðeri.
		MOVLW H'FF'			; FF ten sonra 00 gelir sayac 
		MOVWF SAYAC_SAYI	; Sýfýrlanmýþ olur
		retlw	0x6F		; 9 rakamý için segment deðeri.


;------------------------------------------------------------
;				ANA PROGRAM									;
;------------------------------------------------------------
	ANA_PROGRAM:
		CALL ILKISLEM
	SONSUZ:
		GOTO SONSUZ


	END
	