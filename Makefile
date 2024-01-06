# Source and object files
SRC = blink.c
OBJ = blink.o
LST = blink.lst

# Output files
OUT = blink.out
MAP = blink.out.map
HEX = blink.hex
EE_HEX = blink.ee.hex

# Compiler and flags
CC = avr-gcc
CFLAGS = -I. -I. -g -mmcu=attiny85 -DF_CPU=8000000UL -Os -fpack-struct -fshort-enums -funsigned-bitfields -funsigned-char -Wall -Wstrict-prototypes
LDFLAGS = -Wl,-Map,$(MAP) -mmcu=attiny85 -lm

all: $(HEX) $(EE_HEX)

$(OBJ): $(SRC)
	$(CC) $(CFLAGS) -Wa,-ahlms=$(LST) -c $< -o $@

$(OUT): $(OBJ)
	$(CC) $(LDFLAGS) -o $@ $^

$(HEX): $(OUT)
	avr-objcopy -j .text -j .data -O ihex $< $@

$(EE_HEX): $(OUT)
	avr-objcopy -j .eeprom --change-section-lma .eeprom=0 -O ihex $< $@

erase_and_program:
	avrdude -c usbtiny -p attiny85 -U flash:w:$(HEX)

program:
	avrdude -c usbtiny -p attiny85 -D -U flash:w:$(HEX)

erase:
	avrdude -c usbtiny -p attiny85 -e

clean:
	rm -f $(OBJ) $(OUT) $(HEX) $(EE_HEX) $(LST) $(MAP)

