;--------------------------------------------------
; Behaviour:
;   x = PINC.
;   If x < 3:
;       y = x + 2
;   else:
;       y = x - 1 + 2 = x + 1
;   PORTB = y.
;
; Inputs:
;   - PINC[3:0].
; Outputs:
;   - PORTB[3:0] = PINC[3:0] + 2, if PINC < 3
;                  PINC[3:0] + 1, if PINC >= 3.
;
;--------------------------------------------------
; Register usage:
;   r16 – accumulator (input x and final y)
;   r17 – constants for +/- operations
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

    in  r16, PINC           ; x = PINC

    cpi r16, 3
    brlo small              ; branch if x < 3

    ; Case x >= 3: subtract 1
    ldi r17, 1
    sub r16, r17            ; r16 = x - 1

small:
    ; Both cases now add 2
    ldi r17, 2
    add r16, r17            ; r16 = (x - 1) + 2 or x + 2

    out PORTB, r16          ; y -> PORTB

mainloop:
    rjmp mainloop
