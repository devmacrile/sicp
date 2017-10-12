;(let ((a 1))
;    (define (f x)
;        (define b (+ a x))
;        (define a 5)
;        (+ a b))
;    (f 10))
;
; (1) b set to 11, a 5, result 16
; (2) error due to a being unassigned at the time b is evaluated
; (3) truly simultaneous defines: a set to 5, b set to 15, result 20

; On principle, I support (2).
; To support (3), would have to do a scan out with an ordering
; based on variable dependency, which becomes interesting (read: complex) with
; mutually recursive definitions.