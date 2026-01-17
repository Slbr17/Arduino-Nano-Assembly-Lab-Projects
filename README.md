# Arduino-Nano-Assembly-Lab-Projects

This repository contains a collection of pure AVR assembly programs developed during laboratory sessions at King’s College London. The projects target the Arduino Nano board using the ATmega328P microcontroller and were created as part of coursework focused on low-level embedded systems programming.

All source files are written in AVR assembly language rather than Arduino C/C++. As a result, these programs **must be assembled and flashed separately**.

# Intended Use

This repository is intended primarily for educational purposes and personal reference. It may also be useful to students or learners interested in low-level AVR microcontroller programming.

# Individual Program Behaviour Summary

**Bit_shifting.s:**

  Shifts a byte pattern left and right and displays it on LEDs.

**Blink.s:**

  Blinks an LED on PB0 five times with delays, repeating forever.

**Portc_add2.s**

  Reads PINC, adds 2, outputs the result to PORTB.

**Portc_compare.s**

  Reads PINC and conditionally modifies the value before outputting to PORTB.

**Portc_sub1.s**

  Reads PINC, subtracts 1, outputs the result to PORTB.

**Read_portc.s**

  Copies the value read from PINC directly to PORTB.

**Swap_nybbles.s**

  Alternates between a byte and its nibble-swapped version on LEDs.
