(put `sub `(polynomial polynomial)
    (lambda (p1 p2)
        (add-poly p1 (negate p2))))

(define (negate p)
    (apply-generic `negate p))

(put `negate `integer 
    (lambda (i)
        (sub (make-integer 0) i)))

(put `negate `rational 
    (lambda (r)
        (make-rational (- (numer r) (denom r)))))

(put `negate `complex
    (lambda (c)
        (make-complex-from-real-imag (- (real-part c)) (imag-part c))))

(put `negate `polynomial
    (lambda (p)
        (make-polynomial (variable p) 
                         (negate-terms (term-list p)))))

(define (negate-terms terms)
    (if (empty-termlist? terms)
        terms
        (let ((first (first-term terms)))
            (adjoin-term (make-term (order first)
                                    (negate (coeff first)))
                         (negate-terms (rest-terms terms))))
        (adjoin-term (make-term (order)))))

