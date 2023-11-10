
_main:

;TemperatureSensor.c,18 :: 		void main() {
;TemperatureSensor.c,22 :: 		TRISB = 0;
	CLRF       TRISB+0
;TemperatureSensor.c,23 :: 		TRISC = 0; // output ports for devices
	CLRF       TRISC+0
;TemperatureSensor.c,25 :: 		TRISA = 1; // input port for a device
	MOVLW      1
	MOVWF      TRISA+0
;TemperatureSensor.c,27 :: 		adcon1.RA2 = 1; // connected port RA2, So 2 and that is an analog input port
	BSF        ADCON1+0, 2
;TemperatureSensor.c,29 :: 		ADC_Init(); //initialize analog inputs
	CALL       _ADC_Init+0
;TemperatureSensor.c,31 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;TemperatureSensor.c,33 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;TemperatureSensor.c,34 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;TemperatureSensor.c,36 :: 		while(1){ // while loop
L_main0:
;TemperatureSensor.c,38 :: 		result = ADC_read(2); // port which was connected to read the analog value and that value will be stored as result
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
;TemperatureSensor.c,39 :: 		volt = (result*5000.0)/1023.0; // equation to convert an analog value to a digital value
	CALL       _int2double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      64
	MOVWF      R4+1
	MOVLW      28
	MOVWF      R4+2
	MOVLW      139
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
;TemperatureSensor.c,40 :: 		temp = volt/10.0;
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      main_temp_L0+0
	MOVF       R0+1, 0
	MOVWF      main_temp_L0+1
	MOVF       R0+2, 0
	MOVWF      main_temp_L0+2
	MOVF       R0+3, 0
	MOVWF      main_temp_L0+3
;TemperatureSensor.c,42 :: 		FloatToStr(temp,display); //convert temp value to string and store it in the array display
	MOVF       R0+0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       R0+1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       R0+2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       R0+3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      _display+0
	MOVWF      FARG_FloatToStr_str+0
	CALL       _FloatToStr+0
;TemperatureSensor.c,44 :: 		Lcd_Out(1,2,"Value:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_TemperatureSensor+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;TemperatureSensor.c,46 :: 		Lcd_Out(1,10,display);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      10
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _display+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;TemperatureSensor.c,48 :: 		if(temp > 27.00){   //if temp value > 27
	MOVF       main_temp_L0+0, 0
	MOVWF      R4+0
	MOVF       main_temp_L0+1, 0
	MOVWF      R4+1
	MOVF       main_temp_L0+2, 0
	MOVWF      R4+2
	MOVF       main_temp_L0+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      88
	MOVWF      R0+2
	MOVLW      131
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main2
;TemperatureSensor.c,49 :: 		PORTC.RC0 = 0;
	BCF        PORTC+0, 0
;TemperatureSensor.c,50 :: 		PORTC.RC1 = 1; // motor will be rotated if at least one port is 0 or 1
	BSF        PORTC+0, 1
;TemperatureSensor.c,51 :: 		PORTC.RC2 =1;
	BSF        PORTC+0, 2
;TemperatureSensor.c,52 :: 		PORTC.RC3 = 0;
	BCF        PORTC+0, 3
;TemperatureSensor.c,53 :: 		PORTC.RC4 =1;
	BSF        PORTC+0, 4
;TemperatureSensor.c,54 :: 		Lcd_Out(2,2,"High Temperature:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_TemperatureSensor+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;TemperatureSensor.c,55 :: 		}
	GOTO       L_main3
L_main2:
;TemperatureSensor.c,57 :: 		PORTC.RC0 = 0;
	BCF        PORTC+0, 0
;TemperatureSensor.c,58 :: 		PORTC.RC1 = 0; //motor will be stopped as both the ports are off
	BCF        PORTC+0, 1
;TemperatureSensor.c,59 :: 		PORTC.RC2 = 0;
	BCF        PORTC+0, 2
;TemperatureSensor.c,60 :: 		PORTC.RC3 = 1;
	BSF        PORTC+0, 3
;TemperatureSensor.c,61 :: 		PORTC.RC4 =0;
	BCF        PORTC+0, 4
;TemperatureSensor.c,62 :: 		Lcd_Out(2,2,"Good Temperature");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      2
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_TemperatureSensor+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;TemperatureSensor.c,63 :: 		}
L_main3:
;TemperatureSensor.c,65 :: 		}
	GOTO       L_main0
;TemperatureSensor.c,67 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
