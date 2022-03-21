#include <stdio.h>
#include <mega32.h>
#include <delay.h>
#include <alcd.h>

#define ADC_VREF_TYPE ((1<<REFS1) | (1<<REFS0) | (0<<ADLAR))

char buffer[8];
int state = 1;

unsigned int read_adc(unsigned char adc_input) {
    ADMUX=adc_input | ADC_VREF_TYPE;
    // Delay needed for the stabilization of the ADC input voltage
    delay_us(10);
    // Start the AD conversion
    ADCSRA|=(1<<ADSC);
    // Wait for the AD conversion to complete
    while ((ADCSRA & (1<<ADIF))==0);
    ADCSRA|=(1<<ADIF);
    return ADCW;
}

void cooler_on(int period) {
            PORTD = 0x09;
            delay_ms(period);
            PORTD = 0x08;
            delay_ms(period);
            PORTD = 0x0C;
            delay_ms(period);                    
            PORTD = 0x04;
            delay_ms(period);
            PORTD = 0x06;
            delay_ms(period);
            PORTD = 0x02;
            delay_ms(period);
            PORTD = 0x03;
            delay_ms(period);
            PORTD = 0x01;
            delay_ms(period);
}

void heater_on(int period) {
            PORTD = 0x90;
            delay_ms(period);
            PORTD = 0x80;
            delay_ms(period);
            PORTD = 0xC0;
            delay_ms(period);
            PORTD = 0x40;
            delay_ms(period);
            PORTD = 0x60;
            delay_ms(period);
            PORTD = 0x20;
            delay_ms(period);
            PORTD = 0x30;
            delay_ms(period);
            PORTD = 0x10;
            delay_ms(period);
}

void main(void) {
    unsigned int adc0;    

    DDRD = 0xFF;
    PORTD = 0;
    DDRB = 0xFF;
    
    ADMUX = ADC_VREF_TYPE;
    ADCSRA = (1<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (1<<ADPS1) | (1<<ADPS0);
    SFIOR = (0<<ADTS2) | (0<<ADTS1) | (0<<ADTS0); 
    
    delay_ms(100);
    lcd_init(16);

    while (1) {
       adc0 = read_adc(0) / 4;
       PORTB = adc0; 
        switch(state){ 
            case 1: 

                if(adc0 > 35)       
                    state = 2;
                if(adc0 < 15)
                    state = 3;
                break;    
            case 2:
                     
                if(adc0 < 25)
                    state = 1;
                if(adc0 > 40)       
                    state = 4;      
                break;
            case 3: 

                if(adc0 > 30)
                    state = 1;
                break;
            case 4:

              if(adc0 < 35)
                    state = 2;
              if(adc0 > 45)       
                    state = 5;
              break;     
            case 5:

              if(adc0 < 40)
                    state = 4;    
              break;
        }
             
        if(state == 2)
            cooler_on(300); 
        if(state == 4) 
            cooler_on(200);
        if(state == 5)
            cooler_on(100);
        if(state == 3)
            heater_on(100);
            
        lcd_gotoxy(0, 0);
        sprintf(buffer, "%d", adc0);
        lcd_puts(buffer);
        lcd_putchar(0xDF);
        lcd_putchar('C');
    }
}