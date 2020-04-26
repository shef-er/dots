SHELL = /bin/sh

# Compiler
CC = g++

# Compiler flags
CFLAGS1 = -Wall

# Build target
TARGET = 

all:
	$(CC) $(CFLAGS1) $(TARGET).cpp -o $(TARGET)
