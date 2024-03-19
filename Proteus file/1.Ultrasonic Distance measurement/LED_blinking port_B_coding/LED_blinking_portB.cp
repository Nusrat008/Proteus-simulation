#line 1 "G:/PIC 16F73/Mikro Coding/LED_blinking port_B_coding/LED_blinking_portB.c"
void main() {
 TRISB = 0x00;
 while(1){
 PORTB = 0xFF;
 delay_ms(1000);
 PORTB = 0x00;
 delay_ms(1000);
 }

}
