(define (or-gate a1 a2 output)
    (let ((b (make-wire))
          (c (make-wire))
          (d (make-wire)))
      (inverter a1 b)
      (inverter a2 c)
      (and-gate b c d)
      (inverter d)
      `ok))

; since the inversions of a1/a2 are independent, they
; can occur simultaneously so the total delay would 
; be (+ (* 2 inverter-delay) (* 1 and-gate-delay))