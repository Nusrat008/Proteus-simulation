#line 1 "G:/PIC 16F73/Mikro Coding/Exp_04_luxmeter/luxmeter_demo.c"

sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;


float v,va,vd;
char txt[15];

void Display()
{
 Lcd_init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_cmd(_LCD_CURSOR_OFF);
 if(vd!=0)
 {
 Lcd_out(1,1,"Intesity in lux");
 Lcd_out(2,12,"Lux");
 floattostr(vd,txt);
 Lcd_out(2,1,txt);
 }
}
void main()
{
 T1CON =0x10;
 TRISA = 0b00010000;
 Lcd_init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_cmd(_LCD_CURSOR_OFF);
 Lcd_out(1,1,"lux meter");
 while(1)
 {
 v = ADC_Read(0);
 va=(v*4.9)/255;
 if(va>0.01)
 {
 vd=-(174.4*va*va*va)+(1403*va*va)-(3862*va)+3500;

 }
 else
 vd=0;

 Display();
 Delay_ms(300);


 }
}
