(define (smooth f delta)
    (lambda (x) (/ (+ (f (- x delta)) (f x) (f (+ x delta))))))

; compute the n-fold smoothed version of f
; repeated comes from exercise-143
((repeated smooth n) x)
