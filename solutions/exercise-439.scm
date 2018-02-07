(load "amb.scm")

(define (distinct? items)
  (cond ((null? items) true)
	((null? (cdr items)) true)
	((member (car items) (cdr items)) false)
	(else (distinct? (cdr items)))))

(define (multiple-dwelling)
  (let ((baker (amb 1 2 3 4 5))
	(cooper (amb 1 2 3 4 5))
	(fletcher (amb 1 2 3 4 5))
	(miller (amb 1 2 3 4 5))
	(smith (amb 1 2 3 4 5)))
    (require (not (= baker 5)))
    (require (not (= cooper 1)))
    (require (not (= fletcher 5)))
    (require (not (= fletcher 1)))
    (require (> miller cooper))
    (require (not (= (abs (- fletcher cooper)) 1)))
    (require (not (= (abs (- smith fletcher)) 1)))
    (require    
      (distinct? (list baker cooper fletcher miller smith)))
    (list (list `baker baker)
	  (list `cooper cooper)
	  (list `fletcher fletcher)
	  (list `miller miller)
	  (list `smith smith))))

; Will not effect the set of answers themselves, but efficiency could
; be improved by placing the most restrictive requirements first as well
; as moving the most expensive requirements to be last (here, our distinct?
; procedure is the slowest computationally, so moving it to the end would
; help performance).  My system clock does not necessarily confirm this
; hypothesis though.

(multiple-dwelling)
(system-clock)
