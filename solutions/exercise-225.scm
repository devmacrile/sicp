; (1 3 (5 7) 9)
(car (cdr (car (cddr (list 1 3 (list 5 7) 9)))))

; ((7))
(car (car (list (list 7))))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (= 1 n)
      f
      (compose f (repeated f (- n 1)))))

(define (unlist items)
    (car (cdr items)))

((repeated unlist 6) (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7))))))))))))
