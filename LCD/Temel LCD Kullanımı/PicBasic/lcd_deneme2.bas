Device = 16F877A
XTAL = 4
LCD_DTPIN = PORTB.4 'data nýn LSB biti
LCD_RSPIN = PORTB.0 'register select
LCD_ENPIN = PORTB.1
LCD_INTERFACE = 4
LCD_LINES = 2
LCD_TYPE = 0
ALL_DIGITAL = True

TRISA.0 = 0 
TRISA.1 = 1 

DelayMS 150
Cls
DelayMS 100
 
Main:
    
    If PORTA.1 = 1 Then
        Print At 1,1, "23 Nisan 1920   "
        Print At 2,1, "TBMM nin acilisi"
        PORTA.0 = 1
    Else
        Print At 1,1, "29 Ekim 1923    "
        Print At 2,1, "CUMHURIYET ILANI"
        PORTA.0 = 0
    EndIf
 
GoTo Main

