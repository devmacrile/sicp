(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
    (and (number? exp) (= exp num)))

; addition
(define (sum? x)
    (and (pair? x) (eq? (car x) `+)))

(define (addend s)
    (cadr s))


; multiplication
(define (product? x)
    (and (pair? x) (eq? (car x) `*)))

(define (multiplier p)
    (cadr p))

; exponentiation
(define (exponentiation? x)
    (and (pair? x) (eq? (car x) `**)))

(define (base exp)
    (cadr exp))

(define (exponent exp)
    (caddr exp))

; constructors
(define (make-exponentiation e1 e2)
    (cond ((=number? e2 0) 1)
          ((=number? e2 1) e1)
          ((and (number? e1) (number? e2)) (expt e1 e2))
          (else (list `**  e1 e2))))

(define (make-sum a1 a2) 
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list `+ a1 a2))))

(define (make-product m1 m2) 
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list `* m1 m2))))

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


; Bringing in accumulate from earlier problems
(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (augend s)
    (accumulate make-sum 0 (cddr s)))
  
(define (multiplicand p)
    (accumulate make-product 1 (cddr p)))


; Pretty cool.  Had to fuddle around a bit before realizing we only had to
; alter the augend/multiplicand selectors and could utilize accumulate.
; Saw this way being criticized on a solution forum for changing the structure 
; (doing the calculation all up front, as opposed to letting the recursive calls
; handle it at each step).  I agree now, I guess, but I think the idea is also
; to not litter every little function with the primitive operator (i.e. +/*).
; 'accumulate' allows us to utilize our constructors (unchanged), which I dig.

(deriv `(+ x y) `x)
(deriv `(* x y) `x)
(deriv `(* x y (+ x 3)) `x)
(deriv `(* x y (+ y 2) x (+ x 3)) `x)
