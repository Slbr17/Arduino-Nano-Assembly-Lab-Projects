;--------------------------------------------------
; Behaviour:
;   - Read 8-bit value from PINC into r16
;   - Write r16 to PORTB
;
; Inputs:
;   - PINC[3:0] (e.g. switches on PC0..PC3)
; Outputs:
;   - PORTB[3:0] mirrors PINC[3:0] (D8..D11 follow PC0..PC3)
;
;--------------------------------------------------
; Register usage:
;   r16 – accumulator:
;        - holds value read from PINC
;        - then written to PORTB
;--------------------------------------------------

.equ SREG,  0x3F
.equ DDRB,  0x04
.equ PORTB, 0x05
.equ DDRC,  0x07
.equ PINC,  0x06

.org 0

main:
    ldi r16, 0
    out SREG, r16

    ; PORTB: outputs on low nibble
    ldi r16, 0x0F
    out DDRB, r16

    ; PORTC: inputs on low nibble, outputs on high nibble
    ldi r16, 0xF0
    out DDRC, r16           ; PC0–PC3 = input, PC4–PC7 = output

    in  r16, PINC           ; read external pins
    out PORTB, r16          ; copy to PORTB

mainloop:
    rjmp mainloop
