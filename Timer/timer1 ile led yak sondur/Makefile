# MPLAB IDE generated this makefile for use with GNU make.
# Project: timer1 ile led yak sondur.mcp
# Date: Mon Oct 24 15:39:12 2011

AS = MPASMWIN.exe
CC = 
LD = mplink.exe
AR = mplib.exe
RM = rm

timer1\ ile\ led\ yak\ sondur.cof : timer1\ led.o
	$(CC) /p16F877A "timer1 led.o" /u_DEBUG /z__MPLAB_BUILD=1 /z__MPLAB_DEBUG=1 /o"timer1 ile led yak sondur.cof" /M"timer1 ile led yak sondur.map" /W

timer1\ led.o : timer1\ led.asm ../../../../Program\ Files/Microchip/MPASM\ Suite/p16F877A.inc
	$(AS) /q /p16F877A "timer1 led.asm" /l"timer1 led.lst" /e"timer1 led.err" /o"timer1 led.o" /d__DEBUG=1

clean : 
	$(CC) "timer1 led.o" "timer1 led.err" "timer1 led.lst" "timer1 ile led yak sondur.cof" "timer1 ile led yak sondur.hex"

