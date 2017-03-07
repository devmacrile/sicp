(define (make-segment v w)
    (cons ((cons 0 0) v) ((cons 0 0) w)))

(define (start-segment seg)
    (car seg))

(define (end-segment seg)
    (cdr seg))