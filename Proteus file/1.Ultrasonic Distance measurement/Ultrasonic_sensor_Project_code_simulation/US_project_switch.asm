
_main:

;US_project_switch.c,17 :: 		void main()
;US_project_switch.c,21 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;US_project_switch.c,22 :: 		Lcd_Cmd(_LCD_CLEAR);          // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;US_project_switch.c,23 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);     // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;US_project_switch.c,25 :: 		TRISB = 0b00010000;           //RB4 as Input PIN (ECHO)
	MOVLW      16
	MOVWF      TRISB+0
;US_project_switch.c,26 :: 		TRISD.F0 = 1;                 //Configure 1st bit of PORTD as output
	BSF        TRISD+0, 0
;US_project_switch.c,28 :: 		T1CON = 0x10;                 //Initialize Timer Module
	MOVLW      16
	MOVWF      T1CON+0
;US_project_switch.c,29 :: 		do
L_main0:
;US_project_switch.c,31 :: 		if(PORTD.F0 == 0)
	BTFSC      PORTD+0, 0
	GOTO       L_main3
;US_project_switch.c,33 :: 		Delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_main4:
	DECFSZ     R13+0, 1
	GOTO       L_main4
	DECFSZ     R12+0, 1
	GOTO       L_main4
	DECFSZ     R11+0, 1
	GOTO       L_main4
;US_project_switch.c,34 :: 		if(PORTD.F0 ==0)
	BTFSC      PORTD+0, 0
	GOTO       L_main5
;US_project_switch.c,36 :: 		TMR1H = 0;                  //Sets the Initial Value of Timer
	CLRF       TMR1H+0
;US_project_switch.c,37 :: 		TMR1L = 0;                  //Sets the Initial Value of Timer
	CLRF       TMR1L+0
;US_project_switch.c,39 :: 		PORTB.F0 = 1;               //TRIGGER HIGH
	BSF        PORTB+0, 0
;US_project_switch.c,40 :: 		Delay_us(10);               //10uS Delay
	MOVLW      13
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
;US_project_switch.c,41 :: 		PORTB.F0 = 0;               //TRIGGER LOW
	BCF        PORTB+0, 0
;US_project_switch.c,43 :: 		while(!PORTB.F4);           //Waiting for Echo
L_main7:
	BTFSC      PORTB+0, 4
	GOTO       L_main8
	GOTO       L_main7
L_main8:
;US_project_switch.c,44 :: 		T1CON.F0 = 1;               //Timer Starts
	BSF        T1CON+0, 0
;US_project_switch.c,45 :: 		while(PORTB.F4);            //Waiting for Echo goes LOW
L_main9:
	BTFSS      PORTB+0, 4
	GOTO       L_main10
	GOTO       L_main9
L_main10:
;US_project_switch.c,46 :: 		T1CON.F0 = 0;               //Timer Stops
	BCF        T1CON+0, 0
;US_project_switch.c,48 :: 		a = (TMR1L | (TMR1H<<8));   //Reads Timer Value
	MOVF       TMR1H+0, 0
	MOVWF      R0+1
	CLRF       R0+0
	MOVF       TMR1L+0, 0
	IORWF      R0+0, 1
	MOVLW      0
	IORWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      main_a_L0+0
	MOVF       R0+1, 0
	MOVWF      main_a_L0+1
;US_project_switch.c,49 :: 		a = a/58.82;                //Converts Time to Distance
	CALL       _int2double+0
	MOVLW      174
	MOVWF      R4+0
	MOVLW      71
	MOVWF      R4+1
	MOVLW      107
	MOVWF      R4+2
	MOVLW      132
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	CALL       _double2int+0
	MOVF       R0+0, 0
	MOVWF      main_a_L0+0
	MOVF       R0+1, 0
	MOVWF      main_a_L0+1
;US_project_switch.c,50 :: 		a = a + 1;                  //Distance Calibration
	MOVF       R0+0, 0
	ADDLW      1
	MOVWF      R2+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 0
	MOVWF      R2+1
	MOVF       R2+0, 0
	MOVWF      main_a_L0+0
	MOVF       R2+1, 0
	MOVWF      main_a_L0+1
;US_project_switch.c,51 :: 		if(a>=2 && a<=400)          //Check whether the result is valid or not
	MOVLW      128
	XORWF      R2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main18
	MOVLW      2
	SUBWF      R2+0, 0
L__main18:
	BTFSS      STATUS+0, 0
	GOTO       L_main13
	MOVLW      128
	XORLW      1
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_a_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main19
	MOVF       main_a_L0+0, 0
	SUBLW      144
L__main19:
	BTFSS      STATUS+0, 0
	GOTO       L_main13
L__main16:
;US_project_switch.c,53 :: 		IntToStr(a,txt);
	MOVF       main_a_L0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       main_a_L0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      main_txt_L0+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;US_project_switch.c,54 :: 		Ltrim(txt);
	MOVLW      main_txt_L0+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;US_project_switch.c,55 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;US_project_switch.c,56 :: 		Lcd_Out(1,1,"Distance = ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_US_project_switch+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;US_project_switch.c,57 :: 		Lcd_Out(1,12,txt);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      main_txt_L0+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;US_project_switch.c,58 :: 		Lcd_Out(1,15,"cm");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_US_project_switch+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;US_project_switch.c,59 :: 		}
	GOTO       L_main14
L_main13:
;US_project_switch.c,62 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;US_project_switch.c,63 :: 		Lcd_Out(1,1,"Out of Range");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_US_project_switch+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;US_project_switch.c,64 :: 		}
L_main14:
;US_project_switch.c,65 :: 		Delay_ms(400);
	MOVLW      9
	MOVWF      R11+0
	MOVLW      30
	MOVWF      R12+0
	MOVLW      228
	MOVWF      R13+0
L_main15:
	DECFSZ     R13+0, 1
	GOTO       L_main15
	DECFSZ     R12+0, 1
	GOTO       L_main15
	DECFSZ     R11+0, 1
	GOTO       L_main15
	NOP
;US_project_switch.c,66 :: 		}
L_main5:
;US_project_switch.c,67 :: 		}
L_main3:
;US_project_switch.c,68 :: 		}while(1);
	GOTO       L_main0
;US_project_switch.c,69 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
