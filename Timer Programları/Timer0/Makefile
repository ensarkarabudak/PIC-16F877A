# MPLAB IDE generated this makefile for use with GNU make.
# Project: denemeler.mcp
# Date: Sun Nov 08 23:04:56 2015

AS = MPASMWIN.exe
CC = 
LD = mplink.exe
AR = mplib.exe
RM = rm

deneme.cof : deneme.o
	$(CC) /p16F877 "deneme.o" /u_DEBUG /z__MPLAB_BUILD=1 /z__MPLAB_DEBUG=1 /o"deneme.cof" /M"deneme.map" /W /x

deneme.o : deneme.asm ../MPASM\ Suite/P16F877A.inc
	$(AS) /q /p16F877 "deneme.asm" /l"deneme.lst" /e"deneme.err" /d__DEBUG=1

clean : 
	$(CC) "deneme.o" "deneme.hex" "deneme.err" "deneme.lst" "deneme.cof"

