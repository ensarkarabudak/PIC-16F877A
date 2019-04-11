# MPLAB IDE generated this makefile for use with GNU make.
# Project: Timer1-Led.mcp
# Date: Sun Dec 23 20:58:55 2018

AS = MPASMWIN.exe
CC = 
LD = mplink.exe
AR = mplib.exe
RM = rm

timer1-led.cof : timer1-led.o
	$(CC) /p16F877A "timer1-led.o" /u_DEBUG /z__MPLAB_BUILD=1 /z__MPLAB_DEBUG=1 /o"timer1-led.cof" /M"timer1-led.map" /W /x

timer1-led.o : timer1-led.asm ../../../../../Program\ Files\ (x86)/Microchip/MPASM\ Suite/P16F877A.INC
	$(AS) /q /p16F877A "timer1-led.asm" /l"timer1-led.lst" /e"timer1-led.err" /d__DEBUG=1

clean : 
	$(CC) "timer1-led.o" "timer1-led.hex" "timer1-led.err" "timer1-led.lst" "timer1-led.cof"

