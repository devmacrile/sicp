(define tolerance 0.00001)

(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define (try guess)
        (let ((next (f guess)))
            (newline)
            (display next)
            (if (close-enough? guess next)
                next
                (try next))))
    (try first-guess))

(fixed-point (lambda (y) (/ (log 1000) (log y))) 1.5)

(define (average x y) (/ (+ x y) 2))
(fixed-point (lambda (y) (average y (/ (log 1000) (log y)))) 1.5)

; iterations reduced from 35 to 12 using average damping
