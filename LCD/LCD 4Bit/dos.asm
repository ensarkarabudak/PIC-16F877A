list 				p=16F877
include 		"p16F877.inc" 

	CBLOCK	0x20			;16F877'nýn RAM baþlangýç adresi, 
	sayac0
	sayac1
	sayac2
	LCD_data						;LCD için geçici veri deðiþkeni.
	LCD_tmp0					;LCD için geçici veri deðiþkeni.
	LCD_tmp1					;LCD için geçici veri deðiþkeni.
	LCD_line						;LCD için satýr bilgisini tutan deðiþken.
	LCD_pos						;LCD için sütun bilgisi tutan deðiþken.
	ENDC

	ORG 		0 
	goto 		anaprogram
	ORG 		4
	goto		kesme

; LCD'nin baðlý olduðu port tanýmlarý yapýlýyor.
#define 		LCD_DataPort 		PORTB				;Data pinlerinin baðlý olduðu port (D7-D4  -> RB3-RB0 ).
#define 		LCD_CtrlPort 			PORTB			;Kontrol pinlerinin baðlandýðý port
; LCD'nin kontrol pinlerinin baðlý olduðu mikrodenetleyici pinleri tanýmlanýyor.
#define 		LCD_RS			4							;LCD RS pini RB4'e baðlý.
#define 		LCD_EN			5							;LCD E pini RB5'e baðlý.
#define 		LCD_RW			6							;LCD RW pini RB6'ya baðlý.

mesajlar															;LCD'ye gönderilecek mesajlar buraya yazýlýyor.
			addwf				PCL, F							;mesaj adresini yükle.
			msg0	dt			"Huzeyfe", 0					;0 sonlandýrma karakteri.
			msg1	dt			"Kocabas", 0
			msg2	dt			"Mikroislemciler", 0

; LCD ile ilgili macro tanýmlarý:
LCD_RS_HIGH				macro							;LCD'nin RS giriþini HIGH yaparak 
			banksel 			LCD_CtrlPort					;veri alma modu seçilir.
			bsf					LCD_CtrlPort, LCD_RS
			endm

LCD_RS_LOW				macro							;LCD'nin RS giriþini LOW yaparak 
			banksel 			LCD_CtrlPort					;komut alma modu seçilir.
			bcf					LCD_CtrlPort, LCD_RS	
			endm

LCD_EStrobe 				macro								;LCD'ye veri ya da komut 
			banksel 			LCD_CtrlPort						;gönderildiðinde LCD'nin 
			bsf					LCD_CtrlPort, LCD_EN		;bunu iþlemesini saðlar.
			movlw				d'1'
			call					gecikme_mikrosn
			bcf					LCD_CtrlPort, LCD_EN
			endm

LCD_Locate					macro	line, pos
			movlw 				line									;Satýr bilgisini yükle.
			movwf				LCD_line	
			movlw 				pos									;Sütun bilgisini yükle.
			movwf				LCD_pos				
			call					LCD_SetPos						;Kursörü konumlandýr.
			endm

; 4 bit iletiþim modunda LCD'ye veri transferi yapar.
LCD_NybbleOut
			andlw				0x0F									;En deðersiz 4 bit W'de,
			movwf				LCD_tmp0							;geçici deðiþkene alýnýyor.
			movf					LCD_DataPort,W				;LCD'nin data pinlerinin baðlý olduðu port bilgisi W'de.
			andlw				0xF0									;Port bilgisinin en deðerli 4 bit’i korunuyor.
			iorwf					LCD_tmp0, W					;Korunan bilgi ile veri birleþtiriliyor.
			movwf				LCD_DataPort					;PortA transfer ediliyor.
			LCD_EStrobe											;LCD'nin veriyi almasý saðlanýyor.
			movlw				d'1'
			call					gecikme_mikrosn
			return

; LCD'ye 1 byte komut transfer eder.
LCD_SendCmd         	         	
			movwf				LCD_data	 						;Komutu geçici deðiþkene al.
			swapf				LCD_data, W   					;En deðerli 4 bit’i gönder.
			LCD_RS_LOW											;RS = 0 (komut modu)
			call					LCD_NybbleOut
			movf					LCD_data, W					;En deðersiz 4 bit’i gönder.
			LCD_RS_LOW											;RS = 0 (komut modu)
			call					LCD_NybbleOut			
			return

; LCD'ye bir rakam ya da bir karakter göndermek için kullanýlýr.
LCD_SendCHAR													;LCD'ye karakter göndermek için çaðrýlacak.
			movwf				LCD_data							;Komutu geçici deðiþkene al.
			swapf				LCD_data, W					;En deðerli 4 bit’i gönder.
			LCD_RS_HIGH											;RS = 1 ( veri gönderme modu )
			call					LCD_NybbleOut
			movf					LCD_data, W					;En deðersiz 4 bit’i gönder.
			LCD_RS_HIGH											;RS = 1 ( veri gönderme modu )
			call					LCD_NybbleOut
			return

; LCD ekran belleðini siler.
LCD_Clear
			movlw				0x01									;LCD görüntü belleðini sil, dolayýsý ile 
			call					LCD_SendCmd					;LCD'de görünen bilgileri de sil.
			movlw				d'1'
			call					gecikme_mikrosn
			return

; Kursörü göster
LCD_CursorOn
			movlw				0x0F									;Display'i aç, kursörü göster. 
			call					LCD_SendCmd					;Blink ON.
			return

; Kursörü gizle
LCD_CursorOff
			movlw				0x0C								;Display'i aç, kursörü gizle,
			call					LCD_SendCmd					;Blink OFF.
			return

; LCD ekraný kullanýma hazýrlar.
LCD_init
			bsf					STATUS, RP0					;BANK1 seçildi. Yönlendirme kaydedicileri bu bankta.
			movf					LCD_DataPort, W
			andlw				0xF0									;Portun en deðersiz dörtlüsü çýkýþ yapýldý.
			movwf				LCD_DataPort					;Port yönlendirildi.
			bcf					LCD_CtrlPort, LCD_EN		;LCD_CtrlPort'un LCD_EN pini çýkýþa yönlendirildi.
			bcf					LCD_CtrlPort, LCD_RS		;LCD_RS pini çýkýþ yapýldý. 
			bcf					LCD_CtrlPort, LCD_RW		;LCD_RW pini çýkýþ yapýldý.
			bcf					STATUS, RP0					;BANK0 seçildi.
			clrf					LCD_DataPort
			movlw				d'1'
			call					gecikme_mikrosn
			LCD_RS_LOW
			movlw				0x03									;8 bit iletiþim komutu verildi.
			call					LCD_NybbleOut	
			movlw				d'20'
			call					gecikme_mikrosn
			LCD_EStrobe											;8 bit iletiþim için komut yinelendi.
			movlw				d'10'
			call					gecikme_mikrosn
			LCD_EStrobe											;8 bit iletiþim için komut yinelendi.
			movlw				d'10'
			call					gecikme_mikrosn
			LCD_RS_LOW
			movlw				0x02									;LCD, 4 Bit iletiþim moduna alýndý.
			call					LCD_NybbleOut	
			movlw				d'10'
			call					gecikme_mikrosn
			movlw				0x28									;4 bit iletiþim, 2 satýr LCD, 5x7 
			call					LCD_SendCmd					;font seçildi.
			movlw				0x10									;LCD'de yazýnýn kaymasý engellendi.
			call					LCD_SendCmd
			movlw				0x01									;LCD görüntü belleðini sil.
			call					LCD_SendCmd
			movlw				d'1'
			call					gecikme_milisn
			movlw				0x06									;Kursör her karakter yazýmýnda bir 
			call					LCD_SendCmd					;ilerlesin.
			movlw				0x0C								;Display'i aç, kursörü gizle.
			call					LCD_SendCmd
			return

; Mesaj etiketi (adresi) W’ye yüklenen mesajý LCD ekranda görüntüler                       
LCD_SendMessage
			Movwf				FSR									;Ýlk karaktere iþaret et (onun adresini  tut).
LCD_SMsg			
			Movf					FSR, W							;Ýþaret edilen karakter sýrasýný W'ye al.
			incf					FSR, F								;Bir sonraki karaktere konumlan.
			Call					mesajlar							;Mesajlardan ilgili karakteri al.
			iorlw  				0										;Mesaj sonu mu? 0 bilgisi alýndý ise mesaj sonu demektir.
			btfsc 				STATUS, Z						;Mesaj sonu deðil ise bir komut atla.
			return														;Mesaj sonu ise alt programdan çýk.
			call   				LCD_SendCHAR				;Karakteri LCD'ye yazdýr.
			goto   				LCD_SMsg						;Bir sonraki karakter için iþlemleri tekrarla.
;-------------------------------------------------------------------
; Kursörü LCD'de istenilen satýr ve sütuna konumlandýrýr. Text'in 
; nereye yazýlacaðýný belirler. 1 - 2 satýr olan LCD'ler için 
; yazýldýðýna dikkat ediniz. 4 satýr LCD'ler için LCD_line deðerinin
; 0, 1, 2 veya 3 olmasý durumuna göre DDRAM baþlangýç adresleri 
; tespit edilmelidir.
;-------------------------------------------------------------------
LCD_SetPos
			movlw				0x80									;0. satýr için DDRAM adres baþlangýç deðeri.
			movf					LCD_line, F	
			btfss					STATUS, Z						;0. satýr ise bir komut atla.
			movlw				0xC0								;1. satýr için 0x80 adresine ilave edilecek deðer.
			addwf				LCD_pos, W						;Kursör pozisyonu da ilave edilerek DDRAM'deki adres bulunuyor.
			call					LCD_SendCmd
			return

;Gelen parametre x 0.1 sn kadar bekleme yapar.
gecikme_sn
			movwf				sayac0
dongu0
			movlw				d'255'
			movwf				sayac1
dongu1
			movlw				d'255'
			movwf				sayac2
dongu2
			decfsz				sayac2,F
			goto					dongu2
			decfsz				sayac1
			goto					dongu1
			decfsz				sayac0
			goto					dongu0
			return
;Gelen parametre x 1.5 mikrosn kadar bekleme yapar.
gecikme_mikrosn
			movwf				sayac0
dongu
			decfsz				sayac0,F
			goto					dongu
			return
;Gelen parametre x 382 mikrosn kadar bekleme yapar.
gecikme_milisn
			movwf				sayac0
dongu3
			movlw				d'255'
			movwf				sayac1
dongu4
			decfsz				sayac1,F
			goto					dongu1
			decfsz				sayac0
			goto					dongu0
			return

kesme
			retfie
anaprogram
			call					LCD_init							;LCD’yi kullanýma hazýrlar.
Ana_j0
			call					LCD_CursorOff					;Kursörü gizle.
			LCD_Locate		0, 0									;0. satýr, 0. sütuna konumlan.
			movlw				msg0-6								;mesaj0 yaz (adresi 6 eksiði).
			call					LCD_SendMessage
			LCD_Locate		0, 9									;1. satýr, 0. sütuna konumlan
			movlw				msg1-6								;mesaj1 yaz.
			call					LCD_SendMessage
			LCD_Locate		1, 1									;1. satýr, 0. sütuna konumlan
			movlw				msg2-6								;mesaj1 yaz.
			call					LCD_SendMessage
			movlw				d'255'
			call					gecikme_sn
END 