(define (make-segment start end)
    (cons start end))

(define (start-segment seg)
    (car seg))

(define (end-segment seg)
    (cdr seg))

(define (average x y)
    (/ (+ x y) 2))

(define (midpoint-segment seg)
    (make-point (average (x-point (start-segment seg)) (x-point (end-segment seg)))
        (average (y-point (start-segment seg)) (y-point (end-segment seg)))))

(define (make-point x y)
    (cons x y))

(define (x-point p)
    (car p))

(define (y-point p)
    (cdr p))

(define (print-point p)
    (newline)
    (display "(")
    (display (x-point p))
    (display ", ")
    (display (y-point p))
    (display ")"))

(define (make-rectangle upper-left width height)
    (cons upper-left (cons width height)))

(define (height rect)
    (cdr (cdr rect)))

(define (width rect)
    (car (cdr rect)))

(define (perimeter rect)
    (+ (* (width rect) 2) (* (height rect) 2)))

(define (area rect)
    (* (width rect) (* height rect)))

; Second definition of rectangle, without having to change
; definition of perimeter/area.  Actually, cheating a bit and
; defining a different construction method, but selectors are
; the same.
(define (make-rectangle upper-left lower-right)
    (cons upper-left (cons (- (x-point lower-right) (x-point upper-left))
        (- (y-point upper-left) (y-point lower-right)))))
