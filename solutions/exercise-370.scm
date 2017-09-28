; could probably define accessors on a pair
; procedure here, for cleanliness
(define (weighted-interleave s1 s2 w)
    (if (stream-null? s1)
        s2
        (let ((p1 (stream-car s1))
              (p2 (stream-car s2)))
          (if (< (w (car p1) (cadr p1))
                 (w (car p2) (cadr p2)))
            (cons-stream (stream-car s1)
                         (weighted-interleave s2 (stream-cdr s1) w))
            (cons-stream (stream-car s2)
                         (weighted-interleave s1 (stream-cdr s2) w))))))

(define (weighted-pairs s1 s2 w)
    (cons-stream
        (list (stream-car s1) (stream-car s2))
        (weighted-interleave
            (stream-map (lambda (x) (list (stream-car s1) x))
                        (stream-cdr s2))
            (weighted-pairs (stream-cdr s1) (stream-cdr s2) w) w)))

(define (integers-starting-from n)
    (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (display-line x)
    (newline)
    (display x))

(define (display-stream-head s n)
    (define (display-iter s n)
        (if (= n 0)
            `done
            (begin (display-line (stream-car s))
                   (display-iter (stream-cdr s) (- n 1)))))
    (display-iter s n))

; (a) stream of all pairs of positive integers (i, j) with i <= j
;     s.t. they are ordered w.r.t. i + j
(display-stream-head (weighted-pairs integers integers (lambda (x y) (+ x y))) 100)

; (b) stream of all pairs of positive integers (i, j) with i <= j
;     s.t. neither i nor j is divisible by 2, 3, 5 and the pairs
;     are ordered according to 2i + 3j + 5ij
(define (divides x y)
    (= (remainder x y) 0))
(define (no-ham x)
    (and (not (divides (car x) 2))
         (not (divides (car x) 3))
         (not (divides (car x) 5))
         (not (divides (cadr x) 2))
         (not (divides (cadr x) 3))
         (not (divides (cadr x) 5))))
(display-stream-head 
    (stream-filter 
        no-ham 
        (weighted-pairs integers integers
            (lambda (x y) (+ (* 2 x) (* 3 y) (* 5 x y)))))
    10)