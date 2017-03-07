(define (exponentiation? x)
    (and (pair? x) (eq? (car x) '**)))

(define (base exp)
    (cadr exp))

(define (exponent exp)
    (caddr exp))

(define (make-exponentiation e1 e2)
    (cond ((=number? e2 0) 1)
          ((=number? e2 1) e1)
          ((and (number? e1) (number? e2)) (expt e1 e2))
          (else (list '**  e1 e2))))

(define (deriv exp var)
    (cond ((number? exp) 0)
          ((variable? exp)
            (if (same-variable? exp var) 1 0))
          ((sum? exp)
            (make-sum (deriv (addend exp) var)
                      (deriv (augend exp) var)))
          ((product? exp)
            (make-sum
                (make-product (multiplier exp)
                              (deriv (multiplicand exp) var))
                (make-product (deriv (multiplier exp) var)
                              (multiplicand exp))))
          ((exponentiation? exp)
            (make-product (make-product (exponent exp) 
                                        (make-exponentiation (base exp) (- (exponent exp) 1)))
                          (deriv (base exp) var)))
          (else
            (error "unknown expression type -- DERIV" exp))))