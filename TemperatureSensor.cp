#line 1 "C:/Users/Dhananjaya/OneDrive/Desktop/Temperature/TemperatureSensor.c"
sbit LCD_RS at RB2_bit;
sbit LCD_EN at RB3_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;

sbit LCD_RS_Direction at TRISB2_bit;
sbit LCD_EN_Direction at TRISB3_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;


 char display[16];

void main() {
int result;
float volt,temp;

TRISB = 0;
TRISC = 0;

TRISA = 1;

adcon1.RA2 = 1;

ADC_Init();

Lcd_Init();

Lcd_Cmd(_LCD_CLEAR);
Lcd_Cmd(_LCD_CURSOR_OFF);

while(1){

 result = ADC_read(2);
 volt = (result*5000.0)/1023.0;
 temp = volt/10.0;

 FloatToStr(temp,display);

 Lcd_Out(1,2,"Value:");

 Lcd_Out(1,10,display);

 if(temp > 27.00){
 PORTC.RC0 = 0;
 PORTC.RC1 = 1;
 PORTC.RC2 =1;
 PORTC.RC3 = 0;
 PORTC.RC4 =1;
 Lcd_Out(2,2,"High Temperature:");
 }
 else{
 PORTC.RC0 = 0;
 PORTC.RC1 = 0;
 PORTC.RC2 = 0;
 PORTC.RC3 = 1;
 PORTC.RC4 =0;
 Lcd_Out(2,2,"Good Temperature");
 }

}

}
