(define (iterative-improve improve close-enough?)
    (lambda (guess)
        (if (close-enough? guess)
            guess
            ((iterative-improve improve close-enough?) 
                (improve guess)))))

(define (average x y)
    (/ (+ x y) 2))

(define (fixed-point f first-guess)
    (define tolerance 0.00001)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define (good-enough? guess)
        (close-enough? guess (f guess)))
    ((iterative-improve f good-enough?) 1.0))

(define (sqrt x)
    (define (good-enough? guess)
        (< (abs (- (square guess) x)) 0.001))
    (define (improve guess)
        (average guess (/ x guess)))
    ((iterative-improve improve good-enough?) 1.0))

(fixed-point (lambda (y) (+ (sin y) (cos y))) 1.0)
(sqrt 49)
