(define (monte-carlo trials experiment)
    (define (iter trials-remaining trials-passed)
        (cond ((= trials-remaining 0)
                (/ trials-passed trials))
              ((experiment)
                (iter (- trials-remaining 1) (+ trials-passed 1)))
              (else
                (iter (- trials-remaining 1) trials-passed))))
    (iter trials 0))

(define (estimate-integral predicate x1 x2 y1 y2 trials)
    (let ((experiment (predicate x1 x2 y1 y2)))
        (* (area x1 x2 y1 y2) (monte-carlo trials experiment))))

(define (area x1 x2 y1 y2)
    (abs (* (- x2 x1) (- y2 y1))))

(define (in-unit-circle x1 x2 y1 y2)
    (lambda ()
        (let ((rx (random-in-range x1 x2))
             (ry (random-in-range y1 y2)))
          (< (sqrt (+ (* rx rx) (* ry ry))) 1.0))))

(define (random-in-range low high)
    (let ((range (- high low)))
        (+ low (random range))))

(estimate-integral in-unit-circle -1.0 1.0 -1.0 1.0 100000)
;Value: 3.14408