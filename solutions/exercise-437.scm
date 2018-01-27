; More efficient than 4.35?
; In previous version, will basically be O(n^3), where n is (- high low).
; For this new version, the search space for k get limited, so this 
; solution will be more efficient for large n (as defined above); however,
; introducing the sqrt procedure reduces efficiency, and may negate
; this benefit at low values of n (this is a trade off we could work out).

(define (a-pythagorean-triple-between low high)
  (let ((i (an-integer-between low high))
	(hsq (* high high))
    (let ((j (an-integer-between i high)))
      (require (>= hwq ksq))
      (let ((k (sqrt ksq)))
	(require (integer? k))
	(list i j k))))))
