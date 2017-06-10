(define (=zero? x)
    (apply-generic `=zero? x))

(put `=zero? `scheme-number (lambda (x) (= x 0)))
(put `=zero? `rational (lambda (x) (= (numer x) 0)))
(put `=zero? `complex (lambda (x) (= (magnitude x) 0)))
