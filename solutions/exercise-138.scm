(define (cont-frac n d k)
    (define (iter total-denominator i)
        (if (= i 0)
            (/ (n i) total-denominator)
            (iter (+ (d i) (/ (n i) total-denominator)) (- i 1))))
    (iter 0 k))

(define (d i)
    (if (= (modulo (+ i 1) 3) 0)
        (* 2 (/ (+ i 1) 3))
        1))

(+ 2 (cont-frac (lambda (i) 1.0) (lambda (i) (d i)) 100))
