;*******************************************************************
;	Dosya Adý		: EEPROM_ensar.asm
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
					;Osilatör XT ve 4Mhz
	ORG 	0			;Reset vektör adresi.
	clrf 	PCLATH			;0. Program sayfasý seçildi.
	goto 	ana_program		;ana_programa'a git.
	
	ORG	4			;Kesme vektör adresi.
Kesmeler				;Kesme kullanýmý gerekiyorsa 
					;buradan itibaren yazýlmalý. 
					;ya da goto komutu ile buradan yönlendirilmeli.
	retfie
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
	movlw d'100'
    call GecikWms		;1ms adc'yi bekle	
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
	banksel TRISB			;BANK1 seçildi, TRISB bu bankta.
	clrf	TRISB			;PORTB pinleri çýkýþa ayarlandý.
	banksel PORTB			;BANK0 seçildi, PORTB bu bankta.
	clrf	PORTB			;Ýlk anda LED'ler sönük.
	movlw	0x00			;Yazýlacak Dahili EEPROM adresi
	movwf adres
bir
	
	movf adres,w
	banksel EEADR			;EEADR kaydedicisi için BANK seçildi.
	movwf 	EEADR			;Adres bilgisi yüklendi.
	movlw	0x11			;Yazýlacak veri.
	movwf	EEDATA			;Veri yüklendi.
	call	dahili_EEPROM_yaz	;Yazma alt programýný çaðýr.
	banksel EEADR			;EEADR kaydedicisi için BANK seçildi.
	movlw	0x0A			;Okunacak Dahili EEPROM adresi.
	movwf	EEADR			;Adres bilgisi yüklendi.
	call	dahili_EEPROM_oku	;Okuma alt programýný çaðýr.
	banksel PORTB			;BANK0'a geç.
	movwf	PORTB			;Okunan deðeri LED'lerde görüntüle.
    incfsz  adres,1
goto bir
goto ana
GecikWms				;working register'a atýlan deger kadar ms gecik
	movwf sayac0		;( W * 8 * 255 ) / 2 = W * 1020µsec ~= W ms @ 8Mmhz
Dongu0
	movlw d'8'
	movwf sayac1
Dongu1
	clrf sayac2
Dongu2
	incfsz sayac2,f
	goto Dongu2
	decfsz sayac1,f
	goto Dongu1
	decfsz sayac0,f
	goto Dongu0
	return
ana_j1
	goto	ana_j1			;Sistem kapatýlana yada resetlenene 
ana					;kadar boþ döngü.
	END
;*******************************************************************
