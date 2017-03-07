(define (flip-horiz painter)
    (transform-painter painter
                       (make-vect 1.0 0.0)
                       (make-vect 0.0 0.0)
                       (make-vect 1.0 1.0)))

(define (rotate180 painter)
    ((compose rotate90 rotate90) painter))

(define (rotate270 painter)
    ((compose rotate180 rotate90) painter)
