(define (double f)
    (lambda (x) (f (f x))))

(((double (double double)) (lambda (i) (+ i 1))) 5)
