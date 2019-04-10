lIST P=P16F877
#INCLUDE <P16F877.INC>

templcd EQU H'33'
count1	EQU H'34'
counta	EQU H'35'
countb 	EQU H'36'
count 	EQU H'37'
kay     EQU H'38'
grkay   EQU H'40'
kont    equ H'39'

LCD_PORT EQU PORTB
LCD_TRIS EQU TRISB

LCD_RS   EQU 4
LCD_E    EQU 5
		
		ORG 0X00
			movlw 0x00
			movwf kay
			movlw 0x10
			movwf kont
 		    
			BCF STATUS,6
			BSF STATUS,5
			CLRF LCD_TRIS
			
			BCF STATUS,5
			CALL Delay100
			
			call LCD_Init

			MOVLW 0X01
			CALL LCD_Cmd
			
	
kaydir    
            movf kay,0
 		   ; call LCD_Line1W
			addlw 0x80
			call LCD_Cmd	   
		    clrf count
            incf kay
Message 
		movf count,w
		call Satir1
		xorlw 0x00
		btfsc STATUS,Z
		goto NextMessage
		call LCD_Char
		incf count,f
		goto Message
NextMessage
		call LCD_Line2
		movf kont,w
		call LCD_Line2W
	
		clrf count
Message2
		movf count,w
		call Satir2
		xorlw 0x00
		btfsc STATUS,Z
		goto EndMessage
		call LCD_Char
		incf count,f
		goto Message2
EndMessage

Stop
	call Delay255
	call Delay255
	decfsz kont,F
	goto kaydir	
	CALL BASAL
	GOTO kaydir
BASAL
     MOVLW 0X00
	 MOVWF kay
	 movlw 0x10
	 movwf kont
   
	 call LCD_Clr
	
 	 RETURN
		 
LCD_Init
		 
		CALL Delay100
		call Delay100

		movlw  0x03
		movwf  LCD_PORT
		bsf    LCD_PORT,LCD_E
		bcf    LCD_PORT,LCD_E
		call   Delay50
	
	        bsf    LCD_PORT,LCD_E
		bcf	   LCD_PORT,LCD_E
	 	call   d1
		call   d1
        
       	        bsf    LCD_PORT,LCD_E
		bcf	   LCD_PORT,LCD_E
	 	call   d1
		call   d1
        
		
		movlw  0x02
		movwf  LCD_PORT
		bsf    LCD_PORT,LCD_E
		bcf	   LCD_PORT,LCD_E
		call   d1
		call   d1
		
		movlw 0x28
		call LCD_Cmd
		movlw 0x08
		call LCD_Cmd
                movlw 0x01
		call LCD_Cmd

		movlw 0x06
		call LCD_Cmd
 
		movlw 0x0C
		call LCD_Cmd

		return

LCD_Cmd
      	        movwf templcd
		swapf templcd,W
		andlw 0x0f
		
		movwf LCD_PORT
	 	bcf   LCD_PORT,LCD_RS
    
		call   Pulse_e

		movf  templcd,W
	        andlw  0x0f
		movwf LCD_PORT
		bcf   LCD_PORT,LCD_RS
	
		call Pulse_e
		call Delay5

  	    return
LCD_CharD addlw 0x30
LCD_Char
		movwf templcd
		swapf templcd,w
		andlw 0x0f
		movwf LCD_PORT
	 	bSf   LCD_PORT,LCD_RS
		call   Pulse_e

		MOVF templcd,W
		andlw 0x0f
		movwf LCD_PORT
		bsf   LCD_PORT,LCD_RS

		call   Pulse_e
		call   Delay5
      		return
LCD_Line1
	movlw 0x80
	call  LCD_Cmd
	return
LCD_Line2
 	movlw 0xC0
	call  LCD_Cmd
	return
LCD_Line1W 
	addlw 0x80
	call  LCD_Cmd
	return
LCD_Line2W addlw 0xC0
	call  LCD_Cmd
	return
LCD_CurOn 
   	movlw 0x0d
	call  LCD_Cmd
	return
LCD_CurOff 
	movlw 0x0c
	call  LCD_Cmd
	return
LCD_Clr 
 	movlw 0x01
	call  LCD_Cmd
	return

		


Delay255 movlw d'255'
		goto d0
Delay100 movlw d'100'
		goto d0
    		
Delay50 movlw d'50'
		goto d0
	
Delay25 movlw d'25'
		goto d0
	
Delay5 movlw d'5'
		goto d0
   
d0 movwf count1
d1
   movlw 0xC7
   movwf counta
   movlw 0x01
   movwf countb
Delay_0
		decfsz counta,f
		goto $+2
		decfsz countb,f
		goto Delay_0
		
		decfsz count1,f
		goto d1
		return

Pulse_e
		bsf  LCD_PORT,LCD_E
		bcf  LCD_PORT,LCD_E 
		return


Satir1 
	addwf PCL,f
	retlw  'E'
	retlw  'N'
	retlw  'S'
	retlw  'A'
	retlw  'R'
	retlw  0x00
Satir2
	addwf PCL,f
	retlw  '.'
	retlw  '.'
   	retlw  '.'
	retlw  '.'
   	retlw  '.'
	retlw  ' '
	retlw  0x00
END



