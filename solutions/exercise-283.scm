; place each below pair of definitions/puts
; in their respective packages

(define (raise-integer i)
    (make-rational i 1))

(put `raise `integer (lambda (x) (raise-integer x)))


(define (raise-rational r)
    (make-real (/ (numer r) (denom r))))

(put `raise `rational (lambda (x) (raise-rational x)))


(define (raise-real r)
    (make-complex-from-real-imag r 0))

(put `raise `real (lambda (x) (raise-real x)))

; generic procedure
(define (raise x)
    (apply-generic `raise x))