(load "amb.scm")

(define (distinct? items)
  (cond ((null? items) true)
	((null? (cdr items)) true)
	((member (car items) (cdr items)) false)
	(else (distinct? (cdr items)))))

(define (get-distinct items)
  (define (count-iter items seen)
    (cond ((null? items) seen)
	  ((member (car items) seen)
	   (count-iter (cdr items) seen))
	  (else
	    (count-iter (cdr items) (append (list (car items)) seen)))))
  (count-iter items `()))

(define (lornas-father)
  (let ((moore 1)
	(downing 2)
	(hall 3)
	(hood 4)
	(parker 5)
	(mary-ann (amb 1 2 3 4 5))
	(gabrielle (amb 1 2 3 4 5))
	(lorna (amb 1 2 3 4 5))
	(rosalind (amb 1 2 3 4 5))
	(melissa (amb 1 2 3 4 5)))
    ;(require (= mary-ann moore))
    (require (not (= gabrielle hood)))
    (require (not (= lorna moore)))
    (require (not (= rosalind hall)))
    (require (not (= melissa downing)))
    (require (distinct? (list mary-ann gabrielle lorna rosalind melissa)))
    (list (list `mary-ann mary-ann)
	  (list `gabrielle gabrielle)
	  (list `lorna lorna)
	  (list `rosalind rosalind)
	  (list `melissa melissa))))

(lornas-father)

; With knowledge that Mary Ann is a Moore.
; Value 2: ((mary-ann 1) (gabrielle 5) (lorna 4) (rosalind 2) (melissa 3))
; => Lorna's father is Sir Barnacle Hood

(length (amb-possibility-list (lornas-father)))
; Value: 53 (but this is all combinations).

(define (get-lorna solution)
  (list-ref (list-ref solution 2) 1))
(get-distinct (map get-lorna (amb-possibility-list (lornas-father))))
; (2 5 4 3)
; So, everybody except Moore still, which is interesting.

