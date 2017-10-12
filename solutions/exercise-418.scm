; (lambda <vars>
;   (define u <e1>)
;   (define v <e2>)
;   <e3>)
;
; (lambda <vars>
;    (let ((u `*unassigned*)
;          (v `*unassigned*))
;      (let ((a <e1>)
;            (b <e2>))
;        (set! u a)
;        (set! v b))
;      <e3>))

(define (solve f y0 dt)
    (define y (integral (delay dy) y0 dt))
    (define dy (stream-map f y))
    y)

; Will not work as when b is being assigned, it expects
; y to already be defined (the a assignment is okay because 
; the evaluation of dy is delayed).  Yes, would work in 
; the scanned out version because there are no intermediate
; variables.
