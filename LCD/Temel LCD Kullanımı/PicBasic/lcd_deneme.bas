Device = 16F877A
XTAL = 4
LCD_DTPIN = PORTB.4 'data nýn LSB biti
LCD_RSPIN = PORTB.0 'register select
LCD_ENPIN = PORTB.1
LCD_INTERFACE = 4
LCD_LINES = 2
LCD_TYPE = 0
ALL_DIGITAL = True
TRISA = 0 
DelayMS 150
Cls


DelayMS 100
 
Main:
 
 Print At 1,1, "Hello World"
 

PORTA.0 = 1
DelayMS 60
PORTA.0 = 0
DelayMS 60

GoTo Main

