(define (ripple-carry-adder A B S c-in)
    (if (null? (car A))
        `ok
        (let ((a (car A))
              (b (car B))
              (s (car S))
              (c-out (make-wire)))
          (full-adder a b c-in s c-out)
          (ripply-carry-adder (cdr A) (cdr B) (cdr S) c-out))))

; Delay in terms of delays for and-gates, or-gates, inverters?
; Each full-adder will have two half-adder delays and an or delay.
; Each half-adder will have the max of and+inverter/or + an and.
; => n * (2 * (2 * and + inverter) + or)
;  = 4 * n * and + 2 * n * inverter + n * or