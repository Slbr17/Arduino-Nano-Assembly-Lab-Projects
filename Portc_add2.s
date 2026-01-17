;--------------------------------------------------
; Behaviour:
;   - r16 = PINC
;   - r16 = r16 + 2
;   - PORTB = r16
;
; Inputs:
;   - PINC[3:0]
; Outputs:
;   - PORTB[3:0] = PINC[3:0] + 2
;
;--------------------------------------------------
; Register usage:
;   r16 – accumulator (input and result)
;   r17 – constant 2 used for addition
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

    ldi r16, 0x0F
    out DDRB, r16           ; PB0–PB3 outputs

    ldi r16, 0xF0
    out DDRC, r16           ; PC0–PC3 inputs, PC4–PC7 outputs

    in  r16, PINC
    ldi r17, 2
    add r16, r17            ; r16 = PINC + 2

    out PORTB, r16

mainloop:
    rjmp mainloop
