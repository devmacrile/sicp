(define (below painter1 painter2)
    (let ((split-point (make-vect 0.5 0.0)))
        (let ((paint-top
                (transform-painter painter2
                               split-point
                               (make-vect 1 0.5)
                               (make-vect 0.0 1.0)))
              (paint-bottom
                (tranform-painter painter1
                                  (make-vect 0.0 0.0)
                                  (make-vect 1.0 0.0)
                                  split-point)))
        (lambda (frame)
            (paint-top frame)
            (paint-bottom frame)))))

; Using 'beside' implementation
(define (below painter1 painter2)
    (rotate90 (beside (rotate270 painter1) (rotate270 painter2))))