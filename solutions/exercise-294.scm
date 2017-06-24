(define (gcd-terms a b)
    (if (empty-termlist? b)
        a
        (gcd-terms b (remainder-terms a b))))

(define (remainder-terms a b)
    (cadr (div-terms a b)))

(define (gcd-poly a b)
    (if (same-variable? (variable a) (variable b))
        (make-poly (variable a) 
                   (gcd-terms (term-list a) 
                              (term-list b)))
        (error "Polys not in same var -- DIV-POLY"
               (list a b))))

(put `greatest-common-divisor `(polynomial polynomial)
    (lambda (a b) (gcd-poly a b)))

(put `greatest-common-divisor `(scheme-number scheme-number)
    (lambda (a b) (gcd a b)))

(define (greatest-common-divisor a b)
    (apply-generic `greatest-common-divisor a b))

; tests defined in problem
(define p1 (make-polynomial `x `((4 1) (3 -1) (2 -2) (1 2))))
(define p2 (make-polynomial `x `((3 1) (1 -1))))
(greatest-common-divisor p1 p2)