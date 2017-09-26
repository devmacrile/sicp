; was trying to get fancy with transforms and tableaus,
; but this is actually all we need
(define (stream-limit s tolerance)
    (let ((s0 (stream-ref s 0))
          (s1 (stream-ref s 1)))
    (if (< (abs (- s1 s0)) tolerance)
        s1
        (stream-limit (stream-cdr s) tolerance))))

; test using sqrt-stream
(define (sqrt-stream x)
    (define guesses
        (cons-stream 1.0
                     (stream-map (lambda (guess)
                                   (sqrt-improve guess x))
                                 guesses)))
    guesses)

(define (sqrt-improve guess x)
    (/ (+ guess (/ x guess)) 2))

(define (sqrt-approx x tolerance)
    (stream-limit (sqrt-stream x) tolerance))

(sqrt-approx 2 0.1)
(sqrt-approx 2 0.01)
(sqrt-approx 2 0.0000001)