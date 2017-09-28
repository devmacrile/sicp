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

(define (triples s u v)
    (cons-stream
        (list (stream-car s) (stream-car u) (stream-car v))
        (interleave
            (stream-map (lambda (x) (list (stream-car s) (car x) (cadr x)))
                        (pairs (stream-cdr u) (stream-cdr v)))
            (triples (stream-cdr s) (stream-cdr u) (stream-cdr v)))))



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

(define (sum-of-squares x y)
    (+ (square x) (square y)))

(define pythagorean-triples
    (stream-filter
        (lambda (x) (= (sum-of-squares (list-ref x 0) (list-ref x 1)) 
                       (square (list-ref x 2))))
        (triples integers integers integers)))

; slow as nuts, but works
(display-stream-head pythagorean-triples 5)