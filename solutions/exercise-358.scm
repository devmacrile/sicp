(define (expand num den radix)
    (cons-stream
        (quotient (* num radix) den)
        (expand (remainder (* num radix) den) den radix)))

(define (display-stream s)
    (stream-for-each display-line s))

(define (display-stream-head s n)
    (if (or (= n 0)
            (stream-null? (stream-car s)))
        `done
        (begin (display-line (stream-car s))
               (display-stream-head (stream-cdr s) (- n 1)))))

(define (display-line x)
    (newline)
    (display x))

(define s1 (expand 1 7 10))
(display-stream-head s1 10)
; 1 4 2 8 5 7 1 4 2 8

(define s2 (expand 3 8 10))
(display-stream-head s2 10)
; 3 7 5 0 0 0 0 0 0 0

; The stream computes the expanded decimal form of the fraction
; defined by num / den, with radix providing the base (naturally).
