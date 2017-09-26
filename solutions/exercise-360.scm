(define (scale-stream stream factor)
    (stream-map (lambda (x) (* x factor)) stream))

(define (add-streams s1 s2)
    (stream-map + s1 s2))

(define (mul-series s1 s2)
    (cons-stream (* (stream-car s1) (stream-car s2)) 
                 (add-streams 
                     (scale-stream (stream-cdr s2) (stream-car s1)) 
                     (mul-series (stream-cdr s1) s2))))


; Test mul-series by verifying that sin^2(x) + cos^2(x) = 1
(define ones (cons-stream 1 ones))

(define integers (cons-stream 1 (add-streams ones integers)))

(define (div-streams s1 s2)
    (stream-map / s1 s2))

(define (integrate-series s)
    (div-streams s integers))

(define cosine-series
    (cons-stream 1 (scale-stream (integrate-series sine-series) -1)))

(define sine-series
    (cons-stream 0 (integrate-series cosine-series)))

(define (display-line x)
    (newline)
    (display x))

; the actual test bit
(define unit-circle (add-streams (mul-series cosine-series cosine-series)
                                (mul-series sine-series sine-series)))
(display-line (stream-car unit-circle))
