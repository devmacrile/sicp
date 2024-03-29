;(define (integral delayed-integrand initial-value dt)
;    (define int
;        (cons-stream initial-value
;                     (let ((integrand (force delayed-integrand)))
;                        (add-streams (scale-stream integrand dt)
;                                     int)))))
;
;(define (solve f y0 dt)
;    (define y (integral (delay dy) y0 dt))
;    (define dy (stream-map f y))
;    y)
;
;(stream-ref (solve (lambda (x) x) 1 0.001) 1000)

(define (integral delayed-integrand initial-value dt)
    (cons-stream initial-value
                 (let ((integrand (force delayed-integrand)))
                     (if (stream-null? integrand)
                         the-empty-stream
                         (integral (delay (stream-cdr integrand))
                                   (+ (* dt (stream-car integrand))
                                      initial-value)
                                   dt)))))