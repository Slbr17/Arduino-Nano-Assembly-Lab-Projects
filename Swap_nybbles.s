;--------------------------------------------------
; Behaviour:
;   - r24 starts with a constant pattern (e.g. 0x81)
;   - Display original pattern on LEDs for ~500 ms
;   - Call swap_nibbles on r24
;   - Display swapped pattern for ~500 ms
;   - Swap again (back to original) and repeat forever
;
; Inputs:
;   - None (pattern is hard-coded)
; Outputs:
;   - PORTB[3:0] and PORTD[7:4] show original and swapped nibbles
;
; Pin mapping:
;   - PB0..PB3 -> D8..D11
;   - PD4..PD7 -> D4..D7
;
;--------------------------------------------------
; Register usage:
;   r16  – scratch for SREG/DDR config
;   r24  – current pattern (input & output to swap_nibbles)
;   r18  – temp: low nibble for swap_nibbles
;   r19  – temp: high nibble for swap_nibbles
;   r21  – outer delay counter
;   r22  – middle delay counter
;   r23  – inner delay counter
;--------------------------------------------------
; swap_nibbles calling convention:
;   Input:
;     - r24: byte whose nibbles are to be swapped
;   Output:
;     - r24: byte with high/low nibbles swapped
;   Clobbers:
;     - r18, r19
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

    ; Configure LEDs
    ldi r16, 0x0F
    out DDRB, r16          ; PB0–PB3 outputs
    ldi r16, 0xF0
    out DDRD, r16          ; PD4–PD7 outputs

    ldi r24, 0x81          ; initial pattern 1000 0001

loop:
    ; Show original pattern
    out PORTB, r24
    out PORTD, r24
    rcall Delay_500ms

    ; Swap nibbles in r24
    rcall swap_nibbles

    ; Show swapped pattern
    out PORTB, r24
    out PORTD, r24
    rcall Delay_500ms

    ; Swap back to original and repeat
    rcall swap_nibbles
    rjmp loop

;--------------------------------------------------
; Subroutine: swap_nibbles
; r24 in -> r24 out (nibbles swapped)
;--------------------------------------------------
swap_nibbles:
    mov  r18, r24          ; copy original
    andi r18, 0x0F         ; keep low nibble (0000 efgh)
    lsl  r18               ; move into high nibble
    lsl  r18
    lsl  r18
    lsl  r18               ; r18 = efgh 0000

    mov  r19, r24
    andi r19, 0xF0         ; keep high nibble (abcd 0000)
    lsr  r19
    lsr  r19
    lsr  r19
    lsr  r19               ; r19 = 0000 abcd

    or   r18, r19          ; efgh abcd
    mov  r24, r18
    ret

;--------------------------------------------------
; Delay_500ms
;--------------------------------------------------
Delay_500ms:
    ldi r21, 42
outer:
    ldi r22, 250
middle:
    ldi r23, 250
inner:
    dec r23
    brne inner
    dec r22
    brne middle
    dec r21
    brne outer
    ret
