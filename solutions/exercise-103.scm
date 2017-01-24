(define (biggest-square x y z)
  (cond ((and (< x y) (< x z)) (+ (* y y) (* z z)))
  	    ((and (< y x) (< y z)) (+ (* x x) (* z z)))
  	    (else (+ (* x x) (* y y)))))

; test
(biggest-square 3 4 5)
