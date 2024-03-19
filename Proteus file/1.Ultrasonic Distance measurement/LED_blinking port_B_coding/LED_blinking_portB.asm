
_main:

;LED_blinking_portB.c,1 :: 		void main() {
;LED_blinking_portB.c,2 :: 		TRISB =   0x00;
	CLRF       TRISB+0
;LED_blinking_portB.c,3 :: 		while(1){
L_main0:
;LED_blinking_portB.c,4 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;LED_blinking_portB.c,5 :: 		delay_ms(1000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
	NOP
;LED_blinking_portB.c,6 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;LED_blinking_portB.c,7 :: 		delay_ms(1000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
	NOP
;LED_blinking_portB.c,8 :: 		}
	GOTO       L_main0
;LED_blinking_portB.c,10 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
