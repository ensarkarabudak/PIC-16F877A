		INCLUDE "P16F877A.inc"
        
        SAYAC EQU h'20' 

        ORG 0x00
        GOTO ana_program
        ORG 0x04
        GOTO kesme
 
ana_program
 
        BANKSEL TRISB

        CLRF TRISB   

        MOVLW h'07'
        MOVWF OPTION_REG 
       
     	BCF INTCON,2  

        BANKSEL PORTB
        CLRF PORTB        
        
	CLRF TMR0
       
        BSF INTCON,7
        BSF INTCON,5

        MOVLW 0X0E
        MOVWF SAYAC
    
       

 son               
        goto son  
                   
kesme
       

        BCF  INTCON,2
      
        CLRF TMR0

        INCF SAYAC
      
        MOVLW 0X0F
        SUBWF SAYAC,W
        BTFSS STATUS,Z
        retfie

        CLRF SAYAC
        INCF PORTB

        retfie

   END