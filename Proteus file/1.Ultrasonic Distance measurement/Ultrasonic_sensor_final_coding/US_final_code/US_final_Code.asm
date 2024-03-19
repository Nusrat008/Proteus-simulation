
_main:

;US_final_Code.c,17 :: 		void main()
;US_final_Code.c,21 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;US_final_Code.c,22 :: 		Lcd_Cmd(_LCD_CLEAR);          // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;US_final_Code.c,23 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);     // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;US_final_Code.c,25 :: 		TRISB = 0b00010000;           //RB4 as Input PIN (ECHO)
	MOVLW      16
	MOVWF      TRISB+0
;US_final_Code.c,27 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;US_final_Code.c,29 :: 		T1CON = 0x10;                 //Initialize Timer Module
	MOVLW      16
	MOVWF      T1CON+0
;US_final_Code.c,31 :: 		while(1)
L_main0:
;US_final_Code.c,33 :: 		TMR1H = 0;                  //Sets the Initial Value of Timer
	CLRF       TMR1H+0
;US_final_Code.c,34 :: 		TMR1L = 0;                  //Sets the Initial Value of Timer
	CLRF       TMR1L+0
;US_final_Code.c,36 :: 		PORTB.F0 = 1;               //TRIGGER HIGH
	BSF        PORTB+0, 0
;US_final_Code.c,37 :: 		Delay_us(10);               //10uS Delay
	MOVLW      6
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	NOP
;US_final_Code.c,38 :: 		PORTB.F0 = 0;               //TRIGGER LOW
	BCF        PORTB+0, 0
;US_final_Code.c,40 :: 		while(!PORTB.F4);           //Waiting for Echo
L_main3:
	BTFSC      PORTB+0, 4
	GOTO       L_main4
	GOTO       L_main3
L_main4:
;US_final_Code.c,41 :: 		T1CON.F0 = 1;               //Timer Starts
	BSF        T1CON+0, 0
;US_final_Code.c,42 :: 		while(PORTB.F4);            //Waiting for Echo goes LOW
L_main5:
	BTFSS      PORTB+0, 4
	GOTO       L_main6
	GOTO       L_main5
L_main6:
;US_final_Code.c,43 :: 		T1CON.F0 = 0;               //Timer Stops
	BCF        T1CON+0, 0
;US_final_Code.c,45 :: 		a = (TMR1L | (TMR1H<<8));   //Reads Timer Value
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
;US_final_Code.c,46 :: 		a = a/58.82;                //Converts Time to Distance
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
;US_final_Code.c,47 :: 		a = a + 1;                  //Distance Calibration
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
;US_final_Code.c,48 :: 		if(a>=2 && a<=400)          //Check whether the result is valid or not
	MOVLW      128
	XORWF      R2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main14
	MOVLW      2
	SUBWF      R2+0, 0
L__main14:
	BTFSS      STATUS+0, 0
	GOTO       L_main9
	MOVLW      128
	XORLW      1
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_a_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main15
	MOVF       main_a_L0+0, 0
	SUBLW      144
L__main15:
	BTFSS      STATUS+0, 0
	GOTO       L_main9
L__main12:
;US_final_Code.c,50 :: 		IntToStr(a,txt);
	MOVF       main_a_L0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       main_a_L0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      main_txt_L0+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;US_final_Code.c,51 :: 		Ltrim(txt);
	MOVLW      main_txt_L0+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;US_final_Code.c,52 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;US_final_Code.c,53 :: 		Lcd_Out(1,1,"Distance = ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_US_final_Code+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;US_final_Code.c,54 :: 		Lcd_Out(1,12,txt);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      main_txt_L0+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;US_final_Code.c,55 :: 		Lcd_Out(1,15,"cm");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      15
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_US_final_Code+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;US_final_Code.c,56 :: 		}
	GOTO       L_main10
L_main9:
;US_final_Code.c,59 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;US_final_Code.c,60 :: 		Lcd_Out(1,1,"Out of Range");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_US_final_Code+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;US_final_Code.c,61 :: 		}
L_main10:
;US_final_Code.c,62 :: 		Delay_ms(400);
	MOVLW      5
	MOVWF      R11+0
	MOVLW      15
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_main11:
	DECFSZ     R13+0, 1
	GOTO       L_main11
	DECFSZ     R12+0, 1
	GOTO       L_main11
	DECFSZ     R11+0, 1
	GOTO       L_main11
;US_final_Code.c,63 :: 		}
	GOTO       L_main0
;US_final_Code.c,64 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
