(define (smooth s)
    (stream-map (lambda (x y) (/ (+ x y) 2))
                (cons-stream 0 s)
                s))

(define (make-zero-crossings input-stream last-value last-avpt)
    (let ((avpt (/ (+ (stream-car input-stream) last-value) 2)))
        (cons-stream (sign-change-detector avpt last-avpt)
                     (make-zero-crossings (stream-cdr input-stream)
                                          (stream-car input-stream)
                                          avpt))))

(define (make-zero-crossings input-stream smoother)
    (let ((smooth-stream (stream-map smoother input-stream)))
        (stream-map
            sign-change-detector
            (cons-stream 0 smooth-stream)
            smooth-stream)))