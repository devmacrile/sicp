(define (interleave s1 s2)
    (if (stream-null? s1)
        s2
        (cons-stream (stream-car s1)
                     (interleave s2 (stream-cdr s1)))))

(define (pairs s1 s2)
    (cons-stream
        (list (stream-car s1) (stream-car s2))
        (interleave
            (interleave
                (stream-map (lambda (x) (list (stream-car s1) x))
                            (stream-cdr s2))
                (stream-map (lambda (x) (list x (stream-car s1)))
                            (stream-cdr s2)))
            (pairs (stream-cdr s1) (stream-cdr s2)))))

(define (integers-starting-from n)
    (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (display-line x)
    (newline)
    (display x))

(define (display-stream-head s n)
    (define (display-iter s n)
        (if (= n 0)
            `done
            (begin (display-line (stream-car s))
                   (display-iter (stream-cdr s) (- n 1)))))
    (display-iter s n))

(display-stream-head (pairs integers integers) 100)