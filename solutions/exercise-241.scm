(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (enumerate-interval low high)
    (if (> low high)
        `()
        (cons low (enumerate-interval (+ low 1) high))))

(define (flatmap proc seq)
    (accumulate append `() (map proc seq)))

(define (ordered-triples n)
    (flatmap (lambda (i)
        (flatmap (lambda (j)
            (map (lambda (k)
                (list i j k))
            (enumerate-interval (+ 1 j) n)))
        (enumerate-interval (+ 1 i) (- n 1))))
    (enumerate-interval 1 (- n 2))))

(define (triple-sum triple)
    (accumulate + 0 triple))

(define (equal-sum? s)
    (lambda (x) (= s (triple-sum x))))

(define (make-triple-sum triple)
    (list triple (triple-sum triple)))

(define (ordered-triple-sums n s)
    (map make-triple-sum (filter (equal-sum? s) (ordered-triples n))))

(ordered-triple-sums 10 15)  ; cribbage
