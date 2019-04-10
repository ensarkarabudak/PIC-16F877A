list 			p=16F877
include 		"p16f877.inc"

cblock		0x20
sayac0
sayac1
sayac2
endc

ORG			0
anaprogram
			banksel			TRISC
			clrf   			TRISC
			banksel			PORTC
			clrf 				PORTC
			btfss				PORTC,0
			call				yak
			call				sondur
yak
			bsf				PORTC,0
			movlw			d'10'
			call    			gecikme
sondur
			bcf				PORTC,0
			movlw			d'10'
			call    			gecikme
			goto				yak

;GECÝKMENÝN HESAPLANMASI:
;decfsz ve goto toplam 3 komut çevriminde icra edilir.
;8 Mhz lik bir kristalin 1 komutuicra süresi 0.5 mikrosn olduðuna göre 3 komut 1,5 mikrosn de icra edilir.
;255 kez sayac2 azaltýlacaðýndan toplam 255x1.5=382mikrosn bekler.
;sayac1 de 255 kez azaltýlacak o halde 255x382.5=97,5milisn yani yaklaþýk 0.1sn eder.
;O halde verdiðimiz parametre neyse parametrex97.5milisn kadar program bekler.
;Bu örnekte parametre 10 olduðu için program 975 milisn lik bir bekleme ile çalýþýr.
gecikme
			movwf			sayac0
dongu0
			movlw			d'255'
			movwf			sayac1
dongu1
			movlw			d'255'
			movwf			sayac2
dongu2
			decfsz			sayac2,F
			goto				dongu2
			decfsz			sayac1
			goto				dongu1
			decfsz			sayac0
			goto				dongu0
			return
END 