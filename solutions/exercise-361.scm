(define (scale-stream stream factor)
    (stream-map (lambda (x) (* x factor)) stream))

(define (add-streams s1 s2)
    (stream-map + s1 s2))

(define (mul-series s1 s2)
    (cons-stream (* (stream-car s1) (stream-car s2)) 
                 (add-streams 
                     (scale-stream (stream-cdr s2) (stream-car s1)) 
                     (mul-series (stream-cdr s1) s2))))

(define (invert-unit-series s)
    (cons-stream 1 
                 (scale-stream 
                    (mul-series (stream-cdr s) 
                                (invert-unit-series s)) 
                    -1)))
