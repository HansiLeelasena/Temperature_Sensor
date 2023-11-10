sbit LCD_RS at RB2_bit;    // lcd module connection
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
float volt,temp; //variable to use in order to convert an analog value

TRISB = 0;
TRISC = 0; // output ports for devices

TRISA = 1; // input port for a device

adcon1.RA2 = 1; // connected port RA2, So 2 and that is an analog input port

ADC_Init(); //initialize analog inputs

Lcd_Init();   
                     // Initialize LCD
Lcd_Cmd(_LCD_CLEAR);               // Clear display
Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off

while(1){ // while loop

    result = ADC_read(2); // port which was connected to read the analog value and that value will be stored as result
    volt = (result*5000.0)/1023.0; // equation to convert an analog value to a digital value
    temp = volt/10.0;

    FloatToStr(temp,display); //convert temp value to string and store it in the array display

   Lcd_Out(1,2,"Value:");
   
    Lcd_Out(1,10,display);

    if(temp > 27.00){   //if temp value > 27
      PORTC.RC0 = 0;
      PORTC.RC1 = 1; // motor will be rotated if at least one port is 0 or 1
      PORTC.RC2 =1;
      PORTC.RC3 = 0;
      PORTC.RC4 =1;
      Lcd_Out(2,2,"High Temperature:");
    }
    else{
      PORTC.RC0 = 0;
      PORTC.RC1 = 0; //motor will be stopped as both the ports are off
      PORTC.RC2 = 0;
      PORTC.RC3 = 1;
      PORTC.RC4 =0;
      Lcd_Out(2,2,"Good Temperature");
    }

}

}