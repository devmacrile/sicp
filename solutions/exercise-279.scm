; define equ? for ordinary, rational, and complex numbers
(define (equ? z1 z2)
    (apply-generic `equ? z1 z2))

(put `equ? `(scheme-number scheme-number) =))
(put `equ? `(rational rational) (compare_parts z1 z2 numer denom))
(put `equ? `(complex complex) (compare parts z1 z2 real-part image-part))

(define (compare-parts z1 z2 comp1 comp2)
    (lambda (z1 z2)
        (and (= (comp1 z1)
                (comp1 z2))
             (= (comp2 z1)
                (comp2 z2)))))