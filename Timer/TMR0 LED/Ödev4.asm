		Listp=16F877A
		#include <P16F877A.inc>
        
        SAYAC EQU h'20' 

        ORG 0x00
        GOTO ana_program
        ORG 0x04
        GOTO kesme
 
ana_program
 
        BANKSEL TRISB
        CLRF TRISB        
        BANKSEL PORTB
        CLRF PORTB        
        
		BANKSEL OPTION_REG 
        MOVLW h'07'        
        MOVWF OPTION_REG 
        BANKSEL INTCON 	 
        BCF INTCON,2      
             
        BANKSEL TMR0
        MOVLW h'00'
        MOVWF TMR0
        CLRF SAYAC
        BANKSEL INTCON
        BSF INTCON,7
        BSF INTCON,5

 son              
        goto son   
                   
kesme
        BTFSS INTCON,2
        retfie
        BCF  INTCON,2
        BANKSEL TMR0
        MOVLW d'00'
        MOVWF TMR0
        INCF SAYAC
        MOVLW d'15'
        SUBWF SAYAC,W
        BTFSS STATUS,2
        retfie
        CLRF SAYAC
        INCF PORTB,1
        retfie

               END
             
                