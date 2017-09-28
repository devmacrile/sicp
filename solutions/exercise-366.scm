; considering (pairs integers integers) with pairs implemented
; in the interleaving fashion described..
; How many pairs precede the pair (1, 100) in the stream?  (99, 100)?
;
; The first stream (row) will be interleaved every other, so in 
; general for (1, n), 2n pairs will precede it.
; 
; More generally, for a pair (m, n): the first pair (m, m) will be preceded
; by (2^m - 1) - 1 pairs and will not appear again for 2^m - 1 pairs (i.e. 
; the pair (m, m+1) will be 2^(m - 1) pairs).
; Thus, for the specific case of (99, 100):
;   ((2^99 - 1) - 1) + (2^(99 - 1) - 1)
; pairs would come first.

(define (interleave s1 s2)
    (if (stream-null? s1)
        s2
        (cons-stream (stream-car s1)
                     (interleave s2 (stream-cdr s1)))))

(define (pairs s1 s2)
    (cons-stream
        (list (stream-car s1) (stream-car s2))
        (interleave
            (stream-map (lambda (x) (list (stream-car s1) x))
                        (stream-cdr s2))
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

(display-stream-head (pairs integers integers) 10)
;(1 1)
;(1 2)
;(2 2)
;(1 3)
;(2 3)
;(1 4)
;(3 3)
;(1 5)
;(2 4)
;(1 6)
;Value: done
