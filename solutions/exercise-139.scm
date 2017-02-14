(define (cont-frac n d k)
    (define (iter total-denominator i)
        (if (= i 0)
            (/ (n i) total-denominator)
            (iter (+ (d i) (/ (n i) total-denominator)) (- i 1))))
    (iter 0 k))

(define (tan-cf x k)
    (define (d i)
        (- (* 2 i) 1))
    (define (n i)
        (if (= i 0) 
            x
            (- (* x x))))
    (cont-frac n d k))

(tan-cf 0.001 10)
(tan-cf 3.14 10)  ; approx 0
(tan-cf 0.785398 10)  ; pi/4 => should be about 1