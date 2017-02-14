(define (cont-frac n d k)
    (if (= k 0)
        (/ (n k) (d k))
        (/ (n k) (+ (d k) (cont-frac n d (- k 1))))))

(cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 10)


; recursive above, so iteratively
(define (cont-frac-iter n d k)
    (define (iter total-denominator i)
        (if (= i 1)
            (/ (n i) total-denominator)
            (iter (+ (d i) (/ (n i) total-denominator)) (- i 1))))
    (iter 0 k))

(cont-frac-iter (lambda (i) 1.0) (lambda (i) 1.0) 13)
; Requires more iterations than recursive version... why?
