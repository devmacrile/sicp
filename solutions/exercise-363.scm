(define (sqrt-improve guess x)
    (average guess (/ x guess)))

; Why is...
(define (sqrt-stream x)
    (cons-stream 1.0
                 (stream-map (lambda (guess)
                                (sqrt-improve guess x))
                             (sqrt-stream x))))


; ... less efficient than?
(define (sqrt-stream x)
    (define guesses
        (cons-stream 1.0
                     (stream-map (lambda (guess)
                                   (sqrt-improve guess x))
                                 guesses)))
    guesses)

; The problem is the stream-map call to (sqrt-stream) will repeat
; the improvement process each time the delayed bit of the stream is
; evaluated.  Yes, would still be an issue without the optimization; 
; doesn't have to do with the caching.
