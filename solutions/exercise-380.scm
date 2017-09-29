; An RLC circuit consists of a resistor (R), capacitor (C) and inductor (L)
; connected in a series.  Relationship between voltage (v) and current (i)
; are described by DEs:
;   vR = iR * R
;   vL = L * (diL / dt)
;   iC = C * (dvC / dt)
; and the circuit connection define the relations:
;   iR = iL = -iC
;   vC = vL + vR
; Combining these, we get the pair of DEs:
;   dvC/dt = -iL/C
;   diL/dt = (1/L) * vC - (R/L) * iL

(define (RLC R L C dt)
    (lambda (v0 i0)
        (define v (integral (delay dv) v0 dt))
        (define dv (scale-stream i (- (/ 1 C))))
        (define i (integral (delay di) i0 dt))
        (define di (add-streams (scale-stream v (/ 1 L))
                                (scale-stream i (- (/ R L)))))
        (cons v i)))

(define rlc-proc (RLC 1 1 0.2 0.1))
(define rlc-stream (rlc-proc 10 0))
; (stream-ref rlc-stream 100)
