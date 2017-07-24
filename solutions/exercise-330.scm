(define (ripple-carry-adder A B S c-out)
    (let ((a (car A)
          (b (car B))
          (s (car S)) 
          (c-in (make-wire)))
        (if (null? (cdr A))
            (set-signal! c-in 0)
            (ripple-carry-adder (cdr A) (cdr B) (cdr S) ))
        (full-adder a b c-in s c-out))))
; edit: misunderstood the diagram - need to recurse to the nth binary
; digit and bring the carry back from there.

; Delay in terms of delays for and-gates, or-gates, inverters?
; Each full-adder will have two half-adder delays and an or delay.
; Each half-adder will have the max of and+inverter/or + an and.
; => n * (2 * (2 * and + inverter) + or)
;  = 4 * n * and + 2 * n * inverter + n * or
