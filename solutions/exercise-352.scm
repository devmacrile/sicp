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
(define sum 0)
(display-line sum)
; 0

(define (accum x)
    (set! sum (+ x sum))
    sum)

(define seq (stream-map accum (stream-enumerate-interval 1 20)))
(display-line sum)
; 1

(define y (stream-filter even? seq))
(display-line sum)
; 6

(define z (stream-filter (lambda (x) (= (remainder x 5) 0)) seq))
(display-line sum)
; 10

(stream-ref y 7)
;Value: 136
(display-line sum)
; 136

(display-stream z)
; 10
; 15
; 45
; 55
; 105
; 120
; 190
; 210

(display sum)
; 210

; Yes, values of the sum variable would definitely be different ('double counting'
; would then occur).  The stream-ref and display-stream outputs should be the same.
