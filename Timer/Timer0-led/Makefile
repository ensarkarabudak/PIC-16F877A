# MPLAB IDE generated this makefile for use with GNU make.
# Project: timer0-led.mcp
# Date: Sun Dec 23 19:47:34 2018

AS = MPASMWIN.exe
CC = 
LD = mplink.exe
AR = mplib.exe
RM = rm

timer0-led.cof : timer0-led.o
	$(CC) /p16F877A "timer0-led.o" /u_DEBUG /z__MPLAB_BUILD=1 /z__MPLAB_DEBUG=1 /o"timer0-led.cof" /M"timer0-led.map" /W /x

timer0-led.o : timer0-led.asm ../../../../../Program\ Files\ (x86)/Microchip/MPASM\ Suite/P16F877A.INC
	$(AS) /q /p16F877A "timer0-led.asm" /l"timer0-led.lst" /e"timer0-led.err" /d__DEBUG=1

clean : 
	$(CC) "timer0-led.o" "timer0-led.hex" "timer0-led.err" "timer0-led.lst" "timer0-led.cof"

