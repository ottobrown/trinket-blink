#include <avr/io.h>
#include <util/delay.h>

int main(void) {
    // pin 1
    DDRB |= 0x02;
    while(1) {
        PORTB |= 0x02; // LED ON
        _delay_ms(1000);
        PORTB &= 0x00; // LED OFF
        _delay_ms(1000);
    }
    return 0;
}
