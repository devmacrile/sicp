(define (make-segment start end)
    (cons start end))

(define (start-segment seg)
    (car seg))

(define (end-segment seg)
    (cdr seg))

(define (average x y)
    (/ (+ x y) 2))

(define (midpoint-segment seg)
    (make-point (average (x-point (start-segment seg)) (x-point (end-segment seg)))
        (average (y-point (start-segment seg)) (y-point (end-segment seg)))))

(define (make-point x y)
    (cons x y))

(define (x-point p)
    (car p))

(define (y-point p)
    (cdr p))

(define (print-point p)
    (newline)
    (display "(")
    (display (x-point p))
    (display ", ")
    (display (y-point p))
    (display ")"))

(print-point (midpoint-segment (make-segment (make-point 0 1) (make-point 0 0))))
