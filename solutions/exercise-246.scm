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