; https://en.wikipedia.org/wiki/Binomial_transform#Euler_transform
(define (euler-transform s)
    (let ((s0 (stream-ref 0))
          (s1 (stream-ref s 1))
          (s2 (stream-ref s 2)))
    (cons-stream (- s2 (/ (square (- s2 s1))
                          (+ s0 (* -2 s1) s2)))
                 (euler-transform (stream-cdr s)))))

(define (make-tableau transform s)
    (cons-stream s
                 (make-tableau transform
                               (transform s))))

(define (accelerated-sequence transform s)
    (stream-map stream-car
                (make-tableau transform s)))

; from 3.55
(define (add-streams s1 s2)
    (stream-map + s1 s2))
(define (scale-stream stream factor)
    (stream-map (lambda (x) (* x factor)) stream))
(define (partial-sums s)
    (cons-stream (stream-car s) 
                 (add-streams (stream-cdr s) (partial-sums s))))

; define our ln2 series sum
(define (ln2-summands n)
    (cons-stream (/ 1.0 n)
                 (stream-map - (ln2-summands (+ n 1)))))
(define ln2-stream
    (partial-sums (ln2-summands 1)))

; display utilities
(define (display-line x)
    (newline)
    (display x))
(define (display-stream s)
    (stream-for-each display-line s))

; cannot get the accelerated-sequence to work properly
; code is straight from the book as is
; (display-stream (accelerated-sequence euler-transform ln2-stream))
(display-stream ln2-stream)

