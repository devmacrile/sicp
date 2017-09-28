; Louis' pairs implementation
; no this will not work because it is not utilizing
; the main notion that a streams cdr uses delayed evaluation
; => this attempts to evaluate recursively, hits depth limit
(define (pairs s1 s2)
    (interleave 
        (stream-map (lambda (x) (list (stream-car s1) x))
                    s2)
        (pairs (stream-cdr s1) (stream-cdr s2))))

(define (interleave s1 s2)
    (if (stream-null? s1)
        s2
        (cons-stream (stream-car s1)
                     (interleave s2 (stream-cdr s1)))))

(define (stream-cddr s)
    (stream-cdr (stream-cdr s)))

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