
_Display:

;luxmeter_demo.c,20 :: 		void Display()
;luxmeter_demo.c,22 :: 		Lcd_init();
	CALL       _Lcd_Init+0
;luxmeter_demo.c,23 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;luxmeter_demo.c,24 :: 		Lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;luxmeter_demo.c,25 :: 		if(vd!=0)
	CLRF       R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       _vd+0, 0
	MOVWF      R0+0
	MOVF       _vd+1, 0
	MOVWF      R0+1
	MOVF       _vd+2, 0
	MOVWF      R0+2
	MOVF       _vd+3, 0
	MOVWF      R0+3
	CALL       _Equals_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_Display0
;luxmeter_demo.c,27 :: 		Lcd_out(1,1,"Intesity in lux");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_luxmeter_demo+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;luxmeter_demo.c,28 :: 		Lcd_out(2,12,"Lux");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      12
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_luxmeter_demo+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;luxmeter_demo.c,29 :: 		floattostr(vd,txt);
	MOVF       _vd+0, 0
	MOVWF      FARG_FloatToStr_fnum+0
	MOVF       _vd+1, 0
	MOVWF      FARG_FloatToStr_fnum+1
	MOVF       _vd+2, 0
	MOVWF      FARG_FloatToStr_fnum+2
	MOVF       _vd+3, 0
	MOVWF      FARG_FloatToStr_fnum+3
	MOVLW      _txt+0
	MOVWF      FARG_FloatToStr_str+0
	CALL       _FloatToStr+0
;luxmeter_demo.c,30 :: 		Lcd_out(2,1,txt);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;luxmeter_demo.c,31 :: 		}
L_Display0:
;luxmeter_demo.c,32 :: 		}
L_end_Display:
	RETURN
; end of _Display

_main:

;luxmeter_demo.c,33 :: 		void main()
;luxmeter_demo.c,35 :: 		T1CON =0x10; // configure --------------------000
	MOVLW      16
	MOVWF      T1CON+0
;luxmeter_demo.c,36 :: 		TRISA = 0b00010000; // All pins of port A are declared as i/p
	MOVLW      16
	MOVWF      TRISA+0
;luxmeter_demo.c,37 :: 		Lcd_init();
	CALL       _Lcd_Init+0
;luxmeter_demo.c,38 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;luxmeter_demo.c,39 :: 		Lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;luxmeter_demo.c,40 :: 		Lcd_out(1,1,"lux meter");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_luxmeter_demo+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;luxmeter_demo.c,41 :: 		while(1)
L_main1:
;luxmeter_demo.c,43 :: 		v = ADC_Read(0); //Digital level count, read from RA0
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	CALL       _word2double+0
	MOVF       R0+0, 0
	MOVWF      _v+0
	MOVF       R0+1, 0
	MOVWF      _v+1
	MOVF       R0+2, 0
	MOVWF      _v+2
	MOVF       R0+3, 0
	MOVWF      _v+3
;luxmeter_demo.c,44 :: 		va=(v*4.9)/255; //analog ....... Vref=4.9V
	MOVLW      205
	MOVWF      R4+0
	MOVLW      204
	MOVWF      R4+1
	MOVLW      28
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      134
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _va+0
	MOVF       R0+1, 0
	MOVWF      _va+1
	MOVF       R0+2, 0
	MOVWF      _va+2
	MOVF       R0+3, 0
	MOVWF      _va+3
;luxmeter_demo.c,45 :: 		if(va>0.01)
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVLW      10
	MOVWF      R0+0
	MOVLW      215
	MOVWF      R0+1
	MOVLW      35
	MOVWF      R0+2
	MOVLW      120
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main3
;luxmeter_demo.c,47 :: 		vd=-(174.4*va*va*va)+(1403*va*va)-(3862*va)+3500;//Fitted curve, vd is lux
	MOVLW      102
	MOVWF      R0+0
	MOVLW      102
	MOVWF      R0+1
	MOVLW      46
	MOVWF      R0+2
	MOVLW      134
	MOVWF      R0+3
	MOVF       _va+0, 0
	MOVWF      R4+0
	MOVF       _va+1, 0
	MOVWF      R4+1
	MOVF       _va+2, 0
	MOVWF      R4+2
	MOVF       _va+3, 0
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       _va+0, 0
	MOVWF      R4+0
	MOVF       _va+1, 0
	MOVWF      R4+1
	MOVF       _va+2, 0
	MOVWF      R4+2
	MOVF       _va+3, 0
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       _va+0, 0
	MOVWF      R4+0
	MOVF       _va+1, 0
	MOVWF      R4+1
	MOVF       _va+2, 0
	MOVWF      R4+2
	MOVF       _va+3, 0
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVLW      0
	XORWF      R0+0, 0
	MOVWF      FLOC__main+0
	MOVLW      0
	XORWF      R0+1, 0
	MOVWF      FLOC__main+1
	MOVLW      128
	XORWF      R0+2, 0
	MOVWF      FLOC__main+2
	MOVLW      0
	XORWF      R0+3, 0
	MOVWF      FLOC__main+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      96
	MOVWF      R0+1
	MOVLW      47
	MOVWF      R0+2
	MOVLW      137
	MOVWF      R0+3
	MOVF       _va+0, 0
	MOVWF      R4+0
	MOVF       _va+1, 0
	MOVWF      R4+1
	MOVF       _va+2, 0
	MOVWF      R4+2
	MOVF       _va+3, 0
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       _va+0, 0
	MOVWF      R4+0
	MOVF       _va+1, 0
	MOVWF      R4+1
	MOVF       _va+2, 0
	MOVWF      R4+2
	MOVF       _va+3, 0
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       FLOC__main+0, 0
	MOVWF      R4+0
	MOVF       FLOC__main+1, 0
	MOVWF      R4+1
	MOVF       FLOC__main+2, 0
	MOVWF      R4+2
	MOVF       FLOC__main+3, 0
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       R0+1, 0
	MOVWF      FLOC__main+1
	MOVF       R0+2, 0
	MOVWF      FLOC__main+2
	MOVF       R0+3, 0
	MOVWF      FLOC__main+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      96
	MOVWF      R0+1
	MOVLW      113
	MOVWF      R0+2
	MOVLW      138
	MOVWF      R0+3
	MOVF       _va+0, 0
	MOVWF      R4+0
	MOVF       _va+1, 0
	MOVWF      R4+1
	MOVF       _va+2, 0
	MOVWF      R4+2
	MOVF       _va+3, 0
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVF       FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       FLOC__main+1, 0
	MOVWF      R0+1
	MOVF       FLOC__main+2, 0
	MOVWF      R0+2
	MOVF       FLOC__main+3, 0
	MOVWF      R0+3
	CALL       _Sub_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      90
	MOVWF      R4+2
	MOVLW      138
	MOVWF      R4+3
	CALL       _Add_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _vd+0
	MOVF       R0+1, 0
	MOVWF      _vd+1
	MOVF       R0+2, 0
	MOVWF      _vd+2
	MOVF       R0+3, 0
	MOVWF      _vd+3
;luxmeter_demo.c,49 :: 		}
	GOTO       L_main4
L_main3:
;luxmeter_demo.c,51 :: 		vd=0;
	CLRF       _vd+0
	CLRF       _vd+1
	CLRF       _vd+2
	CLRF       _vd+3
L_main4:
;luxmeter_demo.c,53 :: 		Display(); //Display Function call and return values
	CALL       _Display+0
;luxmeter_demo.c,54 :: 		Delay_ms(300);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      12
	MOVWF      R12+0
	MOVLW      51
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
	NOP
	NOP
;luxmeter_demo.c,57 :: 		}
	GOTO       L_main1
;luxmeter_demo.c,58 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
