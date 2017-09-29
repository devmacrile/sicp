(define (scale-stream stream factor)
    (stream-map (lambda (x) (* x factor)) stream))

(define (area x1 x2 y1 y2)
    (abs (* (- x2 x1) (- y2 y1))))

(define in-unit-circle (lambda (rx ry)
                         (< (sqrt (+ (* rx rx) (* ry ry))) 1.0)))

(define (random-in-range low high)
    (let ((range (- high low)))
        (+ low (random range))))

(define (random-stream-in-range low high)
    (define random-stream 
        (cons-stream (random-in-range low high)
                     (random-stream-in-range low high)))
    random-stream)

(define (monte-carlo experiment-stream passed attempts)
    (define (next passed attempts)
        (cons-stream (/ passed attempts)
                     (monte-carlo (stream-cdr experiment-stream) passed attempts)))
    (if (stream-car experiment-stream)
        (next (+ passed 1) (+ attempts 1))
        (next passed (+ attempts 1))))

(define (estimate-integral predicate x1 x2 y1 y2)
    (let ((xs (random-stream-in-range x1 x2))
          (ys (random-stream-in-range y1 y2)))
      (scale-stream (monte-carlo (stream-map predicate xs ys) 0 0)
                    (area x1 x2 y1 y2))))

(define pi-stream (estimate-integral in-unit-circle -1.0 1.0 -1.0 1.0))
(stream-ref pi-stream 100000)