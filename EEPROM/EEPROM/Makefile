# MPLAB IDE generated this makefile for use with GNU make.
# Project: eeprom.mcp
# Date: Thu Dec 17 17:48:41 2015

AS = MPASMWIN.exe
CC = 
LD = mplink.exe
AR = mplib.exe
RM = rm

eeprom.cof : eeprom.o
	$(CC) /p16F877 "eeprom.o" /u_DEBUG /z__MPLAB_BUILD=1 /z__MPLAB_DEBUG=1 /o"eeprom.cof" /M"eeprom.map" /W /x

eeprom.o : eeprom.asm C:/Program\ Files\ (x86)/Microchip/MPASM\ Suite/P16F877.INC
	$(AS) /q /p16F877 "eeprom.asm" /l"eeprom.lst" /e"eeprom.err" /d__DEBUG=1

clean : 
	$(CC) "eeprom.o" "eeprom.hex" "eeprom.err" "eeprom.lst" "eeprom.cof"

