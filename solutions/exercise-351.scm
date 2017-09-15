(define (stream-enumerate-interval low high)
    (if (> low high)
        the-empty-stream
        (cons-stream
            low
            (stream-enumerate-interval (+ low 1) high))))

(define (stream-map proc . argstreams)
    (if (stream-null? (car argstreams))
        the-empty-stream
        (cons-stream
            (apply proc (map stream-car argstreams))
            (apply stream-map
                   (cons proc (map stream-cdr argstreams))))))

(define (display-stream s)
    (stream-for-each display-line s))

(define (display-line x)
    (newline)
    (display x))

; output tests
(define x (stream-map display-line (stream-enumerate-interval 0 10)))
; 0
;Value: x

(stream-ref x 5)
; 1
; 2
; 3
; 4
; 5

(stream-ref x 7)
; 6
; 7
; only two numbers printed due to the memoization in the
; implementation of delay