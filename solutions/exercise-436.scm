; Because it will not "amb"-out and be forced to backtrack out
; into the outer sets (i.e. as it searches over (i, j, k), i and j
; will just remain fixed.

(define (an-integer)
  (an-integer-starting-from 1))

(define (pythagorean-requirement i j k)
  (= (+ (* i i) (* j j)) (* k k)))

(define (a-pythagorean-triple)
  (let ((i (an-integer)))
    (let ((j (an-integer-between 1 i)))
      (let ((k (an-integer-between (+ i i) (- (+ i j) 1) )))
	(require (pythagorean-requirement i j k))))))
