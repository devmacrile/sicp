(define (weighted-interleave s1 s2 w)
    (if (stream-null? s1)
        s2
        (let ((p1 (stream-car s1))
              (p2 (stream-car s2)))
          (if (< (w p1)
                 (w p2))
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

(define (merge-streams . streams)
    (cons-stream
        (map stream-car streams)
        (apply merge-streams (map stream-cdr streams))))

(define (ss pair)
    (+ (square (car pair)) (square (cadr pair))))

(define pairs (weighted-pairs integers integers ss))

(define ss-stream (stream-map ss pairs))

(define pairs-offset 
    (merge-streams 
        ss-stream 
        pairs 
        (stream-cdr pairs) 
        (stream-cdr (stream-cdr pairs))))

(define triple-sum-of-squares
    (stream-filter 
        (lambda (x) (= (ss (cadr x)) (ss (caddr x)) (ss (cadddr x))))
        pairs-offset))

; shows the 1105 duplicate, which is interesting
(display-stream-head triple-sum-of-squares 10)
