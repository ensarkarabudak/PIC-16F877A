    list p=16F877
	include "p16F877.inc"

    SAYAC0 equ 0x25       
    SAYAC1 equ 0x26
	#define LED0 PORTC,0 ;  
	#define LED1 PORTC,1     
	ORG 0
	GOTO ANA_PROGRAM        
	ORG 4
    GOTO KESME

ANA_PROGRAM
	MOVLW 15                 
	MOVWF SAYAC0          
	MOVLW 4               
	MOVWF SAYAC1           
    MOVLW h'D7'               
	BANKSEL OPTION_REG   	
	MOVWF OPTION_REG     	
    CLRF TRISC          	 
	BANKSEL PORTC       	
    CLRF PORTC           	
	CLRF TMR0            	

	
                              
	MOVLW h'31'		           
	MOVWF T1CON			      
                              
	BCF PIR1,TMR1IF	           
	BANKSEL PIE1	           
	BSF PIE1,TMR1IE	          
	MOVLW 0xE0	                
	MOVWF INTCON	            
	BCF STATUS,RP0             

SONSUZ
	GOTO SONSUZ              

KESME
	BTFSS INTCON,2             
	GOTO  TIMER1_ÝÞLEM
   
    BCF INTCON,2              
	DECFSZ SAYAC0,1        
	RETFIE                     
    BTFSS LED0               
	GOTO Led0_Sonukken        
    BCF LED0               
	MOVLW 15                
	MOVWF SAYAC0          
	RETFIE                     
 
Led0_Sonukken
	BSF LED0  		       
    MOVLW 15               
	MOVWF SAYAC0           
	RETFIE                     


TIMER1_ÝÞLEM
	BCF PIR1,TMR1IF	           
	DECFSZ SAYAC1,1         
	RETFIE                      
    BTFSS LED1            
	GOTO Led1_Sonukken         
    BCF LED1               
    MOVLW 4                  
	MOVWF SAYAC1          
	RETFIE                     

Led1_Sonukken
    BSF LED1  	           
    MOVLW 4                
	MOVWF SAYAC1           
	RETFIE 
                     
	END















