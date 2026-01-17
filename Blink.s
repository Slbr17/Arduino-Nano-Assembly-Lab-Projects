;--------------------------------------------------
; Behaviour:
;   - PB0 is turned on initially
;   - Then it is blinked 5 times:
;       ON  ~500 ms
;       OFF ~100 ms
;     and then repeats from the start
;
; Outputs:
;   - PB0: LED blinking
;
; Pin mapping:
;   - PB0 -> Arduino D8
;--------------------------------------------------
; Register usage:
;   r16 – scratch / PORTB value (0x00 or 0x01)
;   r20 – blink loop counter (5 blinks)
;   r17 – outer delay counter (both delay routines)
;   r18 – middle delay counter
;   r19 – inner delay counter
;--------------------------------------------------

.equ SREG,  0x3F
.equ PORTB, 0x05
.equ DDRB,  0x04

.org 0

main:
    ldi r16, 0
    out SREG, r16          ; clear flags

    ldi r16, 0x01
    out DDRB, r16          ; PB0 as output

    ldi r16, 0x01
    out PORTB, r16         ; LED on initially

blink_loop:
    ldi r20, 5             ; number of blinks

blink_one:
    ; LED already ON here
    call delay500ms

    ldi r16, 0x00          ; LED off
    out PORTB, r16
    call delay100ms

    ldi r16, 0x01          ; LED on
    out PORTB, r16

    dec r20
    brne blink_one         ; do next blink

    rjmp blink_loop        ; restart blinking forever

;--------------------------------------------------
; delay500ms – software delay ~500 ms (timing depends on clock)
; Uses r17, r18, r19 as nested counters
;--------------------------------------------------
delay500ms:
    ldi r17, 42
outer_500:
    ldi r18, 250
middle_500:
    ldi r19, 250
inner_500:
    dec r19
    brne inner_500
    dec r18
    brne middle_500
    dec r17
    brne outer_500
    ret

;--------------------------------------------------
; delay100ms – software delay ~100 ms
; Uses same registers r17, r18, r19
;--------------------------------------------------
delay100ms:
    ldi r17, 42
outer_100:
    ldi r18, 50
middle_100:
    ldi r19, 250
inner_100:
    dec r19
    brne inner_100
    dec r18
    brne middle_100
    dec r17
    brne outer_100
    ret
