; (a)
(define (integerizing-factor a b)
    (let ((a1 (first-term a)))
         ((b1 (first-term b)))
         (expt (coeff b1) 
               (+ 1 (- (order a1) 
                       (order b1))))))

(define (psuedoremainder-terms a b)
    (let ((factor (integerizing-factor a b)))
        (let ((scaled-a (mul-term-by-all-terms (make-term 0 factor) a)))
            (cadr (div-terms scaled-a b)))))

(define (gcd-terms a b)
    (if (empty-termlist? b)
        a
        (gcd-terms b (pseudoremainder-terms a b))))

; (b) 
; modify gcd-terms to remove common factors from the 
; coefficients of the answer
(define (gcd-terms a b)
    (if (empty-termlist? b)
        (let ((coeff-gcd (apply gcd (map coeff a))))
            (div-terms a (make-term 0 a)))
        (gcd-terms b (psuedoremainder-terms a b))))