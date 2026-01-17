;--------------------------------------------------
; Behaviour:
;   - Load r20 = 0x55 (0101 0101)
;   - Shift left once, output to LEDs, delay
;   - Shift right once, output to LEDs, delay
;   - Repeat forever
;
; Outputs:
;   - PORTB[3:0], PORTD[7:4] show shifting pattern
;
; Pin mapping:
;   - PB0..PB3 -> D8..D11
;   - PD4..PD7 -> D4..D7
;--------------------------------------------------
; Register usage:
;   r16 – scratch for SREG/DDR config
;   r20 – pattern being shifted and displayed
;   r17 – outer delay counter
;   r18 – middle delay counter
;   r19 – inner delay counter
;--------------------------------------------------

.equ SREG,  0x3F
.equ PORTB, 0x05
.equ DDRB,  0x04
.equ PORTD, 0x0B
.equ DDRD,  0x0A

.org 0

main:
    ldi r16, 0
    out SREG, r16

    ldi r16, 0x0F
    out DDRB, r16          ; PB0–PB3 outputs
    ldi r16, 0xF0
    out DDRD, r16          ; PD4–PD7 outputs

loop:
    ldi r20, 0x55          ; 0101 0101

    lsl r20                ; shift left one bit
    out PORTB, r20
    out PORTD, r20
    call delay500ms

    lsr r20                ; shift right one bit (back towards original)
    out PORTB, r20
    out PORTD, r20
    call delay500ms

    rjmp loop

;--------------------------------------------------
; delay500ms – software delay (Assuming 16MHz Clock frequency)
;--------------------------------------------------
delay500ms:
    ldi r17, 42
outer:
    ldi r18, 250
middle:
    ldi r19, 250
inner:
    dec r19
    brne inner
    dec r18
    brne middle
    dec r17
    brne outer
    ret
