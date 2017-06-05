; (a)
; Using data-directed programming for different derivative expressions.
; Cannot generalize as numbers/variables are expressions without operators
; (as well as constructors).

; (b, c) 
; I do not actually see the direct analogy here with the complex number representation (and it
; seems reasonable to have a derivative procedure that acts on mult operations, as opposed to operating 
; on the same level).
(define (deriv exp var)
    (cond ((number? exp) 0)
          ((variable? exp) 0)
          (else ((get `deriv (operator exp)) (operands exp) var))))

(define (operator map) (car exp))
(define (operands exp) (cdr exp))

(define (install-deriv-package)

    ; internal procedures
    (define (make-sum-deriv exp var)
        (make-sum (deriv (addend exp) var)
                  (deriv (augend exp) var)))

    (define (make-product-deriv exp var)
        (make-sum (make-product (multiplier exp)
                                (deriv (multiplicand exp) var))
                  (make-product (deriv (multiplier exp) var)
                                (multiplicand exp))))

    ; (c)
    (define (make-exp-deriv)
        (make-product (make-product (exponent exp) 
                                (make-exponentiation (base exp) (- (exponent exp) 1)))
                  (deriv (base exp) var)))

    ; interface to rest of system
    (put `deriv `* make-product-deriv)
    (put `deriv `+ make-sum-deriv)
    (put `deriv `** make-exp-deriv)
    `done)

; (d)
; All we would have to do is change the order of inputs in the (put) commands within 
; the install procedure.
