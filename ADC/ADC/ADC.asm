	LIST p=16F877
	INCLUDE "p16F877.inc"
	
	SAYAC0 EQU 0x21
	SAYAC1 EQU 0x22
	SAYAC2 EQU 0x23
;-----------------------------------------					
	ORG 	0		
	CLRF 	PCLATH			
	GOTO 	ANA_PRO	
	ORG	4		
	GOTO 	KESME
;-----------------------------------------
ANA_PRO	
	BANKSEL TRISD		
	CLRF TRISD
	BSF PIE1,6 	   ;A/D dönüþtürme kesmelerine izin ver  
	MOVLW 0x00	   
	MOVWF ADCON1   ;en anlamsýz 2 bit ADRESL da diðer 8 bit ADRESH da
	BANKSEL PIR1	 	
	BCF PIR1,6 	   ;A/D dönüþtürme bayraðýný indir
	MOVLW h'C0'	  	
	MOVWF INTCON   ;Aktif yapýlmýþ tüm çevresel ve tüm kesmelere izin ver
	MOVLW 0xD1		 	
    MOVWF ADCON0   ;Kanal 2 yi seç
	MOVLW d'1'
	CALL GECÝK_PRO 		    
	BSF ADCON0,2   ;A/D dönüþtüme iþlemine baþla	

SONSUZ
	GOTO SONSUZ

KESME	
	BCF PIR1,6	
	BANKSEL ADRESH   	
	MOVF ADRESH,w  
	BANKSEL PORTD		
	MOVWF PORTD   
	MOVLW 0xD1			
   	MOVWF ADCON0  
	BSF ADCON0,2			
	RETFIE


GECÝK_PRO	
	MOVWF SAYAC0	
DONGU0
	MOVLW d'1'
	MOVWF SAYAC1
DONGU1
	MOVLW d'80'
	MOVWF SAYAC2
DONGU2
	DECFSZ SAYAC2,f
	GOTO DONGU2
	DECFSZ SAYAC1,f
	GOTO DONGU1
	DECFSZ SAYAC0,f
	GOTO DONGU0
	RETURN

	END            
 