(define (make-vect x y)
    (cons x y))

(define (xcor-vect vect)
    (car vect))

(define (ycor-vect vect)
    (cdr vect))

(define (add-vect v w)
    (make-vect (+ (xcor-vect v) (xcor-vect w)) 
        (+ (ycor-vect v) (ycor-vect w))))

(define (scale-vect v s)
    (make-vect (* s (xcor-vect v)) (* s (ycor-vect v))))

(define (sub-vect v w)
    (add-vect v (scale-vect w -1)))

(define (make-frame origin edge1 edge2)
    (cons origin (cons edge1 edge2)))

(define (origin-frame frame)
    (car frame))

(define (edge1-frame frame)
    (car (cdr frame)))

(define (edge2-frame frame)
    (cdr (cdr frame)))

(define (make-segment v w)
    (cons ((cons 0 0) v) ((cons 0 0) w)))

(define (start-segment seg)
    (car seg))

(define (end-segment seg)
    (cdr seg))

(define (frame-coord-map frame)
    (lambda (v)
        (add-vect 
            (origin-frame frame)
            (add-vect (scale-vect (xcor-vect v)
                                  (edge1-frame frame))
                      (scale-vect (ycor-vect v)
                                  (edge2-frame frame))))))

(define (segments->painter segment-list)
    (lambda (frame)
        (for-each
            (lambda (segment)
                (draw-line
                    ((frame-coord-map frame) (start-segment segment))
                    ((frame-coord-map frame) (end-segment segment))))
            segment-list)))

; a
(define (frame-painter frame)
    ((segments->painter
        (list (make-segment (make-vector 0 0) (make-vector 0 1))
              (make-segment (make-vector 0 1) (make-vector 1 1))
              (make-segment (make-vector 1 1) (make-vector 1 0))
              (make-segment (make-vector 1 0) (make-vector 0 0))))
    frame))

; b
(define (x-painter frame)
    ((segments->painter 
        (list (make-segment (make-vector 0 0) (make-vector 1 1)
              (make-segment (make-vector 0 1) (make-vector 1 0)))))
    frame))

; c
(define (diamond-painter frame)
    ((segments->painter
        (list (make-segment (make-vector 0 0.5) (make-vector 0.5 1))
              (make-segment (make-vector 0.5 1) (make-vector 1 0.5))
              (make-segment (make-vector 1 0.5) (make-vector 0.5 0))
              (make-segment (make-vector 0.5 0) (make-vector 0 0.5))))
    frame))

; d
; No patience
