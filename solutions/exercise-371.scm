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

(define (merge-streams s1 s2)
    (cons-stream
        (list (stream-car s1) (stream-car s2))
        (merge-streams (stream-cdr s1) (stream-cdr s2))))

(define (cube x)
    (* x x x))

(define cube-sums 
    (stream-map 
        (lambda (x) (+ (cube (car x)) (cube (cadr x)))) 
        (weighted-pairs integers integers (lambda (x y) (+ (cube x) (cube y))))))

(define cube-sums-offset 
    (merge-streams cube-sums (stream-cdr cube-sums)))

(define ramanujan-numbers 
    (stream-filter 
        (lambda (x) (= (car x) (cadr x)))
        cube-sums-offset))

; first will be 1739, show next five
(display-stream-head ramanujan-numbers 6)
