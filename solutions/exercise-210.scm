(define (make-interval a b) (cons a b))

(define (upper-bound x)
    (cdr x))

(define (lower-bound x)
    (car x))

(define (sub-interval x y)
    (let ((s1 (- (upper-bound x) (lower-bound y)))
          (s2 (- (lower-bound x) (upper-bound y))))
        (make-interval (min s1 s2) (max s1 s2))))

(define (add-interval x y)
    (make-interval (+ (lower-bound x) (lower-bound y))
        (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
    (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
      (make-interval (min p1 p2 p3 p4)
        (max p1 p2 p3 p4))))

(define (div-interval x y)
    ; Less than 1 => either one of lower/upper bound are 0, 
    ; or have different sign
    (if (< (* (lower-bound y) (upper-bound y)) 1)
        (error "Interval 'y' spans 0")
        (mul-interval x 
                  (make-interval (/ 1.0 (upper-bound y)) 
                                   (/ 1.0 (lower-bound y))))))