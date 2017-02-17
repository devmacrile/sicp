(define tolerance 0.0001)

(define (fixed-point f first-guess)
    (define (close-enough? v1 v2)
        (< (abs (- v1 v2)) tolerance))
    (define (try guess)
        (let ((next (f guess)))
            (if (close-enough? guess next)
                next
                (try next))))
    (try first-guess))

(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))

(define (average x y)
    (/ (+ x y) 2))

(define (average-damp f)
    (lambda (x) (average x (f x))))

(define (compose f g)
    (lambda (x) (f (g x))))

(define (repeated f n)
    (if (= n 1)
        f
        (compose f (repeated f (- n 1)))))

; experiments to suss out relationship betwen nth root and number
; of damps required for convergence
;(define (root-experiment x n damps)
;    (fixed-point-of-transform (lambda (y) (/ x (expt y (- n 1)))) (repeated average-damp damps) 1.0))
;(root-experiment 81 4 1)  
;(root-experiment 81 4 2)
;(root-experiment 100000 13 2)

; TODO prove this?
(define (num-damps n)
    (ceiling (log n)))

(define (nth-root x n)
    (fixed-point-of-transform (lambda(y) (/ x (expt y (- n 1)))) (repeated average-damp (num-damps n)) 1.0))

(nth-root 81 4)
(nth-root 100000 13)