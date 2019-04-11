;*******************************************************************
;	Dosya Adý		: 9_1.asm
;	Programýn Amacý		: Dahili eeprom belleðe veri yazma ve okuma
;	PIC DK2.1a 		: PORTB Çýkýþ ==> LED
;				: XT ==> 4Mhz
;*******************************************************************
	list p=16F877A
	include "p16F877A.inc"	
	__config H'3F39' 		;Tüm program sigortalarý kapalý, 
	adres equ 0x20
sayac0 equ 0x21
sayac1 equ 0x22
sayac2 equ 0x23
DEGER equ 0x24
SAYA0 EQU 0X25
SAYA1 EQU 0X26
					;Osilatör XT ve 4Mhz
	ORG 	0			;Reset vektör adresi.
	clrf 	PCLATH			;0. Program sayfasý seçildi.
	goto 	ana_program		;ana_programa'a git.
	
	ORG	4			;Kesme vektör adresi.
    goto KESME				;Kesme kullanýmý gerekiyorsa 
					;buradan itibaren yazýlmalý. 
					;ya da goto komutu ile buradan yönlendirilmeli.
KESME
	BTFSS PIR1,6	 ;Gelen kesme A/D kesmesimi ??	
	RETFIE			 	
	BCF PIR1,6		 ;A/D kesme bayraðýný indir.   
	BTFSS ADCON0,2	 ;A/D kesmesi hangi kanaldan gelmiþ ??	
	retfie        	
    BANKSEL ADRESL   	
	MOVF ADRESL,w   ;ADRESL = W
	BANKSEL DEGER		
	MOVWF DEGER    ;10 bitin en anlamasýz 8 bitini PORTB ye at.
	MOVLW 0xD1			
   	MOVWF ADCON0    ;Kanal3 e git.
	CALL GECÝK		    
	BSF ADCON0,2	;A/D dönüþtürücü iþlem yapsýn.			
   	RETFIE

;-------------------------------------------------------------------
; Dahili EEPROM'a veri yazma alt programý:
; Çaðrýlmadan önce EEADR kaydedicisine yazýlacak adres, EEDATA 
; kaydedicisine ise yazýlacak veri yüklenmeli.
;-------------------------------------------------------------------
dahili_EEPROM_yaz
	banksel EECON1			;EECON1'in bulunduðu BANK seçildi.
	bcf	INTCON, GIE		;Genel kesmeler pasif. (Yazmada 
					;iþlem akýþý bozulmamalý.)
	bsf	EECON1, WREN		;Yazma etkinleþtirme bit’i set 
					;edildi.
	movlw	0x55			;Yazma için buradan itibaren 5 
					;satýr aynen korunmalý.
	movwf	EECON2
	movlw	0xAA
	movwf	EECON2
	bsf	EECON1, WR		;Yaz komutu verildi.
	bsf	INTCON, GIE		;Genel kesmeler aktif. (Kesme 
					;kullanýlmayacaksa silinebilir.)
    call Gecik		;100ms adc'yi bekle	
;dahili_ee_j1
;	btfsc 	EECON1, WR		;Yazma iþlemi tamamlanana kadar 
;					;bekle (WR=0 olana kadar).
;	goto 	dahili_ee_j1
;	bcf 	EECON1, WREN		;Yazma izni kaldýrýldý.
;	return
;-------------------------------------------------------------------
; Dahili EEPROM'dan veri okuma alt programý: Çaðrýlmadan önce EEADR 
; kaydedicisine okunacak verinin adresi yüklenmeli.
;-------------------------------------------------------------------
dahili_EEPROM_oku
	banksel EECON1
	bsf	EECON1, RD
	banksel EEDATA
	movf	EEDATA, W
	return
;-------------------------------------------------------------------
; Ana program: 0x0A dahili EEPROM adresine 0x97 bilgisi yükleniyor,
; Daha sonra ayný adresten veri okunarak PORTB'deki LED'lerde 
; görüntüleniyor.
;-------------------------------------------------------------------
ana_program
	BANKSEL PIE1		
	BSF PIE1,6 	     ;A/D dönuþtürücünün kesmelerine izin ver.	
	MOVLW 0x80	     ;10 bitin en anlamlý 2 bitini ADRESH a,
	MOVWF ADCON1	 ;Diðer 8 bitide ADRESL a atýlýyor.
	BANKSEL PIR1	 	
	BCF PIR1,6 		 ;ADIF Dönuþturme iþlemý gerceklesmedi.   
	MOVLW h'C0'	     ;Aktif yapýlmýþ tüm kesmelere izin ver.  	
	MOVWF INTCON	 ;Aktif yapýlmýþ tüm cevresel kesmelere izin ver.   
	MOVLW 0xD1		 	
    MOVWF ADCON0	 ;Kanal 2 yi seçtik.
	CALL GECÝK		    
	BSF ADCON0,2	 ;A/D dönüþtürücü iþlem yapsýn.	
	

	banksel TRISC			;BANK1 seçildi, TRISB bu bankta.
	clrf	TRISC			;PORTB pinleri çýkýþa ayarlandý.
	banksel PORTC			;BANK0 seçildi, PORTB bu bankta.
	clrf	PORTC			;Ýlk anda LED'ler sönük.
	movlw	0x00			;Yazýlacak Dahili EEPROM adresi
	movwf adres
	banksel PORTC
	bsf  	PORTC,0
	bcf		PORTC,1
bir
	
	movf adres,w
	banksel EEADR			;EEADR kaydedicisi için BANK seçildi.
	movwf 	EEADR			;Adres bilgisi yüklendi.
	movfw	DEGER		;Yazýlacak veri.
	movwf	EEDATA			;Veri yüklendi.
	call	dahili_EEPROM_yaz	;Yazma alt programýný çaðýr.
	banksel EEADR			;EEADR kaydedicisi için BANK seçildi.
	movlw	0x0A			;Okunacak Dahili EEPROM adresi.
	movwf	EEADR			;Adres bilgisi yüklendi.
	call	dahili_EEPROM_oku	;Okuma alt programýný çaðýr.
	;banksel PORTC		;BANK0'a geç.
	;movwf	PORTC		;Okunan deðeri LED'lerde görüntüle.
    incfsz  adres,f
goto bir
banksel PORTC
	bcf  	PORTC,0
	bsf		PORTC,1
	goto	ana_j1
;---------------------------------------

Gecik						;( 240 * 255 ) / 2 = W * 1020µsec ~= W ms @ 8Mmhz
Dongu0
	movlw d'240'
	movwf sayac1
Dongu1
	clrf sayac2
Dongu2
	incfsz sayac2,f
	goto Dongu2
	decfsz sayac1,f
	goto Dongu1
	return

;----------------------------------------
GECÝK	
	MOVLW d'8'		;(8*250)/2=1000 microsec
	MOVWF SAYA1
DÖNG
	MOVLW d'250'
	MOVWF SAYA0
DÖNG1
	DECFSZ SAYA0,1
	GOTO DÖNG1
	DECFSZ SAYA1,1
	GOTO DÖNG
	RETURN


ana_j1
	goto	ana_j1			;Sistem kapatýlana yada resetlenene 	


	
END	
