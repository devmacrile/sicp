(define (make-interval a b) (cons a b))

(define (upper-bound x)
    (cdr x))

(define (lower-bound x)
    (car x))

(define (make-center-width c w)
    (make-interval (- c w) (+ c w)))

(define (center i)
    (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width x)
    (/ (- (upper-bound x) (lower-bound x)) 2))

(define (make-center-percent c p)
    (make-interval (- c (* c p)) (+ c (* c p))))

(define (percent x)
    (/ (- (upper-bound x) (center x)) (center x)))

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

(define (par1 r1 r2)
    (div-interval (mul-interval r1 r2)
        (add-interval r1 r2)))

(define (par2 r1 r2)
    (let ((one (make-interval 1 1)))
        (div-interval one
                      (add-interval (div-interval one r1)
                                    (div-interval one r2)))))

(par1 (make-interval 1.33 1.37) (make-interval 1.93 1.97))
(par2 (make-interval 1.33 1.37) (make-interval 1.93 1.97))
(percent (par1 (make-interval 1.33 1.37) (make-interval 1.93 1.97)))
(percent (par2 (make-interval 1.33 1.37) (make-interval 1.93 1.97)))

; For same intervals
(par1 (make-interval 1.33 1.37) (make-interval 1.33 1.37))
(par2 (make-interval 1.33 1.37) (make-interval 1.33 1.37))

; A/A and A/B
(div-interval (make-interval 1.33 1.37) (make-interval 1.33 1.37))
(div-interval (make-interval 1.33 1.37) (make-interval 1.93 1.97))


