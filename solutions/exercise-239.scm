(define (reverse sequence)
    (fold-right (lambda (x y) (append y (list x))) `() sequence))

(define (reverse-l sequence)
    (fold-left (lambda (x y) (append (list y) x)) `() sequence))

(reverse (list 5 4 3 2 1))
(reverse-l (list 5 4 3 2 1))