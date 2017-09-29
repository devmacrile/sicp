(define (RC R C dt)
    (define (rc-stream istream v0)
        (define voltages
            (cons-stream v0
                         (add-streams (scale-stream istream (/ dt C)))
                         voltages))
        voltages)
    rc-stream)

(define RC1 (RC 5 1 0.5))